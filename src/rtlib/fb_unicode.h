/* Unicode definitions */

typedef uint32_t UTF_32;
typedef uint16_t UTF_16;
typedef uint8_t  UTF_8;

#define UTF8_BYTEMASK            0xBF
#define UTF8_BYTEMARK            0x80

#define UTF16_MAX_BMP            ((UTF_32)0x0000FFFF)
#define UTF16_SUR_HIGH_START     ((UTF_32)0xD800)
#define UTF16_SUR_HIGH_END       ((UTF_32)0xDBFF)
#define UTF16_SUR_LOW_START      ((UTF_32)0xDC00)
#define UTF16_SUR_LOW_END        ((UTF_32)0xDFFF)
#define UTF16_HALFSHIFT          10
#define UTF16_HALFBASE           ((UTF_32)0x0010000UL)
#define UTF16_HALFMASK           ((UTF_32)0x3FFUL)

#if defined HOST_DOS
#	include <ctype.h>
#	define FB_WCHAR char
#	define _LC(c) c
#	define FB_WEOF ((FB_WCHAR)EOF)
#	define wcslen(s) strlen(s)
#	define iswlower(c) islower(c)
#	define iswupper(c) isupper(c)
#	define towlower(c) tolower(c)
#	define towupper(c) toupper(c)
#	define wmemcmp(a,b,c) memcmp(a,b,c)
#	define wmemchr(a,b,c) memchr(a,b,c)
#	define mbstowcs __dos_mbstowcs
#	define wcstombs __dos_wcstombs
#	define wcsstr(str, strSearch) strstr(str, strSearch)
#	define wcsncmp(str1, str2, count) strncmp(str1, str2, count)
#	define wcstod   strtod
#	define wcstol   strtol
#	define wcstoll  strtoll
#	define wcstoul  strtoul
#	define wcstoull strtoull
#	define wcschr   strchr
#	define wcscspn  strcspn
	static __inline__ size_t __dos_mbstowcs(FB_WCHAR *wcstr, const char *mbstr, size_t count)
	{
		return memcpy(wcstr,mbstr,count), count;
	}
	static __inline__ size_t __dos_wcstombs(char *mbstr, const FB_WCHAR *wcstr, size_t count)
	{
		return memcpy(mbstr,wcstr,count), count;
	}
	static __inline__ int swprintf(FB_WCHAR *buffer, size_t n, const FB_WCHAR *format, ...)
	{
		int result;
		va_list ap;
		va_start(ap, format);
		result = vsprintf( buffer, format, ap );
		va_end(ap);
		return result;
	}
#elif defined HOST_MINGW || defined HOST_CYGWIN
#	include <wchar.h>
#	include <wctype.h>
#	define FB_WCHAR wchar_t
#	define _LC(c) L ## c
#	if defined HOST_MINGW
#		define FB_WEOF ((FB_WCHAR)WEOF)
#		define swprintf _snwprintf
#		define FB_WSTR_FROM_INT( buffer, num )        _itow( num, buffer, 10 )
#		define FB_WSTR_FROM_UINT( buffer, num )       _ultow( (unsigned int) num, buffer, 10 )
#		define FB_WSTR_FROM_UINT_OCT( buffer, num )   _itow( num, buffer, 8 )
#		define FB_WSTR_FROM_INT64( buffer, num )      _i64tow( num, buffer, 10 )
#		define FB_WSTR_FROM_UINT64( buffer, num )     _ui64tow( num, buffer, 10 )
#		define FB_WSTR_FROM_UINT64_OCT( buffer, num ) _ui64tow( num, buffer, 8 )
#	else
#		define FB_WEOF ((FB_WCHAR)-1)
#	endif
#else
#	define __USE_ISOC99 1
#	define __USE_ISOC95 1
#	include <wchar.h>
#	include <wctype.h>
#	define FB_WCHAR wchar_t
#	define _LC(c) L ## c
#	define FB_WEOF ((FB_WCHAR)WEOF)
#endif

#ifndef FB_WSTR_FROM_INT
#define FB_WSTR_FROM_INT( buffer, num ) \
    swprintf( buffer, sizeof( int ) * 3 + 1, _LC("%d"), (int) (num) )
#endif

#ifndef FB_WSTR_FROM_UINT
#define FB_WSTR_FROM_UINT( buffer, num ) \
    swprintf( buffer, sizeof( unsigned int ) * 3 + 1, _LC("%u"), (unsigned) (num) )
#endif

#ifndef FB_WSTR_FROM_UINT_OCT
#define FB_WSTR_FROM_UINT_OCT( buffer, num ) \
    swprintf( buffer, sizeof( int ) * 4 + 1, _LC("%o"), (unsigned) (num) )
#endif

#ifndef FB_WSTR_FROM_INT64
#define FB_WSTR_FROM_INT64( buffer, num ) \
    swprintf( buffer, sizeof( long long ) * 3 + 1, _LC("%lld"), (long long) (num) )
