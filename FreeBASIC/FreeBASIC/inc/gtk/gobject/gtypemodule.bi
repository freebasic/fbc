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

#include once "gobject.bi"
#include once "genums.bi"

#define G_TYPE_TYPE_MODULE (g_type_module_get_type ())
#define G_TYPE_MODULE(module) (G_TYPE_CHECK_INSTANCE_CAST ((module), G_TYPE_TYPE_MODULE, GTypeModule))
#define G_TYPE_MODULE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_TYPE_MODULE, GTypeModuleClass))
#define G_IS_TYPE_MODULE(module) (G_TYPE_CHECK_INSTANCE_TYPE ((module), G_TYPE_TYPE_MODULE))
#define G_IS_TYPE_MODULE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_TYPE_MODULE))
#define G_TYPE_MODULE_GET_CLASS(module) (G_TYPE_INSTANCE_GET_CLASS ((module), G_TYPE_TYPE_MODULE, GTypeModuleClass))

type GTypeModule as _GTypeModule
type GTypeModuleClass as _GTypeModuleClass

type _GTypeModule
	parent_instance as GObject
	use_count as guint
	type_infos as GSList ptr
	interface_infos as GSList ptr
	name as zstring ptr
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

declare function g_type_module_get_type () as GType
declare function g_type_module_use (byval module as GTypeModule ptr) as gboolean
declare sub g_type_module_unuse (byval module as GTypeModule ptr)
declare sub g_type_module_set_name (byval module as GTypeModule ptr, byval name as zstring ptr)
declare function g_type_module_register_type (byval module as GTypeModule ptr, byval parent_type as GType, byval type_name as zstring ptr, byval type_info as GTypeInfo ptr, byval flags as GTypeFlags) as GType
declare sub g_type_module_add_interface (byval module as GTypeModule ptr, byval instance_type as GType, byval interface_type as GType, byval interface_info as GInterfaceInfo ptr)
declare function g_type_module_register_enum (byval module as GTypeModule ptr, byval name as zstring ptr, byval const_static_values as GEnumValue ptr) as GType
declare function g_type_module_register_flags (byval module as GTypeModule ptr, byval name as zstring ptr, byval const_static_values as GFlagsValue ptr) as GType

#endif
