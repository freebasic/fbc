/* file device */

#include "fb.h"

#ifdef HOST_XBOX

int fb_DevPipeOpen( FB_FILE *handle, const char *filename, size_t filename_len )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

#else

static FB_FILE_HOOKS hooks_dev_pipe = {
    fb_DevFileEof,
    fb_DevPipeClose,
    NULL,
    NULL,
    fb_DevFileRead,
    fb_DevFileReadWstr,
    fb_DevFileWrite,
    fb_DevFileWriteWstr,
    NULL,
    NULL,
    fb_DevFileReadLine,
    fb_DevFileReadLineWstr,
    NULL,
    fb_DevFileFlush
};

int fb_DevPipeOpen( FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    FILE *fp = NULL;
    char openmask[16];

    FB_LOCK();

    handle->hooks = &hooks_dev_pipe;

    openmask[0] = 0;

    switch( handle->mode )
    {
    case FB_FILE_MODE_INPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_READ;

        if( handle->access != FB_FILE_ACCESS_READ )
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

        strcpy( openmask, "r" );
        break;

    case FB_FILE_MODE_OUTPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_WRITE;

        if( handle->access != FB_FILE_ACCESS_WRITE )
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

        strcpy( openmask, "w" );
        break;

    case FB_FILE_MODE_BINARY:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_WRITE;

		strcpy( openmask, (handle->access == FB_FILE_ACCESS_WRITE? "wb" : "rb") );

        break;

    default:
    	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( res == FB_RTERROR_OK )
    {
        /* try to open/create pipe */
#ifdef HOST_MINGW
        if( (fp = _popen( filename, openmask )) == NULL )
#else
        if( (fp = popen( filename, openmask )) == NULL )
#endif
        {
            res = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
        handle->opaque = fp;
        handle->type = FB_FILE_TYPE_PIPE;
    }

    FB_UNLOCK();

	return res;
}

#endif
