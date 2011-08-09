/* console scrolling for when VIEW is used for Linux */

#include "fb.h"


/*:::::*/
void fb_ConsoleScroll(int nrows)
{
	fb_hTermOut(SEQ_SCROLL, 0, nrows);
}
