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
#include once "gtk/gtk/gtkmenushell.bi"

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

declare function gtk_menu_bar_get_type cdecl alias "gtk_menu_bar_get_type" () as GType
declare function gtk_menu_bar_new cdecl alias "gtk_menu_bar_new" () as GtkWidget ptr
declare sub _gtk_menu_bar_cycle_focus cdecl alias "_gtk_menu_bar_cycle_focus" (byval menubar as GtkMenuBar ptr, byval dir as GtkDirectionType)

#define gtk_menu_bar_append(menu,child)	gtk_menu_shell_append(menu,child)
#define gtk_menu_bar_prepend(menu,child) gtk_menu_shell_prepend(menu,child)
#define gtk_menu_bar_insert(menu,child,pos) gtk_menu_shell_insert(menu,child,pos)

#endif
