/* get current dir (wide string) */

#include "../fb.h"
#include <windows.h>

ssize_t fb_hGetCurrentDir_W( FB_WCHAR *dst, ssize_t maxlen )
{
	return GetCurrentDirectoryW( maxlen, dst );
}
