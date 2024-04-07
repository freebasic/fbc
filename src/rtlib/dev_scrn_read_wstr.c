/* file device */

#include "fb.h"

int fb_DevScrnReadWstr( FB_FILE *handle, FB_WCHAR *dst, size_t *pchars )
{
	size_t chars, copy_chars;
	DEV_SCRN_INFO *info;

	/* !!!FIXME!!! no unicode input supported */

	FB_LOCK();

	chars = *pchars;

	info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;

	while( chars > 0 )
	{
		size_t len = info->length / sizeof( FB_WCHAR );
		copy_chars = (chars > len) ? len : chars;
		if( copy_chars == 0 )
		{
			while( fb_KeyHit( ) == 0 )
				fb_Delay( 25 );    /* release time slice */

			fb_DevScrnFillInput( info );
			if( info->length != 0 )
				continue;

			break;
		}

		fb_wstr_ConvFromA( dst, chars, info->buffer );

		info->length -= copy_chars * sizeof( FB_WCHAR );
		if( info->length != 0 )
		{
			memmove( info->buffer,
					 info->buffer + copy_chars * sizeof( FB_WCHAR ),
					 info->length );
		}

		chars -= copy_chars;
		dst += copy_chars;
	}

	FB_UNLOCK();

	if( chars != 0 )
	{
		memset( dst, 0, chars * sizeof( FB_WCHAR ) );
	}

	*pchars -= chars;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int hReadFromStdin( FB_FILE *handle, FB_WCHAR *dst, size_t *pchars )
{
	return fb_DevFileReadWstr( NULL, dst, pchars );
}

void fb_DevScrnInit_ReadWstr( void )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK( );
	if( FB_HANDLE_SCREEN->hooks->pfnReadWstr == NULL )
	{
		FB_HANDLE_SCREEN->hooks->pfnReadWstr =
			(fb_IsRedirected( TRUE )? hReadFromStdin : fb_DevScrnReadWstr);
	}
	FB_UNLOCK( );
}
