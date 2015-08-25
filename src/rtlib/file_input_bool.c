/* input function for boolean */

#include "fb.h"
#include <math.h>

/*:::::*/
FBCALL int fb_InputBool( char *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
	ssize_t len;
	int isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	*dst = (char)fb_hStr2Bool( buffer, len );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

