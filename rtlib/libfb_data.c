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
 * data.c -- restore and read stmts
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"


char *fb_dataptr = NULL;

#define FB_DATA_LINK -1


/*:::::*/
FBCALL void fb_DataRestore( char *labeladdr )
{
	fb_dataptr = labeladdr;
}

static short fb_hDataRead( void )
{
	short len;

	if( fb_dataptr == NULL )
		return 0;

	len = *((short *)fb_dataptr)++;

	/* link? */
	while ( len == FB_DATA_LINK )
	{
		fb_dataptr = (char *)(*(int *)fb_dataptr);
		if( fb_dataptr == NULL )
			return 0;

		len = *((short *)fb_dataptr)++;
	}

	return len;
}

/*:::::*/
FBCALL void fb_DataReadStr( void *dst, int dst_size )
{
	short len;

	len = fb_hDataRead();

	fb_StrAssign( dst, dst_size, (void *)fb_dataptr, len );

	fb_dataptr += len + 1;
}

/*:::::*/
FBCALL void fb_DataReadByte( char *dst )
{
	short len;

	len = fb_hDataRead();

	if( len == 0 )
		*dst = 0;
	else
	{
        *dst = (char)fb_hStr2Double( (char *)fb_dataptr, len );

		fb_dataptr += len + 1;
	}
}

/*:::::*/
FBCALL void fb_DataReadShort( short *dst )
{
	short len;

	len = fb_hDataRead();

	if( len == 0 )
		*dst = 0;
	else
	{
        *dst = (short)fb_hStr2Double( (char *)fb_dataptr, len );

		fb_dataptr += len + 1;
	}
}

/*:::::*/
FBCALL void fb_DataReadInt( int *dst )
{
	short len;

	len = fb_hDataRead();

	if( len == 0 )
		*dst = 0;
	else
	{
        *dst = (int)fb_hStr2Double( (char *)fb_dataptr, len );

		fb_dataptr += len + 1;
	}
}

/*:::::*/
FBCALL void fb_DataReadSingle( float *dst )
{
	short len;

	len = fb_hDataRead();

	if( len == 0 )
		*dst = 0.0;
	else
	{
        *dst = (float)fb_hStr2Double( (char *)fb_dataptr, len );

		fb_dataptr += len + 1;
	}
}

/*:::::*/
FBCALL void fb_DataReadDouble( double *dst )
{
	short len;

	len = fb_hDataRead();

	if( len == 0 )
		*dst = 0.0;
	else
	{
        *dst = fb_hStr2Double( (char *)fb_dataptr, len );

		fb_dataptr += len + 1;
	}
}

