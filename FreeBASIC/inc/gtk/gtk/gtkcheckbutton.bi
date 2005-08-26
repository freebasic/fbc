''
''
'' gtkcheckbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcheckbutton_bi__
#define __gtkcheckbutton_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtktogglebutton.bi"

type GtkCheckButton as _GtkCheckButton
type GtkCheckButtonClass as _GtkCheckButtonClass

type _GtkCheckButton
	toggle_button as GtkToggleButton
end type

type _GtkCheckButtonClass
	parent_class as GtkToggleButtonClass
	draw_indicator as sub cdecl(byval as GtkCheckButton ptr, byval as GdkRectangle ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_check_button_get_type cdecl alias "gtk_check_button_get_type" () as GType
declare function gtk_check_button_new cdecl alias "gtk_check_button_new" () as GtkWidget ptr
declare function gtk_check_button_new_with_label cdecl alias "gtk_check_button_new_with_label" (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_check_button_new_with_mnemonic cdecl alias "gtk_check_button_new_with_mnemonic" (byval label as zstring ptr) as GtkWidget ptr
declare sub _gtk_check_button_get_props cdecl alias "_gtk_check_button_get_props" (byval check_button as GtkCheckButton ptr, byval indicator_size as gint ptr, byval indicator_spacing as gint ptr)

#endif
