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
 * data_long.c -- read stmt for long integer's
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_DataReadLongint( long long *dst )
{
	short len;

	FB_LOCK();

	len = fb_DataGetLen();

	if( len == 0 )
		*dst = 0;
	else if( len == FB_DATATYPE_OFS )
		*dst = (long long)(unsigned long)__fb_data_ptr->ofs;
	/* wstring? */
	else if( len & FB_DATATYPE_WSTR )
        *dst = (long long)fb_WstrToLongint( __fb_data_ptr->wstr, len & 0x7FFF );
	else
        *dst = (long long)fb_hStr2Longint( __fb_data_ptr->zstr, len );

	if( __fb_data_ptr != NULL )
		++__fb_data_ptr;

	FB_UNLOCK();
}

