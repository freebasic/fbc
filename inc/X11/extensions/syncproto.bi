'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''
''   Copyright 1991, 1993, 1994, 1998  The Open Group
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

#include once "X11/extensions/syncconst.bi"

'' The following symbols have been renamed:
''     struct xSyncSystemCounter => xSyncSystemCounter_
''     typedef xSyncWaitCondition => xSyncWaitCondition_
''     typedef xSyncCounterNotifyEvent => xSyncCounterNotifyEvent_
''     typedef xSyncAlarmNotifyEvent => xSyncAlarmNotifyEvent_

#define _SYNCPROTO_H_
const X_SyncInitialize = 0
const X_SyncListSystemCounters = 1
const X_SyncCreateCounter = 2
const X_SyncSetCounter = 3
const X_SyncChangeCounter = 4
const X_SyncQueryCounter = 5
const X_SyncDestroyCounter = 6
const X_SyncAwait = 7
const X_SyncCreateAlarm = 8
const X_SyncChangeAlarm = 9
const X_SyncQueryAlarm = 10
const X_SyncDestroyAlarm = 11
const X_SyncSetPriority = 12
const X_SyncGetPriority = 13
const X_SyncCreateFence = 14
const X_SyncTriggerFence = 15
const X_SyncResetFence = 16
const X_SyncDestroyFence = 17
const X_SyncQueryFence = 18
const X_SyncAwaitFence = 19

type _xSyncInitialize
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	majorVersion as CARD8
	minorVersion as CARD8
	pad as CARD16
end type

type xSyncInitializeReq as _xSyncInitialize
const sz_xSyncInitializeReq = 8

type xSyncInitializeReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD8
	minorVersion as CARD8
	pad as CARD16
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xSyncInitializeReply = 32

type _xSyncListSystemCounters
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
end type

type xSyncListSystemCountersReq as _xSyncListSystemCounters
const sz_xSyncListSystemCountersReq = 4

type xSyncListSystemCountersReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	nCounters as INT32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xSyncListSystemCountersReply = 32

type xSyncSystemCounter_
	counter as CARD32
	resolution_hi as INT32
	resolution_lo as CARD32
	name_length as CARD16
end type

const sz_xSyncSystemCounter = 14

type _xSyncCreateCounterReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	cid as CARD32
	initial_value_hi as INT32
	initial_value_lo as CARD32
end type

type xSyncCreateCounterReq as _xSyncCreateCounterReq
const sz_xSyncCreateCounterReq = 16

type _xSyncChangeCounterReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	cid as CARD32
	value_hi as INT32
	value_lo as CARD32
end type

type xSyncChangeCounterReq as _xSyncChangeCounterReq
const sz_xSyncChangeCounterReq = 16

type _xSyncSetCounterReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	cid as CARD32
	value_hi as INT32
	value_lo as CARD32
end type

type xSyncSetCounterReq as _xSyncSetCounterReq
const sz_xSyncSetCounterReq = 16

type _xSyncDestroyCounterReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	counter as CARD32
end type

type xSyncDestroyCounterReq as _xSyncDestroyCounterReq
const sz_xSyncDestroyCounterReq = 8

type _xSyncQueryCounterReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	counter as CARD32
end type

type xSyncQueryCounterReq as _xSyncQueryCounterReq
const sz_xSyncQueryCounterReq = 8

type xSyncQueryCounterReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	value_hi as INT32
	value_lo as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

const sz_xSyncQueryCounterReply = 32

type _xSyncAwaitReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
end type

type xSyncAwaitReq as _xSyncAwaitReq
const sz_xSyncAwaitReq = 4

type _xSyncWaitCondition
	counter as CARD32
	value_type as CARD32
	wait_value_hi as INT32
	wait_value_lo as CARD32
	test_type as CARD32
	event_threshold_hi as INT32
	event_threshold_lo as CARD32
end type

type xSyncWaitCondition_ as _xSyncWaitCondition
const sz_xSyncWaitCondition = 28

