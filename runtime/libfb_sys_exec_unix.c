/* exec function for Linux */

#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

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

