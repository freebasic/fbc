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
 * sys_getcmd.c -- get command line for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

/*:::::*/
char *fb_hGetCommandLine( void )
{
    char *buffer;

	buffer = GetCommandLine( );

	/* exe paths with white-spaces are quoted on Windows */
	if( buffer[0] == '"' )
	{
		buffer = strchr( &buffer[1], '"' );
		if( buffer != NULL )
			++buffer;
	}

	return buffer;
}
