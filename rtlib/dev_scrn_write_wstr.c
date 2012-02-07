/* file device */

#include "fb.h"

/*:::::*/
int fb_DevScrnWriteWstr( struct _FB_FILE *handle, const FB_WCHAR* value, size_t valuelen )
{
    fb_PrintBufferWstrEx( value, valuelen, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
void fb_DevScrnInit_WriteWstr( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnWriteWstr == NULL )
    	FB_HANDLE_SCREEN->hooks->pfnWriteWstr = fb_DevScrnWriteWstr;
}
