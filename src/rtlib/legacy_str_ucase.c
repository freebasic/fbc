#include "fb.h"

FBCALL FBSTRING *fb_UCASE( FBSTRING *src )
{
	return fb_StrUcase2( src, 0 );
}
