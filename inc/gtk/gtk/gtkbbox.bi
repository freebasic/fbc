''
''
'' gtkbbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkbbox_bi__
#define __gtkbbox_bi__

#include once "gtkbox.bi"

#define GTK_BUTTONBOX_DEFAULT -1

#define GTK_TYPE_BUTTON_BOX             gtk_button_box_get_type()
#define GTK_BUTTON_BOX(obj)             G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_BUTTON_BOX, GtkButtonBox)
#define GTK_BUTTON_BOX_CLASS(klass)     G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)
#define GTK_IS_BUTTON_BOX(obj)          G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_BUTTON_BOX)
#define GTK_IS_BUTTON_BOX_CLASS(klass)  G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_BUTTON_BOX)
#define GTK_BUTTON_BOX_GET_CLASS(obj)   G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)

type GtkButtonBox as _GtkButtonBox
type GtkButtonBoxClass as _GtkButtonBoxClass

type _GtkButtonBox
	box as GtkBox
	child_min_width as gint
	child_min_height as gint
	child_ipad_x as gint
	child_ipad_y as gint
	layout_style as GtkButtonBoxStyle
end type

type _GtkButtonBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_button_box_get_type () as GType
declare function gtk_button_box_get_layout (byval widget as GtkButtonBox ptr) as GtkButtonBoxStyle
declare sub gtk_button_box_set_layout (byval widget as GtkButtonBox ptr, byval layout_style as GtkButtonBoxStyle)
declare function gtk_button_box_get_child_secondary (byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_button_box_set_child_secondary (byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr, byval is_secondary as gboolean)
declare sub gtk_button_box_set_child_size (byval widget as GtkButtonBox ptr, byval min_width as gint, byval min_height as gint)
declare sub gtk_button_box_set_child_ipadding (byval widget as GtkButtonBox ptr, byval ipad_x as gint, byval ipad_y as gint)
declare sub gtk_button_box_get_child_size (byval widget as GtkButtonBox ptr, byval min_width as gint ptr, byval min_height as gint ptr)
declare sub gtk_button_box_get_child_ipadding (byval widget as GtkButtonBox ptr, byval ipad_x as gint ptr, byval ipad_y as gint ptr)
declare sub _gtk_button_box_child_requisition (byval widget as GtkWidget ptr, byval nvis_children as integer ptr, byval nvis_secondaries as integer ptr, byval width as integer ptr, byval height as integer ptr)

#define gtk_button_box_set_spacing(b,s) gtk_box_set_spacing(GTK_BOX(b), s)
#define gtk_button_box_get_spacing(b) gtk_box_get_spacing(GTK_BOX(b))

#endif
