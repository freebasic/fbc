#ifndef __FB_UNICODE__
#define __FB_UNICODE__

#include <stdlib.h>
#include <string.h>

#if defined(TARGET_DOS)
#include "dos/fb_unicode.h"
#elif defined(TARGET_XBOX)
#include "xbox/fb_unicode.h"
#elif defined(TARGET_CYGWIN)
/* dumb cygwin ... */
#include "dos/fb_unicode.h"
#else
#include <wchar.h>
#include <wctype.h>
#define _LC(c) L ## c
#endif

#ifndef FB_WCHAR
#define FB_WCHAR wchar_t
#endif


/*:::::*/
static __inline__ int fb_wstr_CalcDiff( const FB_WCHAR *ini, const FB_WCHAR *end )
{
	return ((int)end - (int)ini) / sizeof( FB_WCHAR );
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_AllocTemp( int chars )
{
	/* plus the null-term */
	return (FB_WCHAR *)malloc( (chars + 1) * sizeof( FB_WCHAR ) );
}

/*:::::*/
static __inline__ void fb_wstr_Del( FB_WCHAR *s )
{
	free( (void *)s );
}

/*:::::*/
static __inline__ int fb_wstr_Len( const FB_WCHAR *s )
{
	/* without the null-term */
	return wcslen( s );
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_ConvFromA( FB_WCHAR *dst, int dst_chars, const char *src )
{
	/* NULL? */
	if( src == NULL )
	{
		*dst = L'\0';
		return dst;
	}

	/* plus the null-term */
	return (FB_WCHAR *)(((char *)dst) +
						mbstowcs( dst, src, (dst_chars + 1) * sizeof( FB_WCHAR ) ));
}

/*:::::*/
static __inline__ size_t fb_wstr_ConvToA( char *dst, int dst_chars, const FB_WCHAR *src )
{
	/* plus the null-term */
	return wcstombs( dst, src, dst_chars + 1 );
}

/*:::::*/
static __inline__ int fb_wstr_IsLower( FB_WCHAR c )
{
	return iswlower( c );
}

/*:::::*/
static __inline__ int fb_wstr_IsUpper( FB_WCHAR c )
{
	return iswupper( c );
}

/*:::::*/
static __inline__ FB_WCHAR fb_wstr_ToLower( FB_WCHAR c )
{
	return towlower( c );
}

/*:::::*/
static __inline__ FB_WCHAR fb_wstr_ToUpper( FB_WCHAR c )
{
	return towupper( c );
}

/*:::::*/
static __inline__ void fb_wstr_Copy( FB_WCHAR *dst, const FB_WCHAR *src, int chars )
{
    if( (src != NULL) && (chars > 0) )
        dst = FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );

    /* add the null-term */
    *dst = L'\0';
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_Move( FB_WCHAR *dst, const FB_WCHAR *src, int chars )
{
	return FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );
}

/*:::::*/
static __inline__ void fb_wstr_Fill( FB_WCHAR *dst, FB_WCHAR c, int chars )
{
	int i;

	for( i = 0; i < chars; i++ )
		*dst++ = c;

	/* add null-term */
	*dst = L'\0';
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_SkipChar( const FB_WCHAR *s, int chars, FB_WCHAR c )
{
	FB_WCHAR *op, *p;

	if( s == NULL )
		return NULL;

	p = (FB_WCHAR *)s;
	while( chars > 0 )
	{
		op = p;
		if( *p++ != c )
			return op;
		--chars;
	}

    return p;
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_SkipCharRev( const FB_WCHAR *s, int chars, FB_WCHAR c )
{
	const FB_WCHAR *p;

	if( (s == NULL) || (chars <= 0) )
		return (FB_WCHAR *)s;

	p = &s[chars-1];

    /* fixed-len's are filled with null's as in PB, strip them too */
    while( chars > 0 )
    {
		if( (*p != 0) && (*p != c) )
			return (FB_WCHAR *)p;
		--p;
		--chars;
	}

    return (FB_WCHAR *)p;
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_Instr( const FB_WCHAR *s, const FB_WCHAR *patt )
{
	return wcsstr( s, patt );
}

/*:::::*/
static __inline__ int fb_wstr_Compare( const FB_WCHAR *str1, const FB_WCHAR *str2, int chars )
{
	return wcsncmp( str1, str2, chars );
}

#endif /* __FB_UNICODE__ */
