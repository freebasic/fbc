/* repeat, return a string concatenated n times */

#include "fb.h"

FBCALL FBSTRING *fb_StrRepeat ( ssize_t n, char *src, ssize_t slen )
{
    FBSTRING *s;
    ssize_t x, ulen;

    if (slen == 0) return &__fb_ctx.null_desc;

    ulen = slen * n;
    s = fb_hStrAllocTemp( NULL, ulen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    for (x = 0; x < n; x++)
    {
        FB_MEMCPYX( s->data + x*slen, src, slen );
    }
    s->data[ulen] = '\0';
    return s;
}

FBCALL FB_WCHAR *fb_WstrRepeat ( ssize_t n, FB_WCHAR *src, ssize_t *len )
{
    FB_WCHAR *w;
    ssize_t x, ulen, slen = *len;

    if (slen == 0) return NULL;

    ulen = slen * n;
    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    for (x = 0; x < n; x++)
    {
        fb_wstr_Move( w + x*slen, src, slen );
    }
    w[ulen] = _LC('\0');
    *len = ulen;                                      //return length (for ustring)
    return w;
}
