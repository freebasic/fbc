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
 * io_locate.c -- locate (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
void fb_ConsoleLocate( int row, int col, int cursor )
{
	int x, y;

	if (!fb_con.inited)
		return;
	
	if ((row <= 0) || (col <= 0))
		fb_ConsoleGetXY(&x, &y);
	
	if (col > 0)
		x = col;
	if (row > 0)
		y = row;

	fprintf(fb_con.f_out, "\e[%d;%dH", y, x);
	if (cursor == 0)
		fputs("\e[?25l", fb_con.f_out);
	else if (cursor == 1)
		fputs("\e[?25h", fb_con.f_out);
}


/*:::::*/
int fb_ConsoleGetX( void )
{
	int x;
	
	fb_ConsoleGetXY(&x, NULL);
	return x;
}

/*:::::*/
int fb_ConsoleGetY( void )
{
	int y;
	
	fb_ConsoleGetXY(NULL, &y);
	return y;
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int x = 0, y = 0;
	
	if (fb_con.inited) {
		/* Note we read reply from stdin, NOT from fb_con.f_in */
		fflush(stdin);
		fputs("\e[6n", fb_con.f_out);
		if (fscanf(stdin, "\e[%d;%dR", &y, &x) != 2)
			x = y = 0;
	}
	if (col)
		*col = x;
	if (row)
		*row = y;
}

