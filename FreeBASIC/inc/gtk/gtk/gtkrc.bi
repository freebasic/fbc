''
''
'' gtkrc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkrc_bi__
#define __gtkrc_bi__

#include once "gtk/gtk/gtkstyle.bi"

type GtkIconFactory as _GtkIconFactory
type GtkRcContext as _GtkRcContext
type GtkRcStyleClass as _GtkRcStyleClass

enum GtkRcFlags
	GTK_RC_FG = 1 shl 0
	GTK_RC_BG = 1 shl 1
	GTK_RC_TEXT = 1 shl 2
	GTK_RC_BASE = 1 shl 3
end enum


type _GtkRcStyle
	parent_instance as GObject
	name as zstring ptr
	bg_pixmap_name(0 to 5-1) as zstring ptr ptr
	font_desc as PangoFontDescription ptr
	color_flags(0 to 5-1) as GtkRcFlags ptr
	fg(0 to 5-1) as GdkColor ptr
	bg(0 to 5-1) as GdkColor ptr
	text(0 to 5-1) as GdkColor ptr
	base(0 to 5-1) as GdkColor ptr
	xthickness as gint
	ythickness as gint
	rc_properties as GArray ptr
	rc_style_lists as GSList ptr
	icon_factories as GSList ptr
	engine_specified as guint
end type

type _GtkRcStyleClass
	parent_class as GObjectClass
	create_rc_style as function cdecl(byval as GtkRcStyle ptr) as GtkRcStyle
	parse as function cdecl(byval as GtkRcStyle ptr, byval as GtkSettings ptr, byval as GScanner ptr) as guint
	merge as sub cdecl(byval as GtkRcStyle ptr, byval as GtkRcStyle ptr)
	create_style as function cdecl(byval as GtkRcStyle ptr) as GtkStyle
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare sub _gtk_rc_init cdecl alias "_gtk_rc_init" ()
declare sub gtk_rc_add_default_file cdecl alias "gtk_rc_add_default_file" (byval filename as string)
declare sub gtk_rc_set_default_files cdecl alias "gtk_rc_set_default_files" (byval filenames as zstring ptr ptr)
declare function gtk_rc_get_default_files cdecl alias "gtk_rc_get_default_files" () as zstring ptr ptr
declare function gtk_rc_get_style cdecl alias "gtk_rc_get_style" (byval widget as GtkWidget ptr) as GtkStyle ptr
declare function gtk_rc_get_style_by_paths cdecl alias "gtk_rc_get_style_by_paths" (byval settings as GtkSettings ptr, byval widget_path as string, byval class_path as string, byval type as GType) as GtkStyle ptr
declare function gtk_rc_reparse_all_for_settings cdecl alias "gtk_rc_reparse_all_for_settings" (byval settings as GtkSettings ptr, byval force_load as gboolean) as gboolean
declare sub gtk_rc_reset_styles cdecl alias "gtk_rc_reset_styles" (byval settings as GtkSettings ptr)
declare function gtk_rc_find_pixmap_in_path cdecl alias "gtk_rc_find_pixmap_in_path" (byval settings as GtkSettings ptr, byval scanner as GScanner ptr, byval pixmap_file as string) as zstring ptr
declare sub gtk_rc_parse cdecl alias "gtk_rc_parse" (byval filename as string)
declare sub gtk_rc_parse_string cdecl alias "gtk_rc_parse_string" (byval rc_string as string)
declare function gtk_rc_reparse_all cdecl alias "gtk_rc_reparse_all" () as gboolean
declare sub gtk_rc_add_widget_name_style cdecl alias "gtk_rc_add_widget_name_style" (byval rc_style as GtkRcStyle ptr, byval pattern as string)
declare sub gtk_rc_add_widget_class_style cdecl alias "gtk_rc_add_widget_class_style" (byval rc_style as GtkRcStyle ptr, byval pattern as string)
declare sub gtk_rc_add_class_style cdecl alias "gtk_rc_add_class_style" (byval rc_style as GtkRcStyle ptr, byval pattern as string)
declare function gtk_rc_style_get_type cdecl alias "gtk_rc_style_get_type" () as GType
declare function gtk_rc_style_new cdecl alias "gtk_rc_style_new" () as GtkRcStyle ptr
declare function gtk_rc_style_copy cdecl alias "gtk_rc_style_copy" (byval orig as GtkRcStyle ptr) as GtkRcStyle ptr
declare sub gtk_rc_style_ref cdecl alias "gtk_rc_style_ref" (byval rc_style as GtkRcStyle ptr)
declare sub gtk_rc_style_unref cdecl alias "gtk_rc_style_unref" (byval rc_style as GtkRcStyle ptr)
declare function gtk_rc_find_module_in_path cdecl alias "gtk_rc_find_module_in_path" (byval module_file as string) as zstring ptr
declare function gtk_rc_get_theme_dir cdecl alias "gtk_rc_get_theme_dir" () as zstring ptr
declare function gtk_rc_get_module_dir cdecl alias "gtk_rc_get_module_dir" () as zstring ptr
declare function gtk_rc_get_im_module_path cdecl alias "gtk_rc_get_im_module_path" () as zstring ptr
declare function gtk_rc_get_im_module_file cdecl alias "gtk_rc_get_im_module_file" () as zstring ptr

