''
''
'' cst_lts -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_lts_bi__
#define __cst_lts_bi__

type cst_lts_addr as ushort
type cst_lts_phone as integer
type cst_lts_feat as ubyte
type cst_lts_letter as ubyte
type cst_lts_model as ubyte

#define CST_LTS_EOR 255

type cst_lts_rules_struct
	name as zstring ptr
	letter_index as cst_lts_addr ptr
	models as cst_lts_model ptr
	phone_table as byte ptr ptr
	context_window_size as integer
	context_extra_feats as integer
	letter_table as byte ptr ptr
end type

type cst_lts_rules as cst_lts_rules_struct

type cst_lts_rule_struct
	feat as cst_lts_feat
	val as cst_lts_letter
	qtrue as cst_lts_addr
	qfalse as cst_lts_addr
end type

type cst_lts_rule as cst_lts_rule_struct

declare function new_lts_rules cdecl alias "new_lts_rules" () as cst_lts_rules ptr
declare function lts_apply cdecl alias "lts_apply" (byval word as zstring ptr, byval feats as zstring ptr, byval r as cst_lts_rules ptr) as cst_val ptr
declare function lts_apply_val cdecl alias "lts_apply_val" (byval wlist as cst_val ptr, byval feats as zstring ptr, byval r as cst_lts_rules ptr) as cst_val ptr

#endif
