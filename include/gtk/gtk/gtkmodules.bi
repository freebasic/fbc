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

#include once "gtksettings.bi"

declare function _gtk_find_module (byval name as zstring ptr, byval type as zstring ptr) as zstring ptr
declare function _gtk_get_module_path (byval type as zstring ptr) as zstring ptr ptr
declare sub _gtk_modules_init (byval argc as gint ptr, byval argv as zstring ptr ptr ptr, byval gtk_modules_args as zstring ptr)
declare sub _gtk_modules_settings_changed (byval settings as GtkSettings ptr, byval modules as zstring ptr)

type GtkModuleInitFunc as sub cdecl(byval as gint ptr, byval as zstring ptr ptr ptr)
type GtkModuleDisplayInitFunc as sub cdecl(byval as GdkDisplay ptr)

#endif
