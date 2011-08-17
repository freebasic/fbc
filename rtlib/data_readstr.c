/* read stmt for string's */

#include <stdlib.h>
#include "fb.h"

FBCALL void *fb_WstrAssignToA ( void *dst, int dst_chars, FB_WCHAR *src, int fillrem );

/*:::::*/
FBCALL void fb_DataReadStr( void *dst, int dst_size, int fillrem )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == FB_DATATYPE_OFS )
		{ /* !!!WRITEME!!! */ }
	/* wstring? convert.. */
	else if( len & FB_DATATYPE_WSTR )
		fb_WstrAssignToA( dst, dst_size, __fb_data_ptr->wstr, fillrem );
	else
		fb_StrAssign( dst, dst_size, (void *)__fb_data_ptr->zstr, 0, fillrem );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}

