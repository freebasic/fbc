''
''
'' cst_features -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_features_bi__
#define __cst_features_bi__

type cst_featvalpair_struct
	name as zstring ptr
	val as cst_val ptr
	next as cst_featvalpair_struct ptr
end type

type cst_featvalpair as cst_featvalpair_struct

type cst_features_struct
	head as cst_featvalpair_struct ptr
	ctx as cst_alloc_context
end type

type cst_features as cst_features_struct

declare function new_features cdecl alias "new_features" () as cst_features ptr
declare function new_features_local cdecl alias "new_features_local" (byval ctx as cst_alloc_context) as cst_features ptr
declare sub delete_features cdecl alias "delete_features" (byval f as cst_features ptr)
declare function feat_int cdecl alias "feat_int" (byval f as cst_features ptr, byval name as zstring ptr) as integer
declare function feat_float cdecl alias "feat_float" (byval f as cst_features ptr, byval name as zstring ptr) as single
declare function feat_string cdecl alias "feat_string" (byval f as cst_features ptr, byval name as zstring ptr) as zstring ptr
declare function feat_val cdecl alias "feat_val" (byval f as cst_features ptr, byval name as zstring ptr) as cst_val ptr
declare function get_param_int cdecl alias "get_param_int" (byval f as cst_features ptr, byval name as zstring ptr, byval def as integer) as integer
declare function get_param_float cdecl alias "get_param_float" (byval f as cst_features ptr, byval name as zstring ptr, byval def as single) as single
declare function get_param_string cdecl alias "get_param_string" (byval f as cst_features ptr, byval name as zstring ptr, byval def as zstring ptr) as zstring ptr
declare function get_param_val cdecl alias "get_param_val" (byval f as cst_features ptr, byval name as zstring ptr, byval def as cst_val ptr) as cst_val ptr
declare sub feat_set_int cdecl alias "feat_set_int" (byval f as cst_features ptr, byval name as zstring ptr, byval v as integer)
declare sub feat_set_float cdecl alias "feat_set_float" (byval f as cst_features ptr, byval name as zstring ptr, byval v as single)
declare sub feat_set_string cdecl alias "feat_set_string" (byval f as cst_features ptr, byval name as zstring ptr, byval v as zstring ptr)
declare sub feat_set cdecl alias "feat_set" (byval f as cst_features ptr, byval name as zstring ptr, byval v as cst_val ptr)
declare function feat_remove cdecl alias "feat_remove" (byval f as cst_features ptr, byval name as zstring ptr) as integer
declare function feat_present cdecl alias "feat_present" (byval f as cst_features ptr, byval name as zstring ptr) as integer
declare function feat_length cdecl alias "feat_length" (byval f as cst_features ptr) as integer
declare function feat_print cdecl alias "feat_print" (byval fd as cst_file, byval f as cst_features ptr) as integer

#endif
