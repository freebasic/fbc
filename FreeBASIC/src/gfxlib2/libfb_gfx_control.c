/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
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
 * control.c -- Screen states getter/setter routines.
 *
 * chng: oct/2006 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxControl_s( int what, FBSTRING *param )
{
	FBSTRING *src;
	
	if (!param)
		return;
	
	switch ( what ) {
	
	case GET_WINDOW_TITLE:
		if (!__fb_window_title )
			src = &__fb_ctx.null_desc;
		else
			src = fb_StrAllocTempDescF( __fb_window_title, strlen(__fb_window_title) + 1 );
		fb_StrAssign( param, -1, src, -1, FB_FALSE );
		break;
		
	case GET_DRIVER_NAME:
		if (!__fb_gfx)
			src = &__fb_ctx.null_desc;
		else
			src = fb_StrAllocTempDescF( __fb_gfx->driver->name, strlen(__fb_gfx->driver->name) + 1 );
		fb_StrAssign( param, -1, src, -1, FB_FALSE );
		break;
	
	case GET_GL_EXTENSIONS:
		if ((!__fb_gfx) || (!(__fb_gfx->flags & OPENGL_SUPPORT)))
			src = &__fb_ctx.null_desc;
#ifdef HAVE_GL_GL_H
		else
			src = fb_StrAllocTempDescF( __fb_gl.extensions, strlen(__fb_gl.extensions) + 1 );
#endif
		fb_StrAssign( param, -1, src, -1, FB_FALSE );
		break;

	
	case SET_WINDOW_TITLE:
		fb_GfxSetWindowTitle(param);
		break;
	
	case SET_DRIVER_NAME:
		if (__fb_gfx_driver_name)
			free(__fb_gfx_driver_name);
		__fb_gfx_driver_name = NULL;
		if (strlen(param->data) > 0)
			__fb_gfx_driver_name = strdup(param->data);
		break;
	}
}


