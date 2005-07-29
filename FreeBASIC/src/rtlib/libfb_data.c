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
 * data.c -- generic read
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
short fb_DataRead( void )
{
	short len;

	if( fb_DataPtr == NULL )
		return 0;

	len = *((short *)fb_DataPtr);
	fb_DataPtr += sizeof(short);

	/* link? */
	while ( len == FB_DATATYPE_LINK )
	{
		fb_DataPtr = (char *)(*(int *)fb_DataPtr);
		if( fb_DataPtr == NULL )
			return 0;

		len = *((short *)fb_DataPtr);
		fb_DataPtr += sizeof(short);
	}

	return len;
}

