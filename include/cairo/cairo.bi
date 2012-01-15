''
''
'' cairo -- Multi-platform 2D graphics library
''			(header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cairo_bi__
#define __cairo_bi__

#inclib "cairo"

'' begin include "cairo-features.bi"
#define CAIRO_VERSION_MAJOR 1
#define CAIRO_VERSION_MINOR 2
#define CAIRO_VERSION_MICRO 6
#define CAIRO_VERSION_STRING_ "1.2.6"
'' end include

#define CAIRO_VERSION_ENCODE(major, minor, micro) (((major) * 10000) + ((minor) * 100) + ((micro) * 1))
#define CAIRO_VERSION_ CAIRO_VERSION_ENCODE(CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)

type cairo_bool_t as integer
type cairo_t as any
type cairo_surface_t as any

type cairo_matrix_t
	xx as double
	yx as double
	xy as double
	yy as double
	x0 as double
	y0 as double
end type

type cairo_pattern_t as any
type cairo_destroy_func_t as sub cdecl(byval as any ptr)

type cairo_user_data_key_t
	unused as integer
end type

enum cairo_status_t
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
end enum

enum cairo_content_t
	CAIRO_CONTENT_COLOR = &h1000
	CAIRO_CONTENT_ALPHA = &h2000
	CAIRO_CONTENT_COLOR_ALPHA = &h3000
end enum

type cairo_write_func_t as function cdecl(byval as any ptr, byval as ubyte ptr, byval as uinteger) as cairo_status_t
type cairo_read_func_t as function cdecl(byval as any ptr, byval as ubyte ptr, byval as uinteger) as cairo_status_t

enum cairo_operator_t
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
end enum

enum cairo_antialias_t
	CAIRO_ANTIALIAS_DEFAULT
	CAIRO_ANTIALIAS_NONE
	CAIRO_ANTIALIAS_GRAY
	CAIRO_ANTIALIAS_SUBPIXEL
end enum

enum cairo_fill_rule_t
	CAIRO_FILL_RULE_WINDING
	CAIRO_FILL_RULE_EVEN_ODD
end enum

enum cairo_line_cap_t
	CAIRO_LINE_CAP_BUTT
	CAIRO_LINE_CAP_ROUND
	CAIRO_LINE_CAP_SQUARE
end enum

enum cairo_line_join_t
	CAIRO_LINE_JOIN_MITER
	CAIRO_LINE_JOIN_ROUND
	CAIRO_LINE_JOIN_BEVEL
end enum

type cairo_scaled_font_t as any
type cairo_font_face_t as any

type cairo_glyph_t
	index as uinteger
	x as double
	y as double
end type

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

enum cairo_font_slant_t
	CAIRO_FONT_SLANT_NORMAL
	CAIRO_FONT_SLANT_ITALIC
	CAIRO_FONT_SLANT_OBLIQUE
end enum

enum cairo_font_weight_t
	CAIRO_FONT_WEIGHT_NORMAL
	CAIRO_FONT_WEIGHT_BOLD
end enum

enum cairo_subpixel_order_t
	CAIRO_SUBPIXEL_ORDER_DEFAULT
	CAIRO_SUBPIXEL_ORDER_RGB
	CAIRO_SUBPIXEL_ORDER_BGR
	CAIRO_SUBPIXEL_ORDER_VRGB
	CAIRO_SUBPIXEL_ORDER_VBGR
end enum

enum cairo_hint_style_t
	CAIRO_HINT_STYLE_DEFAULT
	CAIRO_HINT_STYLE_NONE
	CAIRO_HINT_STYLE_SLIGHT
	CAIRO_HINT_STYLE_MEDIUM
	CAIRO_HINT_STYLE_FULL
end enum

enum cairo_hint_metrics_t
	CAIRO_HINT_METRICS_DEFAULT
	CAIRO_HINT_METRICS_OFF
	CAIRO_HINT_METRICS_ON
end enum

type cairo_font_options_t as _cairo_font_options

enum cairo_font_type_t
	CAIRO_FONT_TYPE_TOY
	CAIRO_FONT_TYPE_FT
	CAIRO_FONT_TYPE_WIN32
	CAIRO_FONT_TYPE_ATSUI
end enum

enum cairo_path_data_type_t
	CAIRO_PATH_MOVE_TO
	CAIRO_PATH_LINE_TO
	CAIRO_PATH_CURVE_TO
	CAIRO_PATH_CLOSE_PATH
end enum

type cairo_path_data_t__point
	x as double
	y as double
end type

type cairo_path_data_t__header
	type as cairo_path_data_type_t
	length as integer
end type

union cairo_path_data_t
	header as cairo_path_data_t__header
	point as cairo_path_data_t__point
end union

type cairo_path_t
	status as cairo_status_t
	data as cairo_path_data_t ptr
	num_data as integer
end type

enum cairo_surface_type_t
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
end enum

enum cairo_format_t
	CAIRO_FORMAT_ARGB32
	CAIRO_FORMAT_RGB24
	CAIRO_FORMAT_A8
	CAIRO_FORMAT_A1
	CAIRO_FORMAT_RGB16_565
end enum

enum cairo_pattern_type_t
	CAIRO_PATTERN_TYPE_SOLID
	CAIRO_PATTERN_TYPE_SURFACE
	CAIRO_PATTERN_TYPE_LINEAR
	CAIRO_PATTERN_TYPE_RADIAL
end enum

enum cairo_extend_t
	CAIRO_EXTEND_NONE
	CAIRO_EXTEND_REPEAT
	CAIRO_EXTEND_REFLECT
	CAIRO_EXTEND_PAD
end enum

enum cairo_filter_t
	CAIRO_FILTER_FAST
	CAIRO_FILTER_GOOD
	CAIRO_FILTER_BEST
	CAIRO_FILTER_NEAREST
	CAIRO_FILTER_BILINEAR
	CAIRO_FILTER_GAUSSIAN
end enum

extern "c"

declare function cairo_version () as integer
declare function cairo_version_string () as zstring ptr
declare function cairo_create (byval target as cairo_surface_t ptr) as cairo_t ptr
declare function cairo_reference (byval cr as cairo_t ptr) as cairo_t ptr
declare sub cairo_destroy (byval cr as cairo_t ptr)
declare sub cairo_save (byval cr as cairo_t ptr)
declare sub cairo_restore (byval cr as cairo_t ptr)
declare sub cairo_push_group (byval cr as cairo_t ptr)
declare sub cairo_push_group_with_content (byval cr as cairo_t ptr, byval content as cairo_content_t)
declare function cairo_pop_group (byval cr as cairo_t ptr) as cairo_pattern_t ptr
declare sub cairo_pop_group_to_source (byval cr as cairo_t ptr)
declare sub cairo_set_operator (byval cr as cairo_t ptr, byval op as cairo_operator_t)
declare sub cairo_set_source (byval cr as cairo_t ptr, byval source as cairo_pattern_t ptr)
declare sub cairo_set_source_rgb (byval cr as cairo_t ptr, byval red as double, byval green as double, byval blue as double)
declare sub cairo_set_source_rgba (byval cr as cairo_t ptr, byval red as double, byval green as double, byval blue as double, byval alpha as double)
declare sub cairo_set_source_surface (byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval x as double, byval y as double)
declare sub cairo_set_tolerance (byval cr as cairo_t ptr, byval tolerance as double)
declare sub cairo_set_antialias (byval cr as cairo_t ptr, byval antialias as cairo_antialias_t)
declare sub cairo_set_fill_rule (byval cr as cairo_t ptr, byval fill_rule as cairo_fill_rule_t)
declare sub cairo_set_line_width (byval cr as cairo_t ptr, byval width as double)
declare sub cairo_set_line_cap (byval cr as cairo_t ptr, byval line_cap as cairo_line_cap_t)
declare sub cairo_set_line_join (byval cr as cairo_t ptr, byval line_join as cairo_line_join_t)
declare sub cairo_set_dash (byval cr as cairo_t ptr, byval dashes as double ptr, byval num_dashes as integer, byval offset as double)
declare sub cairo_set_miter_limit (byval cr as cairo_t ptr, byval limit as double)
declare sub cairo_translate (byval cr as cairo_t ptr, byval tx as double, byval ty as double)
declare sub cairo_scale (byval cr as cairo_t ptr, byval sx as double, byval sy as double)
declare sub cairo_rotate (byval cr as cairo_t ptr, byval angle as double)
declare sub cairo_transform (byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_set_matrix (byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_identity_matrix (byval cr as cairo_t ptr)
declare sub cairo_user_to_device (byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare sub cairo_user_to_device_distance (byval cr as cairo_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_device_to_user (byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare sub cairo_device_to_user_distance (byval cr as cairo_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_new_path (byval cr as cairo_t ptr)
declare sub cairo_move_to (byval cr as cairo_t ptr, byval x as double, byval y as double)
declare sub cairo_new_sub_path (byval cr as cairo_t ptr)
declare sub cairo_line_to (byval cr as cairo_t ptr, byval x as double, byval y as double)
declare sub cairo_curve_to (byval cr as cairo_t ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double)
declare sub cairo_arc (byval cr as cairo_t ptr, byval xc as double, byval yc as double, byval radius as double, byval angle1 as double, byval angle2 as double)
declare sub cairo_arc_negative (byval cr as cairo_t ptr, byval xc as double, byval yc as double, byval radius as double, byval angle1 as double, byval angle2 as double)
declare sub cairo_rel_move_to (byval cr as cairo_t ptr, byval dx as double, byval dy as double)
declare sub cairo_rel_line_to (byval cr as cairo_t ptr, byval dx as double, byval dy as double)
declare sub cairo_rel_curve_to (byval cr as cairo_t ptr, byval dx1 as double, byval dy1 as double, byval dx2 as double, byval dy2 as double, byval dx3 as double, byval dy3 as double)
declare sub cairo_rectangle (byval cr as cairo_t ptr, byval x as double, byval y as double, byval width as double, byval height as double)
declare sub cairo_close_path (byval cr as cairo_t ptr)
declare sub cairo_paint (byval cr as cairo_t ptr)
declare sub cairo_paint_with_alpha (byval cr as cairo_t ptr, byval alpha as double)
declare sub cairo_mask (byval cr as cairo_t ptr, byval pattern as cairo_pattern_t ptr)
declare sub cairo_mask_surface (byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval surface_x as double, byval surface_y as double)
declare sub cairo_stroke (byval cr as cairo_t ptr)
declare sub cairo_stroke_preserve (byval cr as cairo_t ptr)
declare sub cairo_fill (byval cr as cairo_t ptr)
declare sub cairo_fill_preserve (byval cr as cairo_t ptr)
declare sub cairo_copy_page (byval cr as cairo_t ptr)
declare sub cairo_show_page (byval cr as cairo_t ptr)
declare function cairo_in_stroke (byval cr as cairo_t ptr, byval x as double, byval y as double) as cairo_bool_t
declare function cairo_in_fill (byval cr as cairo_t ptr, byval x as double, byval y as double) as cairo_bool_t
declare sub cairo_stroke_extents (byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cairo_fill_extents (byval cr as cairo_t ptr, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cairo_reset_clip (byval cr as cairo_t ptr)
declare sub cairo_clip (byval cr as cairo_t ptr)
declare sub cairo_clip_preserve (byval cr as cairo_t ptr)
declare function cairo_font_options_create () as cairo_font_options_t ptr
declare function cairo_font_options_copy (byval original as cairo_font_options_t ptr) as cairo_font_options_t ptr
declare sub cairo_font_options_destroy (byval options as cairo_font_options_t ptr)
declare function cairo_font_options_status (byval options as cairo_font_options_t ptr) as cairo_status_t
declare sub cairo_font_options_merge (byval options as cairo_font_options_t ptr, byval other as cairo_font_options_t ptr)
declare function cairo_font_options_equal (byval options as cairo_font_options_t ptr, byval other as cairo_font_options_t ptr) as cairo_bool_t
declare function cairo_font_options_hash (byval options as cairo_font_options_t ptr) as uinteger
declare sub cairo_font_options_set_antialias (byval options as cairo_font_options_t ptr, byval antialias as cairo_antialias_t)
declare function cairo_font_options_get_antialias (byval options as cairo_font_options_t ptr) as cairo_antialias_t
declare sub cairo_font_options_set_subpixel_order (byval options as cairo_font_options_t ptr, byval subpixel_order as cairo_subpixel_order_t)
declare function cairo_font_options_get_subpixel_order (byval options as cairo_font_options_t ptr) as cairo_subpixel_order_t
declare sub cairo_font_options_set_hint_style (byval options as cairo_font_options_t ptr, byval hint_style as cairo_hint_style_t)
declare function cairo_font_options_get_hint_style (byval options as cairo_font_options_t ptr) as cairo_hint_style_t
declare sub cairo_font_options_set_hint_metrics (byval options as cairo_font_options_t ptr, byval hint_metrics as cairo_hint_metrics_t)
declare function cairo_font_options_get_hint_metrics (byval options as cairo_font_options_t ptr) as cairo_hint_metrics_t
declare sub cairo_select_font_face (byval cr as cairo_t ptr, byval family as zstring ptr, byval slant as cairo_font_slant_t, byval weight as cairo_font_weight_t)
declare sub cairo_set_font_size (byval cr as cairo_t ptr, byval size as double)
declare sub cairo_set_font_matrix (byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_get_font_matrix (byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_set_font_options (byval cr as cairo_t ptr, byval options as cairo_font_options_t ptr)
declare sub cairo_get_font_options (byval cr as cairo_t ptr, byval options as cairo_font_options_t ptr)
declare sub cairo_set_scaled_font (byval cr as cairo_t ptr, byval scaled_font as cairo_scaled_font_t ptr)
declare sub cairo_show_text (byval cr as cairo_t ptr, byval utf8 as zstring ptr)
declare sub cairo_show_glyphs (byval cr as cairo_t ptr, byval glyphs as cairo_glyph_t ptr, byval num_glyphs as integer)
declare function cairo_get_font_face (byval cr as cairo_t ptr) as cairo_font_face_t ptr
declare sub cairo_font_extents (byval cr as cairo_t ptr, byval extents as cairo_font_extents_t ptr)
declare sub cairo_set_font_face (byval cr as cairo_t ptr, byval font_face as cairo_font_face_t ptr)
declare sub cairo_text_extents (byval cr as cairo_t ptr, byval utf8 as zstring ptr, byval extents as cairo_text_extents_t ptr)
declare sub cairo_glyph_extents (byval cr as cairo_t ptr, byval glyphs as cairo_glyph_t ptr, byval num_glyphs as integer, byval extents as cairo_text_extents_t ptr)
declare sub cairo_text_path (byval cr as cairo_t ptr, byval utf8 as zstring ptr)
declare sub cairo_glyph_path (byval cr as cairo_t ptr, byval glyphs as cairo_glyph_t ptr, byval num_glyphs as integer)
declare function cairo_font_face_reference (byval font_face as cairo_font_face_t ptr) as cairo_font_face_t ptr
declare sub cairo_font_face_destroy (byval font_face as cairo_font_face_t ptr)
declare function cairo_font_face_status (byval font_face as cairo_font_face_t ptr) as cairo_status_t
declare function cairo_font_face_get_type (byval font_face as cairo_font_face_t ptr) as cairo_font_type_t
declare function cairo_font_face_get_user_data (byval font_face as cairo_font_face_t ptr, byval key as cairo_user_data_key_t ptr) as any ptr
declare function cairo_font_face_set_user_data (byval font_face as cairo_font_face_t ptr, byval key as cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare function cairo_scaled_font_create (byval font_face as cairo_font_face_t ptr, byval font_matrix as cairo_matrix_t ptr, byval ctm as cairo_matrix_t ptr, byval options as cairo_font_options_t ptr) as cairo_scaled_font_t ptr
declare function cairo_scaled_font_reference (byval scaled_font as cairo_scaled_font_t ptr) as cairo_scaled_font_t ptr
declare sub cairo_scaled_font_destroy (byval scaled_font as cairo_scaled_font_t ptr)
declare function cairo_scaled_font_status (byval scaled_font as cairo_scaled_font_t ptr) as cairo_status_t
declare function cairo_scaled_font_get_type (byval scaled_font as cairo_scaled_font_t ptr) as cairo_font_type_t
declare sub cairo_scaled_font_extents (byval scaled_font as cairo_scaled_font_t ptr, byval extents as cairo_font_extents_t ptr)
declare sub cairo_scaled_font_text_extents (byval scaled_font as cairo_scaled_font_t ptr, byval utf8 as zstring ptr, byval extents as cairo_text_extents_t ptr)
declare sub cairo_scaled_font_glyph_extents (byval scaled_font as cairo_scaled_font_t ptr, byval glyphs as cairo_glyph_t ptr, byval num_glyphs as integer, byval extents as cairo_text_extents_t ptr)
declare function cairo_scaled_font_get_font_face (byval scaled_font as cairo_scaled_font_t ptr) as cairo_font_face_t ptr
declare sub cairo_scaled_font_get_font_matrix (byval scaled_font as cairo_scaled_font_t ptr, byval font_matrix as cairo_matrix_t ptr)
declare sub cairo_scaled_font_get_ctm (byval scaled_font as cairo_scaled_font_t ptr, byval ctm as cairo_matrix_t ptr)
declare sub cairo_scaled_font_get_font_options (byval scaled_font as cairo_scaled_font_t ptr, byval options as cairo_font_options_t ptr)
declare function cairo_get_operator (byval cr as cairo_t ptr) as cairo_operator_t
declare function cairo_get_source (byval cr as cairo_t ptr) as cairo_pattern_t ptr
declare function cairo_get_tolerance (byval cr as cairo_t ptr) as double
declare function cairo_get_antialias (byval cr as cairo_t ptr) as cairo_antialias_t
declare sub cairo_get_current_point (byval cr as cairo_t ptr, byval x as double ptr, byval y as double ptr)
declare function cairo_get_fill_rule (byval cr as cairo_t ptr) as cairo_fill_rule_t
declare function cairo_get_line_width (byval cr as cairo_t ptr) as double
declare function cairo_get_line_cap (byval cr as cairo_t ptr) as cairo_line_cap_t
declare function cairo_get_line_join (byval cr as cairo_t ptr) as cairo_line_join_t
declare function cairo_get_miter_limit (byval cr as cairo_t ptr) as double
declare sub cairo_get_matrix (byval cr as cairo_t ptr, byval matrix as cairo_matrix_t ptr)
declare function cairo_get_target (byval cr as cairo_t ptr) as cairo_surface_t ptr
declare function cairo_get_group_target (byval cr as cairo_t ptr) as cairo_surface_t ptr
declare function cairo_copy_path (byval cr as cairo_t ptr) as cairo_path_t ptr
declare function cairo_copy_path_flat (byval cr as cairo_t ptr) as cairo_path_t ptr
declare sub cairo_append_path (byval cr as cairo_t ptr, byval path as cairo_path_t ptr)
declare sub cairo_path_destroy (byval path as cairo_path_t ptr)
declare function cairo_status (byval cr as cairo_t ptr) as cairo_status_t
declare function cairo_status_to_string (byval status as cairo_status_t) as zstring ptr
declare function cairo_surface_create_similar (byval other as cairo_surface_t ptr, byval content as cairo_content_t, byval width as integer, byval height as integer) as cairo_surface_t ptr
declare function cairo_surface_reference (byval surface as cairo_surface_t ptr) as cairo_surface_t ptr
declare sub cairo_surface_finish (byval surface as cairo_surface_t ptr)
declare sub cairo_surface_destroy (byval surface as cairo_surface_t ptr)
declare function cairo_surface_status (byval surface as cairo_surface_t ptr) as cairo_status_t
declare function cairo_surface_get_type (byval surface as cairo_surface_t ptr) as cairo_surface_type_t
declare function cairo_surface_get_content (byval surface as cairo_surface_t ptr) as cairo_content_t
declare function cairo_surface_get_user_data (byval surface as cairo_surface_t ptr, byval key as cairo_user_data_key_t ptr) as any ptr
declare function cairo_surface_set_user_data (byval surface as cairo_surface_t ptr, byval key as cairo_user_data_key_t ptr, byval user_data as any ptr, byval destroy as cairo_destroy_func_t) as cairo_status_t
declare sub cairo_surface_get_font_options (byval surface as cairo_surface_t ptr, byval options as cairo_font_options_t ptr)
declare sub cairo_surface_flush (byval surface as cairo_surface_t ptr)
declare sub cairo_surface_mark_dirty (byval surface as cairo_surface_t ptr)
declare sub cairo_surface_mark_dirty_rectangle (byval surface as cairo_surface_t ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub cairo_surface_set_device_offset (byval surface as cairo_surface_t ptr, byval x_offset as double, byval y_offset as double)
declare sub cairo_surface_get_device_offset (byval surface as cairo_surface_t ptr, byval x_offset as double ptr, byval y_offset as double ptr)
declare sub cairo_surface_set_fallback_resolution (byval surface as cairo_surface_t ptr, byval x_pixels_per_inch as double, byval y_pixels_per_inch as double)
declare function cairo_image_surface_create (byval format as cairo_format_t, byval width as integer, byval height as integer) as cairo_surface_t ptr
declare function cairo_image_surface_create_for_data (byval data as ubyte ptr, byval format as cairo_format_t, byval width as integer, byval height as integer, byval stride as integer) as cairo_surface_t ptr
declare function cairo_image_surface_get_data (byval surface as cairo_surface_t ptr) as ubyte ptr
declare function cairo_image_surface_get_format (byval surface as cairo_surface_t ptr) as cairo_format_t
declare function cairo_image_surface_get_width (byval surface as cairo_surface_t ptr) as integer
declare function cairo_image_surface_get_height (byval surface as cairo_surface_t ptr) as integer
declare function cairo_image_surface_get_stride (byval surface as cairo_surface_t ptr) as integer
declare function cairo_pattern_create_rgb (byval red as double, byval green as double, byval blue as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_rgba (byval red as double, byval green as double, byval blue as double, byval alpha as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_for_surface (byval surface as cairo_surface_t ptr) as cairo_pattern_t ptr
declare function cairo_pattern_create_linear (byval x0 as double, byval y0 as double, byval x1 as double, byval y1 as double) as cairo_pattern_t ptr
declare function cairo_pattern_create_radial (byval cx0 as double, byval cy0 as double, byval radius0 as double, byval cx1 as double, byval cy1 as double, byval radius1 as double) as cairo_pattern_t ptr
declare function cairo_pattern_reference (byval pattern as cairo_pattern_t ptr) as cairo_pattern_t ptr
declare sub cairo_pattern_destroy (byval pattern as cairo_pattern_t ptr)
declare function cairo_pattern_status (byval pattern as cairo_pattern_t ptr) as cairo_status_t
declare function cairo_pattern_get_type (byval pattern as cairo_pattern_t ptr) as cairo_pattern_type_t
declare sub cairo_pattern_add_color_stop_rgb (byval pattern as cairo_pattern_t ptr, byval offset as double, byval red as double, byval green as double, byval blue as double)
declare sub cairo_pattern_add_color_stop_rgba (byval pattern as cairo_pattern_t ptr, byval offset as double, byval red as double, byval green as double, byval blue as double, byval alpha as double)
declare sub cairo_pattern_set_matrix (byval pattern as cairo_pattern_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_pattern_get_matrix (byval pattern as cairo_pattern_t ptr, byval matrix as cairo_matrix_t ptr)
declare sub cairo_pattern_set_extend (byval pattern as cairo_pattern_t ptr, byval extend as cairo_extend_t)
declare function cairo_pattern_get_extend (byval pattern as cairo_pattern_t ptr) as cairo_extend_t
declare sub cairo_pattern_set_filter (byval pattern as cairo_pattern_t ptr, byval filter as cairo_filter_t)
declare function cairo_pattern_get_filter (byval pattern as cairo_pattern_t ptr) as cairo_filter_t
declare sub cairo_matrix_init (byval matrix as cairo_matrix_t ptr, byval xx as double, byval yx as double, byval xy as double, byval yy as double, byval x0 as double, byval y0 as double)
declare sub cairo_matrix_init_identity (byval matrix as cairo_matrix_t ptr)
declare sub cairo_matrix_init_translate (byval matrix as cairo_matrix_t ptr, byval tx as double, byval ty as double)
declare sub cairo_matrix_init_scale (byval matrix as cairo_matrix_t ptr, byval sx as double, byval sy as double)
declare sub cairo_matrix_init_rotate (byval matrix as cairo_matrix_t ptr, byval radians as double)
declare sub cairo_matrix_translate (byval matrix as cairo_matrix_t ptr, byval tx as double, byval ty as double)
declare sub cairo_matrix_scale (byval matrix as cairo_matrix_t ptr, byval sx as double, byval sy as double)
declare sub cairo_matrix_rotate (byval matrix as cairo_matrix_t ptr, byval radians as double)
declare function cairo_matrix_invert (byval matrix as cairo_matrix_t ptr) as cairo_status_t
declare sub cairo_matrix_multiply (byval result as cairo_matrix_t ptr, byval a as cairo_matrix_t ptr, byval b as cairo_matrix_t ptr)
declare sub cairo_matrix_transform_distance (byval matrix as cairo_matrix_t ptr, byval dx as double ptr, byval dy as double ptr)
declare sub cairo_matrix_transform_point (byval matrix as cairo_matrix_t ptr, byval x as double ptr, byval y as double ptr)
declare sub cairo_debug_reset_static_data ()

end extern

#endif
