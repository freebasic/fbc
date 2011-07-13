/*
 * io_printvoid.c -- print functions
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

#include <stdlib.h>

int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintVoid ( int fnum, int mask )
{
    LPrintInit();
    fb_PrintVoidEx( FB_FILE_TO_HANDLE(fnum),
                    FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}

