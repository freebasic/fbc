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


'' intrinsic runtime lib console functions (LOCATE, COLOR, CLS, INKEY, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

#define FB_COLOR_FG_DEFAULT		&h00000001
#define FB_COLOR_BG_DEFAULT		&h00000002


	dim shared as FB_RTL_PROCDEF funcdata( 0 to 16 ) = _
	{ _
		/' fb_ConsoleView ( byval toprow as integer = 0, _
							byval botrow as integer = 0 ) as void '/ _
		( _
			@FB_RTL_CONSOLEVIEW, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_ReadXY ( byval x as integer, byval y as integer, _
					   byval colorflag as integer ) as uinteger '/ _
		( _
			@FB_RTL_CONSOLEREADXY, NULL, _
	 		FB_DATATYPE_UINT, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
        /' fb_Width( byval cols as integer = -1, _
                     byval width_arg as integer = -1 ) as integer '/ _
		( _
			@FB_RTL_WIDTH, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_WidthDev( dev as string, byval width_arg as integer = -1 ) as integer '/ _
		( _
			@FB_RTL_WIDTHDEV, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_WidthFile( byval fnum as integer, byval width_arg as integer = -1 ) as integer '/ _
		( _
			@FB_RTL_WIDTHFILE, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' locate( byval row as integer = 0, byval col as integer = 0, _
				   byval cursor as integer = -1, byval start as integer = 0, _
				   byval stop as integer = 0 ) as integer '/ _
		( _
			@"locate", @"fb_Locate", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		5, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' pos( ) as integer '/ _
		( _
			@"pos", @"fb_GetX", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER, _
	 		0 _
		), _
		/' pos( dummy ) as integer '/ _
		( _
			@"pos", @"fb_Pos", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER, _
     		1, _
	 		{ _
	 			( _
		     		FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' csrlin( ) as integer '/ _
		( _
			@"csrlin", @"fb_GetY", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
		), _
		/' cls( byval n as integer = 1 ) as void '/ _
		( _
			@"cls", @"fb_Cls", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 _
	 			) _
	 		} _
		), _
		/' fb_Color( byval fc as integer, byval bc as integer, byval flags as integer ) as integer '/ _
		( _
			@FB_RTL_COLOR, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' inkey ( ) as string '/ _
		( _
			@"inkey", @"fb_Inkey", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_STRSUFFIX or FB_RTL_OPT_NOQB, _
	 		0 _
		), _
		/' inkey ( ) as string '/ _
		( _
			@"inkey", @"fb_InkeyQB", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_STRSUFFIX or FB_RTL_OPT_QBONLY, _
	 		0 _
		), _
		/' getkey ( ) as integer '/ _
		( _
			@"getkey", @"fb_Getkey", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
	 		0 _
	 	), _
		/' pcopy ( byval frompage as integer = -1, byval topage as integer = -1 ) as integer '/ _
		( _
			@"pcopy", @"fb_PageCopy", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' page ( byval src as integer = -1, byval dst as integer = -1 ) as integer '/ _
		( _
			@FB_RTL_PAGESET, @"fb_PageSet", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }



'':::::
sub rtlConsoleModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlConsoleModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlConsoleView _
	( _
		byval topexpr as ASTNODE ptr, _
		byval botexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( CONSOLEVIEW ) )

    '' byval toprow as integer
    if( astNewARG( proc, topexpr ) = NULL ) then
    	exit function
    end if

    '' byval botrow as integer
    if( astNewARG( proc, botexpr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlWidthScreen _
	( _
		byval width_arg as ASTNODE ptr, _
		byval height_arg as ASTNODE ptr, _
        byval isfunc as integer _
    ) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( WIDTH ) )

    '' byval width_arg as integer
    if( width_arg = NULL ) then
    	width_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, width_arg ) = NULL ) then
    	exit function
    end if

    '' byval height_arg as integer
    if( height_arg = NULL ) then
        height_arg = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, height_arg ) = NULL ) then
    	exit function
    end if

    if( isfunc = FALSE ) then
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
function rtlColor _
	( _
		byval fexpr as ASTNODE ptr, _
		byval bexpr as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer flags = any

	function = NULL
	flags = 0

	''
    proc = astNewCALL( PROCLOOKUP( COLOR ) )

    '' byval fore_color as integer
    if( fexpr = NULL ) then
    	fexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	flags or= FB_COLOR_FG_DEFAULT
    end if
    if( astNewARG( proc, fexpr ) = NULL ) then
    	exit function
    end if

    '' byval back_color as integer
    if( bexpr = NULL ) then
    	bexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	flags or= FB_COLOR_BG_DEFAULT
    end if
    if( astNewARG( proc, bexpr ) = NULL ) then
    	exit function
    end if

    '' byval flags as integer
    if( astNewARG( proc, astNewCONSTi( flags, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

	if( isfunc = FALSE ) then
		astAdd( proc )
	end if

	function = proc

end function

'':::::
function rtlPageSet _
	( _
		byval active as ASTNODE ptr, _
		byval visible as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( PAGESET ) )

    '' byval active as integer = -1
    if( active = NULL ) then
    	active = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, active ) = NULL ) then
    	exit function
    end if

    '' byval visible as integer = -1
    if( visible = NULL ) then
    	visible = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, visible ) = NULL ) then
    	exit function
    end if

	if( isfunc = FALSE ) then
		astAdd( proc )
	end if

	function = proc

end function

'':::::
function rtlConsoleReadXY _
	( _
		byval rowexpr as ASTNODE ptr, _
		byval columnexpr as ASTNODE ptr, _
		byval colorflagexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( CONSOLEREADXY ) )

	'' byval column as integer
	if( astNewARG( proc, columnexpr ) = NULL ) then
    	exit function
    end if

	'' byval row as integer
	if( astNewARG( proc, rowexpr ) = NULL ) then
    	exit function
    end if

	'' byval colorflag as integer
	if( colorflagexpr = NULL ) then
		colorflagexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if
	if( astNewARG( proc, colorflagexpr ) = NULL ) then
    	exit function
    end if

	function = proc

end function

