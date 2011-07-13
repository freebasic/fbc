/*
 * sys_cdir.c -- curdir$
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_CurDir ( void )
{
	FBSTRING 	*dst;
	char		tmp[MAX_PATH];
	int			len;

	FB_LOCK();

	len = fb_hGetCurrentDir( tmp, MAX_PATH );

	/* alloc temp string */
	if( len > 0 )
	{
        dst = fb_hStrAllocTemp( NULL, len );
		if( dst != NULL )
		{
			memcpy( dst->data, tmp, len + 1 );
		}
		else
			dst = &__fb_ctx.null_desc;
	}
	else
		dst = &__fb_ctx.null_desc;

	FB_UNLOCK();

	return dst;
}

