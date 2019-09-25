/* dir() */

#include "fb.h"

FBCALL FB_WCHAR *fb_DirNext_W( int *attrib )
{
	static FB_WCHAR fname = 0; //{ 0, 0, 0 };
	return fb_Dir_W( &fname, 0, attrib );
}
