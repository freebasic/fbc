''
''
'' gtktexttag -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktexttag_bi__
#define __gtktexttag_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkenums.bi"
#include once "gtk/gtk/gtkobject.bi"

type GtkTextIter as _GtkTextIter
type GtkTextTagTable as _GtkTextTagTable
type GtkTextAttributes as _GtkTextAttributes
type GtkTextTag as _GtkTextTag
type GtkTextTagClass as _GtkTextTagClass

type _GtkTextTag
	parent_instance as GObject
	table as GtkTextTagTable ptr
	name as zstring ptr
	priority as integer
	values as GtkTextAttributes ptr
	''!!!FIXME!!! bit-fields support is needed
	union
		bg_color_set as guint
		bg_stipple_set as guint
		fg_color_set as guint
		scale_set as guint
		fg_stipple_set as guint
		justification_set as guint
		left_margin_set as guint
		indent_set as guint
		rise_set as guint
		strikethrough_set as guint
		right_margin_set as guint
		pixels_above_lines_set as guint
		pixels_below_lines_set as guint
		pixels_inside_wrap_set as guint
		tabs_set as guint
		underline_set as guint
		wrap_mode_set as guint
		bg_full_height_set as guint
		invisible_set as guint
		editable_set as guint
		language_set as guint
		pad1 as guint
		pad2 as guint
		pad3 as guint
	end union
end type

type _GtkTextTagClass
	parent_class as GObjectClass
	event as function cdecl(byval as GtkTextTag ptr, byval as GObject ptr, byval as GdkEvent ptr, byval as GtkTextIter ptr) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_text_tag_get_type cdecl alias "gtk_text_tag_get_type" () as GType
declare function gtk_text_tag_new cdecl alias "gtk_text_tag_new" (byval name as string) as GtkTextTag ptr
declare function gtk_text_tag_get_priority cdecl alias "gtk_text_tag_get_priority" (byval tag as GtkTextTag ptr) as gint
declare sub gtk_text_tag_set_priority cdecl alias "gtk_text_tag_set_priority" (byval tag as GtkTextTag ptr, byval priority as gint)
declare function gtk_text_tag_event cdecl alias "gtk_text_tag_event" (byval tag as GtkTextTag ptr, byval event_object as GObject ptr, byval event as GdkEvent ptr, byval iter as GtkTextIter ptr) as gboolean

type GtkTextAppearance as _GtkTextAppearance

type _GtkTextAppearance
	bg_color as GdkColor
	fg_color as GdkColor
	bg_stipple as GdkBitmap ptr
	fg_stipple as GdkBitmap ptr
	rise as gint
	padding1 as gpointer
	''!!!FIXME!!! bit-fields support is needed
	union
		underline as guint
		strikethrough as guint
		draw_bg as guint
		inside_selection as guint
		is_text as guint
		pad1 as guint
		pad2 as guint
		pad3 as guint
		pad4 as guint
	end union
end type

type _GtkTextAttributes
	refcount as guint
	appearance as GtkTextAppearance
	justification as GtkJustification
	direction as GtkTextDirection
	font as PangoFontDescription ptr
	font_scale as gdouble
	left_margin as gint
	indent as gint
	right_margin as gint
	pixels_above_lines as gint
	pixels_below_lines as gint
	pixels_inside_wrap as gint
	tabs as PangoTabArray ptr
	wrap_mode as GtkWrapMode
	language as PangoLanguage ptr
	padding1 as gpointer
	''!!!FIXME!!! bit-fields support is needed
	union
		invisible as guint
		bg_full_height as guint
		editable as guint
		realized as guint
		pad1 as guint
		pad2 as guint
		pad3 as guint
		pad4 as guint
	end union
end type

declare function gtk_text_attributes_new cdecl alias "gtk_text_attributes_new" () as GtkTextAttributes ptr
declare function gtk_text_attributes_copy cdecl alias "gtk_text_attributes_copy" (byval src as GtkTextAttributes ptr) as GtkTextAttributes ptr
declare sub gtk_text_attributes_copy_values cdecl alias "gtk_text_attributes_copy_values" (byval src as GtkTextAttributes ptr, byval dest as GtkTextAttributes ptr)
declare sub gtk_text_attributes_unref cdecl alias "gtk_text_attributes_unref" (byval values as GtkTextAttributes ptr)
declare sub gtk_text_attributes_ref cdecl alias "gtk_text_attributes_ref" (byval values as GtkTextAttributes ptr)
declare function gtk_text_attributes_get_type cdecl alias "gtk_text_attributes_get_type" () as GType

#endif
