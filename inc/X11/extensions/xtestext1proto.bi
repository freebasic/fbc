'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1986, 1987, 1988, 1998  The Open Group
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
''   Copyright 1986, 1987, 1988 by Hewlett-Packard Corporation
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Hewlett-Packard not be used in
''   advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   Hewlett-Packard makes no representations about the
''   suitability of this software for any purpose.  It is provided
''   "as is" without express or implied warranty.
''
''   This software is not subject to any license of the American
''   Telephone and Telegraph Company or of the Regents of the
''   University of California.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/xtestext1const.bi"

'' The following symbols have been renamed:
''     struct xTestInputActionEvent => xTestInputActionEvent_
''     struct xTestFakeAckEvent => xTestFakeAckEvent_

const _XTESTEXT1PROTO_H = 1
const X_TestFakeInput = 1
const X_TestGetInput = 2
const X_TestStopInput = 3
const X_TestReset = 4
const X_TestQueryInputSize = 5

type xTestFakeInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
	ack as CARD32
	action_list(0 to 63) as CARD8
end type

const sz_xTestFakeInputReq = XTestMAX_ACTION_LIST_SIZE + 8

type xTestGetInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
	mode as CARD32
end type

const sz_xTestGetInputReq = 8

type xTestStopInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestStopInputReq = 4

type xTestResetReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestResetReq = 4

type xTestQueryInputSizeReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestQueryInputSizeReq = 4

type xTestQueryInputSizeReply
	as CARD8 type
	pad1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	size_return as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xTestInputActionEvent_
	as CARD8 type
	pad00 as CARD8
	sequenceNumber as CARD16
	actions(0 to 27) as CARD8
end type

type xTestFakeAckEvent_
	as CARD8 type
	pad00 as CARD8
	sequenceNumber as CARD16
	pad02 as CARD32
	pad03 as CARD32
	pad04 as CARD32
	pad05 as CARD32
	pad06 as CARD32
	pad07 as CARD32
	pad08 as CARD32
end type

type XTestKeyInfo
	header as CARD8
	keycode as CARD8
	delay_time as CARD16
end type

type XTestJumpInfo
	header as CARD8
	pad1 as CARD8
	jumpx as CARD16
	jumpy as CARD16
	delay_time as CARD16
end type

type XTestMotionInfo
	header as CARD8
	motion_data as CARD8
	delay_time as CARD16
end type

type XTestDelayInfo
	header as CARD8
	pad1 as CARD8
	pad2 as CARD16
	delay_time as CARD32
end type
