''
''
'' gtypemodule -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtypemodule_bi__
#define __gtypemodule_bi__

#include once "gtk/gobject/gobject.bi"
#include once "gtk/gobject/genums.bi"

type GTypeModule as _GTypeModule
type GTypeModuleClass as _GTypeModuleClass

type _GTypeModule
	parent_instance as GObject
	use_count as guint
	type_infos as GSList ptr
	interface_infos as GSList ptr
	name as gchar ptr
end type

type _GTypeModuleClass
	parent_class as GObjectClass
	load as function cdecl(byval as GTypeModule ptr) as gboolean
	unload as sub cdecl(byval as GTypeModule ptr)
	reserved1 as sub cdecl()
	reserved2 as sub cdecl()
	reserved3 as sub cdecl()
	reserved4 as sub cdecl()
end type

declare function g_type_module_get_type cdecl alias "g_type_module_get_type" () as GType
declare function g_type_module_use cdecl alias "g_type_module_use" (byval module as GTypeModule ptr) as gboolean
declare sub g_type_module_unuse cdecl alias "g_type_module_unuse" (byval module as GTypeModule ptr)
declare sub g_type_module_set_name cdecl alias "g_type_module_set_name" (byval module as GTypeModule ptr, byval name as gchar ptr)
declare function g_type_module_register_type cdecl alias "g_type_module_register_type" (byval module as GTypeModule ptr, byval parent_type as GType, byval type_name as gchar ptr, byval type_info as GTypeInfo ptr, byval flags as GTypeFlags) as GType
declare sub g_type_module_add_interface cdecl alias "g_type_module_add_interface" (byval module as GTypeModule ptr, byval instance_type as GType, byval interface_type as GType, byval interface_info as GInterfaceInfo ptr)
declare function g_type_module_register_enum cdecl alias "g_type_module_register_enum" (byval module as GTypeModule ptr, byval name as gchar ptr, byval const_static_values as GEnumValue ptr) as GType
declare function g_type_module_register_flags cdecl alias "g_type_module_register_flags" (byval module as GTypeModule ptr, byval name as gchar ptr, byval const_static_values as GFlagsValue ptr) as GType

#endif
