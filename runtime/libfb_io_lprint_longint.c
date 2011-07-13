/*
 * io_print_longint.c -- print [#] function (longint)
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintLongint ( int fnum, long long val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
	FB_PRINTNUM( fnum, val, mask, "% ", FB_LL_FMTMOD "d" );
}

/*:::::*/
FBCALL void fb_LPrintULongint ( int fnum, unsigned long long val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "%", FB_LL_FMTMOD "u" );
}
