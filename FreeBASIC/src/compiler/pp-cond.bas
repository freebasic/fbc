''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\pp.bi"

const FB_PP_MAXRECLEVEL = 64

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
	dtype		as FB_DATATYPE
	num			as FBVALUE
	str			as string
end type


declare function ppSkip _
	( _
	) as integer

declare function ppExpression _
	( _
		byref istrue as integer _
	) as integer

declare function ppLogExpression _
	( _
		byref logexpr as PPEXPR _
	) as integer

declare function ppRelExpression _
	( _
		byref relexpr as PPEXPR _
	) as integer

declare function ppAddExpression _
	( _
		byref addexpr as PPEXPR _
	) as integer

declare function ppMultExpression _
	( _
		byref mult_expr as PPEXPR _
	) as integer

declare function ppParentExpr _
	( _
		byref parexpr as PPEXPR _
	) as integer


'' globals
	dim shared pptb(1 to FB_PP_MAXRECLEVEL) as LEXPP_REC

''::::
sub ppCondInit( )

	pp.level = 0

end sub

''::::
sub ppCondEnd( )

end sub

'':::::
function ppCondIf( ) as integer
    dim as integer istrue = any
    dim as FBSYMBOL ptr base_parent = any

    function = FALSE

	istrue = FALSE

	select case as const lexGetToken( LEXCHECK_KWDNAMESPC )
	'' IFDEF ID
	case FB_TK_PP_IFDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		if( cIdentifier( base_parent, FB_IDOPT_NONE ) <> NULL ) then
			'' any symbol is okay or type's wouldn't be found
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IFNDEF ID
	case FB_TK_PP_IFNDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		if( cIdentifier( base_parent, FB_IDOPT_NONE ) = NULL ) then
			'' ditto
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IF Expression
	case FB_TK_PP_IF
        lexSkipToken( )

		if( ppExpression( istrue ) = FALSE ) then
			exit function
		end if

	end select

	pp.level += 1
	if( pp.level > FB_PP_MAXRECLEVEL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
		'' no error recovery: fatal
		return errFatal( )
	end if

	pptb(pp.level).istrue = istrue
	pptb(pp.level).elsecnt = 0

    if( istrue = FALSE ) then
    	function = ppSkip( )
    else
		function = TRUE
	end if

end function

'':::::
function ppCondElse( ) as integer
	dim as integer istrue = any

   	function = FALSE

   	istrue = FALSE

	if( pp.level = 0 ) then
        if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
        	exit function
        else
        	'' error recovery: skip smtm
        	hSkipStmt( )
        	return TRUE
        end if
	end if

    if( pptb(pp.level).elsecnt > 0 ) then
	   	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
	   		exit function
	   	else
        	'' error recovery: skip smtm
        	hSkipStmt( )
        	return TRUE
        end if
    end if

	'' ELSEIF?
	if( lexGetToken( LEXCHECK_KWDNAMESPC ) = FB_TK_PP_ELSEIF ) then
        lexSkipToken( )

		if( ppExpression( istrue ) = FALSE ) then
			exit function
		end if

		if( pptb(pp.level).istrue ) then
		    return ppSkip( )
		else
			pptb(pp.level).istrue = istrue
		end if

	'' ELSE
	else
		lexSkipToken( )

        pptb(pp.level).elsecnt += 1
        pptb(pp.level).istrue = not pptb(pp.level).istrue
    end if

   	if( pptb(pp.level).istrue = FALSE ) then
   		function = ppSkip( )
   	else
   		function = TRUE
   	end if

end function

'':::::
function ppCondEndIf( ) as integer

   	function = FALSE

	if( pp.level = 0 ) then
        if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
			exit function
		else
			'' error recovery: skip token
			lexSkipToken( )
			return TRUE
		end if
	end if

   	'' ENDIF
   	lexSkipToken( )

	pp.level -= 1

end function

'':::::
private function ppSkip( ) as integer
    dim as integer iflevel = any

	function = FALSE

	pp.skipping = TRUE

	'' Comment?
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
			pp.skipping = FALSE
			exit function
		else
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL, TRUE )
		end if

	else
		lexSkipToken( )
	end if

	iflevel = pp.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
    do

		select case lexGetToken( )
        case CHAR_SHARP
        	lexSkipToken( LEXCHECK_KWDNAMESPC )

        	select case as const lexGetToken( LEXCHECK_KWDNAMESPC )
        	case FB_TK_PP_IF, FB_TK_PP_IFDEF, FB_TK_PP_IFNDEF
        		iflevel += 1

        	case FB_TK_PP_ELSE, FB_TK_PP_ELSEIF
        		if( iflevel = pp.level ) then
        			pp.skipping = FALSE
        			return ppCondElse( )

				elseif( iflevel = 0 ) then
            		if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
						pp.skipping = FALSE
						exit function
					end if
        		end if

        	case FB_TK_PP_ENDIF
        		if( iflevel = pp.level ) then
        			pp.skipping = FALSE
        			return ppCondEndIf( )

				elseif( iflevel = 0 ) then
	          		if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
						pp.skipping = FALSE
						exit function
					end if
				else
        			iflevel -= 1
        		end if

    		case FB_TK_PP_DEFINE, FB_TK_PP_UNDEF, FB_TK_PP_PRINT, FB_TK_PP_ERROR, _
    			 FB_TK_PP_INCLUDE, FB_TK_PP_INCLIB, FB_TK_PP_LIBPATH, FB_TK_PP_PRAGMA, _
    			 FB_TK_PP_MACRO, FB_TK_PP_ENDMACRO, FB_TK_PP_LINE

        	case else
        		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
        			pp.skipping = FALSE
        			exit function
        		end if
        	end select

       	case FB_TK_EOF
        	if( errReport( FB_ERRMSG_EXPECTEDENDIF ) = FALSE ) then
        		pp.skipping = FALSE
        		exit function
        	else
       			function = TRUE
       			exit do
       		end if
       	end select

		lexSkipLine( )

		if( lexGetToken( ) = FB_TK_EOL ) then
			lexSkipToken( )
		end if
	loop

	pp.skipping = FALSE

