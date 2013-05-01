''
''
'' cdmf_private -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdmf_private_bi__
#define __cdmf_private_bi__

type cdCanvasMF
	canvas as cdCanvas ptr
	filename as zstring ptr
	data as any ptr
end type

type cdCanvasMF as any

declare sub cdcreatecanvasMF cdecl alias "cdcreatecanvasMF" (byval canvas as cdCanvas ptr, byval data as any ptr)
declare sub cdinittableMF cdecl alias "cdinittableMF" (byval canvas as cdCanvas ptr)
declare sub cdkillcanvasMF cdecl alias "cdkillcanvasMF" (byval mfcanvas as cdCanvasMF ptr)

#endif
