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
#include once "gtkrc.bi"

#define GTK_TYPE_ICON_FACTORY (gtk_icon_factory_get_type ())
#define GTK_ICON_FACTORY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ICON_FACTORY, GtkIconFactory))
#define GTK_ICON_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass))
#define GTK_IS_ICON_FACTORY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ICON_FACTORY))
#define GTK_IS_ICON_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_FACTORY))
#define GTK_ICON_FACTORY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass))
#define GTK_TYPE_ICON_SET (gtk_icon_set_get_type ())
#define GTK_TYPE_ICON_SOURCE (gtk_icon_source_get_type ())

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

#ifdef __FB_Win32__
/' Reserve old names for DLL ABI backward compatibility '/
#define gtk_icon_source_set_filename gtk_icon_source_set_filename_utf8
#define gtk_icon_source_get_filename gtk_icon_source_get_filename_utf8
#endif

declare function gtk_icon_factory_get_type () as GType
declare function gtk_icon_factory_new () as GtkIconFactory ptr
declare sub gtk_icon_factory_add (byval factory as GtkIconFactory ptr, byval stock_id as zstring ptr, byval icon_set as GtkIconSet ptr)
declare function gtk_icon_factory_lookup (byval factory as GtkIconFactory ptr, byval stock_id as zstring ptr) as GtkIconSet ptr
declare sub gtk_icon_factory_add_default (byval factory as GtkIconFactory ptr)
declare sub gtk_icon_factory_remove_default (byval factory as GtkIconFactory ptr)
declare function gtk_icon_factory_lookup_default (byval stock_id as zstring ptr) as GtkIconSet ptr
declare function gtk_icon_size_lookup (byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_lookup_for_settings (byval settings as GtkSettings ptr, byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_register (byval name as zstring ptr, byval width as gint, byval height as gint) as GtkIconSize
declare sub gtk_icon_size_register_alias (byval alias as zstring ptr, byval target as GtkIconSize)
declare function gtk_icon_size_from_name (byval name as zstring ptr) as GtkIconSize
declare function gtk_icon_size_get_name (byval size as GtkIconSize) as zstring ptr
declare function gtk_icon_set_get_type () as GType
declare function gtk_icon_set_new () as GtkIconSet ptr
declare function gtk_icon_set_new_from_pixbuf (byval pixbuf as GdkPixbuf ptr) as GtkIconSet ptr
declare function gtk_icon_set_ref (byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare sub gtk_icon_set_unref (byval icon_set as GtkIconSet ptr)
declare function gtk_icon_set_copy (byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare function gtk_icon_set_render_icon (byval icon_set as GtkIconSet ptr, byval style as GtkStyle ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as zstring ptr) as GdkPixbuf ptr
declare sub gtk_icon_set_add_source (byval icon_set as GtkIconSet ptr, byval source as GtkIconSource ptr)
declare sub gtk_icon_set_get_sizes (byval icon_set as GtkIconSet ptr, byval sizes as GtkIconSize ptr ptr, byval n_sizes as gint ptr)
declare function gtk_icon_source_get_type () as GType
declare function gtk_icon_source_new () as GtkIconSource ptr
declare function gtk_icon_source_copy (byval source as GtkIconSource ptr) as GtkIconSource ptr
declare sub gtk_icon_source_free (byval source as GtkIconSource ptr)
declare sub gtk_icon_source_set_filename (byval source as GtkIconSource ptr, byval filename as zstring ptr)
declare sub gtk_icon_source_set_icon_name (byval source as GtkIconSource ptr, byval icon_name as zstring ptr)
declare sub gtk_icon_source_set_pixbuf (byval source as GtkIconSource ptr, byval pixbuf as GdkPixbuf ptr)
declare function gtk_icon_source_get_filename (byval source as GtkIconSource ptr) as zstring ptr
declare function gtk_icon_source_get_icon_name (byval source as GtkIconSource ptr) as zstring ptr
declare function gtk_icon_source_get_pixbuf (byval source as GtkIconSource ptr) as GdkPixbuf ptr
declare sub gtk_icon_source_set_direction_wildcarded (byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_state_wildcarded (byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_size_wildcarded (byval source as GtkIconSource ptr, byval setting as gboolean)
declare function gtk_icon_source_get_size_wildcarded (byval source as GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_state_wildcarded (byval source as GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_direction_wildcarded (byval source as GtkIconSource ptr) as gboolean
declare sub gtk_icon_source_set_direction (byval source as GtkIconSource ptr, byval direction as GtkTextDirection)
declare sub gtk_icon_source_set_state (byval source as GtkIconSource ptr, byval state as GtkStateType)
declare sub gtk_icon_source_set_size (byval source as GtkIconSource ptr, byval size as GtkIconSize)
declare function gtk_icon_source_get_direction (byval source as GtkIconSource ptr) as GtkTextDirection
declare function gtk_icon_source_get_state (byval source as GtkIconSource ptr) as GtkStateType
declare function gtk_icon_source_get_size (byval source as GtkIconSource ptr) as GtkIconSize
declare sub _gtk_icon_set_invalidate_caches ()
declare function _gtk_icon_factory_list_ids () as GSList ptr
declare sub _gtk_icon_factory_ensure_default_icons ()

#endif
