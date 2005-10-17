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


'' intrinsic runtime lib console functions (LOCATE, COLOR, CLS, INKEY, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

'' locate( byval row as integer = 0, byval col as integer = 0, byval cursor as integer = -1 ) as integer
data @FB_RTL_LOCATE_FN, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' locate( byval row as integer = 0, byval col as integer = 0, byval cursor as integer = -1 ) as integer
data @FB_RTL_LOCATE_SUB, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_ConsoleView ( byval toprow as integer = 0, byval botrow as integer = 0 ) as void
data @FB_RTL_CONSOLEVIEW,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_ReadXY ( byval x as integer, byval y as integer, byval colorflag as integer ) as integer
data @FB_RTL_CONSOLEREADXY,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' width( byval cols as integer = -1, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTH, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' width( dev as string, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTHDEV, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1

'' width( byval fnum as integer, byval width_arg as integer = -1 ) as integer
data @FB_RTL_WIDTHFILE, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1

'' pos( ) as integer
data @"pos", "fb_GetX", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 0

'' pos( dummy ) as integer
data @"pos", "fb_Pos", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
     1, _
     FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' csrlin( ) as integer
data @"csrlin", "fb_GetY", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' cls( byval n as integer = 1 ) as void
data @"cls", "fb_Cls", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&hFFFF0000

'' color( byval fc as integer = -1, byval bc as integer = -1 ) as integer
data @"color", "fb_Color", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' inkey ( ) as string
data @"inkey","fb_Inkey", _
	 FB_SYMBTYPE_STRING,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 0

'' getkey ( ) as integer
data @"getkey","fb_Getkey", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 0

'' EOL
data NULL


'':::::
sub rtlConsoleModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlConsoleModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlConsoleView ( byval topexpr as ASTNODE ptr, _
						  byval botexpr as ASTNODE ptr ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( CONSOLEVIEW ) )

    '' byval toprow as integer
    if( astNewPARAM( proc, topexpr ) = NULL ) then
    	exit function
    end if

    '' byval botrow as integer
    if( astNewPARAM( proc, botexpr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlLocate ( byval row_arg as ASTNODE ptr, _
					 byval col_arg as ASTNODE ptr, _
					 byval cursor_vis_arg as ASTNODE ptr, _
                     byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
    if( isfunc ) then
		f = PROCLOOKUP( LOCATE_FN )
    else
		f = PROCLOOKUP( LOCATE_SUB )
    end if
    proc = astNewFUNCT( f )

    '' byval row_arg as integer
    if( row_arg = NULL ) then
    	row_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, row_arg ) = NULL ) then
    	exit function
    end if

    '' byval col_arg as integer
    if( col_arg = NULL ) then
        col_arg = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, col_arg ) = NULL ) then
    	exit function
    end if

    '' byval cursor_vis_arg as integer
    if( cursor_vis_arg = NULL ) then
        cursor_vis_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, cursor_vis_arg ) = NULL ) then
    	exit function
    end if

    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlWidthScreen ( byval width_arg as ASTNODE ptr, _
					      byval height_arg as ASTNODE ptr, _
                          byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewFUNCT( PROCLOOKUP( WIDTH ) )

    '' byval width_arg as integer
    if( width_arg = NULL ) then
    	width_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, width_arg ) = NULL ) then
    	exit function
    end if

    '' byval height_arg as integer
    if( height_arg = NULL ) then
        height_arg = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, height_arg ) = NULL ) then
    	exit function
    end if

    if( not isfunc ) then
    	dim reslabel as FBSYMBOL ptr
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlConsoleReadXY ( byval rowexpr as ASTNODE ptr, _
							byval columnexpr as ASTNODE ptr, _
							byval colorflagexpr as ASTNODE ptr ) as ASTNODE ptr

	dim as ASTNODE ptr proc

	function = NULL

	''
	proc = astNewFUNCT( PROCLOOKUP( CONSOLEREADXY ) )

	'' byval column as integer
	if( astNewPARAM( proc, columnexpr ) = NULL ) then
    	exit function
    end if

	'' byval row as integer
	if( astNewPARAM( proc, rowexpr ) = NULL ) then
    	exit function
    end if

	'' byval colorflag as integer
	if( colorflagexpr = NULL ) then
		colorflagexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if
	if( astNewPARAM( proc, colorflagexpr ) = NULL ) then
    	exit function
    end if

	function = proc

end function

