'' FreeBASIC binding for cairo-1.14.2
''
'' based on the C header files:
''   cairo - a vector graphics library with display and print output
''
''   Copyright © 2002 University of Southern California
''   Copyright © 2005 Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it either under the terms of the GNU Lesser General Public
''   License version 2.1 as published by the Free Software Foundation
''   (the "LGPL") or, at your option, under the terms of the Mozilla
''   Public License Version 1.1 (the "MPL"). If you do not alter this
''   notice, a recipient may use your version of this file under either
''   the MPL or the LGPL.
''
''   You should have received a copy of the LGPL along with this library
''   in the file COPYING-LGPL-2.1; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
''   You should have received a copy of the MPL along with this library
''   in the file COPYING-MPL-1.1
''
''   The contents of this file are subject to the Mozilla Public License
''   Version 1.1 (the "License"); you may not use this file except in
''   compliance with the License. You may obtain a copy of the License at
''   http://www.mozilla.org/MPL/
''
''   This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
''   OF ANY KIND, either express or implied. See the LGPL or the MPL for
''   the specific language governing rights and limitations.
''
''   The Original Code is the cairo graphics library.
''
''   The Initial Developer of the Original Code is University of Southern
''   California.
''
''   Contributor(s):
''   Carl D. Worth <cworth@cworth.org>
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "cairo"

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     #define CAIRO_VERSION => CAIRO_VERSION_
''     #define CAIRO_VERSION_STRING => CAIRO_VERSION_STRING_

extern "C"

#define CAIRO_H
#define CAIRO_VERSION_H
const CAIRO_VERSION_MAJOR = 1
const CAIRO_VERSION_MINOR = 14
const CAIRO_VERSION_MICRO = 2
#define CAIRO_DEPRECATED_H
#define cairo_current_font_extents cairo_current_font_extents_REPLACED_BY_cairo_font_extents
#define cairo_get_font_extents cairo_get_font_extents_REPLACED_BY_cairo_font_extents
#define cairo_current_operator cairo_current_operator_REPLACED_BY_cairo_get_operator
#define cairo_current_tolerance cairo_current_tolerance_REPLACED_BY_cairo_get_tolerance
#define cairo_current_point cairo_current_point_REPLACED_BY_cairo_get_current_point
#define cairo_current_fill_rule cairo_current_fill_rule_REPLACED_BY_cairo_get_fill_rule
#define cairo_current_line_width cairo_current_line_width_REPLACED_BY_cairo_get_line_width
#define cairo_current_line_cap cairo_current_line_cap_REPLACED_BY_cairo_get_line_cap
#define cairo_current_line_join cairo_current_line_join_REPLACED_BY_cairo_get_line_join
#define cairo_current_miter_limit cairo_current_miter_limit_REPLACED_BY_cairo_get_miter_limit
#define cairo_current_matrix cairo_current_matrix_REPLACED_BY_cairo_get_matrix
#define cairo_current_target_surface cairo_current_target_surface_REPLACED_BY_cairo_get_target
#define cairo_get_status cairo_get_status_REPLACED_BY_cairo_status
#define cairo_concat_matrix cairo_concat_matrix_REPLACED_BY_cairo_transform
#define cairo_scale_font cairo_scale_font_REPLACED_BY_cairo_set_font_size
#define cairo_select_font cairo_select_font_REPLACED_BY_cairo_select_font_face
#define cairo_transform_font cairo_transform_font_REPLACED_BY_cairo_set_font_matrix
#define cairo_transform_point cairo_transform_point_REPLACED_BY_cairo_user_to_device
#define cairo_transform_distance cairo_transform_distance_REPLACED_BY_cairo_user_to_device_distance
#define cairo_inverse_transform_point cairo_inverse_transform_point_REPLACED_BY_cairo_device_to_user
#define cairo_inverse_transform_distance cairo_inverse_transform_distance_REPLACED_BY_cairo_device_to_user_distance
#define cairo_init_clip cairo_init_clip_REPLACED_BY_cairo_reset_clip
#define cairo_surface_create_for_image cairo_surface_create_for_image_REPLACED_BY_cairo_image_surface_create_for_data
#define cairo_default_matrix cairo_default_matrix_REPLACED_BY_cairo_identity_matrix
#define cairo_matrix_set_affine cairo_matrix_set_affine_REPLACED_BY_cairo_matrix_init
#define cairo_matrix_set_identity cairo_matrix_set_identity_REPLACED_BY_cairo_matrix_init_identity
#define cairo_pattern_add_color_stop cairo_pattern_add_color_stop_REPLACED_BY_cairo_pattern_add_color_stop_rgba
#define cairo_set_rgb_color cairo_set_rgb_color_REPLACED_BY_cairo_set_source_rgb
#define cairo_set_pattern cairo_set_pattern_REPLACED_BY_cairo_set_source
#define cairo_xlib_surface_create_for_pixmap_with_visual cairo_xlib_surface_create_for_pixmap_with_visual_REPLACED_BY_cairo_xlib_surface_create
#define cairo_xlib_surface_create_for_window_with_visual cairo_xlib_surface_create_for_window_with_visual_REPLACED_BY_cairo_xlib_surface_create
#define cairo_xcb_surface_create_for_pixmap_with_visual cairo_xcb_surface_create_for_pixmap_with_visual_REPLACED_BY_cairo_xcb_surface_create
#define cairo_xcb_surface_create_for_window_with_visual cairo_xcb_surface_create_for_window_with_visual_REPLACED_BY_cairo_xcb_surface_create
#define cairo_ps_surface_set_dpi cairo_ps_surface_set_dpi_REPLACED_BY_cairo_surface_set_fallback_resolution
#define cairo_pdf_surface_set_dpi cairo_pdf_surface_set_dpi_REPLACED_BY_cairo_surface_set_fallback_resolution
#define cairo_svg_surface_set_dpi cairo_svg_surface_set_dpi_REPLACED_BY_cairo_surface_set_fallback_resolution
#define cairo_atsui_font_face_create_for_atsu_font_id cairo_atsui_font_face_create_for_atsu_font_id_REPLACED_BY_cairo_quartz_font_face_create_for_atsu_font_id
#define cairo_current_path cairo_current_path_DEPRECATED_BY_cairo_copy_path
#define cairo_current_path_flat cairo_current_path_flat_DEPRECATED_BY_cairo_copy_path_flat
#define cairo_get_path cairo_get_path_DEPRECATED_BY_cairo_copy_path
#define cairo_get_path_flat cairo_get_path_flat_DEPRECATED_BY_cairo_get_path_flat
#define cairo_set_alpha cairo_set_alpha_DEPRECATED_BY_cairo_set_source_rgba_OR_cairo_paint_with_alpha
#define cairo_show_surface cairo_show_surface_DEPRECATED_BY_cairo_set_source_surface_AND_cairo_paint
#define cairo_copy cairo_copy_DEPRECATED_BY_cairo_create_AND_MANY_INDIVIDUAL_FUNCTIONS
#define cairo_surface_set_repeat cairo_surface_set_repeat_DEPRECATED_BY_cairo_pattern_set_extend
#define cairo_surface_set_matrix cairo_surface_set_matrix_DEPRECATED_BY_cairo_pattern_set_matrix
#define cairo_surface_get_matrix cairo_surface_get_matrix_DEPRECATED_BY_cairo_pattern_get_matrix
#define cairo_surface_set_filter cairo_surface_set_filter_DEPRECATED_BY_cairo_pattern_set_filter
#define cairo_surface_get_filter cairo_surface_get_filter_DEPRECATED_BY_cairo_pattern_get_filter
#define cairo_matrix_create cairo_matrix_create_DEPRECATED_BY_cairo_matrix_t
#define cairo_matrix_destroy cairo_matrix_destroy_DEPRECATED_BY_cairo_matrix_t
#define cairo_matrix_copy cairo_matrix_copy_DEPRECATED_BY_cairo_matrix_t
#define cairo_matrix_get_affine cairo_matrix_get_affine_DEPRECATED_BY_cairo_matrix_t
#define cairo_set_target_surface cairo_set_target_surface_DEPRECATED_BY_cairo_create
#define cairo_set_target_image cairo_set_target_image_DEPRECATED_BY_cairo_image_surface_create_for_data
#define cairo_set_target_pdf cairo_set_target_pdf_DEPRECATED_BY_cairo_pdf_surface_create
#define cairo_set_target_png cairo_set_target_png_DEPRECATED_BY_cairo_surface_write_to_png
#define cairo_set_target_ps cairo_set_target_ps_DEPRECATED_BY_cairo_ps_surface_create
#define cairo_set_target_quartz cairo_set_target_quartz_DEPRECATED_BY_cairo_quartz_surface_create
#define cairo_set_target_win32 cairo_set_target_win32_DEPRECATED_BY_cairo_win32_surface_create
#define cairo_set_target_xcb cairo_set_target_xcb_DEPRECATED_BY_cairo_xcb_surface_create
#define cairo_set_target_drawable cairo_set_target_drawable_DEPRECATED_BY_cairo_xlib_surface_create
#define cairo_get_status_string cairo_get_status_string_DEPRECATED_BY_cairo_status_AND_cairo_status_to_string
#define cairo_status_string cairo_status_string_DEPRECATED_BY_cairo_status_AND_cairo_status_to_string
#define CAIRO_BEGIN_DECLS
#define CAIRO_END_DECLS
#define cairo_public
#define CAIRO_VERSION_ENCODE(major, minor, micro) ((((major) * 10000) + ((minor) * 100)) + ((micro) * 1))
#define CAIRO_VERSION_ CAIRO_VERSION_ENCODE(CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)
#define CAIRO_VERSION_STRINGIZE_(major, minor, micro) #major "." #minor "." #micro
#define CAIRO_VERSION_STRINGIZE(major, minor, micro) CAIRO_VERSION_STRINGIZE_(major, minor, micro)
#define CAIRO_VERSION_STRING_ CAIRO_VERSION_STRINGIZE(CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)
declare function cairo_version() as long
declare function cairo_version_string() as const zstring ptr

