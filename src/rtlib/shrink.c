/* shrink, normalize delimiter(s) in a string */
                             
#include "fb.h"

FBCALL FBSTRING *fb_StrShrinkDelim ( char *src, char *t )
{
    FBSTRING *s;
    ssize_t x, y, z, slen, tlen;
    char *a, *b, *c, *d;
    char space [] = " ";

    if( src != NULL )
        slen = strlen( src );
    else
        return &__fb_ctx.null_desc;
    
    if( t != NULL )
        tlen = strlen( t );
    else
    {
        b = space;
        d = b;                                        //delimiter = first char
        tlen = 1;
        goto skip1;
    }  

    if (tlen == 0)
    {
        b = space;
        d = b;                                        //delimiter = first char
        tlen = 1;
    }  
    else
    {
        b = t;
        d = b;
    }

skip1:
    s = fb_hStrAllocTemp( NULL, slen);
    if( s == NULL )
        return &__fb_ctx.null_desc;

    a = src;

    // remove leading delimiter(s)
    for (x = 0; x < slen; x++)                        //skip leading delimiter(s)
    {
        b = d;
        
        for (y = 0; y < tlen; y++)
        {
            if (*a == *b)
            {
                goto skip22;
            }
            b++;
        }  
        goto skip33;
skip22:
        a++;
    } 

    // remove trailing delimiter(s)
skip33:
    if (x == slen) return &__fb_ctx.null_desc;
    
    c = src + slen - 1;

    for (z = slen - 1; z >= 0; z--)                   //skip trailing delimiter(s)
    {
        b = d;
        
        for (y = 0; y < tlen; y++)
        {
            if (*c == *b)
            {
                goto skip52;
            }
            b++;
        }  
        goto skip53;
skip52:
        c--;
    } 

    // normalize delimiter(s) inside
skip53:

    if (z < 0) return &__fb_ctx.null_desc;

    c = s->data;

    for (x = x; x <= z; x++)                          //copy string
    {
        b = d;

        for (y = 0; y < tlen; y++)                    //compare to delimiter(s)
        {
            if (*a == *b)                             //found one
            {
                *c = *d;
                c++;

                a++;
                x++;

                while (x < slen)                      //loop until no match or end of string
                {
                    b = d;
                    
                    for (y = 0; y < tlen; y++)
                    {
                        if (*a == *b)
                        {
                            goto skip2;
                        }
                        b++;
                    }  
                    x--;
                    goto skip3;                       //no match
skip2:
                    a++;
                    x++;
                } 

                goto skip4;                     
            }
            b++;
        }  

        *c = *a;
        a++;
        c++;
skip3:;
    }   


skip4:
    *c = '\0';
    s->len = c - s->data;   
    return s;  
}

FBCALL FB_WCHAR *fb_WstrShrinkDelim ( FB_WCHAR *src, FB_WCHAR *t )
{
    FB_WCHAR *w;
    ssize_t x, y, z, slen, tlen;
    FB_WCHAR *a, *b, *c, *d;
    FB_WCHAR space [] = _LC(" ");

    if( src != NULL )
        slen = fb_wstr_Len( src );
    else
        return NULL;
    
    if( t != NULL )
        tlen = fb_wstr_Len( t );
    else
    {
        b = space;
        d = b;                                        //delimiter = first char
        tlen = 1;
        goto skip1;
    }  

    if (tlen == 0)
    {
        b = space;
        d = b;                                        //delimiter = first char
        tlen = 1;
    }  
    else
    {
        b = t;
        d = b;
    }

skip1:
    w = fb_wstr_AllocTemp( slen );
    if( w == NULL )
        return NULL;

    a = src;

    // remove leading delimiter(s)
    for (x = 0; x < slen; x++)              
    {
        b = d;
        
        for (y = 0; y < tlen; y++)
        {
            if (*a == *b)
            {
                goto skip22;
            }
            b++;
        }  
        goto skip33;
skip22:
        a++;
    } 

    // remove trailing delimiter(s)
skip33:
    if (x == slen) return NULL;
    
    c = src + slen - 1;
    
    for (z = slen - 1; z >= 0; z--)
    {
        b = d;
        
        for (y = 0; y < tlen; y++)
        {
            if (*c == *b)
            {
                goto skip52;
            }
            b++;
        }  
        goto skip53;
skip52:
        c--;
    } 

    // normalize delimiter(s) inside
skip53:

    if (z < 0) return NULL;

    c = w;

    for (x = x; x <= z; x++)                          //copy string
    {
        b = d;

        for (y = 0; y < tlen; y++)                    //compare to delimiter(s)
        {
            if (*a == *b)                             //found one
            {
                *c = *d;
                c++;

                a++;
                x++;

                while (x < slen)                      //loop until no match or end of string
                {
                    b = d;
                    
                    for (y = 0; y < tlen; y++)
                    {
                        if (*a == *b)
                        {
                            goto skip2;
                        }
                        b++;
                    }  
                    x--;
                    goto skip3;                       //no match
skip2:
                    a++;
                    x++;
                } 

                goto skip4;                     
            }
            b++;
        }  

        *c = *a;
        a++;
        c++;
skip3:;
    }   


skip4:
    *c = _LC('\0');
    return w;
}

FBCALL FBSTRING *fb_StrShrink ( char *src )
{
    char space [] = " ";
    return fb_StrShrinkDelim ( src, space );
}

FBCALL FB_WCHAR *fb_WstrShrink ( FB_WCHAR *src )
{
    FB_WCHAR space [] = _LC(" ");
    return fb_WstrShrinkDelim ( src, space );
}
