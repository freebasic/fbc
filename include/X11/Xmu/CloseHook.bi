''
''
'' CloseHook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CloseHook_bi__
#define __CloseHook_bi__

type CloseHook as XPointer
type XmuCloseHookProc as function cdecl(byval as Display ptr, byval as XPointer) as integer

declare function XmuRemoveCloseDisplayHook cdecl alias "XmuRemoveCloseDisplayHook" (byval dpy as Display ptr, byval handle as CloseHook, byval proc as XmuCloseHookProc, byval arg as XPointer) as Bool

#endif
