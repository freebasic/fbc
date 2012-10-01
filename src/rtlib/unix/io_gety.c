#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetY( void )
{
	int y;
	fb_ConsoleGetXY( NULL, &y );
	return y;
}
