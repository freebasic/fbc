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
#include once "gtk/gtk/gtkcellrenderer.bi"
#include once "gtk/gtk/gtktreeviewcolumn.bi"

type GtkCellLayout as _GtkCellLayout
type GtkCellLayoutIface as _GtkCellLayoutIface
type GtkCellLayoutDataFunc as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as GtkTreeModel ptr, byval as GtkTreeIter ptr, byval as gpointer)

type _GtkCellLayoutIface
	g_iface as GTypeInterface
	pack_start as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gboolean)
	pack_end as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gboolean)
	clear as sub cdecl(byval as GtkCellLayout ptr)
	add_attribute as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as string, byval as gint)
	set_cell_data_func as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as GtkCellLayoutDataFunc, byval as gpointer, byval as GDestroyNotify)
	clear_attributes as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr)
	reorder as sub cdecl(byval as GtkCellLayout ptr, byval as GtkCellRenderer ptr, byval as gint)
end type

declare function gtk_cell_layout_get_type cdecl alias "gtk_cell_layout_get_type" () as GType
declare sub gtk_cell_layout_pack_start cdecl alias "gtk_cell_layout_pack_start" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_cell_layout_pack_end cdecl alias "gtk_cell_layout_pack_end" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_cell_layout_clear cdecl alias "gtk_cell_layout_clear" (byval cell_layout as GtkCellLayout ptr)
declare sub gtk_cell_layout_set_attributes cdecl alias "gtk_cell_layout_set_attributes" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, ...)
declare sub gtk_cell_layout_add_attribute cdecl alias "gtk_cell_layout_add_attribute" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval attribute as string, byval column as gint)
declare sub gtk_cell_layout_set_cell_data_func cdecl alias "gtk_cell_layout_set_cell_data_func" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval func as GtkCellLayoutDataFunc, byval func_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_cell_layout_clear_attributes cdecl alias "gtk_cell_layout_clear_attributes" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr)
declare sub gtk_cell_layout_reorder cdecl alias "gtk_cell_layout_reorder" (byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval position as gint)

#endif
