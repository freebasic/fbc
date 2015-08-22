'' FreeBASIC binding for pango-1.36.8
''
'' based on the C header files:
''   Copyright (C) 1999, 2004 Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the
''   Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
''   Boston, MA 02111-1301, USA.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "pangocairo-1.0"

#include once "pango/pango.bi"
#include once "cairo/cairo.bi"

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __PANGOCAIRO_H__
type PangoCairoFont as _PangoCairoFont
#define PANGO_TYPE_CAIRO_FONT pango_cairo_font_get_type()
#define PANGO_CAIRO_FONT(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_CAIRO_FONT, PangoCairoFont)
#define PANGO_IS_CAIRO_FONT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_CAIRO_FONT)
type PangoCairoFontMap as _PangoCairoFontMap
#define PANGO_TYPE_CAIRO_FONT_MAP pango_cairo_font_map_get_type()
#define PANGO_CAIRO_FONT_MAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), PANGO_TYPE_CAIRO_FONT_MAP, PangoCairoFontMap)
#define PANGO_IS_CAIRO_FONT_MAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), PANGO_TYPE_CAIRO_FONT_MAP)
type PangoCairoShapeRendererFunc as sub(byval cr as cairo_t ptr, byval attr as PangoAttrShape ptr, byval do_path as gboolean, byval data as gpointer)

declare function pango_cairo_font_map_get_type() as GType
declare function pango_cairo_font_map_new() as PangoFontMap ptr
declare function pango_cairo_font_map_new_for_font_type(byval fonttype as cairo_font_type_t) as PangoFontMap ptr
declare function pango_cairo_font_map_get_default() as PangoFontMap ptr
declare sub pango_cairo_font_map_set_default(byval fontmap as PangoCairoFontMap ptr)
declare function pango_cairo_font_map_get_font_type(byval fontmap as PangoCairoFontMap ptr) as cairo_font_type_t
declare sub pango_cairo_font_map_set_resolution(byval fontmap as PangoCairoFontMap ptr, byval dpi as double)
declare function pango_cairo_font_map_get_resolution(byval fontmap as PangoCairoFontMap ptr) as double
declare function pango_cairo_font_map_create_context(byval fontmap as PangoCairoFontMap ptr) as PangoContext ptr
declare function pango_cairo_font_get_type() as GType
declare function pango_cairo_font_get_scaled_font(byval font as PangoCairoFont ptr) as cairo_scaled_font_t ptr
declare sub pango_cairo_update_context(byval cr as cairo_t ptr, byval context as PangoContext ptr)
declare sub pango_cairo_context_set_font_options(byval context as PangoContext ptr, byval options as const cairo_font_options_t ptr)
declare function pango_cairo_context_get_font_options(byval context as PangoContext ptr) as const cairo_font_options_t ptr
declare sub pango_cairo_context_set_resolution(byval context as PangoContext ptr, byval dpi as double)
declare function pango_cairo_context_get_resolution(byval context as PangoContext ptr) as double
declare sub pango_cairo_context_set_shape_renderer(byval context as PangoContext ptr, byval func as PangoCairoShapeRendererFunc, byval data as gpointer, byval dnotify as GDestroyNotify)
declare function pango_cairo_context_get_shape_renderer(byval context as PangoContext ptr, byval data as gpointer ptr) as PangoCairoShapeRendererFunc
declare function pango_cairo_create_context(byval cr as cairo_t ptr) as PangoContext ptr
declare function pango_cairo_create_layout(byval cr as cairo_t ptr) as PangoLayout ptr
declare sub pango_cairo_update_layout(byval cr as cairo_t ptr, byval layout as PangoLayout ptr)
declare sub pango_cairo_show_glyph_string(byval cr as cairo_t ptr, byval font as PangoFont ptr, byval glyphs as PangoGlyphString ptr)
declare sub pango_cairo_show_glyph_item(byval cr as cairo_t ptr, byval text as const zstring ptr, byval glyph_item as PangoGlyphItem ptr)
declare sub pango_cairo_show_layout_line(byval cr as cairo_t ptr, byval line as PangoLayoutLine ptr)
declare sub pango_cairo_show_layout(byval cr as cairo_t ptr, byval layout as PangoLayout ptr)
declare sub pango_cairo_show_error_underline(byval cr as cairo_t ptr, byval x as double, byval y as double, byval width as double, byval height as double)
declare sub pango_cairo_glyph_string_path(byval cr as cairo_t ptr, byval font as PangoFont ptr, byval glyphs as PangoGlyphString ptr)
declare sub pango_cairo_layout_line_path(byval cr as cairo_t ptr, byval line as PangoLayoutLine ptr)
declare sub pango_cairo_layout_path(byval cr as cairo_t ptr, byval layout as PangoLayout ptr)
declare sub pango_cairo_error_underline_path(byval cr as cairo_t ptr, byval x as double, byval y as double, byval width as double, byval height as double)

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
