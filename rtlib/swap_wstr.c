/* swap for wstrings */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WstrSwap( FB_WCHAR *str1, int str1_size, FB_WCHAR *str2, int str2_size )
{
	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* Retrieve lengths */
	int str1_len, str2_len;

	/* user-allocated wstring? */
	if( str1_size <= 0 )
		str1_len = fb_wstr_Len( str1 );
	else
		str1_len = str1_size - 1;

	if( str2_size <= 0 )
		str2_len = fb_wstr_Len( str2 );
	else
		str2_len = str2_size - 1;

	/* Same length? Only need to do an fb_MemSwap() */
	if( str1_len == str2_len ) {
		if( str1_len > 0 ) {
			fb_MemSwap( (unsigned char *)str1,
			            (unsigned char *)str2,
			            str1_len * sizeof( FB_WCHAR ) );
			/* null terminators don't need to change */
		}
		return;
	}

	/* Make str1/str2 be the smaller/larger string respectively */
	if( str1_len > str2_len ) {
		{
			FB_WCHAR *tempstr = str1;
			str1 = str2;
			str2 = tempstr;
		}

		{
			int templen = str1_len;
			str1_len = str2_len;
			str2_len = templen;
		}

		{
			int templen = str1_size;
			str1_size = str2_size;
			str2_size = templen;
		}
	}

	/* MemSwap as much as possible (i.e. the smaller length) */
	if( str1_len > 0 ) {
		fb_MemSwap( (unsigned char *)str1,
			    (unsigned char *)str2,
			    str1_len * sizeof( FB_WCHAR ) );
	}

	/* and copy over the remainder from larger to smaller, unless it's
	   a fixed-size wstring that doesn't have enough room left */
	if( (str1_size > 0) && (str2_len >= str1_size) ) {
		str2_len = str1_len;
	} else if( str2_len > str1_len ) {
		fb_wstr_Move( (str1 + str1_len),
		              (str2 + str1_len),
		              str2_len - str1_len );
	}

	/* set null terminators */
	str1[str2_len] = L'\0';
	str2[str1_len] = L'\0';
}
