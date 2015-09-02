'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2006 Peter Hutterer
''   Copyright (C) 2013 Daniel Martin
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in all
''   copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
''   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
''   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the names of the authors or their
''   institutions shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from the authors.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xfixes.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_INPUT_GET_EXTENSION_VERSION => XCB_INPUT_GET_EXTENSION_VERSION_
''     constant XCB_INPUT_LIST_INPUT_DEVICES => XCB_INPUT_LIST_INPUT_DEVICES_
''     constant XCB_INPUT_OPEN_DEVICE => XCB_INPUT_OPEN_DEVICE_
''     constant XCB_INPUT_CLOSE_DEVICE => XCB_INPUT_CLOSE_DEVICE_
''     constant XCB_INPUT_SET_DEVICE_MODE => XCB_INPUT_SET_DEVICE_MODE_
''     constant XCB_INPUT_SELECT_EXTENSION_EVENT => XCB_INPUT_SELECT_EXTENSION_EVENT_
''     constant XCB_INPUT_GET_SELECTED_EXTENSION_EVENTS => XCB_INPUT_GET_SELECTED_EXTENSION_EVENTS_
''     constant XCB_INPUT_CHANGE_DEVICE_DONT_PROPAGATE_LIST => XCB_INPUT_CHANGE_DEVICE_DONT_PROPAGATE_LIST_
''     constant XCB_INPUT_GET_DEVICE_DONT_PROPAGATE_LIST => XCB_INPUT_GET_DEVICE_DONT_PROPAGATE_LIST_
''     constant XCB_INPUT_GET_DEVICE_MOTION_EVENTS => XCB_INPUT_GET_DEVICE_MOTION_EVENTS_
''     constant XCB_INPUT_CHANGE_KEYBOARD_DEVICE => XCB_INPUT_CHANGE_KEYBOARD_DEVICE_
''     constant XCB_INPUT_CHANGE_POINTER_DEVICE => XCB_INPUT_CHANGE_POINTER_DEVICE_
''     constant XCB_INPUT_GRAB_DEVICE => XCB_INPUT_GRAB_DEVICE_
''     constant XCB_INPUT_UNGRAB_DEVICE => XCB_INPUT_UNGRAB_DEVICE_
''     constant XCB_INPUT_GRAB_DEVICE_KEY => XCB_INPUT_GRAB_DEVICE_KEY_
''     constant XCB_INPUT_UNGRAB_DEVICE_KEY => XCB_INPUT_UNGRAB_DEVICE_KEY_
''     constant XCB_INPUT_GRAB_DEVICE_BUTTON => XCB_INPUT_GRAB_DEVICE_BUTTON_
''     constant XCB_INPUT_UNGRAB_DEVICE_BUTTON => XCB_INPUT_UNGRAB_DEVICE_BUTTON_
''     constant XCB_INPUT_ALLOW_DEVICE_EVENTS => XCB_INPUT_ALLOW_DEVICE_EVENTS_
''     constant XCB_INPUT_GET_DEVICE_FOCUS => XCB_INPUT_GET_DEVICE_FOCUS_
''     constant XCB_INPUT_SET_DEVICE_FOCUS => XCB_INPUT_SET_DEVICE_FOCUS_
''     constant XCB_INPUT_GET_FEEDBACK_CONTROL => XCB_INPUT_GET_FEEDBACK_CONTROL_
''     constant XCB_INPUT_CHANGE_FEEDBACK_CONTROL => XCB_INPUT_CHANGE_FEEDBACK_CONTROL_
''     constant XCB_INPUT_GET_DEVICE_KEY_MAPPING => XCB_INPUT_GET_DEVICE_KEY_MAPPING_
''     constant XCB_INPUT_CHANGE_DEVICE_KEY_MAPPING => XCB_INPUT_CHANGE_DEVICE_KEY_MAPPING_
''     constant XCB_INPUT_GET_DEVICE_MODIFIER_MAPPING => XCB_INPUT_GET_DEVICE_MODIFIER_MAPPING_
''     constant XCB_INPUT_SET_DEVICE_MODIFIER_MAPPING => XCB_INPUT_SET_DEVICE_MODIFIER_MAPPING_
''     constant XCB_INPUT_GET_DEVICE_BUTTON_MAPPING => XCB_INPUT_GET_DEVICE_BUTTON_MAPPING_
''     constant XCB_INPUT_SET_DEVICE_BUTTON_MAPPING => XCB_INPUT_SET_DEVICE_BUTTON_MAPPING_
''     constant XCB_INPUT_QUERY_DEVICE_STATE => XCB_INPUT_QUERY_DEVICE_STATE_
''     constant XCB_INPUT_SEND_EXTENSION_EVENT => XCB_INPUT_SEND_EXTENSION_EVENT_
''     constant XCB_INPUT_DEVICE_BELL => XCB_INPUT_DEVICE_BELL_
''     constant XCB_INPUT_SET_DEVICE_VALUATORS => XCB_INPUT_SET_DEVICE_VALUATORS_
''     constant XCB_INPUT_GET_DEVICE_CONTROL => XCB_INPUT_GET_DEVICE_CONTROL_
''     constant XCB_INPUT_CHANGE_DEVICE_CONTROL => XCB_INPUT_CHANGE_DEVICE_CONTROL_
''     constant XCB_INPUT_LIST_DEVICE_PROPERTIES => XCB_INPUT_LIST_DEVICE_PROPERTIES_
''     constant XCB_INPUT_CHANGE_DEVICE_PROPERTY => XCB_INPUT_CHANGE_DEVICE_PROPERTY_
''     constant XCB_INPUT_DELETE_DEVICE_PROPERTY => XCB_INPUT_DELETE_DEVICE_PROPERTY_
''     constant XCB_INPUT_GET_DEVICE_PROPERTY => XCB_INPUT_GET_DEVICE_PROPERTY_
''     constant XCB_INPUT_XI_QUERY_POINTER => XCB_INPUT_XI_QUERY_POINTER_
''     constant XCB_INPUT_XI_WARP_POINTER => XCB_INPUT_XI_WARP_POINTER_
''     constant XCB_INPUT_XI_CHANGE_CURSOR => XCB_INPUT_XI_CHANGE_CURSOR_
''     constant XCB_INPUT_XI_CHANGE_HIERARCHY => XCB_INPUT_XI_CHANGE_HIERARCHY_
''     constant XCB_INPUT_XI_SET_CLIENT_POINTER => XCB_INPUT_XI_SET_CLIENT_POINTER_
''     constant XCB_INPUT_XI_GET_CLIENT_POINTER => XCB_INPUT_XI_GET_CLIENT_POINTER_
''     constant XCB_INPUT_XI_SELECT_EVENTS => XCB_INPUT_XI_SELECT_EVENTS_
''     constant XCB_INPUT_XI_QUERY_VERSION => XCB_INPUT_XI_QUERY_VERSION_
''     constant XCB_INPUT_XI_QUERY_DEVICE => XCB_INPUT_XI_QUERY_DEVICE_
''     constant XCB_INPUT_XI_SET_FOCUS => XCB_INPUT_XI_SET_FOCUS_
''     constant XCB_INPUT_XI_GET_FOCUS => XCB_INPUT_XI_GET_FOCUS_
''     constant XCB_INPUT_XI_GRAB_DEVICE => XCB_INPUT_XI_GRAB_DEVICE_
''     constant XCB_INPUT_XI_UNGRAB_DEVICE => XCB_INPUT_XI_UNGRAB_DEVICE_
''     constant XCB_INPUT_XI_ALLOW_EVENTS => XCB_INPUT_XI_ALLOW_EVENTS_
''     constant XCB_INPUT_XI_PASSIVE_GRAB_DEVICE => XCB_INPUT_XI_PASSIVE_GRAB_DEVICE_
''     constant XCB_INPUT_XI_PASSIVE_UNGRAB_DEVICE => XCB_INPUT_XI_PASSIVE_UNGRAB_DEVICE_
''     constant XCB_INPUT_XI_LIST_PROPERTIES => XCB_INPUT_XI_LIST_PROPERTIES_
''     constant XCB_INPUT_XI_CHANGE_PROPERTY => XCB_INPUT_XI_CHANGE_PROPERTY_
''     constant XCB_INPUT_XI_DELETE_PROPERTY => XCB_INPUT_XI_DELETE_PROPERTY_
''     constant XCB_INPUT_XI_GET_PROPERTY => XCB_INPUT_XI_GET_PROPERTY_
''     constant XCB_INPUT_XI_GET_SELECTED_EVENTS => XCB_INPUT_XI_GET_SELECTED_EVENTS_
''     constant XCB_INPUT_XI_BARRIER_RELEASE_POINTER => XCB_INPUT_XI_BARRIER_RELEASE_POINTER_

extern "C"

#define __XINPUT_H
const XCB_INPUT_MAJOR_VERSION = 2
const XCB_INPUT_MINOR_VERSION = 3
extern xcb_input_id as xcb_extension_t
type xcb_input_event_class_t as ulong

type xcb_input_event_class_iterator_t
	data as xcb_input_event_class_t ptr
	as long rem
	index as long
end type

type xcb_input_key_code_t as ubyte

type xcb_input_key_code_iterator_t
	data as xcb_input_key_code_t ptr
	as long rem
	index as long
end type

type xcb_input_device_id_t as ushort

type xcb_input_device_id_iterator_t
	data as xcb_input_device_id_t ptr
	as long rem
	index as long
end type

type xcb_input_fp1616_t as long

type xcb_input_fp1616_iterator_t
	data as xcb_input_fp1616_t ptr
	as long rem
	index as long
end type

type xcb_input_fp3232_t
	integral as long
	frac as ulong
end type

type xcb_input_fp3232_iterator_t
	data as xcb_input_fp3232_t ptr
	as long rem
	index as long
end type

type xcb_input_get_extension_version_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_EXTENSION_VERSION_ = 1

type xcb_input_get_extension_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	name_len as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_input_get_extension_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major as ushort
	server_minor as ushort
	present as ubyte
	pad1(0 to 18) as ubyte
end type

type xcb_input_device_use_t as long
enum
	XCB_INPUT_DEVICE_USE_IS_X_POINTER = 0
	XCB_INPUT_DEVICE_USE_IS_X_KEYBOARD = 1
	XCB_INPUT_DEVICE_USE_IS_X_EXTENSION_DEVICE = 2
	XCB_INPUT_DEVICE_USE_IS_X_EXTENSION_KEYBOARD = 3
	XCB_INPUT_DEVICE_USE_IS_X_EXTENSION_POINTER = 4
end enum

type xcb_input_input_class_t as long
enum
	XCB_INPUT_INPUT_CLASS_KEY = 0
	XCB_INPUT_INPUT_CLASS_BUTTON = 1
	XCB_INPUT_INPUT_CLASS_VALUATOR = 2
	XCB_INPUT_INPUT_CLASS_FEEDBACK = 3
	XCB_INPUT_INPUT_CLASS_PROXIMITY = 4
	XCB_INPUT_INPUT_CLASS_FOCUS = 5
	XCB_INPUT_INPUT_CLASS_OTHER = 6
end enum

type xcb_input_valuator_mode_t as long
enum
	XCB_INPUT_VALUATOR_MODE_RELATIVE = 0
	XCB_INPUT_VALUATOR_MODE_ABSOLUTE = 1
end enum

type xcb_input_device_info_t
	device_type as xcb_atom_t
	device_id as ubyte
	num_class_info as ubyte
	device_use as ubyte
	pad0 as ubyte
end type

type xcb_input_device_info_iterator_t
	data as xcb_input_device_info_t ptr
	as long rem
	index as long
end type

type xcb_input_key_info_t
	class_id as ubyte
	len as ubyte
	min_keycode as xcb_input_key_code_t
	max_keycode as xcb_input_key_code_t
	num_keys as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_input_key_info_iterator_t
	data as xcb_input_key_info_t ptr
	as long rem
	index as long
end type

type xcb_input_button_info_t
	class_id as ubyte
	len as ubyte
	num_buttons as ushort
end type

type xcb_input_button_info_iterator_t
	data as xcb_input_button_info_t ptr
	as long rem
	index as long
end type

type xcb_input_axis_info_t
	resolution as ulong
	minimum as long
	maximum as long
end type

type xcb_input_axis_info_iterator_t
	data as xcb_input_axis_info_t ptr
	as long rem
	index as long
end type

type xcb_input_valuator_info_t
	class_id as ubyte
	len as ubyte
	axes_len as ubyte
	mode as ubyte
	motion_size as ulong
end type

type xcb_input_valuator_info_iterator_t
	data as xcb_input_valuator_info_t ptr
	as long rem
	index as long
end type

type xcb_input_input_info_t
	class_id as ubyte
	len as ubyte
end type

type xcb_input_input_info_iterator_t
	data as xcb_input_input_info_t ptr
	as long rem
	index as long
end type

type xcb_input_device_name_t
	len as ubyte
end type

type xcb_input_device_name_iterator_t
	data as xcb_input_device_name_t ptr
	as long rem
	index as long
end type

type xcb_input_list_input_devices_cookie_t
	sequence as ulong
end type

const XCB_INPUT_LIST_INPUT_DEVICES_ = 2

type xcb_input_list_input_devices_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_input_list_input_devices_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	devices_len as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_input_class_info_t
	class_id as ubyte
	event_type_base as ubyte
end type

type xcb_input_input_class_info_iterator_t
	data as xcb_input_input_class_info_t ptr
	as long rem
	index as long
end type

type xcb_input_open_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_OPEN_DEVICE_ = 3

type xcb_input_open_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_open_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_classes as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_CLOSE_DEVICE_ = 4

type xcb_input_close_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_set_device_mode_cookie_t
	sequence as ulong
end type

const XCB_INPUT_SET_DEVICE_MODE_ = 5

type xcb_input_set_device_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	mode as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_set_device_mode_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_SELECT_EXTENSION_EVENT_ = 6

type xcb_input_select_extension_event_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	num_classes as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_input_get_selected_extension_events_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_SELECTED_EXTENSION_EVENTS_ = 7

type xcb_input_get_selected_extension_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_input_get_selected_extension_events_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_this_classes as ushort
	num_all_classes as ushort
	pad1(0 to 19) as ubyte
end type

type xcb_input_propagate_mode_t as long
enum
	XCB_INPUT_PROPAGATE_MODE_ADD_TO_LIST = 0
	XCB_INPUT_PROPAGATE_MODE_DELETE_FROM_LIST = 1
end enum

