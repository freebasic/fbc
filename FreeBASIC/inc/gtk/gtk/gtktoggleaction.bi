''
''
'' gtktoggleaction -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktoggleaction_bi__
#define __gtktoggleaction_bi__

#include once "gtk/gtk/gtkaction.bi"

type GtkToggleAction as _GtkToggleAction
type GtkToggleActionPrivate as _GtkToggleActionPrivate
type GtkToggleActionClass as _GtkToggleActionClass

type _GtkToggleAction
	parent as GtkAction
	private_data as GtkToggleActionPrivate ptr
end type

type _GtkToggleActionClass
	parent_class as GtkActionClass
	toggled as sub cdecl(byval as GtkToggleAction ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_toggle_action_get_type cdecl alias "gtk_toggle_action_get_type" () as GType
declare function gtk_toggle_action_new cdecl alias "gtk_toggle_action_new" (byval name as zstring ptr, byval label as zstring ptr, byval tooltip as zstring ptr, byval stock_id as zstring ptr) as GtkToggleAction ptr
declare sub gtk_toggle_action_toggled cdecl alias "gtk_toggle_action_toggled" (byval action as GtkToggleAction ptr)
declare sub gtk_toggle_action_set_active cdecl alias "gtk_toggle_action_set_active" (byval action as GtkToggleAction ptr, byval is_active as gboolean)
declare function gtk_toggle_action_get_active cdecl alias "gtk_toggle_action_get_active" (byval action as GtkToggleAction ptr) as gboolean
declare sub gtk_toggle_action_set_draw_as_radio cdecl alias "gtk_toggle_action_set_draw_as_radio" (byval action as GtkToggleAction ptr, byval draw_as_radio as gboolean)
declare function gtk_toggle_action_get_draw_as_radio cdecl alias "gtk_toggle_action_get_draw_as_radio" (byval action as GtkToggleAction ptr) as gboolean

#endif
