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
 * libfb_file_dir.c -- dir$ implementation
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <string.h>

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <io.h>
#include "fb.h"


typedef struct DIR_DATA
{
	int in_use;
	int attrib;
	struct _finddata_t data;
	long handle;
} DIR_DATA;


static DIR_DATA dir_data = { 0 };


/*:::::*/
static void close_dir ( void )
{
	_findclose( dir_data.handle );
	dir_data.in_use = FALSE;
}


/*:::::*/
static char *find_next ( void )
{
	char *name = NULL;

	do
	{
		if( _findnext( dir_data.handle, &dir_data.data ) )
		{
			close_dir( );
			name = NULL;
			break;
		}
		name = dir_data.data.name;
	}
	while( dir_data.data.attrib & ~dir_data.attrib );

	return name;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib )
{
	FBSTRING	*res;
	int		len;
	char		*name, *p;

	len = FB_STRSIZE( filespec );
	name = NULL;

	if( len > 0 )
	{
		/* findfirst */

		if( dir_data.in_use )
			close_dir( );

		dir_data.handle = _findfirst( filespec->data, &dir_data.data );
		if( dir_data.handle >= 0 )
		{
			dir_data.attrib = attrib | 0xFFFFFF00;
			if( dir_data.data.attrib & ~dir_data.attrib )
				name = find_next( );
			else
				name = dir_data.data.name;
			if( name )
				dir_data.in_use = TRUE;
		}
	}
	else {

		/* findnext */

		if( !dir_data.in_use )
			res = &fb_strNullDesc;
		else
			name = find_next( );
	}

	/* store filename if found */
	if( name )
	{
		res = (FBSTRING *)fb_hStrAllocTmpDesc( );
		if( res )
		{
			len = strlen( name );
			fb_hStrAllocTemp( res, len );
			fb_hStrCopy( res->data, name, len );

		}
		else
			res = &fb_strNullDesc;
	}
	else
		res = &fb_strNullDesc;

	fb_hStrDelTemp( filespec );

	return res;
}
