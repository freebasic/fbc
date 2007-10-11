''
''
'' gtktreednd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktreednd_bi__
#define __gtktreednd_bi__

#include once "gtktreemodel.bi"
#include once "gtkdnd.bi"

#define GTK_TYPE_TREE_DRAG_SOURCE (gtk_tree_drag_source_get_type ())
#define GTK_TREE_DRAG_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSource))
#define GTK_IS_TREE_DRAG_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_DRAG_SOURCE))
#define GTK_TREE_DRAG_SOURCE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSourceIface))

#define GTK_TYPE_TREE_DRAG_DEST (gtk_tree_drag_dest_get_type ())
#define GTK_TREE_DRAG_DEST(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDest))
#define GTK_IS_TREE_DRAG_DEST(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_DRAG_DEST))
#define GTK_TREE_DRAG_DEST_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDestIface))

type GtkTreeDragSource as _GtkTreeDragSource
type GtkTreeDragSourceIface as _GtkTreeDragSourceIface

type _GtkTreeDragSourceIface
	g_iface as GTypeInterface
	row_draggable as function cdecl(byval as GtkTreeDragSource ptr, byval as GtkTreePath ptr) as gboolean
	drag_data_get as function cdecl(byval as GtkTreeDragSource ptr, byval as GtkTreePath ptr, byval as GtkSelectionData ptr) as gboolean
	drag_data_delete as function cdecl(byval as GtkTreeDragSource ptr, byval as GtkTreePath ptr) as gboolean
end type

declare function gtk_tree_drag_source_get_type () as GType
declare function gtk_tree_drag_source_row_draggable (byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_drag_source_drag_data_delete (byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_drag_source_drag_data_get (byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean

type GtkTreeDragDest as _GtkTreeDragDest
type GtkTreeDragDestIface as _GtkTreeDragDestIface

type _GtkTreeDragDestIface
	g_iface as GTypeInterface
	drag_data_received as function cdecl(byval as GtkTreeDragDest ptr, byval as GtkTreePath ptr, byval as GtkSelectionData ptr) as gboolean
	row_drop_possible as function cdecl(byval as GtkTreeDragDest ptr, byval as GtkTreePath ptr, byval as GtkSelectionData ptr) as gboolean
end type

declare function gtk_tree_drag_dest_get_type () as GType
declare function gtk_tree_drag_dest_drag_data_received (byval drag_dest as GtkTreeDragDest ptr, byval dest as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_tree_drag_dest_row_drop_possible (byval drag_dest as GtkTreeDragDest ptr, byval dest_path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_tree_set_row_drag_data (byval selection_data as GtkSelectionData ptr, byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_get_row_drag_data (byval selection_data as GtkSelectionData ptr, byval tree_model as GtkTreeModel ptr ptr, byval path as GtkTreePath ptr ptr) as gboolean

#endif
