''
''
'' pango-types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_types_bi__
#define __pango_types_bi__

#include once "gtk/glib.bi"
#include once "gtk/glib-object.bi"

type PangoLogAttr as _PangoLogAttr
type PangoEngineLang as _PangoEngineLang
type PangoEngineShape as _PangoEngineShape
type PangoFont as _PangoFont
type PangoMatrix as _PangoMatrix
type PangoRectangle as _PangoRectangle
type PangoLanguage as _PangoLanguage
type PangoGlyph as guint32

type _PangoRectangle
	x as integer
	y as integer
	width as integer
	height as integer
end type

type _PangoMatrix
	xx as double
	xy as double
	yx as double
	yy as double
	x0 as double
	y0 as double
end type

declare function pango_matrix_get_type () as GType
declare function pango_matrix_copy (byval matrix as PangoMatrix ptr) as PangoMatrix ptr
declare sub pango_matrix_free (byval matrix as PangoMatrix ptr)
declare sub pango_matrix_translate (byval matrix as PangoMatrix ptr, byval tx as double, byval ty as double)
declare sub pango_matrix_scale (byval matrix as PangoMatrix ptr, byval scale_x as double, byval scale_y as double)
declare sub pango_matrix_rotate (byval matrix as PangoMatrix ptr, byval degrees as double)
declare sub pango_matrix_concat (byval matrix as PangoMatrix ptr, byval new_matrix as PangoMatrix ptr)

#define PANGO_SCALE 1024

enum PangoDirection
	PANGO_DIRECTION_LTR
	PANGO_DIRECTION_RTL
	PANGO_DIRECTION_TTB_LTR
	PANGO_DIRECTION_TTB_RTL
	PANGO_DIRECTION_WEAK_LTR
	PANGO_DIRECTION_WEAK_RTL
	PANGO_DIRECTION_NEUTRAL
end enum


declare function pango_language_get_type () as GType
declare function pango_language_from_string (byval language as zstring ptr) as PangoLanguage ptr
declare function pango_language_matches (byval language as PangoLanguage ptr, byval range_list as zstring ptr) as gboolean
declare function pango_get_mirror_char (byval ch as gunichar, byval mirrored_ch as gunichar ptr) as gboolean
declare function pango_unichar_direction (byval ch as gunichar) as PangoDirection
declare function pango_find_base_dir (byval text as zstring ptr, byval length as gint) as PangoDirection

#endif
