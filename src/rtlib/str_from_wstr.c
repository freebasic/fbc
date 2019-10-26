/* string data from wstring */

#include "fb.h"

FBCALL FBSTRING *fb_StrFromWchar( FB_WCHAR *src, ssize_t ulen )
{
    FBSTRING *s;
    ssize_t slen;

    if (ulen == 0) return &__fb_ctx.null_desc;

    slen = ulen * sizeof(FB_WCHAR);
    s = fb_hStrAllocTemp( NULL, slen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    FB_MEMCPYX( s->data, src, slen );
    s->data[slen] = '\0';
    return s;
}
