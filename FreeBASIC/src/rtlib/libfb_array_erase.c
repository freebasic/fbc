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
 * array_erase.c -- erase function for dynamic arrays
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_ArrayErase( FBARRAY *array, int isvarlen )
{
	FB_LOCK();

    if( array->ptr != NULL )
    {
    	if( isvarlen != 0 )
    		fb_hArrayFreeVarLenStrs( array, 0 );

    	free( array->ptr );
    	array->ptr  = NULL;
    	array->data = NULL;

		FB_UNLOCK();

    	return fb_ErrorSetNum( FB_RTERROR_OK );
    }

	FB_UNLOCK();

    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}


