''
''
'' atkobjectfactory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkobjectfactory_bi__
#define __atkobjectfactory_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/atk/atkobject.bi"

type AtkObjectFactory as _AtkObjectFactory
type AtkObjectFactoryClass as _AtkObjectFactoryClass

type _AtkObjectFactory
	parent as GObject
end type

type _AtkObjectFactoryClass
	parent_class as GObjectClass
	create_accessible as function cdecl(byval as GObject ptr) as AtkObject
	invalidate as sub cdecl(byval as AtkObjectFactory ptr)
	get_accessible_type as function cdecl() as GType
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_object_factory_get_type cdecl alias "atk_object_factory_get_type" () as GType
declare function atk_object_factory_create_accessible cdecl alias "atk_object_factory_create_accessible" (byval factory as AtkObjectFactory ptr, byval obj as GObject ptr) as AtkObject ptr
declare sub atk_object_factory_invalidate cdecl alias "atk_object_factory_invalidate" (byval factory as AtkObjectFactory ptr)
declare function atk_object_factory_get_accessible_type cdecl alias "atk_object_factory_get_accessible_type" (byval factory as AtkObjectFactory ptr) as GType

#endif
