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
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include "fb.h"


/*:::::*/
static void close_dir ( void )
{
	FB_DIRCTX *ctx = (FB_DIRCTX *)FB_TLSGET(fb_dirctx);
	
	closedir( ctx->dir );
	ctx->in_use = FALSE;
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
	FB_DIRCTX *ctx = (FB_DIRCTX *)FB_TLSGET(fb_dirctx);
	char *any = NULL;
	char *spec;

	spec = ctx->filespec;
	
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
	FB_DIRCTX *ctx = (FB_DIRCTX *)FB_TLSGET(fb_dirctx);
	char *name = NULL;
	struct stat	info;
	struct dirent *entry;
	char   buffer[MAX_PATH];

	do
	{
		entry = readdir( ctx->dir );
		if( !entry )
		{
			close_dir( );
			name = NULL;
			break;
		}
		name = entry->d_name;
		strcpy( buffer, ctx->dirname );
		strncat( buffer, name, MAX_PATH );
		buffer[MAX_PATH-1] = '\0';
	}
	while( ( stat( buffer, &info ) ) || ( get_attrib( name, &info ) & ~ctx->attrib ) || ( !match_spec( name ) ) );

	return name;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib )
{
	FB_DIRCTX *ctx;
	FBSTRING *res;
	int len;
	char *name, *p;
	struct stat	info;

	FB_STRLOCK();
	
	len = FB_STRSIZE( filespec );
	name = NULL;

	ctx = (FB_DIRCTX *)FB_TLSGET(fb_dirctx);
	if (!ctx) {
		ctx = (FB_DIRCTX *)calloc(1, sizeof(FB_DIRCTX));
		FB_TLSSET(fb_dirctx, ctx);
	}

	if( len > 0 )
	{
		/* findfirst */

		if( ctx->in_use )
			close_dir( );

		if( strchr( filespec->data, '*' ) || strchr( filespec->data, '?' ) )
		{
			/* we have a pattern */

			p = strrchr( filespec->data, '/' );
			if( p )
			{
				strncpy( ctx->filespec, p + 1, MAX_PATH );
				ctx->filespec[MAX_PATH-1] = '\0';
				while( ( *p == '/' ) && ( p > ctx->filespec ) )
					p--;
				len = p - filespec->data + 1;
				if( len > MAX_PATH - 1 )
					len = MAX_PATH - 1;
				memcpy( ctx->dirname, filespec->data, len );
				ctx->dirname[len] = '\0';
			}
			else
			{
				strncpy( ctx->filespec, filespec->data, MAX_PATH );
				ctx->filespec[MAX_PATH-1] = '\0';
				strcpy( ctx->dirname, "./");
			}

			/* compatibility convertions */
			if( (!strcmp( ctx->filespec, "*.*" )) || (!strcmp( ctx->filespec, "*." )) )
				strcpy( ctx->filespec, "*" );
			
			if( (attrib & 0x10) == 0 )
				attrib |= 0x20;
			ctx->attrib = attrib;
			ctx->dir = opendir( ctx->dirname );
			if( ctx->dir )
			{
				name = find_next( );
				if( name )
					ctx->in_use = TRUE;
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

		if( ctx->in_use )
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
	
	FB_STRUNLOCK();

	return res;
}
