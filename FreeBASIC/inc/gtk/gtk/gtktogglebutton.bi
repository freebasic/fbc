''
''
'' gtktogglebutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktogglebutton_bi__
#define __gtktogglebutton_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkbutton.bi"

type GtkToggleButton as _GtkToggleButton
type GtkToggleButtonClass as _GtkToggleButtonClass

type _GtkToggleButton
	button as GtkButton
	active as guint
	draw_indicator as guint
	inconsistent as guint
end type

type _GtkToggleButtonClass
	parent_class as GtkButtonClass
	toggled as sub cdecl(byval as GtkToggleButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_toggle_button_get_type cdecl alias "gtk_toggle_button_get_type" () as GType
declare function gtk_toggle_button_new cdecl alias "gtk_toggle_button_new" () as GtkWidget ptr
declare function gtk_toggle_button_new_with_label cdecl alias "gtk_toggle_button_new_with_label" (byval label as string) as GtkWidget ptr
declare function gtk_toggle_button_new_with_mnemonic cdecl alias "gtk_toggle_button_new_with_mnemonic" (byval label as string) as GtkWidget ptr
declare sub gtk_toggle_button_set_mode cdecl alias "gtk_toggle_button_set_mode" (byval toggle_button as GtkToggleButton ptr, byval draw_indicator as gboolean)
declare function gtk_toggle_button_get_mode cdecl alias "gtk_toggle_button_get_mode" (byval toggle_button as GtkToggleButton ptr) as gboolean
declare sub gtk_toggle_button_set_active cdecl alias "gtk_toggle_button_set_active" (byval toggle_button as GtkToggleButton ptr, byval is_active as gboolean)
declare function gtk_toggle_button_get_active cdecl alias "gtk_toggle_button_get_active" (byval toggle_button as GtkToggleButton ptr) as gboolean
declare sub gtk_toggle_button_toggled cdecl alias "gtk_toggle_button_toggled" (byval toggle_button as GtkToggleButton ptr)
declare sub gtk_toggle_button_set_inconsistent cdecl alias "gtk_toggle_button_set_inconsistent" (byval toggle_button as GtkToggleButton ptr, byval setting as gboolean)
declare function gtk_toggle_button_get_inconsistent cdecl alias "gtk_toggle_button_get_inconsistent" (byval toggle_button as GtkToggleButton ptr) as gboolean

#endif
