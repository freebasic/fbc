/* winput$ function */

#include "fb.h"

FBCALL FB_WCHAR *fb_FileWstrInput( ssize_t chars, int fnum )
{
	FB_FILE *handle;
	FB_WCHAR *dst;
	size_t len;
	int res = FB_RTERROR_OK;

	fb_DevScrnInit_ReadWstr( );

	FB_LOCK();

	handle = FB_FILE_TO_HANDLE(fnum);
	if( !FB_HANDLE_USED(handle) )
	{
		FB_UNLOCK();
		return NULL;
	}

	dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
	{
		ssize_t read_chars = 0;
		if( FB_HANDLE_IS_SCREEN(handle) )
		{
			while( read_chars != chars )
			{
				res = fb_FileGetDataEx( handle,
					0,
					(void *)&dst[read_chars],
					chars - read_chars,
					&len,
					TRUE,
					TRUE );
				if( res != FB_RTERROR_OK )
					break;

				read_chars += len;
			}
		}
		else
		{
			res = fb_FileGetDataEx( handle,
				0,
				(void *)dst,
				chars,
				&len,
				TRUE,
				TRUE );
			read_chars = chars;
		}

		if( res == FB_RTERROR_OK )
		{
			dst[read_chars] = _LC('\0');
		}
		else
		{
			fb_wstr_Del( dst );
			dst = NULL;
		}

	}
	else
	{
		res = FB_RTERROR_OUTOFMEM;
	}

	FB_UNLOCK();

	return dst;
}
