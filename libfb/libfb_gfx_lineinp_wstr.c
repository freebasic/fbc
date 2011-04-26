/*
 * lineinp_wstr - console line input function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb_gfx.h"

/*:::::*/
int fb_GfxLineInputWstr( const FB_WCHAR *text, FB_WCHAR *dst, int max_chars,
						 int addquestion, int addnewline )
{
    FBSTRING *tmp_result;

    /* !!!FIXME!!! no support for unicode input */

    FB_LOCK();

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );

    if( text != NULL )
    {
        fb_PrintWstr( 0, text, 0 );

        if( addquestion != FB_FALSE )
            fb_PrintFixString( 0, "? ", 0 );
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine( TRUE );

    if( addnewline )
				fb_PrintVoid( 0, FB_PRINT_NEWLINE );

    if( tmp_result == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

	fb_WstrAssignFromA( dst, max_chars, tmp_result, -1 );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


