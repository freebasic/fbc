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
 * sys_chain.c -- chain function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>

#include <process.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include "fb.h"

/*:::::*/
FBCALL int fb_Chain ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    char 	arg0[] = "";
    int		res;

	if( (program != NULL) && (program->data != NULL) )
	{
		res = _spawnl( _P_WAIT, fb_hGetShortPath( program->data, buffer, MAX_PATH ), arg0, NULL );
	}

	/* del if temp */
	fb_hStrDelTemp( program );

	return res;
}
