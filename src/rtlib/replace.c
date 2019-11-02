/* replace, replace one string with another one in a string */
                             
#include "fb.h"
//#include <windows.h>

FBCALL FBSTRING *fb_StrReplace ( char *src, ssize_t slen, int any, char *t, ssize_t tlen, char *r, ssize_t rlen )
{                            
    FBSTRING *s;
    ssize_t n, x, y;
    ssize_t *p;
    char *a, *c, *d;

//char buffer [50];
//sprintf (buffer, "in strreplace");
//OutputDebugString(buffer);

    if (slen == 0) return &__fb_ctx.null_desc;
    if (tlen == 0)
    {
exit0:;
        s = fb_hStrAllocTemp( NULL, slen);
        if( s == NULL )
            return &__fb_ctx.null_desc;

        FB_MEMCPYX( s->data, src, slen);
        s->data[slen] = '\0';
        fb_hStrSetLength( s, slen );
        return s;
    }

    // 1. pass: spot characters (either single char or "as string") to replace and store position
    p = malloc((slen + 1) * sizeof(ssize_t));
    a = src;
    n = 0;
    p[n] = 0;
    
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
                    p[n] = x;
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
                p[n] = x;
                x = x + tlen - 1;
                a = a + tlen - 1;
            }
exit2:
            a++;
        } 
    }

    if (n == 0) goto exit0;                           //not found return original string
    p[n+1] = slen;

    // 2. pass: copy original + replacement in position, 

    if (any == 0x414E59)                              //"any" prefixed
    {
        s = fb_hStrAllocTemp( NULL, slen + n*rlen - n);
        if( s == NULL )
            return &__fb_ctx.null_desc;

        c = s->data;
        if (p[1] > 0)
        {
            c = FB_MEMCPYX( c, src, p[1]);
        }    
        c = FB_MEMCPYX( c, r, rlen);

        for (x = 1; x < n; x++)
        {
            c = FB_MEMCPYX( c, src + p[x] + 1, p[x+1] - p[x] - 1);
            c = FB_MEMCPYX( c, r, rlen);
        }
        c = FB_MEMCPYX( c, src + p[x] + 1, p[x+1] - p[x] - 1);

    }
    else
    {
        s = fb_hStrAllocTemp( NULL, slen + n*rlen - n*tlen + 10000);
        if( s == NULL )
            return &__fb_ctx.null_desc;

        c = s->data;
        if (p[1] > 0)
        {
            c = FB_MEMCPYX( c, src, p[1]);
        }    
        c = FB_MEMCPYX( c, r, rlen);

        for (x = 1; x < n; x++)
        {
            c = FB_MEMCPYX( c, src + p[x] + tlen, p[x+1] - p[x] - tlen);
            c = FB_MEMCPYX( c, r, rlen);
        }
        c = FB_MEMCPYX( c, src + p[x] + tlen, p[x+1] - p[x] - tlen );
    }
      
    *c = '\0';
    free(p);

    fb_hStrSetLength( s, c - s->data );
    return s;  
}

FBCALL FB_WCHAR *fb_WstrReplace( FB_WCHAR *src, ssize_t *len, int any, FB_WCHAR *t, ssize_t tlen, FB_WCHAR *r, ssize_t rlen )
{                              
    FB_WCHAR *w;
    ssize_t n, x, y, slen = *len;
    ssize_t *p;
    FB_WCHAR *a, *c, *d;

//char buffer [50];
//sprintf (buffer, "in wstrreplace");
//OutputDebugString(buffer);

    if (slen == 0) return NULL;
    if (tlen == 0)
    {
exit0:   
        w = fb_wstr_AllocTemp( slen );
        if( w == NULL )
            return NULL;

        fb_wstr_Move( w, src, slen );
        w[slen] = _LC('\0');
        *len = slen;
        return w;
    }

    // 1. pass: spot characters (either single char or "as string") to replace and store position
    p = malloc((slen + 1) * sizeof(ssize_t));
    a = src;
    n = 0;
    p[n] = 0;
    
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
                    p[n] = x;
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
                p[n] = x;
                x = x + tlen - 1;
                a = a + tlen - 1;
            }
exit2:
            a++;
        } 
    }

    if (n == 0) goto exit0;                           //not found return original string
    p[n+1] = slen;

    // 2. pass: copy original + replacement in position, 

    if (any == 0x414E59)                              //"any" prefixed
    {
        w = fb_wstr_AllocTemp( slen + n*rlen - n );
        if( w == NULL )
            return NULL;

        c = w;
        if (p[1] > 0)
        {
            c = fb_wstr_Move( c, src, p[1]);
        }    
        c = fb_wstr_Move( c, r, rlen);

        for (x = 1; x < n; x++)
        {
            c = fb_wstr_Move( c, src + p[x] + 1, p[x+1] - p[x] - 1);
            c = fb_wstr_Move( c, r, rlen);
        }
        c = fb_wstr_Move( c, src + p[x] + 1, p[x+1] - p[x] - 1);

    }
    else
    {
        w = fb_wstr_AllocTemp( slen + n*rlen - n*tlen);
        if( w == NULL )
            return NULL;

        c = w;
        if (p[1] > 0)
        {
            c = fb_wstr_Move( c, src, p[1]);
        }    
        c = fb_wstr_Move( c, r, rlen);

        for (x = 1; x < n; x++)
        {
            c = fb_wstr_Move( c, src + p[x] + tlen, p[x+1] - p[x] - tlen );
            c = fb_wstr_Move( c, r, rlen);
        }
        c = fb_wstr_Move( c, src + p[x] + tlen, p[x+1] - p[x] - tlen );
    }

    *c = _LC('\0');
    free(p);

    *len = c - w;
    return w;
}
