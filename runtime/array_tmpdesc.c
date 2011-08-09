/*!!!REMOVEME!!!*/
/* temp descriptor core, for array fields passed by descriptor */

#include <stdlib.h>
#include <stdarg.h>
#include <stddef.h>
#include "fb.h"


/**********
 * temp array descriptors
 **********/

static FB_LIST tmpdsList = { 0 };

static FB_ARRAY_TMPDESC fb_tmpdsTB[FB_ARRAY_TMPDESCRIPTORS];

/*:::::*/
FBARRAY *fb_hArrayAllocTmpDesc
	( 
		void 
	)
{
	FB_ARRAY_TMPDESC *dsc;

	if( (tmpdsList.fhead == NULL) && (tmpdsList.head == NULL) )
		fb_hListInit( &tmpdsList, (void *)fb_tmpdsTB, sizeof(FB_ARRAY_TMPDESC), FB_ARRAY_TMPDESCRIPTORS );

	dsc = (FB_ARRAY_TMPDESC *)fb_hListAllocElem( &tmpdsList );
	if( dsc == NULL )
		return NULL;

	return (FBARRAY *)&dsc->array;
}

/*:::::*/
void fb_hArrayFreeTmpDesc
	( 
		FBARRAY *src 
	)
{
	FB_ARRAY_TMPDESC *dsc;

	dsc = (FB_ARRAY_TMPDESC *)((char *)src - offsetof(FB_ARRAY_TMPDESC, array));

	fb_hListFreeElem( &tmpdsList, (FB_LISTELEM *)dsc );
}

/*:::::*/
FBARRAY *fb_ArrayAllocTempDesc
	( 
		FBARRAY **pdesc, 
		void *arraydata, 
		int element_len, 
		int dimensions, 
		... 
	)
{
    va_list ap;
    int	i, elements, diff;
    FBARRAY	*array;
    FBARRAYDIM *dim;
    int	lbTB[FB_MAXDIMENSIONS];
    int	ubTB[FB_MAXDIMENSIONS];

	FB_LOCK();
    array = fb_hArrayAllocTmpDesc( );
    FB_UNLOCK();

    *pdesc = array;

    if( array == NULL )
    	return NULL;
    	
   	if( dimensions == 0) 
   	{
   		/* special case for GET temp arrays */
   		array->size = 0;
		return array;
   	}

    va_start( ap, dimensions );

	dim = &array->dimTB[0];

    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
    	ubTB[i] = va_arg( ap, int );

    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    	++dim;
    }

    va_end( ap );

    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;

    array->ptr = arraydata;

    FB_ARRAY_SETDESC( array, element_len, dimensions, elements * element_len, diff );

    return array;
}

/*:::::*/
FBCALL void fb_ArrayFreeTempDesc
	( 
		FBARRAY *pdesc 
	)
{

	FB_LOCK();
	fb_hArrayFreeTmpDesc( pdesc );
	FB_UNLOCK();

}
