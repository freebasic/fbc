/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * array_redim.c -- redim function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <stdarg.h>
#include "fb.h"

/*:::::*/
int fb_hArrayAlloc
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		FB_DEFCTOR ctor,
		int dimensions, 
		va_list ap 
	)
{
    int	i, elements, diff, size;
    FBARRAYDIM *dim;
    int	lbTB[FB_MAXDIMENSIONS];
    int	ubTB[FB_MAXDIMENSIONS];

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
        ubTB[i] = va_arg( ap, int );

        if( lbTB[i] > ubTB[i] )
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    	++dim;
    }

    /* calc size */
    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size = elements * element_len;

    /* alloc new */
    if( doclear )
    	array->ptr = calloc( size, 1 );
    else
    	array->ptr = malloc( size );
    
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

    /* set descriptor */
    FB_ARRAY_SETDESC( array, element_len, dimensions, size, diff );

   	/* call ctor for each element */
   	if( ctor != NULL )
   	{
		const char *this_ = (const char *)array->ptr;
		while( elements > 0 )
		{
			/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
			ctor( this_ );
			
			this_ += element_len;
			--elements;
		}
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int hRedim
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		va_list ap 
	)
{

    /* free old */
    if( array->ptr != NULL )
    {
    	if( isvarlen != 0 )
    		fb_hArrayDtorStr( array, NULL, 0 );
    	
    	free( array->ptr );
    	array->ptr = NULL;
    	array->data = NULL;
    }
    
    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

/*:::::*/
int fb_ArrayRedimEx
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		... 
	)
{
	va_list ap;
	int res;
	
	va_start( ap, dimensions );
    res = hRedim( array, element_len, doclear, isvarlen, dimensions, ap );
    va_end( ap );
    
    return res;
}

/*:::::*/
int fb_ArrayRedim
	( 
		FBARRAY *array, 
		int element_len, 
		int isvarlen, 
		int dimensions, 
		... 
	)
{
	va_list ap;
	int res;
	
	va_start( ap, dimensions );
	res = hRedim( array, element_len, TRUE, isvarlen, dimensions, ap );
	va_end( ap );
	
	return res;
}

