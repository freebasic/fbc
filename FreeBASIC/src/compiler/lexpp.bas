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
option escape

defint a-z
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'

declare function ppIf 						( ) as integer
declare function ppElse 					( )  as integer
declare function ppEndIf 					( ) as integer
declare function ppSkip 					( ) as integer

declare function ppLogExpression			( logexpr as integer ) as integer
declare function ppRelExpression			( relexpr as integer, rellit as string, relisnum as integer ) as integer
declare function ppParentExpr				( parexpr as integer, atom as string, isnumber as integer ) as integer

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
private function hLiteral( byval args as integer = 0, _
						   byval arghead as FBDEFARG ptr = NULL ) as string
    dim as string text, token
    dim as integer dpos, flags
    dim as FBDEFARG ptr a

const QUOTE = "\""

	flags = LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX

    text = ""
    do
    	select case lexCurrentToken( flags )
		case FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
			exit do
		end select

    	'' preserve quotes if it's a string literal
    	if( lexCurrentTokenClass = FB.TKCLASS.STRLITERAL ) then
    		text += QUOTE
    		text += hUnescapeStr( lexEatToken )
    		text += QUOTE

    	else
    		'' no args? just read as-is
    		if( args = 0 ) then
    			text += lexEatToken( flags )

    		else
    			'' not and identifier? read as-is
    			if( lexCurrentToken <> FB.TK.ID ) then
    				text += lexEatToken( flags )

    			'' otherwise, check if it's an argument and replace it
    			'' with an unique pattern
    			else
    				token = ucase$( lexTokenText( ) )
    				'' contains a dot? assume it's an udt access
    				dpos = lexTokenDotPos
    				if( dpos > 1 ) then
    					token = left$( token, dpos-1 )
    				end if

    				a = arghead
    				do
    					'' matches?
    					if( token = a->name ) then
    						'' replace
    						text += "\27"
    						text += hex$( a )
    						text += "\27"
    						'' add the remainder if it's an udt access
    						if( dpos > 1 ) then
    							text += mid$( lexEatToken( flags ), dpos )
    						else
    							lexSkipToken( flags )
    						end if
    						exit do
    					end if

    					'' next arg
    					a = a->r
    				loop while( a <> NULL )

    				'' if none matched, read as-is
    				if( a = NULL ) then
    					text += lexEatToken( flags )
    				end if
    			end if

    		end if
    	end if
    loop

	hLiteral = text

end function

