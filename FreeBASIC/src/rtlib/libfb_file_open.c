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
#include "fb.h"
#include "fb_rterr.h"

static void fb_hFileCtx ( int doinit );

#ifdef MULTITHREADED
static int is_exiting = FALSE;
#endif


/*:::::*/
static void fb_hFileExit( void )
{

#ifdef MULTITHREADED
	is_exiting = TRUE;
#endif

	fb_hFileCtx( 0 );

}

/*:::::*/
static void fb_hFileCtx ( int doinit )
{
	static inited = 0;
	int i;

	//
	if( doinit )
	{
		if( inited )
			return;

		for( i = 0; i < FB_MAX_FILES; i++ )
			fb_fileTB[i].f = NULL;


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
	
	for( i = 0; i < FB_MAX_FILES; i++ )
		if( fb_fileTB[i].f != NULL )
		{
			if( fb_fileTB[i].type == FB_FILE_TYPE_NORMAL )
				fclose( fb_fileTB[i].f );
			fb_fileTB[i].f = NULL;
		}

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
	
	for( i = 0; i < FB_MAX_FILES; i++ )
		if( fb_fileTB[i].f == NULL ) {
			FB_UNLOCK();
			return i + 1;
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
FBCALL unsigned int fb_FileSize( int fnum )
{
	unsigned int res;
	
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return 0;

	FB_LOCK();

	if( fb_fileTB[fnum-1].f == NULL ) {
		FB_UNLOCK();
		return 0;
	}

	res = fb_hFileSize( fb_fileTB[fnum-1].f );

	FB_UNLOCK();

	return res;
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
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
	char openmask[16];
	FILE* f;
	int str_len;
	char *filename;
	int type, accesstype;

	/* init fb table if needed */
	fb_hFileCtx( 1 );

	/* check if valid */
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

	if( fb_fileTB[fnum-1].f != NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	str_len = FB_STRSIZE( str );

	if( (str->data == NULL) || (str_len == 0) )
	{
		/* del if temp */
		fb_hStrDelTemp( str );
		
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* check for special file names */
	type = FB_FILE_TYPE_NORMAL;
	if( strcasecmp( str->data, "CONS:" ) == 0 )
		type = FB_FILE_TYPE_CONSOLE;
	else if( strcasecmp( str->data, "ERR:" ) == 0 )
		type = FB_FILE_TYPE_ERR;

	accesstype = (access != FB_FILE_ACCESS_ANY? access: FB_FILE_ACCESS_READWRITE);

	if( type == FB_FILE_TYPE_NORMAL )
	{
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
		filename = fb_hConvertPath( str->data, str_len );

		if( (mode == FB_FILE_MODE_BINARY) || (mode == FB_FILE_MODE_RANDOM) )
		{
			/* try opening */
			if( (f = fopen( filename, openmask )) == NULL )
			{
				/* if file was not found and in READ/WRITE mode, create it */
				if( accesstype == FB_FILE_ACCESS_READWRITE )
				{
					f = fopen( filename,  "w+b" );

					/* if file could not be created and in ANY mode, try opening as read-only */
					if( (f == NULL) && (access == FB_FILE_ACCESS_ANY) )
            			f = fopen( filename,  "rb" );
            	}

            	if( f == NULL )
            	{
            		free( filename );
            		FB_UNLOCK();
            		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
            	}
			}
		}
		else
		{
			/* try opening */
			if( (f = fopen( filename, openmask )) == NULL )
			{
				free( filename );
				FB_UNLOCK();
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}
		}

		free( filename );

		/* change the default buffer size */
		setvbuf( f, NULL, _IOFBF, FB_FILE_BUFSIZE );

	}
	else
	{
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
	}


	/* fill struct */
	fb_fileTB[fnum-1].f    	 = f;
	fb_fileTB[fnum-1].mode 	 = mode;
	fb_fileTB[fnum-1].type 	 = type;
	fb_fileTB[fnum-1].access = accesstype;

	/* reclen */
	switch( mode )
	{
	case FB_FILE_MODE_RANDOM:
	case FB_FILE_MODE_INPUT:
	case FB_FILE_MODE_OUTPUT:
		if( len <= 0 )
			len = 128;
		fb_fileTB[fnum-1].len = len;
		break;

	default:
		fb_fileTB[fnum-1].len = 0;
	}

    /* size */
	if( type == FB_FILE_TYPE_NORMAL )
	{
		switch( mode )
		{
		case FB_FILE_MODE_BINARY:
		case FB_FILE_MODE_RANDOM:
		case FB_FILE_MODE_INPUT:
			fb_fileTB[fnum-1].size = fb_hFileSize( f );
			break;

		default:
			fb_fileTB[fnum-1].size = 0;
		}
	}
	else
		fb_fileTB[fnum-1].size = 0;


	/* del if temp */
	fb_hStrDelTemp( str );

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileClose( int fnum )
{
	/* QB quirk: CLOSE w/o arguments closes all files */
	if( fnum == 0 )
	{
		fb_FileReset( );
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}


	if( fnum < 1 || fnum > FB_MAX_FILES )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

	if( fb_fileTB[fnum-1].type == FB_FILE_TYPE_NORMAL )
		if( fb_fileTB[fnum-1].f != NULL )
			fclose( fb_fileTB[fnum-1].f );

	fb_fileTB[fnum-1].f = NULL;
	
	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

