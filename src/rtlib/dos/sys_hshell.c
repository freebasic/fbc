/* SHELL command */

#include "../fb.h"

int fb_hShell( char *program )
{
	return system( program );
}
