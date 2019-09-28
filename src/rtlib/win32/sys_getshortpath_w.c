#include "../fb.h"
#include <windows.h>

FB_WCHAR *fb_hGetShortPath_W( FB_WCHAR *src, FB_WCHAR *dst, ssize_t maxlen )
{
//	if( wcschr( src, 32 ) == NULL ) {
//		wcscpy( dst, src );
//	} else {
	 	GetShortPathNameW( src, dst, maxlen );
//	}

	return dst;
}
