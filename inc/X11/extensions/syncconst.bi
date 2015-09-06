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

#include once "crt/long.bi"

#define _SYNCCONST_H_
#define SYNC_NAME "SYNC"
const SYNC_MAJOR_VERSION = 3
const SYNC_MINOR_VERSION = 1
const XSyncCounterNotify = 0
const XSyncAlarmNotify = 1
const XSyncAlarmNotifyMask = cast(clong, 1) shl XSyncAlarmNotify
const XSyncNumberEvents = cast(clong, 2)
const XSyncBadCounter = cast(clong, 0)
const XSyncBadAlarm = cast(clong, 1)
const XSyncBadFence = cast(clong, 2)
const XSyncNumberErrors = XSyncBadFence + 1
const XSyncCACounter = cast(clong, 1) shl 0
const XSyncCAValueType = cast(clong, 1) shl 1
const XSyncCAValue = cast(clong, 1) shl 2
const XSyncCATestType = cast(clong, 1) shl 3
const XSyncCADelta = cast(clong, 1) shl 4
const XSyncCAEvents = cast(clong, 1) shl 5
#macro _XSyncIntToValue(pv, i)
	scope
		(pv)->hi = iif(i < 0, not 0, 0)
		(pv)->lo = (i)
	end scope
#endmacro
#macro _XSyncIntsToValue(pv, l, h)
	scope
		(pv)->lo = (l)
		(pv)->hi = (h)
	end scope
#endmacro
#define _XSyncValueGreaterThan(a, b) (((a).hi > (b).hi) orelse (((a).hi = (b).hi) andalso ((a).lo > (b).lo)))
#define _XSyncValueLessThan(a, b) (((a).hi < (b).hi) orelse (((a).hi = (b).hi) andalso ((a).lo < (b).lo)))
#define _XSyncValueGreaterOrEqual(a, b) (((a).hi > (b).hi) orelse (((a).hi = (b).hi) andalso ((a).lo >= (b).lo)))
#define _XSyncValueLessOrEqual(a, b) (((a).hi < (b).hi) orelse (((a).hi = (b).hi) andalso ((a).lo <= (b).lo)))
#define _XSyncValueEqual(a, b) (((a).lo = (b).lo) andalso ((a).hi = (b).hi))
#define _XSyncValueIsNegative(v) iif((v).hi and &h80000000, 1, 0)
#define _XSyncValueIsZero(a) (((a).lo = 0) andalso ((a).hi = 0))
#define _XSyncValueIsPositive(v) iif((v).hi and &h80000000, 0, 1)
#define _XSyncValueLow32(v) (v).lo
#define _XSyncValueHigh32(v) (v).hi
#macro _XSyncValueAdd(presult, a, b, poverflow)
	scope
		dim t as long = (a).lo
		dim signa as long = XSyncValueIsNegative(a)
		dim signb as long = XSyncValueIsNegative(b)
		(presult)->lo = (a).lo + (b).lo
		(presult)->hi = (a).hi + (b).hi
		if t > (presult)->lo then
			(presult)->hi += 1
		end if
		(*poverflow) = -((signa = signb) andalso ((signa = XSyncValueIsNegative(*presult)) = 0))
	end scope
#endmacro
#macro _XSyncValueSubtract(presult, a, b, poverflow)
	scope
		dim t as long = (a).lo
		dim signa as long = XSyncValueIsNegative(a)
		dim signb as long = XSyncValueIsNegative(b)
		(presult)->lo = (a).lo - (b).lo
		(presult)->hi = (a).hi - (b).hi
		if t < (presult)->lo then
			(presult)->hi -= 1
		end if
		(*poverflow) = -((signa = signb) andalso ((signa = XSyncValueIsNegative(*presult)) = 0))
	end scope
#endmacro
#macro _XSyncMaxValue(pv)
	scope
		(pv)->hi = &h7fffffff
		(pv)->lo = &hffffffff
	end scope
#endmacro
#macro _XSyncMinValue(pv)
	scope
		(pv)->hi = &h80000000
		(pv)->lo = 0
	end scope
#endmacro
#define XSyncIntToValue(pv, i) _XSyncIntToValue(pv, i)
#define XSyncIntsToValue(pv, l, h) _XSyncIntsToValue(pv, l, h)
#define XSyncValueGreaterThan(a, b) _XSyncValueGreaterThan(a, b)
#define XSyncValueLessThan(a, b) _XSyncValueLessThan(a, b)
#define XSyncValueGreaterOrEqual(a, b) _XSyncValueGreaterOrEqual(a, b)
#define XSyncValueLessOrEqual(a, b) _XSyncValueLessOrEqual(a, b)
#define XSyncValueEqual(a, b) _XSyncValueEqual(a, b)
#define XSyncValueIsNegative(v) _XSyncValueIsNegative(v)
#define XSyncValueIsZero(a) _XSyncValueIsZero(a)
#define XSyncValueIsPositive(v) _XSyncValueIsPositive(v)
#define XSyncValueLow32(v) _XSyncValueLow32(v)
#define XSyncValueHigh32(v) _XSyncValueHigh32(v)
#define XSyncValueAdd(presult, a, b, poverflow) _XSyncValueAdd(presult, a, b, poverflow)
#define XSyncValueSubtract(presult, a, b, poverflow) _XSyncValueSubtract(presult, a, b, poverflow)
#define XSyncMaxValue(pv) _XSyncMaxValue(pv)
#define XSyncMinValue(pv) _XSyncMinValue(pv)

type XSyncValueType as long
enum
	XSyncAbsolute
	XSyncRelative
end enum

type XSyncTestType as long
enum
	XSyncPositiveTransition
	XSyncNegativeTransition
	XSyncPositiveComparison
	XSyncNegativeComparison
end enum

type XSyncAlarmState as long
enum
	XSyncAlarmActive
	XSyncAlarmInactive
	XSyncAlarmDestroyed
end enum

type XSyncCounter as XID
type XSyncAlarm as XID
type XSyncFence as XID

type _XSyncValue
	hi as long
	lo as ulong
end type

type XSyncValue as _XSyncValue
