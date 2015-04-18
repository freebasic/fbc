'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   ***************************************************************************
''
''    Copyright (c) 1994, 1995  Hewlett-Packard Company
''
''    Permission is hereby granted, free of charge, to any person obtaining
''    a copy of this software and associated documentation files (the
''    "Software"), to deal in the Software without restriction, including
''    without limitation the rights to use, copy, modify, merge, publish,
''    distribute, sublicense, and/or sell copies of the Software, and to
''    permit persons to whom the Software is furnished to do so, subject to
''    the following conditions:
''
''    The above copyright notice and this permission notice shall be included
''    in all copies or substantial portions of the Software.
''
''    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''    IN NO EVENT SHALL HEWLETT-PACKARD COMPANY BE LIABLE FOR ANY CLAIM,
''    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
''    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
''    THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''    Except as contained in this notice, the name of the Hewlett-Packard
''    Company shall not be used in advertising or otherwise to promote the
''    sale, use or other dealings in this Software without prior written
''    authorization from the Hewlett-Packard Company.
''
''        Header file for Xlib-related DBE
''
''   ***************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
