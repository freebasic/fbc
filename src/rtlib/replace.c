/* replace, replace one string with another one in a string */
                             
#include "fb.h"

FBCALL FBSTRING *fb_StrReplace( char *src, int any, char *t, char *r )
{
    FBSTRING *s;
    ssize_t n, x, y, slen, tlen, rlen;
    ssize_t *p;
    char *a, *c, *d;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

    if( t != NULL )
        tlen = strlen( t );
    else
    {
exit0:
        s = fb_hStrAllocTemp( NULL, slen);
        if( s == NULL )
            return &__fb_ctx.null_desc;

        FB_MEMCPYX( s->data, src, slen);
        s->data[slen] = '\0';
        return s;
    }

    if (tlen == 0)
    {
        goto exit0;
    }

    if( r != NULL )
        rlen = strlen( r );
    else
        rlen = 0;


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
        s = fb_hStrAllocTemp( NULL, slen + n*rlen - n*tlen);
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
            c = FB_MEMCPYX( c, src + p[x] + tlen, p[x+1] - p[x] - tlen );
            c = FB_MEMCPYX( c, r, rlen);
        }
        c = FB_MEMCPYX( c, src + p[x] + tlen, p[x+1] - p[x] - tlen );
    }
      
    *c = '\0';
    free(p);

    return s;  
}

FBCALL FB_WCHAR *fb_WstrReplace( FB_WCHAR *src, int any, FB_WCHAR *t, FB_WCHAR *r )
{
    FB_WCHAR *w;
    ssize_t n, x, y, slen, tlen, rlen;
    ssize_t *p;
    FB_WCHAR *a, *c, *d;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;
    
    if( t != NULL )
        tlen = fb_wstr_Len( t );
    else
    {
exit0:
        w = fb_wstr_AllocTemp( slen );
        if( w == NULL )
            return NULL;

        fb_wstr_Move( w, src, slen );
        w[slen] = _LC('\0');
        return w;
    }

    if (tlen == 0)
    {
        goto exit0;
    }

    if( r != NULL )
        rlen = fb_wstr_Len( r );
    else
        rlen = 0;

//***********************************************************************************************
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

    return w;
}
