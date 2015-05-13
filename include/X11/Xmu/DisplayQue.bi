''
''
'' DisplayQue -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __DisplayQue_bi__
#define __DisplayQue_bi__

type XmuDisplayQueue as _XmuDisplayQueue
type XmuDisplayQueueEntry as _XmuDisplayQueueEntry
type XmuCloseDisplayQueueProc as function cdecl(byval as XmuDisplayQueue ptr, byval as XmuDisplayQueueEntry ptr) as integer
type XmuFreeDisplayQueueProc as function cdecl(byval as XmuDisplayQueue ptr) as integer

type _XmuDisplayQueueEntry
	prev as _XmuDisplayQueueEntry ptr
	next as _XmuDisplayQueueEntry ptr
	display as Display ptr
	closehook as CloseHook
	data as XPointer
end type

type _XmuDisplayQueue
	nentries as integer
	head as XmuDisplayQueueEntry ptr
	tail as XmuDisplayQueueEntry ptr
	closefunc as XmuCloseDisplayQueueProc
	freefunc as XmuFreeDisplayQueueProc
	data as XPointer
end type

declare function XmuDQDestroy cdecl alias "XmuDQDestroy" (byval q as XmuDisplayQueue ptr, byval docallbacks as Bool) as Bool
declare function XmuDQLookupDisplay cdecl alias "XmuDQLookupDisplay" (byval q as XmuDisplayQueue ptr, byval dpy as Display ptr) as XmuDisplayQueueEntry ptr
declare function XmuDQAddDisplay cdecl alias "XmuDQAddDisplay" (byval q as XmuDisplayQueue ptr, byval dpy as Display ptr, byval data as XPointer) as XmuDisplayQueueEntry ptr
declare function XmuDQRemoveDisplay cdecl alias "XmuDQRemoveDisplay" (byval q as XmuDisplayQueue ptr, byval dpy as Display ptr) as Bool

#endif
