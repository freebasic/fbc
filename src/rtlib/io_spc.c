/* spc and tab functions */

#include "fb.h"

FBCALL void fb_PrintTab( int fnum, int newcol )
{
    FB_FILE *handle;
    int col, row, cols, rows;

    fb_DevScrnInit_NoOpen( );

    FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if (!handle) {
        FB_UNLOCK();
        return;
    }

	if( FB_HANDLE_IS_SCREEN(handle) || handle->type == FB_FILE_TYPE_CONSOLE )
    {
        if( handle->type == FB_FILE_TYPE_CONSOLE ) {
            if( handle->hooks && handle->hooks->pfnFlush )
                handle->hooks->pfnFlush( handle );
        }

        /* Ensure that we get the "real" cursor position - this quirk is
         * required for cursor positions at the right bottom of the screen */
        fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
		fb_GetXY( &col, &row );
		fb_GetSize( &cols, &rows );

    	if( newcol > cols )
    		newcol %= cols;

        if( col > newcol ) {
            fb_PrintVoidEx ( handle, FB_PRINT_NEWLINE );
			fb_Locate( 0, newcol, -1, 0, 0 );

        } else if( newcol < 1 )
    		fb_Locate( 0, 1, -1, 0, 0 );

    	else
            fb_Locate( 0, newcol, -1, 0, 0 );

    } else {

        if( handle->type==FB_FILE_TYPE_PIPE ) {

            fb_PrintPadEx ( handle, 0 );

        } else {

            if( (newcol >= 0) && ((unsigned int)newcol > handle->line_length) ) {
                fb_PrintStringEx( handle,
                                  fb_StrFill1( newcol - handle->line_length - 1, ' ' ),
                                  0 );
            } else {

                if( handle->mode==FB_FILE_MODE_BINARY ) {
                    fb_PrintStringEx( handle,
                                      fb_StrAllocTempDescF( FB_BINARY_NEWLINE, sizeof( FB_BINARY_NEWLINE ) ),
                                      0 );
                } else {
                    fb_PrintStringEx( handle,
                                      fb_StrAllocTempDescF( FB_NEWLINE, sizeof( FB_NEWLINE ) ),
                                      0 );
                }

                if( newcol > 0 ) {
                    fb_PrintStringEx( handle,
                                      fb_StrFill1( newcol - 1, ' ' ),
                                      0 );
                }

            }

        }

    }

    FB_UNLOCK();
}

FBCALL void fb_PrintSPC( int fnum, ssize_t n )
{
    FB_FILE *handle;
    int col, row, cols, rows, newcol;

    if( n==0 )
        return;

    fb_DevScrnInit_NoOpen( );

    FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if (!handle) {
        FB_UNLOCK();
        return;
    }

	if( FB_HANDLE_IS_SCREEN(handle) || handle->type == FB_FILE_TYPE_CONSOLE )
	{
        if( handle->type == FB_FILE_TYPE_CONSOLE ) {
            if( handle->hooks && handle->hooks->pfnFlush )
                handle->hooks->pfnFlush( handle );
        }

        /* Ensure that we get the "real" cursor position - this quirk is
         * required for cursor positions at the right bottom of the screen */
        fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
		fb_GetXY( &col, &row );
		fb_GetSize( &cols, &rows );

        /* Skip as many spaces as requested. We may even skip entire lines. */
    	newcol = col + n;
        while( newcol > cols ) {
            fb_PrintVoidEx ( handle, FB_PRINT_NEWLINE );
            newcol -= cols;
        }

        fb_Locate( 0, newcol, -1, 0, 0 );

    } else {

        fb_PrintStringEx( handle, fb_StrFill1( n, ' ' ), 0 );

    }

    FB_UNLOCK();
}
