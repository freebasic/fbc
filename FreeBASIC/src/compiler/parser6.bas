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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'

declare function cThreadCreate		( funcexpr as integer, byval isfunc as integer ) as integer

'':::::
function cFuncReturn( byval checkexpr as integer = TRUE ) as integer
    dim expr as integer

    cFuncReturn = FALSE

	if( (env.currproc = NULL) or (env.procstmt.endlabel = NULL) ) then
		hReportError FB.ERRMSG.ILLEGALOUTSIDEASUB
		exit function
	end if

	if( checkexpr ) then
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hAssignFunctResult( env.currproc, expr ) ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	astFlush( astNewBRANCH( IR.OP.JMP, env.procstmt.endlabel ) )

	cFuncReturn = TRUE

end function

'':::::
''GotoStmt   	  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |	  RETURN LABEL?
''				  |   RESUME NEXT? .
''
function cGotoStmt
	dim l as FBSYMBOL ptr
	dim isglobal as integer, isnext as integer

	cGotoStmt = FALSE

	select case as const lexCurrentToken
	'' GOTO LABEL
	case FB.TK.GOTO
		lexSkipToken

		if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
			l = symbFindByNameAndClass( lexTokenText, FB.SYMBCLASS.LABEL )
		else
			l = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexTokenText, FALSE, TRUE )
		end if
		lexSkipToken

		astFlush( astNewBRANCH( IR.OP.JMP, l ) )

		cGotoStmt = TRUE

	'' GOSUB LABEL
	case FB.TK.GOSUB
		lexSkipToken

		if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
			l = symbFindByNameAndClass( lexTokenText, FB.SYMBCLASS.LABEL )
		else
			l = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexTokenText, FALSE, TRUE )
		end if
		lexSkipToken

		astFlush( astNewBRANCH( IR.OP.CALL, l ) )

		cGotoStmt = TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB.TK.RETURN
		lexSkipToken

		'' Comment|StmtSep|EOF? just return
		select case lexCurrentToken
		case FB.TK.EOL, FB.TK.STATSEPCHAR, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM

			'' try to guess here.. if inside a proc currently and no user label was
			'' emited, it's probably a FUNCTION return, no a GOSUB return
			l = NULL
			if( env.scope > 0 ) then
				l = symbGetLastLabel
				if( l <> NULL ) then
					if( l->scope <> env.scope ) then
						l = NULL
					end if
				end if
			end if

			if( (env.scope = 0) or (l <> NULL) ) then
				''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
				irEmitRETURN 0
			else
				cGotoStmt = cFuncReturn( FALSE )
			end if

		case else

			l = NULL

			'' Comment|StmtSep|EOF following? check if it's not an already defined label
			select case lexLookAhead( 1 )
			case FB.TK.EOL, FB.TK.STATSEPCHAR, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
				if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
					l = symbFindByNameAndClass( lexTokenText, FB.SYMBCLASS.LABEL )
				else
					l = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
				end if
			end select

			'' label?
			if( l <> NULL ) then
				lexSkipToken
				astFlush( astNewBRANCH( IR.OP.JMP, l ) )
				cGotoStmt = TRUE

			'' must be a function return then
			else
				cGotoStmt = cFuncReturn( )
			end if

		end select


	'' RESUME NEXT?
	case FB.TK.RESUME

		if( not env.clopt.resumeerr ) then
			hReportError FB.ERRMSG.ILLEGALRESUMEERROR
			exit function
		end if

		lexSkipToken

		if( hMatch( FB.TK.NEXT ) ) then
			isnext = TRUE
		else
			isnext = FALSE
		end if

		rtlErrorResume isnext

		cGotoStmt = TRUE
	end select

end function

