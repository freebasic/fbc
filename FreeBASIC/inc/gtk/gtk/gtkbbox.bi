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

#include once "gtk/gtk/gtkbox.bi"

#define GTK_BUTTONBOX_DEFAULT -1

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

declare function gtk_button_box_get_type cdecl alias "gtk_button_box_get_type" () as GType
declare function gtk_button_box_get_layout cdecl alias "gtk_button_box_get_layout" (byval widget as GtkButtonBox ptr) as GtkButtonBoxStyle
declare sub gtk_button_box_set_layout cdecl alias "gtk_button_box_set_layout" (byval widget as GtkButtonBox ptr, byval layout_style as GtkButtonBoxStyle)
declare function gtk_button_box_get_child_secondary cdecl alias "gtk_button_box_get_child_secondary" (byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_button_box_set_child_secondary cdecl alias "gtk_button_box_set_child_secondary" (byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr, byval is_secondary as gboolean)
declare sub gtk_button_box_set_child_size cdecl alias "gtk_button_box_set_child_size" (byval widget as GtkButtonBox ptr, byval min_width as gint, byval min_height as gint)
declare sub gtk_button_box_set_child_ipadding cdecl alias "gtk_button_box_set_child_ipadding" (byval widget as GtkButtonBox ptr, byval ipad_x as gint, byval ipad_y as gint)
declare sub gtk_button_box_get_child_size cdecl alias "gtk_button_box_get_child_size" (byval widget as GtkButtonBox ptr, byval min_width as gint ptr, byval min_height as gint ptr)
declare sub gtk_button_box_get_child_ipadding cdecl alias "gtk_button_box_get_child_ipadding" (byval widget as GtkButtonBox ptr, byval ipad_x as gint ptr, byval ipad_y as gint ptr)
declare sub _gtk_button_box_child_requisition cdecl alias "_gtk_button_box_child_requisition" (byval widget as GtkWidget ptr, byval nvis_children as integer ptr, byval nvis_secondaries as integer ptr, byval width as integer ptr, byval height as integer ptr)

#endif
