/* exepath$ */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_ExePath ( void )
{
	FBSTRING 	*dst;
	char		*p;
	char		tmp[MAX_PATH+1];
	int			len;

	p = fb_hGetExePath( tmp, MAX_PATH );

	if( p != NULL )
	{
		/* alloc temp string */
        len = strlen( tmp );
        dst = fb_hStrAllocTemp( NULL, len );
		if( dst != NULL )
		{
			fb_hStrCopy( dst->data, tmp, len );
		}
		else
			dst = &__fb_ctx.null_desc;
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}
