/* extract, extract a string from another string */

#include "fb.h"

FBCALL FBSTRING *fb_StrExtractStart ( ssize_t n, int dummy, char *src, int any, char *i )
{
    FBSTRING *s;
    ssize_t x, y, slen, ilen;
    char *a, *c, *d;

    if( src != NULL )
        slen = strlen( src );
    else
        return 0;

    if( i != NULL )
        ilen = strlen( i );
    else
    {
        x = slen;                                     //return all of src
        goto exit3;
    }

    if (n < 0) n = slen + n + 1;
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

FBCALL FB_WCHAR *fb_WstrExtractStart ( ssize_t n, int dummy, FB_WCHAR *src, int any, FB_WCHAR *i )
{
    FB_WCHAR *w;
    ssize_t x, y, slen, ilen;
    FB_WCHAR *a, *c, *d;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return 0;

    if( i != NULL )
        ilen = fb_wstr_Len( i );
    else
    {
        x = slen;                                     //return all of src
        goto exit3;
    }

    if (n < 0) n = slen + n + 1;
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
    return w;
}

FBCALL FBSTRING *fb_StrExtract ( char *src, int any, char *i )
{
    return fb_StrExtractStart ( 1, 0, src, any, i );
}

FBCALL FB_WCHAR *fb_WstrExtract ( FB_WCHAR *src, int any, FB_WCHAR *i )
{
    return fb_WstrExtractStart ( 1, 0, src, any, i );
}
