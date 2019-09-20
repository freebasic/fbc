/* path conversion (wide string) */

#include "fb.h"

void fb_hConvertPath_W( FB_WCHAR *path )
{
    ssize_t i, len;

    DBG_ASSERT( path != NULL );

    len = fb_wstr_Len( path );
    for (i = 0; i < len; i++)
    {
#if defined( HOST_DOS ) || defined( HOST_MINGW ) || defined( HOST_XBOX )
        if( path[i] == L'/' )
            path[i] = L'\\';
#else
        if( path[i] == L'\\' )
            path[i] = L'/';
#endif
    }
}