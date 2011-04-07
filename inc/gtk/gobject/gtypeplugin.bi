''
''
'' gtypeplugin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtypeplugin_bi__
#define __gtypeplugin_bi__

#include once "gtype.bi"

#define G_TYPE_TYPE_PLUGIN (g_type_plugin_get_type ())
#define G_TYPE_PLUGIN(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TYPE_PLUGIN, GTypePlugin))
#define G_TYPE_PLUGIN_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), G_TYPE_TYPE_PLUGIN, GTypePluginClass))
#define G_IS_TYPE_PLUGIN(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TYPE_PLUGIN))
#define G_IS_TYPE_PLUGIN_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), G_TYPE_TYPE_PLUGIN))
#define G_TYPE_PLUGIN_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), G_TYPE_TYPE_PLUGIN, GTypePluginClass))

type GTypePluginClass as _GTypePluginClass
type GTypePluginUse as sub cdecl(byval as GTypePlugin ptr)
type GTypePluginUnuse as sub cdecl(byval as GTypePlugin ptr)
type GTypePluginCompleteTypeInfo as sub cdecl(byval as GTypePlugin ptr, byval as GType, byval as GTypeInfo ptr, byval as GTypeValueTable ptr)
type GTypePluginCompleteInterfaceInfo as sub cdecl(byval as GTypePlugin ptr, byval as GType, byval as GType, byval as GInterfaceInfo ptr)

type _GTypePluginClass
	base_iface as GTypeInterface
	use_plugin as GTypePluginUse
	unuse_plugin as GTypePluginUnuse
	complete_type_info as GTypePluginCompleteTypeInfo
	complete_interface_info as GTypePluginCompleteInterfaceInfo
end type

declare function g_type_plugin_get_type () as GType
declare sub g_type_plugin_use (byval plugin as GTypePlugin ptr)
declare sub g_type_plugin_unuse (byval plugin as GTypePlugin ptr)
declare sub g_type_plugin_complete_type_info (byval plugin as GTypePlugin ptr, byval g_type as GType, byval info as GTypeInfo ptr, byval value_table as GTypeValueTable ptr)
declare sub g_type_plugin_complete_interface_info (byval plugin as GTypePlugin ptr, byval instance_type as GType, byval interface_type as GType, byval info as GInterfaceInfo ptr)

#endif
