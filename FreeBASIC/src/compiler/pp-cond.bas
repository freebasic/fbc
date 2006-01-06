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

enum PPEXPR_CLASS
	PPEXPR_CLASS_NUM
	PPEXPR_CLASS_STR
end enum

type PPEXPR
	class		as PPEXPR_CLASS
	dtype		as FBSYMBTYPE_ENUM
	num			as FBVALUE
	str			as string
end type


declare function ppSkip 					( ) as integer

declare function ppExpression				( byref istrue as integer ) as integer

declare function ppLogExpression			( byref logexpr as PPEXPR ) as integer

declare function ppRelExpression			( byref relexpr as PPEXPR ) as integer

declare function ppParentExpr				( byref parexpr as PPEXPR ) as integer


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

		if( ppExpression( istrue ) = FALSE ) then
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

    if( istrue = FALSE ) then
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

		if( ppExpression( istrue ) = FALSE ) then
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

   	if( pptb(ctx.level).istrue = FALSE ) then
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
	if( hMatch( FB_TK_EOL ) = FALSE ) then
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
private sub hNumLogBOP( byval op as integer, _
					 	byref l as PPEXPR, _
					 	byref r as PPEXPR )

    '' convert to highest precison (must be integer class)..
  	select case as const l.dtype
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			'' do nothing
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			r.num.long = r.num.float
  		case else
			r.num.long = r.num.int
  		end select

  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.dtype = IR_DATATYPE_LONGINT
  			l.num.long = l.num.float
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			l.dtype = IR_DATATYPE_INTEGER
			l.num.int = l.num.float
			r.num.int = r.num.float
  		case else
			l.dtype = IR_DATATYPE_INTEGER
			l.num.int = l.num.float
  		end select

  	case else
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.dtype = IR_DATATYPE_LONGINT
  			l.num.long = l.num.int
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			r.num.int = r.num.float
  		end select
  	end select

    '' do operation
    select case op
    case FB_TK_AND
  		select case l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			l.num.long and= r.num.long
		case else
			l.num.int and= r.num.int
  		end select

    case FB_TK_OR
  		select case l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			l.num.long or= r.num.long
		case else
			l.num.int or= r.num.int
  		end select
    end select

end sub

'':::::
private sub hNumRelBOP( byval op as integer, _
					 	byref l as PPEXPR, _
					 	byref r as PPEXPR )

    '' convert to highest precison..
  	select case as const l.dtype
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			'' do nothing
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			r.num.long = r.num.float
  		case else
			r.num.long = r.num.int
  		end select

  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.dtype = IR_DATATYPE_LONGINT
  			l.num.long = l.num.float
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  			'' do nothing
  		case else
			r.dtype = IR_DATATYPE_DOUBLE
			r.num.float = r.num.int
  		end select

  	case else
  		select case as const r.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.dtype = IR_DATATYPE_LONGINT
  			l.num.long = l.num.int
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			l.dtype = IR_DATATYPE_DOUBLE
			l.num.float = l.num.int
  		end select
  	end select

    '' do operation
   	select case as const op
   	case FB_TK_EQ
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long = r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float = r.num.float
  		case else
  			l.num.int = l.num.int = r.num.int
  		end select

   	case FB_TK_GT
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long > r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float > r.num.float
  		case else
  			l.num.int = l.num.int > r.num.int
  		end select

   	case FB_TK_LT
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long < r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float < r.num.float
  		case else
  			l.num.int = l.num.int < r.num.int
  		end select

   	case FB_TK_NE
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long <> r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float <> r.num.float
  		case else
  			l.num.int = l.num.int <> r.num.int
  		end select

   	case FB_TK_LE
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long <= r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float <= r.num.float
  		case else
  			l.num.int = l.num.int <= r.num.int
  		end select

   	case FB_TK_GE
  		select case as const l.dtype
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  			l.num.int = l.num.long >= r.num.long
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		    l.num.int = l.num.float >= r.num.float
  		case else
  			l.num.int = l.num.int >= r.num.int
  		end select

   	end select

   	l.dtype = IR_DATATYPE_INTEGER

end sub

'':::::
private sub hNumNot( byref l as PPEXPR )

  	'' convert float to integer
  	select case l.dtype
  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  		l.num.int = l.num.float
  		l.dtype = IR_DATATYPE_INTEGER
  	end select

  	select case l.dtype
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		l.num.long = not l.num.long
	case else
		l.num.int = not l.num.int
  	end select

end sub

'':::::
private sub hNumNeg( byref l as PPEXPR )

  	select case as const l.dtype
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		l.num.long = -l.num.long
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		l.num.float = -l.num.float
	case else
		l.num.int = -l.num.int
  	end select

end sub

'':::::
private function hNumToBool( byval dtype as integer, _
							 byref v as FBVALUE _
						   ) as integer

  	select case as const dtype
  	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		function = v.long <> 0LL

  	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		function = v.float <> 0.0

	case else
		function = v.int <> 0
  	end select

end function

'':::::
''Expression      =   LogExpression .
''
private function ppExpression( byref istrue as integer ) as integer
    dim as PPEXPR expr

    function = FALSE

    '' LogExpression
    if( ppLogExpression( expr ) = FALSE ) then
    	exit function
    end if

    if( expr.class = PPEXPR_CLASS_NUM ) then
    	istrue = hNumToBool( expr.dtype, expr.num )
    else
    	istrue = FALSE
    end if

    function = TRUE

