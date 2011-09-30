/* get the executable path for Windows */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hGetExePath( char *dst, int maxlen )
{
	char *p;

	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';
	else
		dst[0] = '\0';

	return p;
}