const XCB_INPUT_CHANGE_DEVICE_DONT_PROPAGATE_LIST_ = 8

type xcb_input_change_device_dont_propagate_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	num_classes as ushort
	mode as ubyte
	pad0 as ubyte
end type

type xcb_input_get_device_dont_propagate_list_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_DONT_PROPAGATE_LIST_ = 9

type xcb_input_get_device_dont_propagate_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_input_get_device_dont_propagate_list_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_classes as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_input_device_time_coord_t
	time as xcb_timestamp_t
end type

type xcb_input_device_time_coord_iterator_t
	data as xcb_input_device_time_coord_t ptr
	as long rem
	index as long
end type

type xcb_input_get_device_motion_events_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_MOTION_EVENTS_ = 10

type xcb_input_get_device_motion_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	start as xcb_timestamp_t
	stop as xcb_timestamp_t
	device_id as ubyte
end type

type xcb_input_get_device_motion_events_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_events as ulong
	num_axes as ubyte
	device_mode as ubyte
	pad1(0 to 17) as ubyte
end type

type xcb_input_change_keyboard_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_CHANGE_KEYBOARD_DEVICE_ = 11

type xcb_input_change_keyboard_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_change_keyboard_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_change_pointer_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_CHANGE_POINTER_DEVICE_ = 12

type xcb_input_change_pointer_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	x_axis as ubyte
	y_axis as ubyte
	device_id as ubyte
	pad0 as ubyte
end type

type xcb_input_change_pointer_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_grab_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GRAB_DEVICE_ = 13

type xcb_input_grab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grab_window as xcb_window_t
	time as xcb_timestamp_t
	num_classes as ushort
	this_device_mode as ubyte
	other_device_mode as ubyte
	owner_events as ubyte
	device_id as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_grab_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_UNGRAB_DEVICE_ = 14

type xcb_input_ungrab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	time as xcb_timestamp_t
	device_id as ubyte
end type

const XCB_INPUT_GRAB_DEVICE_KEY_ = 15

type xcb_input_grab_device_key_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grab_window as xcb_window_t
	num_classes as ushort
	modifiers as ushort
	modifier_device as ubyte
	grabbed_device as ubyte
	key as ubyte
	this_device_mode as ubyte
	other_device_mode as ubyte
	owner_events as ubyte
	pad0(0 to 1) as ubyte
end type

const XCB_INPUT_UNGRAB_DEVICE_KEY_ = 16

type xcb_input_ungrab_device_key_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grabWindow as xcb_window_t
	modifiers as ushort
	modifier_device as ubyte
	key as ubyte
	grabbed_device as ubyte
end type

const XCB_INPUT_GRAB_DEVICE_BUTTON_ = 17

type xcb_input_grab_device_button_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grab_window as xcb_window_t
	grabbed_device as ubyte
	modifier_device as ubyte
	num_classes as ushort
	modifiers as ushort
	this_device_mode as ubyte
	other_device_mode as ubyte
	button as ubyte
	owner_events as ubyte
	pad0(0 to 1) as ubyte
end type

const XCB_INPUT_UNGRAB_DEVICE_BUTTON_ = 18

type xcb_input_ungrab_device_button_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grab_window as xcb_window_t
	modifiers as ushort
	modifier_device as ubyte
	button as ubyte
	grabbed_device as ubyte
end type

type xcb_input_device_input_mode_t as long
enum
	XCB_INPUT_DEVICE_INPUT_MODE_ASYNC_THIS_DEVICE = 0
	XCB_INPUT_DEVICE_INPUT_MODE_SYNC_THIS_DEVICE = 1
	XCB_INPUT_DEVICE_INPUT_MODE_REPLAY_THIS_DEVICE = 2
	XCB_INPUT_DEVICE_INPUT_MODE_ASYNC_OTHER_DEVICES = 3
	XCB_INPUT_DEVICE_INPUT_MODE_ASYNC_ALL = 4
	XCB_INPUT_DEVICE_INPUT_MODE_SYNC_ALL = 5
end enum

const XCB_INPUT_ALLOW_DEVICE_EVENTS_ = 19

type xcb_input_allow_device_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	time as xcb_timestamp_t
	mode as ubyte
	device_id as ubyte
end type

type xcb_input_get_device_focus_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_FOCUS_ = 20

type xcb_input_get_device_focus_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_get_device_focus_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	focus as xcb_window_t
	time as xcb_timestamp_t
	revert_to as ubyte
	pad1(0 to 14) as ubyte
end type

const XCB_INPUT_SET_DEVICE_FOCUS_ = 21

type xcb_input_set_device_focus_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	focus as xcb_window_t
	time as xcb_timestamp_t
	revert_to as ubyte
	device_id as ubyte
end type

type xcb_input_feedback_class_t as long
enum
	XCB_INPUT_FEEDBACK_CLASS_KEYBOARD = 0
	XCB_INPUT_FEEDBACK_CLASS_POINTER = 1
	XCB_INPUT_FEEDBACK_CLASS_STRING = 2
	XCB_INPUT_FEEDBACK_CLASS_INTEGER = 3
	XCB_INPUT_FEEDBACK_CLASS_LED = 4
	XCB_INPUT_FEEDBACK_CLASS_BELL = 5
end enum

type xcb_input_kbd_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	pitch as ushort
	duration as ushort
	led_mask as ulong
	led_values as ulong
	global_auto_repeat as ubyte
	click as ubyte
	percent as ubyte
	pad0 as ubyte
	auto_repeats(0 to 31) as ubyte
end type

type xcb_input_kbd_feedback_state_iterator_t
	data as xcb_input_kbd_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_ptr_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	pad0(0 to 1) as ubyte
	accel_num as ushort
	accel_denom as ushort
	threshold as ushort
end type

type xcb_input_ptr_feedback_state_iterator_t
	data as xcb_input_ptr_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_integer_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	resolution as ulong
	min_value as long
	max_value as long
end type

type xcb_input_integer_feedback_state_iterator_t
	data as xcb_input_integer_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_string_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	max_symbols as ushort
	num_keysyms as ushort
end type

type xcb_input_string_feedback_state_iterator_t
	data as xcb_input_string_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_bell_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	percent as ubyte
	pad0(0 to 2) as ubyte
	pitch as ushort
	duration as ushort
end type

type xcb_input_bell_feedback_state_iterator_t
	data as xcb_input_bell_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_led_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	led_mask as ulong
	led_values as ulong
end type

type xcb_input_led_feedback_state_iterator_t
	data as xcb_input_led_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_feedback_state_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
end type

type xcb_input_feedback_state_iterator_t
	data as xcb_input_feedback_state_t ptr
	as long rem
	index as long
end type

type xcb_input_get_feedback_control_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_FEEDBACK_CONTROL_ = 22

type xcb_input_get_feedback_control_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_get_feedback_control_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_feedbacks as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_input_kbd_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	key as xcb_input_key_code_t
	auto_repeat_mode as ubyte
	key_click_percent as byte
	bell_percent as byte
	bell_pitch as short
	bell_duration as short
	led_mask as ulong
	led_values as ulong
end type

type xcb_input_kbd_feedback_ctl_iterator_t
	data as xcb_input_kbd_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_ptr_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	pad0(0 to 1) as ubyte
	num as short
	denom as short
	threshold as short
end type

type xcb_input_ptr_feedback_ctl_iterator_t
	data as xcb_input_ptr_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_integer_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	int_to_display as long
end type

type xcb_input_integer_feedback_ctl_iterator_t
	data as xcb_input_integer_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_string_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	pad0(0 to 1) as ubyte
	num_keysyms as ushort
end type

type xcb_input_string_feedback_ctl_iterator_t
	data as xcb_input_string_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_bell_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	percent as byte
	pad0(0 to 2) as ubyte
	pitch as short
	duration as short
end type

type xcb_input_bell_feedback_ctl_iterator_t
	data as xcb_input_bell_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_led_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
	led_mask as ulong
	led_values as ulong
end type

type xcb_input_led_feedback_ctl_iterator_t
	data as xcb_input_led_feedback_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_feedback_ctl_t
	class_id as ubyte
	feedback_id as ubyte
	len as ushort
end type

type xcb_input_feedback_ctl_iterator_t
	data as xcb_input_feedback_ctl_t ptr
	as long rem
	index as long
end type

const XCB_INPUT_CHANGE_FEEDBACK_CONTROL_ = 23

type xcb_input_change_feedback_control_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	mask as ulong
	device_id as ubyte
	feedback_id as ubyte
end type

type xcb_input_get_device_key_mapping_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_KEY_MAPPING_ = 24

type xcb_input_get_device_key_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	first_keycode as xcb_input_key_code_t
	count as ubyte
end type

type xcb_input_get_device_key_mapping_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	keysyms_per_keycode as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_CHANGE_DEVICE_KEY_MAPPING_ = 25

type xcb_input_change_device_key_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	first_keycode as xcb_input_key_code_t
	keysyms_per_keycode as ubyte
	keycode_count as ubyte
end type

type xcb_input_get_device_modifier_mapping_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_MODIFIER_MAPPING_ = 26

type xcb_input_get_device_modifier_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_get_device_modifier_mapping_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	keycodes_per_modifier as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_set_device_modifier_mapping_cookie_t
	sequence as ulong
end type

const XCB_INPUT_SET_DEVICE_MODIFIER_MAPPING_ = 27

type xcb_input_set_device_modifier_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	keycodes_per_modifier as ubyte
	pad0 as ubyte
end type

type xcb_input_set_device_modifier_mapping_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_get_device_button_mapping_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_BUTTON_MAPPING_ = 28

type xcb_input_get_device_button_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_get_device_button_mapping_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	map_size as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_set_device_button_mapping_cookie_t
	sequence as ulong
end type

const XCB_INPUT_SET_DEVICE_BUTTON_MAPPING_ = 29

type xcb_input_set_device_button_mapping_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	map_size as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_set_device_button_mapping_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_key_state_t
	class_id as ubyte
	len as ubyte
	num_keys as ubyte
	pad0 as ubyte
	keys(0 to 31) as ubyte
end type

type xcb_input_key_state_iterator_t
	data as xcb_input_key_state_t ptr
	as long rem
	index as long
end type

type xcb_input_button_state_t
	class_id as ubyte
	len as ubyte
	num_buttons as ubyte
	pad0 as ubyte
	buttons(0 to 31) as ubyte
end type

type xcb_input_button_state_iterator_t
	data as xcb_input_button_state_t ptr
	as long rem
	index as long
end type

type xcb_input_valuator_state_t
	class_id as ubyte
	len as ubyte
	num_valuators as ubyte
	mode as ubyte
end type

type xcb_input_valuator_state_iterator_t
	data as xcb_input_valuator_state_t ptr
	as long rem
	index as long
end type

type xcb_input_input_state_t
	class_id as ubyte
	len as ubyte
	num_items as ubyte
	pad0 as ubyte
end type

type xcb_input_input_state_iterator_t
	data as xcb_input_input_state_t ptr
	as long rem
	index as long
end type

type xcb_input_query_device_state_cookie_t
	sequence as ulong
end type

const XCB_INPUT_QUERY_DEVICE_STATE_ = 30

type xcb_input_query_device_state_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_query_device_state_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_classes as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_SEND_EXTENSION_EVENT_ = 31

type xcb_input_send_extension_event_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	destination as xcb_window_t
	device_id as ubyte
	propagate as ubyte
	num_classes as ushort
	num_events as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_INPUT_DEVICE_BELL_ = 32

type xcb_input_device_bell_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	feedback_id as ubyte
	feedback_class as ubyte
	percent as byte
end type

type xcb_input_set_device_valuators_cookie_t
	sequence as ulong
end type

const XCB_INPUT_SET_DEVICE_VALUATORS_ = 33

type xcb_input_set_device_valuators_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	first_valuator as ubyte
	num_valuators as ubyte
	pad0 as ubyte
end type

type xcb_input_set_device_valuators_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_device_control_t as long
enum
	XCB_INPUT_DEVICE_CONTROL_RESOLUTION = 1
	XCB_INPUT_DEVICE_CONTROL_ABS_CALIB = 2
	XCB_INPUT_DEVICE_CONTROL_CORE = 3
	XCB_INPUT_DEVICE_CONTROL_ENABLE = 4
	XCB_INPUT_DEVICE_CONTROL_ABS_AREA = 5
end enum

type xcb_input_device_resolution_state_t
	control_id as ushort
	len as ushort
	num_valuators as ulong
end type

type xcb_input_device_resolution_state_iterator_t
	data as xcb_input_device_resolution_state_t ptr
	as long rem
	index as long
end type

type xcb_input_device_abs_calib_state_t
	control_id as ushort
	len as ushort
	min_x as long
	max_x as long
	min_y as long
	max_y as long
	flip_x as ulong
	flip_y as ulong
	rotation as ulong
	button_threshold as ulong
end type

type xcb_input_device_abs_calib_state_iterator_t
	data as xcb_input_device_abs_calib_state_t ptr
	as long rem
	index as long
end type

type xcb_input_device_abs_area_state_t
	control_id as ushort
	len as ushort
	offset_x as ulong
	offset_y as ulong
	width as ulong
	height as ulong
	screen as ulong
	following as ulong
end type

type xcb_input_device_abs_area_state_iterator_t
	data as xcb_input_device_abs_area_state_t ptr
	as long rem
	index as long
end type

type xcb_input_device_core_state_t
	control_id as ushort
	len as ushort
	status as ubyte
	iscore as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_device_core_state_iterator_t
	data as xcb_input_device_core_state_t ptr
	as long rem
	index as long
end type

type xcb_input_device_enable_state_t
	control_id as ushort
	len as ushort
	enable as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_device_enable_state_iterator_t
	data as xcb_input_device_enable_state_t ptr
	as long rem
	index as long
end type

type xcb_input_device_state_t
	control_id as ushort
	len as ushort
end type

type xcb_input_device_state_iterator_t
	data as xcb_input_device_state_t ptr
	as long rem
	index as long
end type

type xcb_input_get_device_control_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_CONTROL_ = 34

type xcb_input_get_device_control_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	control_id as ushort
	device_id as ubyte
	pad0 as ubyte
end type

type xcb_input_get_device_control_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_device_resolution_ctl_t
	control_id as ushort
	len as ushort
	first_valuator as ubyte
	num_valuators as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_device_resolution_ctl_iterator_t
	data as xcb_input_device_resolution_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_device_abs_calib_ctl_t
	control_id as ushort
	len as ushort
	min_x as long
	max_x as long
	min_y as long
	max_y as long
	flip_x as ulong
	flip_y as ulong
	rotation as ulong
	button_threshold as ulong
