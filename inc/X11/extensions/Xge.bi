'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   Copyright © 2007-2008 Peter Hutterer
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''   Authors: Peter Hutterer, University of South Australia, NICTA
''
''
'' translated to FreeBASIC by:
''   Copyright Â© 2015 FreeBASIC development team

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
