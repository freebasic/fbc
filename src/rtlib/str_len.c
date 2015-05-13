/* string length function */

#include "fb.h"

FBCALL ssize_t fb_StrLen( void *str, ssize_t str_size )
{
	ssize_t len;

	if( str == NULL )
		return 0;

	/* is dst var-len? */
	if( str_size == -1 )
	{
		len = FB_STRSIZE( str );

		/* delete temp? */
		fb_hStrDelTemp( (FBSTRING *)str );
	}
	else
	{
		/* this routine will never be called for fixed-len strings, as
		   their sizes are known at compiler-time, as such, this must be
		   a zstring, so find out the real len (as in C/PB) */
		len = strlen( (char *)str );
	}

	return len;
}
