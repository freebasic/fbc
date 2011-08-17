/* get short path for Windows */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{

	if( strchr( src, 32 ) == NULL )
	{
		strcpy( dst, src );
	}
	else
	{
	 	GetShortPathName( src, dst, maxlen );
    }

	return dst;
}

