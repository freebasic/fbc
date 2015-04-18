'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1988, 1998  The Open Group
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
