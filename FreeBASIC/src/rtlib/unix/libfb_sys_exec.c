/*
 *	libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
 *
 *	This library is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU Lesser General Public
 *	License as published by the Free Software Foundation; either
 *	version 2.1 of the License, or (at your option) any later version.
 *
 *	This library is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *	Lesser General Public License for more details.
 *
 *	You should have received a copy of the GNU Lesser General Public
 *	License along with this library; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *	As a special exception, the copyright holders of this library give
 *	you permission to link this library with independent modules to
 *	produce an executable, regardless of the license terms of these
 *	independent modules, and to copy and distribute the resulting
 *	executable under terms of your choice, provided that you also meet,
 *	for each linked independent module, the terms and conditions of the
 *	license of that module. An independent module is a module which is
 *	not derived from or based on this library. If you modify this library,
 *	you may extend this exception to your version of the library, but
 *	you are not obligated to do so. If you do not wish to do so, delete
 *	this exception statement from your version.
 */

/*
 * sys_exec.c -- exec function for Linux
 *
 * chng: nov/2004 written [lillo]
 *       dec/2006 updated [jeffmarshall] using fb_hParseArgs
 *
 */

#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#ifdef HAVE_ALLOCA_H
# include <alloca.h>
#endif

#include "fb.h"

/*:::::*/
FBCALL int fb_ExecEx ( FBSTRING *program, FBSTRING *args, int do_fork )
{
	char buffer[MAX_PATH+1], *application, *arguments, **argv, *p;
	int i, argc = 0, res = 0, status, len_program, len_arguments;
	pid_t pid;

	if( (program == NULL) || (program->data == NULL) ) 
	{
		fb_hStrDelTemp( args );
		fb_hStrDelTemp( program );
		return -1;
	}

	application = fb_hGetShortPath( program->data, buffer, MAX_PATH );
	DBG_ASSERT( application!=NULL );
	if( application==program->data ) 
	{
		len_program = FB_STRSIZE( program );
		application = buffer;
		FB_MEMCPY(application, program->data, len_program );
		application[len_program] = 0;
	}

	fb_hConvertPath( application, strlen( application ) );

	if( args==NULL ) 
	{
		arguments = "";
	} 
	else 
	{
		len_arguments = FB_STRSIZE( args );
		arguments = alloca( len_arguments + 1 );
		DBG_ASSERT( arguments!=NULL );
		arguments[len_arguments] = 0;
		if( len_arguments )
			argc = fb_hParseArgs( arguments, args->data, len_arguments );

	}

	FB_STRLOCK();

	fb_hStrDelTemp_NoLock( args );
	fb_hStrDelTemp_NoLock( program );

	FB_STRUNLOCK();

	if( argc == -1 )
		return -1;

	argc++; 			/* add 1 for program name */

	argv = alloca( sizeof(char*) * (argc + 1 ));
	DBG_ASSERT( argv!=NULL );

	argv[0] = application;

	/* scan the processed args and set pointers */
	p = arguments;
	for( i=1 ; i<argc; i++)
	{
		argv[i] = p;	/* set pointer to current argument */
		while( *p++ );	/* skip to 1 char past next null char */
	}
	argv[argc] = NULL;


	/* Launch */
	fb_hExitConsole();

	if( do_fork )
	{
		pid = fork();
		if( pid != -1 )
		{
			if (pid == 0)
			{
				exit( execvp( application, argv ) );
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
		res = execvp( application, argv );
	}

	fb_hInitConsole();

	return res;
}

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
	return fb_ExecEx( program, args, TRUE );
}

