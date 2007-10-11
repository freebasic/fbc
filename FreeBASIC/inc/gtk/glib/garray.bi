''
''
'' garray -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __garray_bi__
#define __garray_bi__

#include once "gtypes.bi"

type GArray as _GArray
type GByteArray as _GByteArray
type GPtrArray as _GPtrArray

type _GArray
	data as zstring ptr
	len as guint
end type

type _GByteArray
	data as guint8 ptr
	len as guint
end type

type _GPtrArray
	pdata as gpointer ptr
	len as guint
end type

declare function g_array_new (byval zero_terminated as gboolean, byval clear_ as gboolean, byval element_size as guint) as GArray ptr
declare function g_array_sized_new (byval zero_terminated as gboolean, byval clear_ as gboolean, byval element_size as guint, byval reserved_size as guint) as GArray ptr
declare function g_array_free (byval array as GArray ptr, byval free_segment as gboolean) as zstring ptr
declare function g_array_append_vals (byval array as GArray ptr, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_prepend_vals (byval array as GArray ptr, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_insert_vals (byval array as GArray ptr, byval index_ as guint, byval data as gconstpointer, byval len as guint) as GArray ptr
declare function g_array_set_size (byval array as GArray ptr, byval length as guint) as GArray ptr
declare function g_array_remove_index (byval array as GArray ptr, byval index_ as guint) as GArray ptr
declare function g_array_remove_index_fast (byval array as GArray ptr, byval index_ as guint) as GArray ptr
declare function g_array_remove_range (byval array as GArray ptr, byval index_ as guint, byval length as guint) as GArray ptr
declare sub g_array_sort (byval array as GArray ptr, byval compare_func as GCompareFunc)
declare sub g_array_sort_with_data (byval array as GArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare function g_ptr_array_new () as GPtrArray ptr
declare function g_ptr_array_sized_new (byval reserved_size as guint) as GPtrArray ptr
declare function g_ptr_array_free (byval array as GPtrArray ptr, byval free_seg as gboolean) as gpointer ptr
declare sub g_ptr_array_set_size (byval array as GPtrArray ptr, byval length as gint)
declare function g_ptr_array_remove_index (byval array as GPtrArray ptr, byval index_ as guint) as gpointer
declare function g_ptr_array_remove_index_fast (byval array as GPtrArray ptr, byval index_ as guint) as gpointer
declare function g_ptr_array_remove (byval array as GPtrArray ptr, byval data as gpointer) as gboolean
declare function g_ptr_array_remove_fast (byval array as GPtrArray ptr, byval data as gpointer) as gboolean
declare sub g_ptr_array_remove_range (byval array as GPtrArray ptr, byval index_ as guint, byval length as guint)
declare sub g_ptr_array_add (byval array as GPtrArray ptr, byval data as gpointer)
declare sub g_ptr_array_sort (byval array as GPtrArray ptr, byval compare_func as GCompareFunc)
declare sub g_ptr_array_sort_with_data (byval array as GPtrArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)
declare sub g_ptr_array_foreach (byval array as GPtrArray ptr, byval func as GFunc, byval user_data as gpointer)
declare function g_byte_array_new () as GByteArray ptr
declare function g_byte_array_sized_new (byval reserved_size as guint) as GByteArray ptr
declare function g_byte_array_free (byval array as GByteArray ptr, byval free_segment as gboolean) as guint8 ptr
declare function g_byte_array_append (byval array as GByteArray ptr, byval data as guint8 ptr, byval len as guint) as GByteArray ptr
declare function g_byte_array_prepend (byval array as GByteArray ptr, byval data as guint8 ptr, byval len as guint) as GByteArray ptr
declare function g_byte_array_set_size (byval array as GByteArray ptr, byval length as guint) as GByteArray ptr
declare function g_byte_array_remove_index (byval array as GByteArray ptr, byval index_ as guint) as GByteArray ptr
declare function g_byte_array_remove_index_fast (byval array as GByteArray ptr, byval index_ as guint) as GByteArray ptr
declare function g_byte_array_remove_range (byval array as GByteArray ptr, byval index_ as guint, byval length as guint) as GByteArray ptr
declare sub g_byte_array_sort (byval array as GByteArray ptr, byval compare_func as GCompareFunc)
declare sub g_byte_array_sort_with_data (byval array as GByteArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer)

#endif
