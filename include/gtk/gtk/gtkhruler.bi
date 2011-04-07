''
''
'' gtkhruler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhruler_bi__
#define __gtkhruler_bi__

#include once "gtk/gdk.bi"
#include once "gtkruler.bi"

#define GTK_TYPE_HRULER (gtk_hruler_get_type ())
#define GTK_HRULER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HRULER, GtkHRuler))
#define GTK_HRULER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HRULER, GtkHRulerClass))
#define GTK_IS_HRULER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HRULER))
#define GTK_IS_HRULER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HRULER))
#define GTK_HRULER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HRULER, GtkHRulerClass))

type GtkHRuler as _GtkHRuler
type GtkHRulerClass as _GtkHRulerClass

type _GtkHRuler
	ruler as GtkRuler
end type

type _GtkHRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_hruler_get_type () as GType
declare function gtk_hruler_new () as GtkWidget ptr

#endif
