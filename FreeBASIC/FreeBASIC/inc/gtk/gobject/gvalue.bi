''
''
'' gvalue -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gvalue_bi__
#define __gvalue_bi__

#include once "gtype.bi"

#define	G_TYPE_IS_VALUE(type_) (g_type_check_is_value_type (type_))
#define	G_IS_VALUE(value) (G_TYPE_CHECK_VALUE (value))
#define	G_VALUE_TYPE(value) (((GValue*) (value))->g_type)
#define	G_VALUE_TYPE_NAME(value) (g_type_name (G_VALUE_TYPE (value)))
#define G_VALUE_HOLDS(value,type_) (G_TYPE_CHECK_VALUE_TYPE ((value), (type_)))

type GValueTransform as sub cdecl(byval as GValue ptr, byval as GValue ptr)

union _GValue_data
	v_int as gint
	v_uint as guint
	v_long as glong
	v_ulong as gulong
	v_int64 as gint64
	v_uint64 as guint64
	v_float as gfloat
	v_double as gdouble
	v_pointer as gpointer
end union

type _GValue
	g_type as GType
	data(0 to 2-1) as _GValue_data ptr
end type

declare function g_value_init (byval value as GValue ptr, byval g_type as GType) as GValue ptr
declare sub g_value_copy (byval src_value as GValue ptr, byval dest_value as GValue ptr)
declare function g_value_reset (byval value as GValue ptr) as GValue ptr
declare sub g_value_unset (byval value as GValue ptr)
declare sub g_value_set_instance (byval value as GValue ptr, byval instance as gpointer)
declare function g_value_fits_pointer (byval value as GValue ptr) as gboolean
declare function g_value_peek_pointer (byval value as GValue ptr) as gpointer
declare function g_value_type_compatible (byval src_type as GType, byval dest_type as GType) as gboolean
declare function g_value_type_transformable (byval src_type as GType, byval dest_type as GType) as gboolean
declare function g_value_transform (byval src_value as GValue ptr, byval dest_value as GValue ptr) as gboolean
declare sub g_value_register_transform_func (byval src_type as GType, byval dest_type as GType, byval transform_func as GValueTransform)

#define G_VALUE_NOCOPY_CONTENTS (1 shl 27)

#endif
