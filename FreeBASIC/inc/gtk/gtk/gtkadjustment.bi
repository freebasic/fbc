''
''
'' gtkadjustment -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkadjustment_bi__
#define __gtkadjustment_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkobject.bi"

type GtkAdjustment as _GtkAdjustment
type GtkAdjustmentClass as _GtkAdjustmentClass

type _GtkAdjustment
	parent_instance as GtkObject
	lower as gdouble
	upper as gdouble
	value as gdouble
	step_increment as gdouble
	page_increment as gdouble
	page_size as gdouble
end type

type _GtkAdjustmentClass
	parent_class as GtkObjectClass
	changed as sub cdecl(byval as GtkAdjustment ptr)
	value_changed as sub cdecl(byval as GtkAdjustment ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_adjustment_get_type cdecl alias "gtk_adjustment_get_type" () as GType
declare function gtk_adjustment_new cdecl alias "gtk_adjustment_new" (byval value as gdouble, byval lower as gdouble, byval upper as gdouble, byval step_increment as gdouble, byval page_increment as gdouble, byval page_size as gdouble) as GtkObject ptr
declare sub gtk_adjustment_changed cdecl alias "gtk_adjustment_changed" (byval adjustment as GtkAdjustment ptr)
declare sub gtk_adjustment_value_changed cdecl alias "gtk_adjustment_value_changed" (byval adjustment as GtkAdjustment ptr)
declare sub gtk_adjustment_clamp_page cdecl alias "gtk_adjustment_clamp_page" (byval adjustment as GtkAdjustment ptr, byval lower as gdouble, byval upper as gdouble)
declare function gtk_adjustment_get_value cdecl alias "gtk_adjustment_get_value" (byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_value cdecl alias "gtk_adjustment_set_value" (byval adjustment as GtkAdjustment ptr, byval value as gdouble)

#endif
