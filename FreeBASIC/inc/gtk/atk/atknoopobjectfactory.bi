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

#include once "gtk/atk/atkobjectfactory.bi"

type AtkNoOpObjectFactory as _AtkNoOpObjectFactory
type AtkNoOpObjectFactoryClass as _AtkNoOpObjectFactoryClass

type _AtkNoOpObjectFactory
	parent as AtkObjectFactory
end type

type _AtkNoOpObjectFactoryClass
	parent_class as AtkObjectFactoryClass
end type

declare function atk_no_op_object_factory_get_type cdecl alias "atk_no_op_object_factory_get_type" () as GType
declare function atk_no_op_object_factory_new cdecl alias "atk_no_op_object_factory_new" () as AtkObjectFactory ptr

#endif
