/* end helper for Unix */

#include "fb.h"

/*:::::*/
void fb_hExitConsole( void )
{
	int bottom;

	if (__fb_con.inited) {
		
		if (__fb_con.gfx_exit)
			__fb_con.gfx_exit();
		
		BG_LOCK();
		if (__fb_con.keyboard_exit)
			__fb_con.keyboard_exit();
		if (__fb_con.mouse_exit)
			__fb_con.mouse_exit();
		BG_UNLOCK();

		bottom = fb_ConsoleGetMaxRow();
		if ((fb_ConsoleGetTopRow() != 0) || (fb_ConsoleGetBotRow() != bottom - 1)) {
			/* Restore scrolling region to whole screen and clear */
			fb_hTermOut(SEQ_SCROLL_REGION, bottom - 1, 0);
			fb_hTermOut(SEQ_CLS, 0, 0);
			fb_hTermOut(SEQ_HOME, 0, 0);
		}
		
		/* Cleanup terminal */
#ifdef HOST_LINUX
		if (__fb_con.inited == INIT_CONSOLE)
			fb_hTermOut(SEQ_EXIT_CHARSET, 0, 0);
#endif
		fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		fb_hTermOut(SEQ_EXIT_KEYPAD, 0, 0);
		tcsetattr(__fb_con.h_out, TCSANOW, &__fb_con.old_term_out);

		/* Restore old console keyboard state */
		fcntl(__fb_con.h_in, F_SETFL, __fb_con.old_in_flags);
		tcsetattr(__fb_con.h_in, TCSANOW, &__fb_con.old_term_in);

		if (__fb_con.f_in) {
			fclose(__fb_con.f_in);
			__fb_con.f_in = NULL;
		}
	}
}

/*:::::*/
void fb_unix_hEnd ( int unused )
{
	fb_hExitConsole();
	if (__fb_con.inited) {
		__fb_con.inited = FALSE;
		pthread_join(__fb_con.bg_thread, NULL);
	}
	pthread_mutex_destroy(&__fb_con.bg_mutex);

#ifdef ENABLE_MT
	/* Release multithreading support resources */
	pthread_mutex_destroy(&__fb_global_mutex);
	pthread_mutex_destroy(&__fb_string_mutex);
#endif
}
