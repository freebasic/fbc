''
''
'' pango-attributes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_attributes_bi__
#define __pango_attributes_bi__

#include once "pango-font.bi"
#include once "gtk/glib-object.bi"

type PangoColor as _PangoColor

type _PangoColor
	red as guint16
	green as guint16
	blue as guint16
end type

declare function pango_color_get_type () as GType
declare function pango_color_copy (byval src as PangoColor ptr) as PangoColor ptr
declare sub pango_color_free (byval color as PangoColor ptr)
declare function pango_color_parse (byval color as PangoColor ptr, byval spec as zstring ptr) as gboolean

type PangoAttribute as _PangoAttribute
type PangoAttrClass as _PangoAttrClass
type PangoAttrString as _PangoAttrString
type PangoAttrLanguage as _PangoAttrLanguage
type PangoAttrInt as _PangoAttrInt
type PangoAttrSize as _PangoAttrSize
type PangoAttrFloat as _PangoAttrFloat
type PangoAttrColor as _PangoAttrColor
type PangoAttrFontDesc as _PangoAttrFontDesc
type PangoAttrShape as _PangoAttrShape
type PangoAttrList as _PangoAttrList
type PangoAttrIterator as _PangoAttrIterator

enum PangoAttrType
	PANGO_ATTR_INVALID
	PANGO_ATTR_LANGUAGE
	PANGO_ATTR_FAMILY
	PANGO_ATTR_STYLE
	PANGO_ATTR_WEIGHT
	PANGO_ATTR_VARIANT
	PANGO_ATTR_STRETCH
	PANGO_ATTR_SIZE
	PANGO_ATTR_FONT_DESC
	PANGO_ATTR_FOREGROUND
	PANGO_ATTR_BACKGROUND
	PANGO_ATTR_UNDERLINE
	PANGO_ATTR_STRIKETHROUGH
	PANGO_ATTR_RISE
	PANGO_ATTR_SHAPE
	PANGO_ATTR_SCALE
	PANGO_ATTR_FALLBACK
	PANGO_ATTR_LETTER_SPACING
	PANGO_ATTR_UNDERLINE_COLOR
	PANGO_ATTR_STRIKETHROUGH_COLOR
end enum


enum PangoUnderline
	PANGO_UNDERLINE_NONE
	PANGO_UNDERLINE_SINGLE
	PANGO_UNDERLINE_DOUBLE
	PANGO_UNDERLINE_LOW
	PANGO_UNDERLINE_ERROR
end enum


type _PangoAttribute
	klass as PangoAttrClass ptr
	start_index as guint
	end_index as guint
end type

type PangoAttrFilterFunc as function cdecl(byval as PangoAttribute ptr, byval as gpointer) as gboolean
type PangoAttrDataCopyFunc as function cdecl(byval as gconstpointer) as gpointer

type _PangoAttrClass
	type as PangoAttrType
	copy as function cdecl(byval as PangoAttribute ptr) as PangoAttribute
	destroy as sub cdecl(byval as PangoAttribute ptr)
	equal as function cdecl(byval as PangoAttribute ptr, byval as PangoAttribute ptr) as gboolean
end type

type _PangoAttrString
	attr as PangoAttribute
	value as zstring ptr
end type

type _PangoAttrLanguage
	attr as PangoAttribute
	value as PangoLanguage ptr
end type

type _PangoAttrInt
	attr as PangoAttribute
	value as integer
end type

type _PangoAttrFloat
	attr as PangoAttribute
	value as double
end type

type _PangoAttrColor
	attr as PangoAttribute
	color as PangoColor
end type

type _PangoAttrSize
	attr as PangoAttribute
	size as integer
	absolute as guint
end type

type _PangoAttrShape
	attr as PangoAttribute
	ink_rect as PangoRectangle
	logical_rect as PangoRectangle
	data as gpointer
	copy_func as PangoAttrDataCopyFunc
	destroy_func as GDestroyNotify
end type

type _PangoAttrFontDesc
	attr as PangoAttribute
	desc as PangoFontDescription ptr
end type

