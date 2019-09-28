/* Dynamic library loading function (wide string) */

#include "../fb.h"
#include <windows.h>

FBCALL void *fb_DylibLoad_W( FB_WCHAR *library )
{
	void *res = NULL;

	if( fb_wstr_Len(library) != 0 )
    {
		res = LoadLibraryW( library );
    }
    
	return res;
}
