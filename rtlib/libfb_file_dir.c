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

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <io.h>
#else
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
#endif

#include "fb.h"


typedef struct DIR_DATA
{
	int in_use;
	int attrib;
#ifdef WIN32
	struct _finddata_t data;
	long handle;
#else
	DIR *dir;
	char filespec[MAX_PATH];
	char dirname[MAX_PATH];
#endif
} DIR_DATA;


static DIR_DATA dir_data = { 0 };


/*:::::*/
static void close_dir ( void )
{
#ifdef WIN32
	_findclose( dir_data.handle );
#else
	closedir( dir_data.dir );
#endif
	dir_data.in_use = FALSE;
}


#ifndef WIN32

/*:::::*/
static int get_attrib ( char *name, struct stat *info )
{
	int attrib = 0;
	
	if( ( ( info->st_uid == geteuid() ) && ( info->st_mode & S_IWUSR == 0 ) ) ||
	    ( ( info->st_gid == getegid() ) && ( info->st_mode & S_IWGRP == 0 ) ) ||
	    ( ( info->st_mode & S_IWOTH == 0 ) ) )
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

#endif


/*:::::*/
static char *find_next ( void )
{
	char *name = NULL;

#ifdef WIN32

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

#else

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

#endif

	return name;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib )
{
	FBSTRING	*res;
	int		len;
	char		*name, *p;
#ifndef WIN32
	struct stat	info;
#endif
	
	len = FB_STRSIZE( filespec );
	name = NULL;
	
	if( len > 0 )
	{
		/* findfirst */
		
		if( dir_data.in_use )
			close_dir( );
#ifdef WIN32
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
		
#else
		dir_data.attrib = attrib;
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
			if( !strcmp( dir_data.filespec, "*.*" ) )
				strcpy( dir_data.filespec, "*" );
			else if( !strcmp( dir_data.filespec, "*." ) ) {
				strcpy( dir_data.filespec, "*" );
				dir_data.attrib = 0x17;
			}

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
#endif
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
