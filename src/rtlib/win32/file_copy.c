/* file copy, support wide string filenames */

#include "../fb.h"
#include <windows.h>

//FBCALL int fb_FileCopy( const char *source, const char *destination )
//{
//	BOOL res;
//	res = CopyFile( source, destination, FALSE );
//	return fb_ErrorSetNum( res == FALSE ? FB_RTERROR_ILLEGALFUNCTIONCALL : FB_RTERROR_OK );
//}

FBCALL int fb_FileCopyW( const FB_WCHAR *source, const FB_WCHAR *destination )
{
	BOOL res;
	res = CopyFileW( source, destination, FALSE );
	return fb_ErrorSetNum( res == FALSE ? FB_RTERROR_ILLEGALFUNCTIONCALL : FB_RTERROR_OK );
}
