' This is file cairo.bi
' (FreeBasic binding for cairo library version 1.10.2)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
' Original license text:

/' cairo - a vector graphics library with display and print output
 *
 * Copyright © 2002 University of Southern California
 * Copyright © 2005 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it either under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * (the "LGPL") or, at your option, under the terms of the Mozilla
 * Public License Version 1.1 (the "MPL"). If you do not alter this
 * notice, a recipient may use your version of this file under either
 * the MPL or the LGPL.
 *
 * You should have received a copy of the LGPL along with this library
 * in the file COPYING-LGPL-2.1; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
 * You should have received a copy of the MPL along with this library
 * in the file COPYING-MPL-1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
 * OF ANY KIND, either express or implied. See the LGPL or the MPL for
 * the specific language governing rights and limitations.
 *
 * The Original Code is the cairo graphics library.
 *
 * The Initial Developer of the Original Code is University of Southern
 * California.
 *
 * Contributor(s):
 * Carl D. Worth <cworth@cworth.org>
 '/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "cairo"

EXTERN "C"

#IFNDEF CAIRO_H
#DEFINE CAIRO_H

#IFNDEF CAIRO_VERSION_H
#DEFINE CAIRO_VERSION_H
#DEFINE CAIRO_VERSION_MAJOR (1)
#DEFINE CAIRO_VERSION_MINOR (10)
#DEFINE CAIRO_VERSION_MICRO (2)
#ENDIF ' CAIRO_VERSION_H

#IFNDEF CAIRO_FEATURES_H
#DEFINE CAIRO_FEATURES_H
#DEFINE CAIRO_HAS_FT_FONT 1
#DEFINE CAIRO_HAS_IMAGE_SURFACE 1
#DEFINE CAIRO_HAS_PDF_SURFACE 1
#DEFINE CAIRO_HAS_PNG_FUNCTIONS 1
#DEFINE CAIRO_HAS_PS_SURFACE 1
#DEFINE CAIRO_HAS_SVG_SURFACE 1
#DEFINE CAIRO_HAS_USER_FONT 1
#DEFINE CAIRO_HAS_XLIB_SURFACE 1
#DEFINE CAIRO_HAS_XLIB_XRENDER_SURFACE 1
#ENDIF ' CAIRO_FEATURES_H

