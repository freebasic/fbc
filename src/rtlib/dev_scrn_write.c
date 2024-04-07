/* file device */

#include "fb.h"

int fb_DevScrnWrite( FB_FILE *handle, const void* value, size_t valuelen )
{
	fb_PrintBufferEx( value, valuelen, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

void fb_DevScrnInit_Write( void )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK( );
	if( FB_HANDLE_SCREEN->hooks->pfnWrite == NULL ) {
		FB_HANDLE_SCREEN->hooks->pfnWrite = fb_DevScrnWrite;
	}
	FB_UNLOCK( );
}
