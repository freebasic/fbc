/* wbin(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrBin_p( const void *p )
{
#ifdef HOST_64BIT
	return fb_WstrBin_l( (unsigned long long int)p );
#else
	return fb_WstrBin_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrBinEx_p( const void *p, int digits )
{
#ifdef HOST_64BIT
	return fb_WstrBinEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrBinEx_i( (unsigned int)p, digits );
#endif
}
