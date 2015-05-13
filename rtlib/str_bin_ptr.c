/* bin(any ptr) function */

#include "fb.h"

FBCALL FBSTRING *fb_BIN_p( void *p )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_BIN_l( (unsigned long long int)p );
#else
	return fb_BIN_i( (unsigned int)p );
#endif
}

FBCALL FBSTRING *fb_BINEx_p( void *p, int digits )
{
#if defined HOST_X86_64 || defined HOST_SPARC64 || defined HOST_POWERPC64
	return fb_BINEx_l( (unsigned long long int)p, digits );
#else
	return fb_BINEx_i( (unsigned int)p, digits );
#endif
}
