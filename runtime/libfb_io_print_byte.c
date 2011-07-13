/*
 * io_print_byte.c -- print [#] function (byte)
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintByte ( int fnum, char val, int mask )
{
    FB_PRINTNUM( fnum, ((int) val), mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_PrintUByte ( int fnum, unsigned char val, int mask )
{
    FB_PRINTNUM( fnum, ((unsigned) val), mask, "%", "u" );
}
