/* input function for unsigned bytes */

#include "fb.h"

/*:::::*/
FBCALL int fb_InputUbyte( unsigned char *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
    int len, isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	if( isfp == FALSE )
		*dst = (unsigned char)fb_hStr2UInt( buffer, len );
	else
		*dst = (unsigned char)rint( fb_hStr2Double( buffer, len ) );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
