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
 * sys_run.c -- run function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>

#ifdef WIN32
#include <process.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#define MAX_PATH	1024
#endif

#include "fb.h"

/*:::::*/
FBCALL int fb_Run ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    char 	arg0[] = "";
    int		res;

#ifdef WIN32
	res = _execl( fb_hGetShortPath( program->data, buffer, MAX_PATH ), arg0, NULL );
#else
	char buffer2[MAX_PATH+3];

	fb_hGetShortPath( program->data, buffer, MAX_PATH );
	res = execlp( buffer, buffer, NULL);
	/* Ok, an error occured. Probably the file could not be found;
	 * as a last resort, let's try in current directory.
	 */
	if( !strchr( buffer, '/' )) {
		sprintf( buffer2, "./%s", buffer );
		execlp( buffer2, buffer2, NULL );
	}
	exit( -1 );
#endif

	/* del if temp */
	fb_hStrDelTemp( program );

	return res;
}
