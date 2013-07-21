/* console line input function */

#include "../fb.h"
#include "fb_private_console.h"

char *fb_ConsoleReadStr( char *buffer, ssize_t len )
{
	char *res;

	fb_hRestoreConsoleWindow( );
	FB_CON_CORRECT_POSITION();
	fb_hConsolePutBackEvents( );

	res = fgets( buffer, len, stdin );

	fb_hUpdateConsoleWindow( );

	return res;
}
