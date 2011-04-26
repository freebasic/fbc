/*
 * sys_shell.c -- SHELL command for Linux
 *
 * chng: apr/2005 written [lillo]
 *
 */

#include <unistd.h>

#include "fb.h"

/*:::::*/
FBCALL int fb_Shell ( FBSTRING *program )
{
	int errcode = -1;

	if( (program) && (program->data)) {
		fb_hExitConsole();
		errcode = system( program->data );
		fb_hInitConsole();
	}

	/* del if temp */
	fb_hStrDelTemp( program );

	return errcode;
}
