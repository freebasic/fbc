/* print [#] function (floating point) */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintSingle ( int fnum, float val, int mask )
{
	char buffer[8+1+9+1];

    fb_LPrintInit();
    fb_PrintFixString( fnum,
                       fb_hFloat2Str( (double)val, buffer, 7, FB_F2A_ADDBLANK ),
                       FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}

/*:::::*/
FBCALL void fb_LPrintDouble ( int fnum, double val, int mask )
{
	char buffer[16+1+9+1];

    fb_LPrintInit();
    fb_PrintFixString( fnum,
                       fb_hFloat2Str( val, buffer, 16, FB_F2A_ADDBLANK ),
                       FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
