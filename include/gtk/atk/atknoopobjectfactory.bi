''
''
'' atknoopobjectfactory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atknoopobjectfactory_bi__
#define __atknoopobjectfactory_bi__

#include once "atkobjectfactory.bi"

#define ATK_TYPE_NO_OP_OBJECT_FACTORY() atk_no_op_object_factory_get_type()
#define ATK_NO_OP_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactory)
#define ATK_NO_OP_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass)
#define ATK_IS_NO_OP_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY)
#define ATK_IS_NO_OP_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY)
#define ATK_NO_OP_OBJECT_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ( (obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass)

type AtkNoOpObjectFactory as _AtkNoOpObjectFactory
type AtkNoOpObjectFactoryClass as _AtkNoOpObjectFactoryClass

type _AtkNoOpObjectFactory
	parent as AtkObjectFactory
end type

type _AtkNoOpObjectFactoryClass
	parent_class as AtkObjectFactoryClass
end type

declare function atk_no_op_object_factory_get_type () as GType
declare function atk_no_op_object_factory_new () as AtkObjectFactory ptr

#endif
