''
''
'' gtkfontbutton -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkfontbutton_bi__
#define __gtkfontbutton_bi__

#include once "gtk/gtk/gtkbutton.bi"

type GtkFontButton as _GtkFontButton
type GtkFontButtonClass as _GtkFontButtonClass
type GtkFontButtonPrivate as _GtkFontButtonPrivate

type _GtkFontButton
	button as GtkButton
	priv as GtkFontButtonPrivate ptr
end type

type _GtkFontButtonClass
	parent_class as GtkButtonClass
	font_set as sub cdecl(byval as GtkFontButton ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_font_button_get_type cdecl alias "gtk_font_button_get_type" () as GType
declare function gtk_font_button_new cdecl alias "gtk_font_button_new" () as GtkWidget ptr
declare function gtk_font_button_new_with_font cdecl alias "gtk_font_button_new_with_font" (byval fontname as gchar ptr) as GtkWidget ptr
declare function gtk_font_button_get_title cdecl alias "gtk_font_button_get_title" (byval font_button as GtkFontButton ptr) as gchar ptr
declare sub gtk_font_button_set_title cdecl alias "gtk_font_button_set_title" (byval font_button as GtkFontButton ptr, byval title as gchar ptr)
declare function gtk_font_button_get_use_font cdecl alias "gtk_font_button_get_use_font" (byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_use_font cdecl alias "gtk_font_button_set_use_font" (byval font_button as GtkFontButton ptr, byval use_font as gboolean)
declare function gtk_font_button_get_use_size cdecl alias "gtk_font_button_get_use_size" (byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_use_size cdecl alias "gtk_font_button_set_use_size" (byval font_button as GtkFontButton ptr, byval use_size as gboolean)
declare function gtk_font_button_get_font_name cdecl alias "gtk_font_button_get_font_name" (byval font_button as GtkFontButton ptr) as gchar ptr
declare function gtk_font_button_set_font_name cdecl alias "gtk_font_button_set_font_name" (byval font_button as GtkFontButton ptr, byval fontname as gchar ptr) as gboolean
declare function gtk_font_button_get_show_style cdecl alias "gtk_font_button_get_show_style" (byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_show_style cdecl alias "gtk_font_button_set_show_style" (byval font_button as GtkFontButton ptr, byval show_style as gboolean)
declare function gtk_font_button_get_show_size cdecl alias "gtk_font_button_get_show_size" (byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_show_size cdecl alias "gtk_font_button_set_show_size" (byval font_button as GtkFontButton ptr, byval show_size as gboolean)

#endif
