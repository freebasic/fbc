/* wstring length function */

#include "fb.h"

FBCALL ssize_t fb_WstrLen( FB_WCHAR *str )
{
	if( str == NULL )
		return 0;

	return fb_wstr_Len( str );
}
