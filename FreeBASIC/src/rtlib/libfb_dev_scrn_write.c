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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

FBCALL void fb_PrintBufferEx( const void *buffer, size_t len, int mask );

/*:::::*/
int fb_DevScrnWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    fb_PrintBufferEx( value, valuelen, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
void fb_DevScrnInit_Write( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnWrite == NULL )
    	FB_HANDLE_SCREEN->hooks->pfnWrite = fb_DevScrnWrite;
}
