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
 * exit.c -- end helper for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"
#include <linux/kd.h>

/*:::::*/
void fb_hExitConsole( void )
{
	int bottom;

	if (fb_con.inited) {
		
		fb_hResize();

		if (fb_con.gfx_exit)
			fb_con.gfx_exit();
		
		BG_LOCK();
		if (fb_con.keyboard_exit)
			fb_con.keyboard_exit();
		if (fb_con.mouse_exit)
			fb_con.mouse_exit();
		BG_UNLOCK();

		bottom = fb_ConsoleGetMaxRow();
		if ((fb_ConsoleGetTopRow() != 0) || (fb_ConsoleGetBotRow() != bottom - 1)) {
			/* Restore scrolling region to whole screen and clear */
			fb_hTermOut(SEQ_SCROLL_REGION, bottom - 1, 0);
			fb_hTermOut(SEQ_CLS, 0, 0);
			fb_hTermOut(SEQ_HOME, 0, 0);
		}

		/* Cleanup terminal */
		if (fb_con.inited == INIT_CONSOLE)
			fb_hTermOut(SEQ_EXIT_CHARSET, 0, 0);
		fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		fb_hTermOut(SEQ_EXIT_KEYPAD, 0, 0);
		tcsetattr(fb_con.h_out, TCSANOW, &fb_con.old_term_out);

		/* Restore old console keyboard state */
		fcntl(fb_con.h_in, F_SETFL, fb_con.old_in_flags);
		tcsetattr(fb_con.h_in, TCSANOW, &fb_con.old_term_in);
	}
}

/*:::::*/
void fb_hEnd ( int unused )
{
	fb_hExitConsole();
	if (fb_con.inited) {
		fb_con.inited = FALSE;
		pthread_join(fb_con.bg_thread, NULL);
	}
	pthread_mutex_destroy(&fb_con.bg_mutex);

#ifdef MULTITHREADED
	/* Release multithreading support resources */
	pthread_mutex_destroy(&fb_global_mutex);
	pthread_mutex_destroy(&fb_string_mutex);
#endif
}
