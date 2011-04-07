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
 * error - runtime error handling, set & get
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_ErrorGetNum 
	( 
		void 
	)
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return ctx->err_num;
}

/*:::::*/
FBCALL int fb_ErrorSetNum 
	( 
		int err_num 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	ctx->err_num = err_num;

	return err_num;

}

/*:::::*/
FBCALL int fb_ErrorGetLineNum 
	( 
		void 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return ctx->line_num;

}

/*:::::*/
FBCALL const char *fb_ErrorGetModName 
	( 
		void 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return ctx->mod_name;

}

/*:::::*/
FBCALL const char *fb_ErrorSetModName 
	( 
		const char *mod_name
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
    
    const char *old_name = ctx->mod_name;
    
    ctx->mod_name = mod_name;

	return old_name;

}

/*:::::*/
FBCALL const char *fb_ErrorGetFuncName 
	( 
		void 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return ctx->fun_name;

}

/*:::::*/
FBCALL const char *fb_ErrorSetFuncName 
	( 
		const char *fun_name
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
    
    const char *old_name = ctx->fun_name;
    
    ctx->fun_name = fun_name;

	return old_name;

}
