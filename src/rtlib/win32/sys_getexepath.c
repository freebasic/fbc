/* get the executable path */

#include "../fb.h"
#include <windows.h>

char *fb_hGetExePath( char *dst, int maxlen )
{
	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';
	else
		dst[0] = '\0';

	/* just a drive letter? make sure \ follows to prevent using relative path */
	if( maxlen > 3 && dst[2] == '\0' && dst[1] == ':' )
	{
		if( (dst[0] & ~32) >= 'A' && (dst[0] & ~32) <= 'Z' )
		{
			dst[2] = '\\';
			dst[3] = '\0';
		}
	}

	return p;
}
