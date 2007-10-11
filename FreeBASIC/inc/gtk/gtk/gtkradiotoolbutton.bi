''
''
'' gtkradiotoolbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkradiotoolbutton_bi__
#define __gtkradiotoolbutton_bi__

#include once "gtktoggletoolbutton.bi"

#define GTK_TYPE_RADIO_TOOL_BUTTON (gtk_radio_tool_button_get_type ())
#define GTK_RADIO_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButton))
#define GTK_RADIO_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass))
#define GTK_IS_RADIO_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_TOOL_BUTTON))
#define GTK_IS_RADIO_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_TOOL_BUTTON))
#define GTK_RADIO_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass))

type GtkRadioToolButton as _GtkRadioToolButton
type GtkRadioToolButtonClass as _GtkRadioToolButtonClass

type _GtkRadioToolButton
	parent as GtkToggleToolButton
end type

type _GtkRadioToolButtonClass
	parent_class as GtkToggleToolButtonClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_radio_tool_button_get_type () as GType
declare function gtk_radio_tool_button_new (byval group as GSList ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_from_stock (byval group as GSList ptr, byval stock_id as zstring ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_from_widget (byval group as GtkRadioToolButton ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_with_stock_from_widget (byval group as GtkRadioToolButton ptr, byval stock_id as zstring ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_get_group (byval button as GtkRadioToolButton ptr) as GSList ptr
declare sub gtk_radio_tool_button_set_group (byval button as GtkRadioToolButton ptr, byval group as GSList ptr)

#endif
