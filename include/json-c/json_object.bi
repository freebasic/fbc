''
''
'' json_object -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __json_object_bi__
#define __json_object_bi__

#define JSON_OBJECT_DEF_HASH_ENTRIES 16

#Undef FALSE
#Define FALSE 0

#Undef TRUE
#Define TRUE 1

Extern "C"

extern json_number_chars As zstring ptr
extern json_hex_chars as zstring ptr

type boolean as integer
type printbuf as any
type lh_table as any
type array_list as any
type json_object as any
type json_object_iter as any
type json_tokener as any

enum json_type
	json_type_null
	json_type_boolean
	json_type_double
	json_type_int
	json_type_object
	json_type_array
	json_type_string
end enum


declare function json_object_get (byval obj as json_object ptr) as json_object ptr
declare sub json_object_put (byval obj as json_object ptr)
declare function json_object_is_type (byval obj as json_object ptr, byval type_ as json_type) as integer
declare function json_object_get_type (byval obj as json_object ptr) as json_type
declare function json_object_to_json_string (byval obj as json_object ptr) as zstring ptr
declare function json_object_new_object () as json_object ptr
declare function json_object_get_object (byval obj as json_object ptr) as lh_table ptr
declare sub json_object_object_add (byval obj as json_object ptr, byval key as zstring ptr, byval val_ as json_object ptr)
declare function json_object_object_get (byval obj as json_object ptr, byval key as zstring ptr) as json_object ptr
declare sub json_object_object_del (byval obj as json_object ptr, byval key as zstring ptr)
declare function json_object_new_array () as json_object ptr
declare function json_object_get_array (byval obj as json_object ptr) as array_list ptr
declare function json_object_array_length (byval obj as json_object ptr) as integer
declare function json_object_array_add (byval obj as json_object ptr, byval val_ as json_object ptr) as integer
declare function json_object_array_put_idx (byval obj as json_object ptr, byval idx as integer, byval val_ as json_object ptr) as integer
declare function json_object_array_get_idx (byval obj as json_object ptr, byval idx as integer) as json_object ptr
declare function json_object_new_boolean (byval b as boolean) as json_object ptr
declare function json_object_get_boolean (byval obj as json_object ptr) as boolean
declare function json_object_new_int (byval i as integer) as json_object ptr
declare function json_object_get_int (byval obj as json_object ptr) as integer
declare function json_object_new_double (byval d as double) as json_object ptr
declare function json_object_get_double (byval obj as json_object ptr) as double
declare function json_object_new_string (byval s as zstring ptr) as json_object ptr
declare function json_object_new_string_len (byval s as zstring ptr, byval len_ as integer) as json_object ptr
declare function json_object_get_string (byval obj as json_object ptr) as zstring ptr

End Extern

#endif
