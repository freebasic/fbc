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

#include once "gvalue.bi"
#include once "genums.bi"
#include once "gboxed.bi"
#include once "gobject.bi"

#define	G_TYPE_PARAM_CHAR g_param_spec_types[0]
#define G_IS_PARAM_SPEC_CHAR_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_CHAR)
#define G_PARAM_SPEC_CHAR_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_CHAR, GParamSpecChar)
#define	G_TYPE_PARAM_UCHAR g_param_spec_types[1]
#define G_IS_PARAM_SPEC_UCHAR_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UCHAR)
#define G_PARAM_SPEC_UCHAR_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UCHAR, GParamSpecUChar)
#define	G_TYPE_PARAM_BOOLEAN g_param_spec_types[2]
#define G_IS_PARAM_SPEC_BOOLEAN_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_BOOLEAN)
#define G_PARAM_SPEC_BOOLEAN_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_BOOLEAN, GParamSpecBoolean)
#define	G_TYPE_PARAM_INT g_param_spec_types[3]
#define G_IS_PARAM_SPEC_INT_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_INT)
#define G_PARAM_SPEC_INT_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_INT, GParamSpecInt)
#define	G_TYPE_PARAM_UINT g_param_spec_types[4]
#define G_IS_PARAM_SPEC_UINT_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UINT)
#define G_PARAM_SPEC_UINT_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UINT, GParamSpecUInt)
#define	G_TYPE_PARAM_LONG g_param_spec_types[5]
#define G_IS_PARAM_SPEC_LONG_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_LONG)
#define G_PARAM_SPEC_LONG_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_LONG, GParamSpecLong)
#define	G_TYPE_PARAM_ULONG g_param_spec_types[6]
#define G_IS_PARAM_SPEC_ULONG_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_ULONG)
#define G_PARAM_SPEC_ULONG_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_ULONG, GParamSpecULong)
#define	G_TYPE_PARAM_INT64 g_param_spec_types[7]
#define G_IS_PARAM_SPEC_INT64_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_INT64)
#define G_PARAM_SPEC_INT64_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_INT64, GParamSpecInt64)
#define	G_TYPE_PARAM_UINT64 g_param_spec_types[8]
#define G_IS_PARAM_SPEC_UINT64_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UINT64)
#define G_PARAM_SPEC_UINT64_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UINT64, GParamSpecUInt64)
#define	G_TYPE_PARAM_UNICHAR g_param_spec_types[9]
#define G_PARAM_SPEC_UNICHAR_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UNICHAR, GParamSpecUnichar)
#define G_IS_PARAM_SPEC_UNICHAR_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UNICHAR)
#define	G_TYPE_PARAM_ENUM g_param_spec_types[10]
#define G_IS_PARAM_SPEC_ENUM_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_ENUM)
#define G_PARAM_SPEC_ENUM_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_ENUM, GParamSpecEnum)
#define	G_TYPE_PARAM_FLAGS g_param_spec_types[11]
#define G_IS_PARAM_SPEC_FLAGS_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_FLAGS)
#define G_PARAM_SPEC_FLAGS_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_FLAGS, GParamSpecFlags)
#define	G_TYPE_PARAM_FLOAT g_param_spec_types[12]
#define G_IS_PARAM_SPEC_FLOAT_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_FLOAT)
#define G_PARAM_SPEC_FLOAT_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_FLOAT, GParamSpecFloat)
#define	G_TYPE_PARAM_DOUBLE g_param_spec_types[13]
#define G_IS_PARAM_SPEC_DOUBLE_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_DOUBLE)
#define G_PARAM_SPEC_DOUBLE_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_DOUBLE, GParamSpecDouble)
#define	G_TYPE_PARAM_STRING g_param_spec_types[14]
#define G_IS_PARAM_SPEC_STRING_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_STRING)
#define G_PARAM_SPEC_STRING_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_STRING, GParamSpecString)
#define	G_TYPE_PARAM_PARAM g_param_spec_types[15]
#define G_IS_PARAM_SPEC_PARAM_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_PARAM)
#define G_PARAM_SPEC_PARAM_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_PARAM, GParamSpecParam)
#define	G_TYPE_PARAM_BOXED g_param_spec_types[16]
#define G_IS_PARAM_SPEC_BOXED_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_BOXED)
#define G_PARAM_SPEC_BOXED_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_BOXED, GParamSpecBoxed)
#define	G_TYPE_PARAM_POINTER g_param_spec_types[17]
#define G_IS_PARAM_SPEC_POINTER_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_POINTER)
#define G_PARAM_SPEC_POINTER_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_POINTER, GParamSpecPointer)
#define	G_TYPE_PARAM_VALUE_ARRAY g_param_spec_types[18]
#define G_IS_PARAM_SPEC_VALUE_ARRAY_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_VALUE_ARRAY)
#define G_PARAM_SPEC_VALUE_ARRAY_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_VALUE_ARRAY, GParamSpecValueArray)
#define	G_TYPE_PARAM_OBJECT g_param_spec_types[19]
#define G_IS_PARAM_SPEC_OBJECT_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_OBJECT)
#define G_PARAM_SPEC_OBJECT_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_OBJECT, GParamSpecObject)
#define	G_TYPE_PARAM_OVERRIDE g_param_spec_types[20]
#define G_IS_PARAM_SPEC_OVERRIDE_(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_OVERRIDE)
#define G_PARAM_SPEC_OVERRIDE_(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_OVERRIDE, GParamSpecOverride)

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
	null_fold_if_empty:1 as guint
	ensure_non_null:1 as guint
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

declare function g_param_spec_char (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gint8, byval maximum as gint8, byval default_value as gint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uchar (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as guint8, byval maximum as guint8, byval default_value as guint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boolean (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval default_value as gboolean, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gint, byval maximum as gint, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as guint, byval maximum as guint, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_long (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as glong, byval maximum as glong, byval default_value as glong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_ulong (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gulong, byval maximum as gulong, byval default_value as gulong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int64 (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gint64, byval maximum as gint64, byval default_value as gint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint64 (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as guint64, byval maximum as guint64, byval default_value as guint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_unichar (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval default_value as gunichar, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_enum (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval enum_type as GType, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_flags (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval flags_type as GType, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_float (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gfloat, byval maximum as gfloat, byval default_value as gfloat, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_double (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval minimum as gdouble, byval maximum as gdouble, byval default_value as gdouble, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_string (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval default_value as zstring ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_param (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval param_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boxed (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval boxed_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_pointer (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_value_array (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval element_spec as GParamSpec ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_object (byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval object_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_override (byval name as zstring ptr, byval overridden as GParamSpec ptr) as GParamSpec ptr

extern import g_param_spec_types as GType ptr

#endif
