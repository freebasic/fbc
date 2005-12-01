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

'' pre-processor conditional (#if, #else, #elseif, #endif) parsing
''
'' chng: dec/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\pp.bi"

const FB_PP_MAXRECLEVEL = 64

type LEXPP_CTX
	level 		as integer
end type

type LEXPP_REC
	istrue		as integer
	elsecnt		as integer
end type

declare function ppSkip 					( ) as integer

declare function ppLogExpression			( byref logexpr as integer ) as integer

declare function ppRelExpression			( byref relexpr as integer, _
											  byref rellit as string, _
											  byref relisnum as integer ) as integer

declare function ppParentExpr				( byref parexpr as integer, _
											  byref atom as string, _
											  byref isnumber as integer ) as integer

'' globals
	dim shared ctx as LEXPP_CTX
	dim shared pptb(1 to FB_PP_MAXRECLEVEL) as LEXPP_REC

''::::
sub ppCondInit( )

	ctx.level = 0

end sub

''::::
sub ppCondEnd( )

end sub

'':::::
function ppCondIf( ) as integer
    dim istrue as integer
    dim d as FBSYMBOL ptr

    function = FALSE

	istrue = FALSE

	select case as const lexGetToken( )
	'' IFDEF ID
	case FB_TK_IFDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		d = lexGetSymbol( )
		if( d <> NULL ) then
			'' any symbol is okay or type's wouldn't be found
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IFNDEF ID
	case FB_TK_IFNDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		d = lexGetSymbol( )
		if( d = NULL ) then
			'' ditto
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IF Expression
	case FB_TK_IF
        lexSkipToken( )

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

	end select

	ctx.level += 1
	if( ctx.level > FB_PP_MAXRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
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
function ppCondElse( ) as integer
	dim istrue as integer

   	function = FALSE

   	istrue = FALSE

	if( ctx.level = 0 ) then
        hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

    if( pptb(ctx.level).elsecnt > 0 ) then
	   	hReportError( FB_ERRMSG_SYNTAXERROR )
       	exit function
    end if

	if( lexGetToken( ) = FB_TK_ELSEIF ) then
		'' ELSEIF

        lexSkipToken( )

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

		lexSkipToken( )

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
function ppCondEndIf( ) as integer

   	function = FALSE

	if( ctx.level = 0 ) then
        hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

   	'' ENDIF
   	lexSkipToken( )

	ctx.level -= 1

end function

'':::::
private function ppSkip as integer
    dim iflevel as integer

	function = FALSE

	'' Comment?
	cComment( )

	'' EOL
	if( not hMatch( FB_TK_EOL ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if


	iflevel = ctx.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
    do

		select case lexGetToken( )
        case CHAR_SHARP
        	lexSkipToken( )

        	select case as const lexGetToken( )
        	case FB_TK_IF, FB_TK_IFDEF, FB_TK_IFNDEF
        		iflevel += 1

        	case FB_TK_ELSE, FB_TK_ELSEIF
        		if( iflevel = ctx.level ) then
        			return ppCondElse( )
				elseif( iflevel = 0 ) then
            		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
					exit function
        		end if

        	case FB_TK_ENDIF
        		if( iflevel = ctx.level ) then
        			return ppCondEndIf( )
				elseif( iflevel = 0 ) then
	          		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
					exit function
				else
        			iflevel -= 1
        		end if

    		case FB_TK_DEFINE, FB_TK_UNDEF, FB_TK_PRINT, FB_TK_LPRINT, _
    			 FB_TK_ERROR, FB_TK_INCLUDE, FB_TK_INCLIB, FB_TK_LIBPATH, _
    			 FB_TK_PRAGMA

        	case else
        		hReportError( FB_ERRMSG_SYNTAXERROR )
        		exit function
        	end select

       	case FB_TK_EOF
       		function = TRUE
       		exit do
       	end select

		lexSkipLine( )
		if( lexGetToken( ) = FB_TK_EOL ) then
			lexSkipToken( )
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
    	op = lexGetToken( )
    	select case op
    	case FB_TK_AND, FB_TK_OR
 			lexSkipToken( )
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
    	op = lexGetToken( )
    	select case as const op
    	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' Atom
    	if( not ppParentExpr( parexpr, parlit, parisnum ) ) then
    		exit function
    	end if

   		'' same type?
   		if( (relisnum xor parisnum) = -1 ) then
   			hReportError( FB_ERRMSG_SYNTAXERROR )
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

   		rellit = str( relexpr )
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
  	select case lexGetToken( )
  	case CHAR_LPRNT
  		lexSkipToken( )

  		if( not ppLogExpression( parexpr ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	case FB_TK_DEFINED
  		lexSkipToken( )

    	if( lexGetToken( ) <> CHAR_LPRNT ) then
    		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
    		exit function
    	else
    		lexSkipToken( LEXCHECK_NODEFINE )
    	end if

		d = lexGetSymbol( )
		parexpr = FALSE
		if( d <> NULL ) then
			if( d->class = FB_SYMBCLASS_DEFINE ) then
				parexpr = TRUE
			end if
		end if
		lexSkipToken( )

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  			exit function
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

  		if( not ppParentExpr( parexpr, atom, isnumber ) ) then
  			exit function
  		elseif( not isnumber ) then
  			hReportError( FB_ERRMSG_SYNTAXERROR )
  			exit function
  		end if

  		atom = "-" + atom
  		parexpr = len( atom )

  	'' LITERAL
  	case else
  		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
  			isnumber = TRUE
  		end if

  		atom = *lexGetText( )
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
