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
 * init.c -- libfb initialization
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

#ifdef WIN32
#include <float.h>
#else
#ifndef DISABLE_NCURSES
#include <curses.h>

static color[8] = { COLOR_BLACK, COLOR_BLUE, COLOR_GREEN, COLOR_CYAN,
					COLOR_RED, COLOR_MAGENTA, COLOR_YELLOW, COLOR_WHITE };
#endif
#endif

/*:::::*/
FBCALL void fb_Init ( void )
{
	int i;

#ifdef WIN32

    /* set FPU precision to 64-bit and round to nearest (as in QB) */
	_controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );

#else

#if defined(__GNUC__) && defined(__i386__)
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
#endif

#ifndef DISABLE_NCURSES
	/* Init ncurses */
	system("echo -e \"\\033(U\"");
	initscr();
	cbreak();
	noecho();
	nonl();
	nodelay(stdscr, TRUE);
	keypad(stdscr, TRUE);
	scrollok(stdscr, FALSE);
	if (has_colors() && (start_color() == OK) && (COLOR_PAIRS >= 64)) {
		for (i = 0; i < 64; i++) {
			if (i == 0) continue;
			init_pair(i, color[i % 8], color[i / 8]);
		}
	}
#endif

#endif

	/////atexit( &fb_End );

}