end function

private sub hHighestPrecision _
	( _
		byref l as PPEXPR, _
		byref r as PPEXPR, _
		byval only_integer as integer _
	)

    '' convert to highest precison..
  	select case as const l.dtype
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  		select case as const r.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			'' do nothing

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  			if( only_integer ) then
				r.num.long = r.num.float
  			else
				l.dtype = FB_DATATYPE_DOUBLE
				l.num.float = l.num.long
			end if

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE <> len( integer ) ) then
  				r.num.long = r.num.int
  			end if

  		case else
			r.num.long = r.num.int
  		end select

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		select case as const r.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			if( only_integer ) then
	  			l.dtype = r.dtype
	  			l.num.long = l.num.float
	  		else
	  			r.num.float = r.num.long
	  		end if

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  			if( only_integer ) then
				l.dtype = FB_DATATYPE_INTEGER
				l.num.int = l.num.float
				r.num.int = r.num.float
			end if


  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( only_integer ) then
				l.dtype = r.dtype
				if( FB_LONGSIZE = len( integer ) ) then
					l.num.int = l.num.float
				else
	  				l.num.long = l.num.float
	  			end if
	  		else
	  			if( FB_LONGSIZE = len( integer ) ) then
					r.num.float = r.num.int
				else
					r.num.float = r.num.long
	  			end if
	  		end if

  		case else
  			if( only_integer ) then
				l.dtype = FB_DATATYPE_INTEGER
				l.num.int = l.num.float
			else
				r.num.float = r.num.int
			end if
  		end select

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  		select case as const r.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.dtype = r.dtype
  				l.num.long = l.num.int
  			end if

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  			if( only_integer ) then
				if( FB_LONGSIZE = len( integer ) ) then
					r.num.int = r.num.float
				else
					r.num.long = r.num.float
				end if
			else
				l.dtype = FB_DATATYPE_DOUBLE
				if( FB_LONGSIZE = len( integer ) ) then
					l.num.float = l.num.int
				else
					l.num.float = l.num.long
				end if
			end if

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			'' do nothing

  		case else
  			if( FB_LONGSIZE <> len( integer ) ) then
				r.num.long = r.num.int
			end if
  		end select

  	case else
  		select case as const r.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.dtype = r.dtype
  			l.num.long = l.num.int

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  			if( only_integer ) then
  				r.num.int = r.num.float
  			else
				l.dtype = FB_DATATYPE_DOUBLE
				l.num.float = l.num.int
			end if

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE <> len( integer ) ) then
  				l.dtype = r.dtype
  				l.num.long = l.num.int
  			end if
  		end select
  	end select

