/* instr function */

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

static ssize_t fb_hFindQS
	(
		ssize_t start,
		const char *pachText,
		ssize_t len_text,
		const char *pachPattern,
		ssize_t len_pattern
	)
{
	ssize_t max_size = len_text - len_pattern + 1;
	ssize_t qs_bc[256];
	ssize_t i;

	/* create "bad character" shifts */
	for( i=0; i!=256; ++i)
		qs_bc[ i ] = len_pattern + 1;
	for( i=0; i!=len_pattern; ++i )
		qs_bc[ FB_CHAR_TO_INT(pachPattern[i]) ] = len_pattern - i;

	/* search for string */
	for (i=start;
		i<max_size;
		i+=qs_bc[ FB_CHAR_TO_INT(pachText[ i + len_pattern ]) ])
	{
		if( memcmp( pachPattern, pachText + i, len_pattern )==0 ) {
			return i + 1;
		}
	}

	return 0;
}
#endif

/*
 * Searches for a sub-string using the Boyer-Moore algorithm.
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
	ssize_t ret;

	bm_gc = (ssize_t*) malloc(sizeof(ssize_t) * (len_pattern + 1));
	suffixes = (ssize_t*) malloc(sizeof(ssize_t) * (len_pattern + 1));

	memset( bm_gc, 0, sizeof(ssize_t) * (len_pattern+1) );
	memset( suffixes, 0, sizeof(ssize_t) * (len_pattern+1) );

	/* create "bad character" shifts */
	memset(bm_bc, -1, sizeof(bm_bc));
	for( i=0; i!=len_pattern; ++i )
		bm_bc[ FB_CHAR_TO_INT(pachPattern[i]) ] = i;

	/* preprocessing for "good end strategy" case 1 */
	i = len_pattern; j=len_pattern+1;
	suffixes[ i ] = j;

	while ( i!=0 ) 
	{
		char ch1 = pachPattern[i-1];
		while ( j<=len_pattern && ch1!=pachPattern[j-1] ) 
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

	ret = 0;

	/* search */
	i=start;
	while( i <= len_max ) 
	{
		j = len_pattern;

		while( j!=0 && pachPattern[j-1]==pachText[i+j-1] )
			--j;

		if( j==0 ) 
		{
			ret = i + 1;
			break;
		} 
		else 
		{
			char chText = pachText[i+j-1];
			ssize_t shift_gc = bm_gc[j];
			ssize_t shift_bc = j - 1 - bm_bc[ FB_CHAR_TO_INT(chText) ];
			i += ( (shift_gc > shift_bc) ? shift_gc : shift_bc );
		}
	}

	free( bm_gc );
	free( suffixes );

	return ret;
}

#if 0
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
	ssize_t imax = (len_text - len_pattern + 1);
	pachText += start;
	if( start < imax )
	{
		for( i=start; i != imax; ++i ) {
			ssize_t j;
			for( j=0; j!=len_pattern; ++j ) {
				if( pachText[j]!=pachPattern[j] )
					break;
			}
			if( j==len_pattern )
				return i + 1;
			++pachText;
		}
	}
	return 0;
}
#endif

FBCALL ssize_t fb_StrInstr( ssize_t start, FBSTRING *src, FBSTRING *patt )
{
	ssize_t r;

	if( (src == NULL) || (src->data == NULL) ||
		(patt == NULL) || (patt->data == NULL) )
	{
		r = 0;
	}
	else
	{
		ssize_t size_src = FB_STRSIZE(src);
		ssize_t size_patt = FB_STRSIZE(patt);

		if( (size_src == 0) || (size_patt == 0) ||
			((start < 1) || (start > size_src)) || (size_patt > size_src) )
		{
			r = 0;
		}
		else if( size_patt==1 )
		{
			const char *pszEnd = (const char *) FB_MEMCHR( src->data + start - 1, patt->data[0], size_src - start + 1);
			if( pszEnd==NULL )
			{
				r = 0;
			}
			else
			{
				r = pszEnd - src->data + 1;
			}
		}
		else
		{

			r = fb_hFindBM( start - 1,
							src->data, size_src,
							patt->data, size_patt );

		}
	}

	FB_STRLOCK();

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
	fb_hStrDelTemp_NoLock( patt );

	FB_STRUNLOCK();

	return r;
}
