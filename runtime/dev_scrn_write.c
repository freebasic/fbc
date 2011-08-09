/* file device */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

FBCALL void fb_PrintBufferEx( const void *buffer, size_t len, int mask );

/*:::::*/
int fb_DevScrnWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    fb_PrintBufferEx( value, valuelen, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
void fb_DevScrnInit_Write( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnWrite == NULL )
    	FB_HANDLE_SCREEN->hooks->pfnWrite = fb_DevScrnWrite;
}
