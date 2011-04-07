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
#include once "gtkcheckmenuitem.bi"

#define GTK_TYPE_RADIO_MENU_ITEM (gtk_radio_menu_item_get_type ())
#define GTK_RADIO_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItem))
#define GTK_RADIO_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass))
#define GTK_IS_RADIO_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_MENU_ITEM))
#define GTK_IS_RADIO_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_MENU_ITEM))
#define GTK_RADIO_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass))

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

declare function gtk_radio_menu_item_get_type () as GType
declare function gtk_radio_menu_item_new (byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label (byval group as GSList ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic (byval group as GSList ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_from_widget (byval group as GtkRadioMenuItem ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic_from_widget (byval group as GtkRadioMenuItem ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label_from_widget (byval group as GtkRadioMenuItem ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_get_group (byval radio_menu_item as GtkRadioMenuItem ptr) as GSList ptr
declare sub gtk_radio_menu_item_set_group (byval radio_menu_item as GtkRadioMenuItem ptr, byval group as GSList ptr)

#define gtk_radio_menu_item_group gtk_radio_menu_item_get_group

#endif
