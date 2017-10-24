/* print [#] functions */

#include "fb.h"

/*:::::*/
static void fb_hPrintStrEx( FB_FILE *handle, const char *s, size_t len, int mask )
{
    /* add a lock here or the new-line won't be printed in the right
       place if PRINT is been used in multiple threads and a context
       switch happens between FB_PRINT_EX() and PrintVoidEx() */
    FB_LOCK( );

    if( len != 0 )
        FB_PRINT_EX(handle, s, len, 0);

    fb_PrintVoidEx( handle, mask );

    FB_UNLOCK( );
}

/*:::::*/
void fb_PrintStringEx ( FB_FILE *handle, FBSTRING *s, int mask )
{
    if( (s == NULL) || (s->data == NULL) )
    	fb_PrintVoidEx( handle, mask );
    else
        fb_hPrintStrEx( handle, s->data, FB_STRSIZE(s), mask );

    /* del if temp */
    fb_hStrDelTemp( s );
}

/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
    fb_PrintStringEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}
