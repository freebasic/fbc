/* print [#] functions */

#include <stdlib.h>
#include "fb.h"

int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintFixString ( int fnum, const char *s, int mask )
{
    LPrintInit();
    fb_PrintFixStringEx(FB_FILE_TO_HANDLE(fnum),
                        s,
                        FB_PRINT_CONVERT_BIN_NEWLINE(mask));
}
