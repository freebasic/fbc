''
''
'' allegro\color -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_color_bi__
#define __allegro_color_bi__

#include once "allegro/base.bi"
#include once "allegro/palette.bi"

extern _AL_DLL black_palette(0 to PAL_SIZE-1) alias "black_palette" as PALETTE
extern _AL_DLL desktop_palette(0 to PAL_SIZE-1) alias "desktop_palette" as PALETTE
extern _AL_DLL default_palette(0 to PAL_SIZE-1) alias "default_palette" as PALETTE

type RGB_MAP
	data(0 to 32-1, 0 to 32-1, 0 to 32-1) as ubyte
end type

type COLOR_MAP
	data(0 to PAL_SIZE-1, 0 to PAL_SIZE-1) as ubyte
end type

extern _AL_DLL rgb_map alias "rgb_map" as RGB_MAP ptr
extern _AL_DLL color_map alias "color_map" as COLOR_MAP ptr
extern _AL_DLL _current_palette(0 to PAL_SIZE-1) alias "_current_palette" as PALETTE
extern _AL_DLL _rgb_r_shift_15 alias "_rgb_r_shift_15" as integer
extern _AL_DLL _rgb_g_shift_15 alias "_rgb_g_shift_15" as integer
extern _AL_DLL _rgb_b_shift_15 alias "_rgb_b_shift_15" as integer
extern _AL_DLL _rgb_r_shift_16 alias "_rgb_r_shift_16" as integer
extern _AL_DLL _rgb_g_shift_16 alias "_rgb_g_shift_16" as integer
extern _AL_DLL _rgb_b_shift_16 alias "_rgb_b_shift_16" as integer
extern _AL_DLL _rgb_r_shift_24 alias "_rgb_r_shift_24" as integer
extern _AL_DLL _rgb_g_shift_24 alias "_rgb_g_shift_24" as integer
extern _AL_DLL _rgb_b_shift_24 alias "_rgb_b_shift_24" as integer
extern _AL_DLL _rgb_r_shift_32 alias "_rgb_r_shift_32" as integer
extern _AL_DLL _rgb_g_shift_32 alias "_rgb_g_shift_32" as integer
extern _AL_DLL _rgb_b_shift_32 alias "_rgb_b_shift_32" as integer
extern _AL_DLL _rgb_a_shift_32 alias "_rgb_a_shift_32" as integer
extern _AL_DLL ___rgb_scale_5 alias "_rgb_scale_5" as integer
#define _rgb_scale_5(x) *(@___rgb_scale_5 + (x))
extern _AL_DLL ___rgb_scale_6 alias "_rgb_scale_6" as integer
#define _rgb_scale_6(x) *(@___rgb_scale_6 + (x))

#define MASK_COLOR_8 0
#define MASK_COLOR_15 &h7C1F
#define MASK_COLOR_16 &hF81F
#define MASK_COLOR_24 &hFF00FF
#define MASK_COLOR_32 &hFF00FF

extern _AL_DLL palette_color alias "palette_color" as integer ptr

declare sub set_color cdecl alias "set_color" (byval index as integer, byval p as RGB ptr)
declare sub set_palette cdecl alias "set_palette" (byval p as PALETTE ptr)
declare sub set_palette_range cdecl alias "set_palette_range" (byval p as PALETTE ptr, byval from as integer, byval to as integer, byval retracesync as integer)
declare sub get_color cdecl alias "get_color" (byval index as integer, byval p as RGB ptr)
declare sub get_palette cdecl alias "get_palette" (byval p as PALETTE ptr)
declare sub get_palette_range cdecl alias "get_palette_range" (byval p as PALETTE ptr, byval from as integer, byval to as integer)
declare sub fade_interpolate cdecl alias "fade_interpolate" (byval source as PALETTE ptr, byval dest as PALETTE ptr, byval output as PALETTE ptr, byval pos as integer, byval from as integer, byval to as integer)
declare sub fade_from_range cdecl alias "fade_from_range" (byval source as PALETTE ptr, byval dest as PALETTE ptr, byval speed as integer, byval from as integer, byval to as integer)
declare sub fade_in_range cdecl alias "fade_in_range" (byval p as PALETTE ptr, byval speed as integer, byval from as integer, byval to as integer)
declare sub fade_out_range cdecl alias "fade_out_range" (byval speed as integer, byval from as integer, byval to as integer)
declare sub fade_from cdecl alias "fade_from" (byval source as PALETTE ptr, byval dest as PALETTE ptr, byval speed as integer)
declare sub fade_in cdecl alias "fade_in" (byval p as PALETTE ptr, byval speed as integer)
declare sub fade_out cdecl alias "fade_out" (byval speed as integer)
declare sub select_palette cdecl alias "select_palette" (byval p as PALETTE ptr)
declare sub unselect_palette cdecl alias "unselect_palette" ()
declare sub generate_332_palette cdecl alias "generate_332_palette" (byval pal as PALETTE ptr)
declare function generate_optimized_palette cdecl alias "generate_optimized_palette" (byval image as BITMAP ptr, byval pal as PALETTE ptr, byval rsvdcols as zstring ptr) as integer
declare sub create_rgb_table cdecl alias "create_rgb_table" (byval table as RGB_MAP ptr, byval pal as PALETTE ptr, byval callback as sub cdecl(byval as integer))
declare sub create_light_table cdecl alias "create_light_table" (byval table as COLOR_MAP ptr, byval pal as PALETTE ptr, byval r as integer, byval g as integer, byval b as integer, byval callback as sub cdecl(byval as integer))
declare sub create_trans_table cdecl alias "create_trans_table" (byval table as COLOR_MAP ptr, byval pal as PALETTE ptr, byval r as integer, byval g as integer, byval b as integer, byval callback as sub cdecl(byval as integer))
declare sub create_color_table cdecl alias "create_color_table" (byval table as COLOR_MAP ptr, byval pal as PALETTE ptr, byval blend as sub cdecl(byval as PALETTE ptr, byval as integer, byval as integer, byval as RGB ptr), byval callback as sub cdecl(byval as integer))
declare sub create_blender_table cdecl alias "create_blender_table" (byval table as COLOR_MAP ptr, byval pal as PALETTE ptr, byval callback as sub cdecl(byval as integer))

