/*
 * exit.c -- end helper for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"

 /*:::::*/
void fb_hEnd ( int unused )
{
	fb_unix_hEnd( unused );
}
