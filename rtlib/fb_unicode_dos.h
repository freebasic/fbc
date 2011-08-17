#ifndef __FB_UNICODE_DOS__
#define __FB_UNICODE_DOS__

#include <ctype.h>

#if 0

#include <wchar.h>
#include <wctype.h>

#define _LC(c) L ## c

wchar_t *__bsd_wcsstr( const wchar_t *str, const wchar_t *strSearch );
int __bsd_wcsncmp( const wchar_t *s1, const wchar_t *s2, size_t n );
long __bsd_wcstol( const wchar_t *nptr, wchar_t **endptr, int base );
long long __bsd_wcstoll( const wchar_t *nptr, wchar_t **endptr, int base );
long __bsd_wcstoul( const wchar_t *nptr, wchar_t **endptr, int base );
long long __bsd_wcstoull( const wchar_t *nptr, wchar_t **endptr, int base );
double __bsd_wcstod(const wchar_t *nptr, wchar_t **endptr);

/*:::::*/
static __inline__ size_t wcslen( const wchar_t *s )
{
    const wchar_t *p = s;
    while (*p)
        ++p;
    return p - s;
}

/*:::::*/
static __inline__ int iswlower( wint_t c )
{
    if( c > 255 )
        return 0;
    return islower((int) c);
}

/*:::::*/
static __inline__ int iswupper( wint_t c )
{
    if( c > 255 )
        return 0;
    return isupper((int) c);
}

/*:::::*/
static __inline__ int towlower( wint_t c )
{
    if( c > 255 )
        return c;
    return tolower((int) c);
}

/*:::::*/
static __inline__ int towupper( wint_t c )
{
    if( c > 255 )
        return c;
    return toupper((int) c);
}

/*:::::*/
static __inline__ int iswspace( wint_t c )
{
    if( c > 255 )
        return 0;
    return isspace((int) c);
}

/*:::::*/
static __inline__ wchar_t *wcsstr(const wchar_t *str, const wchar_t *strSearch)
{
    return __bsd_wcsstr( str, strSearch );
}

/*:::::*/
static __inline__ int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n)
{
    return __bsd_wcsncmp( s1, s2, n );
}

/*:::::*/
static __inline__ long wcstol( const wchar_t *nptr, wchar_t **endptr, int base )
{
    return __bsd_wcstol( nptr, endptr, base );
}

/*:::::*/
static __inline__ long long wcstoll( const wchar_t *nptr, wchar_t **endptr, int base )
{
    return __bsd_wcstoll( nptr, endptr, base );
}

/*:::::*/
static __inline__ double wcstod(const wchar_t *nptr, wchar_t **endptr) {
    return __bsd_wcstod(nptr, endptr);
}

/*:::::*/
static __inline__ long wcstoul( const wchar_t *nptr, wchar_t **endptr, int base )
{
    return __bsd_wcstoul( nptr, endptr, base );
}

/*:::::*/
static __inline__ long long wcstoull( const wchar_t *nptr, wchar_t **endptr, int base )
{
    return __bsd_wcstoull( nptr, endptr, base );
}

#else

#include <stdarg.h>
#include <stdio.h>

#undef FB_WCHAR
#define FB_WCHAR char

#define WEOF EOF

#define wcslen(s) strlen(s)
#define iswlower(c) islower(c)
#define iswupper(c) isupper(c)
#define towlower(c) tolower(c)
#define towupper(c) toupper(c)
#define wmemcmp(a,b,c) memcmp(a,b,c)
#define wmemchr(a,b,c) memchr(a,b,c)

/*:::::*/
static __inline__ size_t __dos_mbstowcs(FB_WCHAR *wcstr, const char *mbstr, size_t count)
{
    return memcpy(wcstr,mbstr,count), count;
}

/*:::::*/
static __inline__ size_t __dos_wcstombs(char *mbstr, const FB_WCHAR *wcstr, size_t count)
{
    return memcpy(mbstr,wcstr,count), count;
}

#define mbstowcs __dos_mbstowcs
#define wcstombs __dos_wcstombs

/*:::::*/
static __inline__ void fb_wstr_WcharToChar( char *dst, const FB_WCHAR *src, int chars )
{
	memcpy(dst,src,chars);
}

#define FB_WSTR_WCHARTOCHAR fb_wstr_WcharToChar

#define wcsstr(str, strSearch) \
    strstr(str, strSearch)

#define wcsncmp(str1, str2, count) \
    strncmp(str1, str2, count)

/*:::::*/
static __inline__ int swprintf(FB_WCHAR *buffer, size_t n, const FB_WCHAR *format, ...)
{
    int result;
    va_list ap;
    va_start(ap, format);
    result = vsprintf( buffer, format, ap );
    va_end(ap);
    return result;
}

#define wcstod   strtod
#define wcstol   strtol
#define wcstoll  strtoll
#define wcstoul  strtoul
#define wcstoull strtoull
#define wcschr   strchr
#define wcscspn  strcspn

#define _LC(c) c

#endif

#endif /* __FB_UNICODE_DOS__ */