type _xSyncCreateAlarmReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	id as CARD32
	valueMask as CARD32
end type

type xSyncCreateAlarmReq as _xSyncCreateAlarmReq
const sz_xSyncCreateAlarmReq = 12

type _xSyncDestroyAlarmReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	alarm as CARD32
end type

type xSyncDestroyAlarmReq as _xSyncDestroyAlarmReq
const sz_xSyncDestroyAlarmReq = 8

type _xSyncQueryAlarmReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	alarm as CARD32
end type

type xSyncQueryAlarmReq as _xSyncQueryAlarmReq
const sz_xSyncQueryAlarmReq = 8

type xSyncQueryAlarmReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	counter as CARD32
	value_type as CARD32
	wait_value_hi as INT32
	wait_value_lo as CARD32
	test_type as CARD32
	delta_hi as INT32
	delta_lo as CARD32
	events as XBOOL
	state as UBYTE
	pad0 as UBYTE
	pad1 as UBYTE
end type

const sz_xSyncQueryAlarmReply = 40

type _xSyncChangeAlarmReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	alarm as CARD32
	valueMask as CARD32
end type

type xSyncChangeAlarmReq as _xSyncChangeAlarmReq
const sz_xSyncChangeAlarmReq = 12

type _xSyncSetPriority
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	id as CARD32
	priority as INT32
end type

type xSyncSetPriorityReq as _xSyncSetPriority
const sz_xSyncSetPriorityReq = 12

type _xSyncGetPriority
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	id as CARD32
end type

type xSyncGetPriorityReq as _xSyncGetPriority
const sz_xSyncGetPriorityReq = 8

type xSyncGetPriorityReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	priority as INT32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xSyncGetPriorityReply = 32

type _xSyncCreateFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	d as CARD32
	fid as CARD32
	initially_triggered as XBOOL
	pad0 as CARD8
	pad1 as CARD16
end type

type xSyncCreateFenceReq as _xSyncCreateFenceReq
const sz_xSyncCreateFenceReq = 16

type _xSyncTriggerFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	fid as CARD32
end type

type xSyncTriggerFenceReq as _xSyncTriggerFenceReq
const sz_xSyncTriggerFenceReq = 8

type _xSyncResetFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	fid as CARD32
end type

type xSyncResetFenceReq as _xSyncResetFenceReq
const sz_xSyncResetFenceReq = 8

type _xSyncDestroyFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	fid as CARD32
end type

type xSyncDestroyFenceReq as _xSyncDestroyFenceReq
const sz_xSyncDestroyFenceReq = 8

type _xSyncQueryFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
	fid as CARD32
end type

type xSyncQueryFenceReq as _xSyncQueryFenceReq
const sz_xSyncQueryFenceReq = 8

type _xSyncAwaitFenceReq
	reqType as CARD8
	syncReqType as CARD8
	length as CARD16
end type

type xSyncAwaitFenceReq as _xSyncAwaitFenceReq
const sz_xSyncAwaitFenceReq = 4

type xSyncQueryFenceReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	triggered as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xSyncQueryFenceReply = 32

type _xSyncCounterNotifyEvent
	as UBYTE type
	kind as UBYTE
	sequenceNumber as CARD16
	counter as CARD32
	wait_value_hi as INT32
	wait_value_lo as CARD32
	counter_value_hi as INT32
	counter_value_lo as CARD32
	time as CARD32
	count as CARD16
	destroyed as XBOOL
	pad0 as UBYTE
end type

type xSyncCounterNotifyEvent_ as _xSyncCounterNotifyEvent

type _xSyncAlarmNotifyEvent
	as UBYTE type
	kind as UBYTE
	sequenceNumber as CARD16
	alarm as CARD32
	counter_value_hi as INT32
	counter_value_lo as CARD32
	alarm_value_hi as INT32
	alarm_value_lo as CARD32
	time as CARD32
	state as CARD8
	pad0 as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xSyncAlarmNotifyEvent_ as _xSyncAlarmNotifyEvent
