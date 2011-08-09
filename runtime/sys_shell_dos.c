/* SHELL command for DOS */

#include <stdlib.h>

#include "fb.h"

/*:::::*/
FBCALL int fb_Shell ( FBSTRING *program )
{
	int errcode = -1;

	if( (program) && (program->data))
		errcode = system( program->data );

	/* del if temp */
	fb_hStrDelTemp( program );

	return errcode;
}
