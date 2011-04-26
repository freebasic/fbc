/*
 * qb_str_convto_lng.c -- QB compatible str$ routines for longint, ulongint
 *
 * obs.: the result string's len is being "faked" to appear as if it were shorter
 *       than the one that has to be allocated to fit _itoa and _gvct buffers.
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LongintToStrQB ( long long num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( long long ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef TARGET_WIN32
		dst->data[0] = ' ';
		_i64toa( num, dst->data + (num >= 0? 1:0), 10 );
#else
		sprintf( dst->data, "% lld", num );
#endif
		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_ULongintToStrQB ( unsigned long long num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
	dst = fb_hStrAllocTemp( NULL, sizeof( long long ) * 3 );
	if( dst != NULL )
	{
		/* convert */
#ifdef TARGET_WIN32
		dst->data[0] = ' ';
		_ui64toa( num, dst->data + 1, 10 );
#else
		sprintf( dst->data, "%llu", num );
#endif
		fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}
