/* locate function entry point, returns current position */

#include "fb.h"

/*:::::*/
FBCALL int fb_Locate( int row, int col, int cursor, int start, int stop )
{
    int new_pos;
    int res = fb_LocateEx( row, col, cursor, &new_pos );
    if( res!=FB_RTERROR_OK )
        fb_LocateEx( 0, 0, cursor, &new_pos );
    return new_pos;
}
