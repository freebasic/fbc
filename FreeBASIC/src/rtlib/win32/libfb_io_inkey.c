/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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

    if( key==-1 )
    {
        res = &__fb_ctx.null_desc;
    }
    else if( key > 255 )
    {
        res = fb_hStrAllocTemp( NULL, 2 );
        if( res!=NULL )
        {
            res->data[0] = FB_EXT_CHAR;
            res->data[1] = (key >> 8) & 0xFF;
            res->data[2] = 0;
        }
    }
    else
    {
        res = fb_hStrAllocTemp( NULL, 1 );
        if( res!=NULL )
        {
            res->data[0] = key & 0xFF;
            res->data[1] = 0;
        }
    }

    if( res==NULL )
        res = &__fb_ctx.null_desc;

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = fb_hConsoleGetKey( TRUE );
    while( k==-1 ) {
        fb_Sleep( -1 );
        k = fb_hConsoleGetKey( TRUE );
    }
    return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{
    return fb_hConsolePeekKey( TRUE ) != -1;
}

