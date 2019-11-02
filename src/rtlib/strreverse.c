/* strreverse, revert character order */

#include "fb.h"

FBCALL FBSTRING *fb_StrInvert ( char *src, ssize_t slen )
{
    FBSTRING *s;
    ssize_t x;

    if (slen == 0) return &__fb_ctx.null_desc;

    s = fb_hStrAllocTemp( NULL, slen );
    if( s == NULL )
        return &__fb_ctx.null_desc;

    s->data[slen] = '\0';
    fb_hStrSetLength( s, slen );
    x = 0;

    for (slen = slen - 1; slen >= 0; slen--)
    {
        s->data[slen] = src[x];
        x++;
    }

    return s;
}

FBCALL FB_WCHAR *fb_WstrInvert ( FB_WCHAR *src, ssize_t slen )
{
    FB_WCHAR *w;
    ssize_t x;

    if (slen == 0) return NULL;

    w = fb_wstr_AllocTemp( slen );
    if( w == NULL )
        return NULL;

    w[slen] = _LC('\0');
    x = 0;

    for (slen = slen - 1; slen >= 0; slen--)
    {
//***********************************************************************************************
// handle surrogate pairs
//***********************************************************************************************
//        if ((src[x] >= 0xD800) && (src[x] <= 0xDBFF))
//        {
//            if ((src[x+1] >= 0xDC00) && (src[x+1] <= 0xDFFF))
//            {
//                w[slen] = src[x+1];
//                slen--;
//                w[slen] = src[x];
//                x++;
//                x++;
//            }
//            else goto copy; 
//        }
//        else
//        {  
//copy:
//            w[slen] = src[x];
//            x++;
//        }
//***********************************************************************************************
        w[slen] = src[x];
        x++;
    }

    return w;
}
