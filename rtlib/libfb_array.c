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
 * array.c -- dynamic arrays core
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdarg.h>
#include "fb.h"

/*:::::*/
static int fb_hCalcElements( int dimensions, int *lboundTB, int *uboundTB )
{
	int i;
	int elements = 1;

    for( i = 0; i < dimensions; i++ )
    	elements *= (uboundTB[i] - lboundTB[i]) + 1;

    return elements;
}

/*:::::*/
static int fb_hCalcDiff( int dimensions, int *lboundTB, int *uboundTB )
{
	int i;
	int elements;
	int diff = 0;

    for( i = 0; i < dimensions-1; i++ )
    {
    	elements = (uboundTB[i+1] - lboundTB[i+1]) + 1;
    	diff += -lboundTB[i] * elements;
    }

	if( dimensions > 0 )
		diff += -lboundTB[dimensions-1];

	return diff;
}

/*:::::*/
static void fb_hFreeVarLenStrArray( FBARRAY *array )
{
	int			i;
	int 		elements;
	FBSTRING 	*p;
	FBARRAYDIM	*d;

	p = (FBSTRING *)array->ptr;
	if (p == NULL)
		return;

    d = &array->dimTB[0];
    elements = 1;
    for( i = 0; i < array->dimensions; i++ )
    {
    	elements *= d->elements;
    	++d;
    }

	while( elements != 0 )
	{
		--elements;
		if( p->data != NULL )
			fb_StrDelete( p );
		++p;
	}

}


/*:::::*/
void fb_ArrayRedim( FBARRAY *array, int element_len, int isvarlen, int preserve, int dimensions, ... )
{
    va_list 	ap;
    int			i;
    int			elements, diff, size;
    FBARRAYDIM	*p;
    int			lbTB[FB_MAXDIMENSIONS];
    int			ubTB[FB_MAXDIMENSIONS];

    /* free old */
    if( (preserve == FB_FALSE) && (array->ptr != NULL) )
    {
    	if( isvarlen != 0 )
    		fb_hFreeVarLenStrArray( array );
    	free( array->ptr );

    	array->ptr  = NULL;
    	array->data = NULL;
    }

    /* alloc new */
    va_start( ap, dimensions );

    p = &array->dimTB[0];

    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
    	ubTB[i] = va_arg( ap, int );

    	p->elements = (ubTB[i] - lbTB[i]) + 1;
    	p->lbound 	= lbTB[i];
    	++p;
    }

    va_end( ap );

    elements = fb_hCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff 	 = fb_hCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size	 = elements * element_len;

    if( (preserve == FB_FALSE) || (array->ptr == NULL) )
    	array->ptr = calloc( size, 1 );
    else
    {
        array->ptr = realloc( array->ptr, size );

        if( size > array->size )
        	memset( array->ptr + array->size, 0, size - array->size );
    }

    array->element_len = element_len;
    array->dimensions  = dimensions;
    array->size		   = size;

    if( array->ptr != NULL )
    	array->data = array->ptr + diff;
    else
    	array->data = NULL;
}

/*:::::*/
FBCALL void fb_ArrayErase( FBARRAY *array, int isvarlen )
{
    if( array->ptr != NULL )
    {
    	if( isvarlen != 0 )
    		fb_hFreeVarLenStrArray( array );

    	free( array->ptr );
    	array->ptr  = NULL;
    	array->data = NULL;
    }
}

/*:::::*/
FBCALL void fb_ArrayStrErase( FBARRAY *array )
{
    if( array->ptr != NULL )
    	fb_hFreeVarLenStrArray( array );
}

/*:::::*/
FBCALL int fb_ArrayLBound( FBARRAY *array, int dimension )
{
	FBARRAYDIM	*p;

	if( dimension > 0 )
		--dimension;

    p = &array->dimTB[dimension];

    return p->lbound;
}

/*:::::*/
FBCALL int fb_ArrayUBound( FBARRAY *array, int dimension )
{
	FBARRAYDIM	*p;

	if( dimension > 0 )
		--dimension;

    p = &array->dimTB[dimension];

    return p->lbound + p->elements - 1;
}


/*:::::*/
void fb_ArraySetDesc( FBARRAY *array, void *ptr, int element_len, int dimensions, ... )
{
    va_list 	ap;
    int			i;
    int			diff;
    FBARRAYDIM	*p;
    int			lbTB[FB_MAXDIMENSIONS];
    int			ubTB[FB_MAXDIMENSIONS];

    va_start( ap, dimensions );

    p = &array->dimTB[0];

    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
    	ubTB[i] = va_arg( ap, int );

    	p->elements = (ubTB[i] - lbTB[i]) + 1;
    	p->lbound 	= lbTB[i];
    	++p;
    }

    va_end( ap );

    diff = fb_hCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;

    array->element_len = element_len;
    array->dimensions  = dimensions;

    array->ptr 	= ptr;
    array->data = array->ptr + diff;
}

