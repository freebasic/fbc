'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
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

#include once "crt/long.bi"
#include once "Intrinsic.bi"

'' The following symbols have been renamed:
''     typedef Select => Select_

#define _XtselectionI_h
type Request as _RequestRec ptr
type Select_ as _SelectRec ptr

type _RequestRec
	ctx as Select_
	widget as Widget
	requestor as Window
	property as XAtom
	target as XAtom
	as XAtom type
	format as long
	value as XtPointer
	bytelength as culong
	offset as culong
	timeout as XtIntervalId
	event as XSelectionRequestEvent
	allSent as XBoolean
end type

type RequestRec as _RequestRec

type SelectionPropRec
	prop as XAtom
	avail as XBoolean
end type

type SelectionProp as SelectionPropRec ptr

type PropListRec
	dpy as Display ptr
	incr_atom as XAtom
	indirect_atom as XAtom
	timestamp_atom as XAtom
	propCount as long
	list as SelectionProp
end type

type PropList as PropListRec ptr

type _SelectRec
	selection as XAtom
	dpy as Display ptr
	widget as Widget
	time as Time
	serial as culong
	convert as XtConvertSelectionProc
	loses as XtLoseSelectionProc
	notify as XtSelectionDoneProc
	owner_cancel as XtCancelConvertSelectionProc
	owner_closure as XtPointer
	prop_list as PropList
	req as Request
	ref_count as long
	incremental : 1 as ulong
	free_when_done : 1 as ulong
	was_disowned : 1 as ulong
end type

type SelectRec as _SelectRec

type _ParamRec
	selection as XAtom
	param as XAtom
end type

type ParamRec as _ParamRec
type Param as _ParamRec ptr

type _ParamInfoRec
	count as ulong
	paramlist as Param
end type

type ParamInfoRec as _ParamInfoRec
type ParamInfo as _ParamInfoRec ptr

type _QueuedRequestRec
	selection as XAtom
	target as XAtom
	param as XAtom
	callback as XtSelectionCallbackProc
	closure as XtPointer
	time as Time
	incremental as XBoolean
end type

type QueuedRequestRec as _QueuedRequestRec
type QueuedRequest as _QueuedRequestRec ptr

type _QueuedRequestInfoRec
	count as long
	selections as XAtom ptr
	requests as QueuedRequest ptr
end type

type QueuedRequestInfoRec as _QueuedRequestInfoRec
type QueuedRequestInfo as _QueuedRequestInfoRec ptr

type CallBackInfoRec
	callbacks as XtSelectionCallbackProc ptr
	req_closure as XtPointer ptr
	property as XAtom
	target as XAtom ptr
	as XAtom type
	format as long
	value as zstring ptr
	bytelength as long
	offset as long
	timeout as XtIntervalId
	proc as XtEventHandler
	widget as Widget
	time as Time
	ctx as Select_
	incremental as XBoolean ptr
	current as long
end type

type CallBackInfo as CallBackInfoRec ptr

type IndirectPair
	target as XAtom
	property as XAtom
end type

const IndirectPairWordSize = 2

type RequestWindowRec
	active_transfer_count as long
end type

#define MAX_SELECTION_INCR(dpy) (iif(65536 < XMaxRequestSize(dpy), 65536 shl 2, XMaxRequestSize(dpy) shl 2) - 100)
#define MATCH_SELECT(event, info) ((((event->time = info->time) andalso (event->requestor = XtWindow(info->widget))) andalso (event->selection = info->ctx->selection)) andalso (event->target = (*info->target)))
