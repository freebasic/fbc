/* SHELL command */

#include "fb.h"

FBCALL int fb_Shell( FBSTRING *program )
{
	int errcode = -1;

	if( program && program->data ) {
		errcode = fb_hShell( program->data );
	}

	/* del if temp */
	fb_hStrDelTemp( program );

	return errcode;
}
