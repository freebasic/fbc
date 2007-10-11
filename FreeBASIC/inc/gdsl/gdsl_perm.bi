''
''
'' gdsl_perm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_perm_bi__
#define __gdsl_perm_bi__

#include once "gdsl_types.bi"

type gdsl_perm_t as any ptr

enum gdsl_perm_position_t
	GDSL_PERM_POSITION_FIRST = 1
	GDSL_PERM_POSITION_LAST = 2
end enum

type gdsl_perm_write_func_t as sub cdecl(byval as ulong, byval as FILE ptr, byval as gdsl_perm_position_t, byval as any ptr)

declare function gdsl_perm_alloc (byval NAME as zstring ptr, byval N as ulong) as gdsl_perm_t
declare sub gdsl_perm_free (byval P as gdsl_perm_t)
declare function gdsl_perm_copy (byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_get_name (byval P as gdsl_perm_t) as zstring ptr
declare function gdsl_perm_get_size (byval P as gdsl_perm_t) as ulong
declare function gdsl_perm_get_element (byval P as gdsl_perm_t, byval INDIX as ulong) as ulong
declare function gdsl_perm_get_elements_array (byval P as gdsl_perm_t) as ulong ptr
declare function gdsl_perm_linear_inversions_count (byval P as gdsl_perm_t) as ulong
declare function gdsl_perm_linear_cycles_count (byval P as gdsl_perm_t) as ulong
declare function gdsl_perm_canonical_cycles_count (byval P as gdsl_perm_t) as ulong
declare function gdsl_perm_set_name (byval P as gdsl_perm_t, byval NEW_NAME as zstring ptr) as gdsl_perm_t
declare function gdsl_perm_linear_next (byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_linear_prev (byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_set_elements_array (byval P as gdsl_perm_t, byval ARRAY as ulong ptr) as gdsl_perm_t
declare function gdsl_perm_multiply (byval RESULT as gdsl_perm_t, byval ALPHA as gdsl_perm_t, byval BETA as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_linear_to_canonical (byval Q as gdsl_perm_t, byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_canonical_to_linear (byval Q as gdsl_perm_t, byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_inverse (byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_reverse (byval P as gdsl_perm_t) as gdsl_perm_t
declare function gdsl_perm_randomize cdecl alias "gdsl_perm_randomize" (byval P as gdsl_perm_t) as gdsl_perm_t
extern "c"
declare function gdsl_perm_apply_on_array (byval V as gdsl_element_t ptr, byval P as gdsl_perm_t) as gdsl_element_t ptr
declare sub gdsl_perm_write (byval P as gdsl_perm_t, byval WRITE_F as gdsl_perm_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_perm_write_xml (byval P as gdsl_perm_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_perm_dump (byval P as gdsl_perm_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
