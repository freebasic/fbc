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


'' quirk console statements (VIEW, LOCATE) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
'' ViewStmt	  =   VIEW (PRINT (Expression TO Expression)?) .
''
function cViewStmt _
	( _
		byval is_func as integer = FALSE, _
        byref funcexpr as ASTNODE ptr = NULL _
    ) as integer

    dim as ASTNODE ptr expr1, expr2
    dim as integer default_view, default_view_value

	function = FALSE

	default_view = is_func
    default_view_value = iif(is_func,-1,0)

	'' PRINT
	if( lexGetLookAhead( 1 ) <> FB_TK_PRINT ) then
		exit function
	end if

	lexSkipToken( )
	lexSkipToken( )

	'' (Expression TO Expression)?
	if( is_func = FALSE ) then
    	expr1 = cExpression( )
    	if( expr1 <> NULL ) then
            if( hMatch( FB_TK_TO ) = FALSE ) then
                if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
                	exit function
                else
                	expr1 = astNewCONST( 0, FB_DATATYPE_INTEGER )
                end if
            end if

            hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
        else
            default_view = TRUE
        end if
	end if

    if( default_view ) then
        if( is_func ) then
            hMatchLPRNT( )
            hMatchRPRNT( )
        end if
        expr1 = astNewCONSTi( default_view_value, FB_DATATYPE_INTEGER )
        expr2 = astNewCONSTi( default_view_value, FB_DATATYPE_INTEGER )
	end if

	funcexpr = rtlConsoleView( expr1, expr2 )
    function = funcexpr <> NULL

    if( is_func = FALSE ) then
    	astAdd( funcexpr )
    end if

end function

'':::::
function cWidthStmt _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr fnum, width_arg, height_arg, dev_name
    dim as ASTNODE ptr func
    dim as integer checkrprnt

	function = NULL

	'' WIDTH
	lexSkipToken( )

	if( isfunc ) then
		'' '('?
		checkrprnt = hMatch( CHAR_LPRNT )
	else
		checkrprnt = FALSE
	end if

    if( isfunc ) then
    	'' used as function?
    	if( checkrprnt = FALSE ) then
    		return rtlWidthScreen( NULL, NULL, isfunc )
    	'' ()?
    	elseif( hMatch( CHAR_RPRNT ) ) then
    		return rtlWidthScreen( NULL, NULL, isfunc )
    	end if
	end if

    if( hMatch( FB_TK_LPRINT ) ) then
       ' fb_WidthDev
       dev_name = astNewCONSTstr( "LPT1:" )
       hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )

       function = rtlWidthDev( dev_name, width_arg, isfunc )

	elseif( hMatch( CHAR_SHARP ) ) then
    	' fb_WidthFile

        hMatchExpressionEx( fnum, FB_DATATYPE_INTEGER )

        if( hMatch( CHAR_COMMA ) ) then
        	hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )
		else
        	width_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
		end if

        function = rtlWidthFile( fnum, width_arg, isfunc )

	elseif( hMatch( CHAR_COMMA ) ) then
    	' fb_WidthScreen
        width_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
        hMatchExpressionEx( height_arg, FB_DATATYPE_INTEGER )
        function = rtlWidthScreen( width_arg, height_arg, isfunc )

	else
		hMatchExpressionEx( dev_name, FB_DATATYPE_STRING )
        ' fb_WidthDev
        if( symbIsString( astGetDataType( dev_name ) ) ) then
        	if( hMatch( CHAR_COMMA ) ) then
            	hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )
			else
            	width_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
			end if
            function = rtlWidthDev( dev_name, width_arg, isfunc )

		else
        	' fb_WidthScreen
            width_arg = dev_name
            dev_name = NULL

            if( hMatch( CHAR_COMMA ) ) then
            	hMatchExpressionEx( height_arg, FB_DATATYPE_INTEGER )
			else
            	height_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
			end if
            function = rtlWidthScreen( width_arg, height_arg, isfunc )

		end if
	end if

	if( checkrprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

end function

'':::::
function cColorStmt _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr fore_color, back_color = NULL
    dim as integer checkrprnt

	function = NULL

	'' COLOR
	lexSkipToken( )

	if( isfunc ) then
		'' '('?
		if( hMatch( CHAR_LPRNT ) = TRUE ) then
			fore_color = cExpression( )
			if( hMatch( CHAR_COMMA ) = TRUE ) then
				hMatchExpression( back_color )
			end if
			hMatchRPRNT( )
		end if
	else

		'' '('?
		if( hMatch( CHAR_LPRNT ) = TRUE ) then

			'' expr?
			fore_color = cExpression(  )

			if( hMatch( CHAR_COMMA ) = TRUE ) then

				'' ',' expr ')'
				hMatchExpression( back_color )
				hMatchRPRNT( )

			else

				'' ')' (',' expr)?
				hMatchRPRNT( )
				if( hMatch( CHAR_COMMA ) = TRUE ) then
					hMatchExpression( back_color )
				end if

			end if

		else

			'' expr? (',' expr)?

			fore_color = cExpression(  )
			if( hMatch( CHAR_COMMA ) = TRUE ) then
				hMatchExpression( back_color )
			end if

		end if

	end if

	function = rtlColor( fore_color, back_color, isfunc )

end function

'':::::
'' ScreenFunct   =   SCREEN '(' expr ',' expr ( ',' expr )? ')'
''				 |   SCREEN ( '(' ')' )? -- returns the current active/visible pages
''
function cScreenFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	function = FALSE

	'' SCREEN
	lexSkipToken( )

	dim as integer match_paren = FALSE
	dim as ASTNODE ptr yexpr = NULL
	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		match_paren = TRUE
		yexpr = cExpression( )
	end if

	'' pageset?
	if( yexpr = NULL ) then
		funcexpr = rtlPageSet( NULL, NULL, TRUE )

    '' readXY..
    else
		dim as ASTNODE ptr xexpr, fexpr

		hMatchCOMMA( )

		hMatchExpressionEx( xexpr, FB_DATATYPE_INTEGER )

		fexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( fexpr, FB_DATATYPE_INTEGER )
		end if

		funcexpr = rtlConsoleReadXY( yexpr, xexpr, fexpr )
	end if

	if( match_paren ) then
		hMatchRPRNT( )
	end if

	function = funcexpr <> NULL

end function

