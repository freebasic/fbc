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
#include once "gtk/gtk/gtkitem.bi"

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

declare function gtk_list_item_get_type cdecl alias "gtk_list_item_get_type" () as GtkType
declare function gtk_list_item_new cdecl alias "gtk_list_item_new" () as GtkWidget ptr
declare function gtk_list_item_new_with_label cdecl alias "gtk_list_item_new_with_label" (byval label as string) as GtkWidget ptr
declare sub gtk_list_item_select cdecl alias "gtk_list_item_select" (byval list_item as GtkListItem ptr)
declare sub gtk_list_item_deselect cdecl alias "gtk_list_item_deselect" (byval list_item as GtkListItem ptr)

#endif
