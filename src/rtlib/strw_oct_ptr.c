/* woct(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrOct_p( const void *p )
{
#ifdef HOST_64BIT
	return fb_WstrOct_l( (unsigned long long int)p );
#else
	return fb_WstrOct_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrOctEx_p( const void *p, int digits )
{
#ifdef HOST_64BIT
	return fb_WstrOctEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrOctEx_i( (unsigned int)p, digits );
#endif
}
