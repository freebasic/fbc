''
''
'' gtkvbbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkvbbox_bi__
#define __gtkvbbox_bi__

#include once "gtk/gtk/gtkbbox.bi"

type GtkVButtonBox as _GtkVButtonBox
type GtkVButtonBoxClass as _GtkVButtonBoxClass

type _GtkVButtonBox
	button_box as GtkButtonBox
end type

type _GtkVButtonBoxClass
	parent_class as GtkButtonBoxClass
end type

declare function gtk_vbutton_box_get_type cdecl alias "gtk_vbutton_box_get_type" () as GType
declare function gtk_vbutton_box_new cdecl alias "gtk_vbutton_box_new" () as GtkWidget ptr
declare function gtk_vbutton_box_get_spacing_default cdecl alias "gtk_vbutton_box_get_spacing_default" () as gint
declare sub gtk_vbutton_box_set_spacing_default cdecl alias "gtk_vbutton_box_set_spacing_default" (byval spacing as gint)
declare function gtk_vbutton_box_get_layout_default cdecl alias "gtk_vbutton_box_get_layout_default" () as GtkButtonBoxStyle
declare sub gtk_vbutton_box_set_layout_default cdecl alias "gtk_vbutton_box_set_layout_default" (byval layout as GtkButtonBoxStyle)

#endif
