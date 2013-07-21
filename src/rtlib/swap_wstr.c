/* swap for wstrings */

#include "fb.h"

FBCALL void fb_WstrSwap( FB_WCHAR *str1, ssize_t size1, FB_WCHAR *str2, ssize_t size2 )
{
	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* Retrieve lengths */
	ssize_t len1, len2;

	/* user-allocated wstring? */
	if( size1 <= 0 )
		len1 = fb_wstr_Len( str1 );
	else
		len1 = size1 - 1;

	if( size2 <= 0 )
		len2 = fb_wstr_Len( str2 );
	else
		len2 = size2 - 1;

	/* Same length? Only need to do an fb_MemSwap() */
	if( len1 == len2 ) {
		if( len1 > 0 ) {
			fb_MemSwap( (unsigned char *)str1,
			            (unsigned char *)str2,
			            len1 * sizeof( FB_WCHAR ) );
			/* null terminators don't need to change */
		}
		return;
	}

	/* Make str1/str2 be the smaller/larger string respectively */
	if( len1 > len2 ) {
		{
			FB_WCHAR *str = str1;
			str1 = str2;
			str2 = str;
		}

		{
			ssize_t len = len1;
			len1 = len2;
			len2 = len;
		}

		{
			ssize_t size = size1;
			size1 = size2;
			size2 = size;
		}
	}

	/* MemSwap as much as possible (i.e. the smaller length) */
	if( len1 > 0 ) {
		fb_MemSwap( (unsigned char *)str1,
			    (unsigned char *)str2,
			    len1 * sizeof( FB_WCHAR ) );
	}

	/* and copy over the remainder from larger to smaller, unless it's
	   a fixed-size wstring that doesn't have enough room left */
	if( (size1 > 0) && (len2 >= size1) ) {
		len2 = len1;
	} else if( len2 > len1 ) {
		fb_wstr_Move( (str1 + len1),
		              (str2 + len1),
		              len2 - len1 );
	}

	/* set null terminators */
	str1[len2] = L'\0';
	str2[len1] = L'\0';
}
