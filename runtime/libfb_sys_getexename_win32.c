/* get the executable's name for Windows */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hGetExeName( char *dst, int maxlen )
{
	char *p;

	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;

	return p;
}
