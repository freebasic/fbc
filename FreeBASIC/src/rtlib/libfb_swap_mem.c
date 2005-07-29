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
 * swap_mem.c -- swap f/ non-strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_MemSwap( unsigned char *dst, unsigned char *src, int bytes )
{
	int i;
	unsigned int ti;
	unsigned char tb;

	if( (dst == NULL) || (src == NULL) || (bytes <= 0) )
		return;

	FB_LOCK();
	
	/* words */
	for( i = 0; i < (bytes >> 2); i++ )
	{
		ti = *(unsigned int *)src;
		*(unsigned int *)src = *(unsigned int *)dst;
		*(unsigned int *)dst = ti;

		src += sizeof(unsigned int);
		dst += sizeof(unsigned int);
	}

	/* remainder */
	for( i = 0; i < (bytes & 3); i++ )
	{
		tb = *src;
		*src++ = *dst;
		*dst++ = tb;
	}
	
	FB_UNLOCK();
}




