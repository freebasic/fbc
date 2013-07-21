/* input function */

#include "fb.h"

FBCALL int fb_InputString( void *dst, ssize_t strlen, int fillrem )
{
    char buffer[FB_INPUT_MAXSTRINGLEN+1];
	int isfp;

	fb_FileInputNextToken( buffer, FB_INPUT_MAXSTRINGLEN, TRUE, &isfp );

	fb_StrAssign( dst, strlen, buffer, 0, fillrem );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
