/* file device */

#include "fb.h"

int fb_DevScrnReadLineWstr( FB_FILE *handle, FB_WCHAR *dst, ssize_t dst_chars )
{
	int res;
	FBSTRING temp = { 0, 0, 0 };

	/* !!!FIXME!!! no unicode input supported */

	res = fb_LineInput( NULL, (void *)&temp, -1, FALSE, FALSE, TRUE );

	if( res == FB_RTERROR_OK ) {
		fb_WstrAssignFromA( dst, dst_chars, (void *)&temp, -1 );
	}

	fb_StrDelete( &temp );

	return res;
}

void fb_DevScrnInit_ReadLineWstr( void )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK( );
	if( FB_HANDLE_SCREEN->hooks->pfnReadLineWstr == NULL ) {
		FB_HANDLE_SCREEN->hooks->pfnReadLineWstr = fb_DevScrnReadLineWstr;
	}
	FB_UNLOCK( );
}
