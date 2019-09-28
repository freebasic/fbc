/* command$ */

#include "fb.h"

#if defined HOST_WIN32                                //windows
#include <windows.h>
#include <shellapi.h>

FBCALL FB_WCHAR *fb_Command_W ( int arg )
{
	FB_WCHAR *dst;
	ssize_t i, len;
    int args;
    LPWSTR *list;
  
  
    list = CommandLineToArgvW(GetCommandLineW(), &args);
    if( list == NULL )
    return NULL;

	/* return all arguments? */
	if( arg < 0 )
 	{
	/* concatenate all args but 0 */
		len = 0;
		for( i = 1; i < args; i++ )
        len += fb_wstr_Len( list[i] );

        dst = fb_wstr_AllocTemp( len + args );                   
        if( dst == NULL )
        {
            LocalFree(list);
            return NULL;
        }

        dst[0] = '\0';

        for( i = 1; i < args; i++ )
        {
            wcscat( dst, list[i] );
            if( i != args-1 )
            wcscat( dst, L" " );
        }

        LocalFree(list);
        return dst;
	}

    /* return just one argument */
    if( arg >= args )
    {
        LocalFree(list);
        return NULL;
    }

    len = fb_wstr_Len( list[arg] ) + 1;
    dst = fb_wstr_AllocTemp( len );                   
    if( dst == NULL )
    {
        LocalFree(list);
        return NULL;
    }

    wcscpy( dst, list[arg] );

    LocalFree(list);
    return dst;
}
#endif
