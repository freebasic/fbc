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
			if( not cProcCallOrAssign ) then
				if( not cCompoundStmt ) then
					if( not cProcStatement ) then
						if( not cQuirkStmt ) then
							if( not cAsmBlock ) then
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
				if( not cProcCallOrAssign ) then
					if( not cCompoundStmt ) then
						if( not cQuirkStmt ) then
							if( not cAsmBlock ) then
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
function cConstAssign
    dim id as string, valtext as string
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer
    dim value as double, c as integer, dtype as integer
    dim expr as integer
    dim sym as FBSYMBOL ptr

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

		if( not cSymbolType( typ, subtype, lgt ) ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
			exit function
		end if

		select case typ
		case FB.SYMBTYPE.VOID, FB.SYMBTYPE.FIXSTR
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
		if( astGetClass( expr ) = AST.NODECLASS.VAR ) then
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

		if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
			hReportErrorEx FB.ERRMSG.EXPECTEDCONST, id
			exit function
		end if

		dtype = astGetDataType( expr )
		if( (dtype <> IR.DATATYPE.LONGINT) and (dtype <> IR.DATATYPE.ULONGINT) ) then
			'' QB quirks..
			value = astGetValue( expr )

			if( value - int( value ) <> 0 ) then
				if( typ = INVALID ) then
					typ = FB.SYMBTYPE.DOUBLE
				else
					if( typ = FB.SYMBTYPE.INTEGER ) then
						value = int( value )
					end if
				end if
			else
				if( typ = INVALID ) then
					typ = hGetDefType( id )
				end if
			end if

			valtext = str$( value )

		'' longints..
		else
			valtext = str$( astGetValue64( expr ) )
			if( typ = INVALID ) then
				typ = dtype
			end if
        end if

		astDel expr

		if( symbAddConst( id, typ, valtext, 0 ) = NULL ) then
    		hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
    		exit function
		end if

    end if

	cConstAssign = TRUE

end function

'':::::
''ElementDecl     =   ID ArrayDecl? AS SymbolType
''
function cElementDecl( id as string, typ as integer, subtype as FBSYMBOL ptr, lgt as integer, _
					   dimensions as integer, dTB() as FBARRAYDIM )
	dim res as integer

	cElementDecl = FALSE

	'' allow keywords as field names
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	end if
    end if

	'' ID
	typ = lexTokenType
	subtype = NULL
	id = lexEatToken

	'' ArrayDecl?
	res = cStaticArrayDecl( dimensions, dTB() )

    '' AS SumbolType
    if( not hMatch( FB.TK.AS ) or (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.SYNTAXERROR
    	exit function
    end if

    if( not cSymbolType( typ, subtype, lgt ) ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    	exit function
    end if

	cElementDecl = TRUE

end function

'':::::
''TypeLine      =   (UNION|TYPE Comment? SttSeparator
''					 (ElementDecl? Comment? SttSeparator)+
''					END UNION|TYPE)
''              |   (ElementDecl? Comment? SttSeparator)+ .
''
function cTypeLine as integer
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer
    dim dimensions as integer, dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM
    dim ename as string

	cTypeLine = FALSE

	'' Comment? SttSeparator?
	do while( (cComment <> FALSE) or (cSttSeparator <> FALSE) )
	loop

	select case as const lexCurrentToken
	'' END?
	case FB.TK.END
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

	'' UNION?
	case FB.TK.UNION
		'' isn't it a field called UNION?
		select case lexLookAhead( 1 )
		case FB.TK.STATSEPCHAR, FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
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
		case FB.TK.STATSEPCHAR, FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			if( not env.typectx.isunion ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lexSkipToken

			env.typectx.innercnt += 1

		case else
			goto declfield

		end select

	case else
declfield:

		env.typectx.elements += 1

		if( cElementDecl( ename, typ, subtype, lgt, dimensions, dTB() ) ) then
			if( symbAddUDTElement( env.typectx.symbol, ename, dimensions, dTB(), _
								   typ, subtype, lgt, env.typectx.innercnt > 0 ) = NULL ) then
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

	'' (FIELD '=' Expression)?
	if( hMatch( FB.TK.FIELD ) ) then
		if( not hMatch( FB.TK.ASSIGN ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

		if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

  		align = cint( astGetValue( expr ) )
  		if( align < 0 ) then
  			align = FB.INTEGERSIZE
  		elseif( align > FB.INTEGERSIZE*4 ) then
  			align = FB.INTEGERSIZE*4
  		end if
  		astDel expr

	else
		align = FB.INTEGERSIZE
	end if

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
    static as integer expr, dtype

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
			if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		dtype = astGetDataType( expr )
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			env.enumctx.value = cint( astGetValue64( expr ) )
		else
			env.enumctx.value = cint( astGetValue( expr ) )
		end if
		astDel expr

    end if

	cEnumConstDecl = TRUE

end function

'':::::
''EnumLine      =   (EnumDecl? Comment? SttSeparator) .
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

	env.enumctx.elements = env.enumctx.elements + 1

	if( cEnumConstDecl( ename ) ) then
		if( symbAddConst( ename, FB.SYMBTYPE.INTEGER, str$( env.enumctx.value ), 0 ) = NULL ) then
			hReportErrorEx FB.ERRMSG.DUPDEFINITION, ename
			exit function
		end if
	end if

	''
	env.enumctx.value = env.enumctx.value + 1

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
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
    	exit function
	elseif( not hMatch( FB.TK.ENUM ) ) then
    	hReportError FB.ERRMSG.EXPECTEDENDTYPE
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
		if( astGetClass( exprTB(i, 0) ) <> AST.NODECLASS.CONST ) then
			exit function
		elseif( astGetClass( exprTB(i, 1) ) <> AST.NODECLASS.CONST ) then
			exit function
		end if
	next i

	hIsDynamic = FALSE

end function

''::::
sub hMakeArrayDimTB( byval dimensions as integer, exprTB() as integer, dTB() as FBARRAYDIM )
    static as integer i, expr, dtype

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)

		dtype = astGetDataType( expr )
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			dTB(i).lower = cint( astGetValue64( expr ) )
		else
			dTB(i).lower = cint( astGetValue( expr ) )
		end if

		astDel expr

		'' upper bound
		expr = exprTB(i, 1)

		dtype = astGetDataType( expr )
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			dTB(i).upper = cint( astGetValue64( expr ) )
		else
			dTB(i).upper = cint( astGetValue( expr ) )
		end if

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
    		symbSetAllocType symbol, (alloctype and not FB.ALLOCTYPE.EXTERN) or _
    								 FB.ALLOCTYPE.PUBLIC or _
    								 FB.ALLOCTYPE.SHARED
    	end if
    end if

    hDeclExternVar = symbol

end function

'':::::
''SymbolDef       =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
function cSymbolDef( byval alloctype as integer, byval dopreserve as integer = FALSE )
    dim id as string, idalias as string, symbol as FBSYMBOL ptr
    dim addsuffix as integer, atype as integer, isdynamic as integer, ismultdecl as integer
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, ofs as integer
    dim dimensions as integer, dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM
    dim exprTB(0 to FB.MAXARRAYDIMS-1, 0 to 1) as integer

    cSymbolDef = FALSE

    '' (AS SymbolType)?
    ismultdecl = FALSE
    if( lexCurrentToken = FB.TK.AS ) then
    	lexSkipToken

    	if( not cSymbolType( typ, subtype, lgt ) ) then
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

    			if( not cSymbolType( typ, subtype, lgt ) ) then
    				hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    				exit function
    			end if

    			addsuffix = FALSE

    		else

				if( typ = INVALID ) then
					typ = hGetDefType( id )
				end if
    			lgt	= symbCalcLen( typ, subtype )

    		end if
    	end if

    	''
    	if( isdynamic ) then

    		symbol = cDynArrayDef( id, idalias, typ, subtype, lgt, addsuffix, alloctype, dopreserve, dimensions, exprTB() )
    		if( symbol = NULL ) then
    			exit function
    		end if

    	else

            hMakeArrayDimTB dimensions, exprTB(), dTB()

            atype = alloctype and (not FB.ALLOCTYPE.DYNAMIC)

    		symbol = symbAddVarEx( id, idalias, typ, subtype, lgt, dimensions, dTB(), atype, addsuffix, FALSE, TRUE )
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
		if( hMatch( FB.TK.EQ ) ) then
        	if( not cSymbolInit( symbol ) ) then
        		exit function
        	end if
		end if

		'' (DECL_SEPARATOR SymbolDef)*
		if( lexCurrentToken <> FB.TK.DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken

    loop

    cSymbolDef = TRUE

end function

'':::::
function cDynArrayDef( id as string, idalias as string, byval typ as integer, _
					   byval subtype as FBSYMBOL ptr, byval lgt as integer, _
					   byval addsuffix as integer, byval alloctype as integer, byval dopreserve as integer, _
					   byval dimensions as integer, exprTB() as integer ) as FBSYMBOL ptr
    dim s as FBSYMBOL ptr
    dim res as integer
    dim atype as integer
    dim dTB(0 to FB.MAXARRAYDIMS-1) as FBARRAYDIM

    cDynArrayDef = NULL

    atype = (alloctype or FB.ALLOCTYPE.DYNAMIC) and (not FB.ALLOCTYPE.STATIC)

    ''
  	s = symbFindByNameAndSuffix( id, typ )
   	if( s = NULL ) then
   		s = symbAddVarEx( id, idalias, typ, subtype, lgt, dimensions, dTB(), atype, addsuffix, FALSE, TRUE )
   		if( s = NULL ) then
   			hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
   			exit function
   		end if
	else

		if( not symbGetIsDynamic( s ) ) then

   			s = hDeclExternVar( id, typ, subtype, atype, addsuffix )

   			if( s = NULL ) then
   				hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
				exit function
			end if

		else

			if( (symbGetAllocType( s ) and FB.ALLOCTYPE.EXTERN) > 0 ) then
				if( (atype and FB.ALLOCTYPE.EXTERN) > 0 ) then
   					hReportErrorEx FB.ERRMSG.DUPDEFINITION, id
					exit function
				end if

				symbSetAllocType s, (atype and not FB.ALLOCTYPE.EXTERN) or _
    					            FB.ALLOCTYPE.PUBLIC or _
    					            FB.ALLOCTYPE.SHARED
			end if
		end if
	end if

	alloctype = symbGetAllocType( s )

	''
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
			symbSetArrayDimensions s, dimensions
		end if

	'' or if dims = -1 (cause of "DIM|REDIM array()")
	elseif( symbGetArrayDimensions( s ) = -1 ) then
		symbSetArrayDimensions s, dimensions
	end if

    cDynArrayDef = s

end function

'':::::
function cSymbolInit( byval s as FBSYMBOL ptr ) as integer
    dim expr as integer
    dim litstr as integer, islitstring as integer
    dim dimensions as integer, subtype as FBSYMBOL ptr
    dim istatic as integer
    dim cnt as integer

	cSymbolInit = FALSE

	'' cannot initialize dynamic vars
	if( symbGetIsDynamic( s ) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	istatic = (symbGetAllocType( s ) and FB.ALLOCTYPE.STATIC) > 0

	'' - types are known too, must be checked
	'' - var-len strings can't be accepted on static/mod-level
	'' - fix-len strings must be padded by emit if static/mod-level
	'' - the same goes with same with user types *and* arrays!

	'' impossible to save as trees, they can get really complex with udt with udts inside,
	'' just emit the current vars on a .data seg and restore the .code seg, as DATA does,
	'' emit must be aware that the var was already initialized..

	'' '{'
	if( not hMatch( CHAR_LBRACE ) ) then
		hReportError FB.ERRMSG.EXPECTEDLBRACKET
		exit function
	end if

	cnt = 0
	dimensions = symbGetArrayDimensions( s )
	do

		if( cnt > dimensions ) then
			hReportError FB.ERRMSG.TOOMANYEXPRESSIONS
			exit function
		end if

		islitstring = FALSE
		if( istatic or env.scope = 0 ) then
			if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
				islitstring = TRUE
				litstr = strpAdd( lexEatToken )
			end if
		end if

		if( not islitstring ) then
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if

		'' if static or at module level, only constants can be used as initializers
		if( istatic or env.scope = 0 ) then

			if( not islitstring ) then
				if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if

				'symbVarAddInitScalar s, astGetValue( expr )
				astDel expr

			else

				'symbVarAddInitString s, litstr

			end if

		else

			'symbVarAddInitExpression s, expr

		end if

		cnt = cnt + 1

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	'' '}'
	if( not hMatch( CHAR_RBRACE ) ) then
		hReportError FB.ERRMSG.EXPECTEDRBRACKET
		exit function
	end if


end function

'':::::
''ArrayDecl       =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cStaticArrayDecl( dimensions as integer, dTB() as FBARRAYDIM )
    static as integer i, expr, dtype

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
			if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if
		end if

		dtype = astGetDataType( expr )
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			dTB(i).lower = cint( astGetValue64( expr ) )
		else
			dTB(i).lower = cint( astGetValue( expr ) )
		end if
		astDel expr

        '' TO
    	if( lexCurrentToken = FB.TK.TO ) then
    		lexSkipToken

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			else
				if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if
			end if

			dtype = astGetDataType( expr )
			if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
				dTB(i).upper = cint( astGetValue64( expr ) )
			else
				dTB(i).upper = cint( astGetValue( expr ) )
			end if
			astDel expr

    	else
    	    dTB(i).upper = dTB(i).lower
    		dTB(i).lower = env.optbase
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
function cArrayDecl( dimensions as integer, exprTB() as integer )
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
    		exprTB(i,0) = astNewCONST( env.optbase, IR.DATATYPE.INTEGER )
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
    dim as integer expr, dtype

    cConstExprValue = FALSE

    if( not cExpression( expr ) ) then
    	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    	exit function
    end if

	if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
		hReportError FB.ERRMSG.EXPECTEDCONST
		exit function
	end if

	dtype = astGetDataType( expr )
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		littext = str$( cint( astGetValue64( expr ) ) )
	else
		littext = str$( cint( astGetValue( expr ) ) )
  	end if

  	astDel expr

  	cConstExprValue = TRUE

end function

'':::::
function hMangleFuncPtrName( sname as string, byval typ as integer, byval subtype as FBSYMBOL ptr, _
					    	 byval mode as integer, _
						  	 byval argc as integer, argv() as FBPROCARG ) as string static
    dim i as integer
    dim mname as string
    dim aname as string

    mname = sname

    for i = 0 to argc-1
    	mname += "_"

    	if( argv(i).subtype = NULL ) then
    		aname = hex$( argv(i).typ * argv(i).mode )
    	else
    		aname = hex$( argv(i).subtype )
    	end if

    	mname += aname
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
	dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, mode as integer
	dim argc as integer, argv(0 to FB_MAXPROCARGS-1) as FBPROCARG
	dim sname as string, s as FBSYMBOL ptr

	cSymbolTypeFuncPtr = NULL

	'' mode
	mode = cFunctionMode

	'' ('(' Argument? ')')
	if( hMatch( CHAR_LPRNT ) ) then
		cArguments( mode, argc, argv(), TRUE )

    	if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

	else
		argc = 0
	end if

	'' (AS SymbolType)?
	if( hMatch( FB.TK.AS ) ) then
		if( not cSymbolType( typ, subtype, lgt ) ) then
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
	end if

	sname = hMangleFuncPtrName( "_fbfp_", typ, subtype, mode, argc, argv() )

	s = symbFindByNameAndClass( sname, FB.SYMBCLASS.PROC, TRUE )
	if( s = NULL ) then
		s = symbAddPrototype( sname, "", "", typ, subtype, 0, mode, argc, argv(), TRUE, TRUE )
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
function cSymbolType( typ as integer, subtype as FBSYMBOL ptr, lgt as integer )
    dim isunsigned as integer, isfunction as integer
    dim res as integer, s as FBSYMBOL ptr
    dim littext as string
    dim ptrcnt as integer

	res = FALSE

	lgt = 0
	typ = INVALID
	subtype = NULL

	'' UNSIGNED?
	isunsigned = hMatch( FB.TK.UNSIGNED )

	''
	select case as const lexCurrentToken
	case FB.TK.ANY
		typ = FB.SYMBTYPE.VOID
		lgt = 0
		lexSkipToken

	case FB.TK.BYTE
		typ = FB.SYMBTYPE.BYTE
		lgt = 1
		lexSkipToken
	case FB.TK.UBYTE
		typ = FB.SYMBTYPE.UBYTE
		lgt = 1
		lexSkipToken

	case FB.TK.SHORT
		typ = FB.SYMBTYPE.SHORT
		lgt = 2
		lexSkipToken
	case FB.TK.USHORT
		typ = FB.SYMBTYPE.USHORT
		lgt = 2
		lexSkipToken

	case FB.TK.INTEGER, FB.TK.LONG
		typ = FB.SYMBTYPE.INTEGER
		lgt = FB.INTEGERSIZE
		lexSkipToken
	case FB.TK.UINT
		typ = FB.SYMBTYPE.UINT
		lgt = FB.INTEGERSIZE
		lexSkipToken

	case FB.TK.LONGINT
		typ = FB.SYMBTYPE.LONGINT
		lgt = FB.INTEGERSIZE*2
		lexSkipToken
	case FB.TK.ULONGINT
		typ = FB.SYMBTYPE.ULONGINT
		lgt = FB.INTEGERSIZE*2
		lexSkipToken

	case FB.TK.SINGLE
		typ = FB.SYMBTYPE.SINGLE
		lgt = 4
		lexSkipToken

	case FB.TK.DOUBLE
		typ = FB.SYMBTYPE.DOUBLE
		lgt = 8
		lexSkipToken

	case FB.TK.STRING
		if( lexLookAhead(1) = CHAR_STAR ) then
			lexSkipToken
			lexSkipToken
			typ = FB.SYMBTYPE.FIXSTR
			if( not cConstExprValue( littext ) ) then
				exit function
			end if
			lgt = val( littext ) + 1
			if( lgt = 1 ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		else
			typ = FB.SYMBTYPE.STRING
			lgt = FB.STRSTRUCTSIZE
			lexSkipToken
		end if

	case FB.TK.FUNCTION, FB.TK.SUB
	    isfunction = (lexCurrentToken = FB.TK.FUNCTION)
	    lexSkipToken

		typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION
		lgt = FB.POINTERSIZE

		subtype = cSymbolTypeFuncPtr( isfunction )
		if( subtype = NULL ) then
			exit function
		end if

	case else
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.UDT )
		if( s <> NULL ) then
			typ 	= FB.SYMBTYPE.USERDEF
			subtype = s
			lgt 	= s->lgt
			lexSkipToken
		else
			s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.ENUM )
			if( s <> NULL ) then
				typ = FB.SYMBTYPE.UINT
				lgt = FB.INTEGERSIZE
				lexSkipToken
			end if
		end if
	end select

	''
	if( typ <> INVALID ) then

		res = TRUE

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
		ptrcnt = 0
		do
			select case lexCurrentToken
			case FB.TK.PTR, FB.TK.POINTER
				lexSkipToken
				typ = FB.SYMBTYPE.POINTER + typ
				ptrcnt = ptrcnt + 1
			case else
				exit do
			end select
		loop

        if( ptrcnt > 0 ) then
			'' can't be a fixed-len string
			if( typ = FB.SYMBTYPE.FIXSTR ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if

			lgt = FB.POINTERSIZE
		end if

	else
		if( isunsigned ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
	end if

	cSymbolType = res

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
    dim id as string, typ as integer, subtype as FBSYMBOL ptr, mode as integer, lgt as integer
    dim libname as string, aliasname as string
    dim f as FBSYMBOL ptr, argc as integer, argv(0 to FB_MAXPROCARGS-1) as FBPROCARG

	cSubOrFuncDecl = FALSE

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	typ = lexTokenType
	id = lexEatToken
	subtype = NULL

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
		cArguments( mode, argc, argv(), TRUE )
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB.SYMBTYPE.USERDEF
    		hReportError FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
    		exit function
    	case FB.SYMBTYPE.FIXSTR
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
    f = symbAddPrototype( id, aliasname, libname, typ, subtype, 0, mode, argc, argv(), FALSE )
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
					 argc as integer, argv() as FBPROCARG, byval isproto as integer )

	argc = 0
	do
		if( not cArgDecl( procmode, argc, argv(argc), isproto ) ) then
			cArguments = FALSE
			exit function
		end if

		argc += 1

		'' vararg?
		if( argv(argc-1).mode = FB.ARGMODE.VARARG ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	cArguments = TRUE

end function

'':::::
private sub hReportParamError( byval argnum as integer, id as string )

	hReportErrorEx FB.ERRMSG.ILLEGALPARAMSPECAT, "at parameter " + str$( argnum+1 ) + ": " + id

end sub

'':::::
''ArgDecl         =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" NUM_LIT)? .
''
function cArgDecl( byval procmode as integer, byval argc as integer, arg as FBPROCARG, _
				   byval isproto as integer ) as integer
	dim id as string, mode as integer
	dim expr as integer, dclass as integer, dtype as integer
	dim readid as integer

	cArgDecl = FALSE

	'' "..."?
	if( lexCurrentToken = FB.TK.VARARG ) then
		'' not cdecl or is it the first arg?
		if( (procmode <> FB.FUNCMODE.CDECL) or (argc = 0) ) then
			hReportParamError argc, lexTokenText
			exit function
		end if

		lexSkipToken

		arg.nameidx = INVALID
		arg.typ		= INVALID
		arg.subtype	= NULL
		arg.mode	= FB.ARGMODE.VARARG
		arg.suffix 	= INVALID
    	arg.lgt 	= 0
    	arg.optional= FALSE

		cArgDecl = TRUE
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
		arg.typ = lexTokenType
		id = lexEatToken

		'' don't save arg's name if it's just a prototype
		if( not isproto ) then
			arg.nameidx = strpAdd( id )
		else
			arg.nameidx = INVALID
		end if

		'' ('('')')
		if( hMatch( CHAR_LPRNT ) ) then
			if( (mode <> INVALID) or (not hMatch( CHAR_RPRNT )) ) then
				hReportParamError argc, id
				exit function
			end if

			arg.mode = FB.ARGMODE.BYDESC

		else
			if( mode = INVALID ) then
				arg.mode = env.optargmode
			else
				arg.mode = mode
			end if
		end if

	'' no id
	else
		arg.typ = INVALID

		arg.nameidx = INVALID

		if( mode = INVALID ) then
			arg.mode = env.optargmode
		else
			arg.mode = mode
		end if
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then
    	if( arg.typ <> INVALID ) then
    		hReportParamError argc, id
    		exit function
    	end if
    	if( not cSymbolType( arg.typ, arg.subtype, arg.lgt ) ) then
    		hReportParamError argc, id
    		exit function
    	end if

    	arg.suffix = INVALID
    else
    	arg.subtype = NULL
    	arg.suffix = arg.typ
    end if

    ''
    if( arg.typ = INVALID ) then
        arg.typ = hGetDefType( id )
        arg.suffix = arg.typ
    end if

    '' check for invalid args
    select case arg.typ
    '' can't be a fixed-len string
    case FB.SYMBTYPE.FIXSTR
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
    select case arg.mode
    case FB.ARGMODE.BYREF, FB.ARGMODE.BYDESC
    	arg.lgt = FB.POINTERSIZE

    case FB.ARGMODE.BYVAL

    	'' check for invalid args
    	if( isproto ) then
    		select case arg.typ
    		case FB.SYMBTYPE.VOID
    			hReportParamError argc, id
    			exit function
    		end select
    	end if

    	select case arg.typ
    	case FB.SYMBTYPE.STRING
    		arg.lgt  = FB.POINTERSIZE
    	case else
    		arg.lgt = symbCalcLen( arg.typ, arg.subtype, TRUE )
    	end select
    end select

    '' ('=' NUM_LIT)?
    if( hMatch( FB.TK.ASSIGN ) ) then
    	dclass = irGetDataClass( arg.typ )

    	if( (dclass <> IR.DATACLASS.INTEGER) and (dclass <> IR.DATACLASS.FPOINT) ) then
 	   		hReportParamError argc, id
    		exit function
    	end if

    	if( not cExpression( expr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDCONST
    		exit function
    	end if

    	if( astGetClass( expr ) <> AST.NODECLASS.CONST ) then
			hReportError FB.ERRMSG.EXPECTEDCONST
			exit function
		end if

    	arg.optional = TRUE
    	dtype = astGetDataType( expr )
    	if( (arg.typ = IR.DATATYPE.LONGINT) or (arg.typ = IR.DATATYPE.ULONGINT) ) then
			if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
    			arg.defvalue64 = astGetValue64( expr )
    		else
    			arg.defvalue64 = clngint( astGetValue( expr ) )
    		end if
    	else
			if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
				arg.defvalue = cdbl( astGetValue64( expr ) )
			else
    			arg.defvalue = astGetValue( expr )
    		end if
    	end if
    	astDel expr

    else
    	arg.optional = FALSE
        if( (arg.typ <> IR.DATATYPE.LONGINT) and (arg.typ <> IR.DATATYPE.ULONGINT) ) then
        	arg.defvalue = 0.0
        else
        	arg.defvalue64 = 0
        end if
    end if

    cArgDecl = TRUE

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
function cProcParam( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, byval param as integer, _
					 expr as integer, pmode as integer, byval optonly as integer ) as integer
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
		typ = symbGetArgType( proc, arg )
		if( (typ = IR.DATATYPE.LONGINT) or (typ = IR.DATATYPE.ULONGINT) ) then
			expr = astNewCONST64( symbGetArgDefvalue64( proc, arg ), typ )
		else
			expr = astNewCONST( symbGetArgDefvalue( proc, arg ), typ )
		end if

	else

		'' '('')'?
		if( amode = FB.ARGMODE.BYDESC ) then
			if( lexCurrentToken = CHAR_LPRNT ) then
				if( lexLookahead(1) = CHAR_RPRNT ) then
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
function cProcParamList( byval proc as FBSYMBOL ptr, byval procexpr as integer ) as integer
    dim p as integer, params as integer
    dim res as integer, dtype as integer
    dim args as integer, arg as FBPROCARG ptr
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
			if( arg->mode <> FB.ARGMODE.VARARG ) then
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
		if( arg->mode = FB.ARGMODE.VARARG ) then
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
function hAssignFunctResult( byval proc as FBSYMBOL ptr, byval expr as integer ) as integer static
    dim s as FBSYMBOL ptr
    dim assg as integer
    dim vr as integer

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

    astFlush assg, vr

    hAssignFunctResult = TRUE

end function

'':::::
function cProcCall( byval proc as FBSYMBOL ptr, byval ptrexpr as integer, _
					byval checkparents as integer = FALSE ) as integer
	dim procexpr as integer
	dim vr as integer
	dim typ as integer, dtype as integer

	cProcCall = FALSE

	if( ptrexpr = INVALID ) then
		procexpr = astNewFUNCT( proc, IR.DATATYPE.VOID )
    else
    	procexpr = astNewFUNCTPTR( ptrexpr, proc, IR.DATATYPE.VOID )
    end if

	if( checkparents = TRUE ) then
		'' if the sub has no args, parents are optional
		if( symbGetProcArgs( proc ) = 0 ) then
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
	if( not cProcParamList( proc, procexpr ) ) then
		exit function
	end if

	'' ')'
	if( (checkparents) or (env.prntcnt > 0) ) then

		'' --parent cnt
		env.prntcnt = env.prntcnt - 1

		if( (not hMatch( CHAR_RPRNT )) or (env.prntcnt > 0) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

	end if

	env.prntopt	= FALSE

	'' can proc's result be skipped?
	typ = symbGetType( proc )
	if( typ <> FB.SYMBTYPE.VOID ) then
		if( (irGetDataClass( typ ) = IR.DATACLASS.FPOINT) or hIsString( typ ) ) then
			hReportError FB.ERRMSG.VARIABLEREQUIRED
			exit function
		end if
	end if

	''
	astFlush procexpr, vr


	cProcCall = TRUE

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  ID '=' Expression .						!!QB quirk!!
''
function cProcCallOrAssign
	dim s as FBSYMBOL ptr, expr as integer

	cProcCallOrAssign = FALSE

	select case lexCurrentToken
	'' CALL?
	case FB.TK.CALL
		lexSkipToken

		'' ID
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
		if( s <> NULL ) then
			lexSkipToken
			cProcCallOrAssign = cProcCall( s, INVALID, TRUE )
            exit function
		else
			hReportError FB.ERRMSG.PROCNOTDECLARED
			exit function
		end if

	'' ID?
	case FB.TK.ID

		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
		if( s <> NULL ) then
			lexSkipToken

			'' ID ProcParamList?
			if( not hMatch( FB.TK.ASSIGN ) ) then
				cProcCallOrAssign = cProcCall( s, INVALID )
            	exit function

			'' ID '=' Expression
			else
				if( not cExpression( expr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if

        		if( not hAssignFunctResult( s, expr ) ) then
        			exit function
        		end if

        		cProcCallOrAssign = TRUE
        		exit function
			end if

		end if

	end select

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall
	dim islet as integer
	dim assgexpr as integer, expr as integer, dtype as integer
	dim vr as integer
	dim op as integer

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
    	if( astGetClass( assgexpr ) = AST.NODECLASS.FUNCT ) then
			'' can the result be skipped?
			dtype = astGetDataType( assgexpr )
			if( (irGetDataClass( dtype ) = IR.DATACLASS.FPOINT) or hIsString( dtype ) ) then
				hReportError FB.ERRMSG.VARIABLEREQUIRED
				exit function
			end if

    		'' flush the call
    		astFlush assgexpr, vr
    		cAssignmentOrPtrCall = TRUE
    		exit function
    	end if

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

        astFlush assgexpr, vr
        cAssignmentOrPtrCall = TRUE

	else
		if( islet ) then
        	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
        	exit function
		end if
	end if

end function

'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
function cAsmCode
	dim asmline as string, text as string
	dim ofs as integer, elm as FBSYMBOL ptr, subtype as FBSYMBOL ptr, s as FBSYMBOL ptr

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
						text = symbGetConstText( lexTokenSymbol )
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
    dim issingleline as integer

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