type cairo_bool_t as long
type cairo_t as _cairo
type cairo_surface_t as _cairo_surface
type cairo_device_t as _cairo_device

type _cairo_matrix
	xx as double
	yx as double
	xy as double
	yy as double
	x0 as double
	y0 as double
end type

type cairo_matrix_t as _cairo_matrix
type cairo_pattern_t as _cairo_pattern
type cairo_destroy_func_t as sub(byval data as any ptr)

type _cairo_user_data_key
	unused as long
end type

type cairo_user_data_key_t as _cairo_user_data_key

type _cairo_status as long
enum
	CAIRO_STATUS_SUCCESS = 0
	CAIRO_STATUS_NO_MEMORY
	CAIRO_STATUS_INVALID_RESTORE
	CAIRO_STATUS_INVALID_POP_GROUP
	CAIRO_STATUS_NO_CURRENT_POINT
	CAIRO_STATUS_INVALID_MATRIX
	CAIRO_STATUS_INVALID_STATUS
	CAIRO_STATUS_NULL_POINTER
	CAIRO_STATUS_INVALID_STRING
	CAIRO_STATUS_INVALID_PATH_DATA
	CAIRO_STATUS_READ_ERROR
	CAIRO_STATUS_WRITE_ERROR
	CAIRO_STATUS_SURFACE_FINISHED
	CAIRO_STATUS_SURFACE_TYPE_MISMATCH
	CAIRO_STATUS_PATTERN_TYPE_MISMATCH
	CAIRO_STATUS_INVALID_CONTENT
	CAIRO_STATUS_INVALID_FORMAT
	CAIRO_STATUS_INVALID_VISUAL
	CAIRO_STATUS_FILE_NOT_FOUND
	CAIRO_STATUS_INVALID_DASH
	CAIRO_STATUS_INVALID_DSC_COMMENT
	CAIRO_STATUS_INVALID_INDEX
	CAIRO_STATUS_CLIP_NOT_REPRESENTABLE
	CAIRO_STATUS_TEMP_FILE_ERROR
	CAIRO_STATUS_INVALID_STRIDE
	CAIRO_STATUS_FONT_TYPE_MISMATCH
	CAIRO_STATUS_USER_FONT_IMMUTABLE
	CAIRO_STATUS_USER_FONT_ERROR
	CAIRO_STATUS_NEGATIVE_COUNT
	CAIRO_STATUS_INVALID_CLUSTERS
	CAIRO_STATUS_INVALID_SLANT
	CAIRO_STATUS_INVALID_WEIGHT
	CAIRO_STATUS_INVALID_SIZE
	CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED
	CAIRO_STATUS_DEVICE_TYPE_MISMATCH
	CAIRO_STATUS_DEVICE_ERROR
	CAIRO_STATUS_INVALID_MESH_CONSTRUCTION
	CAIRO_STATUS_DEVICE_FINISHED
	CAIRO_STATUS_JBIG2_GLOBAL_MISSING
	CAIRO_STATUS_LAST_STATUS
end enum

type cairo_status_t as _cairo_status

type _cairo_content as long
enum
	CAIRO_CONTENT_COLOR = &h1000
	CAIRO_CONTENT_ALPHA = &h2000
	CAIRO_CONTENT_COLOR_ALPHA = &h3000
end enum

type cairo_content_t as _cairo_content

type _cairo_format as long
enum
	CAIRO_FORMAT_INVALID = -1
	CAIRO_FORMAT_ARGB32 = 0
	CAIRO_FORMAT_RGB24 = 1
	CAIRO_FORMAT_A8 = 2
	CAIRO_FORMAT_A1 = 3
	CAIRO_FORMAT_RGB16_565 = 4
	CAIRO_FORMAT_RGB30 = 5
end enum

type cairo_format_t as _cairo_format
type cairo_write_func_t as function(byval closure as any ptr, byval data as const ubyte ptr, byval length as ulong) as cairo_status_t
type cairo_read_func_t as function(byval closure as any ptr, byval data as ubyte ptr, byval length as ulong) as cairo_status_t

type _cairo_rectangle_int
	x as long
	y as long
	width as long
	height as long
end type

