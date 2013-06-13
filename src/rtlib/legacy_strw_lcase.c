#include "fb.h"

FBCALL FB_WCHAR *fb_WstrLcase( const FB_WCHAR *src )
{
	return fb_WstrLcase2( src, 0 );
}
