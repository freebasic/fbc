/* exepath$ */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

FBCALL FBSTRING *fb_ExePath ( void )
{
	FBSTRING 	*dst;
	char		*p;
	char		tmp[MAX_PATH+1];
	ssize_t len;

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
