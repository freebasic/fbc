/* ascii to unicode string convertion function */

#include "fb.h"

#if !defined( HOST_DOS )

static ssize_t fb_wstr_ConvFromA_nomultibyte(FB_WCHAR *dst, ssize_t dst_chars, const char *src)
{
	/* mbstowcs() must have failed; translate at least ASCII chars
	   and write out '?' for the others */
	FB_WCHAR *origdst = dst;
	FB_WCHAR *dstlimit = dst + dst_chars;
	while (dst < dstlimit) {
		unsigned char c = *src++;
		if (c == 0)
			break;
		if (c > 127)
			c = '?';
		*dst++ = c;
	}
	*dst = _LC('\0');
	return dst - origdst;
}

#endif

/* dst_chars == room in dst buffer without null terminator. Thus, the dst buffer
   must be at least (dst_chars + 1) * sizeof(FB_WCHAR).
   src must be null-terminated.
   result = number of chars written, excluding null terminator that is always written */
ssize_t fb_wstr_ConvFromA(FB_WCHAR *dst, ssize_t dst_chars, const char *src)
{
	if (src == NULL) {
		*dst = _LC('\0');
		return 0;
	}

#if defined HOST_DOS
	ssize_t chars = strlen(src);
	if (chars > dst_chars)
		chars = dst_chars;

	memcpy(dst, src, chars + 1);
	return chars;
#else
	/* plus the null-term (note: "n" in chars, not bytes!) */
	ssize_t chars = mbstowcs(dst, src, dst_chars + 1);

	/* worked? */
	if (chars >= 0) {
		/* a null terminator won't be added if there was not
		   enough space, so do it manually (this will cut off the last
		   char, but what can you do) */
		if (chars == (dst_chars + 1)) {
			dst[dst_chars] = _LC('\0');
			return dst_chars - 1;
		}
		return chars;
	}

	/* mbstowcs() failed?; translate at least ASCII chars
	** and write out '?' for the others
	*/
	return fb_wstr_ConvFromA_nomultibyte( dst, dst_chars, src );

#endif
}

FBCALL FB_WCHAR *fb_StrToWstr( const char *src )
{
	FB_WCHAR *dst;
	ssize_t chars;

	if( src == NULL )
		return NULL;

#if defined HOST_DOS
	/* on DOS, mbstowcs() simply calls memcpy() and won't compute
	length  see fb_unicode.h */
	chars = strlen( src );
#else
	chars = mbstowcs( NULL, src, 0 );

	/* invalid multibyte characters? get the plain old NUL terminated 
	** string length and allocate a buffer for at least the ASCII chars 
	*/
	if( chars < 0 ) {
		chars = strlen( src );
		dst = fb_wstr_AllocTemp( chars );
		if( dst == NULL ) {
			return NULL;
		}
		/* don't bother calling fb_wstr_ConvFromA() it will just call the trivial conversion anyway */
		fb_wstr_ConvFromA_nomultibyte( dst, chars, src );
		return dst;
	}

#endif
	if( chars == 0 )
		return NULL;

	dst = fb_wstr_AllocTemp( chars );
	if( dst == NULL ) {
		return NULL;
	}

	fb_wstr_ConvFromA( dst, chars, src );

	return dst;
}
