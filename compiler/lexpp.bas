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


'' pre-processor, lex's helper
''
'' chng: dec/2004 written [v1ctor]

option explicit

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'

declare function ppIf 						( ) as integer
declare function ppElse 					( )  as integer
declare function ppEndIf 					( ) as integer
declare function ppSkip 					( ) as integer

declare function ppLogExpression			( logexpr as integer ) as integer
declare function ppRelExpression			( relexpr as integer, rellit as string ) as integer
declare function ppParentExpr				( parexpr as integer, atom as string ) as integer

const FB.PP.MAXRECLEVEL = 64

type FBPPCTX
	level 		as integer
end type

type FBPPREC
	istrue		as integer
	elsecnt		as integer
end type

'' globals
	dim shared ctx as FBPPCTX
	dim shared pptb(1 to FB.PP.MAXRECLEVEL) as FBPPREC


'':::::
private function hLiteral as string
    dim text as string, quote as string

    quote = chr$( CHAR_QUOTE )

    text = ""
    do
    	select case lexCurrentToken
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			exit do
		end select

    	'' preserve quotes if it's a string literal
    	if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
    		text = text + quote + lexEatToken + quote
    	else
    		text = text + lexEatToken
    	end if
    loop

	hLiteral = text

end function

'':::::
'' PreProcess    =   '#'DEFINE ID LITERAL+
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''				 |	 '#'ELSE
''				 |   '#'ELSEIF Expression
''               |   '#'ENDIF
''               |   '#'PRINT LITERAL* .
''
function lexPreProcessor as integer
	dim id as string

	lexPreProcessor = FALSE

    select case lexCurrentToken

    '' DEFINE ID LITERAL+
    case FB.TK.DEFINE
    	lexSkipToken , FALSE

    	'' ID
    	if( symbLookupDefine( lexTokenText ) <> NULL ) then
    		hReportError FB.ERRMSG.DUPDEFINITION
    		exit function
    	else
    		id = lexEatToken
    	end if

    	'' LITERAL+
    	symbAddDefine( id, hLiteral )

    	lexPreProcessor = TRUE

	'' UNDEF ID
    case FB.TK.UNDEF
    	lexSkipToken , FALSE

    	if( not symbDelDefine( lexTokenText ) ) then
    		hReportError FB.ERRMSG.VARIABLENOTDECLARED
    		exit function
    	else
    		lexSkipToken
    	end if

    	lexPreProcessor = TRUE

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB.TK.IFDEF, FB.TK.IFNDEF, FB.TK.IF
    	lexPreProcessor = ppIf

	'' ELSE
	case FB.TK.ELSE, FB.TK.ELSEIF
    	lexPreProcessor = ppElse

	'' ENDIF
	case FB.TK.ENDIF
		lexPreProcessor = ppEndIf

	'' PRINT LITERAL*
	case FB.TK.PRINT
		lexSkipToken
		print hLiteral
		lexPreProcessor = TRUE

	case else
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end select

	'' Comment?
	cComment

	'' EOL
	if( lexCurrentToken <> FB.TK.EOL ) then
		if( lexCurrentToken <> FB.TK.EOF ) then
			lexPreProcessor = FALSE
			hReportError FB.ERRMSG.EXPECTEDEOL
			exit function
		end if
	end if

end function

'':::::
private function ppIf as integer
    dim istrue as integer

    ppIf = FALSE

	istrue = FALSE

	select case lexCurrenttoken
	'' IFDEF ID
	case FB.TK.IFDEF
        lexSkipToken , FALSE

		if( symbLookupDefine( lexEatToken ) <> NULL ) then
			istrue = TRUE
		end if

	'' IFNDEF ID
	case FB.TK.IFNDEF
        lexSkipToken , FALSE

		if( symbLookupDefine( lexEatToken ) = NULL ) then
			istrue = TRUE
		end if

	'' IF Expression
	case FB.TK.IF
        lexSkipToken

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

	end select

	ctx.level = ctx.level + 1
	pptb(ctx.level).istrue = istrue
	pptb(ctx.level).elsecnt = 0

    if( not istrue ) then
    	ppIf = ppSkip
    else
		ppIf = TRUE
	end if

end function

'':::::
private function ppElse as integer
	dim istrue as integer

   	ppElse = FALSE

   	istrue = FALSE

	if( ctx.level = 0 ) then
        hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
		exit function
	end if

    if( pptb(ctx.level).elsecnt > 0 ) then
	   	hReportError FB.ERRMSG.SYNTAXERROR
       	exit function
    end if

	if( lexCurrentToken = FB.TK.ELSEIF ) then
		'' ELSEIF

        lexSkipToken

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

		pptb(ctx.level).istrue = istrue
	else
		'' ELSE

		lexSkipToken

        pptb(ctx.level).elsecnt = pptb(ctx.level).elsecnt + 1

        pptb(ctx.level).istrue = not pptb(ctx.level).istrue

    end if

    if( not pptb(ctx.level).istrue ) then
    	ppElse = ppSkip
    else
    	ppElse = TRUE
    end if

end function

'':::::
private function ppEndIf as integer

   	ppEndIf = FALSE

	if( ctx.level = 0 ) then
        hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
		exit function
	end if

   	'' ENDIF
   	lexSkipToken

	ctx.level = ctx.level - 1

