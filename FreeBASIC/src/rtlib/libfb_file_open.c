/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 *	file_open - open, close and some misc file functions
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hFileCtx ( int doinit );

#ifdef MULTITHREADED
static int is_exiting = FALSE;
#endif

/* don't use the coldnames symbols */
#ifdef WIN32
#undef popen
#define popen(c,m) _popen(c,m)
#undef pclose
#define pclose(f) _pclose(f)
#endif

/*:::::*/
static void fb_hFileExit( void )
{

#ifdef MULTITHREADED
	is_exiting = TRUE;
#endif

	fb_hFileCtx( 0 );

}

/*::::: make it accessible for all VFS functions too */
void fb_hFileCtx ( int doinit )
{
	static int inited = 0;

	//
	if( doinit )
	{
		if( inited )
			return;

		atexit( &fb_hFileExit );

		inited = 1;
	}
	//
	else
	{
		if( !inited )
			return;

		fb_FileReset( );

		inited = 0;
	}
}

/*:::::*/
FBCALL void fb_FileReset ( void )
{
	int i;

#ifdef MULTITHREADED
	if (!is_exiting)
		FB_LOCK();
#endif

    for( i = 1; i != (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) {
        FB_FILE *handle = FB_FILE_TO_HANDLE(i);
        if (handle->hooks != NULL) {
            assert(handle->hooks->pfnClose!=NULL);
            handle->hooks->pfnClose( handle );
        } else if( handle->f != NULL ) {
			if( handle->type == FB_FILE_TYPE_NORMAL )
				fclose( handle->f );
			handle->f = NULL;
		}
    }
    /* clear all file handles */
    memset(FB_FILE_TO_HANDLE(1),
           0,
           sizeof(FB_FILE) * (FB_MAX_FILES - FB_RESERVED_FILES));

#ifdef MULTITHREADED
	if (!is_exiting)
		FB_UNLOCK();
#endif
}

/*:::::*/
FBCALL int fb_FileFree ( void )
{
	int i;

	FB_LOCK();

    for( i = 1; i < (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) {
        FB_FILE *handle = FB_FILE_TO_HANDLE(i);
        if (handle->hooks==NULL && handle->f==NULL) {
			FB_UNLOCK();
			return i;
        }
    }

	FB_UNLOCK();

	return 0;
}

/*:::::*/
long fb_hFileSize( FILE *f )
{
	long cpos, size;

	cpos = ftell( f );

	fseek( f, 0, SEEK_END );
	size = ftell( f );

	fseek( f, cpos, SEEK_SET );

	return size;
}

/*:::::*/
unsigned int fb_FileSizeEx( FB_FILE *handle )
{
	long res = 0;

    if( handle==NULL )
		return res;

	FB_LOCK();

    if (handle->hooks!=NULL) {
        if (handle->hooks->pfnSeek!=NULL && handle->hooks->pfnTell!=NULL) {
            long old_pos;
            /* remember old position */
            int result = handle->hooks->pfnTell(handle, &old_pos);
            if (result==0) {
                /* move to end of file */
                result = handle->hooks->pfnSeek(handle, 0, SEEK_END);
            }
            if (result==0) {
                /* get size */
                result = handle->hooks->pfnTell(handle, &res);
                /* restore old position*/
                handle->hooks->pfnSeek(handle, old_pos, SEEK_SET);
            }
        }
    } else if( handle->f != NULL ) {
        res = fb_hFileSize( handle->f );
	}

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL unsigned int fb_FileSize( int fnum )
{
    return fb_FileSizeEx(FB_FILE_TO_HANDLE(fnum));
}

/*:::::*/
static void getaccessmask( char *dst, int type )
{

	switch( type )
	{
	case FB_FILE_ACCESS_READWRITE:
		strcpy( dst, "r+b" );				/* w+ would erase the contents */
		break;
	case FB_FILE_ACCESS_WRITE:
		strcpy( dst, "wb" );
		break;
	case FB_FILE_ACCESS_READ:
		strcpy( dst, "rb" );
		break;
	default:
		strcpy( dst, "r+b" );				/* w+ would erase the contents */
		break;
	}
}

/*:::::*/
int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
	char openmask[16];
	char fname[MAX_PATH], *pfname;
	FILE* f = NULL;
	int str_len;
	int type, accesstype;

    if( handle==NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* init fb table if needed */
	fb_hFileCtx( 1 );

	FB_STRLOCK();

	/* copy file name */
	str_len = FB_STRSIZE( str );

	fb_hStrCopy( fname, str->data, str_len );

	/* del if temp */
	fb_hStrDelTemp( str );

	FB_STRUNLOCK();

	if( str_len == 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

	if( handle->f != NULL || handle->hooks != NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* check for special file names */
	type = FB_FILE_TYPE_NORMAL;
    if( strcasecmp( fname, "CONS:" ) == 0
        || strcasecmp( fname, "CON:" ) == 0
        || strcasecmp( fname, "\\DEV\\CON" ) == 0
      )
    {
		type = FB_FILE_TYPE_CONSOLE;
    } else if( strcasecmp( fname, "ERR:" ) == 0 ) {
		type = FB_FILE_TYPE_ERR;
    } else if( strncasecmp( fname, "PIPE:", 5 ) == 0 ) {
        type = FB_FILE_TYPE_PIPE;
    }

	accesstype = (access != FB_FILE_ACCESS_ANY? access: FB_FILE_ACCESS_READWRITE);

	switch( type  )
	{
	case FB_FILE_TYPE_NORMAL:
		/* check mode */
		switch( mode )
		{
		case FB_FILE_MODE_APPEND:
			strcpy( openmask, "at" );				/* will create the file if it doesn't exist */
			break;

		case FB_FILE_MODE_INPUT:
			strcpy( openmask, "rt" );				/* will fail if file doesn't exist */
			break;

		case FB_FILE_MODE_OUTPUT:
			strcpy( openmask, "wt" );               /* will create the file if it doesn't exist */
			break;

		case FB_FILE_MODE_BINARY:
		case FB_FILE_MODE_RANDOM:
			getaccessmask( openmask, accesstype );

		}

		/* Convert directory separators to whatever the current platform supports */
		fb_hConvertPath( fname, str_len );

		if( (mode == FB_FILE_MODE_BINARY) || (mode == FB_FILE_MODE_RANDOM) )
		{
			/* try opening */
			if( (f = fopen( fname, openmask )) == NULL )
			{
				/* if file was not found and in READ/WRITE mode, create it */
				if( accesstype == FB_FILE_ACCESS_READWRITE )
				{
					f = fopen( fname,  "w+b" );

					/* if file could not be created and in ANY mode, try opening as read-only */
					if( (f == NULL) && (access == FB_FILE_ACCESS_ANY) )
            			f = fopen( fname,  "rb" );
            	}

            	if( f == NULL )
            	{
            		FB_UNLOCK();
            		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
            	}
			}
		}
		else
		{
			/* try opening */
			if( (f = fopen( fname, openmask )) == NULL )
			{
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}
		}

		/* change the default buffer size */
		setvbuf( f, NULL, _IOFBF, FB_FILE_BUFSIZE );

		break;

	case FB_FILE_TYPE_CONSOLE:
	case FB_FILE_TYPE_ERR:
		/* check mode */
		switch( mode )
		{
		case FB_FILE_MODE_INPUT:
			if( type == FB_FILE_TYPE_CONSOLE )
				f = stdin;
			else {
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
			}
			break;

		case FB_FILE_MODE_OUTPUT:
			if( type == FB_FILE_TYPE_CONSOLE )
				f = stdout;
			else
				f = stderr;
			break;

		default:
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

		break;

	case FB_FILE_TYPE_PIPE:
		pfname = &fname[5];				/* skip PIPE: */

		/* check mode */
		switch( mode )
		{

#ifndef TARGET_XBOX

		case FB_FILE_MODE_INPUT:
			if( (f = popen( pfname, "r" )) == NULL )
			{
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}
			break;

		case FB_FILE_MODE_OUTPUT:
			if( (f = popen( pfname, "w" )) == NULL )
			{
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}
			break;

#endif /* ifndef TARGET_XBOX */

		default:
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

		break;
	}

    /* clear structure */
    memset(handle, 0, sizeof(FB_FILE));

	/* fill struct */
	handle->f    	 = f;
	handle->mode 	 = mode;
	handle->type 	 = type;
	handle->access = accesstype;
	handle->line_length = 0;

	/* reclen */
	switch( mode )
	{
	case FB_FILE_MODE_RANDOM:
	case FB_FILE_MODE_INPUT:
	case FB_FILE_MODE_OUTPUT:
		if( len <= 0 )
			len = 128;
		handle->len = len;
		break;

	default:
		handle->len = 0;
	}

    /* size */
	if( type == FB_FILE_TYPE_NORMAL )
	{
		switch( mode )
		{
		case FB_FILE_MODE_BINARY:
		case FB_FILE_MODE_RANDOM:
		case FB_FILE_MODE_INPUT:
			handle->size = fb_hFileSize( f );
			break;

		default:
			handle->size = 0;
		}
	}
	else
		handle->size = 0;


	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

/*:::::*/
int fb_FileCloseEx( FB_FILE *handle )
{
	FB_LOCK();

    if (handle->hooks != NULL) {
        /* close VFS handle */
        assert(handle->hooks->pfnClose != NULL);
        int result = handle->hooks->pfnClose( handle );
        if (result != 0) {
            FB_UNLOCK();
            return result;
        }
    } else if( handle->f != NULL ) {
		switch( handle->type )
		{
		case FB_FILE_TYPE_NORMAL:
			fclose( handle->f );
			break;

		case FB_FILE_TYPE_PIPE:

#ifndef TARGET_XBOX

			pclose( handle->f );

#endif /* ifndef TARGET_XBOX */

			break;
        }
    }

    /* clear structure */
    memset(handle, 0, sizeof(FB_FILE));

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileClose( int fnum )
{
	/* QB quirk: CLOSE w/o arguments closes all files */
	if( fnum == 0 ) {
		fb_FileReset( );
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}

    if( !FB_FILE_INDEX_VALID(fnum) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return fb_FileCloseEx( FB_FILE_TO_HANDLE(fnum) );
}

/*:::::*/
FBCALL int fb_FileOpenShort( FBSTRING *str_file_mode,
                             int fnum,
                             FBSTRING *filename,
                             int len,
                             FBSTRING *str_access_mode,
                             FBSTRING *str_lock_mode)
{
    unsigned file_mode = 0;
    int access_mode = -1, lock_mode = -1;
    size_t file_mode_len, access_mode_len, lock_mode_len;

	FB_STRLOCK();

    file_mode_len = FB_STRSIZE( str_file_mode );
    access_mode_len = FB_STRSIZE( str_access_mode );
    lock_mode_len = FB_STRSIZE( str_lock_mode );

    if( file_mode_len != 1 || access_mode_len>2 || lock_mode_len>2 ) {
        FB_STRUNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( strcasecmp(str_file_mode->data, "B")==0 ) {
        file_mode = FB_FILE_MODE_BINARY;
    } else if( strcasecmp(str_file_mode->data, "I")==0 ) {
        file_mode = FB_FILE_MODE_INPUT;
    } else if( strcasecmp(str_file_mode->data, "O")==0 ) {
        file_mode = FB_FILE_MODE_OUTPUT;
    } else if( strcasecmp(str_file_mode->data, "A")==0 ) {
        file_mode = FB_FILE_MODE_APPEND;
    } else if( strcasecmp(str_file_mode->data, "R")==0 ) {
        file_mode = FB_FILE_MODE_RANDOM;
    } else {
        FB_STRUNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( access_mode_len!=0 ) {
        if ( strcasecmp(str_access_mode->data, "R")==0 ) {
            access_mode = FB_FILE_ACCESS_READ;
        } else if ( strcasecmp(str_access_mode->data, "W")==0 ) {
            access_mode = FB_FILE_ACCESS_WRITE;
        } else if ( strcasecmp(str_access_mode->data, "RW")==0 ) {
            access_mode = FB_FILE_ACCESS_READWRITE;
        } else {
            FB_STRUNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( lock_mode_len!=0 ) {
        if ( strcasecmp(str_lock_mode->data, "S")==0 ) {
            lock_mode = FB_FILE_LOCK_SHARED;
        } else if ( strcasecmp(str_lock_mode->data, "R")==0 ) {
            lock_mode = FB_FILE_LOCK_READ;
        } else if ( strcasecmp(str_lock_mode->data, "W")==0 ) {
            lock_mode = FB_FILE_LOCK_WRITE;
        } else if ( strcasecmp(str_lock_mode->data, "RW")==0 ) {
            lock_mode = FB_FILE_LOCK_READWRITE;
        } else {
            FB_STRUNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    FB_STRUNLOCK();

    if( access_mode == -1 ) {
        /* determine the default access mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            access_mode = FB_FILE_ACCESS_READ;
            break;
        case FB_FILE_MODE_OUTPUT:
        case FB_FILE_MODE_APPEND:
            access_mode = FB_FILE_ACCESS_WRITE;
            break;
        default:
            access_mode = FB_FILE_ACCESS_ANY;
            break;
        }
    }

    if( lock_mode == -1 ) {
        /* determine the default lock mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            lock_mode = FB_FILE_LOCK_SHARED;
            break;
        default:
            lock_mode = FB_FILE_LOCK_WRITE;
            break;
        }
    }

    return fb_FileOpen( filename,
                        file_mode,
                        access_mode,
                        lock_mode,
                        fnum,
                        len );
}
