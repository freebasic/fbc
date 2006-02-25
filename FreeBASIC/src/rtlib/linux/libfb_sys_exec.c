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
 * sys_exec.c -- exec function for Linux
 *
 * chng: nov/2004 written [lillo]
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
FBCALL int fb_ExecEx ( FBSTRING *program, FBSTRING *args, int do_fork )
{
    char buffer[MAX_PATH+1], *argv[256], *argsdata, *cmdline, *this_arg;
   	int i, argc = 1, res = 0, status;
	pid_t pid;

	if( (program != NULL) && (program->data != NULL) )
	{
		if( (args == NULL) || (args->data == NULL) )
			argsdata = "\0";
		else
			argsdata = args->data;

		/* Build argv list */
		argv[0] = &buffer[0];
		cmdline = strdup( argsdata );
		this_arg = cmdline;
		for (i = 0; (i < strlen( argsdata )) && (argc < 255);) {
			while ((argsdata[i] != ' ') && (argsdata[i] != '\0'))
				i++;
			cmdline[i] = '\0';
			if (strchr(this_arg, '\"')) {
				cmdline[i-1] = '\0';
				fb_hGetShortPath(this_arg + 1, buffer, MAX_PATH);
				argv[argc] = strdup(buffer);
			}
			else
				argv[argc] = strdup(this_arg);
			while (argsdata[i] == ' ')
				i++;
			this_arg = &cmdline[i];
			argc++;
		}
		argv[argc] = NULL;

		/* Launch */
		fb_hExitConsole();

		fb_hConvertPath( program->data, strlen( program->data ) );

		if( do_fork )
		{
			pid = fork();
			if( pid != -1 )
			{
				if (pid == 0)
				{
					exit( execvp( fb_hGetShortPath( program->data, buffer, MAX_PATH ), argv ) );
				}
				else
				{
					if( waitpid(pid, &status, 0) > 0 )
					{
						if (WIFEXITED(status))
						{
							/* only the LSB is returned */
							res = WEXITSTATUS(status);
							if( res == 255 )
								res = -1;
						}
						else
							res = -1;
					}
					else
						res = -1;
				}
			}
			else
				res = -1;
		}
		else
		{
			res = execvp( fb_hGetShortPath( program->data, buffer, MAX_PATH ), argv );
		}

		fb_hInitConsole();

		free(cmdline);
		for (i = 1; i < argc; i++)
			free(argv[i]);

	}

	/* del if temp */
	FB_STRLOCK();

	fb_hStrDelTemp_NoLock( args );
	fb_hStrDelTemp_NoLock( program );

	FB_STRUNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
	return fb_ExecEx( program, args, TRUE );
}

