/* print [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintFixString ( int fnum, const char *s, int mask )
{
    fb_LPrintInit();
    fb_PrintFixStringEx(FB_FILE_TO_HANDLE(fnum),
                        s,
                        FB_PRINT_CONVERT_BIN_NEWLINE(mask));
}
