''
''
'' gtkhbbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkhbbox_bi__
#define __gtkhbbox_bi__

#include once "gtk/gtk/gtkbbox.bi"

type GtkHButtonBox as _GtkHButtonBox
type GtkHButtonBoxClass as _GtkHButtonBoxClass

type _GtkHButtonBox
	button_box as GtkButtonBox
end type

type _GtkHButtonBoxClass
	parent_class as GtkButtonBoxClass
end type

declare function gtk_hbutton_box_get_type cdecl alias "gtk_hbutton_box_get_type" () as GType
declare function gtk_hbutton_box_new cdecl alias "gtk_hbutton_box_new" () as GtkWidget ptr
declare function gtk_hbutton_box_get_spacing_default cdecl alias "gtk_hbutton_box_get_spacing_default" () as gint
declare function gtk_hbutton_box_get_layout_default cdecl alias "gtk_hbutton_box_get_layout_default" () as GtkButtonBoxStyle
declare sub gtk_hbutton_box_set_spacing_default cdecl alias "gtk_hbutton_box_set_spacing_default" (byval spacing as gint)
declare sub gtk_hbutton_box_set_layout_default cdecl alias "gtk_hbutton_box_set_layout_default" (byval layout as GtkButtonBoxStyle)

#endif
