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
 * sys_exec.c -- exec function
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
char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{

	if( strchr( src, 32 ) == NULL )
	{
		strcpy( dst, src );
	}
	else
	{
#ifdef WIN32
	 	GetShortPathName( src, dst, maxlen );
#else
		int i = 0;
		char *old_dst = dst;

		while ((*src) && (i < maxlen - 1)) {
			if (*src == ' ') {
				*dst++ = '\\';
				i++;
			}
			if (i == maxlen - 1)
				break;
			*dst++ = *src++;
			i++;
		}
		dst = old_dst;
		dst[maxlen - 1] = '\0';
#endif
    }

	return dst;
}


/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
    char	buffer[MAX_PATH+1];
    char	*argv[256];
    int		res;

	if( (program != NULL) && (program->data != NULL) )
	{
		char *argsdata;

		if( (args == NULL) || (args->data == NULL) )
			argsdata = "\0";
		else
			argsdata = args->data;

#ifdef WIN32
		argv[0] = &buffer[0];
		argv[1] = argsdata;
		argv[2] = NULL;
		res = _spawnv( _P_WAIT, fb_hGetShortPath( program->data, buffer, MAX_PATH ), (const char **)argv );
#else
		char	*cmdline, *this_arg;
    	int		i, argc = 1;
		pid_t	pid;
		int		status;

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
		if ((pid = fork()) == 0) {
			exit( execvp( fb_hGetShortPath( program->data, buffer, MAX_PATH ), argv ) );
		}
		else {
			waitpid(pid, &status, 0);
			if (WIFEXITED(status))
				res = WEXITSTATUS(status);
			else
				res = -1;
		}
		free(cmdline);
		for (i = 1; i < argc; i++)
			free(argv[i]);

#endif
	}

	/* del if temp */
	fb_hStrDelTemp( args );
	fb_hStrDelTemp( program );

	return res;
}

