/* environ$ function and setenviron stmt (wide string) */

#include "fb.h"

FBCALL FB_WCHAR *fb_GetEnviron_W ( FB_WCHAR *varname )
{
#if defined( HOST_WIN32 )                             //restrict to Windows
	FB_WCHAR	*dst;
	FB_WCHAR	*tmp;
	ssize_t len;

	if ( fb_wstr_Len(varname) != 0)
    {
		tmp = _wgetenv( varname );
    } 
	else
    {
	    return NULL;
    }
    
    len = fb_wstr_Len( tmp ) + 1;
    dst = fb_wstr_AllocTemp( len );                   

    if( dst != NULL )
    {
        memcpy(dst, tmp, len*sizeof(FB_WCHAR));
        dst[len] = 0;
    }
    else
    {  
        return NULL;
    }
    
    return dst;
#else
    return NULL;
#endif
}

FBCALL int fb_SetEnviron_W ( FB_WCHAR *wstr )
{
	int res = 0;

	if ( fb_wstr_Len(wstr) != 0 )
	{
#if defined( HOST_WIN32 )                             //restrict to Windows
		res = _wputenv( wstr );
#else
        char *envname;
        ssize_t bytes;
        size_t envname_length;

        envname_length = fb_wstr_Len( wstr );
        envname = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                                 wstr,
                                 envname_length,
                                 NULL,
                                 &bytes );

        if ( envname != NULL )
        {
          res = putenv( envname );
          free( envname );
        }
#endif
	}

	return res;
}