type cairo_rectangle_int_t as _cairo_rectangle_int
declare function cairo_create(byval target as cairo_surface_t ptr) as cairo_t ptr
declare function cairo_reference(byval cr as cairo_t ptr) as cairo_t ptr
declare sub cairo_destroy(byval cr as cairo_t ptr)
declare function cairo_get_reference_count(byval cr as cairo_t ptr) as ulong
declare function cairo_get_user_data(byval cr as cairo_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_set_user_data(byval cr as cairo_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare sub cairo_save(byval cr as cairo_t ptr)
declare sub cairo_restore(byval cr as cairo_t ptr)
declare sub cairo_push_group(byval cr as cairo_t ptr)
declare sub cairo_push_group_with_content(byval cr as cairo_t ptr, byval content as cairo_content_t)
declare function cairo_pop_group(byval cr as cairo_t ptr) as cairo_pattern_t ptr
declare sub cairo_pop_group_to_source(byval cr as cairo_t ptr)

type _cairo_operator as long
enum
	CAIRO_OPERATOR_CLEAR
	CAIRO_OPERATOR_SOURCE
	CAIRO_OPERATOR_OVER
	CAIRO_OPERATOR_IN
	CAIRO_OPERATOR_OUT
	CAIRO_OPERATOR_ATOP
	CAIRO_OPERATOR_DEST
	CAIRO_OPERATOR_DEST_OVER
	CAIRO_OPERATOR_DEST_IN
	CAIRO_OPERATOR_DEST_OUT
	CAIRO_OPERATOR_DEST_ATOP
	CAIRO_OPERATOR_XOR
	CAIRO_OPERATOR_ADD
	CAIRO_OPERATOR_SATURATE
	CAIRO_OPERATOR_MULTIPLY
	CAIRO_OPERATOR_SCREEN
	CAIRO_OPERATOR_OVERLAY
	CAIRO_OPERATOR_DARKEN
	CAIRO_OPERATOR_LIGHTEN
	CAIRO_OPERATOR_COLOR_DODGE
	CAIRO_OPERATOR_COLOR_BURN
	CAIRO_OPERATOR_HARD_LIGHT
	CAIRO_OPERATOR_SOFT_LIGHT
	CAIRO_OPERATOR_DIFFERENCE
	CAIRO_OPERATOR_EXCLUSION
	CAIRO_OPERATOR_HSL_HUE
	CAIRO_OPERATOR_HSL_SATURATION
	CAIRO_OPERATOR_HSL_COLOR
	CAIRO_OPERATOR_HSL_LUMINOSITY
end enum

type cairo_operator_t as _cairo_operator
declare sub cairo_set_operator(byval cr as cairo_t ptr, byval op as cairo_operator_t)
declare sub cairo_set_source(byval cr as cairo_t ptr, byval source as cairo_pattern_t ptr)
declare sub cairo_set_source_rgb(byval cr as cairo_t ptr, byval red as double, byval green as double, byval blue as double)
declare sub cairo_set_source_rgba(byval cr as cairo_t ptr, byval red as double, byval green as double, byval blue as double, byval alpha as double)
declare sub cairo_set_source_surface(byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval x as double, byval y as double)
declare sub cairo_set_tolerance(byval cr as cairo_t ptr, byval tolerance as double)

type _cairo_antialias as long
enum
	CAIRO_ANTIALIAS_DEFAULT
	CAIRO_ANTIALIAS_NONE
	CAIRO_ANTIALIAS_GRAY
	CAIRO_ANTIALIAS_SUBPIXEL
	CAIRO_ANTIALIAS_FAST
	CAIRO_ANTIALIAS_GOOD
	CAIRO_ANTIALIAS_BEST
end enum

type cairo_antialias_t as _cairo_antialias
declare sub cairo_set_antialias(byval cr as cairo_t ptr, byval antialias as cairo_antialias_t)

type _cairo_fill_rule as long
enum
	CAIRO_FILL_RULE_WINDING
	CAIRO_FILL_RULE_EVEN_ODD
end enum

type cairo_fill_rule_t as _cairo_fill_rule
declare sub cairo_set_fill_rule(byval cr as cairo_t ptr, byval fill_rule as cairo_fill_rule_t)
declare sub cairo_set_line_width(byval cr as cairo_t ptr, byval width as double)

type _cairo_line_cap as long
enum
	CAIRO_LINE_CAP_BUTT
	CAIRO_LINE_CAP_ROUND
	CAIRO_LINE_CAP_SQUARE
end enum

type cairo_line_cap_t as _cairo_line_cap
declare sub cairo_set_line_cap(byval cr as cairo_t ptr, byval line_cap as cairo_line_cap_t)

type _cairo_line_join as long
enum
	CAIRO_LINE_JOIN_MITER
	CAIRO_LINE_JOIN_ROUND
	CAIRO_LINE_JOIN_BEVEL
end enum

type cairo_line_join_t as _cairo_line_join
declare sub cairo_set_line_join(byval cr as cairo_t ptr, byval line_join as cairo_line_join_t)
declare sub cairo_set_dash(byval cr as cairo_t ptr, byval dashes as const double ptr, byval num_dashes as long, byval offset as double)
declare sub cairo_set_miter_limit(byval cr as cairo_t ptr, byval limit as double)
declare sub cairo_translate(byval cr as cairo_t ptr, byval tx as double, byval ty as double)
declare sub cairo_scale(byval cr as cairo_t ptr, byval sx as double, byval sy as double)
declare sub cairo_rotate(byval cr as cairo_t ptr, byval angle as double)
declare sub cairo_transform(byval cr as cairo_t ptr, byval matrix as const cairo_matrix_t ptr)
declare sub cairo_set_matrix(byval cr as cairo_t ptr, byval matrix as const cairo_matrix_t ptr)
declare sub cairo_identity_matrix(byval cr as cairo_t ptr)
declare sub cairo_user_to_device(byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare sub cairo_user_to_device_distance(byval cr as cairo_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_device_to_user(byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare sub cairo_device_to_user_distance(byval cr as cairo_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_new_path(byval cr as cairo_t ptr)
declare sub cairo_move_to(byval cr as cairo_t ptr, byval x as double, byval y as double)
declare sub cairo_new_sub_path(byval cr as cairo_t ptr)
declare sub cairo_line_to(byval cr as cairo_t ptr, byval x as double, byval y as double)
declare sub cairo_curve_to(byval cr as cairo_t ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double)
declare sub cairo_arc(byval cr as cairo_t ptr, byval xc as double, byval yc as double, byval radius as double, byval angle1 as double, byval angle2 as double)
declare sub cairo_arc_negative(byval cr as cairo_t ptr, byval xc as double, byval yc as double, byval radius as double, byval angle1 as double, byval angle2 as double)
declare sub cairo_rel_move_to(byval cr as cairo_t ptr, byval dx as double, byval dy as double)
declare sub cairo_rel_line_to(byval cr as cairo_t ptr, byval dx as double, byval dy as double)
declare sub cairo_rel_curve_to(byval cr as cairo_t ptr, byval dx1 as double, byval dy1 as double, byval dx2 as double, byval dy2 as double, byval dx3 as double, byval dy3 as double)
declare sub cairo_rectangle(byval cr as cairo_t ptr, byval x as double, byval y as double, byval width as double, byval height as double)
declare sub cairo_close_path(byval cr as cairo_t ptr)
declare sub cairo_path_extents(byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cairo_paint(byval cr as cairo_t ptr)
declare sub cairo_paint_with_alpha(byval cr as cairo_t ptr, byval alpha as double)
declare sub cairo_mask(byval cr as cairo_t ptr, byval pattern as cairo_pattern_t ptr)
declare sub cairo_mask_surface(byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval surface_x as double, byval surface_y as double)
declare sub cairo_stroke(byval cr as cairo_t ptr)
declare sub cairo_stroke_preserve(byval cr as cairo_t ptr)
declare sub cairo_fill(byval cr as cairo_t ptr)
declare sub cairo_fill_preserve(byval cr as cairo_t ptr)
declare sub cairo_copy_page(byval cr as cairo_t ptr)
declare sub cairo_show_page(byval cr as cairo_t ptr)
declare function cairo_in_stroke(byval cr as cairo_t ptr, byval x as double, byval y as double) as cairo_bool_t
declare function cairo_in_fill(byval cr as cairo_t ptr, byval x as double, byval y as double) as cairo_bool_t
declare function cairo_in_clip(byval cr as cairo_t ptr, byval x as double, byval y as double) as cairo_bool_t
declare sub cairo_stroke_extents(byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cairo_fill_extents(byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cairo_reset_clip(byval cr as cairo_t ptr)
declare sub cairo_clip(byval cr as cairo_t ptr)
declare sub cairo_clip_preserve(byval cr as cairo_t ptr)
declare sub cairo_clip_extents(byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)

type _cairo_rectangle
	x as double
	y as double
	width as double
	height as double
end type

type cairo_rectangle_t as _cairo_rectangle

type _cairo_rectangle_list
	status as cairo_status_t
	rectangles as cairo_rectangle_t ptr
	num_rectangles as long
end type

type cairo_rectangle_list_t as _cairo_rectangle_list
declare function cairo_copy_clip_rectangle_list(byval cr as cairo_t ptr) as cairo_rectangle_list_t ptr
declare sub cairo_rectangle_list_destroy(byval rectangle_list as cairo_rectangle_list_t ptr)
type cairo_scaled_font_t as _cairo_scaled_font
type cairo_font_face_t as _cairo_font_face

type cairo_glyph_t
	index as culong
	x as double
	y as double
end type

declare function cairo_glyph_allocate(byval num_glyphs as long) as cairo_glyph_t ptr
declare sub cairo_glyph_free(byval glyphs as cairo_glyph_t ptr)

type cairo_text_cluster_t
	num_bytes as long
	num_glyphs as long
end type

declare function cairo_text_cluster_allocate(byval num_clusters as long) as cairo_text_cluster_t ptr
declare sub cairo_text_cluster_free(byval clusters as cairo_text_cluster_t ptr)

type _cairo_text_cluster_flags as long
enum
	CAIRO_TEXT_CLUSTER_FLAG_BACKWARD = &h00000001
end enum

type cairo_text_cluster_flags_t as _cairo_text_cluster_flags

type cairo_text_extents_t
	x_bearing as double
	y_bearing as double
	width as double
	height as double
	x_advance as double
	y_advance as double
end type

type cairo_font_extents_t
	ascent as double
	descent as double
	height as double
	max_x_advance as double
	max_y_advance as double
end type

type _cairo_font_slant as long
enum
	CAIRO_FONT_SLANT_NORMAL
	CAIRO_FONT_SLANT_ITALIC
	CAIRO_FONT_SLANT_OBLIQUE
end enum

type cairo_font_slant_t as _cairo_font_slant

type _cairo_font_weight as long
enum
	CAIRO_FONT_WEIGHT_NORMAL
	CAIRO_FONT_WEIGHT_BOLD
end enum

type cairo_font_weight_t as _cairo_font_weight

type _cairo_subpixel_order as long
enum
	CAIRO_SUBPIXEL_ORDER_DEFAULT
	CAIRO_SUBPIXEL_ORDER_RGB
	CAIRO_SUBPIXEL_ORDER_BGR
	CAIRO_SUBPIXEL_ORDER_VRGB
	CAIRO_SUBPIXEL_ORDER_VBGR
end enum

type cairo_subpixel_order_t as _cairo_subpixel_order

type _cairo_hint_style as long
enum
	CAIRO_HINT_STYLE_DEFAULT
	CAIRO_HINT_STYLE_NONE
	CAIRO_HINT_STYLE_SLIGHT
	CAIRO_HINT_STYLE_MEDIUM
	CAIRO_HINT_STYLE_FULL
end enum

type cairo_hint_style_t as _cairo_hint_style

type _cairo_hint_metrics as long
enum
	CAIRO_HINT_METRICS_DEFAULT
	CAIRO_HINT_METRICS_OFF
	CAIRO_HINT_METRICS_ON
end enum

type cairo_hint_metrics_t as _cairo_hint_metrics
type cairo_font_options_t as _cairo_font_options
declare function cairo_font_options_create() as cairo_font_options_t ptr
declare function cairo_font_options_copy(byval original as const cairo_font_options_t ptr) as cairo_font_options_t ptr
declare sub cairo_font_options_destroy(byval options as cairo_font_options_t ptr)
declare function cairo_font_options_status(byval options as cairo_font_options_t ptr) as cairo_status_t
declare sub cairo_font_options_merge(byval options as cairo_font_options_t ptr, byval other as const cairo_font_options_t ptr)
declare function cairo_font_options_equal(byval options as const cairo_font_options_t ptr, byval other as const cairo_font_options_t ptr) as cairo_bool_t
declare function cairo_font_options_hash(byval options as const cairo_font_options_t ptr) as culong
declare sub cairo_font_options_set_antialias(byval options as cairo_font_options_t ptr, byval antialias as cairo_antialias_t)
declare function cairo_font_options_get_antialias(byval options as const cairo_font_options_t ptr) as cairo_antialias_t
declare sub cairo_font_options_set_subpixel_order(byval options as cairo_font_options_t ptr, byval subpixel_order as cairo_subpixel_order_t)
declare function cairo_font_options_get_subpixel_order(byval options as const cairo_font_options_t ptr) as cairo_subpixel_order_t
declare sub cairo_font_options_set_hint_style(byval options as cairo_font_options_t ptr, byval hint_style as cairo_hint_style_t)
declare function cairo_font_options_get_hint_style(byval options as const cairo_font_options_t ptr) as cairo_hint_style_t
declare sub cairo_font_options_set_hint_metrics(byval options as cairo_font_options_t ptr, byval hint_metrics as cairo_hint_metrics_t)
declare function cairo_font_options_get_hint_metrics(byval options as const cairo_font_options_t ptr) as cairo_hint_metrics_t
declare sub cairo_select_font_face(byval cr as cairo_t ptr, byval family as const zstring ptr, byval slant as cairo_font_slant_t, byval weight as cairo_font_weight_t)
declare sub cairo_set_font_size(byval cr as cairo_t ptr, byval size as double)
declare sub cairo_set_font_matrix(byval cr as cairo_t ptr, byval matrix as const cairo_matrix_t ptr)
declare sub cairo_get_font_matrix(byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_set_font_options(byval cr as cairo_t ptr, byval options as const cairo_font_options_t ptr)
declare sub cairo_get_font_options(byval cr as cairo_t ptr, byval options as cairo_font_options_t ptr)
declare sub cairo_set_font_face(byval cr as cairo_t ptr, byval font_face as cairo_font_face_t ptr)
declare function cairo_get_font_face(byval cr as cairo_t ptr) as cairo_font_face_t ptr
declare sub cairo_set_scaled_font(byval cr as cairo_t ptr, byval scaled_font as const cairo_scaled_font_t ptr)
declare function cairo_get_scaled_font(byval cr as cairo_t ptr) as cairo_scaled_font_t ptr
declare sub cairo_show_text(byval cr as cairo_t ptr, byval utf8 as const zstring ptr)
declare sub cairo_show_glyphs(byval cr as cairo_t ptr, byval glyphs as const cairo_glyph_t ptr, byval num_glyphs as long)
declare sub cairo_show_text_glyphs(byval cr as cairo_t ptr, byval utf8 as const zstring ptr, byval utf8_len as long, byval glyphs as const cairo_glyph_t ptr, byval num_glyphs as long, byval clusters as const cairo_text_cluster_t ptr, byval num_clusters as long, byval cluster_flags as cairo_text_cluster_flags_t)
declare sub cairo_text_path(byval cr as cairo_t ptr, byval utf8 as const zstring ptr)
declare sub cairo_glyph_path(byval cr as cairo_t ptr, byval glyphs as const cairo_glyph_t ptr, byval num_glyphs as long)
declare sub cairo_text_extents(byval cr as cairo_t ptr, byval utf8 as const zstring ptr, byval extents as cairo_text_extents_t ptr)
declare sub cairo_glyph_extents(byval cr as cairo_t ptr, byval glyphs as const cairo_glyph_t ptr, byval num_glyphs as long, byval extents as cairo_text_extents_t ptr)
declare sub cairo_font_extents(byval cr as cairo_t ptr, byval extents as cairo_font_extents_t ptr)
declare function cairo_font_face_reference(byval font_face as cairo_font_face_t ptr) as cairo_font_face_t ptr
declare sub cairo_font_face_destroy(byval font_face as cairo_font_face_t ptr)
declare function cairo_font_face_get_reference_count(byval font_face as cairo_font_face_t ptr) as ulong
declare function cairo_font_face_status(byval font_face as cairo_font_face_t ptr) as cairo_status_t

type _cairo_font_type as long
enum
	CAIRO_FONT_TYPE_TOY
	CAIRO_FONT_TYPE_FT
	CAIRO_FONT_TYPE_WIN32
	CAIRO_FONT_TYPE_QUARTZ
	CAIRO_FONT_TYPE_USER
end enum

const CAIRO_FONT_TYPE_ATSUI = CAIRO_FONT_TYPE_QUARTZ
type cairo_font_type_t as _cairo_font_type
declare function cairo_font_face_get_type(byval font_face as cairo_font_face_t ptr) as cairo_font_type_t
declare function cairo_font_face_get_user_data(byval font_face as cairo_font_face_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_font_face_set_user_data(byval font_face as cairo_font_face_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare function cairo_scaled_font_create(byval font_face as cairo_font_face_t ptr, byval font_matrix as const cairo_matrix_t ptr, byval ctm as const cairo_matrix_t ptr, byval options as const cairo_font_options_t ptr) as cairo_scaled_font_t ptr
declare function cairo_scaled_font_reference(byval scaled_font as cairo_scaled_font_t ptr) as cairo_scaled_font_t ptr
declare sub cairo_scaled_font_destroy(byval scaled_font as cairo_scaled_font_t ptr)
declare function cairo_scaled_font_get_reference_count(byval scaled_font as cairo_scaled_font_t ptr) as ulong
declare function cairo_scaled_font_status(byval scaled_font as cairo_scaled_font_t ptr) as cairo_status_t
declare function cairo_scaled_font_get_type(byval scaled_font as cairo_scaled_font_t ptr) as cairo_font_type_t
declare function cairo_scaled_font_get_user_data(byval scaled_font as cairo_scaled_font_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_scaled_font_set_user_data(byval scaled_font as cairo_scaled_font_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare sub cairo_scaled_font_extents(byval scaled_font as cairo_scaled_font_t ptr, byval extents as cairo_font_extents_t ptr)
declare sub cairo_scaled_font_text_extents(byval scaled_font as cairo_scaled_font_t ptr, byval utf8 as const zstring ptr, byval extents as cairo_text_extents_t ptr)
declare sub cairo_scaled_font_glyph_extents(byval scaled_font as cairo_scaled_font_t ptr, byval glyphs as const cairo_glyph_t ptr, byval num_glyphs as long, byval extents as cairo_text_extents_t ptr)
declare function cairo_scaled_font_text_to_glyphs(byval scaled_font as cairo_scaled_font_t ptr, byval x as double, byval y as double, byval utf8 as const zstring ptr, byval utf8_len as long, byval glyphs as cairo_glyph_t ptr ptr, byval num_glyphs as long ptr, byval clusters as cairo_text_cluster_t ptr ptr, byval num_clusters as long ptr, byval cluster_flags as cairo_text_cluster_flags_t ptr) as cairo_status_t
declare function cairo_scaled_font_get_font_face(byval scaled_font as cairo_scaled_font_t ptr) as cairo_font_face_t ptr
declare sub cairo_scaled_font_get_font_matrix(byval scaled_font as cairo_scaled_font_t ptr, byval font_matrix as cairo_matrix_t ptr)
declare sub cairo_scaled_font_get_ctm(byval scaled_font as cairo_scaled_font_t ptr, byval ctm as cairo_matrix_t ptr)
declare sub cairo_scaled_font_get_scale_matrix(byval scaled_font as cairo_scaled_font_t ptr, byval scale_matrix as cairo_matrix_t ptr)
declare sub cairo_scaled_font_get_font_options(byval scaled_font as cairo_scaled_font_t ptr, byval options as cairo_font_options_t ptr)
declare function cairo_toy_font_face_create(byval family as const zstring ptr, byval slant as cairo_font_slant_t, byval weight as cairo_font_weight_t) as cairo_font_face_t ptr
declare function cairo_toy_font_face_get_family(byval font_face as cairo_font_face_t ptr) as const zstring ptr
declare function cairo_toy_font_face_get_slant(byval font_face as cairo_font_face_t ptr) as cairo_font_slant_t
declare function cairo_toy_font_face_get_weight(byval font_face as cairo_font_face_t ptr) as cairo_font_weight_t
declare function cairo_user_font_face_create() as cairo_font_face_t ptr

type cairo_user_scaled_font_init_func_t as function(byval scaled_font as cairo_scaled_font_t ptr, byval cr as cairo_t ptr, byval extents as cairo_font_extents_t ptr) as cairo_status_t
type cairo_user_scaled_font_render_glyph_func_t as function(byval scaled_font as cairo_scaled_font_t ptr, byval glyph as culong, byval cr as cairo_t ptr, byval extents as cairo_text_extents_t ptr) as cairo_status_t
type cairo_user_scaled_font_text_to_glyphs_func_t as function(byval scaled_font as cairo_scaled_font_t ptr, byval utf8 as const zstring ptr, byval utf8_len as long, byval glyphs as cairo_glyph_t ptr ptr, byval num_glyphs as long ptr, byval clusters as cairo_text_cluster_t ptr ptr, byval num_clusters as long ptr, byval cluster_flags as cairo_text_cluster_flags_t ptr) as cairo_status_t
type cairo_user_scaled_font_unicode_to_glyph_func_t as function(byval scaled_font as cairo_scaled_font_t ptr, byval unicode as culong, byval glyph_index as culong ptr) as cairo_status_t

declare sub cairo_user_font_face_set_init_func(byval font_face as cairo_font_face_t ptr, byval init_func as cairo_user_scaled_font_init_func_t)
declare sub cairo_user_font_face_set_render_glyph_func(byval font_face as cairo_font_face_t ptr, byval render_glyph_func as cairo_user_scaled_font_render_glyph_func_t)
declare sub cairo_user_font_face_set_text_to_glyphs_func(byval font_face as cairo_font_face_t ptr, byval text_to_glyphs_func as cairo_user_scaled_font_text_to_glyphs_func_t)
declare sub cairo_user_font_face_set_unicode_to_glyph_func(byval font_face as cairo_font_face_t ptr, byval unicode_to_glyph_func as cairo_user_scaled_font_unicode_to_glyph_func_t)
declare function cairo_user_font_face_get_init_func(byval font_face as cairo_font_face_t ptr) as cairo_user_scaled_font_init_func_t
declare function cairo_user_font_face_get_render_glyph_func(byval font_face as cairo_font_face_t ptr) as cairo_user_scaled_font_render_glyph_func_t
declare function cairo_user_font_face_get_text_to_glyphs_func(byval font_face as cairo_font_face_t ptr) as cairo_user_scaled_font_text_to_glyphs_func_t
declare function cairo_user_font_face_get_unicode_to_glyph_func(byval font_face as cairo_font_face_t ptr) as cairo_user_scaled_font_unicode_to_glyph_func_t
declare function cairo_get_operator(byval cr as cairo_t ptr) as cairo_operator_t
declare function cairo_get_source(byval cr as cairo_t ptr) as cairo_pattern_t ptr
declare function cairo_get_tolerance(byval cr as cairo_t ptr) as double
declare function cairo_get_antialias(byval cr as cairo_t ptr) as cairo_antialias_t
declare function cairo_has_current_point(byval cr as cairo_t ptr) as cairo_bool_t
declare sub cairo_get_current_point(byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare function cairo_get_fill_rule(byval cr as cairo_t ptr) as cairo_fill_rule_t
declare function cairo_get_line_width(byval cr as cairo_t ptr) as double
declare function cairo_get_line_cap(byval cr as cairo_t ptr) as cairo_line_cap_t
declare function cairo_get_line_join(byval cr as cairo_t ptr) as cairo_line_join_t
declare function cairo_get_miter_limit(byval cr as cairo_t ptr) as double
declare function cairo_get_dash_count(byval cr as cairo_t ptr) as long
declare sub cairo_get_dash(byval cr as cairo_t ptr, byval dashes as double ptr, byval offset as double ptr)
declare sub cairo_get_matrix(byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare function cairo_get_target(byval cr as cairo_t ptr) as cairo_surface_t ptr
declare function cairo_get_group_target(byval cr as cairo_t ptr) as cairo_surface_t ptr

type _cairo_path_data_type as long
enum
	CAIRO_PATH_MOVE_TO
	CAIRO_PATH_LINE_TO
	CAIRO_PATH_CURVE_TO
	CAIRO_PATH_CLOSE_PATH
end enum

type cairo_path_data_type_t as _cairo_path_data_type
type cairo_path_data_t as _cairo_path_data_t

type _cairo_path_data_t_header
	as cairo_path_data_type_t type
	length as long
end type

type _cairo_path_data_t_point
	x as double
	y as double
end type

union _cairo_path_data_t
	header as _cairo_path_data_t_header
	point as _cairo_path_data_t_point
end union

type cairo_path
	status as cairo_status_t
	data as cairo_path_data_t ptr
	num_data as long
end type

type cairo_path_t as cairo_path
declare function cairo_copy_path(byval cr as cairo_t ptr) as cairo_path_t ptr
declare function cairo_copy_path_flat(byval cr as cairo_t ptr) as cairo_path_t ptr
declare sub cairo_append_path(byval cr as cairo_t ptr, byval path as const cairo_path_t ptr)
declare sub cairo_path_destroy(byval path as cairo_path_t ptr)
declare function cairo_status(byval cr as cairo_t ptr) as cairo_status_t
declare function cairo_status_to_string(byval status as cairo_status_t) as const zstring ptr
declare function cairo_device_reference(byval device as cairo_device_t ptr) as cairo_device_t ptr

type _cairo_device_type as long
enum
	CAIRO_DEVICE_TYPE_DRM
	CAIRO_DEVICE_TYPE_GL
	CAIRO_DEVICE_TYPE_SCRIPT
	CAIRO_DEVICE_TYPE_XCB
	CAIRO_DEVICE_TYPE_XLIB
	CAIRO_DEVICE_TYPE_XML
	CAIRO_DEVICE_TYPE_COGL
	CAIRO_DEVICE_TYPE_WIN32
	CAIRO_DEVICE_TYPE_INVALID = -1
end enum

type cairo_device_type_t as _cairo_device_type
declare function cairo_device_get_type(byval device as cairo_device_t ptr) as cairo_device_type_t
declare function cairo_device_status(byval device as cairo_device_t ptr) as cairo_status_t
declare function cairo_device_acquire(byval device as cairo_device_t ptr) as cairo_status_t
declare sub cairo_device_release(byval device as cairo_device_t ptr)
declare sub cairo_device_flush(byval device as cairo_device_t ptr)
declare sub cairo_device_finish(byval device as cairo_device_t ptr)
declare sub cairo_device_destroy(byval device as cairo_device_t ptr)
declare function cairo_device_get_reference_count(byval device as cairo_device_t ptr) as ulong
declare function cairo_device_get_user_data(byval device as cairo_device_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_device_set_user_data(byval device as cairo_device_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare function cairo_surface_create_similar(byval other as cairo_surface_t ptr, byval content as cairo_content_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_surface_create_similar_image(byval other as cairo_surface_t ptr, byval format as cairo_format_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_surface_map_to_image(byval surface as cairo_surface_t ptr, byval extents as const cairo_rectangle_int_t ptr) as cairo_surface_t ptr
declare sub cairo_surface_unmap_image(byval surface as cairo_surface_t ptr, byval image as cairo_surface_t ptr)
declare function cairo_surface_create_for_rectangle(byval target as cairo_surface_t ptr, byval x as double, byval y as double, byval width as double, byval height as double) as cairo_surface_t ptr

type cairo_surface_observer_mode_t as long
enum
	CAIRO_SURFACE_OBSERVER_NORMAL = 0
	CAIRO_SURFACE_OBSERVER_RECORD_OPERATIONS = &h1
end enum

declare function cairo_surface_create_observer(byval target as cairo_surface_t ptr, byval mode as cairo_surface_observer_mode_t) as cairo_surface_t ptr
type cairo_surface_observer_callback_t as sub(byval observer as cairo_surface_t ptr, byval target as cairo_surface_t ptr, byval data as any ptr)
declare function cairo_surface_observer_add_paint_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_mask_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_fill_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_stroke_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_glyphs_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_flush_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_add_finish_callback(byval abstract_surface as cairo_surface_t ptr, byval func as cairo_surface_observer_callback_t, byval data as any ptr) as cairo_status_t
declare function cairo_surface_observer_print(byval surface as cairo_surface_t ptr, byval write_func as cairo_write_func_t, byval closure as any ptr) as cairo_status_t
declare function cairo_surface_observer_elapsed(byval surface as cairo_surface_t ptr) as double
declare function cairo_device_observer_print(byval device as cairo_device_t ptr, byval write_func as cairo_write_func_t, byval closure as any ptr) as cairo_status_t
declare function cairo_device_observer_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_device_observer_paint_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_device_observer_mask_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_device_observer_fill_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_device_observer_stroke_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_device_observer_glyphs_elapsed(byval device as cairo_device_t ptr) as double
declare function cairo_surface_reference(byval surface as cairo_surface_t ptr) as cairo_surface_t ptr
declare sub cairo_surface_finish(byval surface as cairo_surface_t ptr)
declare sub cairo_surface_destroy(byval surface as cairo_surface_t ptr)
declare function cairo_surface_get_device(byval surface as cairo_surface_t ptr) as cairo_device_t ptr
declare function cairo_surface_get_reference_count(byval surface as cairo_surface_t ptr) as ulong
declare function cairo_surface_status(byval surface as cairo_surface_t ptr) as cairo_status_t

type _cairo_surface_type as long
enum
	CAIRO_SURFACE_TYPE_IMAGE
	CAIRO_SURFACE_TYPE_PDF
	CAIRO_SURFACE_TYPE_PS
	CAIRO_SURFACE_TYPE_XLIB
	CAIRO_SURFACE_TYPE_XCB
	CAIRO_SURFACE_TYPE_GLITZ
	CAIRO_SURFACE_TYPE_QUARTZ
	CAIRO_SURFACE_TYPE_WIN32
	CAIRO_SURFACE_TYPE_BEOS
	CAIRO_SURFACE_TYPE_DIRECTFB
	CAIRO_SURFACE_TYPE_SVG
	CAIRO_SURFACE_TYPE_OS2
	CAIRO_SURFACE_TYPE_WIN32_PRINTING
	CAIRO_SURFACE_TYPE_QUARTZ_IMAGE
	CAIRO_SURFACE_TYPE_SCRIPT
	CAIRO_SURFACE_TYPE_QT
	CAIRO_SURFACE_TYPE_RECORDING
	CAIRO_SURFACE_TYPE_VG
	CAIRO_SURFACE_TYPE_GL
	CAIRO_SURFACE_TYPE_DRM
	CAIRO_SURFACE_TYPE_TEE
	CAIRO_SURFACE_TYPE_XML
	CAIRO_SURFACE_TYPE_SKIA
	CAIRO_SURFACE_TYPE_SUBSURFACE
	CAIRO_SURFACE_TYPE_COGL
end enum

type cairo_surface_type_t as _cairo_surface_type
declare function cairo_surface_get_type(byval surface as cairo_surface_t ptr) as cairo_surface_type_t
declare function cairo_surface_get_content(byval surface as cairo_surface_t ptr) as cairo_content_t
declare function cairo_surface_write_to_png(byval surface as cairo_surface_t ptr, byval filename as const zstring ptr) as cairo_status_t
declare function cairo_surface_write_to_png_stream(byval surface as cairo_surface_t ptr, byval write_func as cairo_write_func_t, byval closure as any ptr) as cairo_status_t
declare function cairo_surface_get_user_data(byval surface as cairo_surface_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_surface_set_user_data(byval surface as cairo_surface_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t

#define CAIRO_MIME_TYPE_JPEG "image/jpeg"
#define CAIRO_MIME_TYPE_PNG "image/png"
#define CAIRO_MIME_TYPE_JP2 "image/jp2"
#define CAIRO_MIME_TYPE_URI "text/x-uri"
#define CAIRO_MIME_TYPE_UNIQUE_ID "application/x-cairo.uuid"
#define CAIRO_MIME_TYPE_JBIG2 "application/x-cairo.jbig2"
#define CAIRO_MIME_TYPE_JBIG2_GLOBAL "application/x-cairo.jbig2-global"
#define CAIRO_MIME_TYPE_JBIG2_GLOBAL_ID "application/x-cairo.jbig2-global-id"

declare sub cairo_surface_get_mime_data(byval surface as cairo_surface_t ptr, byval mime_type as const zstring ptr, byval data as const ubyte ptr ptr, byval length as culong ptr)
declare function cairo_surface_set_mime_data(byval surface as cairo_surface_t ptr, byval mime_type as const zstring ptr, byval data as const ubyte ptr, byval length as culong, byval destroy as cairo_destroy_func_t, byval closure as any ptr) as cairo_status_t
declare function cairo_surface_supports_mime_type(byval surface as cairo_surface_t ptr, byval mime_type as const zstring ptr) as cairo_bool_t
declare sub cairo_surface_get_font_options(byval surface as cairo_surface_t ptr, byval options as cairo_font_options_t ptr)
declare sub cairo_surface_flush(byval surface as cairo_surface_t ptr)
declare sub cairo_surface_mark_dirty(byval surface as cairo_surface_t ptr)
declare sub cairo_surface_mark_dirty_rectangle(byval surface as cairo_surface_t ptr, byval x as long, byval y as long, byval width as long, byval height as long)
declare sub cairo_surface_set_device_scale(byval surface as cairo_surface_t ptr, byval x_scale as double, byval y_scale as double)
declare sub cairo_surface_get_device_scale(byval surface as cairo_surface_t ptr, byval x_scale as double ptr, byval y_scale as double ptr)
declare sub cairo_surface_set_device_offset(byval surface as cairo_surface_t ptr, byval x_offset as double, byval y_offset as double)
declare sub cairo_surface_get_device_offset(byval surface as cairo_surface_t ptr, byval x_offset as double ptr, byval y_offset as double ptr)
declare sub cairo_surface_set_fallback_resolution(byval surface as cairo_surface_t ptr, byval x_pixels_per_inch as double, byval y_pixels_per_inch as double)
declare sub cairo_surface_get_fallback_resolution(byval surface as cairo_surface_t ptr, byval x_pixels_per_inch as double ptr, byval y_pixels_per_inch as double ptr)
declare sub cairo_surface_copy_page(byval surface as cairo_surface_t ptr)
declare sub cairo_surface_show_page(byval surface as cairo_surface_t ptr)
declare function cairo_surface_has_show_text_glyphs(byval surface as cairo_surface_t ptr) as cairo_bool_t
declare function cairo_image_surface_create(byval format as cairo_format_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_format_stride_for_width(byval format as cairo_format_t, byval width as long) as long
declare function cairo_image_surface_create_for_data(byval data as ubyte ptr, byval format as cairo_format_t, byval width as long, byval height as long, byval stride as long) as cairo_surface_t ptr
declare function cairo_image_surface_get_data(byval surface as cairo_surface_t ptr) as ubyte ptr
declare function cairo_image_surface_get_format(byval surface as cairo_surface_t ptr) as cairo_format_t
declare function cairo_image_surface_get_width(byval surface as cairo_surface_t ptr) as long
declare function cairo_image_surface_get_height(byval surface as cairo_surface_t ptr) as long
declare function cairo_image_surface_get_stride(byval surface as cairo_surface_t ptr) as long
declare function cairo_image_surface_create_from_png(byval filename as const zstring ptr) as cairo_surface_t ptr
declare function cairo_image_surface_create_from_png_stream(byval read_func as cairo_read_func_t, byval closure as any ptr) as cairo_surface_t ptr
declare function cairo_recording_surface_create(byval content as cairo_content_t, byval extents as const cairo_rectangle_t ptr) as cairo_surface_t ptr
declare sub cairo_recording_surface_ink_extents(byval surface as cairo_surface_t ptr, byval x0 as double ptr, byval y0 as double ptr, byval width as double ptr, byval height as double ptr)
declare function cairo_recording_surface_get_extents(byval surface as cairo_surface_t ptr, byval extents as cairo_rectangle_t ptr) as cairo_bool_t

type cairo_raster_source_acquire_func_t as function(byval pattern as cairo_pattern_t ptr, byval callback_data as any ptr, byval target as cairo_surface_t ptr, byval extents as const cairo_rectangle_int_t ptr) as cairo_surface_t ptr
type cairo_raster_source_release_func_t as sub(byval pattern as cairo_pattern_t ptr, byval callback_data as any ptr, byval surface as cairo_surface_t ptr)
type cairo_raster_source_snapshot_func_t as function(byval pattern as cairo_pattern_t ptr, byval callback_data as any ptr) as cairo_status_t
type cairo_raster_source_copy_func_t as function(byval pattern as cairo_pattern_t ptr, byval callback_data as any ptr, byval other as const cairo_pattern_t ptr) as cairo_status_t
type cairo_raster_source_finish_func_t as sub(byval pattern as cairo_pattern_t ptr, byval callback_data as any ptr)

declare function cairo_pattern_create_raster_source(byval user_data as any ptr, byval content as cairo_content_t, byval width as long, byval height as long) as cairo_pattern_t ptr
declare sub cairo_raster_source_pattern_set_callback_data(byval pattern as cairo_pattern_t ptr, byval data as any ptr)
declare function cairo_raster_source_pattern_get_callback_data(byval pattern as cairo_pattern_t ptr) as any ptr
declare sub cairo_raster_source_pattern_set_acquire(byval pattern as cairo_pattern_t ptr, byval acquire as cairo_raster_source_acquire_func_t, byval release as cairo_raster_source_release_func_t)
declare sub cairo_raster_source_pattern_get_acquire(byval pattern as cairo_pattern_t ptr, byval acquire as cairo_raster_source_acquire_func_t ptr, byval release as cairo_raster_source_release_func_t ptr)
declare sub cairo_raster_source_pattern_set_snapshot(byval pattern as cairo_pattern_t ptr, byval snapshot as cairo_raster_source_snapshot_func_t)
declare function cairo_raster_source_pattern_get_snapshot(byval pattern as cairo_pattern_t ptr) as cairo_raster_source_snapshot_func_t
declare sub cairo_raster_source_pattern_set_copy(byval pattern as cairo_pattern_t ptr, byval copy as cairo_raster_source_copy_func_t)
declare function cairo_raster_source_pattern_get_copy(byval pattern as cairo_pattern_t ptr) as cairo_raster_source_copy_func_t
declare sub cairo_raster_source_pattern_set_finish(byval pattern as cairo_pattern_t ptr, byval finish as cairo_raster_source_finish_func_t)
declare function cairo_raster_source_pattern_get_finish(byval pattern as cairo_pattern_t ptr) as cairo_raster_source_finish_func_t
declare function cairo_pattern_create_rgb(byval red as double, byval green as double, byval blue as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_rgba(byval red as double, byval green as double, byval blue as double, byval alpha as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_for_surface(byval surface as cairo_surface_t ptr) as cairo_pattern_t ptr
declare function cairo_pattern_create_linear(byval x0 as double, byval y0 as double, byval x1 as double, byval y1 as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_radial(byval cx0 as double, byval cy0 as double, byval radius0 as double, byval cx1 as double, byval cy1 as double, byval radius1 as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_mesh() as cairo_pattern_t ptr
declare function cairo_pattern_reference(byval pattern as cairo_pattern_t ptr) as cairo_pattern_t ptr
declare sub cairo_pattern_destroy(byval pattern as cairo_pattern_t ptr)
declare function cairo_pattern_get_reference_count(byval pattern as cairo_pattern_t ptr) as ulong
declare function cairo_pattern_status(byval pattern as cairo_pattern_t ptr) as cairo_status_t
declare function cairo_pattern_get_user_data(byval pattern as cairo_pattern_t ptr, byval key as const cairo_user_data_key_t ptr) as any ptr
declare function cairo_pattern_set_user_data(byval pattern as cairo_pattern_t ptr, byval key as const cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t

type _cairo_pattern_type as long
enum
	CAIRO_PATTERN_TYPE_SOLID
	CAIRO_PATTERN_TYPE_SURFACE
	CAIRO_PATTERN_TYPE_LINEAR
	CAIRO_PATTERN_TYPE_RADIAL
	CAIRO_PATTERN_TYPE_MESH
	CAIRO_PATTERN_TYPE_RASTER_SOURCE
end enum

type cairo_pattern_type_t as _cairo_pattern_type
declare function cairo_pattern_get_type(byval pattern as cairo_pattern_t ptr) as cairo_pattern_type_t
declare sub cairo_pattern_add_color_stop_rgb(byval pattern as cairo_pattern_t ptr, byval offset as double, byval red as double, byval green as double, byval blue as double)
declare sub cairo_pattern_add_color_stop_rgba(byval pattern as cairo_pattern_t ptr, byval offset as double, byval red as double, byval green as double, byval blue as double, byval alpha as double)
declare sub cairo_mesh_pattern_begin_patch(byval pattern as cairo_pattern_t ptr)
declare sub cairo_mesh_pattern_end_patch(byval pattern as cairo_pattern_t ptr)
declare sub cairo_mesh_pattern_curve_to(byval pattern as cairo_pattern_t ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double)
declare sub cairo_mesh_pattern_line_to(byval pattern as cairo_pattern_t ptr, byval x as double, byval y as double)
declare sub cairo_mesh_pattern_move_to(byval pattern as cairo_pattern_t ptr, byval x as double, byval y as double)
declare sub cairo_mesh_pattern_set_control_point(byval pattern as cairo_pattern_t ptr, byval point_num as ulong, byval x as double, byval y as double)
declare sub cairo_mesh_pattern_set_corner_color_rgb(byval pattern as cairo_pattern_t ptr, byval corner_num as ulong, byval red as double, byval green as double, byval blue as double)
declare sub cairo_mesh_pattern_set_corner_color_rgba(byval pattern as cairo_pattern_t ptr, byval corner_num as ulong, byval red as double, byval green as double, byval blue as double, byval alpha as double)
declare sub cairo_pattern_set_matrix(byval pattern as cairo_pattern_t ptr, byval matrix as const cairo_matrix_t ptr)
declare sub cairo_pattern_get_matrix(byval pattern as cairo_pattern_t ptr, byval matrix as cairo_matrix_t ptr)

type _cairo_extend as long
enum
	CAIRO_EXTEND_NONE
	CAIRO_EXTEND_REPEAT
	CAIRO_EXTEND_REFLECT
	CAIRO_EXTEND_PAD
end enum

type cairo_extend_t as _cairo_extend
declare sub cairo_pattern_set_extend(byval pattern as cairo_pattern_t ptr, byval extend as cairo_extend_t)
declare function cairo_pattern_get_extend(byval pattern as cairo_pattern_t ptr) as cairo_extend_t

type _cairo_filter as long
enum
	CAIRO_FILTER_FAST
	CAIRO_FILTER_GOOD
	CAIRO_FILTER_BEST
	CAIRO_FILTER_NEAREST
	CAIRO_FILTER_BILINEAR
	CAIRO_FILTER_GAUSSIAN
end enum

type cairo_filter_t as _cairo_filter
declare sub cairo_pattern_set_filter(byval pattern as cairo_pattern_t ptr, byval filter as cairo_filter_t)
declare function cairo_pattern_get_filter(byval pattern as cairo_pattern_t ptr) as cairo_filter_t
declare function cairo_pattern_get_rgba(byval pattern as cairo_pattern_t ptr, byval red as double ptr, byval green as double ptr, byval blue as double ptr, byval alpha as double ptr) as cairo_status_t
declare function cairo_pattern_get_surface(byval pattern as cairo_pattern_t ptr, byval surface as cairo_surface_t ptr ptr) as cairo_status_t
declare function cairo_pattern_get_color_stop_rgba(byval pattern as cairo_pattern_t ptr, byval index as long, byval offset as double ptr, byval red as double ptr, byval green as double ptr, byval blue as double ptr, byval alpha as double ptr) as cairo_status_t
declare function cairo_pattern_get_color_stop_count(byval pattern as cairo_pattern_t ptr, byval count as long ptr) as cairo_status_t
declare function cairo_pattern_get_linear_points(byval pattern as cairo_pattern_t ptr, byval x0 as double ptr, byval y0 as double ptr, byval x1 as double ptr, byval y1 as double ptr) as cairo_status_t
declare function cairo_pattern_get_radial_circles(byval pattern as cairo_pattern_t ptr, byval x0 as double ptr, byval y0 as double ptr, byval r0 as double ptr, byval x1 as double ptr, byval y1 as double ptr, byval r1 as double ptr) as cairo_status_t
declare function cairo_mesh_pattern_get_patch_count(byval pattern as cairo_pattern_t ptr, byval count as ulong ptr) as cairo_status_t
declare function cairo_mesh_pattern_get_path(byval pattern as cairo_pattern_t ptr, byval patch_num as ulong) as cairo_path_t ptr
declare function cairo_mesh_pattern_get_corner_color_rgba(byval pattern as cairo_pattern_t ptr, byval patch_num as ulong, byval corner_num as ulong, byval red as double ptr, byval green as double ptr, byval blue as double ptr, byval alpha as double ptr) as cairo_status_t
declare function cairo_mesh_pattern_get_control_point(byval pattern as cairo_pattern_t ptr, byval patch_num as ulong, byval point_num as ulong, byval x as double ptr, byval y as double ptr) as cairo_status_t
declare sub cairo_matrix_init(byval matrix as cairo_matrix_t ptr, byval xx as double, byval yx as double, byval xy as double, byval yy as double, byval x0 as double, byval y0 as double)
declare sub cairo_matrix_init_identity(byval matrix as cairo_matrix_t ptr)
declare sub cairo_matrix_init_translate(byval matrix as cairo_matrix_t ptr, byval tx as double, byval ty as double)
declare sub cairo_matrix_init_scale(byval matrix as cairo_matrix_t ptr, byval sx as double, byval sy as double)
declare sub cairo_matrix_init_rotate(byval matrix as cairo_matrix_t ptr, byval radians as double)
declare sub cairo_matrix_translate(byval matrix as cairo_matrix_t ptr, byval tx as double, byval ty as double)
declare sub cairo_matrix_scale(byval matrix as cairo_matrix_t ptr, byval sx as double, byval sy as double)
declare sub cairo_matrix_rotate(byval matrix as cairo_matrix_t ptr, byval radians as double)
declare function cairo_matrix_invert(byval matrix as cairo_matrix_t ptr) as cairo_status_t
declare sub cairo_matrix_multiply(byval result as cairo_matrix_t ptr, byval a as const cairo_matrix_t ptr, byval b as const cairo_matrix_t ptr)
declare sub cairo_matrix_transform_distance(byval matrix as const cairo_matrix_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_matrix_transform_point(byval matrix as const cairo_matrix_t ptr, byval x as double ptr, byval y as double ptr)
type cairo_region_t as _cairo_region

type _cairo_region_overlap as long
enum
	CAIRO_REGION_OVERLAP_IN
	CAIRO_REGION_OVERLAP_OUT
	CAIRO_REGION_OVERLAP_PART
end enum

type cairo_region_overlap_t as _cairo_region_overlap
declare function cairo_region_create() as cairo_region_t ptr
declare function cairo_region_create_rectangle(byval rectangle as const cairo_rectangle_int_t ptr) as cairo_region_t ptr
declare function cairo_region_create_rectangles(byval rects as const cairo_rectangle_int_t ptr, byval count as long) as cairo_region_t ptr
declare function cairo_region_copy(byval original as const cairo_region_t ptr) as cairo_region_t ptr
declare function cairo_region_reference(byval region as cairo_region_t ptr) as cairo_region_t ptr
declare sub cairo_region_destroy(byval region as cairo_region_t ptr)
declare function cairo_region_equal(byval a as const cairo_region_t ptr, byval b as const cairo_region_t ptr) as cairo_bool_t
declare function cairo_region_status(byval region as const cairo_region_t ptr) as cairo_status_t
declare sub cairo_region_get_extents(byval region as const cairo_region_t ptr, byval extents as cairo_rectangle_int_t ptr)
declare function cairo_region_num_rectangles(byval region as const cairo_region_t ptr) as long
declare sub cairo_region_get_rectangle(byval region as const cairo_region_t ptr, byval nth as long, byval rectangle as cairo_rectangle_int_t ptr)
declare function cairo_region_is_empty(byval region as const cairo_region_t ptr) as cairo_bool_t
declare function cairo_region_contains_rectangle(byval region as const cairo_region_t ptr, byval rectangle as const cairo_rectangle_int_t ptr) as cairo_region_overlap_t
declare function cairo_region_contains_point(byval region as const cairo_region_t ptr, byval x as long, byval y as long) as cairo_bool_t
declare sub cairo_region_translate(byval region as cairo_region_t ptr, byval dx as long, byval dy as long)
declare function cairo_region_subtract(byval dst as cairo_region_t ptr, byval other as const cairo_region_t ptr) as cairo_status_t
declare function cairo_region_subtract_rectangle(byval dst as cairo_region_t ptr, byval rectangle as const cairo_rectangle_int_t ptr) as cairo_status_t
declare function cairo_region_intersect(byval dst as cairo_region_t ptr, byval other as const cairo_region_t ptr) as cairo_status_t
declare function cairo_region_intersect_rectangle(byval dst as cairo_region_t ptr, byval rectangle as const cairo_rectangle_int_t ptr) as cairo_status_t
declare function cairo_region_union(byval dst as cairo_region_t ptr, byval other as const cairo_region_t ptr) as cairo_status_t
declare function cairo_region_union_rectangle(byval dst as cairo_region_t ptr, byval rectangle as const cairo_rectangle_int_t ptr) as cairo_status_t
declare function cairo_region_xor(byval dst as cairo_region_t ptr, byval other as const cairo_region_t ptr) as cairo_status_t
declare function cairo_region_xor_rectangle(byval dst as cairo_region_t ptr, byval rectangle as const cairo_rectangle_int_t ptr) as cairo_status_t
declare sub cairo_debug_reset_static_data()

end extern
