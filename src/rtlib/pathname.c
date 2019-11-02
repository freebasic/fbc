/* pathname */

#include "fb.h"

FBCALL FBSTRING *fb_StrPath_path ( char *src )
{
    FBSTRING *s;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

    x = slen;
    for (x = slen; x > 0; x--)
    {
        if (( src[x] == ':') || ( src[x] == '\\') || ( src[x] == '/')) break;
    }  

    if ( x <= 0 ) return &__fb_ctx.null_desc;

    ulen = x + 1;
    s = fb_hStrAllocTemp( NULL, ulen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    FB_MEMCPYX( s->data, src, ulen );
    s->data[ulen] = '\0';
    fb_hStrSetLength( s, ulen );
    return s;
}

FBCALL FB_WCHAR *fb_WstrPath_path ( FB_WCHAR *src )
{
    FB_WCHAR *w;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;

    x = slen;
    for (x = slen; x > 0; x--)
    {
        if (( src[x] == _LC(':')) || ( src[x] == _LC('\\')) || ( src[x] == _LC('/'))) break;
    }  

    if ( x <= 0 ) return NULL;

    ulen = x + 1;
    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    FB_MEMCPYX( w, src, ulen * sizeof(FB_WCHAR));
    w[ulen] = _LC('\0');
    return w;
}

FBCALL FBSTRING *fb_StrPath_name ( char *src )
{
    FBSTRING *s;
    ssize_t x, y, ulen, slen;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

    for (x = slen; x >= 0; x--)
    {
        if (( src[x] == ':') || ( src[x] == '\\') || ( src[x] == '/')) break;
    }  

    for (y = slen; y > x; y--)
    {
        if ( src[y] == _LC('.')) break;
    }  

    if (y > x)
    {
        ulen = y - x - 1;
    }
    else
    {
        ulen = slen - x - 1;
    }  

    s = fb_hStrAllocTemp( NULL, ulen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    FB_MEMCPYX( s->data, src + x + 1, ulen );
    s->data[ulen] = '\0';
    fb_hStrSetLength( s, ulen );
    return s;
}

FBCALL FB_WCHAR *fb_WstrPath_name ( FB_WCHAR *src )
{
    FB_WCHAR *w;
    ssize_t x, y, ulen, slen;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;

    for (x = slen; x >= 0; x--)
    {
        if (( src[x] == ':') || ( src[x] == '\\') || ( src[x] == '/')) break;
    }  

    for (y = slen; y > x; y--)
    {
        if ( src[y] == _LC('.')) break;
    }  

    if (y > x)
    {
        ulen = y - x - 1;
    }
    else
    {
        ulen = slen - x - 1;
    }  

    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    FB_MEMCPYX( w, src + x + 1, ulen * sizeof(FB_WCHAR));
    w[ulen] = _LC('\0');
    return w;
}

FBCALL FBSTRING *fb_StrPath_namex ( char *src )
{
    FBSTRING *s;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

    for (x = slen; x >= 0; x--)
    {
        if (( src[x] == _LC(':')) || ( src[x] == _LC('\\')) || ( src[x] == _LC('/'))) break;
    }  

    ulen = slen - x - 1;
    s = fb_hStrAllocTemp( NULL, ulen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    FB_MEMCPYX( s->data, src + x + 1, ulen );
    s->data[ulen] = '\0';
    fb_hStrSetLength( s, ulen );
    return s;
}

FBCALL FB_WCHAR *fb_WstrPath_namex ( FB_WCHAR *src )
{
    FB_WCHAR *w;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;

    for (x = slen; x >= 0; x--)
    {
        if (( src[x] == _LC(':')) || ( src[x] == _LC('\\')) || ( src[x] == _LC('/'))) break;
    }  

    ulen = slen - x - 1;
    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    FB_MEMCPYX( w, src + x + 1, ulen * sizeof(FB_WCHAR));
    w[ulen] = _LC('\0');
    return w;
}

FBCALL FBSTRING *fb_StrPath_extn ( char *src )
{
    FBSTRING *s;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

//    x = slen;
    for (x = slen; x >= 0; x--)
    {
        if ( src[x] == _LC('.')) break;
        if (( src[x] == ':') || ( src[x] == '\\') || ( src[x] == '/')) return &__fb_ctx.null_desc;
    }  

    if ( x < 0 ) return &__fb_ctx.null_desc;

    ulen = slen - x;
    s = fb_hStrAllocTemp( NULL, ulen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    FB_MEMCPYX( s->data, src + x, ulen );
    s->data[ulen] = '\0';
    fb_hStrSetLength( s, ulen );
    return s;
}

FBCALL FB_WCHAR *fb_WstrPath_extn ( FB_WCHAR *src )
{
    FB_WCHAR *w;
    ssize_t x, ulen, slen;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;

    for (x = slen; x >= 0; x--)
    {
        if ( src[x] == _LC('.')) break;
        if (( src[x] == _LC(':')) || ( src[x] == _LC('\\')) || ( src[x] == _LC('/'))) return NULL;
    }  

    if ( x < 0 ) return NULL;

    ulen = slen - x;
    w = fb_wstr_AllocTemp( ulen );
    if( w == NULL )
        return NULL;

    FB_MEMCPYX( w, src + x, ulen * sizeof(FB_WCHAR));
    w[ulen] = _LC('\0');
    return w;
}
