/* read stmt for ulong integer's */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadULongint( unsigned long long *dst )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == 0 )
		*dst = 0;
	else if( len == FB_DATATYPE_OFS )
		*dst = (unsigned long long)(unsigned long)__fb_data_ptr->ofs;
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
        *dst = (unsigned long long)fb_WstrToULongint( __fb_data_ptr->wstr, len & 0x7FFF );
	else
        *dst = (unsigned long long)fb_hStr2ULongint( __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}
