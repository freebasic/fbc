''
''
'' gdsl_hash -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_hash_bi__
#define __gdsl_hash_bi__

#include once "gdsl_types.bi"

type gdsl_hash_t as any ptr
type gdsl_key_func_t as function cdecl(byval as any ptr) as byte
type gdsl_hash_func_t as function cdecl(byval as zstring ptr) as ulong

extern "c"
declare function gdsl_hash (byval KEY as zstring ptr) as ulong
declare function gdsl_hash_alloc (byval NAME as zstring ptr, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t, byval KEY_F as gdsl_key_func_t, byval HASH_F as gdsl_hash_func_t, byval INITIAL_ENTRIES_NB as ushort) as gdsl_hash_t
declare sub gdsl_hash_free (byval H as gdsl_hash_t)
declare sub gdsl_hash_flush (byval H as gdsl_hash_t)
declare function gdsl_hash_get_name (byval H as gdsl_hash_t) as zstring ptr
declare function gdsl_hash_get_entries_number (byval H as gdsl_hash_t) as ushort
declare function gdsl_hash_get_lists_max_size (byval H as gdsl_hash_t) as ushort
declare function gdsl_hash_get_longest_list_size (byval H as gdsl_hash_t) as ushort
declare function gdsl_hash_get_size (byval H as gdsl_hash_t) as ulong
declare function gdsl_hash_get_fill_factor (byval H as gdsl_hash_t) as double
declare function gdsl_hash_set_name (byval H as gdsl_hash_t, byval NEW_NAME as zstring ptr) as gdsl_hash_t
declare function gdsl_hash_insert (byval H as gdsl_hash_t, byval VALUE as any ptr) as gdsl_element_t
declare function gdsl_hash_remove (byval H as gdsl_hash_t, byval KEY as zstring ptr) as gdsl_element_t
declare function gdsl_hash_delete (byval H as gdsl_hash_t, byval KEY as zstring ptr) as gdsl_hash_t
declare function gdsl_hash_modify (byval H as gdsl_hash_t, byval NEW_ENTRIES_NB as ushort, byval NEW_LISTS_MAX_SIZE as ushort) as gdsl_hash_t
declare function gdsl_hash_search (byval H as gdsl_hash_t, byval KEY as zstring ptr) as gdsl_element_t
declare function gdsl_hash_map (byval H as gdsl_hash_t, byval MAP_F as gdsl_map_func_t, byval USER_DATA as any ptr) as gdsl_element_t
declare sub gdsl_hash_write (byval H as gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_hash_write_xml (byval H as gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_hash_dump (byval H as gdsl_hash_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
