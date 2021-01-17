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

#include "windows.bi"

#include once "common.bi"
#include once "fbhelp_screen.bi"

dim shared as integer mouse_installed = FALSE

dim shared as integer screen_saved = FALSE
dim shared as CONSOLE_SCREEN_BUFFER_INFO screen_csbi
dim shared as any ptr screen_data = NULL

dim shared as integer cursor_visible = FALSE

'' ==========================================================================

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

	GetMouse mx, my, mw, mb

end sub

'':::::
public sub Screen_ShowMouse ( )
	SetMouse , , 1
end sub

'':::::
public sub Screen_HideMouse ( )
	SetMouse , , 0
end sub

public sub Screen_SetSize( byval cols as integer, byval rows as integer, _
	byval buf_cols as integer, byval buf_rows as integer )

	dim as HANDLE hOut = GetStdHandle( STD_OUTPUT_HANDLE )
	dim as CONSOLE_SCREEN_BUFFER_INFO csbi
	dim as SMALL_RECT srWindow
	dim as COORD maxSize

	GetConsoleScreenBufferInfo(hOut, @csbi)

	maxSize = GetLargestConsoleWindowSize(hOut)

	if( cols > maxSize.X ) then cols = maxSize.X
	if( rows > maxSize.Y ) then rows = maxSize.Y

	if( buf_cols < cols ) then buf_cols = cols
	if( buf_rows < rows ) then buf_rows = rows

	with srWindow
		.Left   = 0
		.Right  = cols - 1
		.Top    = 0
		.Bottom = rows - 1
	end with

	maxSize.X = buf_cols
	maxSize.Y = buf_rows

	if( csbi.dwSize.X * csbi.dwSize.Y > maxSize.x * maxSize.y ) then
		SetConsoleWindowInfo(hOut, TRUE, @srWindow)
		SetConsoleScreenBufferSize(hOut, maxSize)
	else
		SetConsoleScreenBufferSize(hOut, maxSize)
		SetConsoleWindowInfo(hOut, TRUE, @srWindow)
	end if

end sub

'':::::
public sub Screen_Init ( )
	Screen_Save( )
	Screen_SetSize( 80, 50, 80, 50 )
end sub

'':::::
public sub Screen_Shut ( )
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

	dim as HANDLE hOut = GetStdHandle( STD_OUTPUT_HANDLE )
	dim as COORD dwBufferSize, dwBufferCoord = ( 0, 0 )
	dim as SMALL_RECT out_rect
	dim as integer i
	
	static ch(0 to 79) as CHAR_INFO

	if( size = -1 ) then
		size = len( *text )
	end if
	if( size <= 0 ) then
		exit sub
	end if

	for i = 0 to size - 1
		ch(i).Char.AsciiChar = text[i]
		ch(i).Attributes = screen_attrib
	next i

	with dwBufferSize
		.X = size
		.Y = 1
	end with

	with out_rect
		.Left   = x
		.Right  = x + size - 1
		.Top    = y
		.Bottom = y
	end with

	WriteConsoleOutput( hOut, _
		@ch(0), _
		dwBufferSize, _
		dwBufferCoord, _
		@out_rect _
	)

end sub

public sub Screen_DrawTextAttrib _
	( _
			byval x as integer, _
			byval y as integer, _
			byval text as char_attrib_t ptr, _
			byval size as integer _
	)

	dim as HANDLE hOut = GetStdHandle( STD_OUTPUT_HANDLE )
	dim as COORD dwBufferSize, dwBufferCoord = ( 0, 0 )
	dim as SMALL_RECT out_rect
	dim as integer i
	
	static ch(0 to 79) as CHAR_INFO

	if( size <= 0 ) then
		exit sub
	end if

	for i = 0 to size - 1
		ch(i).Char.AsciiChar = text[i].char
		ch(i).Attributes = text[i].attrib
	next i

	with dwBufferSize
		.X = size
		.Y = 1
	end with

	with out_rect
		.Left   = x
		.Right  = x + size - 1
		.Top    = y
		.Bottom = y
	end with

	WriteConsoleOutput( hOut, _
		@ch(0), _
		dwBufferSize, _
		dwBufferCoord, _
		@out_rect _
	)

end sub

