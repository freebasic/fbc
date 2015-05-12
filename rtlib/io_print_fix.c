/* print [#] functions */

#include "fb.h"

/*:::::*/
static void fb_hPrintStrEx( FB_FILE *handle, const char *s, size_t len, int mask )
{
    if( len != 0 ) {
        FB_PRINT_EX(handle, s, len, 0);
    }

    fb_PrintVoidEx( handle, mask );
}

/*:::::*/
void fb_PrintFixStringEx ( FB_FILE *handle, const char *s, int mask )
{
    if( s == NULL )
    	fb_PrintVoidEx( handle, mask );
    else
    	fb_hPrintStrEx( handle, s, strlen( s ), mask );
}

/*:::::*/
FBCALL void fb_PrintFixString ( int fnum, const char *s, int mask )
{
    fb_PrintFixStringEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}
