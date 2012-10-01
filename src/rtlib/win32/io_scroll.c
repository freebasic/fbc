/* console scrolling for when VIEW is used */

#include "../fb.h"
#include "fb_private_console.h"

static void fb_ConsoleScrollRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2, int nrows )
{
    int height = y2 - y1 + 1;

    if( nrows <= 0 )
        return;

    if( nrows >= height ) {
        /* clear view */
        fb_ConsoleClearViewRawEx( hConsole, x1, y1, x2, y2 );

    } else {
        /* scroll view */
        SMALL_RECT srec;
        COORD dcoord;
        CHAR_INFO cinf;

        srec.Left 	= (SHORT) x1;
        srec.Right 	= (SHORT) x2;
        srec.Top 	= (SHORT) (y1 + nrows);
        srec.Bottom = (SHORT) y2;

        dcoord.X = (SHORT) x1;
        dcoord.Y = (SHORT) y1;

        cinf.Char.AsciiChar	= ' ';
        cinf.Attributes 	= fb_ConsoleGetColorAttEx( hConsole );

        ScrollConsoleScreenBuffer( hConsole, &srec, NULL, dcoord, &cinf );
#if 0
        fb_ConsoleLocateRawEx( hConsole, y2 - nrows, -1, -1 );
#endif
    }
}

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
