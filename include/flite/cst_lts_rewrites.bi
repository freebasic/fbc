''
''
'' cst_lts_rewrites -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_lts_rewrites_bi__
#define __cst_lts_rewrites_bi__

type cst_lts_rewrites_struct
	name as zstring ptr
	sets as cst_val ptr
	rules as cst_val ptr
end type

type cst_lts_rewrites as cst_lts_rewrites_struct

declare function lts_rewrites cdecl alias "lts_rewrites" (byval itape as cst_val ptr, byval r as cst_lts_rewrites ptr) as cst_val ptr
declare function lts_rewrites_word cdecl alias "lts_rewrites_word" (byval word as zstring ptr, byval r as cst_lts_rewrites ptr) as cst_val ptr

#endif
