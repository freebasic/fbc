''
''
'' gvaluearray -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gvaluearray_bi__
#define __gvaluearray_bi__

#include once "gvalue.bi"

type GValueArray as _GValueArray

type _GValueArray
	n_values as guint
	values as GValue ptr
	n_prealloced as guint
end type

declare function g_value_array_get_nth (byval value_array as GValueArray ptr, byval index_ as guint) as GValue ptr
declare function g_value_array_new (byval n_prealloced as guint) as GValueArray ptr
declare sub g_value_array_free (byval value_array as GValueArray ptr)
declare function g_value_array_copy (byval value_array as GValueArray ptr) as GValueArray ptr
declare function g_value_array_prepend (byval value_array as GValueArray ptr, byval value as GValue ptr) as GValueArray ptr
declare function g_value_array_append (byval value_array as GValueArray ptr, byval value as GValue ptr) as GValueArray ptr
declare function g_value_array_insert (byval value_array as GValueArray ptr, byval index_ as guint, byval value as GValue ptr) as GValueArray ptr
declare function g_value_array_remove (byval value_array as GValueArray ptr, byval index_ as guint) as GValueArray ptr
declare function g_value_array_sort (byval value_array as GValueArray ptr, byval compare_func as GCompareFunc) as GValueArray ptr
declare function g_value_array_sort_with_data (byval value_array as GValueArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GValueArray ptr

#endif
