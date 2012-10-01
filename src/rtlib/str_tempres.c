/* temp result string allocation */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_StrAllocTempResult ( FBSTRING *src )
{
 	FBSTRING *dsc;

	FB_STRLOCK();
	
 	/* alloc a temporary descriptor (the current one at stack will be trashed) */
 	dsc = fb_hStrAllocTmpDesc( );
    if( dsc == NULL ) {
    	FB_STRUNLOCK();
    	return &__fb_ctx.null_desc;
    }

    /* copy just the descriptor, setting it as a temp string */
    dsc->data = src->data;
    dsc->len  = src->len | FB_TEMPSTRBIT;
    dsc->size = src->size;

	/* just for safety.. */
	src->data = NULL;
	src->len  = 0;
	src->size = 0;

	FB_STRUNLOCK();

	return dsc;
}