/*:::::*/
FBCALL void fb_GfxControl_i( int what, int *param1, int *param2, int *param3, int *param4 )
{
	FB_GFXCTX *context = fb_hGetContext();
	int res = 0;
	int res1 = 0, res2 = 0, res3 = 0, res4 = 0;
	int temp1, temp2, temp3, temp4;
	
	if (!param1) param1 = &temp1;
	if (!param2) param2 = &temp2;
	if (!param3) param3 = &temp3;	
	if (!param4) param4 = &temp4;
	
	switch ( what ) {
	
	case GET_WINDOW_POS:
		if ((__fb_gfx) && (__fb_gfx->driver->set_window_pos))
			res = __fb_gfx->driver->set_window_pos(0x80000000, 0x80000000);
		res1 = (int)((short)(res & 0xFFFF));
		res2 = res >> 16;
		break;
	
	case GET_WINDOW_HANDLE:
		if (__fb_gfx)
			res1 = fb_hGetWindowHandle();
		break;
	
	case GET_DESKTOP_SIZE:
		fb_hScreenInfo(&res1, &res2, &temp3, &temp4);
		break;
	
	case GET_SCREEN_SIZE:
		if (__fb_gfx) {
			res1 = __fb_gfx->w;
			res2 = __fb_gfx->h;
		}
		break;
	
	case GET_SCREEN_DEPTH:
		if (__fb_gfx)
			res1 = __fb_gfx->depth;
		break;
	
	case GET_SCREEN_BPP:
		if (__fb_gfx)
			res1 = __fb_gfx->bpp;
		break;
	
	case GET_SCREEN_PITCH:
		if (__fb_gfx)
			res1 = __fb_gfx->pitch;
		break;
	
	case GET_SCREEN_REFRESH:
		if (__fb_gfx)
			res1 = __fb_gfx->refresh_rate;
		break;
	
	case GET_TRANSPARENT_COLOR:
		if ((__fb_gfx) && (__fb_gfx->bpp > 1))
			res1 = MASK_COLOR_32;
		break;
	
	case GET_VIEWPORT:
		if (__fb_gfx) {
			res1 = context->view_x;
			res2 = context->view_y;
			res3 = context->view_x + context->view_w - 1;
			res4 = context->view_y + context->view_h - 1;
		}
		break;
	
	case GET_PEN_POS:
		if (__fb_gfx) {
			res1 = context->last_x;
			res2 = context->last_y;
		}
		break;
	
	case GET_COLOR:
		if (__fb_gfx) {
			res1 = context->fg_color;
			res2 = context->bg_color;
		}
		break;
	
	case GET_ALPHA_PRIMITIVES:
		if (__fb_gfx)
			res1 = (__fb_gfx->flags & ALPHA_PRIMITIVES) ? FB_TRUE : FB_FALSE;
		break;

	case GET_HIGH_PRIORITY:
		if (__fb_gfx)
			res1 = (__fb_gfx->flags & HIGH_PRIORITY) ? FB_TRUE : FB_FALSE;
		break;
	
	case SET_WINDOW_POS:
		if ((__fb_gfx) && (__fb_gfx->driver->set_window_pos))
			__fb_gfx->driver->set_window_pos(*param1, *param2);
		break;
		
	case SET_PEN_POS:
		if (__fb_gfx) {
			if (*param1 != 0x80000000)
				context->last_x = *param1;
			if (*param2 != 0x80000000)
				context->last_y = *param2;
		}
		break;
	
	case SET_ALPHA_PRIMITIVES:
		if ((__fb_gfx) && (*param1 != 0x80000000)) {
			if (*param1)
				__fb_gfx->flags |= ALPHA_PRIMITIVES;
			else
				__fb_gfx->flags &= ~ALPHA_PRIMITIVES;
		}
		break;
	
#ifdef HAVE_GL_GL_H

	case SET_GL_COLOR_BITS:
		__fb_gl_params.color_bits = *param1;
		break;
	
	case SET_GL_COLOR_RED_BITS:
		__fb_gl_params.color_red_bits = *param1;
		break;
	
	case SET_GL_COLOR_GREEN_BITS:
		__fb_gl_params.color_green_bits = *param1;
		break;
	
	case SET_GL_COLOR_BLUE_BITS:
		__fb_gl_params.color_blue_bits = *param1;
		break;
	
	case SET_GL_COLOR_ALPHA_BITS:
		__fb_gl_params.color_alpha_bits = *param1;
		break;
	
	case SET_GL_DEPTH_BITS:
		__fb_gl_params.depth_bits = *param1;
		break;
	
	case SET_GL_STENCIL_BITS:
		__fb_gl_params.stencil_bits = *param1;
		break;
	
	case SET_GL_ACCUM_BITS:
		__fb_gl_params.accum_bits = *param1;
		break;
	
	case SET_GL_ACCUM_RED_BITS:
		__fb_gl_params.accum_red_bits = *param1;
		break;
	
	case SET_GL_ACCUM_GREEN_BITS:
		__fb_gl_params.accum_green_bits = *param1;
		break;
	
	case SET_GL_ACCUM_BLUE_BITS:
		__fb_gl_params.accum_blue_bits = *param1;
		break;
	
	case SET_GL_ACCUM_ALPHA_BITS:
		__fb_gl_params.accum_alpha_bits = *param1;
		break;
	
	case SET_GL_NUM_SAMPLES:
		__fb_gl_params.num_samples = *param1;
		break;

#endif /* HAVE_GL_GL_H */

	case POLL_EVENTS:
		if ((__fb_gfx) && (__fb_gfx->driver->poll_events))
			__fb_gfx->driver->poll_events();
		break;

	}
		
	if (what < SET_FIRST_SETTER) {
		*param1 = res1;
		*param2 = res2;
		*param3 = res3;
		*param4 = res4;
	}
}
