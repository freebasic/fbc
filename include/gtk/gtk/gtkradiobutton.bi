''
''
'' gtkradiobutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkradiobutton_bi__
#define __gtkradiobutton_bi__

#include once "gtk/gdk.bi"
#include once "gtkcheckbutton.bi"

#define GTK_TYPE_RADIO_BUTTON (gtk_radio_button_get_type ())
#define GTK_RADIO_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButton))
#define GTK_RADIO_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass))
#define GTK_IS_RADIO_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_BUTTON))
#define GTK_IS_RADIO_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_BUTTON))
#define GTK_RADIO_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass))

type GtkRadioButton as _GtkRadioButton
type GtkRadioButtonClass as _GtkRadioButtonClass

type _GtkRadioButton
	check_button as GtkCheckButton
	group as GSList ptr
end type

type _GtkRadioButtonClass
	parent_class as GtkCheckButtonClass
	group_changed as sub cdecl(byval as GtkRadioButton ptr)
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_radio_button_get_type () as GType
declare function gtk_radio_button_new (byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_button_new_from_widget (byval group as GtkRadioButton ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label (byval group as GSList ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label_from_widget (byval group as GtkRadioButton ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic (byval group as GSList ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic_from_widget (byval group as GtkRadioButton ptr, byval label as zstring ptr) as GtkWidget ptr
declare function gtk_radio_button_get_group (byval radio_button as GtkRadioButton ptr) as GSList ptr
declare sub gtk_radio_button_set_group (byval radio_button as GtkRadioButton ptr, byval group as GSList ptr)

#define gtk_radio_button_group gtk_radio_button_get_group

#endif
