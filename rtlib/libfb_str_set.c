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
 * str_set.c -- lset and rset functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_StrLset ( FBSTRING *dst, FBSTRING *src )
{
    int slen, dlen, len;

	slen = FB_STRSIZE( src );
	dlen = FB_STRSIZE( dst );

	if( dlen > 0 )
	{
		len = (dlen <= slen? dlen: slen );

		fb_hStrCopy( dst->data, src->data, len );

		len = dlen - slen;
		if( len > 0 )
		{
			memset( &dst->data[slen], 32, len );

			/* null char */
			dst->data[slen+len] = '\0';
		}
	}

	/* del if temp */
	fb_hStrDelTemp( src );
}

/*:::::*/
FBCALL void fb_StrRset ( FBSTRING *dst, FBSTRING *src )
{
    int slen, dlen, len, padlen;

	slen = FB_STRSIZE( src );
	dlen = FB_STRSIZE( dst );

	if( dlen > 0 )
	{
		padlen = dlen - slen;
		if( padlen > 0 )
			memset( dst->data, 32, padlen );
		else
			padlen = 0;

		len = (dlen <= slen? dlen: slen );

		fb_hStrCopy( &dst->data[padlen], src->data, len );
	}

	/* del if temp */
	fb_hStrDelTemp( src );
}

