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
 * array_clear.c -- erase function for static arrays
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_ArrayClear( FBARRAY *array, int isvarlen )
{
	FB_LOCK();

    if( array->ptr != NULL )
    {
    	if( isvarlen == FB_FALSE )
    		memset( array->ptr, 0, array->size );
    	else
    		fb_hArrayFreeVarLenStrs( array, 0 );

		FB_UNLOCK();
    	return fb_ErrorSetNum( FB_RTERROR_OK );
    }
    else {
    	FB_UNLOCK();
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }
}
