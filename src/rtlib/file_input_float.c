/* input function for float's and double's */

#include "fb.h"

FBCALL int fb_InputSingle( float *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
	ssize_t len;
	int isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	if( isfp == FALSE )
	{
		if( len <= FB_INPUT_MAXINTLEN )
			*dst = (float)fb_hStr2Int( buffer, len );
		else if( len <= FB_INPUT_MAXLONGLEN )
			*dst = (float)fb_hStr2Longint( buffer, len );
		else
		{
			if( buffer[0] == '&' )
				*dst = (float)fb_hStr2Longint( buffer, len );
			else
				*dst = strtof( buffer, NULL );
		}
	}
	else
		*dst = strtof( buffer, NULL );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int fb_InputDouble( double *dst )
{
    char buffer[FB_INPUT_MAXNUMERICLEN+1];
	ssize_t len;
	int isfp;

	len = fb_FileInputNextToken( buffer, FB_INPUT_MAXNUMERICLEN, FB_FALSE, &isfp );

	if( isfp == FALSE )
	{
		if( len <= FB_INPUT_MAXINTLEN )
			*dst = (double)fb_hStr2Int( buffer, len );
		else if( len <= FB_INPUT_MAXLONGLEN )
			*dst = (double)fb_hStr2Longint( buffer, len );
		else
		{
			if( buffer[0] == '&' )
				*dst = (double)fb_hStr2Longint( buffer, len );
			else
				*dst = strtod( buffer, NULL );
		}
	}
	else
		*dst = strtod( buffer, NULL );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
