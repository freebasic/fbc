/* read stmt for single's */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadSingle( float *dst )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == 0 )
		*dst = 0.0;
	else if( len == FB_DATATYPE_OFS )
		*dst = (float)(unsigned long)__fb_data_ptr->ofs;
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
        *dst = (float)fb_WstrToDouble( __fb_data_ptr->wstr, len & 0x7FFF );
	else
        *dst = (float)fb_hStr2Double( __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}
