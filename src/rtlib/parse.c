/* parse, return a delimited field of a string */

#include "fb.h"

FBCALL FBSTRING *fb_StrParseDelim ( char *src, ssize_t slen, int any, char *t, ssize_t tlen, int dummy, ssize_t n )
{
    FBSTRING *s;
    ssize_t i, x, y, z;
    char *a, *b, *c, *d;
//char buffer [50];
//sprintf (buffer, "in str n: %i", n);                        //hex  %i = integer
//OutputDebugString(buffer);

    if (slen == 0) return &__fb_ctx.null_desc;
    if (tlen == 0)
    {
        b = src;
        i = 1;
        x = slen;
        goto exit5;
    }  

    if (n == 0) return &__fb_ctx.null_desc;
    if (n > 0)
    { 
//***********************************************************************************************
// foreward parsing
//***********************************************************************************************
        a = src;
        z = 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            for (x = 0; x < slen; x++)
            {
                if (n == z) goto exit3;

                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        z = z + 1;
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
                if (n == z) goto exit3;

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
                    z = z + 1;
                    a = a + tlen - 1;
                }
exit2:
                a++;
            } 
        }

exit3:
        if (n > z) return &__fb_ctx.null_desc;            //n outside
        
        b = a;
        i = x + 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            for (x = x; x < slen; x++)
            {
                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        goto exit5;
                    }    
                    d++;
                }  
                a++;
            } 
        }
        else
        {  
            for (x = x; x < slen - tlen + 1; x++)
            {
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit4;
                        c++;
                        d++;
                    }  
                    goto exit5;
                }
exit4:
                a++;
            } 
        }
    }
    else
    {
//***********************************************************************************************
// reverse parsing
//***********************************************************************************************
        n = n * -1;
        z = 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            a = src + slen - 1;

            for (x = slen - 1; x >= 0; x--)
            {
                if (n == z) goto exit13;

                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        z = z + 1;
                        goto exit11;
                    }    
                    d++;
                }  
exit11:
                a--;
            } 
        }
        else
        {  
            a = src + slen - tlen;

            for (x = slen - tlen; x >= 0; x--)
            {
                if (n == z) goto exit13;
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit12;
                        c++;
                        d++;
                    }  
                    z = z + 1;
                }
exit12:
                a--;
            } 
        }

exit13:
        if (n > z) return &__fb_ctx.null_desc;        //n outside
        if (n == 1) x = slen - 1;

        b = a;
        i = x;

        if (any == 0x414E59)                          //"any" prefixed
        {
            for (x = x; x >= 0; x--)
            {
                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        b = a + 1;
                        z = i;                        //swap i and x
                        i = x + 1;
                        x = z;
                        goto exit5;              
                    }    
                    d++;
                }  
                a--;
            } 
        }
        else
        {  
            for (x = x; x >= 0; x--)
            {
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit14;
                        c++;
                        d++;
                    }  
                    b = a + tlen;
                    z = i;                            //swap i and x
                    i = x + tlen;
                    x = z;
                    goto exit5;
                }
exit14:
                a--;
            } 
        }

        z = i;                            //swap i and x
        i = x + 1;
        x = z;
        b = src;
    }  

exit5:
    s = fb_hStrAllocTemp( NULL, x - i + 1);
    if( s == NULL )
        return &__fb_ctx.null_desc;


    FB_MEMCPYX( s->data, b, x - i + 1 );
    s->data[x - i + 1] = '\0';
    fb_hStrSetLength( s, x - i + 1 );
    return s;  
}

FBCALL FB_WCHAR *fb_WstrParseDelim ( FB_WCHAR *src, ssize_t *len, int any, FB_WCHAR *t, ssize_t tlen, int dummy, ssize_t n )
{
    FB_WCHAR *w;
    ssize_t i, x, y, z, slen = *len;
    FB_WCHAR *a, *b, *c, *d;

    if (slen == 0) return NULL;
    if (tlen == 0)
    {
        b = src;
        i = 1;
        x = slen;
        goto exit5;
    }  

    if (n == 0) return NULL;
    if (n > 0)
    { 
//***********************************************************************************************
// foreward parsing
//***********************************************************************************************
        a = src;
        z = 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            for (x = 0; x < slen; x++)
            {
                if (n == z) goto exit3;

                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        z = z + 1;
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
                if (n == z) goto exit3;

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
                    z = z + 1;
                    a = a + tlen - 1;
                }
exit2:
                a++;
            } 
        }

exit3:
        if (n > z) return NULL;
        
        b = a;
        i = x + 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            for (x = x; x < slen; x++)
            {
                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        goto exit5;
                    }    
                    d++;
                }  
                a++;
            } 
        }
        else
        {  
            for (x = x; x < slen - tlen + 1; x++)
            {
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit4;
                        c++;
                        d++;
                    }  
                    goto exit5;
                }
exit4:
                a++;
            } 
        }
    }
    else
    {
//***********************************************************************************************
// reverse parsing
//***********************************************************************************************
        n = n * -1;
        z = 1;

        if (any == 0x414E59)                              //"any" prefixed
        {
            a = src + slen - 1;

            for (x = slen - 1; x >= 0; x--)
            {
                if (n == z) goto exit13;

                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        z = z + 1;
                        goto exit11;
                    }    
                    d++;
                }  
exit11:
                a--;
            } 
        }
        else
        {  
            a = src + slen - tlen;

            for (x = slen - tlen; x >= 0; x--)
            {
                if (n == z) goto exit13;
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit12;
                        c++;
                        d++;
                    }  
                    z = z + 1;
                }
exit12:
                a--;
            } 
        }

exit13:
        if (n > z) return NULL;
        if (n == 1) x = slen - 1;

        b = a;
        i = x;

        if (any == 0x414E59)                          //"any" prefixed
        {
            for (x = x; x >= 0; x--)
            {
                d = t;

                for (y = 0; y < tlen; y++)
                {
                    if (*a == *d)
                    {
                        b = a + 1;
                        z = i;                        //swap i and x
                        i = x + 1;
                        x = z;
                        goto exit5;              
                    }    
                    d++;
                }  
                a--;
            } 
        }
        else
        {  
            for (x = x; x >= 0; x--)
            {
                if (*a == *t)
                {
                    c = a + 1;
                    d = t + 1;

                    for (y = 1; y < tlen; y++)
                    {
                        if (*c != *d) goto exit14;
                        c++;
                        d++;
                    }  
                    b = a + tlen;
                    z = i;                            //swap i and x
                    i = x + tlen;
                    x = z;
                    goto exit5;
                }
exit14:
                a--;
            } 
        }

        z = i;                            //swap i and x
        i = x + 1;
        x = z;
        b = src;
    }  


exit5:

    w = fb_wstr_AllocTemp( x - i + 1 );
    if( w == NULL )
        return NULL;

    fb_wstr_Move( w, b, x - i + 1);
    w[x - i + 1] = _LC('\0');
    *len = x - i + 1;
    return w;
}

FBCALL FBSTRING *fb_StrParse ( char *src, ssize_t slen, int dummy, ssize_t n )
{
    char comma [2];
    comma[0] = ',';
    comma[1] = '\0';
    return fb_StrParseDelim ( src, slen, 0, comma, 1, 0, n );
}

FBCALL FB_WCHAR *fb_WstrParse ( FB_WCHAR *src, ssize_t *slen, int dummy, ssize_t n )
{
    FB_WCHAR comma [2];
    comma[0] = _LC(',');
    comma[1] = _LC('\0');
    return fb_WstrParseDelim ( src, slen, 0, comma, 1, 0, n);
}
