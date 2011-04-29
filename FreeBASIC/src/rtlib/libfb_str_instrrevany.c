/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * str_instrrev.c -- instrrev function
 *
 * chng: dec/2007 written [jeffm]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_StrInstrRevAny ( FBSTRING *src, FBSTRING *patt, int start )
{
	int r = 0;

	if( (src != NULL) && (src->data != NULL) && (patt != NULL) && (patt->data != NULL) ) 
	{

		size_t size_src = FB_STRSIZE(src);
		size_t size_patt = FB_STRSIZE(patt);

		if( (size_src != 0) && (size_patt != 0) && (start != 0) )
		{
			if( start < 0 )
				start = size_src;
			else if( start > size_src )
				start = 0;

			while( start-- && (r == 0) )
			{
				size_t i;
				for( i = 0; i != size_patt; ++i )
				{
					if( src->data[start] == patt->data[i] )
					{	
						r = start + 1;
						break;
					}
				}
			}
		}
	}

	FB_STRLOCK();

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
	fb_hStrDelTemp_NoLock( patt );

	FB_STRUNLOCK();

	return r;
}
