''
''
'' pango-fontset -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_fontset_bi__
#define __pango_fontset_bi__

#include once "gtk/pango/pango-coverage.bi"
#include once "gtk/pango/pango-types.bi"
#include once "gtk/glib-object.bi"

declare function pango_fontset_get_type cdecl alias "pango_fontset_get_type" () as GType

type PangoFontset as _PangoFontset
type PangoFontsetForeachFunc as function cdecl(byval as PangoFontset ptr, byval as PangoFont ptr, byval as gpointer) as gboolean

declare function pango_fontset_get_font cdecl alias "pango_fontset_get_font" (byval fontset as PangoFontset ptr, byval wc as guint) as PangoFont ptr
declare function pango_fontset_get_metrics cdecl alias "pango_fontset_get_metrics" (byval fontset as PangoFontset ptr) as PangoFontMetrics ptr
declare sub pango_fontset_foreach cdecl alias "pango_fontset_foreach" (byval fontset as PangoFontset ptr, byval func as PangoFontsetForeachFunc, byval data as gpointer)

#endif