declare function pango_attr_type_register (byval name as zstring ptr) as PangoAttrType
declare function pango_attribute_copy (byval attr as PangoAttribute ptr) as PangoAttribute ptr
declare sub pango_attribute_destroy (byval attr as PangoAttribute ptr)
declare function pango_attribute_equal (byval attr1 as PangoAttribute ptr, byval attr2 as PangoAttribute ptr) as gboolean
declare function pango_attr_language_new (byval language as PangoLanguage ptr) as PangoAttribute ptr
declare function pango_attr_family_new (byval family as zstring ptr) as PangoAttribute ptr
declare function pango_attr_foreground_new (byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_background_new (byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_size_new (byval size as integer) as PangoAttribute ptr
declare function pango_attr_size_new_absolute (byval size as integer) as PangoAttribute ptr
declare function pango_attr_style_new (byval style as PangoStyle) as PangoAttribute ptr
declare function pango_attr_weight_new (byval weight as PangoWeight) as PangoAttribute ptr
declare function pango_attr_variant_new (byval variant as PangoVariant) as PangoAttribute ptr
declare function pango_attr_stretch_new (byval stretch as PangoStretch) as PangoAttribute ptr
declare function pango_attr_font_desc_new (byval desc as PangoFontDescription ptr) as PangoAttribute ptr
declare function pango_attr_underline_new (byval underline as PangoUnderline) as PangoAttribute ptr
declare function pango_attr_underline_color_new (byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_strikethrough_new (byval strikethrough as gboolean) as PangoAttribute ptr
declare function pango_attr_strikethrough_color_new (byval red as guint16, byval green as guint16, byval blue as guint16) as PangoAttribute ptr
declare function pango_attr_rise_new (byval rise as integer) as PangoAttribute ptr
declare function pango_attr_scale_new (byval scale_factor as double) as PangoAttribute ptr
declare function pango_attr_fallback_new (byval enable_fallback as gboolean) as PangoAttribute ptr
declare function pango_attr_letter_spacing_new (byval letter_spacing as integer) as PangoAttribute ptr
declare function pango_attr_shape_new (byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr) as PangoAttribute ptr
declare function pango_attr_shape_new_with_data (byval ink_rect as PangoRectangle ptr, byval logical_rect as PangoRectangle ptr, byval data as gpointer, byval copy_func as PangoAttrDataCopyFunc, byval destroy_func as GDestroyNotify) as PangoAttribute ptr
declare function pango_attr_list_get_type () as GType
declare function pango_attr_list_new () as PangoAttrList ptr
declare sub pango_attr_list_ref (byval list as PangoAttrList ptr)
declare sub pango_attr_list_unref (byval list as PangoAttrList ptr)
declare function pango_attr_list_copy (byval list as PangoAttrList ptr) as PangoAttrList ptr
declare sub pango_attr_list_insert (byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_insert_before (byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_change (byval list as PangoAttrList ptr, byval attr as PangoAttribute ptr)
declare sub pango_attr_list_splice (byval list as PangoAttrList ptr, byval other as PangoAttrList ptr, byval pos as gint, byval len as gint)
declare function pango_attr_list_filter (byval list as PangoAttrList ptr, byval func as PangoAttrFilterFunc, byval data as gpointer) as PangoAttrList ptr
declare function pango_attr_list_get_iterator (byval list as PangoAttrList ptr) as PangoAttrIterator ptr
declare sub pango_attr_iterator_range (byval iterator as PangoAttrIterator ptr, byval start as gint ptr, byval end as gint ptr)
declare function pango_attr_iterator_next (byval iterator as PangoAttrIterator ptr) as gboolean
declare function pango_attr_iterator_copy (byval iterator as PangoAttrIterator ptr) as PangoAttrIterator ptr
declare sub pango_attr_iterator_destroy (byval iterator as PangoAttrIterator ptr)
declare function pango_attr_iterator_get (byval iterator as PangoAttrIterator ptr, byval type as PangoAttrType) as PangoAttribute ptr
declare sub pango_attr_iterator_get_font (byval iterator as PangoAttrIterator ptr, byval desc as PangoFontDescription ptr, byval language as PangoLanguage ptr ptr, byval extra_attrs as GSList ptr ptr)
declare function pango_attr_iterator_get_attrs (byval iterator as PangoAttrIterator ptr) as GSList ptr
declare function pango_parse_markup (byval markup_text as zstring ptr, byval length as integer, byval accel_marker as gunichar, byval attr_list as PangoAttrList ptr ptr, byval text as byte ptr ptr, byval accel_char as gunichar ptr, byval error as GError ptr ptr) as gboolean

#endif