'':::::
public sub Screen_SetCursorPos _
	( _
		byval x as integer, _
		byval y as integer _
	)

	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim as COORD dwWriteCoord = ( x, y )

	SetConsoleCursorPosition(hStdOut, dwWriteCoord)

end sub

'':::::
public sub Screen_GetCursorPos _
	( _
		byref x as integer, _
		byref y as integer _
	)

	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim as CONSOLE_SCREEN_BUFFER_INFO csbi
	GetConsoleScreenBufferInfo(hStdOut, @csbi)
	x = csbi.dwCursorPosition.x
	y = csbi.dwCursorPosition.y

end sub

'':::::
public sub Screen_ShowCursor ( )
	
	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim curs as CONSOLE_CURSOR_INFO

	GetConsoleCursorInfo( hStdOut, @curs )
	if( curs.bVisible = FALSE ) then
		curs.bVisible = TRUE
		SetConsoleCursorInfo( hStdOut, @curs )
	end if

end sub

'':::::
public sub Screen_HideCursor ( )

	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim curs as CONSOLE_CURSOR_INFO

	GetConsoleCursorInfo( hStdOut, @curs )
	if( curs.bVisible ) then
		curs.bVisible = FALSE
		SetConsoleCursorInfo( hStdOut, @curs )
	end if

end sub

'':::::
public function Screen_GetCursorState() as integer

	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim curs as CONSOLE_CURSOR_INFO

	GetConsoleCursorInfo( hStdOut, @curs )
	return curs.bVisible

end function

'':::::
public function Screen_GetCols ( ) as integer
	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim as CONSOLE_SCREEN_BUFFER_INFO csbi
	GetConsoleScreenBufferInfo(hStdOut, @csbi)
	return(csbi.dwSize.X)
end function

'':::::
public function Screen_GetRows ( ) as integer
	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim as CONSOLE_SCREEN_BUFFER_INFO csbi
	GetConsoleScreenBufferInfo(hStdOut, @csbi)
	return(csbi.dwSize.Y)
end function

'':::::
public sub Screen_Save ( )

	dim as HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
	dim as COORD dwBufferSize, dwBufferCoord = ( 0, 0 )
	dim as SMALL_RECT out_rect
	dim as any ptr p

	screen_saved = FALSE

	if( GetConsoleScreenBufferInfo(hStdOut, @screen_csbi) ) then

		p = reallocate( screen_data, sizeof( CHAR_INFO ) * screen_csbi.dwSize.X * screen_csbi.dwSize.Y )
		if( p <> NULL ) then

			screen_data = p

			with dwBufferSize
				.X = screen_csbi.dwSize.X
				.Y = screen_csbi.dwSize.Y
			end with

			with out_rect
				.Left   = 0
				.Right  = screen_csbi.dwSize.X - 1
				.Top    = 0
				.Bottom = screen_csbi.dwSize.Y - 1
			end with

			if( ReadConsoleOutput( hStdOut, _
				screen_data, _
				dwBufferSize, _
				dwBufferCoord, _
				@out_rect _
			) ) then

				screen_saved = TRUE

			end if

		end if

	end if

end sub

'':::::
public sub Screen_Restore ( byval bRelease as integer )
	
	if( screen_saved ) then

		if( screen_data <> NULL ) then

			dim as HANDLE hOut = GetStdHandle( STD_OUTPUT_HANDLE )
			dim as COORD dwBufferCoord = ( 0, 0 ), maxsize, bufsize
			dim as SMALL_RECT out_rect
			dim as integer i, cols, rows, buf_cols, buf_rows

			cols = screen_csbi.srWindow.Right - screen_csbi.srWindow.Left + 1
			rows = screen_csbi.srWindow.Bottom - screen_csbi.srWindow.Top + 1

			buf_cols = screen_csbi.dwSize.X
			buf_rows = screen_csbi.dwSize.Y

			Screen_SetSize( cols, rows, buf_cols, buf_rows )

			with out_rect
				.Left   = 0
				.Right  = buf_cols - 1
				.Top    = 0
				.Bottom = buf_rows - 1
			end with

			WriteConsoleOutput( hOut, _
				screen_data, _
				screen_csbi.dwSize, _
				dwBufferCoord, _
				@out_rect _
			)

			Screen_SetCursorPos( screen_csbi.dwCursorPosition.X, screen_csbi.dwCursorPosition.Y )
					
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
