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

#include "fbhelp_screen.bi"

dim shared as integer DEFAULT_FORECOLOR = 7
dim shared as integer DEFAULT_BACKCOLOR = 0
dim shared as integer screen_fc = 7
dim shared as integer screen_bc = 0
dim shared as integer screen_attrib = 7

dim shared as integer screen_colormode = TRUE

'':::::
public sub Screen_SetColorMode( byval flag as integer )
	screen_colormode = flag	
end sub

'':::::
public sub Screen_SetColor _
	( _
		byval fc as integer, _
		byval bc as integer _
	)

	screen_fc = fc
	screen_bc = bc
	screen_attrib = (fc or (bc shl 4)) and &hff

end sub

'':::::
public function Screen_SetCursorState( byval bVisible as integer ) as integer
	dim ret as integer
	ret = Screen_GetCursorState()
	if( bVisible ) then
		Screen_ShowCursor()
	else
		Screen_HideCursor()
	end if
	return ret
end function
