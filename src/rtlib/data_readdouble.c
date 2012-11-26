/* read stmt for double's */

#include "fb.h"

FBCALL void fb_DataReadDouble( double *dst )
{
	FB_LOCK();

	if( __fb_data_ptr ) {
		if( __fb_data_ptr->len == FB_DATATYPE_OFS ) {
			*dst = (double)(unsigned long)__fb_data_ptr->ofs;
		} else if( __fb_data_ptr->len & FB_DATATYPE_WSTR ) {
			*dst = (double)fb_WstrToDouble( __fb_data_ptr->wstr, __fb_data_ptr->len & 0x7FFF );
		} else {
			*dst = (double)fb_hStr2Double( __fb_data_ptr->zstr, __fb_data_ptr->len );
		}
	} else {
		/* no more DATA */
		*dst = 0.0;
	}

	fb_DataNext( );

	FB_UNLOCK();
}
