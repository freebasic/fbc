/*
 * swap_mem.c -- swap f/ non-strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_MemSwap( unsigned char *dst, unsigned char *src, int bytes )
{
	int i;
	unsigned int ti;
	unsigned char tb;

	if( (dst == NULL) || (src == NULL) || (bytes <= 0) )
		return;

	FB_LOCK();
	
	/* words */
	for( i = 0; i < (bytes >> 2); i++ )
	{
		ti = *(unsigned int *)src;
		*(unsigned int *)src = *(unsigned int *)dst;
		*(unsigned int *)dst = ti;

		src += sizeof(unsigned int);
		dst += sizeof(unsigned int);
	}

	/* remainder */
	for( i = 0; i < (bytes & 3); i++ )
	{
		tb = *src;
		*src++ = *dst;
		*dst++ = tb;
	}
	
	FB_UNLOCK();
}




