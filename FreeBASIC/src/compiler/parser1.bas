''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' parser part 1 - main parser, including declarations (DECLARE, CONST, etc)
''
'' a deterministic, top-down, linear directional (LL(1)), recursive (no table-driven)
'' descent parser (syntax analyser)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"

declare function cConstExprValue			( byref value as integer ) as integer

declare function cSymbUDTInit				( byval basesym as FBSYMBOL ptr, _
											  byval sym as FBSYMBOL ptr, _
											  byref ofs as integer, _
					   						  byval islocal as integer ) as integer

declare function cTypeBody					( byval s as FBSYMBOL ptr ) as integer


'':::::
''Program         =   Line* EOF .
''
function cProgram as integer
    dim res as integer

    do
    	res = cLine( )
    loop while( (res) and (lexGetToken( ) <> FB_TK_EOF) )

    if( res ) then
    	if( not hMatch( FB_TK_EOF ) ) then
    		'hReportError FB_ERRMSG_EXPECTEDEOF
    		res = FALSE
    	else
    		res = TRUE
    	end if
    end if

    function = res

end function

'':::::
''Line            =   Label? Statement? Comment? EOL .
''
function cLine as integer

	''
	astAdd( astNewDBG( IR_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label? Statement? Comment?
    cLabel( )
    cStatement( )
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		return FALSE
	end if

	if( not hMatch( FB_TK_EOL ) ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			return FALSE
		end if
    end if

	''
	astAdd( astNewDBG( IR_OP_DBG_LINEEND, lexLineNum( ) ) )

    function = TRUE

end function

'':::::
''SimpleLine      =   Label? SimpleStatement? Comment? EOL .
''
function cSimpleLine as integer
    dim res as integer

	''
	astAdd( astNewDBG( IR_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label? SimpleStatement? Comment?
    cLabel( )
    res = cSimpleStatement( )
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		return FALSE
	end if

	if( not hMatch( FB_TK_EOL ) ) then
		if( res ) then
			return FALSE
		else
			if( lexGetToken( ) <> FB_TK_EOF ) then
				hReportError( FB_ERRMSG_EXPECTEDEOL )
				return FALSE
			end if
		end if
	end if

	''
	astAdd( astNewDBG( IR_OP_DBG_LINEEND, lexLineNum( ) ) )

    function = TRUE

end function


'':::::
''Label           =   NUM_LIT
''                |   ID ':' .
''
function cLabel as integer
    dim l as FBSYMBOL ptr

    function = FALSE

    l = NULL

    '' NUM_LIT
    select case lexGetClass( )
    case FB_TKCLASS_NUMLITERAL
		if( lexGetType( ) = FB_SYMBTYPE_INTEGER ) then
			l = symbAddLabel( lexGetText( ), TRUE, TRUE )
			if( l = NULL ) then
				hReportError( FB_ERRMSG_DUPDEFINITION )
				exit function
			else
				lexSkipToken( )
			end if
		end if

	'' ID
	case FB_TKCLASS_IDENTIFIER
		'' ':'
		if( lexGetLookAhead(1) = CHAR_COLON ) then

			'' ambiguity: it could be a proc call followed by a ':' stmt separator..
			if( symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC ) <> NULL ) then
				exit function
			end if

			l = symbAddLabel( lexGetText( ), TRUE, TRUE )
			if( l = NULL ) then
				hReportError( FB_ERRMSG_DUPDEFINITION )
				exit function
			else
				lexSkipToken( )
			end if

			'' skip ':'
			lexSkipToken( )

		end if
    end select

    if( l <> NULL ) then

    	astAdd( astNewLABEL( l ) )

    	symbSetLastLabel( l )

    	function = TRUE
    end if

end function

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''				                              |   (any_char_but_EOL*)) .
''
function cComment( byval lexflags as LEXCHECK_ENUM ) as integer

	select case lexGetToken( lexflags )
	case FB_TK_COMMENTCHAR, FB_TK_REM
    	lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE )

    	if( lexGetToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE ) = FB_TK_DIRECTIVECHAR ) then
    		lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE )
    		function = cDirective( )
    	else
    		lexSkipLine( )
    		function = TRUE
    	end if

	case else
		function = FALSE
	end select

end function

'':::::
''Directive       =   INCLUDE ONCE? ':' '\'' STR_LIT '\''
''				  |   INCLIB ':' '\'' STR_LIT '\''
''				  |   LIBPATH ':' '\'' STR_LIT '\''
''				  |   DYNAMIC
''				  |   STATIC .
''
function cDirective as integer static
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce, token

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE
		function = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE
		function = TRUE

	case FB_TK_INCLUDE, FB_TK_INCLIB, FB_TK_LIBPATH

		token = lexGetToken( )
		lexSkipToken( )

		'' ONCE?
		isonce = FALSE
		if( ucase$( *lexGetText( ) ) = "ONCE" ) then
			lexSkipToken( )
			isonce = TRUE
		end if

		'' ':'
		if( not hMatch( CHAR_COLON ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		'' "STR_LIT"
		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			lexEatToken( incfile )
			if( env.opt.escapestr ) then
				incfile = hUnescapeStr( incfile )
			end if

		else
			'' '\''
			if( lexGetToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC ) <> CHAR_APOST ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			else
				lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC )
			end if

			lexReadLine( CHAR_APOST, incfile )

			'' '\''
			if( not hMatch( CHAR_APOST ) ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
		end if

		select case token
		case FB_TK_INCLUDE
			function = fbIncludeFile( incfile, isonce )
		case FB_TK_INCLIB
			function = symbAddLib( incfile ) <> NULL
		case FB_TK_LIBPATH
			function = fbAddLibPath( incfile )
		end select

	case else
		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end select

	do until( (lexGetToken( ) = FB_TK_EOL) or (lexGetToken( ) = FB_TK_EOF) )
		lexSkipToken( )
	loop

end function

'':::::
''Statement       =   STT_SEPARATOR? ( Declaration
''									 | ProcCallOrAssign
''								     | CompoundStmt
''									 | ProcStatement
''									 | QuirkStmt
''									 | AsmBlock
''									 | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR Statement)* .
''
function cStatement as integer

	'' ':'?
	if( lexGetToken( ) = FB_TK_STATSEPCHAR ) then
		lexSkipToken( )
	end if

	do
		if( not cDeclaration( ) ) then
			if( not cCompoundStmt( ) ) then
				if( not cProcStatement( ) ) then
					if( not cQuirkStmt( ) ) then
						if( not cAsmBlock( ) ) then
							if( not cProcCallOrAssign( ) ) then
								cAssignmentOrPtrCall( )
							end if
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexGetToken( ) <> FB_TK_STATSEPCHAR ) then
			exit do
		end if
		lexSkipToken( )
	loop

	function = (hGetLastError( ) = FB_ERRMSG_OK)

end function

'':::::
''SimpleStatement =   STT_SEPARATOR? ( ConstDecl
''									 | SymbolDecl
''									 | ProcCallOrAssign
''									 | CompoundStmt
''									 | QuirkStmt
''									 | AsmBlock
''									 | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR SimpleStatement)* .
''
function cSimpleStatement as integer

	'' ':'?
	if( lexGetToken( ) = FB_TK_STATSEPCHAR ) then
		lexSkipToken( )
	end if

	do
		if( not cConstDecl( ) ) then
			if( not cSymbolDecl( ) ) then
				if( not cCompoundStmt( ) ) then
					if( not cQuirkStmt( ) ) then
						if( not cAsmBlock( ) ) then
							if( not cProcCallOrAssign( ) ) then
								cAssignmentOrPtrCall( )
							end if
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexGetToken( ) <> FB_TK_STATSEPCHAR ) then
			exit do
		end if
		lexSkipToken( )
	loop

	function = (hGetLastError( ) = FB_ERRMSG_OK)

end function

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cStmtSeparator( byval lexflags as LEXCHECK_ENUM ) as integer
    dim token as integer

	function = FALSE

	do
		token = lexGetToken( lexflags )
		if( (token <> FB_TK_STATSEPCHAR) and (token <> FB_TK_EOL) ) then
			exit do
		end if
		lexSkipToken( lexflags )

		function = TRUE
	loop

end function

'':::::
''Declaration     =   ConstDecl | TypeDecl | SymbolDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration as integer

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_CONST
		function = cConstDecl( )
	case FB_TK_DECLARE
		function = cProcDecl( )
	case FB_TK_TYPE, FB_TK_UNION
		function = cTypeDecl( )
	case FB_TK_ENUM
		function = cEnumDecl( )
	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN, FB_TK_STATIC
		function = cSymbolDecl( )
	case FB_TK_DEFBYTE, FB_TK_DEFUBYTE, FB_TK_DEFSHORT, FB_TK_DEFUSHORT, FB_TK_DEFINT, FB_TK_DEFLNG, _
		 FB_TK_DEFUINT, FB_TK_DEFSNG, FB_TK_DEFDBL, FB_TK_DEFSTR, FB_TK_DEFLNGINT, FB_TK_DEFULNGINT
		function = cDefDecl( )
	case FB_TK_OPTION
		function = cOptDecl( )
	end select

end function

'':::::
''ConstDecl       =   CONST ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl as integer

    function = FALSE

    '' CONST
    if( not hMatch( FB_TK_CONST ) ) then
    	exit function
    end if

	do
		'' ConstAssign
		if( not cConstAssign( ) ) then
			exit function
		end if

    	'' ','
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if
	loop

	function = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? ASSIGN ConstExpression .
