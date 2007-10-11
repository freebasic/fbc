''
''
'' gtksizegroup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtksizegroup_bi__
#define __gtksizegroup_bi__

#include once "gtkwidget.bi"

#define GTK_TYPE_SIZE_GROUP (gtk_size_group_get_type ())
#define GTK_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroup))
#define GTK_SIZE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass))
#define GTK_IS_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SIZE_GROUP))
#define GTK_IS_SIZE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SIZE_GROUP))
#define GTK_SIZE_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass))

type GtkSizeGroup as _GtkSizeGroup
type GtkSizeGroupClass as _GtkSizeGroupClass

type _GtkSizeGroup
	parent_instance as GObject
	widgets as GSList ptr
	mode as guint8
	have_width:1 as guint
	have_height:1 as guint
	requisition as GtkRequisition
end type

type _GtkSizeGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

enum GtkSizeGroupMode
	GTK_SIZE_GROUP_NONE
	GTK_SIZE_GROUP_HORIZONTAL
	GTK_SIZE_GROUP_VERTICAL
	GTK_SIZE_GROUP_BOTH
end enum


declare function gtk_size_group_get_type () as GType
declare function gtk_size_group_new (byval mode as GtkSizeGroupMode) as GtkSizeGroup ptr
declare sub gtk_size_group_set_mode (byval size_group as GtkSizeGroup ptr, byval mode as GtkSizeGroupMode)
declare function gtk_size_group_get_mode (byval size_group as GtkSizeGroup ptr) as GtkSizeGroupMode
declare sub gtk_size_group_add_widget (byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare sub gtk_size_group_remove_widget (byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare sub _gtk_size_group_get_child_requisition (byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub _gtk_size_group_compute_requisition (byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub _gtk_size_group_queue_resize (byval widget as GtkWidget ptr)

#endif
