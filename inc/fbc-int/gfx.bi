#ifndef __FBC_INT_GFX_BI__
#define __FBC_INT_GFX_BI__

#include once "fbgfx.bi"

# if __FB_LANG__ = "qb"
# error not supported in qb dialect
# endif

'' declarations must follow ./src/rtlib/fb_gfx_private.h

namespace FBGFXLIB

enum PUT_MODES_ENUM
	PUT_MODE_TRANS      = 0
	PUT_MODE_PSET       = 1
	PUT_MODE_PRESET     = 2
	PUT_MODE_AND        = 3
	PUT_MODE_OR         = 4
	PUT_MODE_XOR        = 5
	PUT_MODE_ALPHA      = 6
	PUT_MODE_ADD        = 7
	PUT_MODE_CUSTOM     = 8
	PUT_MODE_BLEND      = 9
	PUT_MODES           = 10
end enum

extern "rtlib"
	type FBGFX_BLENDER as function _
		( _
			byval src as ulong, _
			byval dst as ulong, _
			byval param as any ptr _
		) as ulong

	type FBGFX_PUTTER as sub _
		( _
			byval src as ubyte ptr, _
			byval dst as ubyte ptr, _
			byval w as long, _
			byval h as long, _
			byval src_ptich as long, _
			byval dst_pitch as long, _
			byval alpha as long, _
			byval blender as FBGFX_BLENDER, _
			byval param as any ptr _
		)

	type FB_GFXCTX
		dim id as long
		dim work_page as long
		dim line as ubyte ptr ptr
		dim max_h as long
		dim target_bpp as long
		dim target_pitch as long
		dim last_target as any ptr
		dim last_x as single
		dim last_y as single
		union
			type
				dim view_x as long
				dim view_y as long
				dim view_w as long
				dim view_h as long
			end type
			dim view(0 to 3) as long
		end union
		union
			type
				dim old_view_x as long
				dim old_view_y as long
				dim old_view_w as long
				dim old_view_h as long
			end type
			dim old_view(0 to 3) as long
		end union
		dim win_x as single
		dim win_y as single
		dim win_w as single
		dim win_h as single
		dim fg_color as ulong
		dim bg_color as ulong
		dim put_pixel as sub _
			( _
				byval ctx as FB_GFXCTX ptr, _
				byval x as long, _
				byval y as long, _
				byval clr as ulong _
			)
		dim get_pixel as function _
			( _
				byval ctx as FB_GFXCTX ptr, _
				byval x as long, _
				byval y as long _
			) as ulong
		dim pixel_set as function _
			( _
				byval dst as any ptr, _
				byval clr as long, _
				byval size as integer _
			) as any ptr
		dim putter(0 to PUT_MODES-1) as FBGFX_PUTTER ptr
		dim flags as long
	end type
end extern

extern "c"
	declare function GetGfxContext alias "fb_hGetContext" () as fbgfxlib.FB_GFXCTX ptr
end extern

end namespace

#endif
