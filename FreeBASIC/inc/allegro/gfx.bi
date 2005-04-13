'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Basic graphics support routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_GFX_H
#define ALLEGRO_GFX_H

#include "allegro/base.bi"
#include "allegro/fixed.bi"

Const GFX_TEXT%				= -1
Const GFX_AUTODETECT%			= 0
Const GFX_AUTODETECT_FULLSCREEN%	= 1
Const GFX_AUTODETECT_WINDOWED%		= 2
Const GFX_SAFE%				= (83 shl 24) or (65 shl 16) or (70 shl 8) or 69 ' AL_ID('S','A','F','E')

Type GFX_MODE
	width As Integer
	height As Integer
	bpp As Integer
End Type

Type GFX_MODE_LIST
	num_modes As Integer			' number of gfx modes
	mode As GFX_MODE Ptr			' pointer to the actual mode list array
End Type

type GFX_DRIVER
   id as integer
   name as byte ptr
   desc as byte ptr
   ascii_name as byte ptr
   init as sub
   exit as sub
   scroll as sub
   vsync as sub
   set_palette as sub
   request_scroll as sub
   poll_scroll as sub
   enable_triple_buffer as sub
   create_video_bitmap as sub
   destroy_video_bitmap as sub
   show_video_bitmap as sub
   request_video_bitmap as sub
   create_system_bitmap as sub
   destroy_system_bitmap as sub
   set_mouse_sprite as sub
   show_mouse as sub
   hide_mouse as sub
   move_mouse as sub
   drawing_mode as sub
   save_video_state as sub
   restore_video_state as sub
   fetch_mode_list as sub
   w as integer
   h as integer
   linear as integer
   bank_size as integer
   bank_gran as integer
   vid_mem as integer
   vid_phys_base as integer
   windowed as integer
end type

extern import gfx_driver alias "gfx_driver" as GFX_DRIVER ptr
extern import _gfx_driver_list Alias "_gfx_driver_list" As _DRIVER_INFO Ptr

Const GFX_CAN_SCROLL%			= &H00000001
Const GFX_CAN_TRIPLE_BUFFER%		= &H00000002
Const GFX_HW_CURSOR%			= &H00000004
Const GFX_HW_HLINE%			= &H00000008
Const GFX_HW_HLINE_XOR%			= &H00000010
Const GFX_HW_HLINE_SOLID_PATTERN%	= &H00000020
Const GFX_HW_HLINE_COPY_PATTERN%	= &H00000040
Const GFX_HW_FILL%			= &H00000080
Const GFX_HW_FILL_XOR%			= &H00000100
Const GFX_HW_FILL_SOLID_PATTERN%	= &H00000200
Const GFX_HW_FILL_COPY_PATTERN%		= &H00000400
Const GFX_HW_LINE%			= &H00000800
Const GFX_HW_LINE_XOR%			= &H00001000
Const GFX_HW_TRIANGLE%			= &H00002000
Const GFX_HW_TRIANGLE_XOR%		= &H00004000
Const GFX_HW_GLYPH%			= &H00008000
Const GFX_HW_VRAM_BLIT%			= &H00010000
Const GFX_HW_VRAM_BLIT_MASKED%		= &H00020000
Const GFX_HW_MEM_BLIT%			= &H00040000
Const GFX_HW_MEM_BLIT_MASKED%		= &H00080000
Const GFX_HW_SYS_TO_VRAM_BLIT%		= &H00100000
Const GFX_HW_SYS_TO_VRAM_BLIT_MASKED%	= &H00200000

Extern Import gfx_capabilities Alias "gfx_capabilities" As Integer

Type GFX_VTABLE        ' functions for drawing onto bitmaps
	color_depth As Integer
	mask_color As Integer
	unwrite_bank As Integer  ' C function on some machines, asm on i386
	set_clip As Integer
	acquire As Integer
	release As Integer
	create_sub_bitmap As Integer
	created_sub_bitmap As Integer
	getpixel As Integer
	putpixel As Integer
	vline As Integer
	hline As Integer
	hfill As Integer
	draw_line As Integer
	rectfill As Integer
	triangle As Integer
	draw_sprite As Integer
	draw_256_sprite As Integer
	draw_sprite_v_flip As Integer
	draw_sprite_h_flip As Integer
	draw_sprite_vh_flip As Integer
	draw_trans_sprite As Integer
	draw_trans_rgba_sprite As Integer
	draw_lit_sprite As Integer
	draw_rle_sprite As Integer
	draw_trans_rle_sprite As Integer
	draw_trans_rgba_rle_sprite As Integer
	draw_lit_rle_sprite As Integer
	draw_character As Integer
	draw_glyph As Integer
	blit_from_memory As Integer
	blit_to_memory As Integer
	blit_from_system As Integer
	blit_to_system As Integer
	blit_to_self As Integer
	blit_to_self_forward As Integer
	blit_to_self_backward As Integer
	blit_between_formats As Integer
	masked_blit As Integer
	clear_to_color As Integer
	pivot_scaled_sprite_flip As Integer
	draw_sprite_end As Integer
	blit_end As Integer
