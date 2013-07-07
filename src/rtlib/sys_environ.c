/* environ$ function and setenviron stmt */

#include "fb.h"

FBCALL FBSTRING *fb_GetEnviron ( FBSTRING *varname )
{
	FBSTRING 	*dst;
	char 		*tmp;
	ssize_t len;

	if( (varname != NULL) && (varname->data != NULL) )
		tmp = getenv( varname->data );
	else
		tmp = NULL;

	FB_STRLOCK();

	if( tmp != NULL )
	{
        len = strlen( tmp );
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			fb_hStrCopy( dst->data, tmp, len );
		}
		else
			dst = &__fb_ctx.null_desc;
	}
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( varname );

	FB_STRUNLOCK();

	return dst;
}

FBCALL int fb_SetEnviron ( FBSTRING *str )
{
	int res = 0;

	if( (str != NULL) && (str->data != NULL) )
	{
#ifdef HOST_MINGW
		res = _putenv( str->data );
#else
		res = putenv( str->data );
#endif
	}

	/* del if temp */
	fb_hStrDelTemp( str );

	return res;
}
