#include "../fb.h"
#include "fb_private_console.h"
#include <process.h>

FBCALL int fb_ExecEx( FBSTRING *program, FBSTRING *args, int do_fork )
{
	char buffer[MAX_PATH], *arguments, **argv, *p;
	int i, argc = 0, res = 0;
	ssize_t len_arguments;

	if( (program == NULL) || (program->data == NULL) ) 
	{
		fb_hStrDelTemp( args );
		fb_hStrDelTemp( program );
		return -1;
	}

	fb_hGetShortPath( program->data, buffer, MAX_PATH );

	if( args==NULL ) {
		arguments = "";
	} else {
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

	argv[0] = buffer;

	/* scan the processed args and set pointers */
	p = arguments;
	for( i=1 ; i<argc; i++)
	{
		argv[i] = p;	/* set pointer to current argument */
		while( *p++ );	/* skip to 1 char past next null char */
	}
	argv[argc] = NULL;

	/* NOTE: DJGPP info on 3rd arg of spawnv* functions is inconsistent;
	   in docs, defined as const char **;
	   in process.h, defined as char *const _argv[]
	*/

	if( do_fork )
		res = spawnv( P_WAIT, buffer, (char * const *)argv );
	else
		res = execv( buffer, (char * const *)argv );

	return res;
}
