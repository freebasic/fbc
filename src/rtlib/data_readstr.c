/* read stmt for strings */

#include "fb.h"

FBCALL void fb_DataReadStr( void *dst, ssize_t dst_size, int fillrem )
{
	FB_LOCK();

	if( __fb_data_ptr ) {
		if( __fb_data_ptr->len == FB_DATATYPE_OFS ) {
			/* !!!WRITEME!!! */
		} else if( __fb_data_ptr->len & FB_DATATYPE_WSTR ) {
			fb_WstrAssignToA( dst, dst_size, __fb_data_ptr->wstr, fillrem );
		} else {
			fb_StrAssign( dst, dst_size, __fb_data_ptr->zstr, 0, fillrem );
		}
	} else {
		/* no more DATA, return empty string */
		fb_StrAssign( dst, dst_size, "", 0, fillrem );
	}

	fb_DataNext( );

	FB_UNLOCK();
}
