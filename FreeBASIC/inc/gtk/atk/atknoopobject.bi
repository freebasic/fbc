''
''
'' atknoopobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atknoopobject_bi__
#define __atknoopobject_bi__

type AtkNoOpObject as _AtkNoOpObject
type AtkNoOpObjectClass as _AtkNoOpObjectClass

type _AtkNoOpObject
	parent as AtkObject
end type

declare function atk_no_op_object_get_type cdecl alias "atk_no_op_object_get_type" () as GType

type _AtkNoOpObjectClass
	parent_class as AtkObjectClass
end type

declare function atk_no_op_object_new cdecl alias "atk_no_op_object_new" (byval obj as GObject ptr) as AtkObject ptr

#endif
