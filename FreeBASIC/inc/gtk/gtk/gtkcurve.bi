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
#include once "gtk/gtk/gtkdrawingarea.bi"

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

declare function gtk_curve_get_type cdecl alias "gtk_curve_get_type" () as GType
declare function gtk_curve_new cdecl alias "gtk_curve_new" () as GtkWidget ptr
declare sub gtk_curve_reset cdecl alias "gtk_curve_reset" (byval curve as GtkCurve ptr)
declare sub gtk_curve_set_gamma cdecl alias "gtk_curve_set_gamma" (byval curve as GtkCurve ptr, byval gamma_ as gfloat)
declare sub gtk_curve_set_range cdecl alias "gtk_curve_set_range" (byval curve as GtkCurve ptr, byval min_x as gfloat, byval max_x as gfloat, byval min_y as gfloat, byval max_y as gfloat)
declare sub gtk_curve_get_vector cdecl alias "gtk_curve_get_vector" (byval curve as GtkCurve ptr, byval veclen as integer, byval vector as gfloat ptr)
declare sub gtk_curve_set_vector cdecl alias "gtk_curve_set_vector" (byval curve as GtkCurve ptr, byval veclen as integer, byval vector as gfloat ptr)
declare sub gtk_curve_set_curve_type cdecl alias "gtk_curve_set_curve_type" (byval curve as GtkCurve ptr, byval type as GtkCurveType)

#endif
