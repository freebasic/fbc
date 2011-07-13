/*
 * io_scroll.c -- console scrolling for when VIEW is used for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
void fb_ConsoleScroll(int nrows)
{
	fb_hTermOut(SEQ_SCROLL, 0, nrows);
}
