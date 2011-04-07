''
''
'' pango-glyph -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_glyph_bi__
#define __pango_glyph_bi__

#include once "pango-types.bi"
#include once "pango-item.bi"

type PangoGlyphGeometry as _PangoGlyphGeometry
type PangoGlyphVisAttr as _PangoGlyphVisAttr
type PangoGlyphInfo as _PangoGlyphInfo
type PangoGlyphString as _PangoGlyphString
type PangoGlyphUnit as gint32

type _PangoGlyphGeometry
	width as PangoGlyphUnit
	x_offset as PangoGlyphUnit
	y_offset as PangoGlyphUnit
end type

type _PangoGlyphVisAttr
	is_cluster_start as guint
end type

type _PangoGlyphInfo
	glyph as PangoGlyph
	geometry as PangoGlyphGeometry
	attr as PangoGlyphVisAttr
end type

type _PangoGlyphString
	num_glyphs as gint
	glyphs as PangoGlyphInfo ptr
	log_clusters as gint ptr
	space as gint
end type

declare function pango_glyph_string_new () as PangoGlyphString ptr
declare sub pango_glyph_string_set_size (byval string as PangoGlyphString ptr, byval new_len as gint)
declare function pango_glyph_string_get_type () as GType
declare function pango_glyph_string_copy (byval string as PangoGlyphString ptr) as PangoGlyphString ptr
declare sub pango_glyph_string_free (byval string as PangoGlyphString ptr)
declare sub pango_glyph_string_extents (byval glyphs as PangoGlyphString ptr, byval font as PangoFont ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_glyph_string_extents_range (byval glyphs as PangoGlyphString ptr, byval start as integer, byval end as integer, byval font as PangoFont ptr, byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr)
declare sub pango_glyph_string_get_logical_widths (byval glyphs as PangoGlyphString ptr, byval text as zstring ptr, byval length as integer, byval embedding_level as integer, byval logical_widths as integer ptr)
declare sub pango_glyph_string_index_to_x (byval glyphs as PangoGlyphString ptr, byval text as zstring ptr, byval length as integer, byval analysis as PangoAnalysis ptr, byval index_ as integer, byval trailing as gboolean, byval x_pos as integer ptr)
declare sub pango_glyph_string_x_to_index (byval glyphs as PangoGlyphString ptr, byval text as zstring ptr, byval length as integer, byval analysis as PangoAnalysis ptr, byval x_pos as integer, byval index_ as integer ptr, byval trailing as integer ptr)
declare sub pango_shape (byval text as zstring ptr, byval length as gint, byval analysis as PangoAnalysis ptr, byval glyphs as PangoGlyphString ptr)
declare function pango_reorder_items (byval logical_items as GList ptr) as GList ptr

#endif
