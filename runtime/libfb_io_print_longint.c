/*
 * io_print_longint.c -- print [#] function (longint)
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintLongint ( int fnum, long long val, int mask )
{
	FB_PRINTNUM( fnum, val, mask, "% ", FB_LL_FMTMOD "d" );
}

/*:::::*/
FBCALL void fb_PrintULongint ( int fnum, unsigned long long val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "%", FB_LL_FMTMOD "u" );
}
