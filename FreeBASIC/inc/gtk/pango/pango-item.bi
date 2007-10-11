''
''
'' pango-item -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_item_bi__
#define __pango_item_bi__

#include once "pango-types.bi"

type PangoAnalysis as _PangoAnalysis
type PangoItem as _PangoItem

type _PangoAnalysis
	shape_engine as PangoEngineShape ptr
	lang_engine as PangoEngineLang ptr
	font as PangoFont ptr
	level as guint8
	language as PangoLanguage ptr
	extra_attrs as GSList ptr
end type

type _PangoItem
	offset as gint
	length as gint
	num_chars as gint
	analysis as PangoAnalysis
end type

declare function pango_item_new () as PangoItem ptr
declare function pango_item_copy (byval item as PangoItem ptr) as PangoItem ptr
declare sub pango_item_free (byval item as PangoItem ptr)
declare function pango_item_split (byval orig as PangoItem ptr, byval split_index as integer, byval split_offset as integer) as PangoItem ptr

#endif
