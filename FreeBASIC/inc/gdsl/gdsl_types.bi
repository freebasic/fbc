''
''
'' gdsl_types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_types_bi__
#define __gdsl_types_bi__

#ifndef FILE
type FILE as any
#endif

enum gdsl_constant_t
	GDSL_ERR_MEM_ALLOC = -1
	GDSL_MAP_STOP = 0
	GDSL_MAP_CONT = 1
	GDSL_INSERTED
	GDSL_FOUND
end enum

type gdsl_element_t as any ptr
type gdsl_alloc_func_t as function cdecl(byval as any ptr) as gdsl_element_t
type gdsl_free_func_t as sub cdecl(byval as gdsl_element_t)
type gdsl_copy_func_t as function cdecl(byval as gdsl_element_t) as gdsl_element_t
type gdsl_map_func_t as function cdecl(byval as gdsl_element_t, byval as any ptr) as integer
type gdsl_compare_func_t as function cdecl(byval as gdsl_element_t, byval as any ptr) as integer
type gdsl_write_func_t as sub cdecl(byval as gdsl_element_t, byval as FILE ptr, byval as any ptr)
#ifndef ulong
type ulong as uinteger
#endif

enum bool
  FALSE = 0
  TRUE = 1
end enum

#endif
