/* remain, return remainder of a string */

#include "fb.h"

FBCALL FBSTRING *fb_StrRemainStart ( ssize_t n, int dummy, char *src, ssize_t slen, int any, char *i, ssize_t ilen )
{
//    FBSTRING *s;
//    ssize_t x, y, slen, ilen;
//    char *a, *c, *d;
////char buffer [50];
//
//    if( src != NULL )
//        slen = strlen( src );
//    else
//        return &__fb_ctx.null_desc;
//
//    if( i != NULL )
//        ilen = strlen( i );
//    else
//        return &__fb_ctx.null_desc;

    FBSTRING *s;
    ssize_t x, y;
    char *a, *c, *d;

    if (slen == 0) return &__fb_ctx.null_desc;
    if (ilen == 0) return &__fb_ctx.null_desc;

    if (n == 0) return &__fb_ctx.null_desc;
    if (n < 0) n = slen + n + 1;
    if (n < 1) n = 1;
    a = src + n - 1;

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen - n + 1; x++)
        {
            d = i;

            for (y = 0; y < ilen; y++)
            {
                if (*a == *d)
                {
                    x = x + 1;
                    goto exit3;                       //copy the rest from x + 1 to the end
                }    
                d++;
            }  
            a++;
        } 
        return &__fb_ctx.null_desc;
    }
    else
    {  
        for (x = 0; x < slen - ilen - n + 2; x++)
        {
            if (*a == *i)
            {
                c = a + 1;
                d = i + 1;

                for (y = 1; y < ilen; y++)
                {
                    if (*c != *d) goto exit2;
                    c++;
                    d++;
                } 
                x = x + ilen;
                goto exit3;                           //copy the rest from x + ilen to the end
            }
exit2:
            a++;
        } 
        return &__fb_ctx.null_desc;
    }

exit3:
    s = fb_hStrAllocTemp( NULL, slen - x - n + 1);
    if( s == NULL )
        return &__fb_ctx.null_desc;


    FB_MEMCPYX( s->data, src + n - 1 + x, slen - x - n + 1 );
    s->data[slen - x - n + 1] = '\0';
    return s;
}

FBCALL FB_WCHAR *fb_WstrRemainStart ( ssize_t n, int dummy, FB_WCHAR *src, ssize_t *len, int any, FB_WCHAR *i, ssize_t ilen )
{
//    FB_WCHAR *w;
//    ssize_t x, y, slen, ilen;
//    FB_WCHAR *a, *c, *d;
//
//    if( src != NULL )
//        slen = fb_wstr_Len( src );
//    else
//        return NULL;
//
//    if( i != NULL )
//        ilen = fb_wstr_Len( i );
//    else
//        return NULL;

    FB_WCHAR *w;
    ssize_t x, y, slen = *len;
    FB_WCHAR *a, *c, *d;

    if (slen == 0) return NULL;
    if (ilen == 0) return NULL;


    if (n == 0) return 0;
    if (n < 0) n = slen + n + 1;
    if (n < 1) n = 1;
    a = src + n - 1;

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen - n + 1; x++)
        {
            d = i;

            for (y = 0; y < ilen; y++)
            {
                if (*a == *d)
                {
                    x = x + 1;
                    goto exit3;                       //copy the rest from x + 1 to the end
                }    
                d++;
            }  
            a++;
        } 
        return NULL;
    }
    else
    {  
        for (x = 0; x < slen - ilen - n + 2; x++)
        {
            if (*a == *i)
            {
                c = a + 1;
                d = i + 1;

                for (y = 1; y < ilen; y++)
                {
                    if (*c != *d) goto exit2;
                    c++;
                    d++;
                } 
                x = x + ilen;
                goto exit3;                           //copy the rest from x + ilen to the end
            }
exit2:
            a++;
        } 
        return NULL;
    }

exit3:
    w = fb_wstr_AllocTemp( slen - x - n + 1 );
    if( w == NULL )
        return NULL;

    fb_wstr_Move( w, src + n - 1 + x, slen - x - n + 1 );
    w[slen - x - n + 1] = _LC('\0');
    *len = slen - x - n + 1;
    return w;
}

FBCALL FBSTRING *fb_StrRemain ( char *src, ssize_t slen, int any, char *i, ssize_t ilen )
{
    return fb_StrRemainStart ( 1, 0, src, slen, any, i, ilen );
}

FBCALL FB_WCHAR *fb_WstrRemain ( FB_WCHAR *src, ssize_t *slen, int any, FB_WCHAR *i, ssize_t ilen )
{
    return fb_WstrRemainStart ( 1, 0, src, slen, any, i, ilen );
}
