/* console scrolling for when VIEW is used for Windows */

#include "fb.h"

/*:::::*/
void fb_ConsoleScroll( int nrows )
{
    int left, right;
    int toprow, botrow;

    if( nrows <= 0 )
    	return;

    left = 1;
    fb_ConsoleGetSize( &right, NULL );
    fb_ConsoleGetView( &toprow, &botrow );
    fb_hConvertToConsole( &left, &toprow, &right, &botrow );

    fb_ConsoleScrollRawEx( __fb_out_handle, left, toprow, right, botrow, nrows );
}
