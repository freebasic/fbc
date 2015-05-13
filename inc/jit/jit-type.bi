''
''
'' jit-type -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_type_bi__
#define __jit_type_bi__

#include "jit/jit-common.bi"

extern jit_type_void alias "jit_type_void" as jit_type_t
extern jit_type_sbyte alias "jit_type_sbyte" as jit_type_t
extern jit_type_ubyte alias "jit_type_ubyte" as jit_type_t
extern jit_type_short alias "jit_type_short" as jit_type_t
extern jit_type_ushort alias "jit_type_ushort" as jit_type_t
extern jit_type_int alias "jit_type_int" as jit_type_t
extern jit_type_uint alias "jit_type_uint" as jit_type_t
extern jit_type_nint alias "jit_type_nint" as jit_type_t
extern jit_type_nuint alias "jit_type_nuint" as jit_type_t
extern jit_type_long alias "jit_type_long" as jit_type_t
extern jit_type_ulong alias "jit_type_ulong" as jit_type_t
extern jit_type_float32 alias "jit_type_float32" as jit_type_t
extern jit_type_float64 alias "jit_type_float64" as jit_type_t
extern jit_type_nfloat alias "jit_type_nfloat" as jit_type_t
extern jit_type_void_ptr alias "jit_type_void_ptr" as jit_type_t
extern jit_type_sys_bool alias "jit_type_sys_bool" as jit_type_t
extern jit_type_sys_char alias "jit_type_sys_char" as jit_type_t
extern jit_type_sys_schar alias "jit_type_sys_schar" as jit_type_t
extern jit_type_sys_uchar alias "jit_type_sys_uchar" as jit_type_t
extern jit_type_sys_short alias "jit_type_sys_short" as jit_type_t
extern jit_type_sys_ushort alias "jit_type_sys_ushort" as jit_type_t
extern jit_type_sys_int alias "jit_type_sys_int" as jit_type_t
extern jit_type_sys_uint alias "jit_type_sys_uint" as jit_type_t
extern jit_type_sys_long alias "jit_type_sys_long" as jit_type_t
extern jit_type_sys_ulong alias "jit_type_sys_ulong" as jit_type_t
extern jit_type_sys_longlong alias "jit_type_sys_longlong" as jit_type_t
extern jit_type_sys_ulonglong alias "jit_type_sys_ulonglong" as jit_type_t
extern jit_type_sys_float alias "jit_type_sys_float" as jit_type_t
extern jit_type_sys_double alias "jit_type_sys_double" as jit_type_t
extern jit_type_sys_long_double alias "jit_type_sys_long_double" as jit_type_t

#define _JIT_TYPE_INVALID -1
#define _JIT_TYPE_VOID 0
#define _JIT_TYPE_SBYTE 1
#define _JIT_TYPE_UBYTE 2
#define _JIT_TYPE_SHORT 3
#define _JIT_TYPE_USHORT 4
#define _JIT_TYPE_INT 5
#define _JIT_TYPE_UINT 6
#define _JIT_TYPE_NINT 7
#define _JIT_TYPE_NUINT 8
#define _JIT_TYPE_LONG 9
#define _JIT_TYPE_ULONG 10
#define _JIT_TYPE_FLOAT32 11
#define _JIT_TYPE_FLOAT64 12
#define _JIT_TYPE_NFLOAT 13
#define _JIT_TYPE_MAX_PRIMITIVE 13
#define _JIT_TYPE_STRUCT 14
#define _JIT_TYPE_UNION 15
#define _JIT_TYPE_SIGNATURE 16
#define _JIT_TYPE_PTR 17
#define _JIT_TYPE_FIRST_TAGGED 32
#define JIT_TYPETAG_NAME 10000
#define JIT_TYPETAG_STRUCT_NAME 10001
#define JIT_TYPETAG_UNION_NAME 10002
#define JIT_TYPETAG_ENUM_NAME 10003
#define JIT_TYPETAG_CONST 10004
#define JIT_TYPETAG_VOLATILE 10005
#define JIT_TYPETAG_REFERENCE 10006
#define JIT_TYPETAG_OUTPUT 10007
#define JIT_TYPETAG_RESTRICT 10008
#define JIT_TYPETAG_SYS_BOOL 10009
#define JIT_TYPETAG_SYS_CHAR 10010
#define JIT_TYPETAG_SYS_SCHAR 10011
#define JIT_TYPETAG_SYS_UCHAR 10012
#define JIT_TYPETAG_SYS_SHORT 10013
#define JIT_TYPETAG_SYS_USHORT 10014
#define JIT_TYPETAG_SYS_INT 10015
#define JIT_TYPETAG_SYS_UINT 10016
#define JIT_TYPETAG_SYS_LONG 10017
#define JIT_TYPETAG_SYS_ULONG 10018
#define JIT_TYPETAG_SYS_LONGLONG 10019
#define JIT_TYPETAG_SYS_ULONGLONG 10020
#define JIT_TYPETAG_SYS_FLOAT 10021
#define JIT_TYPETAG_SYS_DOUBLE 10022
#define JIT_TYPETAG_SYS_LONGDOUBLE 10023

enum jit_abi_t
	jit_abi_cdecl
	jit_abi_vararg
	jit_abi_stdcall
	jit_abi_fastcall
end enum


