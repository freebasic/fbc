/* locate (console, no gfx) function for Windows */

#include "fb.h"

/*:::::*/
int fb_ConsoleLocate( int row, int col, int cursor )
{

	return (0);
}


/*:::::*/
int fb_ConsoleGetX( void )
{
	return(0);
}

/*:::::*/
int fb_ConsoleGetY( void )
{
	return(0);
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
}

/*:::::*/
FBCALL unsigned int fb_ConsoleReadXY( int col, int row, int colorflag )
{
	return(0);
}
