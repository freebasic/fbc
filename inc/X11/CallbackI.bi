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

extern "C"

type CallbackTable as XrmResource ptr ptr
const _XtCBCalling = 1
const _XtCBFreeAfterCalling = 2

type InternalCallbackRec
	count as ushort
	is_padded as byte
	call_state as byte

	#ifdef __FB_64BIT__
		align_pad as ulong
	#endif
end type

type InternalCallbackList as InternalCallbackRec ptr
type _XtConditionProc as function(byval as XtPointer) as XBoolean
declare sub _XtAddCallback(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtAddCallbackOnce(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare function _XtCompileCallbackList(byval as XtCallbackList) as InternalCallbackList
declare function _XtGetCallbackList(byval as InternalCallbackList ptr) as XtCallbackList
declare sub _XtRemoveAllCallbacks(byval as InternalCallbackList ptr)
declare sub _XtRemoveCallback(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtPeekCallback(byval as Widget, byval as XtCallbackList, byval as XtCallbackProc ptr, byval as XtPointer ptr)
declare sub _XtCallConditionalCallbackList(byval as Widget, byval as XtCallbackList, byval as XtPointer, byval as _XtConditionProc)

end extern
