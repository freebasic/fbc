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
#include once "gtk/gtk/gtkscale.bi"

type GtkHScale as _GtkHScale
type GtkHScaleClass as _GtkHScaleClass

type _GtkHScale
	scale as GtkScale
end type

type _GtkHScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_hscale_get_type cdecl alias "gtk_hscale_get_type" () as GType
declare function gtk_hscale_new cdecl alias "gtk_hscale_new" (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_hscale_new_with_range cdecl alias "gtk_hscale_new_with_range" (byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#endif
