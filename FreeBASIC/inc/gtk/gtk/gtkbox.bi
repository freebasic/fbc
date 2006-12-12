''
''
'' gtkbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbox_bi__
#define __gtkbox_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define GTK_TYPE_BOX            gtk_box_get_type()
#define GTK_BOX(obj)            G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_BOX, GtkBox)
#define GTK_BOX_CLASS(klass)    G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_BOX, GtkBoxClass)
#define GTK_IS_BOX(obj)         G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_BOX)
#define GTK_IS_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_BOX)
#define GTK_BOX_GET_CLASS(obj)  G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_BOX, GtkBoxClass)

type GtkBox as _GtkBox
type GtkBoxClass as _GtkBoxClass
type GtkBoxChild as _GtkBoxChild

type _GtkBox
	container as GtkContainer
	children as GList ptr
	spacing as gint16
	homogeneous:1 as guint
end type

type _GtkBoxClass
	parent_class as GtkContainerClass
end type

type _GtkBoxChild
	widget as GtkWidget ptr
	padding as guint16
	expand:1 as guint
	fill:1 as guint
	pack:1 as guint
	is_secondary:1 as guint
end type

declare function gtk_box_get_type () as GType
declare sub gtk_box_pack_start (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_end (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_start_defaults (byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_pack_end_defaults (byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_set_homogeneous (byval box as GtkBox ptr, byval homogeneous as gboolean)
declare function gtk_box_get_homogeneous (byval box as GtkBox ptr) as gboolean
declare sub gtk_box_set_spacing (byval box as GtkBox ptr, byval spacing as gint)
declare function gtk_box_get_spacing (byval box as GtkBox ptr) as gint
declare sub gtk_box_reorder_child (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_box_query_child_packing (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval padding as guint ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_box_set_child_packing (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint, byval pack_type as GtkPackType)

#endif
