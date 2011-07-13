/*
 * io_scroll.c -- console scrolling for when VIEW is used for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: only use window width [mjs]
 *                mod: use convert*console functions [mjs]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleScrollRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2, int nrows )
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

