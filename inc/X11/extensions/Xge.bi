#pragma once

#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XGE_H_

type XGenericEventMask
	extension as ubyte
	pad0 as ubyte
	pad1 as ushort
	evmask as ulong
end type

declare function XGEQueryExtension(byval dpy as Display ptr, byval event_basep as long ptr, byval err_basep as long ptr) as long
declare function XGEQueryVersion(byval dpy as Display ptr, byval major as long ptr, byval minor as long ptr) as long

end extern
