/* remove, remove substring from string */
                             
#include "fb.h"

FBCALL FBSTRING *fb_StrRemove( char *src, int any, char *t )
{
    FBSTRING *s;
    ssize_t x, y, slen, tlen;
    char *a, *b, *c, *d;

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;

    s = fb_hStrAllocTemp( NULL, slen);
    if( s == NULL )
        return &__fb_ctx.null_desc;

    a = src;
    c = s->data;

    if( t != NULL )
        tlen = strlen( t );
    else
    {
        for (x = 0; x < slen; x++)                   
        {
            *c = *a;
            c++;
            a++;
        } 
        goto skip4;
    }

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen; x++)                   
        {
            b = t;
            
            for (y = 0; y < tlen; y++)
            {
                if (*a == *b)
                {
                    goto skip1;
                }
                b++;
            }  

            *c = *a;
            c++;

skip1:
            a++;
        } 
    } 
    else
    {
        for (x = 0; x < slen; x++)                   
        {
            b = t;
            d = c;
            
            if (tlen > 0)
            {
                for (y = 0; y < tlen; y++)
                {
                    if (*a != *b)
                    {
                        goto skip2;
                    }
                    *c = *a;
                    a++;
                    b++;
                    c++;
                    x++;
                }  
                c = d;
                x--;
                goto skip3;
            }
skip2:
            *c = *a;
            c++;
            a++;

skip3:;
        } 
    }  

skip4:
    *c = '\0';
    s->len = c - s->data;   
    return s;  
}

FBCALL FB_WCHAR *fb_WstrRemove( FB_WCHAR *src, int any, FB_WCHAR *t )
{
    FB_WCHAR *w;
    ssize_t x, y, slen, tlen;
    FB_WCHAR *a, *b, *c, *d;

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;
    
    w = fb_wstr_AllocTemp( slen );
    if( w == NULL )
        return NULL;

    a = src;
    c = w;

    if( t != NULL )
        tlen = fb_wstr_Len( t );
    else
    {
        for (x = 0; x < slen; x++)                   
        {
            *c = *a;
            c++;
            a++;
        } 
        goto skip4;
    }

    if (any == 0x414E59)                              //"any" prefixed
    {
        for (x = 0; x < slen; x++)                   
        {
            b = t;
            
            for (y = 0; y < tlen; y++)
            {
                if (*a == *b)
                {
                    goto skip1;
                }
                b++;
            }  

            *c = *a;
            c++;

skip1:
            a++;
        } 
    } 
    else
    {
        for (x = 0; x < slen; x++)                   
        {
            b = t;
            d = c;
            
            if (tlen > 0)
            {
                for (y = 0; y < tlen; y++)
                {
                    if (*a != *b)
                    {
                        goto skip2;
                    }
                    *c = *a;
                    a++;
                    b++;
                    c++;
                    x++;
                }  
                c = d;
                x--;
                goto skip3;
            }
skip2:
            *c = *a;
            c++;
            a++;

skip3:;
        } 
    }  

skip4:
    *c = _LC('\0');
    return w;
}
