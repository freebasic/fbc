/* string deletion function */

#include "fb.h"

/*:::::*/
FBCALL void fb_StrDelete ( FBSTRING *str )
{
    if( (str == NULL) || (str->data == NULL) )
    	return;

    free( (void *)str->data );

	str->data = NULL;
	str->len  = 0;
	str->size = 0;
}
