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
 * sys_run.c -- run function for Linux
 *
 * chng: nov/2004 written [lillo]
 *
 */

#include <malloc.h>
#include <string.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#define MAX_PATH	1024

#include "fb.h"

/*:::::*/
FBCALL int fb_Run ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    char 	arg0[] = "";
    int		res;

	if( (program != NULL) && (program->data != NULL) )
	{
		char buffer2[MAX_PATH+3];

		fb_hGetShortPath( program->data, buffer, MAX_PATH );
		res = execlp( buffer, buffer, NULL);
		/* Ok, an error occured. Probably the file could not be found;
	 	* as a last resort, let's try in current directory.
	 	*/
		if( !strchr( buffer, '/' ))
		{
			sprintf( buffer2, "./%s", buffer );
			execlp( buffer2, buffer2, NULL );
		}
		exit( -1 );
	}

	/* del if temp */
	fb_hStrDelTemp( program );

	return res;
}
