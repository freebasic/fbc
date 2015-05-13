/* whex(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrHex_p( const void *p )
{
#ifdef HOST_64BIT
	return fb_WstrHex_l( (unsigned long long int)p );
#else
	return fb_WstrHex_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrHexEx_p( const void *p, int digits )
{
#ifdef HOST_64BIT
	return fb_WstrHexEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrHexEx_i( (unsigned int)p, digits );
#endif
}
