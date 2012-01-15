''
''
'' gtktearoffmenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktearoffmenuitem_bi__
#define __gtktearoffmenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkmenuitem.bi"

#define GTK_TYPE_TEAROFF_MENU_ITEM (gtk_tearoff_menu_item_get_type ())
#define GTK_TEAROFF_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItem))
#define GTK_TEAROFF_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass))
#define GTK_IS_TEAROFF_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEAROFF_MENU_ITEM))
#define GTK_IS_TEAROFF_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEAROFF_MENU_ITEM))
#define GTK_TEAROFF_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass))

type GtkTearoffMenuItem as _GtkTearoffMenuItem
type GtkTearoffMenuItemClass as _GtkTearoffMenuItemClass

type _GtkTearoffMenuItem
	menu_item as GtkMenuItem
	torn_off as guint
end type

type _GtkTearoffMenuItemClass
	parent_class as GtkMenuItemClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tearoff_menu_item_get_type () as GType
declare function gtk_tearoff_menu_item_new () as GtkWidget ptr

#endif
