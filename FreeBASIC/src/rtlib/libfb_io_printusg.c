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

static int fb_PrintUsingFmtStr( int fnum );


/*:::::*/
FBCALL int fb_PrintUsingInit( FBSTRING *fmtstr )
{
	FBSTRING s;
	
	s.data = (char *)FB_TLSGET( fb_printusgctx.fmtstr.data );
	s.len = (int)FB_TLSGET( fb_printusgctx.fmtstr.len );
	s.size = (int)FB_TLSGET( fb_printusgctx.fmtstr.size );
	fb_StrAssign( (void *)&s, -1, fmtstr, -1, 0 );

	FB_TLSSET( fb_printusgctx.fmtstr.data, s.data );
	FB_TLSSET( fb_printusgctx.fmtstr.len, s.len );
	FB_TLSSET( fb_printusgctx.fmtstr.size, s.size );

	FB_TLSSET( fb_printusgctx.ptr, s.data );
	FB_TLSSET( fb_printusgctx.chars, FB_STRSIZE( &s ) );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_PrintUsingEnd( int fnum )
{
	FBSTRING s;
	
	fb_PrintUsingFmtStr( fnum );

	s.data = (char *)FB_TLSGET( fb_printusgctx.fmtstr.data );
	s.len = (int)FB_TLSGET( fb_printusgctx.fmtstr.len );
	s.size = (int)FB_TLSGET( fb_printusgctx.fmtstr.size );
	fb_StrDelete( &s );
	FB_TLSSET( fb_printusgctx.fmtstr.data, s.data );
	FB_TLSSET( fb_printusgctx.fmtstr.len, s.len );
	FB_TLSSET( fb_printusgctx.fmtstr.size, s.size );

	FB_TLSSET( fb_printusgctx.ptr, 0 );
	FB_TLSSET( fb_printusgctx.chars, 0 );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int fb_PrintUsingFmtStr( int fnum )
{
	char 	buffer[BUFFERLEN+1], *ptr;
	int 	c, len;
	int 	doexit;

	len = 0;
	if( FB_TLSGET( fb_printusgctx.ptr ) == 0 )
		FB_TLSSET( fb_printusgctx.chars, 0 );

	while( ((int)FB_TLSGET( fb_printusgctx.chars ) > 0) && (len < BUFFERLEN) )
	{
		ptr = (char *)FB_TLSGET( fb_printusgctx.ptr );
		c = *ptr;

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
			c = *(ptr+1);
			++ptr;
			FB_TLSSET( fb_printusgctx.ptr, ptr );
			FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );
		}

		if( doexit )
			break;

		buffer[len++] = (char)c;

		FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
		FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );
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
	FBSTRING aux;
	char 	buffer[BUFFERLEN+1], *ptr;
	int 	c, nc, lc;
	int 	strchars, doexit, i;

    /* restart if needed */
	if( FB_TLSGET( fb_printusgctx.chars ) == 0 )
	{
		FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.fmtstr.data ) );
		FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.fmtstr.len ) & ~FB_TEMPSTRBIT );
	}

	/* any text first */
	fb_PrintUsingFmtStr( fnum );

	FB_STRLOCK();

	strchars = -1;

	if( FB_TLSGET( fb_printusgctx.ptr ) == 0 )
		FB_TLSSET( fb_printusgctx.chars, 0 );

	while( (int)FB_TLSGET( fb_printusgctx.chars ) > 0 )
    {
    	ptr = (char *)FB_TLSGET( fb_printusgctx.ptr );
		c = *ptr;

		if( (int)FB_TLSGET( fb_printusgctx.chars ) > 1 )
			nc = *(ptr+1);
		else
			nc = -1;

		doexit = 1;
		switch( c )
		{
		case '!':
			buffer[0] = s->data[0];
			buffer[1] = '\0';
			fb_PrintFixString( fnum, buffer, 0 );

			FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
			FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );
			break;

		case '&':
			fb_PrintFixString( fnum, s->data, 0 );

			FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
			FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );
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
						memcpy( buffer, s->data, strchars );
						buffer[strchars] = '\0';
						fb_PrintFixString( fnum, buffer, 0 );
					}

					FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
					FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );
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

		FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
		FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );

		lc = c;
	}

	/* any text */
	fb_PrintUsingFmtStr( fnum );

	//
	if( mask & FB_PRINT_ISLAST )
	{
		if( mask & FB_PRINT_NEWLINE )
			fb_PrintVoid( fnum, FB_PRINT_NEWLINE );

		aux.data = (char *)FB_TLSGET( fb_printusgctx.fmtstr.data );
		aux.len = (int)FB_TLSGET( fb_printusgctx.fmtstr.len );
		aux.size = (int)FB_TLSGET( fb_printusgctx.fmtstr.size );
#ifdef MULTITHREADED
		fb_hStrDeleteLocked( &aux );
#else
		fb_StrDelete( &aux );
#endif
		FB_TLSSET( fb_printusgctx.fmtstr.data, aux.data );
		FB_TLSSET( fb_printusgctx.fmtstr.len, aux.len );
		FB_TLSSET( fb_printusgctx.fmtstr.size, aux.size );
	}

	/* del if temp */
	fb_hStrDelTemp( s );

	FB_STRUNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_PrintUsingVal( int fnum, double value, int mask )
{
	FBSTRING s;
	char 	buffer[BUFFERLEN+1], *p, *ptr;
	int 	c, nc, lc, d, i, j, len, intlgt;
	int 	doexit, padchar, intdigs, decdigs, totdigs;
	int		adddolar, addcomma, endcomma, signatend, isexp, isneg;


    /* restart if needed */
	if( FB_TLSGET( fb_printusgctx.chars ) == 0 )
	{
		FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.fmtstr.data ) );
		FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.fmtstr.len ) & ~FB_TEMPSTRBIT );
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

	if( FB_TLSGET( fb_printusgctx.ptr ) == 0 )
		FB_TLSSET( fb_printusgctx.chars, 0 );

	while( (int)FB_TLSGET( fb_printusgctx.chars ) > 0 )
	{
	
		ptr = (char *)FB_TLSGET( fb_printusgctx.ptr );
		c = *ptr;

		if( (int)FB_TLSGET( fb_printusgctx.chars ) > 1 )
			nc = *(ptr+1);
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

		FB_TLSSET( fb_printusgctx.ptr, (char *)FB_TLSGET( fb_printusgctx.ptr ) + 1 );
		FB_TLSSET( fb_printusgctx.chars, (int)FB_TLSGET( fb_printusgctx.chars ) - 1 );

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
		if( decdigs <= 0 )
			totdigs = intdigs;
		else
			totdigs = intdigs+decdigs-1;

		if( totdigs <= 0 )
			totdigs = 1;
		else if( totdigs > 16 )
			totdigs = 16;

		fb_hFloat2Str( value, buffer, totdigs, FB_F2A_NOEXP );

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
	if( !signatend && isneg )
	{
		memmove( &buffer[1], buffer, strlen( buffer )+1 );
		buffer[0] = '-';

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
		else if( decdigs < 0 )
			buffer[len+decdigs] = '\0';
	}
	else
	{
		p = strchr( buffer, '.' );
		if( p != NULL )
			*p = '\0';
	}


	// neg
	if( signatend && isneg )
	{
		strcat( buffer, "-" );
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

		s.data = (char *)FB_TLSGET( fb_printusgctx.fmtstr.data );
		s.len = (int)FB_TLSGET( fb_printusgctx.fmtstr.len );
		s.size = (int)FB_TLSGET( fb_printusgctx.fmtstr.size );
		fb_StrDelete( &s );
		FB_TLSSET( fb_printusgctx.fmtstr.data, s.data );
		FB_TLSSET( fb_printusgctx.fmtstr.len, s.len );
		FB_TLSSET( fb_printusgctx.fmtstr.size, s.size );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

