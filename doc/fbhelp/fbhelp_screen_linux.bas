''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

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
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

'' chng: jul/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp_screen.bi"
#include once "crt/stdio.bi"

#inclib "fbgfx"

dim shared as integer cursor_x = 0, cursor_y = 0

dim shared as integer cursor_visible = FALSE

''#define SIG_IGN 1

#define SIGWINCH 28

type sighandler_t as sub cdecl ( byval sig as integer )

declare function signal cdecl alias "signal" ( byval sig as integer, byval handler as sighandler_t ) as sighandler_t
declare function raise cdecl alias "raise" ( byval sig as integer ) as integer

'' ==========================================================================

'':::::
private sub screen_resize cdecl ( byval sig as integer )
	
	static prev_handler as sighandler_t = NULL

	if( prev_handler ) then
		prev_handler( sig )
	end if

	'' set a global var that can be checked later
	'' to know that we were resized

	prev_handler = signal( SIGWINCH, procptr(screen_resize) )

end sub

'':::::
public sub Screen_BlinkCursor()
end sub

'':::::
public function Screen_MouseInstalled ( ) as integer
	return TRUE
end function

'':::::
public sub Screen_GetMouse _
	( _
		byref mx as integer, _
		byref my as integer, _
		byref mw as integer, _
		byref mb as integer _
	)

	static as integer last_mx, last_my, last_mw, last_mb

	GetMouse mx, my, mw, mb

	if( mx = -1 ) then
		mx = last_mx
		my = last_my
		mw = 0
		mb = last_mb
	end if

	last_mx = mx
	last_my = my
	last_mw = mw
	last_mb = mb

end sub

'':::::
public sub Screen_ShowMouse ( )
end sub

'':::::
public sub Screen_HideMouse ( )
end sub

'':::::
public sub Screen_Init ( )
	screen 0
	''screen_resize SIGWINCH
	Screen_ShowCursor()
end sub

'':::::
public sub Screen_Shut ( )
	color 7,0
	cls
end sub

'':::::
public sub Screen_DrawText _
	( _
			byval x as integer, _
			byval y as integer, _
			byval text as zstring ptr, _
			byval size as integer _
	)
	dim as integer i,xx,yy,ww

	if( size = -1) then
		size = len( *text )
	end if

	if( size <= 0 ) then
		exit sub
	end if
	
	color screen_fc, screen_bc
	locate y + 1, x + 1, 0
	print *text;

	locate y + 1, x + 1, 0

end sub

public sub Screen_DrawTextAttrib _
	( _
			byval x as integer, _
			byval y as integer, _
			byval text as char_attrib_t ptr, _
			byval size as integer _
	)
	dim as integer i

	if( size <= 0 ) then
		exit sub
	end if

	for i = 0 to size - 1
		locate y + 1, x + i + 1
		color 4,4
		color text[i].attrib and 15, text[i].attrib shr 4
		print chr(text[i].char);
	next
	
end sub

'':::::
public sub Screen_SetCursorPos _
	( _
		byval x as integer, _
		byval y as integer _
	)

	if(( cursor_x <> x ) or ( cursor_y <> y )) then
		locate y + 1, x + 1, cursor_visible

		cursor_x = x
		cursor_y = y

	end if

end sub

'':::::
public sub Screen_GetCursorPos _
	( _
		byref x as integer, _
		byref y as integer _
	)
	x = csrlin()
	y = pos()
end sub

'':::::
public sub Screen_ShowCursor ( )
	if( cursor_visible = FALSE ) then
		locate , , 1
		cursor_visible = TRUE
	end if
end sub

'':::::
public sub Screen_HideCursor ( )
	if( cursor_visible ) then
		locate , , 0
		cursor_visible = FALSE
	end if
end sub

'':::::
public function Screen_GetCursorState() as integer
	return cursor_visible
end function

'':::::
public function Screen_GetCols ( ) as integer
	return loword(width())
end function

'':::::
public function Screen_GetRows ( ) as integer
	return hiword(width())
end function

'':::::
public sub Screen_Save ( )
end sub

'':::::
public sub Screen_Restore ( byval bRelease as integer )
end sub
