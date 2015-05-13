/* print [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintString ( int fnum, FBSTRING *s, int mask )
{
    fb_LPrintInit();
    fb_PrintStringEx(FB_FILE_TO_HANDLE(fnum),
                     s,
                     FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
