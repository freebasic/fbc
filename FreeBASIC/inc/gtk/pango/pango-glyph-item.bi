''
''
'' pango-glyph-item -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_glyph_item_bi__
#define __pango_glyph_item_bi__

#include once "pango-attributes.bi"
#include once "pango-break.bi"
#include once "pango-item.bi"
#include once "pango-glyph.bi"

type PangoGlyphItem as _PangoGlyphItem

type _PangoGlyphItem
	item as PangoItem ptr
	glyphs as PangoGlyphString ptr
end type

declare function pango_glyph_item_split (byval orig as PangoGlyphItem ptr, byval text as zstring ptr, byval split_index as integer) as PangoGlyphItem ptr
declare sub pango_glyph_item_free (byval glyph_item as PangoGlyphItem ptr)
declare function pango_glyph_item_apply_attrs (byval glyph_item as PangoGlyphItem ptr, byval text as zstring ptr, byval list as PangoAttrList ptr) as GSList ptr
declare sub pango_glyph_item_letter_space (byval glyph_item as PangoGlyphItem ptr, byval text as zstring ptr, byval log_attrs as PangoLogAttr ptr, byval letter_spacing as integer)

#endif
