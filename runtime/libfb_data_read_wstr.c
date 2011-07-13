/*
 * data_wstr.c -- read stmt for wstring's
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadWstr( FB_WCHAR *dst, int dst_size )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == FB_DATATYPE_OFS )
		{ /* !!!WRITEME!!! */ }
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
		fb_WstrAssign( dst, dst_size, __fb_data_ptr->wstr );
	else
		fb_WstrAssignFromA( dst, dst_size, __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}

