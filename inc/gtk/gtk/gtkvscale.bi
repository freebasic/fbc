''
''
'' gtkvscale -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvscale_bi__
#define __gtkvscale_bi__

#include once "gtk/gdk.bi"
#include once "gtkscale.bi"

#define GTK_TYPE_VSCALE (gtk_vscale_get_type ())
#define GTK_VSCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSCALE, GtkVScale))
#define GTK_VSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSCALE, GtkVScaleClass))
#define GTK_IS_VSCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSCALE))
#define GTK_IS_VSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSCALE))
#define GTK_VSCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSCALE, GtkVScaleClass))

type GtkVScale as _GtkVScale
type GtkVScaleClass as _GtkVScaleClass

type _GtkVScale
	scale as GtkScale
end type

type _GtkVScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_vscale_get_type () as GType
declare function gtk_vscale_new (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_vscale_new_with_range (byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#endif
