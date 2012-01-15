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

#include once "gtktoolitem.bi"

#define GTK_TYPE_TOOL_BUTTON (gtk_tool_button_get_type ())
#define GTK_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButton))
#define GTK_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass))
#define GTK_IS_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOL_BUTTON))
#define GTK_IS_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOL_BUTTON))
#define GTK_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass))

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

declare function gtk_tool_button_get_type () as GType
declare function gtk_tool_button_new (byval icon_widget as GtkWidget ptr, byval label as zstring ptr) as GtkToolItem ptr
declare function gtk_tool_button_new_from_stock (byval stock_id as zstring ptr) as GtkToolItem ptr
declare sub gtk_tool_button_set_label (byval button as GtkToolButton ptr, byval label as zstring ptr)
declare function gtk_tool_button_get_label (byval button as GtkToolButton ptr) as zstring ptr
declare sub gtk_tool_button_set_use_underline (byval button as GtkToolButton ptr, byval use_underline as gboolean)
declare function gtk_tool_button_get_use_underline (byval button as GtkToolButton ptr) as gboolean
declare sub gtk_tool_button_set_stock_id (byval button as GtkToolButton ptr, byval stock_id as zstring ptr)
declare function gtk_tool_button_get_stock_id (byval button as GtkToolButton ptr) as zstring ptr
declare sub gtk_tool_button_set_icon_widget (byval button as GtkToolButton ptr, byval icon_widget as GtkWidget ptr)
declare function gtk_tool_button_get_icon_widget (byval button as GtkToolButton ptr) as GtkWidget ptr
declare sub gtk_tool_button_set_label_widget (byval button as GtkToolButton ptr, byval label_widget as GtkWidget ptr)
declare function gtk_tool_button_get_label_widget (byval button as GtkToolButton ptr) as GtkWidget ptr
declare function _gtk_tool_button_get_button (byval button as GtkToolButton ptr) as GtkWidget ptr

#endif
