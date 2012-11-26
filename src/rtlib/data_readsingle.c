/* read stmt for single's */

#include "fb.h"

FBCALL void fb_DataReadSingle( float *dst )
{
	FB_LOCK();

	if( __fb_data_ptr ) {
		if( __fb_data_ptr->len == FB_DATATYPE_OFS ) {
			*dst = (float)(unsigned long)__fb_data_ptr->ofs;
		} else if( __fb_data_ptr->len & FB_DATATYPE_WSTR ) {
			*dst = (float)fb_WstrToDouble( __fb_data_ptr->wstr, __fb_data_ptr->len & 0x7FFF );
		} else {
			*dst = (float)fb_hStr2Double( __fb_data_ptr->zstr, __fb_data_ptr->len );
		}
	} else {
		/* no more DATA */
		*dst = 0.0;
	}

	fb_DataNext( );

	FB_UNLOCK();
}
