/* file device */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

int fb_DevScrnReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
    return fb_LineInput( NULL, dst, -1, FALSE, FALSE, TRUE );
}


/*:::::*/
void fb_DevScrnInit_ReadLine( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnReadLine == NULL )
        FB_HANDLE_SCREEN->hooks->pfnReadLine = fb_DevScrnReadLine;
}
