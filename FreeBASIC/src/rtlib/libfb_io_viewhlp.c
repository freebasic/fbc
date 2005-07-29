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
 * io_getview.c -- view print helpers (console, no gfx)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

static int view_toprow = -1, view_botrow = -1;

/*:::::*/
int fb_ConsoleGetTopRow( void )
{
    if( view_toprow == -1 ) {
#if FB_CON_BOUNDS==0 || FB_CON_BOUNDS==1 || FB_CON_BOUNDS==2
        view_toprow = 0;
#else
        fb_ConsoleGetWindow( NULL, &view_toprow, NULL, NULL );
        if( view_toprow!=0 )
            --view_toprow;
#endif
    }

	return view_toprow;
}

/*:::::*/
int fb_ConsoleGetBotRow( void )
{
    if( view_botrow == -1 ) {
#if FB_CON_BOUNDS==0 || !defined(TARGET_WIN32)
        view_botrow = fb_ConsoleGetMaxRow( );
#elif FB_CON_BOUNDS==1 || FB_CON_BOUNDS==2
        fb_ConsoleGetWindow( NULL, NULL, NULL, &view_botrow );
#else
        int view_top;
        fb_ConsoleGetWindow( NULL, &view_top, NULL, &view_botrow );
        if( view_botrow!=0 )
            view_botrow += view_top - 1;
#endif
        if( view_botrow!=0 )
            --view_botrow;
    }

	return view_botrow;
}

/*:::::*/
void fb_ConsoleSetTopBotRows( int top, int bot )
{
    view_toprow = top;
    view_botrow = bot;
}

/*:::::*/
void fb_ConsoleGetView( int *toprow, int *botrow )
{
	*toprow = fb_ConsoleGetTopRow( ) + 1;
    *botrow = fb_ConsoleGetBotRow( ) + 1;
}


