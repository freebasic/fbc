''
''
'' gtklistitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtklistitem_bi__
#define __gtklistitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkitem.bi"

#define GTK_TYPE_LIST_ITEM (gtk_list_item_get_type ())
#define GTK_LIST_ITEM(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_LIST_ITEM, GtkListItem))
#define GTK_LIST_ITEM_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_LIST_ITEM, GtkListItemClass))
#define GTK_IS_LIST_ITEM(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_LIST_ITEM))
#define GTK_IS_LIST_ITEM_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LIST_ITEM))
#define GTK_LIST_ITEM_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_LIST_ITEM, GtkListItemClass))

type GtkListItem as _GtkListItem
type GtkListItemClass as _GtkListItemClass

type _GtkListItem
	item as GtkItem
end type

type _GtkListItemClass
	parent_class as GtkItemClass
	toggle_focus_row as sub cdecl(byval as GtkListItem ptr)
	select_all as sub cdecl(byval as GtkListItem ptr)
	unselect_all as sub cdecl(byval as GtkListItem ptr)
	undo_selection as sub cdecl(byval as GtkListItem ptr)
	start_selection as sub cdecl(byval as GtkListItem ptr)
	end_selection as sub cdecl(byval as GtkListItem ptr)
	extend_selection as sub cdecl(byval as GtkListItem ptr, byval as GtkScrollType, byval as gfloat, byval as gboolean)
	scroll_horizontal as sub cdecl(byval as GtkListItem ptr, byval as GtkScrollType, byval as gfloat)
	scroll_vertical as sub cdecl(byval as GtkListItem ptr, byval as GtkScrollType, byval as gfloat)
	toggle_add_mode as sub cdecl(byval as GtkListItem ptr)
end type

declare function gtk_list_item_get_type () as GtkType
declare function gtk_list_item_new () as GtkWidget ptr
declare function gtk_list_item_new_with_label (byval label as zstring ptr) as GtkWidget ptr
declare sub gtk_list_item_select (byval list_item as GtkListItem ptr)
declare sub gtk_list_item_deselect (byval list_item as GtkListItem ptr)

#endif
