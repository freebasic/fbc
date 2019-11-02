/* insert, insert a string into another string at position n */

#include "fb.h"

FBCALL FBSTRING *fb_StrInsert ( char *src, ssize_t slen, char *i, ssize_t ilen, ssize_t n )
{
    FBSTRING *s;

    if ((slen == 0) && (ilen == 0))
    {
        return &__fb_ctx.null_desc;
    }

    s = fb_hStrAllocTemp( NULL, slen + ilen);
    if( s == NULL )
        return &__fb_ctx.null_desc;

    if (n < 0) n = slen + n + 1;
    if (n < 1) n = 0;
    else if (n > slen) n = slen;
    else n = n - 1;                                   //n is one based, need it zero based here

    FB_MEMCPYX( s->data, src, n );
    FB_MEMCPYX( s->data + n, i, ilen );
    FB_MEMCPYX( s->data + n + ilen, src + n, slen - n );

    s->data[slen + ilen] = '\0';
    fb_hStrSetLength( s, slen + ilen);
    return s;
}

FBCALL FB_WCHAR *fb_WstrInsert ( FB_WCHAR *src, ssize_t *len, FB_WCHAR *i, ssize_t ilen, ssize_t n )
{
    FB_WCHAR *w;
    ssize_t slen = *len;

    if ((slen == 0) && (ilen == 0))
    {
        return NULL;
    }

    w = fb_wstr_AllocTemp( slen + ilen );
    if( w == NULL )
        return NULL;

    if (n < 0) n = slen + n + 1;
    if (n < 1) n = 0;
    else if (n > slen) n = slen;
    else n = n -1;                                    //n is one based, need it zero based here

    fb_wstr_Move( w, src, n );
    fb_wstr_Move( w + n, i, ilen );
    fb_wstr_Move( w + n + ilen, src + n, slen - n );

    w[slen + ilen] = _LC('\0');
    *len = slen + ilen;
    return w;
}
