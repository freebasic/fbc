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
 * io_printbuff.c -- low-level print to console function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"

#define CTRL_ALWAYS	0x0800D101
#define ENTER_UTF8	"\e%G"
#define EXIT_UTF8  	"\e%@"


/*:::::*/
void fb_ConsolePrintBuffer( char *buffer, int mask )
{
	int len, avail;
	unsigned char *c = buffer;
	
	if (!fb_con.inited) {
		printf("%s", buffer);
		return;
	}
	
	fb_hResize();
	
	/* ToDo: handle scrolling for internal characters/attributes buffer? */
	len = strlen(buffer);
	avail = (fb_con.w * fb_con.h) - (((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1);
	if (avail < len)
		len = avail;
	memcpy(fb_con.char_buffer + ((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1, buffer, len);
	memset(fb_con.attr_buffer + ((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1, fb_con.fg_color | (fb_con.bg_color << 4), len);
	
	for (len = strlen(buffer); len; len--, c++) {
		if (fb_con.inited == INIT_CONSOLE) {
			if ((*c < 32) && ((CTRL_ALWAYS >> *c) & 0x1)) {
				/* This character can't be printed, we must use unicode
				 * Enter UTF-8 and start constructing 0xF000 code
				 */
				fputs(ENTER_UTF8 "\xEF\x80", fb_con.f_out);
				/* Set the last 6 bits */
				fputc(*c | 0x80, fb_con.f_out);
				/* Escape UTF-8 */
				fputs(EXIT_UTF8, fb_con.f_out);
			}
			else if (*c == 128 + 27)
				/* A specially evil code: Meta+ESC, it can't be printed
				 * Just send Unicode 0xF09B to screen
				 */
				fputs(ENTER_UTF8 "\xEF\x82\x9B" EXIT_UTF8, fb_con.f_out);
			else
				fputc(*c, fb_con.f_out);
		}
		else
			fputc(*c, fb_con.f_out);
		
		fb_con.cur_x++;
		if ((*c == 10) || (fb_con.cur_x >= fb_con.w)) {
			fb_con.cur_x = 1;
			fb_con.cur_y++;
			if (fb_con.cur_y > fb_con.h)
				fb_con.cur_y = fb_con.h;
		}
	}
	fflush(fb_con.f_out);
}

