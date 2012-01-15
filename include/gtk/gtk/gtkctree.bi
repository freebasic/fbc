''
''
'' gtkctree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkctree_bi__
#define __gtkctree_bi__

#include once "gtkclist.bi"

#define GTK_TYPE_CTREE (gtk_ctree_get_type ())
#define GTK_CTREE(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_CTREE, GtkCTree))
#define GTK_CTREE_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_CTREE, GtkCTreeClass))
#define GTK_IS_CTREE(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_CTREE))
#define GTK_IS_CTREE_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CTREE))
#define GTK_CTREE_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_CTREE, GtkCTreeClass))

#define GTK_CTREE_ROW(_node_) cast(GtkCTreeRow ptr,cast(GList ptr,_node_)->data)
#define GTK_CTREE_NODE(_node_) cast(GtkCTreeNode ptr,_node_)
#define GTK_CTREE_NODE_NEXT(_nnode_) cast(GtkCTreeNode ptr,cast(GList ptr,_nnode_)->next)
#define GTK_CTREE_NODE_PREV(_pnode_) cast(GtkCTreeNode ptr,cast(GList ptr,_pnode_)->prev)
#define GTK_CTREE_FUNC(_func_) cast(GtkCTreeFunc,_func_)

#define GTK_TYPE_CTREE_NODE (gtk_ctree_node_get_type ())

enum GtkCTreePos
	GTK_CTREE_POS_BEFORE
	GTK_CTREE_POS_AS_CHILD
	GTK_CTREE_POS_AFTER
end enum


enum GtkCTreeLineStyle
	GTK_CTREE_LINES_NONE
	GTK_CTREE_LINES_SOLID
	GTK_CTREE_LINES_DOTTED
	GTK_CTREE_LINES_TABBED
end enum


enum GtkCTreeExpanderStyle
	GTK_CTREE_EXPANDER_NONE
	GTK_CTREE_EXPANDER_SQUARE
	GTK_CTREE_EXPANDER_TRIANGLE
	GTK_CTREE_EXPANDER_CIRCULAR
end enum


enum GtkCTreeExpansionType
	GTK_CTREE_EXPANSION_EXPAND
	GTK_CTREE_EXPANSION_EXPAND_RECURSIVE
	GTK_CTREE_EXPANSION_COLLAPSE
	GTK_CTREE_EXPANSION_COLLAPSE_RECURSIVE
	GTK_CTREE_EXPANSION_TOGGLE
	GTK_CTREE_EXPANSION_TOGGLE_RECURSIVE
end enum

type GtkCTree as _GtkCTree
type GtkCTreeClass as _GtkCTreeClass
type GtkCTreeRow as _GtkCTreeRow
type GtkCTreeNode as _GtkCTreeNode
type GtkCTreeFunc as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr, byval as gpointer)
type GtkCTreeGNodeFunc as function cdecl(byval as GtkCTree ptr, byval as guint, byval as GNode ptr, byval as GtkCTreeNode ptr, byval as gpointer) as gboolean
type GtkCTreeCompareDragFunc as function cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr, byval as GtkCTreeNode ptr, byval as GtkCTreeNode ptr) as gboolean

type _GtkCTree
	clist as GtkCList
	lines_gc as GdkGC ptr
	tree_indent as gint
	tree_spacing as gint
	tree_column as gint
	line_style:2 as guint
	expander_style:2 as guint
	show_stub:1 as guint
	drag_compare as GtkCTreeCompareDragFunc
end type

type _GtkCTreeClass
	parent_class as GtkCListClass
	tree_select_row as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr, byval as gint)
	tree_unselect_row as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr, byval as gint)
	tree_expand as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr)
	tree_collapse as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr)
	tree_move as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeNode ptr, byval as GtkCTreeNode ptr, byval as GtkCTreeNode ptr)
	change_focus_row_expansion as sub cdecl(byval as GtkCTree ptr, byval as GtkCTreeExpansionType)
end type

type _GtkCTreeRow
	row as GtkCListRow
	parent as GtkCTreeNode ptr
	sibling as GtkCTreeNode ptr
	children as GtkCTreeNode ptr
	pixmap_closed as GdkPixmap ptr
	mask_closed as GdkBitmap ptr
	pixmap_opened as GdkPixmap ptr
	mask_opened as GdkBitmap ptr
	level as guint16
	is_leaf:1 as guint
	expanded:1 as guint
end type

type _GtkCTreeNode
	list as GList
end type

