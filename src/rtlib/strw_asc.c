/* ascw function */

#include "fb.h"

FBCALL unsigned int fb_WstrAsc( const FB_WCHAR *str, ssize_t pos )
{
	ssize_t len;

	if( str == NULL )
		return 0;

	len = fb_wstr_Len( str );
	if( (len == 0) || (pos <= 0) || (pos > len) )
		return 0;
	else
	/* on DOS, FB_WCHAR is a 'char' which is
	   typically signed.  To avoid an undesired
	   sign extension for chars >= 128, cast
	   to unsigned char first
	*/
	#if defined HOST_DOS
		return (unsigned char)str[pos-1];
	#else
		return str[pos-1];
	#endif
}
