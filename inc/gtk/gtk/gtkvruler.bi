''
''
'' gtkvruler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvruler_bi__
#define __gtkvruler_bi__

#include once "gtk/gdk.bi"
#include once "gtkruler.bi"

#define GTK_TYPE_VRULER (gtk_vruler_get_type ())
#define GTK_VRULER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VRULER, GtkVRuler))
#define GTK_VRULER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VRULER, GtkVRulerClass))
#define GTK_IS_VRULER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VRULER))
#define GTK_IS_VRULER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VRULER))
#define GTK_VRULER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VRULER, GtkVRulerClass))

type GtkVRuler as _GtkVRuler
type GtkVRulerClass as _GtkVRulerClass

type _GtkVRuler
	ruler as GtkRuler
end type

type _GtkVRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_vruler_get_type () as GType
declare function gtk_vruler_new () as GtkWidget ptr

#endif
