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

#include once "gtk/gtk/gtkaccelgroup.bi"

type GtkAccelMap as _GtkAccelMap
type GtkAccelMapClass as _GtkAccelMapClass
type GtkAccelMapForeach as sub cdecl(byval as gpointer, byval as gchar ptr, byval as guint, byval as GdkModifierType, byval as gboolean)

declare sub gtk_accel_map_add_entry cdecl alias "gtk_accel_map_add_entry" (byval accel_path as gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType)
declare function gtk_accel_map_lookup_entry cdecl alias "gtk_accel_map_lookup_entry" (byval accel_path as gchar ptr, byval key as GtkAccelKey ptr) as gboolean
declare function gtk_accel_map_change_entry cdecl alias "gtk_accel_map_change_entry" (byval accel_path as gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval replace as gboolean) as gboolean
declare sub gtk_accel_map_load cdecl alias "gtk_accel_map_load" (byval file_name as gchar ptr)
declare sub gtk_accel_map_save cdecl alias "gtk_accel_map_save" (byval file_name as gchar ptr)
declare sub gtk_accel_map_foreach cdecl alias "gtk_accel_map_foreach" (byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare sub gtk_accel_map_load_fd cdecl alias "gtk_accel_map_load_fd" (byval fd as gint)
declare sub gtk_accel_map_load_scanner cdecl alias "gtk_accel_map_load_scanner" (byval scanner as GScanner ptr)
declare sub gtk_accel_map_save_fd cdecl alias "gtk_accel_map_save_fd" (byval fd as gint)
declare sub gtk_accel_map_lock_path cdecl alias "gtk_accel_map_lock_path" (byval accel_path as gchar ptr)
declare sub gtk_accel_map_unlock_path cdecl alias "gtk_accel_map_unlock_path" (byval accel_path as gchar ptr)
declare sub gtk_accel_map_add_filter cdecl alias "gtk_accel_map_add_filter" (byval filter_pattern as gchar ptr)
declare sub gtk_accel_map_foreach_unfiltered cdecl alias "gtk_accel_map_foreach_unfiltered" (byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare function gtk_accel_map_get_type cdecl alias "gtk_accel_map_get_type" () as GType
declare function gtk_accel_map_get cdecl alias "gtk_accel_map_get" () as GtkAccelMap ptr
declare sub _gtk_accel_map_init cdecl alias "_gtk_accel_map_init" ()
declare sub _gtk_accel_map_add_group cdecl alias "_gtk_accel_map_add_group" (byval accel_path as gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare sub _gtk_accel_map_remove_group cdecl alias "_gtk_accel_map_remove_group" (byval accel_path as gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare function _gtk_accel_path_is_valid cdecl alias "_gtk_accel_path_is_valid" (byval accel_path as gchar ptr) as gboolean

#endif
