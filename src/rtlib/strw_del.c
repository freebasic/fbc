/* wstring deletion function */

#include "fb.h"

FBCALL void fb_WstrDelete ( FB_WCHAR *str )
{
    if( str == NULL )
    	return;

    fb_wstr_Del( str );
}
