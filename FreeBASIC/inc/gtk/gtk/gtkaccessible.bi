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
#include once "gtkwidget.bi"

#define GTK_TYPE_ACCESSIBLE (gtk_accessible_get_type ())
#define GTK_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACCESSIBLE, GtkAccessible))
#define GTK_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass))
#define GTK_IS_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACCESSIBLE))
#define GTK_IS_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCESSIBLE))
#define GTK_ACCESSIBLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass))

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

declare function gtk_accessible_get_type () as GType
declare sub gtk_accessible_connect_widget_destroyed (byval accessible as GtkAccessible ptr)

#endif
