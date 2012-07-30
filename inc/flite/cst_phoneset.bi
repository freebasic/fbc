''
''
'' cst_phoneset -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_phoneset_bi__
#define __cst_phoneset_bi__

type cst_phoneset_struct
	name as zstring ptr
	featnames as byte ptr ptr
	featvals as cst_val ptr ptr
	phonenames as byte ptr ptr
	silence as zstring ptr
	num_phones as integer
	fvtable as integer ptr ptr
end type

type cst_phoneset as cst_phoneset_struct

declare function new_phoneset cdecl alias "new_phoneset" () as cst_phoneset ptr
declare sub delete_phoneset cdecl alias "delete_phoneset" (byval u as cst_phoneset ptr)
declare function phone_feature cdecl alias "phone_feature" (byval ps as cst_phoneset ptr, byval phonename as zstring ptr, byval featname as zstring ptr) as cst_val ptr
declare function phone_feature_string cdecl alias "phone_feature_string" (byval ps as cst_phoneset ptr, byval phonename as zstring ptr, byval featname as zstring ptr) as zstring ptr
declare function phone_id cdecl alias "phone_id" (byval ps as cst_phoneset ptr, byval phonename as zstring ptr) as integer
declare function phone_feat_id cdecl alias "phone_feat_id" (byval ps as cst_phoneset ptr, byval featname as zstring ptr) as integer
declare function item_phoneset cdecl alias "item_phoneset" (byval i as cst_item ptr) as cst_phoneset ptr

#endif
