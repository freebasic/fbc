#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetX( void )
{
	int x;
	fb_ConsoleGetXY( &x, NULL );
	return x;
}
