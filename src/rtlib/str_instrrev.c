/* instrrev function */

#include "fb.h"

#if 0 /* FIXME: implementation is bugged somewhere, missing some matches */
static ssize_t fb_hFindBM
	(
		ssize_t start,
		const char *pachText,
		ssize_t len_text,
		const char *pachPattern,
		ssize_t len_pattern
	)
{
	ssize_t i, j, len_max = len_text - len_pattern;
	ssize_t bm_bc[256];
	ssize_t *bm_gc, *suffixes;

	bm_gc = (ssize_t*) alloca(sizeof(ssize_t) * (len_pattern + 1));
	suffixes = (ssize_t*) alloca(sizeof(ssize_t) * (len_pattern + 1));

	memset( bm_gc, 0, sizeof(ssize_t) * (len_pattern+1) );
	memset( suffixes, 0, sizeof(ssize_t) * (len_pattern+1) );

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
			ssize_t shift_gc = bm_gc[j];
			ssize_t shift_bc = j - 1 - bm_bc[ FB_CHAR_TO_INT(chText) ];
			i += ( (shift_gc > shift_bc) ? shift_gc : shift_bc );
		}
	}
	return 0;
}
#endif

#if 1
static ssize_t fb_hFindNaive
	(
		ssize_t start,
		const char *pachText,
		ssize_t len_text,
		const char *pachPattern,
		ssize_t len_pattern
	)
{
	ssize_t i;
	pachText += start;
	for( i=0; i<=start; ++i ) {
		ssize_t j;
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

FBCALL ssize_t fb_StrInstrRev( FBSTRING *src, FBSTRING *patt, ssize_t start )
{
	ssize_t r = 0;

	if( (src != NULL) && (src->data != NULL) && (patt != NULL) && (patt->data != NULL) ) 
	{
		ssize_t size_src = FB_STRSIZE(src);
		ssize_t size_patt = FB_STRSIZE(patt);

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
