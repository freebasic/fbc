''
''
'' gtktoggletoolbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktoggletoolbutton_bi__
#define __gtktoggletoolbutton_bi__

#include once "gtktoolbutton.bi"

#define GTK_TYPE_TOGGLE_TOOL_BUTTON (gtk_toggle_tool_button_get_type ())
#define GTK_TOGGLE_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButton))
#define GTK_TOGGLE_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass))
#define GTK_IS_TOGGLE_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON))
#define GTK_IS_TOGGLE_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON))
#define GTK_TOGGLE_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass))

type GtkToggleToolButton as _GtkToggleToolButton
type GtkToggleToolButtonClass as _GtkToggleToolButtonClass
type GtkToggleToolButtonPrivate as _GtkToggleToolButtonPrivate

type _GtkToggleToolButton
	parent as GtkToolButton
	priv as GtkToggleToolButtonPrivate ptr
end type

type _GtkToggleToolButtonClass
	parent_class as GtkToolButtonClass
	toggled as sub cdecl(byval as GtkToggleToolButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_toggle_tool_button_get_type () as GType
declare function gtk_toggle_tool_button_new () as GtkToolItem ptr
declare function gtk_toggle_tool_button_new_from_stock (byval stock_id as zstring ptr) as GtkToolItem ptr
declare sub gtk_toggle_tool_button_set_active (byval button as GtkToggleToolButton ptr, byval is_active as gboolean)
declare function gtk_toggle_tool_button_get_active (byval button as GtkToggleToolButton ptr) as gboolean

#endif
