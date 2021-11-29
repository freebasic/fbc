/* ERASE for static arrays of objects: re-init the elements

   fb_ArrayClearObj() is called only if it was known at
   compile time that the array is fixed length.
   Otherwise, if dynamic / static was not known, then
   the entry point will be through fb_ArrayEraseObj().and
   a run time check for dynamic / static is made.
*/

#include "fb.h"

void fb_hArrayCtorObj( FBARRAY *array, FB_DEFCTOR ctor )
{
	size_t elements, element_len;
	unsigned char *this_;

	if( array->ptr == NULL )
		return;

	elements = fb_ArrayLen( array );

	/* call ctors */
	element_len = array->element_len;
	this_ = array->ptr;

	while( elements > 0 ) {
		/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
		ctor( this_ );
		this_ += element_len;
		--elements;
	}
}

FBCALL int fb_ArrayClearObj
	(
		FBARRAY *array,
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor
	)
{
	/* destruct all objects in the array
	   (dtor can be NULL if there only is a ctor) */
	if( dtor )
		fb_ArrayDestructObj( array, dtor );

	/* re-initialize (ctor can be NULL if there only is a dtor) */
	if( ctor )
		/* if a ctor exists, it should handle the whole initialization */
		fb_hArrayCtorObj( array, ctor );
	else
		/* otherwise, just clear */
		fb_ArrayClear( array );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
