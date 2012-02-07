/* SHELL command */

#include "fb.h"

FBCALL int fb_Shell( FBSTRING *program )
{
	int errcode = -1;

	if( (program) && (program->data)) {
#if defined( HOST_DOS ) || defined( HOST_WIN32 )
		errcode = system( program->data );
#elif defined( HOST_UNIX )
		fb_hExitConsole();
		errcode = system( program->data );
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
