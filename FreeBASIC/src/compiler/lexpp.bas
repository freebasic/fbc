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
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

declare function ppInclude					( ) as integer

declare function ppIncLib					( ) as integer

declare function ppLibPath					( ) as integer

declare function ppDefine					( ) as integer

declare function ppIf 						( ) as integer

declare function ppElse 					( )  as integer

declare function ppEndIf 					( ) as integer

declare function ppSkip 					( ) as integer

declare function ppLogExpression			( logexpr as integer ) as integer

declare function ppRelExpression			( relexpr as integer, _
											  rellit as string, _
											  relisnum as integer ) as integer

declare function ppParentExpr				( parexpr as integer, _
											  atom as string, _
											  isnumber as integer ) as integer

const FB_PP_MAXRECLEVEL = 64

type FBPPCTX
	level 		as integer
end type

type FBPPREC
	istrue		as integer
	elsecnt		as integer
end type

'' globals
	dim shared ctx as FBPPCTX
	dim shared pptb(1 to FB_PP_MAXRECLEVEL) as FBPPREC

'':::::
private function hLiteral( byval args as integer = 0, _
						   byval arghead as FBDEFARG ptr = NULL ) as zstring ptr

	static as zstring * FB_MAXNAMELEN+1 token
	static as zstring * FB_MAXINTDEFINELEN+1+1 text			'' +1 sentinel..
    dim as integer dpos, flags, addquotes
    dim as FBDEFARG ptr a

const QUOTE = "\""

	flags = LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE

    addquotes = FALSE
    text = ""
    do
    	select case lexCurrentToken( flags )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

    	'' preserve quotes if it's a string literal
    	if( lexCurrentTokenClass( ) = FB_TKCLASS_STRLITERAL ) then
    		text += QUOTE
    		lexEatToken( token )
    		text += hUnescapeStr( token )
    		text += QUOTE

    	else
    		'' no args? just read as-is
    		if( args = 0 ) then
    			lexEatToken( token, flags )
    			text += token

    		else

    			'' '#'?
    			if( lexCurrentToken( ) = CHAR_SHARP ) then
    				select case lexLookAhead( 1 )
    				'' '##'?
    				case CHAR_SHARP
    					lexSkipToken( )
    					lexSkipToken( )
    					continue do

    				'' '#' id?
    				case FB_TK_ID
    				    lexSkipToken( )
    				    text += QUOTE
    				    addquotes = TRUE
    				end select
    			end if

    			'' not and identifier? read as-is
    			if( lexCurrentToken( ) <> FB_TK_ID ) then
    				lexEatToken( token, flags )
    				text += token

    			'' otherwise, check if it's an argument and replace it
    			'' with an unique pattern
    			else
    				token = ucase( *lexTokenText( ) )
    				'' contains a dot? assume it's an udt access
    				dpos = lexTokenDotPos( )
    				if( dpos > 1 ) then
    					token = left( token, dpos-1 )
    				end if

    				a = arghead
    				do
    					'' matches?
    					if( token = a->name ) then
    						'' replace
    						text += "\27"
    						text += hex( a->id )
    						text += "\27"
    						'' add the remainder if it's an udt access
    						if( dpos > 1 ) then
    							lexEatToken( token, flags )
    							text += mid( token, dpos )
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
    					lexEatToken( token, flags )
    					text += token
    				end if
    			end if

    			''
    			if( addquotes ) then
    				addquotes = FALSE
    				text += QUOTE
    			end if

    		end if
    	end if

    loop

	function = @text

end function

