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
#include once "gtk/gtk/gtkscale.bi"

type GtkVScale as _GtkVScale
type GtkVScaleClass as _GtkVScaleClass

type _GtkVScale
	scale as GtkScale
end type

type _GtkVScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_vscale_get_type cdecl alias "gtk_vscale_get_type" () as GType
declare function gtk_vscale_new cdecl alias "gtk_vscale_new" (byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_vscale_new_with_range cdecl alias "gtk_vscale_new_with_range" (byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#endif
