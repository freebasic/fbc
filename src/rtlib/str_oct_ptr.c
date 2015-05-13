/* oct(any ptr) function */

#include "fb.h"

FBCALL FBSTRING *fb_OCT_p( const void *p )
{
#ifdef HOST_64BIT
	return fb_OCT_l( (unsigned long long int)p );
#else
	return fb_OCT_i( (unsigned int)p );
#endif
}

FBCALL FBSTRING *fb_OCTEx_p( const void *p, int digits )
{
#ifdef HOST_64BIT
	return fb_OCTEx_l( (unsigned long long int)p, digits );
#else
	return fb_OCTEx_i( (unsigned int)p, digits );
#endif
}
