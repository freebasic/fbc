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
 * file_input - input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

static void fb_hGetNextToken( char *buffer, int maxlen, int isstring );

typedef struct _FB_INPCTX {
	FILE 		*f;
	FBSTRING	s;
	int			i;
} FB_INPCTX;

/* FIXME: not thread safe */
static FB_INPCTX ctx = { 0 };


/*:::::*/
FBCALL int fb_FileInput( int fnum )
{

	ctx.f = fb_fileTB[fnum-1].f;

	fb_StrDelete( &ctx.s );


	if( fnum < 1 || fnum > FB_MAX_FILES )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if( fb_fileTB[fnum-1].f == NULL )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;


	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_ConsoleInput( FBSTRING *text, int addquestion, int addnewline )
{

	ctx.f = NULL;
	ctx.i = 0;

	return fb_LineInput( text, &ctx.s, -1, addquestion, addnewline );

}

/*:::::*/
FBCALL int fb_InputByte( char *dst )
{
    char buffer[4+1];

	fb_hGetNextToken( buffer, 4, FB_FALSE );

	*dst = (char)atoi( buffer );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_InputShort( short *dst )
{
    char buffer[6+1];

	fb_hGetNextToken( buffer, 6, FB_FALSE );

	*dst = (short)atoi( buffer );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_InputInt( int *dst )
{
    char buffer[11+1];

	fb_hGetNextToken( buffer, 11, FB_FALSE );

	*dst = (int)atoi( buffer );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_InputSingle( float *dst )
{
    char buffer[15+1];

	fb_hGetNextToken( buffer, 15, FB_FALSE );

	*dst = (float)atof( buffer );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_InputDouble( double *dst )
{
    char buffer[21+1];

	fb_hGetNextToken( buffer, 21, FB_FALSE );

	*dst = (double)atof( buffer );

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_InputString( void *dst, int strlen )
{
    char buffer[1024+1];

	fb_hGetNextToken( buffer, 1024, FB_TRUE );

	fb_StrAssign( dst, strlen, buffer, 1024 );

	return FB_RTERROR_OK;
}

/*****************************************************************************/
/* low level 																 */
/*****************************************************************************/

/*:::::*/
static int fb_hReadChar( void )
{

	if( ctx.f != NULL )
		return fgetc( ctx.f );
	else
	{
		if( ctx.i >= FB_STRSIZE( &ctx.s ) )
			return EOF;
		else
			return (int)ctx.s.data[ctx.i++];
	}

}

/*:::::*/
static int fb_hUnreadChar( int c )
{

	if( ctx.f != NULL )
		return ungetc( c, ctx.f );
	else
	{
		if( ctx.i <= 0 )
			return 0;
		else
		{
			--ctx.i;
			return 1;
		}
	}

}

/*:::::*/
static void fb_hGetNextToken( char *buffer, int maxlen, int isstring )
{
    int 	c, len, isquote;
    char    *p;

	/* skip white spc */
	while( (c = fb_hReadChar( )) != EOF )
		if( (c != 32) && (c != 9) && (c != 10) && (c != 13) )
		{
			fb_hUnreadChar( c );
			break;
		}

	/* */
	isquote = 0;
	p = buffer;
	len = 0;
	while( (c = fb_hReadChar( )) != EOF )
	{
		switch( c )
		{
		case 10:
			len = maxlen;						/* exit */
			break;

		case 13:
			if( (c = fb_hReadChar( )) != 10 )
				fb_hUnreadChar( c );

			len = maxlen;						/* exit */
			break;

		case '"':
			if( !isquote )
			{
				isquote = 1;
			}
			else
			{
				isquote = 0;
				if( isstring )
					len = maxlen;				/* exit */
			}

			break;

		case ',':
			if( !isquote )
			{
				len = maxlen;					/* exit */
				break;
			}

			goto savechar;

		case 9:
		case ' ':
			if( len == 0 )
			{
				break;							/* skip white-space */
			}
			else if( !isstring && !isquote )
			{
				len = maxlen;					/* exit */
				break;
			}

		default:
savechar:
			*p++ = (char)c;
			++len;
		}

		if( len >= maxlen )
			break;
	}

	/* null term */
	*p = '\0';

}
