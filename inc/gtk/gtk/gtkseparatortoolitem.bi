''
''
'' gtkseparatortoolitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkseparatortoolitem_bi__
#define __gtkseparatortoolitem_bi__

#include once "gtktoolitem.bi"

#define GTK_TYPE_SEPARATOR_TOOL_ITEM (gtk_separator_tool_item_get_type ())
#define GTK_SEPARATOR_TOOL_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItem))
#define GTK_SEPARATOR_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass))
#define GTK_IS_SEPARATOR_TOOL_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM))
#define GTK_IS_SEPARATOR_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM))
#define GTK_SEPARATOR_TOOL_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass))

type GtkSeparatorToolItem as _GtkSeparatorToolItem
type GtkSeparatorToolItemClass as _GtkSeparatorToolItemClass
type GtkSeparatorToolItemPrivate as _GtkSeparatorToolItemPrivate

type _GtkSeparatorToolItem
	parent as GtkToolItem
	priv as GtkSeparatorToolItemPrivate ptr
end type

type _GtkSeparatorToolItemClass
	parent_class as GtkToolItemClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_separator_tool_item_get_type () as GType
declare function gtk_separator_tool_item_new () as GtkToolItem ptr
declare function gtk_separator_tool_item_get_draw (byval item as GtkSeparatorToolItem ptr) as gboolean
declare sub gtk_separator_tool_item_set_draw (byval item as GtkSeparatorToolItem ptr, byval draw as gboolean)

#endif
