''
''
'' gtkcellview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcellview_bi__
#define __gtkcellview_bi__

#include once "gtk/gtk/gtkwidget.bi"
#include once "gtk/gtk/gtkcellrenderer.bi"
#include once "gtk/gtk/gtktreemodel.bi"

type GtkCellView as _GtkCellView
type GtkCellViewClass as _GtkCellViewClass
type GtkCellViewPrivate as _GtkCellViewPrivate

type _GtkCellView
	parent_instance as GtkWidget
	priv as GtkCellViewPrivate ptr
end type

type _GtkCellViewClass
	parent_class as GtkWidgetClass
end type

declare function gtk_cell_view_get_type cdecl alias "gtk_cell_view_get_type" () as GType
declare function gtk_cell_view_new cdecl alias "gtk_cell_view_new" () as GtkWidget ptr
declare function gtk_cell_view_new_with_text cdecl alias "gtk_cell_view_new_with_text" (byval text as string) as GtkWidget ptr
declare function gtk_cell_view_new_with_markup cdecl alias "gtk_cell_view_new_with_markup" (byval markup as string) as GtkWidget ptr
declare function gtk_cell_view_new_with_pixbuf cdecl alias "gtk_cell_view_new_with_pixbuf" (byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare sub gtk_cell_view_set_model cdecl alias "gtk_cell_view_set_model" (byval cell_view as GtkCellView ptr, byval model as GtkTreeModel ptr)
declare sub gtk_cell_view_set_displayed_row cdecl alias "gtk_cell_view_set_displayed_row" (byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr)
declare function gtk_cell_view_get_displayed_row cdecl alias "gtk_cell_view_get_displayed_row" (byval cell_view as GtkCellView ptr) as GtkTreePath ptr
declare function gtk_cell_view_get_size_of_row cdecl alias "gtk_cell_view_get_size_of_row" (byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr, byval requisition as GtkRequisition ptr) as gboolean
declare sub gtk_cell_view_set_background_color cdecl alias "gtk_cell_view_set_background_color" (byval cell_view as GtkCellView ptr, byval color as GdkColor ptr)
declare function gtk_cell_view_get_cell_renderers cdecl alias "gtk_cell_view_get_cell_renderers" (byval cell_view as GtkCellView ptr) as GList ptr

#endif
