''
''
'' gtkrange -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkrange_bi__
#define __gtkrange_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkadjustment.bi"
#include once "gtk/gtk/gtkwidget.bi"

type GtkRangeLayout as _GtkRangeLayout
type GtkRangeStepTimer as _GtkRangeStepTimer
type GtkRange as _GtkRange
type GtkRangeClass as _GtkRangeClass

type _GtkRange
	widget as GtkWidget
	adjustment as GtkAdjustment ptr
	update_policy as GtkUpdateType
	inverted as guint
	flippable as guint
	has_stepper_a as guint
	has_stepper_b as guint
	has_stepper_c as guint
	has_stepper_d as guint
	need_recalc as guint
	slider_size_fixed as guint
	min_slider_size as gint
	orientation as GtkOrientation
	range_rect as GdkRectangle
	slider_start as gint
	slider_end as gint
	round_digits as gint
	trough_click_forward as guint
	update_pending as guint
	layout as GtkRangeLayout ptr
	timer as GtkRangeStepTimer ptr
	slide_initial_slider_position as gint
	slide_initial_coordinate as gint
	update_timeout_id as guint
	event_window as GdkWindow ptr
end type

type _GtkRangeClass
	parent_class as GtkWidgetClass
	slider_detail as gchar ptr
	stepper_detail as gchar ptr
	value_changed as sub cdecl(byval as GtkRange ptr)
	adjust_bounds as sub cdecl(byval as GtkRange ptr, byval as gdouble)
	move_slider as sub cdecl(byval as GtkRange ptr, byval as GtkScrollType)
	get_range_border as sub cdecl(byval as GtkRange ptr, byval as GtkBorder ptr)
	change_value as function cdecl(byval as GtkRange ptr, byval as GtkScrollType, byval as gdouble) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_range_get_type cdecl alias "gtk_range_get_type" () as GType
declare sub gtk_range_set_update_policy cdecl alias "gtk_range_set_update_policy" (byval range as GtkRange ptr, byval policy as GtkUpdateType)
declare function gtk_range_get_update_policy cdecl alias "gtk_range_get_update_policy" (byval range as GtkRange ptr) as GtkUpdateType
declare sub gtk_range_set_adjustment cdecl alias "gtk_range_set_adjustment" (byval range as GtkRange ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_range_get_adjustment cdecl alias "gtk_range_get_adjustment" (byval range as GtkRange ptr) as GtkAdjustment ptr
declare sub gtk_range_set_inverted cdecl alias "gtk_range_set_inverted" (byval range as GtkRange ptr, byval setting as gboolean)
declare function gtk_range_get_inverted cdecl alias "gtk_range_get_inverted" (byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_increments cdecl alias "gtk_range_set_increments" (byval range as GtkRange ptr, byval step as gdouble, byval page as gdouble)
declare sub gtk_range_set_range cdecl alias "gtk_range_set_range" (byval range as GtkRange ptr, byval min as gdouble, byval max as gdouble)
declare sub gtk_range_set_value cdecl alias "gtk_range_set_value" (byval range as GtkRange ptr, byval value as gdouble)
declare function gtk_range_get_value cdecl alias "gtk_range_get_value" (byval range as GtkRange ptr) as gdouble
declare function _gtk_range_get_wheel_delta cdecl alias "_gtk_range_get_wheel_delta" (byval range as GtkRange ptr, byval direction as GdkScrollDirection) as gdouble

#endif
