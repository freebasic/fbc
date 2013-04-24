/* get the executable path */

#include "../fb.h"
#include <windows.h>

char *fb_hGetExePath( char *dst, int maxlen )
{
	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		*(p + 1) = '\0';
	else
		dst[0] = '\0';

	return p;
}
