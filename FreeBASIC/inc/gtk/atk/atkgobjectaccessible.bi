''
''
'' atkgobjectaccessible -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkgobjectaccessible_bi__
#define __atkgobjectaccessible_bi__

#include once "gtk/atk.bi"

type AtkGObjectAccessible as _AtkGObjectAccessible
type AtkGObjectAccessibleClass as _AtkGObjectAccessibleClass

type _AtkGObjectAccessible
	parent as AtkObject
end type

declare function atk_gobject_accessible_get_type cdecl alias "atk_gobject_accessible_get_type" () as GType

type _AtkGObjectAccessibleClass
	parent_class as AtkObjectClass
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_gobject_accessible_for_object cdecl alias "atk_gobject_accessible_for_object" (byval obj as GObject ptr) as AtkObject ptr
declare function atk_gobject_accessible_get_object cdecl alias "atk_gobject_accessible_get_object" (byval obj as AtkGObjectAccessible ptr) as GObject ptr

#endif