''
function cConstAssign as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    static as zstring * FB_MAXLITLEN+1 valtext
    dim as integer typ, lgt, ptrcnt
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr sym, subtype

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	'' ID
	typ = lexGetType( )
	lexEatToken( id )

	'' (AS SymbolType)?
	if( hMatch( FB_TK_AS ) ) then
		if( typ <> INVALID ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end if

		select case typ
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR, FB_SYMBTYPE_CHAR
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end select

	end if

	'' '='
	if( not hMatch( FB_TK_ASSIGN ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEQ )
		exit function
	end if

	'' ConstExpression
	if( not cExpression( expr ) ) then
		hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
		exit function
	end if

	'' check if it's an string
	sym = NULL
	if( astGetDataType( expr ) = IR_DATATYPE_FIXSTR ) then
		if( astIsVAR( expr ) ) then
			sym = astGetSymbolOrElm( expr )
			if( sym <> NULL ) then
				if( not symbGetVarInitialized( sym ) ) then
					sym = NULL
				end if
			end if
		end if
	end if

	'' string?
	if( sym <> NULL ) then
		astDel( expr )

		lgt = symbGetLen( sym ) - 1 			'' less the null-char
		if( symbAddConst( @id, FB_SYMBTYPE_STRING, NULL, _
						  strptr( sym->var.inittext ), lgt ) = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
		end if

		if( symbGetAccessCnt( sym ) = 0 ) then
			symbDelVar( sym )
		end if

	else

		if( not astIsCONST( expr ) ) then
			hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
			exit function
		end if

		typ 	= astGetDataType( expr )
		subtype = astGetSubtype( expr )
		valtext = astGetValueAsStr( expr )
		astDel( expr )

		if( symbAddConst( @id, typ, subtype, @valtext, 0 ) = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
		end if

    end if

	function = TRUE

end function

'':::::
function cTypedefDecl( byval id as string ) as integer
    dim as zstring ptr tname
    dim as integer typ, lgt, ptrcnt
    dim as FBSYMBOL ptr subtype

    function = FALSE

    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then

    	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if

    	tname = lexGetText( )
    	'' pointing to itself? then it's a void..
    	if( *tname = id ) then
    		typ 	= FB_SYMBTYPE_VOID
    		subtype = NULL
    		lgt 	= 0

    	'' else, create a forward reference (or lookup one)
    	else
    		typ 	= FB_SYMBTYPE_FWDREF
    		subtype = symbAddFwdRef( tname )
			lgt 	= -1
			if( subtype = NULL ) then
				subtype = symbFindByNameAndClass( tname, FB_SYMBCLASS_FWDREF )
				if( subtype = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if
			end if
    	end if

    	lexSkipToken( )
    end if

	if( ptrcnt = 0 ) then
		'' (PTR|POINTER)*
		do
			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				lexSkipToken( )
				typ += FB_SYMBTYPE_POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop
	end if

    if( symbAddTypedef( @id, typ, subtype, ptrcnt, lgt ) = NULL ) then
		hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
		exit function
    end if

	function = TRUE

end function

'':::::
''TypeMultElementDecl =   AS SymbolType ID (ArrayDecl | ':' NUMLIT)? (',' ID (ArrayDecl | ':' NUMLIT)?)*
''
function cTypeMultElementDecl( byval s as FBSYMBOL ptr ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr subtype
    dim as integer dims, typ, lgt, ptrcnt, bits

    function = FALSE

    '' SymbolType
    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	exit function
    end if

	do
		'' allow keywords as field names
		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
			if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
    			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    			exit function
    		end if
    	end if

    	'' contains a period?
    	if( lexGetPeriodPos( ) > 0 ) then
    		hReportError( FB_ERRMSG_CANTINCLUDEPERIODS )
    		exit function
    	end if

	    lexEatToken( id )
	    bits = 0

		'' ArrayDecl?
		if( not cStaticArrayDecl( dims, dTB() ) ) then

    		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

			'' ':' NUMLIT?
			if( lexGetToken( ) = CHAR_COLON ) then
				if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
					lexSkipToken( )
					bits = valint( *lexGetText( ) )
					lexSkipToken( )
				end if

				if( not symbCheckBitField( s, typ, lgt, bits ) ) then
    				hReportError( FB_ERRMSG_INVALIDBITFIELD, TRUE )
    				exit function
				end if

			end if

		end if

        ''
		if( symbAddUDTElement( s, @id, _
							   dims, dTB(), _
							   typ, subtype, ptrcnt, lgt, bits ) = NULL ) then
			hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
			exit function
		end if

	'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	function = TRUE

end function

'':::::
'' TypeElementDecl	= ID (ArrayDecl| ':' NUMLIT)? AS SymbolType
''
function cTypeElementDecl( byval s as FBSYMBOL ptr ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr subtype
    dim as integer dims, typ, lgt, ptrcnt, bits

	function = FALSE

	'' allow keywords as field names
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if
    end if

    '' contains a period?
    if( lexGetPeriodPos( ) > 0 ) then
    	hReportError( FB_ERRMSG_CANTINCLUDEPERIODS )
    	exit function
    end if

	'' ID
	typ = lexGetType( )
	subtype = NULL
	lexEatToken( id )
	bits = 0

	'' ArrayDecl?
	if( not cStaticArrayDecl( dims, dTB() ) ) then
		'' ':' NUMLIT?
		if( lexGetToken( ) = CHAR_COLON ) then
			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
				lexSkipToken( )
				bits = valint( *lexGetText( ) )
				lexSkipToken( )
				if( bits <= 0 ) then
    				hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
    				exit function
    			end if
			end if
		end if
	end if

    '' AS
    if( not hMatch( FB_TK_AS ) or (typ <> INVALID) ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
    end if

    '' SymbolType
    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	exit function
    end if

	''
	if( bits <> 0 ) then
		if( not symbCheckBitField( s, typ, lgt, bits ) ) then
    		hReportError( FB_ERRMSG_INVALIDBITFIELD, TRUE )
    		exit function
		end if
	end if

	'' ref to self?
	if( typ = FB_SYMBTYPE_USERDEF ) then
		if( subtype = s ) then
			hReportError( FB_ERRMSG_RECURSIVEUDT )
			exit function
		end if
	end if

	if( symbAddUDTElement( s, @id, _
						   dims, dTB(), _
						   typ, subtype, ptrcnt, lgt, bits ) = NULL ) then
		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
		exit function
	end if

	function = TRUE

end function

'':::::
private function hTypeAdd( byval parent as FBSYMBOL ptr, _
						   byval id as string, _
						   byval isunion as integer, _
						   byval align as integer ) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s

	function = NULL

	s = symbAddUDT( parent, @id, isunion, align )
	if( s = NULL ) then
    	hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    	exit function
	end if

	'' Comment? SttSeparator
	cComment( )

	if( not cStmtSeparator( ) ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
	end if

	'' TypeBody
	if( not cTypeBody( s ) ) then
		exit function
	end if

	if( hGetLastError() <> FB_ERRMSG_OK ) then
		exit function
	end if

	'' pad the UDT if needed
	symbRoundUDTSize( s )

	'' END TYPE|UNION
	if( not hMatch( FB_TK_END ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDENDTYPE )
    	exit function
	end if

	if( not hMatch( iif( isunion, FB_TK_UNION, FB_TK_TYPE ) ) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDTYPE )
		exit function
	end if

	function = s

end function

'':::::
''TypeBody      =   ( (UNION|TYPE Comment? SttSeparator
''					   ElementDecl
''					  END UNION|TYPE)
''                  | ElementDecl
''				    | AS AsElementDecl )+ .
''
function cTypeBody( byval s as FBSYMBOL ptr ) as integer
	dim as integer istype
	dim as FBSYMBOL ptr inner

	function = FALSE

	do
		'' Comment? SttSeparator?
		do while( cComment( ) or cStmtSeparator( ) )
		loop

		select case as const lexGetToken( )
		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			'' isn't it a field called "end"?
			select case lexGetLookAhead( 1 )
			case FB_TK_AS, CHAR_LPRNT, CHAR_COLON
				if( not cTypeElementDecl( s ) ) then
					exit function
				end if

			'' it's not a field, exit
			case else
				exit do

			end select

		'' (TYPE|UNION)?
		case FB_TK_TYPE, FB_TK_UNION
			'' isn't it a field called TYPE|UNION?
			select case lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM

				'' it's an anonymous inner UDT
				istype = lexGetToken( ) = FB_TK_TYPE
				if( istype ) then
					if( not symbGetUDTIsUnion( s ) ) then
						hReportError( FB_ERRMSG_SYNTAXERROR )
						exit function
					end if
				else
					if( symbGetUDTIsUnion( s ) ) then
						hReportError( FB_ERRMSG_SYNTAXERROR )
						exit function
					end if
				end if

				lexSkipToken( )

				'' create a "temp" one
				inner = hTypeAdd( s, hMakeTmpStr( ), not istype, symbGetUDTAlign( s ) )
				if( inner = NULL ) then
					exit function
				end if

				'' insert it into the parent UDT
				symbInsertInnerUDT( s, inner )

			'' it's a field, parse it
			case else
				if( not cTypeElementDecl( s ) ) then
					exit function
				end if

			end select

		'' AS?
		case FB_TK_AS
			'' isn't it a field called "as"?
			select case lexGetLookAhead( 1 )
			case FB_TK_AS, CHAR_LPRNT, CHAR_COLON
				if( not cTypeElementDecl( s ) ) then
					exit function
				end if

			'' it's a multi-declaration
			case else
				lexSkipToken( )

				if( not cTypeMultElementDecl( s ) ) then
					exit function
				end if
			end select

		'' anything else, must be a field
		case else
			if( not cTypeElementDecl( s ) ) then
				exit function
			end if

		end select

		'' Comment? SttSeparator
		cComment( )

	    if( not cStmtSeparator( ) ) then
	    	hReportError( FB_ERRMSG_SYNTAXERROR )
	    	exit function
		end if

	loop

	'' nothing added?
	if( symbGetUDTElements( s ) = 0 ) then
		hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
		exit function
	end if

    function = TRUE

end function

'':::::
''TypeDecl        =   (TYPE|UNION) ID (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr s
    dim as integer align, isunion

	function = FALSE

	'' TYPE | UNION
	select case lexGetToken( )
	case FB_TK_TYPE
		isunion = FALSE
		lexSkipToken( )
	case FB_TK_UNION
		isunion = TRUE
		lexSkipToken( )
	case else
		exit function
	end select

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	exit function
    end if

	lexEatToken( id )

	''
	select case lexGetToken( )
	'' AS?
	case FB_TK_AS
		if( isunion ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		lexSkipToken( )

		return cTypedefDecl( id )

	'' (FIELD '=' Expression)?
    case FB_TK_FIELD
		lexSkipToken( )

		if( not hMatch( FB_TK_ASSIGN ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

    	if( not cExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

		if( not astIsCONST( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDCONST )
			exit function
		end if

  		'' follow the GCC 3.x ABI
  		align = astGetValueAsInt( expr )
  		astDel( expr )
  		if( align < 0 ) then
  			align = 0
  		elseif( align > FB_INTEGERSIZE ) then
  			align = 0
  		elseif( align = 3 ) then
  			align = 2
  		end if

	case else
		align = 0
	end select

    ''
	function = (hTypeAdd( NULL, id, isunion, align ) <> NULL)

end function

'':::
''EnumConstDecl     =   ID ('=' ConstExpression)? .
''
function cEnumConstDecl( byval id as string, _
						 byref value as integer ) as integer
    static as ASTNODE ptr expr

	function = FALSE

	'' ID
	lexEatToken( id )

	'' '='?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

		'' ConstExpression
		if( not cExpression( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDCONST )
			exit function
		end if

		if( not astIsCONST( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDCONST )
			exit function
		end if

		'' not an integer?
		if( astGetDataClass( expr ) <> IR_DATACLASS_INTEGER ) then
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION, id )
		end if

		value = astGetValueAsInt( expr )
		astDel( expr )

    end if

	function = TRUE

end function

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
function cEnumBody( byval s as FBSYMBOL ptr ) as integer
	static as zstring * FB_MAXNAMELEN+1 ename
	dim as integer value

	function = FALSE

	value = 0

	do
		'' Comment? SttSeparator?
		do while( cComment( ) or cStmtSeparator( ) )
		loop

		select case lexGetToken( )
		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			exit do

		case else

			'' ID ConstDecl (',' ID ConstDecl)*
			do
				'' ID?
				if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
					exit do
				end if

				'' ConstDecl
				if( not cEnumConstDecl( ename, value ) ) then
					exit function
				end if

				if( symbAddEnumElement( s, @ename, value ) = NULL ) then
					hReportErrorEx( FB_ERRMSG_DUPDEFINITION, ename )
					exit function
				end if

				value += 1

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if
				lexSkipToken( )
			loop

			'' Comment? SttSeparator
			cComment( )

			if( not cStmtSeparator( ) ) then
    			hReportError( FB_ERRMSG_EXPECTEDEOL )
    			exit function
			end if
		end select

	loop

	'' nothing added?
	if( symbGetEnumElements( s ) = 0 ) then
		hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
		exit function
	end if

    function = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    dim as FBSYMBOL ptr e

	function = FALSE

	'' ENUM
	lexSkipToken( )

	'' ID?
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
    	lexEatToken( id )
    else
    	id = *hMakeTmpStr( FALSE )
    end if

	e = symbAddEnum( @id )
	if( e = NULL ) then
    	hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    	exit function
	end if

	'' Comment? SttSeparator
	cComment( )

	if( not cStmtSeparator( ) ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
	end if

	'' EnumBody
	if( not cEnumBody( e ) ) then
		exit function
	end if

	'' END ENUM
	if( not hMatch( FB_TK_END ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDENDENUM )
    	exit function
	end if
	if( not hMatch( FB_TK_ENUM ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDENDENUM )
    	exit function
	end if

    ''
	function = TRUE

end function

'':::::
''SymbolDecl      =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN IMPORT? SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cSymbolDecl as integer
	dim alloctype as integer
	dim dopreserve as integer
    dim is_dim as integer

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN

		alloctype = 0
		dopreserve = FALSE

		select case as const lexGetToken( )
		'' REDIM
		case FB_TK_REDIM
			lexSkipToken( )
			alloctype or= FB_ALLOCTYPE_DYNAMIC

			'' PRESERVE?
			if( hMatch( FB_TK_PRESERVE ) ) then
				dopreserve = TRUE
			end if

		'' COMMON
		case FB_TK_COMMON
			'' can't use COMMON inside a proc or inside a scope block
			if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    			else
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    			end if
    			exit function
			end if

			''
			lexSkipToken( )

			alloctype or= FB_ALLOCTYPE_COMMON or FB_ALLOCTYPE_DYNAMIC

		'' EXTERN
		case FB_TK_EXTERN
			'' can't use EXTERN inside a proc
			if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    			else
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    			end if
    			exit function
			end if

			lexSkipToken( )

			alloctype or= FB_ALLOCTYPE_EXTERN or FB_ALLOCTYPE_SHARED

		case else
			lexSkipToken( )
            is_dim = TRUE

		end select

		''
		if( env.opt.dynamic ) then
			alloctype or= FB_ALLOCTYPE_DYNAMIC
		end if

		if( (alloctype and FB_ALLOCTYPE_EXTERN) = 0 ) then
			'' SHARED?
			if( lexGetToken( ) = FB_TK_SHARED ) then
				'' can't use SHARED inside a proc
				if( env.scope > 0 ) then
					if( fbIsLocal( ) ) then
    					hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    				else
    					hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    				end if
    				exit function
				end if

				lexSkipToken( )
				alloctype or= FB_ALLOCTYPE_SHARED
			end if

		else
			'' IMPORT?
			if( hMatch( FB_TK_IMPORT ) ) then
				alloctype or= FB_ALLOCTYPE_IMPORT
			end if
		end if

		''
		if( env.isprocstatic ) then
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) = 0 ) then
				alloctype or= FB_ALLOCTYPE_STATIC
			end if
		end if

		''
		function = cSymbolDef( alloctype, dopreserve, is_dim )

	'' STATIC
	case FB_TK_STATIC

		'' check ambiguity with STATIC SUB|FUNCTION
		select case lexGetLookAhead( 1 )
		case FB_TK_SUB, FB_TK_FUNCTION
			exit function
		end select

		'' can't use STATIC outside a proc
		if( not fbIsLocal( ) ) then
   			hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
   			exit function
		end if

		lexSkipToken( )

		function = cSymbolDef( FB_ALLOCTYPE_STATIC )

	end select

end function

'':::::
private function hIsDynamic( byval dimensions as integer, _
					 		 exprTB() as ASTNODE ptr ) as integer
    dim i as integer

	function = TRUE

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		if( not astIsCONST( exprTB(i, 0) ) ) then
			exit function
		elseif( not astIsCONST( exprTB(i, 1) ) ) then
			exit function
		end if
	next i

	function = FALSE

end function

''::::
private sub hMakeArrayDimTB( byval dimensions as integer, _
					 		 exprTB() as ASTNODE ptr, _
					 		 dTB() as FBARRAYDIM )
    static as integer i
    static as ASTNODE ptr expr

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).lower = astGetValue64( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).lower = astGetValuef( expr )
		case else
			dTB(i).lower = astGetValuei( expr )
		end select

		astDel( expr )

		'' upper bound
		expr = exprTB(i, 1)

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).upper = astGetValue64( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).upper = astGetValuef( expr )
		case else
			dTB(i).upper = astGetValuei( expr )
		end select

		astDel( expr )
	next i

end sub

'':::::
private function hDeclExternVar( byval id as zstring ptr, _
						 		 byval typ as integer, _
						 		 byval subtype as FBSYMBOL ptr, _
						 		 byval alloctype as integer, _
						 		 byval addsuffix as integer, _
						 		 byval dimensions as integer, _
					   	 		 dTB() as FBARRAYDIM ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s

    function = NULL

    s = symbFindByNameAndSuffix( id, typ )
    if( s <> NULL ) then

    	'' no extern?
    	if( not symbIsExtern( s ) ) then
    		exit function
    	end if

    	'' check type
		if( (typ <> symbGetType( s )) or _
			(subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if

		'' dynamic?
		if( symbIsDynamic( s ) ) then
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) = 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if
    	else
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) > 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if

    		'' no static as local
    		if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportErrorEx( FB_ERRMSG_ILLEGALINSIDEASUB, *id )
    			else
    				hReportErrorEx( FB_ERRMSG_ILLEGALINSIDEASCOPE, *id )
    			end if
    			exit function
    		end if
    	end if

    	'' dup extern?
    	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
    		return s
    	end if

    	'' set type
    	symbSetAllocType( s, (alloctype and not FB_ALLOCTYPE_EXTERN) or _
    					      FB_ALLOCTYPE_PUBLIC or _
    					      FB_ALLOCTYPE_SHARED )

		'' check dimensions
		if( symbGetArrayDimensions( s ) <> 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			hReportErrorEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			exit function
    		end if

			'' set dims
			symbSetArrayDims( s, dimensions, dTB() )

		end if

    else
    	'' dup extern?
    	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
    		exit function
    	end if

    end if

    function = s

end function

'':::::
private function hStaticSymbDef( byval id as zstring ptr, _
					     		 byval dotpos as integer, _
					     		 byval idalias as zstring ptr, _
					     		 byval typ as integer, _
					     		 byval subtype as FBSYMBOL ptr, _
					     		 byval ptrcnt as integer, _
					     		 byval lgt as integer, _
					     		 byval addsuffix as integer, _
					     		 byval alloctype as integer, _
					     		 byval dimensions as integer, _
					     		 exprTB() as ASTNODE ptr ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    hMakeArrayDimTB( dimensions, exprTB(), dTB() )

    alloctype and= (not FB_ALLOCTYPE_DYNAMIC)

    '' symbol with periods? double-check..
    if( dotpos > 0 ) then
    	'' any UDT var already allocated?
    	if( symbLookupUDTVar( id, dotpos ) <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
    	end if
    end if

    ''
    s = symbAddVarEx( id, idalias, typ, subtype, ptrcnt, _
    				  lgt, dimensions, dTB(), _
    				  alloctype, addsuffix, FALSE, TRUE )

    if( s = NULL ) then
    	s = hDeclExternVar( id, typ, subtype, alloctype, _
    						addsuffix, dimensions, dTB() )

		if( s = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		return NULL
    	end if

	end if

	'' another quirk: if array is local (ie, inside a proc) and it's not dynamic, it's
	'' descriptor won't will be filled ever, so a call to another rtl routine is needed,
	'' or that array coulnd't be passed by descriptor to other procs (allocating a static
	'' descriptor won't help, as that would break recursion)
	if( fbIsLocal( ) ) then
		if( dimensions > 0 ) then
			if( (alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then
				if( not rtlArraySetDesc( s, lgt, dimensions, dTB() ) ) then
					return NULL
				end if
			end if
		end if
	end if

	function = s

end function

'':::::
private function hDynArrayDef( byval id as zstring ptr, _
							   byval dotpos as integer, _
					   		   byval idalias as zstring ptr, _
					   		   byval typ as integer, _
					   		   byval subtype as FBSYMBOL ptr, _
					   		   byval ptrcnt as integer, _
					   		   byval istypeless as integer, _
					   		   byval lgt as integer, _
					   		   byval addsuffix as integer, _
					   		   byval alloctype as integer, _
					   		   byval dopreserve as integer, _
					   		   byval dimensions as integer, _
					   		   exprTB() as ASTNODE ptr ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as integer atype, isrealloc
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    function = NULL

    atype = (alloctype or FB_ALLOCTYPE_DYNAMIC) and (not FB_ALLOCTYPE_STATIC)

    '' symbol with periods? double-check..
    if( dotpos > 0 ) then
    	'' any UDT var already allocated?
    	if( symbLookupUDTVar( id, dotpos ) <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_CANTREDIMARRAYFIELDS, *id )
    		exit function
    	end if
    end if

    ''
  	isrealloc = TRUE
  	s = symbFindByNameAndSuffix( id, typ )
   	if( s = NULL ) then

   		'' typeless REDIM's?
   		if( istypeless ) then
   			'' try to find a var with the same name
   			s = symbFindByNameAndClass( id, FB_SYMBCLASS_VAR )
   			'' copy type
   			if( s <> NULL ) then
   				typ 	= s->typ
   				subtype = s->subtype
   				lgt		= s->lgt
   			end if
   		end if

   		if( s = NULL ) then
   			isrealloc = FALSE
   			s = symbAddVarEx( id, idalias, typ, subtype, ptrcnt, _
   							  lgt, dimensions, dTB(), _
   							  atype, addsuffix, FALSE, TRUE )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
   				exit function
   			end if
   		end if

   	end if

	'' check reallocation
	if( isrealloc ) then
		'' not dynamic?
		if( not symbGetIsDynamic( s ) ) then

   			'' could be an external..
   			s = hDeclExternVar( id, typ, subtype, atype, addsuffix, _
   								dimensions, dTB() )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
				exit function
			end if

		else

			'' external?
			if( symbIsExtern( s ) ) then
				if( (atype and FB_ALLOCTYPE_EXTERN) > 0 ) then
   					hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
					exit function
				end if

				symbSetAllocType( s, (atype and not FB_ALLOCTYPE_EXTERN) or _
    					             FB_ALLOCTYPE_PUBLIC or _
    					             FB_ALLOCTYPE_SHARED )
			end if
		end if
	end if

	alloctype = symbGetAllocType( s )

	'' external? don't do any checks
	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
		return s
	end if

	'' not an argument passed by descriptor or a common array?
	if( (alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or FB_ALLOCTYPE_COMMON)) = 0 ) then

		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if

		if( symbGetArrayDimensions( s ) > 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			hReportErrorEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if
	end if

	'' if dimensions not = -1 (COMMON or DIM|REDIM array()), redim it
	if( dimensions > 0 ) then
		if( not rtlArrayRedim( s, lgt, dimensions, exprTB(), dopreserve ) ) then
			exit function
		end if
	end if

	'' if COMMON, check for max dimensions used
	if( (alloctype and FB_ALLOCTYPE_COMMON) > 0 ) then
		if( dimensions > symbGetArrayDimensions( s ) ) then
			symbSetArrayDimensions( s, dimensions )
		end if

	'' or if dims = -1 (cause of "DIM|REDIM array()")
	elseif( symbGetArrayDimensions( s ) = -1 ) then
		symbSetArrayDimensions( s, dimensions )
	end if

    function = s

end function

'':::::
''SymbolDef       =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
function cSymbolDef( byval alloctype as integer, _
					 byval dopreserve as integer = FALSE, _
                     byval is_dim as integer = FALSE ) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, idalias
    dim as FBSYMBOL ptr symbol, subtype, test_symbol
    dim as integer addsuffix, isdynamic, ismultdecl, istypeless
    dim as integer typ, lgt, ofs, ptrcnt, dotpos
    dim as integer dimensions
    dim as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
    dim as zstring ptr palias

    function = FALSE

    '' (AS SymbolType)?
    ismultdecl = FALSE
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' ANY?
    	if( typ = FB_SYMBTYPE_VOID ) then
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end if

    	addsuffix = FALSE

    	ismultdecl = TRUE
    end if

    do
    	'' ID
    	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	if( not ismultdecl ) then
    		typ 		= lexGetType
    		subtype 	= NULL
    		lgt			= 0
    		addsuffix 	= TRUE
    	else
    		if( lexGetType( ) <> INVALID ) then
    			hReportError( FB_ERRMSG_SYNTAXERROR )
    			exit function
    		end if
    	end if

    	dotpos = lexGetPeriodPos( )
    	lexEatToken( id )
    	palias = NULL
    	istypeless	= FALSE

    	'' ('(' ArrayDecl? ')')?
		dimensions = 0
		if( hMatch( CHAR_LPRNT ) ) then

			if( lexGetToken( ) = CHAR_RPRNT ) then
				'' can't predict the size needed by the descriptor on stack
				if( fbIsLocal( ) ) then
					hReportError( FB_ERRMSG_ILLEGALINSIDEASUB, true )
					exit function
				end if

				dimensions = -1 				'' fake it
    		else
    			'' only allow indexes if not COMMON
    			if( (alloctype and FB_ALLOCTYPE_COMMON) = 0 ) then
    				if( not cArrayDecl( dimensions, exprTB() ) ) then
    					exit function
    				end if
    			end if
    		end if

			'' ')'
    		if( not hMatch( CHAR_RPRNT ) ) then
    			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    			exit function
    		end if

            '' QB quirk:
            '' when the symbol was defined already by a preceeding COMMON
            '' statement, then a DIM will work the same way as a REDIM
            if( is_dim ) then
                test_symbol = symbFindByNameAndClass( @id, FB_SYMBCLASS_VAR )
                if( test_symbol <> NULL ) then
                    if( symbGetArrayDimensions(test_symbol) <> 0 ) and _
                      ( (symbGetAllocType(test_symbol) and FB_ALLOCTYPE_COMMON) <> 0 ) _
                    then
                        alloctype and= not FB_ALLOCTYPE_STATIC
                        alloctype or= FB_ALLOCTYPE_DYNAMIC
                    end if
                end if
            end if

    	end if

		'' ALIAS LIT_STR
		if( (alloctype and (FB_ALLOCTYPE_PUBLIC or FB_ALLOCTYPE_EXTERN)) > 0 ) then
			if( hMatch( FB_TK_ALIAS ) ) then
				if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end if
				lexEatToken( idalias )
				idalias = hCreateDataAlias( idalias, (alloctype and FB_ALLOCTYPE_IMPORT) > 0 )
				palias = @idalias
			end if
		end if

    	'' dynamic?
    	isdynamic = FALSE
    	if( dimensions <> 0 ) then
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) > 0 ) then
				isdynamic = TRUE
			else
				if( (dimensions = -1) or hIsDynamic( dimensions, exprTB() ) ) then
    				isdynamic = TRUE
				end if
			end if
		end if

    	if( not ismultdecl ) then
    		'' (AS SymbolType)?
    		if( lexGetToken( ) = FB_TK_AS ) then

    			if( typ <> INVALID ) then
    				hReportError( FB_ERRMSG_SYNTAXERROR )
    				exit function
    			end if

    			lexSkipToken( )

    			if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    				hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    				exit function
    			end if

    			'' ANY?
    			if( typ = FB_SYMBTYPE_VOID ) then
    				hReportError( FB_ERRMSG_INVALIDDATATYPES )
    				exit function
    			end if

    			addsuffix = FALSE

    		else

				if( typ = INVALID ) then
					istypeless = TRUE
					typ = hGetDefType( id )
				end if
    			lgt	= symbCalcLen( typ, subtype )

    		end if
    	end if

    	'' contains a period?
    	if( dotpos > 0 ) then
    		if( typ = FB_SYMBTYPE_USERDEF ) then
    			hReportErrorEx( FB_ERRMSG_CANTINCLUDEPERIODS, id )
    			exit function
    		end if
    	end if

    	''
    	if( isdynamic ) then
    		symbol = hDynArrayDef( id, dotpos, palias, _
    							   typ, subtype, ptrcnt, istypeless, _
    							   lgt, addsuffix, alloctype, dopreserve, _
    							   dimensions, exprTB() )
    	else
			symbol = hStaticSymbDef( id, dotpos, palias, _
									 typ, subtype, ptrcnt, _
    							     lgt, addsuffix, alloctype, _
    							     dimensions, exprTB() )
		end if

    	if( symbol = NULL ) then
    		exit function
    	end if

		'' ('=' SymbolInitializer)?
		select case lexGetToken( )
		case FB_TK_DBLEQ, FB_TK_EQ
			lexSkipToken( )
        	if( not cSymbolInit( symbol ) ) then
        		exit function
        	end if
		end select

		'' (DECL_SEPARATOR SymbolDef)*
		if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken( )

    loop

    function = TRUE

end function

'':::::
function cSymbElmInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   byref ofs as integer, _
					   byval islocal as integer ) as integer static

	dim as integer dtype
	dim as ASTNODE ptr expr, assgexpr
    dim as FBSYMBOL ptr litsym

	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		return FALSE
	end if

    dtype = astGetDataType( expr )

	'' if static or at module level, only constants can be used as initializers
	if( not islocal ) then

		'' check if it's a literal string
		litsym = NULL
		if( dtype = IR_DATATYPE_FIXSTR ) then
			if( astIsVAR( expr ) ) then
				litsym = astGetSymbolOrElm( expr )
				if( litsym <> NULL ) then
					if( not symbGetVarInitialized( litsym ) ) then
						litsym = NULL
					end if
				end if
			end if
		end if

		'' not a literal string?
		if( litsym = NULL ) then

			'' string?
			if( hIsString( sym->typ ) ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				return FALSE
			end if

			'' offset?
			if( astIsOFFSET( expr ) ) then

				'' different types?
				if( (irGetDataClass( sym->typ ) <> IR_DATACLASS_INTEGER) or _
					(irGetDataSize( sym->typ ) <> FB_POINTERSIZE) ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					return FALSE
				end if

				irEmitVARINIOFS( astGetSymbolOrElm( expr ) )

			else
				'' not a constant?
				if( not astIsCONST( expr ) ) then
					hReportError( FB_ERRMSG_EXPECTEDCONST )
					return FALSE
				end if

				'' different types?
				if( dtype <> sym->typ ) then
					expr = astNewCONV( INVALID, sym->typ, sym->subtype, expr )
				end if

				select case as const sym->typ
				case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
					irEmitVARINI64( sym->typ, astGetValue64( expr ) )
				case FB_SYMBTYPE_SINGLE, FB_SYMBTYPE_DOUBLE
					irEmitVARINIf( sym->typ, astGetValuef( expr ) )
				case else
					irEmitVARINIi( sym->typ, astGetValuei( expr ) )
				end select

			end if

		else

			'' not a string?
			if( not hIsString( sym->typ ) ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				return FALSE
			end if

			'' can't be a variable-len string
			if( sym->typ = FB_SYMBTYPE_STRING ) then
				hReportError( FB_ERRMSG_CANTINITDYNAMICSTRINGS )
				return FALSE
			end if

			'' less the null-char
			irEmitVARINISTR( sym->lgt - 1, symbGetVarText( litsym ), symbGetLen( litsym ) - 1 )

			if( symbGetAccessCnt( litsym ) = 0 ) then
				symbDelVar( litsym )
			end if

		end if

		astDel( expr )

	else

        assgexpr = astNewVAR( basesym, NULL, ofs, sym->typ, sym->subtype )

        assgexpr = astNewASSIGN( assgexpr, expr )

        if( assgexpr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
            return FALSE
        end if

        astAdd( assgexpr )

	end if

	ofs += sym->lgt

	function = TRUE

end function

'':::::
function cSymbArrayInit( byval basesym as FBSYMBOL ptr, _
						 byval sym as FBSYMBOL ptr, _
					     byref ofs as integer, _
					     byval islocal as integer, _
					     byval isarray as integer ) as integer

    dim as integer dimensions, dimcnt, elements, elmcnt
    dim as integer isopen, lgt, pad
    dim as FBVARDIM ptr d, ld

	function = FALSE

	dimensions = sym->var.array.dims
    dimcnt = 0

	if( isarray ) then
		d = sym->var.array.dimhead
	else
		d = NULL
	end if

	lgt = 0

	'' for each array dimension..
	do
		'' '{'?
		isopen = FALSE
		if( isarray ) then
			if( hMatch( CHAR_LBRACE ) ) then
				dimcnt += 1
				if( dimcnt > dimensions ) then
					hReportError( FB_ERRMSG_TOOMANYEXPRESSIONS )
					exit function
				end if

				ld = d
				d = d->next

				isopen = TRUE
			end if
		end if

		if( d <> NULL ) then
			elements = (d->upper - d->lower) + 1
		else
			elements = 1
		end if

		'' for each array element..
		elmcnt = 0
		do

			if( sym->typ <> FB_SYMBTYPE_USERDEF ) then
				if( not cSymbElmInit( basesym, sym, ofs, islocal ) ) then
					exit function
				end if
			else
				if( not cSymbUDTInit( basesym, sym, ofs, islocal ) ) then
					exit function
				end if
			end if

			elmcnt += 1
			if( elmcnt >= elements ) then
				exit do
			end if

		'' ','
		loop while( hMatch( CHAR_COMMA ) )

		'' pad
		if( not islocal ) then
			if( elmcnt < elements ) then
				irEmitVARINIPAD (elements - elmcnt) * sym->lgt
			end if
			lgt += elements * sym->lgt
		else
			lgt += elmcnt * sym->lgt
		end if

		if( not isopen ) then
			exit do
		end if

		if( isarray ) then
			'' '}'?
			if( not hMatch( CHAR_RBRACE ) ) then
				hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
				exit function
			end if

			dimcnt -= 1
			d = ld
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' pad
	pad = (sym->lgt * hCalcElements( sym )) - lgt
	if( pad > 0 ) then
		if( not islocal ) then
			irEmitVARINIPAD( pad )
		else
			ofs += pad
		end if
	end if

	function = TRUE

end function

'':::::
function cSymbUDTInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   byref ofs as integer, _
					   byval islocal as integer ) as integer

	dim as integer elements, elmcnt, isarray, elmofs, lgt, pad
    dim as FBSYMBOL ptr elm, lelm, udt

    function = FALSE

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
		exit function
	end if

	udt = sym->subtype
	elm = symbGetUDTFirstElm( udt )
	lelm = NULL

	elements = udt->udt.elements
	elmcnt = 0

	lgt = 0

	'' for each UDT element..
	do
		elmcnt += 1
		if( elmcnt > elements ) then
			hReportError( FB_ERRMSG_TOOMANYEXPRESSIONS )
			exit function
		end if

		'' '{'?
		isarray = hMatch( CHAR_LBRACE )

		elmofs = elm->var.elm.ofs
		if( not islocal ) then
			if( lelm <> NULL ) then
				pad = (elmofs - lelm->var.elm.ofs) - lelm->lgt
				if( pad > 0 ) then
					irEmitVARINIPAD( pad )
					lgt += pad
				end if
			end if
		end if

		elmofs += ofs

        if( not cSymbArrayInit( basesym, elm, elmofs, islocal, isarray ) ) then
          	exit function
        end if

        if( isarray ) then
			'' '}'
			if( not hMatch( CHAR_RBRACE ) ) then
				hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
				exit function
			end if
		end if

		lgt += elm->lgt

		'' next
		lelm = elm
		elm = symbGetUDTNextElm( elm )

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	ofs += sym->lgt

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
		exit function
	end if

	'' pad
	if( not islocal ) then
		pad = sym->lgt - lgt
		if( pad > 0 ) then
			irEmitVARINIPAD( pad )
		end if
	end if

	function = TRUE

end function

'':::::
function cSymbolInit( byval sym as FBSYMBOL ptr ) as integer
    dim as integer islocal, isarray, ofs

	function = FALSE

	'' cannot initialize dynamic vars
	if( symbGetIsDynamic( sym ) ) then
		hReportError( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
		exit function
	end if

	'' common?? impossible but..
	if( symbIsCommon( sym ) ) then
		hReportError( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
		exit function
	end if

	'' already emited?? impossible but..
	if( symbGetVarEmited( sym ) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
		exit function
	end if

	symbSetVarEmited( sym, TRUE )

	islocal = (not symbIsStatic( sym )) and fbIsLocal( )

	''
	if( not islocal ) then
		irEmitVARINIBEGIN( sym )
	end if

	'' '{'?
	isarray = hMatch( CHAR_LBRACE )

	ofs = 0

	if( not cSymbArrayInit( sym, sym, ofs, islocal, isarray ) ) then
		exit function
	end if

    if( isarray ) then
		'' '}'
		if( not hMatch( CHAR_RBRACE ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRBRACKET )
			exit function
		end if
	end if

	''
	if( not islocal ) then
		irEmitVARINIEND( sym )
	end if

	''
	function = TRUE

end function

'':::::
''ArrayDecl       =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cStaticArrayDecl( byref dimensions as integer, _
						   dTB() as FBARRAYDIM ) as integer

    static as integer i
    static as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    '' IDX_OPEN
    if( not hMatch( CHAR_LPRNT ) ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB_ERRMSG_EXPECTEDCONST
			exit function
		else
			if( not astIsCONST( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			end if
		end if

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).lower = astGetValue64( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).lower = astGetValuef( expr )
		case else
			dTB(i).lower = astGetValuei( expr )
		end select

		astDel( expr )

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			else
				if( not astIsCONST( expr ) ) then
					hReportError FB_ERRMSG_EXPECTEDCONST
					exit function
				end if
			end if

			dTB(i).upper = astGetValueAsInt( expr )
			astDel( expr )

    	else
    	    dTB(i).upper = dTB(i).lower
    		dTB(i).lower = env.opt.base
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

		if( i >= FB_MAXARRAYDIMS ) then
			hReportError FB_ERRMSG_TOOMANYDIMENSIONS
			exit function
		end if
	loop

	'' IDX_CLOSE
    if( not hMatch( CHAR_RPRNT ) ) then
    	hReportError FB_ERRMSG_EXPECTEDRPRNT
    	exit function
    end if

	function = TRUE

end function

'':::::
''ArrayDecl    	  =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cArrayDecl( byref dimensions as integer, _
					 exprTB() as ASTNODE ptr ) as integer

    dim as integer i
    dim as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
			exit function
		end if

    	'' check if non-numeric
    	if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    		hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    		exit function
    	end if

		exprTB(i,0) = expr

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if

    		'' check if non-numeric
    		if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    			exit function
    		end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONSTi( env.opt.base, IR_DATATYPE_INTEGER )
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

		if( i >= FB_MAXARRAYDIMS ) then
			hReportError FB_ERRMSG_TOOMANYDIMENSIONS
			exit function
		end if
	loop

	function = TRUE

end function

''::::
function cConstExprValue( byref value as integer ) as integer
    dim as ASTNODE ptr expr

    function = FALSE

    if( not cExpression( expr ) ) then
    	hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    	exit function
    end if

	if( not astIsCONST( expr ) ) then
		hReportError FB_ERRMSG_EXPECTEDCONST
		exit function
	end if

	value = astGetValueAsInt( expr )
  	astDel( expr )

  	function = TRUE

end function

'':::::
function hMangleFuncPtrName( byval proc as FBSYMBOL ptr, _
							 byval typ as integer, _
							 byval subtype as FBSYMBOL ptr, _
					    	 byval mode as integer ) as zstring ptr static

    static as zstring * FB_MAXINTNAMELEN+1 mname, aname
    dim as FBSYMBOL ptr arg
    dim as integer i

    mname = "{fbfp}"

    arg = symbGetProcTailArg( proc )
    for i = 0 to symbGetProcArgs( proc )-1
    	mname += "_"

    	if( arg->subtype = NULL ) then
    		aname = hex( arg->typ * arg->arg.mode )
    	else
    		aname = hex( arg->subtype )
    	end if

    	mname += aname

    	arg = arg->prev
    next

    mname += "@"

	if( subtype = NULL ) then
		mname += hex( typ )
	else
		mname += hex( subtype )
	end if

    mname += "@"

    mname += hex( mode )

	function = @mname

end function

'':::::
function cSymbolTypeFuncPtr( byval isfunction as integer ) as FBSYMBOL ptr
	dim as integer typ, lgt, mode, ptrcnt
	dim as FBSYMBOL ptr proc, sym, subtype
	static as zstring ptr sname

	function = NULL

	'' mode
	mode = cFunctionMode( )

	proc = symbPreAddProc( )

	'' ('(' Argument? ')')
	if( hMatch( CHAR_LPRNT ) ) then

		cArguments( proc, mode, TRUE )
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	if( not hMatch( CHAR_RPRNT ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end if

	'' (AS SymbolType)?
	if( hMatch( FB_TK_AS ) ) then
		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			exit function
		end if

	else
		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			hReportError( FB_ERRMSG_EXPECTEDRESTYPE )
			exit function
		end if

		subtype = NULL
		typ = FB_SYMBTYPE_VOID
		ptrcnt = 0
	end if

	sname = hMangleFuncPtrName( proc, typ, subtype, mode )

	'' already exists?
	sym = symbFindByNameAndClass( sname, FB_SYMBCLASS_PROC, TRUE )
	if( sym <> NULL ) then
		return sym
	end if

	'' create a new prototype
	function = symbAddPrototype( proc, sname, NULL, NULL, _
							     typ, subtype, ptrcnt, _
							     0, mode, TRUE, TRUE )

end function


'':::::
''SymbolType      =   UNSIGNED? (
''				      ANY
''				  |   CHAR|BYTE
''				  |	  SHORT|WORD
''				  |	  INTEGER|LONG|DWORD
''				  |   SINGLE
''				  |   DOUBLE
''                |   STRING ('*' NUM_LIT)?
''                |   USERDEFTYPE
''				  |   (FUNCTION|SUB) ('(' args ')') (AS SymbolType)?
''				      (PTR|POINTER)* .
''
function cSymbolType( byref typ as integer, _
					  byref subtype as FBSYMBOL ptr, _
					  byref lgt as integer, _
					  byref ptrcnt as integer ) as integer

    dim as integer isunsigned, isfunction, allowptr
    dim s as FBSYMBOL ptr

	function = FALSE

	lgt 	= 0
	typ 	= INVALID
	subtype = NULL
	ptrcnt	= 0

	allowptr = TRUE

	'' UNSIGNED?
	isunsigned = hMatch( FB_TK_UNSIGNED )

	''
	select case as const lexGetToken( )
	case FB_TK_ANY
		lexSkipToken( )
		typ = FB_SYMBTYPE_VOID
		lgt = 0

	case FB_TK_BYTE
		lexSkipToken( )
		typ = FB_SYMBTYPE_BYTE
		lgt = 1
	case FB_TK_UBYTE
		lexSkipToken( )
		typ = FB_SYMBTYPE_UBYTE
		lgt = 1

	case FB_TK_SHORT
		lexSkipToken( )
		typ = FB_SYMBTYPE_SHORT
		lgt = 2
	case FB_TK_USHORT
		lexSkipToken( )
		typ = FB_SYMBTYPE_USHORT
		lgt = 2

	case FB_TK_INTEGER, FB_TK_LONG
		lexSkipToken( )
		typ = FB_SYMBTYPE_INTEGER
		lgt = FB_INTEGERSIZE
	case FB_TK_UINT
		lexSkipToken( )
		typ = FB_SYMBTYPE_UINT
		lgt = FB_INTEGERSIZE

	case FB_TK_LONGINT
		lexSkipToken( )
		typ = FB_SYMBTYPE_LONGINT
		lgt = FB_INTEGERSIZE*2
	case FB_TK_ULONGINT
		lexSkipToken( )
		typ = FB_SYMBTYPE_ULONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_TK_SINGLE
		lexSkipToken( )
		typ = FB_SYMBTYPE_SINGLE
		lgt = 4

	case FB_TK_DOUBLE
		lexSkipToken( )
		typ = FB_SYMBTYPE_DOUBLE
		lgt = 8

	case FB_TK_STRING
		if( lexGetLookAhead(1) = CHAR_STAR ) then
			lexSkipToken( )
			lexSkipToken( )
			typ = FB_SYMBTYPE_FIXSTR
			if( not cConstExprValue( lgt ) ) then
				exit function
			end if
			lgt += 1
			'' min 1 char + null-term
			if( lgt <= 1 ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
			allowptr = FALSE
		else
			typ = FB_SYMBTYPE_STRING
			lgt = FB_STRDESCLEN
			lexSkipToken( )
		end if

	case FB_TK_ZSTRING
		lexSkipToken( )
		if( lexGetToken( ) = CHAR_STAR ) then
			lexSkipToken( )
			if( not cConstExprValue( lgt ) ) then
				exit function
			end if
			typ = FB_SYMBTYPE_CHAR
			'' min 1 char
			if( lgt < 1 ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
			allowptr = FALSE

		else
    		typ = FB_SYMBTYPE_CHAR
    		lgt = 0
		end if

	case FB_TK_FUNCTION, FB_TK_SUB
	    isfunction = (lexGetToken( ) = FB_TK_FUNCTION)
	    lexSkipToken( )

		typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION
		lgt = FB_POINTERSIZE
		ptrcnt = 1

		subtype = cSymbolTypeFuncPtr( isfunction )
		if( subtype = NULL ) then
			exit function
		end if

	case else
		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_UDT )
		if( s <> NULL ) then
			lexSkipToken( )
			typ 	= FB_SYMBTYPE_USERDEF
			subtype = s
			lgt 	= s->lgt
		else
			s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_ENUM )
			if( s <> NULL ) then
				lexSkipToken( )
				typ 	= FB_SYMBTYPE_ENUM
				subtype = s
				lgt 	= FB_INTEGERSIZE
			else
				s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_TYPEDEF )
				if( s <> NULL ) then
					lexSkipToken( )
					typ 	= s->typ
					subtype = s->subtype
					lgt 	= s->lgt
					ptrcnt	= s->ptrcnt
			    end if
			end if
		end if
	end select

	''
	if( typ <> INVALID ) then

		if( isunsigned ) then
			select case as const typ
			case FB_SYMBTYPE_BYTE
				typ = FB_SYMBTYPE_UBYTE
			case FB_SYMBTYPE_SHORT
				typ = FB_SYMBTYPE_USHORT
			case FB_SYMBTYPE_INTEGER
				typ = FB_SYMBTYPE_UINT
			case FB_SYMBTYPE_LONGINT
				typ = FB_SYMBTYPE_ULONGINT
			case else
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end select
		end if

		'' (PTR|POINTER)*
		do
			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				lexSkipToken( )
				typ += FB_SYMBTYPE_POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop

        if( ptrcnt > 0 ) then
			if( not allowptr ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if

			lgt = FB_POINTERSIZE

		else
			'' can't have forward typedef's if they aren't pointers
			if( typ = FB_SYMBTYPE_FWDREF ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE )
				exit function
			elseif( lgt <= 0 ) then
				if( typ = FB_SYMBTYPE_CHAR ) then
					hReportError( FB_ERRMSG_EXPECTEDPOINTER )
					exit function
				end if
			end if
		end if

		function = TRUE

	else
		if( isunsigned ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end if

end function

'':::::
''ProcDecl        =   DECLARE (SUB SubDecl) |
''                            (FUNCTION FuncDecl) .
''
function cProcDecl as integer

    function = FALSE

    '' DECLARE
    lexSkipToken( )

	select case lexGetToken( )
	case FB_TK_SUB
		lexSkipToken( )
		function = cSubOrFuncDecl( TRUE )

	case FB_TK_FUNCTION
		lexSkipToken( )
		function = cSubOrFuncDecl( FALSE )

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
	end select

end function

'':::::
function cFunctionMode as integer

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexGetToken( )
	case FB_TK_CDECL
		function = FB_FUNCMODE_CDECL
		lexSkipToken( )
	case FB_TK_STDCALL
		function = FB_FUNCMODE_STDCALL
		lexSkipToken( )
	case FB_TK_PASCAL
		function = FB_FUNCMODE_PASCAL
		lexSkipToken( )
	case else
		function = FB_DEFAULT_FUNCMODE
	end select

end function

'':::::
''SubOrFuncDecl      =  ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')?
''					 |	ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')? (AS SymbolType)? .
''
function cSubOrFuncDecl( byval isSub as integer ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id, libname, aliasname
    dim as zstring ptr plib, palias
    dim as integer typ, mode, lgt, ptrcnt, alloctype
    dim as FBSYMBOL ptr subtype, proc

	function = FALSE

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	typ = lexGetType( )
	lexEatToken( id )
	subtype = NULL
	ptrcnt = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError( FB_ERRMSG_INVALIDCHARACTER )
    	exit function
	end if

	''
	mode = cFunctionMode( )

	'' OVERLOAD?
	alloctype = 0
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
		lexSkipToken( )
		alloctype = FB_ALLOCTYPE_OVERLOADED
	end if

	'' (LIB STR_LIT)?
	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		lexEatToken( libname )
		plib = @libname
	else
		plib = NULL
	end if

	'' (ALIAS STR_LIT)?
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		lexEatToken( aliasname )
		palias = @aliasname
	else
		palias = NULL
	end if

	proc = symbPreAddProc( )

	'' ('(' Arguments? ')')?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		cArguments( proc, mode, TRUE )

		if( lexGetToken( ) <> CHAR_RPRNT ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		lexSkipToken( )
	end if

    '' (AS SymbolType)?
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError( FB_ERRMSG_SYNTAXERROR )
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB_SYMBTYPE_FIXSTR, FB_SYMBTYPE_CHAR
    		hReportError( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
    		exit function
    	case FB_SYMBTYPE_VOID
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB_SYMBTYPE_VOID
    	subtype = NULL
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    ''
    proc = symbAddPrototype( proc, @id, palias, plib, _
    						 typ, subtype, ptrcnt, _
    					     alloctype, mode, FALSE )
    if( proc = NULL ) then
    	hReportError( FB_ERRMSG_DUPDEFINITION )
    	exit function
    end if

    function = TRUE

end function

'':::::
''Arguments       =   ArgDecl (',' ArgDecl)* .
''
function cArguments( byval proc as FBSYMBOL ptr, _
					 byval procmode as integer, _
					 byval isproto as integer ) as FBSYMBOL ptr

	dim as FBSYMBOL ptr arg

	do
		arg = cArgDecl( proc, procmode, isproto )
		if( arg = NULL ) then
			return NULL
		end if

		'' vararg?
		if( arg->arg.mode = FB_ARGMODE_VARARG ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	function = arg

end function

'':::::
private sub hReportParamError( byval argnum as integer, byval id as string )

	hReportErrorEx( FB_ERRMSG_ILLEGALPARAMSPECAT, "at parameter " + str$( argnum+1 ) + ": " + id )

end sub

'':::::
''ArgDecl         =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
function cArgDecl( byval proc as FBSYMBOL ptr, _
				   byval procmode as integer, _
				   byval isproto as integer ) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 idTB(0 to FB_MAXARGRECLEVEL-1)
	static as integer arglevel = 0
	dim as zstring ptr pid
	dim as ASTNODE ptr expr
	dim as integer dclass, dtype, readid, mode, dotpos
	dim as integer atype, amode, alen, asuffix, optional, ptrcnt
	dim as FBVALUE optval
	dim as FBSYMBOL ptr subtype, sym

	function = NULL

	'' "..."?
	if( lexGetToken( ) = FB_TK_VARARG ) then
		'' not cdecl or is it the first arg?
		if( (procmode <> FB_FUNCMODE_CDECL) or _
			(symbGetProcArgs( proc ) = 0) ) then
			hReportParamError( symbGetProcArgs( proc ), *lexGetText( ) )
			exit function
		end if

		lexSkipToken( )

		return symbAddArg( proc, NULL, _
						   INVALID, NULL, 0, _
						   0, FB_ARGMODE_VARARG, INVALID, _
						   FALSE, NULL )
	end if

	'' (BYVAL|BYREF)?
	select case lexGetToken( )
	case FB_TK_BYVAL
		mode = FB_ARGMODE_BYVAL
		lexSkipToken( )
	case FB_TK_BYREF
		mode = FB_ARGMODE_BYREF
		lexSkipToken( )
	case else
		mode = INVALID
	end select

	'' only allow keywords as arg names on prototypes
	readid = TRUE
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		if( not isproto ) then
			'' anything but keywords will be catch by parser (could be a ')' too)
			if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
				hReportParamError( symbGetProcArgs( proc ), *lexGetText( ) )
				exit function
			end if
		end if

		if(	lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
			if( symbGetProcArgs( proc ) > 0 ) then
				hReportParamError( symbGetProcArgs( proc ), *lexGetText( ) )
			end if
			exit function
		end if

		if( isproto ) then
			'' AS?
			if( lexGetToken( ) = FB_TK_AS ) then
				readid = FALSE
			end if
		end if
	end if

	''
	if( arglevel >= FB_MAXARGRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	pid = @idTB(arglevel)

	''
	if( readid ) then
		'' ID
		atype  = lexGetType( )
		dotpos = lexGetPeriodPos( )
		lexEatToken( *pid )

		'' ('('')')
		if( hMatch( CHAR_LPRNT ) ) then
			if( (mode <> INVALID) or (not hMatch( CHAR_RPRNT )) ) then
				hReportParamError( symbGetProcArgs( proc ), *pid )
				exit function
			end if

			amode = FB_ARGMODE_BYDESC

		else
			if( mode = INVALID ) then
				amode = env.opt.argmode
			else
				amode = mode
			end if
		end if

	'' no id
	else
		atype  = INVALID
		dotpos = 0

		if( mode = INVALID ) then
			amode = env.opt.argmode
		else
			amode = mode
		end if
	end if

    '' (AS SymbolType)?
    if( hMatch( FB_TK_AS ) ) then
    	if( atype <> INVALID ) then
    		hReportParamError( symbGetProcArgs( proc ), *pid )
    		exit function
    	end if

    	arglevel += 1
    	if( not cSymbolType( atype, subtype, alen, ptrcnt ) ) then
    		hReportParamError( symbGetProcArgs( proc ), *pid )
    		arglevel -= 1
    		exit function
    	end if
    	arglevel -= 1

    	asuffix = INVALID

    else
    	if( not readid ) then
    		hReportParamError( symbGetProcArgs( proc ), "" )
    		exit function
    	end if

    	subtype = NULL
    	asuffix = atype
    	ptrcnt = 0
    end if

    ''
    if( atype = INVALID ) then
        atype = hGetDefType( *pid )
        asuffix = atype
    end if

    '' check for invalid args
    select case atype
    '' can't be a fixed-len string
    case FB_SYMBTYPE_FIXSTR, FB_SYMBTYPE_CHAR
    	hReportParamError( symbGetProcArgs( proc ), *pid )
    	exit function

	'' can't be as ANY on non-prototypes
    case FB_SYMBTYPE_VOID
    	if( not isproto ) then
    		hReportParamError( symbGetProcArgs( proc ), *pid )
    		exit function
    	end if
    end select

    ''
    select case amode
    case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
    	alen = FB_POINTERSIZE

    case FB_ARGMODE_BYVAL

    	'' check for invalid args
    	if( isproto ) then
    		select case atype
    		case FB_SYMBTYPE_VOID
    			hReportParamError( symbGetProcArgs( proc ), *pid )
    			exit function
    		end select
    	end if

    	if( atype = FB_SYMBTYPE_STRING ) then
    		alen = FB_POINTERSIZE
    	else
    		alen = symbCalcLen( atype, subtype, TRUE )
    	end if
    end select

    if( not isproto ) then
    	'' contains a period?
    	if( dotpos > 0 ) then
    		if( atype = FB_SYMBTYPE_USERDEF ) then
    			hReportParamError( symbGetProcArgs( proc ), *pid )
    			exit function
    		end if
    	end if
    end if

    '' ('=' (NUM_LIT|STR_LIT))?
    if( hMatch( FB_TK_ASSIGN ) ) then

    	'' not byval or byref?
    	if( (amode <> FB_ARGMODE_BYVAL) and (amode <> FB_ARGMODE_BYREF) ) then
 	   		hReportParamError( symbGetProcArgs( proc ), *pid )
    		exit function
    	end if

    	dclass = irGetDataClass( atype )

    	'' not int, float or string?
    	select case dclass
    	case IR_DATACLASS_INTEGER, IR_DATACLASS_FPOINT, IR_DATACLASS_STRING
    	case else
 	   		hReportParamError( symbGetProcArgs( proc ), *pid )
    		exit function
    	end select

    	if( not cExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDCONST )
    		exit function
    	end if

    	dtype = astGetDataType( expr )
    	'' not a constant?
    	if( not astIsCONST( expr ) ) then
    		'' not a literal string?
    		if( (not astIsVAR( expr )) or (dtype <> IR_DATATYPE_FIXSTR) ) then
				hReportError( FB_ERRMSG_EXPECTEDCONST )
				exit function
			end if

			sym = astGetSymbolOrElm( expr )
			'' diff types or isn't it a literal string?
			if( (dclass <> IR_DATACLASS_STRING) or _
				(not symbGetVarInitialized( sym )) ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if

		else
			'' diff types?
			if( dclass = IR_DATACLASS_STRING ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES )
				exit function
			end if
		end if

    	optional = TRUE
    	'' string?
    	select case as const atype
    	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
    		optval.valuestr = sym
    	case else
    		astConvertValue( expr, @optval, atype )
    	end select

    	astDel( expr )

    else
    	optional = FALSE
    end if

    if( isproto ) then
    	pid = NULL
    end if

    function = symbAddArg( proc, pid, _
    					   atype, subtype, ptrcnt, _
    					   alen, amode, asuffix, _
    					   optional, @optval )

end function

'':::::
''DefDecl         =   (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
''
function cDefDecl as integer static
    static as zstring * 32+1 char
    dim as integer typ, ichar, echar

	function = FALSE

	typ = INVALID

	select case as const lexGetToken( )
	case FB_TK_DEFBYTE
		typ = FB_SYMBTYPE_BYTE
	case FB_TK_DEFUBYTE
		typ = FB_SYMBTYPE_UBYTE
	case FB_TK_DEFSHORT
		typ = FB_SYMBTYPE_SHORT
	case FB_TK_DEFUSHORT
		typ = FB_SYMBTYPE_USHORT
	case FB_TK_DEFINT, FB_TK_DEFLNG
		typ = FB_SYMBTYPE_INTEGER
	case FB_TK_DEFUINT
		typ = FB_SYMBTYPE_UINT
	case FB_TK_DEFLNGINT
		typ = FB_SYMBTYPE_LONGINT
	case FB_TK_DEFULNGINT
		typ = FB_SYMBTYPE_ULONGINT
	case FB_TK_DEFUSHORT
		typ = FB_SYMBTYPE_USHORT
	case FB_TK_DEFSNG
		typ = FB_SYMBTYPE_SINGLE
	case FB_TK_DEFDBL
		typ = FB_SYMBTYPE_DOUBLE
	case FB_TK_DEFSTR
		typ = FB_SYMBTYPE_STRING
	end select

	if( typ <> INVALID ) then
		lexSkipToken( )

		'' (CHAR '-' CHAR ','?)*
		do
			'' CHAR
			char = ucase$( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				hReportError FB_ERRMSG_EXPECTEDCOMMA
				exit do
			end if
			ichar = asc( char )
			lexSkipToken( )

			'' '-'
			if( not hMatch( CHAR_MINUS ) ) then
				hReportError FB_ERRMSG_EXPECTEDMINUS
				exit do
			end if

			'' CHAR
			char = ucase$( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				hReportError FB_ERRMSG_EXPECTEDCOMMA
				exit do
			end if
			echar = asc( char )
			lexSkipToken( )

			''
			hSetDefType( ichar, echar, typ )

      		'' ','
      		if( lexGetToken( ) <> CHAR_COMMA ) then
      			exit do
      		else
      			lexSkipToken( )
      		end if

		loop

		function = TRUE
	end if

end function

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl as integer
	dim s as FBSYMBOL ptr

	function = FALSE

	'' OPTION
	lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_EXPLICIT
		lexSkipToken( )
		env.opt.explicit = TRUE

	case FB_TK_BASE
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		env.opt.base = valint( *lexGetText( ) )
		lexSkipToken( )

	case FB_TK_BYVAL
		lexSkipToken( )
		env.opt.argmode = FB_ARGMODE_BYVAL

	case FB_TK_PRIVATE
		lexSkipToken( )
		env.opt.procpublic = FALSE

	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE

	case else

		'' ESCAPE? (it's not a reserved word, there are too many already..)
		select case ucase$( *lexGetText( ) )
		case "ESCAPE"
			lexSkipToken( )
			env.opt.escapestr = TRUE

		'' NOKEYWORD? (ditto..)
		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
				select case lexGetClass( LEXCHECK_NODEFINE )
				case FB_TKCLASS_KEYWORD
					if( not symbDelKeyword( lexGetSymbol ) ) then
						hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
						exit function
					end if

					lexSkipToken( )

				case FB_TKCLASS_IDENTIFIER
					'' proc?
					s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
					if( s <> NULL ) then

						'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
						if( not symbGetProcIsRTL( s ) ) then
							hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
							exit function
						end if

						symbDelPrototype( s )
					else

						'' macro?
						s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_DEFINE )
						if( s = NULL ) then
							hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
							exit function
						end if

						symbDelDefine( s )
					end if

					lexSkipToken( )

				case else
					hReportError FB_ERRMSG_SYNTAXERROR
					exit function
				end select

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				else
					lexSkipToken( LEXCHECK_NODEFINE )
				end if

			loop

		case else
			hReportError FB_ERRMSG_SYNTAXERROR
			exit function
		end select

	end select

	function = TRUE

end function

'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cProcParam( byval proc as FBSYMBOL ptr, _
					 byval arg as FBSYMBOL ptr, _
					 byval param as integer, _
					 byref expr as ASTNODE ptr, _
					 byref pmode as integer, _
					 byval isfunc as integer, _
					 byval optonly as integer ) as integer

	dim as integer amode
	dim as FBSYMBOL ptr oldsym

	function = FALSE

	amode = symbGetArgMode( proc, arg )

	pmode = INVALID
	expr = NULL

	if( not optonly ) then
		'' BYVAL?
		if( hMatch( FB_TK_BYVAL ) ) then
			pmode = FB_ARGMODE_BYVAL
		end if

		oldsym = env.ctxsym
		env.ctxsym = arg

		'' Expression
		if( not cExpression( expr ) ) then

			'' error?
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				env.ctxsym = oldsym
				exit function
			end if

			if( isfunc ) then
				expr = NULL

			else
				'' failed and expr not null?
				if( expr <> NULL ) then
					env.ctxsym = oldsym
					exit function
				end if

				'' check for BYVAL if it's the first param, due the optional ()'s
				if( (param = 0) and (pmode = INVALID) ) then
					'' BYVAL?
					if( hMatch( FB_TK_BYVAL ) ) then
						pmode = FB_ARGMODE_BYVAL
						if( not cExpression( expr ) ) then
							expr = NULL
						end if
					end if
				end if
			end if

		end if

		env.ctxsym = oldsym
	end if

	if( expr = NULL ) then

		'' check if argument is optional
		if( not symbGetArgOptional( proc, arg ) ) then
			if( amode <> FB_ARGMODE_VARARG ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
			end if
			exit function
		end if

		'' create an arg
		select case as const symbGetType( arg )
  		case IR_DATATYPE_ENUM
  			expr = astNewENUM( symbGetArgOptvalI( proc, arg ), symbGetSubType( arg ) )

		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			expr = astNewVAR( symbGetArgOptvalStr( proc, arg ), NULL, 0, IR_DATATYPE_FIXSTR )

		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			expr = astNewCONST64( symbGetArgOptval64( proc, arg ), symbGetType( arg ) )

		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			expr = astNewCONSTf( symbGetArgOptvalF( proc, arg ), symbGetType( arg ) )

		case else
			expr = astNewCONSTi( symbGetArgOptvalI( proc, arg ), _
								 symbGetType( arg ), symbGetSubType( arg ) )
		end select

	else

		'' '('')'?
		if( amode = FB_ARGMODE_BYDESC ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				if( lexGetLookAhead(1) = CHAR_RPRNT ) then
					if( pmode <> INVALID ) then
						hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
						exit function
					end if
					lexSkipToken( )
					lexSkipToken( )
					pmode = FB_ARGMODE_BYDESC
				end if
			end if
    	end if

    end if

	''
	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            if( amode <> FB_ARGMODE_VARARG ) then
            	'' allow BYVAL params passed to BYREF/BYDESC args
            	'' (to pass NULL to pointers and so on)
            	if( pmode <> FB_ARGMODE_BYVAL ) then
					if( amode <> pmode ) then
						hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
						exit function
					end if
				end if
			end if
		end if
	end if

	function = TRUE

end function

'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cOvlProcParam( byval param as integer, _
					    byref expr as ASTNODE ptr, _
					    byref pmode as integer, _
					    byval isfunc as integer, _
					    byval optonly as integer ) as integer

	dim as FBSYMBOL ptr oldsym

	function = FALSE

	pmode = INVALID
	expr = NULL

	if( not optonly ) then
		'' BYVAL?
		if( hMatch( FB_TK_BYVAL ) ) then
			pmode = FB_ARGMODE_BYVAL
		end if

		oldsym = env.ctxsym
		env.ctxsym = NULL

		'' Expression
		if( not cExpression( expr ) ) then

			'' error?
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				env.ctxsym = oldsym
				exit function
			end if

			if( isfunc ) then
				expr = NULL

			else
				'' failed and expr not null?
				if( expr <> NULL ) then
					env.ctxsym = oldsym
					exit function
				end if

				'' check for BYVAL if it's the first param, due the optional ()'s
				if( (param = 0) and (pmode = INVALID) ) then
					'' BYVAL?
					if( hMatch( FB_TK_BYVAL ) ) then
						pmode = FB_ARGMODE_BYVAL
						if( not cExpression( expr ) ) then
							expr = NULL
						end if
					end if
				end if
			end if

		end if

		env.ctxsym = oldsym

	end if

	if( expr <> NULL ) then
		'' '('')'?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( lexGetLookAhead(1) = CHAR_RPRNT ) then
				if( pmode <> INVALID ) then
					hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
					exit function
				end if
				lexSkipToken( )
				lexSkipToken( )
				pmode = FB_ARGMODE_BYDESC
			end if
		end if

    end if

	function = TRUE

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
private function hOvlProcParamList( byval proc as FBSYMBOL ptr, _
									byval ptrexpr as ASTNODE ptr, _
									byval isfunc as integer, _
									byval optonly as integer ) as ASTNODE ptr

    dim as integer args, p, params, modeTB(0 to FB_MAXPROCARGS-1)
    dim as FBSYMBOL ptr arg
    dim as ASTNODE ptr procexpr, exprTB(0 to FB_MAXPROCARGS-1)

	function = NULL

	params = 0
	args = symGetProcOvlMaxArgs( proc )

	if( not optonly ) then
		do
			if( params >= args ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
				exit function
			end if

			if( params >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( not cOvlProcParam( params, exprTB(params), modeTB(params), _
								   isfunc, FALSE ) ) then
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				end if
			end if

			params += 1

		loop while( hMatch( CHAR_COMMA ) )
	end if

	''
	proc = symbFindClosestOvlProc( proc, params, exprTB(), modeTB() )

	''
	args = symbGetProcArgs( proc )

	if( params < args ) then

	    arg = symbGetProcLastArg( proc )
	    for p = 1 to params
	    	arg = symbGetProcPrevArg( proc, arg )
	    next

		do while( params < args )
			if( params >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( not cProcParam( proc, arg, params, _
								exprTB(params), modeTB(params), _
								isfunc, TRUE ) ) then
				exit function
			end if

			params += 1
			arg = symbGetProcPrevArg( proc, arg )
		loop
	end if

	''
	procexpr = astNewFUNCT( proc, ptrexpr )

    ''
	for p = 0 to params-1

		if( astNewPARAM( procexpr, exprTB(p), INVALID, modeTB(p) ) = NULL ) then
			hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
			exit function
		end if

	next

	function = procexpr

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
function cProcParamList( byval proc as FBSYMBOL ptr, _
						 byval ptrexpr as ASTNODE ptr, _
						 byval isfunc as integer, _
						 byval optonly as integer ) as ASTNODE ptr

    dim as integer args, p, params, modeTB(0 to FB_MAXPROCARGS-1)
    dim as FBSYMBOL ptr arg
    dim as ASTNODE ptr procexpr, exprTB(0 to FB_MAXPROCARGS-1)

	'' overloaded?
	if( symbGetProcIsOverloaded( proc ) ) then
		return hOvlProcParamList( proc, ptrexpr, isfunc, optonly )
	end if

	function = NULL

	args = symbGetProcArgs( proc )

	'' proc has no args?
	if( args = 0 ) then
		if( not isfunc ) then
			'' '('
			if( hMatch( CHAR_LPRNT ) ) then
				'' ')'
				if( not hMatch( CHAR_RPRNT ) ) then
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end if
			end if
		end if

		return astNewFUNCT( proc, ptrexpr )
	end if

	params = 0
	arg = symbGetProcLastArg( proc )

	if( not optonly ) then
		do
			if( params >= args ) then
				if( arg->arg.mode <> FB_ARGMODE_VARARG ) then
					hReportError( FB_ERRMSG_ARGCNTMISMATCH )
					exit function
				end if
			end if

			if( params >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( not cProcParam( proc, arg, params, _
								exprTB(params), modeTB(params), _
								isfunc, FALSE ) ) then
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				else
					exit do
				end if
			end if

			params += 1

			if( params < args ) then
				arg = symbGetProcPrevArg( proc, arg )
			end if

		loop while( hMatch( CHAR_COMMA ) )
	end if

	''
	do while( params < args )
		if( arg->arg.mode = FB_ARGMODE_VARARG ) then
			exit do
		end if

		if( params >= FB_MAXPROCARGS ) then
			hReportError( FB_ERRMSG_TOOMANYPARAMS )
			exit function
		end if

		if( not cProcParam( proc, arg, params, _
							exprTB(params), modeTB(params), _
							isfunc, TRUE ) ) then
			exit function
		end if

		params += 1
		arg = symbGetProcPrevArg( proc, arg )
	loop

    ''
    procexpr = astNewFUNCT( proc, ptrexpr )

    ''
	for p = 0 to params-1

		if( astNewPARAM( procexpr, exprTB(p), INVALID, modeTB(p) ) = NULL ) then
			hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
			exit function
		end if

	next

	function = procexpr

end function

'':::::
function hAssignFunctResult( byval proc as FBSYMBOL ptr, _
							 byval expr as ASTNODE ptr ) as integer static
    dim s as FBSYMBOL ptr
    dim assg as ASTNODE ptr

    function = FALSE

    s = symbLookupProcResult( proc )
    if( s = NULL ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
    end if

    assg = astNewVAR( s, NULL, 0, symbGetType( s ), symbGetSubtype( s ) )

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_SYMBTYPE_USERDEF ) then
		'' pointer? deref
		if( symbGetProcRealType( proc ) = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
			assg = astNewPTR( s, NULL, 0, assg, FB_SYMBTYPE_USERDEF, symbGetSubType( proc ) )
		end if
	end if

    assg = astNewASSIGN( assg, expr )
    if( assg = NULL ) then
    	hReportError( FB_ERRMSG_INVALIDDATATYPES )
    	exit function
    end if

    astAdd( assg )

    function = TRUE

end function

'':::::
function cProcCall( byval sym as FBSYMBOL ptr, _
					byref procexpr as ASTNODE ptr, _
					byval ptrexpr as ASTNODE ptr, _
					byval checkprnts as integer = FALSE ) as integer
	dim as integer typ, isfuncptr, doflush
	dim as FBSYMBOL ptr subtype, elm, reslabel

	function = FALSE

	if( checkprnts = TRUE ) then
		'' if the sub has no args, prnts are optional
		if( symbGetProcArgs( sym ) = 0 ) then
			checkprnts = FALSE
		end if

	'' if it's a function pointer, prnts are obligatory
	elseif( ptrexpr <> NULL ) then
		checkprnts = TRUE

	end if

	if( checkprnts ) then
		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

	end if

	env.prntcnt = 0
	env.prntopt	= not checkprnts

	'' ProcParamList
	procexpr = cProcParamList( sym, ptrexpr, FALSE, FALSE )
	if( procexpr = NULL ) then
		exit function
	end if

	'' ')'
	if( (checkprnts) or (env.prntcnt > 0) ) then

		'' --parent cnt
		env.prntcnt -= 1

		if( (not hMatch( CHAR_RPRNT )) or (env.prntcnt > 0) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

	end if

	env.prntopt	= FALSE

	typ = symbGetType( sym )

	'' if function returns a pointer, check for field deref
	doflush = TRUE
	if( typ >= FB_SYMBTYPE_POINTER ) then
		elm = NULL
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		if( not cFuncPtrOrDerefFields( sym, elm, typ, subtype, _
									   procexpr, isfuncptr, TRUE ) ) then
			'' error?
			if( hGetLastError <> FB_ERRMSG_OK ) then
				exit function
			end if

		'' type changed
		else
			doflush = FALSE
			typ = astGetDataType( procexpr )

			'' if it stills a function, unless type = string (ie: implicit pointer),
			'' flush it, as the assignament would be invalid
			if( astIsFUNCT( procexpr ) ) then
				if( typ <> IR_DATATYPE_STRING ) then
					doflush = TRUE
				end if
			end if

		end if

	end if

	''
	if( doflush ) then
		'' can proc's result be skipped?
		if( typ <> FB_SYMBTYPE_VOID ) then
			if( irGetDataClass( typ ) <> IR_DATACLASS_INTEGER ) then
				hReportError( FB_ERRMSG_VARIABLEREQUIRED )
				exit function
			end if
		end if

		'' check error?
		if( sym <> NULL ) then
			if( symbGetProcErrorCheck( sym ) ) then
    			if( env.clopt.resumeerr ) then
					reslabel = symbAddLabel( NULL )
    				astAdd( astNewLABEL( reslabel ) )
    			else
    				reslabel = NULL
    			end if

				function = rtlErrorCheck( procexpr, reslabel, lexLineNum( ) )
				procexpr = NULL
				exit function
			end if
		end if

		astSetDataType( procexpr, IR_DATATYPE_VOID )
		astAdd( procexpr )
		procexpr = NULL
	end if

	function = TRUE

end function

'':::::
private function hAssign( byval assgexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as integer op, dtype

	function = FALSE

	'' BOP?
    op = INVALID
    if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    	if( lexGetClass( ) = FB_TKCLASS_OPERATOR ) then

        	select case as const lexGetToken( )
        	case FB_TK_AND
        		op = IR_OP_AND
        	case FB_TK_OR
        		op = IR_OP_OR
        	case FB_TK_XOR
        		op = IR_OP_XOR
			case FB_TK_EQV
				op = IR_OP_EQV
			case FB_TK_IMP
				op = IR_OP_IMP
        	case FB_TK_SHL
        		op = IR_OP_SHL
        	case FB_TK_SHR
        		op = IR_OP_SHR
        	case FB_TK_MOD
        		op = IR_OP_MOD
        	end select

        	if( op = INVALID ) then
        		select case as const lexGetToken( )
        		case CHAR_PLUS
        			op = IR_OP_ADD
        		case CHAR_MINUS
        			op = IR_OP_SUB
        		case CHAR_RSLASH
        			op = IR_OP_INTDIV
        		case CHAR_CARET
        			op = IR_OP_MUL
        		case CHAR_SLASH
        			op = IR_OP_DIV
        		case CHAR_CART
        			op = IR_OP_POW
        		end select
        	end if

        	if( op <> INVALID ) then
        		lexSkipToken( )
        	end if
        end if
	end if

	'' '='
    if( not hMatch( FB_TK_ASSIGN ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDEQ )
    	exit function
    end if

    '' function pointer?
    if( astGetDataType( assgexpr ) >= IR_DATATYPE_POINTER+IR_DATATYPE_FUNCTION ) then
    	env.ctxsym = astGetSymbolOrElm( assgexpr )
    end if

    '' Expression
    if( not cExpression( expr ) ) then
       	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
       	exit function
    end if

    env.ctxsym = NULL

    '' BOP?
    if( op <> INVALID ) then
    	'' pointer?
    	if( astGetDataType( assgexpr ) >= IR_DATATYPE_POINTER ) then
    		cUpdPointer( op, assgexpr, expr )
    		if( expr = NULL ) then
    			hReportError( FB_ERRMSG_TYPEMISMATCH )
    			exit function
    		end if
    	end if

    	expr = astNewBOP( op, astCloneTree( assgexpr ), expr )
    	if( expr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
	end if

    '' do assign
    assgexpr = astNewASSIGN( assgexpr, expr )

    if( assgexpr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
        exit function
	end if

    astAdd( assgexpr )

    function = TRUE

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall as integer
	dim as integer islet
	dim as ASTNODE ptr assgexpr

	function = FALSE

	if( hMatch( FB_TK_LET ) ) then
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	if( cVarOrDeref( assgexpr ) ) then

    	'' calling a SUB ptr?
    	if( assgexpr = NULL ) then
    		return TRUE
    	end if

    	'' calling a FUNCTION ptr?
    	if( astIsFUNCT( assgexpr ) ) then
			'' can the result be skipped?
			if( irGetDataClass( astGetDataType( assgexpr ) ) <> IR_DATACLASS_INTEGER ) then
				hReportError( FB_ERRMSG_VARIABLEREQUIRED )
				exit function
			end if

    		'' flush the call
    		astAdd( assgexpr )
    		function = TRUE

    	'' ordinary assignment..
    	else

    		function = hAssign( assgexpr )

    	end if


	else
		if( islet ) then
        	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
        	exit function
		end if
	end if

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  (ID | FUNCTION) '=' Expression .
''
function cProcCallOrAssign as integer
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr, procexpr
	dim as integer dtype

	function = FALSE

	select case lexGetToken( )
	'' CALL?
	case FB_TK_CALL
		lexSkipToken( )

		'' ID
		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( s = NULL ) then
			hReportError( FB_ERRMSG_PROCNOTDECLARED )
			exit function
		end if

		lexSkipToken( )
		if( not cProcCall( s, procexpr, NULL, TRUE ) ) then
			exit function
		end if

		'' can't assign deref'ed functions with CALL's
		if( procexpr <> NULL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		return TRUE

	'' ID?
	case FB_TK_ID

		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( s <> NULL ) then
			lexSkipToken( )

			'' ID ProcParamList?
			if( not hMatch( FB_TK_ASSIGN ) ) then
				if( not cProcCall( s, procexpr, NULL ) ) then
					exit function
				end if

				'' assignament of a function deref?
				if( procexpr <> NULL ) then
					return hAssign( procexpr )
            	end if

            	return TRUE

			'' ID '=' Expression
			else
                '' check if name is valid (or if overloaded)
				if( not symbIsProcOverloadOf( env.currproc, s ) ) then
					hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB, TRUE )
					exit function
				end if

				if( not cExpression( expr ) ) then
					hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

        		return hAssignFunctResult( env.currproc, expr )
			end if

		end if

	'' FUNCTION?
	case FB_TK_FUNCTION
		'' '='?
		if( lexGetLookAhead(1) = FB_TK_ASSIGN ) then
			if( env.currproc = NULL ) then
				hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
				exit function
			end if

			lexSkipToken( )
			lexSkipToken( )

			'' Expression
			if( not cExpression( expr ) ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

        	return hAssignFunctResult( env.currproc, expr )
		end if
	end select

end function


'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
function cAsmCode as integer static
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMBOL ptr elm, subtype, s
	dim as string asmline
	dim as integer ofs

	function = FALSE

	asmline = ""

	do
		'' !(END|Comment|NEWLINE)
		select case lexGetToken( LEXCHECK_NOWHITESPC )
		case FB_TK_END, FB_TK_EOL, FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOF
			exit do
		end select

		text = *lexGetText( )

		if( lexGetClass( LEXCHECK_NOWHITESPC ) = FB_TKCLASS_IDENTIFIER ) then
			if( not emitIsKeyword( text ) ) then
				'' function?
				s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
				if( s <> NULL ) then
					text = symbGetName( s )
				else
					'' const?
					s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_CONST )
				    if( s <> NULL ) then
						text = symbGetConstText( s )
					else
						'' var?
						s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_VAR )
						if( s <> NULL ) then
							text = emitGetVarName( s )
						else
							'' label?
							s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
							if( s <> NULL ) then
								text = symbGetName( s )
							end if
						end if
					end if
				end if
			end if

		else
			'' FUNCTION?
			if( lexGetToken( LEXCHECK_NOWHITESPC ) = FB_TK_FUNCTION ) then
    			s = symbLookupProcResult( env.currproc )
    			if( s = NULL ) then
    				hReportError( FB_ERRMSG_SYNTAXERROR )
    				exit function
    			end if
    			text = emitGetVarName( s )
			end if
		end if

		asmline += text

		lexSkipToken( LEXCHECK_NOWHITESPC )

	loop

	''
	if( len( asmline ) > 0 ) then
		astAdd( astNewLIT( asmline, TRUE ) )
	end if

	function = TRUE

end function

'':::::
''AsmBlock        =   ASM Comment? SttSeparator
''                        (AsmCode Comment? NewLine)+
''					  END ASM .
function cAsmBlock as integer
    dim as integer issingleline

	function = FALSE

	'' ASM
	if( not hMatch( FB_TK_ASM ) ) then
		exit function
	end if

	'' (Comment SttSeparator)?
	issingleline = FALSE
	if( cComment( ) ) then
		if( not cStmtSeparator( ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEOL
    		exit function
		end if
	else
		if( not cStmtSeparator( ) ) then
			issingleline = TRUE
        end if
	end if

	'' (AsmCode Comment? NewLine)+
	do
		cAsmCode( )

		'' Comment?
		cComment( LEXCHECK_NOWHITESPC )

		'' NewLine
		select case lexGetToken( )
		case FB_TK_EOL
			if( issingleline ) then
				exit do
			end if

			lexSkipToken( )

		case FB_TK_END
			exit do

		case else
    		hReportError( FB_ERRMSG_EXPECTEDEOL )
    		exit function
		end select
	loop

	if( not issingleline ) then
		'' END ASM
		if( not hMatch( FB_TK_END ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDENDASM )
    		exit function
		elseif( not hMatch( FB_TK_ASM ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDENDASM )
    		exit function
		end if
	end if


	function = TRUE

end function

