''
''
'' gtkmodules -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmodules_bi__
#define __gtkmodules_bi__

#include once "gtk/gtk/gtksettings.bi"

declare function _gtk_find_module cdecl alias "_gtk_find_module" (byval name as gchar ptr, byval type as gchar ptr) as gchar ptr
declare function _gtk_get_module_path cdecl alias "_gtk_get_module_path" (byval type as gchar ptr) as gchar ptr ptr
declare sub _gtk_modules_init cdecl alias "_gtk_modules_init" (byval argc as gint ptr, byval argv as gchar ptr ptr ptr, byval gtk_modules_args as gchar ptr)
declare sub _gtk_modules_settings_changed cdecl alias "_gtk_modules_settings_changed" (byval settings as GtkSettings ptr, byval modules as gchar ptr)

type GtkModuleInitFunc as sub cdecl(byval as gint ptr, byval as gchar ptr ptr ptr)
type GtkModuleDisplayInitFunc as sub cdecl(byval as GdkDisplay ptr)

#endif
