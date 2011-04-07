''
''
'' gtkcheckmenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcheckmenuitem_bi__
#define __gtkcheckmenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkmenuitem.bi"

#define GTK_TYPE_CHECK_MENU_ITEM (gtk_check_menu_item_get_type ())
#define GTK_CHECK_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItem))
#define GTK_CHECK_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass))
#define GTK_IS_CHECK_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CHECK_MENU_ITEM))
#define GTK_IS_CHECK_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CHECK_MENU_ITEM))
#define GTK_CHECK_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass))

type GtkCheckMenuItem as _GtkCheckMenuItem
type GtkCheckMenuItemClass as _GtkCheckMenuItemClass

type _GtkCheckMenuItem
	menu_item as GtkMenuItem
	active:1 as guint
	always_show_toggle:1 as guint
	inconsistent:1 as guint
	draw_as_radio:1 as guint
end type

type _GtkCheckMenuItemClass
	parent_class as GtkMenuItemClass
	toggled as sub cdecl(byval as GtkCheckMenuItem ptr)
	draw_indicator as sub cdecl(byval as GtkCheckMenuItem ptr, byval as GdkRectangle ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_check_menu_item_get_type () as GType
declare function gtk_check_menu_item_new () as GtkWidget ptr
declare function gtk_check_menu_item_new_with_label (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_check_menu_item_new_with_mnemonic (byval label as zstring ptr) as GtkWidget ptr
declare sub gtk_check_menu_item_set_active (byval check_menu_item as GtkCheckMenuItem ptr, byval is_active as gboolean)
declare function gtk_check_menu_item_get_active (byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_toggled (byval check_menu_item as GtkCheckMenuItem ptr)
declare sub gtk_check_menu_item_set_inconsistent (byval check_menu_item as GtkCheckMenuItem ptr, byval setting as gboolean)
declare function gtk_check_menu_item_get_inconsistent (byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_set_draw_as_radio (byval check_menu_item as GtkCheckMenuItem ptr, byval draw_as_radio as gboolean)
declare function gtk_check_menu_item_get_draw_as_radio (byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_set_show_toggle (byval menu_item as GtkCheckMenuItem ptr, byval always as gboolean)

#define	gtk_check_menu_item_set_state gtk_check_menu_item_set_active

#endif
