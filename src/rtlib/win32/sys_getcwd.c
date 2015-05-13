/* get current dir */

#include "../fb.h"
#include <windows.h>

ssize_t fb_hGetCurrentDir( char *dst, ssize_t maxlen )
{
	return GetCurrentDirectory( maxlen, dst );
}
