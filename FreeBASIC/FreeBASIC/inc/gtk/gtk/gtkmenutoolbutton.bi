''
''
'' gtkmenutoolbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmenutoolbutton_bi__
#define __gtkmenutoolbutton_bi__

#include once "gtkmenu.bi"
#include once "gtktoolbutton.bi"

#define GTK_TYPE_MENU_TOOL_BUTTON (gtk_menu_tool_button_get_type ())
#define GTK_MENU_TOOL_BUTTON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButton))
#define GTK_MENU_TOOL_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass))
#define GTK_IS_MENU_TOOL_BUTTON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_MENU_TOOL_BUTTON))
#define GTK_IS_MENU_TOOL_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_MENU_TOOL_BUTTON))
#define GTK_MENU_TOOL_BUTTON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass))

type GtkMenuToolButtonClass as _GtkMenuToolButtonClass
type GtkMenuToolButton as _GtkMenuToolButton
type GtkMenuToolButtonPrivate as _GtkMenuToolButtonPrivate

type _GtkMenuToolButton
	parent as GtkToolButton
	priv as GtkMenuToolButtonPrivate ptr
end type

type _GtkMenuToolButtonClass
	parent_class as GtkToolButtonClass
	show_menu as sub cdecl(byval as GtkMenuToolButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_menu_tool_button_get_type () as GType
declare function gtk_menu_tool_button_new (byval icon_widget as GtkWidget ptr, byval label as zstring ptr) as GtkToolItem ptr
declare function gtk_menu_tool_button_new_from_stock (byval stock_id as zstring ptr) as GtkToolItem ptr
declare sub gtk_menu_tool_button_set_menu (byval button as GtkMenuToolButton ptr, byval menu as GtkWidget ptr)
declare function gtk_menu_tool_button_get_menu (byval button as GtkMenuToolButton ptr) as GtkWidget ptr
declare sub gtk_menu_tool_button_set_arrow_tooltip (byval button as GtkMenuToolButton ptr, byval tooltips as GtkTooltips ptr, byval tip_text as zstring ptr, byval tip_private as zstring ptr)

#endif
