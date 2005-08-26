''
''
'' genums -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __genums_bi__
#define __genums_bi__

#include once "gtk/gobject/gtype.bi"

type GEnumClass as _GEnumClass
type GFlagsClass as _GFlagsClass
type GEnumValue as _GEnumValue
type GFlagsValue as _GFlagsValue

type _GEnumClass
	g_type_class as GTypeClass
	minimum as gint
	maximum as gint
	n_values as guint
	values as GEnumValue ptr
end type

type _GFlagsClass
	g_type_class as GTypeClass
	mask as guint
	n_values as guint
	values as GFlagsValue ptr
end type

type _GEnumValue
	value as gint
	value_name as zstring ptr
	value_nick as zstring ptr
end type

type _GFlagsValue
	value as guint
	value_name as zstring ptr
	value_nick as zstring ptr
end type

declare function g_enum_get_value cdecl alias "g_enum_get_value" (byval enum_class as GEnumClass ptr, byval value as gint) as GEnumValue ptr
declare function g_enum_get_value_by_name cdecl alias "g_enum_get_value_by_name" (byval enum_class as GEnumClass ptr, byval name as zstring ptr) as GEnumValue ptr
declare function g_enum_get_value_by_nick cdecl alias "g_enum_get_value_by_nick" (byval enum_class as GEnumClass ptr, byval nick as zstring ptr) as GEnumValue ptr
declare function g_flags_get_first_value cdecl alias "g_flags_get_first_value" (byval flags_class as GFlagsClass ptr, byval value as guint) as GFlagsValue ptr
declare function g_flags_get_value_by_name cdecl alias "g_flags_get_value_by_name" (byval flags_class as GFlagsClass ptr, byval name as zstring ptr) as GFlagsValue ptr
declare function g_flags_get_value_by_nick cdecl alias "g_flags_get_value_by_nick" (byval flags_class as GFlagsClass ptr, byval nick as zstring ptr) as GFlagsValue ptr
declare sub g_value_set_enum cdecl alias "g_value_set_enum" (byval value as GValue ptr, byval v_enum as gint)
declare function g_value_get_enum cdecl alias "g_value_get_enum" (byval value as GValue ptr) as gint
declare sub g_value_set_flags cdecl alias "g_value_set_flags" (byval value as GValue ptr, byval v_flags as guint)
declare function g_value_get_flags cdecl alias "g_value_get_flags" (byval value as GValue ptr) as guint
declare function g_enum_register_static cdecl alias "g_enum_register_static" (byval name as zstring ptr, byval const_static_values as GEnumValue ptr) as GType
declare function g_flags_register_static cdecl alias "g_flags_register_static" (byval name as zstring ptr, byval const_static_values as GFlagsValue ptr) as GType
declare sub g_enum_complete_type_info cdecl alias "g_enum_complete_type_info" (byval g_enum_type as GType, byval info as GTypeInfo ptr, byval const_values as GEnumValue ptr)
declare sub g_flags_complete_type_info cdecl alias "g_flags_complete_type_info" (byval g_flags_type as GType, byval info as GTypeInfo ptr, byval const_values as GFlagsValue ptr)

#endif
