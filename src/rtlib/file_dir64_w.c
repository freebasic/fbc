#include "fb.h"

FBCALL FB_WCHAR *fb_Dir64_W( FB_WCHAR *filespec, int attrib, long long *outattrib )
{
	int ioutattrib;
	FB_WCHAR *res;

	res = fb_Dir_W( filespec, attrib, &ioutattrib );

	*outattrib = ioutattrib;
	return res;
}