'':::::
'' PreProcess    =   '#'DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''				 |	 '#'ELSE
''				 |   '#'ELSEIF Expression
''               |   '#'ENDIF
''               |   '#'PRINT LITERAL*
''				 |   '#'INCLUDE ONCE? LIT_STR
''				 |   '#'INCLIB LIT_STR
''				 |	 '#'LIBPATH LIT_STR
''				 |	 '#'ERROR LIT_STR .
''
function lexPreProcessor as integer
	dim as string id, text
	dim as integer isonce, args, isargless
	dim as FBDEFARG ptr arghead, lastarg
	dim as FBSYMBOL ptr s

	lexPreProcessor = FALSE

    select case as const lexCurrentToken

    '' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
    case FB.TK.DEFINE
    	lexSkipToken LEXCHECK_NODEFINE

    	'' ID
    	s = lexTokenSymbol
    	if( s <> NULL ) then
    		if( s->class <> FB.SYMBCLASS.DEFINE ) then
    			hReportError FB.ERRMSG.DUPDEFINITION
    			exit function
    		end if
    	end if

    	id = lexEatToken( LEXCHECK_NOWHITESPC )

    	args = 0
    	arghead = NULL
    	isargless = FALSE

    	'' '('?
    	if( lexCurrentToken = CHAR_LPRNT ) then
    		lexSkipToken LEXCHECK_NODEFINE

			'' not arg-less?
			if( lexCurrentToken <> CHAR_RPRNT ) then
				lastarg = NULL
				do
			    	lastarg = symbAddDefineArg( lastarg, lexEatToken( LEXCHECK_NODEFINE ) )
			    	args = args + 1

			    	if( arghead = NULL ) then
			    		arghead = lastarg
			    	end if

					'' ','?
					if( lexCurrentToken <> CHAR_COMMA ) then
						exit do
					end if
			    	lexSkipToken LEXCHECK_NODEFINE
				loop

			else
				isargless = TRUE
			end if

    		'' ')'
    		if( not hMatch( CHAR_RPRNT ) ) then
    			hReportError FB.ERRMSG.EXPECTEDRPRNT
    			exit function
    		end if

    	else
    		select case lexCurrentToken
    		case CHAR_SPACE, CHAR_TAB
    			'' skip white-space
    			lexSkipToken
    		end select
    	end if

    	'' LITERAL+
    	text = hLiteral( args, arghead )

    	'' already defined? if there are no differences, do nothing..
    	if( s <> NULL ) then
    		if( (s->def.args <> args) or (s->def.text <> text) ) then
    			hReportError FB.ERRMSG.DUPDEFINITION
    			exit function
    		end if

    	else
    		symbAddDefine( id, text, args, arghead, isargless )
    	end if

    	lexPreProcessor = TRUE

	'' UNDEF ID
    case FB.TK.UNDEF
    	lexSkipToken LEXCHECK_NODEFINE

    	if( not symbDelDefine( lexTokenSymbol ) ) then
    	'''''hReportError FB.ERRMSG.VARIABLENOTDECLARED
		'''''exit function
    	end if

    	lexSkipToken

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

	'' ERROR LITERAL*
	case FB.TK.ERROR
		lexSkipToken
		hReportErrorEx -1, hLiteral
		exit function

	'' INCLUDE ONCE? LIT_STR
	case FB.TK.INCLUDE
		lexSkipToken

		'' ONCE?
		isonce = FALSE
		if( lexCurrentTokenClass = FB.TKCLASS.IDENTIFIER ) then
			if( ucase$( lexTokenText ) = "ONCE" ) then
				lexSkipToken
				isonce = TRUE
			end if
		end if

		text = hUnescapeStr( lexEatToken )
		lexPreProcessor = fbIncludeFile( text, isonce )

	'' INCLIB LIT_STR
	case FB.TK.INCLIB
		lexSkipToken

		if( symbAddLib( hUnescapeStr( lexEatToken ) ) <> NULL ) then
			lexPreProcessor = TRUE
		end if

	'' LIBPATH LIT_STR
	case FB.TK.LIBPATH
		lexSkipToken

		if( not fbAddLibPath( hUnescapeStr( lexEatToken ) ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if
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
    dim d as FBSYMBOL ptr

    ppIf = FALSE

	istrue = FALSE

	select case as const lexCurrenttoken
	'' IFDEF ID
	case FB.TK.IFDEF
        lexSkipToken LEXCHECK_NODEFINE

		d = lexTokenSymbol
		if( d <> NULL ) then
			'' any symbol is okay or type's wouldn't be found
			istrue = TRUE
		end if
		lexSkipToken

	'' IFNDEF ID
	case FB.TK.IFNDEF
        lexSkipToken LEXCHECK_NODEFINE

		d = lexTokenSymbol
		if( d = NULL ) then
			'' ditto
			istrue = TRUE
		end if
		lexSkipToken

	'' IF Expression
	case FB.TK.IF
        lexSkipToken

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

	end select

	ctx.level = ctx.level + 1
	pptb(ctx.level).istrue = istrue
	pptb(ctx.level).elsecnt   = 0

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

		if( pptb(ctx.level).istrue ) then
		    ppElse = ppSkip
		    exit function
		else
			pptb(ctx.level).istrue = istrue
		end if

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

        	select case as const lexCurrentToken
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
    dim loglit as string, logisnum
    dim relexpr as integer, rellit as string, relisnum as integer

    logexpr = FALSE

    '' NOT?
    donot = FALSE
    if( hMatch( FB.TK.NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not ppRelExpression( logexpr, loglit, logisnum ) ) then
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
    	if( not ppRelExpression( relexpr, rellit, relisnum ) ) then
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
private function ppRelExpression( relexpr as integer, rellit as string, relisnum as integer )
    dim op as integer, ops as integer
    dim parexpr as integer, parlit as string, parisnum

   	ppRelExpression = FALSE

    '' Atom
    if( not ppParentExpr( relexpr, rellit, relisnum ) ) then
    	exit function
    end if

    '' ( ... )*
    ops = 0
    do
    	'' Relational operator
    	op = lexCurrentToken
    	select case as const op
    	case FB.TK.EQ, FB.TK.GT, FB.TK.LT, FB.TK.NE, FB.TK.LE, FB.TK.GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' Atom
    	if( not ppParentExpr( parexpr, parlit, parisnum ) ) then
    		exit function
    	end if

   		'' same type?
   		if( (relisnum xor parisnum) = -1 ) then
   			hReportError FB.ERRMSG.SYNTAXERROR
   			exit function
   		end if

   		'' do operation
   		if( relisnum ) then
   			'' can't compare as strings if both are numbers, '"10" > "2"' is FALSE for QB/FB
   			select case as const op
   			case FB.TK.EQ
   				relexpr = val( rellit ) = val( parlit )
   			case FB.TK.GT
   				relexpr = val( rellit ) > val( parlit )
   			case FB.TK.LT
   				relexpr = val( rellit ) < val( parlit )
   			case FB.TK.NE
   				relexpr = val( rellit ) <> val( parlit )
   			case FB.TK.LE
   				relexpr = val( rellit ) <= val( parlit )
   			case FB.TK.GE
   				relexpr = val( rellit ) >= val( parlit )
   			end select

   		else
   			select case as const op
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
   		end if

   		rellit = str$( relexpr )
   		relisnum = TRUE
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
private function ppParentExpr( parexpr as integer, atom as string, isnumber as integer ) as integer
    dim res as integer
    dim d as FBSYMBOL ptr

  	ppParentExpr = FALSE
  	res = FALSE

  	atom = ""
  	isnumber = FALSE

  	'' '(' Expression ')'
  	select case lexCurrentToken
  	case CHAR_LPRNT
  		lexSkipToken

  		if( not ppLogExpression( parexpr ) ) then
  			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	case FB.TK.DEFINED
  		lexSkipToken

    	if( lexCurrentToken <> CHAR_LPRNT ) then
    		hReportError FB.ERRMSG.EXPECTEDLPRNT
    		exit function
    	else
    		lexSkipToken LEXCHECK_NODEFINE
    	end if

		d = lexTokenSymbol
		parexpr = FALSE
		if( d <> NULL ) then
			if( d->class = FB.SYMBCLASS.DEFINE ) then
				parexpr = TRUE
			end if
		end if
		lexSkipToken

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB.ERRMSG.EXPECTEDRPRNT
  			exit function
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken

  		if( not ppParentExpr( parexpr, atom, isnumber ) ) then
  			exit function
  		elseif( not isnumber ) then
  			hReportError FB.ERRMSG.SYNTAXERROR
  			exit function
  		end if

  		atom = "-" + atom
  		parexpr = len( atom )

  	'' LITERAL
  	case else
  		if( lexCurrentTokenClass <> FB.TKCLASS.STRLITERAL ) then
  			isnumber = TRUE
  		end if

  		atom = lexEatToken
  		if( len( atom ) = 0 ) then
  			hReportError FB.ERRMSG.SYNTAXERROR
  			exit function
  		end if

  		if( isnumber ) then
  			parexpr = ( val( atom ) <> 0 )
  		end if
  	end select

	ppParentExpr = TRUE

end function
