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
#include once "gtkenums.bi"
#include once "gtkobject.bi"

#define GTK_TYPE_TEXT_TAG (gtk_text_tag_get_type ())
#define GTK_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG, GtkTextTag))
#define GTK_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_TAG, GtkTextTagClass))
#define GTK_IS_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG))
#define GTK_IS_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_TAG))
#define GTK_TEXT_TAG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_TAG, GtkTextTagClass))

#define GTK_TYPE_TEXT_ATTRIBUTES (gtk_text_attributes_get_type ())

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
	bg_color_set:1 as guint
	bg_stipple_set:1 as guint
	fg_color_set:1 as guint
	scale_set:1 as guint
	fg_stipple_set:1 as guint
	justification_set:1 as guint
	left_margin_set:1 as guint
	indent_set:1 as guint
	rise_set:1 as guint
	strikethrough_set:1 as guint
	right_margin_set:1 as guint
	pixels_above_lines_set:1 as guint
	pixels_below_lines_set:1 as guint
	pixels_inside_wrap_set:1 as guint
	tabs_set:1 as guint
	underline_set:1 as guint
	wrap_mode_set:1 as guint
	bg_full_height_set:1 as guint
	invisible_set:1 as guint
	editable_set:1 as guint
	language_set:1 as guint
	pad1:1 as guint
	pad2:1 as guint
	pad3:1 as guint
end type

type _GtkTextTagClass
	parent_class as GObjectClass
	event as function cdecl(byval as GtkTextTag ptr, byval as GObject ptr, byval as GdkEvent ptr, byval as GtkTextIter ptr) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_text_tag_get_type () as GType
declare function gtk_text_tag_new (byval name as zstring ptr) as GtkTextTag ptr
declare function gtk_text_tag_get_priority (byval tag as GtkTextTag ptr) as gint
declare sub gtk_text_tag_set_priority (byval tag as GtkTextTag ptr, byval priority as gint)
declare function gtk_text_tag_event (byval tag as GtkTextTag ptr, byval event_object as GObject ptr, byval event as GdkEvent ptr, byval iter as GtkTextIter ptr) as gboolean

type GtkTextAppearance as _GtkTextAppearance

type _GtkTextAppearance
	bg_color as GdkColor
	fg_color as GdkColor
	bg_stipple as GdkBitmap ptr
	fg_stipple as GdkBitmap ptr
	rise as gint
	padding1 as gpointer
	underline:4 as guint
	strikethrough:1 as guint
	draw_bg:1 as guint
	inside_selection:1 as guint
	is_text:1 as guint
	pad1:1 as guint
	pad2:1 as guint
	pad3:1 as guint
	pad4:1 as guint
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
	invisible:1 as guint
	bg_full_height:1 as guint
	editable:1 as guint
	realized:1 as guint
	pad1:1 as guint
	pad2:1 as guint
	pad3:1 as guint
	pad4:1 as guint
end type

declare function gtk_text_attributes_new () as GtkTextAttributes ptr
declare function gtk_text_attributes_copy (byval src as GtkTextAttributes ptr) as GtkTextAttributes ptr
declare sub gtk_text_attributes_copy_values (byval src as GtkTextAttributes ptr, byval dest as GtkTextAttributes ptr)
declare sub gtk_text_attributes_unref (byval values as GtkTextAttributes ptr)
declare sub gtk_text_attributes_ref (byval values as GtkTextAttributes ptr)
declare function gtk_text_attributes_get_type () as GType

#endif
