''
''
'' gtkradioaction -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkradioaction_bi__
#define __gtkradioaction_bi__

#include once "gtk/gtk/gtktoggleaction.bi"

type GtkRadioAction as _GtkRadioAction
type GtkRadioActionPrivate as _GtkRadioActionPrivate
type GtkRadioActionClass as _GtkRadioActionClass

type _GtkRadioAction
	parent as GtkToggleAction
	private_data as GtkRadioActionPrivate ptr
end type

type _GtkRadioActionClass
	parent_class as GtkToggleActionClass
	changed as sub cdecl(byval as GtkRadioAction ptr, byval as GtkRadioAction ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_radio_action_get_type cdecl alias "gtk_radio_action_get_type" () as GType
declare function gtk_radio_action_new cdecl alias "gtk_radio_action_new" (byval name as string, byval label as string, byval tooltip as string, byval stock_id as string, byval value as gint) as GtkRadioAction ptr
declare function gtk_radio_action_get_group cdecl alias "gtk_radio_action_get_group" (byval action as GtkRadioAction ptr) as GSList ptr
declare sub gtk_radio_action_set_group cdecl alias "gtk_radio_action_set_group" (byval action as GtkRadioAction ptr, byval group as GSList ptr)
declare function gtk_radio_action_get_current_value cdecl alias "gtk_radio_action_get_current_value" (byval action as GtkRadioAction ptr) as gint

#endif