end type

type xcb_input_device_abs_calib_ctl_iterator_t
	data as xcb_input_device_abs_calib_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_device_abs_area_ctrl_t
	control_id as ushort
	len as ushort
	offset_x as ulong
	offset_y as ulong
	width as long
	height as long
	screen as long
	following as ulong
end type

type xcb_input_device_abs_area_ctrl_iterator_t
	data as xcb_input_device_abs_area_ctrl_t ptr
	as long rem
	index as long
end type

type xcb_input_device_core_ctrl_t
	control_id as ushort
	len as ushort
	status as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_device_core_ctrl_iterator_t
	data as xcb_input_device_core_ctrl_t ptr
	as long rem
	index as long
end type

type xcb_input_device_enable_ctrl_t
	control_id as ushort
	len as ushort
	enable as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_device_enable_ctrl_iterator_t
	data as xcb_input_device_enable_ctrl_t ptr
	as long rem
	index as long
end type

type xcb_input_device_ctl_t
	control_id as ushort
	len as ushort
end type

type xcb_input_device_ctl_iterator_t
	data as xcb_input_device_ctl_t ptr
	as long rem
	index as long
end type

type xcb_input_change_device_control_cookie_t
	sequence as ulong
end type

const XCB_INPUT_CHANGE_DEVICE_CONTROL_ = 35

type xcb_input_change_device_control_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	control_id as ushort
	device_id as ubyte
	pad0 as ubyte
end type

type xcb_input_change_device_control_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_input_list_device_properties_cookie_t
	sequence as ulong
end type

const XCB_INPUT_LIST_DEVICE_PROPERTIES_ = 36

type xcb_input_list_device_properties_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_list_device_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_atoms as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_input_property_format_t as long
enum
	XCB_INPUT_PROPERTY_FORMAT_8_BITS = 8
	XCB_INPUT_PROPERTY_FORMAT_16_BITS = 16
	XCB_INPUT_PROPERTY_FORMAT_32_BITS = 32
end enum

type xcb_input_change_device_property_items_t
	data8 as ubyte ptr
	data16 as ushort ptr
	data32 as ulong ptr
end type

const XCB_INPUT_CHANGE_DEVICE_PROPERTY_ = 37

type xcb_input_change_device_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	property as xcb_atom_t
	as xcb_atom_t type
	device_id as ubyte
	format as ubyte
	mode as ubyte
	pad0 as ubyte
	num_items as ulong
end type

const XCB_INPUT_DELETE_DEVICE_PROPERTY_ = 38

type xcb_input_delete_device_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	property as xcb_atom_t
	device_id as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_get_device_property_cookie_t
	sequence as ulong
end type

const XCB_INPUT_GET_DEVICE_PROPERTY_ = 39

type xcb_input_get_device_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	property as xcb_atom_t
	as xcb_atom_t type
	offset as ulong
	len as ulong
	device_id as ubyte
	_delete as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_get_device_property_items_t
	data8 as ubyte ptr
	data16 as ushort ptr
	data32 as ulong ptr
end type

type xcb_input_get_device_property_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	as xcb_atom_t type
	bytes_after as ulong
	num_items as ulong
	format as ubyte
	device_id as ubyte
	pad1(0 to 9) as ubyte
end type

type xcb_input_device_t as long
enum
	XCB_INPUT_DEVICE_ALL = 0
	XCB_INPUT_DEVICE_ALL_MASTER = 1
end enum

type xcb_input_group_info_t
	base as ubyte
	latched as ubyte
	locked as ubyte
	effective as ubyte
end type

type xcb_input_group_info_iterator_t
	data as xcb_input_group_info_t ptr
	as long rem
	index as long
end type

type xcb_input_modifier_info_t
	base as ulong
	latched as ulong
	locked as ulong
	effective as ulong
end type

type xcb_input_modifier_info_iterator_t
	data as xcb_input_modifier_info_t ptr
	as long rem
	index as long
end type

type xcb_input_xi_query_pointer_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_QUERY_POINTER_ = 40

type xcb_input_xi_query_pointer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_query_pointer_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
	child as xcb_window_t
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	win_x as xcb_input_fp1616_t
	win_y as xcb_input_fp1616_t
	same_screen as ubyte
	pad1 as ubyte
	buttons_len as ushort
	mods as xcb_input_modifier_info_t
	group as xcb_input_group_info_t
end type

const XCB_INPUT_XI_WARP_POINTER_ = 41

type xcb_input_xi_warp_pointer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	src_win as xcb_window_t
	dst_win as xcb_window_t
	src_x as xcb_input_fp1616_t
	src_y as xcb_input_fp1616_t
	src_width as ushort
	src_height as ushort
	dst_x as xcb_input_fp1616_t
	dst_y as xcb_input_fp1616_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

const XCB_INPUT_XI_CHANGE_CURSOR_ = 42

type xcb_input_xi_change_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	cursor as xcb_cursor_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_hierarchy_change_type_t as long
enum
	XCB_INPUT_HIERARCHY_CHANGE_TYPE_ADD_MASTER = 1
	XCB_INPUT_HIERARCHY_CHANGE_TYPE_REMOVE_MASTER = 2
	XCB_INPUT_HIERARCHY_CHANGE_TYPE_ATTACH_SLAVE = 3
	XCB_INPUT_HIERARCHY_CHANGE_TYPE_DETACH_SLAVE = 4
end enum

type xcb_input_change_mode_t as long
enum
	XCB_INPUT_CHANGE_MODE_ATTACH = 1
	XCB_INPUT_CHANGE_MODE_FLOAT = 2
end enum

type xcb_input_add_master_t
	as ushort type
	len as ushort
	name_len as ushort
	send_core as ubyte
	enable as ubyte
end type

type xcb_input_add_master_iterator_t
	data as xcb_input_add_master_t ptr
	as long rem
	index as long
end type

type xcb_input_remove_master_t
	as ushort type
	len as ushort
	deviceid as xcb_input_device_id_t
	return_mode as ubyte
	pad0 as ubyte
	return_pointer as xcb_input_device_id_t
	return_keyboard as xcb_input_device_id_t
end type

type xcb_input_remove_master_iterator_t
	data as xcb_input_remove_master_t ptr
	as long rem
	index as long
end type

type xcb_input_attach_slave_t
	as ushort type
	len as ushort
	deviceid as xcb_input_device_id_t
	master as xcb_input_device_id_t
end type

type xcb_input_attach_slave_iterator_t
	data as xcb_input_attach_slave_t ptr
	as long rem
	index as long
end type

type xcb_input_detach_slave_t
	as ushort type
	len as ushort
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_detach_slave_iterator_t
	data as xcb_input_detach_slave_t ptr
	as long rem
	index as long
end type

type xcb_input_hierarchy_change_t
	as ushort type
	len as ushort
end type

type xcb_input_hierarchy_change_iterator_t
	data as xcb_input_hierarchy_change_t ptr
	as long rem
	index as long
end type

const XCB_INPUT_XI_CHANGE_HIERARCHY_ = 43

type xcb_input_xi_change_hierarchy_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	num_changes as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_INPUT_XI_SET_CLIENT_POINTER_ = 44

type xcb_input_xi_set_client_pointer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_get_client_pointer_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_GET_CLIENT_POINTER_ = 45

type xcb_input_xi_get_client_pointer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_input_xi_get_client_pointer_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	set as ubyte
	pad1 as ubyte
	deviceid as xcb_input_device_id_t
	pad2(0 to 19) as ubyte
end type

type xcb_input_xi_event_mask_t as long
enum
	XCB_INPUT_XI_EVENT_MASK_DEVICE_CHANGED = 2
	XCB_INPUT_XI_EVENT_MASK_KEY_PRESS = 4
	XCB_INPUT_XI_EVENT_MASK_KEY_RELEASE = 8
	XCB_INPUT_XI_EVENT_MASK_BUTTON_PRESS = 16
	XCB_INPUT_XI_EVENT_MASK_BUTTON_RELEASE = 32
	XCB_INPUT_XI_EVENT_MASK_MOTION = 64
	XCB_INPUT_XI_EVENT_MASK_ENTER = 128
	XCB_INPUT_XI_EVENT_MASK_LEAVE = 256
	XCB_INPUT_XI_EVENT_MASK_FOCUS_IN = 512
	XCB_INPUT_XI_EVENT_MASK_FOCUS_OUT = 1024
	XCB_INPUT_XI_EVENT_MASK_HIERARCHY = 2048
	XCB_INPUT_XI_EVENT_MASK_PROPERTY = 4096
	XCB_INPUT_XI_EVENT_MASK_RAW_KEY_PRESS = 8192
	XCB_INPUT_XI_EVENT_MASK_RAW_KEY_RELEASE = 16384
	XCB_INPUT_XI_EVENT_MASK_RAW_BUTTON_PRESS = 32768
	XCB_INPUT_XI_EVENT_MASK_RAW_BUTTON_RELEASE = 65536
	XCB_INPUT_XI_EVENT_MASK_RAW_MOTION = 131072
	XCB_INPUT_XI_EVENT_MASK_TOUCH_BEGIN = 262144
	XCB_INPUT_XI_EVENT_MASK_TOUCH_UPDATE = 524288
	XCB_INPUT_XI_EVENT_MASK_TOUCH_END = 1048576
	XCB_INPUT_XI_EVENT_MASK_TOUCH_OWNERSHIP = 2097152
	XCB_INPUT_XI_EVENT_MASK_RAW_TOUCH_BEGIN = 4194304
	XCB_INPUT_XI_EVENT_MASK_RAW_TOUCH_UPDATE = 8388608
	XCB_INPUT_XI_EVENT_MASK_RAW_TOUCH_END = 16777216
	XCB_INPUT_XI_EVENT_MASK_BARRIER_HIT = 33554432
	XCB_INPUT_XI_EVENT_MASK_BARRIER_LEAVE = 67108864
end enum

type xcb_input_event_mask_t
	deviceid as xcb_input_device_id_t
	mask_len as ushort
end type

type xcb_input_event_mask_iterator_t
	data as xcb_input_event_mask_t ptr
	as long rem
	index as long
end type

const XCB_INPUT_XI_SELECT_EVENTS_ = 46

type xcb_input_xi_select_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	num_mask as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_query_version_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_QUERY_VERSION_ = 47

type xcb_input_xi_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ushort
	minor_version as ushort
end type

type xcb_input_xi_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
	pad1(0 to 19) as ubyte
end type

type xcb_input_device_class_type_t as long
enum
	XCB_INPUT_DEVICE_CLASS_TYPE_KEY = 0
	XCB_INPUT_DEVICE_CLASS_TYPE_BUTTON = 1
	XCB_INPUT_DEVICE_CLASS_TYPE_VALUATOR = 2
	XCB_INPUT_DEVICE_CLASS_TYPE_SCROLL = 3
	XCB_INPUT_DEVICE_CLASS_TYPE_TOUCH = 8
end enum

type xcb_input_device_type_t as long
enum
	XCB_INPUT_DEVICE_TYPE_MASTER_POINTER = 1
	XCB_INPUT_DEVICE_TYPE_MASTER_KEYBOARD = 2
	XCB_INPUT_DEVICE_TYPE_SLAVE_POINTER = 3
	XCB_INPUT_DEVICE_TYPE_SLAVE_KEYBOARD = 4
	XCB_INPUT_DEVICE_TYPE_FLOATING_SLAVE = 5
end enum

type xcb_input_scroll_flags_t as long
enum
	XCB_INPUT_SCROLL_FLAGS_NO_EMULATION = 1
	XCB_INPUT_SCROLL_FLAGS_PREFERRED = 2
end enum

type xcb_input_scroll_type_t as long
enum
	XCB_INPUT_SCROLL_TYPE_VERTICAL = 1
	XCB_INPUT_SCROLL_TYPE_HORIZONTAL = 2
end enum

type xcb_input_touch_mode_t as long
enum
	XCB_INPUT_TOUCH_MODE_DIRECT = 1
	XCB_INPUT_TOUCH_MODE_DEPENDENT = 2
end enum

type xcb_input_button_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	num_buttons as ushort
end type

type xcb_input_button_class_iterator_t
	data as xcb_input_button_class_t ptr
	as long rem
	index as long
end type

type xcb_input_key_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	num_keys as ushort
end type

type xcb_input_key_class_iterator_t
	data as xcb_input_key_class_t ptr
	as long rem
	index as long
end type

type xcb_input_scroll_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	number as ushort
	scroll_type as ushort
	pad0(0 to 1) as ubyte
	flags as ulong
	increment as xcb_input_fp3232_t
end type

type xcb_input_scroll_class_iterator_t
	data as xcb_input_scroll_class_t ptr
	as long rem
	index as long
end type

type xcb_input_touch_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	mode as ubyte
	num_touches as ubyte
end type

type xcb_input_touch_class_iterator_t
	data as xcb_input_touch_class_t ptr
	as long rem
	index as long
end type

type xcb_input_valuator_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	number as ushort
	label as xcb_atom_t
	min as xcb_input_fp3232_t
	max as xcb_input_fp3232_t
	value as xcb_input_fp3232_t
	resolution as ulong
	mode as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_valuator_class_iterator_t
	data as xcb_input_valuator_class_t ptr
	as long rem
	index as long
end type

type xcb_input_device_class_t
	as ushort type
	len as ushort
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_device_class_iterator_t
	data as xcb_input_device_class_t ptr
	as long rem
	index as long
end type

type xcb_input_xi_device_info_t
	deviceid as xcb_input_device_id_t
	as ushort type
	attachment as xcb_input_device_id_t
	num_classes as ushort
	name_len as ushort
	enabled as ubyte
	pad0 as ubyte
end type

type xcb_input_xi_device_info_iterator_t
	data as xcb_input_xi_device_info_t ptr
	as long rem
	index as long
end type

type xcb_input_xi_query_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_QUERY_DEVICE_ = 48

type xcb_input_xi_query_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_query_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_infos as ushort
	pad1(0 to 21) as ubyte
end type

const XCB_INPUT_XI_SET_FOCUS_ = 49

type xcb_input_xi_set_focus_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	time as xcb_timestamp_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_get_focus_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_GET_FOCUS_ = 50

type xcb_input_xi_get_focus_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_get_focus_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	focus as xcb_window_t
	pad1(0 to 19) as ubyte
end type

