/* array calculations */

#include "fb.h"

FBCALL int fb_ArrayCalcIdxPos ( FBARRAY *array, size_t li, array_index *ai )
/***********************************************************************************************
 return indices from linear (one based) position (li), do some basic bounds checking
***********************************************************************************************/
{
size_t count;
size_t i;
size_t x;
size_t y = 0;
ssize_t *p;

	p = &ai->i1;

	count = (array->size / array->element_len);
	ai->li = li;

	if (array->size == 0)                             
	{
		fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		return 0;
	}
	else if (li < 1)                                  
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else if (li > (array->size / array->element_len)) 
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else
	{
		li -= 1;                                      
		ai->n = array->dimensions;

		for(x = array->dimensions; x > 0; x--)        
		{
			count = count /array->dimTB[y].elements;  
			i = li / count;                           
			li -= i * count;                          
			p[y] = i + array->dimTB[y].lbound;        
			y += 1;                                   
		}  

		fb_ErrorSetNum( FB_RTERROR_OK );
		return 1;
	}
}


FBCALL int fb_ArrayCalcIdxPtr ( FBARRAY *array, void *pm, array_index *ai )
/***********************************************************************************************
 return indices from memory ptr (pm), do some basic bounds checking
***********************************************************************************************/
{
size_t li = 1 + (pm - array->ptr)/array->element_len;
size_t count;
size_t i;
size_t x;
size_t y = 0;
ssize_t *p;

	p = &ai->i1;
	count = (array->size / array->element_len);
	ai->li = li;

	if (li < 1)                                       
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else if (li > (array->size / array->element_len)) 
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else
	{
		li -= 1;                                      
		ai->n = array->dimensions;

		for(x = array->dimensions; x > 0; x--)        
		{
			count = count /array->dimTB[y].elements;  
			i = li / count;                           
			li -= i * count;                          
			p[y] = i + array->dimTB[y].lbound;        
			y += 1;                                   
		}  

		fb_ErrorSetNum( FB_RTERROR_OK );
		return 1;
	}
}


FBCALL size_t fb_ArrayCalcPos( FBARRAY *array, void *p ) 
/***********************************************************************************************
 return linear index of element pointed to by p, do some basic bounds checking
***********************************************************************************************/
{
size_t li = 1 + (p - array->ptr)/array->element_len;

	if (li < 1)                                       
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else if (li > (array->size / array->element_len)) 
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else
	{
		fb_ErrorSetNum( FB_RTERROR_OK );
		return li;
	}
}
