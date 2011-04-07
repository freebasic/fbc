''
''
'' gtktreeitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreeitem_bi__
#define __gtktreeitem_bi__

#include once "gtk/gdk.bi"
#include once "gtkitem.bi"

#define GTK_TYPE_TREE_ITEM (gtk_tree_item_get_type ())
#define GTK_TREE_ITEM(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_TREE_ITEM, GtkTreeItem))
#define GTK_TREE_ITEM_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_ITEM, GtkTreeItemClass))
#define GTK_IS_TREE_ITEM(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_TREE_ITEM))
#define GTK_IS_TREE_ITEM_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_ITEM))
#define GTK_TREE_ITEM_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_TREE_ITEM, GtkTreeItemClass))

#define GTK_TREE_ITEM_SUBTREE(obj) (GTK_TREE_ITEM(obj)->subtree)

type GtkTreeItem as _GtkTreeItem
type GtkTreeItemClass as _GtkTreeItemClass

type _GtkTreeItem
	item as GtkItem
	subtree as GtkWidget ptr
	pixmaps_box as GtkWidget ptr
	plus_pix_widget as GtkWidget ptr
	minus_pix_widget as GtkWidget ptr
	pixmaps as GList ptr
	expanded as guint
end type

type _GtkTreeItemClass
	parent_class as GtkItemClass
	expand as sub cdecl(byval as GtkTreeItem ptr)
	collapse as sub cdecl(byval as GtkTreeItem ptr)
end type

declare function gtk_tree_item_get_type () as GtkType
declare function gtk_tree_item_new () as GtkWidget ptr
declare function gtk_tree_item_new_with_label (byval label as gchar ptr) as GtkWidget ptr
declare sub gtk_tree_item_set_subtree (byval tree_item as GtkTreeItem ptr, byval subtree as GtkWidget ptr)
declare sub gtk_tree_item_remove_subtree (byval tree_item as GtkTreeItem ptr)
declare sub gtk_tree_item_select (byval tree_item as GtkTreeItem ptr)
declare sub gtk_tree_item_deselect (byval tree_item as GtkTreeItem ptr)
declare sub gtk_tree_item_expand (byval tree_item as GtkTreeItem ptr)
declare sub gtk_tree_item_collapse (byval tree_item as GtkTreeItem ptr)

#endif
