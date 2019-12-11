#include "../fb.h"
#include <windows.h>

char *fb_hGetShortPath( char *src, char *dst, ssize_t maxlen )
{
	if( strchr( src, 32 ) == NULL ) {
		strncpy( dst, src, maxlen );
		dst[maxlen-1] = '\0';
	} else {
	 	GetShortPathName( src, dst, maxlen );
	}

	return dst;
}
