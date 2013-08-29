#include "fb.h"

FBCALL FBSTRING *fb_Dir64( FBSTRING *filespec, int attrib, long long *outattrib )
{
	int ioutattrib;
	FBSTRING *res;

	res = fb_Dir( filespec, attrib, &ioutattrib );

	*outattrib = ioutattrib;
	return res;
}
