''
''
'' gtkaccessible -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaccessible_bi__
#define __gtkaccessible_bi__

#include once "gtk/atk.bi"
#include once "gtk/gtk/gtkwidget.bi"

type GtkAccessible as _GtkAccessible
type GtkAccessibleClass as _GtkAccessibleClass

type _GtkAccessible
	parent as AtkObject ptr
	widget as GtkWidget ptr
end type

type _GtkAccessibleClass
	parent_class as AtkObjectClass
	connect_widget_destroyed as sub cdecl(byval as GtkAccessible ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_accessible_get_type cdecl alias "gtk_accessible_get_type" () as GType
declare sub gtk_accessible_connect_widget_destroyed cdecl alias "gtk_accessible_connect_widget_destroyed" (byval accessible as GtkAccessible ptr)

#endif
