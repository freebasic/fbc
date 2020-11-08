/* unicode to ascii string convertion function */

#include "fb.h"

/* dst_chars == room in dst buffer without null terminator. Thus, the dst buffer
   must be at least dst_chars+1 bytes.
   src must be null-terminated.
   result = number of chars written, excluding null terminator that is always written */
ssize_t fb_wstr_ConvToA(char *dst, ssize_t dst_chars, const FB_WCHAR *src)
{
	if (src == NULL) {
		*dst = '\0';
		return 0;
	}

#if defined HOST_DOS
	ssize_t chars = strlen(src);
	if (chars > dst_chars)
		chars = dst_chars;

	memcpy(dst, src, chars + 1);
	return chars;
#else
	/* plus the null-term */
	ssize_t chars = wcstombs(dst, src, dst_chars + 1);

	/* worked? */
	if (chars >= 0) {
		/* a null terminator won't be added if there was not
		   enough space, so do it manually (this will cut off the last
		   char, but what can you do) */
		if (chars == (dst_chars + 1)) {
			dst[dst_chars] = '\0';
			return dst_chars - 1;
		}
		return chars;
	}

	/* wcstombs() failed; translate at least ASCII chars
	   and write out '?' for the others */
	char *origdst = dst;
	char *dstlimit = dst + dst_chars;
	while (dst < dstlimit) {
#if defined HOST_WIN32
		UTF_16 c = *src++;
		if (c == 0)
			break;
		if (c > 127) {
			if (c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END)
				src++;
			c = '?';
		}
#else
		UTF_32 c = *src++;
		if (c == 0)
			break;
		if (c > 127)
			c = '?';
#endif
		*dst++ = c;
	}
	*dst = '\0';
	return dst - origdst;
#endif
}

FBCALL FBSTRING *fb_WstrToStr( const FB_WCHAR *src )
{
	FBSTRING *dst;
	ssize_t chars;

    if( src == NULL )
        return &__fb_ctx.null_desc;

#if defined HOST_DOS
    /* on DOS, wcstombs() simply calls memcpy() and won't compute
       length  see fb_unicode.h */
    chars = fb_wstr_Len( src );
#else
    chars = wcstombs( NULL, src, 0 );
#endif
    if( chars == 0 )
        return &__fb_ctx.null_desc;

    dst = fb_hStrAllocTemp( NULL, chars );
    if( dst == NULL )
        return &__fb_ctx.null_desc;

    fb_wstr_ConvToA( dst->data, chars, src );

    return dst;
}
