/* wstring allocation function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrAlloc( ssize_t chars )
{
	if( chars <= 0 )
		return NULL;

	return fb_wstr_AllocTemp( chars );
}
