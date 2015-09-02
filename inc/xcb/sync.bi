'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2004 Mikko Torni and Josh Triplett.
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person
''   obtaining a copy of this software and associated
''   documentation files (the "Software"), to deal in the
''   Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute,
''   sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so,
''   subject to the following conditions:
''
''   The above copyright notice and this permission notice shall
''   be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
''   KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
''   WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
''   PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
''   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the names of the authors
''   or their institutions shall not be used in advertising or
''   otherwise to promote the sale, use or other dealings in this
''   Software without prior written authorization from the
''   authors.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_SYNC_INITIALIZE => XCB_SYNC_INITIALIZE_
''     constant XCB_SYNC_LIST_SYSTEM_COUNTERS => XCB_SYNC_LIST_SYSTEM_COUNTERS_
''     constant XCB_SYNC_CREATE_COUNTER => XCB_SYNC_CREATE_COUNTER_
''     constant XCB_SYNC_DESTROY_COUNTER => XCB_SYNC_DESTROY_COUNTER_
''     constant XCB_SYNC_QUERY_COUNTER => XCB_SYNC_QUERY_COUNTER_
''     constant XCB_SYNC_AWAIT => XCB_SYNC_AWAIT_
''     constant XCB_SYNC_CHANGE_COUNTER => XCB_SYNC_CHANGE_COUNTER_
''     constant XCB_SYNC_SET_COUNTER => XCB_SYNC_SET_COUNTER_
''     constant XCB_SYNC_CREATE_ALARM => XCB_SYNC_CREATE_ALARM_
''     constant XCB_SYNC_CHANGE_ALARM => XCB_SYNC_CHANGE_ALARM_
''     constant XCB_SYNC_DESTROY_ALARM => XCB_SYNC_DESTROY_ALARM_
''     constant XCB_SYNC_QUERY_ALARM => XCB_SYNC_QUERY_ALARM_
''     constant XCB_SYNC_SET_PRIORITY => XCB_SYNC_SET_PRIORITY_
''     constant XCB_SYNC_GET_PRIORITY => XCB_SYNC_GET_PRIORITY_
''     constant XCB_SYNC_CREATE_FENCE => XCB_SYNC_CREATE_FENCE_
''     constant XCB_SYNC_TRIGGER_FENCE => XCB_SYNC_TRIGGER_FENCE_
''     constant XCB_SYNC_RESET_FENCE => XCB_SYNC_RESET_FENCE_
''     constant XCB_SYNC_DESTROY_FENCE => XCB_SYNC_DESTROY_FENCE_
''     constant XCB_SYNC_QUERY_FENCE => XCB_SYNC_QUERY_FENCE_
''     constant XCB_SYNC_AWAIT_FENCE => XCB_SYNC_AWAIT_FENCE_

extern "C"

#define __SYNC_H
const XCB_SYNC_MAJOR_VERSION = 3
const XCB_SYNC_MINOR_VERSION = 1
extern xcb_sync_id as xcb_extension_t
type xcb_sync_alarm_t as ulong

type xcb_sync_alarm_iterator_t
	data as xcb_sync_alarm_t ptr
	as long rem
	index as long
end type

type xcb_sync_alarmstate_t as long
enum
	XCB_SYNC_ALARMSTATE_ACTIVE = 0
	XCB_SYNC_ALARMSTATE_INACTIVE = 1
	XCB_SYNC_ALARMSTATE_DESTROYED = 2
end enum

type xcb_sync_counter_t as ulong

type xcb_sync_counter_iterator_t
	data as xcb_sync_counter_t ptr
	as long rem
	index as long
end type

type xcb_sync_fence_t as ulong

type xcb_sync_fence_iterator_t
	data as xcb_sync_fence_t ptr
	as long rem
	index as long
end type

type xcb_sync_testtype_t as long
enum
	XCB_SYNC_TESTTYPE_POSITIVE_TRANSITION = 0
	XCB_SYNC_TESTTYPE_NEGATIVE_TRANSITION = 1
	XCB_SYNC_TESTTYPE_POSITIVE_COMPARISON = 2
	XCB_SYNC_TESTTYPE_NEGATIVE_COMPARISON = 3
end enum

type xcb_sync_valuetype_t as long
enum
	XCB_SYNC_VALUETYPE_ABSOLUTE = 0
	XCB_SYNC_VALUETYPE_RELATIVE = 1
