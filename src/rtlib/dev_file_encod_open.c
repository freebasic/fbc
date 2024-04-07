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

static int hCheckBOM( FILE *fp, FB_FILE_ENCOD encod )
{
	int res, bom = 0;

	switch( encod )
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

	return res;
}

static int hWriteBOM( FILE *fp, FB_FILE_ENCOD encod )
{
	int bom;

	switch( encod )
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
	int effective_mode;

	FB_LOCK();

	fname = (char*) alloca(fname_len + 1);
	memcpy(fname, filename, fname_len);
	fname[fname_len] = 0;

	/* Convert directory separators to whatever the current platform supports */
	fb_hConvertPath( fname );

	handle->hooks = &hooks_dev_file;
	effective_mode = handle->mode;

	openmask = NULL;

	switch( handle->mode )
	{
	case FB_FILE_MODE_INPUT:
	case FB_FILE_MODE_APPEND:
		/*	Even in append mode, try and open for reading first 
			because trying to read the BOM in "ab" mode will fail 
		*/
		openmask = "rb";
		break;

	case FB_FILE_MODE_OUTPUT:
		openmask = "wb";
		break;

	default:
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* try opening */
	fp = fopen( fname, openmask );

	if( handle->mode == FB_FILE_MODE_APPEND )
	{
		/*	if we weren't able to open an existing file for
			append, then try writing instead 
		*/
		if( fp == NULL )
		{
			/* not found? handle mode as if output was specified */
			effective_mode = FB_FILE_MODE_OUTPUT;
			openmask = "ab";
			fp = fopen( fname, openmask );
		}
		else
		{
			fb_hSetFileBufSize( fp );

			if( !hCheckBOM( fp, handle->encod ) )
			{
				fclose( fp );
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_FILEIO );
			}
			else
			{
				/* if we have the correct BOM, then reopen the file for append */
				openmask = "ab";
				fp = freopen( fname, openmask, fp );
			}
		}
	}

	/* not opened? */
	if( fp == NULL )
	{
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}

	fb_hSetFileBufSize( fp );

	handle->opaque = fp;

	if ( handle->access == FB_FILE_ACCESS_ANY)
		handle->access = FB_FILE_ACCESS_READWRITE;

	switch( effective_mode )
	{
	case FB_FILE_MODE_INPUT:
		/* check the BOM if reading only */
		if( !hCheckBOM( fp, handle->encod ) )
		{
			fclose( fp );
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
		}
		break;

	case FB_FILE_MODE_OUTPUT:
		/* write the BOM if file was just newly created */
		if( !hWriteBOM( fp, handle->encod ) )
		{
			fclose( fp );
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		}
		break;
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
