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

/*:::::*/
void fb_hExitConsole( void )
{
	int bottom;

	if (fb_con.inited) {
		BG_LOCK();
		if (fb_con.keyboard_exit)
			fb_con.keyboard_exit();
		if (fb_con.mouse_exit)
			fb_con.mouse_exit();
		BG_UNLOCK();

		bottom = fb_ConsoleGetMaxRow();
		if ((fb_ConsoleGetTopRow() != 0) || (fb_ConsoleGetBotRow() != bottom - 1)) {
			/* Restore scrolling region to whole screen and clear */
			fprintf(fb_con.f_out, "\e[1;%dr", bottom);
			fputs("\e[2J", fb_con.f_out);
		}
		/* Restore latin1 charset */
		fputs("\e(B", fb_con.f_out);
		/* Restore default attributes and color */
		fputs("\e[0m", fb_con.f_out);
		/* Force cursor display */
		fputs("\e[?25h", fb_con.f_out);
		fflush(fb_con.f_out);
		tcsetattr(fb_con.h_out, TCSAFLUSH, &fb_con.old_term_out);

		/* Restore old console keyboard state */
		fflush(fb_con.f_in);
		fcntl(fb_con.h_in, F_SETFL, fb_con.old_in_flags);
		tcsetattr(fb_con.h_in, TCSAFLUSH, &fb_con.old_term_in);
	}
}

/*:::::*/
void fb_hEnd ( int errlevel )
{
	fb_hExitConsole();
	if (fb_con.inited) {
		fb_con.inited = FALSE;
		pthread_join(fb_con.bg_thread, NULL);
	}
	pthread_mutex_destroy(&fb_con.bg_mutex);

	if( FB_TLSGET(fb_dirctx) )
		free( (FB_DIRCTX *)FB_TLSGET(fb_dirctx) );

#ifdef MULTITHREADED
	/* Release multithreading support resources */
	pthread_mutex_destroy(&fb_global_mutex);
	pthread_mutex_destroy(&fb_string_mutex);

	/* allocate thread local storage vars for runtime error handling */
	pthread_key_delete(fb_errctx.handler);
	pthread_key_delete(fb_errctx.num);
	pthread_key_delete(fb_errctx.linenum);
	pthread_key_delete(fb_errctx.reslbl);
	pthread_key_delete(fb_errctx.resnxtlbl);

	/* allocate thread local storage vars for input context */
	pthread_key_delete(fb_inpctx.handle);
	pthread_key_delete(fb_inpctx.i);
	pthread_key_delete(fb_inpctx.s.data);
	pthread_key_delete(fb_inpctx.s.len);
	pthread_key_delete(fb_inpctx.s.size);

	/* allocate thread local storage vars for print using context */
	pthread_key_delete(fb_printusgctx.chars);
	pthread_key_delete(fb_printusgctx.ptr);
	pthread_key_delete(fb_printusgctx.fmtstr.data);
	pthread_key_delete(fb_printusgctx.fmtstr.len);
	pthread_key_delete(fb_printusgctx.fmtstr.size);
	
	pthread_key_delete(fb_dirctx);
#endif
}
