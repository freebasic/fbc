#include "fb.h"

FBCALL FB_WCHAR *fb_DirNext64_W( long long *outattrib )
{
	int ioutattrib;
	FB_WCHAR *res;

	res = fb_DirNext_W( &ioutattrib );

	*outattrib = ioutattrib;
	return res;
}
