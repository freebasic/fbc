/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_pcopy.c -- pcopy (console, no gfx) function for Windows
 *
 * chng: sep/2007 written [v1ctor]
 *
 */

#include "fb.h"

HANDLE fb_hConsoleCreateBuffer( void );

/*:::::*/
int fb_ConsolePageCopy ( int src, int dst )
{
	fb_hConsoleGetHandle( FALSE );

	/* use current? */
	if( src < 0 )
		src = __fb_con.active;

	/* not allocated yet? */
	if( __fb_con.pgHandleTb[src] == NULL )
	{
    	HANDLE hnd = fb_hConsoleCreateBuffer( );
        if( hnd == NULL )
           	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		else
			__fb_con.pgHandleTb[src] = hnd;
	}

	/* use current? */
	if( dst < 0 )
		dst = __fb_con.visible;

	if( src == dst )
		return fb_ErrorSetNum( FB_RTERROR_OK );

	/* not allocated yet? */
	if( __fb_con.pgHandleTb[dst] == NULL )
	{
    	HANDLE hnd = fb_hConsoleCreateBuffer( );
        if( hnd == NULL )
           	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		else
			__fb_con.pgHandleTb[dst] = hnd;
	}

	/* do the copy */
	static COORD pos = { 0, 0 };

	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[src], &csbi );
	PCHAR_INFO buff = alloca( csbi.dwSize.X * csbi.dwSize.Y * sizeof( CHAR_INFO ) );

	ReadConsoleOutput( __fb_con.pgHandleTb[src], buff, csbi.dwSize, pos, &csbi.srWindow );

	GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[dst], &csbi );
	WriteConsoleOutput( __fb_con.pgHandleTb[dst], buff, csbi.dwSize, pos, &csbi.srWindow );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


