/* extract, extract a string from another string */

#include "fb.h"

FBCALL FBSTRING *fb_StrExtractStart ( ssize_t n, int dummy, char *src, ssize_t slen, int any, char *i, ssize_t ilen )
{
    FBSTRING *s;
    ssize_t x, y;
    char *a, *c, *d;

    if (slen == 0) return &__fb_ctx.null_desc;
    if (ilen == 0)
    {
        x = slen;                                     //return all of src
        goto exit3;
    }

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
                    goto exit3;
                }    
                d++;
            }  
            a++;
        } 
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
                goto exit3; 
            }
exit2:
            a++;
        } 
        x = slen;
    }

exit3:
    s = fb_hStrAllocTemp( NULL, x );
    if( s == NULL )
        return &__fb_ctx.null_desc;


    FB_MEMCPYX( s->data, src + n - 1, x );
    s->data[x] = '\0';
    return s;
}

FBCALL FB_WCHAR *fb_WstrExtractStart ( ssize_t n, int dummy, FB_WCHAR *src, ssize_t *len, int any, FB_WCHAR *i, ssize_t ilen )
{
    FB_WCHAR *w;
    ssize_t x, y, slen = *len;
    FB_WCHAR *a, *c, *d;

    if (slen == 0) return NULL;
    if (ilen == 0)
    {
        x = slen;                                     //return all of src
        goto exit3;
    }

    if (n == 0) return NULL;
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
                    goto exit3;
                }    
                d++;
            }  
            a++;
        } 
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
                goto exit3; 
            }
exit2:
            a++;
        } 
        x = slen;
    }

exit3:
    w = fb_wstr_AllocTemp( x );
    if( w == NULL )
        return NULL;

    fb_wstr_Move( w, src + n - 1, x );
    w[x] = _LC('\0');
    *len = x;
    return w;
}

FBCALL FBSTRING *fb_StrExtract ( char *src, ssize_t slen, int any, char *i, ssize_t ilen )
{
    return fb_StrExtractStart ( 1, 0, src, slen, any, i, ilen );
}

FBCALL FB_WCHAR *fb_WstrExtract ( FB_WCHAR *src, ssize_t *slen, int any, FB_WCHAR *i, ssize_t ilen )
{
    return fb_WstrExtractStart ( 1, 0, src, slen, any, i, ilen );
}
