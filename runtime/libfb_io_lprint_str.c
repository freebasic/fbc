/*
 * io_print.c -- print [#] functions
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintString ( int fnum, FBSTRING *s, int mask )
{
    LPrintInit();
    fb_PrintStringEx(FB_FILE_TO_HANDLE(fnum),
                     s,
                     FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
