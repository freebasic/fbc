''
''
'' gtkruler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkruler_bi__
#define __gtkruler_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkwidget.bi"

type GtkRuler as _GtkRuler
type GtkRulerClass as _GtkRulerClass
type GtkRulerMetric as _GtkRulerMetric

type _GtkRuler
	widget as GtkWidget
	backing_store as GdkPixmap ptr
	non_gr_exp_gc as GdkGC ptr
	metric as GtkRulerMetric ptr
	xsrc as gint
	ysrc as gint
	slider_size as gint
	lower as gdouble
	upper as gdouble
	position as gdouble
	max_size as gdouble
end type

type _GtkRulerClass
	parent_class as GtkWidgetClass
	draw_ticks as sub cdecl(byval as GtkRuler ptr)
	draw_pos as sub cdecl(byval as GtkRuler ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkRulerMetric
	metric_name as gchar ptr
	abbrev as gchar ptr
	pixels_per_unit as gdouble
	ruler_scale(0 to 10-1) as gdouble ptr
	subdivide(0 to 5-1) as gint ptr
end type

declare function gtk_ruler_get_type cdecl alias "gtk_ruler_get_type" () as GType
declare sub gtk_ruler_set_metric cdecl alias "gtk_ruler_set_metric" (byval ruler as GtkRuler ptr, byval metric as GtkMetricType)
declare sub gtk_ruler_set_range cdecl alias "gtk_ruler_set_range" (byval ruler as GtkRuler ptr, byval lower as gdouble, byval upper as gdouble, byval position as gdouble, byval max_size as gdouble)
declare sub gtk_ruler_draw_ticks cdecl alias "gtk_ruler_draw_ticks" (byval ruler as GtkRuler ptr)
declare sub gtk_ruler_draw_pos cdecl alias "gtk_ruler_draw_pos" (byval ruler as GtkRuler ptr)
declare function gtk_ruler_get_metric cdecl alias "gtk_ruler_get_metric" (byval ruler as GtkRuler ptr) as GtkMetricType
declare sub gtk_ruler_get_range cdecl alias "gtk_ruler_get_range" (byval ruler as GtkRuler ptr, byval lower as gdouble ptr, byval upper as gdouble ptr, byval position as gdouble ptr, byval max_size as gdouble ptr)

#endif
