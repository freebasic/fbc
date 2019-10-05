/* wstring from string data */

#include "fb.h"
//#include <windows.h>

FBCALL FB_WCHAR *fb_WcharFromStr( char *src )
{
    FB_WCHAR *w;
    ssize_t ulen, slen;

    if( src != NULL )
        slen = strlen( src );
    else
        return NULL;

    ulen = (slen + sizeof(FB_WCHAR) - 1) / sizeof(FB_WCHAR);


//char buffer [50];
//sprintf (buffer, "%X", slen);                        //hex  %i = integer
//OutputDebugString(buffer);
//
//sprintf (buffer, "%X", ulen);                        //hex  %i = integer
//OutputDebugString(buffer);


    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    w[ulen-1] = _LC('\0');
    FB_MEMCPYX( w, src, slen );
    w[ulen] = _LC('\0');
    return w;
}
