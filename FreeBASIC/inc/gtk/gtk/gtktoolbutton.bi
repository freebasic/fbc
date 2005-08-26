''
''
'' gtktoolbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktoolbutton_bi__
#define __gtktoolbutton_bi__

#include once "gtk/gtk/gtktoolitem.bi"

type GtkToolButton as _GtkToolButton
type GtkToolButtonClass as _GtkToolButtonClass
type GtkToolButtonPrivate as _GtkToolButtonPrivate

type _GtkToolButton
	parent as GtkToolItem
	priv as GtkToolButtonPrivate ptr
end type

type _GtkToolButtonClass
	parent_class as GtkToolItemClass
	button_type as GType
	clicked as sub cdecl(byval as GtkToolButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tool_button_get_type cdecl alias "gtk_tool_button_get_type" () as GType
declare function gtk_tool_button_new cdecl alias "gtk_tool_button_new" (byval icon_widget as GtkWidget ptr, byval label as zstring ptr) as GtkToolItem ptr
declare function gtk_tool_button_new_from_stock cdecl alias "gtk_tool_button_new_from_stock" (byval stock_id as zstring ptr) as GtkToolItem ptr
declare sub gtk_tool_button_set_label cdecl alias "gtk_tool_button_set_label" (byval button as GtkToolButton ptr, byval label as zstring ptr)
declare function gtk_tool_button_get_label cdecl alias "gtk_tool_button_get_label" (byval button as GtkToolButton ptr) as zstring ptr
declare sub gtk_tool_button_set_use_underline cdecl alias "gtk_tool_button_set_use_underline" (byval button as GtkToolButton ptr, byval use_underline as gboolean)
declare function gtk_tool_button_get_use_underline cdecl alias "gtk_tool_button_get_use_underline" (byval button as GtkToolButton ptr) as gboolean
declare sub gtk_tool_button_set_stock_id cdecl alias "gtk_tool_button_set_stock_id" (byval button as GtkToolButton ptr, byval stock_id as zstring ptr)
declare function gtk_tool_button_get_stock_id cdecl alias "gtk_tool_button_get_stock_id" (byval button as GtkToolButton ptr) as zstring ptr
declare sub gtk_tool_button_set_icon_widget cdecl alias "gtk_tool_button_set_icon_widget" (byval button as GtkToolButton ptr, byval icon_widget as GtkWidget ptr)
declare function gtk_tool_button_get_icon_widget cdecl alias "gtk_tool_button_get_icon_widget" (byval button as GtkToolButton ptr) as GtkWidget ptr
declare sub gtk_tool_button_set_label_widget cdecl alias "gtk_tool_button_set_label_widget" (byval button as GtkToolButton ptr, byval label_widget as GtkWidget ptr)
declare function gtk_tool_button_get_label_widget cdecl alias "gtk_tool_button_get_label_widget" (byval button as GtkToolButton ptr) as GtkWidget ptr
declare function _gtk_tool_button_get_button cdecl alias "_gtk_tool_button_get_button" (byval button as GtkToolButton ptr) as GtkWidget ptr

#endif
