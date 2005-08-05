/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 */

/*
 * str_instr.c -- instr function
 *
 * chng: oct/2004 written [v1ctor]
 * chng: aug/2005 added boyer-moore and quirck search algorithms [mjs]
 *                added special search case with pattern length = 1 [mjs]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

#if 0
/** Searches for a sub-string using the Quick Search algorithm.
 *
 * - simplification of the Boyer-Moore algorithm
 * - uses only the bad-character shift
 * - easy to implement
 * - preprocessing phase in O(m + o-) time and O(o-) space complexity
 * - searching phase in O(m * n) time complexity
 * - very fast in practice for short patterns and large alphabets
 *
 * o- = greek letter "sigma"
 *
 * From "Handbook of Exact String-Matching Algorithms" by
 * Christian Charras and Thierry Lecroq
 * ( http://www-igm.univ-mlv.fr/~lecroq/string/string.pdf ).
 */
static int fb_hFindQS( size_t start,
                       const char *pachText, size_t len_text,
                       const char *pachPattern, size_t len_pattern )
{
    size_t max_size = len_text - len_pattern + 1;
    size_t qs_bc[256];
    size_t i;

    /* create "bad character" shifts */
    for( i=0; i!=256; ++i)
        qs_bc[ i ] = len_pattern + 1;
    for( i=0; i!=len_pattern; ++i )
        qs_bc[ (unsigned) (unsigned char) pachPattern[i] ] = len_pattern - i;

    /* search for string */
    for (i=start;
         i<max_size;
         i+=qs_bc[ (unsigned) (unsigned char) pachText[ i + len_pattern ] ])
    {
        if( memcmp( pachPattern, pachText + i, len_pattern )==0 ) {
            return i + 1;
        }
    }

    return 0;
}
#endif

/** Searches for a sub-string using the Boyer-Moore algorithm.
 *
 * - performs the comparisons from right to left
 * - preprocessing phase in O(m + o-) time and space complexity
 * - searching phase in O(m * n) time complexity
 * - 3n text character comparisons in the worst case when searching
 *   for a non periodic pattern
 * - O(n / m) best performance
 *
 * o- = greek letter "sigma"
 *
 * From "Handbook of Exact String-Matching Algorithms" by
 * Christian Charras and Thierry Lecroq
 * ( http://www-igm.univ-mlv.fr/~lecroq/string/string.pdf ).
 *
 * Implementation from
 * http://www.iti.fh-flensburg.de/lang/algorithmen/pattern/bm.htm
 */
static int fb_hFindBM( size_t start,
                       const char *pachText, size_t len_text,
                       const char *pachPattern, size_t len_pattern )
{
    size_t i, j, len_max = len_text - len_pattern;
    int bm_bc[256];
    int *bm_gc, *suffixes;

    bm_gc = (int*) alloca(sizeof(int) * (len_pattern + 1));
    suffixes = (int*) alloca(sizeof(int) * (len_pattern + 1));

    memset( bm_gc, 0, sizeof(int) * (len_pattern+1) );
    memset( suffixes, 0, sizeof(int) * (len_pattern+1) );

    /* create "bad character" shifts */
    memset(bm_bc, -1, sizeof(bm_bc));
    for( i=0; i!=len_pattern; ++i )
        bm_bc[ (unsigned) (unsigned char) pachPattern[i] ] = i;

    /* preprocessing for "good end strategy" case 1 */
    i = len_pattern; j=len_pattern+1;
    suffixes[ i ] = j;
    while ( i!=0 ) {
        char ch1 = pachPattern[i-1];
        while ( j<=len_pattern && ch1!=pachPattern[j-1] ) {
            if( bm_gc[j]==0 )
                bm_gc[j] = j - i;
            j = suffixes[j];
        }
        --i; --j;
        suffixes[i] = j;
    }

    /* preprocessing for "good end strategy" case 2 */
    j = suffixes[0];
    for( i=0; i<=len_pattern; ++i ) {
        if( bm_gc[i]==0 )
            bm_gc[i] = j;
        if( i==j )
            j = suffixes[j];
    }

    /* search */
    i=start;
    while( i <= len_max ) {
        j = len_pattern;
        while( j!=0 && pachPattern[j-1]==pachText[i+j-1] )
            --j;
        if( j==0 ) {
            return i + 1;
        } else {
            char chText = pachText[i+j-1];
            int shift_gc = bm_gc[j];
            int shift_bc = j - 1 - bm_bc[ (unsigned) (unsigned char) chText ];
            i += ( (shift_gc > shift_bc) ? shift_gc : shift_bc );
        }
    }
    return 0;
}

#if 0
static int fb_hFindNaive( size_t start,
                          const char *pachText, size_t len_text,
                          const char *pachPattern, size_t len_pattern )
{
    size_t i;
    pachText += start;
    for( i=start; i!=len_text; ++i ) {
        size_t j;
        for( j=0; j!=len_pattern; ++j ) {
            if( pachText[j]!=pachPattern[j] )
                break;
        }
        if( j==len_pattern )
            return i + 1;
        ++pachText;
    }
    return 0;
}
#endif

FBCALL int fb_StrInstr ( int start, FBSTRING *src, FBSTRING *patt )
{
    int r;

    FB_STRLOCK();

    if( (src == NULL) || (src->data == NULL) || (patt == NULL) || (patt->data == NULL) ) {
        r = 0;
    } else {
        size_t size_src = FB_STRSIZE(src);
        size_t size_patt = FB_STRSIZE(patt);
        if( ((start < 1) || (start > size_src)) || (size_patt > size_src) ) {
            r = 0;
        } else if( size_patt==0 && size_src!=0 ) {
            r = start;
        } else if( size_patt==1 ) {
            const char *pszEnd = FB_MEMCHR( src->data + start - 1, patt->data[0], size_src - start + 1);
            if( pszEnd==NULL ) {
                r = 0;
            } else {
                r = pszEnd - src->data + 1;
            }
        } else {
            r = fb_hFindBM( start - 1,
                            src->data, size_src,
                            patt->data, size_patt );
        }
    }

	/* del if temp */
	fb_hStrDelTemp( src );
	fb_hStrDelTemp( patt );

    FB_STRUNLOCK();

    return r;
}

/* Not removed to avoid chicken/egg problem */
/*:::::*/
FBCALL int fb_StrInstrRe ( FBSTRING *src, FBSTRING *patt )
{
	return fb_StrInstr( 1, src, patt );
}
