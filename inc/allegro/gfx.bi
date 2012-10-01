''
''
'' allegro\gfx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_gfx_bi__
#define __allegro_gfx_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"

#define GFX_TEXT -1
#define GFX_AUTODETECT 0
#define GFX_AUTODETECT_FULLSCREEN 1
#define GFX_AUTODETECT_WINDOWED 2
#define GFX_SAFE AL_ID(asc("S"),asc("A"),asc("F"),asc("E"))

type GFX_MODE
	width as integer
	height as integer
	bpp as integer
end type

type GFX_MODE_LIST
	num_modes as integer
	mode as GFX_MODE ptr
end type

type BITMAP_ as BITMAP

type GFX_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	init as function cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as BITMAP_ ptr
	exit as sub cdecl(byval as BITMAP_ ptr)
	scroll as function cdecl(byval as integer, byval as integer) as integer
	vsync as sub cdecl()
	set_palette as sub cdecl(byval as RGB ptr, byval as integer, byval as integer, byval as integer)
	request_scroll as function cdecl(byval as integer, byval as integer) as integer
	poll_scroll as function cdecl() as integer
	enable_triple_buffer as sub cdecl()
	create_video_bitmap as function cdecl(byval as integer, byval as integer) as BITMAP_ ptr
	destroy_video_bitmap as sub cdecl(byval as BITMAP_ ptr)
	show_video_bitmap as function cdecl(byval as BITMAP_ ptr) as integer
	request_video_bitmap as function cdecl(byval as BITMAP_ ptr) as integer
	create_system_bitmap as function cdecl(byval as integer, byval as integer) as BITMAP_ ptr
	destroy_system_bitmap as sub cdecl(byval as BITMAP_ ptr)
	set_mouse_sprite as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer) as integer
	show_mouse as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer) as integer
	hide_mouse as sub cdecl()
	move_mouse as sub cdecl(byval as integer, byval as integer)
	drawing_mode as sub cdecl()
	save_video_state as sub cdecl()
	restore_video_state as sub cdecl()
	fetch_mode_list as function cdecl() as GFX_MODE_LIST ptr
	w as integer
	h as integer
	linear as integer
	bank_size as integer
	bank_gran as integer
	vid_mem as integer
	vid_phys_base as integer
	windowed as integer
end type

extern _AL_DLL gfx_driver alias "gfx_driver" as GFX_DRIVER ptr
extern _AL_DLL ___gfx_driver_list alias "_gfx_driver_list" as _DRIVER_INFO
#define _gfx_driver_list(x) *(@___gfx_driver_list + (x))

#define GFX_CAN_SCROLL &h00000001
#define GFX_CAN_TRIPLE_BUFFER &h00000002
#define GFX_HW_CURSOR &h00000004
#define GFX_HW_HLINE &h00000008
#define GFX_HW_HLINE_XOR &h00000010
#define GFX_HW_HLINE_SOLID_PATTERN &h00000020
#define GFX_HW_HLINE_COPY_PATTERN &h00000040
#define GFX_HW_FILL &h00000080
#define GFX_HW_FILL_XOR &h00000100
#define GFX_HW_FILL_SOLID_PATTERN &h00000200
#define GFX_HW_FILL_COPY_PATTERN &h00000400
#define GFX_HW_LINE &h00000800
#define GFX_HW_LINE_XOR &h00001000
#define GFX_HW_TRIANGLE &h00002000
#define GFX_HW_TRIANGLE_XOR &h00004000
#define GFX_HW_GLYPH &h00008000
#define GFX_HW_VRAM_BLIT &h00010000
#define GFX_HW_VRAM_BLIT_MASKED &h00020000
#define GFX_HW_MEM_BLIT &h00040000
#define GFX_HW_MEM_BLIT_MASKED &h00080000
#define GFX_HW_SYS_TO_VRAM_BLIT &h00100000
#define GFX_HW_SYS_TO_VRAM_BLIT_MASKED &h00200000

extern _AL_DLL gfx_capabilities alias "gfx_capabilities" as integer

type RLE_SPRITE_ as RLE_SPRITE
type FONT_GLYPH_ as FONT_GLYPH

