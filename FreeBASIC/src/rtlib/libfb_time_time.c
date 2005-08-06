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
 * time_time.c -- time$ function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include <time.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_Time ( void )
{
	FBSTRING	*dst;
	time_t 		rawtime;
  	struct tm	*ptm;

	FB_STRLOCK();
		
	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, 2+1+2+1+2 );

        /* guard by global lock because time/localtime might not be thread-safe */
        FB_LOCK();
  		time( &rawtime );
  		ptm = localtime( &rawtime );
        sprintf( dst->data, "%02d:%02d:%02d", ptm->tm_hour, ptm->tm_min, ptm->tm_sec );
        FB_UNLOCK();
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();
		
	return dst;
}

