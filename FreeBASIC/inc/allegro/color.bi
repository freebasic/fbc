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
'      Color manipulation routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_COLOR_H
#define ALLEGRO_COLOR_H

#include "allegro/base.bi"
#include "allegro/palette.bi"

Extern Import black_palette Alias "black_palette" As PALETTE
Extern Import desktop_palette Alias "desktop_palette" As PALETTE
Extern Import default_palette Alias "default_palette" As PALETTE

Type RGB_MAP
	data(31, 31, 31) As UByte
End Type

Type COLOR_MAP
	data(PAL_SIZE - 1, PAL_SIZE - 1) As UByte
End Type

Extern Import rgb_map Alias "rgb_map" As RGB_MAP Ptr
Extern Import color_map Alias "color_map" As COLOR_MAP Ptr

Extern Import _current_palette Alias "_current_palette" As PALETTE

extern import _rgb_r_shift_15 alias "_rgb_r_shift_15" as integer
extern import _rgb_g_shift_15 alias "_rgb_g_shift_15" as integer
extern import _rgb_b_shift_15 alias "_rgb_b_shift_15" as integer
extern import _rgb_r_shift_16 alias "_rgb_r_shift_16" as integer
extern import _rgb_g_shift_16 alias "_rgb_g_shift_16" as integer
extern import _rgb_b_shift_16 alias "_rgb_b_shift_16" as integer
extern import _rgb_r_shift_24 alias "_rgb_r_shift_24" as integer
extern import _rgb_g_shift_24 alias "_rgb_g_shift_24" as integer
extern import _rgb_b_shift_24 alias "_rgb_b_shift_24" as integer
extern import _rgb_r_shift_32 alias "_rgb_r_shift_32" as integer
extern import _rgb_g_shift_32 alias "_rgb_g_shift_32" as integer
extern import _rgb_b_shift_32 alias "_rgb_b_shift_32" as integer
extern import _rgb_a_shift_32 alias "_rgb_a_shift_32" as integer

extern import _rgb_scale_5 alias "_rgb_scale_5" as integer
extern import _rgb_scale_6 alias "_rgb_scale_6" as integer

#define MASK_COLOR_8	0
#define MASK_COLOR_15	&H7C1F
#define MASK_COLOR_16	&HF81F
#define MASK_COLOR_24	&HFF00FF
#define MASK_COLOR_32	&HFF00FF

Extern Import palette_color Alias "palette_color" As Integer Ptr

Declare Sub set_color CDecl Alias "set_color" (ByVal index As Integer, ByVal p As RGB Ptr)
Declare Sub set_palette CDecl Alias "set_palette" (ByVal p As PALETTE)
Declare Sub set_palette_range CDecl Alias "set_palette_range" (ByVal p As PALETTE, ByVal from As Integer, ByVal _to As Integer, ByVal retracesync As Integer)

Declare Sub get_color CDecl Alias "get_color" (ByVal index As Integer, ByVal p As RGB Ptr)
Declare Sub get_palette CDecl Alias "get_palette" (ByVal p As PALETTE)
Declare Sub get_palette_range CDecl Alias "get_palette_range" (ByVal p As PALETTE, ByVal from As Integer, ByVal iTo As Integer)

