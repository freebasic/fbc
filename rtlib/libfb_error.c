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
 *	error - runtime error handling
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"


void 	*fb_errhandler	= NULL;
int		fb_errnum 		= FB_RTERROR_OK;


/*:::::*/
__stdcall void *fb_ErrorThrow ( int errnum )
{

    fb_errnum = errnum;

    if( fb_errhandler != NULL )
    	return fb_errhandler;


	printf( "\nRuntime error: %d\n", errnum );

	fb_End( errnum );
}

/*:::::*/
__stdcall void *fb_ErrorSetHandler ( void *newhandler )
{
	void *oldhandler;

    oldhandler = fb_errhandler;

    fb_errhandler = newhandler;

	return oldhandler;
}

/*:::::*/
__stdcall int fb_ErrorGetNum ( void )
{

	return fb_errnum;

}


/*:::::*/
__stdcall void fb_ErrorSetNum ( int errnum )
{

	fb_errnum = errnum;

}

