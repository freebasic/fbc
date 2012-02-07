/* print functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintVoid ( int fnum, int mask )
{
    fb_LPrintInit();
    fb_PrintVoidEx( FB_FILE_TO_HANDLE(fnum),
                    FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
