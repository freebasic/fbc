/* UTF-encoded file device LINE INPUT for wstrings */

#include "fb.h"

int fb_DevFileReadLineEncodWstr( FB_FILE *handle, FB_WCHAR *dst, int max_chars )
{
    int res;
    FILE *fp;
    FB_WCHAR c[2] = { 0 };

	FB_LOCK();

    fp = (FILE *)handle->opaque;
    if( fp == stdout || fp == stderr )
        fp = stdin;

	if( fp == NULL )
	{
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    *dst = _LC('\0');

    while( TRUE )
    {
    	size_t len;
    	res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, TRUE );
    	if( (res != FB_RTERROR_OK) || (len == 0) )
    		break;

    	if( c[0] == _LC('\r') )
    	{
    		res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, TRUE );
    		if( (res != FB_RTERROR_OK) || (len == 0) )
    			break;

    		if( c[0] != _LC('\n') )
    			fb_FilePutBackEx( handle, c, 1 );

    		break;
    	}
    	else if( c[0] == _LC('\n') )
    	{
    			break;
    	}

    	fb_WstrConcatAssign( dst, max_chars, c );
    }

	FB_UNLOCK();

	return res;
}