declare function jit_type_copy cdecl alias "jit_type_copy" (byval type as jit_type_t) as jit_type_t
declare sub jit_type_free cdecl alias "jit_type_free" (byval type as jit_type_t)
declare function jit_type_create_struct cdecl alias "jit_type_create_struct" (byval fields as jit_type_t ptr, byval num_fields as uinteger, byval incref as integer) as jit_type_t
declare function jit_type_create_union cdecl alias "jit_type_create_union" (byval fields as jit_type_t ptr, byval num_fields as uinteger, byval incref as integer) as jit_type_t
declare function jit_type_create_signature cdecl alias "jit_type_create_signature" (byval abi as jit_abi_t, byval return_type as jit_type_t, byval params as jit_type_t ptr, byval num_params as uinteger, byval incref as integer) as jit_type_t
declare function jit_type_create_pointer cdecl alias "jit_type_create_pointer" (byval type as jit_type_t, byval incref as integer) as jit_type_t
declare function jit_type_create_tagged cdecl alias "jit_type_create_tagged" (byval type as jit_type_t, byval kind as integer, byval data as any ptr, byval free_func as jit_meta_free_func, byval incref as integer) as jit_type_t
declare function jit_type_set_names cdecl alias "jit_type_set_names" (byval type as jit_type_t, byval names as byte ptr ptr, byval num_names as uinteger) as integer
declare sub jit_type_set_size_and_alignment cdecl alias "jit_type_set_size_and_alignment" (byval type as jit_type_t, byval size as jit_nint, byval alignment as jit_nint)
declare sub jit_type_set_offset cdecl alias "jit_type_set_offset" (byval type as jit_type_t, byval field_index as uinteger, byval offset as jit_nuint)
declare function jit_type_get_kind cdecl alias "jit_type_get_kind" (byval type as jit_type_t) as integer
declare function jit_type_get_size cdecl alias "jit_type_get_size" (byval type as jit_type_t) as jit_nuint
declare function jit_type_get_alignment cdecl alias "jit_type_get_alignment" (byval type as jit_type_t) as jit_nuint
declare function jit_type_num_fields cdecl alias "jit_type_num_fields" (byval type as jit_type_t) as uinteger
declare function jit_type_get_field cdecl alias "jit_type_get_field" (byval type as jit_type_t, byval field_index as uinteger) as jit_type_t
declare function jit_type_get_offset cdecl alias "jit_type_get_offset" (byval type as jit_type_t, byval field_index as uinteger) as jit_nuint
declare function jit_type_get_name cdecl alias "jit_type_get_name" (byval type as jit_type_t, byval index as uinteger) as zstring ptr
declare function jit_type_find_name cdecl alias "jit_type_find_name" (byval type as jit_type_t, byval name as zstring ptr) as uinteger
declare function jit_type_num_params cdecl alias "jit_type_num_params" (byval type as jit_type_t) as uinteger
declare function jit_type_get_return cdecl alias "jit_type_get_return" (byval type as jit_type_t) as jit_type_t
declare function jit_type_get_param cdecl alias "jit_type_get_param" (byval type as jit_type_t, byval param_index as uinteger) as jit_type_t
declare function jit_type_get_abi cdecl alias "jit_type_get_abi" (byval type as jit_type_t) as jit_abi_t
declare function jit_type_get_ref cdecl alias "jit_type_get_ref" (byval type as jit_type_t) as jit_type_t
declare function jit_type_get_tagged_type cdecl alias "jit_type_get_tagged_type" (byval type as jit_type_t) as jit_type_t
declare sub jit_type_set_tagged_type cdecl alias "jit_type_set_tagged_type" (byval type as jit_type_t, byval underlying as jit_type_t, byval incref as integer)
declare function jit_type_get_tagged_kind cdecl alias "jit_type_get_tagged_kind" (byval type as jit_type_t) as integer
declare function jit_type_get_tagged_data cdecl alias "jit_type_get_tagged_data" (byval type as jit_type_t) as any ptr
declare sub jit_type_set_tagged_data cdecl alias "jit_type_set_tagged_data" (byval type as jit_type_t, byval data as any ptr, byval free_func as jit_meta_free_func)
declare function jit_type_is_primitive cdecl alias "jit_type_is_primitive" (byval type as jit_type_t) as integer
declare function jit_type_is_struct cdecl alias "jit_type_is_struct" (byval type as jit_type_t) as integer
declare function jit_type_is_union cdecl alias "jit_type_is_union" (byval type as jit_type_t) as integer
declare function jit_type_is_signature cdecl alias "jit_type_is_signature" (byval type as jit_type_t) as integer
declare function jit_type_is_pointer cdecl alias "jit_type_is_pointer" (byval type as jit_type_t) as integer
declare function jit_type_is_tagged cdecl alias "jit_type_is_tagged" (byval type as jit_type_t) as integer
declare function jit_type_best_alignment cdecl alias "jit_type_best_alignment" () as jit_nuint
declare function jit_type_normalize cdecl alias "jit_type_normalize" (byval type as jit_type_t) as jit_type_t
declare function jit_type_remove_tags cdecl alias "jit_type_remove_tags" (byval type as jit_type_t) as jit_type_t
declare function jit_type_promote_int cdecl alias "jit_type_promote_int" (byval type as jit_type_t) as jit_type_t
declare function jit_type_return_via_pointer cdecl alias "jit_type_return_via_pointer" (byval type as jit_type_t) as integer
declare function jit_type_has_tag cdecl alias "jit_type_has_tag" (byval type as jit_type_t, byval kind as integer) as integer

#endif
