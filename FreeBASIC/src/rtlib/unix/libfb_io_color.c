/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * io_color.c -- color (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
int fb_ConsoleColor( int fc, int bc, int flags )
{
	const char map[8] = { 0, 4, 2, 6, 1, 5, 3, 7 };
	int old_fg = __fb_con.fg_color;
	int old_bg = __fb_con.bg_color;
	int force = FALSE;
	
	if (!__fb_con.inited)
		return old_fg | (old_bg << 16);
	
	if (!(flags & FB_COLOR_FG_DEFAULT))
		__fb_con.fg_color = (fc & 0xF);
	if (!(flags & FB_COLOR_BG_DEFAULT))
		__fb_con.bg_color = (bc & 0xF);
	
	if ((__fb_con.inited == INIT_CONSOLE) || (__fb_con.term_type != TERM_XTERM)) {
		/* console and any terminal but xterm do not support extended color attributes and only allow 16+8 colors */
		if (__fb_con.fg_color != old_fg) {
			if ((__fb_con.fg_color ^ old_fg) & 0x8) {
				/* bright mode changed: reset attributes and force setting both back and fore colors */
				fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
				if (__fb_con.fg_color & 0x8)
					fb_hTermOut(SEQ_BRIGHT_COLOR, 0, 0);
				force = TRUE;
			}
			fb_hTermOut(SEQ_FG_COLOR, 0, map[__fb_con.fg_color & 0x7]);
		}
		if ((__fb_con.bg_color != old_bg) || (force))
			fb_hTermOut(SEQ_BG_COLOR, 0, map[__fb_con.bg_color & 0x7]);
	}
	else {
		/* generic xterm supports 16+16 colors */
		if (__fb_con.fg_color != old_fg)
			fb_hTermOut(SEQ_SET_COLOR_EX, map[__fb_con.fg_color & 0x7] + (__fb_con.fg_color & 0x8 ? 90 : 30), 0);
		if (__fb_con.bg_color != old_bg)
			fb_hTermOut(SEQ_SET_COLOR_EX, map[__fb_con.bg_color & 0x7] + (__fb_con.bg_color & 0x8 ? 100 : 40), 0);
	}
	
	return old_fg | (old_bg << 16);
}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
	return __fb_con.inited ? (__fb_con.fg_color | (__fb_con.bg_color << 4)) : 0x7;
}
