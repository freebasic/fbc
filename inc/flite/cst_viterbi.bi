''
''
'' cst_viterbi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_viterbi_bi__
#define __cst_viterbi_bi__

type cst_vit_cand_struct
	score as integer
	val as cst_val ptr
	ival as integer
	pos as integer
	item as cst_item ptr
	next as cst_vit_cand_struct ptr
end type

type cst_vit_cand as cst_vit_cand_struct

declare function new_vit_cand cdecl alias "new_vit_cand" () as cst_vit_cand ptr
declare sub vit_cand_set cdecl alias "vit_cand_set" (byval vc as cst_vit_cand ptr, byval val as cst_val ptr)
declare sub vit_cand_set_int cdecl alias "vit_cand_set_int" (byval vc as cst_vit_cand ptr, byval ival as integer)
declare sub delete_vit_cand cdecl alias "delete_vit_cand" (byval vc as cst_vit_cand ptr)

type cst_vit_path_struct
	score as integer
	state as integer
	cand as cst_vit_cand ptr
	f as cst_features ptr
	from as cst_vit_path_struct ptr
	next as cst_vit_path_struct ptr
end type

type cst_vit_path as cst_vit_path_struct

declare function new_vit_path cdecl alias "new_vit_path" () as cst_vit_path ptr
declare sub delete_vit_path cdecl alias "delete_vit_path" (byval vp as cst_vit_path ptr)

type cst_vit_point_struct
	item as cst_item ptr
	num_states as integer
	num_paths as integer
	cands as cst_vit_cand ptr
	paths as cst_vit_path ptr
	state_paths as cst_vit_path ptr ptr
	next as cst_vit_point_struct ptr
end type

type cst_vit_point as cst_vit_point_struct

declare function new_vit_point cdecl alias "new_vit_point" () as cst_vit_point ptr
declare sub delete_vit_point cdecl alias "delete_vit_point" (byval vp as cst_vit_point ptr)

type cst_vit_cand_f_t as cst_vit_cand
type cst_vit_path_f_t as cst_vit_path

type cst_viterbi_struct
	num_states as integer
	cand_func as cst_vit_cand_f_t ptr
	path_func as cst_vit_path_f_t ptr
	big_is_good as integer
	timeline as cst_vit_point ptr
	last_point as cst_vit_point ptr
	f as cst_features ptr
end type

type cst_viterbi as cst_viterbi_struct

declare function new_viterbi cdecl alias "new_viterbi" (byval cand_func as cst_vit_cand_f_t ptr, byval path_func as cst_vit_path_f_t ptr) as cst_viterbi ptr
declare sub delete_viterbi cdecl alias "delete_viterbi" (byval vd as cst_viterbi ptr)
declare sub viterbi_initialise cdecl alias "viterbi_initialise" (byval vd as cst_viterbi ptr, byval r as cst_relation ptr)
declare sub viterbi_decode cdecl alias "viterbi_decode" (byval vd as cst_viterbi ptr)
declare function viterbi_result cdecl alias "viterbi_result" (byval vd as cst_viterbi ptr, byval n as zstring ptr) as integer
declare sub viterbi_copy_feature cdecl alias "viterbi_copy_feature" (byval vd as cst_viterbi ptr, byval featname as zstring ptr)

#endif
