/* remove, remove substring from string */
                             
#include "fb.h"
//#include <windows.h>

FBCALL FBSTRING *fb_StrRemove( char *src, ssize_t slen, int any, char *t, ssize_t tlen )
{
    FBSTRING *s;
    ssize_t x, y;
    char *a, *b, *c, *d;

    if (slen == 0) return &__fb_ctx.null_desc;

    s = fb_hStrAllocTemp( NULL, slen);
    if( s == NULL )
        return &__fb_ctx.null_desc;

    a = src;
    c = s->data;

    if (tlen == 0)
    {
        for (x = 0; x < slen; x++)                   
        {
            *c = *a;
            c++;
            a++;
        } 
        goto skip4;
    }


//char buffer [50];
//sprintf (buffer, "slen %i", slen); 
//OutputDebugString(buffer);
//sprintf (buffer, "tlen %i", tlen); 
//OutputDebugString(buffer);
//sprintf (buffer, "c %X", c); 
//OutputDebugString(buffer);
//sprintf (buffer, "s->data %X", s->data); 
//OutputDebugString(buffer);


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
//sprintf (buffer, "check x %i", x); 
//OutputDebugString(buffer);
//sprintf (buffer, "char written check: a %c", *c); 
//OutputDebugString(buffer);



                    a++;
                    b++;
                    c++;
                    x++;

                    if (x >= slen)
                    {
                        if (y == tlen - 1) c = d;
                        goto skip4; 
                    }
                }  
                c = d;
//sprintf (buffer, "found: x %i", x); 
//OutputDebugString(buffer);
//sprintf (buffer, "char: a %c", *a); 
//OutputDebugString(buffer);



                x--;
                goto skip3;
            }
skip2:
            *c = *a;
//sprintf (buffer, "regular x %i", x); 
//OutputDebugString(buffer);
//sprintf (buffer, "char written regular: a %c", *c); 
//OutputDebugString(buffer);
            c++;
            a++;

skip3:;
        } 
    }  

skip4:
    *c = '\0';
    fb_hStrSetLength( s, c - s->data);

//sprintf (buffer, "********** s->len %x", s->len); 
//OutputDebugString(buffer);
//sprintf (buffer, "c %X", c); 
//OutputDebugString(buffer);
//sprintf (buffer, "s->data %X", s->data); 
//OutputDebugString(buffer);

    return s;  
}

FBCALL FB_WCHAR *fb_WstrRemove( FB_WCHAR *src, ssize_t *len, int any, FB_WCHAR *t, ssize_t tlen )
{
    FB_WCHAR *w;
    ssize_t x, y, slen = *len;
    FB_WCHAR *a, *b, *c, *d;

    if (slen == 0) return NULL;
    
    w = fb_wstr_AllocTemp( slen );
    if( w == NULL )
        return NULL;

    a = src;
    c = w;

    if (tlen == 0)
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

                    if (x >= slen)
                    {
                        if (y == tlen - 1) c = d;
                        goto skip4; 
                    }
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
    *len = c - w;
    return w;
}
