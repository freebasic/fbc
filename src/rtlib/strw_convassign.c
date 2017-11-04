/* ascii <-> unicode string convertion functions */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrAssignFromA
	(
		FB_WCHAR *dst,
		ssize_t dst_chars,
		void *src,
		ssize_t src_size
	)
{
	char *src_ptr;
	ssize_t src_chars;

	if( dst != NULL )
	{
		FB_STRSETUP_FIX( src, src_size, src_ptr, src_chars );

		/* size unknown? assume it's big enough */
		if( dst_chars == 0 )
		{
			dst_chars = src_chars;
		}
		else
		{
			/* less the null-term */
			--dst_chars;
		}

		fb_wstr_ConvFromA( dst, dst_chars, src_ptr );
	}

	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)src );

	return dst;
}

/* We'll convert wide-string to multi-byte string -- we don't know
   how big the result will be, but we can make a good guess.
   In the worst case, we'll allocate too much. */
/* 4 bytes per char - allowing for UTF8 multi-byte strings, happens on GNU/Linux.
   On Windows there can be double-byte encodings etc. too. */
#define getALenForWLen(wlen) ((wlen) * 4)

FBCALL void *fb_WstrAssignToAEx
	(
		void *dst,
		ssize_t dst_chars,
		FB_WCHAR *src,
		int fill_rem,
		int is_init
	)
{
	ssize_t src_chars;

	if( dst == NULL )
		return dst;

	if( src != NULL )
		src_chars = fb_wstr_Len( src );
	else
		src_chars = 0;

	/* is dst var-len? */
	if( dst_chars == -1 )
	{
		/* src NULL? */
		if( src_chars == 0 )
		{
			if( is_init == FB_FALSE )
			{
				fb_StrDelete( (FBSTRING *)dst );
			}
			else
			{
				((FBSTRING *)dst)->data = NULL;
				((FBSTRING *)dst)->len = 0;
				((FBSTRING *)dst)->size = 0;
			}
		}
		else
		{
        	/* realloc dst if needed and copy src */
			dst_chars = getALenForWLen(src_chars);
			if( is_init == FB_FALSE )
			{
				if( FB_STRSIZE( dst ) != dst_chars )
					fb_hStrRealloc( (FBSTRING *)dst, dst_chars, FB_FALSE );
			}
			else
			{
				fb_hStrAlloc( (FBSTRING *)dst, dst_chars );
			}

			ssize_t writtenchars = fb_wstr_ConvToA( ((FBSTRING *)dst)->data, dst_chars, src );
			fb_hStrSetLength( dst, writtenchars );
		}
	}
	/* fixed-len or zstring.. */
	else
	{
		/* src NULL? */
		if( src_chars == 0 ) {
			if( fill_rem && dst_chars > 0 ) {
				memset( dst, 0, dst_chars );
			} else {
				*(char *)dst = '\0';
			}
		/* byte ptr? as in C, assume dst is large enough */
		} else if( dst_chars == 0 ) {
			dst_chars = getALenForWLen(src_chars);
			fb_wstr_ConvToA( (char *)dst, dst_chars, src );
		} else {
			dst_chars -= 1; /* null terminator */
			ssize_t writtenchars = fb_wstr_ConvToA( (char *)dst, dst_chars, src );

			/* fill remainder with null's */
			if( fill_rem && writtenchars < dst_chars ) {
				/* + 1 to fill behind null terminator. There is room for dst_chars + 1. */
				memset( ((char *)dst) + writtenchars + 1, 0, dst_chars - writtenchars );
			}
		}
	}

	return dst;
}

FBCALL void *fb_WstrAssignToA
	(
		void *dst,
		ssize_t dst_chars,
		FB_WCHAR *src,
		int fill_rem
	)
{
	return fb_WstrAssignToAEx( dst, dst_chars, src, fill_rem, FB_FALSE );
}

FBCALL void *fb_WstrAssignToA_Init
	(
		void *dst,
		ssize_t dst_chars,
		FB_WCHAR *src,
		int fill_rem
	)
{
	return fb_WstrAssignToAEx( dst, dst_chars, src, fill_rem, FB_TRUE );
}
