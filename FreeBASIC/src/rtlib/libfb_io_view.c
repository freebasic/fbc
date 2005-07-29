/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * io_view.c -- view print (console, no gfx)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_ConsoleView( int toprow, int botrow )
{
    int do_update = FALSE;
    int maxrow, minrow;


#if FB_CON_BOUNDS==0 || !defined(TARGET_WIN32)
    minrow = 1;
    maxrow = fb_ConsoleGetMaxRow( );
#elif FB_CON_BOUNDS==1 || FB_CON_BOUNDS==2
    minrow = 1;
    fb_ConsoleGetWindow( NULL, NULL, NULL, &maxrow );
#else
    fb_ConsoleGetWindow( NULL, &minrow, NULL, &maxrow );
    maxrow += minrow - 1;
#endif

    if( toprow > 0 ) {
        do_update = TRUE;
    } else if ( toprow == 0 ) {
        do_update = TRUE;
        toprow = minrow;
    } else {
        toprow = fb_ConsoleGetTopRow() + 1;
    }

    if( botrow > 0 ) {
        do_update = TRUE;
    } else if ( botrow == 0 ) {
        do_update = TRUE;
        botrow = maxrow;
    } else {
        botrow = fb_ConsoleGetBotRow() + 1;
    }

    fb_ConsoleSetTopBotRows( toprow - 1, botrow - 1 );

    if( do_update ) {
        /* to top row */
        fb_ConsoleViewUpdate( );
        fb_Locate( toprow, 1, -1 );
    }

    return toprow + (botrow << 16);
}

