/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
#include "fb.h"
#include "fb_rterr.h"

#define BUFFERLEN 2048

typedef struct _FB_PRINTUSGCTX {
	FBSTRING	fmtstr;
	int			chars;
	char		*ptr;
} FB_PRINTUSGCTX;


static int fb_PrintUsingFmtStr( int fnum );


/* FIXME: not thread safe */
static FB_PRINTUSGCTX ctx = { 0 };


/*:::::*/
FBCALL int fb_PrintUsingInit( FBSTRING *fmtstr )
{

	fb_StrAssign( (void *)&ctx.fmtstr, -1, fmtstr, -1 );

	ctx.ptr		= ctx.fmtstr.data;
	ctx.chars	= FB_STRSIZE( &ctx.fmtstr );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_PrintUsingEnd( int fnum )
{

	fb_PrintUsingFmtStr( fnum );

	fb_StrDelete( &ctx.fmtstr );

	ctx.ptr		= NULL;
	ctx.chars	= 0;

	return FB_RTERROR_OK;
}

/*:::::*/
static int fb_PrintUsingFmtStr( int fnum )
{
	char 	buffer[BUFFERLEN+1];
	int 	c, len;
	int 	doexit;

	len = 0;
	if( ctx.ptr == NULL )
		ctx.chars = 0;

	while( (ctx.chars > 0) && (len < BUFFERLEN) )
	{
		c = *ctx.ptr;

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
			c = *(ctx.ptr+1);
			++ctx.ptr;
			--ctx.chars;
		}

		if( doexit )
			break;

		buffer[len++] = (char)c;

		++ctx.ptr;
		--ctx.chars;
	}

    /* flush */
    if( len > 0 )
    {
    	buffer[len] = '\0';
    	fb_PrintFixString( fnum, buffer, 0 );
    }

	return FB_RTERROR_OK;
}


/*:::::*/
FBCALL int fb_PrintUsingStr( int fnum, FBSTRING *s, int mask )
{
	char 	buffer[BUFFERLEN+1];
	int 	c, nc, lc;
	int 	strchars, doexit, i;

    /* restart if needed */
	if( ctx.chars == 0 )
	{
		ctx.ptr	  = ctx.fmtstr.data;
		ctx.chars = FB_STRSIZE( &ctx.fmtstr );
	}

	/* any text first */
	fb_PrintUsingFmtStr( fnum );


	strchars = -1;

	if( ctx.ptr == NULL )
		ctx.chars = 0;

	while( ctx.chars > 0 )
    {
		c = *ctx.ptr;

		if( ctx.chars > 1 )
			nc = *(ctx.ptr+1);
		else
			nc = -1;

		doexit = 1;
		switch( c )
		{
		case '!':
			buffer[0] = s->data[0];
			buffer[1] = '\0';
			fb_PrintFixString( fnum, buffer, 0 );

			++ctx.ptr;
			--ctx.chars;
			break;

		case '&':
			fb_PrintFixString( fnum, s->data, 0 );

			++ctx.ptr;
			--ctx.chars;
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

						for( i = 0; i < strchars - FB_STRSIZE( s ); i++ )
							buffer[i] = ' ';
						buffer[i] = '\0';

						fb_PrintFixString( fnum, buffer, 0 );
					}
					else
					{
						strncpy( buffer, s->data, strchars );
						buffer[strchars] = '\0';
						fb_PrintFixString( fnum, buffer, 0 );
					}

					++ctx.ptr;
					--ctx.chars;
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

		++ctx.ptr;
		--ctx.chars;

		lc = c;
	}

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	//
	if( mask & FB_PRINT_ISLAST )
	{
		if( mask & FB_PRINT_NEWLINE )
			fb_PrintVoid( fnum, FB_PRINT_NEWLINE );

		fb_StrDelete( &ctx.fmtstr );
	}

	/* del if temp */
	fb_hStrDelTemp( s );

	return FB_RTERROR_OK;
}


/*:::::*/
FBCALL int fb_PrintUsingVal( int fnum, double value, int mask )
{
	char 	buffer[BUFFERLEN+1], *p;
	int 	c, nc, lc, d, i, j, len, intlgt;
	int 	doexit, padchar, intdigs, decdigs;
	int		adddolar, addcomma, endcomma, signatend, isexp, isneg;


    /* restart if needed */
	if( ctx.chars == 0 )
	{
		ctx.ptr	  = ctx.fmtstr.data;
		ctx.chars = FB_STRSIZE( &ctx.fmtstr );
	}

	/* any text first */
	fb_PrintUsingFmtStr( fnum );

	//
	padchar 	= ' ';
	intdigs 	= 0;
	decdigs 	= -1;
	adddolar 	= 0;
	addcomma	= 0;
	endcomma 	= 0;
	signatend 	= 0;
	isexp 		= 0;

	lc = -1;

	if( ctx.ptr == NULL )
		ctx.chars = 0;

	while( ctx.chars > 0 )
	{

		c = *ctx.ptr;

		if( ctx.chars > 1 )
			nc = *(ctx.ptr+1);
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
			break;

		case '^':
			if( nc == '^' || lc == '^' )
				isexp = 1;
			break;

		default:
			doexit = 1;
		}

		if( doexit )
			break;

		++ctx.ptr;
		--ctx.chars;

		lc = c;
	}

	/* ------------------------------------------------------ */

	//
	if( isexp )
	{
    	sprintf( buffer, "%e", value );
        len = strlen( buffer );
	}
	else
	{
		fb_hFloat2Str( value, buffer, 16, FB_FALSE );

		len = strlen( buffer );
		if( buffer[len-1] == '.' )
		{
			buffer[len-1] = '\0';
			--len;
		}
	}

	//
	if( buffer[0] == '-' )
	{
      	memmove( buffer, &buffer[1], len-1 + 1 );
		isneg = 1;
		--len;
	}
	else
		isneg = 0;

	//
	p = strchr( buffer, '.' );
	if( p == NULL )
		d = 0;
	else
		d = (int)(p - buffer) + 1;

	if( d == 0 )
		if( decdigs > 0 )
		{
			strcat( buffer, "." );
			++len;
			d = len;
		}

	if( d == 0 )
		intlgt = len;
	else
		intlgt = d - 1;

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

	//
	if( adddolar )
	{
		memmove( &buffer[1], buffer, strlen( buffer )+1 );
		buffer[0] = '$';
	}

	// neg
	if( !signatend )
	{
		memmove( &buffer[1], buffer, strlen( buffer )+1 );
		if( isneg )
			buffer[0] = '-';
		else
			buffer[0] = ' ';

		++intlgt;
	}

	// padding
	if( intdigs > 0 )
	{
		intdigs -= intlgt;

		if( intdigs > 0 )
		{
			memmove( &buffer[intdigs], buffer, strlen( buffer )+1 );
			memset( buffer, padchar, intdigs );
		}
	}

	//
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
	}

	// neg
	if( signatend )
	{
		if( isneg )
			strcat( buffer, "-" );
		else
			strcat( buffer, " " );
	}

	if( endcomma )
		strcat( buffer, "," );

	//
	fb_PrintFixString( fnum, buffer, 0 );

	/* ------------------------------------------------------ */

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	//
	if( mask & FB_PRINT_ISLAST )
	{
		if( mask & FB_PRINT_NEWLINE )
			fb_PrintVoid( fnum, FB_PRINT_NEWLINE );

		fb_StrDelete( &ctx.fmtstr );
	}

	return FB_RTERROR_OK;
}

