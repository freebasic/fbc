''
''
'' gtkseparator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkseparator_bi__
#define __gtkseparator_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_SEPARATOR (gtk_separator_get_type ())
#define GTK_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR, GtkSeparator))
#define GTK_SEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR, GtkSeparatorClass))
#define GTK_IS_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR))
#define GTK_IS_SEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR))
#define GTK_SEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SEPARATOR, GtkSeparatorClass))

type GtkSeparator as _GtkSeparator
type GtkSeparatorClass as _GtkSeparatorClass

type _GtkSeparator
	widget as GtkWidget
end type

type _GtkSeparatorClass
	parent_class as GtkWidgetClass
end type

declare function gtk_separator_get_type () as GType

#endif
