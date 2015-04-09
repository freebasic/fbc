'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xlibint.bi"

extern "C"

#define _XMU_CLOSEHOOK_H_
type CloseHook as XPointer
type XmuCloseHookProc as function(byval dpy as Display ptr, byval data as XPointer) as long
declare function XmuAddCloseDisplayHook(byval dpy as Display ptr, byval proc as XmuCloseHookProc, byval arg as XPointer) as CloseHook
declare function XmuLookupCloseDisplayHook(byval dpy as Display ptr, byval handle as CloseHook, byval proc as XmuCloseHookProc, byval arg as XPointer) as long
declare function XmuRemoveCloseDisplayHook(byval dpy as Display ptr, byval handle as CloseHook, byval proc as XmuCloseHookProc, byval arg as XPointer) as long

end extern
