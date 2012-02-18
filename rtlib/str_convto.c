/* str$ routines for int, uint
 *
 * the result string's len is being "faked" to appear as if it were shorter
 * than the one that has to be allocated to fit _itoa and _gvct buffers.
 */

#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_IntToStr ( int num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( int ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef HOST_MINGW
		_itoa( num, dst->data, 10 );
#else
		sprintf( dst->data, "%d", num );
#endif
		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_UIntToStr ( unsigned int num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( int ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef HOST_MINGW
		_ultoa( num, dst->data, 10 );
#else
		sprintf( dst->data, "%u", num );
#endif
		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}
