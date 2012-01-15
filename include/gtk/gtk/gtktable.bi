''
''
'' gtktable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktable_bi__
#define __gtktable_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define GTK_TYPE_TABLE (gtk_table_get_type ())
#define GTK_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TABLE, GtkTable))
#define GTK_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TABLE, GtkTableClass))
#define GTK_IS_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TABLE))
#define GTK_IS_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TABLE))
#define GTK_TABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TABLE, GtkTableClass))

type GtkTable as _GtkTable
type GtkTableClass as _GtkTableClass
type GtkTableChild as _GtkTableChild
type GtkTableRowCol as _GtkTableRowCol

type _GtkTable
	container as GtkContainer
	children as GList ptr
	rows as GtkTableRowCol ptr
	cols as GtkTableRowCol ptr
	nrows as guint16
	ncols as guint16
	column_spacing as guint16
	row_spacing as guint16
	homogeneous:1 as guint
end type

type _GtkTableClass
	parent_class as GtkContainerClass
end type

type _GtkTableChild
	widget as GtkWidget ptr
	left_attach as guint16
	right_attach as guint16
	top_attach as guint16
	bottom_attach as guint16
	xpadding as guint16
	ypadding as guint16
	xexpand:1 as guint
	yexpand:1 as guint
	xshrink:1 as guint
	yshrink:1 as guint
	xfill:1 as guint
	yfill:1 as guint
end type

type _GtkTableRowCol
	requisition as guint16
	allocation as guint16
	spacing as guint16
	need_expand:1 as guint
	need_shrink:1 as guint
	expand:1 as guint
	shrink:1 as guint
	empty:1 as guint
end type

declare function gtk_table_get_type () as GType
declare function gtk_table_new (byval rows as guint, byval columns as guint, byval homogeneous as gboolean) as GtkWidget ptr
declare sub gtk_table_resize (byval table as GtkTable ptr, byval rows as guint, byval columns as guint)
declare sub gtk_table_attach (byval table as GtkTable ptr, byval child as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint, byval xoptions as GtkAttachOptions, byval yoptions as GtkAttachOptions, byval xpadding as guint, byval ypadding as guint)
declare sub gtk_table_attach_defaults (byval table as GtkTable ptr, byval widget as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint)
declare sub gtk_table_set_row_spacing (byval table as GtkTable ptr, byval row as guint, byval spacing as guint)
declare function gtk_table_get_row_spacing (byval table as GtkTable ptr, byval row as guint) as guint
declare sub gtk_table_set_col_spacing (byval table as GtkTable ptr, byval column as guint, byval spacing as guint)
declare function gtk_table_get_col_spacing (byval table as GtkTable ptr, byval column as guint) as guint
declare sub gtk_table_set_row_spacings (byval table as GtkTable ptr, byval spacing as guint)
declare function gtk_table_get_default_row_spacing (byval table as GtkTable ptr) as guint
declare sub gtk_table_set_col_spacings (byval table as GtkTable ptr, byval spacing as guint)
declare function gtk_table_get_default_col_spacing (byval table as GtkTable ptr) as guint
declare sub gtk_table_set_homogeneous (byval table as GtkTable ptr, byval homogeneous as gboolean)
declare function gtk_table_get_homogeneous (byval table as GtkTable ptr) as gboolean

#endif
