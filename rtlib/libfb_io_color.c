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
 * io_color.c -- color (console, no gfx) function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_colors.h"

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#ifndef DISABLE_NCURSES
#include <curses.h>
#endif
#endif

#ifdef WIN32

/* globals */
int colorlut[16] = { FB_COLOR_BLACK, FB_COLOR_BLUE,
					 FB_COLOR_GREEN, FB_COLOR_CYAN,
					 FB_COLOR_RED, FB_COLOR_MAGENTA,
					 FB_COLOR_BROWN, FB_COLOR_WHITE,
					 FB_COLOR_GREY, FB_COLOR_LBLUE,
					 FB_COLOR_LGREEN, FB_COLOR_LCYAN,
					 FB_COLOR_LRED, FB_COLOR_LMAGENTA,
					 FB_COLOR_YELLOW, FB_COLOR_BWHITE };

int fb_last_bc = FB_COLOR_BLACK,
	fb_last_fc = FB_COLOR_WHITE;

#else

int fb_last_bc = 0,
	fb_last_fc = 15;

#endif

/*:::::*/
void fb_ConsoleColor( int fc, int bc )
{
#ifdef WIN32

    if( fc >= 0 )
    	fb_last_fc = colorlut[fc & 15];

    if( bc >= 0 )
    	fb_last_bc = colorlut[bc & 7];

    SetConsoleTextAttribute( GetStdHandle( STD_OUTPUT_HANDLE ), fb_last_fc + (fb_last_bc << 4) );

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	int pair;
	
	if (!has_color())
		return;
	
	if (fc >= 0)
		fb_last_fc = (fc & 0xf);
	if (bc >= 0)
		fb_last_bc = (bc & 0x7);
	
	pair = ((fb_last_fc & 0x7) | (fb_last_bc << 3));
	attrset(COLOR_PAIR(pair) | (fb_last_fc & 0x8 ? A_BOLD : 0));
#endif

#endif /* WIN32 */

}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

	GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );

	return info.wAttributes;

#else /* WIN32 */

	int res = 0;
	
#ifndef DISABLE_NCURSES
	attr_t attr;
	short pair;
	
	attr_get(&attr, &pair, NULL);
	res = (pair & 0x7) | (attr & A_BOLD ? 0x8 : 0) | ((pair & 0x38) << 4);
#endif

	return res;

#endif /* WIN32 */

}
