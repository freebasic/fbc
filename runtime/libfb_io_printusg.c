/* print using function */

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "fb.h"

#define BUFFERLEN 2048
#define MIN_EXPDIGS 3
#define MAX_EXPDIGS 5
#define MAX_DIGS (BUFFERLEN                                 \
                   - 2                 /* '%' char(s)   */  \
                   - 1                 /* +/- sign      */  \
                   - 1                 /* dollar sign   */  \
                   - 1                 /* decimal point */  \
                   - MAX_EXPDIGS       /* exp digits    */  \
                   - (MIN_EXPDIGS - 1) /* stray carets  */  \
                 )


#define CHAR_ZERO        '0'
#define CHAR_DOT         '.'
#define CHAR_COMMA       ','
#define CHAR_TOOBIG      '%'
#define CHAR_PLUS        '+'
#define CHAR_MINUS       '-'
#define CHAR_STAR        '*'
#define CHAR_DOLLAR      '$'
#define CHAR_SPACE       ' '
#define CHAR_WTF         '!'
#define CHAR_EXP_SINGLE  'E'
#if 0
#define CHAR_EXP_DOUBLE  'D'
#endif

#define STR_NAN "NAN"
#define STR_INF "INF"

#define ADD_CHAR( c )              \
    do {                           \
        DBG_ASSERT( p >= buffer ); \
        if( p >= buffer )          \
            *(p--) = (char)(c);    \
        else if( p == buffer )     \
            *p = CHAR_WTF;         \
    } while (0)


/*-------------------------------------------------------------*/
/* Checks for Infinity/NaN                                     *
 * (assumes x86 endian, IEEE-754 floating-point format)        *
 * TODO: use a proper implementation: most/all platforms       *
 * have specific functions built-in for this                   */

#define LO32( x ) (((uint32_t *)&(x))[0])
#define HI32( x ) (((uint32_t *)&(x))[1])

#define IS_NEG( x ) (                           \
    (HI32(x) & 0x80000000) != 0  )

#define IS_ZERO( x ) (                          \
    ((HI32(x) & 0x7fffffff) | LO32(x)) == 0  )

#define IS_FINITE( x ) (                        \
    (HI32(x) & 0x7ff00000) != 0x7ff00000  )

#define IS_INFINITE( x ) (                      \
    LO32(x) == 0 &&                             \
    (HI32(x) & 0x7fffffff) == 0x7ff00000  )

#define IS_NAN( x ) (                           \
    (HI32(x) & 0x7ff00000) == 0x7ff00000 &&     \
    ((HI32(x) & 0x000fffff) | LO32(x)) != 0   )



#define IS_NEG_F( x ) (                         \
    (LO32(x) & 0x80000000) != 0  )

#define IS_ZERO_F( x ) (                        \
    (LO32(x) & 0x7fffffff) == 0  )

#define IS_FINITE_F( x ) (                      \
    (LO32(x) & 0x7f800000) != 0x7f800000  )

#define IS_INFINITE_F( x ) (                    \
    (LO32(x) & 0x7fffffff) == 0x7f800000  )

#define IS_NAN_F( x ) (                         \
    (LO32(x) & 0x7f800000) == 0x7f800000 &&     \
    (LO32(x) & 0x007fffff) != 0              )

/*-------------------------------------------------------------*/

#define VAL_ISNEG 0x1
#define VAL_ISINF 0x2
#define VAL_ISNAN 0x4

#define VAL_ISFLOAT 0x8
#define VAL_ISSNG 0x10


static int fb_PrintUsingFmtStr( int fnum );


