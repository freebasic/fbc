''
''
'' gparamspecs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gparamspecs_bi__
#define __gparamspecs_bi__

#include once "gtk/gobject/gvalue.bi"
#include once "gtk/gobject/genums.bi"
#include once "gtk/gobject/gboxed.bi"
#include once "gtk/gobject/gobject.bi"

type GParamSpecChar as _GParamSpecChar
type GParamSpecUChar as _GParamSpecUChar
type GParamSpecBoolean as _GParamSpecBoolean
type GParamSpecInt as _GParamSpecInt
type GParamSpecUInt as _GParamSpecUInt
type GParamSpecLong as _GParamSpecLong
type GParamSpecULong as _GParamSpecULong
type GParamSpecInt64 as _GParamSpecInt64
type GParamSpecUInt64 as _GParamSpecUInt64
type GParamSpecUnichar as _GParamSpecUnichar
type GParamSpecEnum as _GParamSpecEnum
type GParamSpecFlags as _GParamSpecFlags
type GParamSpecFloat as _GParamSpecFloat
type GParamSpecDouble as _GParamSpecDouble
type GParamSpecString as _GParamSpecString
type GParamSpecParam as _GParamSpecParam
type GParamSpecBoxed as _GParamSpecBoxed
type GParamSpecPointer as _GParamSpecPointer
type GParamSpecValueArray as _GParamSpecValueArray
type GParamSpecObject as _GParamSpecObject
type GParamSpecOverride as _GParamSpecOverride

type _GParamSpecChar
	parent_instance as GParamSpec
	minimum as gint8
	maximum as gint8
	default_value as gint8
end type

type _GParamSpecUChar
	parent_instance as GParamSpec
	minimum as guint8
	maximum as guint8
	default_value as guint8
end type

type _GParamSpecBoolean
	parent_instance as GParamSpec
	default_value as gboolean
end type

type _GParamSpecInt
	parent_instance as GParamSpec
	minimum as gint
	maximum as gint
	default_value as gint
end type

type _GParamSpecUInt
	parent_instance as GParamSpec
	minimum as guint
	maximum as guint
	default_value as guint
end type

type _GParamSpecLong
	parent_instance as GParamSpec
	minimum as glong
	maximum as glong
	default_value as glong
end type

type _GParamSpecULong
	parent_instance as GParamSpec
	minimum as gulong
	maximum as gulong
	default_value as gulong
end type

type _GParamSpecInt64
	parent_instance as GParamSpec
	minimum as gint64
	maximum as gint64
	default_value as gint64
end type

type _GParamSpecUInt64
	parent_instance as GParamSpec
	minimum as guint64
	maximum as guint64
	default_value as guint64
end type

type _GParamSpecUnichar
	parent_instance as GParamSpec
	default_value as gunichar
end type

type _GParamSpecEnum
	parent_instance as GParamSpec
	enum_class as GEnumClass ptr
	default_value as gint
end type

type _GParamSpecFlags
	parent_instance as GParamSpec
	flags_class as GFlagsClass ptr
	default_value as guint
end type

type _GParamSpecFloat
	parent_instance as GParamSpec
	minimum as gfloat
	maximum as gfloat
	default_value as gfloat
	epsilon as gfloat
end type

type _GParamSpecDouble
	parent_instance as GParamSpec
	minimum as gdouble
	maximum as gdouble
	default_value as gdouble
	epsilon as gdouble
end type

type _GParamSpecString
	parent_instance as GParamSpec
	default_value as zstring ptr
	cset_first as zstring ptr
	cset_nth as zstring ptr
	substitutor as gchar
	''!!!FIXME!!! bit-fields support is needed
	union
		null_fold_if_empty as guint
		ensure_non_null as guint
	end union
end type

type _GParamSpecParam
	parent_instance as GParamSpec
end type

type _GParamSpecBoxed
	parent_instance as GParamSpec
end type

type _GParamSpecPointer
	parent_instance as GParamSpec
end type

type _GParamSpecValueArray
	parent_instance as GParamSpec
	element_spec as GParamSpec ptr
	fixed_n_elements as guint
end type

type _GParamSpecObject
	parent_instance as GParamSpec
end type

type _GParamSpecOverride
	parent_instance as GParamSpec
	overridden as GParamSpec ptr
end type

declare function g_param_spec_char cdecl alias "g_param_spec_char" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gint8, byval maximum as gint8, byval default_value as gint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uchar cdecl alias "g_param_spec_uchar" (byval name as string, byval nick as string, byval blurb as string, byval minimum as guint8, byval maximum as guint8, byval default_value as guint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boolean cdecl alias "g_param_spec_boolean" (byval name as string, byval nick as string, byval blurb as string, byval default_value as gboolean, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int cdecl alias "g_param_spec_int" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gint, byval maximum as gint, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint cdecl alias "g_param_spec_uint" (byval name as string, byval nick as string, byval blurb as string, byval minimum as guint, byval maximum as guint, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_long cdecl alias "g_param_spec_long" (byval name as string, byval nick as string, byval blurb as string, byval minimum as glong, byval maximum as glong, byval default_value as glong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_ulong cdecl alias "g_param_spec_ulong" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gulong, byval maximum as gulong, byval default_value as gulong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int64 cdecl alias "g_param_spec_int64" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gint64, byval maximum as gint64, byval default_value as gint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint64 cdecl alias "g_param_spec_uint64" (byval name as string, byval nick as string, byval blurb as string, byval minimum as guint64, byval maximum as guint64, byval default_value as guint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_unichar cdecl alias "g_param_spec_unichar" (byval name as string, byval nick as string, byval blurb as string, byval default_value as gunichar, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_enum cdecl alias "g_param_spec_enum" (byval name as string, byval nick as string, byval blurb as string, byval enum_type as GType, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_flags cdecl alias "g_param_spec_flags" (byval name as string, byval nick as string, byval blurb as string, byval flags_type as GType, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_float cdecl alias "g_param_spec_float" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gfloat, byval maximum as gfloat, byval default_value as gfloat, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_double cdecl alias "g_param_spec_double" (byval name as string, byval nick as string, byval blurb as string, byval minimum as gdouble, byval maximum as gdouble, byval default_value as gdouble, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_string cdecl alias "g_param_spec_string" (byval name as string, byval nick as string, byval blurb as string, byval default_value as string, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_param cdecl alias "g_param_spec_param" (byval name as string, byval nick as string, byval blurb as string, byval param_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boxed cdecl alias "g_param_spec_boxed" (byval name as string, byval nick as string, byval blurb as string, byval boxed_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_pointer cdecl alias "g_param_spec_pointer" (byval name as string, byval nick as string, byval blurb as string, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_value_array cdecl alias "g_param_spec_value_array" (byval name as string, byval nick as string, byval blurb as string, byval element_spec as GParamSpec ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_object cdecl alias "g_param_spec_object" (byval name as string, byval nick as string, byval blurb as string, byval object_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_override cdecl alias "g_param_spec_override" (byval name as string, byval overridden as GParamSpec ptr) as GParamSpec ptr

#endif
