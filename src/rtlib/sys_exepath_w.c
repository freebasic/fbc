/* exepath$ (wide string) */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

FBCALL FB_WCHAR *fb_ExePath_W ( void )
{
	FB_WCHAR	*dst = 0;
	char	*p;
	ssize_t len;


	FB_WCHAR tmp[MAX_PATH+1];
	p = fb_hGetExePath_W( tmp, MAX_PATH );


	if( p != NULL )
	{
        len = fb_wstr_Len( &tmp[0] ) + 1;
        dst = fb_wstr_AllocTemp( len );                   

        if( dst != NULL )
        {
            memcpy(dst, &tmp[0], len*2);
            dst[len] = 0;
        }
        else
            return NULL;
	}
    else
        return NULL;

  return dst;
}
