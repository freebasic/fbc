/* misc string routines */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_SPACE ( int len )
{
	FBSTRING 	*dst;

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_hStrAllocTemp( NULL, len );
		if( dst != NULL )
		{
			/* fill it */
			memset( dst->data, 32, len );

			/* null char */
			dst->data[len] = '\0';
		}
		else
			dst = &__fb_ctx.null_desc;
    }
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

