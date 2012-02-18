/* UTF-encoded file device LINE INPUT for strings */

#include "fb.h"

int fb_DevFileReadLineEncod( FB_FILE *handle, FBSTRING *dst )
{
    int res;
    FILE *fp;
    char c[2] = { 0 };

	FB_LOCK();

    fp = (FILE *)handle->opaque;
    if( fp == stdout || fp == stderr )
        fp = stdin;

	if( fp == NULL )
	{
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    fb_StrDelete( dst );

    while( TRUE )
    {
    	size_t len;
    	res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, FALSE );
    	if( res != FB_RTERROR_OK )
    		break;

    	if( c[0] != _LC('\r') )
    	{
    		if( c[0] != _LC('\n') )
    			fb_StrConcatAssign( (void *)dst, -1, c, 1, FB_FALSE );
    		else
    			break;
    	}
    	else
    	{
    		res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, FALSE );
    		if( res != FB_RTERROR_OK )
    			break;
    		if( c[0] != _LC('\n') )
    			fb_FilePutBackEx( handle, c, 1 );
    		break;
    	}
    }

	FB_UNLOCK();

	return res;
}
