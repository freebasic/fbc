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

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

'':::::
''GotoStmt   	  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |	  RETURN LABEL? .
''
function cGotoStmt
	dim res as integer, l as integer, lname as string
	dim isglobal as integer

	res = FALSE

	select case lexCurrentToken
	''
	case FB.TK.GOTO
		lexSkipToken
		l = symbLookupLabel( lexTokenText )
		if( l = INVALID ) then
			l = symbAddLabelEx( lexTokenText, FALSE )
		end if
		lexSkipToken

		isglobal = symbGetLabelScope( l ) = 0
		irEmitBRANCH IR.OP.JMP, l, isglobal
		res = TRUE

	''
	case FB.TK.GOSUB
		lexSkipToken
		l = symbLookupLabel( lexTokenText )
		if( l = INVALID ) then
			l = symbAddLabelEx( lexTokenText, FALSE )
		end if
		lexSkipToken

		lname = symbGetLabelName( l )
		isglobal = symbGetLabelScope( l ) = 0
		irEmitCALL lname, 0, isglobal
		res = TRUE

	case FB.TK.RETURN
		lexSkipToken

		if( (lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL) or (lexCurrentToken = FB.TK.ID) ) then

			l = symbLookupLabel( lexTokenText )
			if( l = INVALID ) then
				l = symbAddLabelEx( lexTokenText, FALSE )
			end if
			lexSkipToken

			isglobal = symbGetLabelScope( l ) = 0
			irEmitBRANCH IR.OP.JMP, l, isglobal

		else
			irEmitRETURN 0
		end if

		res = TRUE
	end select

	cGotoStmt = res

end function

