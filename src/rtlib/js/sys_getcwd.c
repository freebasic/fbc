/* get current dir */

#include "../fb.h"

ssize_t fb_hGetCurrentDir( char *dst, ssize_t maxlen )
{
	if( getcwd( dst, maxlen ) != NULL )
		return strlen( dst );
	return 0;
}
