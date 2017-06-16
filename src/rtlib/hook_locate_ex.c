/* locate entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL int fb_LocateEx( int row, int col, int cursor, int *current_pos )
{
    int tmp_current_pos = 0;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    int start_y, end_y, con_width;

    fb_ConsoleGetView(&start_y, &end_y);
    fb_GetSize( &con_width, NULL );

    if( row!=0 && (row<start_y || row>end_y) ) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    } else if( col!=0 && (col<1 || col>con_width) ) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    } else {
        fb_DevScrnInit_NoOpen( );

        FB_LOCK();

        if( __fb_ctx.hooks.locateproc ) {
            tmp_current_pos = __fb_ctx.hooks.locateproc( row, col, cursor );
        } else {
            tmp_current_pos = fb_ConsoleLocate( row, col, cursor );
        }

        if( col!=0 )
            FB_HANDLE_SCREEN->line_length = col - 1;

        FB_UNLOCK();
    }

    if( current_pos )
        *current_pos = tmp_current_pos;

    return res;
}
