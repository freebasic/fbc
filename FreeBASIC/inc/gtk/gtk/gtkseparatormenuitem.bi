''
''
'' gtkseparatormenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkseparatormenuitem_bi__
#define __gtkseparatormenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkmenuitem.bi"

type GtkSeparatorMenuItem as _GtkSeparatorMenuItem
type GtkSeparatorMenuItemClass as _GtkSeparatorMenuItemClass

type _GtkSeparatorMenuItem
	menu_item as GtkMenuItem
end type

type _GtkSeparatorMenuItemClass
	parent_class as GtkMenuItemClass
end type

declare function gtk_separator_menu_item_get_type cdecl alias "gtk_separator_menu_item_get_type" () as GType
declare function gtk_separator_menu_item_new cdecl alias "gtk_separator_menu_item_new" () as GtkWidget ptr

#endif
