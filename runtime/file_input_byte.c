/* input function for signed bytes */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_InputByte( char *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
    int len, isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	if( isfp == FALSE )
		*dst = (char)fb_hStr2Int( buffer, len );
	else
		*dst = (char)rint( fb_hStr2Double( buffer, len ) );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
