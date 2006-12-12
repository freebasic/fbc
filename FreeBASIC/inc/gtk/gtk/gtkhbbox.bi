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

#include once "gtkbbox.bi"

#define GTK_TYPE_HBUTTON_BOX (gtk_hbutton_box_get_type ())
#define GTK_HBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBox))
#define GTK_HBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass))
#define GTK_IS_HBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HBUTTON_BOX))
#define GTK_IS_HBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HBUTTON_BOX))
#define GTK_HBUTTON_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass))

type GtkHButtonBox as _GtkHButtonBox
type GtkHButtonBoxClass as _GtkHButtonBoxClass

type _GtkHButtonBox
	button_box as GtkButtonBox
end type

type _GtkHButtonBoxClass
	parent_class as GtkButtonBoxClass
end type

declare function gtk_hbutton_box_get_type () as GType
declare function gtk_hbutton_box_new () as GtkWidget ptr
declare function gtk_hbutton_box_get_spacing_default () as gint
declare function gtk_hbutton_box_get_layout_default () as GtkButtonBoxStyle
declare sub gtk_hbutton_box_set_spacing_default (byval spacing as gint)
declare sub gtk_hbutton_box_set_layout_default (byval layout as GtkButtonBoxStyle)

#endif
