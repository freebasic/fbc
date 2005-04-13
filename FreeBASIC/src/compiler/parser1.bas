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
'' a deterministic, top-down, linear directional (LL(1)), recursive (no table-driven) descent
'' parser (syntax analyser)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'

declare function cConstExprValue			( littext as string ) as integer

declare function cSymbUDTInit				( byval basesym as FBSYMBOL ptr, _
											  byval sym as FBSYMBOL ptr, _
											  ofs as integer, _
					   						  byval islocal as integer ) as integer

'':::::
function hIsSttSeparatorOrComment( byval token as integer ) as integer static

	hIsSttSeparatorOrComment = FALSE

	if( token = FB.TK.STATSEPCHAR ) then
		hIsSttSeparatorOrComment = TRUE
	elseif( token = FB.TK.COMMENTCHAR ) then
		hIsSttSeparatorOrComment = TRUE
	else
		select case as const token
		case FB.TK.EOL, FB.TK.EOF, FB.TK.REM
			hIsSttSeparatorOrComment = TRUE
		end select
	end if

end function


'':::::
''Program         =   Line* EOF .
''
function cProgram
    dim res as integer

    do
    	res = cLine
    loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

    if( res ) then
    	if( not hMatch( FB.TK.EOF ) ) then
    		'hReportError FB.ERRMSG.EXPECTEDEOF
    		res = FALSE
    	else
    		res = TRUE
    	end if
    end if

    cProgram = res

end function

'':::::
sub cDebugLineBegin

    if( env.clopt.debug and (env.reclevel = 0) ) then
    	if( env.dbglnum > 0 ) then
    		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    		irFlush
    		env.dbgpos = emitGetPos - env.dbgpos
    		if( env.dbgpos > 0 ) then
    			emitDbgLine env.dbglnum, env.dbglname
    		end if
    	end if
    	''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    	irFlush
    	env.dbgpos	 = emitGetPos
    	env.dbglnum  = lexLineNum
    	env.dbglname = hMakeTmpStr
    	emitLABEL env.dbglname
    end if

end sub

'':::::
sub cDebugLineEnd

    if( env.clopt.debug and (env.reclevel = 0) ) then
    	if( env.dbglnum > 0 ) then
    		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    		irFlush
     		env.dbgpos = emitGetPos - env.dbgpos
    		if( env.dbgpos > 0 ) then
   				emitDbgLine env.dbglnum, env.dbglname
   			end if
    		env.dbglnum = 0
    	end if
    end if

end sub

'':::::
''Line            =   Label? Statement? Comment? EOL .
''
function cLine
    dim res as integer

	cDebugLineBegin

    res = cLabel
    res = cStatement
    res = cComment

	if( hGetLastError = FB.ERRMSG.OK ) then
		if( not hMatch( FB.TK.EOL ) ) then
			if( lexCurrentToken <> FB.TK.EOF ) then
				hReportError FB.ERRMSG.EXPECTEDEOL
				res = FALSE
			else
				res = TRUE
			end if
		else
			res = TRUE
    	end if
    else
    	res = FALSE
    end if

    if( res = TRUE ) then
    	cDebugLineEnd
    end if

    cLine = res

end function

'':::::
''SimpleLine      =   Label? SimpleStatement? Comment? EOL .
''
function cSimpleLine
    dim res as integer, stmtres as integer

    cDebugLineBegin

    res = cLabel
    stmtres = cSimpleStatement

    res = cComment

	if( hGetLastError = FB.ERRMSG.OK ) then
		if( not hMatch( FB.TK.EOL ) ) then
			if( (stmtres = FALSE) and (lexCurrentToken <> FB.TK.EOF) ) then
				hReportError FB.ERRMSG.EXPECTEDEOL
				res = FALSE
			else
				if( stmtres ) then
					res = FALSE
				else
					res = TRUE
				end if
			end if
		else
			res = TRUE
    	end if
    else
    	res = FALSE
    end if

    if( res = TRUE ) then
    	cDebugLineEnd
    end if

    cSimpleLine = res

end function


'':::::
''Label           =   NUM_LIT
''                |   ID ':' .
''
function cLabel
    dim token as integer, l as FBSYMBOL ptr

    cLabel = FALSE

    token = lexCurrentToken

    l = NULL

    '' NUM_LIT
    select case lexCurrentTokenClass
    case FB.TKCLASS.NUMLITERAL
		if( lexTokenType = FB.SYMBTYPE.INTEGER ) then
			l = symbAddLabel( lexTokenText, TRUE, TRUE )
			if( l = NULL ) then
				hReportError FB.ERRMSG.DUPDEFINITION
				exit function
			else
				lexSkipToken
			end if
		end if

	'' ID
	case FB.TKCLASS.IDENTIFIER
		'' ':'
		if( lexLookAhead(1) = CHAR_COLON ) then

			'' ambiguity: it could be a proc call followed by a ':' stmt separator..
			if( symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC ) <> NULL ) then
				exit function
			end if

			l = symbAddLabel( lexTokenText, TRUE, TRUE )
			if( l = NULL ) then
				hReportError FB.ERRMSG.DUPDEFINITION
				exit function
			else
				lexSkipToken
			end if

			'' skip ':'
			lexSkipToken

		end if
    end select

    if( l <> NULL ) then

    	''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    	irEmitLABEL l, (env.scope = 0)

    	symbSetLastLabel l

    	cLabel = TRUE
    end if

end function

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''				                              |   (any_char_but_EOL*)) .
''
function cComment( byval lexflags as LEXCHECK_ENUM )

	select case lexCurrentToken( lexflags )
	case FB.TK.COMMENTCHAR, FB.TK.REM
    	lexSkipToken LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE

    	if( lexCurrentToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE ) = FB.TK.DIRECTIVECHAR ) then
    		lexSkipToken LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE
    		cComment = cDirective
    	else
    		lexSkipLine
    		cComment = TRUE
    	end if

	case else
		cComment = FALSE
	end select

end function

