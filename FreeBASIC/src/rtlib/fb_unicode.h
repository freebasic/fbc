/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2008 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

#ifndef __FB_UNICODE__
#define __FB_UNICODE__

#ifdef HAVE_STDINT_H
#include <stdint.h>
#endif
#ifdef HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif
#include <stdlib.h>
#include <string.h>

#define FB_WCHAR wchar_t

typedef uint32_t UTF_32;
typedef uint16_t UTF_16;
typedef uint8_t  UTF_8;

#define UTF8_BYTEMASK 		 0xBF
#define UTF8_BYTEMARK 		 0x80

#define UTF16_MAX_BMP 		 (UTF_32)0x0000FFFF
#define	UTF16_SUR_HIGH_START (UTF_32)0xD800
#define	UTF16_SUR_HIGH_END	 (UTF_32)0xDBFF
#define	UTF16_SUR_LOW_START	 (UTF_32)0xDC00
#define	UTF16_SUR_LOW_END	 (UTF_32)0xDFFF
#define	UTF16_HALFSHIFT		 10
#define	UTF16_HALFBASE 		 (UTF_32)0x0010000UL
#define	UTF16_HALFMASK 		 (UTF_32)0x3FFUL

#if defined(TARGET_DOS)
# include "dos/fb_unicode.h"
#elif defined(TARGET_XBOX)
# include "xbox/fb_unicode.h"
#elif defined(TARGET_CYGWIN)
/* dumb cygwin ... */
# include "dos/fb_unicode.h"
#elif defined(TARGET_WIN32)
# include "win32/fb_unicode.h"
#else
# define __USE_ISOC99 1
# define __USE_ISOC95 1
# include <wchar.h>
# include <wctype.h>
#endif

#ifndef _LC
#define _LC(c) L ## c
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

#ifndef FB_WSTR_WCHARTOCHAR
#define FB_WSTR_WCHARTOCHAR fb_wstr_WcharToChar
static __inline__ void fb_wstr_WcharToChar
	( 
		char *dst,
		const FB_WCHAR *src,
		int chars
	)
{
	UTF_32 c;

	while( chars )
	{
		c = *src++;

		if( c > 255 )
    		c = '?';

		*dst++ = c;
		--chars;
	}
}
#endif

/** Calculate the number of characters between two pointers.
 */
static __inline__ int fb_wstr_CalcDiff
	( 
		const FB_WCHAR *ini,
		const FB_WCHAR *end 
	)
{
	return ((intptr_t)end - (intptr_t)ini) / sizeof( FB_WCHAR );
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_AllocTemp
	( 
		int chars 
	)
{
	/* plus the null-term */
	return (FB_WCHAR *)malloc( (chars + 1) * sizeof( FB_WCHAR ) );
}

/*:::::*/
static __inline__ void fb_wstr_Del 
	( 
		FB_WCHAR *s 
	)
{
	free( (void *)s );
}

/** Return the length of a WSTRING.
 */
static __inline__ int fb_wstr_Len
	( 
		const FB_WCHAR *s 
	)
{
	/* without the null-term */
	return wcslen( s );
}

/*:::::*/
static __inline__ void fb_wstr_ConvFromA
	( 
		FB_WCHAR *dst,
		int dst_chars, 
		const char *src 
	)
{
	int chars;

	/* NULL? */
	if( src == NULL )
	{
		chars = -1;
	}
	else
	{
		/* plus the null-term (note: "n" in chars, not bytes!) */
		chars = mbstowcs( dst, src, dst_chars + 1 );
	}

	/* error? */
	if( chars == -1 )
		*dst = _LC('\0');

	/* if there's no enough space in dst the null-term won't be added? */
	else if( chars == (dst_chars + 1) )
		dst[dst_chars] = _LC('\0');

}

/*:::::*/
static __inline__ void fb_wstr_ConvToA
	( 
		char *dst,
		const FB_WCHAR *src, 
		int chars 
	)
{
	/* !!!FIXME!!! wcstombs() will fail and not emit '?' or such if the
				   characters are above 255 and can't be converted? not good.. */
#if 0
	int bytes;

	/* plus the null-term */
	bytes = wcstombs( dst, src, chars + 1 );

	/* error? */
	if( bytes == -1 )
		*dst = '\0';

	/* if there's no enough space in dst the null-term won't be added? */
	else if( bytes == chars + 1 )
		dst[src_chars] = '\0';

#else
	FB_WSTR_WCHARTOCHAR( dst, src, chars );

	/* plus the null-term */
	dst[chars] = '\0';
#endif
}

/*:::::*/
static __inline__ int fb_wstr_IsLower
	( 
		FB_WCHAR c 
	)
{
	return iswlower( c );
}

/*:::::*/
static __inline__ int fb_wstr_IsUpper
	( 
		FB_WCHAR c 
	)
{
	return iswupper( c );
}

/*:::::*/
static __inline__ FB_WCHAR fb_wstr_ToLower
	( 
		FB_WCHAR c 
	)
{
	return towlower( c );
}

/*:::::*/
static __inline__ FB_WCHAR fb_wstr_ToUpper
	( 
		FB_WCHAR c 
	)
{
	return towupper( c );
}

/** Copy n characters from A to B and terminate with NUL.
 */
static __inline__ void fb_wstr_Copy
	( 
		FB_WCHAR *dst,
		const FB_WCHAR *src, 
		int chars 
	)
{
	if( (src != NULL) && (chars > 0) )
		dst = FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );

	/* add the null-term */
	*dst = _LC('\0');
}

