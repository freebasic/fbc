/*
 * init.c -- libfb initialization for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"

/*:::::*/
void fb_hInit ( void )
{
	fb_unix_hInit( );
	
	__fb_con.has_perm = ioperm(0, 0x400, 1) ? FALSE : TRUE;
}