/*:::::*/
FBCALL int fb_PrintUsingInit
	(
		FBSTRING *fmtstr
	)
{
    FB_PRINTUSGCTX *ctx;

    FB_LOCK();

    ctx = FB_TLSGETCTX( PRINTUSG );

	fb_StrAssign( (void *)&ctx->fmtstr, -1, fmtstr, -1, 0 );
	ctx->ptr = ctx->fmtstr.data;
	ctx->chars = FB_STRSIZE( &ctx->fmtstr );

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_PrintUsingEnd
	(
		int fnum
	)
{
	FB_PRINTUSGCTX *ctx;

	fb_PrintUsingFmtStr( fnum );

	FB_LOCK();

	ctx = FB_TLSGETCTX( PRINTUSG );

	fb_StrDelete( &ctx->fmtstr );
	ctx->ptr = 0;
	ctx->chars = 0;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static unsigned long long hPow10_ULL( int n )
{

	DBG_ASSERT( n >= 0 && n <= 19 );

	unsigned long long ret = 1, a = 10;
	while( n > 0 )
	{
		if( n & 1 ) ret *= a;
		a *= a;
		n >>= 1;
	}

	return ret;
}

/*:::::*/
static int hLog10_ULL( unsigned long long a )
{
	int ret = 0;
	long a32;
	unsigned long long a64;

	a64 = a;
	while( a64 >= (long)1.E+8 )
	{
		a64 /= (long)1.E+8;
		ret += 8;
	}
	a32 = (long)a64;
	if( a32 >= (long)1.E+4 ) ret += 4; else a32 *= (long)1.E+4;
	if( a32 >= (long)1.E+6 ) ret += 2; else a32 *= (long)1.E+2;
	if( a32 >= (long)1.E+7 ) ret += 1;

	if( a == 0 )
		DBG_ASSERT( ret == 0 );
	else
		DBG_ASSERT( hPow10_ULL( ret ) <= a && hPow10_ULL( ret ) > a / 10 );

	return ret;
}

/*:::::*/
static unsigned long long hDivPow10_ULL( unsigned long long a, int n )
{
	unsigned long long b, ret;

	DBG_ASSERT( n >= 0 );

	if( n > 19 ) return 0;

	b = hPow10_ULL( n );
	ret = a / b;

	if( (a % b) >= (b + 1) / 2 )
		ret += 1; /* round up */

	return ret;
}

/*:::::*/
static int fb_PrintUsingFmtStr
	(
		int fnum
	)
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1];
	int c, nc, nnc, len, doexit;

	ctx = FB_TLSGETCTX( PRINTUSG );

	len = 0;
	if( ctx->ptr == NULL )
		ctx->chars = 0;

	while( (ctx->chars > 0) && (len < BUFFERLEN) )
	{
		c = *ctx->ptr;
		nc = ( ctx->chars > 1? ctx->ptr[1] : -1 );
		nnc = ( ctx->chars > 2? ctx->ptr[2] : -1 );

		doexit = 0;
		switch( c )
		{
		case '*':
			/* "**..." number format (includes "**$...") */
			if( nc == '*' )
				doexit = 1;

			break;

		case '$':
			/* "$$..." number format */
			if( nc == '$' )
				doexit = 1;

			break;

		case '+':
			/* "+#...", "+$$...", "+**...", "+.#..." */
			if( (nc == '#') ||
			    ((nc == '$') && (nnc == '$')) ||
			    ((nc == '*') && (nnc == '*')) ||
			    ((nc == '.') && (nnc == '#')) )

				doexit = 1;
			break;

		case '!':
		case '\\':
		case '&':
		case '#':
			/* "!", "\ ... \", "&" string formats, "#..." number format */
			doexit = 1;
			break;

		case '.':
			/* ".#[...]" number format */
			if( nc == '#' )
				doexit = 1;

			break;

		case '_':
			/* escape next char if there is one, otherwise just print '_' */
			if( ctx->chars > 1 )
			{
				c = nc;
				++ctx->ptr;
				--ctx->chars;
			}
		}

		if( doexit )
			break;

		buffer[len++] = (char)c;

		++ctx->ptr;
		--ctx->chars;
	}

	/* flush */
	if( len > 0 )
	{
		buffer[len] = '\0';
		fb_PrintFixString( fnum, buffer, 0 );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_PrintUsingStr
	(
		int fnum,
		FBSTRING *s,
		int mask
	)
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1];
	int c, nc, strchars, doexit, i;

	ctx = FB_TLSGETCTX( PRINTUSG );

    /* restart if needed */
	if( ctx->chars == 0 )
	{
		ctx->ptr = ctx->fmtstr.data;
		ctx->chars = FB_STRSIZE( &ctx->fmtstr );
	}

	/* any text first */
	fb_PrintUsingFmtStr( fnum );

	strchars = -1;

	if( ctx->ptr == NULL )
		ctx->chars = 0;

	while( ctx->chars > 0 )
    {
		c = *ctx->ptr;
        nc = ( ctx->chars > 1? ctx->ptr[1] : -1 );

		doexit = 1;
		switch( c )
		{
		case '!':
			if( FB_STRSIZE( s ) >= 1 )
				buffer[0] = s->data[0];
			else
				buffer[0] = ' ';

			buffer[1] = '\0';
			fb_PrintFixString( fnum, buffer, 0 );

			++ctx->ptr;
			--ctx->chars;
			break;

		case '&':
			fb_PrintFixString( fnum, s->data, 0 );

			++ctx->ptr;
			--ctx->chars;
			break;

		case '\\':
			if( (strchars != -1) || (nc == ' ') || (nc == '\\') )
			{
				if( strchars > 0 )
				{
					++strchars;

					if( FB_STRSIZE( s ) < strchars )
					{
						fb_PrintFixString( fnum, s->data, 0 );

						strchars -= FB_STRSIZE( s );
						for( i = 0; i < strchars; i++ )
							buffer[i] = ' ';
						buffer[i] = '\0';
					}
					else
					{
						memcpy( buffer, s->data, strchars );
						buffer[strchars] = '\0';
					}

					/* replace null-terminators by spaces */
					for( i = 0; i < strchars; i++ )
						if( buffer[i] == '\0' )
							buffer[i] = ' ';

					fb_PrintFixString( fnum, buffer, 0 );

					++ctx->ptr;
					--ctx->chars;
				}
				else
				{
					strchars = 1;
					doexit = 0;
				}
			}
			break;

		case ' ':
			if( strchars > -1 )
			{
				++strchars;
				doexit = 0;
			}
			break;
		}

		if( doexit )
			break;

		++ctx->ptr;
		--ctx->chars;
	}

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	/**/
	if( mask & FB_PRINT_ISLAST )
	{
		if( mask & FB_PRINT_NEWLINE )
			fb_PrintVoid( fnum, FB_PRINT_NEWLINE );

		fb_StrDelete( &ctx->fmtstr );

	}

	/* del if temp */
	fb_hStrDelTemp( s );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*::::*/
static int hPrintNumber
	(
		int fnum,
		unsigned long long val, int val_exp, int flags,
		int mask
	)
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1], *p;
	int val_digs, val_zdigs;
	unsigned long long val0;
	int val_digs0, val_exp0;
	int val_isneg, val_isinf, val_isnan, val_isfloat, val_issng;
	int c, lc;
	int doexit, padchar, intdigs, decdigs, expdigs;
	int adddollar, addcommas, signatend, signatini, plussign, toobig;
	int intdigs2, expsignchar, totdigs, decpoint;
	int isamp;
	int i;

	ctx = FB_TLSGETCTX( PRINTUSG );

	/* restart if needed */
	if( ctx->chars == 0 )
	{
		ctx->ptr = ctx->fmtstr.data;
		ctx->chars = FB_STRSIZE( &ctx->fmtstr );
	}

	/* any text first */
	fb_PrintUsingFmtStr( fnum );

	/**/
	padchar    = CHAR_SPACE;
	intdigs    = 0;
	decdigs    = -1;
	expdigs    = 0;
	adddollar  = 0;
	addcommas  = 0;
	signatend  = 0;
	signatini  = 0;
	plussign   = 0;
	toobig     = 0;
	isamp      = 0;

	lc = -1;

	if( ctx->ptr == NULL )
		ctx->chars = 0;

	while( ctx->chars > 0 )
	{
		/* exit if just parsed end '+'/'-' sign, or '&' sign */
		if( signatend || isamp ) break;

		c = *ctx->ptr;

		doexit = 0;
		switch( c )
		{
		case '#':
			/* increment intdigs or decdigs if in int/dec part, else exit */
			if( expdigs != 0 )
				doexit = 1;
			else if( decdigs != -1 )
				++decdigs;
			else
				++intdigs;
			break;

		case '.':
			/* add decimal point if still in integer part, else exit */
			if( decdigs != -1 || expdigs != 0 )
				doexit = 1;
			else
				decdigs = 0;
			break;

		case '*':
			/* if first two characters, change padding to asterisks, else exit */
			if( (intdigs == 0 && decdigs == -1) )
			{
				DBG_ASSERT( nc == '*' );
				padchar = CHAR_STAR;
				++intdigs;
			}
			else if( intdigs == 1 && lc == '*' )
			{
				++intdigs;
			}
			else
				doexit = 1;
			break;

		case '$':
			/* at beginning or after two '*'s: prepend a dollar sign to number */

			/* did it follow a '*'? (Will have been the two at the start, else would have exited by now */
			if( lc == '*' )
			{
				adddollar = 1;
			}
			/* at start of number, before integer part? */
			else if( intdigs == 0 && decdigs == -1 )
			{
				if( !adddollar )
				{	/* first one */
					DBG_ASSERT( nc == '$' ); /* otherwise, shouldn't have been brought here */
					adddollar = 1;
				}
				else
				{	/* second one */
					DBG_ASSERT( lc == '$' );
					++intdigs;
				}
			}
			else
				doexit = 1;
			break;

		case ',':
			/* if parsing integer part, enable commas and increment intdigs */
			if( decdigs != -1 || expdigs != 0 )
				doexit = 1;
			else
			{
				addcommas = 1;
				++intdigs;
			}
			break;

		case '+':
		case '-':
			/* '+' at start/end:  explicit '+'/'-' sign
			   '-' at end:  explicit '-' sign, if negative */

			/* one already at start? */
			if( signatini )
			{
				doexit = 1;
			}
			/* found one before integer part? */
			else if( intdigs == 0 && decdigs == -1 )
			{
				DBG_ASSERT( c != '-' ); /* explicit '-' sign isn't checked for at start */
				if( c == '+' )
					plussign = 1;
				signatini = 1;
			}
			/* otherwise it's at the end, as long as there are enough expdigs for an
			   exponent (or none at all), otherwise they are all normal printable characters */
			else if( expdigs == 0 || expdigs >= MIN_EXPDIGS )
			{
				if( c == '+' )
					plussign = 1;
				signatend = 1;
			}
			else
				doexit = 1;
			break;

		case '^':
			/* exponent digits (there must be at least MIN_EXPDIGS of them,
			   otherwise they will just be appended as printable chars      */

			/* Too many? Leave the rest as printable chars */
			if( expdigs < MAX_EXPDIGS )
				++expdigs;
			else
				doexit = 1;
			break;

		case '&':
			/* string format '&'
			   print number in most natural form - similar to STR */
			if( intdigs == 0 && decdigs == -1 && !signatini )
			{
				DBG_ASSERT( expdigs == 0 );
				isamp = 1;
			}
			else
				doexit = 1;
			break;

		default:
			doexit = 1;
		}

		if( doexit )
			break;

		++ctx->ptr;
		--ctx->chars;

		lc = c;
	}

	/* ------------------------------------------------------ */

	/* check flags */
	val_isneg = ( (flags & VAL_ISNEG) != 0 );
	val_isfloat = ( (flags & VAL_ISFLOAT) != 0 );
	val_issng = ( (flags & VAL_ISSNG) != 0 );

	if( flags & (VAL_ISINF | VAL_ISNAN) )
	{
		val_isinf = ( (flags & VAL_ISINF) != 0 );
		val_isnan = ( (flags & VAL_ISNAN) != 0 );
		
		intdigs += (decdigs + 1);
		decdigs = -1;
		if( expdigs >= MIN_EXPDIGS )
		{
			intdigs += expdigs;
			expdigs = 0;
		}
	}
	else
	{
		val_isinf = 0;
		val_isnan = 0;
	}

	if( val != 0 && !(val_isinf || val_isnan) )
		val_digs = hLog10_ULL( val ) + 1;
	else
		val_digs = 0;
	val_zdigs = 0;

	/* Special '&' format? */
	if( isamp )
	{
		if( val_isinf )
		{
			intdigs = strlen(STR_INF);
			decdigs = 0;
			decpoint = 0;
		}
		else if( val_isnan )
		{
			intdigs = strlen(STR_NAN);
			decdigs = 0;
			decpoint = 0;
		}
		else
		{
			if( val_issng )
			{	/* crop to 7-digit precision */
				if( val_digs > 7 )
					val = hDivPow10_ULL( val, val_digs - 7 );
					val_exp += val_digs - 7;
					val_digs = 7;

				if( val == 0 )
				{	/* val has been scaled down to zero */
					val_digs = 0;
					val_exp = -decdigs;
				}
				else if( val == hPow10_ULL( val_digs ) )
				{	/* rounding up took val to next power of 10:
					   set value to 1, put val_digs zeroes onto val_exp */
					val = 1;
					val_exp += val_digs;
					val_digs = 1;
				}
			}

			if( val_isfloat )
			{	/* remove trailing zeroes in float digits */
				while( val_digs > 1 && (val % 10) == 0 )
				{
					val /= 10;
					--val_digs;
					++val_exp;
				}
			}

			/* set digits for fixed-point */
			if( val_digs + val_exp > 0 )
				intdigs = val_digs + val_exp;
			else
				intdigs = 1;

			if( val_exp < 0 )
				decdigs = -val_exp;

			if( val_isfloat )
			{	/* scientific notation? e.g. 3.1E+42 */
				if( intdigs > 16 || (val_issng && intdigs > 7) ||
				    val_digs + val_exp - 1 < -MIN_EXPDIGS )
				{
					intdigs = 1;
					decdigs = val_digs - 1;

					expdigs = 2 + hLog10_ULL( abs(val_digs + val_exp - 1) ) + 1;
					if( expdigs < MIN_EXPDIGS + 1 )
						expdigs = MIN_EXPDIGS;
				}
			}
		}

		if( val_isneg )
			signatini = 1;
	}

	/* crop number of digits */
	if( intdigs + 1 + decdigs > MAX_DIGS )
	{
		decdigs -= ((intdigs + 1 + decdigs) - MAX_DIGS);
		if( decdigs < -1 )
		{
			intdigs -= (-1 - decdigs);
			decdigs = -1;
		}
	}

	/* decimal point if decdigs >= 0 */
	if( decdigs <= -1 )
	{
		decpoint = 0;
		decdigs = 0;
	}
	else
		decpoint = 1;

	/* ------------------------------------------------------ */

	p = &buffer[BUFFERLEN];
	ADD_CHAR( '\0' );

	if( signatend )
	{	/* put sign at end */
		if( val_isneg )
			ADD_CHAR( CHAR_MINUS );
		else
			ADD_CHAR( plussign? CHAR_PLUS : CHAR_SPACE );
	}
	else if( val_isneg && !signatini )
	{	/* implicit negative sign at start */
		signatini = 1;
		--intdigs;
	}

	/* fixed-point format? */
	if( expdigs < MIN_EXPDIGS )
	{
		/* append any trailing carets */
		for( ; expdigs > 0; --expdigs )
			ADD_CHAR( '^' );

		if( !(val_isinf || val_isnan) )
		{
			/* backup unscaled value */
			val0 = val;
			val_digs0 = val_digs;
			val_exp0 = val_exp;

			/* check range */
			if( val_exp < -decdigs )
			{	/* scale and round integer value to get val_exp equal to -decdigs */
				val_exp += (-decdigs - val_exp0);
				val_digs -= (-decdigs - val_exp0);
				val = hDivPow10_ULL( val, -decdigs - val_exp0 );

				if( val == 0 )
				{	/* val is/has been scaled down to zero */
					val_digs = 0;
					val_exp = -decdigs;
				}
				else if( val == hPow10_ULL( val_digs ) )
				{	/* rounding up took val to next power of 10:
					   set value to 1, put val_digs zeroes onto val_exp */
					val = 1;
					val_exp += val_digs;
					val_digs = 1;
				}
			}

			intdigs2 = val_digs + val_exp;
			if( intdigs2 < 0 ) intdigs2 = 0;
			if( addcommas )
				intdigs2 += (intdigs2 - 1) / 3;

			/* compare fixed/floating point representations, 
			   and use the one that needs fewest digits */
			if( intdigs2 > intdigs + MIN_EXPDIGS )
			{	/* too many digits in number for fixed point:
				   switch to floating-point */

				expdigs = MIN_EXPDIGS; /* add three digits for exp notation (was four in QB) */
				toobig = 1;  /* add '%' sign */

				/* restore unscaled value */
				val = val0;
				val_digs = val_digs0;
				val_exp = val_exp0;

				val_zdigs = 0;
			}
			else
			{	/* keep fixed point */

				if( intdigs2 > intdigs )
				{	/* slightly too many digits in number */
					intdigs = intdigs2; /* extend intdigs */
					toobig = 1;         /* add '%' sign */
				}

				if( val_exp > -decdigs)
				{	/* put excess trailing zeroes from val_exp into val_zdigs */
					val_zdigs = val_exp - -decdigs;
					val_exp = -decdigs;
				}
			}
		}
		else
		{
			if( val_isinf )
			{
				if( intdigs < strlen(STR_INF) )
				{
					intdigs = strlen(STR_INF);
					toobig = 1;
				}
			}
			else if( val_isnan )
			{
				if( intdigs < strlen(STR_NAN) )
				{
					intdigs = strlen(STR_NAN);
					toobig = 1;
				}
			}
			else
				DBG_ASSERT( 0 );

			val = 0;
			val_exp = 0;
			val_digs = 0;
			val_zdigs = 0;
		}
	}


	/* floating-point format */
	if( expdigs > 0 )
	{
		addcommas = 0; /* commas unused in f-p format */

		if( intdigs == -1 || (intdigs == 0 && decdigs == 0) )
		{	/* add [another] '%' sign */
			++intdigs;
#if 0
			++toobig;   /* QB could prepend two independent '%'s */
#else
			toobig = 1; /* We'll just stick with one */
#endif
		}

		totdigs = intdigs + decdigs; /* treat intdigs and decdigs the same */
		val_exp += decdigs; /* move decimal position to end */

		/* blank first digit if positive and no explicit sign
		   (pos/neg numbers should be formatted the same where
		   possible, as in QB) */
		if( !isamp && !val_isneg && !(signatini || signatend) )
			if( intdigs >= 1 && totdigs > 1 )
				--totdigs;

		if( val == 0 )
		{
			val_exp = 0;         /* ensure exponent is printed as 0 */
			val_zdigs = decdigs; /* enough trailing zeroes to fill dec part */
		}
		else if( val_digs < totdigs )
		{	/* add "zeroes" to the end of val:
			   subtract from val_exp and put into val_zdigs */
			val_zdigs = totdigs - val_digs ;
			val_exp -= val_zdigs;
		}
		else if( val_digs > totdigs )
		{	/* scale down value */
			val = hDivPow10_ULL( val, val_digs - totdigs );
			val_exp += (val_digs - totdigs);
			val_digs = totdigs;
			val_zdigs = 0;

			if( val >= hPow10_ULL( val_digs ) )
			{	/* rounding up brought val to the next power of 10:
				   add the extra digit onto val_exp */
				val /= 10;
				++val_exp;
			}
		}
		else
			val_zdigs = 0;


		/* output exp part */

		if( val_exp < 0 )
		{
			expsignchar = CHAR_MINUS;
			val_exp = -val_exp;
		}
		else
			expsignchar = CHAR_PLUS;

		/* expdigs > 3 */
		for( ; expdigs > 3; --expdigs )
		{
			ADD_CHAR( CHAR_ZERO + (val_exp % 10) );
			val_exp /= 10;
		}
		
		/* expdigs == 3 */
		if( val_exp > 9 ) /* too many exp digits? */
		{
#if 1		/* Add remaining digits (QB would just crop these) */
			do {
				ADD_CHAR( CHAR_ZERO + (val_exp % 10) );
				val_exp /= 10;
			} while( val_exp > 9 );
			ADD_CHAR( CHAR_ZERO + val_exp );
#endif
			ADD_CHAR( CHAR_TOOBIG ); /* add a '%' sign */
		}
		else
			ADD_CHAR( CHAR_ZERO + val_exp );

		expdigs -= 1;

		/* expdigs == 2 */
		ADD_CHAR( expsignchar );
		ADD_CHAR( CHAR_EXP_SINGLE ); /* QB would use 'D' for doubles */

		expdigs -= 2;
	}


	/* output dec part */
	if( decpoint )
	{
		for( ; decdigs > 0; --decdigs )
		{
			if( val_zdigs > 0 )
			{
				ADD_CHAR( CHAR_ZERO );
				--val_zdigs;
			}
			else if( val_digs > 0 )
			{
				DBG_ASSERT( val > 0 );
				ADD_CHAR( CHAR_ZERO + (val % 10) );
				val /= 10;
				--val_digs;
			}
			else
				ADD_CHAR( CHAR_ZERO );
		}
		ADD_CHAR( CHAR_DOT );
	}


	if( !(val_isinf || val_isnan) )
	{	/* output int part */
		i = 0;
		for( ;; )
		{
			if( addcommas && (i & 3) == 3 && val_digs > 0 )
			{	/* insert comma */
				ADD_CHAR( CHAR_COMMA );
			}
			else
			{
				if( val_zdigs > 0 )
				{
					ADD_CHAR( CHAR_ZERO );
					--val_zdigs;
				}
				else if( val_digs > 0 )
				{
					DBG_ASSERT( val > 0 );
					ADD_CHAR( CHAR_ZERO + (val % 10) );
					val /= 10;
					--val_digs;
				}
				else
				{
					if( i == 0 && intdigs > 0 )
						ADD_CHAR( CHAR_ZERO );
					else
						break;
				}
			}
			DBG_ASSERT( intdigs > 0 );
			++i;
			--intdigs;
		}
	}
	else
	{	/* output INF/NAN string */
		if( val_isinf )
		{
			DBG_ASSERT( intdigs >= strlen(STR_INF) );
			for( i = strlen(STR_INF)-1; i >= 0; --i )
			{
				ADD_CHAR( STR_INF[i] );
				--intdigs;
			}
		}
		else if( val_isnan )
		{
			DBG_ASSERT( intdigs >= strlen(STR_NAN) );
			for( i = strlen(STR_NAN)-1; i >= 0; --i )
			{
				ADD_CHAR( STR_NAN[i] );
				--intdigs;
			}
		}
		else
			DBG_ASSERT( 0 );
	}

	DBG_ASSERT( val == 0 );
	DBG_ASSERT( val_digs == 0 );
	DBG_ASSERT( val_zdigs == 0 );

	DBG_ASSERT( decdigs == 0 );
	DBG_ASSERT( expdigs == 0 );
	DBG_ASSERT( intdigs >= 0 );

	/* output dollar sign? */
	if( adddollar )
		ADD_CHAR( CHAR_DOLLAR );

	/* output sign? */
	if( signatini )
	{
		if( val_isneg )
			ADD_CHAR( CHAR_MINUS );
		else
			ADD_CHAR( plussign? CHAR_PLUS : padchar );
	}

	/* output padding for any remaining intdigs */
	for( ; intdigs > 0; --intdigs )
		ADD_CHAR( padchar );

	/* output '%' sign(s)? */
	for( ; toobig > 0; --toobig )
		ADD_CHAR( CHAR_TOOBIG );


	/**/
	++p;
	fb_PrintFixString( fnum, p, 0 );

	/* ------------------------------------------------------ */

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	/**/
	if( mask & (FB_PRINT_NEWLINE | FB_PRINT_PAD) )
		fb_PrintVoid( fnum, mask & (FB_PRINT_NEWLINE | FB_PRINT_PAD) );

	if( mask & FB_PRINT_ISLAST )
	{
		fb_StrDelete( &ctx->fmtstr );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static unsigned long long hScaleDoubleToULL( double value, int *pval_exp )
{

	/* scale down to a 16-digit number, plus base-10 exponent */

	if( value == 0.0 )
	{
		*pval_exp = 0;
		return 0;
	}
	long double val_ld = value;
	unsigned long long val_ull;
	int val_exp;

	/* find number of digits in double (approximation, may be 1 lower) */

	val_exp = 1 + (int)floor( log10( val_ld ) - 0.5 );

	/* scale down to 16..17 digits (use long doubles to prevent inaccuracy/overflow in pow) */
	val_exp -= 16;
	val_ld /= pow( (long double)10.0, val_exp );
	if( val_ld >= (long double)1.E+16 )
	{
		val_ld /= (long double)10.0;
		++val_exp;
	}

	/* convert to ULL */
	val_ull = (unsigned long long)(val_ld + 0.5);
	DBG_ASSERT( val_ull >= (unsigned long long)1.E+15 || val_ull == 0 );
	DBG_ASSERT( val_ull <= (unsigned long long)1.E+16 );

	*pval_exp = val_exp;
	return val_ull;

}

/*:::::*/
FBCALL int fb_PrintUsingDouble
	(
		int fnum,
		double value,
		int mask
	)
{

	int val_exp;
	int flags;
	unsigned long long val_ull = 1;

	flags = VAL_ISFLOAT;

	if( IS_NEG( value ) )
		flags |= VAL_ISNEG;

	if( IS_ZERO( value ) )
	{
		val_ull = 0;
		val_exp = 0;
	}
	else if( IS_FINITE( value ) )
	{
		value = fabs( value );
		val_ull = hScaleDoubleToULL( value, &val_exp );
	}
	else
	{
		if( IS_INFINITE( value ) )
			flags |= VAL_ISINF;
		else if( IS_NAN( value ) )
			flags |= VAL_ISNAN;
		else
			DBG_ASSERT( 0 );
	}

	return hPrintNumber( fnum, val_ull, val_exp, flags, mask );

}

/*:::::*/
FBCALL int fb_PrintUsingSingle
	(
		int fnum,
		float value_f,
		int mask
	)
{

	int val_exp;
	int flags;
	unsigned long long val_ull = 1;

	flags = VAL_ISFLOAT | VAL_ISSNG;

	if( IS_NEG_F( value_f ) )
		flags |= VAL_ISNEG;

	if( IS_ZERO_F( value_f ) )
	{
		val_ull = 0;
		val_exp = 0;
	}
	else if( IS_FINITE_F( value_f ) )
	{
		value_f = fabs( value_f );
		val_ull = hScaleDoubleToULL( value_f, &val_exp );
	}
	else
	{
		if( IS_INFINITE_F( value_f ) )
			flags |= VAL_ISINF;
		else if( IS_NAN_F( value_f ) )
			flags |= VAL_ISNAN;
		else
			DBG_ASSERT( 0 );
	}

	return hPrintNumber( fnum, val_ull, val_exp, flags, mask );

}

/*:::::*/
FBCALL int fb_PrintUsingULongint
	(
		int fnum,
		unsigned long long value_ull,
		int mask
	)
{

	return hPrintNumber( fnum, value_ull, 0, 0, mask );

}

/*:::::*/
FBCALL int fb_PrintUsingLongint
	(
		int fnum,
		long long val_ll,
		int mask
	)
{

	int flags;
	unsigned long long val_ull;

	if( val_ll < 0 )
	{
		flags = VAL_ISNEG;
		val_ull = -val_ll;
	}
	else
	{
		flags = 0;
		val_ull = val_ll;
	}
	
	return hPrintNumber( fnum, val_ull, 0, flags, mask );

}
