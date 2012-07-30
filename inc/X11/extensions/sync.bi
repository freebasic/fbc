''
''
'' sync -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sync_bi__
#define __sync_bi__

#define SYNC_MINOR_VERSION 0
#define X_SyncInitialize 0
#define X_SyncListSystemCounters 1
#define X_SyncCreateCounter 2
#define X_SyncSetCounter 3
#define X_SyncChangeCounter 4
#define X_SyncQueryCounter 5
#define X_SyncDestroyCounter 6
#define X_SyncAwait 7
#define X_SyncCreateAlarm 8
#define X_SyncChangeAlarm 9
#define X_SyncQueryAlarm 10
#define X_SyncDestroyAlarm 11
#define X_SyncSetPriority 12
#define X_SyncGetPriority 13
#define XSyncCounterNotify 0
#define XSyncAlarmNotify 1
#define XSyncAlarmNotifyMask (1L shl 1)
#define XSyncNumberEvents 2L
#define XSyncBadCounter 0L
#define XSyncBadAlarm 1L
#define XSyncNumberErrors (1L+1)
#define XSyncCACounter (1L shl 0)
#define XSyncCAValueType (1L shl 1)
#define XSyncCAValue (1L shl 2)
#define XSyncCATestType (1L shl 3)
#define XSyncCADelta (1L shl 4)
#define XSyncCAEvents (1L shl 5)

enum XSyncValueType
	XSyncAbsolute
	XSyncRelative
end enum


enum XSyncTestType
	XSyncPositiveTransition
	XSyncNegativeTransition
	XSyncPositiveComparison
	XSyncNegativeComparison
end enum


enum XSyncAlarmState
	XSyncAlarmActive
	XSyncAlarmInactive
	XSyncAlarmDestroyed
end enum

type XSyncCounter as XID
type XSyncAlarm as XID

type _XSyncValue
	hi as integer
	lo as uinteger
end type

type XSyncValue as _XSyncValue

declare sub XSyncIntToValue cdecl alias "XSyncIntToValue" (byval as XSyncValue ptr, byval as integer)
declare sub XSyncIntsToValue cdecl alias "XSyncIntsToValue" (byval as XSyncValue ptr, byval as uinteger, byval as integer)
declare function XSyncValueGreaterThan cdecl alias "XSyncValueGreaterThan" (byval as XSyncValue, byval as XSyncValue) as Bool
declare function XSyncValueLessThan cdecl alias "XSyncValueLessThan" (byval as XSyncValue, byval as XSyncValue) as Bool
declare function XSyncValueGreaterOrEqual cdecl alias "XSyncValueGreaterOrEqual" (byval as XSyncValue, byval as XSyncValue) as Bool
declare function XSyncValueLessOrEqual cdecl alias "XSyncValueLessOrEqual" (byval as XSyncValue, byval as XSyncValue) as Bool
declare function XSyncValueEqual cdecl alias "XSyncValueEqual" (byval as XSyncValue, byval as XSyncValue) as Bool
declare function XSyncValueIsNegative cdecl alias "XSyncValueIsNegative" (byval as XSyncValue) as Bool
declare function XSyncValueIsZero cdecl alias "XSyncValueIsZero" (byval as XSyncValue) as Bool
declare function XSyncValueIsPositive cdecl alias "XSyncValueIsPositive" (byval as XSyncValue) as Bool
declare function XSyncValueLow32 cdecl alias "XSyncValueLow32" (byval as XSyncValue) as uinteger
declare function XSyncValueHigh32 cdecl alias "XSyncValueHigh32" (byval as XSyncValue) as integer
declare sub XSyncValueAdd cdecl alias "XSyncValueAdd" (byval as XSyncValue ptr, byval as XSyncValue, byval as XSyncValue, byval as integer ptr)
declare sub XSyncValueSubtract cdecl alias "XSyncValueSubtract" (byval as XSyncValue ptr, byval as XSyncValue, byval as XSyncValue, byval as integer ptr)
declare sub XSyncMaxValue cdecl alias "XSyncMaxValue" (byval as XSyncValue ptr)
declare sub XSyncMinValue cdecl alias "XSyncMinValue" (byval as XSyncValue ptr)

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
	events as Bool
	state as XSyncAlarmState
end type

type XSyncCounterNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	counter as XSyncCounter
	wait_value as XSyncValue
	counter_value as XSyncValue
	time as Time
	count as integer
	destroyed as Bool
end type

type XSyncAlarmNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	alarm as XSyncAlarm
	counter_value as XSyncValue
	alarm_value as XSyncValue
	time as Time
	state as XSyncAlarmState
end type

type XSyncAlarmError
	type as integer
	display as Display ptr
	alarm as XSyncAlarm
	serial as uinteger
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

type XSyncCounterError
	type as integer
	display as Display ptr
	counter as XSyncCounter
	serial as uinteger
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

declare function XSyncQueryExtension cdecl alias "XSyncQueryExtension" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Status
declare function XSyncInitialize cdecl alias "XSyncInitialize" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Status
declare function XSyncListSystemCounters cdecl alias "XSyncListSystemCounters" (byval as Display ptr, byval as integer ptr) as XSyncSystemCounter ptr
declare sub XSyncFreeSystemCounterList cdecl alias "XSyncFreeSystemCounterList" (byval as XSyncSystemCounter ptr)
declare function XSyncCreateCounter cdecl alias "XSyncCreateCounter" (byval as Display ptr, byval as XSyncValue) as XSyncCounter
declare function XSyncSetCounter cdecl alias "XSyncSetCounter" (byval as Display ptr, byval as XSyncCounter, byval as XSyncValue) as Status
declare function XSyncChangeCounter cdecl alias "XSyncChangeCounter" (byval as Display ptr, byval as XSyncCounter, byval as XSyncValue) as Status
declare function XSyncDestroyCounter cdecl alias "XSyncDestroyCounter" (byval as Display ptr, byval as XSyncCounter) as Status
declare function XSyncQueryCounter cdecl alias "XSyncQueryCounter" (byval as Display ptr, byval as XSyncCounter, byval as XSyncValue ptr) as Status
declare function XSyncAwait cdecl alias "XSyncAwait" (byval as Display ptr, byval as XSyncWaitCondition ptr, byval as integer) as Status
declare function XSyncCreateAlarm cdecl alias "XSyncCreateAlarm" (byval as Display ptr, byval as uinteger, byval as XSyncAlarmAttributes ptr) as XSyncAlarm
declare function XSyncDestroyAlarm cdecl alias "XSyncDestroyAlarm" (byval as Display ptr, byval as XSyncAlarm) as Status
declare function XSyncQueryAlarm cdecl alias "XSyncQueryAlarm" (byval as Display ptr, byval as XSyncAlarm, byval as XSyncAlarmAttributes ptr) as Status
declare function XSyncChangeAlarm cdecl alias "XSyncChangeAlarm" (byval as Display ptr, byval as XSyncAlarm, byval as uinteger, byval as XSyncAlarmAttributes ptr) as Status
declare function XSyncSetPriority cdecl alias "XSyncSetPriority" (byval as Display ptr, byval as XID, byval as integer) as Status
declare function XSyncGetPriority cdecl alias "XSyncGetPriority" (byval as Display ptr, byval as XID, byval as integer ptr) as Status

#endif
