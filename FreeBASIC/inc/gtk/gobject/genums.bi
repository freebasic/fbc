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

#include once "gtype.bi"

#define G_TYPE_IS_ENUM(type_) (G_TYPE_FUNDAMENTAL (type_) == G_TYPE_ENUM)
#define G_ENUM_CLASS(class_) (G_TYPE_CHECK_CLASS_CAST ((class_), G_TYPE_ENUM, GEnumClass))
#define G_IS_ENUM_CLASS(class_) (G_TYPE_CHECK_CLASS_TYPE ((class_), G_TYPE_ENUM))
#define G_ENUM_CLASS_TYPE(class_) (G_TYPE_FROM_CLASS (class_))
#define G_ENUM_CLASS_TYPE_NAME(class_) (g_type_name (G_ENUM_CLASS_TYPE (class_)))
#define G_TYPE_IS_FLAGS(type_) (G_TYPE_FUNDAMENTAL (type_) == G_TYPE_FLAGS)
#define G_FLAGS_CLASS(class_) (G_TYPE_CHECK_CLASS_CAST ((class_), G_TYPE_FLAGS, GFlagsClass))
#define G_IS_FLAGS_CLASS(class_) (G_TYPE_CHECK_CLASS_TYPE ((class_), G_TYPE_FLAGS))
#define G_FLAGS_CLASS_TYPE(class_) (G_TYPE_FROM_CLASS (class_))
#define G_FLAGS_CLASS_TYPE_NAME(class_) (g_type_name (G_FLAGS_TYPE (class_)))
#define G_VALUE_HOLDS_ENUM(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_ENUM))
#define G_VALUE_HOLDS_FLAGS(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_FLAGS))

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

declare function g_enum_get_value (byval enum_class as GEnumClass ptr, byval value as gint) as GEnumValue ptr
declare function g_enum_get_value_by_name (byval enum_class as GEnumClass ptr, byval name as zstring ptr) as GEnumValue ptr
declare function g_enum_get_value_by_nick (byval enum_class as GEnumClass ptr, byval nick as zstring ptr) as GEnumValue ptr
declare function g_flags_get_first_value (byval flags_class as GFlagsClass ptr, byval value as guint) as GFlagsValue ptr
declare function g_flags_get_value_by_name (byval flags_class as GFlagsClass ptr, byval name as zstring ptr) as GFlagsValue ptr
declare function g_flags_get_value_by_nick (byval flags_class as GFlagsClass ptr, byval nick as zstring ptr) as GFlagsValue ptr
declare sub g_value_set_enum (byval value as GValue ptr, byval v_enum as gint)
declare function g_value_get_enum (byval value as GValue ptr) as gint
declare sub g_value_set_flags (byval value as GValue ptr, byval v_flags as guint)
declare function g_value_get_flags (byval value as GValue ptr) as guint
declare function g_enum_register_static (byval name as zstring ptr, byval const_static_values as GEnumValue ptr) as GType
declare function g_flags_register_static (byval name as zstring ptr, byval const_static_values as GFlagsValue ptr) as GType
declare sub g_enum_complete_type_info (byval g_enum_type as GType, byval info as GTypeInfo ptr, byval const_values as GEnumValue ptr)
declare sub g_flags_complete_type_info (byval g_flags_type as GType, byval info as GTypeInfo ptr, byval const_values as GFlagsValue ptr)

#endif
