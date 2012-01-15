''
''
'' gtkimagemenuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkimagemenuitem_bi__
#define __gtkimagemenuitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkmenuitem.bi"

#define GTK_TYPE_IMAGE_MENU_ITEM (gtk_image_menu_item_get_type ())
#define GTK_IMAGE_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItem))
#define GTK_IMAGE_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass))
#define GTK_IS_IMAGE_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IMAGE_MENU_ITEM))
#define GTK_IS_IMAGE_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IMAGE_MENU_ITEM))
#define GTK_IMAGE_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass))

type GtkImageMenuItem as _GtkImageMenuItem
type GtkImageMenuItemClass as _GtkImageMenuItemClass

type _GtkImageMenuItem
	menu_item as GtkMenuItem
	image as GtkWidget ptr
end type

type _GtkImageMenuItemClass
	parent_class as GtkMenuItemClass
end type

declare function gtk_image_menu_item_get_type () as GType
declare function gtk_image_menu_item_new () as GtkWidget ptr
declare function gtk_image_menu_item_new_with_label (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_image_menu_item_new_with_mnemonic (byval label as zstring ptr) as GtkWidget ptr
declare function gtk_image_menu_item_new_from_stock (byval stock_id as zstring ptr, byval accel_group as GtkAccelGroup ptr) as GtkWidget ptr
declare sub gtk_image_menu_item_set_image (byval image_menu_item as GtkImageMenuItem ptr, byval image as GtkWidget ptr)
declare function gtk_image_menu_item_get_image (byval image_menu_item as GtkImageMenuItem ptr) as GtkWidget ptr

#endif
