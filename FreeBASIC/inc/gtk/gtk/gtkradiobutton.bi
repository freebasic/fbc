''
''
'' gtkradiobutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkradiobutton_bi__
#define __gtkradiobutton_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcheckbutton.bi"

type GtkRadioButton as _GtkRadioButton
type GtkRadioButtonClass as _GtkRadioButtonClass

type _GtkRadioButton
	check_button as GtkCheckButton
	group as GSList ptr
end type

type _GtkRadioButtonClass
	parent_class as GtkCheckButtonClass
	group_changed as sub cdecl(byval as GtkRadioButton ptr)
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_radio_button_get_type cdecl alias "gtk_radio_button_get_type" () as GType
declare function gtk_radio_button_new cdecl alias "gtk_radio_button_new" (byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_button_new_from_widget cdecl alias "gtk_radio_button_new_from_widget" (byval group as GtkRadioButton ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label cdecl alias "gtk_radio_button_new_with_label" (byval group as GSList ptr, byval label as gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label_from_widget cdecl alias "gtk_radio_button_new_with_label_from_widget" (byval group as GtkRadioButton ptr, byval label as gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic cdecl alias "gtk_radio_button_new_with_mnemonic" (byval group as GSList ptr, byval label as gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic_from_widget cdecl alias "gtk_radio_button_new_with_mnemonic_from_widget" (byval group as GtkRadioButton ptr, byval label as gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_get_group cdecl alias "gtk_radio_button_get_group" (byval radio_button as GtkRadioButton ptr) as GSList ptr
declare sub gtk_radio_button_set_group cdecl alias "gtk_radio_button_set_group" (byval radio_button as GtkRadioButton ptr, byval group as GSList ptr)

#endif