type xcb_input_grab_owner_t as long
enum
	XCB_INPUT_GRAB_OWNER_NO_OWNER = 0
	XCB_INPUT_GRAB_OWNER_OWNER = 1
end enum

type xcb_input_xi_grab_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_GRAB_DEVICE_ = 51

type xcb_input_xi_grab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	time as xcb_timestamp_t
	cursor as xcb_cursor_t
	deviceid as xcb_input_device_id_t
	mode as ubyte
	paired_device_mode as ubyte
	owner_events as ubyte
	pad0 as ubyte
	mask_len as ushort
end type

type xcb_input_xi_grab_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status as ubyte
	pad1(0 to 22) as ubyte
end type

const XCB_INPUT_XI_UNGRAB_DEVICE_ = 52

type xcb_input_xi_ungrab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	time as xcb_timestamp_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_event_mode_t as long
enum
	XCB_INPUT_EVENT_MODE_ASYNC_DEVICE = 0
	XCB_INPUT_EVENT_MODE_SYNC_DEVICE = 1
	XCB_INPUT_EVENT_MODE_REPLAY_DEVICE = 2
	XCB_INPUT_EVENT_MODE_ASYNC_PAIRED_DEVICE = 3
	XCB_INPUT_EVENT_MODE_ASYNC_PAIR = 4
	XCB_INPUT_EVENT_MODE_SYNC_PAIR = 5
	XCB_INPUT_EVENT_MODE_ACCEPT_TOUCH = 6
	XCB_INPUT_EVENT_MODE_REJECT_TOUCH = 7
end enum

const XCB_INPUT_XI_ALLOW_EVENTS_ = 53

type xcb_input_xi_allow_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	time as xcb_timestamp_t
	deviceid as xcb_input_device_id_t
	event_mode as ubyte
	pad0 as ubyte
	touchid as ulong
	grab_window as xcb_window_t
end type

type xcb_input_grab_mode_22_t as long
enum
	XCB_INPUT_GRAB_MODE_22_SYNC = 0
	XCB_INPUT_GRAB_MODE_22_ASYNC = 1
	XCB_INPUT_GRAB_MODE_22_TOUCH = 2
end enum

type xcb_input_grab_type_t as long
enum
	XCB_INPUT_GRAB_TYPE_BUTTON = 0
	XCB_INPUT_GRAB_TYPE_KEYCODE = 1
	XCB_INPUT_GRAB_TYPE_ENTER = 2
	XCB_INPUT_GRAB_TYPE_FOCUS_IN = 3
	XCB_INPUT_GRAB_TYPE_TOUCH_BEGIN = 4
end enum

type xcb_input_modifier_mask_t as long
enum
	XCB_INPUT_MODIFIER_MASK_ANY = 2147483648
end enum

type xcb_input_grab_modifier_info_t
	modifiers as ulong
	status as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_grab_modifier_info_iterator_t
	data as xcb_input_grab_modifier_info_t ptr
	as long rem
	index as long
end type

type xcb_input_xi_passive_grab_device_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_PASSIVE_GRAB_DEVICE_ = 54

type xcb_input_xi_passive_grab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	time as xcb_timestamp_t
	grab_window as xcb_window_t
	cursor as xcb_cursor_t
	detail as ulong
	deviceid as xcb_input_device_id_t
	num_modifiers as ushort
	mask_len as ushort
	grab_type as ubyte
	grab_mode as ubyte
	paired_device_mode as ubyte
	owner_events as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_passive_grab_device_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_modifiers as ushort
	pad1(0 to 21) as ubyte
end type

const XCB_INPUT_XI_PASSIVE_UNGRAB_DEVICE_ = 55

type xcb_input_xi_passive_ungrab_device_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	grab_window as xcb_window_t
	detail as ulong
	deviceid as xcb_input_device_id_t
	num_modifiers as ushort
	grab_type as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_input_xi_list_properties_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_LIST_PROPERTIES_ = 56

type xcb_input_xi_list_properties_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
end type

type xcb_input_xi_list_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_properties as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_input_xi_change_property_items_t
	data8 as ubyte ptr
	data16 as ushort ptr
	data32 as ulong ptr
end type

const XCB_INPUT_XI_CHANGE_PROPERTY_ = 57

type xcb_input_xi_change_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	mode as ubyte
	format as ubyte
	property as xcb_atom_t
	as xcb_atom_t type
	num_items as ulong
end type

const XCB_INPUT_XI_DELETE_PROPERTY_ = 58

type xcb_input_xi_delete_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	property as xcb_atom_t
end type

type xcb_input_xi_get_property_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_GET_PROPERTY_ = 59

type xcb_input_xi_get_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceid as xcb_input_device_id_t
	_delete as ubyte
	pad0 as ubyte
	property as xcb_atom_t
	as xcb_atom_t type
	offset as ulong
	len as ulong
end type

type xcb_input_xi_get_property_items_t
	data8 as ubyte ptr
	data16 as ushort ptr
	data32 as ulong ptr
end type

type xcb_input_xi_get_property_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	as xcb_atom_t type
	bytes_after as ulong
	num_items as ulong
	format as ubyte
	pad1(0 to 10) as ubyte
end type

type xcb_input_xi_get_selected_events_cookie_t
	sequence as ulong
end type

const XCB_INPUT_XI_GET_SELECTED_EVENTS_ = 60

type xcb_input_xi_get_selected_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_input_xi_get_selected_events_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_masks as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_input_barrier_release_pointer_info_t
	deviceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	barrier as xcb_xfixes_barrier_t
	eventid as ulong
end type

type xcb_input_barrier_release_pointer_info_iterator_t
	data as xcb_input_barrier_release_pointer_info_t ptr
	as long rem
	index as long
end type

const XCB_INPUT_XI_BARRIER_RELEASE_POINTER_ = 61

type xcb_input_xi_barrier_release_pointer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	num_barriers as ulong
end type

const XCB_INPUT_DEVICE_VALUATOR = 0

type xcb_input_device_valuator_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	device_state as ushort
	num_valuators as ubyte
	first_valuator as ubyte
	valuators(0 to 5) as long
end type

const XCB_INPUT_DEVICE_KEY_PRESS = 1

type xcb_input_device_key_press_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	event_x as short
	event_y as short
	state as ushort
	same_screen as ubyte
	device_id as ubyte
end type

const XCB_INPUT_DEVICE_KEY_RELEASE = 2
type xcb_input_device_key_release_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_DEVICE_BUTTON_PRESS = 3
type xcb_input_device_button_press_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_DEVICE_BUTTON_RELEASE = 4
type xcb_input_device_button_release_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_DEVICE_MOTION_NOTIFY = 5
type xcb_input_device_motion_notify_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_DEVICE_FOCUS_IN = 6

type xcb_input_device_focus_in_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	window as xcb_window_t
	mode as ubyte
	device_id as ubyte
	pad0(0 to 17) as ubyte
end type

const XCB_INPUT_DEVICE_FOCUS_OUT = 7
type xcb_input_device_focus_out_event_t as xcb_input_device_focus_in_event_t
const XCB_INPUT_PROXIMITY_IN = 8
type xcb_input_proximity_in_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_PROXIMITY_OUT = 9
type xcb_input_proximity_out_event_t as xcb_input_device_key_press_event_t
const XCB_INPUT_DEVICE_STATE_NOTIFY = 10

type xcb_input_device_state_notify_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	num_keys as ubyte
	num_buttons as ubyte
	num_valuators as ubyte
	classes_reported as ubyte
	buttons(0 to 3) as ubyte
	keys(0 to 3) as ubyte
	valuators(0 to 2) as ulong
end type

const XCB_INPUT_DEVICE_MAPPING_NOTIFY = 11

type xcb_input_device_mapping_notify_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	request as ubyte
	first_keycode as xcb_input_key_code_t
	count as ubyte
	pad0 as ubyte
	time as xcb_timestamp_t
	pad1(0 to 19) as ubyte
end type

const XCB_INPUT_CHANGE_DEVICE_NOTIFY = 12

type xcb_input_change_device_notify_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	request as ubyte
	pad0(0 to 22) as ubyte
end type

const XCB_INPUT_DEVICE_KEY_STATE_NOTIFY = 13

type xcb_input_device_key_state_notify_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	keys(0 to 27) as ubyte
end type

const XCB_INPUT_DEVICE_BUTTON_STATE_NOTIFY = 14

type xcb_input_device_button_state_notify_event_t
	response_type as ubyte
	device_id as ubyte
	sequence as ushort
	buttons(0 to 27) as ubyte
end type

type xcb_input_device_change_t as long
enum
	XCB_INPUT_DEVICE_CHANGE_ADDED = 0
	XCB_INPUT_DEVICE_CHANGE_REMOVED = 1
	XCB_INPUT_DEVICE_CHANGE_ENABLED = 2
	XCB_INPUT_DEVICE_CHANGE_DISABLED = 3
	XCB_INPUT_DEVICE_CHANGE_UNRECOVERABLE = 4
	XCB_INPUT_DEVICE_CHANGE_CONTROL_CHANGED = 5
end enum

const XCB_INPUT_DEVICE_PRESENCE_NOTIFY = 15

type xcb_input_device_presence_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	devchange as ubyte
	device_id as ubyte
	control as ushort
	pad1(0 to 19) as ubyte
end type

const XCB_INPUT_DEVICE_PROPERTY_NOTIFY = 16

type xcb_input_device_property_notify_event_t
	response_type as ubyte
	state as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	property as xcb_atom_t
	pad0(0 to 18) as ubyte
	device_id as ubyte
end type

type xcb_input_change_reason_t as long
enum
	XCB_INPUT_CHANGE_REASON_SLAVE_SWITCH = 1
	XCB_INPUT_CHANGE_REASON_DEVICE_CHANGE = 2
end enum

const XCB_INPUT_DEVICE_CHANGED = 1

type xcb_input_device_changed_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	num_classes as ushort
	sourceid as xcb_input_device_id_t
	reason as ubyte
	pad0(0 to 10) as ubyte
	full_sequence as ulong
end type

type xcb_input_key_event_flags_t as long
enum
	XCB_INPUT_KEY_EVENT_FLAGS_KEY_REPEAT = 65536
end enum

const XCB_INPUT_KEY_PRESS = 2

type xcb_input_key_press_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	full_sequence as ulong
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	event_x as xcb_input_fp1616_t
	event_y as xcb_input_fp1616_t
	buttons_len as ushort
	valuators_len as ushort
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	flags as ulong
	mods as xcb_input_modifier_info_t
	group as xcb_input_group_info_t
end type

const XCB_INPUT_KEY_RELEASE = 3
type xcb_input_key_release_event_t as xcb_input_key_press_event_t

type xcb_input_pointer_event_flags_t as long
enum
	XCB_INPUT_POINTER_EVENT_FLAGS_POINTER_EMULATED = 65536
end enum

const XCB_INPUT_BUTTON_PRESS = 4

type xcb_input_button_press_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	full_sequence as ulong
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	event_x as xcb_input_fp1616_t
	event_y as xcb_input_fp1616_t
	buttons_len as ushort
	valuators_len as ushort
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	flags as ulong
	mods as xcb_input_modifier_info_t
	group as xcb_input_group_info_t
end type

const XCB_INPUT_BUTTON_RELEASE = 5
type xcb_input_button_release_event_t as xcb_input_button_press_event_t
const XCB_INPUT_MOTION = 6
type xcb_input_motion_event_t as xcb_input_button_press_event_t

type xcb_input_notify_mode_t as long
enum
	XCB_INPUT_NOTIFY_MODE_NORMAL = 0
	XCB_INPUT_NOTIFY_MODE_GRAB = 1
	XCB_INPUT_NOTIFY_MODE_UNGRAB = 2
	XCB_INPUT_NOTIFY_MODE_WHILE_GRABBED = 3
	XCB_INPUT_NOTIFY_MODE_PASSIVE_GRAB = 4
	XCB_INPUT_NOTIFY_MODE_PASSIVE_UNGRAB = 5
end enum

type xcb_input_notify_detail_t as long
enum
	XCB_INPUT_NOTIFY_DETAIL_ANCESTOR = 0
	XCB_INPUT_NOTIFY_DETAIL_VIRTUAL = 1
	XCB_INPUT_NOTIFY_DETAIL_INFERIOR = 2
	XCB_INPUT_NOTIFY_DETAIL_NONLINEAR = 3
	XCB_INPUT_NOTIFY_DETAIL_NONLINEAR_VIRTUAL = 4
	XCB_INPUT_NOTIFY_DETAIL_POINTER = 5
	XCB_INPUT_NOTIFY_DETAIL_POINTER_ROOT = 6
	XCB_INPUT_NOTIFY_DETAIL_NONE = 7
end enum

const XCB_INPUT_ENTER = 7

type xcb_input_enter_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	sourceid as xcb_input_device_id_t
	mode as ubyte
	detail as ubyte
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	full_sequence as ulong
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	event_x as xcb_input_fp1616_t
	event_y as xcb_input_fp1616_t
	same_screen as ubyte
	focus as ubyte
	buttons_len as ushort
	mods as xcb_input_modifier_info_t
	group as xcb_input_group_info_t
end type

const XCB_INPUT_LEAVE = 8
type xcb_input_leave_event_t as xcb_input_enter_event_t
const XCB_INPUT_FOCUS_IN = 9
type xcb_input_focus_in_event_t as xcb_input_enter_event_t
const XCB_INPUT_FOCUS_OUT = 10
type xcb_input_focus_out_event_t as xcb_input_enter_event_t

type xcb_input_hierarchy_mask_t as long
enum
	XCB_INPUT_HIERARCHY_MASK_MASTER_ADDED = 1
	XCB_INPUT_HIERARCHY_MASK_MASTER_REMOVED = 2
	XCB_INPUT_HIERARCHY_MASK_SLAVE_ADDED = 4
	XCB_INPUT_HIERARCHY_MASK_SLAVE_REMOVED = 8
	XCB_INPUT_HIERARCHY_MASK_SLAVE_ATTACHED = 16
	XCB_INPUT_HIERARCHY_MASK_SLAVE_DETACHED = 32
	XCB_INPUT_HIERARCHY_MASK_DEVICE_ENABLED = 64
	XCB_INPUT_HIERARCHY_MASK_DEVICE_DISABLED = 128
end enum

type xcb_input_hierarchy_info_t
	deviceid as xcb_input_device_id_t
	attachment as xcb_input_device_id_t
	as ubyte type
	enabled as ubyte
	pad0(0 to 1) as ubyte
	flags as ulong
end type

