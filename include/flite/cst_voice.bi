''
''
'' cst_voice -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_voice_bi__
#define __cst_voice_bi__

type cst_voice_struct
	name as zstring ptr
	features as cst_features ptr
	ffunctions as cst_features ptr
	utt_init as function cdecl(byval as cst_utterance ptr, byval as cst_voice_struct ptr) as cst_utterance ptr
end type

type cst_voice as cst_voice_struct

declare function new_voice cdecl alias "new_voice" () as cst_voice ptr
declare sub delete_voice cdecl alias "delete_voice" (byval u as cst_voice ptr)

#endif
