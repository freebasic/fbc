/*
 * data_double.c -- read stmt for double's
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadDouble( double *dst )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == 0 )
		*dst = 0.0;
	else if( len == FB_DATATYPE_OFS )
		*dst = (double)(unsigned long)__fb_data_ptr->ofs;
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
        *dst = (double)fb_WstrToDouble( __fb_data_ptr->wstr, len & 0x7FFF );
	else
        *dst = (double)fb_hStr2Double( __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}

