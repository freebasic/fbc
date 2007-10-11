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
#include once "gtkmenuitem.bi"

#define GTK_TYPE_SEPARATOR_MENU_ITEM (gtk_separator_menu_item_get_type ())
#define GTK_SEPARATOR_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItem))
#define GTK_SEPARATOR_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass))
#define GTK_IS_SEPARATOR_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM))
#define GTK_IS_SEPARATOR_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR_MENU_ITEM))
#define GTK_SEPARATOR_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass))

type GtkSeparatorMenuItem as _GtkSeparatorMenuItem
type GtkSeparatorMenuItemClass as _GtkSeparatorMenuItemClass

type _GtkSeparatorMenuItem
	menu_item as GtkMenuItem
end type

type _GtkSeparatorMenuItemClass
	parent_class as GtkMenuItemClass
end type

declare function gtk_separator_menu_item_get_type () as GType
declare function gtk_separator_menu_item_new () as GtkWidget ptr

#endif
