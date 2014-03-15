/* string assigning function */

#include "fb.h"

FBCALL void *fb_StrAssignEx
	(
		void *dst,
		ssize_t dst_size,
		void *src,
		ssize_t src_size,
		int fill_rem,
		int is_init
	)
{
	FBSTRING *dstr;
	const char *src_ptr;
	ssize_t src_len;

	FB_STRLOCK();

	if( dst == NULL )
	{
		if( src_size == -1 )
			fb_hStrDelTemp_NoLock( (FBSTRING *)src );

		FB_STRUNLOCK();

		return dst;
	}

	/* src */
	FB_STRSETUP_FIX( src, src_size, src_ptr, src_len );

	/* is dst var-len? */
	if( dst_size == -1 )
	{
        dstr = (FBSTRING *)dst;

		/* src NULL? */
		if( src_len == 0 )
		{
			if( is_init == FB_FALSE )
			{
				fb_StrDelete( dstr );
			}
			else
			{
				dstr->data = NULL;
				dstr->len = 0;
				dstr->size = 0;
			}
		}
		else
		{
			/* if src is a temp, just copy the descriptor */
			if( (src_size == -1) && FB_ISTEMP(src) )
			{
				if( is_init == FB_FALSE )
					fb_StrDelete( dstr );

				dstr->data = (char *)src_ptr;
				dstr->len = src_len;
				dstr->size = ((FBSTRING *)src)->size;

				((FBSTRING *)src)->data = NULL;
				((FBSTRING *)src)->len = 0;
				((FBSTRING *)src)->size = 0;

				fb_hStrDelTempDesc( (FBSTRING *)src );

				FB_STRUNLOCK();

				return dst;
			}

        	/* else, realloc dst if needed and copy src */
        	if( is_init == FB_FALSE )
        	{
				if( FB_STRSIZE( dst ) != src_len )
					fb_hStrRealloc( dstr, src_len, FB_FALSE );
        	}
        	else
        	{
				fb_hStrAlloc( dstr, src_len );
        	}

			fb_hStrCopy( dstr->data, src_ptr, src_len );
		}
	}
	/* fixed-len or zstring.. */
	else
	{
		/* src NULL? */
		if( src_len == 0 )
		{
			*(char *)dst = '\0';
		}
		else
		{
			/* byte ptr? as in C, assume dst is large enough */
			if( dst_size == 0 )
				dst_size = src_len;
			else
			{
				--dst_size; 						/* less the null-term */
				if( dst_size < src_len )
					src_len = dst_size;
			}

			fb_hStrCopy( (char *)dst, src_ptr, src_len );
		}

		/* fill reminder with null's */
		if( fill_rem != 0 )
		{
			dst_size -= src_len;
			if( dst_size > 0 )
				memset( &(((char *)dst)[src_len]), 0, dst_size );
		}
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)src );

	FB_STRUNLOCK();

	return dst;
}

FBCALL void *fb_StrAssign
	(
		void *dst,
		ssize_t dst_size,
		void *src,
		ssize_t src_size,
		int fill_rem
	)
{
	return fb_StrAssignEx( dst, dst_size, src, src_size, fill_rem, FB_FALSE );
}

FBCALL void *fb_StrInit
	(
		void *dst,
		ssize_t dst_size,
		void *src,
		ssize_t src_size,
		int fill_rem
	)
{
	return fb_StrAssignEx( dst, dst_size, src, src_size, fill_rem, FB_TRUE );
}
