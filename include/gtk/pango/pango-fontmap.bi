''
''
'' pango-fontmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_fontmap_bi__
#define __pango_fontmap_bi__

#include once "pango-font.bi"
#include once "pango-fontset.bi"

#define PANGO_TYPE_FONT_MAP (pango_font_map_get_type ())
#define PANGO_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONT_MAP, PangoFontMap))
#define PANGO_IS_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONT_MAP))

#define PANGO_FONT_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONT_MAP, PangoFontMapClass))
#define PANGO_IS_FONT_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONT_MAP))
#define PANGO_FONT_MAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONT_MAP, PangoFontMapClass))

type PangoContext as _PangoContext
type PangoFontMap as _PangoFontMap

declare function pango_font_map_get_type () as GType
declare function pango_font_map_load_font (byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as PangoFontDescription ptr) as PangoFont ptr
declare function pango_font_map_load_fontset (byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontset ptr
declare sub pango_font_map_list_families (byval fontmap as PangoFontMap ptr, byval families as PangoFontFamily ptr ptr ptr, byval n_families as integer ptr)

#endif
