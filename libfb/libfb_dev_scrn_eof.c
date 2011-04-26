/*
 *	dev_file_eof - detects EOF for file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

void fb_DevScrnFillInput( DEV_SCRN_INFO *info )
{
    FBSTRING *str;
    size_t len = 0;

    str = fb_Inkey( );
    if( str != NULL )
    {
    	len = FB_STRSIZE( str );
	    if( (str->data != NULL) && (len > 0) )
	    {
	    	DBG_ASSERT(len < sizeof(info->buffer));
    		/* copy null-term too */
    		memcpy( info->buffer, str->data, len+1 );
    	}

    	fb_hStrDelTemp( str );
    }

    info->length = len;
}

/*:::::*/
int fb_DevScrnEof( struct _FB_FILE *handle )
{
    DEV_SCRN_INFO *info;
    int       got_data;

    FB_LOCK();
    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;
    got_data = info->length!=0;
    FB_UNLOCK();
    if( !got_data ) {
        FB_LOCK();
        fb_DevScrnFillInput( info );
        got_data = info->length!=0;
        FB_UNLOCK();
    }
	return !got_data;
}