end sub

'':::::
private sub hNumLogBOP _
	( _
		byval op as integer, _
		byref l as PPEXPR, _
		byref r as PPEXPR _
	)

	'' integers
	hHighestPrecision( l, r, TRUE )

    '' do operation
    select case op
    case FB_TK_AND
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			l.num.long and= r.num.long

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				l.num.int and= r.num.int
			else
				l.num.long and= r.num.long
			end if

		case else
			l.num.int and= r.num.int
  		end select

    case FB_TK_OR
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			l.num.long or= r.num.long

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				l.num.int or= r.num.int
			else
				l.num.long or= r.num.long
			end if

		case else
			l.num.int or= r.num.int
  		end select
    end select

end sub

'':::::
private sub hNumRelBOP _
	( _
		byval op as integer, _
		byref l as PPEXPR, _
		byref r as PPEXPR _
	)

    '' type is flexible
    hHighestPrecision( l, r, FALSE )

    '' do operation
   	select case as const op
   	case FB_TK_EQ
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long = r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float = r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int = r.num.int
  			else
  				l.num.int = l.num.long = r.num.long
  			end if

  		case else
  			l.num.int = l.num.int = r.num.int
  		end select

   	case FB_TK_GT
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long > r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float > r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int > r.num.int
  			else
  				l.num.int = l.num.long > r.num.long
  			end if

  		case else
  			l.num.int = l.num.int > r.num.int
  		end select

   	case FB_TK_LT
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long < r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float < r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int < r.num.int
  			else
  				l.num.int = l.num.long < r.num.long
  			end if

  		case else
  			l.num.int = l.num.int < r.num.int
  		end select

   	case FB_TK_NE
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long <> r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float <> r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int <> r.num.int
  			else
  				l.num.int = l.num.long <> r.num.long
  			end if

  		case else
  			l.num.int = l.num.int <> r.num.int
  		end select

   	case FB_TK_LE
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long <= r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float <= r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int <= r.num.int
  			else
  				l.num.int = l.num.long <= r.num.long
  			end if

  		case else
  			l.num.int = l.num.int <= r.num.int
  		end select

   	case FB_TK_GE
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.int = l.num.long >= r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.int = l.num.float >= r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int >= r.num.int
  			else
  				l.num.int = l.num.long >= r.num.long
  			end if

  		case else
  			l.num.int = l.num.int >= r.num.int
  		end select

   	end select

   	l.dtype = FB_DATATYPE_INTEGER

end sub

'':::::
private sub hNumAddMulBOP _
	( _
		byval op as integer, _
		byref l as PPEXPR, _
		byref r as PPEXPR _
	)

    '' type is flexible
    hHighestPrecision( l, r, FALSE )

