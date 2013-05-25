#include "fb.h"

FBCALL FB_WCHAR *fb_WstrUcase( const FB_WCHAR *src )
{
	return fb_WstrUcase2( src, 0 );
}
