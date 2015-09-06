'' FreeBASIC binding for glib-2.44.1
''
'' based on the C header files:
''   GMODULE - GLIB wrapper code for dynamic module loading
''   Copyright (C) 1998 Tim Janik
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gmodule-2.0"

#include once "glib.bi"

#ifdef __FB_WIN32__
	'' The following symbols have been renamed:
	''     procedure g_module_open => g_module_open_
	''     procedure g_module_name => g_module_name_
#endif

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GMODULE_H__

type GModuleFlags as long
enum
	G_MODULE_BIND_LAZY = 1 shl 0
	G_MODULE_BIND_LOCAL = 1 shl 1
	G_MODULE_BIND_MASK = &h03
end enum

type GModule as _GModule
type GModuleCheckInit as function(byval module as GModule ptr) as const gchar ptr
type GModuleUnload as sub(byval module as GModule ptr)
declare function g_module_supported() as gboolean

#ifdef __FB_UNIX__
	declare function g_module_open(byval file_name as const gchar ptr, byval flags as GModuleFlags) as GModule ptr
#else
	declare function g_module_open_ alias "g_module_open"(byval file_name as const gchar ptr, byval flags as GModuleFlags) as GModule ptr
#endif

declare function g_module_close(byval module as GModule ptr) as gboolean
declare sub g_module_make_resident(byval module as GModule ptr)
declare function g_module_error() as const gchar ptr
declare function g_module_symbol(byval module as GModule ptr, byval symbol_name as const gchar ptr, byval symbol as gpointer ptr) as gboolean

#ifdef __FB_UNIX__
	declare function g_module_name(byval module as GModule ptr) as const gchar ptr
#else
	declare function g_module_name_ alias "g_module_name"(byval module as GModule ptr) as const gchar ptr
#endif

declare function g_module_build_path(byval directory as const gchar ptr, byval module_name as const gchar ptr) as gchar ptr

#ifdef __FB_WIN32__
	declare function g_module_open_utf8(byval file_name as const gchar ptr, byval flags as GModuleFlags) as GModule ptr
	declare function g_module_open alias "g_module_open_utf8"(byval file_name as const gchar ptr, byval flags as GModuleFlags) as GModule ptr
	declare function g_module_name_utf8(byval module as GModule ptr) as const gchar ptr
	declare function g_module_name alias "g_module_name_utf8"(byval module as GModule ptr) as const gchar ptr
#endif

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
