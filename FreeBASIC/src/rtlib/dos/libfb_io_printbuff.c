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
 * io_printbuff.c -- low-level print to console function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>
#include <sys/farptr.h>
#include <go32.h>
#include <pc.h>

#define TEXT_ADDR	0xB8000

/*:::::*/
void fb_ConsolePrintBuffer( char *buffer, int mask )
{
	int top, bot;
	int no_scroll = FALSE;
	int len;
	int end_char;
	
	top = (fb_viewTopRow >= 0 ? fb_viewTopRow + 1 : 1);
	bot = (fb_viewBotRow >= 0 ? fb_viewBotRow + 1 : 1);
	
	/* if no newline and row at bottom and col+string at right, don't scroll */
	if ( ((mask & FB_PRINT_NEWLINE) == 0)  && (wherey() == bot - top + 1) ) {
		len = strlen(buffer);
		end_char = buffer[len - 1];
		buffer[len - 1] = '\0';
		no_scroll = TRUE;
	}
	
	cprintf( "%s", buffer );
	
	if (no_scroll) {
		/* write the last character */
		/*_farpokew(	_dos_ds,
				TEXT_ADDR + (wherey() + top - 2) * ScreenCols() * 2 + (wherex() - 1) * 2,
				end_char | ScreenAttrib << 8);*/
		_farpokew(	_dos_ds,
				TEXT_ADDR + (((wherey() + top - 2) * ScreenCols() + wherex() - 1) << 1),
				end_char | ScreenAttrib << 8);
	}
	
	if (mask & FB_PRINT_NEWLINE) {
		gotoxy(1, wherey()); /* carriage return */
	}

}

