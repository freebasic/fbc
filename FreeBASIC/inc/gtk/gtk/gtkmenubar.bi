''
''
'' gtkmenubar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmenubar_bi__
#define __gtkmenubar_bi__

#include once "gtk/gdk.bi"
#include once "gtkmenushell.bi"

#define	GTK_TYPE_MENU_BAR               gtk_menu_bar_get_type()
#define GTK_MENU_BAR(obj)               G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_MENU_BAR, GtkMenuBar)
#define GTK_MENU_BAR_CLASS(klass)       G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_MENU_BAR, GtkMenuBarClass)
#define GTK_IS_MENU_BAR(obj)            G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_MENU_BAR)
#define GTK_IS_MENU_BAR_CLASS(klass)    G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_MENU_BAR)
#define GTK_MENU_BAR_GET_CLASS(obj)     G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_MENU_BAR, GtkMenuBarClass)

type GtkMenuBar as _GtkMenuBar
type GtkMenuBarClass as _GtkMenuBarClass

type _GtkMenuBar
	menu_shell as GtkMenuShell
end type

type _GtkMenuBarClass
	parent_class as GtkMenuShellClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_menu_bar_get_type () as GType
declare function gtk_menu_bar_new () as GtkWidget ptr
declare sub _gtk_menu_bar_cycle_focus (byval menubar as GtkMenuBar ptr, byval dir as GtkDirectionType)

#define gtk_menu_bar_append(menu,child)	gtk_menu_shell_append(cptr(GtkMenuShell ptr, menu), child)
#define gtk_menu_bar_prepend(menu,child) gtk_menu_shell_prepend(cptr(GtkMenuShell ptr, menu), child)
#define gtk_menu_bar_insert(menu,child,pos) gtk_menu_shell_insert(cptr(GtkMenuShell ptr, menu), child, pos)

#endif
