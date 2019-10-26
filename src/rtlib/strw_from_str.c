/* wstring from string data */

#include "fb.h"

FBCALL FB_WCHAR *fb_WcharFromStr( char *src, ssize_t *len )
{
    FB_WCHAR *w;
    ssize_t ulen, slen = *len;

    if (slen == 0) return NULL;

    ulen = (slen + sizeof(FB_WCHAR) - 1) / sizeof(FB_WCHAR);
    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    w[ulen-1] = _LC('\0');                            //in case ulen is odd, fill remaining byte with 0
    FB_MEMCPYX( w, src, slen );
    w[ulen] = _LC('\0');
    *len = ulen;                                      //return length (for ustring)
    return w;
}
