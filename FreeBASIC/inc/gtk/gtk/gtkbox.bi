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
#include once "gtk/gtk/gtkcontainer.bi"

type GtkBox as _GtkBox
type GtkBoxClass as _GtkBoxClass
type GtkBoxChild as _GtkBoxChild

type _GtkBox
	container as GtkContainer
	children as GList ptr
	spacing as gint16
	homogeneous as guint
end type

type _GtkBoxClass
	parent_class as GtkContainerClass
end type

type _GtkBoxChild
	widget as GtkWidget ptr
	padding as guint16
	''!!!FIXME!!! bit-fields support is needed
	union
		expand as guint
		fill as guint
		pack as guint
		is_secondary as guint
	end union
end type

declare function gtk_box_get_type cdecl alias "gtk_box_get_type" () as GType
declare sub gtk_box_pack_start cdecl alias "gtk_box_pack_start" (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_end cdecl alias "gtk_box_pack_end" (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_start_defaults cdecl alias "gtk_box_pack_start_defaults" (byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_pack_end_defaults cdecl alias "gtk_box_pack_end_defaults" (byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_set_homogeneous cdecl alias "gtk_box_set_homogeneous" (byval box as GtkBox ptr, byval homogeneous as gboolean)
declare function gtk_box_get_homogeneous cdecl alias "gtk_box_get_homogeneous" (byval box as GtkBox ptr) as gboolean
declare sub gtk_box_set_spacing cdecl alias "gtk_box_set_spacing" (byval box as GtkBox ptr, byval spacing as gint)
declare function gtk_box_get_spacing cdecl alias "gtk_box_get_spacing" (byval box as GtkBox ptr) as gint
declare sub gtk_box_reorder_child cdecl alias "gtk_box_reorder_child" (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_box_query_child_packing cdecl alias "gtk_box_query_child_packing" (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval padding as guint ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_box_set_child_packing cdecl alias "gtk_box_set_child_packing" (byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint, byval pack_type as GtkPackType)

#endif
