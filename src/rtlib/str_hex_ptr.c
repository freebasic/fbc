/* hex(any ptr) function */

#include "fb.h"

FBCALL FBSTRING *fb_HEX_p( const void *p )
{
#ifdef HOST_64BIT
	return fb_HEX_l( (unsigned long long int)p );
#else
	return fb_HEX_i( (unsigned int)p );
#endif
}

FBCALL FBSTRING *fb_HEXEx_p( const void *p, int digits )
{
#ifdef HOST_64BIT
	return fb_HEXEx_l( (unsigned long long int)p, digits );
#else
	return fb_HEXEx_i( (unsigned int)p, digits );
#endif
}
