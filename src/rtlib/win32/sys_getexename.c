/* get the executable's name */

#include "../fb.h"
#include <windows.h>

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;

	return p;
}
