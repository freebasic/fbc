/* file device */

#include "fb.h"

static FB_FILE_HOOKS hooks_dev_err = {
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

int fb_DevErrOpen( FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );

    FB_LOCK();

    handle->hooks = &hooks_dev_err;

    if ( handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    if( res == FB_RTERROR_OK ) {
        handle->opaque = stderr;
        handle->type = FB_FILE_TYPE_PIPE;
    }

    FB_UNLOCK();

	return res;
}
