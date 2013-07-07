/* string concat and assigning (s = s + expr) function */

#include "fb.h"

FBCALL void *fb_StrConcatAssign
	(
		void *dst,
		ssize_t dst_size,
		void *src,
		ssize_t src_size,
		int fillrem
	)
{
	FBSTRING *dstr;
	const char *src_ptr;
	ssize_t src_len, dst_len;

	if( dst == NULL )
	{
		/* delete temp? */
		if( src_size == -1 )
			fb_hStrDelTemp( (FBSTRING *)src );

		return dst;
	}

	/* src */
	FB_STRSETUP_FIX( src, src_size, src_ptr, src_len );

	/* not NULL? */
	if( src_len > 0 )
	{
		/* is dst var-len? */
		if( dst_size == -1 )
		{
        	dstr = (FBSTRING *)dst;
        	dst_len = FB_STRSIZE( dst );

			fb_hStrRealloc( dstr, dst_len+src_len, FB_TRUE );

			fb_hStrCopy( &dstr->data[dst_len], src_ptr, src_len );
		}
		else
		{
			dst_len = strlen( (char *)dst );

			/* don't check byte ptr's */
			if( dst_size > 0 )
			{
				--dst_size;							/* less the null-term */

				if( src_len > dst_size - dst_len )
					src_len = dst_size - dst_len;
			}

			fb_hStrCopy( &(((char *)dst)[dst_len]), src_ptr, src_len );

			/* don't check byte ptr's */
			if( (fillrem != 0) && (dst_size > 0) )
			{
				/* fill reminder with null's */
				dst_size -= (dst_len + src_len);
				if( dst_size > 0 )
					memset( &(((char *)dst)[dst_len+src_len]), 0, dst_size );
			}
		}
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)src );

	return dst;
}