end enum

type xcb_sync_ca_t as long
enum
	XCB_SYNC_CA_COUNTER = 1
	XCB_SYNC_CA_VALUE_TYPE = 2
	XCB_SYNC_CA_VALUE = 4
	XCB_SYNC_CA_TEST_TYPE = 8
	XCB_SYNC_CA_DELTA = 16
	XCB_SYNC_CA_EVENTS = 32
end enum

type xcb_sync_int64_t
	hi as long
	lo as ulong
end type

type xcb_sync_int64_iterator_t
	data as xcb_sync_int64_t ptr
	as long rem
	index as long
end type

type xcb_sync_systemcounter_t
	counter as xcb_sync_counter_t
	resolution as xcb_sync_int64_t
	name_len as ushort
end type

type xcb_sync_systemcounter_iterator_t
	data as xcb_sync_systemcounter_t ptr
	as long rem
	index as long
end type

type xcb_sync_trigger_t
	counter as xcb_sync_counter_t
	wait_type as ulong
	wait_value as xcb_sync_int64_t
	test_type as ulong
end type

type xcb_sync_trigger_iterator_t
	data as xcb_sync_trigger_t ptr
	as long rem
	index as long
end type

type xcb_sync_waitcondition_t
	trigger as xcb_sync_trigger_t
	event_threshold as xcb_sync_int64_t
end type

type xcb_sync_waitcondition_iterator_t
	data as xcb_sync_waitcondition_t ptr
	as long rem
	index as long
end type

const XCB_SYNC_COUNTER = 0

type xcb_sync_counter_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	bad_counter as ulong
	minor_opcode as ushort
	major_opcode as ubyte
end type

const XCB_SYNC_ALARM = 1

type xcb_sync_alarm_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	bad_alarm as ulong
	minor_opcode as ushort
	major_opcode as ubyte
end type

type xcb_sync_initialize_cookie_t
	sequence as ulong
end type

const XCB_SYNC_INITIALIZE_ = 0

type xcb_sync_initialize_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	desired_major_version as ubyte
	desired_minor_version as ubyte
end type

type xcb_sync_initialize_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ubyte
	minor_version as ubyte
	pad1(0 to 21) as ubyte
end type

type xcb_sync_list_system_counters_cookie_t
	sequence as ulong
end type

const XCB_SYNC_LIST_SYSTEM_COUNTERS_ = 1

type xcb_sync_list_system_counters_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_sync_list_system_counters_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	counters_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SYNC_CREATE_COUNTER_ = 2

type xcb_sync_create_counter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	id as xcb_sync_counter_t
	initial_value as xcb_sync_int64_t
end type

const XCB_SYNC_DESTROY_COUNTER_ = 6

type xcb_sync_destroy_counter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	counter as xcb_sync_counter_t
end type

type xcb_sync_query_counter_cookie_t
	sequence as ulong
end type

const XCB_SYNC_QUERY_COUNTER_ = 5

type xcb_sync_query_counter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	counter as xcb_sync_counter_t
end type

type xcb_sync_query_counter_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	counter_value as xcb_sync_int64_t
end type

const XCB_SYNC_AWAIT_ = 7

type xcb_sync_await_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

const XCB_SYNC_CHANGE_COUNTER_ = 4

type xcb_sync_change_counter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	counter as xcb_sync_counter_t
	amount as xcb_sync_int64_t
end type

const XCB_SYNC_SET_COUNTER_ = 3

type xcb_sync_set_counter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	counter as xcb_sync_counter_t
	value as xcb_sync_int64_t
end type

type xcb_sync_create_alarm_value_list_t
	counter as xcb_sync_counter_t
	valueType as ulong
	value as xcb_sync_int64_t
	testType as ulong
	delta as xcb_sync_int64_t
	events as ulong
end type

const XCB_SYNC_CREATE_ALARM_ = 8

type xcb_sync_create_alarm_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	id as xcb_sync_alarm_t
	value_mask as ulong
end type

type xcb_sync_change_alarm_value_list_t
	counter as xcb_sync_counter_t
	valueType as ulong
	value as xcb_sync_int64_t
	testType as ulong
	delta as xcb_sync_int64_t
	events as ulong
end type

const XCB_SYNC_CHANGE_ALARM_ = 9

