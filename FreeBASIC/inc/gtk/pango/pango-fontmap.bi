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

#include once "gtk/pango/pango-font.bi"
#include once "gtk/pango/pango-fontset.bi"

type PangoContext as _PangoContext
type PangoFontMap as _PangoFontMap

declare function pango_font_map_get_type cdecl alias "pango_font_map_get_type" () as GType
declare function pango_font_map_load_font cdecl alias "pango_font_map_load_font" (byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as PangoFontDescription ptr) as PangoFont ptr
declare function pango_font_map_load_fontset cdecl alias "pango_font_map_load_fontset" (byval fontmap as PangoFontMap ptr, byval context as PangoContext ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontset ptr
declare sub pango_font_map_list_families cdecl alias "pango_font_map_list_families" (byval fontmap as PangoFontMap ptr, byval families as PangoFontFamily ptr ptr ptr, byval n_families as integer ptr)

#endif
