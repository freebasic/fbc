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
 * sys_exec.c -- run and chain
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>

#ifdef WIN32
#include <process.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

#include "fb.h"

/*:::::*/
static char *fn_hGetShortPath( char *src, char *dst, int maxlen )
{

	if( strchr( src, 32 ) == NULL )
	{
		strcpy( dst, src );
	}
	else
	{
#ifdef WIN32
 	GetShortPathName( src, dst, maxlen );
#else
	!!!WRITEME!!!
#endif
    }

	return dst;
}

/*:::::*/
FBCALL int fb_Run ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    char 	arg0[] = "";
    int		res;

#ifdef WIN32
	res = _execl( fn_hGetShortPath( program->data, buffer, MAX_PATH ), arg0, NULL );
#else
	!!!WRITEME!!!
#endif

	/* del if temp */
	fb_hStrDelTemp( program );

	return res;
}

/*:::::*/
FBCALL int fb_Chain ( FBSTRING *program )
{
    char	buffer[MAX_PATH+1];
    char 	arg0[] = "";
    int		res;

#ifdef WIN32
	res = _spawnl( _P_WAIT, fn_hGetShortPath( program->data, buffer, MAX_PATH ), arg0, NULL );
#else
	!!!WRITEME!!!
#endif

	/* del if temp */
	fb_hStrDelTemp( program );

	return res;
}

/*:::::*/
FBCALL int fb_Exec ( FBSTRING *program, FBSTRING *args )
{
    char	buffer[MAX_PATH+1];
    char	*argv[3];
    int		res;

	argv[0] = &buffer[0];
	argv[1] = args->data;
	argv[2] = NULL;

#ifdef WIN32
	res = _spawnv( _P_WAIT, fn_hGetShortPath( program->data, buffer, MAX_PATH ), argv );
#else
	!!!WRITEME!!!
#endif

	/* del if temp */
	fb_hStrDelTemp( args );
	fb_hStrDelTemp( program );

	return res;
}

