/* wstring concatenation + convertion functions */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrConcatWA( const FB_WCHAR *str1, const void *str2, ssize_t str2_size )
{
	FB_WCHAR *dst;
	ssize_t str1_len, str2_len;
	char *str2_ptr;

	if( str1 != NULL )
		str1_len = fb_wstr_Len( str1 );
	else
		str1_len = 0;

	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	/* NULL? */
	if( str1_len + str2_len == 0 )
	{
		dst = NULL;
	}
	else
	{
		/* alloc temp string */
    	dst = fb_wstr_AllocTemp( str1_len + str2_len );

		/* do the concatenation */
    	fb_wstr_Move( dst, str1, str1_len );
    	fb_wstr_ConvFromA( &dst[str1_len], str2_len, str2_ptr );
    }

	/* delete temp? */
	if( str2_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str2 );

	return dst;
}

FBCALL FB_WCHAR *fb_WstrConcatAW( const void *str1, ssize_t str1_size, const FB_WCHAR *str2 )
{
	FB_WCHAR *dst;
	ssize_t str1_len, str2_len;
	char *str1_ptr;

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );

	if( str2 != NULL )
		str2_len = fb_wstr_Len( str2 );
	else
		str2_len = 0;

	/* NULL? */
	if( str1_len + str2_len == 0 )
	{
		dst = NULL;
	}
	else
	{
		/* alloc temp string */
    	dst = fb_wstr_AllocTemp( str1_len + str2_len );

		/* do the concatenation */
    	str1_len = fb_wstr_ConvFromA( dst, str1_len, str1_ptr );
    	if( str2_len > 0 )
    		fb_wstr_Move( &dst[str1_len], str2, str2_len + 1 );
    }

	/* delete temp? */
	if( str1_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str1 );

	return dst;
}