End Type

Extern Import __linear_vtable8 Alias "__linear_vtable8" As GFX_VTABLE
Extern Import __linear_vtable15 Alias "__linear_vtable15" As GFX_VTABLE
Extern Import __linear_vtable16 Alias "__linear_vtable16" As GFX_VTABLE
Extern Import __linear_vtable24 Alias "__linear_vtable24" As GFX_VTABLE
Extern Import __linear_vtable32 Alias "__linear_vtable32" As GFX_VTABLE

type _VTABLE_INFO
	color_depth as integer
	vtable as GFX_VTABLE ptr
end type

extern import _vtable_list alias "_vtable_list" as _VTABLE_INFO ptr

Type BITMAP            				' a bitmap structure
	w As Integer				' width and height in pixels
	h as integer
	clip As Integer				' flag if clipping is turned on
	cl As Integer				' clip left, right, top and bottom values
	cr As Integer
	ct As Integer
	cb As Integer
	vtable As GFX_VTABLE Ptr		' drawing functions
	write_bank As Integer 'void *write_bank;' C func on some machines, asm on i386
	read_bank As Integer 'void *read_bank;	' C func on some machines, asm on i386
	dat As Integer Ptr			' the memory we allocated for the bitmap
	id As Unsigned Integer			' for identifying sub-bitmaps
	extra As UByte Ptr			' points to a structure with more info
	x_ofs As Integer			' horizontal offset (for sub-bitmaps)
	y_ofs As Integer			' vertical offset (for sub-bitmaps)
	seg As Integer				' bitmap segment
	line As UByte Ptr 			'ZERO_SIZE_ARRAY(unsigned char *, line);
End Type

#define BMP_ID_VIDEO       &H80000000
#define BMP_ID_SYSTEM      &H40000000
#define BMP_ID_SUB         &H20000000
#define BMP_ID_PLANAR      &H10000000
#define BMP_ID_NOBLIT      &H08000000
#define BMP_ID_LOCKED      &H04000000
#define BMP_ID_AUTOLOCK    &H02000000
#define BMP_ID_MASK        &H01FFFFFF

Extern Import screen Alias "screen" As BITMAP Ptr

#define SCREEN_W iif(gfx_driver <> 0, gfx_driver->w, 0)
#define SCREEN_H iif(gfx_driver <> 0, gfx_driver->h, 0)

#define VIRTUAL_W    iif(screen <> 0, screen->w, 0)
#define VIRTUAL_H    iif(screen <> 0, screen->h, 0)


#define COLORCONV_NONE              0

#define COLORCONV_8_TO_15           1
#define COLORCONV_8_TO_16           2
#define COLORCONV_8_TO_24           4
#define COLORCONV_8_TO_32           8

#define COLORCONV_15_TO_8           &H10
#define COLORCONV_15_TO_16          &H20
#define COLORCONV_15_TO_24          &H40
#define COLORCONV_15_TO_32          &H80

#define COLORCONV_16_TO_8           &H100
#define COLORCONV_16_TO_15          &H200
#define COLORCONV_16_TO_24          &H400
#define COLORCONV_16_TO_32          &H800

#define COLORCONV_24_TO_8           &H1000
#define COLORCONV_24_TO_15          &H2000
#define COLORCONV_24_TO_16          &H4000
#define COLORCONV_24_TO_32          &H8000

#define COLORCONV_32_TO_8           &H10000
#define COLORCONV_32_TO_15          &H20000
#define COLORCONV_32_TO_16          &H40000
#define COLORCONV_32_TO_24          &H80000

#define COLORCONV_32A_TO_8          &H100000
#define COLORCONV_32A_TO_15         &H200000
#define COLORCONV_32A_TO_16         &H400000
#define COLORCONV_32A_TO_24         &H800000

#define COLORCONV_DITHER_PAL        &H1000000
#define COLORCONV_DITHER_HI         &H2000000
#define COLORCONV_KEEP_TRANS        &H4000000

#define COLORCONV_DITHER            (COLORCONV_DITHER_PAL or COLORCONV_DITHER_HI)

#define COLORCONV_EXPAND_256        (COLORCONV_8_TO_15 or COLORCONV_8_TO_16 or COLORCONV_8_TO_24 or COLORCONV_8_TO_32)

