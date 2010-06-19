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
 * str_cvmk.c -- CV# and MK#$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
static void hCV( FBSTRING *str, int len, void *num )
{
	int	i;

	if( (str->data != NULL) && (FB_STRSIZE( str ) >= len) )
	{
		for( i = 0; i < len; i++ )
			((char *)num)[i] = str->data[i];
	}

	/* del if temp */
	fb_hStrDelTemp( str );
}

/*:::::*/
FBCALL double fb_CVD ( FBSTRING *str )
{
    double num;

	if( str == NULL )
		return 0.0;

	num = 0.0;
	hCV( str, sizeof( double ), &num );

	return num;
}

/*:::::*/
FBCALL float fb_CVS ( FBSTRING *str )
{
    float num;

	if( str == NULL )
		return 0.0;

	num = 0.0;
	hCV( str, sizeof( float ), &num );

	return num;
}

/*:::::*/
FBCALL int fb_CVI ( FBSTRING *str )
{
    int	num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( int ), &num );

	return num;
}

/*:::::*/
FBCALL short fb_CVSHORT ( FBSTRING *str )
{
    short num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( short ), &num );

	return num;
}

/*:::::*/
FBCALL long long fb_CVLONGINT ( FBSTRING *str )
{
    long long num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( long long ), &num );

	return num;
}

/*:::::*/
static FBSTRING *hMK( int len, void *num )
{
	int	i;
	FBSTRING *dst;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, len );
	if( dst != NULL )
	{
		/* convert */
		for( i = 0; i < len; i++ )
			dst->data[i] = ((char *)num)[i];

		dst->data[len] = '\0';
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_MKD ( double num )
{
	return hMK( sizeof( double ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKS ( float num )
{
	return hMK( sizeof( float ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKI ( int num )
{
	return hMK( sizeof( int ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKSHORT ( short num )
{
	return hMK( sizeof( short ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKLONGINT ( long long num )
{
	return hMK( sizeof( long long ), &num );
}



