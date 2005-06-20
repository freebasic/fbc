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
 * libfb_file_dir.c -- dos dir$ implementation
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include <dir.h>
#include "fb.h"


typedef struct DIR_DATA
{
	int in_use;
	int attrib;
	struct ffblk f;
} DIR_DATA;


static DIR_DATA dir_data = { 0 };


/*:::::*/
static void close_dir ( void )
{
	dir_data.in_use = FALSE;
}


/*:::::*/
static char *find_next ( void )
{

	if (findnext(&dir_data.f) == 0)
		return dir_data.f.ff_name;
		
	close_dir();
	
	return NULL;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib )
{
	FBSTRING	*res;
	int		len;
	char		*name;

	len = FB_STRSIZE( filespec );
	name = NULL;

	if( len > 0 )
	{
		/* findfirst */

		if( dir_data.in_use )
			close_dir( );
		
		if (findfirst(filespec->data, &dir_data.f, attrib) == 0) {
			name = dir_data.f.ff_name;
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
