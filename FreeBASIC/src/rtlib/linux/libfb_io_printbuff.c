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

static const char *cp437_utf8 = "\xC3\x87\x00\xC3\xBC\x00\xC3\xA9\x00\xC3\xA2\x00\xC3\xA4\x00"
	"\xC3\xA0\x00\xC3\xA5\x00\xC3\xA7\x00\xC3\xAA\x00\xC3\xAB\x00\xC3\xA8\x00\xC3\xAF\x00\xC3"
	"\xAE\x00\xC3\xAC\x00\xC3\x84\x00\xC3\x85\x00\xC3\x89\x00\xC3\xA6\x00\xC3\x86\x00\xC3\xB4"
	"\x00\xC3\xB6\x00\xC3\xB2\x00\xC3\xBB\x00\xC3\xB9\x00\xC3\xBF\x00\xC3\x96\x00\xC3\x9C\x00"
	"\xC2\xA2\x00\xC2\xA3\x00\xC2\xA5\x00\xE2\x82\xA7\x00\xC6\x92\x00\xC3\xA1\x00\xC3\xAD\x00"
	"\xC3\xB3\x00\xC3\xBA\x00\xC3\xB1\x00\xC3\x91\x00\xC2\xAA\x00\xC2\xBA\x00\xC2\xBF\x00\xE2"
	"\x8C\x90\x00\xC2\xAC\x00\xC2\xBD\x00\xC2\xBC\x00\xC2\xA1\x00\xC2\xAB\x00\xC2\xBB\x00\xE2"
	"\x96\x91\x00\xE2\x96\x92\x00\xE2\x96\x93\x00\xE2\x94\x82\x00\xE2\x94\xA4\x00\xE2\x95\xA1"
	"\x00\xE2\x95\xA2\x00\xE2\x95\x96\x00\xE2\x95\x95\x00\xE2\x95\xA3\x00\xE2\x95\x91\x00\xE2"
	"\x95\x97\x00\xE2\x95\x9D\x00\xE2\x95\x9C\x00\xE2\x95\x9B\x00\xE2\x94\x90\x00\xE2\x94\x94"
	"\x00\xE2\x94\xB4\x00\xE2\x94\xAC\x00\xE2\x94\x9C\x00\xE2\x94\x80\x00\xE2\x94\xBC\x00\xE2"
	"\x95\x9E\x00\xE2\x95\x9F\x00\xE2\x95\x9A\x00\xE2\x95\x94\x00\xE2\x95\xA9\x00\xE2\x95\xA6"
	"\x00\xE2\x95\xA0\x00\xE2\x95\x90\x00\xE2\x95\xAC\x00\xE2\x95\xA7\x00\xE2\x95\xA8\x00\xE2"
	"\x95\xA4\x00\xE2\x95\xA5\x00\xE2\x95\x99\x00\xE2\x95\x98\x00\xE2\x95\x92\x00\xE2\x95\x93"
	"\x00\xE2\x95\xAB\x00\xE2\x95\xAA\x00\xE2\x94\x98\x00\xE2\x94\x8C\x00\xE2\x96\x88\x00\xE2"
	"\x96\x84\x00\xE2\x96\x8C\x00\xE2\x96\x90\x00\xE2\x96\x80\x00\xCE\xB1\x00\xC3\x9F\x00\xCE"
	"\x93\x00\xCF\x80\x00\xCE\xA3\x00\xCF\x83\x00\xC2\xB5\x00\xCF\x84\x00\xCE\xA6\x00\xCE\x98"
	"\x00\xCE\xA9\x00\xCE\xB4\x00\xE2\x88\x9E\x00\xCF\x86\x00\xCE\xB5\x00\xE2\x88\xA9\x00\xE2"
	"\x89\xA1\x00\xC2\xB1\x00\xE2\x89\xA5\x00\xE2\x89\xA4\x00\xE2\x8C\xA0\x00\xE2\x8C\xA1\x00"
	"\xC3\xB7\x00\xE2\x89\x88\x00\xC2\xB0\x00\xE2\x88\x99\x00\xC2\xB7\x00\xE2\x88\x9A\x00\xE2"
	"\x81\xBF\x00\xC2\xB2\x00\xE2\x96\xA0\x00\xC2\xA0\x00";


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
		else if ((*c > 127) && (fb_con.inited == INIT_X11)) {
			/* Use UTF8 to ensure CP437 compatibility under X */
			code = cp437_utf8;
			for (i = 128; i < *c; i++) {
				while (*code)
					code++;
				code++;
			}
			fputs(code, fb_con.f_out);
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

