''
''
'' atkregistry -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkregistry_bi__
#define __atkregistry_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/atk/atkobjectfactory.bi"

type _AtkRegistry
	parent as GObject
	factory_type_registry as GHashTable ptr
	factory_singleton_cache as GHashTable ptr
end type

type _AtkRegistryClass
	parent_class as GObjectClass
end type

type AtkRegistry as _AtkRegistry
type AtkRegistryClass as _AtkRegistryClass

declare function atk_registry_get_type cdecl alias "atk_registry_get_type" () as GType
declare sub atk_registry_set_factory_type cdecl alias "atk_registry_set_factory_type" (byval registry as AtkRegistry ptr, byval type as GType, byval factory_type as GType)
declare function atk_registry_get_factory_type cdecl alias "atk_registry_get_factory_type" (byval registry as AtkRegistry ptr, byval type as GType) as GType
declare function atk_registry_get_factory cdecl alias "atk_registry_get_factory" (byval registry as AtkRegistry ptr, byval type as GType) as AtkObjectFactory ptr
declare function atk_get_default_registry cdecl alias "atk_get_default_registry" () as AtkRegistry ptr

#endif
