/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 * io_printusg - print using function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "fb.h"

#define BUFFERLEN 2048

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
static int fb_PrintUsingFmtStr
	( 
		int fnum 
	)
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1];
	int c, lc, nc, len, doexit;

	ctx = FB_TLSGETCTX( PRINTUSG );

	len = 0;
	if( ctx->ptr == NULL )
		ctx->chars = 0;

	lc = -1;
	while( (ctx->chars > 0) && (len < BUFFERLEN) )
	{
		c = *ctx->ptr;
		nc = ( ctx->chars > 1? ctx->ptr[1] : -1 );

		doexit = 0;
		switch( c )
		{
		case '*':
			if( nc == '*' || lc == '*' )
				doexit = 1;

			break;

		case '$':
			if( nc == '$' || lc == '$' || lc == '*' )
				doexit = 1;

			break;

		case '!':
		case '\\':
		case '&':
		case '+':
		case ',':
		case '#':
			doexit = 1;
			break;

		case '.':
			if( nc == '#' || lc == '#' )
				doexit = 1;

			break;

		case '_':
			c = nc;
			if( ctx->chars > 1 )
			{
				++ctx->ptr;
				--ctx->chars;
			}
		}

		if( doexit )
			break;

		buffer[len++] = (char)c;

		++ctx->ptr;
		--ctx->chars;

		lc = c;
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
	int c, nc, lc, strchars, doexit, i;

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
			buffer[0] = s->data[0];
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

		lc = c;
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
static double hRound
	( 
		double value, 
		int intdigs, 
		int decdigs 
	)
{
	double fix, frac = modf( value, &fix );

    if( decdigs == 0 )
    {
    	/* convert to fixed-point because the imprecision and the optimizations
       	   that can be done by gcc (ie: keeping values on fpu stack as twords) */
    	long long int intfrac = (long long int)(frac * 1.E+15);
    	if( intfrac > (long long int)(5.E+14) )
       		fix = ceil( value );
		else if( intfrac < -(long long int)(5.E+14) )
       		fix = floor( value );

       	value = fix;
	}
	else
	{
		/* remove the fraction of the fraction to be compatible with
		   VBDOS (ie: 2.55 -> 2.5, not 2.6 as in VB6) */
		if( frac != 0.0 )
		{
	    	double p10 = pow( 10.0, decdigs );

	        double fracfrac = modf( frac * p10, &frac );

	        /* convert to fixed-point, see above */
	        long long int intfrac = (long long int)(fracfrac * (1.E+15 / p10) );

	        if( intfrac > (long long int)(5.E+14 / p10) )
	        	frac += 1.0;
	        else if( intfrac < -(long long int)(5.E+14 / p10) )
	        	frac += -1.0;

	        frac /= p10;

	        value = fix + frac;
		}
	}

	return value;
}

/*::::*/
static void hToString
	( 
		double value,
		char *fix_buf, 
		int *fix_len,
		char *frac_buf, 
		int *frac_len,
		int intdigs,
		int decdigs 
	)
{
	double fix, frac = modf( value, &fix );

	if( decdigs > 0 )
	{
		*frac_len = sprintf( frac_buf, "%.*f", decdigs, fabs( frac ) ) - 1;
		/* remove the "0" in the fix-part */
		memmove( frac_buf, &frac_buf[1], *frac_len + 1 );
	}
	else
	{
        *frac_len = 0;
        frac_buf[0] = '\0';
	}

	if( intdigs > 0 )
	{
		*fix_len = sprintf( fix_buf, "%" FB_LL_FMTMOD "d", (long long int)fix );
	}
	else
	{
        *fix_len = 0;
        fix_buf[0] = '\0';
	}
}

/*:::::*/
static int hPrintDouble
	( 
		int fnum, 
		double value, 
		int mask, 
		int maxdigits 
	)
{
	FB_PRINTUSGCTX *ctx;
	char fix_buf[BUFFERLEN+1], frac_buf[16+1+1], expbuff[16+1+1+1];
	int fix_len, frac_len;
	int c, nc, lc;
	int doexit, padchar, intdigs, decdigs, totdigs, expdigs, doscale;
	int	adddolar, addcomma, endcomma, signatend, signatini;
	int isexp, isneg, value_exp;

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
	padchar 	= ' ';
	intdigs 	= 0;
	decdigs 	= -1;
	expdigs		= 0;
	adddolar 	= 0;
	addcomma	= 0;
	endcomma 	= 0;
	signatend 	= 0;
	signatini	= 0;
	isexp 		= 0;

	lc = -1;

	if( ctx->ptr == NULL )
		ctx->chars = 0;

	while( ctx->chars > 0 )
	{
		c = *ctx->ptr;
        nc = ( ctx->chars > 1? ctx->ptr[1] : -1 );

		doexit = 0;
		switch( c )
		{
		case '#':
			if( decdigs != -1 )
				++decdigs;
			else
				++intdigs;
			break;

		case '.':
			decdigs = 0;
			break;

		case '*':
			if( nc == '*' || lc == '*' )
				padchar = '*';
			else
				doexit = 1;
			break;

		case '$':

			if( nc == '$' || lc == '$' || lc == '*' )
				adddolar = 1;
			else
				doexit = 1;
			break;

		case ',':
			if( nc == '#' )
			{
				if( addcomma == 0 )
					++intdigs;
				addcomma = 1;
			}
			else
				endcomma = 1;
			break;

		case '+':
			if( intdigs > 0 )
				signatend = 1;
			else
				signatini = 1;
			break;

		case '^':
			++expdigs;
			isexp = 1;
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

	/**/
	isneg = value < 0.0;
	value = fabs( value );

	/* forced sign? */
	if( !signatend && isneg )
	{
		signatini = 1;
		/* one digit less.. */
		if( intdigs > 0 )
			--intdigs;
	}

	/* check digits */
	if( decdigs <= 0 )
		totdigs = intdigs;
	else
	{
		if( decdigs > maxdigits )
			decdigs = maxdigits;

		totdigs = intdigs + decdigs;
	}

	if( totdigs <= 0 )
		totdigs = 1;
	else if( totdigs > maxdigits )
		totdigs = maxdigits;

	/* calc exponent */
	if( value != 0.0 )
		value_exp = (int)floor( log10( value ) ) + 1;
	else
		value_exp = 0;

	/* scale up if too small, hRound() will chop the fractional part */
	doscale = TRUE;
	if( value_exp < 0 )
	{
		if( abs( value_exp ) > decdigs-1 )
		{
			value_exp -= intdigs;
			value *= pow( 10.0, -value_exp );
			doscale = FALSE;
		}
		else
			value_exp = 0;
	}

	/* round & chop */
	value = hRound( value, intdigs, (decdigs >= 0? decdigs : 0) );

	if( doscale )
	{
		/* scall down if it's big - must be done after hRound() */
		if( value_exp > 0 )
		{
			if( value_exp > intdigs )
			{
				value_exp -= intdigs;
				value *= pow( 10.0, -value_exp );
			}
			else
				value_exp = 0;
		}
	}

	/* convert to string */
	hToString( value, fix_buf, &fix_len, frac_buf, &frac_len, intdigs,
			   (decdigs >= 0? decdigs : 0) );

	/* separate with commas? */
	if( addcomma )
	{
		int i, j;
		char *p = &fix_buf[fix_len-1];
		for( i = fix_len, j = 0; i > 0; i--, p-- )
		{
			++j;
			if( j == 3 )
			{
				if( i > 1 )
				{
					memmove( p+1, p, fix_len-i+1+1 );
					*p = ',';
					++fix_len;
				}
				j = 0;
			}
		}
	}

	/* prefix with a dollar sign? */
	if( adddolar )
	{
		memmove( &fix_buf[1], fix_buf, fix_len+1 );
		fix_buf[0] = '$';
		++fix_len;
	}

	/* sign */
	if( signatini )
	{
		memmove( &fix_buf[1], fix_buf, fix_len+1 );
		fix_buf[0] = (isneg? '-' : '+');
		++fix_len;
		isneg = 0;						/* QB quirk */
	}

	/* padding */
	if( intdigs > 0 )
	{
		intdigs -= fix_len;

		if( intdigs > 0 )
		{
			memmove( &fix_buf[intdigs], fix_buf, fix_len+1 );
			memset( fix_buf, padchar, intdigs );
			fix_len += intdigs;
		}
	}

	/* any fractional part? */
	if( decdigs > 0 )
	{
		strcat( fix_buf, frac_buf );
		fix_len += frac_len;

		decdigs -= frac_len;
		if( decdigs > 0 )
		{
			memset( &fix_buf[fix_len], '0', decdigs );
			frac_buf[fix_len+decdigs] = '\0';
		}
	}
	/* but period must be added? */
	else if( decdigs == 0 )
		strcat( fix_buf, "." );

	/* add exponent? */
	if( isexp )
	{
		sprintf( expbuff, "e%+d", value_exp );
		value_exp = 0;

		if( expdigs > 0 )
		{
			int len = strlen( expbuff );
			if( len > expdigs )
			{
				if( expdigs > 2 )
					memmove( &expbuff[2], &expbuff[len-(expdigs-2)], expdigs-2+1 );
				else
					expbuff[expdigs] = '\0';
			}
			else if( len < expdigs )
			{
				int diff = expdigs - len;
				memmove( &expbuff[2+diff], &expbuff[2], len-2+1 );
				memset( &expbuff[2], '0', diff );
			}
		}

		strcat( fix_buf, expbuff );
	}

	/* sign */
	if( signatend )
	{
		strcat( fix_buf, (isneg? "-" : "+") );
	}

	if( endcomma )
		strcat( fix_buf, "," );

	/* too big? */
	if( value_exp != 0 )
	{
		sprintf( expbuff, "%%e%+d", value_exp );
		strcat( fix_buf, expbuff );
	}


	/**/
	fb_PrintFixString( fnum, fix_buf, 0 );

	/* ------------------------------------------------------ */

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	/**/
	if( mask & FB_PRINT_ISLAST )
	{
		if( mask & FB_PRINT_NEWLINE )
			fb_PrintVoid( fnum, FB_PRINT_NEWLINE );

		fb_StrDelete( &ctx->fmtstr );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_PrintUsingDouble
	( 
		int fnum, 
		double value, 
		int mask 
	)
{
	return hPrintDouble( fnum, value, mask, 16 );
}

/*:::::*/
FBCALL int fb_PrintUsingSingle
	( 
		int fnum, 
		float value_f, 
		int mask
	)
{
	double value = value_f;
	int value_exp;

	if( value != 0.0 )
	{
		value_exp = (int)floor( log10( fabs( value ) ) ) + 1;

		/* fix dizima */
		if( value_exp <= 0 )
			value += pow( 10.0, value_exp - 7 );
		else
			value += pow( 10.0, -(value_exp + 7) );
	}

	return hPrintDouble( fnum, value, mask, 7 );
}

/* !!!FIXME!! remove this function when the chicken-egg is over */

FBCALL int fb_PrintUsingVal
	( 
		int fnum, 
		double value, 
		int mask 
	)
{
	return fb_PrintUsingDouble( fnum, value, mask );
}

