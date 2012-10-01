/* get current dir */

#include "../fb.h"

int fb_hGetCurrentDir( char *dst, int maxlen )
{
	if( getcwd( dst, maxlen ) != NULL )
		return strlen( dst );
	return 0;
}
