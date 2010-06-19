/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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

/*
 * str_instrrev.c -- instrrev function
 *
 * chng: dec/2007 written [jeffm] - thanks to counting_pine for 
 *                providing the reverse implementation based on
 *                the one in str_instr.c.
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

#if 0 /* FIXME: implementation is bugged somewhere, missing some matches */
/*:::::*/
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
		bm_bc[ FB_CHAR_TO_INT(pachPattern[i]) ] = i;

	/* preprocessing for "good end strategy" case 1 */
	i = len_pattern; 
	j = len_pattern + 1;
	suffixes[ i ] = j;
	while ( i != 0 ) 
	{
		char ch1 = pachPattern[len_pattern-i];
		while ( j <= len_pattern && ch1 != pachPattern[len_pattern-j] ) 
		{
			if( bm_gc[j]==0 )
				bm_gc[j] = j - i;
			j = suffixes[j];
		}
		--i; 
		--j;
		suffixes[i] = j;
	}

	/* preprocessing for "good end strategy" case 2 */
	j = suffixes[0];
	for( i=0; i<=len_pattern; ++i ) 
	{
		if( bm_gc[i]==0 )
			bm_gc[i] = j;
		if( i==j )
			j = suffixes[j];
	}

	/* search */
	i = len_max - start;
	while( i <= len_max ) 
	{
		j = len_pattern;
		while( j != 0 && pachPattern[len_pattern-j] == pachText[len_text - i - j] )
			--j;
		if( j==0 ) {
			return len_text - len_pattern - i + 1;
		} else {
			char chText = pachText[len_text - i - j];
			int shift_gc = bm_gc[j];
			int shift_bc = j - 1 - bm_bc[ FB_CHAR_TO_INT(chText) ];
			i += ( (shift_gc > shift_bc) ? shift_gc : shift_bc );
		}
	}
	return 0;
}
#endif

#if 1
/*:::::*/
static int fb_hFindNaive( size_t start,
                          const char *pachText, size_t len_text,
                          const char *pachPattern, size_t len_pattern )
{
	size_t i;
	pachText += start;
	for( i=0; i<=start; ++i ) {
		size_t j;
		for( j=0; j!=len_pattern; ++j ) {
			if( pachText[j]!=pachPattern[j] )
				break;
		}
		if( j==len_pattern )
			return start - i + 1;
		--pachText;
	}
	return 0;
}
#endif

/*:::::*/
FBCALL int fb_StrInstrRev ( FBSTRING *src, FBSTRING *patt, int start )
{
	int r = 0;

	if( (src != NULL) && (src->data != NULL) && (patt != NULL) && (patt->data != NULL) ) 
	{

 		size_t size_src = FB_STRSIZE(src);
		size_t size_patt = FB_STRSIZE(patt);

		if( (size_src != 0) && (size_patt != 0) && (size_patt <= size_src) && (start != 0))
		{
			/* handle signed/unsigned comparisons of start and size_* vars */
			if( start < 0 )
				start = size_src - size_patt + 1;
			else if( start > size_src )
				start = 0;
			else if( start > size_src - size_patt )
				start = size_src - size_patt + 1;
			
			if( start > 0 )
			{
#if 1
				r = fb_hFindNaive( start - 1,
					src->data, size_src,
					patt->data, size_patt );
#else
				r = fb_hFindBM( start - 1,
					src->data, size_src,
					patt->data, size_patt );
#endif
			}
		}
	}

	FB_STRLOCK();

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
	fb_hStrDelTemp_NoLock( patt );

	FB_STRUNLOCK();

	return r;
}
