''
''
'' gtkradiomenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkradiomenuitem_bi__
#define __gtkradiomenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcheckmenuitem.bi"

type GtkRadioMenuItem as _GtkRadioMenuItem
type GtkRadioMenuItemClass as _GtkRadioMenuItemClass

type _GtkRadioMenuItem
	check_menu_item as GtkCheckMenuItem
	group as GSList ptr
end type

type _GtkRadioMenuItemClass
	parent_class as GtkCheckMenuItemClass
	group_changed as sub cdecl(byval as GtkRadioMenuItem ptr)
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_radio_menu_item_get_type cdecl alias "gtk_radio_menu_item_get_type" () as GType
declare function gtk_radio_menu_item_new cdecl alias "gtk_radio_menu_item_new" (byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label cdecl alias "gtk_radio_menu_item_new_with_label" (byval group as GSList ptr, byval label as string) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic cdecl alias "gtk_radio_menu_item_new_with_mnemonic" (byval group as GSList ptr, byval label as string) as GtkWidget ptr
declare function gtk_radio_menu_item_new_from_widget cdecl alias "gtk_radio_menu_item_new_from_widget" (byval group as GtkRadioMenuItem ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic_from_widget cdecl alias "gtk_radio_menu_item_new_with_mnemonic_from_widget" (byval group as GtkRadioMenuItem ptr, byval label as string) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label_from_widget cdecl alias "gtk_radio_menu_item_new_with_label_from_widget" (byval group as GtkRadioMenuItem ptr, byval label as string) as GtkWidget ptr
declare function gtk_radio_menu_item_get_group cdecl alias "gtk_radio_menu_item_get_group" (byval radio_menu_item as GtkRadioMenuItem ptr) as GSList ptr
declare sub gtk_radio_menu_item_set_group cdecl alias "gtk_radio_menu_item_set_group" (byval radio_menu_item as GtkRadioMenuItem ptr, byval group as GSList ptr)

#endif
