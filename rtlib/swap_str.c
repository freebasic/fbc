/* swap for strings */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_StrSwap( void *str1, int str1_size, void *str2, int str2_size )
{
	char *str1_ptr, *str2_ptr;
	int str1_len, str2_len;

	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* both var-len? */
	if( (str1_size == -1) && (str2_size == -1) )
	{
		FBSTRING td;

		/* just swap the descriptors */
		td.data = ((FBSTRING *)str1)->data;
		td.len  = ((FBSTRING *)str1)->len;
		td.size  = ((FBSTRING *)str1)->size;

		((FBSTRING *)str1)->data = ((FBSTRING *)str2)->data;
		((FBSTRING *)str1)->len = ((FBSTRING *)str2)->len;
		((FBSTRING *)str1)->size = ((FBSTRING *)str2)->size;

		((FBSTRING *)str2)->data = td.data;
		((FBSTRING *)str2)->len = td.len;
		((FBSTRING *)str2)->size = td.size;

		return;
	}

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );
	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	/* Same length? Only need to do an fb_MemSwap() */
	if( str1_len == str2_len ) {
		if( str1_len > 0 ) {
			fb_MemSwap( (unsigned char *)str1_ptr,
			            (unsigned char *)str2_ptr,
			            str1_len );
			/* null terminators don't need to change */
		}
		return;
	}

	/* Note: user-allocated zstrings are assumed to be large enough */

	/* Only one of them var-len? It may need to be (re)allocated,
	   a temp string must be used */
	if( (str1_size == -1) || (str2_size == -1) )
	{
		FBSTRING td = { 0 };
		fb_StrAssign( &td, -1, str1, str1_size, FALSE );
		fb_StrAssign( str1, str1_size, str2, str2_size, FALSE );
		fb_StrAssign( str2, str2_size, &td, -1, FALSE );
		fb_StrDelete( &td );
		return;
	}

	/* Both are fixed-size/user-allocated zstrings */

	/* Make str1/str2 be the smaller/larger string respectively */
	if( str1_len > str2_len ) {
		{
			char* tempstr = str1_ptr;
			str1_ptr = str2_ptr;
			str2_ptr = tempstr;
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
		fb_MemSwap( (unsigned char *)str1_ptr,
			    (unsigned char *)str2_ptr,
			    str1_len );
	}

	/* and copy over the remainder from larger to smaller, unless it's
	   a fixed-size zstring that doesn't have enough room left */
	if( (str1_size > 0) && (str2_len >= str1_size) ) {
		str2_len = str1_len;
	} else if( str2_len > str1_len ) {
		FB_MEMCPYX( (unsigned char *)(str1_ptr + str1_len),
		            (unsigned char *)(str2_ptr + str1_len),
		            str2_len - str1_len );
	}

	/* set null terminators */
	str1_ptr[str2_len] = '\0';
	str2_ptr[str1_len] = '\0';
}
