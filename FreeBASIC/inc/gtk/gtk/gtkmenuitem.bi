''
''
'' gtkmenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmenuitem_bi__
#define __gtkmenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkitem.bi"

#define	GTK_TYPE_MENU_ITEM		gtk_menu_item_get_type()
#define GTK_MENU_ITEM(obj)		G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_MENU_ITEM, GtkMenuItem)
#define GTK_MENU_ITEM_CLASS(klass)	G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_MENU_ITEM, GtkMenuItemClass)
#define GTK_IS_MENU_ITEM(obj)		G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_MENU_ITEM)
#define GTK_IS_MENU_ITEM_CLASS(klass)	G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_MENU_ITEM)
#define GTK_MENU_ITEM_GET_CLASS(obj)    G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_MENU_ITEM, GtkMenuItemClass)

type GtkMenuItem as _GtkMenuItem
type GtkMenuItemClass as _GtkMenuItemClass

type _GtkMenuItem
	item as GtkItem
	submenu as GtkWidget ptr
	event_window as GdkWindow ptr
	toggle_size as guint16
	accelerator_width as guint16
	accel_path as zstring ptr
	show_submenu_indicator:1 as guint
	submenu_placement:1 as guint
	submenu_direction:1 as guint
	right_justify:1 as guint
	timer_from_keypress:1 as guint
	timer as guint
end type

type _GtkMenuItemClass
	parent_class as GtkItemClass
	hide_on_activate as guint
	activate as sub cdecl(byval as GtkMenuItem ptr)
	activate_item as sub cdecl(byval as GtkMenuItem ptr)
	toggle_size_request as sub cdecl(byval as GtkMenuItem ptr, byval as gint ptr)
	toggle_size_allocate as sub cdecl(byval as GtkMenuItem ptr, byval as gint)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_menu_item_get_type () as GType
declare function gtk_menu_item_new () as GtkWidget ptr
declare function gtk_menu_item_new_with_label (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_menu_item_new_with_mnemonic (byval label as zstring ptr) as GtkWidget ptr
declare sub gtk_menu_item_set_submenu (byval menu_item as GtkMenuItem ptr, byval submenu as GtkWidget ptr)
declare function gtk_menu_item_get_submenu (byval menu_item as GtkMenuItem ptr) as GtkWidget ptr
declare sub gtk_menu_item_remove_submenu (byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_select (byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_deselect (byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_activate (byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_toggle_size_request (byval menu_item as GtkMenuItem ptr, byval requisition as gint ptr)
declare sub gtk_menu_item_toggle_size_allocate (byval menu_item as GtkMenuItem ptr, byval allocation as gint)
declare sub gtk_menu_item_set_right_justified (byval menu_item as GtkMenuItem ptr, byval right_justified as gboolean)
declare function gtk_menu_item_get_right_justified (byval menu_item as GtkMenuItem ptr) as gboolean
declare sub gtk_menu_item_set_accel_path (byval menu_item as GtkMenuItem ptr, byval accel_path as zstring ptr)
declare sub _gtk_menu_item_refresh_accel_path (byval menu_item as GtkMenuItem ptr, byval prefix as zstring ptr, byval accel_group as GtkAccelGroup ptr, byval group_changed as gboolean)
declare function _gtk_menu_item_is_selectable (byval menu_item as GtkWidget ptr) as gboolean
declare sub _gtk_menu_item_popup_submenu (byval menu_item as GtkWidget ptr)

#define gtk_menu_item_right_justify(menu_item) gtk_menu_item_set_right_justified(menu_item, TRUE)

#endif
