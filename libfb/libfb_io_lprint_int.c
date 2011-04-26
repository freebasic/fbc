/*
 * io_print_byte.c -- print [#] function (int)
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintInt ( int fnum, int val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_LPrintUInt ( int fnum, unsigned int val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "%", "u" );
}
