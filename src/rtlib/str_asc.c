/* asc function */

#include "fb.h"

FBCALL unsigned int fb_ASC( FBSTRING *str, ssize_t pos )
{
    unsigned int a;
	ssize_t len;

	if( str == NULL )
		return 0;

	len = FB_STRSIZE( str );
	if( (str->data == NULL) || (len == 0) || (pos <= 0) || (pos > len) )
		a = 0;
	else
		a = (unsigned char)str->data[pos-1];

	/* del if temp */
	fb_hStrDelTemp( str );

	return a;
}
