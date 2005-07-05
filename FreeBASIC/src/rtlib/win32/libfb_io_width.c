/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * io_width.c -- width (console, no gfx) for Windows
 *
 * credits: code based on PDCurses, Win32 port by Chris Szurgot (szurgot@itribe.net)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleWidth( int cols, int rows )
{
   	COORD size, max;
   	SMALL_RECT rect;
   	CONSOLE_SCREEN_BUFFER_INFO info;
    int cur;

   	max = GetLargestConsoleWindowSize( fb_out_handle );

   	GetConsoleScreenBufferInfo( fb_out_handle, &info );

   	cur = info.dwSize.X | (info.dwSize.Y << 16);

   	if( cols > 0 )
   		size.X = cols;
   	else
   		size.X = info.dwSize.X;

   	if( rows > 0 )
   		size.Y = rows;
   	else
   		size.Y = info.dwSize.Y;

   	rect.Left = rect.Top = 0;
   	rect.Right = size.X - 1;
   	if( rect.Right > max.X )
      	rect.Right = max.X;

   	rect.Bottom = rect.Top + size.Y - 1;
   	if( rect.Bottom > max.Y )
      	rect.Bottom = max.Y;

	/* */
	fb_ConsoleSetTopBotRows( rect.Top, rect.Bottom );

   	SetConsoleScreenBufferSize( fb_out_handle, size );
   	SetConsoleWindowInfo( fb_out_handle, TRUE, &rect );

   	/* repeat or the window will be only resized */
   	SetConsoleScreenBufferSize( fb_out_handle, size );
   	SetConsoleWindowInfo( fb_out_handle, TRUE, &rect );

   	SetConsoleActiveScreenBuffer( fb_out_handle );

	return cur;
}
