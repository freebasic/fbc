/* string concatenation function */

#include "fb.h"

static __inline__ void fb_hStrConcat
	(
		char *dst,
		const char *str1,
		ssize_t len1,
		const char *str2,
		ssize_t len2
	)
{
    dst = (char *) FB_MEMCPYX( dst, str1, len1 );
    dst = (char *) FB_MEMCPYX( dst, str2, len2 );
	*dst = '\0';
}

FBCALL FBSTRING *fb_StrConcat
	(
		FBSTRING *dst,
		void *str1,
		ssize_t str1_size,
		void *str2,
		ssize_t str2_size
	)
{
	const char *str1_ptr, *str2_ptr;
	ssize_t str1_len, str2_len;

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );

	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	/* NULL? */
	if( str1_len+str2_len == 0 )
	{
		fb_StrDelete( dst );
	}
	else
	{
		/* alloc temp string */
		dst = fb_hStrAllocTemp( dst, str1_len+str2_len );
		DBG_ASSERT( dst );

		/* do the concatenation */
		fb_hStrConcat( dst->data, str1_ptr, str1_len, str2_ptr, str2_len );
	}

	FB_STRLOCK();

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return dst;
}