#macro do_op(tk,op)
   	case tk
  		select case as const l.dtype
  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			l.num.long = l.num.long op r.num.long

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		    l.num.float = l.num.float op r.num.float

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  			if( FB_LONGSIZE = len( integer ) ) then
  				l.num.int = l.num.int op r.num.int
  			else
  				l.num.long = l.num.long op r.num.long
  			end if

  		case else
  			l.num.int = l.num.int op r.num.int
  		end select
#endmacro

    '' do operation
   	select case as const op

	   	do_op( CHAR_PLUS  , + )
	   	do_op( CHAR_MINUS , - )
	   	do_op( CHAR_CARET , * )
	   	do_op( CHAR_SLASH , / )
	   	do_op( CHAR_RSLASH, \ )

   	end select

end sub

'':::::
private sub hNumNot _
	( _
		byref l as PPEXPR _
	)

  	'' convert float to integer
  	select case l.dtype
  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		l.num.int = l.num.float
  		l.dtype = FB_DATATYPE_INTEGER
  	end select

  	select case as const l.dtype
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		l.num.long = not l.num.long

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			l.num.int = not l.num.int
		else
			l.num.long = not l.num.long
		end if

	case else
		l.num.int = not l.num.int
  	end select

end sub

'':::::
private sub hNumNeg _
	( _
		byref l as PPEXPR _
	)

  	select case as const l.dtype
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		l.num.long = -l.num.long

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		l.num.float = -l.num.float

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			l.num.int = -l.num.int
		else
			l.num.long = -l.num.long
		end if

	case else
		l.num.int = -l.num.int
  	end select

end sub

'':::::
private function hNumToBool _
	( _
		byval dtype as integer, _
		byref v as FBVALUE _
	) as integer

  	select case as const typeGet( dtype )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = v.long <> 0LL

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = v.float <> 0.0

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = v.int <> 0
		else
			function = v.long <> 0LL
		end if

	case else
		function = v.int <> 0
  	end select

end function

'':::::
''Expression      =   LogExpression .
''
private function ppExpression _
	( _
		byref istrue as integer _
	) as integer

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
private function ppLogExpression _
	( _
		byref logexpr as PPEXPR _
	) as integer

    dim as integer op = any
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
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
			else
  				'' error recovery: convert expr
  				logexpr.class = PPEXPR_CLASS_NUM
  				logexpr.dtype = FB_DATATYPE_INTEGER
  				logexpr.num.int = valint( logexpr.str )
  				logexpr.str = ""
    		end if
    	end if

    	'' RelExpression
    	if( ppRelExpression( relexpr ) = FALSE ) then
            if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
           		exit function
           	else
  				'' error recovery: fake an expr
  				relexpr.class = PPEXPR_CLASS_NUM
  				relexpr.dtype = FB_DATATYPE_INTEGER
  				relexpr.num.int = 0
    		end if
    	end if

    	if( relexpr.class <> PPEXPR_CLASS_NUM ) then
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
			else
  				'' error recovery: convert expr
  				relexpr.class = PPEXPR_CLASS_NUM
  				relexpr.dtype = FB_DATATYPE_INTEGER
  				relexpr.num.int = valint( relexpr.str )
  				relexpr.str = ""
    		end if
    	end if

    	'' do operation
    	hNumLogBOP( op, logexpr, relexpr )
    loop

	function = TRUE

end function

