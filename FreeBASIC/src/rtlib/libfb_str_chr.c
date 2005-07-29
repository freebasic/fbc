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
 * str_chr.c -- chr$ routine
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <stdarg.h>
#include "fb.h"

/*:::::*/
FBSTRING *fb_CHR ( int args, ... )
{
	FBSTRING 	*dst;
	va_list 	ap;
	unsigned int num;
	int i;

	if( args <= 0 )
		return &fb_strNullDesc;

	va_start( ap, args );

	FB_STRLOCK();

	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, args );

		/* convert */
		for( i = 0; i < args; i++ )
		{
			num = va_arg( ap, unsigned int );
			dst->data[i] = (unsigned char)num;
		}

		dst->data[args] = '\0';
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	va_end( ap );

	return dst;
}

