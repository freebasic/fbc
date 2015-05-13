''
''
'' cst_relation -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_relation_bi__
#define __cst_relation_bi__

type cst_relation_struct
	name as zstring ptr
	features as cst_features ptr
	utterance as cst_utterance ptr
	head as cst_item ptr
	tail as cst_item ptr
end type

declare function new_relation cdecl alias "new_relation" (byval name as zstring ptr, byval u as cst_utterance ptr) as cst_relation ptr
declare sub delete_relation cdecl alias "delete_relation" (byval r as cst_relation ptr)
declare function relation_head cdecl alias "relation_head" (byval r as cst_relation ptr) as cst_item ptr
declare function relation_tail cdecl alias "relation_tail" (byval r as cst_relation ptr) as cst_item ptr
declare function relation_name cdecl alias "relation_name" (byval r as cst_relation ptr) as zstring ptr
declare function relation_append cdecl alias "relation_append" (byval r as cst_relation ptr, byval i as cst_item ptr) as cst_item ptr
declare function relation_prepend cdecl alias "relation_prepend" (byval r as cst_relation ptr, byval i as cst_item ptr) as cst_item ptr
declare function relation_load cdecl alias "relation_load" (byval r as cst_relation ptr, byval filename as zstring ptr) as integer
declare function relation_save cdecl alias "relation_save" (byval r as cst_relation ptr, byval filename as zstring ptr) as integer

#endif
