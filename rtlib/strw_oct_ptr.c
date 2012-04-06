/* woct(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrOct_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrOct_l( (unsigned long long int)p );
#else
	return fb_WstrOct_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrOctEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrOctEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrOctEx_i( (unsigned int)p, digits );
#endif
}
