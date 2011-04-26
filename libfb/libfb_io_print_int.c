/*
 * io_print_byte.c -- print [#] function (int)
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintInt ( int fnum, int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_PrintUInt ( int fnum, unsigned int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "%", "u" );
}
