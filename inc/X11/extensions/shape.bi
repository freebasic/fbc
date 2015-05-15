'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/shapeconst.bi"
#include once "X11/Xutil.bi"

extern "C"

#define _SHAPE_H_

type XShapeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	kind as long
	x as long
	y as long
	width as ulong
	height as ulong
	time as Time
	shaped as long
end type

declare function XShapeQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XShapeQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare sub XShapeCombineRegion(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Region, byval as long)
declare sub XShapeCombineRectangles(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as XRectangle ptr, byval as long, byval as long, byval as long)
declare sub XShapeCombineMask(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Pixmap, byval as long)
declare sub XShapeCombineShape(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Window, byval as long, byval as long)
declare sub XShapeOffsetShape(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long)
declare function XShapeQueryExtents(byval as Display ptr, byval as Window, byval as long ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr) as long
declare sub XShapeSelectInput(byval as Display ptr, byval as Window, byval as culong)
declare function XShapeInputSelected(byval as Display ptr, byval as Window) as culong
declare function XShapeGetRectangles(byval as Display ptr, byval as Window, byval as long, byval as long ptr, byval as long ptr) as XRectangle ptr

end extern
