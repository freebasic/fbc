/*
 * swap_wstr.c -- swap f/ wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WstrSwap( FB_WCHAR *str1, int str1_size, FB_WCHAR *str2, int str2_size )
{
	int size;

	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* handle zstring ptr's */
	if( str1_size <= 0 )
		str1_size = fb_wstr_Len( str1 ) + 1;

	if( str2_size <= 0 )
		str2_size = fb_wstr_Len( str2 ) + 1;

	/* don't overrun */
	size = (str1_size <= str2_size? str1_size : str2_size) - 1;

	if( size > 0 )
		fb_MemSwap( (unsigned char *)str1, (unsigned char *)str2, size * sizeof( FB_WCHAR ) );

	/* add the null-terms */
	str1[size] = L'\0';
	str2[size] = L'\0';
}
