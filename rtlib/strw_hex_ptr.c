/* whex(any ptr) function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrHex_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrHex_l( (unsigned long long int)p );
#else
	return fb_WstrHex_i( (unsigned int)p );
#endif
}

FBCALL FB_WCHAR *fb_WstrHexEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_WstrHexEx_l( (unsigned long long int)p, digits );
#else
	return fb_WstrHexEx_i( (unsigned int)p, digits );
#endif
}
