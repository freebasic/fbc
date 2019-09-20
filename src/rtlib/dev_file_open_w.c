/* file device (wide string) */

#include "fb.h"

#if defined( HOST_WIN32 )                             //restrict to Windows

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

void fb_hSetFileBufSize_W( FILE *fp )
{
	/* change the default buffer size */
	setvbuf( fp, NULL, _IOFBF, FB_FILE_BUFSIZE );
	/* Note: setvbuf() is only allowed to be called before doing any I/O
	   with that FILE handle */
}
#endif

int fb_DevFileOpen_W( FB_FILE *handle, const FB_WCHAR *filename, size_t fname_len )
{
//#if defined( HOST_DOS ) || defined( HOST_WIN32 ) || defined( HOST_XBOX )
#if defined( HOST_WIN32 )                             //restrict to Windows

    FILE *fp = NULL;
    FB_WCHAR *openmask;
    FB_WCHAR *fname;

    FB_LOCK();

    fname = (FB_WCHAR*) alloca(fname_len * sizeof(FB_WCHAR) + sizeof(FB_WCHAR)); // + 1);
    memcpy(fname, filename, fname_len * sizeof(FB_WCHAR));
    fname[fname_len] = 0;

    /* Convert directory separators to whatever the current platform supports */
    fb_hConvertPath_W( fname );

    handle->hooks = &hooks_dev_file;

    openmask = NULL;
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        /* will create the file if it doesn't exist */
        openmask = L"ab";
        break;

    case FB_FILE_MODE_INPUT:
        /* will fail if file doesn't exist */
        openmask = L"rt";
        break;

    case FB_FILE_MODE_OUTPUT:
        /* will create the file if it doesn't exist */
        openmask = L"wb";
        break;

    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:

        switch( handle->access )
        {
        case FB_FILE_ACCESS_WRITE:
            openmask = L"wb";
            break;
        case FB_FILE_ACCESS_READ:
            openmask = L"rb";
            break;
        default:
            /* w+ would erase the contents */
            openmask = L"r+b";
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
        if( (fp = _wfopen( fname, openmask )) == NULL )
        {
            /* if file was not found and in READ/WRITE (or ANY) mode,
             * create it */
            if( handle->access == FB_FILE_ACCESS_ANY
                || handle->access == FB_FILE_ACCESS_READWRITE )
            {
                fp = _wfopen( fname,  L"w+b" );

                /* if file could not be created and in ANY mode, try opening as read-only */
                if( (fp == NULL) && (handle->access==FB_FILE_ACCESS_ANY) ) {
                    fp = _wfopen( fname,  L"rb" );
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

        fb_hSetFileBufSize_W( fp );
        break;

    /* special case, fseek() is unreliable in text-mode, so the file size
       must be calculated in binary mode - bin mode can't be used for text
       input because newlines must be converted, and EOF char (27) handled */
    case FB_FILE_MODE_INPUT:
        /* try opening in binary mode */
        if( (fp = _wfopen( fname, L"rb" )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize_W( fp );

        /* calc file size */
        handle->size = fb_DevFileGetSize( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );
        if( handle->size == -1 )
        {
            fclose( fp );
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

        /* now reopen it in text-mode */
        if( (fp = _wfreopen( fname, openmask, fp )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize_W( fp );

        /* skip BOM, if any */
        fb_hDevFileSeekStart( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );

        break;

    default:
        /* try opening */
        if( (fp = _wfopen( fname, openmask )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        fb_hSetFileBufSize_W( fp );
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
    if( _wcsicmp( fname, L"CON" )==0 )
        handle->type = FB_FILE_TYPE_CONSOLE;

    FB_UNLOCK();

    return fb_ErrorSetNum( FB_RTERROR_OK );

#else
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
#endif
}
