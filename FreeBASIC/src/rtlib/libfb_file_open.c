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


/* globals */
FB_FILE fb_fileTB[FB_MAX_FILES] = { NULL };


/*:::::*/
static void fb_hFileExit( void )
{

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

	for( i = 0; i < FB_MAX_FILES; i++ )
		if( fb_fileTB[i].f != NULL )
		{
			fclose( fb_fileTB[i].f );
			fb_fileTB[i].f = NULL;
		}
}

/*:::::*/
FBCALL int fb_FileFree ( void )
{
	int i;

	for( i = 0; i < FB_MAX_FILES; i++ )
		if( fb_fileTB[i].f == NULL )
			return i + 1;

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
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return 0;

	if( fb_fileTB[fnum-1].f == NULL )
		return 0;

	return fb_hFileSize( fb_fileTB[fnum-1].f );
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						   unsigned int lock, int fnum, int len )
{
	char openmask[16];
	FILE* f;
	int strlen;
	char *filename;

	/* init fb table if needed */
	fb_hFileCtx( 1 );

	/* check if valid */
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if( fb_fileTB[fnum-1].f != NULL )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	strlen = FB_STRSIZE( str );

	if( (str->data == NULL) || (strlen == 0) )
	{
		/* del if temp */
		fb_hStrDelTemp( str );

		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	}

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
		strcpy( openmask, "r+b" );				/* w+ would erase the contents */
		break;
	}

	/* Convert directory separators to whatever the current platform supports */
	filename = fb_hConvertPath( str->data, strlen );

	/* try opening */
	if( (f = fopen( filename, openmask )) == NULL )
	{
		/* try creating the file if it doesn't exist */
		if( mode == FB_FILE_MODE_BINARY || mode == FB_FILE_MODE_RANDOM )
		{
			if( (f = fopen( filename, "w+b" )) == NULL )
			{
				free( filename );
				return FB_RTERROR_FILENOTFOUND;
			}
		}
		else
		{
			free( filename );
			return FB_RTERROR_FILENOTFOUND;
		}
	}

	free( filename );

	/* fill struct */
	fb_fileTB[fnum-1].f    = f;
	fb_fileTB[fnum-1].mode = mode;

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

	/* del if temp */
	fb_hStrDelTemp( str );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_FileClose( int fnum )
{
	/* QB quirk: CLOSE w/o arguments closes all files */
	if( fnum == 0 )
	{
		fb_FileReset( );
		return FB_RTERROR_OK;
	}


	if( fnum < 1 || fnum > FB_MAX_FILES )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if( fb_fileTB[fnum-1].f != NULL )
		fclose( fb_fileTB[fnum-1].f );

	fb_fileTB[fnum-1].f = NULL;

	return FB_RTERROR_OK;
}

