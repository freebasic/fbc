''
''
'' gtkhscale -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhscale_bi__
#define __gtkhscale_bi__

#include once "gtk/gdk.bi"
#include once "gtkscale.bi"

#define GTK_TYPE_HSCALE (gtk_hscale_get_type ())
#define GTK_HSCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSCALE, GtkHScale))
#define GTK_HSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSCALE, GtkHScaleClass))
#define GTK_IS_HSCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSCALE))
#define GTK_IS_HSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSCALE))
#define GTK_HSCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSCALE, GtkHScaleClass))

type GtkHScale as _GtkHScale
type GtkHScaleClass as _GtkHScaleClass

type _GtkHScale
	scale as GtkScale
end type

type _GtkHScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_hscale_get_type () as GType
declare function gtk_hscale_new (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_hscale_new_with_range (byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#endif
