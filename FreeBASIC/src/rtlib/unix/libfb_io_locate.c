/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_locate.c -- locate (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
int fb_ConsoleLocate( int row, int col, int cursor )
{
	int x, y;
	static int visible = 0x10000;

	if (!__fb_con.inited)
		return 0;

	if ((row <= 0) || (col <= 0))
		fb_ConsoleGetXY(&x, &y);

	BG_LOCK();

	if (col > 0)
		x = col;
	if (row > 0)
		y = row;

	if (x <= __fb_con.w)
		__fb_con.cur_x = x;
	else
		__fb_con.cur_x = __fb_con.w;
	if (y <= __fb_con.h)
		__fb_con.cur_y = y;
	else
		__fb_con.cur_y = __fb_con.h;
	fb_hTermOut(SEQ_LOCATE, x-1, y-1);
	if (cursor == 0) {
		fb_hTermOut(SEQ_HIDE_CURSOR, 0, 0);
		visible = 0;
	}
	else if (cursor == 1) {
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		visible = 0x10000;
	}

	BG_UNLOCK();

	return (x & 0xFF) | ((y & 0xFF) << 8) | visible;
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
	int x = __fb_con.cur_x, y = __fb_con.cur_y;

	if (__fb_con.inited) {
		/* Note we read reply from stdin, NOT from __fb_con.f_in */
		BG_LOCK();

#ifdef TARGET_LINUX
		fflush(stdin);
		fb_hTermOut(SEQ_QUERY_CURSOR, 0, 0);
		if (fscanf(stdin, "\e[%d;%dR", &y, &x) != 2)
#endif
		{
			x = __fb_con.cur_x;
			y = __fb_con.cur_y;
		}

		BG_UNLOCK();
	}
	if (col)
		*col = x;
	if (row)
		*row = y;
}

/*:::::*/
FBCALL unsigned int fb_ConsoleReadXY( int x, int y, int colorflag )
{
	unsigned char *buffer;

	if ((!__fb_con.inited) || (x < 1) || (x > __fb_con.w) || (y < 1) || (y > __fb_con.h))
		return 0;

	if (colorflag)
		buffer = __fb_con.attr_buffer;
	else
		buffer = __fb_con.char_buffer;

	return (unsigned int)buffer[((y - 1) * __fb_con.w) + x - 1];
}
