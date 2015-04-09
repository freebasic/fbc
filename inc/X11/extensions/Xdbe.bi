'' FreeBASIC binding for libXext-1.3.3

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/dbe.bi"

extern "C"

#define XDBE_H

type XdbeVisualInfo
	visual as VisualID
	depth as long
	perflevel as long
end type

type XdbeScreenVisualInfo
	count as long
	visinfo as XdbeVisualInfo ptr
end type

type XdbeBackBuffer as Drawable
type XdbeSwapAction as ubyte

type XdbeSwapInfo
	swap_window as Window
	swap_action as XdbeSwapAction
end type

type XdbeBackBufferAttributes
	window as Window
end type

type XdbeBufferError
	as long type
	display as Display ptr
	buffer as XdbeBackBuffer
	serial as culong
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

declare function XdbeQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XdbeAllocateBackBufferName(byval as Display ptr, byval as Window, byval as XdbeSwapAction) as XdbeBackBuffer
declare function XdbeDeallocateBackBufferName(byval as Display ptr, byval as XdbeBackBuffer) as long
declare function XdbeSwapBuffers(byval as Display ptr, byval as XdbeSwapInfo ptr, byval as long) as long
declare function XdbeBeginIdiom(byval as Display ptr) as long
declare function XdbeEndIdiom(byval as Display ptr) as long
declare function XdbeGetVisualInfo(byval as Display ptr, byval as Drawable ptr, byval as long ptr) as XdbeScreenVisualInfo ptr
declare sub XdbeFreeVisualInfo(byval as XdbeScreenVisualInfo ptr)
declare function XdbeGetBackBufferAttributes(byval as Display ptr, byval as XdbeBackBuffer) as XdbeBackBufferAttributes ptr

end extern
