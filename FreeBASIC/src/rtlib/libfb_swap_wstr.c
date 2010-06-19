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
 * swap_wstr.c -- swap f/ wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WstrSwap( FB_WCHAR *str1, int str1_size, FB_WCHAR *str2, int str2_size )
{
	int size;

	if( (str1 == NULL) || (str2 == NULL) )
		return;

	/* handle zstring ptr's */
	if( str1_size <= 0 )
		str1_size = fb_wstr_Len( str1 ) + 1;

	if( str2_size <= 0 )
		str2_size = fb_wstr_Len( str2 ) + 1;

	/* don't overrun */
	size = (str1_size <= str2_size? str1_size : str2_size) - 1;

	if( size > 0 )
		fb_MemSwap( (unsigned char *)str1, (unsigned char *)str2, size * sizeof( FB_WCHAR ) );

	/* add the null-terms */
	str1[size] = L'\0';
	str2[size] = L'\0';
}
