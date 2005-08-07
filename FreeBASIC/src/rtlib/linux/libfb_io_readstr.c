/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * io_hgetstr - console line input function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
char *fb_ConsoleReadStr( char *buffer, int len )
{
	int k, x, y, cols, pos = 0;
	char ch[2] = { 0, '\0' };
	
	if (!fb_con.inited)
		return fgets(buffer, len, stdin);
	
	fb_ConsoleGetSize(&cols, NULL);
	
	do {
		while (((k = fb_hGetCh(TRUE)) == -1) || (k & 0x100))
			;
		/* drop subsequent keypresses, if any; this is needed to avoid escape
		 * sequence parsing problems in the fb_ConsoleGetXY() call below.
		 */
		while (fb_hGetCh(TRUE) >= 0)
			;
		
		fb_ConsoleGetXY(&x, &y);
		
		if (k == 8) {
			if (pos > 0) {
				x--;
				if (x <= 0) {
					x = cols;
					y--;
					if (y <= 0)
						x = y = 1;
				}
				fprintf(fb_con.f_out, "\e[%d;%dH", y, x);
				fputs("\e[1P", fb_con.f_out);
				pos--;
			}
		}
		else if (k != '\t') {
			if (pos < len - 1) {
				buffer[pos++] = ch[0] = k;
				fb_ConsolePrintBuffer(ch, 0);
				if (x == cols)
					fputc('\n', fb_con.f_out);
			}
		}
	} while (k != '\r');
	fputc('\n', fb_con.f_out);
	buffer[pos] = '\0';
	
	return buffer;
}

