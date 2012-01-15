''
''
'' pango-layout -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_layout_bi__
#define __pango_layout_bi__

#include once "pango-attributes.bi"
#include once "pango-context.bi"
#include once "pango-glyph-item.bi"
#include once "pango-tabs.bi"

#define PANGO_TYPE_LAYOUT (pango_layout_get_type ())
#define PANGO_LAYOUT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_LAYOUT, PangoLayout))
#define PANGO_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_LAYOUT, PangoLayoutClass))
#define PANGO_IS_LAYOUT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_LAYOUT))
#define PANGO_IS_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_LAYOUT))
#define PANGO_LAYOUT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_LAYOUT, PangoLayoutClass))

type PangoLayout as _PangoLayout
type PangoLayoutClass as _PangoLayoutClass
type PangoLayoutLine as _PangoLayoutLine
type PangoLayoutRun as PangoGlyphItem

enum PangoAlignment
	PANGO_ALIGN_LEFT
	PANGO_ALIGN_CENTER
	PANGO_ALIGN_RIGHT
end enum


enum PangoWrapMode
	PANGO_WRAP_WORD
	PANGO_WRAP_CHAR
	PANGO_WRAP_WORD_CHAR
end enum


enum PangoEllipsizeMode
	PANGO_ELLIPSIZE_NONE
	PANGO_ELLIPSIZE_START
	PANGO_ELLIPSIZE_MIDDLE
	PANGO_ELLIPSIZE_END
end enum


type _PangoLayoutLine
	layout as PangoLayout ptr
	start_index as gint
	length as gint
	runs as GSList ptr
	is_paragraph_start:1 as guint
	resolved_dir:3 as guint
end type

