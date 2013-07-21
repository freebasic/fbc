/* LINE INPUT function */

#include "fb_gfx.h"

static const char *pszDefaultQuestion = "? ";

int fb_GfxLineInput
	(
		FBSTRING *text,
		void *dst,
		ssize_t dst_len,
		int fillrem,
		int addquestion,
		int addnewline
	)
{
    FBSTRING *tmp_result;

    FB_LOCK();

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );

    if( text != NULL )
    {
        if( text->data != NULL ) {
            fb_PrintString( 0, text, 0 );
        }

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine( TRUE );

    if( addnewline ) {
				fb_PrintVoid( 0, FB_PRINT_NEWLINE );
    }

    if( tmp_result!=NULL ) {
        fb_StrAssign( dst, dst_len, tmp_result, -1, fillrem );
        return fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
}
