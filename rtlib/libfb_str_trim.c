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
 * str_trim.c -- ltrim$, rtrim$ and trim$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LTRIM ( FBSTRING *src )
{
	FBSTRING 	*dst;
	int 		len;
	char		*p;

	if( (src == NULL) || (src->data == NULL) )
		return &fb_strNullDesc;

	p = fb_hStrSkipChar( src->data, FB_STRSIZE( src ), 32 );

	len = FB_STRSIZE( src ) - (int)(p - src->data);
	if( len > 0 )
	{
		/* alloc temp string */
		dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
		if( dst != NULL )
		{
			fb_hStrAllocTemp( dst, len );

			/* simple copy */
			fb_hStrCopy( dst->data, p, len );
		}
		else
			dst = &fb_strNullDesc;
    }
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_RTRIM ( FBSTRING *src )
{
	FBSTRING 	*dst;
	int 		len;
	char		*p;

	if( (src == NULL) || (src->data == NULL) )
		return &fb_strNullDesc;

	p = fb_hStrSkipCharRev( src->data, FB_STRSIZE( src ), 32 );

	len = (int)(p - src->data) + 1;
	if( len > 0 )
	{
		/* alloc temp string */
		dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
		if( dst != NULL )
		{
			fb_hStrAllocTemp( dst, len );

			/* simple copy */
			fb_hStrCopy( dst->data, src->data, len );
		}
		else
			dst = &fb_strNullDesc;
    }
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_TRIM ( FBSTRING *src )
{
	FBSTRING 	*dst;
	int 		len;
	char		*p;

	if( (src == NULL) || (src->data == NULL) )
		return &fb_strNullDesc;

	p = fb_hStrSkipCharRev( src->data, FB_STRSIZE( src ), 32 );

	len = (int)(p - src->data);
	if( len > 0 )
	{
		p = fb_hStrSkipChar( src->data, FB_STRSIZE( src ), 32 );
		len -= (int)(p - src->data);
		if( len > 0 )
		{
			/* alloc temp string */
			dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
			if( dst != NULL )
			{
				fb_hStrAllocTemp( dst, len );

				/* simple copy */
				fb_hStrCopy( dst->data, p, len );
			}
			else
				dst = &fb_strNullDesc;
		}
		else
			dst = &fb_strNullDesc;
    }
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}




