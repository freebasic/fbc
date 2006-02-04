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
 * io_printusg - print using function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "fb.h"
#include "fb_rterr.h"

#define BUFFERLEN 2048

static int fb_PrintUsingFmtStr( int fnum );


/*:::::*/
FBCALL int fb_PrintUsingInit( FBSTRING *fmtstr )
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
FBCALL int fb_PrintUsingEnd( int fnum )
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
static int fb_PrintUsingFmtStr( int fnum )
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1];
	int c, len, doexit;

	ctx = FB_TLSGETCTX( PRINTUSG );

	len = 0;
	if( ctx->ptr == 0 )
		ctx->chars = 0;

	while( (ctx->chars > 0) && (len < BUFFERLEN) )
	{
		c = *ctx->ptr;

		doexit = 0;
		switch( c )
		{
		case '!':
		case '\\':
		case '&':
		case '+':
		case ',':
		case '$':
		case '*':
		case '.':
		case '#':
			doexit = 1;
			break;

		case '_':
			c = *(ctx->ptr+1);
			++ctx->ptr;
			--ctx->chars;
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
FBCALL int fb_PrintUsingStr( int fnum, FBSTRING *s, int mask )
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

	if( ctx->ptr == 0 )
		ctx->chars = 0;

	while( ctx->chars > 0 )
    {
		c = *ctx->ptr;

		if( ctx->chars > 1 )
			nc = *(ctx->ptr+1);
		else
			nc = -1;

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
			if( nc == ' ' || strchars != -1 )
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


/*:::::*/
FBCALL int fb_PrintUsingVal( int fnum, double value, int mask )
{
	FB_PRINTUSGCTX *ctx;
	char buffer[BUFFERLEN+1], expbuff[16+1+1+1], *p;
	int c, nc, lc, d, i, j, len, intlgt;
	int doexit, padchar, intdigs, decdigs, totdigs, expdigs;
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

	if( ctx->ptr == 0 )
		ctx->chars = 0;

	while( ctx->chars > 0 )
	{

		c = *ctx->ptr;

		if( ctx->chars > 1 )
			nc = *(ctx->ptr+1);
		else
			nc = -1;

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
	isneg = value < 0.0f;
	value = fabs( value );

	/* forced sign? */
	if( !signatend && isneg )
	{
		signatini = 1;
		/* one digit less.. */
		if( intdigs > 0 )
			--intdigs;
	}

	if( decdigs <= 0 )
		totdigs = intdigs;
	else
		totdigs = intdigs+decdigs;

	if( totdigs <= 0 )
		totdigs = 1;
	else if( totdigs > 15 )
		totdigs = 15;

	value_exp = (int)floor( log10( value ) );
	/* exponent too big? scale */
	if( value_exp >= 0 )
	{
		if( value_exp >= intdigs )
		{
			value_exp -= (intdigs-1);
			value /= pow( 10.0f, value_exp );
		}
		else
			value_exp = 0;
	}
	else
	{
		if( -value_exp >= decdigs )
		{
			value_exp -= (intdigs-1);
			value *= pow( 10.0f, -value_exp );
		}
		else
			value_exp = 0;
	}

	/* convert to string */
	fb_hFloat2Str( value, buffer, totdigs, FB_F2A_NOEXP );

	len = strlen( buffer );

	/* no integer digits? */
	if( intdigs == 0 )
	{
		/* is it a 0? remove.. */
		if( buffer[0] == '0' )
		{
			memmove( buffer, &buffer[1], len-1 + 1 );
			--len;
		}
	}

	/* any decimal places? */
	p = strchr( buffer, '.' );
	if( p == NULL )
		d = 0;
	else
		d = (int)(p - buffer) + 1;

	/* no decimal digits? */
	if( d == 0 )
		/* but stills need to print some? */
		if( decdigs > 0 )
		{
			/* create a dec digit in the end */
			strcat( buffer, "." );
			++len;
			d = len;
		}

	if( d == 0 )
		intlgt = len;
	else
		intlgt = d - 1;

	/* separate with commas? */
	if( addcomma )
	{
		len = strlen( buffer );
		p = &buffer[intlgt-1];
		for( i = intlgt, j = 0; i > 0; i--, p-- )
		{
			++j;
			if( j == 3 )
			{
				if( i > 1 )
				{
					memmove( p+1, p, len-i+1+1 );
					*p = ',';
					++len;
					++intlgt;
				}
				j = 0;
			}
		}
	}

	/* prefix with a dollar sign? */
	if( adddolar )
	{
		memmove( &buffer[1], buffer, strlen( buffer )+1 );
		buffer[0] = '$';
	}

	/* sign */
	if( signatini )
	{
		memmove( &buffer[1], buffer, strlen( buffer )+1 );
		buffer[0] = (isneg? '-' : '+');

		++intlgt;
		isneg = 0;						/* QB quirk */
	}

	/* padding */
	if( intdigs > 0 )
	{
		intdigs -= intlgt;

		if( intdigs > 0 )
		{
			memmove( &buffer[intdigs], buffer, strlen( buffer )+1 );
			memset( buffer, padchar, intdigs );
		}
	}

	/**/
	if( decdigs > 0 )
	{
		p = strchr( buffer, '.' );
		if( p == NULL )
			d = 0;
		else
			d = (int)(p - buffer) + 1;

		len = strlen( buffer );
		decdigs -= (len - d);
		if( decdigs > 0 )
		{
			memset( &buffer[len], '0', decdigs );
			buffer[len+decdigs] = '\0';
		}
		else if( decdigs < 0 )
			buffer[len+decdigs] = '\0';
	}
	else
	{
		p = strchr( buffer, '.' );
		if( p != NULL )
			*p = '\0';
	}

	/* add exponent? */
	if( isexp )
	{
		sprintf( expbuff, "e%+d", value_exp );
		value_exp = 0;

		if( expdigs > 0 )
		{
			len = strlen( expbuff );
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
				memmove( &expbuff[2+diff], &expbuff[2], diff+1 );
				memset( &expbuff[2], '0', diff );
			}
		}

		strcat( buffer, expbuff );
	}

	/* sign */
	if( signatend )
	{
		strcat( buffer, (isneg? "-" : "+") );
	}

	if( endcomma )
		strcat( buffer, "," );

	/* too big? */
	if( value_exp != 0 )
	{
		sprintf( expbuff, "%%e%+d", value_exp );
		strcat( buffer, expbuff );
	}


	/**/
	fb_PrintFixString( fnum, buffer, 0 );

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

