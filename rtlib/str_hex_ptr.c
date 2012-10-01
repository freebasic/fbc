/* hex(any ptr) function */

#include "fb.h"

FBCALL FBSTRING *fb_HEX_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_HEX_l( (unsigned long long int)p );
#else
	return fb_HEX_i( (unsigned int)p );
#endif
}

FBCALL FBSTRING *fb_HEXEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_HEXEx_l( (unsigned long long int)p, digits );
#else
	return fb_HEXEx_i( (unsigned int)p, digits );
#endif
}
