/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * dev_efile_open - UTF-encoded file devices open
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

int fb_DevFileWriteEncod( struct _FB_FILE *handle, const void* buffer, size_t chars );
int fb_DevFileWriteEncodWstr( struct _FB_FILE *handle, const FB_WCHAR* buffer, size_t len );
int fb_DevFileReadEncod( struct _FB_FILE *handle, void *dst, size_t *max_chars );
int fb_DevFileReadEncodWstr( struct _FB_FILE *handle, FB_WCHAR *dst, size_t *max_chars );
int fb_DevFileReadLineEncod( struct _FB_FILE *handle, FBSTRING *dst );
int fb_DevFileReadLineEncodWstr( struct _FB_FILE *handle, FB_WCHAR *dst, int max_chars );

static FB_FILE_HOOKS fb_hooks_dev_file = {
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

/*:::::*/
static int hCheckBOM( struct _FB_FILE *handle )
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

/*:::::*/
static int hWriteBOM( struct _FB_FILE *handle )
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

/*:::::*/
int fb_DevFileOpenEncod( struct _FB_FILE *handle, const char *filename, size_t fname_len )
{
    FILE *fp = NULL;
    char *openmask;
    char *fname;

    FB_LOCK();

    fname = (char*) alloca(fname_len + 1);
    memcpy(fname, filename, fname_len);
    fname[fname_len] = 0;

    /* Convert directory separators to whatever the current platform supports */
    fb_hConvertPath( fname, fname_len );

    handle->hooks = &fb_hooks_dev_file;

    openmask = NULL;
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        openmask = "ab";				/* will create the file if it doesn't exist */
        break;

    case FB_FILE_MODE_INPUT:
        openmask = "rb";				/* will fail if file doesn't exist */
        break;

    case FB_FILE_MODE_OUTPUT:
        openmask = "wb";       			/* will create the file if it doesn't exist */
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

    /* change the default buffer size */
    setvbuf( fp, NULL, _IOFBF, FB_FILE_BUFSIZE );

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

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
