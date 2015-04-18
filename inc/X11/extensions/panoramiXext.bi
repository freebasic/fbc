'' FreeBASIC binding for libXinerama-1.1.3
''
'' based on the C header files:
''   ***************************************************************
''   Copyright (c) 1991, 1997 Digital Equipment Corporation, Maynard, Massachusetts.
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   DIGITAL EQUIPMENT CORPORATION BE LIABLE FOR ANY CLAIM, DAMAGES, INCLUDING,
''   BUT NOT LIMITED TO CONSEQUENTIAL OR INCIDENTAL DAMAGES, OR OTHER LIABILITY,
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
''   IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Digital Equipment Corporation
''   shall not be used in advertising or otherwise to promote the sale, use or other
''   dealings in this Software without prior written authorization from Digital
''   Equipment Corporation.
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _panoramiXext_h

type XPanoramiXInfo
	window as Window
	screen as long
	State as long
	width as long
	height as long
	ScreenCount as long
	eventMask as XID
end type

declare function XPanoramiXQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XPanoramiXQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XPanoramiXAllocInfo() as XPanoramiXInfo ptr
declare function XPanoramiXGetState(byval as Display ptr, byval as Drawable, byval as XPanoramiXInfo ptr) as long
declare function XPanoramiXGetScreenCount(byval as Display ptr, byval as Drawable, byval as XPanoramiXInfo ptr) as long
declare function XPanoramiXGetScreenSize(byval as Display ptr, byval as Drawable, byval as long, byval as XPanoramiXInfo ptr) as long

end extern
