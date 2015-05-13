''
''
'' cst_utterance -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_utterance_bi__
#define __cst_utterance_bi__

type cst_utterance_struct
	features as cst_features ptr
	ffunctions as cst_features ptr
	relations as cst_features ptr
	ctx as cst_alloc_context
end type

declare function new_utterance cdecl alias "new_utterance" () as cst_utterance ptr
declare sub delete_utterance cdecl alias "delete_utterance" (byval u as cst_utterance ptr)
declare function utt_relation cdecl alias "utt_relation" (byval u as cst_utterance ptr, byval name as zstring ptr) as cst_relation ptr
declare function utt_relation_create cdecl alias "utt_relation_create" (byval u as cst_utterance ptr, byval name as zstring ptr) as cst_relation ptr
declare function utt_relation_delete cdecl alias "utt_relation_delete" (byval u as cst_utterance ptr, byval name as zstring ptr) as integer
declare function utt_relation_present cdecl alias "utt_relation_present" (byval u as cst_utterance ptr, byval name as zstring ptr) as integer

type cst_uttfunc as function cdecl(byval as cst_utterance ptr) as cst_utterance ptr

#endif
