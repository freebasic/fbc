#ifndef __FBHELP_SCREEN_BI__
#define __FBHELP_SCREEN_BI__

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


	#include once "common.bi"

	#ifdef __FB_WIN32__
		type char_attrib_t field = 1
			union
				as ubyte char
				as ushort unicodechar
			end union
			as ushort attrib
		end type
	#else
		type char_attrib_t field = 1
			as ubyte char
			as ubyte attrib
		end type
	#endif

	declare sub Screen_Init ( )

	declare sub Screen_Shut ( )

	declare sub Screen_DrawText _
		( _
			byval x as integer, _
			byval y as integer, _
			byval text as zstring ptr, _
			byval size as integer = -1 _
		)

	declare sub Screen_DrawTextAttrib _
		( _
			byval x as integer, _
			byval y as integer, _
			byval text as char_attrib_t ptr, _
			byval size as integer _
		)

	declare sub Screen_SetCursorPos _
		( _
			byval x as integer, _
			byval y as integer _
		)

	declare sub Screen_GetCursorPos _
		( _
			byref x as integer, _
			byref y as integer _
		)

	declare sub Screen_SetColor _
		( _
			byval fc as integer, _
			byval bc as integer _
		)

	declare sub Screen_ShowCursor ( )
	declare sub Screen_HideCursor ( )
	declare function Screen_SetCursorState( byval bVisible as integer ) as integer
	declare function Screen_GetCursorState() as integer
	declare function Screen_GetCols ( ) as integer
	declare function Screen_GetRows ( ) as integer

	declare sub Screen_Save ( )
	declare sub Screen_Restore ( byval bRelease as integer )

	declare sub Screen_GetMouse _
		( _
			byref mx as integer, _
			byref my as integer, _
			byref mw as integer, _
			byref mb as integer _
		)

	declare sub Screen_ShowMouse ( )
	declare sub Screen_HideMouse ( )
	declare function Screen_MouseInstalled ( ) as integer
	declare sub Screen_SetColorMode( byval flag as integer )
	declare sub Screen_BlinkCursor()
	
	extern as integer DEFAULT_FORECOLOR
	extern as integer DEFAULT_BACKCOLOR

	extern as integer screen_fc
	extern as integer screen_bc
	extern as integer screen_attrib
	extern as integer screen_colormode

	#define MAX_LINE_WIDTH 160

#endif