#endif

#ifndef FB_WSTR_FROM_UINT64
#define FB_WSTR_FROM_UINT64( buffer, num ) \
    swprintf( buffer, sizeof( unsigned long long ) * 3 + 1, _LC("%llu"), (unsigned long long) (num) )
#endif

#ifndef FB_WSTR_FROM_UINT64_OCT
#define FB_WSTR_FROM_UINT64_OCT( buffer, num ) \
    swprintf( buffer, sizeof( long long ) * 4 + 1, _LC("%llo"), (unsigned long long) (num) )
#endif

#ifndef FB_WSTR_FROM_FLOAT
#define FB_WSTR_FROM_FLOAT( buffer, num ) \
    swprintf( buffer, 7+8 + 1, _LC("%.7g"), (double) (num) )
#endif

#ifndef FB_WSTR_FROM_DOUBLE
#define FB_WSTR_FROM_DOUBLE( buffer, num ) \
    swprintf( buffer, 16+8 + 1, _LC("%.16g"), (double) (num) )
#endif

/* Calculate the number of characters between two pointers. */
static __inline__ ssize_t fb_wstr_CalcDiff( const FB_WCHAR *ini, const FB_WCHAR *end )
{
	return end - ini;
}

static __inline__ FB_WCHAR *fb_wstr_AllocTemp( ssize_t chars )
{
	/* plus the null-term */
	return (FB_WCHAR *)malloc( (chars + 1) * sizeof( FB_WCHAR ) );
}

static __inline__ void fb_wstr_Del( FB_WCHAR *s )
{
	free( (void *)s );
}

/* Return the length of a WSTRING. */
static __inline__ ssize_t fb_wstr_Len( const FB_WCHAR *s )
{
	/* without the null-term */
	return wcslen( s );
}

ssize_t fb_wstr_ConvFromA( FB_WCHAR *dst, ssize_t dst_chars, const char *src );
ssize_t fb_wstr_ConvToA( char *dst, ssize_t dst_chars, const FB_WCHAR *src );

static __inline__ int fb_wstr_IsLower( FB_WCHAR c )
{
	return iswlower( c );
}

static __inline__ int fb_wstr_IsUpper( FB_WCHAR c )
{
	return iswupper( c );
}

static __inline__ FB_WCHAR fb_wstr_ToLower( FB_WCHAR c )
{
	return towlower( c );
}

static __inline__ FB_WCHAR fb_wstr_ToUpper( FB_WCHAR c )
{
	return towupper( c );
}

/* Copy n characters from A to B and terminate with NUL. */
static __inline__ void fb_wstr_Copy( FB_WCHAR *dst, const FB_WCHAR *src, ssize_t chars )
{
	if( (src != NULL) && (chars > 0) )
		dst = (FB_WCHAR *) FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );

	/* add the null-term */
	*dst = _LC('\0');
}

/* Copy n characters from A to B. */
static __inline__ FB_WCHAR *fb_wstr_Move( FB_WCHAR *dst, const FB_WCHAR *src, ssize_t chars )
{
	return (FB_WCHAR *) FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );
}

static __inline__ void fb_wstr_Fill( FB_WCHAR *dst, FB_WCHAR c, ssize_t chars )
{
	ssize_t i;
	for( i = 0; i < chars; i++ )
		*dst++ = c;
	/* add null-term */
	*dst = _LC('\0');
}

/* Skip all characters (c) from the beginning of the string, max 'n' chars. */
static __inline__ const FB_WCHAR *fb_wstr_SkipChar( const FB_WCHAR *s, ssize_t chars, FB_WCHAR c )
{
	if( s == NULL )
		return NULL;

	const FB_WCHAR *p = s;
	while( chars > 0 )
	{
		if( *p != c )
			return p;
		++p;
		--chars;
	}

	return p;
}

/* Skip all characters (c) from the end of the string, max 'n' chars. */
static __inline__ const FB_WCHAR *fb_wstr_SkipCharRev( const FB_WCHAR *s, ssize_t chars, FB_WCHAR c )
{
	if( (s == NULL) || (chars <= 0) )
		return s;

	/* fixed-len's are filled with null's as in PB, strip them too */
	const FB_WCHAR *p = &s[chars];
	while( chars > 0 )
	{
		--p;
		if( *p != c )
			return ++p;
		--chars;
	}

	return p;
}

static __inline__ FB_WCHAR *fb_wstr_Instr( const FB_WCHAR *s, const FB_WCHAR *patt )
{
	return wcsstr( s, patt );
}

static __inline__ size_t fb_wstr_InstrAny( const FB_WCHAR *s, const FB_WCHAR *sset )
{
	return wcscspn( s, sset );
}

static __inline__ int fb_wstr_Compare( const FB_WCHAR *str1, const FB_WCHAR *str2, ssize_t chars )
{
	return wcsncmp( str1, str2, chars );
}
