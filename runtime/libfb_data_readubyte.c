/*
 * data_ubyte.c -- read stmt for ubyte's
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadUByte( unsigned char *dst )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen( );

	if( len == 0 )
		*dst = 0;
	else if( len == FB_DATATYPE_OFS )
		*dst = (unsigned char)(unsigned long)__fb_data_ptr->ofs;
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
        *dst = (unsigned char)fb_WstrToUInt( __fb_data_ptr->wstr, len & 0x7FFF );
	else
        *dst = (unsigned char)fb_hStr2UInt( __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}