'':::::
''RelExpression   =   AddExpression ( (EQ | GT | LT | NE | LE | GE) AddExpression )* .
''
private function ppRelExpression _
	( _
		byref relexpr as PPEXPR _
	) as integer

    dim as integer op = any
    dim as PPEXPR add_expr

   	function = FALSE

    '' AddExpression
    if( ppAddExpression( relexpr ) = FALSE ) then
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

    	'' AddExpression
    	if( ppAddExpression( add_expr ) = FALSE ) then
            if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
           		exit function
           	else
  				'' error recovery: fake an expr
  				add_expr.class = PPEXPR_CLASS_NUM
  				add_expr.dtype = FB_DATATYPE_INTEGER
  				add_expr.num.int = 0
    		end if
    	end if

   		'' same type?
   		if( relexpr.class <> add_expr.class ) then
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
   			else
   				'' error recovery: fake a type
   				if( relexpr.class = PPEXPR_CLASS_NUM ) then
   					add_expr.class = PPEXPR_CLASS_NUM
   					add_expr.dtype = FB_DATATYPE_INTEGER
   					add_expr.num.int = valint( add_expr.str )
   					add_expr.str = ""

   				else
   					add_expr.class = PPEXPR_CLASS_STR

   					select case as const add_expr.dtype
   					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
   						add_expr.str = str( add_expr.num.long )

   					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
   					    add_expr.str = str( add_expr.num.float )

   					case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
   						if( FB_LONGSIZE = len( integer ) ) then
   							add_expr.str = str( add_expr.num.int )
   						else
   							add_expr.str = str( add_expr.num.long )
   						end if

   					case else
   						add_expr.str = str( add_expr.num.int )
   					end select
   				end if
   			end if
   		end if

   		'' can't compare as strings if both are numbers, '"10" > "2"' is FALSE for QB/FB
   		if( relexpr.class = PPEXPR_CLASS_NUM ) then
   			hNumRelBOP( op, relexpr, add_expr )

   		else
   			select case as const op
   			case FB_TK_EQ
   				relexpr.num.int = relexpr.str = add_expr.str
   			case FB_TK_GT
   				relexpr.num.int = relexpr.str > add_expr.str
   			case FB_TK_LT
   				relexpr.num.int = relexpr.str < add_expr.str
   			case FB_TK_NE
   				relexpr.num.int = relexpr.str <> add_expr.str
   			case FB_TK_LE
   				relexpr.num.int = relexpr.str <= add_expr.str
   			case FB_TK_GE
   				relexpr.num.int = relexpr.str >= add_expr.str
   			end select

   			relexpr.class = PPEXPR_CLASS_NUM
   			relexpr.dtype = FB_DATATYPE_INTEGER

   			relexpr.str = ""
   			add_expr.str = ""
   		end if

    loop

    function = TRUE

end function

'':::::
''AddExpression   =   MultExpression ( ('+' | '-') MultExpression )* .
''
private function ppAddExpression _
	( _
		byref add_expr as PPEXPR _
	) as integer

    dim as integer op = any
    dim as PPEXPR mult_expr

   	function = FALSE

    '' MultExpression
    if( ppMultExpression( add_expr ) = FALSE ) then
    	exit function
    end if

    '' ( ... )*
    do
    	'' Add/Sub operator
    	op = lexGetToken( )
    	select case as const op
    	case CHAR_PLUS, CHAR_MINUS
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' ParentExpr
    	if( ppMultExpression( mult_expr ) = FALSE ) then
            if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
           		exit function
           	else
  				'' error recovery: fake an expr
  				mult_expr.class = PPEXPR_CLASS_NUM
  				mult_expr.dtype = FB_DATATYPE_INTEGER
  				mult_expr.num.int = 0
    		end if
    	end if

   		'' same type?
   		if( add_expr.class <> mult_expr.class ) then
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
   			else
   				'' error recovery: fake a type
   				if( add_expr.class = PPEXPR_CLASS_NUM ) then
   					mult_expr.class = PPEXPR_CLASS_NUM
   					mult_expr.dtype = FB_DATATYPE_INTEGER
   					mult_expr.num.int = valint( mult_expr.str )
   					mult_expr.str = ""

   				else
   					mult_expr.class = PPEXPR_CLASS_STR

   					select case as const mult_expr.dtype
   					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
   						mult_expr.str = str( mult_expr.num.long )

   					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
   					    mult_expr.str = str( mult_expr.num.float )

   					case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
   						if( FB_LONGSIZE = len( integer ) ) then
   							mult_expr.str = str( mult_expr.num.int )
   						else
   							mult_expr.str = str( mult_expr.num.long )
   						end if

   					case else
   						mult_expr.str = str( mult_expr.num.int )
   					end select
   				end if
   			end if
   		end if

   		if( add_expr.class = PPEXPR_CLASS_NUM ) then
   			hNumAddMulBOP( op, add_expr, mult_expr )
   		else
   			select case as const op
   			case CHAR_PLUS
   				add_expr.str = add_expr.str + mult_expr.str
   			case CHAR_MINUS
	   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
	   				exit function
	   			end if
   			end select

   			mult_expr.str = ""
   		end if

    loop

    function = TRUE

