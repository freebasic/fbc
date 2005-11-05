''
''
'' gtkaccellabel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaccellabel_bi__
#define __gtkaccellabel_bi__

#include once "gtk/gtk/gtklabel.bi"

type GtkAccelLabel as _GtkAccelLabel
type GtkAccelLabelClass as _GtkAccelLabelClass

type _GtkAccelLabel
	label as GtkLabel
	gtk_reserved as guint
	accel_padding as guint
	accel_widget as GtkWidget ptr
	accel_closure as GClosure ptr
	accel_group as GtkAccelGroup ptr
	accel_string as zstring ptr
	accel_string_width as guint16
end type

type _GtkAccelLabelClass
	parent_class as GtkLabelClass
	signal_quote1 as zstring ptr
	signal_quote2 as zstring ptr
	mod_name_shift as zstring ptr
	mod_name_control as zstring ptr
	mod_name_alt as zstring ptr
	mod_separator as zstring ptr
	accel_seperator as zstring ptr
	latin1_to_char as guint
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_accel_label_get_type cdecl alias "gtk_accel_label_get_type" () as GType
declare function gtk_accel_label_new cdecl alias "gtk_accel_label_new" (byval string as zstring ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_widget cdecl alias "gtk_accel_label_get_accel_widget" (byval accel_label as GtkAccelLabel ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_width cdecl alias "gtk_accel_label_get_accel_width" (byval accel_label as GtkAccelLabel ptr) as guint
declare sub gtk_accel_label_set_accel_widget cdecl alias "gtk_accel_label_set_accel_widget" (byval accel_label as GtkAccelLabel ptr, byval accel_widget as GtkWidget ptr)
declare sub gtk_accel_label_set_accel_closure cdecl alias "gtk_accel_label_set_accel_closure" (byval accel_label as GtkAccelLabel ptr, byval accel_closure as GClosure ptr)
declare function gtk_accel_label_refetch cdecl alias "gtk_accel_label_refetch" (byval accel_label as GtkAccelLabel ptr) as gboolean
declare function _gtk_accel_label_class_get_accelerator_label cdecl alias "_gtk_accel_label_class_get_accelerator_label" (byval klass as GtkAccelLabelClass ptr, byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as zstring ptr

#define	gtk_accel_label_accelerator_width gtk_accel_label_get_accel_width

#endif
