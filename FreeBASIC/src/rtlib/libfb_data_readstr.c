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
 * data_str.c -- read stmt for string's
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadStr( void *dst, int dst_size, int fillrem )
{
	short len;

	FB_LOCK();

	len = fb_DataRead();

	if( len == FB_DATATYPE_OFS )
	{
		/* !!!WRITEME!!! */
		fb_DataPtr += sizeof( unsigned int );
	}
	else
	{
		fb_StrAssign( dst, dst_size, (void *)fb_DataPtr, 0, fillrem );

		fb_DataPtr += len + 1;
	}

	FB_UNLOCK();
}

