/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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
static char *find_next ( int *attrib )
{

	if (findnext(&dir_data.f) == 0)
	{
		*attrib = dir_data.f.ff_attrib;
		return dir_data.f.ff_name;
	}
		
	close_dir();
	
	return NULL;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib, int *out_attrib )
{
	FBSTRING *res;
	int	len, tmp_attrib;
	char *name;

	if( out_attrib == NULL ) 
		out_attrib = &tmp_attrib;

	len = FB_STRSIZE( filespec );
	name = NULL;

	if( len > 0 )
	{
		/* findfirst */

		if( dir_data.in_use )
			close_dir( );
		
		if (findfirst(filespec->data, &dir_data.f, attrib) == 0) {
			name = dir_data.f.ff_name;
			*out_attrib = dir_data.f.ff_attrib;
			dir_data.in_use = TRUE;
		}
	}
	else {

		/* findnext */
		if( dir_data.in_use )
			name = find_next( out_attrib );
	}

	/* store filename if found */
	if( name )
	{
        len = strlen( name );
		res = fb_hStrAllocTemp( NULL, len );
		if( res )
		{
			fb_hStrCopy( res->data, name, len );

		}
		else
			res = &fb_strNullDesc;
	}
	else
	{
		res = &fb_strNullDesc;
		*out_attrib = 0;
	}

	fb_hStrDelTemp( filespec );

	return res;
}

/*:::::*/
FBCALL FBSTRING *fb_DirNext ( int *attrib )
{
	static FBSTRING fname = { 0 };
	return fb_Dir( &fname, 0, attrib );
}
