/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
	if( view_toprow == -1 )
		view_toprow = 0;

	return view_toprow;
}

/*:::::*/
int fb_ConsoleGetBotRow( void )
{
	if( view_botrow == -1 )
		view_botrow = fb_ConsoleGetMaxRow( ) - 1;

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


