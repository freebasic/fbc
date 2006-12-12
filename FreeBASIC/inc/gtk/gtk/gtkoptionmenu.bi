''
''
'' gtkoptionmenu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkoptionmenu_bi__
#define __gtkoptionmenu_bi__

#include once "gtk/gdk.bi"
#include once "gtkbutton.bi"

#define GTK_TYPE_OPTION_MENU (gtk_option_menu_get_type ())
#define GTK_OPTION_MENU(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_OPTION_MENU, GtkOptionMenu))
#define GTK_OPTION_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_OPTION_MENU, GtkOptionMenuClass))
#define GTK_IS_OPTION_MENU(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_OPTION_MENU))
#define GTK_IS_OPTION_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_OPTION_MENU))
#define GTK_OPTION_MENU_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_OPTION_MENU, GtkOptionMenuClass))

type GtkOptionMenu as _GtkOptionMenu
type GtkOptionMenuClass as _GtkOptionMenuClass

type _GtkOptionMenu
	button as GtkButton
	menu as GtkWidget ptr
	menu_item as GtkWidget ptr
	width as guint16
	height as guint16
end type

type _GtkOptionMenuClass
	parent_class as GtkButtonClass
	changed as sub cdecl(byval as GtkOptionMenu ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_option_menu_get_type () as GType
declare function gtk_option_menu_new () as GtkWidget ptr
declare function gtk_option_menu_get_menu (byval option_menu as GtkOptionMenu ptr) as GtkWidget ptr
declare sub gtk_option_menu_set_menu (byval option_menu as GtkOptionMenu ptr, byval menu as GtkWidget ptr)
declare sub gtk_option_menu_remove_menu (byval option_menu as GtkOptionMenu ptr)
declare function gtk_option_menu_get_history (byval option_menu as GtkOptionMenu ptr) as gint
declare sub gtk_option_menu_set_history (byval option_menu as GtkOptionMenu ptr, byval index_ as guint)

#endif
