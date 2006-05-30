''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

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

	'' VIEW
	if( lexGetToken( ) <> FB_TK_VIEW ) then
		exit function
	end if

	'' PRINT
	if( lexGetLookAhead( 1 ) <> FB_TK_PRINT ) then
		exit function
	end if

	lexSkipToken( )
	lexSkipToken( )

	'' (Expression TO Expression)?
	if( is_func = FALSE ) then
    	if( cExpression( expr1 ) ) then
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
        if( hIsString( astGetDataType( dev_name ) ) ) then
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
function cLocateStmt _
	( _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr row_arg, col_arg, cursor_vis_arg
    dim as ASTNODE ptr func

	function = NULL

	'' LOCATE
	lexSkipToken( )

	if( isfunc ) then
		'' '('?
		hMatchLPRNT( )
	end if

    if( cExpression( row_arg ) = FALSE ) then
    	row_arg = NULL
    end if

    if( hMatch( CHAR_COMMA ) ) then
    	if( cExpression( col_arg ) = FALSE ) then
    		col_arg = NULL
    	end if

	    if( hMatch( CHAR_COMMA ) ) then
		    if( cExpression( cursor_vis_arg ) = FALSE ) then
		    	cursor_vis_arg = NULL
		    end if
	    end if
    end if

	if( isfunc ) then
		'' ')'?
		hMatchRPRNT( )
	end if

    if( row_arg = NULL ) then
    	row_arg = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

    if( col_arg = NULL ) then
    	col_arg = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

	if( cursor_vis_arg = NULL ) then
		cursor_vis_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
	end if

    function = rtlLocate( row_arg, col_arg, cursor_vis_arg, isfunc )

end function

'':::::
'' ScreenFunct   =   SCREEN '(' expr ',' expr ( ',' expr )? ')'
''
function cScreenFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr yexpr, xexpr, fexpr

	function = FALSE

	'' SCREEN
	lexSkipToken( )

	hMatchLPRNT( )

	hMatchExpressionEx( yexpr, FB_DATATYPE_INTEGER )

	hMatchCOMMA( )

	hMatchExpressionEx( xexpr, FB_DATATYPE_INTEGER )

	fexpr = NULL
	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpressionEx( fexpr, FB_DATATYPE_INTEGER )
	end if

	hMatchRPRNT( )

	funcexpr = rtlConsoleReadXY( yexpr, xexpr, fexpr )

	function = funcexpr <> NULL

end function

