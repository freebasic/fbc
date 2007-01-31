''
''
'' gtkaccelmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaccelmap_bi__
#define __gtkaccelmap_bi__

#include once "gtkaccelgroup.bi"

#define GTK_TYPE_ACCEL_MAP (gtk_accel_map_get_type ())
#define GTK_ACCEL_MAP(accel_map) (G_TYPE_CHECK_INSTANCE_CAST ((accel_map), GTK_TYPE_ACCEL_MAP, GtkAccelMap))
#define GTK_ACCEL_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass))
#define GTK_IS_ACCEL_MAP(accel_map) (G_TYPE_CHECK_INSTANCE_TYPE ((accel_map), GTK_TYPE_ACCEL_MAP))
#define GTK_IS_ACCEL_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCEL_MAP))
#define GTK_ACCEL_MAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass))

type GtkAccelMap as _GtkAccelMap
type GtkAccelMapClass as _GtkAccelMapClass

type GtkAccelMapForeach as sub cdecl(byval as gpointer, byval as zstring ptr, byval as guint, byval as GdkModifierType, byval as gboolean)

#ifdef __FB_Win32__
/' Reserve old names for DLL ABI backward compatibility '/
#define gtk_accel_map_load gtk_accel_map_load_utf8
#define gtk_accel_map_save gtk_accel_map_save_utf8
#endif

declare sub gtk_accel_map_add_entry (byval accel_path as zstring ptr, byval accel_key as guint, byval accel_mods as GdkModifierType)
declare function gtk_accel_map_lookup_entry (byval accel_path as zstring ptr, byval key as GtkAccelKey ptr) as gboolean
declare function gtk_accel_map_change_entry (byval accel_path as zstring ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval replace as gboolean) as gboolean
declare sub gtk_accel_map_load (byval file_name as zstring ptr)
declare sub gtk_accel_map_save (byval file_name as zstring ptr)
declare sub gtk_accel_map_foreach (byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare sub gtk_accel_map_load_fd (byval fd as gint)
declare sub gtk_accel_map_load_scanner (byval scanner as GScanner ptr)
declare sub gtk_accel_map_save_fd (byval fd as gint)
declare sub gtk_accel_map_lock_path (byval accel_path as zstring ptr)
declare sub gtk_accel_map_unlock_path (byval accel_path as zstring ptr)
declare sub gtk_accel_map_add_filter (byval filter_pattern as zstring ptr)
declare sub gtk_accel_map_foreach_unfiltered (byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare function gtk_accel_map_get_type () as GType
declare function gtk_accel_map_get () as GtkAccelMap ptr
declare sub _gtk_accel_map_init ()
declare sub _gtk_accel_map_add_group (byval accel_path as zstring ptr, byval accel_group as GtkAccelGroup ptr)
declare sub _gtk_accel_map_remove_group (byval accel_path as zstring ptr, byval accel_group as GtkAccelGroup ptr)
declare function _gtk_accel_path_is_valid (byval accel_path as zstring ptr) as gboolean

#endif
