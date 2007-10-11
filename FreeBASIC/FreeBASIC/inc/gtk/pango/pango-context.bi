''
''
'' pango-context -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_context_bi__
#define __pango_context_bi__

#include once "pango-font.bi"
#include once "pango-fontmap.bi"
#include once "pango-attributes.bi"

#define PANGO_TYPE_CONTEXT (pango_context_get_type ())
#define PANGO_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_CONTEXT, PangoContext))
#define PANGO_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), PANGO_TYPE_CONTEXT, PangoContextClass))
#define PANGO_IS_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_CONTEXT))
#define PANGO_IS_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), PANGO_TYPE_CONTEXT))
#define PANGO_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), PANGO_TYPE_CONTEXT, PangoContextClass))


type PangoContextClass as _PangoContextClass

declare function pango_context_get_type () as GType
declare function pango_context_get_font_map (byval context as PangoContext ptr) as PangoFontMap ptr
declare sub pango_context_list_families (byval context as PangoContext ptr, byval families as PangoFontFamily ptr ptr ptr, byval n_families as integer ptr)
declare function pango_context_load_font (byval context as PangoContext ptr, byval desc as PangoFontDescription ptr) as PangoFont ptr
declare function pango_context_load_fontset (byval context as PangoContext ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontset ptr
declare function pango_context_get_metrics (byval context as PangoContext ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr) as PangoFontMetrics ptr
declare sub pango_context_set_font_description (byval context as PangoContext ptr, byval desc as PangoFontDescription ptr)
declare function pango_context_get_font_description (byval context as PangoContext ptr) as PangoFontDescription ptr
declare function pango_context_get_language (byval context as PangoContext ptr) as PangoLanguage ptr
declare sub pango_context_set_language (byval context as PangoContext ptr, byval language as PangoLanguage ptr)
declare sub pango_context_set_base_dir (byval context as PangoContext ptr, byval direction as PangoDirection)
declare function pango_context_get_base_dir (byval context as PangoContext ptr) as PangoDirection
declare sub pango_context_set_matrix (byval context as PangoContext ptr, byval matrix as PangoMatrix ptr)
declare function pango_context_get_matrix (byval context as PangoContext ptr) as PangoMatrix ptr
declare function pango_itemize (byval context as PangoContext ptr, byval text as zstring ptr, byval start_index as integer, byval length as integer, byval attrs as PangoAttrList ptr, byval cached_iter as PangoAttrIterator ptr) as GList ptr
declare function pango_itemize_with_base_dir (byval context as PangoContext ptr, byval base_dir as PangoDirection, byval text as zstring ptr, byval start_index as integer, byval length as integer, byval attrs as PangoAttrList ptr, byval cached_iter as PangoAttrIterator ptr) as GList ptr

#endif
