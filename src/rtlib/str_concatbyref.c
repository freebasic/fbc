/* 
	run-time optimization for:

		dim shared m as string
		sub proc( byref s as string, byref t as string )
			'' these are optimized to fb_StrConcatByref() 
			m += s
			s += t
		end sub

		dim as string a, b
		proc( m, a )
		proc( a, a )
		proc( a, b )

	it can't be determined at compile time within proc() if the strings passed
	to proc() are the same strings.  Might be able to use fb_StrConcatAssign() 
	but only if it is known that the strings are different.  Otherwise the
	contents of the string could be destroyed before the are copied.  If the
	strings are the same, then extend the buffer and copy the first part of the
	string to the second half.

	We should only get here if the left hand side variable was an FBSTRING type
	and we should expect a string descriptor.
*/

#include "fb.h"

FBCALL void *fb_StrConcatByref
	(
		void *dst,
		ssize_t dst_size,
		void *src,
		ssize_t src_size,
		int fillrem
	)
{
	char *dst_ptr;
	const char *src_ptr;
	ssize_t dst_len, src_len;

	/* dst should always be var-len string */
	DBG_ASSERT( dst_size == -1 );

	/* dst */
	FB_STRSETUP_FIX( dst, dst_size, dst_ptr, dst_len );

	/* src */
	FB_STRSETUP_FIX( src, src_size, src_ptr, src_len );

	/* Are dst & src same same data? */
	if( dst == src || dst_ptr == src_ptr )
	{
		FBSTRING *str = dst;

		FB_STRLOCK();
		
		if( fb_hStrRealloc( str, dst_len + src_len, FB_TRUE ) )
		{
			/* recalculate dst */
			FB_STRSETUP_FIX( str, dst_size, dst_ptr, dst_len );

			/* copy start of dst to second half */
			FB_MEMCPYX( dst_ptr + dst_len, dst, dst_len );

			fb_hStrSetLength( str, dst_len + dst_len );

			str->data[dst_len + dst_len] = '\0';
		}

		/* delete temps? */
		if( dst_size == -1 )
			fb_hStrDelTemp_NoLock( (FBSTRING *)dst );
		if( src_size == -1 )
			fb_hStrDelTemp_NoLock( (FBSTRING *)src );

		FB_STRUNLOCK();

		return dst;
	}

	return fb_StrConcatAssign( dst, dst_size, src, src_size, fillrem );
}
