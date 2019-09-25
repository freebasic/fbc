/* file device */

#include "fb.h"

static FB_FILE_HOOKS hooks_dev_file = {
    fb_DevFileEof,
    fb_DevFileClose,
    fb_DevFileSeek,
    fb_DevFileTell,
    fb_DevFileRead,
    fb_DevFileReadWstr,
    fb_DevFileWrite,
    fb_DevFileWriteWstr,
    fb_DevFileLock,
    fb_DevFileUnlock,
    fb_DevFileReadLine,
    fb_DevFileReadLineWstr,
    NULL,
    fb_DevFileFlush
};

void fb_hSetFileBufSize( FILE *fp )
{
	/* change the default buffer size */
	setvbuf( fp, NULL, _IOFBF, FB_FILE_BUFSIZE );
	/* Note: setvbuf() is only allowed to be called before doing any I/O
	   with that FILE handle */
}

int fb_DevFileOpen( FB_FILE *handle, const char *filename, size_t fname_len )
{
    FILE *fp = NULL;
    char *openmask;
    char *fname;

    FB_LOCK();

    fname = (char*) alloca(fname_len + 1);
    memcpy(fname, filename, fname_len);
    fname[fname_len] = 0;

    /* Convert directory separators to whatever the current platform supports */
    fb_hConvertPath( fname );

    handle->hooks = &hooks_dev_file;

    openmask = NULL;
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        /* will create the file if it doesn't exist */
        openmask = "ab";
        break;

    case FB_FILE_MODE_INPUT:
        /* will fail if file doesn't exist */
        openmask = "rt";
        break;

    case FB_FILE_MODE_OUTPUT:
        /* will create the file if it doesn't exist */
        openmask = "wb";
        break;

    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:

        switch( handle->access )
        {
        case FB_FILE_ACCESS_WRITE:
            openmask = "wb";
            break;
        case FB_FILE_ACCESS_READ:
            openmask = "rb";
            break;
        default:
            /* w+ would erase the contents */
            openmask = "r+b";
            break;
        }
    }

    if( openmask == NULL )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    handle->size = -1;

    switch (handle->mode)
    {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            /* if file was not found and in READ/WRITE (or ANY) mode,
             * create it */
            if( handle->access == FB_FILE_ACCESS_ANY
                || handle->access == FB_FILE_ACCESS_READWRITE )
            {
                fp = fopen( fname,  "w+b" );

                /* if file could not be created and in ANY mode, try opening as read-only */
                if( (fp == NULL) && (handle->access==FB_FILE_ACCESS_ANY) ) {
                    fp = fopen( fname,  "rb" );
                    if (fp != NULL) {
                        // don't forget to set the effective access mode ...
                        handle->access = FB_FILE_ACCESS_READ;
                    }
                }
            }

            if( fp == NULL )
            {
                FB_UNLOCK();
                return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
            }
        }

        fb_hSetFileBufSize( fp );
        break;

    /* special case, fseek() is unreliable in text-mode, so the file size
       must be calculated in binary mode - bin mode can't be used for text
       input because newlines must be converted, and EOF char (27) handled */
    case FB_FILE_MODE_INPUT:
        /* try opening in binary mode */
        if( (fp = fopen( fname, "rb" )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize( fp );

        /* calc file size */
        handle->size = fb_DevFileGetSize( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );
        if( handle->size == -1 )
        {
        	fclose( fp );
            FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

        /* now reopen it in text-mode */
        if( (fp = freopen( fname, openmask, fp )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize( fp );

        /* skip BOM, if any */
        fb_hDevFileSeekStart( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );

        break;

    default:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize( fp );
    }

	if( handle->size == -1 )
	{
        /* calc file size */
        handle->size = fb_DevFileGetSize( fp, handle->mode, handle->encod, TRUE );
        if( handle->size == -1 )
        {
        	fclose( fp );
            FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    handle->opaque = fp;
    if (handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    /* We just need this for TAB(n) and SPC(n) */
    if( strcasecmp( fname, "CON" )==0 )
        handle->type = FB_FILE_TYPE_CONSOLE;

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
