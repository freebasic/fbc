/* console scrolling for when VIEW is used */

#include "../fb.h"
#include "../unix/fb_private_console.h"

void fb_ConsoleScroll(int nrows)
{
	fb_hTermOut(SEQ_SCROLL, 0, nrows);
}
