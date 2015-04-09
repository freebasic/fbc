'' FreeBASIC binding for libXext-1.3.3

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/syncconst.bi"

extern "C"

#define _SYNC_H_
declare sub XSyncIntToValue(byval as XSyncValue ptr, byval as long)
declare sub XSyncIntsToValue(byval as XSyncValue ptr, byval as ulong, byval as long)
declare function XSyncValueGreaterThan(byval as XSyncValue, byval as XSyncValue) as long
declare function XSyncValueLessThan(byval as XSyncValue, byval as XSyncValue) as long
declare function XSyncValueGreaterOrEqual(byval as XSyncValue, byval as XSyncValue) as long
declare function XSyncValueLessOrEqual(byval as XSyncValue, byval as XSyncValue) as long
declare function XSyncValueEqual(byval as XSyncValue, byval as XSyncValue) as long
declare function XSyncValueIsNegative(byval as XSyncValue) as long
declare function XSyncValueIsZero(byval as XSyncValue) as long
declare function XSyncValueIsPositive(byval as XSyncValue) as long
declare function XSyncValueLow32(byval as XSyncValue) as ulong
declare function XSyncValueHigh32(byval as XSyncValue) as long
declare sub XSyncValueAdd(byval as XSyncValue ptr, byval as XSyncValue, byval as XSyncValue, byval as long ptr)
declare sub XSyncValueSubtract(byval as XSyncValue ptr, byval as XSyncValue, byval as XSyncValue, byval as long ptr)
declare sub XSyncMaxValue(byval as XSyncValue ptr)
declare sub XSyncMinValue(byval as XSyncValue ptr)

type _XSyncSystemCounter
	name as zstring ptr
	counter as XSyncCounter
	resolution as XSyncValue
end type

type XSyncSystemCounter as _XSyncSystemCounter

type XSyncTrigger
	counter as XSyncCounter
	value_type as XSyncValueType
	wait_value as XSyncValue
	test_type as XSyncTestType
end type

type XSyncWaitCondition
	trigger as XSyncTrigger
	event_threshold as XSyncValue
end type

type XSyncAlarmAttributes
	trigger as XSyncTrigger
	delta as XSyncValue
	events as long
	state as XSyncAlarmState
end type

type XSyncCounterNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	counter as XSyncCounter
	wait_value as XSyncValue
	counter_value as XSyncValue
	time as Time
	count as long
	destroyed as long
end type

type XSyncAlarmNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	alarm as XSyncAlarm
	counter_value as XSyncValue
	alarm_value as XSyncValue
	time as Time
	state as XSyncAlarmState
end type

type XSyncAlarmError
	as long type
	display as Display ptr
	alarm as XSyncAlarm
	serial as culong
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

type XSyncCounterError
	as long type
	display as Display ptr
	counter as XSyncCounter
	serial as culong
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

declare function XSyncQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XSyncInitialize(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XSyncListSystemCounters(byval as Display ptr, byval as long ptr) as XSyncSystemCounter ptr
declare sub XSyncFreeSystemCounterList(byval as XSyncSystemCounter ptr)
declare function XSyncCreateCounter(byval as Display ptr, byval as XSyncValue) as XSyncCounter
declare function XSyncSetCounter(byval as Display ptr, byval as XSyncCounter, byval as XSyncValue) as long
declare function XSyncChangeCounter(byval as Display ptr, byval as XSyncCounter, byval as XSyncValue) as long
declare function XSyncDestroyCounter(byval as Display ptr, byval as XSyncCounter) as long
declare function XSyncQueryCounter(byval as Display ptr, byval as XSyncCounter, byval as XSyncValue ptr) as long
declare function XSyncAwait(byval as Display ptr, byval as XSyncWaitCondition ptr, byval as long) as long
declare function XSyncCreateAlarm(byval as Display ptr, byval as culong, byval as XSyncAlarmAttributes ptr) as XSyncAlarm
declare function XSyncDestroyAlarm(byval as Display ptr, byval as XSyncAlarm) as long
declare function XSyncQueryAlarm(byval as Display ptr, byval as XSyncAlarm, byval as XSyncAlarmAttributes ptr) as long
declare function XSyncChangeAlarm(byval as Display ptr, byval as XSyncAlarm, byval as culong, byval as XSyncAlarmAttributes ptr) as long
declare function XSyncSetPriority(byval as Display ptr, byval as XID, byval as long) as long
declare function XSyncGetPriority(byval as Display ptr, byval as XID, byval as long ptr) as long
declare function XSyncCreateFence(byval as Display ptr, byval as Drawable, byval as long) as XSyncFence
declare function XSyncTriggerFence(byval as Display ptr, byval as XSyncFence) as long
declare function XSyncResetFence(byval as Display ptr, byval as XSyncFence) as long
declare function XSyncDestroyFence(byval as Display ptr, byval as XSyncFence) as long
declare function XSyncQueryFence(byval as Display ptr, byval as XSyncFence, byval as long ptr) as long
declare function XSyncAwaitFence(byval as Display ptr, byval as const XSyncFence ptr, byval as long) as long

end extern
