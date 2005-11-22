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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_DevScrnReadLineWstr( struct _FB_FILE *handle, FB_WCHAR *dst, int dst_chars )
{
    int res;
    FBSTRING temp = { 0 };

    /* !!!FIXME!!! no unicode input supported */

    res = fb_LineInput( NULL, (void *)&temp, -1, FALSE, FALSE, TRUE );

    if( res == FB_RTERROR_OK )
    	fb_WstrAssignFromA( dst, dst_chars, (void *)&temp, -1 );

    fb_StrDelete( &temp );

    return res;
}

/*:::::*/
void fb_DevScrnInit_ReadLineWstr( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnReadLineWstr == NULL )
        FB_HANDLE_SCREEN->hooks->pfnReadLineWstr = fb_DevScrnReadLineWstr;
}
