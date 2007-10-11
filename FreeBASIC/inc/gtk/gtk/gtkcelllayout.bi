''
''
'' gtkcelllayout -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcelllayout_bi__
#define __gtkcelllayout_bi__

#include once "gtk/glib-object.bi"
#include once "gtkcellrenderer.bi"
#include once "gtktreeviewcolumn.bi"

#define GTK_TYPE_CELL_LAYOUT (gtk_cell_layout_get_type ())
#define GTK_CELL_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayout))
#define GTK_IS_CELL_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_LAYOUT))
#define GTK_CELL_LAYOUT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayoutIface))

type GtkCellLayout as _GtkCellLayout
type GtkCellLayoutIface as _GtkCellLayoutIface
type GtkCellLayoutDataFunc as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gpointer)

type _GtkCellLayoutIface
	g_iface as GTypeInterface
	pack_start as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gboolean)
	pack_end as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gboolean)
	clear as sub cdecl(byval as GtkCellLayout ptr)
	add_attribute as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as zstring ptr, byval as gint)
	set_cell_data_func as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as GtkCellLayoutDataFunc, byval as gpointer, byval as GDestroyNotify)
	clear_attributes as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr)
	reorder as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gint)
end type

declare function gtk_cell_layout_get_type () as GType
declare sub gtk_cell_layout_pack_start (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_cell_layout_pack_end (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_cell_layout_clear (byval cell_layout as GtkCellLayout ptr)
declare sub gtk_cell_layout_set_attributes (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, ...)
declare sub gtk_cell_layout_add_attribute (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval attribute as zstring ptr, byval column as gint)
declare sub gtk_cell_layout_set_cell_data_func (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval func as GtkCellLayoutDataFunc, byval func_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_cell_layout_clear_attributes (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr)
declare sub gtk_cell_layout_reorder (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval position as gint)

#endif
