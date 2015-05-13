#include "fb.h"

FBCALL FBSTRING *fb_DirNext64( long long *outattrib )
{
	int ioutattrib;
	FBSTRING *res;

	res = fb_DirNext( &ioutattrib );

	*outattrib = ioutattrib;
	return res;
}