#IFNDEF CAIRO_DEPRECATED_H
#DEFINE CAIRO_DEPRECATED_H
#DEFINE CAIRO_FONT_TYPE_ATSUI CAIRO_FONT_TYPE_QUARTZ
#DEFINE cairo_current_font_extents cairo_current_font_extents_REPLACED_BY_cairo_font_extents
#DEFINE cairo_get_font_extents cairo_get_font_extents_REPLACED_BY_cairo_font_extents
#DEFINE cairo_current_operator cairo_current_operator_REPLACED_BY_cairo_get_operator
#DEFINE cairo_current_tolerance cairo_current_tolerance_REPLACED_BY_cairo_get_tolerance
#DEFINE cairo_current_point cairo_current_point_REPLACED_BY_cairo_get_current_point
#DEFINE cairo_current_fill_rule cairo_current_fill_rule_REPLACED_BY_cairo_get_fill_rule
#DEFINE cairo_current_line_width cairo_current_line_width_REPLACED_BY_cairo_get_line_width
#DEFINE cairo_current_line_cap cairo_current_line_cap_REPLACED_BY_cairo_get_line_cap
#DEFINE cairo_current_line_join cairo_current_line_join_REPLACED_BY_cairo_get_line_join
#DEFINE cairo_current_miter_limit cairo_current_miter_limit_REPLACED_BY_cairo_get_miter_limit
#DEFINE cairo_current_matrix cairo_current_matrix_REPLACED_BY_cairo_get_matrix
#DEFINE cairo_current_target_surface cairo_current_target_surface_REPLACED_BY_cairo_get_target
#DEFINE cairo_get_status cairo_get_status_REPLACED_BY_cairo_status
#DEFINE cairo_concat_matrix cairo_concat_matrix_REPLACED_BY_cairo_transform
#DEFINE cairo_scale_font cairo_scale_font_REPLACED_BY_cairo_set_font_size
#DEFINE cairo_select_font cairo_select_font_REPLACED_BY_cairo_select_font_face
#DEFINE cairo_transform_font cairo_transform_font_REPLACED_BY_cairo_set_font_matrix
#DEFINE cairo_transform_point cairo_transform_point_REPLACED_BY_cairo_user_to_device
#DEFINE cairo_transform_distance ERROR cairo_transform_distance REPLACED_BY cairo_user_to_device_distance
#DEFINE cairo_inverse_transform_point cairo_inverse_transform_point_REPLACED_BY_cairo_device_to_user
#DEFINE cairo_inverse_transform_distance ERROR cairo_inverse_transform_distance REPLACED_BY cairo_device_to_user_distance
#DEFINE cairo_init_clip cairo_init_clip_REPLACED_BY_cairo_reset_clip
#DEFINE cairo_surface_create_for_image ERROR cairo_surface_create_for_image REPLACED_BY cairo_image_surface_create_for_data
#DEFINE cairo_default_matrix cairo_default_matrix_REPLACED_BY_cairo_identity_matrix
#DEFINE cairo_matrix_set_affine cairo_matrix_set_affine_REPLACED_BY_cairo_matrix_init
#DEFINE cairo_matrix_set_identity cairo_matrix_set_identity_REPLACED_BY_cairo_matrix_init_identity
#DEFINE cairo_pattern_add_color_stop ERROR cairo_pattern_add_color_stop REPLACED_BY cairo_pattern_add_color_stop_rgba
#DEFINE cairo_set_rgb_color cairo_set_rgb_color_REPLACED_BY_cairo_set_source_rgb
#DEFINE cairo_set_pattern cairo_set_pattern_REPLACED_BY_cairo_set_source
#DEFINE cairo_xlib_surface_create_for_pixmap_with_visual ERROR cairo_xlib_surface_create_for_pixmap_with_visual REPLACED_BY cairo_xlib_surface_create
#DEFINE cairo_xlib_surface_create_for_window_with_visual ERROR cairo_xlib_surface_create_for_window_with_visual REPLACED_BY cairo_xlib_surface_create
#DEFINE cairo_xcb_surface_create_for_pixmap_with_visual ERROR cairo_xcb_surface_create_for_pixmap_with_visual REPLACED_BY cairo_xcb_surface_create
#DEFINE cairo_xcb_surface_create_for_window_with_visual ERROR cairo_xcb_surface_create_for_window_with_visual REPLACED_BY cairo_xcb_surface_create
#DEFINE cairo_ps_surface_set_dpi ERROR cairo_ps_surface_set_dpi REPLACED_BY cairo_surface_set_fallback_resolution
#DEFINE cairo_pdf_surface_set_dpi ERROR cairo_pdf_surface_set_dpi REPLACED_BY cairo_surface_set_fallback_resolution
#DEFINE cairo_svg_surface_set_dpi ERROR cairo_svg_surface_set_dpi REPLACED_BY cairo_surface_set_fallback_resolution
#DEFINE cairo_atsui_font_face_create_for_atsu_font_id ERROR cairo_atsui_font_face_create_for_atsu_font_id REPLACED_BY cairo_quartz_font_face_create_for_atsu_font_id
#DEFINE cairo_current_path cairo_current_path_DEPRECATED_BY_cairo_copy_path
#DEFINE cairo_current_path_flat cairo_current_path_flat_DEPRECATED_BY_cairo_copy_path_flat
#DEFINE cairo_get_path cairo_get_path_DEPRECATED_BY_cairo_copy_path
#DEFINE cairo_get_path_flat cairo_get_path_flat_DEPRECATED_BY_cairo_get_path_flat
#DEFINE cairo_set_alpha ERROR cairo_set_alpha DEPRECATED_BY cairo_set_source_rgba_OR_cairo_paint_with_alpha
#DEFINE cairo_show_surface ERROR cairo_show_surface DEPRECATED_BY cairo_set_source_surface_AND_cairo_paint
#DEFINE cairo_copy ERROR cairo_copy DEPRECATED_BY cairo_create_AND_MANY_INDIVIDUAL_FUNCTIONS
#DEFINE cairo_surface_set_repeat cairo_surface_set_repeat_DEPRECATED_BY_cairo_pattern_set_extend
#DEFINE cairo_surface_set_matrix cairo_surface_set_matrix_DEPRECATED_BY_cairo_pattern_set_matrix
#DEFINE cairo_surface_get_matrix cairo_surface_get_matrix_DEPRECATED_BY_cairo_pattern_get_matrix
#DEFINE cairo_surface_set_filter cairo_surface_set_filter_DEPRECATED_BY_cairo_pattern_set_filter
#DEFINE cairo_surface_get_filter cairo_surface_get_filter_DEPRECATED_BY_cairo_pattern_get_filter
#DEFINE cairo_matrix_create cairo_matrix_create_DEPRECATED_BY_cairo_matrix_t
#DEFINE cairo_matrix_destroy cairo_matrix_destroy_DEPRECATED_BY_cairo_matrix_t
#DEFINE cairo_matrix_copy cairo_matrix_copy_DEPRECATED_BY_cairo_matrix_t
#DEFINE cairo_matrix_get_affine cairo_matrix_get_affine_DEPRECATED_BY_cairo_matrix_t
#DEFINE cairo_set_target_surface cairo_set_target_surface_DEPRECATED_BY_cairo_create
#DEFINE cairo_set_target_image ERROR cairo_set_target_image DEPRECATED_BY cairo_image_surface_create_for_data
#DEFINE cairo_set_target_pdf cairo_set_target_pdf_DEPRECATED_BY_cairo_pdf_surface_create
#DEFINE cairo_set_target_png cairo_set_target_png_DEPRECATED_BY_cairo_surface_write_to_png
#DEFINE cairo_set_target_ps cairo_set_target_ps_DEPRECATED_BY_cairo_ps_surface_create
#DEFINE cairo_set_target_quartz ERROR cairo_set_target_quartz DEPRECATED_BY cairo_quartz_surface_create
#DEFINE cairo_set_target_win32 cairo_set_target_win32_DEPRECATED_BY_cairo_win32_surface_create
#DEFINE cairo_set_target_xcb cairo_set_target_xcb_DEPRECATED_BY_cairo_xcb_surface_create
#DEFINE cairo_set_target_drawable ERROR cairo_set_target_drawable DEPRECATED_BY cairo_xlib_surface_create
#DEFINE cairo_get_status_string ERROR cairo_get_status_string DEPRECATED_BY cairo_status_AND_cairo_status_to_string
#DEFINE cairo_status_string ERROR cairo_status_string DEPRECATED_BY cairo_status AND cairo_status_to_string
#ENDIF ' CAIRO_DEPRECATED_H

#DEFINE CAIRO_VERSION_ENCODE(major, minor, micro) ((major) * 10000 + (minor) * 100 + (micro))
#DEFINE CAIRO_VERSION CAIRO_VERSION_ENCODE(CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)
#DEFINE CAIRO_VERSION_STRINGIZE_(major, minor, micro) #major & "." & #minor & "." & #micro
#DEFINE CAIRO_VERSION_STRINGIZE(major, minor, micro) CAIRO_VERSION_STRINGIZE_(major, minor, micro)
#DEFINE CAIRO_VERSION_STRING CAIRO_VERSION_STRINGIZE(CAIRO_VERSION_MAJOR, CAIRO_VERSION_MINOR, CAIRO_VERSION_MICRO)

DECLARE FUNCTION cairo_version_FB ALIAS "cairo_version"() AS INTEGER
DECLARE FUNCTION cairo_version_string_FB ALIAS "cairo_version_string"() AS CONST ZSTRING PTR

TYPE cairo_bool_t AS INTEGER
TYPE cairo_t AS _cairo
TYPE cairo_surface_t AS _cairo_surface
TYPE cairo_device_t AS _cairo_device

TYPE _cairo_matrix
  AS DOUBLE xx
  AS DOUBLE yx
  AS DOUBLE xy
  AS DOUBLE yy
  AS DOUBLE x0
  AS DOUBLE y0
END TYPE

TYPE AS _cairo_matrix cairo_matrix_t

TYPE cairo_pattern_t AS _cairo_pattern
TYPE cairo_destroy_func_t AS SUB(BYVAL AS ANY PTR)

