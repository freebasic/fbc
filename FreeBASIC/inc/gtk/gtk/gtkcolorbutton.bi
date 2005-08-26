''
''
'' gtkcolorbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcolorbutton_bi__
#define __gtkcolorbutton_bi__

#include once "gtk/gtk/gtkbutton.bi"

type GtkColorButton as _GtkColorButton
type GtkColorButtonClass as _GtkColorButtonClass
type GtkColorButtonPrivate as _GtkColorButtonPrivate

type _GtkColorButton
	button as GtkButton
	priv as GtkColorButtonPrivate ptr
end type

type _GtkColorButtonClass
	parent_class as GtkButtonClass
	color_set as sub cdecl(byval as GtkColorButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_color_button_get_type cdecl alias "gtk_color_button_get_type" () as GType
declare function gtk_color_button_new cdecl alias "gtk_color_button_new" () as GtkWidget ptr
declare function gtk_color_button_new_with_color cdecl alias "gtk_color_button_new_with_color" (byval color as GdkColor ptr) as GtkWidget ptr
declare sub gtk_color_button_set_color cdecl alias "gtk_color_button_set_color" (byval color_button as GtkColorButton ptr, byval color as GdkColor ptr)
declare sub gtk_color_button_set_alpha cdecl alias "gtk_color_button_set_alpha" (byval color_button as GtkColorButton ptr, byval alpha as guint16)
declare sub gtk_color_button_get_color cdecl alias "gtk_color_button_get_color" (byval color_button as GtkColorButton ptr, byval color as GdkColor ptr)
declare function gtk_color_button_get_alpha cdecl alias "gtk_color_button_get_alpha" (byval color_button as GtkColorButton ptr) as guint16
declare sub gtk_color_button_set_use_alpha cdecl alias "gtk_color_button_set_use_alpha" (byval color_button as GtkColorButton ptr, byval use_alpha as gboolean)
declare function gtk_color_button_get_use_alpha cdecl alias "gtk_color_button_get_use_alpha" (byval color_button as GtkColorButton ptr) as gboolean
declare sub gtk_color_button_set_title cdecl alias "gtk_color_button_set_title" (byval color_button as GtkColorButton ptr, byval title as zstring ptr)
declare function gtk_color_button_get_title cdecl alias "gtk_color_button_get_title" (byval color_button as GtkColorButton ptr) as zstring ptr

#endif
