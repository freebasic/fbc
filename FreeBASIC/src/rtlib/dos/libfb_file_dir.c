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
 * libfb_file_dir.c -- dos dir$ implementation
 *
 * chng: jan/2005 written [DrV]
 *       feb/2007 fixed to return only files with the proper attributes and use thread context
 *
 */

#include "fb.h"

#define FB_ATTRIB_MASK ~0xFFFFFF00

/*:::::*/
static char *find_next ( int *out_attrib )
{
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );
	char *name = NULL;
	
	do
	{
		if( findnext( &ctx->f ) == 0 )
		{
			name = ctx->f.ff_name;
		}
		else
		{
			name = NULL;
			break;
		}
	}
	while( ctx->f.ff_attrib & ~ctx->attrib );
	
	*out_attrib = ctx->f.ff_attrib & FB_ATTRIB_MASK;
	
	return name;
}


/*:::::*/
FBCALL FBSTRING *fb_Dir ( FBSTRING *filespec, int attrib, int *out_attrib )
{
	FBSTRING  *res;
	int       len, out_attrib_fake;
	char      *name = NULL;
	FB_DIRCTX *ctx = FB_TLSGETCTX( DIR );
	
	if ( !out_attrib )
		out_attrib = &out_attrib_fake;
	
	len = FB_STRSIZE( filespec );
	
	if( len > 0 ) /* filespec specified (return first result) */
	{
		ctx->attrib = attrib | 0xFFFFFF00;
		
		/* archive bit not set? set the dir bit at least.. */
		if( (attrib & 0x10) == 0 )
			ctx->attrib |= 0x20;
		
		if( findfirst( filespec->data, &ctx->f, ctx->attrib ) == 0 )
		{	
			if( ctx->f.ff_attrib & ~ctx->attrib )
			{
				name = find_next( out_attrib );
			}
			else
			{
				*out_attrib = ctx->f.ff_attrib & FB_ATTRIB_MASK;
				name = ctx->f.ff_name;
			}
		}
		
		if( name )
		{
			ctx->in_use = TRUE;
			ctx->attrib = attrib;
		}
	}
	else /* filespec not specified (return next result) */
	{
		if( ctx->in_use )
		{
			name = find_next( out_attrib );
		}
	}
	
	/* store filename if found */
	if( name )
	{
		ctx->in_use = TRUE;
		
		len = strlen( name );
		res = fb_hStrAllocTemp( NULL, len );
		if( res )
		{
			fb_hStrCopy( res->data, name, len );
		}
		else
		{
			res = &__fb_ctx.null_desc;
		}
	}
	else
	{
		ctx->in_use = FALSE;
		res = &__fb_ctx.null_desc;
		*out_attrib = 0;
	}
	
	fb_hStrDelTemp( filespec );

	return res;
}

/*:::::*/
FBCALL FBSTRING *fb_DirNext ( int *attrib )
{
	static FBSTRING fname = { 0 };
	return fb_Dir( &fname, 0, attrib );
}