end function

'':::::
''LogExpression      =   RelExpression ( (AND | OR) RelExpression )* .
''
private function ppLogExpression( byref logexpr as PPEXPR ) as integer
    dim as integer op
    dim as PPEXPR relexpr

    function = FALSE

    '' RelExpression
    if( ppRelExpression( logexpr ) = FALSE ) then
    	exit function
    end if

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

    	if( logexpr.class <> PPEXPR_CLASS_NUM ) then
    		exit function
    	end if

    	'' RelExpression
    	if( ppRelExpression( relexpr ) = FALSE ) then
    		exit function
    	end if

    	if( relexpr.class <> PPEXPR_CLASS_NUM ) then
    		exit function
    	end if

    	'' do operation
    	hNumLogBOP( op, logexpr, relexpr )
    loop

	function = TRUE

end function

'':::::
''RelExpression   =   ParentExpr ( (EQ | GT | LT | NE | LE | GE) ParentExpr )* .
''
private function ppRelExpression( byref relexpr as PPEXPR ) as integer
    dim as integer op
    dim as PPEXPR parexpr

   	function = FALSE

    '' Atom
    if( ppParentExpr( relexpr ) = FALSE ) then
    	exit function
    end if

    '' ( ... )*
    do
    	'' Relational operator
    	op = lexGetToken( )
    	select case as const op
    	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' ParentExpr
    	if( ppParentExpr( parexpr ) = FALSE ) then
    		exit function
    	end if

   		'' same type?
   		if( relexpr.class <> parexpr.class ) then
   			hReportError( FB_ERRMSG_SYNTAXERROR )
   			exit function
   		end if

   		'' can't compare as strings if both are numbers, '"10" > "2"' is FALSE for QB/FB
   		if( relexpr.class = PPEXPR_CLASS_NUM ) then
   			hNumRelBOP( op, relexpr, parexpr )

   		else
   			select case as const op
   			case FB_TK_EQ
   				relexpr.num.int = relexpr.str = parexpr.str
   			case FB_TK_GT
   				relexpr.num.int = relexpr.str > parexpr.str
   			case FB_TK_LT
   				relexpr.num.int = relexpr.str < parexpr.str
   			case FB_TK_NE
   				relexpr.num.int = relexpr.str <> parexpr.str
   			case FB_TK_LE
   				relexpr.num.int = relexpr.str <= parexpr.str
   			case FB_TK_GE
   				relexpr.num.int = relexpr.str >= parexpr.str
   			end select

   			relexpr.class = PPEXPR_CLASS_NUM
   			relexpr.dtype = IR_DATATYPE_INTEGER

   			relexpr.str = ""
   			parexpr.str = ""
   		end if

    loop

    function = TRUE

end function

'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL
''			   |   NOT RelExpression .
private function ppParentExpr( byref parexpr as PPEXPR ) as integer

    dim as FBSYMBOL ptr d

  	function = FALSE

  	'' '(' Expression ')'
  	select case lexGetToken( )
  	case CHAR_LPRNT
  		lexSkipToken( )

  		if( ppLogExpression( parexpr ) = FALSE ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  		if( hMatch( CHAR_RPRNT ) = FALSE ) then
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

		parexpr.class = PPEXPR_CLASS_NUM
		parexpr.dtype = IR_DATATYPE_INTEGER

		d = lexGetSymbol( )
		parexpr.num.int = FALSE
		if( d <> NULL ) then
			if( d->class = FB_SYMBCLASS_DEFINE ) then
				parexpr.num.int = TRUE
			end if
		end if
		lexSkipToken( )

  		if( hMatch( CHAR_RPRNT ) = FALSE ) then
  			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  			exit function
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

  		if( ppParentExpr( parexpr ) = FALSE ) then
  			exit function
  		end if

  		if( parexpr.class <> PPEXPR_CLASS_NUM ) then
  			hReportError( FB_ERRMSG_INVALIDDATATYPES )
  			exit function
  		end if

  		hNumNeg( parexpr )

    '' NOT RelExpression
	case FB_TK_NOT
		lexSkipToken( )

  		if( ppRelExpression( parexpr ) = FALSE ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  		if( parexpr.class <> PPEXPR_CLASS_NUM ) then
  			hReportError( FB_ERRMSG_INVALIDDATATYPES )
  			exit function
  		end if

  		hNumNot( parexpr )

  	'' LITERAL
  	case else
  		parexpr.dtype = lexGetType( )

  		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
  			parexpr.class = PPEXPR_CLASS_NUM

  			select case as const parexpr.dtype
  			case IR_DATATYPE_LONGINT
				parexpr.num.long = vallng( *lexGetText( ) )

			case IR_DATATYPE_ULONGINT
				parexpr.num.long = valulng( *lexGetText( ) )

  			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
				parexpr.num.float = val( *lexGetText( ) )

			case IR_DATATYPE_UINT
				parexpr.num.int = valuint( *lexGetText( ) )

			case else
				parexpr.num.int = valint( *lexGetText( ) )
  			end select

  		else
  			parexpr.class = PPEXPR_CLASS_STR
  			parexpr.str = *lexGetText( )

  		end if

  		lexSkipToken( )

  	end select

	function = TRUE

end function
