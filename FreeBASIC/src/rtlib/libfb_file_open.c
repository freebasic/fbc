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
 * file_open - open and core file functions
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

	type = FB_FILE_TYPE_NORMAL;
	/* check for special file names */
    if( strchr( fname, ':' ) != NULL )
    {
	    if( strcasecmp( fname, "CONS:" ) == 0 || 
	        strcasecmp( fname, "CON:" ) == 0 )
	    {
			type = FB_FILE_TYPE_CONSOLE;
	    } 
	    else if( strcasecmp( fname, "ERR:" ) == 0 ) 
	    {
			type = FB_FILE_TYPE_ERR;
	    } 
	    else if( strncasecmp( fname, "PIPE:", 5 ) == 0 ) 
	    {
	        type = FB_FILE_TYPE_PIPE;
	    }
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
	handle->access   = accesstype;
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

