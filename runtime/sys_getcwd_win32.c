/* get current dir for Windows */

#include "fb.h"

/*:::::*/
int fb_hGetCurrentDir ( char *dst, int maxlen )
{
	return GetCurrentDirectory( maxlen, dst );
}
