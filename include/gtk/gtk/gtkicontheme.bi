''
''
'' gtkicontheme -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkicontheme_bi__
#define __gtkicontheme_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/gdk-pixbuf.bi"
#include once "gtk/gdk/gdkscreen.bi"

#define GTK_TYPE_ICON_INFO (gtk_icon_info_get_type ())

#define GTK_TYPE_ICON_THEME (gtk_icon_theme_get_type ())
#define GTK_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ICON_THEME, GtkIconTheme))
#define GTK_ICON_THEME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_THEME, GtkIconThemeClass))
#define GTK_IS_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ICON_THEME))
#define GTK_IS_ICON_THEME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_THEME))
#define GTK_ICON_THEME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ICON_THEME, GtkIconThemeClass))

type GtkIconInfo as _GtkIconInfo
type GtkIconTheme as _GtkIconTheme
type GtkIconThemeClass as _GtkIconThemeClass
type GtkIconThemePrivate as _GtkIconThemePrivate

type _GtkIconTheme
	parent_instance as GObject
	priv as GtkIconThemePrivate ptr
end type

type _GtkIconThemeClass
	parent_class as GObjectClass
	changed as sub cdecl(byval as GtkIconTheme ptr)
end type

enum GtkIconLookupFlags
	GTK_ICON_LOOKUP_NO_SVG = 1 shl 0
	GTK_ICON_LOOKUP_FORCE_SVG = 1 shl 1
	GTK_ICON_LOOKUP_USE_BUILTIN = 1 shl 2
end enum


enum GtkIconThemeError
	GTK_ICON_THEME_NOT_FOUND
	GTK_ICON_THEME_FAILED
end enum


declare function gtk_icon_theme_error_quark () as GQuark

#ifdef __FB_Win32__
/' Reserve old name for DLL ABI backward compatibility '/
#define gtk_icon_theme_set_search_path gtk_icon_theme_set_search_path_utf8
#define gtk_icon_theme_get_search_path gtk_icon_theme_get_search_path_utf8
#define gtk_icon_theme_append_search_path gtk_icon_theme_append_search_path_utf8
#define gtk_icon_theme_prepend_search_path gtk_icon_theme_prepend_search_path_utf8
#define gtk_icon_info_get_filename gtk_icon_info_get_filename_utf8
#endif

declare function gtk_icon_theme_get_type () as GType
declare function gtk_icon_theme_new () as GtkIconTheme ptr
declare function gtk_icon_theme_get_default () as GtkIconTheme ptr
declare function gtk_icon_theme_get_for_screen (byval screen as GdkScreen ptr) as GtkIconTheme ptr
declare sub gtk_icon_theme_set_screen (byval icon_theme as GtkIconTheme ptr, byval screen as GdkScreen ptr)
declare sub gtk_icon_theme_set_search_path (byval icon_theme as GtkIconTheme ptr, byval path as zstring ptr ptr, byval n_elements as gint)
declare sub gtk_icon_theme_get_search_path (byval icon_theme as GtkIconTheme ptr, byval path as zstring ptr ptr ptr, byval n_elements as gint ptr)
declare sub gtk_icon_theme_append_search_path (byval icon_theme as GtkIconTheme ptr, byval path as zstring ptr)
declare sub gtk_icon_theme_prepend_search_path (byval icon_theme as GtkIconTheme ptr, byval path as zstring ptr)
declare sub gtk_icon_theme_set_custom_theme (byval icon_theme as GtkIconTheme ptr, byval theme_name as zstring ptr)
declare function gtk_icon_theme_has_icon (byval icon_theme as GtkIconTheme ptr, byval icon_name as zstring ptr) as gboolean
declare function gtk_icon_theme_get_icon_sizes (byval icon_theme as GtkIconTheme ptr, byval icon_name as zstring ptr) as gint ptr
declare function gtk_icon_theme_lookup_icon (byval icon_theme as GtkIconTheme ptr, byval icon_name as zstring ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_load_icon (byval icon_theme as GtkIconTheme ptr, byval icon_name as zstring ptr, byval size as gint, byval flags as GtkIconLookupFlags, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_theme_list_icons (byval icon_theme as GtkIconTheme ptr, byval context as zstring ptr) as GList ptr
declare function gtk_icon_theme_get_example_icon_name (byval icon_theme as GtkIconTheme ptr) as zstring ptr
declare function gtk_icon_theme_rescan_if_needed (byval icon_theme as GtkIconTheme ptr) as gboolean
declare sub gtk_icon_theme_add_builtin_icon (byval icon_name as zstring ptr, byval size as gint, byval pixbuf as GdkPixbuf ptr)
declare function gtk_icon_info_get_type () as GType
declare function gtk_icon_info_copy (byval icon_info as GtkIconInfo ptr) as GtkIconInfo ptr
declare sub gtk_icon_info_free (byval icon_info as GtkIconInfo ptr)
declare function gtk_icon_info_get_base_size (byval icon_info as GtkIconInfo ptr) as gint
declare function gtk_icon_info_get_filename (byval icon_info as GtkIconInfo ptr) as zstring ptr
declare function gtk_icon_info_get_builtin_pixbuf (byval icon_info as GtkIconInfo ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_icon (byval icon_info as GtkIconInfo ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gtk_icon_info_set_raw_coordinates (byval icon_info as GtkIconInfo ptr, byval raw_coordinates as gboolean)
declare function gtk_icon_info_get_embedded_rect (byval icon_info as GtkIconInfo ptr, byval rectangle as GdkRectangle ptr) as gboolean
declare function gtk_icon_info_get_attach_points (byval icon_info as GtkIconInfo ptr, byval points as GdkPoint ptr ptr, byval n_points as gint ptr) as gboolean
declare function gtk_icon_info_get_display_name (byval icon_info as GtkIconInfo ptr) as zstring ptr

#endif
