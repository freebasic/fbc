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
			if( is_init == FB_FALSE )
			{
				if( FB_STRSIZE( dst ) != (size_t)src_chars )
					fb_hStrRealloc( (FBSTRING *)dst, src_chars, FB_FALSE );
			}
			else
			{
				fb_hStrAlloc( (FBSTRING *)dst, src_chars );
			}

			fb_wstr_ConvToA( ((FBSTRING *)dst)->data, src, src_chars );
		}
	}
	/* fixed-len or zstring.. */
	else
	{
		/* src NULL? */
		if( src_chars == 0 )
		{
			*(char *)dst = '\0';
		}
		else
		{
			/* byte ptr? as in C, assume dst is large enough */
			if( dst_chars == 0 )
				dst_chars = src_chars;

			fb_wstr_ConvToA( (char *)dst,
							 src,
							 (dst_chars <= src_chars? dst_chars : src_chars) );
		}

		/* fill reminder with null's */
		if( fill_rem != 0 )
		{
			dst_chars -= src_chars;
			if( dst_chars > 0 )
				memset( &(((char *)dst)[src_chars]), 0, dst_chars );
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
