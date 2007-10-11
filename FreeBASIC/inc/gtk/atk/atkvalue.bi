''
''
'' atkvalue -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkvalue_bi__
#define __atkvalue_bi__

#include once "atkobject.bi"

#define ATK_TYPE_VALUE() atk_value_get_type ()
#define ATK_IS_VALUE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_VALUE)
#define ATK_VALUE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_VALUE, AtkValue)
#define ATK_VALUE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_VALUE, AtkValueIface)

type AtkValue as _AtkValue
type AtkValueIface as _AtkValueIface

type _AtkValueIface
	parent as GTypeInterface
	get_current_value as sub cdecl(byval as AtkValue ptr, byval as GValue ptr)
	get_maximum_value as sub cdecl(byval as AtkValue ptr, byval as GValue ptr)
	get_minimum_value as sub cdecl(byval as AtkValue ptr, byval as GValue ptr)
	set_current_value as function cdecl(byval as AtkValue ptr, byval as GValue ptr) as gboolean
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_value_get_type () as GType
declare sub atk_value_get_current_value (byval obj as AtkValue ptr, byval value as GValue ptr)
declare sub atk_value_get_maximum_value (byval obj as AtkValue ptr, byval value as GValue ptr)
declare sub atk_value_get_minimum_value (byval obj as AtkValue ptr, byval value as GValue ptr)
declare function atk_value_set_current_value (byval obj as AtkValue ptr, byval value as GValue ptr) as gboolean

#endif
