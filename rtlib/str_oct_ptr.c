/* oct(any ptr) function */

#include "fb.h"

FBCALL FBSTRING *fb_OCT_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_OCT_l( (unsigned long long int)p );
#else
	return fb_OCT_i( (unsigned int)p );
#endif
}

FBCALL FBSTRING *fb_OCTEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_OCTEx_l( (unsigned long long int)p, digits );
#else
	return fb_OCTEx_i( (unsigned int)p, digits );
#endif
}
