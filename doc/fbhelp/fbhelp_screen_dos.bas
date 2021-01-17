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


#include "dos/conio.bi"
#include "dos/pc.bi"
#include "dos/dpmi.bi"

dim shared as __dpmi_regs regs

#include once "common.bi"
#include once "fbhelp_screen.bi"

dim shared as integer screen_saved = FALSE
dim shared as any ptr screen_data = NULL
dim shared as integer save_x = 0
dim shared as integer save_y = 0
dim shared as integer save_w = 0
dim shared as integer save_h = 0

dim shared as integer mouse_installed = FALSE

dim shared as integer cursor_visible = FALSE

'' ==========================================================================

private function dos_int86( byval vec as integer) as integer

  dim as integer rc
  regs.x.ss = 0
  regs.x.sp = 0
  regs.x.flags = 0

  __dpmi_simulate_real_mode_interrupt ( vec, @regs )

  return (rc <> 0) or ((regs.x.flags and 1) <> 0)

end function

'':::::
public sub Screen_BlinkCursor()
end sub

'':::::
public function Screen_MouseInstalled ( ) as integer
	return mouse_installed
end function

'':::::
public sub Screen_GetMouse _
	( _
		byref mx as integer, _
		byref my as integer, _
		byref mw as integer, _
		byref mb as integer _
	)

	if( mouse_installed > 0 ) then
		regs.x.ax = &h3
		' __dpmi_int(&h33, @regs)
		dos_int86( &h33 )

		mb = regs.x.bx
		mx = regs.x.cx \ 8
		my = regs.x.dx \ 8
		mw = 0
	end if

end sub

'':::::
public sub Screen_ShowMouse ( )
	if( mouse_installed > 0 ) then
		regs.x.ax = &h1
		' __dpmi_int(&h33, @regs)
		dos_int86( &h33 )
	end if
end sub

'':::::
public sub Screen_HideMouse ( )
	if( mouse_installed > 0 ) then
		regs.x.ax = &h2
		' __dpmi_int(&h33, @regs)
		dos_int86( &h33 )
	end if
end sub

'':::::
public sub Screen_Init ( )

	
	regs.x.ax = &h0
	' __dpmi_int(&h33, @regs)
	dos_int86( &h33 )

	if( regs.x.ax <> 0 ) then
		mouse_installed = regs.x.bx

	else
		mouse_installed = 0
	end if

	Screen_Save()

	Screen_ShowMouse()

end sub

'':::::
public sub Screen_Shut ( )
	Screen_HideMouse()
	Screen_Restore( TRUE )
end sub


'':::::
public sub Screen_DrawText _
	( _
			byval x as integer, _
			byval y as integer, _
			byval text as zstring ptr, _
			byval size as integer _
	)

	dim as integer i
	
	static ch(0 to 79) as char_attrib_t

	if( size = -1) then
		size = len( *text )
	end if
	if( size <= 0 ) then
		exit sub
	end if

	for i = 0 to size - 1
		ch(i).char = text[i]
		ch(i).attrib = screen_attrib
	next i

	puttext( x + 1, y + 1, x + size - 1 + 1, y + 1, @ch(0) )

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

	puttext( x + 1, y + 1, x + size - 1 + 1, y + 1, text )

end sub

'':::::
public sub Screen_SetCursorPos _
	( _
		byval x as integer, _
		byval y as integer _
	)

	gotoxy(x+1, y+1)

end sub

'':::::
public sub Screen_GetCursorPos _
	( _
		byref x as integer, _
		byref y as integer _
	)

	x = wherex() - 1
	y = wherey() - 1

end sub

'':::::
public sub Screen_ShowCursor ( )

	cursor_visible = TRUE
	_setcursortype( _NORMALCURSOR )	

end sub

'':::::
public sub Screen_HideCursor ( )

	cursor_visible = FALSE
	_setcursortype( _NOCURSOR )	

end sub

'':::::
public function Screen_GetCursorState() as integer
	return cursor_visible
end function

'':::::
public function Screen_GetCols ( ) as integer
	return(ScreenCols())	
end function

'':::::
public function Screen_GetRows ( ) as integer
	return(ScreenRows())	
end function

'':::::
public sub Screen_Save ( )

	dim as any ptr p

	screen_saved = FALSE

	save_x = wherex() - 1
	save_y = wherey() - 1
	save_w = ScreenCols()
	save_h = ScreenRows()

	p = reallocate( screen_data, sizeof( char_attrib_t ) * save_w * save_h )
	if( p <> NULL ) then

		screen_data = p

		gettext( 1, 1, save_w, save_h, screen_data )

		screen_saved = TRUE

	end if

end sub

'':::::
public sub Screen_Restore ( byval bRelease as integer )
	
	if( screen_saved ) then

		if( screen_data <> NULL ) then

			puttext( 1, 1, save_w, save_h, screen_data )

			Screen_SetCursorPos( save_x, save_y )
					
		end if

	end if

	if( bRelease <> NULL ) then
		
		if( screen_data <> NULL ) then
			deallocate screen_data
			screen_data = NULL
		end if

		screen_saved = FALSE

	end if

end sub
