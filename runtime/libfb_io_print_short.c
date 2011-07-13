/*
 * io_print_byte.c -- print [#] function (short)
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintShort ( int fnum, short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "% ", "hd" );
}

/*:::::*/
FBCALL void fb_PrintUShort ( int fnum, unsigned short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "%", "hu" );
}
