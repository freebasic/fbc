'' FreeBASIC binding for libXtst-1.2.2
''
'' based on the C header files:
''
''   Copyright 1992, 1998  The Open Group
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
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/xtestconst.bi"
#include once "X11/extensions/XInput.bi"

extern "C"

#define _XTEST_H_
declare function XTestQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XTestCompareCursorWithWindow(byval as Display ptr, byval as Window, byval as Cursor) as long
declare function XTestCompareCurrentCursorWithWindow(byval as Display ptr, byval as Window) as long
declare function XTestFakeKeyEvent(byval as Display ptr, byval as ulong, byval as long, byval as culong) as long
declare function XTestFakeButtonEvent(byval as Display ptr, byval as ulong, byval as long, byval as culong) as long
declare function XTestFakeMotionEvent(byval as Display ptr, byval as long, byval as long, byval as long, byval as culong) as long
declare function XTestFakeRelativeMotionEvent(byval as Display ptr, byval as long, byval as long, byval as culong) as long
declare function XTestFakeDeviceKeyEvent(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeDeviceButtonEvent(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeProximityEvent(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeDeviceMotionEvent(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestGrabControl(byval as Display ptr, byval as long) as long
declare sub XTestSetGContextOfGC(byval as GC, byval as GContext)
declare sub XTestSetVisualIDOfVisual(byval as Visual ptr, byval as VisualID)
declare function XTestDiscard(byval as Display ptr) as long

end extern
