''
''
'' gtkcurve -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcurve_bi__
#define __gtkcurve_bi__

#include once "gtk/gdk.bi"
#include once "gtkdrawingarea.bi"

#define GTK_TYPE_CURVE (gtk_curve_get_type ())
#define GTK_CURVE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CURVE, GtkCurve))
#define GTK_CURVE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CURVE, GtkCurveClass))
#define GTK_IS_CURVE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CURVE))
#define GTK_IS_CURVE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CURVE))
#define GTK_CURVE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CURVE, GtkCurveClass))

type GtkCurve as _GtkCurve
type GtkCurveClass as _GtkCurveClass

type _GtkCurve
	graph as GtkDrawingArea
	cursor_type as gint
	min_x as gfloat
	max_x as gfloat
	min_y as gfloat
	max_y as gfloat
	pixmap as GdkPixmap ptr
	curve_type as GtkCurveType
	height as gint
	grab_point as gint
	last as gint
	num_points as gint
	point as GdkPoint ptr
	num_ctlpoints as gint
	ctlpoint as gfloat ptr ptr
end type

type _GtkCurveClass
	parent_class as GtkDrawingAreaClass
	curve_type_changed as sub cdecl(byval as GtkCurve ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_curve_get_type () as GType
declare function gtk_curve_new () as GtkWidget ptr
declare sub gtk_curve_reset (byval curve as GtkCurve ptr)
declare sub gtk_curve_set_gamma (byval curve as GtkCurve ptr, byval gamma_ as gfloat)
declare sub gtk_curve_set_range (byval curve as GtkCurve ptr, byval min_x as gfloat, byval max_x as gfloat, byval min_y as gfloat, byval max_y as gfloat)
declare sub gtk_curve_get_vector (byval curve as GtkCurve ptr, byval veclen as integer, byval vector as gfloat ptr)
declare sub gtk_curve_set_vector (byval curve as GtkCurve ptr, byval veclen as integer, byval vector as gfloat ptr)
declare sub gtk_curve_set_curve_type (byval curve as GtkCurve ptr, byval type as GtkCurveType)

#endif
