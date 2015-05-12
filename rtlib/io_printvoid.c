/* print functions */

#include "fb.h"

/*:::::*/
void fb_PrintVoidEx ( FB_FILE *handle, int mask )
{
    if( mask & FB_PRINT_BIN_NEWLINE ) {

        FB_PRINT_EX(handle,
                    FB_BINARY_NEWLINE,
                    sizeof(FB_BINARY_NEWLINE)-1,
                    mask);

    } else if( mask & FB_PRINT_NEWLINE ) {

        FB_PRINT_EX(handle,
                    FB_NEWLINE,
                    sizeof(FB_NEWLINE)-1,
                    mask);

    } else if( mask & FB_PRINT_PAD ) {

        fb_PrintPadEx( handle, mask & ~FB_PRINT_HLMASK );

    }
}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    fb_PrintVoidEx( FB_FILE_TO_HANDLE(fnum), mask );
}

