/* redim function */

#include "fb.h"

FBCALL int fb_ArrayRedimTo
	(
		FBARRAY *dest,
		const FBARRAY *source,
		int isvarlen,
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor
	)
{
	ssize_t diff;
	unsigned char *this_;
	unsigned char *limit;

	if( dest == source ) {
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}

	/* ditto, see fb_hArrayAlloc() */
	if( (source->dimensions != dest->dimensions) && (dest->dimensions != 0) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* Retrieve diff value so we don't have to re-calculate it */
	if( source->ptr > source->data ) {
		diff = ((size_t)source->ptr) - ((size_t)source->data);
		diff = -diff;
	} else {
		/* both may be NULL too */
		diff = ((size_t)source->data) - ((size_t)source->ptr);
	}

	/* free old */
	if( dtor )
		fb_ArrayDestructObj( dest, dtor );

	if( isvarlen ) {
		fb_ArrayStrErase( dest );
	} else {
		fb_ArrayErase( dest );
	}

	DBG_ASSERT( dest->element_len == source->element_len || dest->element_len == 0 );
	DBG_ASSERT( dest->dimensions == source->dimensions || dest->dimensions == 0 );

	/* Copy over bounds etc. */
	dest->size = source->size;
	dest->element_len = source->element_len;
	dest->dimensions = source->dimensions;
	memcpy( &dest->dimTB[0], &source->dimTB[0], sizeof( FBARRAYDIM ) * dest->dimensions );

	/* Empty/unallocated source array? */
	if( dest->size == 0 ) {
		/* Destination will be empty/unallocated too */
		dest->ptr = NULL;
		dest->data = NULL;
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}

	/* Allocate new buffer; clear unless ctors will be called.
	   (ctors take care of clearing themselves) */
	if( ctor == NULL ) {
		dest->ptr = calloc( dest->size, 1 );
	} else {
		dest->ptr = malloc( dest->size );
	}
	if( dest->ptr == NULL ) {
		return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
	}
	dest->data = ((unsigned char *)dest->ptr) + diff;

	/* Call ctor for each element */
	if( ctor ) {
		this_ = dest->ptr;
		limit = this_ + dest->size;
		while( this_ < limit ) {
			ctor( this_ );
			this_ += dest->element_len;
		}
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
