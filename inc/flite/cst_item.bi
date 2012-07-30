''
''
'' cst_item -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_item_bi__
#define __cst_item_bi__

type cst_relation as cst_relation_struct
type cst_utterance as cst_utterance_struct
type cst_item as cst_item_struct

type cst_item_struct
	contents as cst_item_contents ptr
	relation as cst_relation ptr
	n as cst_item ptr
	p as cst_item ptr
	u as cst_item ptr
	d as cst_item ptr
end type

declare function new_item_relation cdecl alias "new_item_relation" (byval r as cst_relation ptr, byval i as cst_item ptr) as cst_item ptr
declare function new_item_contents cdecl alias "new_item_contents" (byval i as cst_item ptr) as cst_item_contents ptr
declare sub delete_item cdecl alias "delete_item" (byval item as cst_item ptr)
declare sub item_contents_set cdecl alias "item_contents_set" (byval current as cst_item ptr, byval i as cst_item ptr)
declare sub item_unref_contents cdecl alias "item_unref_contents" (byval i as cst_item ptr)
declare function item_as cdecl alias "item_as" (byval i as cst_item ptr, byval rname as zstring ptr) as cst_item ptr
declare function item_utt cdecl alias "item_utt" (byval i as cst_item ptr) as cst_utterance ptr
declare function item_next cdecl alias "item_next" (byval i as cst_item ptr) as cst_item ptr
declare function item_prev cdecl alias "item_prev" (byval i as cst_item ptr) as cst_item ptr
declare function item_append cdecl alias "item_append" (byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_prepend cdecl alias "item_prepend" (byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_parent cdecl alias "item_parent" (byval i as cst_item ptr) as cst_item ptr
declare function item_nth_daughter cdecl alias "item_nth_daughter" (byval i as cst_item ptr, byval n as integer) as cst_item ptr
declare function item_daughter cdecl alias "item_daughter" (byval i as cst_item ptr) as cst_item ptr
declare function item_last_daughter cdecl alias "item_last_daughter" (byval i as cst_item ptr) as cst_item ptr
declare function item_add_daughter cdecl alias "item_add_daughter" (byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_append_sibling cdecl alias "item_append_sibling" (byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_prepend_sibling cdecl alias "item_prepend_sibling" (byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_feat_present cdecl alias "item_feat_present" (byval i as cst_item ptr, byval name as zstring ptr) as integer
declare function item_feat_remove cdecl alias "item_feat_remove" (byval i as cst_item ptr, byval name as zstring ptr) as integer
declare function item_feats cdecl alias "item_feats" (byval i as cst_item ptr) as cst_features ptr
declare function item_feat cdecl alias "item_feat" (byval i as cst_item ptr, byval name as zstring ptr) as cst_val ptr
declare function item_feat_int cdecl alias "item_feat_int" (byval i as cst_item ptr, byval name as zstring ptr) as integer
declare function item_feat_float cdecl alias "item_feat_float" (byval i as cst_item ptr, byval name as zstring ptr) as single
declare function item_feat_string cdecl alias "item_feat_string" (byval i as cst_item ptr, byval name as zstring ptr) as zstring ptr
declare sub item_set cdecl alias "item_set" (byval i as cst_item ptr, byval name as zstring ptr, byval val as cst_val ptr)
declare sub item_set_int cdecl alias "item_set_int" (byval i as cst_item ptr, byval name as zstring ptr, byval val as integer)
declare sub item_set_float cdecl alias "item_set_float" (byval i as cst_item ptr, byval name as zstring ptr, byval val as single)
declare sub item_set_string cdecl alias "item_set_string" (byval i as cst_item ptr, byval name as zstring ptr, byval val as zstring ptr)
declare function item_equal cdecl alias "item_equal" (byval a as cst_item ptr, byval b as cst_item ptr) as integer
declare function ffeature_string cdecl alias "ffeature_string" (byval item as cst_item ptr, byval featpath as zstring ptr) as zstring ptr
declare function ffeature_int cdecl alias "ffeature_int" (byval item as cst_item ptr, byval featpath as zstring ptr) as integer
declare function ffeature_float cdecl alias "ffeature_float" (byval item as cst_item ptr, byval featpath as zstring ptr) as single
declare function ffeature cdecl alias "ffeature" (byval item as cst_item ptr, byval featpath as zstring ptr) as cst_val ptr
declare function path_to_item cdecl alias "path_to_item" (byval item as cst_item ptr, byval featpath as zstring ptr) as cst_item ptr

type cst_ffunction as function cdecl(byval as cst_item ptr) as cst_val ptr

declare sub ff_register cdecl alias "ff_register" (byval ffeatures as cst_features ptr, byval name as zstring ptr, byval f as cst_ffunction)
declare sub ff_unregister cdecl alias "ff_unregister" (byval ffeatures as cst_features ptr, byval name as zstring ptr)

type cst_itemfunc as function cdecl(byval as cst_item ptr) as cst_val ptr

#endif
