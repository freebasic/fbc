#include "fb.h"

FBCALL FBSTRING *fb_LCASE( FBSTRING *src )
{
	return fb_StrLcase2( src, 0 );
}
