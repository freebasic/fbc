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

dim shared as integer mouse_installed = FALSE

dim shared as integer screen_saved = FALSE
dim shared as any ptr screen_data = NULL

dim shared as integer cursor_x = 0, cursor_y = 0

dim shared as any ptr cursor_gfx = NULL
dim shared as integer cursor_drawn = FALSE
dim shared as integer cursor_visible = FALSE

'' ==========================================================================

'':::::
private sub blitCursor(byval x as integer, byval y as integer)
	dim as integer xx, yy
	xx = x * 8
	yy = y * 8
	put (xx,yy),cursor_gfx, xor
end sub

'':::::
public sub Screen_BlinkCursor()
	static dLast as double, dNow as double
	if( cursor_visible ) then
		dNow = Timer
		if( dNow - dLast > 0.25 ) then
			dLast = dNow
			if( cursor_drawn ) then
				blitCursor( cursor_x, cursor_y )
				cursor_drawn = FALSE
			else
				blitCursor( cursor_x, cursor_y )
				cursor_drawn = TRUE
			end if
		end if
	end if
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

	mx shr= 3
	my shr= 3

end sub

'':::::
public sub Screen_ShowMouse ( )
end sub

'':::::
public sub Screen_HideMouse ( )
end sub

'':::::
public sub Screen_Init ( )
	screen 12
	width 80, 60
	cursor_gfx = imagecreate( 8,8,15 ) 
	Screen_ShowCursor()
end sub

'':::::
public sub Screen_Shut ( )
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
	yy = y * 8
	xx = x * 8
	ww = size * 8
	line(xx,yy)-(xx+ww-1,yy+7), screen_bc, bf
	Draw String (xx,yy), *text, cast(ubyte, screen_fc)

	if( cursor_drawn ) then
		if( cursor_x >= x ) then
			if( cursor_y = y ) then
				if( cursor_x < x + size ) then
					blitCursor( cursor_x, cursor_y )
				end if
			end if
		end if
	end if

end sub

public sub Screen_DrawTextAttrib _
	( _
			byval x as integer, _
			byval y as integer, _
			byval text as char_attrib_t ptr, _
			byval size as integer _
	)
	dim as integer i,xx,yy
	if( size <= 0 ) then
		exit sub
	end if
	yy = y * 8
	xx = x * 8
	for i = 0 to size - 1
		line (xx,yy)-(xx+7,yy+7),text[i].attrib shr 4, bf
		Draw String (xx,yy), chr(text[i].char), text[i].attrib and 15
		xx += 8
	next i
	
	if( cursor_drawn ) then
		if( cursor_x >= x ) then
			if( cursor_y = y ) then
				if( cursor_x < x + size ) then
					blitCursor( cursor_x, cursor_y )
				end if
			end if
		end if
	end if

end sub

'':::::
public sub Screen_SetCursorPos _
	( _
		byval x as integer, _
		byval y as integer _
	)

	if(( cursor_x <> x ) or ( cursor_y <> y )) then

		if( cursor_drawn ) then
			blitCursor( cursor_x, cursor_y )
		end if

		cursor_x = x
		cursor_y = y

		if( cursor_visible ) then
			blitCursor( cursor_x, cursor_y )
			cursor_drawn = TRUE
		end if		
	
	end if

end sub

'':::::
public sub Screen_GetCursorPos _
	( _
		byref x as integer, _
		byref y as integer _
	)
	x = cursor_x
	y = cursor_y
end sub

'':::::
public sub Screen_ShowCursor ( )
	if( cursor_visible = FALSE ) then
		cursor_visible = TRUE
	end if
end sub

'':::::
public sub Screen_HideCursor ( )
	if( cursor_visible ) then
		cursor_visible = FALSE
	end if
end sub

'':::::
public function Screen_GetCursorState() as integer
	return cursor_visible
end function

'':::::
public function Screen_GetCols ( ) as integer
	return 80
end function

'':::::
public function Screen_GetRows ( ) as integer
	return 60
end function

'':::::
public sub Screen_Save ( )
end sub

'':::::
public sub Screen_Restore ( byval bRelease as integer )
end sub
