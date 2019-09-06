/* shift array elements up or down one element */

#include "fb.h"

FBCALL void *fb_ArrayShift( FBARRAY *array, void *p, size_t li, size_t c, int flag ) 
/***********************************************************************************************
 shift up (flag = 1) or down (flag = 0) c (count) array elements, start at p or li
***********************************************************************************************/
{
void *cc;

	if ((li == 0) && (p == 0))                        //if neither a linear index nor a memory pointer is given
	{
		p = array->ptr;                               
		li = 1;
	}
	else if (li == 0)                                 //no linear index -> there is a valid memory poiter
	{
		li = 1 + (p - array->ptr)/array->element_len; 
	}    
	else if (p == 0)                                  //no memory pointer -> there is a valid linear index
	{
		p = array->ptr + (li - 1) * array->element_len;                   
	}    

	if (c == 0)                                       //count of elements to shift, 0 = move all from here to the end
	{
		c = array->size/array->element_len - (li - 1);                    
	}


	if (li < 1)                                       //error checking
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else if (li > (array->size / array->element_len)) 
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}


	if (li - 1 + c > array->size/array->element_len)  //prevent overflow, if count is too big 
	{
		c = array->size/array->element_len - (li -1);
	}

    /* shifting doesn´t create or delete elements, so there are no memory leaks or
       uninitialzed elements for arrays of data types, which have/need a constructor
       or destructor. In fact it´s more like rotating one element and shifting all
       others. It´s up to the caller, to properly overwrite (array(insert, ...) or 
       delete (array(delete, ...) the rotated element */
       
	if (flag == 0)                                    //delete: shift down, put element at p to the end
	{
		cc = malloc(array->element_len);
		memcpy(cc, p, array->element_len);
		memcpy(p, p + array->element_len, (c - 1) * array->element_len);
		memcpy(p + array->element_len * (c - 1), cc, array->element_len);
		free(cc);
		p = p + (c - 1) * array->element_len;
		
	}
	else                                              //insert: shift up, put last element to p
	{
		cc = malloc(array->element_len);
		memcpy(cc, p + array->element_len * (c - 1), array->element_len);
		memmove(p + array->element_len, p, (c - 1) * array->element_len);
		memcpy(p, cc, array->element_len);
		free(cc);
	}

	fb_ErrorSetNum( FB_RTERROR_OK );
	return p;
}
