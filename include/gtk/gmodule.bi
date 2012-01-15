''
''
'' gmodule -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmodule_bi__
#define __gmodule_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "gmodule-2.0"

enum GModuleFlags
  G_MODULE_BIND_LAZY	= 1 shl 0
  G_MODULE_BIND_LOCAL	= 1 shl 1
  G_MODULE_BIND_MASK	= &h03
end enum

type GModule as _GModule
type GModuleCheckInit as function cdecl(byval as GModule ptr) as gchar
type GModuleUnload as sub cdecl(byval as GModule ptr)

#ifdef __FB_WIN32__
#define g_module_open g_module_open_utf8
#define g_module_name g_module_name_utf8
#endif

declare function g_module_open (byval file_name as zstring ptr, byval flags as GModuleFlags) as GModule ptr
declare function g_module_close (byval module as GModule ptr) as gboolean
declare sub g_module_make_resident (byval module as GModule ptr)
declare function g_module_error () as zstring ptr
declare function g_module_symbol (byval module as GModule ptr, byval symbol_name as zstring ptr, byval symbol as gpointer ptr) as gboolean
declare function g_module_name (byval module as GModule ptr) as zstring ptr
declare function g_module_build_path (byval directory as zstring ptr, byval module_name as zstring ptr) as zstring ptr

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
