/* SHELL command */

#include "../fb.h"
#include "fb_private_console.h"

int fb_hShell( char *program )
{
	int errcode;

	fb_hExitConsole();

	errcode = system( program );

	/* system() result uses same format as the status
	   returned by waitpid(), or -1 on error */
	if( errcode != -1 && WIFEXITED( errcode ) ) {
		errcode = WEXITSTATUS( errcode );
		if( errcode == 127 ) {
			/* /bin/sh could not be executed */
			/* FIXME: can't tell difference if /bin/sh returned 127 */
			errcode = -1;
		}
	}

	fb_hInitConsole();

	return errcode;
}