#define COLORCONV_REDUCE_TO_256     (COLORCONV_15_TO_8 or COLORCONV_16_TO_8 or COLORCONV_24_TO_8 or COLORCONV_32_TO_8 or COLORCONV_32A_TO_8)

#define COLORCONV_EXPAND_15_TO_16    COLORCONV_15_TO_16

#define COLORCONV_REDUCE_16_TO_15    COLORCONV_16_TO_15

#define COLORCONV_EXPAND_HI_TO_TRUE (COLORCONV_15_TO_24 or COLORCONV_15_TO_32 or COLORCONV_16_TO_24 or COLORCONV_16_TO_32)

#define COLORCONV_REDUCE_TRUE_TO_HI (COLORCONV_24_TO_15 or COLORCONV_24_TO_16 or COLORCONV_32_TO_15 or COLORCONV_32_TO_16)

#define COLORCONV_24_EQUALS_32      (COLORCONV_24_TO_32 or COLORCONV_32_TO_24)

#define COLORCONV_TOTAL             (COLORCONV_EXPAND_256 or COLORCONV_REDUCE_TO_256 or COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_EXPAND_HI_TO_TRUE or COLORCONV_REDUCE_TRUE_TO_HI or COLORCONV_24_EQUALS_32 or COLORCONV_32A_TO_15 or COLORCONV_32A_TO_16 or COLORCONV_32A_TO_24)

#define COLORCONV_PARTIAL           (COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_24_EQUALS_32)

#define COLORCONV_MOST              (COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_EXPAND_HI_TO_TRUE or COLORCONV_REDUCE_TRUE_TO_HI or COLORCONV_24_EQUALS_32)


Declare Function get_gfx_mode_list CDecl Alias "get_gfx_mode_list" (ByVal card As Integer) As GFX_MODE_LIST Ptr
Declare Sub destroy_gfx_mode_list CDecl Alias "destroy_gfx_mode_list" (ByVal mode_list As GFX_MODE_LIST Ptr)
Declare Sub set_color_depth CDecl Alias "set_color_depth" (ByVal depth As Integer)
Declare Sub set_color_conversion CDecl Alias "set_color_conversion" (ByVal mode As Integer)
Declare Sub request_refresh_rate CDecl Alias "request_refresh_rate" (ByVal rate As Integer)
Declare Function get_refresh_rate CDecl Alias "get_refresh_rate" () As Integer
Declare Function set_gfx_mode CDecl Alias "set_gfx_mode" (ByVal card As Integer, ByVal w As Integer, ByVal h As Integer, ByVal v_w As Integer, ByVal v_h As Integer)
Declare Function scroll_screen CDecl Alias "scroll_screen" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function request_scroll CDecl Alias "request_scroll" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function poll_scroll CDecl Alias "poll_scroll" () As Integer
Declare Function show_video_bitmap CDecl Alias "show_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function request_video_bitmap CDecl Alias "request_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function enable_triple_buffer CDecl Alias "enable_triple_buffer" () As Integer
Declare Function create_bitmap CDecl Alias "create_bitmap" (ByVal w As Integer, ByVal h As Integer) as BITMAP Ptr
Declare Function create_bitmap_ex CDecl Alias "create_bitmap_ex" (ByVal color_depth As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_sub_bitmap CDecl Alias "create_sub_bitmap" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_video_bitmap CDecl Alias "create_video_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_system_bitmap CDecl Alias "create_system_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Sub destroy_bitmap CDecl Alias "destroy_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub set_clip CDecl Alias "set_clip" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
Declare Sub clear_bitmap CDecl Alias "clear_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub vsync CDecl Alias "vsync" ()

#define SWITCH_NONE           0
#define SWITCH_PAUSE          1
#define SWITCH_AMNESIA        2
#define SWITCH_BACKGROUND     3
#define SWITCH_BACKAMNESIA    4

#define SWITCH_IN             0
#define SWITCH_OUT            1

Declare Function set_display_switch_mode CDecl Alias "set_display_switch_mode" (ByVal mode As Integer) As Integer
Declare Function get_display_switch_mode CDecl Alias "get_display_switch_mode" () As Integer
Declare Function set_display_switch_callback CDecl Alias "set_display_switch_callback" (ByVal dir As Integer, ByVal cb As Sub()) As Integer
Declare Sub remove_display_switch_callback CDecl Alias "remove_display_switch_callback" (ByVal cb As Sub())
Declare Sub lock_bitmap CDecl Alias "lock_bitmap" (ByVal bmp As BITMAP Ptr)

#include "allegro/inline/gfx.inl"

#endif
