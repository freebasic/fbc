/* tally, count how many times t is in src */

#include "fb.h"

FBCALL ssize_t fb_StrTally ( char *src, ssize_t slen, int any, char *t, ssize_t tlen )
{
    ssize_t n, x, y;
    char *a, *c, *d;

    if (slen == 0) return 0;
    if (tlen == 0) return 0;

    a = src;
    n = 0;

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen; x++)
        {
            d = t;

            for (y = 0; y < tlen; y++)
            {
                if (*a == *d)
                {
                    n = n + 1;
                    goto exit1;
                }    
                d++;
            }  
exit1:
            a++;
        } 
    }
    else
    {  
        for (x = 0; x < slen - tlen + 1; x++)
        {
            if (*a == *t)
            {
                c = a + 1;
                d = t + 1;

                for (y = 1; y < tlen; y++)
                {
                    if (*c != *d) goto exit2;
                    c++;
                    d++;
                }  
                n = n + 1;
                a = a + tlen - 1;
            }
exit2:
            a++;
        } 
    }

    return n;
}

FBCALL ssize_t fb_WstrTally ( FB_WCHAR *src, ssize_t slen, int any, FB_WCHAR *t, ssize_t tlen )
{
    ssize_t n, x, y;
    FB_WCHAR *a, *c, *d;

    if (slen == 0) return 0;
    if (tlen == 0) return 0;

    a = src;
    n = 0;

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen; x++)
        {
            d = t;

            for (y = 0; y < tlen; y++)
            {
                if (*a == *d)
                {
                    n = n + 1;
                    goto exit1;
                }    
                d++;
            }  
exit1:
            a++;
        } 
    }
    else
    {  
        for (x = 0; x < slen - tlen + 1; x++)
        {
            if (*a == *t)
            {
                c = a + 1;
                d = t + 1;

                for (y = 1; y < tlen; y++)
                {
                    if (*c != *d) goto exit2;
                    c++;
                    d++;
                }  
                n = n + 1;
                a = a + tlen - 1;
            }
exit2:
            a++;
        } 
    }

    return n;
}