enum GtkRcTokenType
	GTK_RC_TOKEN_INVALID = G_TOKEN_LAST
	GTK_RC_TOKEN_INCLUDE
	GTK_RC_TOKEN_NORMAL
	GTK_RC_TOKEN_ACTIVE
	GTK_RC_TOKEN_PRELIGHT
	GTK_RC_TOKEN_SELECTED
	GTK_RC_TOKEN_INSENSITIVE
	GTK_RC_TOKEN_FG
	GTK_RC_TOKEN_BG
	GTK_RC_TOKEN_TEXT
	GTK_RC_TOKEN_BASE
	GTK_RC_TOKEN_XTHICKNESS
	GTK_RC_TOKEN_YTHICKNESS
	GTK_RC_TOKEN_FONT
	GTK_RC_TOKEN_FONTSET
	GTK_RC_TOKEN_FONT_NAME
	GTK_RC_TOKEN_BG_PIXMAP
	GTK_RC_TOKEN_PIXMAP_PATH
	GTK_RC_TOKEN_STYLE
	GTK_RC_TOKEN_BINDING
	GTK_RC_TOKEN_BIND
	GTK_RC_TOKEN_WIDGET
	GTK_RC_TOKEN_WIDGET_CLASS
	GTK_RC_TOKEN_CLASS
	GTK_RC_TOKEN_LOWEST
	GTK_RC_TOKEN_GTK
	GTK_RC_TOKEN_APPLICATION
	GTK_RC_TOKEN_THEME
	GTK_RC_TOKEN_RC
	GTK_RC_TOKEN_HIGHEST
	GTK_RC_TOKEN_ENGINE
	GTK_RC_TOKEN_MODULE_PATH
	GTK_RC_TOKEN_IM_MODULE_PATH
	GTK_RC_TOKEN_IM_MODULE_FILE
	GTK_RC_TOKEN_STOCK
	GTK_RC_TOKEN_LTR
	GTK_RC_TOKEN_RTL
	GTK_RC_TOKEN_LAST
end enum


declare function gtk_rc_scanner_new cdecl alias "gtk_rc_scanner_new" () as GScanner ptr
declare function gtk_rc_parse_color cdecl alias "gtk_rc_parse_color" (byval scanner as GScanner ptr, byval color as GdkColor ptr) as guint
declare function gtk_rc_parse_state cdecl alias "gtk_rc_parse_state" (byval scanner as GScanner ptr, byval state as GtkStateType ptr) as guint
declare function gtk_rc_parse_priority cdecl alias "gtk_rc_parse_priority" (byval scanner as GScanner ptr, byval priority as GtkPathPriorityType ptr) as guint

type _GtkRcProperty
	type_name as GQuark
	property_name as GQuark
	origin as zstring ptr
	value as GValue
end type

declare function _gtk_rc_style_lookup_rc_property cdecl alias "_gtk_rc_style_lookup_rc_property" (byval rc_style as GtkRcStyle ptr, byval type_name as GQuark, byval property_name as GQuark) as GtkRcProperty ptr
declare function _gtk_rc_context_get_default_font_name cdecl alias "_gtk_rc_context_get_default_font_name" (byval settings as GtkSettings ptr) as zstring ptr

#endif
