/* input function for signed long long's */

#include "fb.h"
#include <math.h>

FBCALL int fb_InputLongint( long long *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
	ssize_t len;
	int isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	if( isfp == FALSE )
	{
		if( len <= FB_INPUT_MAXINTLEN )
			*dst = fb_hStr2Int( buffer, len );
		else
			*dst = fb_hStr2Longint( buffer, len );
	}
	else
		*dst = (long long)rint( fb_hStr2Double( buffer, len ) );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
