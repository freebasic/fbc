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
 * array_tmpdesc.c -- temp descriptor core, for array fields passed by descriptor
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdarg.h>
#include "fb.h"


/**********
 * temp array descriptors
 **********/

static FB_ARRAY_TMPDESCLIST tmpdsList = { 0 };

static FB_ARRAY_TMPDESC fb_tmpdsTB[FB_ARRAY_TMPDESCRIPTORS] = { 0 };

/*:::::*/
static void fb_hArrayInitTmpDesc( void )
{
    int 			i;
    FB_ARRAY_TMPDESC  *next;

	tmpdsList.head 	= NULL;
	tmpdsList.tail 	= NULL;
	tmpdsList.fhead = &fb_tmpdsTB[0];
	tmpdsList.cnt	= 0;

	for( i = 0; i < FB_ARRAY_TMPDESCRIPTORS; i++ )
	{
    	if( i < FB_ARRAY_TMPDESCRIPTORS-1 )
    		next = &fb_tmpdsTB[i+1];
    	else
    		next = NULL;

    	fb_tmpdsTB[i].prev 	= NULL;
    	fb_tmpdsTB[i].next 	= next;
	}
}

/*:::::*/
FBARRAY *fb_hArrayAllocTmpDesc( void )
{
	FB_ARRAY_TMPDESC *dsc;

	if( (tmpdsList.fhead == NULL) && (tmpdsList.head == NULL) )
		fb_hArrayInitTmpDesc( );

	/* take from free list */
	dsc = tmpdsList.fhead;
	if( dsc == NULL )
		return NULL;

	tmpdsList.fhead = dsc->next;

	/* add to entry used list */
	if( tmpdsList.tail != NULL )
		tmpdsList.tail->next = dsc;
	else
		tmpdsList.head = dsc;

	dsc->prev = tmpdsList.tail;
	dsc->next = NULL;

	tmpdsList.tail = dsc;

	++tmpdsList.cnt;

	/*  */

	return (FBARRAY *)&dsc->array;
}

/*:::::*/
void fb_hArrayFreeTmpDesc( FBARRAY *src )
{
	FB_ARRAY_TMPDESC *dsc;

	dsc = (FB_ARRAY_TMPDESC *)(((char *)src) - (sizeof( void * ) * 2));

    /* del from used list */
	if( dsc->prev != NULL )
		dsc->prev->next = dsc->next;
	else
		tmpdsList.head = dsc->next;

	if( dsc->next != NULL )
		dsc->next->prev = dsc->prev;
	else
		tmpdsList.tail = dsc->prev;

	/* add to free list */
	dsc->prev = NULL;
	dsc->next = tmpdsList.fhead;
	tmpdsList.fhead = dsc;

	--tmpdsList.cnt;
}

/*:::::*/
FBARRAY *fb_ArrayAllocTempDesc( FBARRAY **pdesc, void *arraydata, int element_len, int dimensions, ... )
{
    va_list 	ap;
    int			i;
    int			elements, diff;
    FBARRAY		*array;
    FBARRAYDIM	*p;
    int			lbTB[FB_MAXDIMENSIONS];
    int			ubTB[FB_MAXDIMENSIONS];

    array = fb_hArrayAllocTmpDesc( );

    if( array != NULL )
    {
    	if( dimensions == 0) {

    		/* special case for GET temp arrays */
    		array->size = 0;
    		*pdesc = array;

       		return array;
    	}
    	
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

    	elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    	diff 	 = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;

    	array->element_len = element_len;
    	array->dimensions  = dimensions;

    	array->ptr 	= arraydata;
    	array->data = array->ptr + diff;
    	array->size	= elements * element_len;
    	
    }

    *pdesc = array;

    return array;
}

/*:::::*/
FBCALL void fb_ArrayFreeTempDesc( FBARRAY *pdesc )
{

	fb_hArrayFreeTmpDesc( pdesc );

}








