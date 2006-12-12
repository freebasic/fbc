''
''
'' gtktree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktree_bi__
#define __gtktree_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define GTK_TYPE_TREE (gtk_tree_get_type ())
#define GTK_TREE(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_TREE, GtkTree))
#define GTK_TREE_CLASS(klass)(GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE, GtkTreeClass))
#define GTK_IS_TREE(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_TREE))
#define GTK_IS_TREE_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE))
#define GTK_TREE_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_TREE, GtkTreeClass))

#define GTK_IS_ROOT_TREE(obj) cast(GtkObject ptr, GTK_TREE(obj)->root_tree = cast(GtkObject ptr,obj))
#define GTK_TREE_ROOT_TREE(obj) iif(GTK_TREE(obj)->root_tree, GTK_TREE(obj)->root_tree, GTK_TREE(obj))
#define GTK_TREE_SELECTION_OLD(obj) (GTK_TREE_ROOT_TREE(obj)->selection)

enum GtkTreeViewMode
	GTK_TREE_VIEW_LINE
	GTK_TREE_VIEW_ITEM
end enum

type GtkTree as _GtkTree
type GtkTreeClass as _GtkTreeClass

type _GtkTree
	container as GtkContainer
	children as GList ptr
	root_tree as GtkTree ptr
	tree_owner as GtkWidget ptr
	selection as GList ptr
	level as guint
	indent_value as guint
	current_indent as guint
	selection_mode:2 as guint
	view_mode:1 as guint
	view_line:1 as guint
end type

type _GtkTreeClass
	parent_class as GtkContainerClass
	selection_changed as sub cdecl(byval as GtkTree ptr)
	select_child as sub cdecl(byval as GtkTree ptr, byval as GtkWidget ptr)
	unselect_child as sub cdecl(byval as GtkTree ptr, byval as GtkWidget ptr)
end type

declare function gtk_tree_get_type () as GtkType
declare function gtk_tree_new () as GtkWidget ptr
declare sub gtk_tree_append (byval tree as GtkTree ptr, byval tree_item as GtkWidget ptr)
declare sub gtk_tree_prepend (byval tree as GtkTree ptr, byval tree_item as GtkWidget ptr)
declare sub gtk_tree_insert (byval tree as GtkTree ptr, byval tree_item as GtkWidget ptr, byval position as gint)
declare sub gtk_tree_remove_items (byval tree as GtkTree ptr, byval items as GList ptr)
declare sub gtk_tree_clear_items (byval tree as GtkTree ptr, byval start as gint, byval end as gint)
declare sub gtk_tree_select_item (byval tree as GtkTree ptr, byval item as gint)
declare sub gtk_tree_unselect_item (byval tree as GtkTree ptr, byval item as gint)
declare sub gtk_tree_select_child (byval tree as GtkTree ptr, byval tree_item as GtkWidget ptr)
declare sub gtk_tree_unselect_child (byval tree as GtkTree ptr, byval tree_item as GtkWidget ptr)
declare function gtk_tree_child_position (byval tree as GtkTree ptr, byval child as GtkWidget ptr) as gint
declare sub gtk_tree_set_selection_mode (byval tree as GtkTree ptr, byval mode as GtkSelectionMode)
declare sub gtk_tree_set_view_mode (byval tree as GtkTree ptr, byval mode as GtkTreeViewMode)
declare sub gtk_tree_set_view_lines (byval tree as GtkTree ptr, byval flag as gboolean)
declare sub gtk_tree_remove_item (byval tree as GtkTree ptr, byval child as GtkWidget ptr)

#endif
