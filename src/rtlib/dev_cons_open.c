/* file device */

#include "fb.h"

static FB_FILE_HOOKS hooks_dev_cons = {
    fb_DevFileEof,
    fb_DevStdIoClose,
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

int fb_DevConsOpen( FB_FILE *handle, const char *filename, size_t filename_len )
{
    switch ( handle->mode )
    {
	case FB_FILE_MODE_INPUT:
	case FB_FILE_MODE_OUTPUT:
	case FB_FILE_MODE_APPEND:
		break;

	default:
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    FB_LOCK();

    handle->hooks = &hooks_dev_cons;

    if ( handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_WRITE;

    handle->opaque = (handle->mode == FB_FILE_MODE_INPUT? stdin : stdout);
    handle->type = FB_FILE_TYPE_PIPE;

    FB_UNLOCK();

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
