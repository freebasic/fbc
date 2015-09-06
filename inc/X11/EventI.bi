'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1998  The Open Group
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
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "PassivGraI.bi"

extern "C"

#define _Event_h_
declare sub _XtEventInitialize()

type _XtEventRec
	next as XtEventTable
	mask as EventMask
	proc as XtEventHandler
	closure as XtPointer
	select : 1 as ulong
	has_type_specifier : 1 as ulong
	async : 1 as ulong
end type

type XtEventRec as _XtEventRec

type _XtGrabRec
	next as XtGrabList
	widget as Widget
	exclusive : 1 as ulong
	spring_loaded : 1 as ulong
end type

type XtGrabRec as _XtGrabRec

type _BlockHookRec
	next as _BlockHookRec ptr
	app as XtAppContext
	proc as XtBlockHookProc
	closure as XtPointer
end type

type BlockHookRec as _BlockHookRec
type BlockHook as _BlockHookRec ptr
declare sub _XtFreeEventTable(byval as XtEventTable ptr)
declare function _XtOnGrabList(byval as Widget, byval as XtGrabRec ptr) as XBoolean
declare sub _XtRemoveAllInputs(byval as XtAppContext)
declare sub _XtRefreshMapping(byval as XEvent ptr, byval as XBoolean)
declare sub _XtSendFocusEvent(byval as Widget, byval as long)
declare function _XtConvertTypeToMask(byval as long) as EventMask
declare function _XtFindRemapWidget(byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput) as Widget
declare sub _XtUngrabBadGrabs(byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput)
declare sub _XtFillAncestorList(byval listPtr as Widget ptr ptr, byval maxElemsPtr as long ptr, byval numElemsPtr as long ptr, byval start as Widget, byval breakWidget as Widget)
extern XtAppPeekEvent_SkipTimer as XBoolean

end extern