declare function gtk_ctree_get_type () as GtkType
declare function gtk_ctree_new_with_titles (byval columns as gint, byval tree_column as gint, byval titles as zstring ptr ptr) as GtkWidget ptr
declare function gtk_ctree_new (byval columns as gint, byval tree_column as gint) as GtkWidget ptr
declare function gtk_ctree_insert_node (byval ctree as GtkCTree ptr, byval parent as GtkCTreeNode ptr, byval sibling as GtkCTreeNode ptr, byval text as zstring ptr ptr, byval spacing as guint8, byval pixmap_closed as GdkPixmap ptr, byval mask_closed as GdkBitmap ptr, byval pixmap_opened as GdkPixmap ptr, byval mask_opened as GdkBitmap ptr, byval is_leaf as gboolean, byval expanded as gboolean) as GtkCTreeNode ptr
declare sub gtk_ctree_remove_node (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare function gtk_ctree_insert_gnode (byval ctree as GtkCTree ptr, byval parent as GtkCTreeNode ptr, byval sibling as GtkCTreeNode ptr, byval gnode as GNode ptr, byval func as GtkCTreeGNodeFunc, byval data as gpointer) as GtkCTreeNode ptr
declare function gtk_ctree_export_to_gnode (byval ctree as GtkCTree ptr, byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeGNodeFunc, byval data as gpointer) as GNode ptr
declare sub gtk_ctree_post_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_post_recursive_to_depth (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_pre_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_pre_recursive_to_depth (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint, byval func as GtkCTreeFunc, byval data as gpointer)
declare function gtk_ctree_is_viewable (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_last (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkCTreeNode ptr
declare function gtk_ctree_find_node_ptr (byval ctree as GtkCTree ptr, byval ctree_row as GtkCTreeRow ptr) as GtkCTreeNode ptr
declare function gtk_ctree_node_nth (byval ctree as GtkCTree ptr, byval row as guint) as GtkCTreeNode ptr
declare function gtk_ctree_find (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval child as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_is_ancestor (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval child as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_find_by_row_data (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer) as GtkCTreeNode ptr
declare function gtk_ctree_find_all_by_row_data (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer) as GList ptr
declare function gtk_ctree_find_by_row_data_custom (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval func as GCompareFunc) as GtkCTreeNode ptr
declare function gtk_ctree_find_all_by_row_data_custom (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval func as GCompareFunc) as GList ptr
declare function gtk_ctree_is_hot_spot (byval ctree as GtkCTree ptr, byval x as gint, byval y as gint) as gboolean
declare sub gtk_ctree_move (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval new_parent as GtkCTreeNode ptr, byval new_sibling as GtkCTreeNode ptr)
declare sub gtk_ctree_expand (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_expand_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_expand_to_depth (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint)
declare sub gtk_ctree_collapse (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_collapse_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_collapse_to_depth (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint)
declare sub gtk_ctree_toggle_expansion (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_toggle_expansion_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_select (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_select_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_unselect (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_unselect_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_real_select_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval state as gint)
declare sub gtk_ctree_node_set_text (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as zstring ptr)
declare sub gtk_ctree_node_set_pixmap (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_ctree_node_set_pixtext (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as zstring ptr, byval spacing as guint8, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_ctree_set_node_info (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval text as zstring ptr, byval spacing as guint8, byval pixmap_closed as GdkPixmap ptr, byval mask_closed as GdkBitmap ptr, byval pixmap_opened as GdkPixmap ptr, byval mask_opened as GdkBitmap ptr, byval is_leaf as gboolean, byval expanded as gboolean)
declare sub gtk_ctree_node_set_shift (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval vertical as gint, byval horizontal as gint)
declare sub gtk_ctree_node_set_selectable (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval selectable as gboolean)
declare function gtk_ctree_node_get_selectable (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_node_get_cell_type (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint) as GtkCellType
declare function gtk_ctree_node_get_text (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as zstring ptr ptr) as gboolean
declare function gtk_ctree_node_get_pixmap (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gboolean
declare function gtk_ctree_node_get_pixtext (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as zstring ptr ptr, byval spacing as guint8 ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gboolean
declare function gtk_ctree_get_node_info (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval text as zstring ptr ptr, byval spacing as guint8 ptr, byval pixmap_closed as GdkPixmap ptr ptr, byval mask_closed as GdkBitmap ptr ptr, byval pixmap_opened as GdkPixmap ptr ptr, byval mask_opened as GdkBitmap ptr ptr, byval is_leaf as gboolean ptr, byval expanded as gboolean ptr) as gboolean
declare sub gtk_ctree_node_set_row_style (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval style as GtkStyle ptr)
declare function gtk_ctree_node_get_row_style (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkStyle ptr
declare sub gtk_ctree_node_set_cell_style (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval style as GtkStyle ptr)
declare function gtk_ctree_node_get_cell_style (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint) as GtkStyle ptr
declare sub gtk_ctree_node_set_foreground (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval color as GdkColor ptr)
declare sub gtk_ctree_node_set_background (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval color as GdkColor ptr)
declare sub gtk_ctree_node_set_row_data (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer)
declare sub gtk_ctree_node_set_row_data_full (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare function gtk_ctree_node_get_row_data (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gpointer
declare sub gtk_ctree_node_moveto (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval row_align as gfloat, byval col_align as gfloat)
declare function gtk_ctree_node_is_visible (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkVisibility
declare sub gtk_ctree_set_indent (byval ctree as GtkCTree ptr, byval indent as gint)
declare sub gtk_ctree_set_spacing (byval ctree as GtkCTree ptr, byval spacing as gint)
declare sub gtk_ctree_set_show_stub (byval ctree as GtkCTree ptr, byval show_stub as gboolean)
declare sub gtk_ctree_set_line_style (byval ctree as GtkCTree ptr, byval line_style as GtkCTreeLineStyle)
declare sub gtk_ctree_set_expander_style (byval ctree as GtkCTree ptr, byval expander_style as GtkCTreeExpanderStyle)
declare sub gtk_ctree_set_drag_compare_func (byval ctree as GtkCTree ptr, byval cmp_func as GtkCTreeCompareDragFunc)
declare sub gtk_ctree_sort_node (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_sort_recursive (byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare function gtk_ctree_node_get_type () as GType

#endif
