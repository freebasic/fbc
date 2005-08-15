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
 * io_inkey.c -- inkey$ function for Windows console mode apps
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING 	 *res;
    int  key = fb_hConsoleGetKey( TRUE );
    FB_STRLOCK();
    if( key==-1 ) {
        res = &fb_strNullDesc;
    } else if( key > 255 ) {
        res = fb_hStrAllocTemp( NULL, 2 );
        if( res!=NULL ) {
            res->data[0] = FB_EXT_CHAR;
            res->data[1] = (key >> 8) & 0xFF;
            res->data[2] = 0;
        }
    } else {
        res = fb_hStrAllocTemp( NULL, 1 );
        if( res!=NULL ) {
            res->data[0] = key & 0xFF;
            res->data[1] = 0;
        }
    }
    FB_STRUNLOCK();
    if( res==NULL )
        res = &fb_strNullDesc;
	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = fb_hConsoleGetKey( TRUE );
    if( k==-1 )
        k = 0;
    return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{
    return fb_hConsolePeekKey( TRUE ) != -1;
}

