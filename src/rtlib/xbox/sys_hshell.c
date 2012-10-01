/* SHELL command */

#include "../fb.h"

int fb_hShell( char *program )
{
	XLaunchXBE( program );
	return -1;
}
