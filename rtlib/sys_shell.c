/* SHELL command */

#include "fb.h"
#if defined HOST_UNIX
	#include "fb_private_console.h"
#endif

FBCALL int fb_Shell( FBSTRING *program )
{
	int errcode = -1;

	if( (program) && (program->data)) {

#if defined( HOST_DOS ) || defined( HOST_WIN32 )
		errcode = system( program->data );

#elif defined( HOST_UNIX )
		fb_hExitConsole();
		int status = system( program->data );
		/* system() result uses same format as the status
		   returned by waitpid(), or -1 on error */
		if( status != -1 && WIFEXITED( status ) ) {
			errcode = WEXITSTATUS( status );
			if( errcode == 127 ) {
				/* /bin/sh could not be executed */
				/* FIXME: can't tell difference if /bin/sh returned 127 */
				errcode = -1;
			}
		}
		fb_hInitConsole();

#elif defined( HOST_XBOX )
		XLaunchXBE( program->data );

#else
#	error TODO
#endif

	}

	/* del if temp */
	fb_hStrDelTemp( program );

	return errcode;
}
