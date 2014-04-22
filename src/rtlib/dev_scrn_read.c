/* file device */

#include "fb.h"

int fb_DevScrnRead( FB_FILE *handle, void* value, size_t *pLength )
{
    size_t length, copy_length;
    DEV_SCRN_INFO *info;
    char *pachBuffer = (char*) value;

    FB_LOCK();

    DBG_ASSERT(pLength!=NULL);
    length = *pLength;

    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;

    while( length > 0 ) {
        copy_length = (length > info->length) ? info->length : length;
        if (copy_length==0) {

        	while( fb_KeyHit( ) == 0 )
           		fb_Delay( 25 );				/* release time slice */

            fb_DevScrnFillInput( info );
            if( info->length != 0 )
                continue;

            break;
        }
        memcpy(pachBuffer, info->buffer, copy_length);
        info->length -= copy_length;
        if (info->length!=0) {
            memmove(info->buffer,
                    info->buffer + copy_length,
                    info->length);
        }
        length -= copy_length;
        pachBuffer += copy_length;
    }

    FB_UNLOCK();

    if (length!=0)
        memset(pachBuffer, 0, length);

    *pLength -= length;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int hReadFromStdin( FB_FILE *handle, void* dst, size_t *pLength )
{
    return fb_DevFileRead( NULL, dst, pLength );
}

void fb_DevScrnInit_Read( void )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK( );
    if( FB_HANDLE_SCREEN->hooks->pfnRead == NULL )
    {
    	FB_HANDLE_SCREEN->hooks->pfnRead =
    				(fb_IsRedirected( TRUE )? hReadFromStdin : fb_DevScrnRead);
    }
	FB_UNLOCK( );
}