end function


'':::::
''MultExpression   =   ParentExpr ( ('*' | '/' | '\') ParentExpr )* .
''
private function ppMultExpression _
	( _
		byref mul_expr as PPEXPR _
	) as integer

    dim as integer op = any
    dim as PPEXPR parexpr

   	function = FALSE

    '' ParentExpr
    if( ppParentExpr( mul_expr ) = FALSE ) then
    	exit function
    end if

    '' ( ... )*
    do
    	'' Mul/Div operator
    	op = lexGetToken( )
    	select case as const op
    	case CHAR_CARET, CHAR_SLASH, CHAR_RSLASH
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' ParentExpr
    	if( ppParentExpr( parexpr ) = FALSE ) then
            if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
           		exit function
           	else
  				'' error recovery: fake an expr
  				parexpr.class = PPEXPR_CLASS_NUM
  				parexpr.dtype = FB_DATATYPE_INTEGER
  				parexpr.num.int = 0
    		end if
    	end if

   		'' same type?
   		if( mul_expr.class <> parexpr.class ) then
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
   			else
   				'' error recovery: fake a type
   				if( mul_expr.class = PPEXPR_CLASS_NUM ) then
   					parexpr.class = PPEXPR_CLASS_NUM
   					parexpr.dtype = FB_DATATYPE_INTEGER
   					parexpr.num.int = valint( parexpr.str )
   					parexpr.str = ""

   				else
   					parexpr.class = PPEXPR_CLASS_STR

   					select case as const parexpr.dtype
   					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
   						parexpr.str = str( parexpr.num.long )

   					case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
   					    parexpr.str = str( parexpr.num.float )

   					case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
   						if( FB_LONGSIZE = len( integer ) ) then
   							parexpr.str = str( parexpr.num.int )
   						else
   							parexpr.str = str( parexpr.num.long )
   						end if

   					case else
   						parexpr.str = str( parexpr.num.int )
   					end select
   				end if
   			end if
   		end if

   		if( mul_expr.class = PPEXPR_CLASS_NUM ) then
   			hNumAddMulBOP( op, mul_expr, parexpr )
   		else
   			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
   				exit function
   			end if
   		end if

    loop

    function = TRUE

end function


'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL
''			   |   NOT RelExpression .
private function ppParentExpr _
	( _
		byref parexpr as PPEXPR _
	) as integer

  	function = FALSE

  	select case lexGetToken( )
  	'' TYPEOF '(' Expression ')'
  	case FB_TK_TYPEOF
  		lexSkipToken( )

		parexpr.class = PPEXPR_CLASS_STR
		dim as zstring ptr res = ppTypeOf( )
		if( res = NULL ) then
			exit function
		end if
		parexpr.str += *res

  	'' '(' Expression ')'
  	case CHAR_LPRNT
  		lexSkipToken( )

  		if( ppLogExpression( parexpr ) = FALSE ) then
  			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: fake an expr
  				parexpr.class = PPEXPR_CLASS_NUM
  				parexpr.dtype = FB_DATATYPE_INTEGER
  				parexpr.num.int = FALSE
  			end if
  		end if

  		if( hMatch( CHAR_RPRNT ) = FALSE ) then
  			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: skip until ')'
  				hSkipUntil( CHAR_RPRNT, TRUE )
  			end if
  		end if

  	'' DEFINED'(' ID ')'
  	case FB_TK_DEFINED
  		lexSkipToken( LEXCHECK_NODEFINE )

    	if( lexGetToken( ) <> CHAR_LPRNT ) then
    		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
    			exit function
    		end if
    	else
    		lexSkipToken( LEXCHECK_NODEFINE )
    	end if

		parexpr.class = PPEXPR_CLASS_NUM
		parexpr.dtype = FB_DATATYPE_INTEGER

		dim as FBSYMBOL ptr base_parent = any

		parexpr.num.int = (cIdentifier( base_parent, FB_IDOPT_NONE ) <> NULL)

		lexSkipToken( )

  		if( hMatch( CHAR_RPRNT ) = FALSE ) then
  			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: skip until ')'
  				hSkipUntil( CHAR_RPRNT, TRUE )
  			end if
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

  		if( ppParentExpr( parexpr ) = FALSE ) then
  			exit function
  		end if

  		if( parexpr.class <> PPEXPR_CLASS_NUM ) then
  			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: fake an expr
  				parexpr.class = PPEXPR_CLASS_NUM
  				parexpr.dtype = FB_DATATYPE_INTEGER
  				parexpr.num.int = 0
  			end if

  		else
  			hNumNeg( parexpr )
  		end if

    '' NOT RelExpression
	case FB_TK_NOT
		lexSkipToken( )

  		if( ppRelExpression( parexpr ) = FALSE ) then
  			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: fake an expr
  				parexpr.class = PPEXPR_CLASS_NUM
  				parexpr.dtype = FB_DATATYPE_INTEGER
  				parexpr.num.int = 0
  			end if
  		end if

  		if( parexpr.class <> PPEXPR_CLASS_NUM ) then
  			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
  				exit function
  			else
  				'' error recovery: fake an expr
  				parexpr.class = PPEXPR_CLASS_NUM
  				parexpr.dtype = FB_DATATYPE_INTEGER
  				parexpr.num.int = 0
  			end if

  		else
  			hNumNot( parexpr )
  		end if

  	'' LITERAL
  	case else
  		parexpr.dtype = lexGetType( )

  		select case lexGetClass( )
  		case FB_TKCLASS_NUMLITERAL
  			parexpr.class = PPEXPR_CLASS_NUM

  			select case as const parexpr.dtype
  			case FB_DATATYPE_LONGINT
				parexpr.num.long = vallng( *lexGetText( ) )

			case FB_DATATYPE_ULONGINT
				parexpr.num.long = valulng( *lexGetText( ) )

  			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				parexpr.num.float = val( *lexGetText( ) )

			case FB_DATATYPE_UINT
				parexpr.num.int = valuint( *lexGetText( ) )

   			case FB_DATATYPE_LONG
   				if( FB_LONGSIZE = len( integer ) ) then
   					parexpr.num.int = valint( *lexGetText( ) )
   				else
   					parexpr.num.long = vallng( *lexGetText( ) )
   				end if

   			case FB_DATATYPE_ULONG
   				if( FB_LONGSIZE = len( integer ) ) then
   					parexpr.num.int = valuint( *lexGetText( ) )
   				else
   					parexpr.num.long = valulng( *lexGetText( ) )
   				end if

			case else
				parexpr.num.int = valint( *lexGetText( ) )
  			end select

		case FB_TKCLASS_STRLITERAL
  			parexpr.class = PPEXPR_CLASS_STR
  			parexpr.str = QUOTE
  			parexpr.str += *lexGetText( )
  			parexpr.str += QUOTE

  		case else
  			parexpr.class = PPEXPR_CLASS_STR
  			parexpr.str = ucase( *lexGetText( ) )
  		end select

  		lexSkipToken( )

  	end select

	function = TRUE

end function