TYPE _cairo_user_data_key
  AS INTEGER unused
END TYPE

TYPE AS _cairo_user_data_key cairo_user_data_key_t

ENUM _cairo_status
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
  CAIRO_STATUS_LAST_STATUS
END ENUM

TYPE AS _cairo_status cairo_status_t

ENUM _cairo_content
  CAIRO_CONTENT_COLOR = &h1000
  CAIRO_CONTENT_ALPHA = &h2000
  CAIRO_CONTENT_COLOR_ALPHA = &h3000
END ENUM

TYPE AS _cairo_content cairo_content_t

TYPE cairo_write_func_t AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS CONST UBYTE PTR, BYVAL AS UINTEGER) AS cairo_status_t
TYPE cairo_read_func_t AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS UBYTE PTR, BYVAL AS UINTEGER) AS cairo_status_t

DECLARE FUNCTION cairo_create(BYVAL AS cairo_surface_t PTR) AS cairo_t PTR
DECLARE FUNCTION cairo_reference(BYVAL AS cairo_t PTR) AS cairo_t PTR
DECLARE SUB cairo_destroy(BYVAL AS cairo_t PTR)
DECLARE FUNCTION cairo_get_reference_count(BYVAL AS cairo_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_get_user_data(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_set_user_data(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t
DECLARE SUB cairo_save(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_restore(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_push_group(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_push_group_with_content(BYVAL AS cairo_t PTR, BYVAL AS cairo_content_t)
DECLARE FUNCTION cairo_pop_group(BYVAL AS cairo_t PTR) AS cairo_pattern_t PTR
DECLARE SUB cairo_pop_group_to_source(BYVAL AS cairo_t PTR)

ENUM _cairo_operator
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
END ENUM

TYPE AS _cairo_operator cairo_operator_t

DECLARE SUB cairo_set_operator(BYVAL AS cairo_t PTR, BYVAL AS cairo_operator_t)
DECLARE SUB cairo_set_source(BYVAL AS cairo_t PTR, BYVAL AS cairo_pattern_t PTR)
DECLARE SUB cairo_set_source_rgb(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_set_source_rgba(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_set_source_surface(BYVAL AS cairo_t PTR, BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_set_tolerance(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)

ENUM _cairo_antialias
  CAIRO_ANTIALIAS_DEFAULT
  CAIRO_ANTIALIAS_NONE
  CAIRO_ANTIALIAS_GRAY
  CAIRO_ANTIALIAS_SUBPIXEL
END ENUM

TYPE AS _cairo_antialias cairo_antialias_t

DECLARE SUB cairo_set_antialias(BYVAL AS cairo_t PTR, BYVAL AS cairo_antialias_t)

ENUM _cairo_fill_rule
  CAIRO_FILL_RULE_WINDING
  CAIRO_FILL_RULE_EVEN_ODD
END ENUM

TYPE AS _cairo_fill_rule cairo_fill_rule_t

DECLARE SUB cairo_set_fill_rule(BYVAL AS cairo_t PTR, BYVAL AS cairo_fill_rule_t)
DECLARE SUB cairo_set_line_width(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)

ENUM _cairo_line_cap
  CAIRO_LINE_CAP_BUTT
  CAIRO_LINE_CAP_ROUND
  CAIRO_LINE_CAP_SQUARE
END ENUM

TYPE AS _cairo_line_cap cairo_line_cap_t

DECLARE SUB cairo_set_line_cap(BYVAL AS cairo_t PTR, BYVAL AS cairo_line_cap_t)

ENUM _cairo_line_join
  CAIRO_LINE_JOIN_MITER
  CAIRO_LINE_JOIN_ROUND
  CAIRO_LINE_JOIN_BEVEL
END ENUM

TYPE AS _cairo_line_join cairo_line_join_t

DECLARE SUB cairo_set_line_join(BYVAL AS cairo_t PTR, BYVAL AS cairo_line_join_t)
DECLARE SUB cairo_set_dash(BYVAL AS cairo_t PTR, BYVAL AS CONST DOUBLE PTR, BYVAL AS INTEGER, BYVAL AS DOUBLE)
DECLARE SUB cairo_set_miter_limit(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)
DECLARE SUB cairo_translate(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_scale(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_rotate(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)
DECLARE SUB cairo_transform(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE SUB cairo_set_matrix(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE SUB cairo_identity_matrix(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_user_to_device(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_user_to_device_distance(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_device_to_user(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_device_to_user_distance(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_new_path(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_move_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_new_sub_path(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_line_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_curve_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_arc(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_arc_negative(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_rel_move_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_rel_line_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_rel_curve_to(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_rectangle(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_close_path(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_path_extents(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_paint(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_paint_with_alpha(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)
DECLARE SUB cairo_mask(BYVAL AS cairo_t PTR, BYVAL AS cairo_pattern_t PTR)
DECLARE SUB cairo_mask_surface(BYVAL AS cairo_t PTR, BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_stroke(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_stroke_preserve(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_fill(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_fill_preserve(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_copy_page(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_show_page(BYVAL AS cairo_t PTR)
DECLARE FUNCTION cairo_in_stroke(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_bool_t
DECLARE FUNCTION cairo_in_fill(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_bool_t
DECLARE FUNCTION cairo_in_clip(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_bool_t
DECLARE SUB cairo_stroke_extents(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_fill_extents(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_reset_clip(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_clip(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_clip_preserve(BYVAL AS cairo_t PTR)
DECLARE SUB cairo_clip_extents(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)

TYPE _cairo_rectangle
  AS DOUBLE x, y, width, height
END TYPE

TYPE AS _cairo_rectangle cairo_rectangle_t

TYPE _cairo_rectangle_list
  AS cairo_status_t status
  AS cairo_rectangle_t PTR rectangles
  AS INTEGER num_rectangles
END TYPE

TYPE AS _cairo_rectangle_list cairo_rectangle_list_t

DECLARE FUNCTION cairo_copy_clip_rectangle_list(BYVAL AS cairo_t PTR) AS cairo_rectangle_list_t PTR
DECLARE SUB cairo_rectangle_list_destroy(BYVAL AS cairo_rectangle_list_t PTR)

TYPE cairo_scaled_font_t AS _cairo_scaled_font
TYPE cairo_font_face_t AS _cairo_font_face

TYPE cairo_glyph_t
  AS UINTEGER index
  AS DOUBLE x
  AS DOUBLE y
END TYPE

DECLARE FUNCTION cairo_glyph_allocate(BYVAL AS INTEGER) AS cairo_glyph_t PTR
DECLARE SUB cairo_glyph_free(BYVAL AS cairo_glyph_t PTR)

TYPE cairo_text_cluster_t
  AS INTEGER num_bytes
  AS INTEGER num_glyphs
END TYPE

DECLARE FUNCTION cairo_text_cluster_allocate(BYVAL AS INTEGER) AS cairo_text_cluster_t PTR
DECLARE SUB cairo_text_cluster_free(BYVAL AS cairo_text_cluster_t PTR)

ENUM _cairo_text_cluster_flags
  CAIRO_TEXT_CLUSTER_FLAG_BACKWARD = &h00000001
END ENUM

TYPE AS _cairo_text_cluster_flags cairo_text_cluster_flags_t

TYPE cairo_text_extents_t
  AS DOUBLE x_bearing
  AS DOUBLE y_bearing
  AS DOUBLE width
  AS DOUBLE height
  AS DOUBLE x_advance
  AS DOUBLE y_advance
END TYPE

TYPE cairo_font_extents_t
  AS DOUBLE ascent
  AS DOUBLE descent
  AS DOUBLE height
  AS DOUBLE max_x_advance
  AS DOUBLE max_y_advance
END TYPE

ENUM _cairo_font_slant
  CAIRO_FONT_SLANT_NORMAL
  CAIRO_FONT_SLANT_ITALIC
  CAIRO_FONT_SLANT_OBLIQUE
END ENUM

TYPE AS _cairo_font_slant cairo_font_slant_t

ENUM _cairo_font_weight
  CAIRO_FONT_WEIGHT_NORMAL
  CAIRO_FONT_WEIGHT_BOLD
END ENUM

TYPE AS _cairo_font_weight cairo_font_weight_t

ENUM _cairo_subpixel_order
  CAIRO_SUBPIXEL_ORDER_DEFAULT
  CAIRO_SUBPIXEL_ORDER_RGB
  CAIRO_SUBPIXEL_ORDER_BGR
  CAIRO_SUBPIXEL_ORDER_VRGB
  CAIRO_SUBPIXEL_ORDER_VBGR
END ENUM

TYPE AS _cairo_subpixel_order cairo_subpixel_order_t

ENUM _cairo_hint_style
  CAIRO_HINT_STYLE_DEFAULT
  CAIRO_HINT_STYLE_NONE
  CAIRO_HINT_STYLE_SLIGHT
  CAIRO_HINT_STYLE_MEDIUM
  CAIRO_HINT_STYLE_FULL
END ENUM

TYPE AS _cairo_hint_style cairo_hint_style_t

ENUM _cairo_hint_metrics
  CAIRO_HINT_METRICS_DEFAULT
  CAIRO_HINT_METRICS_OFF
  CAIRO_HINT_METRICS_ON
END ENUM

TYPE AS _cairo_hint_metrics cairo_hint_metrics_t

TYPE cairo_font_options_t AS _cairo_font_options

DECLARE FUNCTION cairo_font_options_create() AS cairo_font_options_t PTR
DECLARE FUNCTION cairo_font_options_copy(BYVAL AS CONST cairo_font_options_t PTR) AS cairo_font_options_t PTR
DECLARE SUB cairo_font_options_destroy(BYVAL AS cairo_font_options_t PTR)
DECLARE FUNCTION cairo_font_options_status(BYVAL AS cairo_font_options_t PTR) AS cairo_status_t
DECLARE SUB cairo_font_options_merge(BYVAL AS cairo_font_options_t PTR, BYVAL AS CONST cairo_font_options_t PTR)
DECLARE FUNCTION cairo_font_options_equal(BYVAL AS CONST cairo_font_options_t PTR, BYVAL AS CONST cairo_font_options_t PTR) AS cairo_bool_t
DECLARE FUNCTION cairo_font_options_hash(BYVAL AS CONST cairo_font_options_t PTR) AS UINTEGER
DECLARE SUB cairo_font_options_set_antialias(BYVAL AS cairo_font_options_t PTR, BYVAL AS cairo_antialias_t)
DECLARE FUNCTION cairo_font_options_get_antialias(BYVAL AS CONST cairo_font_options_t PTR) AS cairo_antialias_t
DECLARE SUB cairo_font_options_set_subpixel_order(BYVAL AS cairo_font_options_t PTR, BYVAL AS cairo_subpixel_order_t)
DECLARE FUNCTION cairo_font_options_get_subpixel_order(BYVAL AS CONST cairo_font_options_t PTR) AS cairo_subpixel_order_t
DECLARE SUB cairo_font_options_set_hint_style(BYVAL AS cairo_font_options_t PTR, BYVAL AS cairo_hint_style_t)
DECLARE FUNCTION cairo_font_options_get_hint_style(BYVAL AS CONST cairo_font_options_t PTR) AS cairo_hint_style_t
DECLARE SUB cairo_font_options_set_hint_metrics(BYVAL AS cairo_font_options_t PTR, BYVAL AS cairo_hint_metrics_t)
DECLARE FUNCTION cairo_font_options_get_hint_metrics(BYVAL AS CONST cairo_font_options_t PTR) AS cairo_hint_metrics_t
DECLARE SUB cairo_select_font_face(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS cairo_font_slant_t, BYVAL AS cairo_font_weight_t)
DECLARE SUB cairo_set_font_size(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE)
DECLARE SUB cairo_set_font_matrix(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE SUB cairo_get_font_matrix(BYVAL AS cairo_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_set_font_options(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_font_options_t PTR)
DECLARE SUB cairo_get_font_options(BYVAL AS cairo_t PTR, BYVAL AS cairo_font_options_t PTR)
DECLARE SUB cairo_set_font_face(BYVAL AS cairo_t PTR, BYVAL AS cairo_font_face_t PTR)
DECLARE FUNCTION cairo_get_font_face(BYVAL AS cairo_t PTR) AS cairo_font_face_t PTR
DECLARE SUB cairo_set_scaled_font(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_scaled_font_t PTR)
DECLARE FUNCTION cairo_get_scaled_font(BYVAL AS cairo_t PTR) AS cairo_scaled_font_t PTR
DECLARE SUB cairo_show_text(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB cairo_show_glyphs(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_glyph_t PTR, BYVAL AS INTEGER)
DECLARE SUB cairo_show_text_glyphs(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS CONST cairo_glyph_t PTR, BYVAL AS INTEGER, BYVAL AS CONST cairo_text_cluster_t PTR, BYVAL AS INTEGER, BYVAL AS cairo_text_cluster_flags_t)
DECLARE SUB cairo_text_path(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB cairo_glyph_path(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_glyph_t PTR, BYVAL AS INTEGER)
DECLARE SUB cairo_text_extents(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS cairo_text_extents_t PTR)
DECLARE SUB cairo_glyph_extents(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_glyph_t PTR, BYVAL AS INTEGER, BYVAL AS cairo_text_extents_t PTR)
DECLARE SUB cairo_font_extents(BYVAL AS cairo_t PTR, BYVAL AS cairo_font_extents_t PTR)
DECLARE FUNCTION cairo_font_face_reference(BYVAL AS cairo_font_face_t PTR) AS cairo_font_face_t PTR
DECLARE SUB cairo_font_face_destroy(BYVAL AS cairo_font_face_t PTR)
DECLARE FUNCTION cairo_font_face_get_reference_count(BYVAL AS cairo_font_face_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_font_face_status(BYVAL AS cairo_font_face_t PTR) AS cairo_status_t

ENUM _cairo_font_type
  CAIRO_FONT_TYPE_TOY
  CAIRO_FONT_TYPE_FT
  CAIRO_FONT_TYPE_WIN32
  CAIRO_FONT_TYPE_QUARTZ
  CAIRO_FONT_TYPE_USER
END ENUM

TYPE AS _cairo_font_type cairo_font_type_t

DECLARE FUNCTION cairo_font_face_get_type(BYVAL AS cairo_font_face_t PTR) AS cairo_font_type_t
DECLARE FUNCTION cairo_font_face_get_user_data(BYVAL AS cairo_font_face_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_font_face_set_user_data(BYVAL AS cairo_font_face_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t
DECLARE FUNCTION cairo_scaled_font_create(BYVAL AS cairo_font_face_t PTR, BYVAL AS CONST cairo_matrix_t PTR, BYVAL AS CONST cairo_matrix_t PTR, BYVAL AS CONST cairo_font_options_t PTR) AS cairo_scaled_font_t PTR
DECLARE FUNCTION cairo_scaled_font_reference(BYVAL AS cairo_scaled_font_t PTR) AS cairo_scaled_font_t PTR
DECLARE SUB cairo_scaled_font_destroy(BYVAL AS cairo_scaled_font_t PTR)
DECLARE FUNCTION cairo_scaled_font_get_reference_count(BYVAL AS cairo_scaled_font_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_scaled_font_status(BYVAL AS cairo_scaled_font_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_scaled_font_get_type(BYVAL AS cairo_scaled_font_t PTR) AS cairo_font_type_t
DECLARE FUNCTION cairo_scaled_font_get_user_data(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_scaled_font_set_user_data(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t
DECLARE SUB cairo_scaled_font_extents(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_font_extents_t PTR)
DECLARE SUB cairo_scaled_font_text_extents(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS cairo_text_extents_t PTR)
DECLARE SUB cairo_scaled_font_glyph_extents(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS CONST cairo_glyph_t PTR, BYVAL AS INTEGER, BYVAL AS cairo_text_extents_t PTR)
DECLARE FUNCTION cairo_scaled_font_text_to_glyphs(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS cairo_glyph_t PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS cairo_text_cluster_t PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS cairo_text_cluster_flags_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_scaled_font_get_font_face(BYVAL AS cairo_scaled_font_t PTR) AS cairo_font_face_t PTR
DECLARE SUB cairo_scaled_font_get_font_matrix(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_scaled_font_get_ctm(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_scaled_font_get_scale_matrix(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_scaled_font_get_font_options(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_font_options_t PTR)
DECLARE FUNCTION cairo_toy_font_face_create(BYVAL AS CONST ZSTRING PTR, BYVAL AS cairo_font_slant_t, BYVAL AS cairo_font_weight_t) AS cairo_font_face_t PTR
DECLARE FUNCTION cairo_toy_font_face_get_family(BYVAL AS cairo_font_face_t PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION cairo_toy_font_face_get_slant(BYVAL AS cairo_font_face_t PTR) AS cairo_font_slant_t
DECLARE FUNCTION cairo_toy_font_face_get_weight(BYVAL AS cairo_font_face_t PTR) AS cairo_font_weight_t
DECLARE FUNCTION cairo_user_font_face_create() AS cairo_font_face_t PTR

TYPE cairo_user_scaled_font_init_func_t AS FUNCTION(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_t PTR, BYVAL AS cairo_font_extents_t PTR) AS cairo_status_t
TYPE cairo_user_scaled_font_render_glyph_func_t AS FUNCTION(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS UINTEGER, BYVAL AS cairo_t PTR, BYVAL AS cairo_text_extents_t PTR) AS cairo_status_t
TYPE cairo_user_scaled_font_text_to_glyphs_func_t AS FUNCTION(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS cairo_glyph_t PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS cairo_text_cluster_t PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS cairo_text_cluster_flags_t PTR) AS cairo_status_t
TYPE cairo_user_scaled_font_unicode_to_glyph_func_t AS FUNCTION(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS UINTEGER, BYVAL AS UINTEGER PTR) AS cairo_status_t

DECLARE SUB cairo_user_font_face_set_init_func(BYVAL AS cairo_font_face_t PTR, BYVAL AS cairo_user_scaled_font_init_func_t)
DECLARE SUB cairo_user_font_face_set_render_glyph_func(BYVAL AS cairo_font_face_t PTR, BYVAL AS cairo_user_scaled_font_render_glyph_func_t)
DECLARE SUB cairo_user_font_face_set_text_to_glyphs_func(BYVAL AS cairo_font_face_t PTR, BYVAL AS cairo_user_scaled_font_text_to_glyphs_func_t)
DECLARE SUB cairo_user_font_face_set_unicode_to_glyph_func(BYVAL AS cairo_font_face_t PTR, BYVAL AS cairo_user_scaled_font_unicode_to_glyph_func_t)
DECLARE FUNCTION cairo_user_font_face_get_init_func(BYVAL AS cairo_font_face_t PTR) AS cairo_user_scaled_font_init_func_t
DECLARE FUNCTION cairo_user_font_face_get_render_glyph_func(BYVAL AS cairo_font_face_t PTR) AS cairo_user_scaled_font_render_glyph_func_t
DECLARE FUNCTION cairo_user_font_face_get_text_to_glyphs_func(BYVAL AS cairo_font_face_t PTR) AS cairo_user_scaled_font_text_to_glyphs_func_t
DECLARE FUNCTION cairo_user_font_face_get_unicode_to_glyph_func(BYVAL AS cairo_font_face_t PTR) AS cairo_user_scaled_font_unicode_to_glyph_func_t
DECLARE FUNCTION cairo_get_operator(BYVAL AS cairo_t PTR) AS cairo_operator_t
DECLARE FUNCTION cairo_get_source(BYVAL AS cairo_t PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_get_tolerance(BYVAL AS cairo_t PTR) AS DOUBLE
DECLARE FUNCTION cairo_get_antialias(BYVAL AS cairo_t PTR) AS cairo_antialias_t
DECLARE FUNCTION cairo_has_current_point(BYVAL AS cairo_t PTR) AS cairo_bool_t
DECLARE SUB cairo_get_current_point(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE FUNCTION cairo_get_fill_rule(BYVAL AS cairo_t PTR) AS cairo_fill_rule_t
DECLARE FUNCTION cairo_get_line_width(BYVAL AS cairo_t PTR) AS DOUBLE
DECLARE FUNCTION cairo_get_line_cap(BYVAL AS cairo_t PTR) AS cairo_line_cap_t
DECLARE FUNCTION cairo_get_line_join(BYVAL AS cairo_t PTR) AS cairo_line_join_t
DECLARE FUNCTION cairo_get_miter_limit(BYVAL AS cairo_t PTR) AS DOUBLE
DECLARE FUNCTION cairo_get_dash_count(BYVAL AS cairo_t PTR) AS INTEGER
DECLARE SUB cairo_get_dash(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_get_matrix(BYVAL AS cairo_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE FUNCTION cairo_get_target(BYVAL AS cairo_t PTR) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_get_group_target(BYVAL AS cairo_t PTR) AS cairo_surface_t PTR

ENUM _cairo_path_data_type
  CAIRO_PATH_MOVE_TO
  CAIRO_PATH_LINE_TO
  CAIRO_PATH_CURVE_TO
  CAIRO_PATH_CLOSE_PATH
END ENUM

TYPE AS _cairo_path_data_type cairo_path_data_type_t

TYPE cairo_path_data_t AS _cairo_path_data_t

TYPE _cairo_path_data_t_header
  AS cairo_path_data_type_t type
  AS INTEGER length
END TYPE

TYPE _cairo_path_data_t_point
  AS DOUBLE x, y
END TYPE

UNION _cairo_path_data_t
  AS _cairo_path_data_t_header header
  AS _cairo_path_data_t_point point
END UNION

TYPE cairo_path
  AS cairo_status_t status
  AS cairo_path_data_t PTR data
  AS INTEGER num_data
END TYPE

TYPE AS cairo_path cairo_path_t

DECLARE FUNCTION cairo_copy_path(BYVAL AS cairo_t PTR) AS cairo_path_t PTR
DECLARE FUNCTION cairo_copy_path_flat(BYVAL AS cairo_t PTR) AS cairo_path_t PTR
DECLARE SUB cairo_append_path(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_path_t PTR)
DECLARE SUB cairo_path_destroy(BYVAL AS cairo_path_t PTR)
DECLARE FUNCTION cairo_status(BYVAL AS cairo_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_status_to_string(BYVAL AS cairo_status_t) AS CONST ZSTRING PTR
DECLARE FUNCTION cairo_device_reference(BYVAL AS cairo_device_t PTR) AS cairo_device_t PTR

ENUM _cairo_device_type
  CAIRO_DEVICE_TYPE_DRM
  CAIRO_DEVICE_TYPE_GL
  CAIRO_DEVICE_TYPE_SCRIPT
  CAIRO_DEVICE_TYPE_XCB
  CAIRO_DEVICE_TYPE_XLIB
  CAIRO_DEVICE_TYPE_XML
END ENUM

TYPE AS _cairo_device_type cairo_device_type_t

DECLARE FUNCTION cairo_device_get_type(BYVAL AS cairo_device_t PTR) AS cairo_device_type_t
DECLARE FUNCTION cairo_device_status(BYVAL AS cairo_device_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_device_acquire(BYVAL AS cairo_device_t PTR) AS cairo_status_t
DECLARE SUB cairo_device_release(BYVAL AS cairo_device_t PTR)
DECLARE SUB cairo_device_flush(BYVAL AS cairo_device_t PTR)
DECLARE SUB cairo_device_finish(BYVAL AS cairo_device_t PTR)
DECLARE SUB cairo_device_destroy(BYVAL AS cairo_device_t PTR)
DECLARE FUNCTION cairo_device_get_reference_count(BYVAL AS cairo_device_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_device_get_user_data(BYVAL AS cairo_device_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_device_set_user_data(BYVAL AS cairo_device_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t
DECLARE FUNCTION cairo_surface_create_similar(BYVAL AS cairo_surface_t PTR, BYVAL AS cairo_content_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_surface_create_for_rectangle(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_surface_reference(BYVAL AS cairo_surface_t PTR) AS cairo_surface_t PTR
DECLARE SUB cairo_surface_finish(BYVAL AS cairo_surface_t PTR)
DECLARE SUB cairo_surface_destroy(BYVAL AS cairo_surface_t PTR)
DECLARE FUNCTION cairo_surface_get_device(BYVAL AS cairo_surface_t PTR) AS cairo_device_t PTR
DECLARE FUNCTION cairo_surface_get_reference_count(BYVAL AS cairo_surface_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_surface_status(BYVAL AS cairo_surface_t PTR) AS cairo_status_t

ENUM _cairo_surface_type
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
END ENUM

TYPE AS _cairo_surface_type cairo_surface_type_t

DECLARE FUNCTION cairo_surface_get_type(BYVAL AS cairo_surface_t PTR) AS cairo_surface_type_t
DECLARE FUNCTION cairo_surface_get_content(BYVAL AS cairo_surface_t PTR) AS cairo_content_t

#IF CAIRO_HAS_PNG_FUNCTIONS

DECLARE FUNCTION cairo_surface_write_to_png(BYVAL AS cairo_surface_t PTR, BYVAL AS CONST ZSTRING PTR) AS cairo_status_t
DECLARE FUNCTION cairo_surface_write_to_png_stream(BYVAL AS cairo_surface_t PTR, BYVAL AS cairo_write_func_t, BYVAL AS ANY PTR) AS cairo_status_t

#ENDIF ' CAIRO_HAS_PNG_FUNCTIONS

DECLARE FUNCTION cairo_surface_get_user_data(BYVAL AS cairo_surface_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_surface_set_user_data(BYVAL AS cairo_surface_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t

#DEFINE CAIRO_MIME_TYPE_JPEG !"image/jpeg"
#DEFINE CAIRO_MIME_TYPE_PNG !"image/png"
#DEFINE CAIRO_MIME_TYPE_JP2 !"image/jp2"
#DEFINE CAIRO_MIME_TYPE_URI !"text/x-uri"

DECLARE SUB cairo_surface_get_mime_data(BYVAL AS cairo_surface_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST UBYTE PTR PTR, BYVAL AS UINTEGER PTR)
DECLARE FUNCTION cairo_surface_set_mime_data(BYVAL AS cairo_surface_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST UBYTE PTR, BYVAL AS UINTEGER, BYVAL AS cairo_destroy_func_t, BYVAL AS ANY PTR) AS cairo_status_t
DECLARE SUB cairo_surface_get_font_options(BYVAL AS cairo_surface_t PTR, BYVAL AS cairo_font_options_t PTR)
DECLARE SUB cairo_surface_flush(BYVAL AS cairo_surface_t PTR)
DECLARE SUB cairo_surface_mark_dirty(BYVAL AS cairo_surface_t PTR)
DECLARE SUB cairo_surface_mark_dirty_rectangle(BYVAL AS cairo_surface_t PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB cairo_surface_set_device_offset(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_surface_get_device_offset(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_surface_set_fallback_resolution(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_surface_get_fallback_resolution(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_surface_copy_page(BYVAL AS cairo_surface_t PTR)
DECLARE SUB cairo_surface_show_page(BYVAL AS cairo_surface_t PTR)
DECLARE FUNCTION cairo_surface_has_show_text_glyphs(BYVAL AS cairo_surface_t PTR) AS cairo_bool_t

ENUM _cairo_format
  CAIRO_FORMAT_INVALID = -1
  CAIRO_FORMAT_ARGB32 = 0
  CAIRO_FORMAT_RGB24 = 1
  CAIRO_FORMAT_A8 = 2
  CAIRO_FORMAT_A1 = 3
  CAIRO_FORMAT_RGB16_565 = 4
END ENUM

TYPE AS _cairo_format cairo_format_t

DECLARE FUNCTION cairo_image_surface_create(BYVAL AS cairo_format_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_format_stride_for_width(BYVAL AS cairo_format_t, BYVAL AS INTEGER) AS INTEGER
DECLARE FUNCTION cairo_image_surface_create_for_data(BYVAL AS UBYTE PTR, BYVAL AS cairo_format_t, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_image_surface_get_data(BYVAL AS cairo_surface_t PTR) AS UBYTE PTR
DECLARE FUNCTION cairo_image_surface_get_format(BYVAL AS cairo_surface_t PTR) AS cairo_format_t
DECLARE FUNCTION cairo_image_surface_get_width(BYVAL AS cairo_surface_t PTR) AS INTEGER
DECLARE FUNCTION cairo_image_surface_get_height(BYVAL AS cairo_surface_t PTR) AS INTEGER
DECLARE FUNCTION cairo_image_surface_get_stride(BYVAL AS cairo_surface_t PTR) AS INTEGER

#IF CAIRO_HAS_PNG_FUNCTIONS

DECLARE FUNCTION cairo_image_surface_create_from_png(BYVAL AS CONST ZSTRING PTR) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_image_surface_create_from_png_stream(BYVAL AS cairo_read_func_t, BYVAL AS ANY PTR) AS cairo_surface_t PTR

#ENDIF ' CAIRO_HAS_PNG_FUNCTIONS

DECLARE FUNCTION cairo_recording_surface_create(BYVAL AS cairo_content_t, BYVAL AS CONST cairo_rectangle_t PTR) AS cairo_surface_t PTR
DECLARE SUB cairo_recording_surface_ink_extents(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE FUNCTION cairo_pattern_create_rgb(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_pattern_create_rgba(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_pattern_create_for_surface(BYVAL AS cairo_surface_t PTR) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_pattern_create_linear(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_pattern_create_radial(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_pattern_t PTR
DECLARE FUNCTION cairo_pattern_reference(BYVAL AS cairo_pattern_t PTR) AS cairo_pattern_t PTR
DECLARE SUB cairo_pattern_destroy(BYVAL AS cairo_pattern_t PTR)
DECLARE FUNCTION cairo_pattern_get_reference_count(BYVAL AS cairo_pattern_t PTR) AS UINTEGER
DECLARE FUNCTION cairo_pattern_status(BYVAL AS cairo_pattern_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_user_data(BYVAL AS cairo_pattern_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR) AS ANY PTR
DECLARE FUNCTION cairo_pattern_set_user_data(BYVAL AS cairo_pattern_t PTR, BYVAL AS CONST cairo_user_data_key_t PTR, BYVAL AS ANY PTR, BYVAL AS cairo_destroy_func_t) AS cairo_status_t

ENUM _cairo_pattern_type
  CAIRO_PATTERN_TYPE_SOLID
  CAIRO_PATTERN_TYPE_SURFACE
  CAIRO_PATTERN_TYPE_LINEAR
  CAIRO_PATTERN_TYPE_RADIAL
END ENUM

TYPE AS _cairo_pattern_type cairo_pattern_type_t

DECLARE FUNCTION cairo_pattern_get_type(BYVAL AS cairo_pattern_t PTR) AS cairo_pattern_type_t
DECLARE SUB cairo_pattern_add_color_stop_rgb(BYVAL AS cairo_pattern_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_pattern_add_color_stop_rgba(BYVAL AS cairo_pattern_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_pattern_set_matrix(BYVAL AS cairo_pattern_t PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE SUB cairo_pattern_get_matrix(BYVAL AS cairo_pattern_t PTR, BYVAL AS cairo_matrix_t PTR)

ENUM _cairo_extend
  CAIRO_EXTEND_NONE
  CAIRO_EXTEND_REPEAT
  CAIRO_EXTEND_REFLECT
  CAIRO_EXTEND_PAD
END ENUM

TYPE AS _cairo_extend cairo_extend_t

DECLARE SUB cairo_pattern_set_extend(BYVAL AS cairo_pattern_t PTR, BYVAL AS cairo_extend_t)
DECLARE FUNCTION cairo_pattern_get_extend(BYVAL AS cairo_pattern_t PTR) AS cairo_extend_t

ENUM _cairo_filter
  CAIRO_FILTER_FAST
  CAIRO_FILTER_GOOD
  CAIRO_FILTER_BEST
  CAIRO_FILTER_NEAREST
  CAIRO_FILTER_BILINEAR
  CAIRO_FILTER_GAUSSIAN
END ENUM

TYPE AS _cairo_filter cairo_filter_t

DECLARE SUB cairo_pattern_set_filter(BYVAL AS cairo_pattern_t PTR, BYVAL AS cairo_filter_t)
DECLARE FUNCTION cairo_pattern_get_filter(BYVAL AS cairo_pattern_t PTR) AS cairo_filter_t
DECLARE FUNCTION cairo_pattern_get_rgba(BYVAL AS cairo_pattern_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_surface(BYVAL AS cairo_pattern_t PTR, BYVAL AS cairo_surface_t PTR PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_color_stop_rgba(BYVAL AS cairo_pattern_t PTR, BYVAL AS INTEGER, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_color_stop_count(BYVAL AS cairo_pattern_t PTR, BYVAL AS INTEGER PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_linear_points(BYVAL AS cairo_pattern_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR) AS cairo_status_t
DECLARE FUNCTION cairo_pattern_get_radial_circles(BYVAL AS cairo_pattern_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR) AS cairo_status_t
DECLARE SUB cairo_matrix_init(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_init_identity(BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_matrix_init_translate(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_init_scale(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_init_rotate(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_translate(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_scale(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB cairo_matrix_rotate(BYVAL AS cairo_matrix_t PTR, BYVAL AS DOUBLE)
DECLARE FUNCTION cairo_matrix_invert(BYVAL AS cairo_matrix_t PTR) AS cairo_status_t
DECLARE SUB cairo_matrix_multiply(BYVAL AS cairo_matrix_t PTR, BYVAL AS CONST cairo_matrix_t PTR, BYVAL AS CONST cairo_matrix_t PTR)
DECLARE SUB cairo_matrix_transform_distance(BYVAL AS CONST cairo_matrix_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)
DECLARE SUB cairo_matrix_transform_point(BYVAL AS CONST cairo_matrix_t PTR, BYVAL AS DOUBLE PTR, BYVAL AS DOUBLE PTR)

TYPE cairo_region_t AS _cairo_region

TYPE _cairo_rectangle_int
  AS INTEGER x, y
  AS INTEGER width, height
END TYPE

TYPE AS _cairo_rectangle_int cairo_rectangle_int_t

ENUM _cairo_region_overlap
  CAIRO_REGION_OVERLAP_IN
  CAIRO_REGION_OVERLAP_OUT
  CAIRO_REGION_OVERLAP_PART
END ENUM

TYPE AS _cairo_region_overlap cairo_region_overlap_t

DECLARE FUNCTION cairo_region_create() AS cairo_region_t PTR
DECLARE FUNCTION cairo_region_create_rectangle(BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_region_t PTR
DECLARE FUNCTION cairo_region_create_rectangles(BYVAL AS CONST cairo_rectangle_int_t PTR, BYVAL AS INTEGER) AS cairo_region_t PTR
DECLARE FUNCTION cairo_region_copy(BYVAL AS CONST cairo_region_t PTR) AS cairo_region_t PTR
DECLARE FUNCTION cairo_region_reference(BYVAL AS cairo_region_t PTR) AS cairo_region_t PTR
DECLARE SUB cairo_region_destroy(BYVAL AS cairo_region_t PTR)
DECLARE FUNCTION cairo_region_equal(BYVAL AS CONST cairo_region_t PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_bool_t
DECLARE FUNCTION cairo_region_status(BYVAL AS CONST cairo_region_t PTR) AS cairo_status_t
DECLARE SUB cairo_region_get_extents(BYVAL AS CONST cairo_region_t PTR, BYVAL AS cairo_rectangle_int_t PTR)
DECLARE FUNCTION cairo_region_num_rectangles(BYVAL AS CONST cairo_region_t PTR) AS INTEGER
DECLARE SUB cairo_region_get_rectangle(BYVAL AS CONST cairo_region_t PTR, BYVAL AS INTEGER, BYVAL AS cairo_rectangle_int_t PTR)
DECLARE FUNCTION cairo_region_is_empty(BYVAL AS CONST cairo_region_t PTR) AS cairo_bool_t
DECLARE FUNCTION cairo_region_contains_rectangle(BYVAL AS CONST cairo_region_t PTR, BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_region_overlap_t
DECLARE FUNCTION cairo_region_contains_point(BYVAL AS CONST cairo_region_t PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_bool_t
DECLARE SUB cairo_region_translate(BYVAL AS cairo_region_t PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE FUNCTION cairo_region_subtract(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_subtract_rectangle(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_intersect(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_intersect_rectangle(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_union(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_union_rectangle(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_xor(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_status_t
DECLARE FUNCTION cairo_region_xor_rectangle(BYVAL AS cairo_region_t PTR, BYVAL AS CONST cairo_rectangle_int_t PTR) AS cairo_status_t
DECLARE SUB cairo_debug_reset_static_data()

#ENDIF ' CAIRO_H

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
