/* get current dir */

#include "../fb.h"
#include <windows.h>

int fb_hGetCurrentDir( char *dst, int maxlen )
{
	return GetCurrentDirectory( maxlen, dst );
}
