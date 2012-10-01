/* file copy */

#include "../fb.h"
#include <windows.h>

FBCALL int fb_FileCopy( const char *source, const char *destination )
{
	BOOL res;
	res = CopyFile( source, destination, FALSE );
	return fb_ErrorSetNum( res == FALSE ? FB_RTERROR_ILLEGALFUNCTIONCALL : FB_RTERROR_OK );
}