'':::::
''Directive       =   INCLUDE ONCE? ':' '\'' STR_LIT '\''
''				  |   INCLIB ':' '\'' STR_LIT '\''
''				  |   LIBPATH ':' '\'' STR_LIT '\''
''				  |   DYNAMIC
''				  |   STATIC .
''
function cDirective
    dim res as integer
    dim incfile as string, isonce as integer
    dim token as integer

	res = FALSE

	select case as const lexCurrentToken
	case FB.TK.DYNAMIC
		lexSkipToken
		env.optdynamic = TRUE
		res = TRUE

	case FB.TK.STATIC
		lexSkipToken
		env.optdynamic = FALSE
		res = TRUE

	case FB.TK.INCLUDE, FB.TK.INCLIB, FB.TK.LIBPATH

		token = lexCurrentToken
		lexSkipToken

		'' ONCE?
		isonce = FALSE
		if( ucase$( lexTokenText ) = "ONCE" ) then
			lexSkipToken
			isonce = TRUE
		end if

		'' ':'
		if( not hMatch( CHAR_COLON ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		incfile = ""

		'' "STR_LIT"
		if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
			incfile = hUnescapeStr( lexEatToken )

		else
			'' '\''
			if( lexCurrentToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC ) <> CHAR_APOST ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			else
				lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC )
			end if

			lexReadLine CHAR_APOST, incfile

			'' '\''
			if( not hMatch( CHAR_APOST ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		end if

		select case token
		case FB.TK.INCLUDE
			res = fbIncludeFile( incfile, isonce )
		case FB.TK.INCLIB
			if( symbAddLib( incfile ) <> NULL ) then
				res = TRUE
			else
				res = FALSE
			end if
		case FB.TK.LIBPATH
			if( not fbAddLibPath( incfile ) ) then
				res = TRUE
			else
				res = FALSE
			end if
		end select

	end select

	do until( (lexCurrentToken = FB.TK.EOL) or (lexCurrentToken = FB.TK.EOF) )
		lexSkipToken
	loop

	cDirective = res

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
	if( lexCurrentToken = FB.TK.STATSEPCHAR ) then
		lexSkipToken
	end if

	do
		if( not cDeclaration ) then
			if( not cCompoundStmt ) then
				if( not cProcStatement ) then
					if( not cQuirkStmt ) then
						if( not cAsmBlock ) then
							if( not cProcCallOrAssign ) then
								cAssignmentOrPtrCall
							end if
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexCurrentToken <> FB.TK.STATSEPCHAR ) then
			exit do
		end if
		lexSkipToken
	loop

	cStatement = (hGetLastError = FB.ERRMSG.OK)

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
	if( lexCurrentToken = FB.TK.STATSEPCHAR ) then
		lexSkipToken
	end if

	do
		if( not cConstDecl ) then
			if( not cSymbolDecl ) then
				if( not cCompoundStmt ) then
					if( not cQuirkStmt ) then
						if( not cAsmBlock ) then
							if( not cProcCallOrAssign ) then
								cAssignmentOrPtrCall
							end if
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexCurrentToken <> FB.TK.STATSEPCHAR ) then
			exit do
		end if
		lexSkipToken
	loop

	cSimpleStatement = (hGetLastError = FB.ERRMSG.OK)

end function

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cSttSeparator( byval lexflags as LEXCHECK_ENUM )
    dim token as integer

	cSttSeparator = FALSE

	do
		token = lexCurrentToken( lexflags )
		if( (token <> FB.TK.STATSEPCHAR) and (token <> FB.TK.EOL) ) then
			exit do
		end if
		lexSkipToken( lexflags )
		cSttSeparator = TRUE
	loop

end function

'':::::
''Declaration     =   ConstDecl | TypeDecl | SymbolDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration
    dim res as integer

	res = FALSE

	select case as const lexCurrentToken
	case FB.TK.CONST
		res = cConstDecl
	case FB.TK.DECLARE
		res = cProcDecl
	case FB.TK.TYPE, FB.TK.UNION
		res = cTypeDecl
	case FB.TK.ENUM
		res = cEnumDecl
	case FB.TK.DIM, FB.TK.REDIM, FB.TK.COMMON, FB.TK.EXTERN, FB.TK.STATIC
		res = cSymbolDecl
	case FB.TK.DEFBYTE, FB.TK.DEFUBYTE, FB.TK.DEFSHORT, FB.TK.DEFUSHORT, FB.TK.DEFINT, FB.TK.DEFLNG, _
		 FB.TK.DEFUINT, FB.TK.DEFSNG, FB.TK.DEFDBL, FB.TK.DEFSTR, FB.TK.DEFLNGINT, FB.TK.DEFULNGINT
		res = cDefDecl
	case FB.TK.OPTION
		res = cOptDecl
	end select

	cDeclaration = res

end function

'':::::
''ConstDecl       =   CONST ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl

    cConstDecl = FALSE

    '' CONST
    if( not hMatch( FB.TK.CONST ) ) then
    	exit function
    end if

	do
		'' ConstAssign
		if( not cConstAssign ) then
			exit function
		end if

    	'' ','
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if
	loop

	cConstDecl = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? ASSIGN ConstExpression .
''
function cConstAssign as integer static
    dim as string id, valtext
    dim as integer typ, lgt, ptrcnt, expr
    dim as FBSYMBOL ptr sym, subtype

	cConstAssign = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	'' ID
	typ = lexTokenType
	id = lexEatToken

	'' (AS SymbolType)?
	if( hMatch( FB.TK.AS ) ) then
		if( typ <> INVALID ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
			exit function
		end if

		select case typ
		case FB.SYMBTYPE.VOID, FB.SYMBTYPE.FIXSTR, FB.SYMBTYPE.CHAR
			hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
			exit function
		end select

	end if

	'' '='
	if( not hMatch( FB.TK.ASSIGN ) ) then
		hReportError FB.ERRMSG.EXPECTEDEQ
		exit function
	end if

	'' ConstExpression
	if( not cExpression( expr ) ) then
		hReportErrorEx FB.ERRMSG.EXPECTEDCONST, id
		exit function
	end if

	'' check if it's an string
	sym = NULL
	if( astGetDataType( expr ) = IR.DATATYPE.FIXSTR ) then
		if( astIsVAR( expr ) ) then
			sym = astGetSymbol( expr )
			if( not symbGetVarInitialized( sym ) ) then
				sym = NULL
			end if
		end if
	end if

	'' string?
	if( sym <> NULL ) then
		astDel expr

		lgt = symbGetLen( sym ) - 1 			'' less the null-char
		if( symbAddConst( id, FB.SYMBTYPE.STRING, symbGetVarText( sym ), lgt ) = NULL ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

		if( symbGetAccessCnt( sym ) = 0 ) then
			symbDelVar sym
		end if

	else

		if( not astIsCONST( expr ) ) then
			hReportErrorEx FB.ERRMSG.EXPECTEDCONST, id
			exit function
		end if

		typ = astGetDataType( expr )
		select case as const typ
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			valtext = str$( astGetValue64( expr ) )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			valtext = str$( astGetValuef( expr ) )
		case else
			valtext = str$( astGetValuei( expr ) )
        end select

		astDel expr

		if( symbAddConst( id, typ, valtext, 0 ) = NULL ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

    end if

	cConstAssign = TRUE

end function

'':::::
function cTypedefDecl( id as string ) as integer
    dim as integer typ, lgt, ptrcnt
    dim as FBSYMBOL ptr subtype
    dim as string tname

    cTypedefDecl = FALSE

    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then

    	if( hGetLastError <> FB.ERRMSG.OK ) then
    		exit function
    	end if
    	
    	tname = lexTokenText
    	'' pointing to itself? then it's a void..
    	if( tname = id ) then
    		typ 	= FB.SYMBTYPE.VOID
    		subtype = NULL
    		lgt 	= 0

    	'' else, create a forward reference (or lookup one)
    	else
    		typ 	= FB.SYMBTYPE.FWDREF
    		subtype = symbAddFwdRef( tname )
			lgt 	= -1
			if( subtype = NULL ) then
				subtype = symbFindByNameAndClass( tname, FB.SYMBCLASS.FWDREF )
				if( subtype = NULL ) then
					hReportError FB.ERRMSG.DUPDEFINITION
					exit function
				end if
			end if
    	end if

    	lexSkipToken
    end if

	if( ptrcnt = 0 ) then
		'' (PTR|POINTER)*
		do
			select case lexCurrentToken
			case FB.TK.PTR, FB.TK.POINTER
				lexSkipToken
				typ += FB.SYMBTYPE.POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop
	end if

    if( symbAddTypedef( id, typ, subtype, ptrcnt, lgt ) = NULL ) then
		hReportError FB.ERRMSG.DUPDEFINITION, TRUE
		exit function
    end if

	cTypedefDecl = TRUE

end function

'':::::
''ElementDecl     =   ID ArrayDecl? AS SymbolType
''
function cElementDecl( id as string, _
					   typ as integer, _
					   subtype as FBSYMBOL ptr, _
					   ptrcnt as integer, _
					   lgt as integer, _
					   bits as integer, _
					   dimensions as integer, _
					   dTB() as FBARRAYDIM )

	cElementDecl = FALSE

	'' allow keywords as field names
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if
    end if

	'' ID
	typ = lexTokenType
	subtype = NULL
	id = lexEatToken
	bits = 0

	'' ArrayDecl?
	if( not cStaticArrayDecl( dimensions, dTB() ) ) then
		'' ':' NUMLIT?
		if( lexCurrentToken = CHAR_COLON ) then
			if( lexLookAheadClass( 1 ) = FB.TKCLASS.NUMLITERAL ) then
				lexSkipToken
				bits = val( lexEatToken )
				if( bits <= 0 ) then
    				hReportError FB.ERRMSG.SYNTAXERROR, TRUE
    				exit function
    			end if
			end if
		end if
	end if

    '' AS SymbolType
    if( not hMatch( FB.TK.AS ) or (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
    end if

    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	''
	if( bits <> 0 ) then
		if( not symbCheckBitField( env.typectx.symbol, typ, lgt, bits ) ) then
    		hReportError FB.ERRMSG.INVALIDBITFIELD, TRUE
    		exit function
		end if
	end if

	cElementDecl = TRUE

end function

'':::::
''AsElementDecl     =   AS SymbolType ID (ArrayDecl | ':' NUMLIT)? (',' ID (ArrayDecl | ':' NUMLIT)?)*
''
function cAsElementDecl( ) as integer
    dim as FBSYMBOL ptr subtype
    dim as integer dimensions, typ, lgt, ptrcnt, bits
    dim as string id
    static as FBARRAYDIM dTB(0 to FB.MAXARRAYDIMS-1)

    cAsElementDecl = FALSE

    '' SymbolType
    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	do
		'' allow keywords as field names
		if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
			if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
    			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    			exit function
    		end if
    	end if

	    id = lexEatToken
	    bits = 0

		'' ArrayDecl?
		if( not cStaticArrayDecl( dimensions, dTB() ) ) then

    		if( hGetLastError <> FB.ERRMSG.OK ) then
    			exit function
    		end if

			'' ':' NUMLIT?
			if( lexCurrentToken = CHAR_COLON ) then
				if( lexLookAheadClass( 1 ) = FB.TKCLASS.NUMLITERAL ) then
					lexSkipToken
					bits = val( lexEatToken )
				end if

				if( not symbCheckBitField( env.typectx.symbol, typ, lgt, bits ) ) then
    				hReportError FB.ERRMSG.INVALIDBITFIELD, TRUE
    				exit function
				end if

			end if

		end if


		if( symbAddUDTElement( env.typectx.symbol, id, _
							   dimensions, dTB(), _
							   typ, subtype, ptrcnt, lgt, bits, _
							   env.typectx.innercnt > 0 ) = NULL ) then
				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
				exit function
		end if

		env.typectx.elements += 1

	'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	cAsElementDecl = TRUE

end function

'':::::
''TypeLine      =   ( (UNION|TYPE Comment? SttSeparator
''					   ElementDecl
''					  END UNION|TYPE)
''                  | ElementDecl
''				    | AS AsElementDecl ) .
''
function cTypeLine as integer
    dim as FBSYMBOL ptr subtype
    dim as integer dimensions, typ, lgt, ptrcnt, bits
    dim as string ename
    static as FBARRAYDIM dTB(0 to FB.MAXARRAYDIMS-1)

	cTypeLine = FALSE

	'' Comment? SttSeparator?
	do while( (cComment <> FALSE) or (cSttSeparator <> FALSE) )
	loop

	select case as const lexCurrentToken
	'' END?
	case FB.TK.END
		'' isn't it a field called "end"?
		select case lexLookAhead( 1 )
		case FB.TK.AS, CHAR_LPRNT, CHAR_COLON
			goto declfield

		case else
			if( env.typectx.innercnt = 0 ) then
				exit function
			else
				lexSkipToken
			end if

			if( env.typectx.isunion ) then
				if( not hMatch( FB.TK.TYPE ) ) then
	    			hReportError FB.ERRMSG.EXPECTEDENDTYPE
    				exit function
				end if
			else
				if( not hMatch( FB.TK.UNION ) ) then
    				hReportError FB.ERRMSG.EXPECTEDENDTYPE
    				exit function
				end if
			end if

			env.typectx.innercnt -= 1

			if( env.typectx.innercnt = 0 ) then
				symbRecalcUDTSize env.typectx.symbol
			end if
		end select

	'' UNION?
	case FB.TK.UNION
		'' isn't it a field called UNION?
		select case lexLookAhead( 1 )
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			if( env.typectx.isunion ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lexSkipToken

			env.typectx.innercnt += 1

		case else
			goto declfield

		end select

	'' TYPE?
	case FB.TK.TYPE
		'' isn't it a field called TYPE?
		select case lexLookAhead( 1 )
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			if( not env.typectx.isunion ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lexSkipToken

			env.typectx.innercnt += 1

		case else
			goto declfield

		end select

	'' AS?
	case FB.TK.AS
		'' isn't it a field called "as"?
		select case lexLookAhead( 1 )
		case FB.TK.AS, CHAR_LPRNT, CHAR_COLON
			goto declfield
		end select

		lexSkipToken

		if( not cAsElementDecl( ) ) then
			exit function
		end if

	case else
declfield:

		env.typectx.elements += 1

		if( cElementDecl( ename, typ, subtype, ptrcnt, lgt, bits, dimensions, dTB() ) ) then

			if( symbAddUDTElement( env.typectx.symbol, ename, _
								   dimensions, dTB(), _
								   typ, subtype, ptrcnt, lgt, bits, _
								   env.typectx.innercnt > 0 ) = NULL ) then
				hReportErrorEx FB.ERRMSG.DUPDEFINITION, ename
				exit function
			end if

		end if
	end select


	'' Comment? SttSeparator
	cComment

    if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

    cTypeLine = TRUE

end function

'':::::
''TypeDecl        =   (TYPE|UNION) ID (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl
    dim id as string, align as integer, expr as integer
    dim res as integer

	cTypeDecl = FALSE

	'' TYPE | UNION
	select case lexCurrentToken
	case FB.TK.TYPE
		env.typectx.isunion = FALSE
		lexSkipToken
	case FB.TK.UNION
		env.typectx.isunion = TRUE
		lexSkipToken
	case else
		exit function
	end select

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	id = lexEatToken

	''
	select case lexCurrentToken
	'' AS?
	case FB.TK.AS
		if( env.typectx.isunion ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		lexSkipToken

		cTypeDecl = cTypedefDecl( id )
		exit function

	'' (FIELD '=' Expression)?
    case FB.TK.FIELD
		lexSkipToken

		if( not hMatch( FB.TK.ASSIGN ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

		if( not astIsCONST( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

  		select case as const astGetDataType( expr )
  		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
  		    align = astGetValue64( expr )
  		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
  			align = astGetValuef( expr )
  		case else
  			align = astGetValuei( expr )
  		end select

  		if( align < 0 ) then
  			align = FB.INTEGERSIZE
  		elseif( align > FB.INTEGERSIZE*4 ) then
  			align = FB.INTEGERSIZE*4
  		end if
  		astDel expr

	case else
		align = FB.INTEGERSIZE
	end select

	env.typectx.symbol = symbAddUDT( id, env.typectx.isunion, align )
	if( env.typectx.symbol = NULL ) then
    	hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    	exit function
	end if

	'' Comment? SttSeparator
	res = cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

	'' TypeLine+
	env.typectx.elements = 0
	env.typectx.innercnt = 0
	do
		res = cTypeLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	''
	if( env.typectx.elements = 0 ) then
		hReportError FB.ERRMSG.ELEMENTNOTDEFINED
		exit function
	end if

	'' align to multiple of sizeof( int )
	symbRoundUDTSize env.typectx.symbol

	'' END
	if( not hMatch( FB.TK.END ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
	end if

	'' TYPE | UNION
	select case lexCurrentToken
	case FB.TK.TYPE, FB.TK.UNION
		lexSkipToken
	case else
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
    end select

    ''
	cTypeDecl = TRUE

end function

'':::
''EnumConstDecl     =   ID (ASSIGN ConstExpression)? .
''
function cEnumConstDecl( id as string )
    static as integer expr

	cEnumConstDecl = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		exit function
	end if

	'' ID
	id = lexEatToken

	'' ASSIGN
	if( hMatch( FB.TK.ASSIGN ) ) then

		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		else
			if( not astIsCONST( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		select case as const astGetDataType( expr )
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			env.enumctx.value = astGetValue64( expr )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			env.enumctx.value = astGetValuef( expr )
		case else
			env.enumctx.value = astGetValuei( expr )
		end select

		astDel expr

    end if

	cEnumConstDecl = TRUE

end function

'':::::
''EnumLine      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator) .
''
function cEnumLine as integer
	dim ename as string

	cEnumLine = FALSE

	'' Comment? SttSeparator?
	do while( (cComment <> FALSE) or (cSttSeparator <> FALSE) )
	loop

	if( lexCurrentToken = FB.TK.END ) then
		exit function
	end if

	do
		env.enumctx.elements += 1

		if( cEnumConstDecl( ename ) ) then
			if( symbAddConst( ename, FB.SYMBTYPE.INTEGER, str$( env.enumctx.value ), 0 ) = NULL ) then
				hReportErrorEx FB.ERRMSG.DUPDEFINITION, ename
				exit function
			end if
		end if

		''
		env.enumctx.value += 1

		'' ','?
		if( lexCurrentToken <> CHAR_COMMA ) then
			exit do
		end if
		lexSkipToken
	loop

	'' Comment? SttSeparator
	cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.EXPECTEDEOL
    	exit function
	end if

	cEnumLine = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl
    dim id as string, e as integer
    dim res as integer

	cEnumDecl = FALSE

	'' ENUM
	lexSkipToken

	'' ID?
	if( lexCurrentTokenClass = FB.TKCLASS.IDENTIFIER ) then
    	id = lexEatToken
    else
    	id = hMakeTmpStr
    end if

	e = symbAddEnum( id )
	if( e = NULL ) then
    	hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    	exit function
	end if

	'' Comment? SttSeparator
	res = cComment

	if( not cSttSeparator ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
	end if

	'' EnumLine+
	env.enumctx.elements = 0
	env.enumctx.value = 0
	do
		res = cEnumLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	''
	if( env.enumctx.elements = 0 ) then
		hReportError FB.ERRMSG.ELEMENTNOTDEFINED
		exit function
	end if

	'' END ENUM
	if( not hMatch( FB.TK.END ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDENUM
    	exit function
	elseif( not hMatch( FB.TK.ENUM ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDENUM
    	exit function
	end if

    ''
	cEnumDecl = TRUE

end function

'':::::
''SymbolDecl      =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN IMPORT? SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cSymbolDecl
	dim res as integer, alloctype as integer
	dim dopreserve as integer

	cSymbolDecl = FALSE

	select case as const lexCurrentToken
	case FB.TK.DIM, FB.TK.REDIM, FB.TK.COMMON, FB.TK.EXTERN

		alloctype = 0
		dopreserve = FALSE

		select case as const lexCurrentToken
		'' REDIM
		case FB.TK.REDIM
			lexSkipToken
			alloctype = alloctype or FB.ALLOCTYPE.DYNAMIC

			'' PRESERVE?
			if( hMatch( FB.TK.PRESERVE ) ) then
				dopreserve = TRUE
			end if

		'' COMMON
		case FB.TK.COMMON
			'' can't use COMMON inside a proc
			if( env.scope > 0 ) then
    			hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    			exit function
			end if

			lexSkipToken

			alloctype = alloctype or FB.ALLOCTYPE.COMMON or FB.ALLOCTYPE.DYNAMIC

		'' EXTERN
		case FB.TK.EXTERN
			'' can't use EXTERN inside a proc
			if( env.scope > 0 ) then
    			hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    			exit function
			end if

			lexSkipToken

			alloctype = alloctype or FB.ALLOCTYPE.EXTERN or FB.ALLOCTYPE.SHARED

		case else
			lexSkipToken
		end select

		''
		if( env.optdynamic ) then
			alloctype = alloctype or FB.ALLOCTYPE.DYNAMIC
		end if

		if( (alloctype and FB.ALLOCTYPE.EXTERN) = 0 ) then
			'' SHARED?
			if( lexCurrentToken = FB.TK.SHARED ) then
				'' can't use SHARED inside a proc
				if( env.scope > 0 ) then
    				hReportError FB.ERRMSG.ILLEGALINSIDEASUB
    				exit function
				end if

				lexSkipToken
				alloctype = alloctype or FB.ALLOCTYPE.SHARED
			end if

		else
			'' IMPORT?
			if( hMatch( FB.TK.IMPORT ) ) then
				alloctype = alloctype or FB.ALLOCTYPE.IMPORT
			end if
		end if

		''
		if( env.isprocstatic ) then
			if( (alloctype and FB.ALLOCTYPE.DYNAMIC) = 0 ) then
				alloctype = alloctype or FB.ALLOCTYPE.STATIC
			end if
		end if

		''
		cSymbolDecl = cSymbolDef( alloctype, dopreserve )

	'' STATIC
	case FB.TK.STATIC

		'' check ambiguity with STATIC SUB|FUNCTION
		select case lexLookAhead( 1 )
		case FB.TK.SUB, FB.TK.FUNCTION
			exit function
		end select

		'' can't use STATIC outside a proc
		if( env.scope = 0 ) then
   			hReportError FB.ERRMSG.ILLEGALOUTSIDEASUB
   			exit function
		end if

		lexSkipToken

		cSymbolDecl = cSymbolDef( FB.ALLOCTYPE.STATIC )

	end select

end function

'':::::
function hIsDynamic( byval dimensions as integer, exprTB() as integer ) as integer
    dim i as integer

	hIsDynamic = TRUE

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

	hIsDynamic = FALSE

end function

''::::
sub hMakeArrayDimTB( byval dimensions as integer, exprTB() as integer, dTB() as FBARRAYDIM )
    static as integer i, expr

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)

		select case as const astGetDataType( expr )
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			dTB(i).lower = astGetValue64( expr )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			dTB(i).lower = astGetValuef( expr )
		case else
			dTB(i).lower = astGetValuei( expr )
		end select

		astDel expr

		'' upper bound
		expr = exprTB(i, 1)

		select case as const astGetDataType( expr )
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			dTB(i).upper = astGetValue64( expr )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			dTB(i).upper = astGetValuef( expr )
		case else
			dTB(i).upper = astGetValuei( expr )
		end select

		astDel expr
	next i

end sub

'':::::
function hDeclExternVar( id as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
						 byval alloctype as integer, byval addsuffix as integer ) as FBSYMBOL ptr
	dim symbol as FBSYMBOL ptr

    hDeclExternVar = NULL

    '' dup extern?
    if( (alloctype and FB.ALLOCTYPE.EXTERN) > 0 ) then
    	exit function
    end if

    symbol = symbFindByNameAndSuffix( id, typ )
    if( symbol <> NULL ) then
    	if( (symbGetAllocType( symbol ) and FB.ALLOCTYPE.EXTERN) = 0 ) then
    		exit function
    	else
    		symbSetAllocType( symbol, (alloctype and not FB.ALLOCTYPE.EXTERN) or _
    								 FB.ALLOCTYPE.PUBLIC or _
    								 FB.ALLOCTYPE.SHARED )
    	end if
    end if

    hDeclExternVar = symbol

end function

'':::::
''SymbolDef       =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
function cSymbolDef( byval alloctype as integer, _
					 byval dopreserve as integer = FALSE )

    dim as string id, idalias
    dim as FBSYMBOL ptr symbol, subtype
    dim as integer addsuffix, atype, isdynamic, ismultdecl, istypeless
    dim as integer typ, lgt, ofs, ptrcnt
    dim as FBARRAYDIM dTB(0 to FB.MAXARRAYDIMS-1)
    dim as integer exprTB(0 to FB.MAXARRAYDIMS-1, 0 to 1) , dimensions

    cSymbolDef = FALSE

    '' (AS SymbolType)?
    ismultdecl = FALSE
    if( lexCurrentToken = FB.TK.AS ) then
    	lexSkipToken

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	addsuffix = FALSE

    	ismultdecl = TRUE
    end if

    do
    	'' ID
    	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	if( not ismultdecl ) then
    		typ 		= lexTokenType
    		subtype 	= NULL
    		lgt			= 0
    		addsuffix 	= TRUE
    	else
    		if( lexTokenType <> INVALID ) then
    			hReportError FB.ERRMSG.SYNTAXERROR
    			exit function
    		end if
    	end if

    	id 			= lexEatToken
    	idalias		= ""
    	istypeless	= FALSE

    	'' ('(' ArrayDecl? ')')?
		dimensions = 0
		if( hMatch( CHAR_LPRNT ) ) then

			if( lexCurrentToken = CHAR_RPRNT ) then
				'' can't predict the size needed by the descriptor on stack
				if( env.scope > 0 ) then
					hReportError FB.ERRMSG.ILLEGALINSIDEASUB, true
					exit function
				end if

				dimensions = -1 				'' fake it
    		else
    			'' only allow indexes if not COMMON
    			if( (alloctype and FB.ALLOCTYPE.COMMON) = 0 ) then
    				if( not cArrayDecl( dimensions, exprTB() ) ) then
    					exit function
    				end if
    			end if
    		end if

			'' ')'
    		if( not hMatch( CHAR_RPRNT ) ) then
    			hReportError FB.ERRMSG.EXPECTEDRPRNT
    			exit function
    		end if
    	end if

		'' ALIAS LIT_STR
		if( (alloctype and (FB.ALLOCTYPE.PUBLIC or FB.ALLOCTYPE.EXTERN)) > 0 ) then
			if( hMatch( FB.TK.ALIAS ) ) then
				if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
					hReportError FB.ERRMSG.SYNTAXERROR
					exit function
				end if
				idalias = hCreateDataAlias( lexEatToken, (alloctype and FB.ALLOCTYPE.IMPORT) > 0 )
			end if
		end if

    	'' dynamic?
    	isdynamic = FALSE
    	if( dimensions <> 0 ) then
			if( (alloctype and FB.ALLOCTYPE.DYNAMIC) > 0 ) then
				isdynamic = TRUE
			else
				if( (dimensions = -1) or hIsDynamic( dimensions, exprTB() ) ) then
    				isdynamic = TRUE
				end if
			end if
		end if

    	if( not ismultdecl ) then
    		'' (AS SymbolType)?
    		if( lexCurrentToken = FB.TK.AS ) then

    			if( typ <> INVALID ) then
    				hReportError FB.ERRMSG.SYNTAXERROR
    				exit function
    			end if

    			lexSkipToken

    			if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    				hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
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

    	''
    	if( isdynamic ) then

    		symbol = cDynArrayDef( id, idalias, typ, subtype, ptrcnt, istypeless, _
    							   lgt, addsuffix, alloctype, dopreserve, _
    							   dimensions, exprTB() )
    		if( symbol = NULL ) then
    			exit function
    		end if

    	else

            hMakeArrayDimTB( dimensions, exprTB(), dTB() )

            atype = alloctype and (not FB.ALLOCTYPE.DYNAMIC)

    		symbol = symbAddVarEx( id, idalias, typ, subtype, ptrcnt, _
    							   lgt, dimensions, dTB(), _
    							   atype, addsuffix, FALSE, TRUE )
    		if( symbol = NULL ) then

                symbol = hDeclExternVar( id, typ, subtype, atype, addsuffix )

    			if( symbol = NULL ) then
    				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    				exit function
    			end if
			end if

			'' another quirk: if array is local (ie, inside a proc) and it's not dynamic, it's
			'' descriptor won't will be filled ever, so a call to another rtl routine is needed,
			'' or that array coulnd't be passed by descriptor to other procs (allocating a static
			'' descriptor won't help, as that would break recursion)
			if( env.scope > 0 ) then
				if( dimensions > 0 ) then
					if( (alloctype and (FB.ALLOCTYPE.SHARED or FB.ALLOCTYPE.STATIC)) = 0 ) then
						if( not rtlArraySetDesc( symbol, lgt, dimensions, dTB() ) ) then
							exit function
						end if
					end if
				end if
			end if

		end if

		'' ('=' SymbolInitializer)?
		select case lexCurrentToken
		case FB.TK.DBLEQ, FB.TK.EQ
			lexSkipToken
        	if( not cSymbolInit( symbol ) ) then
        		exit function
        	end if
		end select

		'' (DECL_SEPARATOR SymbolDef)*
		if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken

    loop

    cSymbolDef = TRUE

end function

'':::::
function cDynArrayDef( id as string, _
					   idalias as string, _
					   byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, _
					   byval ptrcnt as integer, _
					   byval istypeless as integer, _
					   byval lgt as integer, _
					   byval addsuffix as integer, _
					   byval alloctype as integer, _
					   byval dopreserve as integer, _
					   byval dimensions as integer, _
					   exprTB() as integer ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as integer atype, isrealloc
    dim as FBARRAYDIM dTB(0 to FB.MAXARRAYDIMS-1)

    cDynArrayDef = NULL

    atype = (alloctype or FB.ALLOCTYPE.DYNAMIC) and (not FB.ALLOCTYPE.STATIC)

    ''
  	isrealloc = TRUE
  	s = symbFindByNameAndSuffix( id, typ )
   	if( s = NULL ) then

   		'' typeless REDIM's?
   		if( istypeless ) then
   			'' try to find a var with the same name
   			s = symbFindByNameAndClass( id, FB.SYMBCLASS.VAR )
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
   				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
   				exit function
   			end if
   		end if

   	end if

	'' check reallocation
	if( isrealloc ) then
		'' not dynamic?
		if( not symbGetIsDynamic( s ) ) then

   			'' could be an external..
   			s = hDeclExternVar( id, typ, subtype, atype, addsuffix )
   			if( s = NULL ) then
   				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
				exit function
			end if

		else

			'' external?
			if( (symbGetAllocType( s ) and FB.ALLOCTYPE.EXTERN) > 0 ) then
				if( (atype and FB.ALLOCTYPE.EXTERN) > 0 ) then
   					hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
					exit function
				end if

				symbSetAllocType( s, (atype and not FB.ALLOCTYPE.EXTERN) or _
    					             FB.ALLOCTYPE.PUBLIC or _
    					             FB.ALLOCTYPE.SHARED )
			end if
		end if
	end if

	alloctype = symbGetAllocType( s )

	'' external? don't do any checks
	if( (alloctype and FB.ALLOCTYPE.EXTERN) > 0 ) then
		cDynArrayDef = TRUE
		exit function
	end if

	'' not an argument passed by descriptor or a common array?
	if( (alloctype and (FB.ALLOCTYPE.ARGUMENTBYDESC or FB.ALLOCTYPE.COMMON)) = 0 ) then

		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

		if( symbGetArrayDimensions( s ) > 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			hReportErrorEx FB.ERRMSG.WRONGDIMENSIONS, id
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
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
	if( (alloctype and FB.ALLOCTYPE.COMMON) > 0 ) then
		if( dimensions > symbGetArrayDimensions( s ) ) then
			symbSetArrayDimensions( s, dimensions )
		end if

	'' or if dims = -1 (cause of "DIM|REDIM array()")
	elseif( symbGetArrayDimensions( s ) = -1 ) then
		symbSetArrayDimensions( s, dimensions )
	end if

    cDynArrayDef = s

end function

'':::::
function cSymbElmInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   ofs as integer, _
					   byval islocal as integer ) as integer static

	dim as integer dtype, expr, assgexpr
    dim as FBSYMBOL ptr litsym

	if( not cExpression( expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		return FALSE
	end if

    dtype = astGetDataType( expr )

	'' if static or at module level, only constants can be used as initializers
	if( not islocal ) then

		'' check if it's a literal string
		litsym = NULL
		if( dtype = IR.DATATYPE.FIXSTR ) then
			if( astIsVAR( expr ) ) then
				litsym = astGetSymbol( expr )
				if( not symbGetVarInitialized( litsym ) ) then
					litsym = NULL
				end if
			end if
		end if

		'' not a literal string?
		if( litsym = NULL ) then

			'' string?
			if( hIsString( sym->typ ) ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				return FALSE
			end if

			'' offset?
			if( astIsOFFSET( expr ) ) then

				'' different types?
				if( (irGetDataClass( sym->typ ) <> IR.DATACLASS.INTEGER) or _
					(irGetDataSize( sym->typ ) <> FB.POINTERSIZE) ) then
					hReportError FB.ERRMSG.INVALIDDATATYPES
					return FALSE
				end if

				irEmitVARINIOFS( astGetSymbol( expr ) )

			else
				'' not a constant?
				if( not astIsCONST( expr ) ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					return FALSE
				end if

				'' different types?
				if( dtype <> sym->typ ) then
					expr = astNewCONV( INVALID, sym->typ, expr )
				end if

				select case as const sym->typ
				case FB.SYMBTYPE.LONGINT, FB.SYMBTYPE.ULONGINT
					irEmitVARINI64( sym->typ, astGetValue64( expr ) )
				case FB.SYMBTYPE.SINGLE, FB.SYMBTYPE.DOUBLE
					irEmitVARINIf( sym->typ, astGetValuef( expr ) )
				case else
					irEmitVARINIi( sym->typ, astGetValuei( expr ) )
				end select

			end if

		else

			'' not a string?
			if( not hIsString( sym->typ ) ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				return FALSE
			end if

			'' can't be a variable-len string
			if( sym->typ = FB.SYMBTYPE.STRING ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				return FALSE
			end if

			'' less the null-char
			irEmitVARINISTR( sym->lgt - 1, symbGetVarText( litsym ) )

			if( symbGetAccessCnt( litsym ) = 0 ) then
				symbDelVar litsym
			end if

		end if

		astDel expr

	else

        assgexpr = astNewVAR( basesym, NULL, ofs, sym->typ, NULL )

        assgexpr = astNewASSIGN( assgexpr, expr )

        if( assgexpr = INVALID ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
            return FALSE
        end if

        astFlush( assgexpr )

	end if

	ofs += sym->lgt

	return TRUE

end function

'':::::
function cSymbArrayInit( byval basesym as FBSYMBOL ptr, _
						 byval sym as FBSYMBOL ptr, _
					     ofs as integer, _
					     byval islocal as integer, _
					     byval isarray as integer ) as integer

    dim as integer dimensions, dimcnt, elements, elmcnt
    dim as integer isopen, lgt, pad
    dim as FBVARDIM ptr d, ld

	cSymbArrayInit = FALSE

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
					hReportError FB.ERRMSG.TOOMANYEXPRESSIONS
					exit function
				end if

				ld = d
				d = d->r

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

			if( sym->typ <> FB.SYMBTYPE.USERDEF ) then
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
				hReportError FB.ERRMSG.EXPECTEDRBRACKET
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
			irEmitVARINIPAD pad
		else
			ofs += pad
		end if
	end if

	cSymbArrayInit = TRUE

end function

'':::::
function cSymbUDTInit( byval basesym as FBSYMBOL ptr, _
					   byval sym as FBSYMBOL ptr, _
					   ofs as integer, _
					   byval islocal as integer ) as integer

	dim as integer elements, elmcnt, isarray, elmofs, lgt, pad
    dim as FBSYMBOL ptr elm, lelm, udt

    cSymbUDTInit = FALSE

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	udt = sym->subtype
	elm = udt->udt.head
	lelm = NULL

	elements = udt->udt.elements
	elmcnt = 0

	lgt = 0

	'' for each UDT element..
	do

		elmcnt += 1
		if( elmcnt > elements ) then
			hReportError FB.ERRMSG.TOOMANYEXPRESSIONS
			exit function
		end if

		'' '{'?
		isarray = hMatch( CHAR_LBRACE )

		elmofs = elm->var.elm.ofs
		if( not islocal ) then
			if( lelm <> NULL ) then
				pad = (elmofs - lelm->var.elm.ofs) - lelm->lgt
				if( pad > 0 ) then
					irEmitVARINIPAD pad
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
				hReportError FB.ERRMSG.EXPECTEDRBRACKET
				exit function
			end if
		end if

		lgt += elm->lgt

		'' next
		lelm = elm
		elm = elm->var.elm.r

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	ofs += sym->lgt

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	'' pad
	if( not islocal ) then
		pad = sym->lgt - lgt
		if( pad > 0 ) then
			irEmitVARINIPAD pad
		end if
	end if

	cSymbUDTInit = TRUE

end function

'':::::
function cSymbolInit( byval sym as FBSYMBOL ptr ) as integer
    dim as integer islocal, isarray, ofs

	cSymbolInit = FALSE

	'' cannot initialize dynamic vars
	if( symbGetIsDynamic( sym ) ) then
		hReportError FB.ERRMSG.CANTINITDYNAMICARRAYS, TRUE
		exit function
	end if

	'' common?? impossible but..
	if( (sym->alloctype and FB.ALLOCTYPE.COMMON) > 0 ) then
		hReportError FB.ERRMSG.CANTINITDYNAMICARRAYS, TRUE
		exit function
	end if

	'' already emited?? impossible but..
	if( sym->var.emited ) then
		hReportError FB.ERRMSG.SYNTAXERROR, TRUE
		exit function
	end if

	islocal = ((sym->alloctype and FB.ALLOCTYPE.STATIC) = 0) and (env.scope > 0)

	''
	if( not islocal ) then
		irEmitVARINIBEGIN sym
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
			hReportError FB.ERRMSG.EXPECTEDRBRACKET
			exit function
		end if
	end if

	''
	if( not islocal ) then
		irEmitVARINIEND sym
	end if

	''
	sym->var.emited = TRUE

	cSymbolInit = TRUE

end function

'':::::
''ArrayDecl       =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cStaticArrayDecl( dimensions as integer, _
						   dTB() as FBARRAYDIM )

    static as integer i, expr

    cStaticArrayDecl = FALSE

    dimensions = 0

    '' IDX_OPEN
    if( not hMatch( CHAR_LPRNT ) ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		else
			if( not astIsCONST( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		select case as const astGetDataType( expr )
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			dTB(i).lower = astGetValue64( expr )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			dTB(i).lower = astGetValuef( expr )
		case else
			dTB(i).lower = astGetValuei( expr )
		end select

		astDel expr

        '' TO
    	if( lexCurrentToken = FB.TK.TO ) then
    		lexSkipToken

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			else
				if( not astIsCONST( expr ) ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if
			end if

			select case as const astGetDataType( expr )
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
				dTB(i).upper = astGetValue64( expr )
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				dTB(i).upper = astGetValuef( expr )
			case else
				dTB(i).upper = astGetValuei( expr )
			end select

			astDel expr

    	else
    	    dTB(i).upper = dTB(i).lower
    		dTB(i).lower = env.optbase
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

		if( i >= FB.MAXARRAYDIMS ) then
			hReportError FB.ERRMSG.TOOMANYDIMENSIONS
			exit function
		end if
	loop

	'' IDX_CLOSE
    if( not hMatch( CHAR_RPRNT ) ) then
    	hReportError FB.ERRMSG.EXPECTEDRPRNT
    	exit function
    end if

	cStaticArrayDecl = TRUE

end function

'':::::
''ArrayDecl    	  =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cArrayDecl( dimensions as integer, _
					 exprTB() as integer )

    dim i as integer, expr as integer

    cArrayDecl = FALSE

    dimensions = 0

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		exprTB(i,0) = expr

        '' TO
    	if( lexCurrentToken = FB.TK.TO ) then
    		lexSkipToken

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONSTi( env.optbase, IR.DATATYPE.INTEGER )
    	end if

    	dimensions = dimensions + 1
    	i = i + 1

    	'' separator
    	if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken
    	end if

		if( i >= FB.MAXARRAYDIMS ) then
			hReportError FB.ERRMSG.TOOMANYDIMENSIONS
			exit function
		end if
	loop

	cArrayDecl = TRUE

end function

''::::
function cConstExprValue( littext as string ) as integer
    dim as integer expr

    cConstExprValue = FALSE

    if( not cExpression( expr ) ) then
    	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    	exit function
    end if

	if( not astIsCONST( expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDCONST
		exit function
	end if

	select case as const astGetDataType( expr )
	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
		littext = str$( astGetValue64( expr ) )
	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
		littext = str$( cint( astGetValuef( expr ) ) )
	case else
		littext = str$( astGetValuei( expr ) )
  	end select

  	astDel expr

  	cConstExprValue = TRUE

end function

'':::::
function hMangleFuncPtrName( sname as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
					    	 byval mode as integer, _
						  	 byval argc as integer, byval argtail as FBSYMBOL ptr ) as string static
    dim i as integer
    dim mname as string
    dim aname as string

    mname = sname

    for i = 0 to argc-1
    	mname += "_"

    	if( argtail->subtype = NULL ) then
    		aname = hex$( argtail->typ * argtail->arg.mode )
    	else
    		aname = hex$( argtail->subtype )
    	end if

    	mname += aname

    	argtail = argtail->arg.l
    next i

    mname += "@"

	if( subtype = NULL ) then
		mname += hex$( typ * mode )
	else
		mname += hex$( subtype )
	end if

	hMangleFuncPtrName = mname

end function

'':::::
function cSymbolTypeFuncPtr( byval isfunction as integer ) as FBSYMBOL ptr
	dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, mode as integer, ptrcnt as integer
	dim argc as integer, argtail as FBSYMBOL ptr
	dim sname as string, s as FBSYMBOL ptr

	cSymbolTypeFuncPtr = NULL

	'' mode
	mode = cFunctionMode

	'' ('(' Argument? ')')
	if( hMatch( CHAR_LPRNT ) ) then
		argtail = cArguments( mode, argc, argtail, TRUE )

    	if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

	else
		argc = 0
		argtail = NULL
	end if

	'' (AS SymbolType)?
	if( hMatch( FB.TK.AS ) ) then
		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			exit function
		end if
	else

		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			hReportError FB.ERRMSG.EXPECTEDRESTYPE
			exit function
		end if

		subtype = NULL
		typ = FB.SYMBTYPE.VOID
		ptrcnt = 0
	end if

	sname = hMangleFuncPtrName( "_fbfp_", typ, subtype, mode, argc, argtail )

	s = symbFindByNameAndClass( sname, FB.SYMBCLASS.PROC, TRUE )
	if( s = NULL ) then
		s = symbAddPrototype( sname, "", "", typ, subtype, ptrcnt, 0, mode, argc, argtail, TRUE, TRUE )
	end if

	cSymbolTypeFuncPtr = s

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
function cSymbolType( typ as integer, _
					  subtype as FBSYMBOL ptr, _
					  lgt as integer, _
					  ptrcnt as integer )

    dim as integer isunsigned, isfunction, allowptr
    dim s as FBSYMBOL ptr
    dim text as string

	cSymbolType = FALSE

	lgt = 0
	typ = INVALID
	subtype = NULL
	ptrcnt = 0

	allowptr = TRUE

	'' UNSIGNED?
	isunsigned = hMatch( FB.TK.UNSIGNED )

	''
	select case as const lexCurrentToken
	case FB.TK.ANY
		lexSkipToken
		typ = FB.SYMBTYPE.VOID
		lgt = 0

	case FB.TK.BYTE
		lexSkipToken
		typ = FB.SYMBTYPE.BYTE
		lgt = 1
	case FB.TK.UBYTE
		lexSkipToken
		typ = FB.SYMBTYPE.UBYTE
		lgt = 1

	case FB.TK.SHORT
		lexSkipToken
		typ = FB.SYMBTYPE.SHORT
		lgt = 2
	case FB.TK.USHORT
		lexSkipToken
		typ = FB.SYMBTYPE.USHORT
		lgt = 2

	case FB.TK.INTEGER, FB.TK.LONG
		lexSkipToken
		typ = FB.SYMBTYPE.INTEGER
		lgt = FB.INTEGERSIZE
	case FB.TK.UINT
		lexSkipToken
		typ = FB.SYMBTYPE.UINT
		lgt = FB.INTEGERSIZE

	case FB.TK.LONGINT
		lexSkipToken
		typ = FB.SYMBTYPE.LONGINT
		lgt = FB.INTEGERSIZE*2
	case FB.TK.ULONGINT
		lexSkipToken
		typ = FB.SYMBTYPE.ULONGINT
		lgt = FB.INTEGERSIZE*2

	case FB.TK.SINGLE
		lexSkipToken
		typ = FB.SYMBTYPE.SINGLE
		lgt = 4

	case FB.TK.DOUBLE
		lexSkipToken
		typ = FB.SYMBTYPE.DOUBLE
		lgt = 8

	case FB.TK.STRING
		if( lexLookAhead(1) = CHAR_STAR ) then
			lexSkipToken
			lexSkipToken
			typ = FB.SYMBTYPE.FIXSTR
			if( not cConstExprValue( text ) ) then
				exit function
			end if
			lgt = val( text ) + 1
			'' min 1 char + null-term
			if( lgt <= 1 ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
			allowptr = FALSE
		else
			typ = FB.SYMBTYPE.STRING
			lgt = FB.STRSTRUCTSIZE
			lexSkipToken
		end if

	case FB.TK.ZSTRING
		lexSkipToken
		if( lexCurrentToken = CHAR_STAR ) then
			lexSkipToken
			if( not cConstExprValue( text ) ) then
				exit function
			end if
			typ = FB.SYMBTYPE.CHAR
			lgt = val( text )
			'' min 1 char
			if( lgt < 1 ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
			allowptr = FALSE

		else
    		typ = FB.SYMBTYPE.CHAR
    		lgt = 0
		end if

	case FB.TK.FUNCTION, FB.TK.SUB
	    isfunction = (lexCurrentToken = FB.TK.FUNCTION)
	    lexSkipToken

		typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION
		lgt = FB.POINTERSIZE
		ptrcnt = 1

		subtype = cSymbolTypeFuncPtr( isfunction )
		if( subtype = NULL ) then
			exit function
		end if

	case else
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.UDT )
		if( s <> NULL ) then
			lexSkipToken
			typ 	= FB.SYMBTYPE.USERDEF
			subtype = s
			lgt 	= s->lgt
		else
			s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.ENUM )
			if( s <> NULL ) then
				lexSkipToken
				typ = FB.SYMBTYPE.UINT
				lgt = FB.INTEGERSIZE
			else
				s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.TYPEDEF )
				if( s <> NULL ) then
					lexSkipToken
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
			case FB.SYMBTYPE.BYTE
				typ = FB.SYMBTYPE.UBYTE
			case FB.SYMBTYPE.SHORT
				typ = FB.SYMBTYPE.USHORT
			case FB.SYMBTYPE.INTEGER
				typ = FB.SYMBTYPE.UINT
			case FB.SYMBTYPE.LONGINT
				typ = FB.SYMBTYPE.ULONGINT
			case else
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end select
		end if

		'' (PTR|POINTER)*
		do
			select case lexCurrentToken
			case FB.TK.PTR, FB.TK.POINTER
				lexSkipToken
				typ += FB.SYMBTYPE.POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop

        if( ptrcnt > 0 ) then
			if( not allowptr ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lgt = FB.POINTERSIZE

		else
			'' can't have forward typedef's if they aren't pointers
			if( typ = FB.SYMBTYPE.FWDREF ) then
				hReportError FB.ERRMSG.INCOMPLETETYPE
				exit function
			elseif( lgt <= 0 ) then
				if( typ = FB.SYMBTYPE.CHAR ) then
					hReportError FB.ERRMSG.EXPECTEDPOINTER
					exit function
				end if
			end if
		end if

		cSymbolType = TRUE

	else
		if( isunsigned ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
	end if

end function

'':::::
''ProcDecl        =   DECLARE (SUB SubDecl) |
''                            (FUNCTION FuncDecl) .
''
function cProcDecl

    cProcDecl = FALSE

    '' DECLARE
    lexSkipToken

	select case lexCurrentToken
	case FB.TK.SUB
		lexSkipToken
		cProcDecl = cSubOrFuncDecl( TRUE )

	case FB.TK.FUNCTION
		lexSkipToken
		cProcDecl = cSubOrFuncDecl( FALSE )

	case else
		hReportError FB.ERRMSG.SYNTAXERROR
	end select

end function

'':::::
function cFunctionMode as integer

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexCurrentToken
	case FB.TK.CDECL
		cFunctionMode = FB.FUNCMODE.CDECL
		lexSkipToken
	case FB.TK.STDCALL
		cFunctionMode = FB.FUNCMODE.STDCALL
		lexSkipToken
	case FB.TK.PASCAL
		cFunctionMode = FB.FUNCMODE.PASCAL
		lexSkipToken
	case else
		cFunctionMode = FB.DEFAULT.FUNCMODE
	end select

end function


'':::::
''SubOrFuncDecl      =  ID (CDECL|STDCALL|PASCAL)? (ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')?
''					 |	ID (CDECL|STDCALL|PASCAL)? (ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')? (AS SymbolType)? .
''
function cSubOrFuncDecl( byval isSub as integer ) static
    dim res as integer
    dim id as string
    dim typ as integer, subtype as FBSYMBOL ptr, mode as integer, lgt as integer, ptrcnt as integer
    dim libname as string, aliasname as string
    dim f as FBSYMBOL ptr, argc as integer, argtail as FBSYMBOL ptr

	cSubOrFuncDecl = FALSE

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	typ = lexTokenType
	id = lexEatToken
	subtype = NULL
	ptrcnt = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.INVALIDCHARACTER
    	exit function
	end if

	''
	mode = cFunctionMode

	'' (LIB STR_LIT)?
	if( hMatch( FB.TK.LIB ) ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		libname = lexEatToken
	else
		libname = ""
	end if

	'' (ALIAS STR_LIT)?
	if( hMatch( FB.TK.ALIAS ) ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		aliasname = lexEatToken
	else
		aliasname = ""
	end if

	'' ('(' Arguments? ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		argtail = cArguments( mode, argc, argtail, TRUE )
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
		argtail = NULL
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB.SYMBTYPE.USERDEF
    		'hReportError FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
    		'exit function
    	case FB.SYMBTYPE.FIXSTR, FB.SYMBTYPE.CHAR
    		hReportError FB.ERRMSG.CANNOTRETURNFIXLENFROMFUNCTS
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB.SYMBTYPE.VOID
    	subtype = NULL
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    ''
    f = symbAddPrototype( id, aliasname, libname, typ, subtype, ptrcnt, 0, mode, argc, argtail, FALSE )
    if( f = NULL ) then
    	hReportError FB.ERRMSG.DUPDEFINITION
    	exit function
    end if

    cSubOrFuncDecl = TRUE

end function

'':::::
''Arguments       =   ArgDecl (',' ArgDecl)* .
''
function cArguments( byval procmode as integer, _
					 argc as integer, _
					 byval argtail as FBSYMBOL ptr, _
					 byval isproto as integer ) as FBSYMBOL ptr

	argtail = NULL
	argc = 0

	do
		argtail = cArgDecl( procmode, argc, argtail, isproto )
		if( argtail = NULL ) then
			cArguments = NULL
			exit function
		end if

		argc += 1

		'' vararg?
		if( argtail->arg.mode = FB.ARGMODE.VARARG ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	cArguments = argtail

end function

'':::::
private sub hReportParamError( byval argnum as integer, id as string )

	hReportErrorEx FB.ERRMSG.ILLEGALPARAMSPECAT, "at parameter " + str$( argnum+1 ) + ": " + id

end sub

'':::::
''ArgDecl         =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
function cArgDecl( byval procmode as integer, _
				   byval argc as integer, _
				   byval argtail as FBSYMBOL ptr, _
				   byval isproto as integer ) as FBSYMBOL ptr

	dim as string id
	dim as integer expr, dclass, dtype, readid, mode
	dim as integer atype, amode, alen, asuffix, optional, ptrcnt
	dim as FBVALUE optval
	dim as FBSYMBOL ptr subtype, sym

	cArgDecl = NULL

	'' "..."?
	if( lexCurrentToken = FB.TK.VARARG ) then
		'' not cdecl or is it the first arg?
		if( (procmode <> FB.FUNCMODE.CDECL) or (argc = 0) ) then
			hReportParamError argc, lexTokenText
			exit function
		end if

		lexSkipToken

		cArgDecl = symbAddArg( "", argtail, INVALID, NULL, 0, 0, FB.ARGMODE.VARARG, INVALID, FALSE, NULL )
		exit function
	end if

	'' (BYVAL|BYREF)?
	select case lexCurrentToken
	case FB.TK.BYVAL
		mode = FB.ARGMODE.BYVAL
		lexSkipToken
	case FB.TK.BYREF
		mode = FB.ARGMODE.BYREF
		lexSkipToken
	case else
		mode = INVALID
	end select

	'' only allow keywords as arg names on prototypes
	readid = TRUE
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		if( not isproto ) then
			'' anything but keywords will be catch by parser (could be a ')' too)
			if( lexCurrentTokenClass = FB.TKCLASS.KEYWORD ) then
				hReportParamError argc, lexTokenText
				exit function
			end if
		end if

		if(	lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
			if( argc > 0 ) then
				hReportParamError argc, lexTokenText
			end if
			exit function
		end if

		if( isproto ) then
			'' AS?
			if( lexCurrentToken = FB.TK.AS ) then
				readid = FALSE
			end if
		end if
	end if

	if( readid ) then
		'' ID
		atype = lexTokenType
		id = lexEatToken

		'' ('('')')
		if( hMatch( CHAR_LPRNT ) ) then
			if( (mode <> INVALID) or (not hMatch( CHAR_RPRNT )) ) then
				hReportParamError argc, id
				exit function
			end if

			amode = FB.ARGMODE.BYDESC

		else
			if( mode = INVALID ) then
				amode = env.optargmode
			else
				amode = mode
			end if
		end if

	'' no id
	else
		atype = INVALID

		if( mode = INVALID ) then
			amode = env.optargmode
		else
			amode = mode
		end if
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then
    	if( atype <> INVALID ) then
    		hReportParamError argc, id
    		exit function
    	end if
    	if( not cSymbolType( atype, subtype, alen, ptrcnt ) ) then
    		hReportParamError argc, id
    		exit function
    	end if

    	asuffix = INVALID

    else
    	if( not readid ) then
    		hReportParamError argc, ""
    		exit function
    	end if

    	subtype = NULL
    	asuffix = atype
    	ptrcnt = 0
    end if

    ''
    if( atype = INVALID ) then
        atype = hGetDefType( id )
        asuffix = atype
    end if

    '' check for invalid args
    select case atype
    '' can't be a fixed-len string
    case FB.SYMBTYPE.FIXSTR, FB.SYMBTYPE.CHAR
    	hReportParamError argc, id
    	exit function

	'' can't be as ANY on non-prototypes
    case FB.SYMBTYPE.VOID
    	if( not isproto ) then
    		hReportParamError argc, id
    		exit function
    	end if
    end select

    ''
    select case amode
    case FB.ARGMODE.BYREF, FB.ARGMODE.BYDESC
    	alen = FB.POINTERSIZE

    case FB.ARGMODE.BYVAL

    	'' check for invalid args
    	if( isproto ) then
    		select case atype
    		case FB.SYMBTYPE.VOID
    			hReportParamError argc, id
    			exit function
    		end select
    	end if

    	select case atype
    	case FB.SYMBTYPE.STRING
    		alen = FB.POINTERSIZE
    	case else
    		alen = symbCalcLen( atype, subtype, TRUE )
    	end select
    end select

    '' ('=' (NUM_LIT|STR_LIT))?
    if( hMatch( FB.TK.ASSIGN ) ) then

    	'' not byval or byref?
    	if( (amode <> FB.ARGMODE.BYVAL) and (amode <> FB.ARGMODE.BYREF) ) then
 	   		hReportParamError argc, id
    		exit function
    	end if

    	dclass = irGetDataClass( atype )

    	if( dclass <> IR.DATACLASS.INTEGER ) then
    		if( dclass <> IR.DATACLASS.FPOINT ) then
    			if( dclass <> IR.DATACLASS.STRING ) then
 	   				hReportParamError argc, id
    				exit function
    			end if
    		end if
    	end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDCONST
    		exit function
    	end if

    	dtype = astGetDataType( expr )
    	'' not a constant?
    	if( not astIsCONST( expr ) ) then
    		'' not a literal string?
    		if( (not astIsVAR( expr )) or (dtype <> IR.DATATYPE.FIXSTR) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if

			sym = astGetSymbol( expr )
			'' diff types or isn't it a literal string?
			if( (dclass <> IR.DATACLASS.STRING) or (not symbGetVarInitialized( sym )) ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if

		else
			'' diff types?
			if( dclass = IR.DATACLASS.STRING ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

    	optional = TRUE
    	'' string?
    	select case as const atype
    	case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR, IR.DATATYPE.CHAR
    		optval.valuestr = sym

    	case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			select case as const dtype
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
    			optval.value64 = astGetValue64( expr )
    		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
    			optval.value64 = astGetValuef( expr )
    		case else
    			optval.value64 = astGetValuei( expr )
    		end select

    	case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			select case as const dtype
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
    			optval.valuef = astGetValue64( expr )
    		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
    			optval.valuef = astGetValuef( expr )
    		case else
    			optval.valuef = astGetValuei( expr )
    		end select

    	case else
			select case as const dtype
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
    			optval.valuei = astGetValue64( expr )
    		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
    			optval.valuei = astGetValuef( expr )
    		case else
    			optval.valuei = astGetValuei( expr )
    		end select

    	end select

    	astDel expr

    else
    	optional = FALSE
    end if

    if( isproto ) then
    	id = ""
    end if

    cArgDecl = symbAddArg( id, argtail, atype, subtype, ptrcnt, alen, amode, asuffix, optional, @optval )

end function

'':::::
''DefDecl         =   (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
''
function cDefDecl
    dim res as integer, typ as integer
    dim ichar as integer, echar as integer, char as string

	res = FALSE

	typ = INVALID

	select case as const lexCurrentToken
	case FB.TK.DEFBYTE
		typ = FB.SYMBTYPE.BYTE
	case FB.TK.DEFUBYTE
		typ = FB.SYMBTYPE.UBYTE
	case FB.TK.DEFSHORT
		typ = FB.SYMBTYPE.SHORT
	case FB.TK.DEFUSHORT
		typ = FB.SYMBTYPE.USHORT
	case FB.TK.DEFINT, FB.TK.DEFLNG
		typ = FB.SYMBTYPE.INTEGER
	case FB.TK.DEFUINT
		typ = FB.SYMBTYPE.UINT
	case FB.TK.DEFLNGINT
		typ = FB.SYMBTYPE.LONGINT
	case FB.TK.DEFULNGINT
		typ = FB.SYMBTYPE.ULONGINT
	case FB.TK.DEFUSHORT
		typ = FB.SYMBTYPE.USHORT
	case FB.TK.DEFSNG
		typ = FB.SYMBTYPE.SINGLE
	case FB.TK.DEFDBL
		typ = FB.SYMBTYPE.DOUBLE
	case FB.TK.DEFSTR
		typ = FB.SYMBTYPE.STRING
	end select

	if( typ <> INVALID ) then
		lexSkipToken

		'' (CHAR '-' CHAR ','?)*
		do
			'' CHAR
			char = ucase$( lexTokenText )
			if( len( char ) <> 1 ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit do
			end if
			ichar = asc( char )
			lexSkipToken

			'' '-'
			if( not hMatch( CHAR_MINUS ) ) then
				hReportError FB.ERRMSG.EXPECTEDMINUS
				exit do
			end if

			'' CHAR
			char = ucase$( lexTokenText )
			if( len( char ) <> 1 ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit do
			end if
			echar = asc( char )
			lexSkipToken

			''
			hSetDefType	ichar, echar, typ

      		'' ','
      		if( lexCurrentToken <> CHAR_COMMA ) then
      			exit do
      		else
      			lexSkipToken
      		end if

		loop

		res = TRUE
	end if

	cDefDecl = res

end function

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl
	dim s as FBSYMBOL ptr

	cOptDecl = FALSE

	'' OPTION
	lexSkipToken

	select case as const lexCurrentToken
	case FB.TK.EXPLICIT
		lexSkipToken
		env.optexplicit = TRUE

	case FB.TK.BASE
		lexSkipToken
		if( lexCurrentTokenClass <> FB.TKCLASS.NUMLITERAL ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
		env.optbase = val( lexEatToken )

	case FB.TK.BYVAL
		lexSkipToken
		env.optargmode = FB.ARGMODE.BYVAL

	case FB.TK.PRIVATE
		lexSkipToken
		env.optprocpublic = FALSE

	case FB.TK.DYNAMIC
		lexSkipToken
		env.optdynamic = TRUE

	case FB.TK.STATIC
		lexSkipToken
		env.optdynamic = FALSE

	case else

		'' ESCAPE? (it's not a reserved word, there are too many already..)
		select case ucase$( lexTokenText )
		case "ESCAPE"
			lexSkipToken
			env.optescapestr = TRUE

		'' NOKEYWORD? (ditto..)
		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
				select case lexCurrentTokenClass( LEXCHECK_NODEFINE )
				case FB.TKCLASS.KEYWORD
					if( not symbDelKeyword( lexTokenSymbol ) ) then
						hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
						exit function
					end if

					lexSkipToken

				case FB.TKCLASS.IDENTIFIER
					'' proc?
					s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
					if( s <> NULL ) then

						'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
						if( symbGetProcLib( s ) <> "fb" ) then
							hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
							exit function
						end if

						symbDelPrototype s
					else

						'' macro?
						s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.DEFINE )
						if( s = NULL ) then
							hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
							exit function
						end if

						symbDelDefine s
					end if

					lexSkipToken

				case else
					hReportError FB.ERRMSG.SYNTAXERROR
					exit function
				end select

				'' ','?
				if( lexCurrentToken <> CHAR_COMMA ) then
					exit do
				else
					lexSkipToken( LEXCHECK_NODEFINE )
				end if

			loop

		case else
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end select

	end select

	cOptDecl = TRUE

end function

'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cProcParam( byval proc as FBSYMBOL ptr, _
					 byval arg as FBSYMBOL ptr, _
					 byval param as integer, _
					 expr as integer, _
					 pmode as integer, _
					 byval optonly as integer ) as integer

	dim amode as integer
	dim typ as integer

	cProcParam = FALSE

	amode = symbGetArgMode( proc, arg )

	pmode = INVALID
	expr = INVALID

	if( not optonly ) then
		'' BYVAL?
		if( hMatch( FB.TK.BYVAL ) ) then
			pmode = FB.ARGMODE.BYVAL
		end if

		'' Expression
		if( not cExpression( expr ) ) then
			'' failed and expr not null?
			if( expr <> INVALID ) then
				exit function
			end if

			'' check for BYVAL if it's the first param, due the optional ()'s
			if( (param = 0) and (pmode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB.TK.BYVAL ) ) then
					pmode = FB.ARGMODE.BYVAL
					if( not cExpression( expr ) ) then
						expr = INVALID
					end if
				end if
			end if
		end if
	end if

	if( expr = INVALID ) then

		'' check if argument is optional
		if( not symbGetArgOptional( proc, arg ) ) then
			if( amode <> FB.ARGMODE.VARARG ) then
				hReportError FB.ERRMSG.ARGCNTMISMATCH
			end if
			exit function
		end if

		'' create an arg
		typ = symbGetType( arg )
		select case as const typ
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING, IR.DATATYPE.CHAR
			expr = astNewVAR( symbGetArgOptvalStr( proc, arg ), NULL, 0, IR.DATATYPE.FIXSTR )
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			expr = astNewCONST64( symbGetArgOptval64( proc, arg ), typ )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			expr = astNewCONSTf( symbGetArgOptvalF( proc, arg ), typ )
		case else
			expr = astNewCONSTi( symbGetArgOptvalI( proc, arg ), typ )
		end select

	else

		'' '('')'?
		if( amode = FB.ARGMODE.BYDESC ) then
			if( lexCurrentToken = CHAR_LPRNT ) then
				if( lexLookahead(1) = CHAR_RPRNT ) then
					if( pmode <> INVALID ) then
						hReportError FB.ERRMSG.PARAMTYPEMISMATCH
						exit function
					end if
					lexSkipToken
					lexSkipToken
					pmode = FB.ARGMODE.BYDESC
				end if
			end if
    	end if

    end if

	''
	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            if( amode <> FB.ARGMODE.VARARG ) then
            	'' allow BYVAL params passed to BYREF/BYDESC args (to pass NULL to pointers and so on)
            	if( pmode <> FB.ARGMODE.BYVAL ) then
					if( amode <> pmode ) then
						hReportError FB.ERRMSG.PARAMTYPEMISMATCH
						exit function
					end if
				end if
			end if
		end if
	end if

	cProcParam = TRUE

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
function cProcParamList( byval proc as FBSYMBOL ptr, _
						 byval procexpr as integer ) as integer

    dim p as integer, params as integer
    dim res as integer, dtype as integer
    dim args as integer, arg as FBSYMBOL ptr
    dim elist(0 to FB_MAXPROCARGS-1) as integer, mlist(0 to FB_MAXPROCARGS-1) as integer

	args = symbGetProcArgs( proc )

	'' proc has no args?
	if( args = 0 ) then
		'' '('
		if( hMatch( CHAR_LPRNT ) ) then
			'' ')'
			if( not hMatch( CHAR_RPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDRPRNT
				exit function
			end if
		end if

		cProcParamList = TRUE
		exit function
	end if

	cProcParamList = FALSE

	params = 0
	arg = symbGetProcLastArg( proc )
	do
		if( params >= args ) then
			if( arg->arg.mode <> FB.ARGMODE.VARARG ) then
				hReportError FB.ERRMSG.ARGCNTMISMATCH
				exit function
			end if
		end if

		if( not cProcParam( proc, arg, params, elist(params), mlist(params), FALSE ) ) then
			if( hGetLastError <> FB.ERRMSG.OK ) then
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

	''
	do while( params < args )
		if( arg->arg.mode = FB.ARGMODE.VARARG ) then
			exit do
		end if

		if( not cProcParam( proc, arg, params, elist(params), mlist(params), TRUE ) ) then
			exit function
		end if

		params += 1
		arg = symbGetProcPrevArg( proc, arg )
	loop

    ''
	for p = 0 to params-1

		if( astNewPARAM( procexpr, elist(p), INVALID, mlist(p) ) = INVALID ) then
			hReportError FB.ERRMSG.PARAMTYPEMISMATCH
			exit function
		end if

	next

	cProcParamList = TRUE

end function

'':::::
function hAssignFunctResult( byval proc as FBSYMBOL ptr, _
							 byval expr as integer ) as integer static
    dim s as FBSYMBOL ptr
    dim assg as integer

    hAssignFunctResult = FALSE

    s = symbLookupProcResult( proc )
    if( s = NULL ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
    end if

    assg = astNewVAR( s, NULL, 0, symbGetType( s ), symbGetSubtype( s ) )

    assg = astNewASSIGN( assg, expr )
    if( assg = INVALID ) then
    	hReportError FB.ERRMSG.INVALIDDATATYPES
    	exit function
    end if

    astFlush( assg )

    hAssignFunctResult = TRUE

end function

'':::::
function cProcCall( byval sym as FBSYMBOL ptr, _
					procexpr as integer, _
					byval ptrexpr as integer, _
					byval checkparents as integer = FALSE ) as integer
	dim as integer typ, isfuncptr, doflush
	dim as FBSYMBOL ptr subtype, elm

	cProcCall = FALSE

	typ = symbGetType( sym )

	procexpr = astNewFUNCT( sym, typ, ptrexpr )

	if( checkparents = TRUE ) then
		'' if the sub has no args, parents are optional
		if( symbGetProcArgs( sym ) = 0 ) then
			checkparents = FALSE
		end if

	'' if it's a function pointer, parents are obrigatory
	elseif( ptrexpr <> INVALID ) then
		checkparents = TRUE

	end if

	if( checkparents ) then
		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

	end if

	env.prntcnt = 0
	env.prntopt	= not checkparents

	'' ProcParamList
	if( not cProcParamList( sym, procexpr ) ) then
		exit function
	end if

	'' ')'
	if( (checkparents) or (env.prntcnt > 0) ) then

		'' --parent cnt
		env.prntcnt -= 1

		if( (not hMatch( CHAR_RPRNT )) or (env.prntcnt > 0) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

	end if

	env.prntopt	= FALSE

	'' if function returns a pointer, check for field deref
	doflush = TRUE
	if( typ >= FB.SYMBTYPE.POINTER ) then
		elm = NULL
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		if( not cFuncPtrOrDerefFields( sym, elm, typ, subtype, procexpr, isfuncptr, TRUE ) ) then
			'' error?
			if( hGetLastError <> FB.ERRMSG.OK ) then
				exit function
			end if

		'' type changed
		else
			doflush = FALSE
			typ = astGetDataType( procexpr )

			'' if it stills a function, unless type = string (ie: implict pointer),
			'' flush it, as the assignament would be invalid
			if( astIsFUNCT( procexpr ) ) then
				if( typ <> IR.DATATYPE.STRING ) then
					doflush = TRUE
				end if
			end if

		end if

	end if

	''
	if( doflush ) then
		'' can proc's result be skipped?
		if( typ <> FB.SYMBTYPE.VOID ) then
			if( (irGetDataClass( typ ) = IR.DATACLASS.FPOINT) or _
				(typ = IR.DATATYPE.STRING) ) then
				hReportError FB.ERRMSG.VARIABLEREQUIRED
				exit function
			end if
		end if

		astSetDataType( procexpr, IR.DATATYPE.VOID )
		astFlush( procexpr )
		procexpr = INVALID
	end if

	cProcCall = TRUE

end function

'':::::
private function hAssign( byval assgexpr as integer ) as integer
	dim as integer expr, op

	hAssign = FALSE

	'' BOP?
    op = INVALID
    if( lexCurrentToken <> FB.TK.ASSIGN ) then
    	if( lexCurrentTokenClass = FB.TKCLASS.OPERATOR ) then

        	select case as const lexCurrentToken
        	case FB.TK.AND
        		op = IR.OP.AND
        	case FB.TK.OR
        		op = IR.OP.OR
        	case FB.TK.XOR
        		op = IR.OP.XOR
			case FB.TK.EQV
				op = IR.OP.EQV
			case FB.TK.IMP
				op = IR.OP.IMP
        	case FB.TK.SHL
        		op = IR.OP.SHL
        	case FB.TK.SHR
        		op = IR.OP.SHR
        	case FB.TK.MOD
        		op = IR.OP.MOD
        	end select

        	if( op = INVALID ) then
        		select case as const lexCurrentToken
        		case CHAR_PLUS
        			op = IR.OP.ADD
        		case CHAR_MINUS
        			op = IR.OP.SUB
        		case CHAR_RSLASH
        			op = IR.OP.INTDIV
        		case CHAR_CARET
        			op = IR.OP.MUL
        		case CHAR_SLASH
        			op = IR.OP.DIV
        		case CHAR_CART
        			op = IR.OP.POW
        		end select
        	end if

        	if( op <> INVALID ) then
        		lexSkipToken
        	end if
        end if
	end if

	'' '='
    if( not hMatch( FB.TK.ASSIGN ) ) then
    	hReportError FB.ERRMSG.EXPECTEDEQ
    	exit function
    end if

    '' Expression
    if( not cExpression( expr ) ) then
       	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
       	exit function
    end if

    '' BOP?
    if( op <> INVALID ) then
    	expr = astNewBOP( op, astCloneTree( assgexpr ), expr )
	end if

    '' do assign
    assgexpr = astNewASSIGN( assgexpr, expr )

    if( assgexpr = INVALID ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
        exit function
	end if

    astFlush( assgexpr )

    hAssign = TRUE

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall
	dim as integer islet, dtype
	dim as integer assgexpr

	cAssignmentOrPtrCall = FALSE

	if( hMatch( FB.TK.LET ) ) then
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	if( cVarOrDeref( assgexpr ) ) then

    	'' calling a SUB ptr?
    	if( assgexpr = INVALID ) then
    		cAssignmentOrPtrCall = TRUE
    		exit function
    	end if

    	'' calling a FUNCTION ptr?
    	if( astIsFUNCT( assgexpr ) ) then
			'' can the result be skipped?
			dtype = astGetDataType( assgexpr )
			if( (irGetDataClass( dtype ) = IR.DATACLASS.FPOINT) or _
				( dtype = IR.DATATYPE.STRING ) ) then
				hReportError FB.ERRMSG.VARIABLEREQUIRED
				exit function
			end if

    		'' flush the call
    		astFlush( assgexpr )
    		cAssignmentOrPtrCall = TRUE

    	'' ordinary assignament..
    	else

    		cAssignmentOrPtrCall = hAssign( assgexpr )

    	end if


	else
		if( islet ) then
        	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
        	exit function
		end if
	end if

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  (ID | FUNCTION) '=' Expression .
''
function cProcCallOrAssign
	dim as FBSYMBOL ptr s
	dim as integer expr, procexpr, dtype

	cProcCallOrAssign = FALSE

	select case lexCurrentToken
	'' CALL?
	case FB.TK.CALL
		lexSkipToken

		'' ID
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
		if( s = NULL ) then
			hReportError FB.ERRMSG.PROCNOTDECLARED
			exit function
		end if

		lexSkipToken
		if( not cProcCall( s, procexpr, INVALID, TRUE ) ) then
			exit function
		end if

		'' can't assign deref'ed functions with CALL's
		if( procexpr <> INVALID ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		return TRUE

	'' ID?
	case FB.TK.ID

		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
		if( s <> NULL ) then
			lexSkipToken

			'' ID ProcParamList?
			if( not hMatch( FB.TK.ASSIGN ) ) then
				if( not cProcCall( s, procexpr, INVALID ) ) then
					exit function
				end if

				'' assignament of a function deref?
				if( procexpr <> INVALID ) then
					return hAssign( procexpr )
            	end if

            	return TRUE

			'' ID '=' Expression
			else
				if( not cExpression( expr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if

        		return hAssignFunctResult( s, expr )
			end if

		end if

	'' FUNCTION?
	case FB.TK.FUNCTION
		'' '='?
		if( lexLookAhead(1) = FB.TK.ASSIGN ) then
			if( env.currproc = NULL ) then
				hReportError FB.ERRMSG.ILLEGALOUTSIDEASUB
				exit function
			end if

			lexSkipToken
			lexSkipToken

			'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

        	return hAssignFunctResult( env.currproc, expr )
		end if
	end select

end function


'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
function cAsmCode
	dim as FBSYMBOL ptr elm, subtype, s
	dim as string asmline, text
	dim as integer ofs

	cAsmCode = FALSE

	asmline = ""

	do
		'' !(END|Comment|NEWLINE)
		select case lexCurrentToken( LEXCHECK_NOWHITESPC )
		case FB.TK.END, FB.TK.EOL, FB.TK.COMMENTCHAR, FB.TK.REM, FB.TK.EOF
			exit do
		end select

		text = lexTokenText

		if( lexCurrentTokenClass( LEXCHECK_NOWHITESPC ) = FB.TKCLASS.IDENTIFIER ) then
			if( not emitIsKeyword( text ) ) then
				'' function?
				s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
				if( s <> NULL ) then
					text = symbGetName( s )
				else
					'' const?
					s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.CONST )
				    if( s <> NULL ) then
						text = symbGetConstText( s )
					else
						'' var?
						s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.VAR )
						if( s <> NULL ) then
							text = EmitGetVarName( s )
						end if
					end if
				end if
			end if
		end if

		asmline = asmline + text

		lexSkipToken LEXCHECK_NOWHITESPC

	loop

	''
	if( len( asmline ) > 0 ) then
		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
		irFlush
		emitASM asmline
	end if

	cAsmCode = TRUE

end function

'':::::
''AsmBlock        =   ASM Comment? SttSeparator
''                        (AsmCode Comment? NewLine)+
''					  END ASM .
function cAsmBlock
    dim as integer issingleline

	cAsmBlock = FALSE

	'' ASM
	if( not hMatch( FB.TK.ASM ) ) then
		exit function
	end if

	'' (Comment SttSeparator)?
	issingleline = FALSE
	if( cComment ) then
		if( not cSttSeparator ) then
    		hReportError FB.ERRMSG.EXPECTEDEOL
    		exit function
		end if
	else
		if( not cSttSeparator ) then
			issingleline = TRUE
        end if
	end if

	'' (AsmCode Comment? NewLine)+
	do
		cAsmCode

		'' Comment?
		cComment LEXCHECK_NOWHITESPC

		'' NewLine
		select case lexCurrentToken
		case FB.TK.EOL
			if( issingleline ) then
				exit do
			end if

			lexSkipToken

		case FB.TK.END
			exit do

		case else
    		hReportError FB.ERRMSG.EXPECTEDEOL
    		exit function
		end select
	loop

	if( not issingleline ) then
		'' END ASM
		if( not hMatch( FB.TK.END ) ) then
    		hReportError FB.ERRMSG.EXPECTEDENDASM
    		exit function
		elseif( not hMatch( FB.TK.ASM ) ) then
    		hReportError FB.ERRMSG.EXPECTEDENDASM
    		exit function
		end if
	end if


	cAsmBlock = TRUE

end function