'':::::
''ArrayStmt   	  =   ERASE ID (',' ID)*;
''				  |   SWAP Variable, Variable .
''
function cArrayStmt
	dim s as FBSYMBOL ptr
	dim expr1 as integer, expr2 as integer

	cArrayStmt = FALSE

	select case lexCurrentToken
	case FB.TK.ERASE
		lexSkipToken

		do
			if( not cVarOrDeref( expr1, FALSE ) ) then
				hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
				exit function
			end if

			'' array?
    		s = astGetSymbol( expr1 )
    		if( not symbIsArray( s ) ) then
				hReportError FB.ERRMSG.EXPECTEDARRAY
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

		cArrayStmt = TRUE

	'' SWAP Variable, Variable
	case FB.TK.SWAP
		lexSkipToken

		if( not cVarOrDeref( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cVarOrDeref( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		select case astGetDataType( expr1 )
		case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR, IR.DATATYPE.CHAR
			cArrayStmt = rtlStrSwap( expr1, expr2 )
		case else
			cArrayStmt = rtlMemSwap( expr1, expr2 )
		end select

	end select

end function

'':::::
''MidStmt   	  =   MID '(' Expression{str}, Expression{int} (',' Expression{int}) ')' '=' Expression{str} .
''
function cMidStmt
	dim expr1 as integer, expr2 as integer, expr3 as integer, expr4 as integer

	cMidStmt = FALSE

	if( hMatch( FB.TK.MID ) ) then

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cExpression( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( hMatch( CHAR_COMMA ) ) then
			if( not cExpression( expr3 ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			expr3 = astNewCONSTi( -1, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		if( not hMatch( FB.TK.ASSIGN ) ) then
			hReportError FB.ERRMSG.EXPECTEDEQ
			exit function
		end if

		if( not cExpression( expr4 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		cMidStmt = rtlStrAssignMid( expr1, expr2, expr3, expr4 ) <> INVALID
	end if

end function

'':::::
'' LsetStmt		=	LSET String|UDT ',' String|UDT
function cLSetStmt( ) as integer
    dim as integer dstexpr, srcexpr
    dim as integer dtype1, dtype2
    dim as FBSYMBOL ptr dst, src

    cLSetStmt = FALSE

	'' LSET
	lexSkipToken

	'' Expression
	if( not cVarOrDeref( dstexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	dtype1 = astGetDataType( dstexpr )
	select case dtype1
	case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR, IR.DATATYPE.CHAR, IR.DATATYPE.USERDEF
	case else
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end select

	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	'' Expression
	if( not cVarOrDeref( srcexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	dtype2 = astGetDataType( srcexpr )
	select case dtype2
	case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR, IR.DATATYPE.CHAR, IR.DATATYPE.USERDEF
	case else
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end select

	if( (dtype1 = IR.DATATYPE.USERDEF) or (dtype2 = IR.DATATYPE.USERDEF) ) then

		if( dtype1 <> dtype2 ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		dst = astGetSymbol( dstexpr )
		src = astGetSymbol( srcexpr )
		if( (dst = NULL) or (src = NULL) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		cLSetStmt = rtlMemCopyClear( dstexpr, symbGetUDTLen( dst->subtype ), _
									 srcexpr, symbGetUDTLen( src->subtype ) )
	else
		cLSetStmt = rtlStrLset( dstexpr, srcexpr )
	end if

end function

'':::::
''DataStmt   	  =   RESTORE LABEL?
''				  |   READ Variable{int|flt|str} (',' Variable{int|flt|str})*
''				  |   DATA literal|constant (',' literal|constant)*
''
function cDataStmt
	dim expr as integer, typ as integer
	dim s as FBSYMBOL ptr
	dim littext as string, litlen as integer

	cDataStmt = FALSE

	select case lexCurrentToken
	'' RESTORE LABEL?
	case FB.TK.RESTORE
		lexSkipToken

		'' LABEL?
		s = NULL
		if( not hIsSttSeparatorOrComment( lexCurrentToken ) ) then
			s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
			if( s = NULL ) then
				s = symbAddLabel( lexTokenText, FALSE, TRUE )
			end if
			lexSkipToken
		end if

		cDataStmt = rtlDataRestore( s )

	'' READ Variable{int|flt|str} (',' Variable{int|flt|str})*
	case FB.TK.READ
		lexSkipToken

		do
		    if( not cVarOrDeref( expr ) ) then
		    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		    	exit function
		    end if

            if( not rtlDataRead( expr ) ) then
            	exit function
            end if

			if( not hMatch( CHAR_COMMA ) ) then
				exit do
			end if
		loop

		cDataStmt = TRUE

	'' DATA literal|constant expr (',' literal|constant expr)*
	case FB.TK.DATA

		'' not allowed inside procs
		if( env.scope > 0 ) then
			hReportError FB.ERRMSG.ILLEGALINSIDEASUB
			exit function
		end if

		lexSkipToken

		rtlDataStoreBegin

		do
			littext = ""
			typ = INVALID

			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			    exit function
			end if

			'' check if it's an string
			s = NULL
			if( astGetDataType( expr ) = IR.DATATYPE.FIXSTR ) then
				if( astIsVAR( expr ) ) then
					s = astGetSymbol( expr )
					if( not symbGetVarInitialized( s ) ) then
						s = NULL
					end if
				end if
			end if

			'' string?
			if( s <> NULL ) then
				astDel expr

                typ = FB.SYMBTYPE.FIXSTR
				litlen  = symbGetLen( s ) - 1 				'' less the null-char
				littext = symbGetVarText( s )

				if( symbGetAccessCnt( s ) = 0 ) then
					symbDelVar s
				end if

			else

				if( astIsOFFSET( expr ) ) then
					littext = symbGetName( astGetSymbol( expr ) )

				else

					if( not astIsCONST( expr ) ) then
						hReportError FB.ERRMSG.EXPECTEDCONST
						exit function
					end if

  					select case as const astGetDataType( expr )
  					case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
  						littext = str$( astGetValue64( expr ) )
  					case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
  						littext = str$( astGetValueF( expr ) )
  					case else
  						littext = str$( astGetValueI( expr ) )
  					end select

  					litlen = len( littext )

  				end if
  				typ = IR.DATATYPE.FIXSTR

  				astDel expr
		    end if

            if( not rtlDataStore( littext, litlen, typ ) ) then
            	exit function
            end if

			if( not hMatch( CHAR_COMMA ) ) then
				exit do
			end if
		loop

		rtlDataStoreEnd

		cDataStmt = TRUE

	end select

end function

'':::::
'' PrintStmt	  =   (PRINT|'?') ('#' Expression ',')? (USING Expression{str} ';')? (Expression? ';'|"," )*
''
function cPrintStmt
    dim usingexpr as integer, filexpr as integer, filexprcopy as integer, expr as integer
    dim issemicolon as integer, iscomma as integer, istab as integer, isspc as integer
    dim expressions as integer

	cPrintStmt = FALSE

	'' (PRINT|'?')
	if( not hMatch( FB.TK.PRINT ) ) then
		if( not hMatch( CHAR_QUESTION ) ) then
			exit function
		end if
	end if

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
		if( not cExpression( filexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

    else
    	filexpr = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
	end if

	'' (USING Expression{str} ';')?
	usingexpr = INVALID
	if( hMatch( FB.TK.USING ) ) then
		if( not cExpression( usingexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_SEMICOLON ) ) then
			hReportError FB.ERRMSG.EXPECTEDSEMICOLON
			exit function
		end if

		if( not rtlPrintUsingInit( usingexpr ) ) then
			exit function
		end if
    end if

    '' (Expression?|SPC(Expression)|TAB(Expression) ';'|"," )*
    expressions = 0
    do
        '' (Expression?|SPC(Expression)|TAB(Expression)
        isspc = FALSE
        istab = FALSE
        if( hMatch( FB.TK.SPC ) ) then
        	isspc = TRUE
			if( not hMatch( CHAR_LPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDLPRNT
				exit function
			end if

			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			if( not hMatch( CHAR_RPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDRPRNT
				exit function
			end if

        elseif( hMatch( FB.TK.TAB ) ) then
            istab = TRUE
			if( not hMatch( CHAR_LPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDLPRNT
				exit function
			end if

			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			if( not hMatch( CHAR_RPRNT ) ) then
				hReportError FB.ERRMSG.EXPECTEDRPRNT
				exit function
			end if

        elseif( not cExpression( expr ) ) then
        	expr = INVALID
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
    	if( (not iscomma) and (not issemicolon) and (expr = INVALID) ) then
    		if( usingexpr = INVALID ) then
    			if( expressions = 0 ) then
    				if( not rtlPrint( filexprcopy, FALSE, FALSE, INVALID ) ) then
						exit function
					end if
    			end if
    		else
    			if( not rtlPrintUsingEnd( filexprcopy ) ) then
					exit function
				end if
    		end if

    		exit do
    	end if

    	if( usingexpr = INVALID ) then
    		if( isspc ) then
    			if( not rtlPrintSPC( filexprcopy, expr ) ) then
					exit function
				end if
    		elseif( istab ) then
    			if( not rtlPrintTab( filexprcopy, expr ) ) then
					exit function
				end if
    		else
    			if( not rtlPrint( filexprcopy, iscomma, issemicolon, expr ) ) then
					hReportError FB.ERRMSG.INVALIDDATATYPES
					exit function
				end if
    		end if

    	else
    		if( not rtlPrintUsing( filexprcopy, expr, issemicolon ) ) then
    			hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
    	end if

    	expressions += 1
    loop while( iscomma or issemicolon )

    ''
    astDelTree filexpr

    cPrintStmt = TRUE

end function

'':::::
'' WriteStmt	  =   WRITE ('#' Expression)? (Expression? "," )*
''
function cWriteStmt
    dim filexpr as integer, filexprcopy as integer, expr as integer
    dim expressions as integer, iscomma as integer

	cWriteStmt = FALSE

	'' WRITE
	if( not hMatch( FB.TK.WRITE ) ) then
		exit function
	end if

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
		if( not cExpression( filexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

    else
    	filexpr = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
	end if

    '' (Expression? "," )*
    expressions = 0
    do
		if( not cExpression( expr ) ) then
        	expr = INVALID
        end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle WRITE w/o expressions
    	if( (not iscomma) and (expr = INVALID) ) then
    		if( expressions = 0 ) then
    			rtlWrite( filexprcopy, FALSE, INVALID )
    		end if

    		exit do
    	end if

    	if( not rtlWrite( filexprcopy, iscomma, expr ) ) then
    		hReportError FB.ERRMSG.INVALIDDATATYPES
    		exit function
    	end if

    	expressions += 1
    loop while( iscomma )

    ''
    astDelTree filexpr

    cWriteStmt = TRUE

end function

'':::::
'' LineInputStmt	  =   LINE INPUT ';'? ('#' Expression| Expression{str}?) (','|';')? Variable? .
''
function cLineInputStmt
    dim expr as integer, dstexpr as integer
    dim isfile as integer, addnewline as integer, issep as integer

	cLineInputStmt = FALSE

	'' LINE
	if( lexCurrentToken <> FB.TK.LINE ) then
		exit function
	end if

	'' INPUT
	if( lexLookahead(1) <> FB.TK.INPUT ) then
		exit function
	end if

	lexSkipToken
	lexSkipToken

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
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		expr = INVALID
	end if

	'' ','|';'?
	issep = TRUE
	if( not hMatch( CHAR_COMMA ) ) then
		if( not hMatch( CHAR_SEMICOLON ) ) then
			issep = FALSE
			if( (expr = INVALID) or (isfile) ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit function
			end if
		end if
	end if

    '' Variable?
	if( not cVarOrDeref( dstexpr ) ) then
       	if( (expr = INVALID) or (isfile) ) then
       		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
       		exit function
       	end if
       	dstexpr = expr
       	expr = INVALID
    else
    	if( issep = FALSE ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
    	end if
    end if

    cLineInputStmt = rtlFileLineInput( isfile, expr, dstexpr, FALSE, addnewline )

end function

'':::::
'' InputStmt	  =   INPUT ';'? (('#' Expression| STRING_LIT) (','|';'))? Variable (',' Variable)*
''
function cInputStmt
    dim filestrexpr as integer, dstexpr as integer
    dim iscomma as integer, isfile as integer, addnewline as integer, addquestion as integer
    dim lgt as integer

	cInputStmt = FALSE

	'' INPUT
	if( not hMatch( FB.TK.INPUT ) ) then
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
		if( not cExpression( filestrexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

    else
    	isfile = FALSE
    	'' STRING_LIT?
    	if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
			lgt = lexTokenTextLen
			filestrexpr = astNewVAR( hAllocStringConst( lexEatToken, lgt ), NULL, 0, IR.DATATYPE.FIXSTR )
    	else
    		filestrexpr = INVALID
    	end if
	end if

	'' ','|';'
	addquestion = FALSE
	if( (isfile) or (filestrexpr <> INVALID) ) then
		if( not hMatch( CHAR_COMMA ) ) then
			if( not hMatch( CHAR_SEMICOLON ) ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
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
       		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
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

    cInputStmt = TRUE

end function

'':::::
'' ViewStmt	  =   VIEW (PRINT (Expression TO Expression)?) .
''
function cViewStmt
    dim expr1 as integer, expr2 as integer

	cViewStmt = FALSE

	'' VIEW
	if( lexCurrentToken <> FB.TK.VIEW ) then
		exit function
	end if

	'' PRINT
	if( lexLookAhead(1) <> FB.TK.PRINT ) then
		exit function
	end if

	lexSkipToken
	lexSkipToken

	'' (Expression TO Expression)?
	if( cExpression( expr1 ) ) then
		if( not hMatch( FB.TK.TO ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		if( not cExpression( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

	else
		expr1 = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
		expr2 = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
	end if

    cViewStmt = rtlConsoleView( expr1, expr2 )

end function

'':::::
''PokeStmt =   POKE Expression, Expression .
''
function cPokeStmt
	dim expr1 as integer, expr2 as integer
	dim poketype as integer, subtype as FBSYMBOL ptr, lgt as integer, ptrcnt as integer

	cPokeStmt = FALSE

	'' POKE
	lexSkipToken

	'' (SymbolType ',')?
	if( cSymbolType( poketype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case poketype
		case FB.SYMBTYPE.VOID, FB.SYMBTYPE.FIXSTR
			hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
			exit function
		end select

		'' ','
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

	else
		poketype = IR.DATATYPE.BYTE
		subtype  = NULL
	end if

	'' Expression, Expression
	if( not cExpression( expr1 ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if
	if( not cExpression( expr2 ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

    select case astGetDataClass( expr1 )
    case IR.DATACLASS.STRING
    	hReportError FB.ERRMSG.INVALIDDATATYPES
        exit function
	case IR.DATACLASS.FPOINT
    	expr1 = astNewCONV( INVALID, IR.DATATYPE.UINT, expr1 )
	case else
        if( astGetDataSize( expr1 ) <> FB.POINTERSIZE ) then
        	hReportError FB.ERRMSG.INVALIDDATATYPES
        	exit function
        end if
	end select

    expr1 = astNewPTR( NULL, NULL, 0, expr1, poketype, subtype )

    expr1 = astNewASSIGN( expr1, expr2 )

	astFlush( expr1 )

    cPokeStmt = TRUE

end function

'':::::
private function hFileClose( byval isfunc as integer ) as integer
	dim as integer cnt, filenum, proc

	hFileClose = INVALID

	'' CLOSE
	lexSkipToken

	if( isfunc ) then
		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
	end if

	cnt = 0
	do
		hMatch( CHAR_SHARP )

    	if( not cExpression( filenum ) ) then
			if( cnt = 0 ) then
				filenum = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
			else
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if

		proc = rtlFileClose( filenum, isfunc )
		if( proc = INVALID ) then
			exit function
		end if

		if( isfunc ) then
			exit do
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	if( isfunc ) then
		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	hFileClose = proc

end function

'':::::
private function hFilePut( byval isfunc as integer ) as integer
	dim as integer filenum, expr1, expr2, isarray
	dim as FBSYMBOL ptr s

	hFilePut = INVALID

	'' '#'?
	if( lexCurrentToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	if( not cExpression( filenum ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( expr1 ) ) then
		expr1 = INVALID
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( expr2 ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

    isarray = FALSE
    if( lexCurrentToken = CHAR_LPRNT ) then
    	if( lexLookahead(1) = CHAR_RPRNT ) then
    		s = astGetSymbol( expr2 )
    		isarray = symbIsArray( s )
    		if( isarray ) then
    			lexSkipToken
    			lexSkipToken
    		end if
    	end if
    end if

	if( not isarray ) then
		hFilePut = rtlFilePut( filenum, expr1, expr2, isfunc )
	else
		hFilePut = rtlFilePutArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileGet( byval isfunc as integer ) as integer
	dim as integer filenum, expr1, expr2, isarray
	dim as FBSYMBOL ptr s

	hFileGet = INVALID

	'' '#'?
	if( lexCurrentToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	if( not cExpression( filenum ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( expr1 ) ) then
		expr1 = INVALID
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cVarOrDeref( expr2 ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

    isarray = FALSE
    if( lexCurrentToken = CHAR_LPRNT ) then
    	if( lexLookahead(1) = CHAR_RPRNT ) then
    		s = astGetSymbol( expr2 )
    		isarray = symbIsArray( s )
    		if( isarray ) then
    			lexSkipToken
    			lexSkipToken
    		end if
    	end if
    end if

	if( not isarray ) then
		hFileGet = rtlFileGet( filenum, expr1, expr2, isfunc )
	else
		hFileGet = rtlFileGetArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileOpen( byval isfunc as integer ) as integer
	dim as integer filenum
	dim as integer filename, fmode, faccess, flock, flen

	hFileOpen = INVALID

	if( isfunc ) then
		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
	end if

	if( not cExpression( filename ) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))?
	if( hMatch( FB.TK.FOR ) ) then
		select case lexCurrentToken
		case FB.TK.INPUT
			fmode = FB.FILE.MODE.INPUT
		case FB.TK.OUTPUT
			fmode = FB.FILE.MODE.OUTPUT
		case FB.TK.BINARY
			fmode = FB.FILE.MODE.BINARY
		case FB.TK.RANDOM
			fmode = FB.FILE.MODE.RANDOM
		case FB.TK.APPEND
			fmode = FB.FILE.MODE.APPEND
		case else
			exit function
		end select
		lexSkipToken

	else
		fmode = FB.FILE.MODE.RANDOM
	end if

	fmode = astNewCONSTi( fmode, IR.DATATYPE.INTEGER )

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (ACCESS (READ|WRITE|READ WRITE))?
	if( hMatch( FB.TK.ACCESS ) ) then
		select case lexCurrentToken
		case FB.TK.WRITE
			lexSkipToken
			faccess = astNewCONSTi( FB.FILE.ACCESS.WRITE, IR.DATATYPE.INTEGER )
		case FB.TK.READ
			lexSkipToken
			if( hMatch( FB.TK.WRITE ) ) then
				faccess = astNewCONSTi( FB.FILE.ACCESS.READWRITE, IR.DATATYPE.INTEGER )
			else
				faccess = astNewCONSTi( FB.FILE.ACCESS.READ, IR.DATATYPE.INTEGER )
			end if
		end select
	else
		faccess = astNewCONSTi( FB.FILE.ACCESS.ANY, IR.DATATYPE.INTEGER )
	end if

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (SHARED|LOCK (READ|WRITE|READ WRITE))?
	if( hMatch( FB.TK.SHARED ) ) then
		flock = astNewCONSTi( FB.FILE.LOCK.SHARED, IR.DATATYPE.INTEGER )
	elseif( hMatch( FB.TK.LOCK ) ) then
		select case lexCurrentToken
		case FB.TK.WRITE
			lexSkipToken
			flock = astNewCONSTi( FB.FILE.LOCK.WRITE, IR.DATATYPE.INTEGER )
		case FB.TK.READ
			lexSkipToken
			if( hMatch( FB.TK.WRITE ) ) then
				flock = astNewCONSTi( FB.FILE.LOCK.READWRITE, IR.DATATYPE.INTEGER )
			else
				flock = astNewCONSTi( FB.FILE.LOCK.READ, IR.DATATYPE.INTEGER )
			end if
		end select
	else
		flock = astNewCONSTi( FB.FILE.LOCK.SHARED, IR.DATATYPE.INTEGER )
	end if

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' AS '#'? Expression
	if( not hMatch( FB.TK.AS ) ) then
		hReportError FB.ERRMSG.EXPECTINGAS
		exit function
	end if

	hMatch( CHAR_SHARP )

	if( not cExpression( filenum ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( isfunc ) then
		'' ','?
		hMatch( CHAR_COMMA )
	end if

	'' (LEN '=' Expression)?
	if( hMatch( FB.TK.LEN ) ) then
		if( not hMatch( FB.TK.ASSIGN ) ) then
			hReportError FB.ERRMSG.EXPECTEDEQ
			exit function
		end if
		if( not cExpression( flen ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	else
		flen = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
	end if

	if( isfunc ) then
		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	''
	hFileOpen = rtlFileOpen( filename, fmode, faccess, flock, filenum, flen, isfunc )

end function


'':::::
'' FileStmt		  =	   OPEN Expression{str} (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))? (ACCESS Expression)?
''					   (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
''				  |	   CLOSE ('#'? Expression)*
''				  |	   SEEK '#'? Expression ',' Expression
''				  |	   PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
''				  |	   GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
''				  |    (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)? .
function cFileStmt
    dim filenum as integer, expr1 as integer, expr2 as integer
    dim res as integer, islock as integer

	cFileStmt = FALSE

	select case as const lexCurrentToken
	'' OPEN Expression{str} (FOR Expression)? (ACCESS Expression)?
	'' (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
	case FB.TK.OPEN
		lexSkipToken

		cFileStmt = (hFileOpen( FALSE ) <> INVALID)


	'' CLOSE ('#'? Expression)*
	case FB.TK.CLOSE

		cFileStmt = (hFileClose( FALSE ) <> INVALID)

	'' SEEK '#'? Expression ',' Expression
	case FB.TK.SEEK
		lexSkipToken
		res = hMatch( CHAR_SHARP )

		if( not cExpression( filenum ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		cFileStmt = rtlFileSeek( filenum, expr1 )

	'' PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
	case FB.TK.PUT
		if( lexLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken

        cFileStmt = (hFilePut( FALSE ) <> INVALID)

	'' GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
	case FB.TK.GET
		if( lexLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken

		cFileStmt = (hFileGet( FALSE ) <> INVALID)

	'' (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)?
	case FB.TK.LOCK, FB.TK.UNLOCK
		if( lexCurrentToken = FB.TK.LOCK ) then
			islock = TRUE
		else
			islock = FALSE
		end if

		lexSkipToken
		res = hMatch( CHAR_SHARP )

		if( not cExpression( filenum ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( hMatch( FB.TK.TO ) ) then
			if( not cExpression( expr2 ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			expr2 = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
		end if

		cFileStmt = rtlFileLock( islock, filenum, expr1, expr2 )
	end select

end function

'':::::
private function hSelConstAllocTbSym( ) as FBSYMBOL ptr static
	dim dTB(0) as FBARRAYDIM

	hSelConstAllocTbSym = symbAddVarEx( hMakeTmpStr, "", FB.SYMBTYPE.UINT, NULL, 0, _
										FB.INTEGERSIZE, 1, dTB(), FB.ALLOCTYPE.SHARED, _
										FALSE, FALSE, FALSE )

end function

'':::::
function cGOTBStmt( byval expr as integer, byval isgoto as integer ) as integer
    dim idxexpr as integer
	dim sym as FBSYMBOL ptr
	dim exitlabel as FBSYMBOL ptr
	dim tbsym as FBSYMBOL ptr
	dim l as integer, i as integer
	dim labelTB(0 to FB.MAXGOTBITEMS-1) as FBSYMBOL ptr

	cGOTBStmt = FALSE

	'' convert to uinteger if needed
	if( astGetDataType( expr ) <> IR.DATATYPE.UINT ) then
		expr = astNewCONV( INVALID, IR.DATATYPE.UINT, expr )
	end if

	'' store expression into a temp var
	sym = symbAddTempVar( FB.SYMBTYPE.UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), expr )
	if( expr = INVALID ) then
		exit function
	end if
	astFlush( expr )

	'' read labels
	l = 0
	do
		if( (lexCurrentTokenClass <> FB.TKCLASS.NUMLITERAL) and _
			(lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		'' Label
		labelTB(l) = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
		if( labelTB(l) = NULL ) then
			labelTB(l) = symbAddLabel( lexTokenText, FALSE, TRUE )
		end if
		lexSkipToken

		l = l + 1
	loop while( hMatch( CHAR_COMMA ) )

	''
	exitlabel = symbAddLabel( hMakeTmpStr )

	'' < 1?
	expr = astNewBOP( IR.OP.LT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
					  astNewCONSTi( 1, IR.DATATYPE.UINT ), exitlabel, FALSE )
	astFlush( expr )

	'' > labels?
	expr = astNewBOP( IR.OP.GT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
					  astNewCONSTi( l, IR.DATATYPE.UINT ), exitlabel, FALSE )
	astFlush( expr )

    '' jump to table[idx]
    tbsym = hSelConstAllocTbSym( )

	idxexpr = astNewBOP( IR.OP.MUL, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
    				  			    astNewCONSTi( FB.INTEGERSIZE, IR.DATATYPE.UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, NULL, -1*FB.INTEGERSIZE, IR.DATATYPE.UINT ), idxexpr, _
    				  IR.DATATYPE.UINT, NULL )

    if( isgoto ) then
    	astFlush( astNewBRANCH( IR.OP.JUMPPTR, NULL, expr ) )
    else
    	astFlush( astNewBRANCH( IR.OP.CALLPTR, NULL, expr ) )
    end if

    '' emit table
    irEmitLABEL tbsym, FALSE

    ''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    irFlush

    ''
    for i = 0 to l-1
    	emitTYPE IR.DATATYPE.UINT, symbGetName( labelTB(i) )
    next

    '' the table is not needed anymore
    symbDelVar tbsym

    '' emit exit label
    irEmitLABEL exitlabel, FALSE

    cGOTBStmt = TRUE

end function

'':::::
''OnStmt 		=	ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
''
function cOnStmt
	dim as integer expr, isgoto, islocal, isrestore
	dim as FBSYMBOL ptr label

	cOnStmt = FALSE

	'' ON
	if( not hMatch( FB.TK.ON ) ) then
		exit function
	end if

	'' LOCAL?
	if( hMatch( FB.TK.LOCAL ) ) then
		if( env.scope = 0 ) then
			hReportError FB.ERRMSG.SYNTAXERROR, TRUE
			exit function
		end if
		islocal = TRUE
	else
		islocal = FALSE
	end if

	'' ERROR | Expression
	expr = INVALID
	select case lexCurrentToken
	case FB.TK.ERROR
		lexSkipToken
	case else
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	end select

	'' GOTO|GOSUB
	if( hMatch( FB.TK.GOTO ) ) then
		isgoto = TRUE
	elseif( hMatch( FB.TK.GOSUB ) ) then
	    '' can't do GOSUB with ON ERROR
	    if( expr = INVALID ) then
	    	hReportError FB.ERRMSG.SYNTAXERROR
	    	exit function
	    end if
	    isgoto = FALSE
	else
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

    '' on error?
	if( expr = INVALID ) then
		isrestore = FALSE
		'' ON ERROR GOTO 0?
		if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
			if( lexTokenText = "0" ) then
				lexSkipToken
				isrestore = TRUE
			end if
        end if

		if( not isrestore ) then
			'' Label
			label = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
			if( label = NULL ) then
				label = symbAddLabel( lexTokenText, FALSE, TRUE )
			end if
			lexSkipToken

			expr = astNewVAR( label, NULL, 0, IR.DATATYPE.UINT )
			expr = astNewADDR( IR.OP.ADDROF, expr, label )
			rtlErrorSetHandler expr, (islocal = TRUE)

		else
        	rtlErrorSetHandler astNewCONSTi( NULL, IR.DATATYPE.UINT ), (islocal = TRUE)
		end if

		cOnStmt = TRUE

	else
        cOnStmt = cGOTBStmt( expr, isgoto )
	end if

end function

'':::::
''ErrorStmt 	=	ERROR Expression
''				|   ERR '=' Expression .
''
function cErrorStmt
	dim expr as integer

	cErrorStmt = FALSE


	select case lexCurrentToken

	'' ERROR
	case FB.TK.ERROR
		lexSkipToken

		'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		rtlErrorThrow expr

		cErrorStmt = TRUE

	'' ERR '=' Expression
	case FB.TK.ERR
		lexSkipToken

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

		rtlErrorSetnum expr

		cErrorStmt = TRUE

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
function cQuirkStmt
	dim as integer res
	dim as integer funcexpr

	cQuirkStmt = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
		if( lexCurrentToken = CHAR_QUESTION ) then	'' PRINT as '?', can't be a keyword..
			cQuirkStmt = cPrintStmt
		end if
		exit function
	end if

	res = FALSE

	select case as const lexCurrentToken
	case FB.TK.GOTO, FB.TK.GOSUB, FB.TK.RETURN, FB.TK.RESUME
		res = cGotoStmt
	case FB.TK.PRINT
		res = cPrintStmt
	case FB.TK.RESTORE, FB.TK.READ, FB.TK.DATA
		res = cDataStmt
	case FB.TK.ERASE, FB.TK.SWAP
		res = cArrayStmt
	case FB.TK.LINE
		res = cLineInputStmt
	case FB.TK.INPUT
		res = cInputStmt
	case FB.TK.POKE
		res = cPokeStmt
	case FB.TK.OPEN, FB.TK.CLOSE, FB.TK.SEEK, FB.TK.PUT, FB.TK.GET, FB.TK.LOCK, FB.TK.UNLOCK
		res = cFileStmt
	case FB.TK.ON
		res = cOnStmt
	case FB.TK.WRITE
		res = cWriteStmt
	case FB.TK.ERROR, FB.TK.ERR
		res = cErrorStmt
	case FB.TK.VIEW
		res = cViewStmt
	case FB.TK.MID
		res = cMidStmt
	case FB.TK.LSET
		res = cLSetStmt
	case FB.TK.THREADCREATE
		if( cThreadCreate( funcexpr, FALSE ) ) then
			astFlush( funcexpr )
			return TRUE
		end if
	end select

	if( res = FALSE ) then
		if( hGetLastError = FB.ERRMSG.OK ) then
			res = cGfxStmt
		end if
	end if

	cQuirkStmt = res

end function


'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct( funcexpr as integer )
	dim as integer sexpr, islbound, expr
	dim as FBSYMBOL ptr s

	cArrayFunct = FALSE

	select case lexCurrentToken

	'' (LBOUND|UBOUND) '(' ID (',' Expression)? ')'
	case FB.TK.LBOUND, FB.TK.UBOUND
		if( lexCurrentToken = FB.TK.LBOUND ) then
			islbound = TRUE
		else
			islbound = FALSE
		end if
		lexSkipToken

		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDLPRNT
    		exit function
		end if

		'' ID
		if( not cVarOrDeref( sexpr, FALSE ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		'' array?
		s = astGetSymbol( sexpr )
		if( not symbIsArray( s ) ) then
			hReportError FB.ERRMSG.EXPECTEDARRAY, TRUE
			exit function
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			expr = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
    		exit function
		end if

		funcexpr = rtlArrayBound( sexpr, expr, islbound )

		cArrayFunct = funcexpr <> INVALID

	end select

end function

'':::::
private function cStrCHR( funcexpr as integer ) as integer
	dim as string s, o
	dim as integer v, i, cnt, isconst, exprtb(0 to 31), expr

	cStrCHR = FALSE

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	cnt = 0
	do
		if( not cExpression( exprtb(cnt) ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		cnt += 1
		if( cnt >= 32 ) then
			exit do
		end if
	loop while( hMatch( CHAR_COMMA ) )

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	'' constant? evaluate at compile-time
	isconst = TRUE
	for i = 0 to cnt-1
		if( not astIsCONST( exprtb(i) ) ) then
			isconst = FALSE
			exit for
		end if
	next i

	if( isconst ) then
		s = ""

		for i = 0 to cnt-1
  			expr = exprtb(i)
  			select case as const astGetDataType( expr )
  			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
  				v = astGetValue64( expr )
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				v = astGetValueF( expr )
			case else
				v = astGetValueI( expr )
			end select

			if( (v < CHAR_SPACE) or (v > 127) ) then
				s += "\27"
				o = oct$( v )
				s += chr$( len( o ) )
				s += o
			else
				s += chr$( v )
			end if

			astDel expr
		next i

		funcexpr = astNewVAR( hAllocStringConst( s, cnt ), NULL, 0, IR.DATATYPE.FIXSTR )

    else

		funcexpr = rtlStrChr( cnt, exprtb() )

	end if

	cStrCHR = funcexpr <> INVALID

end function

'':::::
private function cStrASC( funcexpr as integer ) as integer
    dim as integer expr1, posexpr, p
    dim as FBSYMBOL ptr sym

	cStrASC = FALSE

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( expr1 ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' (',' Expression)?
	if( hMatch( CHAR_COMMA ) ) then

		if( not cExpression( posexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	else
		posexpr = INVALID
	end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	'' constant? evaluate at compile-time
	if( astIsVAR( expr1 ) ) then
		if( astGetDataType( expr1 ) = IR.DATATYPE.FIXSTR ) then
			sym = astGetSymbol( expr1 )
			if( symbGetVarInitialized( sym ) ) then

				'' pos is an constant too?
				if( posexpr <> INVALID ) then
					if( astIsCONST( posexpr ) ) then

  						select case as const astGetDataType( posexpr )
  						case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
							p = astGetValue64( posexpr )
						case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
							p = astGetValueF( posexpr )
						case else
							p = astGetValueI( posexpr )
						end select

						if( p < 0 ) then
							p = 0
						end if
						astDel posexpr
					else
						p = -1
					end if
				else
					p = 1
				end if

				if( p >= 0 ) then
					funcexpr = astNewCONSTi( asc( symbGetVarText( sym ), p ), IR.DATATYPE.INTEGER )

					'' delete var if it was never accessed before
					if( symbGetAccessCnt( sym ) = 0 ) then
						symbDelVar sym
					end if

	    			astDel expr1
	    			expr1 = INVALID
	    		end if
	    	end if
	    end if
	end if

	if( expr1 <> INVALID ) then
		funcexpr = rtlStrAsc( expr1, posexpr )
	end if

	cStrASC = funcexpr <> INVALID

end function

'':::::
'' cStringFunct	=	STR$ '(' Expression{int|float|double} ')'
'' 				|   INSTR '(' ((Expression{int} ',' Expression ',' Expression)|
''							   (Expression{str} ',' Expression)) ')'
'' 				|   MID$ '(' Expression ',' Expression (',' Expression)? ')'
'' 				|   STRING$ '(' Expression ',' Expression{int|str} ')' .
''
function cStringFunct( funcexpr as integer )
    dim as integer expr1, expr2, expr3
    dim as integer dclass, dtype

	cStringFunct = FALSE

	select case lexCurrentToken
	'' STR$ '(' Expression{int|float|double} ')'
	case FB.TK.STR
		lexSkipToken
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlToStr( expr1 )

		cStringFunct = funcexpr <> INVALID

	'' INSTR '(' ((Expression{int} ',' Expression{str} ',' Expression{int})|
	''			  (Expression{str} ',' Expression{int})) ')'
	case FB.TK.INSTR
		lexSkipToken
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		dtype = astGetDataType( expr1 )
		dclass = irGetDataClass( dtype )
		'' (Expression{int} ',' Expression{str} ',' Expression{str})
		if( (dclass <> IR.DATACLASS.STRING) and (dtype <> IR.DATATYPE.CHAR) ) then
			if( not hMatch( CHAR_COMMA ) ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit function
			end if

			if( not cExpression( expr2 ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

		'' (Expression{str} ',' Expression{str})
		else
			expr2 = expr1
			expr1 = astNewCONSTi( 1, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cExpression( expr3 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlStrInstr( expr1, expr2, expr3 )

		cStringFunct = funcexpr <> INVALID

	'' MID$ '(' Expression ',' Expression (',' Expression)? ')'
	case FB.TK.MID
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cExpression( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( hMatch( CHAR_COMMA ) ) then
			if( not cExpression( expr3 ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			expr3 = astNewCONSTi( -1, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlStrMid( expr1, expr2, expr3 )

		cStringFunct = funcexpr <> INVALID


	'' STRING$ '(' Expression ',' Expression{int|str} ')'
	case FB.TK.STRING
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cExpression( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cExpression( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlStrFill( expr1, expr2 )

		cStringFunct = funcexpr <> INVALID

	'' CHR$ '(' Expression (',' Expression )* ')'
	case FB.TK.CHR
		lexSkipToken

		cStringFunct = cStrCHR( funcexpr )

	'' ASC '(' Expression (',' Expression)? ')'
	case FB.TK.ASC
		lexSkipToken

		cStringFunct = cStrASC( funcexpr )

	end select

end function

'':::::
'' cMathFunct	=	ABS( Expression )
'' 				|   SGN( Expression )
''				|   FIX( Expression )
''				|   INT( Expression )
''				|	LEN( data type | Expression ) .
''
function cMathFunct( funcexpr as integer )
    dim expr as integer, islen as integer
    dim typ as integer, subtype as FBSYMBOL ptr, lgt as integer, ptrcnt as integer
    dim sym as FBSYMBOL ptr

	cMathFunct = FALSE

	select case as const lexCurrentToken
	'' ABS( Expression )
	case FB.TK.ABS
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		'' hack! implemented as Unary OP for better speed on x86's
		funcexpr = astNewUOP( IR.OP.ABS, expr )
		if( funcexpr = INVALID ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		cMathFunct = TRUE

	'' SGN( Expression )
	case FB.TK.SGN
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		'' hack! implemented as Unary OP for better speed on x86's
		funcexpr = astNewUOP( IR.OP.SGN, expr )
		if( funcexpr = INVALID ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		cMathFunct = TRUE

	'' FIX( Expression )
	case FB.TK.FIX
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlMathFIX( expr )
		if( funcexpr = INVALID ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		cMathFunct = TRUE

	'' INT( Expression ) is implemented by libc's floor( )


	'' LEN|SIZEOF( data type | Expression{idx-less arrays too} )
	case FB.TK.LEN, FB.TK.SIZEOF
		islen = (lexCurrentToken = FB.TK.LEN)
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		expr = INVALID
		if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
			env.varcheckarray = FALSE
			if( not cExpression( expr ) ) then
				env.varcheckarray = TRUE
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
			env.varcheckarray = TRUE
		end if

		'' string expressions with SIZEOF() are not allowed
		if( expr <> INVALID ) then
			if( not islen ) then
				if( astGetDataClass( expr ) = IR.DATACLASS.STRING ) then
					if( (astGetSymbol( expr ) = NULL) or (astIsFUNCT( expr )) ) then
						hReportError FB.ERRMSG.EXPECTEDIDENTIFIER, TRUE
						exit function
					end if
				end if
			end if
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		if( expr <> INVALID ) then
			funcexpr = rtlMathLen( expr, islen )
		else
			funcexpr = astNewCONSTi( lgt, IR.DATATYPE.INTEGER )
		end if

		cMathFunct = TRUE

	end select

end function

'':::::
'' PeekFunct =   PEEK '(' (SymbolType ',')? Expression ')' .
''
function cPeekFunct( funcexpr as integer )
	dim expr as integer
	dim peektype as integer, subtype as FBSYMBOL ptr, lgt as integer, ptrcnt as integer

	cPeekFunct = FALSE

	'' PEEK
	lexSkipToken

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT, TRUE
		exit function
	end if

	'' (SymbolType ',')?
	if( cSymbolType( peektype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case peektype
		case FB.SYMBTYPE.VOID, FB.SYMBTYPE.FIXSTR
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end select

		'' ','
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

	else
		peektype = IR.DATATYPE.BYTE
		subtype = NULL
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

    ''
    select case astGetDataClass( expr )
    case IR.DATACLASS.STRING
    	hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	case IR.DATACLASS.FPOINT
		expr = astNewCONV( INVALID, IR.DATATYPE.UINT, expr )
	case else
		if( astGetDataSize( expr ) <> FB.POINTERSIZE ) then
        	hReportError FB.ERRMSG.INVALIDDATATYPES
        	exit function
		end if
	end select

    funcexpr = astNewPTR( NULL, NULL, 0, expr, peektype, subtype )

	'' hack! to handle loading to x86 regs DI and SI, as they don't have byte versions &%@#&
    if( peektype = IR.DATATYPE.BYTE ) then
    	funcexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, funcexpr )
	end if

    cPeekFunct = TRUE

end function

'':::::
'' FileFunct =   SEEK '(' Expression ')' |
''				 INPUT '(' Expr, (',' '#'? Expr)? ')'.
''
function cFileFunct( funcexpr as integer )
	dim filenum as integer, expr as integer
	dim res as integer

	cFileFunct = FALSE

	'' SEEK '(' Expression ')'
	select case as const lexCurrentToken
	case FB.TK.SEEK
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
		if( not cExpression( filenum ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlFileTell( filenum )

		cFileFunct = funcexpr <> INVALID

	'' INPUT '(' Expr (',' '#'? Expr)? ')'
	case FB.TK.INPUT
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( hMatch( CHAR_COMMA ) ) then
			res = hMatch( CHAR_SHARP )

			if( not cExpression( filenum ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			filenum = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlFileStrInput( expr, filenum )

		cFileFunct = funcexpr <> INVALID

	'' OPEN '(' ... ')'
	case FB.TK.OPEN
		lexSkipToken

		funcexpr = hFileOpen( TRUE )
		cFileFunct = funcexpr <> INVALID

	'' CLOSE '(' '#'? Expr? ')'
	case FB.TK.CLOSE

		funcexpr = hFileClose( TRUE )
		cFileFunct = funcexpr <> INVALID

	'' PUT '(' '#'? Expr, Expr?, Expr ')'
	case FB.TK.PUT
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		funcexpr = hFilePut( TRUE )
		cFileFunct = funcexpr <> INVALID

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

	'' GET '(' '#'? Expr, Expr?, Expr ')'
	case FB.TK.GET
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		funcexpr = hFileGet( TRUE )
		cFileFunct = funcexpr <> INVALID

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

	end select

end function

'':::::
''cErrorFunct =   ERR .
''
function cErrorFunct( funcexpr as integer )

	cErrorFunct = FALSE

	if( hMatch( FB.TK.ERR ) ) then

		funcexpr = rtlErrorGetNum

		cErrorFunct = TRUE
	end if

end function

'':::::
''cIIFFunct =   IIF '(' condexpr ',' truexpr ',' falsexpr ')' .
''
function cIIFFunct( funcexpr as integer )
	dim condexpr as integer, truexpr as integer, falsexpr as integer

	cIIFFunct = FALSE

	'' IIF
	lexSkipToken

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	'' condexpr
	if( not cExpression( condexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	'' truexpr
	if( not cExpression( truexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	'' falsexpr
	if( not cExpression( falsexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	''
	funcexpr = astNewIIF( condexpr, truexpr, falsexpr )

	if( funcexpr = INVALID ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
		exit function
	end if

	cIIFFunct = TRUE

end function

'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct( funcexpr as integer )
    dim expr as integer
    dim arg as FBSYMBOL ptr
    dim proc as FBSYMBOL ptr, sym as FBSYMBOL ptr

	cVAFunct = FALSE

	proc = env.currproc

	if( proc = NULL ) then
		exit function
	end if

	if( proc->proc.mode <> FB.FUNCMODE.CDECL ) then
		exit function
	end if

	arg = symbGetProcTailArg( proc )
	arg = symbGetProcNextArg( proc, arg )
	if( arg = NULL ) then
		exit function
	end if

	sym = symbFindByNameAndClass( arg->alias, FB.SYMBCLASS.VAR )
	if( sym = NULL ) then
		exit function
	end if

	'' VA_FIRST
	lexSkipToken

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	'' @arg
	expr = astNewVAR( sym, NULL, 0, symbGetType( sym ), NULL )
	expr = astNewADDR( IR.OP.ADDROF, expr, sym )

	'' + arglen( arg )
	funcexpr = astNewBOP( IR.OP.ADD, _
						  expr, _
						  astNewCONSTi( symbCalcArgLen( arg->typ, arg->subtype, arg->arg.mode ), _
						  				IR.DATATYPE.UINT ) )



	cVAFunct = TRUE

end function

'':::::
''cThreadCreate =   THREADCREATE '(' procexpr ( ',' paramexpr )? ')'
''
function cThreadCreate( funcexpr as integer, _
						byval isfunc as integer )
	dim procexpr as integer, paramexpr as integer

	cThreadCreate = FALSE

	'' THREADCREATE
	lexSkipToken

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		if( isfunc ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if
	end if

	'' procexpr
	if( not cExpression( procexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	paramexpr = INVALID
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( paramexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	end if

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		if( isfunc ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	funcexpr = rtlThreadCreate( procexpr, paramexpr )

	cThreadCreate = TRUE

end function

'':::::
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction( funcexpr as integer )
	dim res as integer

	cQuirkFunction = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
		exit function
	end if

	res = FALSE

	select case as const lexCurrentToken
	case FB.TK.STR, FB.TK.INSTR, FB.TK.MID, FB.TK.STRING, FB.TK.CHR, FB.TK.ASC
		res = cStringFunct( funcexpr )
	case FB.TK.ABS, FB.TK.SGN, FB.TK.FIX, FB.TK.LEN, FB.TK.SIZEOF
		res = cMathFunct( funcexpr )
	case FB.TK.PEEK
		res = cPeekFunct( funcexpr )
	case FB.TK.LBOUND, FB.TK.UBOUND
		res = cArrayFunct( funcexpr )
	case FB.TK.SEEK, FB.TK.INPUT, FB.TK.OPEN, FB.TK.CLOSE, FB.TK.GET, FB.TK.PUT
		res = cFileFunct( funcexpr )
	case FB.TK.ERR
		res = cErrorFunct( funcexpr )
	case FB.TK.IIF
		res = cIIFFunct( funcexpr )
	case FB.TK.VA_FIRST
		res = cVAFunct( funcexpr )
	case FB.TK.THREADCREATE
		res = cThreadCreate( funcexpr, TRUE )
	end select

	if( not res ) then
		if( hGetLastError = FB.ERRMSG.OK ) then
			res = cGfxFunct( funcexpr )
		end if
	end if

	cQuirkFunction = res

end function
