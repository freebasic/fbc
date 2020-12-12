/* console line input function */

#include "../fb.h"
#include "fb_private_console.h"


char *fb_ConsoleReadStr( char *buffer, ssize_t len )
{
	EM_ASM_ARGS({
		var jsString = __fb_rtlib.console.input();
		jsString+='\n';
		stringToUTF8(jsString, $0, $1);
	}, buffer, len );


	return buffer;

	//return fgets( buffer, len, stdin );
}