Declare Sub fade_interpolate CDecl Alias "fade_interpolate" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal poutput As RGB Ptr, ByVal pos As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from_range CDecl Alias "fade_from_range" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_in_range CDecl Alias "fade_in_range" (ByVal p As RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_out_range CDecl Alias "fade_out_range" (ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from CDecl Alias "fade_from" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal speed As Integer)
Declare Sub fade_in CDecl Alias "fade_in" (ByVal p As RGB Ptr, ByVal speed As Integer)
Declare Sub fade_out CDecl Alias "fade_out" (ByVal speed As Integer)

Declare Sub select_palette CDecl Alias "select_palette" (ByVal p As RGB Ptr)
Declare Sub unselect_palette CDecl Alias "unselect_palette" ()

Declare Sub generate_332_palette CDecl Alias "generate_332_palette" (ByVal pal As RGB ptr)
Declare Function generate_optimized_palette CDecl Alias "generate_optimized_palette" (ByVal bmp As BITMAP Ptr, ByVal pal As RGB ptr, ByVal rsvd As String) As Integer

Declare Sub create_rgb_table CDecl Alias "create_rgb_table" (ByVal table As RGB_MAP Ptr, ByVal pal As RGB Ptr, ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub create_light_table CDecl Alias "create_light_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As PALETTE, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub CDecl(ByVal _pos As Integer))
Declare sub create_trans_table CDecl Alias "create_trans_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As PALETTE, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub CDecl(ByVal _pos As Integer))
Declare Sub create_color_table CDecl Alias "create_color_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As PALETTE, ByVal blend As Sub CDecl(ByVal pal As PALETTE, ByVal x As Integer, ByVal y As Integer, ByVal _rgb As RGB Ptr), ByVal callback As Sub CDecl(ByVal _pos As Integer))
Declare Sub create_blender_table CDecl Alias "create_blender_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As PALETTE, ByVal callback As Sub CDecl(ByVal _pos As Integer))

Type BLENDER_FUNC As Function CDecl(ByVal x As UInteger, ByVal y As UInteger, ByVal n As UInteger) As UInteger

Declare Sub set_blender_mode CDecl Alias "set_blender_mode" (ByVal b15 As BLENDER_FUNC, ByVal b16 as BLENDER_FUNC, ByVal b24 as BLENDER_FUNC, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_blender_mode_ex CDecl Alias "set_blender_mode_ex" (ByVal b15 as BLENDER_FUNC, ByVal b16 as BLENDER_FUNC, ByVal b24 as BLENDER_FUNC, ByVal b32 as BLENDER_FUNC, ByVal b15x as BLENDER_FUNC, ByVal b16x as BLENDER_FUNC, ByVal b24x as BLENDER_FUNC, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)

Declare Sub set_alpha_blender CDecl Alias "set_alpha_blender" ()
Declare Sub set_write_alpha_blender CDecl Alias "set_write_alpha_blender" ()
Declare Sub set_trans_blender CDecl Alias "set_trans_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_add_blender CDecl Alias "set_add_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_burn_blender CDecl Alias "set_burn_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_color_blender CDecl Alias "set_color_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_difference_blender CDecl Alias "set_difference_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dissolve_blender CDecl Alias "set_dissolve_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dodge_blender CDecl Alias "set_dodge_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_hue_blender CDecl Alias "set_hue_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_invert_blender CDecl Alias "set_invert_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_luminance_blender CDecl Alias "set_luminance_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_multiply_blender CDecl Alias "set_multiply_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_saturation_blender CDecl Alias "set_saturation_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_screen_blender CDecl Alias "set_screen_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)

Declare Sub hsv_to_rgb CDecl Alias "hsv_to_rgb" (ByVal h As Single, ByVal s As Single, ByVal v As Single, ByRef r As Integer, ByRef g As Integer, ByRef b As Integer)
Declare Sub rgb_to_hsv CDecl Alias "rgb_to_hsv" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByRef h As Single, ByRef s As Single, ByRef v As Single)

Declare Function bestfit_color CDecl Alias "bestfit_color" (ByVal pal As RGB ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer

Declare Function makecol CDecl Alias "makecol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol8 CDecl Alias "makecol8" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol_depth CDecl Alias "makecol_depth" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer

Declare Function makeacol CDecl Alias "makeacol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makeacol_depth CDecl Alias "makeacol" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer

Declare Function makecol15_dither CDecl Alias "makecol15_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function makecol16_dither CDecl Alias "makecol16_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer

Declare Function getr CDecl Alias "getr" (ByVal c As Integer) As Integer
Declare Function getg CDecl Alias "getg" (ByVal c As Integer) As Integer
Declare Function getb CDecl Alias "getb" (ByVal c As Integer) As Integer
Declare Function geta CDecl Alias "geta" (ByVal c As Integer) As Integer

Declare Function getr_depth CDecl Alias "getr_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getg_depth CDecl Alias "getg_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getb_depth CDecl Alias "getb_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function geta_depth CDecl Alias "geta_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer

#include "allegro/inline/color.inl"

#endif