end function

'':::::
private function ppSkip as integer
    dim iflevel as integer

	ppSkip = FALSE

	'' Comment?
	cComment

	'' EOL
	if( not hMatch( FB.TK.EOL ) ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if


	iflevel = ctx.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
    do

		select case lexCurrentToken
        case CHAR_SHARP
        	lexSkipToken

        	select case lexCurrentToken
        	case FB.TK.IF, FB.TK.IFDEF, FB.TK.IFNDEF
        		iflevel = iflevel + 1

        	case FB.TK.ELSE, FB.TK.ELSEIF
        		if( iflevel = ctx.level ) then
        			ppSkip = ppElse
        			exit function
				elseif( iflevel = 0 ) then
            		hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
					exit function
        		end if

        	case FB.TK.ENDIF
        		if( iflevel = ctx.level ) then
        			ppSkip = ppEndIf
        			exit function
				elseif( iflevel = 0 ) then
	          		hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
					exit function
				else
        			iflevel = iflevel - 1
        		end if
        	end select

       	case FB.TK.EOF
       		ppSkip = TRUE
       		exit do
       	end select

		lexSkipLine
		if( lexCurrentToken = FB.TK.EOL ) then
			lexSkipToken
		end if
	loop

end function

'':::::
''LogExpression      =   NOT? RelExpression ( (AND | OR) NOT? RelExpression )* .
''
private function ppLogExpression( logexpr as integer )
    dim donot as integer, op as integer
    dim loglit as string
    dim relexpr as integer, rellit as string

    logexpr = FALSE

    '' NOT?
    donot = FALSE
    if( hMatch( FB.TK.NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not ppRelExpression( logexpr, loglit ) ) then
    	ppLogExpression = FALSE
    	exit function
    end if

    '' exec not
    if( donot ) then
    	logexpr = not logexpr
    end if

	ppLogExpression = TRUE

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.AND, FB.TK.OR
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' NOT?
    	donot = FALSE
    	if( hMatch( FB.TK.NOT ) ) then
    		donot = TRUE
    	end if

    	'' RelExpression
    	if( not ppRelExpression( relexpr, rellit ) ) then
    		ppLogExpression = FALSE
    		exit function
    	end if

    	'' exec not
    	if( donot ) then
    		relexpr = not relexpr
    	end if

    	'' do operation
    	select case op
    	case FB.TK.AND
    		logexpr = logexpr and relexpr
    	case FB.TK.OR
    		logexpr = logexpr or relexpr
    	end select
    loop

end function

'':::::
''RelExpression   =   ParentExpr ( (EQ | GT | LT | NE | LE | GE) ParentExpr )* .
''
private function ppRelExpression( relexpr as integer, rellit as string )
    dim op as integer, ops as integer
    dim parexpr as integer, parlit as string

   	ppRelExpression = FALSE

    '' Atom
    if( not ppParentExpr( relexpr, rellit ) ) then
    	exit function
    end if

    '' ( ... )*
    ops = 0
    do
    	'' Relational operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.EQ, FB.TK.GT, FB.TK.LT, FB.TK.NE, FB.TK.LE, FB.TK.GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' Atom
    	if( not ppParentExpr( parexpr, parlit ) ) then
    		exit function
    	end if

   		'' both literals?
   		if( relexpr <= 0 or parexpr <= 0 ) then
   			hReportError FB.ERRMSG.SYNTAXERROR
   			exit function
   		end if

   		'' do operation
   		select case op
   		case FB.TK.EQ
   			relexpr = rellit = parlit
   		case FB.TK.GT
   			relexpr = rellit > parlit
   		case FB.TK.LT
   			relexpr = rellit < parlit
   		case FB.TK.NE
   			relexpr = rellit <> parlit
   		case FB.TK.LE
   			relexpr = rellit <= parlit
   		case FB.TK.GE
   			relexpr = rellit >= parlit
   		end select

   		ops = ops + 1
    loop

    ''
    if( (ops = 0) and (relexpr > 0) ) then
    	relexpr = TRUE
    end if

    ppRelExpression = TRUE

end function

'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL .
private function ppParentExpr( parexpr as integer, atom as string ) as integer
    dim res as integer

  	ppParentExpr = FALSE
  	res = FALSE

  	atom = ""

  	'' '(' Expression ')'
  	if( hMatch( CHAR_LPRNT ) ) then
  		res = ppLogExpression( parexpr )
  		if( not res ) then
  			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	elseif( hMatch( FB.TK.DEFINED ) ) then

    	if( lexCurrentToken <> CHAR_LPRNT ) then
    		hReportError FB.ERRMSG.EXPECTEDLPRNT
    		exit function
    	else
    		lexSkipToken , FALSE
    	end if

		if( symbLookupDefine( lexEatToken ) <> NULL ) then
			parexpr = TRUE
		else
			parexpr = FALSE
		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  		res = TRUE

  	'' LITERAL
  	else
  		atom = lexEatToken
  		parexpr = len( atom )
  		if( parexpr = 0 ) then
  			res = FALSE
  		else
  			res = TRUE
  		end if
  	end if

	ppParentExpr = res

end function
