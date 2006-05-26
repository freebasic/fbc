/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
	size_t avail, avail_len;
	const unsigned char *c = (const unsigned char *) buffer;
	const char *code;
	int i;
	
    if (!fb_con.inited) {
        fwrite(buffer, len, 1, stdout);
        fflush(stdout);
		return;
	}
	
	fb_hResize();
	
	/* ToDo: handle scrolling for internal characters/attributes buffer? */
    avail = (fb_con.w * fb_con.h) - (((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1);
    avail_len = len;
	if (avail < avail_len)
		avail_len = avail;
	memcpy(fb_con.char_buffer + ((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1, buffer, avail_len);
	memset(fb_con.attr_buffer + ((fb_con.cur_y - 1) * fb_con.w) + fb_con.cur_x - 1, fb_con.fg_color | (fb_con.bg_color << 4), avail_len);
	
	for (; len; len--, c++) {
		if (*c < 32) {
			if ((CTRL_ALWAYS >> *c) & 0x1) {
				/* This character can't be printed, we must use unicode
				 * Enter UTF-8 and start constructing 0xF000 code
				 */
				fputs(ENTER_UTF8 "\xEF\x80", fb_con.f_out);
				/* Set the last 6 bits */
				fputc(*c | 0x80, fb_con.f_out);
				/* Escape UTF-8 */
				fputs(EXIT_UTF8, fb_con.f_out);
			}
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

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}

