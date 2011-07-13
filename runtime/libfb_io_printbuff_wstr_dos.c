/*
 * io_printbuff_wstr.c -- low-level print to console function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_con.h"

/*:::::*/
void fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask )
{
    /* !!!FIXME!!! no support for unicode output */

    char *temp = alloca( len + 1 );

    if( len > 0 )
    	fb_wstr_ConvToA( temp, buffer, len );
    else
    	*temp = '\0';

    fb_ConsolePrintBufferEx( temp, len, mask );
}

/*:::::*/
void fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask )
{
	fb_ConsolePrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );
}
