/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * file_input - input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hGetNextToken( char *buffer, int maxlen, int isstring );

#define FB_DOUBLE_MAXLEN (16 + 1 + 1 + 1 + 3)

/*:::::*/
FBCALL int fb_InputSingle( float *dst )
{
    char buffer[FB_DOUBLE_MAXLEN+1];

	fb_hGetNextToken( buffer, FB_DOUBLE_MAXLEN, FB_FALSE );

	*dst = strtof( buffer, NULL );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_InputDouble( double *dst )
{
    char buffer[FB_DOUBLE_MAXLEN+1];

	fb_hGetNextToken( buffer, FB_DOUBLE_MAXLEN, FB_FALSE );

	*dst = strtod( buffer, NULL );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