declare function pango_layout_get_type () as GType
declare function pango_layout_new (byval context as PangoContext ptr) as PangoLayout ptr
declare function pango_layout_copy (byval src as PangoLayout ptr) as PangoLayout ptr
declare function pango_layout_get_context (byval layout as PangoLayout ptr) as PangoContext ptr
declare sub pango_layout_set_attributes (byval layout as PangoLayout ptr, byval attrs as PangoAttrList ptr)
declare function pango_layout_get_attributes (byval layout as PangoLayout ptr) as PangoAttrList ptr
declare sub pango_layout_set_text (byval layout as PangoLayout ptr, byval text as zstring ptr, byval length as integer)
declare function pango_layout_get_text (byval layout as PangoLayout ptr) as zstring ptr
declare sub pango_layout_set_markup (byval layout as PangoLayout ptr, byval markup as zstring ptr, byval length as integer)
declare sub pango_layout_set_markup_with_accel (byval layout as PangoLayout ptr, byval markup as zstring ptr, byval length as integer, byval accel_marker as gunichar, byval accel_char as gunichar ptr)
declare sub pango_layout_set_font_description (byval layout as PangoLayout ptr, byval desc as PangoFontDescription ptr)
declare function pango_layout_get_font_description (byval layout as PangoLayout ptr) as PangoFontDescription ptr
declare sub pango_layout_set_width (byval layout as PangoLayout ptr, byval width as integer)
declare function pango_layout_get_width (byval layout as PangoLayout ptr) as integer
declare sub pango_layout_set_wrap (byval layout as PangoLayout ptr, byval wrap as PangoWrapMode)
declare function pango_layout_get_wrap (byval layout as PangoLayout ptr) as PangoWrapMode
declare sub pango_layout_set_indent (byval layout as PangoLayout ptr, byval indent as integer)
declare function pango_layout_get_indent (byval layout as PangoLayout ptr) as integer
declare sub pango_layout_set_spacing (byval layout as PangoLayout ptr, byval spacing as integer)
declare function pango_layout_get_spacing (byval layout as PangoLayout ptr) as integer
declare sub pango_layout_set_justify (byval layout as PangoLayout ptr, byval justify as gboolean)
declare function pango_layout_get_justify (byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_auto_dir (byval layout as PangoLayout ptr, byval auto_dir as gboolean)
declare function pango_layout_get_auto_dir (byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_alignment (byval layout as PangoLayout ptr, byval alignment as PangoAlignment)
declare function pango_layout_get_alignment (byval layout as PangoLayout ptr) as PangoAlignment
declare sub pango_layout_set_tabs (byval layout as PangoLayout ptr, byval tabs as PangoTabArray ptr)
declare function pango_layout_get_tabs (byval layout as PangoLayout ptr) as PangoTabArray ptr
declare sub pango_layout_set_single_paragraph_mode (byval layout as PangoLayout ptr, byval setting as gboolean)
declare function pango_layout_get_single_paragraph_mode (byval layout as PangoLayout ptr) as gboolean
declare sub pango_layout_set_ellipsize (byval layout as PangoLayout ptr, byval ellipsize as PangoEllipsizeMode)
declare function pango_layout_get_ellipsize (byval layout as PangoLayout ptr) as PangoEllipsizeMode
declare sub pango_layout_context_changed (byval layout as PangoLayout ptr)
declare sub pango_layout_get_log_attrs (byval layout as PangoLayout ptr, byval attrs as PangoLogAttr ptr ptr, byval n_attrs as gint ptr)
declare sub pango_layout_index_to_pos (byval layout as PangoLayout ptr, byval index_ as integer, byval pos as PangoRectangle ptr)
declare sub pango_layout_get_cursor_pos (byval layout as PangoLayout ptr, byval index_ as integer, byval strong_pos as PangoRectangle ptr, byval weak_pos as PangoRectangle ptr)
declare sub pango_layout_move_cursor_visually (byval layout as PangoLayout ptr, byval strong as gboolean, byval old_index as integer, byval old_trailing as integer, byval direction as integer, byval new_index as integer ptr, byval new_trailing as integer ptr)
declare function pango_layout_xy_to_index (byval layout as PangoLayout ptr, byval x as integer, byval y as integer, byval index_ as integer ptr, byval trailing as integer ptr) as gboolean
declare sub pango_layout_get_extents (byval layout as PangoLayout ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_get_pixel_extents (byval layout as PangoLayout ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_get_size (byval layout as PangoLayout ptr, byval width as integer ptr, byval height as integer ptr)
declare sub pango_layout_get_pixel_size (byval layout as PangoLayout ptr, byval width as integer ptr, byval height as integer ptr)
declare function pango_layout_get_line_count (byval layout as PangoLayout ptr) as integer
declare function pango_layout_get_line (byval layout as PangoLayout ptr, byval line as integer) as PangoLayoutLine ptr
declare function pango_layout_get_lines (byval layout as PangoLayout ptr) as GSList ptr
declare sub pango_layout_line_ref (byval line as PangoLayoutLine ptr)
declare sub pango_layout_line_unref (byval line as PangoLayoutLine ptr)
declare function pango_layout_line_x_to_index (byval line as PangoLayoutLine ptr, byval x_pos as integer, byval index_ as integer ptr, byval trailing as integer ptr) as gboolean
declare sub pango_layout_line_index_to_x (byval line as PangoLayoutLine ptr, byval index_ as integer, byval trailing as gboolean, byval x_pos as integer ptr)
declare sub pango_layout_line_get_x_ranges (byval line as PangoLayoutLine ptr, byval start_index as integer, byval end_index as integer, byval ranges as integer ptr ptr, byval n_ranges as integer ptr)
declare sub pango_layout_line_get_extents (byval line as PangoLayoutLine ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_line_get_pixel_extents (byval layout_line as PangoLayoutLine ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)

type PangoLayoutIter as _PangoLayoutIter

declare function pango_layout_iter_get_type () as GType
declare function pango_layout_get_iter (byval layout as PangoLayout ptr) as PangoLayoutIter ptr
declare sub pango_layout_iter_free (byval iter as PangoLayoutIter ptr)
declare function pango_layout_iter_get_index (byval iter as PangoLayoutIter ptr) as integer
declare function pango_layout_iter_get_run (byval iter as PangoLayoutIter ptr) as PangoLayoutRun ptr
declare function pango_layout_iter_get_line (byval iter as PangoLayoutIter ptr) as PangoLayoutLine ptr
declare function pango_layout_iter_at_last_line (byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_char (byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_cluster (byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_run (byval iter as PangoLayoutIter ptr) as gboolean
declare function pango_layout_iter_next_line (byval iter as PangoLayoutIter ptr) as gboolean
declare sub pango_layout_iter_get_char_extents (byval iter as PangoLayoutIter ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_cluster_extents (byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_run_extents (byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_line_extents (byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_layout_iter_get_line_yrange (byval iter as PangoLayoutIter ptr, byval y0_ as integer ptr, byval y1_ as integer ptr)
declare sub pango_layout_iter_get_layout_extents (byval iter as PangoLayoutIter ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare function pango_layout_iter_get_baseline (byval iter as PangoLayoutIter ptr) as integer

#endif
