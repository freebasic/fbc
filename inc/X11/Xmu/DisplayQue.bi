'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1994, 1998  The Open Group
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
