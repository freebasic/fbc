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
 * str_len.c -- string length function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_StrLen( void *str, int str_size )
{
	int len;

	if( str == NULL )
		return 0;

	/* is dst var-len? */
	if( str_size == -1 )
	{
		len = FB_STRSIZE( str );

		/* delete temp? */
		fb_hStrDelTemp( (FBSTRING *)str );
	}
	else 
	{
		/* this routine will never be called for fixed-len strings, as
		   their sizes are known at compiler-time, as such, this must be
		   a zstring, so find out the real len (as in C/PB) */
		len = strlen( (char *)str );
	}

	return len;
}