type xcb_sync_change_alarm_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	id as xcb_sync_alarm_t
	value_mask as ulong
end type

const XCB_SYNC_DESTROY_ALARM_ = 11

type xcb_sync_destroy_alarm_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	alarm as xcb_sync_alarm_t
end type

type xcb_sync_query_alarm_cookie_t
	sequence as ulong
end type

const XCB_SYNC_QUERY_ALARM_ = 10

type xcb_sync_query_alarm_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	alarm as xcb_sync_alarm_t
end type

type xcb_sync_query_alarm_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	trigger as xcb_sync_trigger_t
	delta as xcb_sync_int64_t
	events as ubyte
	state as ubyte
	pad1(0 to 1) as ubyte
end type

const XCB_SYNC_SET_PRIORITY_ = 12

type xcb_sync_set_priority_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	id as ulong
	priority as long
end type

type xcb_sync_get_priority_cookie_t
	sequence as ulong
end type

const XCB_SYNC_GET_PRIORITY_ = 13

type xcb_sync_get_priority_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	id as ulong
end type

type xcb_sync_get_priority_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	priority as long
end type

const XCB_SYNC_CREATE_FENCE_ = 14

type xcb_sync_create_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	fence as xcb_sync_fence_t
	initially_triggered as ubyte
end type

const XCB_SYNC_TRIGGER_FENCE_ = 15

type xcb_sync_trigger_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	fence as xcb_sync_fence_t
end type

const XCB_SYNC_RESET_FENCE_ = 16

type xcb_sync_reset_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	fence as xcb_sync_fence_t
end type

const XCB_SYNC_DESTROY_FENCE_ = 17

type xcb_sync_destroy_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	fence as xcb_sync_fence_t
end type

type xcb_sync_query_fence_cookie_t
	sequence as ulong
end type

const XCB_SYNC_QUERY_FENCE_ = 18

type xcb_sync_query_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	fence as xcb_sync_fence_t
end type

type xcb_sync_query_fence_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	triggered as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_SYNC_AWAIT_FENCE_ = 19

type xcb_sync_await_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

const XCB_SYNC_COUNTER_NOTIFY = 0

type xcb_sync_counter_notify_event_t
	response_type as ubyte
	kind as ubyte
	sequence as ushort
	counter as xcb_sync_counter_t
	wait_value as xcb_sync_int64_t
	counter_value as xcb_sync_int64_t
	timestamp as xcb_timestamp_t
	count as ushort
	destroyed as ubyte
	pad0 as ubyte
end type

const XCB_SYNC_ALARM_NOTIFY = 1

type xcb_sync_alarm_notify_event_t
	response_type as ubyte
	kind as ubyte
	sequence as ushort
	alarm as xcb_sync_alarm_t
	counter_value as xcb_sync_int64_t
	alarm_value as xcb_sync_int64_t
	timestamp as xcb_timestamp_t
	state as ubyte
	pad0(0 to 2) as ubyte
end type

