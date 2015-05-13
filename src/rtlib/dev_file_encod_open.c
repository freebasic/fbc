/* UTF-encoded file devices open */

#include "fb.h"

static FB_FILE_HOOKS hooks_dev_file = {
    fb_DevFileEof,
    fb_DevFileClose,
    fb_DevFileSeek,
    fb_DevFileTell,
    fb_DevFileReadEncod,
    fb_DevFileReadEncodWstr,
    fb_DevFileWriteEncod,
    fb_DevFileWriteEncodWstr,
    fb_DevFileLock,
    fb_DevFileUnlock,
    fb_DevFileReadLineEncod,
	fb_DevFileReadLineEncodWstr,
    NULL,
    fb_DevFileFlush
};

static int hCheckBOM( FB_FILE *handle )
{
    int res, bom = 0;
    FILE *fp = (FILE *)handle->opaque;

    if( handle->mode == FB_FILE_MODE_APPEND )
    	fseek( fp, 0, SEEK_SET );

    switch( handle->encod )
    {
    case FB_FILE_ENCOD_UTF8:
        if( fread( &bom, 3, 1, fp ) != 1 )
        	return 0;

    	res = (bom == 0x00BFBBEF);
    	break;

	case FB_FILE_ENCOD_UTF16:
        if( fread( &bom, sizeof( UTF_16 ), 1, fp ) != 1 )
        	return 0;

    	/* !!!FIXME!!! only litle-endian supported */
    	res = (bom == 0x0000FEFF);
    	break;

	case FB_FILE_ENCOD_UTF32:

        if( fread( &bom, sizeof( UTF_32 ), 1, fp ) != 1 )
        	return 0;

    	/* !!!FIXME!!! only litle-endian supported */
    	res = (bom == 0x0000FEFF);
		break;

    default:
    	res = 0;
    }

    if( handle->mode == FB_FILE_MODE_APPEND )
    	fseek( fp, 0, SEEK_END );

	return res;
}

static int hWriteBOM( FB_FILE *handle )
{
    int bom;
    FILE *fp = (FILE *)handle->opaque;

    switch( handle->encod )
    {
    case FB_FILE_ENCOD_UTF8:
        bom = 0x00BFBBEF;
        if( fwrite( &bom, 3, 1, fp ) != 1 )
        	return 0;
    	break;

	case FB_FILE_ENCOD_UTF16:
        /* !!!FIXME!!! only litle-endian supported */
        bom = 0x0000FEFF;
        if( fwrite( &bom, sizeof( UTF_16 ), 1, fp ) != 1 )
        	return 0;
    	break;

	case FB_FILE_ENCOD_UTF32:
        /* !!!FIXME!!! only litle-endian supported */
        bom = 0x0000FEFF;
        if( fwrite( &bom, sizeof( UTF_32 ), 1, fp ) != 1 )
        	return 0;
		break;

    default:
    	return 0;
    }

	return 1;
}

int fb_DevFileOpenEncod
	(
		FB_FILE *handle,
		const char *filename,
		size_t fname_len
	)
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
        openmask = "rb";
        break;

    case FB_FILE_MODE_OUTPUT:
        /* will create the file if it doesn't exist */
        openmask = "wb";
        break;

    default:
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* try opening */
    if( (fp = fopen( fname, openmask )) == NULL )
    {
    	FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    }

    fb_hSetFileBufSize( fp );

    handle->opaque = fp;

    if ( handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    /* handle BOM */
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
    case FB_FILE_MODE_INPUT:
        if( !hCheckBOM( handle ) )
        {
    		fclose( fp );
    		FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        break;

    case FB_FILE_MODE_OUTPUT:
        if( !hWriteBOM( handle ) )
        {
    		fclose( fp );
    		FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
	}

	/* calc file size */
    handle->size = fb_DevFileGetSize( fp, handle->mode, handle->encod, TRUE );
    if( handle->size == -1 )
    {
    	fclose( fp );
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