type xcb_input_hierarchy_info_iterator_t
	data as xcb_input_hierarchy_info_t ptr
	as long rem
	index as long
end type

const XCB_INPUT_HIERARCHY = 11

type xcb_input_hierarchy_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	flags as ulong
	num_infos as ushort
	pad0(0 to 9) as ubyte
	full_sequence as ulong
end type

type xcb_input_property_flag_t as long
enum
	XCB_INPUT_PROPERTY_FLAG_DELETED = 0
	XCB_INPUT_PROPERTY_FLAG_CREATED = 1
	XCB_INPUT_PROPERTY_FLAG_MODIFIED = 2
end enum

const XCB_INPUT_PROPERTY = 12

type xcb_input_property_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	property as xcb_atom_t
	what as ubyte
	pad0(0 to 10) as ubyte
	full_sequence as ulong
end type

const XCB_INPUT_RAW_KEY_PRESS = 13

type xcb_input_raw_key_press_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	sourceid as xcb_input_device_id_t
	valuators_len as ushort
	flags as ulong
	pad0(0 to 3) as ubyte
	full_sequence as ulong
end type

const XCB_INPUT_RAW_KEY_RELEASE = 14
type xcb_input_raw_key_release_event_t as xcb_input_raw_key_press_event_t
const XCB_INPUT_RAW_BUTTON_PRESS = 15

type xcb_input_raw_button_press_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	sourceid as xcb_input_device_id_t
	valuators_len as ushort
	flags as ulong
	pad0(0 to 3) as ubyte
	full_sequence as ulong
end type

const XCB_INPUT_RAW_BUTTON_RELEASE = 16
type xcb_input_raw_button_release_event_t as xcb_input_raw_button_press_event_t
const XCB_INPUT_RAW_MOTION = 17
type xcb_input_raw_motion_event_t as xcb_input_raw_button_press_event_t

type xcb_input_touch_event_flags_t as long
enum
	XCB_INPUT_TOUCH_EVENT_FLAGS_TOUCH_PENDING_END = 65536
	XCB_INPUT_TOUCH_EVENT_FLAGS_TOUCH_EMULATING_POINTER = 131072
end enum

const XCB_INPUT_TOUCH_BEGIN = 18

type xcb_input_touch_begin_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	full_sequence as ulong
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	event_x as xcb_input_fp1616_t
	event_y as xcb_input_fp1616_t
	buttons_len as ushort
	valuators_len as ushort
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	flags as ulong
	mods as xcb_input_modifier_info_t
	group as xcb_input_group_info_t
end type

const XCB_INPUT_TOUCH_UPDATE = 19
type xcb_input_touch_update_event_t as xcb_input_touch_begin_event_t
const XCB_INPUT_TOUCH_END = 20
type xcb_input_touch_end_event_t as xcb_input_touch_begin_event_t

type xcb_input_touch_ownership_flags_t as long
enum
	XCB_INPUT_TOUCH_OWNERSHIP_FLAGS_NONE = 0
end enum

const XCB_INPUT_TOUCH_OWNERSHIP = 21

type xcb_input_touch_ownership_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	touchid as ulong
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	full_sequence as ulong
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	flags as ulong
	pad1(0 to 7) as ubyte
end type

const XCB_INPUT_RAW_TOUCH_BEGIN = 22

type xcb_input_raw_touch_begin_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	detail as ulong
	sourceid as xcb_input_device_id_t
	valuators_len as ushort
	flags as ulong
	pad0(0 to 3) as ubyte
	full_sequence as ulong
end type

const XCB_INPUT_RAW_TOUCH_UPDATE = 23
type xcb_input_raw_touch_update_event_t as xcb_input_raw_touch_begin_event_t
const XCB_INPUT_RAW_TOUCH_END = 24
type xcb_input_raw_touch_end_event_t as xcb_input_raw_touch_begin_event_t
const XCB_INPUT_BARRIER_HIT = 25

type xcb_input_barrier_hit_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	deviceid as xcb_input_device_id_t
	time as xcb_timestamp_t
	eventid as ulong
	root as xcb_window_t
	event as xcb_window_t
	barrier as xcb_xfixes_barrier_t
	full_sequence as ulong
	dtime as ulong
	flags as ulong
	sourceid as xcb_input_device_id_t
	pad0(0 to 1) as ubyte
	root_x as xcb_input_fp1616_t
	root_y as xcb_input_fp1616_t
	dx as xcb_input_fp3232_t
	dy as xcb_input_fp3232_t
end type

const XCB_INPUT_BARRIER_LEAVE = 26
type xcb_input_barrier_leave_event_t as xcb_input_barrier_hit_event_t
const XCB_INPUT_DEVICE = 0

type xcb_input_device_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_INPUT_EVENT = 1

type xcb_input_event_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_INPUT_MODE = 2

type xcb_input_mode_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_INPUT_DEVICE_BUSY = 3

type xcb_input_device_busy_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_INPUT_CLASS = 4

type xcb_input_class_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

