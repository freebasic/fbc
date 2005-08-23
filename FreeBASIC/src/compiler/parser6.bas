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


'' parser part 6 - QB's quirk statements (GOTO, GOSUB) and intrinsic
''                 routines (PRINT, STR$, etc)
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


'':::::
function cFuncReturn( byval checkexpr as integer = TRUE ) as integer
    dim as ASTNODE ptr expr

    function = FALSE

	if( (env.currproc = NULL) or (env.procstmt.endlabel = NULL) ) then
		hReportError FB_ERRMSG_ILLEGALOUTSIDEASUB
		exit function
	end if

	if( checkexpr ) then
		hMatchExpression( expr )

		if( not hAssignFunctResult( env.currproc, expr ) ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	astAdd( astNewBRANCH( IR_OP_JMP, env.procstmt.endlabel ) )

	function = TRUE

end function

'':::::
''GotoStmt   	  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |	  RETURN LABEL?
''				  |   RESUME NEXT? .
''
function cGotoStmt as integer
	dim as FBSYMBOL ptr l
	dim as integer isglobal, isnext

	function = FALSE

	select case as const lexGetToken( )
	'' GOTO LABEL
	case FB_TK_GOTO
		lexSkipToken( )

		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			l = symbFindByNameAndClass( *lexGetText( ), FB_SYMBCLASS_LABEL )
		else
			l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( *lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_JMP, l ) )

		function = TRUE

	'' GOSUB LABEL
	case FB_TK_GOSUB
		lexSkipToken( )

		if( lexGetClass = FB_TKCLASS_NUMLITERAL ) then
			l = symbFindByNameAndClass( *lexGetText( ), FB_SYMBCLASS_LABEL )
		else
			l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( *lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_CALL, l ) )

		function = TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB_TK_RETURN
		lexSkipToken( )

		'' Comment|StmtSep|EOF? just return
		select case lexGetToken( )
		case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM

			'' try to guess here.. if inside a proc currently and no user label was
			'' emitted, it's probably a FUNCTION return, not a GOSUB return
			l = NULL
			if( env.scope > 0 ) then
				l = symbGetLastLabel( )
				if( l <> NULL ) then
					if( l->scope <> env.scope ) then
						l = NULL
					end if
				end if
			end if

			if( (env.scope = 0) or (l <> NULL) ) then
				'' return 0
				astAdd( astNewBRANCH( IR_OP_RET, NULL ) )
			else
				function = cFuncReturn( FALSE )
			end if

		case else

			l = NULL

			'' Comment|StmtSep|EOF following? check if it's not an already defined label
			select case lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
				if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
					l = symbFindByNameAndClass( *lexGetText( ), FB_SYMBCLASS_LABEL )
				else
					l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
				end if
			end select

			'' label?
			if( l <> NULL ) then
				lexSkipToken( )
				astAdd( astNewBRANCH( IR_OP_JMP, l ) )
				function = TRUE

			'' must be a function return then
			else
				function = cFuncReturn( )
			end if

		end select


	'' RESUME NEXT?
	case FB_TK_RESUME

		if( not env.clopt.resumeerr ) then
			hReportError( FB_ERRMSG_ILLEGALRESUMEERROR )
			exit function
		end if

		lexSkipToken( )

		if( hMatch( FB_TK_NEXT ) ) then
			isnext = TRUE
		else
			isnext = FALSE
		end if

		rtlErrorResume( isnext )

		function = TRUE
	end select

end function

