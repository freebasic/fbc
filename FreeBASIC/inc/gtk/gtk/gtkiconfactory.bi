''
''
'' gtkiconfactory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkiconfactory_bi__
#define __gtkiconfactory_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkrc.bi"

type GtkIconFactoryClass as _GtkIconFactoryClass

type _GtkIconFactory
	parent_instance as GObject
	icons as GHashTable ptr
end type

type _GtkIconFactoryClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_icon_factory_get_type cdecl alias "gtk_icon_factory_get_type" () as GType
declare function gtk_icon_factory_new cdecl alias "gtk_icon_factory_new" () as GtkIconFactory ptr
declare sub gtk_icon_factory_add cdecl alias "gtk_icon_factory_add" (byval factory as GtkIconFactory ptr, byval stock_id as gchar ptr, byval icon_set as GtkIconSet ptr)
declare function gtk_icon_factory_lookup cdecl alias "gtk_icon_factory_lookup" (byval factory as GtkIconFactory ptr, byval stock_id as gchar ptr) as GtkIconSet ptr
declare sub gtk_icon_factory_add_default cdecl alias "gtk_icon_factory_add_default" (byval factory as GtkIconFactory ptr)
declare sub gtk_icon_factory_remove_default cdecl alias "gtk_icon_factory_remove_default" (byval factory as GtkIconFactory ptr)
declare function gtk_icon_factory_lookup_default cdecl alias "gtk_icon_factory_lookup_default" (byval stock_id as gchar ptr) as GtkIconSet ptr
declare function gtk_icon_size_lookup cdecl alias "gtk_icon_size_lookup" (byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_lookup_for_settings cdecl alias "gtk_icon_size_lookup_for_settings" (byval settings as GtkSettings ptr, byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_register cdecl alias "gtk_icon_size_register" (byval name as gchar ptr, byval width as gint, byval height as gint) as GtkIconSize
declare sub gtk_icon_size_register_alias cdecl alias "gtk_icon_size_register_alias" (byval alias as gchar ptr, byval target as GtkIconSize)
declare function gtk_icon_size_from_name cdecl alias "gtk_icon_size_from_name" (byval name as gchar ptr) as GtkIconSize
declare function gtk_icon_size_get_name cdecl alias "gtk_icon_size_get_name" (byval size as GtkIconSize) as gchar ptr
declare function gtk_icon_set_get_type cdecl alias "gtk_icon_set_get_type" () as GType
declare function gtk_icon_set_new cdecl alias "gtk_icon_set_new" () as GtkIconSet ptr
declare function gtk_icon_set_new_from_pixbuf cdecl alias "gtk_icon_set_new_from_pixbuf" (byval pixbuf as GdkPixbuf ptr) as GtkIconSet ptr
declare function gtk_icon_set_ref cdecl alias "gtk_icon_set_ref" (byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare sub gtk_icon_set_unref cdecl alias "gtk_icon_set_unref" (byval icon_set as GtkIconSet ptr)
declare function gtk_icon_set_copy cdecl alias "gtk_icon_set_copy" (byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare function gtk_icon_set_render_icon cdecl alias "gtk_icon_set_render_icon" (byval icon_set as GtkIconSet ptr, byval style as GtkStyle ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as string) as GdkPixbuf ptr
declare sub gtk_icon_set_add_source cdecl alias "gtk_icon_set_add_source" (byval icon_set as GtkIconSet ptr, byval source as GtkIconSource ptr)
declare sub gtk_icon_set_get_sizes cdecl alias "gtk_icon_set_get_sizes" (byval icon_set as GtkIconSet ptr, byval sizes as GtkIconSize ptr ptr, byval n_sizes as gint ptr)
declare function gtk_icon_source_get_type cdecl alias "gtk_icon_source_get_type" () as GType
declare function gtk_icon_source_new cdecl alias "gtk_icon_source_new" () as GtkIconSource ptr
declare function gtk_icon_source_copy cdecl alias "gtk_icon_source_copy" (byval source as GtkIconSource ptr) as GtkIconSource ptr
declare sub gtk_icon_source_free cdecl alias "gtk_icon_source_free" (byval source as GtkIconSource ptr)
declare sub gtk_icon_source_set_filename cdecl alias "gtk_icon_source_set_filename" (byval source as GtkIconSource ptr, byval filename as gchar ptr)
declare sub gtk_icon_source_set_icon_name cdecl alias "gtk_icon_source_set_icon_name" (byval source as GtkIconSource ptr, byval icon_name as gchar ptr)
declare sub gtk_icon_source_set_pixbuf cdecl alias "gtk_icon_source_set_pixbuf" (byval source as GtkIconSource ptr, byval pixbuf as GdkPixbuf ptr)
declare function gtk_icon_source_get_filename cdecl alias "gtk_icon_source_get_filename" (byval source as GtkIconSource ptr) as gchar ptr
declare function gtk_icon_source_get_icon_name cdecl alias "gtk_icon_source_get_icon_name" (byval source as GtkIconSource ptr) as gchar ptr
declare function gtk_icon_source_get_pixbuf cdecl alias "gtk_icon_source_get_pixbuf" (byval source as GtkIconSource ptr) as GdkPixbuf ptr
declare sub gtk_icon_source_set_direction_wildcarded cdecl alias "gtk_icon_source_set_direction_wildcarded" (byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_state_wildcarded cdecl alias "gtk_icon_source_set_state_wildcarded" (byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_size_wildcarded cdecl alias "gtk_icon_source_set_size_wildcarded" (byval source as GtkIconSource ptr, byval setting as gboolean)
declare function gtk_icon_source_get_size_wildcarded cdecl alias "gtk_icon_source_get_size_wildcarded" (byval source as GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_state_wildcarded cdecl alias "gtk_icon_source_get_state_wildcarded" (byval source as GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_direction_wildcarded cdecl alias "gtk_icon_source_get_direction_wildcarded" (byval source as GtkIconSource ptr) as gboolean
declare sub gtk_icon_source_set_direction cdecl alias "gtk_icon_source_set_direction" (byval source as GtkIconSource ptr, byval direction as GtkTextDirection)
declare sub gtk_icon_source_set_state cdecl alias "gtk_icon_source_set_state" (byval source as GtkIconSource ptr, byval state as GtkStateType)
declare sub gtk_icon_source_set_size cdecl alias "gtk_icon_source_set_size" (byval source as GtkIconSource ptr, byval size as GtkIconSize)
declare function gtk_icon_source_get_direction cdecl alias "gtk_icon_source_get_direction" (byval source as GtkIconSource ptr) as GtkTextDirection
declare function gtk_icon_source_get_state cdecl alias "gtk_icon_source_get_state" (byval source as GtkIconSource ptr) as GtkStateType
declare function gtk_icon_source_get_size cdecl alias "gtk_icon_source_get_size" (byval source as GtkIconSource ptr) as GtkIconSize
declare sub _gtk_icon_set_invalidate_caches cdecl alias "_gtk_icon_set_invalidate_caches" ()
declare function _gtk_icon_factory_list_ids cdecl alias "_gtk_icon_factory_list_ids" () as GSList ptr
declare sub _gtk_icon_factory_ensure_default_icons cdecl alias "_gtk_icon_factory_ensure_default_icons" ()

#endif