declare sub xcb_input_event_class_next(byval i as xcb_input_event_class_iterator_t ptr)
declare function xcb_input_event_class_end(byval i as xcb_input_event_class_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_key_code_next(byval i as xcb_input_key_code_iterator_t ptr)
declare function xcb_input_key_code_end(byval i as xcb_input_key_code_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_id_next(byval i as xcb_input_device_id_iterator_t ptr)
declare function xcb_input_device_id_end(byval i as xcb_input_device_id_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_fp1616_next(byval i as xcb_input_fp1616_iterator_t ptr)
declare function xcb_input_fp1616_end(byval i as xcb_input_fp1616_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_fp3232_next(byval i as xcb_input_fp3232_iterator_t ptr)
declare function xcb_input_fp3232_end(byval i as xcb_input_fp3232_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_get_extension_version_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_extension_version(byval c as xcb_connection_t ptr, byval name_len as ushort, byval name as const zstring ptr) as xcb_input_get_extension_version_cookie_t
declare function xcb_input_get_extension_version_unchecked(byval c as xcb_connection_t ptr, byval name_len as ushort, byval name as const zstring ptr) as xcb_input_get_extension_version_cookie_t
declare function xcb_input_get_extension_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_extension_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_extension_version_reply_t ptr
declare sub xcb_input_device_info_next(byval i as xcb_input_device_info_iterator_t ptr)
declare function xcb_input_device_info_end(byval i as xcb_input_device_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_key_info_next(byval i as xcb_input_key_info_iterator_t ptr)
declare function xcb_input_key_info_end(byval i as xcb_input_key_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_button_info_next(byval i as xcb_input_button_info_iterator_t ptr)
declare function xcb_input_button_info_end(byval i as xcb_input_button_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_axis_info_next(byval i as xcb_input_axis_info_iterator_t ptr)
declare function xcb_input_axis_info_end(byval i as xcb_input_axis_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_valuator_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_valuator_info_axes(byval R as const xcb_input_valuator_info_t ptr) as xcb_input_axis_info_t ptr
declare function xcb_input_valuator_info_axes_length(byval R as const xcb_input_valuator_info_t ptr) as long
declare function xcb_input_valuator_info_axes_iterator(byval R as const xcb_input_valuator_info_t ptr) as xcb_input_axis_info_iterator_t
declare sub xcb_input_valuator_info_next(byval i as xcb_input_valuator_info_iterator_t ptr)
declare function xcb_input_valuator_info_end(byval i as xcb_input_valuator_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_input_info_next(byval i as xcb_input_input_info_iterator_t ptr)
declare function xcb_input_input_info_end(byval i as xcb_input_input_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_device_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_name_string(byval R as const xcb_input_device_name_t ptr) as zstring ptr
declare function xcb_input_device_name_string_length(byval R as const xcb_input_device_name_t ptr) as long
declare function xcb_input_device_name_string_end(byval R as const xcb_input_device_name_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_name_next(byval i as xcb_input_device_name_iterator_t ptr)
declare function xcb_input_device_name_end(byval i as xcb_input_device_name_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_list_input_devices_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_list_input_devices(byval c as xcb_connection_t ptr) as xcb_input_list_input_devices_cookie_t
declare function xcb_input_list_input_devices_unchecked(byval c as xcb_connection_t ptr) as xcb_input_list_input_devices_cookie_t
declare function xcb_input_list_input_devices_devices(byval R as const xcb_input_list_input_devices_reply_t ptr) as xcb_input_device_info_t ptr
declare function xcb_input_list_input_devices_devices_length(byval R as const xcb_input_list_input_devices_reply_t ptr) as long
declare function xcb_input_list_input_devices_devices_iterator(byval R as const xcb_input_list_input_devices_reply_t ptr) as xcb_input_device_info_iterator_t
declare function xcb_input_list_input_devices_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_list_input_devices_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_list_input_devices_reply_t ptr
declare sub xcb_input_input_class_info_next(byval i as xcb_input_input_class_info_iterator_t ptr)
declare function xcb_input_input_class_info_end(byval i as xcb_input_input_class_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_open_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_open_device(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_open_device_cookie_t
declare function xcb_input_open_device_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_open_device_cookie_t
declare function xcb_input_open_device_class_info(byval R as const xcb_input_open_device_reply_t ptr) as xcb_input_input_class_info_t ptr
declare function xcb_input_open_device_class_info_length(byval R as const xcb_input_open_device_reply_t ptr) as long
declare function xcb_input_open_device_class_info_iterator(byval R as const xcb_input_open_device_reply_t ptr) as xcb_input_input_class_info_iterator_t
declare function xcb_input_open_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_open_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_open_device_reply_t ptr
declare function xcb_input_close_device_checked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_close_device(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_set_device_mode(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval mode as ubyte) as xcb_input_set_device_mode_cookie_t
declare function xcb_input_set_device_mode_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval mode as ubyte) as xcb_input_set_device_mode_cookie_t
declare function xcb_input_set_device_mode_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_set_device_mode_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_set_device_mode_reply_t ptr
declare function xcb_input_select_extension_event_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_select_extension_event_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_classes as ushort, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_select_extension_event(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_classes as ushort, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_get_selected_extension_events_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_selected_extension_events(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_get_selected_extension_events_cookie_t
declare function xcb_input_get_selected_extension_events_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_get_selected_extension_events_cookie_t
declare function xcb_input_get_selected_extension_events_this_classes(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as xcb_input_event_class_t ptr
declare function xcb_input_get_selected_extension_events_this_classes_length(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as long
declare function xcb_input_get_selected_extension_events_this_classes_end(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_selected_extension_events_all_classes(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as xcb_input_event_class_t ptr
declare function xcb_input_get_selected_extension_events_all_classes_length(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as long
declare function xcb_input_get_selected_extension_events_all_classes_end(byval R as const xcb_input_get_selected_extension_events_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_selected_extension_events_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_selected_extension_events_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_selected_extension_events_reply_t ptr
declare function xcb_input_change_device_dont_propagate_list_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_change_device_dont_propagate_list_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_classes as ushort, byval mode as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_change_device_dont_propagate_list(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_classes as ushort, byval mode as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_get_device_dont_propagate_list_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_device_dont_propagate_list(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_get_device_dont_propagate_list_cookie_t
declare function xcb_input_get_device_dont_propagate_list_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_get_device_dont_propagate_list_cookie_t
declare function xcb_input_get_device_dont_propagate_list_classes(byval R as const xcb_input_get_device_dont_propagate_list_reply_t ptr) as xcb_input_event_class_t ptr
declare function xcb_input_get_device_dont_propagate_list_classes_length(byval R as const xcb_input_get_device_dont_propagate_list_reply_t ptr) as long
declare function xcb_input_get_device_dont_propagate_list_classes_end(byval R as const xcb_input_get_device_dont_propagate_list_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_dont_propagate_list_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_dont_propagate_list_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_dont_propagate_list_reply_t ptr
declare sub xcb_input_device_time_coord_next(byval i as xcb_input_device_time_coord_iterator_t ptr)
declare function xcb_input_device_time_coord_end(byval i as xcb_input_device_time_coord_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_get_device_motion_events(byval c as xcb_connection_t ptr, byval start as xcb_timestamp_t, byval stop as xcb_timestamp_t, byval device_id as ubyte) as xcb_input_get_device_motion_events_cookie_t
declare function xcb_input_get_device_motion_events_unchecked(byval c as xcb_connection_t ptr, byval start as xcb_timestamp_t, byval stop as xcb_timestamp_t, byval device_id as ubyte) as xcb_input_get_device_motion_events_cookie_t
declare function xcb_input_get_device_motion_events_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_motion_events_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_motion_events_reply_t ptr
declare function xcb_input_change_keyboard_device(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_change_keyboard_device_cookie_t
declare function xcb_input_change_keyboard_device_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_change_keyboard_device_cookie_t
declare function xcb_input_change_keyboard_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_change_keyboard_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_change_keyboard_device_reply_t ptr
declare function xcb_input_change_pointer_device(byval c as xcb_connection_t ptr, byval x_axis as ubyte, byval y_axis as ubyte, byval device_id as ubyte) as xcb_input_change_pointer_device_cookie_t
declare function xcb_input_change_pointer_device_unchecked(byval c as xcb_connection_t ptr, byval x_axis as ubyte, byval y_axis as ubyte, byval device_id as ubyte) as xcb_input_change_pointer_device_cookie_t
declare function xcb_input_change_pointer_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_change_pointer_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_change_pointer_device_reply_t ptr
declare function xcb_input_grab_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_grab_device(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval time as xcb_timestamp_t, byval num_classes as ushort, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval owner_events as ubyte, byval device_id as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_input_grab_device_cookie_t
declare function xcb_input_grab_device_unchecked(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval time as xcb_timestamp_t, byval num_classes as ushort, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval owner_events as ubyte, byval device_id as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_input_grab_device_cookie_t
declare function xcb_input_grab_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_grab_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_grab_device_reply_t ptr
declare function xcb_input_ungrab_device_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_ungrab_device(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_grab_device_key_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_grab_device_key_checked(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval num_classes as ushort, byval modifiers as ushort, byval modifier_device as ubyte, byval grabbed_device as ubyte, byval key as ubyte, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval owner_events as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_grab_device_key(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval num_classes as ushort, byval modifiers as ushort, byval modifier_device as ubyte, byval grabbed_device as ubyte, byval key as ubyte, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval owner_events as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_ungrab_device_key_checked(byval c as xcb_connection_t ptr, byval grabWindow as xcb_window_t, byval modifiers as ushort, byval modifier_device as ubyte, byval key as ubyte, byval grabbed_device as ubyte) as xcb_void_cookie_t
declare function xcb_input_ungrab_device_key(byval c as xcb_connection_t ptr, byval grabWindow as xcb_window_t, byval modifiers as ushort, byval modifier_device as ubyte, byval key as ubyte, byval grabbed_device as ubyte) as xcb_void_cookie_t
declare function xcb_input_grab_device_button_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_grab_device_button_checked(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval grabbed_device as ubyte, byval modifier_device as ubyte, byval num_classes as ushort, byval modifiers as ushort, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval button as ubyte, byval owner_events as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_grab_device_button(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval grabbed_device as ubyte, byval modifier_device as ubyte, byval num_classes as ushort, byval modifiers as ushort, byval this_device_mode as ubyte, byval other_device_mode as ubyte, byval button as ubyte, byval owner_events as ubyte, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_ungrab_device_button_checked(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval modifiers as ushort, byval modifier_device as ubyte, byval button as ubyte, byval grabbed_device as ubyte) as xcb_void_cookie_t
declare function xcb_input_ungrab_device_button(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval modifiers as ushort, byval modifier_device as ubyte, byval button as ubyte, byval grabbed_device as ubyte) as xcb_void_cookie_t
declare function xcb_input_allow_device_events_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval mode as ubyte, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_allow_device_events(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval mode as ubyte, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_get_device_focus(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_focus_cookie_t
declare function xcb_input_get_device_focus_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_focus_cookie_t
declare function xcb_input_get_device_focus_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_focus_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_focus_reply_t ptr
declare function xcb_input_set_device_focus_checked(byval c as xcb_connection_t ptr, byval focus as xcb_window_t, byval time as xcb_timestamp_t, byval revert_to as ubyte, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_set_device_focus(byval c as xcb_connection_t ptr, byval focus as xcb_window_t, byval time as xcb_timestamp_t, byval revert_to as ubyte, byval device_id as ubyte) as xcb_void_cookie_t
declare sub xcb_input_kbd_feedback_state_next(byval i as xcb_input_kbd_feedback_state_iterator_t ptr)
declare function xcb_input_kbd_feedback_state_end(byval i as xcb_input_kbd_feedback_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_ptr_feedback_state_next(byval i as xcb_input_ptr_feedback_state_iterator_t ptr)
declare function xcb_input_ptr_feedback_state_end(byval i as xcb_input_ptr_feedback_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_integer_feedback_state_next(byval i as xcb_input_integer_feedback_state_iterator_t ptr)
declare function xcb_input_integer_feedback_state_end(byval i as xcb_input_integer_feedback_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_string_feedback_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_string_feedback_state_keysyms(byval R as const xcb_input_string_feedback_state_t ptr) as xcb_keysym_t ptr
declare function xcb_input_string_feedback_state_keysyms_length(byval R as const xcb_input_string_feedback_state_t ptr) as long
declare function xcb_input_string_feedback_state_keysyms_end(byval R as const xcb_input_string_feedback_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_string_feedback_state_next(byval i as xcb_input_string_feedback_state_iterator_t ptr)
declare function xcb_input_string_feedback_state_end(byval i as xcb_input_string_feedback_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_bell_feedback_state_next(byval i as xcb_input_bell_feedback_state_iterator_t ptr)
declare function xcb_input_bell_feedback_state_end(byval i as xcb_input_bell_feedback_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_led_feedback_state_next(byval i as xcb_input_led_feedback_state_iterator_t ptr)
declare function xcb_input_led_feedback_state_end(byval i as xcb_input_led_feedback_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_feedback_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_feedback_state_uninterpreted_data(byval R as const xcb_input_feedback_state_t ptr) as ubyte ptr
declare function xcb_input_feedback_state_uninterpreted_data_length(byval R as const xcb_input_feedback_state_t ptr) as long
declare function xcb_input_feedback_state_uninterpreted_data_end(byval R as const xcb_input_feedback_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_feedback_state_next(byval i as xcb_input_feedback_state_iterator_t ptr)
declare function xcb_input_feedback_state_end(byval i as xcb_input_feedback_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_get_feedback_control_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_feedback_control(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_feedback_control_cookie_t
declare function xcb_input_get_feedback_control_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_feedback_control_cookie_t
declare function xcb_input_get_feedback_control_feedbacks_length(byval R as const xcb_input_get_feedback_control_reply_t ptr) as long
declare function xcb_input_get_feedback_control_feedbacks_iterator(byval R as const xcb_input_get_feedback_control_reply_t ptr) as xcb_input_feedback_state_iterator_t
declare function xcb_input_get_feedback_control_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_feedback_control_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_feedback_control_reply_t ptr
declare sub xcb_input_kbd_feedback_ctl_next(byval i as xcb_input_kbd_feedback_ctl_iterator_t ptr)
declare function xcb_input_kbd_feedback_ctl_end(byval i as xcb_input_kbd_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_ptr_feedback_ctl_next(byval i as xcb_input_ptr_feedback_ctl_iterator_t ptr)
declare function xcb_input_ptr_feedback_ctl_end(byval i as xcb_input_ptr_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_integer_feedback_ctl_next(byval i as xcb_input_integer_feedback_ctl_iterator_t ptr)
declare function xcb_input_integer_feedback_ctl_end(byval i as xcb_input_integer_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_string_feedback_ctl_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_string_feedback_ctl_keysyms(byval R as const xcb_input_string_feedback_ctl_t ptr) as xcb_keysym_t ptr
declare function xcb_input_string_feedback_ctl_keysyms_length(byval R as const xcb_input_string_feedback_ctl_t ptr) as long
declare function xcb_input_string_feedback_ctl_keysyms_end(byval R as const xcb_input_string_feedback_ctl_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_string_feedback_ctl_next(byval i as xcb_input_string_feedback_ctl_iterator_t ptr)
declare function xcb_input_string_feedback_ctl_end(byval i as xcb_input_string_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_bell_feedback_ctl_next(byval i as xcb_input_bell_feedback_ctl_iterator_t ptr)
declare function xcb_input_bell_feedback_ctl_end(byval i as xcb_input_bell_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_led_feedback_ctl_next(byval i as xcb_input_led_feedback_ctl_iterator_t ptr)
declare function xcb_input_led_feedback_ctl_end(byval i as xcb_input_led_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_feedback_ctl_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_feedback_ctl_uninterpreted_data(byval R as const xcb_input_feedback_ctl_t ptr) as ubyte ptr
declare function xcb_input_feedback_ctl_uninterpreted_data_length(byval R as const xcb_input_feedback_ctl_t ptr) as long
declare function xcb_input_feedback_ctl_uninterpreted_data_end(byval R as const xcb_input_feedback_ctl_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_feedback_ctl_next(byval i as xcb_input_feedback_ctl_iterator_t ptr)
declare function xcb_input_feedback_ctl_end(byval i as xcb_input_feedback_ctl_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_change_feedback_control_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_change_feedback_control_checked(byval c as xcb_connection_t ptr, byval mask as ulong, byval device_id as ubyte, byval feedback_id as ubyte, byval feedback as xcb_input_feedback_ctl_t ptr) as xcb_void_cookie_t
declare function xcb_input_change_feedback_control(byval c as xcb_connection_t ptr, byval mask as ulong, byval device_id as ubyte, byval feedback_id as ubyte, byval feedback as xcb_input_feedback_ctl_t ptr) as xcb_void_cookie_t
declare function xcb_input_get_device_key_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_device_key_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_keycode as xcb_input_key_code_t, byval count as ubyte) as xcb_input_get_device_key_mapping_cookie_t
declare function xcb_input_get_device_key_mapping_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_keycode as xcb_input_key_code_t, byval count as ubyte) as xcb_input_get_device_key_mapping_cookie_t
declare function xcb_input_get_device_key_mapping_keysyms(byval R as const xcb_input_get_device_key_mapping_reply_t ptr) as xcb_keysym_t ptr
declare function xcb_input_get_device_key_mapping_keysyms_length(byval R as const xcb_input_get_device_key_mapping_reply_t ptr) as long
declare function xcb_input_get_device_key_mapping_keysyms_end(byval R as const xcb_input_get_device_key_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_key_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_key_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_key_mapping_reply_t ptr
declare function xcb_input_change_device_key_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_change_device_key_mapping_checked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_keycode as xcb_input_key_code_t, byval keysyms_per_keycode as ubyte, byval keycode_count as ubyte, byval keysyms as const xcb_keysym_t ptr) as xcb_void_cookie_t
declare function xcb_input_change_device_key_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_keycode as xcb_input_key_code_t, byval keysyms_per_keycode as ubyte, byval keycode_count as ubyte, byval keysyms as const xcb_keysym_t ptr) as xcb_void_cookie_t
declare function xcb_input_get_device_modifier_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_device_modifier_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_modifier_mapping_cookie_t
declare function xcb_input_get_device_modifier_mapping_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_modifier_mapping_cookie_t
declare function xcb_input_get_device_modifier_mapping_keymaps(byval R as const xcb_input_get_device_modifier_mapping_reply_t ptr) as ubyte ptr
declare function xcb_input_get_device_modifier_mapping_keymaps_length(byval R as const xcb_input_get_device_modifier_mapping_reply_t ptr) as long
declare function xcb_input_get_device_modifier_mapping_keymaps_end(byval R as const xcb_input_get_device_modifier_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_modifier_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_modifier_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_modifier_mapping_reply_t ptr
declare function xcb_input_set_device_modifier_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_set_device_modifier_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval keycodes_per_modifier as ubyte, byval keymaps as const ubyte ptr) as xcb_input_set_device_modifier_mapping_cookie_t
declare function xcb_input_set_device_modifier_mapping_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval keycodes_per_modifier as ubyte, byval keymaps as const ubyte ptr) as xcb_input_set_device_modifier_mapping_cookie_t
declare function xcb_input_set_device_modifier_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_set_device_modifier_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_set_device_modifier_mapping_reply_t ptr
declare function xcb_input_get_device_button_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_device_button_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_button_mapping_cookie_t
declare function xcb_input_get_device_button_mapping_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_get_device_button_mapping_cookie_t
declare function xcb_input_get_device_button_mapping_map(byval R as const xcb_input_get_device_button_mapping_reply_t ptr) as ubyte ptr
declare function xcb_input_get_device_button_mapping_map_length(byval R as const xcb_input_get_device_button_mapping_reply_t ptr) as long
declare function xcb_input_get_device_button_mapping_map_end(byval R as const xcb_input_get_device_button_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_button_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_button_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_button_mapping_reply_t ptr
declare function xcb_input_set_device_button_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_set_device_button_mapping(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval map_size as ubyte, byval map as const ubyte ptr) as xcb_input_set_device_button_mapping_cookie_t
declare function xcb_input_set_device_button_mapping_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval map_size as ubyte, byval map as const ubyte ptr) as xcb_input_set_device_button_mapping_cookie_t
declare function xcb_input_set_device_button_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_set_device_button_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_set_device_button_mapping_reply_t ptr
declare sub xcb_input_key_state_next(byval i as xcb_input_key_state_iterator_t ptr)
declare function xcb_input_key_state_end(byval i as xcb_input_key_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_button_state_next(byval i as xcb_input_button_state_iterator_t ptr)
declare function xcb_input_button_state_end(byval i as xcb_input_button_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_valuator_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_valuator_state_valuators(byval R as const xcb_input_valuator_state_t ptr) as ulong ptr
declare function xcb_input_valuator_state_valuators_length(byval R as const xcb_input_valuator_state_t ptr) as long
declare function xcb_input_valuator_state_valuators_end(byval R as const xcb_input_valuator_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_valuator_state_next(byval i as xcb_input_valuator_state_iterator_t ptr)
declare function xcb_input_valuator_state_end(byval i as xcb_input_valuator_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_input_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_input_state_uninterpreted_data(byval R as const xcb_input_input_state_t ptr) as ubyte ptr
declare function xcb_input_input_state_uninterpreted_data_length(byval R as const xcb_input_input_state_t ptr) as long
declare function xcb_input_input_state_uninterpreted_data_end(byval R as const xcb_input_input_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_input_state_next(byval i as xcb_input_input_state_iterator_t ptr)
declare function xcb_input_input_state_end(byval i as xcb_input_input_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_query_device_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_query_device_state(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_query_device_state_cookie_t
declare function xcb_input_query_device_state_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_query_device_state_cookie_t
declare function xcb_input_query_device_state_classes_length(byval R as const xcb_input_query_device_state_reply_t ptr) as long
declare function xcb_input_query_device_state_classes_iterator(byval R as const xcb_input_query_device_state_reply_t ptr) as xcb_input_input_state_iterator_t
declare function xcb_input_query_device_state_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_query_device_state_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_query_device_state_reply_t ptr
declare function xcb_input_send_extension_event_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_send_extension_event_checked(byval c as xcb_connection_t ptr, byval destination as xcb_window_t, byval device_id as ubyte, byval propagate as ubyte, byval num_classes as ushort, byval num_events as ubyte, byval events as const ubyte ptr, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_send_extension_event(byval c as xcb_connection_t ptr, byval destination as xcb_window_t, byval device_id as ubyte, byval propagate as ubyte, byval num_classes as ushort, byval num_events as ubyte, byval events as const ubyte ptr, byval classes as const xcb_input_event_class_t ptr) as xcb_void_cookie_t
declare function xcb_input_device_bell_checked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval feedback_id as ubyte, byval feedback_class as ubyte, byval percent as byte) as xcb_void_cookie_t
declare function xcb_input_device_bell(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval feedback_id as ubyte, byval feedback_class as ubyte, byval percent as byte) as xcb_void_cookie_t
declare function xcb_input_set_device_valuators_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_set_device_valuators(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_valuator as ubyte, byval num_valuators as ubyte, byval valuators as const long ptr) as xcb_input_set_device_valuators_cookie_t
declare function xcb_input_set_device_valuators_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte, byval first_valuator as ubyte, byval num_valuators as ubyte, byval valuators as const long ptr) as xcb_input_set_device_valuators_cookie_t
declare function xcb_input_set_device_valuators_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_set_device_valuators_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_set_device_valuators_reply_t ptr
declare function xcb_input_device_resolution_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_resolution_state_resolution_values(byval R as const xcb_input_device_resolution_state_t ptr) as ulong ptr
declare function xcb_input_device_resolution_state_resolution_values_length(byval R as const xcb_input_device_resolution_state_t ptr) as long
declare function xcb_input_device_resolution_state_resolution_values_end(byval R as const xcb_input_device_resolution_state_t ptr) as xcb_generic_iterator_t
declare function xcb_input_device_resolution_state_resolution_min(byval R as const xcb_input_device_resolution_state_t ptr) as ulong ptr
declare function xcb_input_device_resolution_state_resolution_min_length(byval R as const xcb_input_device_resolution_state_t ptr) as long
declare function xcb_input_device_resolution_state_resolution_min_end(byval R as const xcb_input_device_resolution_state_t ptr) as xcb_generic_iterator_t
declare function xcb_input_device_resolution_state_resolution_max(byval R as const xcb_input_device_resolution_state_t ptr) as ulong ptr
declare function xcb_input_device_resolution_state_resolution_max_length(byval R as const xcb_input_device_resolution_state_t ptr) as long
declare function xcb_input_device_resolution_state_resolution_max_end(byval R as const xcb_input_device_resolution_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_resolution_state_next(byval i as xcb_input_device_resolution_state_iterator_t ptr)
declare function xcb_input_device_resolution_state_end(byval i as xcb_input_device_resolution_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_abs_calib_state_next(byval i as xcb_input_device_abs_calib_state_iterator_t ptr)
declare function xcb_input_device_abs_calib_state_end(byval i as xcb_input_device_abs_calib_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_abs_area_state_next(byval i as xcb_input_device_abs_area_state_iterator_t ptr)
declare function xcb_input_device_abs_area_state_end(byval i as xcb_input_device_abs_area_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_core_state_next(byval i as xcb_input_device_core_state_iterator_t ptr)
declare function xcb_input_device_core_state_end(byval i as xcb_input_device_core_state_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_enable_state_next(byval i as xcb_input_device_enable_state_iterator_t ptr)
declare function xcb_input_device_enable_state_end(byval i as xcb_input_device_enable_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_device_state_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_state_uninterpreted_data(byval R as const xcb_input_device_state_t ptr) as ubyte ptr
declare function xcb_input_device_state_uninterpreted_data_length(byval R as const xcb_input_device_state_t ptr) as long
declare function xcb_input_device_state_uninterpreted_data_end(byval R as const xcb_input_device_state_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_state_next(byval i as xcb_input_device_state_iterator_t ptr)
declare function xcb_input_device_state_end(byval i as xcb_input_device_state_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_get_device_control_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_get_device_control(byval c as xcb_connection_t ptr, byval control_id as ushort, byval device_id as ubyte) as xcb_input_get_device_control_cookie_t
declare function xcb_input_get_device_control_unchecked(byval c as xcb_connection_t ptr, byval control_id as ushort, byval device_id as ubyte) as xcb_input_get_device_control_cookie_t
declare function xcb_input_get_device_control_control(byval R as const xcb_input_get_device_control_reply_t ptr) as xcb_input_device_state_t ptr
declare function xcb_input_get_device_control_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_control_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_control_reply_t ptr
declare function xcb_input_device_resolution_ctl_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_resolution_ctl_resolution_values(byval R as const xcb_input_device_resolution_ctl_t ptr) as ulong ptr
declare function xcb_input_device_resolution_ctl_resolution_values_length(byval R as const xcb_input_device_resolution_ctl_t ptr) as long
declare function xcb_input_device_resolution_ctl_resolution_values_end(byval R as const xcb_input_device_resolution_ctl_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_resolution_ctl_next(byval i as xcb_input_device_resolution_ctl_iterator_t ptr)
declare function xcb_input_device_resolution_ctl_end(byval i as xcb_input_device_resolution_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_abs_calib_ctl_next(byval i as xcb_input_device_abs_calib_ctl_iterator_t ptr)
declare function xcb_input_device_abs_calib_ctl_end(byval i as xcb_input_device_abs_calib_ctl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_abs_area_ctrl_next(byval i as xcb_input_device_abs_area_ctrl_iterator_t ptr)
declare function xcb_input_device_abs_area_ctrl_end(byval i as xcb_input_device_abs_area_ctrl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_core_ctrl_next(byval i as xcb_input_device_core_ctrl_iterator_t ptr)
declare function xcb_input_device_core_ctrl_end(byval i as xcb_input_device_core_ctrl_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_device_enable_ctrl_next(byval i as xcb_input_device_enable_ctrl_iterator_t ptr)
declare function xcb_input_device_enable_ctrl_end(byval i as xcb_input_device_enable_ctrl_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_device_ctl_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_ctl_uninterpreted_data(byval R as const xcb_input_device_ctl_t ptr) as ubyte ptr
declare function xcb_input_device_ctl_uninterpreted_data_length(byval R as const xcb_input_device_ctl_t ptr) as long
declare function xcb_input_device_ctl_uninterpreted_data_end(byval R as const xcb_input_device_ctl_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_ctl_next(byval i as xcb_input_device_ctl_iterator_t ptr)
declare function xcb_input_device_ctl_end(byval i as xcb_input_device_ctl_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_change_device_control_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_change_device_control(byval c as xcb_connection_t ptr, byval control_id as ushort, byval device_id as ubyte, byval control as xcb_input_device_ctl_t ptr) as xcb_input_change_device_control_cookie_t
declare function xcb_input_change_device_control_unchecked(byval c as xcb_connection_t ptr, byval control_id as ushort, byval device_id as ubyte, byval control as xcb_input_device_ctl_t ptr) as xcb_input_change_device_control_cookie_t
declare function xcb_input_change_device_control_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_change_device_control_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_change_device_control_reply_t ptr
declare function xcb_input_list_device_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_list_device_properties(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_list_device_properties_cookie_t
declare function xcb_input_list_device_properties_unchecked(byval c as xcb_connection_t ptr, byval device_id as ubyte) as xcb_input_list_device_properties_cookie_t
declare function xcb_input_list_device_properties_atoms(byval R as const xcb_input_list_device_properties_reply_t ptr) as xcb_atom_t ptr
declare function xcb_input_list_device_properties_atoms_length(byval R as const xcb_input_list_device_properties_reply_t ptr) as long
declare function xcb_input_list_device_properties_atoms_end(byval R as const xcb_input_list_device_properties_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_list_device_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_list_device_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_list_device_properties_reply_t ptr
declare function xcb_input_change_device_property_items_data_8(byval S as const xcb_input_change_device_property_items_t ptr) as ubyte ptr
declare function xcb_input_change_device_property_items_data_8_length(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as long
declare function xcb_input_change_device_property_items_data_8_end(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_change_device_property_items_data_16(byval S as const xcb_input_change_device_property_items_t ptr) as ushort ptr
declare function xcb_input_change_device_property_items_data_16_length(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as long
declare function xcb_input_change_device_property_items_data_16_end(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_change_device_property_items_data_32(byval S as const xcb_input_change_device_property_items_t ptr) as ulong ptr
declare function xcb_input_change_device_property_items_data_32_length(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as long
declare function xcb_input_change_device_property_items_data_32_end(byval R as const xcb_input_change_device_property_request_t ptr, byval S as const xcb_input_change_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_change_device_property_items_serialize(byval _buffer as any ptr ptr, byval num_items as ulong, byval format as ubyte, byval _aux as const xcb_input_change_device_property_items_t ptr) as long
declare function xcb_input_change_device_property_items_unpack(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte, byval _aux as xcb_input_change_device_property_items_t ptr) as long
declare function xcb_input_change_device_property_items_sizeof(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte) as long
declare function xcb_input_change_device_property_checked(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval device_id as ubyte, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval items as const any ptr) as xcb_void_cookie_t
declare function xcb_input_change_device_property(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval device_id as ubyte, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval items as const any ptr) as xcb_void_cookie_t
declare function xcb_input_change_device_property_aux_checked(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval device_id as ubyte, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval items as const xcb_input_change_device_property_items_t ptr) as xcb_void_cookie_t
declare function xcb_input_change_device_property_aux(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval device_id as ubyte, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval items as const xcb_input_change_device_property_items_t ptr) as xcb_void_cookie_t
declare function xcb_input_delete_device_property_checked(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_delete_device_property(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval device_id as ubyte) as xcb_void_cookie_t
declare function xcb_input_get_device_property_items_data_8(byval S as const xcb_input_get_device_property_items_t ptr) as ubyte ptr
declare function xcb_input_get_device_property_items_data_8_length(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as long
declare function xcb_input_get_device_property_items_data_8_end(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_property_items_data_16(byval S as const xcb_input_get_device_property_items_t ptr) as ushort ptr
declare function xcb_input_get_device_property_items_data_16_length(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as long
declare function xcb_input_get_device_property_items_data_16_end(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_property_items_data_32(byval S as const xcb_input_get_device_property_items_t ptr) as ulong ptr
declare function xcb_input_get_device_property_items_data_32_length(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as long
declare function xcb_input_get_device_property_items_data_32_end(byval R as const xcb_input_get_device_property_reply_t ptr, byval S as const xcb_input_get_device_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_get_device_property_items_serialize(byval _buffer as any ptr ptr, byval num_items as ulong, byval format as ubyte, byval _aux as const xcb_input_get_device_property_items_t ptr) as long
declare function xcb_input_get_device_property_items_unpack(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte, byval _aux as xcb_input_get_device_property_items_t ptr) as long
declare function xcb_input_get_device_property_items_sizeof(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte) as long
declare function xcb_input_get_device_property(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval offset as ulong, byval len as ulong, byval device_id as ubyte, byval _delete as ubyte) as xcb_input_get_device_property_cookie_t
declare function xcb_input_get_device_property_unchecked(byval c as xcb_connection_t ptr, byval property as xcb_atom_t, byval type as xcb_atom_t, byval offset as ulong, byval len as ulong, byval device_id as ubyte, byval _delete as ubyte) as xcb_input_get_device_property_cookie_t
declare function xcb_input_get_device_property_items(byval R as const xcb_input_get_device_property_reply_t ptr) as any ptr
declare function xcb_input_get_device_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_get_device_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_get_device_property_reply_t ptr
declare sub xcb_input_group_info_next(byval i as xcb_input_group_info_iterator_t ptr)
declare function xcb_input_group_info_end(byval i as xcb_input_group_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_modifier_info_next(byval i as xcb_input_modifier_info_iterator_t ptr)
declare function xcb_input_modifier_info_end(byval i as xcb_input_modifier_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_query_pointer_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_query_pointer(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_query_pointer_cookie_t
declare function xcb_input_xi_query_pointer_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_query_pointer_cookie_t
declare function xcb_input_xi_query_pointer_buttons(byval R as const xcb_input_xi_query_pointer_reply_t ptr) as ulong ptr
declare function xcb_input_xi_query_pointer_buttons_length(byval R as const xcb_input_xi_query_pointer_reply_t ptr) as long
declare function xcb_input_xi_query_pointer_buttons_end(byval R as const xcb_input_xi_query_pointer_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_query_pointer_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_query_pointer_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_query_pointer_reply_t ptr
declare function xcb_input_xi_warp_pointer_checked(byval c as xcb_connection_t ptr, byval src_win as xcb_window_t, byval dst_win as xcb_window_t, byval src_x as xcb_input_fp1616_t, byval src_y as xcb_input_fp1616_t, byval src_width as ushort, byval src_height as ushort, byval dst_x as xcb_input_fp1616_t, byval dst_y as xcb_input_fp1616_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_warp_pointer(byval c as xcb_connection_t ptr, byval src_win as xcb_window_t, byval dst_win as xcb_window_t, byval src_x as xcb_input_fp1616_t, byval src_y as xcb_input_fp1616_t, byval src_width as ushort, byval src_height as ushort, byval dst_x as xcb_input_fp1616_t, byval dst_y as xcb_input_fp1616_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_change_cursor_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval cursor as xcb_cursor_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_change_cursor(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval cursor as xcb_cursor_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_add_master_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_add_master_name(byval R as const xcb_input_add_master_t ptr) as zstring ptr
declare function xcb_input_add_master_name_length(byval R as const xcb_input_add_master_t ptr) as long
declare function xcb_input_add_master_name_end(byval R as const xcb_input_add_master_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_add_master_next(byval i as xcb_input_add_master_iterator_t ptr)
declare function xcb_input_add_master_end(byval i as xcb_input_add_master_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_remove_master_next(byval i as xcb_input_remove_master_iterator_t ptr)
declare function xcb_input_remove_master_end(byval i as xcb_input_remove_master_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_attach_slave_next(byval i as xcb_input_attach_slave_iterator_t ptr)
declare function xcb_input_attach_slave_end(byval i as xcb_input_attach_slave_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_detach_slave_next(byval i as xcb_input_detach_slave_iterator_t ptr)
declare function xcb_input_detach_slave_end(byval i as xcb_input_detach_slave_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_hierarchy_change_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_hierarchy_change_uninterpreted_data(byval R as const xcb_input_hierarchy_change_t ptr) as ubyte ptr
declare function xcb_input_hierarchy_change_uninterpreted_data_length(byval R as const xcb_input_hierarchy_change_t ptr) as long
declare function xcb_input_hierarchy_change_uninterpreted_data_end(byval R as const xcb_input_hierarchy_change_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_hierarchy_change_next(byval i as xcb_input_hierarchy_change_iterator_t ptr)
declare function xcb_input_hierarchy_change_end(byval i as xcb_input_hierarchy_change_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_change_hierarchy_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_change_hierarchy_checked(byval c as xcb_connection_t ptr, byval num_changes as ubyte, byval changes as const xcb_input_hierarchy_change_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_change_hierarchy(byval c as xcb_connection_t ptr, byval num_changes as ubyte, byval changes as const xcb_input_hierarchy_change_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_set_client_pointer_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_set_client_pointer(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_get_client_pointer(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_xi_get_client_pointer_cookie_t
declare function xcb_input_xi_get_client_pointer_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_xi_get_client_pointer_cookie_t
declare function xcb_input_xi_get_client_pointer_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_get_client_pointer_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_get_client_pointer_reply_t ptr
declare function xcb_input_event_mask_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_event_mask_mask(byval R as const xcb_input_event_mask_t ptr) as ulong ptr
declare function xcb_input_event_mask_mask_length(byval R as const xcb_input_event_mask_t ptr) as long
declare function xcb_input_event_mask_mask_end(byval R as const xcb_input_event_mask_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_event_mask_next(byval i as xcb_input_event_mask_iterator_t ptr)
declare function xcb_input_event_mask_end(byval i as xcb_input_event_mask_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_select_events_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_select_events_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_mask as ushort, byval masks as const xcb_input_event_mask_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_select_events(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval num_mask as ushort, byval masks as const xcb_input_event_mask_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_query_version(byval c as xcb_connection_t ptr, byval major_version as ushort, byval minor_version as ushort) as xcb_input_xi_query_version_cookie_t
declare function xcb_input_xi_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ushort, byval minor_version as ushort) as xcb_input_xi_query_version_cookie_t
declare function xcb_input_xi_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_query_version_reply_t ptr
declare function xcb_input_button_class_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_button_class_state(byval R as const xcb_input_button_class_t ptr) as ulong ptr
declare function xcb_input_button_class_state_length(byval R as const xcb_input_button_class_t ptr) as long
declare function xcb_input_button_class_state_end(byval R as const xcb_input_button_class_t ptr) as xcb_generic_iterator_t
declare function xcb_input_button_class_labels(byval R as const xcb_input_button_class_t ptr) as xcb_atom_t ptr
declare function xcb_input_button_class_labels_length(byval R as const xcb_input_button_class_t ptr) as long
declare function xcb_input_button_class_labels_end(byval R as const xcb_input_button_class_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_button_class_next(byval i as xcb_input_button_class_iterator_t ptr)
declare function xcb_input_button_class_end(byval i as xcb_input_button_class_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_key_class_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_key_class_keys(byval R as const xcb_input_key_class_t ptr) as ulong ptr
declare function xcb_input_key_class_keys_length(byval R as const xcb_input_key_class_t ptr) as long
declare function xcb_input_key_class_keys_end(byval R as const xcb_input_key_class_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_key_class_next(byval i as xcb_input_key_class_iterator_t ptr)
declare function xcb_input_key_class_end(byval i as xcb_input_key_class_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_scroll_class_next(byval i as xcb_input_scroll_class_iterator_t ptr)
declare function xcb_input_scroll_class_end(byval i as xcb_input_scroll_class_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_touch_class_next(byval i as xcb_input_touch_class_iterator_t ptr)
declare function xcb_input_touch_class_end(byval i as xcb_input_touch_class_iterator_t) as xcb_generic_iterator_t
declare sub xcb_input_valuator_class_next(byval i as xcb_input_valuator_class_iterator_t ptr)
declare function xcb_input_valuator_class_end(byval i as xcb_input_valuator_class_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_device_class_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_device_class_uninterpreted_data(byval R as const xcb_input_device_class_t ptr) as ubyte ptr
declare function xcb_input_device_class_uninterpreted_data_length(byval R as const xcb_input_device_class_t ptr) as long
declare function xcb_input_device_class_uninterpreted_data_end(byval R as const xcb_input_device_class_t ptr) as xcb_generic_iterator_t
declare sub xcb_input_device_class_next(byval i as xcb_input_device_class_iterator_t ptr)
declare function xcb_input_device_class_end(byval i as xcb_input_device_class_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_device_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_device_info_name(byval R as const xcb_input_xi_device_info_t ptr) as zstring ptr
declare function xcb_input_xi_device_info_name_length(byval R as const xcb_input_xi_device_info_t ptr) as long
declare function xcb_input_xi_device_info_name_end(byval R as const xcb_input_xi_device_info_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_device_info_classes_length(byval R as const xcb_input_xi_device_info_t ptr) as long
declare function xcb_input_xi_device_info_classes_iterator(byval R as const xcb_input_xi_device_info_t ptr) as xcb_input_device_class_iterator_t
declare sub xcb_input_xi_device_info_next(byval i as xcb_input_xi_device_info_iterator_t ptr)
declare function xcb_input_xi_device_info_end(byval i as xcb_input_xi_device_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_query_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_query_device(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_query_device_cookie_t
declare function xcb_input_xi_query_device_unchecked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_query_device_cookie_t
declare function xcb_input_xi_query_device_infos_length(byval R as const xcb_input_xi_query_device_reply_t ptr) as long
declare function xcb_input_xi_query_device_infos_iterator(byval R as const xcb_input_xi_query_device_reply_t ptr) as xcb_input_xi_device_info_iterator_t
declare function xcb_input_xi_query_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_query_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_query_device_reply_t ptr
declare function xcb_input_xi_set_focus_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_set_focus(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_get_focus(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_get_focus_cookie_t
declare function xcb_input_xi_get_focus_unchecked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_get_focus_cookie_t
declare function xcb_input_xi_get_focus_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_get_focus_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_get_focus_reply_t ptr
declare function xcb_input_xi_grab_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_grab_device(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval time as xcb_timestamp_t, byval cursor as xcb_cursor_t, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval paired_device_mode as ubyte, byval owner_events as ubyte, byval mask_len as ushort, byval mask as const ulong ptr) as xcb_input_xi_grab_device_cookie_t
declare function xcb_input_xi_grab_device_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval time as xcb_timestamp_t, byval cursor as xcb_cursor_t, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval paired_device_mode as ubyte, byval owner_events as ubyte, byval mask_len as ushort, byval mask as const ulong ptr) as xcb_input_xi_grab_device_cookie_t
declare function xcb_input_xi_grab_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_grab_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_grab_device_reply_t ptr
declare function xcb_input_xi_ungrab_device_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_ungrab_device(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t) as xcb_void_cookie_t
declare function xcb_input_xi_allow_events_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t, byval event_mode as ubyte, byval touchid as ulong, byval grab_window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_input_xi_allow_events(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval deviceid as xcb_input_device_id_t, byval event_mode as ubyte, byval touchid as ulong, byval grab_window as xcb_window_t) as xcb_void_cookie_t
declare sub xcb_input_grab_modifier_info_next(byval i as xcb_input_grab_modifier_info_iterator_t ptr)
declare function xcb_input_grab_modifier_info_end(byval i as xcb_input_grab_modifier_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_passive_grab_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_passive_grab_device(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval grab_window as xcb_window_t, byval cursor as xcb_cursor_t, byval detail as ulong, byval deviceid as xcb_input_device_id_t, byval num_modifiers as ushort, byval mask_len as ushort, byval grab_type as ubyte, byval grab_mode as ubyte, byval paired_device_mode as ubyte, byval owner_events as ubyte, byval mask as const ulong ptr, byval modifiers as const ulong ptr) as xcb_input_xi_passive_grab_device_cookie_t
declare function xcb_input_xi_passive_grab_device_unchecked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t, byval grab_window as xcb_window_t, byval cursor as xcb_cursor_t, byval detail as ulong, byval deviceid as xcb_input_device_id_t, byval num_modifiers as ushort, byval mask_len as ushort, byval grab_type as ubyte, byval grab_mode as ubyte, byval paired_device_mode as ubyte, byval owner_events as ubyte, byval mask as const ulong ptr, byval modifiers as const ulong ptr) as xcb_input_xi_passive_grab_device_cookie_t
declare function xcb_input_xi_passive_grab_device_modifiers(byval R as const xcb_input_xi_passive_grab_device_reply_t ptr) as xcb_input_grab_modifier_info_t ptr
declare function xcb_input_xi_passive_grab_device_modifiers_length(byval R as const xcb_input_xi_passive_grab_device_reply_t ptr) as long
declare function xcb_input_xi_passive_grab_device_modifiers_iterator(byval R as const xcb_input_xi_passive_grab_device_reply_t ptr) as xcb_input_grab_modifier_info_iterator_t
declare function xcb_input_xi_passive_grab_device_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_passive_grab_device_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_passive_grab_device_reply_t ptr
declare function xcb_input_xi_passive_ungrab_device_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_passive_ungrab_device_checked(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval detail as ulong, byval deviceid as xcb_input_device_id_t, byval num_modifiers as ushort, byval grab_type as ubyte, byval modifiers as const ulong ptr) as xcb_void_cookie_t
declare function xcb_input_xi_passive_ungrab_device(byval c as xcb_connection_t ptr, byval grab_window as xcb_window_t, byval detail as ulong, byval deviceid as xcb_input_device_id_t, byval num_modifiers as ushort, byval grab_type as ubyte, byval modifiers as const ulong ptr) as xcb_void_cookie_t
declare function xcb_input_xi_list_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_list_properties(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_list_properties_cookie_t
declare function xcb_input_xi_list_properties_unchecked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t) as xcb_input_xi_list_properties_cookie_t
declare function xcb_input_xi_list_properties_properties(byval R as const xcb_input_xi_list_properties_reply_t ptr) as xcb_atom_t ptr
declare function xcb_input_xi_list_properties_properties_length(byval R as const xcb_input_xi_list_properties_reply_t ptr) as long
declare function xcb_input_xi_list_properties_properties_end(byval R as const xcb_input_xi_list_properties_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_list_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_list_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_list_properties_reply_t ptr
declare function xcb_input_xi_change_property_items_data_8(byval S as const xcb_input_xi_change_property_items_t ptr) as ubyte ptr
declare function xcb_input_xi_change_property_items_data_8_length(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as long
declare function xcb_input_xi_change_property_items_data_8_end(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_change_property_items_data_16(byval S as const xcb_input_xi_change_property_items_t ptr) as ushort ptr
declare function xcb_input_xi_change_property_items_data_16_length(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as long
declare function xcb_input_xi_change_property_items_data_16_end(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_change_property_items_data_32(byval S as const xcb_input_xi_change_property_items_t ptr) as ulong ptr
declare function xcb_input_xi_change_property_items_data_32_length(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as long
declare function xcb_input_xi_change_property_items_data_32_end(byval R as const xcb_input_xi_change_property_request_t ptr, byval S as const xcb_input_xi_change_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_change_property_items_serialize(byval _buffer as any ptr ptr, byval num_items as ulong, byval format as ubyte, byval _aux as const xcb_input_xi_change_property_items_t ptr) as long
declare function xcb_input_xi_change_property_items_unpack(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte, byval _aux as xcb_input_xi_change_property_items_t ptr) as long
declare function xcb_input_xi_change_property_items_sizeof(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte) as long
declare function xcb_input_xi_change_property_checked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval format as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval num_items as ulong, byval items as const any ptr) as xcb_void_cookie_t
declare function xcb_input_xi_change_property(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval format as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval num_items as ulong, byval items as const any ptr) as xcb_void_cookie_t
declare function xcb_input_xi_change_property_aux_checked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval format as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval num_items as ulong, byval items as const xcb_input_xi_change_property_items_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_change_property_aux(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval mode as ubyte, byval format as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval num_items as ulong, byval items as const xcb_input_xi_change_property_items_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_delete_property_checked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_input_xi_delete_property(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_input_xi_get_property_items_data_8(byval S as const xcb_input_xi_get_property_items_t ptr) as ubyte ptr
declare function xcb_input_xi_get_property_items_data_8_length(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as long
declare function xcb_input_xi_get_property_items_data_8_end(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_get_property_items_data_16(byval S as const xcb_input_xi_get_property_items_t ptr) as ushort ptr
declare function xcb_input_xi_get_property_items_data_16_length(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as long
declare function xcb_input_xi_get_property_items_data_16_end(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_get_property_items_data_32(byval S as const xcb_input_xi_get_property_items_t ptr) as ulong ptr
declare function xcb_input_xi_get_property_items_data_32_length(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as long
declare function xcb_input_xi_get_property_items_data_32_end(byval R as const xcb_input_xi_get_property_reply_t ptr, byval S as const xcb_input_xi_get_property_items_t ptr) as xcb_generic_iterator_t
declare function xcb_input_xi_get_property_items_serialize(byval _buffer as any ptr ptr, byval num_items as ulong, byval format as ubyte, byval _aux as const xcb_input_xi_get_property_items_t ptr) as long
declare function xcb_input_xi_get_property_items_unpack(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte, byval _aux as xcb_input_xi_get_property_items_t ptr) as long
declare function xcb_input_xi_get_property_items_sizeof(byval _buffer as const any ptr, byval num_items as ulong, byval format as ubyte) as long
declare function xcb_input_xi_get_property(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval _delete as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval offset as ulong, byval len as ulong) as xcb_input_xi_get_property_cookie_t
declare function xcb_input_xi_get_property_unchecked(byval c as xcb_connection_t ptr, byval deviceid as xcb_input_device_id_t, byval _delete as ubyte, byval property as xcb_atom_t, byval type as xcb_atom_t, byval offset as ulong, byval len as ulong) as xcb_input_xi_get_property_cookie_t
declare function xcb_input_xi_get_property_items(byval R as const xcb_input_xi_get_property_reply_t ptr) as any ptr
declare function xcb_input_xi_get_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_get_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_get_property_reply_t ptr
declare function xcb_input_xi_get_selected_events_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_get_selected_events(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_xi_get_selected_events_cookie_t
declare function xcb_input_xi_get_selected_events_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_input_xi_get_selected_events_cookie_t
declare function xcb_input_xi_get_selected_events_masks_length(byval R as const xcb_input_xi_get_selected_events_reply_t ptr) as long
declare function xcb_input_xi_get_selected_events_masks_iterator(byval R as const xcb_input_xi_get_selected_events_reply_t ptr) as xcb_input_event_mask_iterator_t
declare function xcb_input_xi_get_selected_events_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_input_xi_get_selected_events_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_input_xi_get_selected_events_reply_t ptr
declare sub xcb_input_barrier_release_pointer_info_next(byval i as xcb_input_barrier_release_pointer_info_iterator_t ptr)
declare function xcb_input_barrier_release_pointer_info_end(byval i as xcb_input_barrier_release_pointer_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_xi_barrier_release_pointer_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_xi_barrier_release_pointer_checked(byval c as xcb_connection_t ptr, byval num_barriers as ulong, byval barriers as const xcb_input_barrier_release_pointer_info_t ptr) as xcb_void_cookie_t
declare function xcb_input_xi_barrier_release_pointer(byval c as xcb_connection_t ptr, byval num_barriers as ulong, byval barriers as const xcb_input_barrier_release_pointer_info_t ptr) as xcb_void_cookie_t
declare function xcb_input_device_changed_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_key_press_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_key_release_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_button_press_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_button_release_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_motion_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_enter_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_leave_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_focus_in_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_focus_out_sizeof(byval _buffer as const any ptr) as long
declare sub xcb_input_hierarchy_info_next(byval i as xcb_input_hierarchy_info_iterator_t ptr)
declare function xcb_input_hierarchy_info_end(byval i as xcb_input_hierarchy_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_input_hierarchy_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_key_press_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_key_release_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_button_press_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_button_release_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_motion_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_touch_begin_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_touch_update_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_touch_end_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_touch_begin_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_touch_update_sizeof(byval _buffer as const any ptr) as long
declare function xcb_input_raw_touch_end_sizeof(byval _buffer as const any ptr) as long

end extern