/** Copy n characters from A to B.
 */
static __inline__ FB_WCHAR *fb_wstr_Move
	( 
		FB_WCHAR *dst,
		const FB_WCHAR *src, 
		int chars 
	)
{
	return FB_MEMCPYX( dst, src, chars * sizeof( FB_WCHAR ) );
}

/*:::::*/
static __inline__ void fb_wstr_Fill
	( 
		FB_WCHAR *dst, 
		FB_WCHAR c, 
		int chars 
	)
{
	int i;

	for( i = 0; i < chars; i++ )
		*dst++ = c;

	/* add null-term */
	*dst = _LC('\0');
}

/** Skip all characters (c) from the beginning of the string, max 'n' chars.
 */
static __inline__ const FB_WCHAR *fb_wstr_SkipChar
	( 
		const FB_WCHAR *s,
		int chars, 
		FB_WCHAR c 
	)
{
	const FB_WCHAR *p;

	if( s == NULL )
		return NULL;

	p = s;
	while( chars > 0 )
	{
		if( *p != c )
			return p;
		++p;
		--chars;
	}

    return p;
}

/** Skip all characters (c) from the end of the string, max 'n' chars.
 */
static __inline__ const FB_WCHAR *fb_wstr_SkipCharRev
	( 
		const FB_WCHAR *s,
		int chars, 
		FB_WCHAR c 
	)
{
	const FB_WCHAR *p;

	if( (s == NULL) || (chars <= 0) )
		return s;

	p = &s[chars-1];

	/* fixed-len's are filled with null's as in PB, strip them too */
	while( chars > 0 )
	{
		if( *p != c )
			return p;
		--p;
		--chars;
	}

    return p;
}

/*:::::*/
static __inline__ FB_WCHAR *fb_wstr_Instr
	( 
		const FB_WCHAR *s,
		const FB_WCHAR *patt 
	)
{
	return wcsstr( s, patt );
}

/*:::::*/
static __inline__ size_t fb_wstr_InstrAny
	( 
		const FB_WCHAR *s,
		const FB_WCHAR *sset
	)
{
	return wcscspn( s, sset );
}

/*:::::*/
static __inline__ int fb_wstr_Compare
	( 
		const FB_WCHAR *str1,
		const FB_WCHAR *str2, 
		int chars 
	)
{
	return wcsncmp( str1, str2, chars );
}


#endif /* __FB_UNICODE__ */
