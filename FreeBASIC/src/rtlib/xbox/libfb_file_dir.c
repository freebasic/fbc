/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * libfb_file_dir.c -- dir$ implementation
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#define MAX_PATH	1024
#ifndef FALSE
#define FALSE	0
#endif
#ifndef TRUE
#define TRUE	1
#endif

#include "fb.h"


typedef struct DIR_DATA
{
	int in_use;
	int attrib;
	DIR *dir;
	char filespec[MAX_PATH];
	char dirname[MAX_PATH];
} DIR_DATA;


static DIR_DATA dir_data = { 0 };


/*:::::*/
static void close_dir ( void )
{
	closedir( dir_data.dir );
	dir_data.in_use = FALSE;
}


/*:::::*/
static int get_attrib ( char *name, struct stat *info )
{
	int attrib = 0;

	if( ( ( info->st_uid == geteuid() ) && ( ( info->st_mode & S_IWUSR ) == 0 ) ) ||
	    ( ( info->st_gid == getegid() ) && ( ( info->st_mode & S_IWGRP ) == 0 ) ) ||
	    ( ( ( info->st_mode & S_IWOTH ) == 0 ) ) )
		attrib |= 0x1;	/* read only */
	if( name[0] == '.' )
		attrib |= 0x2;	/* hidden */
	if( S_ISCHR( info->st_mode ) || S_ISBLK( info->st_mode ) || S_ISFIFO( info->st_mode ) || S_ISSOCK( info->st_mode ) )
		attrib |= 0x4;	/* system */
	if( S_ISDIR( info->st_mode ) )
		attrib |= 0x10;	/* directory */
	else
		attrib |= 0x20;	/* archive */

	return attrib;
}


/*:::::*/
static int match_spec( char *name )
{
	char *spec = dir_data.filespec;
	char *any = NULL;

	while( ( *spec ) || ( *name ) )
	{
		switch( *spec )
		{
			case '*':
				any = spec;
				spec++;
				while( ( *name != *spec ) && ( *name ) )
					name++;
				break;

			case '?':
				spec++;
				if( *name )
					name++;
				break;

			default:
				if( *spec != *name )
				{
					if( ( any ) && ( *name ) )
						spec = any;
					else
						return FALSE;
				}
				else
				{
					spec++;
					name++;
				}
				break;
		}
	}

	return TRUE;
}

/*:::::*/
static char *find_next ( void )
{
	char *name = NULL;

	struct stat	info;
	struct dirent	*entry;
	char		buffer[MAX_PATH];

	do
	{
		entry = readdir( dir_data.dir );
		if( !entry )
		{
			close_dir( );
			name = NULL;
			break;
		}
		name = entry->d_name;
		strcpy( buffer, dir_data.dirname );
		strncat( buffer, name, MAX_PATH );
		buffer[MAX_PATH-1] = '\0';
	}
	while( ( stat( buffer, &info ) ) || ( get_attrib( name, &info ) & ~dir_data.attrib ) || ( !match_spec( name ) ) );

	return name;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib )
{
	FBSTRING	*res;
	int		len;
	char		*name, *p;
	struct stat	info;

	len = FB_STRSIZE( filespec );
	name = NULL;

	if( len > 0 )
	{
		/* findfirst */

		if( dir_data.in_use )
			close_dir( );

		if( strchr( filespec->data, '*' ) || strchr( filespec->data, '?' ) )
		{
			/* we have a pattern */

			p = strrchr( filespec->data, '/' );
			if( p )
			{
				strncpy( dir_data.filespec, p + 1, MAX_PATH );
				dir_data.filespec[MAX_PATH-1] = '\0';
				while( ( *p == '/' ) && ( p > dir_data.filespec ) )
					p--;
				len = p - filespec->data + 1;
				if( len > MAX_PATH - 1 )
					len = MAX_PATH - 1;
				memcpy( dir_data.dirname, filespec->data, len );
				dir_data.dirname[len] = '\0';
			}
			else
			{
				strncpy( dir_data.filespec, filespec->data, MAX_PATH );
				dir_data.filespec[MAX_PATH-1] = '\0';
				strcpy( dir_data.dirname, "./");
			}

			/* compatibility convertions */
			if( (!strcmp( dir_data.filespec, "*.*" )) || (!strcmp( dir_data.filespec, "*." )) )
				strcpy( dir_data.filespec, "*" );

			if( (attrib & 0x10) == 0 )
				attrib |= 0x20;
			dir_data.attrib = attrib;
			dir_data.dir = opendir( dir_data.dirname );
			if( dir_data.dir )
			{
				name = find_next( );
				if( name )
					dir_data.in_use = TRUE;
			}
		}
		else
		{
			/* no pattern, use stat on single file */

			if( !stat( filespec->data, &info ) && ( ( get_attrib( filespec->data, &info ) & ~attrib ) == 0 ) )
			{
				name = strrchr( filespec->data, '/' );
				if( !name )
					name = filespec->data;
				else
					name++;
			}
		}
	}
	else {

		/* findnext */

		if( !dir_data.in_use )
			res = &__fb_ctx.null_desc;
		else
			name = find_next( );
	}


	FB_STRLOCK();

	/* store filename if found */
	if( name )
	{
        len = strlen( name );
        res = fb_hStrAllocTemp_NoLock( NULL, len );
		if( res )
		{
			fb_hStrCopy( res->data, name, len );
		}
		else
			res = &__fb_ctx.null_desc;
	}
	else
		res = &__fb_ctx.null_desc;

	fb_hStrDelTemp_NoLock( filespec );

	FB_STRUNLOCK();

	return res;
}