type GFX_VTABLE
	color_depth as integer
	mask_color as integer
	unwrite_bank as any ptr
	set_clip as sub cdecl(byval as BITMAP_ ptr)
	acquire as sub cdecl(byval as BITMAP_ ptr)
	release as sub cdecl(byval as BITMAP_ ptr)
	create_sub_bitmap as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer) as BITMAP_ ptr
	created_sub_bitmap as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr)
	getpixel as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer) as integer
	putpixel as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer)
	vline as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	hline as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	hfill as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	line as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	rectfill as sub cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	triangle as function cdecl(byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
	draw_sprite as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_256_sprite as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_sprite_v_flip as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_sprite_h_flip as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_sprite_vh_flip as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_trans_sprite as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_trans_rgba_sprite as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer)
	draw_lit_sprite as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer)
	draw_rle_sprite as sub cdecl(byval as BITMAP_ ptr, byval as RLE_SPRITE_ ptr, byval as integer, byval as integer)
	draw_trans_rle_sprite as sub cdecl(byval as BITMAP_ ptr, byval as RLE_SPRITE_ ptr, byval as integer, byval as integer)
	draw_trans_rgba_rle_sprite as sub cdecl(byval as BITMAP_ ptr, byval as RLE_SPRITE_ ptr, byval as integer, byval as integer)
	draw_lit_rle_sprite as sub cdecl(byval as BITMAP_ ptr, byval as RLE_SPRITE_ ptr, byval as integer, byval as integer, byval as integer)
	draw_character as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer)
	draw_glyph as sub cdecl(byval as BITMAP_ ptr, byval as FONT_GLYPH_ ptr, byval as integer, byval as integer, byval as integer)
	blit_from_memory as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_to_memory as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_from_system as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_to_system as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_to_self as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_to_self_forward as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_to_self_backward as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	blit_between_formats as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	masked_blit as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	clear_to_color as sub cdecl(byval as BITMAP_ ptr, byval as integer)
	pivot_scaled_sprite_flip as sub cdecl(byval as BITMAP_ ptr, byval as BITMAP_ ptr, byval as fixed, byval as fixed, byval as fixed, byval as fixed, byval as fixed, byval as fixed, byval as integer)
	draw_sprite_end as sub cdecl()
	blit_end as sub cdecl()
end type

extern _AL_DLL __linear_vtable8 alias "__linear_vtable8" as GFX_VTABLE
extern _AL_DLL __linear_vtable15 alias "__linear_vtable15" as GFX_VTABLE
extern _AL_DLL __linear_vtable16 alias "__linear_vtable16" as GFX_VTABLE
extern _AL_DLL __linear_vtable24 alias "__linear_vtable24" as GFX_VTABLE
extern _AL_DLL __linear_vtable32 alias "__linear_vtable32" as GFX_VTABLE

type _VTABLE_INFO
	color_depth as integer
	vtable as GFX_VTABLE ptr
end type

extern _AL_DLL ___vtable_list alias "_vtable_list" as _VTABLE_INFO
#define _vtable_list(x) *(@___vtable_list + (x))

type BITMAP
	w as integer
	h as integer
	clip as integer
	cl as integer
	cr as integer
	ct as integer
	cb as integer
	vtable as GFX_VTABLE ptr
	write_bank as any ptr
	read_bank as any ptr
	dat as any ptr
	id as uinteger
	extra as any ptr
	x_ofs as integer
	y_ofs as integer
	seg as integer
	line(0 to 0) as ubyte ptr
end type

#define BMP_ID_VIDEO &h80000000
#define BMP_ID_SYSTEM &h40000000
#define BMP_ID_SUB &h20000000
#define BMP_ID_PLANAR &h10000000
#define BMP_ID_NOBLIT &h08000000
#define BMP_ID_LOCKED &h04000000
#define BMP_ID_AUTOLOCK &h02000000
#define BMP_ID_MASK &h01FFFFFF

extern _AL_DLL screen alias "screen" as BITMAP ptr

#define SCREEN_W iif(gfx_driver, gfx_driver->w, 0)
#define SCREEN_H iif(gfx_driver, gfx_driver->h, 0)
#define VIRTUAL_W iif(screen, screen->w, 0)
#define VIRTUAL_H iif(screen, screen->h, 0)