type BLENDER_FUNC as function cdecl(byval as uinteger, byval as uinteger, byval as uinteger) as uinteger

declare sub set_blender_mode cdecl alias "set_blender_mode" (byval b15 as BLENDER_FUNC, byval b16 as BLENDER_FUNC, byval b24 as BLENDER_FUNC, byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_blender_mode_ex cdecl alias "set_blender_mode_ex" (byval b15 as BLENDER_FUNC, byval b16 as BLENDER_FUNC, byval b24 as BLENDER_FUNC, byval b32 as BLENDER_FUNC, byval b15x as BLENDER_FUNC, byval b16x as BLENDER_FUNC, byval b24x as BLENDER_FUNC, byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_alpha_blender cdecl alias "set_alpha_blender" ()
declare sub set_write_alpha_blender cdecl alias "set_write_alpha_blender" ()
declare sub set_trans_blender cdecl alias "set_trans_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_add_blender cdecl alias "set_add_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_burn_blender cdecl alias "set_burn_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_color_blender cdecl alias "set_color_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_difference_blender cdecl alias "set_difference_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_dissolve_blender cdecl alias "set_dissolve_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_dodge_blender cdecl alias "set_dodge_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_hue_blender cdecl alias "set_hue_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_invert_blender cdecl alias "set_invert_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_luminance_blender cdecl alias "set_luminance_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_multiply_blender cdecl alias "set_multiply_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_saturation_blender cdecl alias "set_saturation_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub set_screen_blender cdecl alias "set_screen_blender" (byval r as integer, byval g as integer, byval b as integer, byval a as integer)
declare sub hsv_to_rgb cdecl alias "hsv_to_rgb" (byval h as single, byval s as single, byval v as single, byval r as integer ptr, byval g as integer ptr, byval b as integer ptr)
declare sub rgb_to_hsv cdecl alias "rgb_to_hsv" (byval r as integer, byval g as integer, byval b as integer, byval h as single ptr, byval s as single ptr, byval v as single ptr)
declare function bestfit_color cdecl alias "bestfit_color" (byval pal as PALETTE ptr, byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol cdecl alias "makecol" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol8 cdecl alias "makecol8" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol_depth cdecl alias "makecol_depth" (byval color_depth as integer, byval r as integer, byval g as integer, byval b as integer) as integer
declare function makeacol cdecl alias "makeacol" (byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function makeacol_depth cdecl alias "makeacol_depth" (byval color_depth as integer, byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function makecol15_dither cdecl alias "makecol15_dither" (byval r as integer, byval g as integer, byval b as integer, byval x as integer, byval y as integer) as integer
declare function makecol16_dither cdecl alias "makecol16_dither" (byval r as integer, byval g as integer, byval b as integer, byval x as integer, byval y as integer) as integer
declare function getr cdecl alias "getr" (byval c as integer) as integer
declare function getg cdecl alias "getg" (byval c as integer) as integer
declare function getb cdecl alias "getb" (byval c as integer) as integer
declare function geta cdecl alias "geta" (byval c as integer) as integer
declare function getr_depth cdecl alias "getr_depth" (byval color_depth as integer, byval c as integer) as integer
declare function getg_depth cdecl alias "getg_depth" (byval color_depth as integer, byval c as integer) as integer
declare function getb_depth cdecl alias "getb_depth" (byval color_depth as integer, byval c as integer) as integer
declare function geta_depth cdecl alias "geta_depth" (byval color_depth as integer, byval c as integer) as integer

#include once "allegro/inline/color.bi"

#endif