'':::::
''ArrayStmt   	  =   ERASE ID
''				  |   SWAP Variable, Variable .
''
function cArrayStmt
	dim s as integer, ofs as integer, typ as integer
	dim elm as integer, typesymbol as integer
	dim expr1 as integer, expr2 as integer

	cArrayStmt = FALSE

	select case lexCurrentToken
	case FB.TK.ERASE
		lexSkipToken

		typ = lexTokenType
		s = symbLookupVar( lexTokenText, typ, ofs, elm, typesymbol )
		if( s = INVALID ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		else
			lexSkipToken
		end if

		rtlArrayErase s

		cArrayStmt = TRUE

	'' SWAP Variable, Variable
	case FB.TK.SWAP
		lexSkipToken

		if( not cVariable( expr1 ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cVariable( expr2 ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

		select case astGetDataType( expr1 )
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING
			rtlStrSwap expr1, expr2
		case else
			rtlMemSwap expr1, expr2
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
			expr3 = astNewCONST( -1, IR.DATATYPE.INTEGER )
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

		rtlStrAssignMid expr1, expr2, expr3, expr4

		cMidStmt = TRUE
	end if

end function

'':::::
''DataStmt   	  =   RESTORE LABEL?
''				  |   READ Variable{int|flt|str} (',' Variable{int|flt|str})*
''				  |   DATA literal|constant (',' literal|constant)*
''
function cDataStmt
	dim expr as integer, typ as integer
	dim s as integer
	dim littext as string

	cDataStmt = FALSE

	select case lexCurrentToken
	'' RESTORE LABEL?
	case FB.TK.RESTORE
		lexSkipToken

		'' LABEL?
		s = INVALID
		if( not hIsSttSeparatorOrComment( lexCurrentToken ) ) then
			s = symbLookupLabel( lexTokenText )
			if( s = INVALID ) then
				s = symbAddLabelEx( lexTokenText, FALSE )
			end if
			lexSkipToken
		end if

		rtlDataRestore s
		cDataStmt = TRUE

	'' READ Variable{int|flt|str} (',' Variable{int|flt|str})*
	case FB.TK.READ
		lexSkipToken

		do
		    if( not cVariable( expr ) ) then
		    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		    	exit function
		    end if

            rtlDataRead expr

			if( not hMatch( CHAR_COMMA ) ) then
				exit do
			end if
		loop

		cDataStmt = TRUE

	'' DATA literal|constant expr (',' literal|constant expr)*
	case FB.TK.DATA
		lexSkipToken

		rtlDataStoreBegin

		do
			littext = ""
			typ = INVALID

  			if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
                typ = FB.SYMBTYPE.FIXSTR
				littext = lexTokenText
				lexSkipToken

			else
			    if( not cExpression( expr ) ) then
			    	hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			    	exit function
			    end if

				if( astGetType( expr ) <> AST.NODETYPE.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if

  				typ = IR.DATATYPE.FIXSTR
  				littext = ltrim$( str$( astGetValue( expr ) ) )
  				astDel expr
		    end if

            rtlDataStore littext, typ

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
    	filexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
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

		rtlPrintUsingInit usingexpr
    end if

    '' (Expression?|SPC(Expression)|TAB(Expression) ';'|"," )*
    expressions = 0
    do
        '' (Expression?|SPC(Expression)|TAB(Expression)
        isspc = FALSE
        istab = FALSE
        if( hMatch( FB.TK.SPC ) ) then
        	isspc = TRUE
			if( not hMatch( CHAR_LPRNT ) ) then exit function
			if( not cExpression( expr ) ) then exit function
			if( not hMatch( CHAR_RPRNT ) ) then exit function

        elseif( hMatch( FB.TK.TAB ) ) then
            istab = TRUE
			if( not hMatch( CHAR_LPRNT ) ) then exit function
			if( not cExpression( expr ) ) then exit function
			if( not hMatch( CHAR_RPRNT ) ) then exit function

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
    				rtlPrint filexprcopy, FALSE, FALSE, INVALID
    			end if
    		else
    			rtlPrintUsingEnd filexprcopy
    		end if

    		exit do
    	end if

    	if( usingexpr = INVALID ) then
    		if( isspc ) then
    			rtlPrintSPC filexprcopy, expr
    		elseif( istab ) then
    			rtlPrintTab filexprcopy, expr
    		else
    			rtlPrint filexprcopy, iscomma, issemicolon, expr
    		end if

    	else
    		rtlPrintUsing filexprcopy, expr, issemicolon
    	end if

    	expressions = expressions + 1
    loop

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
    	filexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )
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
    			rtlWrite filexprcopy, FALSE, INVALID
    		end if

    		exit do
    	end if

    	rtlWrite filexprcopy, iscomma, expr

    	expressions = expressions + 1
    loop

    ''
    astDelTree filexpr

    cWriteStmt = TRUE

end function

'':::::
'' LineInputStmt	  =   LINE INPUT ';'? ('#' Expression| Expression{str}) (','|';') Variable .
''
function cLineInputStmt
    dim expr as integer, dstexpr as integer
    dim isfile as integer, addnewline as integer, addquestion as integer

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

	'' ('#' Expression)?
	isfile = FALSE
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
	end if

	if( not cExpression( expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ','|';'
	if( not hMatch( CHAR_COMMA ) ) then
		if( not hMatch( CHAR_SEMICOLON ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
		addquestion = TRUE
	else
		addquestion = FALSE
	end if

    '' Variable
	if( not cVariable( dstexpr ) ) then
       	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
       	exit function
    end if

    rtlFileLineInput isfile, expr, dstexpr, addquestion, addnewline

    cLineInputStmt = TRUE

end function

'':::::
'' InputStmt	  =   INPUT ';'? ('#' Expression| Expression{str}) (','|';') Variable (',' Variable)*
''
function cInputStmt
    dim filestrexpr as integer, dstexpr as integer
    dim iscomma as integer, isfile as integer, addnewline as integer, addquestion as integer

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

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
        isfile = TRUE
    else
    	isfile = FALSE
	end if

	if( not cExpression( filestrexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ','|';'
	if( not hMatch( CHAR_COMMA ) ) then
		if( not hMatch( CHAR_SEMICOLON ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
		addquestion = TRUE
	else
		addquestion = FALSE
	end if

	rtlFileInput isfile, filestrexpr, addquestion, addnewline

    '' Variable (',' Variable)*
    do
		if( not cVariable( dstexpr ) ) then
       		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
       		exit function
    	end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	rtlFileInputGet dstexpr
    loop while( iscomma )

    cInputStmt = TRUE

end function

'':::::
'' ViewStmt	  =   VIEW (PRINT (Expression TO Expression)?)
''			  |   (SCREEN Expression...) .
''
function cViewStmt
    dim expr1 as integer, expr2 as integer

	cViewStmt = FALSE

	'' VIEW
	if( not hMatch( FB.TK.VIEW ) ) then
		exit function
	end if

	'' PRINT
	if( not hMatch( FB.TK.PRINT ) ) then
		exit function
	end if

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
		expr1 = astNewCONST( 0, IR.DATATYPE.INTEGER )
		expr2 = astNewCONST( 0, IR.DATATYPE.INTEGER )
	end if


    rtlConsoleView expr1, expr2

    cViewStmt = TRUE

end function

'':::::
''PokeStmt =   POKE Expression, Expression .
''
function cPokeStmt
	dim expr1 as integer, expr2 as integer
	dim poketype as integer
	dim vr as integer

	cPokeStmt = FALSE

	'' POKE Expression, Expression
	poketype = INVALID
	select case lexCurrentToken
	case FB.TK.POKE
		poketype = IR.DATATYPE.BYTE
	case FB.TK.POKES
		poketype = IR.DATATYPE.SHORT
	case FB.TK.POKEI
		poketype = IR.DATATYPE.INTEGER
	end select

	if( poketype <> INVALID ) then
		lexSkipToken

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

        astUpdNodeResult expr1
        select case astGetDataClass( expr1 )
        case IR.DATACLASS.STRING
        	hReportError FB.ERRMSG.INVALIDDATATYPES
        	exit function
        case IR.DATACLASS.FPOINT
        	expr1 = astNewCONV( INVALID, IR.DATATYPE.UINT, expr1 )
        case else
        	if( astGetDataSize( expr1 ) < FB.POINTERSIZE ) then
        		hReportError FB.ERRMSG.INVALIDDATATYPES
        		exit function
        	end if
        end select

        expr1 = astNewPTR( 0, poketype, expr1 )

        expr1 = astNewASSIGN( expr1, expr2 )

		astFlush expr1, vr

        cPokeStmt = TRUE

	end if

end function

'':::::
'' FileStmt		  =	   OPEN Expression{str} (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))? (ACCESS Expression)?
''					   (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
''				  |	   CLOSE '#'? Expression
''				  |	   SEEK '#'? Expression ',' Expression
''				  |	   PUT '#' Expression ',' Expression? ',' Expression{str|int|float}
''				  |	   GET '#' Expression ',' Expression? ',' Expression{str|int|float}
''				  |    (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)? .
function cFileStmt
    dim filenum as integer, expr1 as integer, expr2 as integer
    dim filename as integer, fmode as integer, faccess as integer, flock as integer, flen as integer
    dim res as integer, islock as integer

	cFileStmt = FALSE

	select case lexCurrentToken
	'' OPEN Expression{str} (FOR Expression)? (ACCESS Expression)?
	'' (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
	case FB.TK.OPEN
		lexSkipToken

		if( not cExpression( filename ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
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
		fmode = astNewCONST( fmode, IR.DATATYPE.INTEGER )

		'' (ACCESS Expression)?
		if( hMatch( FB.TK.ACCESS ) ) then
			if( not cExpression( faccess ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			faccess = astNewCONST( FB.FILE.ACCESS.READWRITE, IR.DATATYPE.INTEGER )
		end if

		'' (SHARED|LOCK (READ|WRITE|READ WRITE))?
		if( hMatch( FB.TK.SHARED ) ) then
			flock = astNewCONST( FB.FILE.LOCK.SHARED, IR.DATATYPE.INTEGER )
		elseif( hMatch( FB.TK.LOCK ) ) then
			select case lexCurrentToken
			case FB.TK.WRITE
				lexSkipToken
				flock = astNewCONST( FB.FILE.LOCK.WRITE, IR.DATATYPE.INTEGER )
			case FB.TK.READ
				lexSkipToken
				if( hMatch( FB.TK.WRITE ) ) then
					flock = astNewCONST( FB.FILE.LOCK.READWRITE, IR.DATATYPE.INTEGER )
				else
					flock = astNewCONST( FB.FILE.LOCK.READ, IR.DATATYPE.INTEGER )
				end if
			end select
		else
			flock = astNewCONST( FB.FILE.LOCK.SHARED, IR.DATATYPE.INTEGER )
		end if

		'' AS '#'? Expression
		if( not hMatch( FB.TK.AS ) ) then
			hReportError FB.ERRMSG.EXPECTINGAS
			exit function
		end if

		res = hMatch( CHAR_SHARP )

		if( not cExpression( filenum ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
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
			flen = astNewCONST( 0, IR.DATATYPE.INTEGER )
		end if

		''
		rtlFileOpen filename, fmode, faccess, flock, filenum, flen

		cFileStmt = TRUE

	'' CLOSE '#'? Expression
	case FB.TK.CLOSE
		lexSkipToken
		res = hMatch( CHAR_SHARP )

		if( not cExpression( filenum ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		rtlFileClose filenum

		cFileStmt = TRUE

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

		rtlFileSeek filenum, expr1

		cFileStmt = TRUE

	'' PUT '#' Expression ',' Expression? ',' Expression{str|int|float}
	case FB.TK.PUT
		if( lexLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if
		lexSkipToken
		lexSkipToken

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

		rtlFilePut filenum, expr1, expr2

		cFileStmt = TRUE

	'' GET '#' Expression ',' Expression? ',' Expression{str|int|float}
	case FB.TK.GET
		if( lexLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if
		lexSkipToken
		lexSkipToken

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

		rtlFileGet filenum, expr1, expr2

		cFileStmt = TRUE

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
			expr2 = astNewCONST( 0, IR.DATATYPE.INTEGER )
		end if

		rtlFileLock islock, filenum, expr1, expr2

		cFileStmt = TRUE
	end select

end function

'':::::
''OnStmt 		=	ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
''
function cOnStmt
	dim expr as integer
	dim isgoto as integer, label as integer, islocal as integer
	dim vr as integer, cr as integer, skipcompare as integer, endlabel as integer
	dim s as integer, dtype as integer

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
	    isgoto = FALSE
	else
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' Label
	label = symbLookupLabel( lexTokenText )
	if( label = INVALID ) then
		label = symbAddLabelEx( lexTokenText, FALSE )
	end if
	lexSkipToken

    '' on error?
	if( expr = INVALID ) then
		expr = astNewVAR( label, 0, IR.DATATYPE.UINT )
		expr = astNewADDR( IR.OP.ADDROF, expr )
		rtlErrorSetHandler expr, (islocal = TRUE)

	else
		if( isgoto ) then
			'' try to optimize if an logical op is at top of tree
			skipcompare = astFlushEx( expr, vr, label, TRUE )

			if( not skipcompare ) then
				dtype = irGetVRDataType( vr )
				if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
					cr = irAllocVRIMM( dtype, FALSE )
				else
					s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
					cr = irAllocVRVAR( dtype, s, 0 )
				end if
				irEmitCOMPBRANCHNF IR.OP.NE, vr, cr, label
			end if

		else
			endlabel = symbAddLabel( hMakeTmpStr )
			astFlush expr, vr
			dtype = irGetVRDataType( vr )
			if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
				cr = irAllocVRIMM( irGetVRDataType( vr ), FALSE )
			else
				s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
				cr = irAllocVRVAR( dtype, s, 0 )
			end if
			irEmitCOMPBRANCHNF IR.OP.EQ, vr, cr, endlabel
			irEmitCALL symbGetLabelName( label ), 0, FALSE
            irEmitLABEL endlabel, FALSE
		end if

	end if

	cOnStmt = TRUE

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
	dim res as integer

	cQuirkStmt = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
		if( lexCurrentToken <> CHAR_QUESTION ) then	'' PRINT as '?', can't be a keyword..
			exit function
		end if
	end if

	res = cGotoStmt
	if( not res ) then
		res = cArrayStmt
		if( not res ) then
			res = cDataStmt
			if( not res ) then
				res = cPrintStmt
				if( not res ) then
					res = cPokeStmt
					if( not res ) then
						res = cMidStmt
						if( not res ) then
							res = cFileStmt
							if( not res ) then
								res = cOnStmt
								if( not res ) then
									res = cErrorStmt
									if( not res ) then
										res = cWriteStmt
										if( not res ) then
											res = cLineInputStmt
											if( not res ) then
												res = cInputStmt
												if( not res ) then
													res = cViewStmt
												end if
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				end if
			end if
		end if
	end if

	cQuirkStmt = res

end function


'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct( funcexpr as integer )
	dim s as integer, ofs as integer, typ as integer
	dim elm as integer, typesymbol as integer
	dim islbound as integer, expr as integer

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
		typ = lexTokenType
		s = symbLookupVar( lexTokenText, typ, ofs, elm, typesymbol )
		if( s = INVALID ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		else
			lexSkipToken
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			if( not cExpression( expr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		else
			expr = astNewCONST( 0, IR.DATATYPE.INTEGER )
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
    		exit function
		end if

		funcexpr = rtlArrayBound( s, expr, islbound )

		cArrayFunct = TRUE
	end select

end function

'':::::
'' cStringFunct	=	STR$ '(' Expression{int|float|double} ')'
'' 				|   INSTR '(' ((Expression{int} ',' Expression ',' Expression)|
''							   (Expression{str} ',' Expression)) ')'
'' 				|   MID$ '(' Expression ',' Expression (',' Expression)? ')'
'' 				|   STRING$ '(' Expression ',' Expression{int|str} ')' .
''
function cStringFunct( funcexpr as integer )
    dim expr1 as integer, expr2 as integer, expr3 as integer
    dim dclass as integer

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
		cStringFunct = TRUE

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

		dclass = astGetDataClass( expr1 )
		'' (Expression{int} ',' Expression{str} ',' Expression{str})
		if( (dclass = IR.DATACLASS.INTEGER) or (dclass = IR.DATACLASS.FPOINT) ) then
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
			expr1 = astNewCONST( 1, IR.DATATYPE.INTEGER )
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
		cStringFunct = TRUE

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
			expr3 = astNewCONST( -1, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlStrMid( expr1, expr2, expr3 )
		cStringFunct = TRUE


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
		cStringFunct = TRUE

	end select

end function

'':::::
'' cMathFunct	=	ABS( Expression )
'' 				|   SGN( Expression )
''				|   FIX( Expression )
''				|   INT( Expression )
''				|	LEN( Expression | data type ) .
''
function cMathFunct( funcexpr as integer )
    dim expr as integer
    dim typ as integer, subtype as integer, lgt as integer, s as integer

	cMathFunct = FALSE

	select case lexCurrentToken
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


	'' LEN( UDT | Expression | data type )
	case FB.TK.LEN
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		expr = INVALID
		s = symbLookupUDT( lexTokenText, lgt )
		if( s <> INVALID ) then
			lexSkipToken
		else
			s = symbLookupEnum( lexTokenText )
			if( s <> INVALID ) then
				lexSkipToken
				lgt = FB.INTEGERSIZE
			else

				if( not cExpression( expr ) ) then
					if( not cSymbolType( typ, subtype, lgt ) ) then
						hReportError FB.ERRMSG.SYNTAXERROR
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
			funcexpr = rtlMathLen( expr )
		else
			funcexpr = astNewCONST( lgt, IR.DATATYPE.INTEGER )
		end if

		cMathFunct = TRUE
	end select

end function

'':::::
'' PeekFunct =   (PEEK|PEEKS|PEEKI) '(' Expression ')' .
''
function cPeekFunct( funcexpr as integer )
	dim expr as integer
	dim peektype as integer

	cPeekFunct = FALSE

	'' PEEK( Expression )
	peektype = INVALID
	select case lexCurrentToken
	case FB.TK.PEEK
		peektype = IR.DATATYPE.BYTE
	case FB.TK.PEEKS
		peektype = IR.DATATYPE.SHORT
	case FB.TK.PEEKI
		peektype = IR.DATATYPE.INTEGER
	end select

	if( peektype <> INVALID ) then
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

        astUpdNodeResult expr
        select case astGetDataClass( expr )
        case IR.DATACLASS.STRING
        	hReportError FB.ERRMSG.INVALIDDATATYPES
        	exit function
        case IR.DATACLASS.FPOINT
        	expr = astNewCONV( INVALID, IR.DATATYPE.UINT, expr )
        case else
        	if( astGetDataSize( expr ) < FB.POINTERSIZE ) then
        		hReportError FB.ERRMSG.INVALIDDATATYPES
        		exit function
        	end if
        end select

        funcexpr = astNewPTR( 0, peektype, expr )

        '' hack! to handle loading to x86 regs DI and SI, as they don't have byte versions &%@#&
        if( peektype = IR.DATATYPE.BYTE ) then
        	funcexpr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, funcexpr )
        end if

        cPeekFunct = TRUE

	end if

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
	select case lexCurrentToken
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

		cFileFunct = TRUE

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
			filenum = astNewCONST( 0, IR.DATATYPE.INTEGER )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		funcexpr = rtlFileStrInput( expr, filenum )

		cFileFunct = TRUE
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
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction( funcexpr as integer )
	dim res as integer

	cQuirkFunction = FALSE

	if( lexCurrentTokenClass <> FB.TKCLASS.KEYWORD ) then
		exit function
	end if

	res = cArrayFunct( funcexpr )
	if( not res ) then
		res = cStringFunct( funcexpr )
		if( not res ) then
			res = cMathFunct( funcexpr )
			if( not res ) then
				res = cPeekFunct( funcexpr )
				if( not res ) then
					res = cFileFunct( funcexpr )
					if( not res ) then
						res = cErrorFunct( funcexpr )
					end if
				end if
			end if
		end if
	end if

	cQuirkFunction = res

end function