'':::::
''ArrayStmt   	  =   ERASE ID (',' ID)*;
''				  |   SWAP Variable, Variable .
''
function cArrayStmt as integer
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr1, expr2

	function = FALSE

	select case lexGetToken
	case FB_TK_ERASE
		lexSkipToken

		do
			if( not cVarOrDeref( expr1, FALSE ) ) then
				hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
				exit function
			end if

			'' array?
    		s = astGetSymbolOrElm( expr1 )
    		if( s = NULL ) then
    			hReportError( FB_ERRMSG_EXPECTEDARRAY )
    			exit function
    		end if

    		if( not symbIsArray( s ) ) then
				hReportError( FB_ERRMSG_EXPECTEDARRAY )
				exit function
			end if

			if( symbGetIsDynamic( s ) ) then
				if( not rtlArrayErase( expr1 ) ) then
					exit function
				end if
			else
				if( not rtlArrayClear( expr1 ) ) then
					exit function
				end if
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' SWAP Variable, Variable
	case FB_TK_SWAP
		lexSkipToken

		if( not cVarOrDeref( expr1 ) ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			exit function
		end if

		hMatchCOMMA( )

		if( not cVarOrDeref( expr2 ) ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			exit function
		end if

		select case astGetDataType( expr1 )
		case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
			function = rtlStrSwap( expr1, expr2 )
		case else
			function = rtlMemSwap( expr1, expr2 )
		end select

	end select

end function

'':::::
''MidStmt   	  =   MID '(' Expression{str}, Expression{int} (',' Expression{int}) ')' '=' Expression{str} .
''
function cMidStmt as integer
	dim as ASTNODE ptr expr1, expr2, expr3, expr4

	function = FALSE

	if( hMatch( FB_TK_MID ) ) then

		hMatchLPRNT()

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( expr3 )
		else
			expr3 = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		if( not hMatch( FB_TK_ASSIGN ) ) then
			hReportError FB_ERRMSG_EXPECTEDEQ
			exit function
		end if

		hMatchExpression( expr4 )

		function = rtlStrAssignMid( expr1, expr2, expr3, expr4 ) <> NULL
	end if

end function

'':::::
'' LsetStmt		=	LSET String|UDT (','|'=') Expression|UDT
function cLSetStmt( ) as integer
    dim as ASTNODE ptr dstexpr, srcexpr
    dim as integer dtype1, dtype2
    dim as FBSYMBOL ptr dst, src

    function = FALSE

	'' LSET
	lexSkipToken( )

	'' Expression
	if( not cVarOrDeref( dstexpr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	dtype1 = astGetDataType( dstexpr )
	select case dtype1
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR, IR_DATATYPE_USERDEF
	case else
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end select

	'' ',' or '='
	if( not hMatch( CHAR_COMMA ) ) then
        if( not hMatch( CHAR_EQ ) ) then
			hReportError FB_ERRMSG_EXPECTEDCOMMA
			exit function
        end if
	end if

	'' Expression
	hMatchExpression( srcexpr )

	dtype2 = astGetDataType( srcexpr )
	select case dtype2
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR, IR_DATATYPE_USERDEF
	case else
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end select

	if( (dtype1 = IR_DATATYPE_USERDEF) or (dtype2 = IR_DATATYPE_USERDEF) ) then

		if( dtype1 <> dtype2 ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		dst = astGetSymbolOrElm( dstexpr )
		src = astGetSymbolOrElm( srcexpr )
		if( (dst = NULL) or (src = NULL) ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

		function = rtlMemCopyClear( dstexpr, symbGetUDTLen( dst->subtype ), _
									srcexpr, symbGetUDTLen( src->subtype ) )
	else
		function = rtlStrLset( dstexpr, srcexpr )
	end if

end function

'':::::
''DataStmt   	  =   RESTORE LABEL?
''				  |   READ Variable{int|flt|str} (',' Variable{int|flt|str})*
''				  |   DATA literal|constant (',' literal|constant)*
''
function cDataStmt as integer static
	dim as ASTNODE ptr expr
	dim as integer typ, litlen
	dim as FBSYMBOL ptr s
	static as zstring * FB_MAXLITLEN+1 littext

	function = FALSE

	select case lexGetToken( )
	'' RESTORE LABEL?
	case FB_TK_RESTORE
		lexSkipToken( )

		'' LABEL?
		s = NULL
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_NUMLITERAL
			s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
			if( s = NULL ) then
				s = symbAddLabel( *lexGetText( ), FALSE, TRUE )
				if( s = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if
			end if
			lexSkipToken( )
		end select

		function = rtlDataRestore( s )

	'' READ Variable{int|flt|str} (',' Variable{int|flt|str})*
	case FB_TK_READ
		lexSkipToken( )

		do
		    if( not cVarOrDeref( expr ) ) then
		    	hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		    	exit function
		    end if

            if( not rtlDataRead( expr ) ) then
            	exit function
            end if

		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' DATA literal|constant expr (',' literal|constant expr)*
	case FB_TK_DATA

        '' it should be allowed inside procs to avoid global namespace
        '' pollution - so I simply removed the check if we're inside
        '' a proc.

''		'' not allowed inside procs
''		if( env.scope > 0 ) then
''			hReportError FB_ERRMSG_ILLEGALINSIDEASUB
''			exit function
''		end if

		lexSkipToken( )

		rtlDataStoreBegin( )

		do
			littext = ""
			typ = INVALID

			hMatchExpression( expr )

			'' check if it's an string
			s = NULL
			if( astGetDataType( expr ) = IR_DATATYPE_FIXSTR ) then
				if( astIsVAR( expr ) ) then
					s = astGetSymbolOrElm( expr )
					if( s <> NULL ) then
						if( not symbGetVarInitialized( s ) ) then
							s = NULL
						end if
					end if
				end if
			end if

			'' string?
			if( s <> NULL ) then
				astDel expr

                typ = FB_SYMBTYPE_FIXSTR
				litlen  = symbGetLen( s ) - 1 				'' less the null-char
				littext = symbGetVarText( s )

				if( symbGetAccessCnt( s ) = 0 ) then
					symbDelVar s
				end if

            	if( not rtlDataStore( littext, litlen, typ ) ) then
	            	exit function
    	        end if

			else

				if( astIsOFFSET( expr ) ) then
            		if( not rtlDataStoreOFS( astGetSymbolOrElm( expr ) ) ) then
	            		exit function
    	        	end if

				else

					if( not astIsCONST( expr ) ) then
						hReportError FB_ERRMSG_EXPECTEDCONST
						exit function
					end if

  					littext = astGetValueAsStr( expr )
  					litlen = len( littext )

            		if( not rtlDataStore( littext, litlen, IR_DATATYPE_FIXSTR ) ) then
	            		exit function
    	        	end if

  				end if

  				astDel( expr )

		    end if

		loop while( hMatch( CHAR_COMMA ) )

		rtlDataStoreEnd

		function = TRUE

	end select

end function

'':::::
'' PrintStmt	  =   (PRINT|'?') ('#' Expression ',')? (USING Expression{str} ';')? (Expression? ';'|"," )*
''
function cPrintStmt as integer
    dim as ASTNODE ptr usingexpr, filexpr, filexprcopy, expr
    dim as integer expressions, issemicolon, iscomma, istab, isspc, islprint

	function = FALSE

	'' (PRINT|'?')
	if( not hMatch( FB_TK_PRINT ) ) then
		if( not hMatch( CHAR_QUESTION ) ) then
            if( not hMatch( FB_TK_LPRINT ) ) then
				exit function
            else
                islprint = TRUE
            end if
		end if
	end if

    if( islprint ) then
    	filexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    else
        '' ('#' Expression)?
        if( hMatch( CHAR_SHARP ) ) then
            hMatchExpression( filexpr )

            hMatchCOMMA( )

        else
            filexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        end if
    end if

	'' (USING Expression{str} ';')?
	usingexpr = NULL
	if( hMatch( FB_TK_USING ) ) then
		hMatchExpression( usingexpr )

		if( not hMatch( CHAR_SEMICOLON ) ) then
			hReportError FB_ERRMSG_EXPECTEDSEMICOLON
			exit function
		end if

		if( not rtlPrintUsingInit( usingexpr, islprint ) ) then
			exit function
		end if
    end if

    '' (Expression?|SPC(Expression)|TAB(Expression) ';'|"," )*
    expressions = 0
    do
        '' (Expression?|SPC(Expression)|TAB(Expression)
        isspc = FALSE
        istab = FALSE
        if( hMatch( FB_TK_SPC ) ) then
        	isspc = TRUE
			hMatchLPRNT( )

			hMatchExpression( expr )

			hMatchRPRNT( )

        elseif( hMatch( FB_TK_TAB ) ) then
            istab = TRUE
			hMatchLPRNT( )

			hMatchExpression( expr )

			hMatchRPRNT( )

        elseif( not cExpression( expr ) ) then
        	expr = NULL
        end if

		iscomma = FALSE
		issemicolon = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		elseif( hMatch( CHAR_SEMICOLON ) ) then
			issemicolon = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle PRINT w/o expressions
    	if( (not iscomma) and (not issemicolon) and (expr = NULL) ) then
    		if( usingexpr = NULL ) then
    			if( expressions = 0 ) then
    				if( not rtlPrint( filexprcopy, FALSE, FALSE, NULL, islprint ) ) then
						exit function
					end if
    			end if
    		else
    			if( not rtlPrintUsingEnd( filexprcopy, islprint ) ) then
					exit function
				end if
    		end if

    		exit do
    	end if

    	if( usingexpr = NULL ) then
    		if( isspc ) then
    			if( not rtlPrintSPC( filexprcopy, expr, islprint ) ) then
					exit function
				end if
    		elseif( istab ) then
    			if( not rtlPrintTab( filexprcopy, expr, islprint ) ) then
					exit function
				end if
    		else
    			if( not rtlPrint( filexprcopy, iscomma, issemicolon, expr, islprint ) ) then
					hReportError FB_ERRMSG_INVALIDDATATYPES
					exit function
				end if
    		end if

    	else
    		if( not rtlPrintUsing( filexprcopy, expr, iscomma, issemicolon, islprint ) ) then
    			hReportError FB_ERRMSG_INVALIDDATATYPES
				exit function
			end if
    	end if

    	expressions += 1
    loop while( iscomma or issemicolon )

    ''
    astDelTree( filexpr )

    function = TRUE

end function

'':::::
'' WriteStmt	  =   WRITE ('#' Expression)? (Expression? "," )*
''
function cWriteStmt as integer
    dim as ASTNODE ptr filexpr, filexprcopy, expr
    dim as integer expressions, iscomma

	function = FALSE

	'' WRITE
	if( not hMatch( FB_TK_WRITE ) ) then
		exit function
	end if

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
		hMatchExpression( filexpr )

		hMatchCOMMA( )

    else
    	filexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if

    '' (Expression? "," )*
    expressions = 0
    do
		if( not cExpression( expr ) ) then
        	expr = NULL
        end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle WRITE w/o expressions
    	if( (not iscomma) and (expr = NULL) ) then
    		if( expressions = 0 ) then
    			rtlWrite( filexprcopy, FALSE, NULL )
    		end if

    		exit do
    	end if

    	if( not rtlWrite( filexprcopy, iscomma, expr ) ) then
    		hReportError FB_ERRMSG_INVALIDDATATYPES
    		exit function
    	end if

    	expressions += 1
    loop while( iscomma )

    ''
    astDelTree( filexpr )

    function = TRUE

end function

'':::::
'' LineInputStmt	  =   LINE INPUT ';'? ('#' Expression| Expression{str}?) (','|';')? Variable? .
''
function cLineInputStmt as integer
    dim as ASTNODE ptr expr, dstexpr
    dim as integer isfile, addnewline, issep, addquestion

	function = FALSE

	'' LINE
	if( lexGetToken( ) <> FB_TK_LINE ) then
		exit function
	end if

	'' INPUT
	if( lexGetLookAhead(1) <> FB_TK_INPUT ) then
		exit function
	end if

	lexSkipToken( )
	lexSkipToken( )

	'' ';'?
	if( hMatch( CHAR_SEMICOLON ) ) then
		addnewline = FALSE
	else
		addnewline = TRUE
	end if

	'' '#'?
	isfile = FALSE
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
	end if

	'' Expression?
	if( not cExpression( expr ) ) then
		if( isfile ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if
		expr = NULL
	end if

	'' ','|';'?
	issep = TRUE
	if( not hMatch( CHAR_COMMA ) ) then
		if( not hMatch( CHAR_SEMICOLON ) ) then
			issep = FALSE
			if( (expr = NULL) or (isfile) ) then
				hReportError( FB_ERRMSG_EXPECTEDCOMMA )
				exit function
			end if
        else
        	addquestion = TRUE
		end if
    else
        addquestion = FALSE
	end if

    '' Variable?
	if( not cVarOrDeref( dstexpr ) ) then
       	if( (expr = NULL) or (isfile) ) then
       		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
       		exit function
       	end if
       	dstexpr = expr
       	expr = NULL
    else
    	if( issep = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDCOMMA )
			exit function
    	end if
    end if

    '' not a string?
    if( not hIsString( astGetDataType( dstexpr ) ) ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
    end if

    function = rtlFileLineInput( isfile, expr, dstexpr, addquestion, addnewline )

end function

'':::::
'' InputStmt	  =   INPUT ';'? (('#' Expression| STRING_LIT) (','|';'))? Variable (',' Variable)*
''
function cInputStmt as integer
    dim as ASTNODE ptr filestrexpr, dstexpr
    dim as integer iscomma, isfile, addnewline, addquestion, lgt

	function = FALSE

	'' INPUT
	if( not hMatch( FB_TK_INPUT ) ) then
		exit function
	end if

	'' ';'?
	if( hMatch( CHAR_SEMICOLON ) ) then
		addnewline = FALSE
	else
		addnewline = TRUE
	end if

	'' '#'?
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
		'' Expression
		hMatchExpression( filestrexpr )

    else
    	isfile = FALSE
    	'' STRING_LIT?
    	if( lexGetClass = FB_TKCLASS_STRLITERAL ) then
			lgt = lexGetTextLen( )
			filestrexpr = astNewVAR( hAllocStringConst( *lexGetText( ), lgt ), _
									 NULL, 0, IR_DATATYPE_FIXSTR )
			lexSkipToken( )
    	else
    		filestrexpr = NULL
    	end if
	end if

	'' ','|';'
	addquestion = FALSE
	if( (isfile) or (filestrexpr <> NULL) ) then
		if( not hMatch( CHAR_COMMA ) ) then
			if( not hMatch( CHAR_SEMICOLON ) ) then
				hReportError FB_ERRMSG_EXPECTEDCOMMA
				exit function
			else
				addquestion = TRUE
			end if
		end if
	end if

	''
	if( not rtlFileInput( isfile, filestrexpr, addquestion, addnewline ) ) then
		exit function
	end if

    '' Variable (',' Variable)*
    do
		if( not cVarOrDeref( dstexpr ) ) then
       		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
       		exit function
       	end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	if( not rtlFileInputGet( dstexpr ) ) then
			exit function
		end if
    loop while( iscomma )

    function = TRUE

end function

'':::::
'' ViewStmt	  =   VIEW (PRINT (Expression TO Expression)?) .
''
function cViewStmt(byval is_func as integer = FALSE, _
                   byref funcexpr as ASTNODE ptr = NULL ) as integer
    dim as ASTNODE ptr expr1, expr2
    dim as integer default_view, default_view_value

	function = FALSE

	default_view = is_func
    default_view_value = iif(is_func,-1,0)

	'' VIEW
	if( lexGetToken <> FB_TK_VIEW ) then
		exit function
	end if

	'' PRINT
	if( lexGetLookAhead(1) <> FB_TK_PRINT ) then
		exit function
	end if

	lexSkipToken
	lexSkipToken

	'' (Expression TO Expression)?
	if( not is_func ) then
    	if( cExpression( expr1 ) ) then
            if( not hMatch( FB_TK_TO ) ) then
                hReportError FB_ERRMSG_SYNTAXERROR
                exit function
            end if

            hMatchExpression( expr2 )
        else
            default_view = TRUE
        end if
	end if

    if( default_view ) then
        if( is_func ) then
            hMatchLPRNT()
            hMatchRPRNT()
        end if
        expr1 = astNewCONSTi( default_view_value, IR_DATATYPE_INTEGER )
        expr2 = astNewCONSTi( default_view_value, IR_DATATYPE_INTEGER )
	end if

	funcexpr = rtlConsoleView( expr1, expr2 )
    function = funcexpr <> NULL

    if( not is_func ) then
    	astAdd( funcexpr )
    end if

end function

'':::::
''PokeStmt =   POKE Expression, Expression .
''
function cPokeStmt as integer
	dim as ASTNODE ptr expr1, expr2
	dim as integer poketype, lgt, ptrcnt
	dim as FBSYMBOL ptr subtype

	function = FALSE

	'' POKE
	lexSkipToken

	'' (SymbolType ',')?
	if( cSymbolType( poketype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case poketype
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR
			hReportError FB_ERRMSG_INVALIDDATATYPES, TRUE
			exit function
		end select

		'' ','
		hMatchCOMMA( )

	else
		poketype = IR_DATATYPE_BYTE
		subtype  = NULL
	end if

	'' Expression, Expression
	hMatchExpression( expr1 )

	hMatchCOMMA( )

	hMatchExpression( expr2 )

    select case astGetDataClass( expr1 )
    case IR_DATACLASS_STRING
    	hReportError FB_ERRMSG_INVALIDDATATYPES
        exit function
	case IR_DATACLASS_FPOINT
    	expr1 = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr1 )
	case else
        if( astGetDataSize( expr1 ) <> FB_POINTERSIZE ) then
        	hReportError FB_ERRMSG_INVALIDDATATYPES
        	exit function
        end if
	end select

    expr1 = astNewPTR( NULL, NULL, 0, expr1, poketype, subtype )

    expr1 = astNewASSIGN( expr1, expr2 )

	astAdd( expr1 )

    function = TRUE

end function

'':::::
private function hFileClose( byval isfunc as integer ) as ASTNODE ptr
	dim as integer cnt
	dim as ASTNODE ptr filenum, proc

	function = NULL

	'' CLOSE
	lexSkipToken

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

	cnt = 0
	do
		hMatch( CHAR_SHARP )

    	if( not cExpression( filenum ) ) then
			if( cnt = 0 ) then
				filenum = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
			else
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if
		end if

		proc = rtlFileClose( filenum, isfunc )
		if( proc = NULL ) then
			exit function
		end if

		if( isfunc ) then
			exit do
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	if( isfunc ) then
		'' ')'
		hMatchRPRNT( )
	end if

	function = proc

end function

'':::::
private function hFilePut( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, expr1, expr2
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	hMatchExpression( filenum )

	hMatchCOMMA( )

	if( not cExpression( expr1 ) ) then
		expr1 = NULL
	end if

	hMatchCOMMA( )

	hMatchExpression( expr2 )

	'' don't allow literal values, due the way "byref as
	'' any" args work (ie, the VB-way: literals are passed by value)
	if( astIsCONST( expr2 ) or astIsOFFSET( expr2 ) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE )
		exit function
	end if

    isarray = FALSE
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    		s = astGetSymbolOrElm( expr2 )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then
    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_SYMBTYPE_STRING ) then
						hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						exit function
    				end if
    				lexSkipToken( )
    				lexSkipToken( )
    			end if
    		end if
    	end if
    end if

	if( not isarray ) then
		function = rtlFilePut( filenum, expr1, expr2, isfunc )
	else
		function = rtlFilePutArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileGet( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, expr1, expr2
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	hMatchExpression( filenum )

	hMatchCOMMA( )

	if( not cExpression( expr1 ) ) then
		expr1 = NULL
	end if

	hMatchCOMMA( )

	if( not cVarOrDeref( expr2 ) ) then
		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		exit function
	end if

    isarray = FALSE
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    		s = astGetSymbolOrElm( expr2 )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then
    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_SYMBTYPE_STRING ) then
						hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						exit function
    				end if
    				lexSkipToken( )
    				lexSkipToken( )
    			end if
    		end if
    	end if
    end if

	if( not isarray ) then
		function = rtlFileGet( filenum, expr1, expr2, isfunc )
	else
		function = rtlFileGetArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileOpen( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, filename, fmode, faccess, flock, flen
    dim as integer short_form
	dim as integer file_mode, access_mode, lock_mode, record_len
    dim as FBOPENKIND open_kind

	function = NULL

    open_kind = FB_FILE_TYPE_FILE

    short_form = FALSE

	'' special devices
	select case ucase$( *lexGetText( ) )
    case "CONS"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
    		open_kind = FB_FILE_TYPE_CONS
    	end if

    case "ERR"
		lexSkipToken( )
        open_kind = FB_FILE_TYPE_ERR

    case "PIPE"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
        	open_kind = FB_FILE_TYPE_PIPE
        end if

    case "SCRN"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
        	open_kind = FB_FILE_TYPE_SCRN
        end if

    case "LPT"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
    		open_kind = FB_FILE_TYPE_LPT
    	end if
    end select

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

    select case open_kind
    case FB_FILE_TYPE_FILE, FB_FILE_TYPE_PIPE, FB_FILE_TYPE_LPT
        '' a filename is only valid for some file types

		hMatchExpression( filename )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        ' only test for short OPEN form when using the "normal" OPEN
        if open_kind = FB_FILE_TYPE_FILE then
	        if( isfunc ) then
                select case lexGetToken
                case FB_TK_FOR, FB_TK_ACCESS, FB_TK_AS
                case else
                    short_form = TRUE
                end select
	        else
	            if( hMatch( CHAR_COMMA ) ) then
	                '' ',' -> indicates the short form
	                short_form = TRUE
	            end if
            end if
        end if

    case else

        ' no file name provided for this kind of OPEN statmenets
    	filename = astNewCONSTs( "" )

    end select

    if( short_form ) then
        '' file mode ("I"|"O"|"A"|"B"|"R")
        fmode = filename
        filename = NULL

        '' '#'? file number
        hMatch( CHAR_SHARP )
        hMatchExpression( filenum )

        hMatchCOMMA( )
        '' file name
        hMatchExpression( filename )

        '' record length
        if( hMatch( CHAR_COMMA ) ) then
            if( lexGetToken <> CHAR_COMMA ) then
            	hMatchExpression( flen )
            end if
            '' access mode
            if( hMatch( CHAR_COMMA ) ) then
                if( lexGetToken <> CHAR_COMMA ) then
                    hMatchExpression( faccess )
                end if
                '' lock mode
                if( hMatch( CHAR_COMMA ) ) then
                	hMatchExpression( flock )
                end if
            end if
        end if
        if( flen = NULL ) then flen = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        if( faccess = NULL ) then faccess = astNewCONSTs( "" )
        if( flock = NULL ) then flock = astNewCONSTs( "" )
    else
        '' (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))?
        if( hMatch( FB_TK_FOR ) ) then
            select case lexGetToken
            case FB_TK_INPUT
                file_mode = FB_FILE_MODE_INPUT
            case FB_TK_OUTPUT
                file_mode = FB_FILE_MODE_OUTPUT
            case FB_TK_BINARY
                file_mode = FB_FILE_MODE_BINARY
            case FB_TK_RANDOM
                file_mode = FB_FILE_MODE_RANDOM
            case FB_TK_APPEND
                file_mode = FB_FILE_MODE_APPEND
            case else
                exit function
            end select
            lexSkipToken

        else
            file_mode = FB_FILE_MODE_RANDOM
        end if

        fmode = astNewCONSTi( file_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (ACCESS (READ|WRITE|READ WRITE))?
        if( hMatch( FB_TK_ACCESS ) ) then
            select case lexGetToken
            case FB_TK_WRITE
                lexSkipToken
                access_mode = FB_FILE_ACCESS_WRITE
            case FB_TK_READ
                lexSkipToken
                if( hMatch( FB_TK_WRITE ) ) then
                    access_mode = FB_FILE_ACCESS_READWRITE
                else
                    access_mode = FB_FILE_ACCESS_READ
                end if
            end select
        else
            access_mode = FB_FILE_ACCESS_ANY
        end if

        faccess = astNewCONSTi( access_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (SHARED|LOCK (READ|WRITE|READ WRITE))?
        if( hMatch( FB_TK_SHARED ) ) then
            lock_mode = FB_FILE_LOCK_SHARED
        elseif( hMatch( FB_TK_LOCK ) ) then
            select case lexGetToken
            case FB_TK_WRITE
                lexSkipToken
                lock_mode = FB_FILE_LOCK_WRITE
            case FB_TK_READ
                lexSkipToken
                if( hMatch( FB_TK_WRITE ) ) then
                    lock_mode = FB_FILE_LOCK_READWRITE
                else
                    lock_mode = FB_FILE_LOCK_READ
                end if
            end select
        else
            lock_mode = FB_FILE_LOCK_SHARED
        end if

        flock = astNewCONSTi( lock_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' AS '#'? Expression
        if( not hMatch( FB_TK_AS ) ) then
            hReportError FB_ERRMSG_EXPECTINGAS
            exit function
        end if

        hMatch( CHAR_SHARP )

        hMatchExpression( filenum )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (LEN '=' Expression)?
        if( hMatch( FB_TK_LEN ) ) then
            if( not hMatch( FB_TK_ASSIGN ) ) then
                hReportError FB_ERRMSG_EXPECTEDEQ
                exit function
            end if
            hMatchExpression( flen )
        else
            flen = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        end if

    end if

    if( isfunc ) then
        '' ')'
        hMatchRPRNT( )
    end if

	''
	function = rtlFileOpen( filename, fmode, faccess, flock, filenum, flen, isfunc, open_kind )

end function

'':::::
private function cWidth( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr fnum, width_arg, height_arg, dev_name
    dim as ASTNODE ptr func
    dim as integer checkrprnt

	function = NULL

	lexSkipToken( )

	if( isfunc ) then
		'' '('?
		checkrprnt = hMatch( CHAR_LPRNT )
	else
		checkrprnt = FALSE
	end if

    if( isfunc ) then
    	' Width Screen?
    	if( (not checkrprnt) or _                   '' !!!FIXME!!! change to OrElse
    		hMatch( CHAR_RPRNT ) ) then
    		return rtlWidthScreen( NULL, NULL, isfunc )
    	end if

	end if

    if( hMatch( FB_TK_LPRINT ) ) then
       ' fb_WidthDev
       dev_name = astNewCONSTs( "LPT1:" )
       hMatchExpression( width_arg )

       function = rtlWidthDev( dev_name, width_arg, isfunc )

	elseif( hMatch( CHAR_SHARP ) ) then
    	' fb_WidthFile

        hMatchExpression( fnum )

        if( hMatch( CHAR_COMMA ) ) then
        	hMatchExpression( width_arg )
		else
        	width_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

        function = rtlWidthFile( fnum, width_arg, isfunc )

	elseif( hMatch( CHAR_COMMA ) ) then
    	' fb_WidthScreen
        width_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        hMatchExpression( height_arg )
        function = rtlWidthScreen( width_arg, height_arg, isfunc )

	else
		hMatchExpression( dev_name )
        select case astGetDataType( dev_name )
        case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR:
            ' fb_WidthDev

        	if( hMatch( CHAR_COMMA ) ) then
            	hMatchExpression( width_arg )
			else
            	width_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
			end if
            function = rtlWidthDev( dev_name, width_arg, isfunc )

		case else
        	' fb_WidthScreen
            width_arg = dev_name
            dev_name = NULL

            if( hMatch( CHAR_COMMA ) ) then
            	hMatchExpression( height_arg )
			else
            	height_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
			end if
            function = rtlWidthScreen( width_arg, height_arg, isfunc )

		end select
	end if

	if( checkrprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

end function

'':::::
private function hFileRename( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filename_old, filename_new
	dim as integer matchprnt

	function = NULL

	'' '('
    if( isfunc ) then
		hMatchLPRNT( )
    else
		'' '('?
       	matchprnt = hMatch( CHAR_LPRNT )
    end if

	hMatchExpression( filename_old )

	if( isfunc ) then
		'' ','?
		hMatchCOMMA( )
    else
        if( not hMatch( FB_TK_AS ) ) then
        	if( not hMatch( CHAR_COMMA ) ) then
                hReportError FB_ERRMSG_EXPECTINGAS
                exit function
            end if
        end if
	end if

	hMatchExpression( filename_new )

	if( isfunc or matchprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

	''
	function = rtlFileRename( filename_new, filename_old, isfunc )

end function


'':::::
'' FileStmt		  =	   OPEN Expression{str} (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))? (ACCESS Expression)?
''					   (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
''                |    OPEN ("O"|"I"|"B"|"R"|"A")',' '#'? Expression{int} ',' Expression{str}
''                     (',' Expression{int}? (',' Expression{str}? (',' Expression{str})? )? )?
''				  |	   CLOSE ('#'? Expression)*
''				  |	   SEEK '#'? Expression ',' Expression
''				  |	   PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
''				  |	   GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
''				  |    (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)? .
function cFileStmt as integer
    dim as ASTNODE ptr filenum, expr1, expr2
    dim as integer islock

	function = FALSE

	select case as const lexGetToken
	'' OPEN Expression{str} (FOR Expression)? (ACCESS Expression)?
	'' (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
    ''
    '' or:
    ''
    '' OPEN ("O"|"I"|"B"|"R"|"A")',' '#'? Expression{int}',' Expression{str} (',' Expression{int})?
	case FB_TK_OPEN
		lexSkipToken

		function = (hFileOpen( FALSE ) <> NULL)


	'' CLOSE ('#'? Expression)*
	case FB_TK_CLOSE

		function = (hFileClose( FALSE ) <> NULL)

	'' SEEK '#'? Expression ',' Expression
	case FB_TK_SEEK
		lexSkipToken
		hMatch( CHAR_SHARP )

		hMatchExpression( filenum )

		hMatchCOMMA( )

		hMatchExpression( expr1 )

		function = rtlFileSeek( filenum, expr1 )

	'' PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
	case FB_TK_PUT
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken( )

        function = (hFilePut( FALSE ) <> NULL)

	'' GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
	case FB_TK_GET
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken

		function = (hFileGet( FALSE ) <> NULL)

	'' (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)?
	case FB_TK_LOCK, FB_TK_UNLOCK
		if( lexGetToken = FB_TK_LOCK ) then
			islock = TRUE
		else
			islock = FALSE
		end if

		lexSkipToken
		hMatch( CHAR_SHARP )

		hMatchExpression( filenum )

		hMatchCOMMA( )

		hMatchExpression( expr1 )

		if( hMatch( FB_TK_TO ) ) then
			hMatchExpression( expr2 )
		else
			expr2 = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

		function = rtlFileLock( islock, filenum, expr1, expr2 )

    '' NAME oldfilespec$ AS newfilespec$
    case FB_TK_NAME
		lexSkipToken

		function = (hFileRename( FALSE ) <> NULL)

	end select

end function

'':::::
function cGOTBStmt( byval expr as ASTNODE ptr, _
					byval isgoto as integer ) as integer
    dim as ASTNODE ptr idxexpr
	dim as integer l, i
	dim as FBSYMBOL ptr sym, exitlabel, tbsym, labelTB(0 to FB_MAXGOTBITEMS-1)

	function = FALSE

	'' convert to uinteger if needed
	if( astGetDataType( expr ) <> IR_DATATYPE_UINT ) then
		expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
	end if

	'' store expression into a temp var
	sym = symbAddTempVar( FB_SYMBTYPE_UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' read labels
	l = 0
	do
		if( (lexGetClass <> FB_TKCLASS_NUMLITERAL) and _
			(lexGetClass <> FB_TKCLASS_IDENTIFIER) ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			exit function
		end if

		'' Label
		labelTB(l) = symbFindByClass( lexGetSymbol, FB_SYMBCLASS_LABEL )
		if( labelTB(l) = NULL ) then
			labelTB(l) = symbAddLabel( *lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		l += 1
	loop while( hMatch( CHAR_COMMA ) )

	''
	exitlabel = symbAddLabel( "" )

	'' < 1?
	expr = astNewBOP( IR_OP_LT, astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
					  astNewCONSTi( 1, IR_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

	'' > labels?
	expr = astNewBOP( IR_OP_GT, astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
					  astNewCONSTi( l, IR_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( IR_OP_MUL, astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
    				  			    astNewCONSTi( FB_INTEGERSIZE, IR_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, NULL, -1*FB_INTEGERSIZE, IR_DATATYPE_UINT ), idxexpr, _
    				  IR_DATATYPE_UINT, NULL )

    if( not isgoto ) then
    	astAdd( astNewSTACK( IR_OP_PUSH, astNewADDR( IR_OP_ADDROF, astNewVAR( exitlabel ) ) ) )
    end if

    astAdd( astNewBRANCH( IR_OP_JUMPPTR, NULL, expr ) )

    '' emit table
    astAdd( astNewLABEL( tbsym ) )

    ''
    for i = 0 to l-1
    	astAdd( astNewJMPTB( IR_DATATYPE_UINT, labelTB(i) ) )
    next

    '' emit exit label
    astAdd( astNewLABEL( exitlabel ) )

    function = TRUE

end function

'':::::
''OnStmt 		=	ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
''
function cOnStmt as integer
	dim as ASTNODE ptr expr
	dim as integer isgoto, islocal, isrestore
	dim as FBSYMBOL ptr label

	function = FALSE

	'' ON
	if( not hMatch( FB_TK_ON ) ) then
		exit function
	end if

	'' LOCAL?
	if( hMatch( FB_TK_LOCAL ) ) then
		if( env.scope = 0 ) then
			hReportError FB_ERRMSG_SYNTAXERROR, TRUE
			exit function
		end if
		islocal = TRUE
	else
		islocal = FALSE
	end if

	'' ERROR | Expression
	expr = NULL
	select case lexGetToken( )
	case FB_TK_ERROR
		lexSkipToken( )
	case else
		hMatchExpression( expr )
	end select

	'' GOTO|GOSUB
	if( hMatch( FB_TK_GOTO ) ) then
		isgoto = TRUE
	elseif( hMatch( FB_TK_GOSUB ) ) then
	    '' can't do GOSUB with ON ERROR
	    if( expr = NULL ) then
	    	hReportError FB_ERRMSG_SYNTAXERROR
	    	exit function
	    end if
	    isgoto = FALSE
	else
		hReportError FB_ERRMSG_SYNTAXERROR
		exit function
	end if

    '' on error?
	if( expr = NULL ) then
		isrestore = FALSE
		'' ON ERROR GOTO 0?
		if( lexGetClass = FB_TKCLASS_NUMLITERAL ) then
			if( *lexGetText( ) = "0" ) then
				lexSkipToken( )
				isrestore = TRUE
			end if
        end if

		if( not isrestore ) then
			'' Label
			label = symbFindByClass( lexGetSymbol, FB_SYMBCLASS_LABEL )
			if( label = NULL ) then
				label = symbAddLabel( *lexGetText( ), FALSE, TRUE )
			end if
			lexSkipToken( )

			expr = astNewVAR( label, NULL, 0, IR_DATATYPE_UINT )
			expr = astNewADDR( IR_OP_ADDROF, expr, label )
			rtlErrorSetHandler( expr, (islocal = TRUE) )

		else
        	rtlErrorSetHandler( astNewCONSTi( NULL, IR_DATATYPE_UINT ), (islocal = TRUE) )
		end if

		function = TRUE

	else
        function = cGOTBStmt( expr, isgoto )
	end if

end function

'':::::
''ErrorStmt 	=	ERROR Expression
''				|   ERR '=' Expression .
''
function cErrorStmt as integer
	dim as ASTNODE ptr expr

	function = FALSE


	select case lexGetToken( )

	'' ERROR Expression
	case FB_TK_ERROR
		lexSkipToken( )

		'' Expression
		hMatchExpression( expr )

		rtlErrorThrow( expr, lexLineNum( ) )

		function = TRUE

	'' ERR '=' Expression
	case FB_TK_ERR
		lexSkipToken( )

		'' '='
		if( not hMatch( FB_TK_ASSIGN ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEQ )
			exit function
		end if

		'' Expression
		hMatchExpression( expr )

		rtlErrorSetnum( expr )

		function = TRUE

	end select

end function

'':::::
''QuirkStmt   	  =   GotoStmt
''				  |   ArrayStmt
''				  |	  PrintStmt
''				  |   MidStmt
''				  |   DataStmt
''				  |   etc .
''
function cQuirkStmt as integer
	dim as integer res

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
		if( lexGetToken( ) = CHAR_QUESTION ) then	'' PRINT as '?', can't be a keyword..
			function = cPrintStmt( )
		end if
		exit function
	end if

	res = FALSE

	select case as const lexGetToken( )
	case FB_TK_GOTO, FB_TK_GOSUB, FB_TK_RETURN, FB_TK_RESUME
		res = cGotoStmt( )
	case FB_TK_PRINT, FB_TK_LPRINT
		res = cPrintStmt( )
	case FB_TK_RESTORE, FB_TK_READ, FB_TK_DATA
		res = cDataStmt( )
	case FB_TK_ERASE, FB_TK_SWAP
		res = cArrayStmt( )
	case FB_TK_LINE
		res = cLineInputStmt( )
	case FB_TK_INPUT
		res = cInputStmt( )
	case FB_TK_POKE
		res = cPokeStmt( )
	case FB_TK_OPEN, FB_TK_CLOSE, FB_TK_SEEK, FB_TK_PUT, FB_TK_GET, _
		 FB_TK_LOCK, FB_TK_UNLOCK, FB_TK_NAME
		res = cFileStmt( )
	case FB_TK_ON
		res = cOnStmt( )
	case FB_TK_WRITE
		res = cWriteStmt( )
	case FB_TK_ERROR, FB_TK_ERR
		res = cErrorStmt( )
	case FB_TK_VIEW
		res = cViewStmt( )
	case FB_TK_MID
		res = cMidStmt( )
	case FB_TK_LSET
		res = cLSetStmt( )
    case FB_TK_WIDTH
        res = cWidth( FALSE ) <> NULL

	end select

	if( res = FALSE ) then
		if( hGetLastError( ) = FB_ERRMSG_OK ) then
			res = cGfxStmt( )
		end if
	end if

	function = res

end function


'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr sexpr, expr
	dim as integer islbound
	dim as FBSYMBOL ptr s

	function = FALSE

	select case lexGetToken

	'' (LBOUND|UBOUND) '(' ID (',' Expression)? ')'
	case FB_TK_LBOUND, FB_TK_UBOUND
		if( lexGetToken = FB_TK_LBOUND ) then
			islbound = TRUE
		else
			islbound = FALSE
		end if
		lexSkipToken

		'' '('
		hMatchLPRNT( )

		'' ID
		if( not cVarOrDeref( sexpr, FALSE ) ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			exit function
		end if

		'' array?
		s = astGetSymbolOrElm( sexpr )
		if( s = NULL ) then
			hReportError( FB_ERRMSG_EXPECTEDARRAY, TRUE )
			exit function
		end if

		if( not symbIsArray( s ) ) then
			hReportError( FB_ERRMSG_EXPECTEDARRAY, TRUE )
			exit function
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( expr )
		else
			expr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

		'' ')'
		hMatchRPRNT( )

		funcexpr = rtlArrayBound( sexpr, expr, islbound )

		function = funcexpr <> NULL

	end select

end function

'':::::
private function cStrCHR( byref funcexpr as ASTNODE ptr ) as integer
	static as zstring * 32*6+1 s
	static as zstring * 8+1 o
	dim as integer v, i, cnt, isconst
	dim as ASTNODE ptr exprtb(0 to 31), expr

	function = FALSE

	hMatchLPRNT( )

	cnt = 0
	do
		hMatchExpression( exprtb(cnt) )
		cnt += 1
		if( cnt >= 32 ) then
			exit do
		end if
	loop while( hMatch( CHAR_COMMA ) )

	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	isconst = TRUE
	for i = 0 to cnt-1
		if( not astIsCONST( exprtb(i) ) ) then
			isconst = FALSE
			exit for
        else

            '' when the constant value is 0, we must not handle this as a
            '' constant string
  			expr = exprtb(i)
  			v = astGetValueAsInt( expr )

			if( v = 0 ) then
				isconst = FALSE
				exit for
			end if

		end if
	next i

	if( isconst ) then
		s = ""

		for i = 0 to cnt-1
  			expr = exprtb(i)
  			v = astGetValueAsInt( expr )
  			astDel( expr )

			if( (v < CHAR_SPACE) or (v > 127) ) then
				s += "\27"
				o = oct$( v )
				s += chr$( len( o ) )
				s += o
			else
				s += chr$( v )
			end if
		next i

		funcexpr = astNewVAR( hAllocStringConst( s, cnt ), NULL, 0, IR_DATATYPE_FIXSTR )

    else

		funcexpr = rtlStrChr( cnt, exprtb() )

	end if

	function = funcexpr <> NULL

end function

'':::::
private function cStrASC( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr1, posexpr
    dim as integer p
    dim as FBSYMBOL ptr sym

	cStrASC = FALSE

	hMatchLPRNT( )

	hMatchExpression( expr1 )

	'' (',' Expression)?
	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpression( posexpr )
	else
		posexpr = NULL
	end if

	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	if( astIsVAR( expr1 ) ) then
		if( astGetDataType( expr1 ) = IR_DATATYPE_FIXSTR ) then
			sym = astGetSymbolOrElm( expr1 )
			if( sym <> NULL ) then
				if( symbGetVarInitialized( sym ) ) then

					'' pos is an constant too?
					if( posexpr <> NULL ) then
						if( astIsCONST( posexpr ) ) then

							p = astGetValueAsInt( posexpr )
							astDel( posexpr )

							if( p < 0 ) then
								p = 0
							end if
						else
							p = -1
						end if
					else
						p = 1
					end if

					if( p >= 0 ) then
						funcexpr = astNewCONSTi( asc( hEscapeToChar( symbGetVarText( sym ) ) , p ), _
											 	 IR_DATATYPE_INTEGER )

						'' delete var if it was never accessed before
						if( symbGetAccessCnt( sym ) = 0 ) then
							symbDelVar( sym )
						end if

	    				astDel( expr1 )
	    				expr1 = NULL
	    			end if

	    		end if
	    	end if
		end if
	end if

	if( expr1 <> NULL ) then
		funcexpr = rtlStrAsc( expr1, posexpr )
	end if

	function = funcexpr <> NULL

end function

'':::::
'' cStringFunct	=	STR$ '(' Expression{int|float|double} ')'
'' 				|   MID$ '(' Expression ',' Expression (',' Expression)? ')'
'' 				|   STRING$ '(' Expression ',' Expression{int|str} ')' .
''              |   INSTR '(' (Expression{int} ',')? Expression{str}, "ANY"? Expression{str} ')'
''              |   RTRIM$ '(' Expression{str} (, "ANY" Expression{str} )? ')'
''
function cStringFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr1, expr2, expr3
    dim as integer dclass, dtype, is_any

	function = FALSE

	select case lexGetToken
	'' STR$ '(' Expression{int|float|double} ')'
	case FB_TK_STR
		lexSkipToken
		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchRPRNT( )

		funcexpr = rtlToStr( expr1 )

		function = funcexpr <> NULL

	'' MID$ '(' Expression ',' Expression (',' Expression)? ')'
	case FB_TK_MID
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( expr3 )
		else
			expr3 = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		funcexpr = rtlStrMid( expr1, expr2, expr3 )

		function = funcexpr <> NULL


	'' STRING$ '(' Expression ',' Expression{int|str} ')'
	case FB_TK_STRING
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		hMatchRPRNT( )

		funcexpr = rtlStrFill( expr1, expr2 )

		function = funcexpr <> NULL

	'' CHR$ '(' Expression (',' Expression )* ')'
	case FB_TK_CHR
		lexSkipToken

		function = cStrCHR( funcexpr )

	'' ASC '(' Expression (',' Expression)? ')'
	case FB_TK_ASC
		lexSkipToken

		function = cStrASC( funcexpr )

    case FB_TK_INSTR
        lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

        is_any = hMatch( FB_TK_ANY )

		hMatchExpression( expr2 )

        if( not is_any ) then
        	if( hMatch( CHAR_COMMA ) ) then
                is_any = hMatch( FB_TK_ANY )
                hMatchExpression( expr3 )
            end if
        end if

        if( expr3 = NULL ) then
            expr3 = expr2
            expr2 = expr1
			expr1 = astNewCONSTi( 1, IR_DATATYPE_INTEGER )
        end if

		hMatchRPRNT( )

		funcexpr = rtlStrInstr( expr1, expr2, expr3, is_any )

		function = funcexpr <> NULL

    case FB_TK_TRIM

        lexSkipToken

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

    case FB_TK_RTRIM

        lexSkipToken

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrRTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

    case FB_TK_LTRIM

        lexSkipToken

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrLTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

	end select

end function

'':::::
'' cMathFunct	=	ABS( Expression )
'' 				|   SGN( Expression )
''				|   FIX( Expression )
''				|   INT( Expression )
''				|	LEN( data type | Expression ) .
''
function cMathFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr, expr2
    dim as integer islen, typ, lgt, ptrcnt, op
    dim as FBSYMBOL ptr sym, subtype

	function = FALSE

	select case as const lexGetToken
	'' ABS( Expression )
	case FB_TK_ABS
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr )

		hMatchRPRNT( )

		'' hack! implemented as Unary OP for better speed on x86's
		funcexpr = astNewUOP( IR_OP_ABS, expr )
		if( funcexpr = NULL ) then
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end if

		function = TRUE

	'' SGN( Expression )
	case FB_TK_SGN
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr )

		hMatchRPRNT( )

		'' hack! implemented as Unary OP for better speed on x86's
		funcexpr = astNewUOP( IR_OP_SGN, expr )
		if( funcexpr = NULL ) then
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end if

		function = TRUE

	'' FIX( Expression )
	case FB_TK_FIX
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr )

		hMatchRPRNT( )

		funcexpr = rtlMathFIX( expr )
		if( funcexpr = NULL ) then
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end if

		function = TRUE

	'' SIN/COS/...( Expression )
	case FB_TK_SIN, FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, FB_TK_ATN, _
		 FB_TK_SQR, FB_TK_LOG, FB_TK_INT

		select case as const lexGetToken( )
		case FB_TK_SIN
			op = IR_OP_SIN
		case FB_TK_ASIN
			op = IR_OP_ASIN
		case FB_TK_COS
			op = IR_OP_COS
		case FB_TK_ACOS
			op = IR_OP_ACOS
		case FB_TK_TAN
			op = IR_OP_TAN
		case FB_TK_ATN
			op = IR_OP_ATAN
		case FB_TK_SQR
			op = IR_OP_SQRT
		case FB_TK_LOG
			op = IR_OP_LOG
		case FB_TK_INT
			op = IR_OP_FLOOR
		end select

		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpression( expr )

		hMatchRPRNT( )

		'' hack! implemented as Unary OP for better speed on x86's
		funcexpr = astNewUOP( op, expr )
		if( funcexpr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		function = TRUE

	'' ATAN2( Expression ',' Expression )
	case FB_TK_ATAN2
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpression( expr )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		hMatchRPRNT( )

		'' hack! implemented as Binary OP for better speed on x86's
		funcexpr = astNewBOP( IR_OP_ATAN2, expr, expr2 )
		if( funcexpr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		function = TRUE

	'' LEN|SIZEOF( data type | Expression{idx-less arrays too} )
	case FB_TK_LEN, FB_TK_SIZEOF
		islen = (lexGetToken = FB_TK_LEN)
		lexSkipToken

		hMatchLPRNT( )

		expr = NULL
		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			env.checkarray = FALSE
			if( not cExpression( expr ) ) then
				env.checkarray = TRUE
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if
			env.checkarray = TRUE
		end if

		'' string expressions with SIZEOF() are not allowed
		if( expr <> NULL ) then
			if( not islen ) then
				if( astGetDataClass( expr ) = IR_DATACLASS_STRING ) then
					if( (astGetSymbolOrElm( expr ) = NULL) or (astIsFUNCT( expr )) ) then
						hReportError FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE
						exit function
					end if
				end if
			end if
		end if

		hMatchRPRNT( )

		if( expr <> NULL ) then
			funcexpr = rtlMathLen( expr, islen )
		else
			funcexpr = astNewCONSTi( lgt, IR_DATATYPE_INTEGER )
		end if

		function = TRUE

	end select

end function

'':::::
'' PeekFunct =   PEEK '(' (SymbolType ',')? Expression ')' .
''
function cPeekFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as integer peektype, lgt, ptrcnt
	dim as FBSYMBOL ptr subtype

	function = FALSE

	'' PEEK
	lexSkipToken

	'' '('
	hMatchLPRNT( )

	'' (SymbolType ',')?
	if( cSymbolType( peektype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case peektype
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end select

		'' ','
		hMatchCOMMA( )

	else
		peektype = IR_DATATYPE_BYTE
		subtype = NULL
	end if

	'' Expression
	hMatchExpression( expr )

	' ')'
	hMatchRPRNT( )

    ''
    select case astGetDataClass( expr )
    case IR_DATACLASS_STRING
    	hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	case IR_DATACLASS_FPOINT
		expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
	case else
		if( astGetDataSize( expr ) <> FB_POINTERSIZE ) then
        	hReportError FB_ERRMSG_INVALIDDATATYPES
        	exit function
		end if
	end select

    funcexpr = astNewPTR( NULL, NULL, 0, expr, peektype, subtype )

	'' hack! to handle loading to x86 regs DI and SI, as they don't have byte versions &%@#&
    if( peektype = IR_DATATYPE_BYTE ) then
    	funcexpr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, funcexpr )
	end if

    function = TRUE

end function

'':::::
'' FileFunct =   SEEK '(' Expression ')' |
''				 INPUT '(' Expr, (',' '#'? Expr)? ')'.
''
function cFileFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr filenum, expr

	function = FALSE

	'' SEEK '(' Expression ')'
	select case as const lexGetToken
	case FB_TK_SEEK
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( filenum )

		hMatchRPRNT( )

		funcexpr = rtlFileTell( filenum )

		function = funcexpr <> NULL

	'' INPUT '(' Expr (',' '#'? Expr)? ')'
	case FB_TK_INPUT
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr )

		if( hMatch( CHAR_COMMA ) ) then
			hMatch( CHAR_SHARP )

			hMatchExpression( filenum )
		else
			filenum = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		funcexpr = rtlFileStrInput( expr, filenum )

		function = funcexpr <> NULL

	'' OPEN '(' ... ')'
	case FB_TK_OPEN
		lexSkipToken

		funcexpr = hFileOpen( TRUE )
		function = funcexpr <> NULL

	'' CLOSE '(' '#'? Expr? ')'
	case FB_TK_CLOSE

		funcexpr = hFileClose( TRUE )
		function = funcexpr <> NULL

	'' PUT '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_PUT
		lexSkipToken

		hMatchLPRNT( )

		funcexpr = hFilePut( TRUE )
		function = funcexpr <> NULL

		hMatchRPRNT( )

	'' GET '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_GET
		lexSkipToken

		hMatchLPRNT( )

		funcexpr = hFileGet( TRUE )
		function = funcexpr <> NULL

		hMatchRPRNT( )

    '' NAME '(' oldfilespec$ ',' newfilespec$ ')'
    case FB_TK_NAME
		lexSkipToken

		funcexpr = hFileRename( TRUE )
		function = funcexpr <> NULL

	end select

end function

'':::::
''cErrorFunct =   ERR .
''
function cErrorFunct( byref funcexpr as ASTNODE ptr ) as integer

	function = FALSE

	if( hMatch( FB_TK_ERR ) ) then

		funcexpr = rtlErrorGetNum

		function = TRUE
	end if

end function

'':::::
''cIIFFunct =   IIF '(' condexpr ',' truexpr ',' falsexpr ')' .
''
function cIIFFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr condexpr, truexpr, falsexpr

	function = FALSE

	'' IIF
	lexSkipToken

	'' '('
	hMatchLPRNT( )

	'' condexpr
	hMatchExpression( condexpr )

	'' ','
	hMatchCOMMA( )

	'' truexpr
	hMatchExpression( truexpr )

	'' ','
	hMatchCOMMA( )

	'' falsexpr
	hMatchExpression( falsexpr )

	'' ')'
	hMatchRPRNT( )

	''
	funcexpr = astNewIIF( condexpr, truexpr, falsexpr )

	if( funcexpr = NULL ) then
		hReportError FB_ERRMSG_INVALIDDATATYPES, TRUE
		exit function
	end if

	function = TRUE

end function

'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr arg, proc, sym

	function = FALSE

	proc = env.currproc

	if( proc = NULL ) then
		exit function
	end if

	if( proc->proc.mode <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	arg = symbGetProcTailArg( proc )
	arg = symbGetProcNextArg( proc, arg )
	if( arg = NULL ) then
		exit function
	end if

	sym = symbFindByNameAndClass( arg->alias, FB_SYMBCLASS_VAR )
	if( sym = NULL ) then
		exit function
	end if

	'' VA_FIRST
	lexSkipToken

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		hMatchRPRNT( )
	end if

	'' @arg
	expr = astNewVAR( sym, NULL, 0, symbGetType( sym ), NULL )
	expr = astNewADDR( IR_OP_ADDROF, expr, sym )

	'' + arglen( arg )
	funcexpr = astNewBOP( IR_OP_ADD, _
						  expr, _
						  astNewCONSTi( symbCalcArgLen( arg->typ, arg->subtype, arg->arg.mode ), _
						  				IR_DATATYPE_UINT ) )



	function = TRUE

end function

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr( byref tconvexpr as ASTNODE ptr ) as integer
    dim totype as integer, op as integer

	function = FALSE

	totype = INVALID
	op = INVALID

	select case as const lexGetToken( )
	case FB_TK_CBYTE
		totype = IR_DATATYPE_BYTE
	case FB_TK_CSHORT
		totype = IR_DATATYPE_SHORT
	case FB_TK_CINT, FB_TK_CLNG
		totype = IR_DATATYPE_INTEGER
	case FB_TK_CLNGINT
		totype = IR_DATATYPE_LONGINT

	case FB_TK_CUBYTE
		totype = IR_DATATYPE_UBYTE
	case FB_TK_CUSHORT
		totype = IR_DATATYPE_USHORT
	case FB_TK_CUINT
		totype = IR_DATATYPE_UINT
	case FB_TK_CULNGINT
		totype = IR_DATATYPE_ULONGINT

	case FB_TK_CSNG
		totype = IR_DATATYPE_SINGLE
	case FB_TK_CDBL
		totype = IR_DATATYPE_DOUBLE

	case FB_TK_CSIGN
		totype = IR_DATATYPE_VOID				'' hack! AST will handle that
		op = IR_OP_TOSIGNED
	case FB_TK_CUNSG
		totype = IR_DATATYPE_VOID				'' hack! /
		op = IR_OP_TOUNSIGNED
	end select

	if( totype = INVALID ) then
		exit function
	else
		lexSkipToken( )
	end if

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
		exit function
	end if

	if( not cExpression( tconvexpr ) ) then
		exit function
	end if

	tconvexpr = astNewCONV( op, totype, NULL, tconvexpr )

    if( tconvexpr = NULL ) Then
    	hReportError( FB_ERRMSG_TYPEMISMATCH, TRUE )
    	exit function
    end if

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
		exit function
	end if

	function = TRUE

end function

'':::::
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction( byref funcexpr as ASTNODE ptr ) as integer
	dim as integer res

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
		exit function
	end if

	res = FALSE

	select case as const lexGetToken( )
	case FB_TK_STR, FB_TK_MID, FB_TK_STRING, FB_TK_CHR, FB_TK_ASC, FB_TK_INSTR, FB_TK_TRIM, FB_TK_RTRIM, FB_TK_LTRIM
		res = cStringFunct( funcexpr )

	case FB_TK_ABS, FB_TK_SGN, FB_TK_FIX, FB_TK_LEN, FB_TK_SIZEOF, _
		 FB_TK_SIN, FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, FB_TK_ATN, _
		 FB_TK_SQR, FB_TK_LOG, FB_TK_ATAN2, FB_TK_INT
		res = cMathFunct( funcexpr )

	case FB_TK_PEEK
		res = cPeekFunct( funcexpr )

	case FB_TK_LBOUND, FB_TK_UBOUND
		res = cArrayFunct( funcexpr )

	case FB_TK_SEEK, FB_TK_INPUT, FB_TK_OPEN, FB_TK_CLOSE, FB_TK_GET, FB_TK_PUT, FB_TK_NAME
		res = cFileFunct( funcexpr )

	case FB_TK_ERR
		res = cErrorFunct( funcexpr )

	case FB_TK_IIF
		res = cIIFFunct( funcexpr )

	case FB_TK_VA_FIRST
		res = cVAFunct( funcexpr )

	case FB_TK_CBYTE, FB_TK_CSHORT, FB_TK_CINT, FB_TK_CLNG, FB_TK_CLNGINT, _
		 FB_TK_CUBYTE, FB_TK_CUSHORT, FB_TK_CUINT, FB_TK_CULNGINT, _
		 FB_TK_CSNG, FB_TK_CDBL, _
         FB_TK_CSIGN, FB_TK_CUNSG
		res = cTypeConvExpr( funcexpr )

	case FB_TK_VIEW
		res = cViewStmt( TRUE, funcexpr )

    case FB_TK_WIDTH
        funcexpr = cWidth( TRUE )
        res = funcexpr <> NULL

	end select

	if( not res ) then
		if( hGetLastError( ) = FB_ERRMSG_OK ) then
			res = cGfxFunct( funcexpr )
		end if
	end if

	function = res

end function
