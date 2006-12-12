''
''
'' gdsl_2darray -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdsl_2darray_bi__
#define __gdsl_2darray_bi__

#include once "gdsl_types.bi"

type gdsl_2darray_t as any ptr

enum gdsl_2darray_position_t
	GDSL_2DARRAY_POSITION_FIRST_ROW = 1
	GDSL_2DARRAY_POSITION_LAST_ROW = 2
	GDSL_2DARRAY_POSITION_FIRST_COL = 4
	GDSL_2DARRAY_POSITION_LAST_COL = 8
end enum

type gdsl_2darray_write_func_t as sub cdecl(byval as gdsl_element_t, byval as FILE ptr, byval as gdsl_2darray_position_t, byval as any ptr)

extern "c"
declare function gdsl_2darray_alloc (byval NAME as zstring ptr, byval R as ulong, byval C as ulong, byval ALLOC_F as gdsl_alloc_func_t, byval FREE_F as gdsl_free_func_t) as gdsl_2darray_t
declare sub gdsl_2darray_free (byval A as gdsl_2darray_t)
declare function gdsl_2darray_get_name (byval A as gdsl_2darray_t) as zstring ptr
declare function gdsl_2darray_get_rows_number (byval A as gdsl_2darray_t) as ulong
declare function gdsl_2darray_get_columns_number (byval A as gdsl_2darray_t) as ulong
declare function gdsl_2darray_get_size (byval A as gdsl_2darray_t) as ulong
declare function gdsl_2darray_get_content (byval A as gdsl_2darray_t, byval R as ulong, byval C as ulong) as gdsl_element_t
declare function gdsl_2darray_set_name (byval A as gdsl_2darray_t, byval NEW_NAME as zstring ptr) as gdsl_2darray_t
declare function gdsl_2darray_set_content (byval A as gdsl_2darray_t, byval R as ulong, byval C as ulong, byval VALUE as any ptr) as gdsl_element_t
declare sub gdsl_2darray_write (byval A as gdsl_2darray_t, byval WRITE_F as gdsl_2darray_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_2darray_write_xml (byval A as gdsl_2darray_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub gdsl_2darray_dump (byval A as gdsl_2darray_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