'':::::
'' PreProcess    =   '#'DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL*
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

	function = FALSE

    select case as const lexCurrentToken( )

    '' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
    case FB_TK_DEFINE
    	lexSkipToken( LEXCHECK_NODEFINE )

    	function = ppDefine( )

	'' UNDEF ID
    case FB_TK_UNDEF
    	lexSkipToken( LEXCHECK_NODEFINE )

    	if( not symbDelDefine( lexTokenSymbol ) ) then
    	'''''hReportError FB_ERRMSG_VARIABLENOTDECLARED
		'''''exit function
    	end if

    	lexSkipToken( )

    	function = TRUE

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB_TK_IFDEF, FB_TK_IFNDEF, FB_TK_IF
    	function = ppIf( )

	'' ELSE
	case FB_TK_ELSE, FB_TK_ELSEIF
    	function = ppElse( )

	'' ENDIF
	case FB_TK_ENDIF
		function = ppEndIf( )

	'' PRINT LITERAL*
	case FB_TK_PRINT
		lexSkipToken( )
		print *hLiteral( )
		function = TRUE

	'' ERROR LITERAL*
	case FB_TK_ERROR
		lexSkipToken( )
		hReportErrorEx( -1, *hLiteral( ) )
		exit function

	'' INCLUDE ONCE? LIT_STR
	case FB_TK_INCLUDE
		lexSkipToken( )
		function = ppInclude( )

	'' INCLIB LIT_STR
	case FB_TK_INCLIB
		lexSkipToken( )
        function = ppIncLib( )

	'' LIBPATH LIT_STR
	case FB_TK_LIBPATH
		lexSkipToken
		function = ppLibPath( )

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end select

	'' Comment?
	cComment( )

	'' EOL
	if( lexCurrentToken( ) <> FB_TK_EOL ) then
		if( lexCurrentToken( ) <> FB_TK_EOF ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			return FALSE
		end if
	end if

end function

'':::::
private function ppInclude( ) as integer
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce

	function = FALSE

	'' ONCE?
	isonce = FALSE
	if( lexCurrentTokenClass( ) = FB_TKCLASS_IDENTIFIER ) then
		if( ucase$( *lexTokenText( ) ) = "ONCE" ) then
			lexSkipToken( )
			isonce = TRUE
		end if
	end if

	lexEatToken( incfile )

	function = fbIncludeFile( hUnescapeStr( incfile ), isonce )

end function

'':::::
private function ppIncLib( ) as integer
    static as zstring * FB_MAXPATHLEN+1 libfile

	lexEatToken( libfile )

	function = symbAddLib( hUnescapeStr( libfile ) ) <> NULL

end function

'':::::
private function ppLibPath( ) as integer
    static as zstring * FB_MAXPATHLEN+1 path

	lexEatToken( path )

	if( not fbAddLibPath( hUnescapeStr( path ) ) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
		return FALSE
	end if

	function = TRUE

end function

'':::::
private function ppDefine( ) as integer
	static as zstring * FB_MAXNAMELEN+1 defname, argname
	dim as zstring ptr text
	dim as integer args, isargless, textlen
	dim as FBDEFARG ptr arghead, lastarg
	dim as FBSYMBOL ptr s

	function = FALSE

    '' ID
    s = lexTokenSymbol( )
    if( s <> NULL ) then
    	if( s->class <> FB_SYMBCLASS_DEFINE ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION )
    		exit function
    	end if
    end if

    lexEatToken( defname, LEXCHECK_NOWHITESPC )

    args = 0
    arghead = NULL
    isargless = FALSE

    '' '('?
    if( lexCurrentToken( ) = CHAR_LPRNT ) then
    	lexSkipToken( LEXCHECK_NODEFINE )

		'' not arg-less?
		if( lexCurrentToken( ) <> CHAR_RPRNT ) then
			lastarg = NULL
			do
		    	lexEatToken( argname, LEXCHECK_NODEFINE )
		    	lastarg = symbAddDefineArg( lastarg, argname )
		    	args += 1

		    	if( arghead = NULL ) then
		    		arghead = lastarg
		    	end if

				'' ','?
				if( lexCurrentToken( ) <> CHAR_COMMA ) then
					exit do
				end if
		    	lexSkipToken( LEXCHECK_NODEFINE )
			loop

		else
			isargless = TRUE
		end if

    	'' ')'
    	if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    		exit function
    	end if

    else
    	select case lexCurrentToken
    	case CHAR_SPACE, CHAR_TAB
    		'' skip white-space
    		lexSkipToken( )
    	end select
    end if

    '' LITERAL*
    text = hLiteral( args, arghead )

    '' check len, use the sentinel as "text" is a static zstring
    textlen = len( *text )
    if( textlen = FB_MAXINTDEFINELEN+1 ) then
		hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
		exit function
    end if

    '' already defined? if there are no differences, do nothing..
    if( s <> NULL ) then
    	if( (s->def.args <> args) or (s->def.text <> *text) ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION )
    		exit function
    	end if

    else
    	symbAddDefine( defname, text, textlen, args, arghead, isargless )
    end if

	function = TRUE

end function

'':::::
private function ppIf as integer
    dim istrue as integer
    dim d as FBSYMBOL ptr

    function = FALSE

	istrue = FALSE

	select case as const lexCurrenttoken
	'' IFDEF ID
	case FB_TK_IFDEF
        lexSkipToken LEXCHECK_NODEFINE

		d = lexTokenSymbol
		if( d <> NULL ) then
			'' any symbol is okay or type's wouldn't be found
			istrue = TRUE
		end if
		lexSkipToken

	'' IFNDEF ID
	case FB_TK_IFNDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		d = lexTokenSymbol
		if( d = NULL ) then
			'' ditto
			istrue = TRUE
		end if
		lexSkipToken

	'' IF Expression
	case FB_TK_IF
        lexSkipToken

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

	end select

	ctx.level += 1
	if( ctx.level > FB_PP_MAXRECLEVEL ) then
		hReportError FB_ERRMSG_RECLEVELTOODEPTH
		exit function
	end if

	pptb(ctx.level).istrue = istrue
	pptb(ctx.level).elsecnt = 0

    if( not istrue ) then
    	function = ppSkip( )
    else
		function = TRUE
	end if

end function

'':::::
private function ppElse as integer
	dim istrue as integer

   	function = FALSE

   	istrue = FALSE

	if( ctx.level = 0 ) then
        hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
		exit function
	end if

    if( pptb(ctx.level).elsecnt > 0 ) then
	   	hReportError FB_ERRMSG_SYNTAXERROR
       	exit function
    end if

	if( lexCurrentToken = FB_TK_ELSEIF ) then
		'' ELSEIF

        lexSkipToken

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

		if( pptb(ctx.level).istrue ) then
		    return ppSkip( )
		else
			pptb(ctx.level).istrue = istrue
		end if

	else
		'' ELSE

		lexSkipToken

        pptb(ctx.level).elsecnt += 1

        pptb(ctx.level).istrue = not pptb(ctx.level).istrue

    end if

   	if( not pptb(ctx.level).istrue ) then
   		function = ppSkip( )
   	else
   		function = TRUE
   	end if


end function

'':::::
private function ppEndIf as integer

   	function = FALSE

	if( ctx.level = 0 ) then
        hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
		exit function
	end if

   	'' ENDIF
   	lexSkipToken

	ctx.level -= 1

end function

'':::::
private function ppSkip as integer
    dim iflevel as integer

	function = FALSE

	'' Comment?
	cComment

	'' EOL
	if( not hMatch( FB_TK_EOL ) ) then
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if


	iflevel = ctx.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
    do

		select case lexCurrentToken
        case CHAR_SHARP
        	lexSkipToken

        	select case as const lexCurrentToken
        	case FB_TK_IF, FB_TK_IFDEF, FB_TK_IFNDEF
        		iflevel += 1

        	case FB_TK_ELSE, FB_TK_ELSEIF
        		if( iflevel = ctx.level ) then
        			return ppElse( )
				elseif( iflevel = 0 ) then
            		hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
					exit function
        		end if

        	case FB_TK_ENDIF
        		if( iflevel = ctx.level ) then
        			return ppEndIf( )
				elseif( iflevel = 0 ) then
	          		hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
					exit function
				else
        			iflevel -= 1
        		end if
        	end select

       	case FB_TK_EOF
       		function = TRUE
       		exit do
       	end select

		lexSkipLine
		if( lexCurrentToken = FB_TK_EOL ) then
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
    if( hMatch( FB_TK_NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not ppRelExpression( logexpr, loglit, logisnum ) ) then
    	return FALSE
    end if

    '' exec not
    if( donot ) then
    	logexpr = not logexpr
    end if

	function = TRUE

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexCurrentToken
    	select case op
    	case FB_TK_AND, FB_TK_OR
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' NOT?
    	donot = FALSE
    	if( hMatch( FB_TK_NOT ) ) then
    		donot = TRUE
    	end if

    	'' RelExpression
    	if( not ppRelExpression( relexpr, rellit, relisnum ) ) then
    		return FALSE
    	end if

    	'' exec not
    	if( donot ) then
    		relexpr = not relexpr
    	end if

    	'' do operation
    	select case op
    	case FB_TK_AND
    		logexpr = logexpr and relexpr
    	case FB_TK_OR
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

   	function = FALSE

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
    	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE
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
   			hReportError FB_ERRMSG_SYNTAXERROR
   			exit function
   		end if

   		'' do operation
   		if( relisnum ) then
   			'' can't compare as strings if both are numbers, '"10" > "2"' is FALSE for QB/FB
   			select case as const op
   			case FB_TK_EQ
   				relexpr = val( rellit ) = val( parlit )
   			case FB_TK_GT
   				relexpr = val( rellit ) > val( parlit )
   			case FB_TK_LT
   				relexpr = val( rellit ) < val( parlit )
   			case FB_TK_NE
   				relexpr = val( rellit ) <> val( parlit )
   			case FB_TK_LE
   				relexpr = val( rellit ) <= val( parlit )
   			case FB_TK_GE
   				relexpr = val( rellit ) >= val( parlit )
   			end select

   		else
   			select case as const op
   			case FB_TK_EQ
   				relexpr = rellit = parlit
   			case FB_TK_GT
   				relexpr = rellit > parlit
   			case FB_TK_LT
   				relexpr = rellit < parlit
   			case FB_TK_NE
   				relexpr = rellit <> parlit
   			case FB_TK_LE
   				relexpr = rellit <= parlit
   			case FB_TK_GE
   				relexpr = rellit >= parlit
   			end select
   		end if

   		rellit = str$( relexpr )
   		relisnum = TRUE
   		ops += 1
    loop

    ''
    if( (ops = 0) and (relexpr > 0) ) then
    	relexpr = TRUE
    end if

    function = TRUE

end function

'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL .
private function ppParentExpr( parexpr as integer, _
							   atom as string, _
							   isnumber as integer ) as integer
    dim d as FBSYMBOL ptr

  	function = FALSE

  	atom = ""
  	isnumber = FALSE

  	'' '(' Expression ')'
  	select case lexCurrentToken
  	case CHAR_LPRNT
  		lexSkipToken

  		if( not ppLogExpression( parexpr ) ) then
  			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB_ERRMSG_EXPECTEDRPRNT
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	case FB_TK_DEFINED
  		lexSkipToken

    	if( lexCurrentToken <> CHAR_LPRNT ) then
    		hReportError FB_ERRMSG_EXPECTEDLPRNT
    		exit function
    	else
    		lexSkipToken LEXCHECK_NODEFINE
    	end if

		d = lexTokenSymbol
		parexpr = FALSE
		if( d <> NULL ) then
			if( d->class = FB_SYMBCLASS_DEFINE ) then
				parexpr = TRUE
			end if
		end if
		lexSkipToken

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError FB_ERRMSG_EXPECTEDRPRNT
  			exit function
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken

  		if( not ppParentExpr( parexpr, atom, isnumber ) ) then
  			exit function
  		elseif( not isnumber ) then
  			hReportError FB_ERRMSG_SYNTAXERROR
  			exit function
  		end if

  		atom = "-" + atom
  		parexpr = len( atom )

  	'' LITERAL
  	case else
  		if( lexCurrentTokenClass <> FB_TKCLASS_STRLITERAL ) then
  			isnumber = TRUE
  		end if

  		atom = *lexTokenText( )
  		lexSkipToken( )
  		if( len( atom ) = 0 ) then
  			hReportError( FB_ERRMSG_SYNTAXERROR )
  			exit function
  		end if

  		if( isnumber ) then
  			parexpr = ( val( atom ) <> 0 )
  		end if
  	end select

	function = TRUE

end function
