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
#include once "atkobject.bi"

#define ATK_TYPE_OBJECT_FACTORY() atk_object_factory_get_type ()
#define ATK_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactory)
#define ATK_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass)
#define ATK_IS_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_OBJECT_FACTORY)
#define ATK_IS_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_OBJECT_FACTORY)
#define ATK_OBJECT_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass)

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

declare function atk_object_factory_get_type () as GType
declare function atk_object_factory_create_accessible (byval factory as AtkObjectFactory ptr, byval obj as GObject ptr) as AtkObject ptr
declare sub atk_object_factory_invalidate (byval factory as AtkObjectFactory ptr)
declare function atk_object_factory_get_accessible_type (byval factory as AtkObjectFactory ptr) as GType

#endif
