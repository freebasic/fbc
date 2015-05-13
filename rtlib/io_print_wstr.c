/* print [#] wstring functions */

#include "fb.h"

/*:::::*/
static void fb_hPrintWstrEx
	(
		FB_FILE *handle,
		const FB_WCHAR *s,
		size_t len, int mask
	)
{
    /* add a lock here or the new-line won't be printed in the right
       place if PRINT is been used in multiple threads and a context
       switch happens between FB_PRINT_EX() and PrintVoidEx() */
    FB_LOCK( );

    if( len != 0 )
        FB_PRINTWSTR_EX( handle, s, len, 0 );

    fb_PrintVoidWstrEx( handle, mask );

    FB_UNLOCK( );
}

/*:::::*/
void fb_PrintWstrEx
	(
		FB_FILE *handle,
		const FB_WCHAR *s,
		int mask
	)
{
    if( s == NULL )
    	fb_PrintVoidWstrEx( handle, mask );
    else
    	fb_hPrintWstrEx( handle, s, fb_wstr_Len( s ), mask );
}

/*:::::*/
FBCALL void fb_PrintWstr
	(
		int fnum,
		const FB_WCHAR *s,
		int mask
	)
{
    fb_PrintWstrEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}
