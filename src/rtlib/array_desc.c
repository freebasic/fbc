/* return descriptor values for arrays */

#include "fb.h"

FBCALL void *fb_ArrayDesc( FBARRAY *array, int mode ) 
/***********************************************************************************************
 return values of the array´s descriptor
***********************************************************************************************/
{
	if ( mode == array_data)                          
	{
		return (void *)array->ptr; 
	}
	else if ( mode == array_dimensions)               
	{
		return (void *)array->dimensions; 
	}
	else if ( mode == array_totalsize)                
	{
		return (void *)array->size; 
	}
	else if ( mode == array_totalcount)               
	{
		return (void *)(array->size / array->element_len); 
	}
	else if ( mode == array_size)                     
	{
		return (void *)array->element_len; 
	}
	else if ( mode == array_desc)                     
	{
		return (void *)array;                             
	}
	else if ( mode == array_is_fixed_len)                    
	{
		return (void *) (array->flags & FBARRAY_FLAGS_FIXED_LEN);
	}
	else if ( mode == array_is_fixed_dim)                    
	{
		return (void *) (array->flags & FBARRAY_FLAGS_FIXED_DIM);
	}
	else if ( mode == array_is_dynamic)                   
	{
		if ((array->flags & (FBARRAY_FLAGS_FIXED_LEN | FBARRAY_FLAGS_FIXED_DIM)) == 0)
        {
			return (void *) 1;
        }
        else
        {
			return (void *) 0;
        }      
	}
	else if ( mode == array_is_attached)                 
	{
		return (void *) (array->flags & FBARRAY_FLAGS_ATTACHED);
	}
	else
	{
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		return 0;
	}
}
