/* swap for strings */

#include "fb.h"

FBCALL void fb_StrSwap( void *str1, ssize_t size1, int fillrem1,
                        void *str2, ssize_t size2, int fillrem2 )
{
	char *p1, *p2;
	ssize_t len1, len2;

	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* both var-len? */
	if( (size1 == -1) && (size2 == -1) )
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

	FB_STRSETUP_FIX( str1, size1, p1, len1 );
	FB_STRSETUP_FIX( str2, size2, p2, len2 );

	/* Same length? Only need to do an fb_MemSwap() */
	if( len1 == len2 ) {
		if( len1 > 0 ) {
			fb_MemSwap( (unsigned char *)p1,
			            (unsigned char *)p2,
			            len1 );
			/* null terminators don't need to change */
		}
		return;
	}

	/* Note: user-allocated zstrings are assumed to be large enough */

	/* Is one of them a var-len string? Might need to be (re)allocated */
	if( (size1 == -1) || (size2 == -1) )
	{
		FBSTRING td = { 0, 0, 0 };
		fb_StrAssign( &td, -1, str1, size1, FALSE );
		fb_StrAssign( str1, size1, str2, size2, fillrem1 );
		fb_StrAssign( str2, size2, &td, -1, fillrem2 );
		fb_StrDelete( &td );
		return;
	}

	/* Both are fixed-size/user-allocated [z]strings */

	/* Make str1/str2 be the smaller/larger string respectively */
	if( len1 > len2 ) {
		{
			char* p = p1;
			p1 = p2;
			p2 = p;
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

		{
			int fillrem = fillrem1;
			fillrem1 = fillrem2;
			fillrem2 = fillrem;
		}
	}

	/* MemSwap as much as possible (i.e. the smaller length) */
	if( len1 > 0 ) {
		fb_MemSwap( (unsigned char *)p1,
			    (unsigned char *)p2,
			    len1 );
	}

	/* and copy over the remainder from larger to smaller, unless it's
	   a fixed-size [z]string that doesn't have enough room left (not even
	   for the null terminator) */
	if( (size1 > 0) && (len2 >= size1) ) {
		len2 = len1;
	} else if( len2 > len1 ) {
		FB_MEMCPYX( (unsigned char *)(p1 + len1),
		            (unsigned char *)(p2 + len1),
		            len2 - len1 );
	}

	/* set null terminators */
	p1[len2] = '\0';
	p2[len1] = '\0';

	/* Clear remainder of the larger (now smaller) string with nulls if
	   requested (see also fb_StrAssign()). We can assume that the strings
	   were originally cleared properly, because uninitialized strings
	   mustn't be used in rvalues, FB_STRSETUP_FIX() doesn't handle that.
	   The smaller (now larger) string doesn't need to be touched, as it's
	   remainder didn't increase */
	if( fillrem2 ) {
		ssize_t used2 = len1 + 1;
		if( size2 > used2 ) {
			memset( p2 + used2, 0, size2 - used2 );
		}
	}
}
