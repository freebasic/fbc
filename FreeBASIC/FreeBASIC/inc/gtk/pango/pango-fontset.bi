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

#include once "pango-coverage.bi"
#include once "pango-types.bi"
#include once "gtk/glib-object.bi"

#define PANGO_TYPE_FONTSET (pango_fontset_get_type ())
#define PANGO_FONTSET(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONTSET, PangoFontset))
#define PANGO_IS_FONTSET(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONTSET))

#define PANGO_FONTSET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_FONTSET, PangoFontsetClass))
#define PANGO_IS_FONTSET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_FONTSET))
#define PANGO_FONTSET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_FONTSET, PangoFontsetClass))

#define PANGO_TYPE_FONTSET_SIMPLE (pango_fontset_simple_get_type ())
#define PANGO_FONTSET_SIMPLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_FONTSET_SIMPLE, PangoFontsetSimple))
#define PANGO_IS_FONTSET_SIMPLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_FONTSET_SIMPLE))

declare function pango_fontset_get_type () as GType

type PangoFontset as _PangoFontset
type PangoFontsetForeachFunc as function cdecl(byval as PangoFontset ptr, byval as PangoFont ptr, byval as gpointer) as gboolean

declare function pango_fontset_get_font (byval fontset as PangoFontset ptr, byval wc as guint) as PangoFont ptr
declare function pango_fontset_get_metrics (byval fontset as PangoFontset ptr) as PangoFontMetrics ptr
declare sub pango_fontset_foreach (byval fontset as PangoFontset ptr, byval func as PangoFontsetForeachFunc, byval data as gpointer)

#endif
