'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xmu/CloseHook.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_DISPLAYQUE_H_
type XmuDisplayQueue as _XmuDisplayQueue
type XmuDisplayQueueEntry as _XmuDisplayQueueEntry
type XmuCloseDisplayQueueProc as function(byval queue as XmuDisplayQueue ptr, byval entry as XmuDisplayQueueEntry ptr) as long
type XmuFreeDisplayQueueProc as function(byval queue as XmuDisplayQueue ptr) as long

type _XmuDisplayQueueEntry
	prev as _XmuDisplayQueueEntry ptr
	next as _XmuDisplayQueueEntry ptr
	display as Display ptr
	closehook as CloseHook
	data as XPointer
end type

type _XmuDisplayQueue
	nentries as long
	head as XmuDisplayQueueEntry ptr
	tail as XmuDisplayQueueEntry ptr
	closefunc as XmuCloseDisplayQueueProc
	freefunc as XmuFreeDisplayQueueProc
	data as XPointer
end type

declare function XmuDQCreate(byval closefunc as XmuCloseDisplayQueueProc, byval freefunc as XmuFreeDisplayQueueProc, byval data as XPointer) as XmuDisplayQueue ptr
declare function XmuDQDestroy(byval q as XmuDisplayQueue ptr, byval docallbacks as long) as long
declare function XmuDQLookupDisplay(byval q as XmuDisplayQueue ptr, byval dpy as Display ptr) as XmuDisplayQueueEntry ptr
declare function XmuDQAddDisplay(byval q as XmuDisplayQueue ptr, byval dpy as Display ptr, byval data as XPointer) as XmuDisplayQueueEntry ptr
declare function XmuDQRemoveDisplay(byval q as XmuDisplayQueue ptr, byval dpy as Display ptr) as long
#define XmuDQNDisplays(q) (q)->nentries

end extern
