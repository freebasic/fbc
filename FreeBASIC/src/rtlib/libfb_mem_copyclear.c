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
 * mem_copyclear.c -- LSET for non-strings
 *
 * chng: apr/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <malloc.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_MemCopyClear( unsigned char *dst, int dstlen, unsigned char *src, int srclen )
{
	int bytes;

	if( (dst == NULL) || (src == NULL) || (dstlen <= 0) || (srclen <= 0) )
		return;

	bytes = (dstlen <= srclen? dstlen: srclen);
	
	/* move */
	memcpy( dst, src, bytes );

	/* clear remainder */
	dstlen -= bytes;
	if( dstlen > 0 )
		memset( &dst[bytes], 0, dstlen );

}




