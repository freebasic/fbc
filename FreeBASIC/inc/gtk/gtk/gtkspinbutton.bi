''
''
'' gtkspinbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkspinbutton_bi__
#define __gtkspinbutton_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkentry.bi"
#include once "gtk/gtk/gtkadjustment.bi"

#define GTK_INPUT_ERROR -1

enum GtkSpinButtonUpdatePolicy
	GTK_UPDATE_ALWAYS
	GTK_UPDATE_IF_VALID
end enum


enum GtkSpinType
	GTK_SPIN_STEP_FORWARD
	GTK_SPIN_STEP_BACKWARD
	GTK_SPIN_PAGE_FORWARD
	GTK_SPIN_PAGE_BACKWARD
	GTK_SPIN_HOME
	GTK_SPIN_END
	GTK_SPIN_USER_DEFINED
end enum

type GtkSpinButton as _GtkSpinButton
type GtkSpinButtonClass as _GtkSpinButtonClass

type _GtkSpinButton
	entry as GtkEntry
	adjustment as GtkAdjustment ptr
	panel as GdkWindow ptr
	timer as guint32
	climb_rate as gdouble
	timer_step as gdouble
	update_policy as GtkSpinButtonUpdatePolicy
	in_child as guint
	click_child as guint
	button as guint
	need_timer as guint
	timer_calls as guint
	digits as guint
	numeric as guint
	wrap as guint
	snap_to_ticks as guint
end type

type _GtkSpinButtonClass
	parent_class as GtkEntryClass
	input as function cdecl(byval as GtkSpinButton ptr, byval as gdouble ptr) as gint
	output as function cdecl(byval as GtkSpinButton ptr) as gint
	value_changed as sub cdecl(byval as GtkSpinButton ptr)
	change_value as sub cdecl(byval as GtkSpinButton ptr, byval as GtkScrollType)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_spin_button_get_type cdecl alias "gtk_spin_button_get_type" () as GType
declare sub gtk_spin_button_configure cdecl alias "gtk_spin_button_configure" (byval spin_button as GtkSpinButton ptr, byval adjustment as GtkAdjustment ptr, byval climb_rate as gdouble, byval digits as guint)
declare function gtk_spin_button_new cdecl alias "gtk_spin_button_new" (byval adjustment as GtkAdjustment ptr, byval climb_rate as gdouble, byval digits as guint) as GtkWidget ptr
declare function gtk_spin_button_new_with_range cdecl alias "gtk_spin_button_new_with_range" (byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr
declare sub gtk_spin_button_set_adjustment cdecl alias "gtk_spin_button_set_adjustment" (byval spin_button as GtkSpinButton ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_spin_button_get_adjustment cdecl alias "gtk_spin_button_get_adjustment" (byval spin_button as GtkSpinButton ptr) as GtkAdjustment ptr
declare sub gtk_spin_button_set_digits cdecl alias "gtk_spin_button_set_digits" (byval spin_button as GtkSpinButton ptr, byval digits as guint)
declare function gtk_spin_button_get_digits cdecl alias "gtk_spin_button_get_digits" (byval spin_button as GtkSpinButton ptr) as guint
declare sub gtk_spin_button_set_increments cdecl alias "gtk_spin_button_set_increments" (byval spin_button as GtkSpinButton ptr, byval step as gdouble, byval page as gdouble)
declare sub gtk_spin_button_get_increments cdecl alias "gtk_spin_button_get_increments" (byval spin_button as GtkSpinButton ptr, byval step as gdouble ptr, byval page as gdouble ptr)
declare sub gtk_spin_button_set_range cdecl alias "gtk_spin_button_set_range" (byval spin_button as GtkSpinButton ptr, byval min as gdouble, byval max as gdouble)
declare sub gtk_spin_button_get_range cdecl alias "gtk_spin_button_get_range" (byval spin_button as GtkSpinButton ptr, byval min as gdouble ptr, byval max as gdouble ptr)
declare function gtk_spin_button_get_value cdecl alias "gtk_spin_button_get_value" (byval spin_button as GtkSpinButton ptr) as gdouble
declare function gtk_spin_button_get_value_as_int cdecl alias "gtk_spin_button_get_value_as_int" (byval spin_button as GtkSpinButton ptr) as gint
declare sub gtk_spin_button_set_value cdecl alias "gtk_spin_button_set_value" (byval spin_button as GtkSpinButton ptr, byval value as gdouble)
declare sub gtk_spin_button_set_update_policy cdecl alias "gtk_spin_button_set_update_policy" (byval spin_button as GtkSpinButton ptr, byval policy as GtkSpinButtonUpdatePolicy)
declare function gtk_spin_button_get_update_policy cdecl alias "gtk_spin_button_get_update_policy" (byval spin_button as GtkSpinButton ptr) as GtkSpinButtonUpdatePolicy
declare sub gtk_spin_button_set_numeric cdecl alias "gtk_spin_button_set_numeric" (byval spin_button as GtkSpinButton ptr, byval numeric as gboolean)
declare function gtk_spin_button_get_numeric cdecl alias "gtk_spin_button_get_numeric" (byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_spin cdecl alias "gtk_spin_button_spin" (byval spin_button as GtkSpinButton ptr, byval direction as GtkSpinType, byval increment as gdouble)
declare sub gtk_spin_button_set_wrap cdecl alias "gtk_spin_button_set_wrap" (byval spin_button as GtkSpinButton ptr, byval wrap as gboolean)
declare function gtk_spin_button_get_wrap cdecl alias "gtk_spin_button_get_wrap" (byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_set_snap_to_ticks cdecl alias "gtk_spin_button_set_snap_to_ticks" (byval spin_button as GtkSpinButton ptr, byval snap_to_ticks as gboolean)
declare function gtk_spin_button_get_snap_to_ticks cdecl alias "gtk_spin_button_get_snap_to_ticks" (byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_update cdecl alias "gtk_spin_button_update" (byval spin_button as GtkSpinButton ptr)

#endif
