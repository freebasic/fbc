''
''
'' gtkhseparator -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhseparator_bi__
#define __gtkhseparator_bi__

#include once "gtk/gdk.bi"
#include once "gtkseparator.bi"

#define GTK_TYPE_HSEPARATOR (gtk_hseparator_get_type ())
#define GTK_HSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSEPARATOR, GtkHSeparator))
#define GTK_HSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass))
#define GTK_IS_HSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSEPARATOR))
#define GTK_IS_HSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSEPARATOR))
#define GTK_HSEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass))

type GtkHSeparator as _GtkHSeparator
type GtkHSeparatorClass as _GtkHSeparatorClass

type _GtkHSeparator
	separator as GtkSeparator
end type

type _GtkHSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_hseparator_get_type () as GType
declare function gtk_hseparator_new () as GtkWidget ptr

#endif
