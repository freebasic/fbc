/* str$ routines for longint, ulongint
 *
 * the result string's len is being "faked" to appear as if it were shorter
 * than the one that has to be allocated to fit _itoa and _gvct buffers.
 */

#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LongintToStr ( long long num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( long long ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef HOST_MINGW
		_i64toa( num, dst->data, 10 );
#else
		sprintf( dst->data, "%lld", num );
#endif

		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_ULongintToStr ( unsigned long long num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( long long ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef HOST_MINGW
		_ui64toa( num, dst->data, 10 );
#else
		sprintf( dst->data, "%llu", num );
#endif

		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}