#define COLORCONV_NONE 0
#define COLORCONV_8_TO_15 1
#define COLORCONV_8_TO_16 2
#define COLORCONV_8_TO_24 4
#define COLORCONV_8_TO_32 8
#define COLORCONV_15_TO_8 &h10
#define COLORCONV_15_TO_16 &h20
#define COLORCONV_15_TO_24 &h40
#define COLORCONV_15_TO_32 &h80
#define COLORCONV_16_TO_8 &h100
#define COLORCONV_16_TO_15 &h200
#define COLORCONV_16_TO_24 &h400
#define COLORCONV_16_TO_32 &h800
#define COLORCONV_24_TO_8 &h1000
#define COLORCONV_24_TO_15 &h2000
#define COLORCONV_24_TO_16 &h4000
#define COLORCONV_24_TO_32 &h8000
#define COLORCONV_32_TO_8 &h10000
#define COLORCONV_32_TO_15 &h20000
#define COLORCONV_32_TO_16 &h40000
#define COLORCONV_32_TO_24 &h80000
#define COLORCONV_32A_TO_8 &h100000
#define COLORCONV_32A_TO_15 &h200000
#define COLORCONV_32A_TO_16 &h400000
#define COLORCONV_32A_TO_24 &h800000
#define COLORCONV_DITHER_PAL &h1000000
#define COLORCONV_DITHER_HI &h2000000
#define COLORCONV_KEEP_TRANS &h4000000
#define COLORCONV_DITHER (&h1000000 or &h2000000)
#define COLORCONV_EXPAND_256 (1 or 2 or 4 or 8)
#define COLORCONV_REDUCE_TO_256 (&h10 or &h100 or &h1000 or &h10000 or &h100000)
#define COLORCONV_EXPAND_15_TO_16 &h20
#define COLORCONV_REDUCE_16_TO_15 &h200
#define COLORCONV_EXPAND_HI_TO_TRUE (&h40 or &h80 or &h400 or &h800)
#define COLORCONV_REDUCE_TRUE_TO_HI (&h2000 or &h4000 or &h20000 or &h40000)
#define COLORCONV_24_EQUALS_32 (&h8000 or &h80000)
#define COLORCONV_TOTAL ((1 or 2 or 4 or 8) or (&h10 or &h100 or &h1000 or &h10000 or &h100000) or &h20 or &h200 or (&h40 or &h80 or &h400 or &h800) or (&h2000 or &h4000 or &h20000 or &h40000) or (&h8000 or &h80000) or &h200000 or &h400000 or &h800000)
#define COLORCONV_PARTIAL (&h20 or &h200 or (&h8000 or &h80000))
#define COLORCONV_MOST (&h20 or &h200 or (&h40 or &h80 or &h400 or &h800) or (&h2000 or &h4000 or &h20000 or &h40000) or (&h8000 or &h80000))

declare function get_gfx_mode_list cdecl alias "get_gfx_mode_list" (byval card as integer) as GFX_MODE_LIST ptr
declare sub destroy_gfx_mode_list cdecl alias "destroy_gfx_mode_list" (byval gfx_mode_list as GFX_MODE_LIST ptr)
declare sub set_color_depth cdecl alias "set_color_depth" (byval depth as integer)
declare sub set_color_conversion cdecl alias "set_color_conversion" (byval mode as integer)
declare sub request_refresh_rate cdecl alias "request_refresh_rate" (byval rate as integer)
declare function get_refresh_rate cdecl alias "get_refresh_rate" () as integer
declare function set_gfx_mode cdecl alias "set_gfx_mode" (byval card as integer, byval w as integer, byval h as integer, byval v_w as integer, byval v_h as integer) as integer
declare function scroll_screen cdecl alias "scroll_screen" (byval x as integer, byval y as integer) as integer
declare function request_scroll cdecl alias "request_scroll" (byval x as integer, byval y as integer) as integer
declare function poll_scroll cdecl alias "poll_scroll" () as integer
declare function show_video_bitmap cdecl alias "show_video_bitmap" (byval bitmap as BITMAP ptr) as integer
declare function request_video_bitmap cdecl alias "request_video_bitmap" (byval bitmap as BITMAP ptr) as integer
declare function enable_triple_buffer cdecl alias "enable_triple_buffer" () as integer
declare function create_bitmap cdecl alias "create_bitmap" (byval width as integer, byval height as integer) as BITMAP ptr
declare function create_bitmap_ex cdecl alias "create_bitmap_ex" (byval color_depth as integer, byval width as integer, byval height as integer) as BITMAP ptr
declare function create_sub_bitmap cdecl alias "create_sub_bitmap" (byval parent as BITMAP ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as BITMAP ptr
declare function create_video_bitmap cdecl alias "create_video_bitmap" (byval width as integer, byval height as integer) as BITMAP ptr
declare function create_system_bitmap cdecl alias "create_system_bitmap" (byval width as integer, byval height as integer) as BITMAP ptr
declare sub destroy_bitmap cdecl alias "destroy_bitmap" (byval bitmap as BITMAP ptr)
declare sub set_clip cdecl alias "set_clip" (byval bitmap as BITMAP ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub clear_bitmap cdecl alias "clear_bitmap" (byval bitmap as BITMAP ptr)
declare sub vsync cdecl alias "vsync" ()

#define SWITCH_NONE 0
#define SWITCH_PAUSE 1
#define SWITCH_AMNESIA 2
#define SWITCH_BACKGROUND 3
#define SWITCH_BACKAMNESIA 4
#define SWITCH_IN 0
#define SWITCH_OUT 1

declare function set_display_switch_mode cdecl alias "set_display_switch_mode" (byval mode as integer) as integer
declare function get_display_switch_mode cdecl alias "get_display_switch_mode" () as integer
declare function set_display_switch_callback cdecl alias "set_display_switch_callback" (byval dir as integer, byval cb as sub cdecl()) as integer
declare sub remove_display_switch_callback cdecl alias "remove_display_switch_callback" (byval cb as sub cdecl())
declare sub lock_bitmap cdecl alias "lock_bitmap" (byval bmp as BITMAP ptr)

#include once "allegro/inline/gfx.bi"

#endif
