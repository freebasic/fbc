/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2005 Mark Junker (mjscod@gmx.de)
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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
static int fb_DevFileEof( struct _FB_FILE *handle )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return FB_TRUE;
	}

    switch( handle->mode )
    {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        if( ftell( fp ) >= handle->size ) {
            FB_UNLOCK();
            return FB_TRUE;
        } else {
            FB_UNLOCK();
            return FB_FALSE;
        }
    }

	res = (feof( fp ) == 0 ? FB_FALSE : FB_TRUE);
	FB_UNLOCK();

	return res;
}

/*:::::*/
static int fb_DevFileClose( struct _FB_FILE *handle )
{
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp != NULL ) {
        fclose( fp );
    }

	handle->opaque = NULL;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int fb_DevFileSeek( struct _FB_FILE *handle, long offset, int whence )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	res = fb_ErrorSetNum( fseek( fp, offset, whence ) == 0 ? FB_RTERROR_OK : FB_RTERROR_FILEIO );

	FB_UNLOCK();

	return res;
}

static int fb_DevFileTell( struct _FB_FILE *handle, long *pOffset )
{
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	*pOffset = ftell( fp );

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int fb_DevFileRead( struct _FB_FILE *handle, void* value, size_t *pLength )
{
    FILE *fp;
    size_t rlen, length;
    char *pachData = (char*) value;

    FB_LOCK();

    assert(pLength!=NULL);
    length = *pLength;

    fp = (FILE*) handle->opaque;
    if( fp==stdout || fp==stderr )
        fp = stdin;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* do read */
	rlen = fread( pachData, 1, length, fp );
	if( rlen != length )
    {
		/* fill with nulls if at eof */
        memset( pachData + rlen, 0, length - rlen );
    }

    *pLength = rlen;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int fb_DevFileWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    FILE *fp;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* do write */
	if( fwrite( value, 1, valuelen, fp ) != valuelen ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int fb_DevFileLock( struct _FB_FILE *handle, unsigned int position, unsigned int size )
{
    FILE *fp;
	int		res;

	if( size==0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	res = fb_hFileLock( fp, position, size );

	FB_UNLOCK();

	return res;
}

static int fb_DevFileUnlock( struct _FB_FILE *handle, unsigned int position, unsigned int size )
{
	int 	res;
	FILE 	*fp;

	if( size==0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	res = fb_hFileUnlock( fp, position, size );

	FB_UNLOCK();

	return res;
}

static int fb_DevFileReadLine( struct _FB_FILE *handle, FBSTRING *dst )
{
    FILE *fp;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    char buffer[512];
    size_t buffer_len = sizeof(buffer);
    int found;
    FBSTRING *src;

    assert( dst!=NULL );

	FB_LOCK();

    fp = (FILE*) handle->opaque;
    if( fp==stdout || fp==stderr )
        fp = stdin;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    found = FALSE;
    while (!found) {
        int tmp_buf_len;

        memset( buffer, 0, buffer_len );
        if( fgets( buffer, sizeof(buffer), fp ) == NULL ) {
            /* EOF reached ... this is not an error !!! */
            res = FB_RTERROR_FILEIO; /* but we have to notify the caller */
            break;
        }

        /* the last character always is NUL */
        buffer_len = sizeof(buffer) - 1;

        /* now let's find the end of the buffer */
        while (buffer_len--) {
            char ch = buffer[buffer_len];
            if (ch==13 || ch==10) {
                /* accept both CR and LF */
                found = TRUE;
                break;
            } else if( ch!=0 ) {
                /* a character other than CR/LF found ... i.e. buffer full */
                break;
            }
        }

        if( !found ) {
            /* remember the real length */
            tmp_buf_len = buffer_len + 1;
            buffer_len = sizeof(buffer) - 1;

            /* not found ... so simply add this to the result string */

        } else {
            /* remember the real length */
            tmp_buf_len = buffer_len + 1;

            /* filter a (possibly valid) CR/LF sequence */
            if( buffer[buffer_len]==10 && buffer_len!=0 ) {
                if( buffer[buffer_len-1]==13 ) {
                    --buffer_len;
                }
            }

            /* set the CR or LF to NUL */
            buffer[buffer_len] = 0;
        }

        /* create temporary string to ensure that NUL's are preserved ...
         * this function wants the length WITH the NUL character!!! */
        src = fb_StrAllocTempDescF( buffer, buffer_len + 1);

        /* concatenate */
        fb_StrConcatAssign ( dst, -1, src, -1, FALSE );

        /* the temporary string is already deleted by fb_StrConcatAssign */

        buffer_len = tmp_buf_len;
    }

	FB_UNLOCK();

	return res;

}

static int FindFirstOf( const char *filename, size_t filename_len, const char *pszFindChars, size_t max_len )
{
    size_t i;
    if( max_len==0 || max_len > filename_len) {
        max_len = filename_len;
    }
    for( i=0; i!=max_len; ++i ) {
        if (strchr(pszFindChars, filename[i])!=NULL) {
            return i;
        }
    }
    return -1;
}

static int fb_DevFileTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    int found_len = FindFirstOf( filename, filename_len, ":\\/", 5 );

    if (found_len==-1)
        return TRUE;

    if (filename[found_len]==':') {
        if (found_len==1)
            return TRUE;
        if (found_len!=4)
            return FALSE;
        if (strncasecmp(filename,
                        "file",
                        4)==0)
            return TRUE;
    }

    return FALSE;
}

static const FB_FILE_HOOKS fb_hooks_dev_file = {
    fb_DevFileEof,
    fb_DevFileClose,
    fb_DevFileSeek,
    fb_DevFileTell,
    fb_DevFileRead,
    fb_DevFileWrite,
    fb_DevFileLock,
    fb_DevFileUnlock,
    fb_DevFileReadLine
};

static int fb_DevFileOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FILE *fp = NULL;
    char openmask[16];
    char *fname;
    size_t str_len;

    FB_LOCK();

    if (strncasecmp(filename,
                    "file:",
                    5)==0)
    {
        str_len = filename_len - 5;
        fname = (char*) alloca(str_len);
        memcpy(fname, filename + 5, str_len);
    } else {
        str_len = filename_len;
        fname = (char*) alloca(str_len);
        memcpy(fname, filename, str_len);
    }
    fname[str_len] = 0;

    /* Convert directory separators to whatever the current platform supports */
    fb_hConvertPath( fname, str_len );

    handle->hooks = &fb_hooks_dev_file;

    openmask[0] = 0;

    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        strcpy( openmask, "at" );		/* will create the file if it doesn't exist */
        break;

    case FB_FILE_MODE_INPUT:
        strcpy( openmask, "rt" );		/* will fail if file doesn't exist */
        break;

    case FB_FILE_MODE_OUTPUT:
        strcpy( openmask, "wt" );       /* will create the file if it doesn't exist */
        break;

    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:

        switch( handle->access )
        {
        case FB_FILE_ACCESS_WRITE:
            strcpy( openmask, "wb" );
            break;
        case FB_FILE_ACCESS_READ:
            strcpy( openmask, "rb" );
            break;
        default:
            strcpy( openmask, "r+b" );  /* w+ would erase the contents */
            break;
        }
    }

    if (strlen(openmask)==0) {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    switch (handle->mode) {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            /* if file was not found and in READ/WRITE mode, create it */
            if( handle->access == FB_FILE_ACCESS_READWRITE )
            {
                fp = fopen( fname,  "w+b" );

                /* if file could not be created and in ANY mode, try opening as read-only */
                if( (fp == NULL) && (handle->access == FB_FILE_ACCESS_ANY) ) {
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
        break;

    default:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
    }

    /* change the default buffer size */
    setvbuf( fp, NULL, _IOFBF, FB_FILE_BUFSIZE );

    handle->opaque = fp;
    if (handle->access==FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

void fb_DevRegisterFILE(void)
{
    FB_VFS_PROTOCOL *protocol =
        (FB_VFS_PROTOCOL*) calloc(1, sizeof(FB_VFS_PROTOCOL));
    protocol->id = "file";
    protocol->pfnTestProtocol = fb_DevFileTestProtocol;
    protocol->pfnOpen = fb_DevFileOpen;
    fb_ProtocolRegister ( protocol );
}









/* ========================================================================
 * CONS: and ERR: handler
 * ======================================================================== */











static int fb_DevConsTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    return strcasecmp(filename, "CONS:")==0
        || strcasecmp(filename, "CON:")==0
        || strcasecmp(filename, "/DEV/CON")==0;
}

static int fb_DevErrTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    return strcasecmp(filename, "ERR:")==0;
}

/*:::::*/
static int fb_DevStdIoClose( struct _FB_FILE *handle )
{
	FB_LOCK();

	handle->opaque = NULL;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static const FB_FILE_HOOKS fb_hooks_dev_stdio = {
    fb_DevFileEof,
    fb_DevStdIoClose,
    NULL,
    NULL,
    fb_DevFileRead,
    fb_DevFileWrite,
    NULL,
    NULL,
    fb_DevFileReadLine
};

static int fb_DevConsOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );

    FB_LOCK();

    handle->hooks = &fb_hooks_dev_stdio;

    if ( handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    if( res == FB_RTERROR_OK ) {
        handle->opaque = stdout;
    }

    FB_UNLOCK();

	return res;
}

static int fb_DevErrOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );

    FB_LOCK();

    handle->hooks = &fb_hooks_dev_stdio;

    if ( handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    if( res == FB_RTERROR_OK ) {
        handle->opaque = stderr;
    }

    FB_UNLOCK();

	return res;
}

void fb_DevRegisterCONS(void)
{
    FB_VFS_PROTOCOL *protocol =
        (FB_VFS_PROTOCOL*) calloc(1, sizeof(FB_VFS_PROTOCOL));
    protocol->id = "cons";
    protocol->pfnTestProtocol = fb_DevConsTestProtocol;
    protocol->pfnOpen = fb_DevConsOpen;
    fb_ProtocolRegister ( protocol );
}

void fb_DevRegisterERR(void)
{
    FB_VFS_PROTOCOL *protocol =
        (FB_VFS_PROTOCOL*) calloc(1, sizeof(FB_VFS_PROTOCOL));
    protocol->id = "err";
    protocol->pfnTestProtocol = fb_DevErrTestProtocol;
    protocol->pfnOpen = fb_DevErrOpen;
    fb_ProtocolRegister ( protocol );
}










/* ========================================================================
 * PIPE: handler
 * ======================================================================== */











#ifndef TARGET_XBOX

#if defined(WIN32) || defined(__WIN32__)
#undef popen
#define popen(c,m) _popen(c,m)
#undef pclose
#define pclose(f) _pclose(f)
#endif

static int fb_DevPipeTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    return strncasecmp(filename, "pipe:", 5)==0;
}

/*:::::*/
static int fb_DevPipeClose( struct _FB_FILE *handle )
{
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp != NULL ) {
        pclose( fp );
    }

	handle->opaque = NULL;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static const FB_FILE_HOOKS fb_hooks_dev_pipe = {
    fb_DevFileEof,
    fb_DevPipeClose,
    NULL,
    NULL,
    fb_DevFileRead,
    fb_DevFileWrite,
    NULL,
    NULL,
    fb_DevFileReadLine
};

static int fb_DevPipeOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    FILE *fp = NULL;
    char openmask[16];
    const char *fname;
    size_t str_len;

    FB_LOCK();

    fname = filename + 5;
    str_len = filename_len - 5;

    handle->hooks = &fb_hooks_dev_pipe;

    openmask[0] = 0;

    switch( handle->mode )
    {
    case FB_FILE_MODE_INPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_READ;
        if( handle->access != FB_FILE_ACCESS_READ ) {
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
        strcpy( openmask, "r" );		/* will fail if file doesn't exist */
        break;

    case FB_FILE_MODE_OUTPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_WRITE;
        if( handle->access != FB_FILE_ACCESS_WRITE ) {
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
        strcpy( openmask, "w" );       /* will create the file if it doesn't exist */
        break;
    }

    if (res==FB_RTERROR_OK && strlen(openmask)==0) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( res == FB_RTERROR_OK ) {
        /* try to open/create pipe */
        if( (fp = popen( fname, openmask )) == NULL )
        {
            res = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
        handle->opaque = fp;
    }

    FB_UNLOCK();

	return res;
}

void fb_DevRegisterPIPE(void)
{
    FB_VFS_PROTOCOL *protocol =
        (FB_VFS_PROTOCOL*) calloc(1, sizeof(FB_VFS_PROTOCOL));
    protocol->id = "pipe";
    protocol->pfnTestProtocol = fb_DevPipeTestProtocol;
    protocol->pfnOpen = fb_DevPipeOpen;
    fb_ProtocolRegister ( protocol );
}

#else

void fb_DevRegisterPIPE(void)
{
    /* placeholder */
}

#endif
