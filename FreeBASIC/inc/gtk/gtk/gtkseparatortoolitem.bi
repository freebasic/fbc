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

#include once "gtk/gtk/gtktoolitem.bi"

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

declare function gtk_separator_tool_item_get_type cdecl alias "gtk_separator_tool_item_get_type" () as GType
declare function gtk_separator_tool_item_new cdecl alias "gtk_separator_tool_item_new" () as GtkToolItem ptr
declare function gtk_separator_tool_item_get_draw cdecl alias "gtk_separator_tool_item_get_draw" (byval item as GtkSeparatorToolItem ptr) as gboolean
declare sub gtk_separator_tool_item_set_draw cdecl alias "gtk_separator_tool_item_set_draw" (byval item as GtkSeparatorToolItem ptr, byval draw as gboolean)

#endif