declare sub xcb_sync_alarm_next(byval i as xcb_sync_alarm_iterator_t ptr)
declare function xcb_sync_alarm_end(byval i as xcb_sync_alarm_iterator_t) as xcb_generic_iterator_t
declare sub xcb_sync_counter_next(byval i as xcb_sync_counter_iterator_t ptr)
declare function xcb_sync_counter_end(byval i as xcb_sync_counter_iterator_t) as xcb_generic_iterator_t
declare sub xcb_sync_fence_next(byval i as xcb_sync_fence_iterator_t ptr)
declare function xcb_sync_fence_end(byval i as xcb_sync_fence_iterator_t) as xcb_generic_iterator_t
declare sub xcb_sync_int64_next(byval i as xcb_sync_int64_iterator_t ptr)
declare function xcb_sync_int64_end(byval i as xcb_sync_int64_iterator_t) as xcb_generic_iterator_t
declare function xcb_sync_systemcounter_sizeof(byval _buffer as const any ptr) as long
declare function xcb_sync_systemcounter_name(byval R as const xcb_sync_systemcounter_t ptr) as zstring ptr
declare function xcb_sync_systemcounter_name_length(byval R as const xcb_sync_systemcounter_t ptr) as long
declare function xcb_sync_systemcounter_name_end(byval R as const xcb_sync_systemcounter_t ptr) as xcb_generic_iterator_t
declare sub xcb_sync_systemcounter_next(byval i as xcb_sync_systemcounter_iterator_t ptr)
declare function xcb_sync_systemcounter_end(byval i as xcb_sync_systemcounter_iterator_t) as xcb_generic_iterator_t
declare sub xcb_sync_trigger_next(byval i as xcb_sync_trigger_iterator_t ptr)
declare function xcb_sync_trigger_end(byval i as xcb_sync_trigger_iterator_t) as xcb_generic_iterator_t
declare sub xcb_sync_waitcondition_next(byval i as xcb_sync_waitcondition_iterator_t ptr)
declare function xcb_sync_waitcondition_end(byval i as xcb_sync_waitcondition_iterator_t) as xcb_generic_iterator_t
declare function xcb_sync_initialize(byval c as xcb_connection_t ptr, byval desired_major_version as ubyte, byval desired_minor_version as ubyte) as xcb_sync_initialize_cookie_t
declare function xcb_sync_initialize_unchecked(byval c as xcb_connection_t ptr, byval desired_major_version as ubyte, byval desired_minor_version as ubyte) as xcb_sync_initialize_cookie_t
declare function xcb_sync_initialize_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_initialize_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_initialize_reply_t ptr
declare function xcb_sync_list_system_counters_sizeof(byval _buffer as const any ptr) as long
declare function xcb_sync_list_system_counters(byval c as xcb_connection_t ptr) as xcb_sync_list_system_counters_cookie_t
declare function xcb_sync_list_system_counters_unchecked(byval c as xcb_connection_t ptr) as xcb_sync_list_system_counters_cookie_t
declare function xcb_sync_list_system_counters_counters_length(byval R as const xcb_sync_list_system_counters_reply_t ptr) as long
declare function xcb_sync_list_system_counters_counters_iterator(byval R as const xcb_sync_list_system_counters_reply_t ptr) as xcb_sync_systemcounter_iterator_t
declare function xcb_sync_list_system_counters_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_list_system_counters_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_list_system_counters_reply_t ptr
declare function xcb_sync_create_counter_checked(byval c as xcb_connection_t ptr, byval id as xcb_sync_counter_t, byval initial_value as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_create_counter(byval c as xcb_connection_t ptr, byval id as xcb_sync_counter_t, byval initial_value as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_destroy_counter_checked(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t) as xcb_void_cookie_t
declare function xcb_sync_destroy_counter(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t) as xcb_void_cookie_t
declare function xcb_sync_query_counter(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t) as xcb_sync_query_counter_cookie_t
declare function xcb_sync_query_counter_unchecked(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t) as xcb_sync_query_counter_cookie_t
declare function xcb_sync_query_counter_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_query_counter_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_query_counter_reply_t ptr
declare function xcb_sync_await_sizeof(byval _buffer as const any ptr, byval wait_list_len as ulong) as long
declare function xcb_sync_await_checked(byval c as xcb_connection_t ptr, byval wait_list_len as ulong, byval wait_list as const xcb_sync_waitcondition_t ptr) as xcb_void_cookie_t
declare function xcb_sync_await(byval c as xcb_connection_t ptr, byval wait_list_len as ulong, byval wait_list as const xcb_sync_waitcondition_t ptr) as xcb_void_cookie_t
declare function xcb_sync_change_counter_checked(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t, byval amount as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_change_counter(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t, byval amount as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_set_counter_checked(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t, byval value as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_set_counter(byval c as xcb_connection_t ptr, byval counter as xcb_sync_counter_t, byval value as xcb_sync_int64_t) as xcb_void_cookie_t
declare function xcb_sync_create_alarm_value_list_serialize(byval _buffer as any ptr ptr, byval value_mask as ulong, byval _aux as const xcb_sync_create_alarm_value_list_t ptr) as long
declare function xcb_sync_create_alarm_value_list_unpack(byval _buffer as const any ptr, byval value_mask as ulong, byval _aux as xcb_sync_create_alarm_value_list_t ptr) as long
declare function xcb_sync_create_alarm_value_list_sizeof(byval _buffer as const any ptr, byval value_mask as ulong) as long
declare function xcb_sync_create_alarm_checked(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const any ptr) as xcb_void_cookie_t
declare function xcb_sync_create_alarm(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const any ptr) as xcb_void_cookie_t
declare function xcb_sync_create_alarm_aux_checked(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const xcb_sync_create_alarm_value_list_t ptr) as xcb_void_cookie_t
declare function xcb_sync_create_alarm_aux(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const xcb_sync_create_alarm_value_list_t ptr) as xcb_void_cookie_t
declare function xcb_sync_change_alarm_value_list_serialize(byval _buffer as any ptr ptr, byval value_mask as ulong, byval _aux as const xcb_sync_change_alarm_value_list_t ptr) as long
declare function xcb_sync_change_alarm_value_list_unpack(byval _buffer as const any ptr, byval value_mask as ulong, byval _aux as xcb_sync_change_alarm_value_list_t ptr) as long
declare function xcb_sync_change_alarm_value_list_sizeof(byval _buffer as const any ptr, byval value_mask as ulong) as long
declare function xcb_sync_change_alarm_checked(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const any ptr) as xcb_void_cookie_t
declare function xcb_sync_change_alarm(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const any ptr) as xcb_void_cookie_t
declare function xcb_sync_change_alarm_aux_checked(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const xcb_sync_change_alarm_value_list_t ptr) as xcb_void_cookie_t
declare function xcb_sync_change_alarm_aux(byval c as xcb_connection_t ptr, byval id as xcb_sync_alarm_t, byval value_mask as ulong, byval value_list as const xcb_sync_change_alarm_value_list_t ptr) as xcb_void_cookie_t
declare function xcb_sync_destroy_alarm_checked(byval c as xcb_connection_t ptr, byval alarm as xcb_sync_alarm_t) as xcb_void_cookie_t
declare function xcb_sync_destroy_alarm(byval c as xcb_connection_t ptr, byval alarm as xcb_sync_alarm_t) as xcb_void_cookie_t
declare function xcb_sync_query_alarm(byval c as xcb_connection_t ptr, byval alarm as xcb_sync_alarm_t) as xcb_sync_query_alarm_cookie_t
declare function xcb_sync_query_alarm_unchecked(byval c as xcb_connection_t ptr, byval alarm as xcb_sync_alarm_t) as xcb_sync_query_alarm_cookie_t
declare function xcb_sync_query_alarm_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_query_alarm_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_query_alarm_reply_t ptr
declare function xcb_sync_set_priority_checked(byval c as xcb_connection_t ptr, byval id as ulong, byval priority as long) as xcb_void_cookie_t
declare function xcb_sync_set_priority(byval c as xcb_connection_t ptr, byval id as ulong, byval priority as long) as xcb_void_cookie_t
declare function xcb_sync_get_priority(byval c as xcb_connection_t ptr, byval id as ulong) as xcb_sync_get_priority_cookie_t
declare function xcb_sync_get_priority_unchecked(byval c as xcb_connection_t ptr, byval id as ulong) as xcb_sync_get_priority_cookie_t
declare function xcb_sync_get_priority_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_get_priority_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_get_priority_reply_t ptr
declare function xcb_sync_create_fence_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as xcb_sync_fence_t, byval initially_triggered as ubyte) as xcb_void_cookie_t
declare function xcb_sync_create_fence(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as xcb_sync_fence_t, byval initially_triggered as ubyte) as xcb_void_cookie_t
declare function xcb_sync_trigger_fence_checked(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_trigger_fence(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_reset_fence_checked(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_reset_fence(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_destroy_fence_checked(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_destroy_fence(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_void_cookie_t
declare function xcb_sync_query_fence(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_sync_query_fence_cookie_t
declare function xcb_sync_query_fence_unchecked(byval c as xcb_connection_t ptr, byval fence as xcb_sync_fence_t) as xcb_sync_query_fence_cookie_t
declare function xcb_sync_query_fence_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_sync_query_fence_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_sync_query_fence_reply_t ptr
declare function xcb_sync_await_fence_sizeof(byval _buffer as const any ptr, byval fence_list_len as ulong) as long
declare function xcb_sync_await_fence_checked(byval c as xcb_connection_t ptr, byval fence_list_len as ulong, byval fence_list as const xcb_sync_fence_t ptr) as xcb_void_cookie_t
declare function xcb_sync_await_fence(byval c as xcb_connection_t ptr, byval fence_list_len as ulong, byval fence_list as const xcb_sync_fence_t ptr) as xcb_void_cookie_t

end extern
