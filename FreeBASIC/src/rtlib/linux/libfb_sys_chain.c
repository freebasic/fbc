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
 * sys_chain.c -- chain function for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <malloc.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#define MAX_PATH	1024

#include "fb.h"
#include "fb_linux.h"

/*:::::*/
FBCALL int fb_Chain ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    int		res = 0;

	FB_STRLOCK();
	
	if( (program != NULL) && (program->data != NULL) )
	{
		pid_t pid;
		int status;

		fb_hExitConsole();
		if ((pid = fork()) == 0)
		{
			char buffer2[MAX_PATH+3];

			FB_STRUNLOCK();

			fb_hGetShortPath( program->data, buffer, MAX_PATH );
			execlp( buffer, buffer, NULL );
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
		else
		{
			waitpid(pid, &status, 0);
			if (WIFEXITED(status))
				res = WEXITSTATUS(status);
			else
				res = -1;
		}
		fb_hInitConsole(fb_con.inited);
	}

	/* del if temp */
	fb_hStrDelTemp( program );

	FB_STRUNLOCK();

	return res;
}
