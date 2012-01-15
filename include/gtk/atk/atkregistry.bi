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
#include once "atkobjectfactory.bi"

#define ATK_TYPE_REGISTRY() atk_registry_get_type ()
#define ATK_REGISTRY(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_REGISTRY, AtkRegistry)
#define ATK_REGISTRY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_REGISTRY, AtkRegistryClass)
#define ATK_IS_REGISTRY(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_REGISTRY)
#define ATK_IS_REGISTRY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_REGISTRY)
#define ATK_REGISTRY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_REGISTRY, AtkRegistryClass)

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

declare function atk_registry_get_type () as GType
declare sub atk_registry_set_factory_type (byval registry as AtkRegistry ptr, byval type as GType, byval factory_type as GType)
declare function atk_registry_get_factory_type (byval registry as AtkRegistry ptr, byval type as GType) as GType
declare function atk_registry_get_factory (byval registry as AtkRegistry ptr, byval type as GType) as AtkObjectFactory ptr
declare function atk_get_default_registry () as AtkRegistry ptr

#endif
