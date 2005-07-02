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
 * hook_printstr.c -- print string entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintBufferEx( const void *buffer, size_t len, int mask )
{
#ifndef FB_NATIVE_TAB
    const char *pachText = (const char *) buffer;
    int con_width;
    size_t i;
    fb_GetSize( &con_width, NULL );
#endif

	FB_LOCK();

    if( fb_hooks.printbuffproc )
        fb_hooks.printbuffproc( buffer, len, mask );
    else
        fb_ConsolePrintBufferEx( buffer, len, mask );

#ifndef FB_NATIVE_TAB
    /* search for last printed CR or LF */
    i = len;
    while( i-- )
    {
        char ch = pachText[i];
        if (ch == '\n' || ch == '\r')
            break;
    }
    ++i;
    if( i == 0 )
        len += fb_FileGetLineLen( 0 );
    else
        len -= i;

    fb_FileSetLineLen( 0, len % con_width );
#endif

	FB_UNLOCK();

}

/*:::::*/
FBCALL void fb_PrintBuffer( const char *buffer, int mask )
{

    return fb_PrintBufferEx( buffer, strlen( buffer ), mask );

}
