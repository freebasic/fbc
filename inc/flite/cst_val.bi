''
''
'' cst_val -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_val_bi__
#define __cst_val_bi__

#define CST_VAL_TYPE_CONS 0
#define CST_VAL_TYPE_INT 1
#define CST_VAL_TYPE_FLOAT 3
#define CST_VAL_TYPE_STRING 5
#define CST_VAL_TYPE_FIRST_FREE 7
#define CST_VAL_TYPE_MAX 54

type cst_val_cons_struct
	car as cst_val_struct ptr
	cdr as cst_val_struct ptr
end type

type cst_val_cons as cst_val_cons_struct

type cst_val_atom_struct
	type as short
	ref_count as short
	v as cst_val_atom__NESTED__v
end type

type cst_val_atom as cst_val_atom_struct

union cst_val_atom__NESTED__v
	fval as single
	ival as integer
	vval as any ptr
end union

type cst_val_struct
	c as cst_val__NESTED__c
end type

type cst_val as cst_val_struct

union cst_val__NESTED__c
	cc as cst_val_cons
	a as cst_val_atom
end union

type cst_val_def_struct
	name as zstring ptr
	delete_function as sub cdecl(byval as any ptr)
end type

type cst_val_def as cst_val_def_struct

declare function int_val cdecl alias "int_val" (byval i as integer) as cst_val ptr
declare function float_val cdecl alias "float_val" (byval f as single) as cst_val ptr
declare function string_val cdecl alias "string_val" (byval s as zstring ptr) as cst_val ptr
declare function val_new_typed cdecl alias "val_new_typed" (byval type as integer, byval vv as any ptr) as cst_val ptr
declare function cons_val cdecl alias "cons_val" (byval a as cst_val ptr, byval b as cst_val ptr) as cst_val ptr
declare sub delete_val cdecl alias "delete_val" (byval val as cst_val ptr)
declare sub delete_val_list cdecl alias "delete_val_list" (byval val as cst_val ptr)
declare function val_int cdecl alias "val_int" (byval v as cst_val ptr) as integer
declare function val_float cdecl alias "val_float" (byval v as cst_val ptr) as single
declare function val_string cdecl alias "val_string" (byval v as cst_val ptr) as zstring ptr
declare function val_void cdecl alias "val_void" (byval v as cst_val ptr) as any ptr
declare function val_generic cdecl alias "val_generic" (byval v as cst_val ptr, byval type as integer, byval stype as zstring ptr) as any ptr
declare function val_car cdecl alias "val_car" (byval v as cst_val ptr) as cst_val ptr
declare function val_cdr cdecl alias "val_cdr" (byval v as cst_val ptr) as cst_val ptr
declare function set_cdr cdecl alias "set_cdr" (byval v1 as cst_val ptr, byval v2 as cst_val ptr) as cst_val ptr
declare function set_car cdecl alias "set_car" (byval v1 as cst_val ptr, byval v2 as cst_val ptr) as cst_val ptr
declare function cst_val_consp cdecl alias "cst_val_consp" (byval v as cst_val ptr) as integer
declare function val_equal cdecl alias "val_equal" (byval a as cst_val ptr, byval b as cst_val ptr) as integer
declare function val_less cdecl alias "val_less" (byval a as cst_val ptr, byval b as cst_val ptr) as integer
declare function val_greater cdecl alias "val_greater" (byval a as cst_val ptr, byval b as cst_val ptr) as integer
declare function val_member cdecl alias "val_member" (byval a as cst_val ptr, byval b as cst_val ptr) as integer
declare function val_member_string cdecl alias "val_member_string" (byval a as zstring ptr, byval b as cst_val ptr) as integer
declare function val_stringp cdecl alias "val_stringp" (byval a as cst_val ptr) as integer
declare function val_assoc_string cdecl alias "val_assoc_string" (byval v1 as zstring ptr, byval al as cst_val ptr) as cst_val ptr
declare sub val_print cdecl alias "val_print" (byval fd as cst_file, byval v as cst_val ptr)
declare function val_reverse cdecl alias "val_reverse" (byval v as cst_val ptr) as cst_val ptr
declare function val_append cdecl alias "val_append" (byval a as cst_val ptr, byval b as cst_val ptr) as cst_val ptr
declare function val_length cdecl alias "val_length" (byval l as cst_val ptr) as integer
declare function cst_utf8_explode cdecl alias "cst_utf8_explode" (byval utf8string as cst_string ptr) as cst_val ptr
declare function cst_implode cdecl alias "cst_implode" (byval string_list as cst_val ptr) as cst_string ptr
declare function val_dec_refcount cdecl alias "val_dec_refcount" (byval b as cst_val ptr) as integer
declare function val_inc_refcount cdecl alias "val_inc_refcount" (byval b as cst_val ptr) as cst_val ptr
extern cst_val_defs(0 to -1) alias "cst_val_defs" as cst_val_def

type cst_userdata as any

#endif
