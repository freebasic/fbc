/* console line input function */

#include "fb.h"

static const char *pszDefaultQuestion = "? ";

#if defined( HOST_WIN32 ) || defined( HOST_DOS ) || defined( HOST_LINUX )

int fb_ConsoleLineInput
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
        if( text->data != NULL )
        {
            fb_PrintString( 0, text, 0 );
        }
    	/* del if temp */
    	else
    	{
    		fb_hStrDelTemp( text );
    	}

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine( FALSE );

    if( addnewline ) {
				fb_PrintVoid( 0, FB_PRINT_NEWLINE );
    }

    if( tmp_result!=NULL ) {
        fb_StrAssign( dst, dst_len, tmp_result, -1, fillrem );
        return fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
}

#else

static char *hWrapper( char *buffer, size_t count, FILE *fp )
{
    return fb_ReadString( buffer, count, fp );
}

int fb_ConsoleLineInput
	(
		FBSTRING *text,
		void *dst,
		ssize_t dst_len,
		int fillrem,
		int addquestion,
		int addnewline
	)
{
	int res, old_x, old_y;
	size_t len;

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
    fb_GetXY( &old_x, &old_y );

	FB_LOCK();

    if( text != NULL )
    {
        if( text->data != NULL )
        {
            fb_PrintString( 0, text, 0 );
        }
    	/* del if temp */
    	else
    	{
    		fb_hStrDelTemp( text );
    	}

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    {
        /* create temporary string */
        FBSTRING str_result = { .data = NULL, .len = 0, .size = 0 };

        res = fb_DevFileReadLineDumb( stdin, &str_result, hWrapper );

        len = FB_STRSIZE(&str_result);

        /* We have to handle the NEWLINE stuff here because we *REQUIRE*
         * the *COMPLETE* temporary input string for the correct position
         * adjustment. */
        if( !addnewline ) {
            /* This is the easy and dumb method to do the position adjustment.
             * The problem is that it doesn't take TAB's into account. */
            int cols, rows, old_y;

            fb_GetSize( &cols, &rows );
            fb_GetXY( NULL, &old_y );

            old_x += len - 1;
            old_x %= cols;
            old_x += 1;
            old_y -= 1;

            fb_Locate( old_y, old_x, -1, 0, 0 );
        }


        /* add contents of tempporary string to result buffer */
        fb_StrAssign( dst, dst_len, (void *)&str_result, -1, fillrem );

        fb_StrDelete( &str_result );
    }

	FB_UNLOCK();

    return res;
}

#endif
