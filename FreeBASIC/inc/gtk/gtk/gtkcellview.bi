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

#include once "gtkwidget.bi"
#include once "gtkcellrenderer.bi"
#include once "gtktreemodel.bi"

#define GTK_TYPE_CELL_VIEW (gtk_cell_view_get_type ())
#define GTK_CELL_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_VIEW, GtkCellView))
#define GTK_CELL_VIEW_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_CELL_VIEW, GtkCellViewClass))
#define GTK_IS_CELL_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_VIEW))
#define GTK_IS_CELL_VIEW_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_CELL_VIEW))
#define GTK_CELL_VIEW_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_CELL_VIEW, GtkCellViewClass))

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

declare function gtk_cell_view_get_type () as GType
declare function gtk_cell_view_new () as GtkWidget ptr
declare function gtk_cell_view_new_with_text (byval text as zstring ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_markup (byval markup as zstring ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_pixbuf (byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare sub gtk_cell_view_set_model (byval cell_view as GtkCellView ptr, byval model as GtkTreeModel ptr)
declare sub gtk_cell_view_set_displayed_row (byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr)
declare function gtk_cell_view_get_displayed_row (byval cell_view as GtkCellView ptr) as GtkTreePath ptr
declare function gtk_cell_view_get_size_of_row (byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr, byval requisition as GtkRequisition ptr) as gboolean
declare sub gtk_cell_view_set_background_color (byval cell_view as GtkCellView ptr, byval color as GdkColor ptr)
declare function gtk_cell_view_get_cell_renderers (byval cell_view as GtkCellView ptr) as GList ptr

#endif
