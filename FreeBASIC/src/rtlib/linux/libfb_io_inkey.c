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
 * io_inkey.c -- inkey$ function for Linux console mode apps
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif


#ifndef DISABLE_NCURSES

/*:::::*/
static int fb_hKeyCursesToQB( int key )
{
	switch( key )
	{
		case KEY_DOWN:		return 0xFF50;
		case KEY_UP:		return 0xFF48;
		case KEY_LEFT:		return 0xFF4B;
		case KEY_RIGHT:		return 0xFF4D;
		case KEY_HOME:		return 0xFF47;
		case KEY_BACKSPACE:	return 0x0008;
		case KEY_F(1):		return 0xFF3B;
		case KEY_F(2):		return 0xFF3C;
		case KEY_F(3):		return 0xFF3D;
		case KEY_F(4):		return 0xFF3E;
		case KEY_F(5):		return 0xFF3F;
		case KEY_F(6):		return 0xFF40;
		case KEY_F(7):		return 0xFF41;
		case KEY_F(8):		return 0xFF42;
		case KEY_F(9):		return 0xFF43;
		case KEY_F(10):		return 0xFF44;
		case KEY_F(11):		return 0xFF85;
		case KEY_F(12):		return 0xFF86;
		case KEY_DC:		return 0xFF53;
		case KEY_IC:		return 0xFF52;
		case KEY_NPAGE:		return 0xFF51;
		case KEY_PPAGE:		return 0xFF49;
		case KEY_END:		return 0xFF4F;
	}
	return -1;
}

#endif


/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING 	 *res;
	unsigned int k;
	int			 chars;

#ifndef DISABLE_NCURSES
	int ch;

	if ((ch = getch()) != ERR) {
		chars = 1;
		if (ch > 255) {
			ch = fb_hKeyCursesToQB(ch);
			if ((ch > 0) && (ch & 0xFF00)) {
				chars = 2;
				ch &= 0xFF;
			}
		}
		if (ch > 0) {

			res = (FBSTRING *)fb_hStrAllocTmpDesc();

			fb_hStrAllocTemp(res, chars);

			if( chars > 1 )
				res->data[0] = 255;					/* note: can't use '\0' here as in qb */

			res->data[chars-1] = (unsigned char)ch;
			res->data[chars-0] = '\0';
		}
		else
			res = &fb_strNullDesc;
	}
	else
#endif
		res = &fb_strNullDesc;

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = 0;

#ifndef DISABLE_NCURSES
	while ((k = getch()) == ERR)
		;
#endif

	return k;
}
