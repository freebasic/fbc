/* wbin(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrBin_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrBin_l( (unsigned long long int)p );
#else
	return fb_WstrBin_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrBinEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrBinEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrBinEx_i( (unsigned int)p, digits );
#endif
}
