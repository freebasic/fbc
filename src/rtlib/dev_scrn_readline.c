/* file device */

#include "fb.h"

int fb_DevScrnReadLine( FB_FILE *handle, FBSTRING *dst )
{
	return fb_LineInput( NULL, dst, -1, FALSE, FALSE, TRUE );
}

void fb_DevScrnInit_ReadLine( void )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK( );
	if( FB_HANDLE_SCREEN->hooks->pfnReadLine == NULL ) {
		FB_HANDLE_SCREEN->hooks->pfnReadLine = fb_DevScrnReadLine;
	}
	FB_UNLOCK( );
}
