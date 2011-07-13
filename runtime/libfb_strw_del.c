/*
 * strw_del.c -- wstring deletion function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_WstrDelete ( FB_WCHAR *str )
{
    if( str == NULL )
    	return;

    fb_wstr_Del( str );

}

