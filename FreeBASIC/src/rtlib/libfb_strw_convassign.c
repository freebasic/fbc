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
 * strw_convassign.c -- ascii <-> unicode string convertion functions
 *
 * chng: ago/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrAssignFromA 
	( 
		FB_WCHAR *dst, 
		int dst_chars, 
		void *src, 
		int src_size 
	)
{
	char *src_ptr;
	int src_chars;

	if( dst != NULL )
	{
		FB_STRSETUP_FIX( src, src_size, src_ptr, src_chars );

		/* size unknown? assume it's big enough */
		if( dst_chars == 0 )
		{
			dst_chars = src_chars;
		}
		else
		{
			/* less the null-term */
			--dst_chars;
		}

		fb_wstr_ConvFromA( dst, dst_chars, src_ptr );
	}

	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)src );

	return dst;
}

/*:::::*/
FBCALL void *fb_WstrAssignToAEx
	( 
		void *dst, 
		int dst_chars, 
		FB_WCHAR *src, 
		int fill_rem,
		int is_init
	)
{
	int src_chars;

	if( dst == NULL )
		return dst;

    if( src != NULL )
    	src_chars = fb_wstr_Len( src );
    else
    	src_chars = 0;

	/* is dst var-len? */
	if( dst_chars == -1 )
	{
		/* src NULL? */
		if( src_chars == 0 )
		{
			if( is_init == FB_FALSE )
			{
				fb_StrDelete( (FBSTRING *)dst );
			}
			else
			{
				((FBSTRING *)dst)->data = NULL;
				((FBSTRING *)dst)->len = 0;
				((FBSTRING *)dst)->size = 0;
			}
		}
		else
		{
        	/* realloc dst if needed and copy src */
			if( is_init == FB_FALSE )
			{
				if( FB_STRSIZE( dst ) != src_chars )
					fb_hStrRealloc( (FBSTRING *)dst, src_chars, FB_FALSE );
			}
			else
			{
				fb_hStrAlloc( (FBSTRING *)dst, src_chars );
			}

			fb_wstr_ConvToA( ((FBSTRING *)dst)->data, src, src_chars );
		}
	}
	/* fixed-len or zstring.. */
	else
	{
		/* src NULL? */
		if( src_chars == 0 )
		{
			*(char *)dst = '\0';
		}
		else
		{
			/* byte ptr? as in C, assume dst is large enough */
			if( dst_chars == 0 )
				dst_chars = src_chars;

			fb_wstr_ConvToA( (char *)dst,
							 src,
							 (dst_chars <= src_chars? dst_chars : src_chars) );
		}

		/* fill reminder with null's */
		if( fill_rem != 0 )
		{
			dst_chars -= src_chars;
			if( dst_chars > 0 )
				memset( &(((char *)dst)[src_chars]), 0, dst_chars );
		}
	}

	return dst;
}

/*:::::*/
FBCALL void *fb_WstrAssignToA 
	( 
		void *dst, 
		int dst_chars, 
		FB_WCHAR *src, 
		int fill_rem
	)
{
	return fb_WstrAssignToAEx( dst, dst_chars, src, fill_rem, FB_FALSE );
}

/*:::::*/
FBCALL void *fb_WstrAssignToA_Init 
	( 
		void *dst, 
		int dst_chars, 
		FB_WCHAR *src, 
		int fill_rem
	)
{
	return fb_WstrAssignToAEx( dst, dst_chars, src, fill_rem, FB_TRUE );
}
