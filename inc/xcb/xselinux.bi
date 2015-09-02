'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_SELINUX_QUERY_VERSION => XCB_SELINUX_QUERY_VERSION_
''     constant XCB_SELINUX_SET_DEVICE_CREATE_CONTEXT => XCB_SELINUX_SET_DEVICE_CREATE_CONTEXT_
''     constant XCB_SELINUX_GET_DEVICE_CREATE_CONTEXT => XCB_SELINUX_GET_DEVICE_CREATE_CONTEXT_
''     constant XCB_SELINUX_SET_DEVICE_CONTEXT => XCB_SELINUX_SET_DEVICE_CONTEXT_
''     constant XCB_SELINUX_GET_DEVICE_CONTEXT => XCB_SELINUX_GET_DEVICE_CONTEXT_
''     constant XCB_SELINUX_SET_WINDOW_CREATE_CONTEXT => XCB_SELINUX_SET_WINDOW_CREATE_CONTEXT_
''     constant XCB_SELINUX_GET_WINDOW_CREATE_CONTEXT => XCB_SELINUX_GET_WINDOW_CREATE_CONTEXT_
''     constant XCB_SELINUX_GET_WINDOW_CONTEXT => XCB_SELINUX_GET_WINDOW_CONTEXT_
''     constant XCB_SELINUX_SET_PROPERTY_CREATE_CONTEXT => XCB_SELINUX_SET_PROPERTY_CREATE_CONTEXT_
''     constant XCB_SELINUX_GET_PROPERTY_CREATE_CONTEXT => XCB_SELINUX_GET_PROPERTY_CREATE_CONTEXT_
''     constant XCB_SELINUX_SET_PROPERTY_USE_CONTEXT => XCB_SELINUX_SET_PROPERTY_USE_CONTEXT_
''     constant XCB_SELINUX_GET_PROPERTY_USE_CONTEXT => XCB_SELINUX_GET_PROPERTY_USE_CONTEXT_
''     constant XCB_SELINUX_GET_PROPERTY_CONTEXT => XCB_SELINUX_GET_PROPERTY_CONTEXT_
''     constant XCB_SELINUX_GET_PROPERTY_DATA_CONTEXT => XCB_SELINUX_GET_PROPERTY_DATA_CONTEXT_
''     constant XCB_SELINUX_LIST_PROPERTIES => XCB_SELINUX_LIST_PROPERTIES_
''     constant XCB_SELINUX_SET_SELECTION_CREATE_CONTEXT => XCB_SELINUX_SET_SELECTION_CREATE_CONTEXT_
''     constant XCB_SELINUX_GET_SELECTION_CREATE_CONTEXT => XCB_SELINUX_GET_SELECTION_CREATE_CONTEXT_
''     constant XCB_SELINUX_SET_SELECTION_USE_CONTEXT => XCB_SELINUX_SET_SELECTION_USE_CONTEXT_
''     constant XCB_SELINUX_GET_SELECTION_USE_CONTEXT => XCB_SELINUX_GET_SELECTION_USE_CONTEXT_
''     constant XCB_SELINUX_GET_SELECTION_CONTEXT => XCB_SELINUX_GET_SELECTION_CONTEXT_
''     constant XCB_SELINUX_GET_SELECTION_DATA_CONTEXT => XCB_SELINUX_GET_SELECTION_DATA_CONTEXT_
''     constant XCB_SELINUX_LIST_SELECTIONS => XCB_SELINUX_LIST_SELECTIONS_
''     constant XCB_SELINUX_GET_CLIENT_CONTEXT => XCB_SELINUX_GET_CLIENT_CONTEXT_

extern "C"

#define __XSELINUX_H
const XCB_SELINUX_MAJOR_VERSION = 1
const XCB_SELINUX_MINOR_VERSION = 0
extern xcb_selinux_id as xcb_extension_t

type xcb_selinux_query_version_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_QUERY_VERSION_ = 0

type xcb_selinux_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major as ubyte
	client_minor as ubyte
end type

type xcb_selinux_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major as ushort
	server_minor as ushort
end type

const XCB_SELINUX_SET_DEVICE_CREATE_CONTEXT_ = 1

type xcb_selinux_set_device_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_device_create_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_DEVICE_CREATE_CONTEXT_ = 2

type xcb_selinux_get_device_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_device_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SELINUX_SET_DEVICE_CONTEXT_ = 3

type xcb_selinux_set_device_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device as ulong
	context_len as ulong
end type

type xcb_selinux_get_device_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_DEVICE_CONTEXT_ = 4

type xcb_selinux_get_device_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	device as ulong
end type

type xcb_selinux_get_device_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SELINUX_SET_WINDOW_CREATE_CONTEXT_ = 5

type xcb_selinux_set_window_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_window_create_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_WINDOW_CREATE_CONTEXT_ = 6

type xcb_selinux_get_window_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_window_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_window_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_WINDOW_CONTEXT_ = 7

type xcb_selinux_get_window_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_selinux_get_window_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_list_item_t
	name as xcb_atom_t
	object_context_len as ulong
	data_context_len as ulong
end type

type xcb_selinux_list_item_iterator_t
	data as xcb_selinux_list_item_t ptr
	as long rem
	index as long
end type

const XCB_SELINUX_SET_PROPERTY_CREATE_CONTEXT_ = 8

type xcb_selinux_set_property_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_property_create_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_PROPERTY_CREATE_CONTEXT_ = 9

type xcb_selinux_get_property_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_property_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SELINUX_SET_PROPERTY_USE_CONTEXT_ = 10

type xcb_selinux_set_property_use_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_property_use_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_PROPERTY_USE_CONTEXT_ = 11

type xcb_selinux_get_property_use_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_property_use_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_property_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_PROPERTY_CONTEXT_ = 12

type xcb_selinux_get_property_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	property as xcb_atom_t
end type

type xcb_selinux_get_property_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_property_data_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_PROPERTY_DATA_CONTEXT_ = 13

type xcb_selinux_get_property_data_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	property as xcb_atom_t
end type

type xcb_selinux_get_property_data_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_list_properties_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_LIST_PROPERTIES_ = 14

type xcb_selinux_list_properties_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_selinux_list_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	properties_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SELINUX_SET_SELECTION_CREATE_CONTEXT_ = 15

type xcb_selinux_set_selection_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_selection_create_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_SELECTION_CREATE_CONTEXT_ = 16

type xcb_selinux_get_selection_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_selection_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_SELINUX_SET_SELECTION_USE_CONTEXT_ = 17

type xcb_selinux_set_selection_use_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_len as ulong
end type

type xcb_selinux_get_selection_use_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_SELECTION_USE_CONTEXT_ = 18

type xcb_selinux_get_selection_use_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_get_selection_use_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_selection_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_SELECTION_CONTEXT_ = 19

type xcb_selinux_get_selection_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	selection as xcb_atom_t
end type

type xcb_selinux_get_selection_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_selection_data_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_SELECTION_DATA_CONTEXT_ = 20

type xcb_selinux_get_selection_data_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	selection as xcb_atom_t
end type

type xcb_selinux_get_selection_data_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_list_selections_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_LIST_SELECTIONS_ = 21

type xcb_selinux_list_selections_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_selinux_list_selections_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	selections_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_selinux_get_client_context_cookie_t
	sequence as ulong
end type

const XCB_SELINUX_GET_CLIENT_CONTEXT_ = 22

type xcb_selinux_get_client_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	resource as ulong
end type

type xcb_selinux_get_client_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_len as ulong
	pad1(0 to 19) as ubyte
end type

declare function xcb_selinux_query_version(byval c as xcb_connection_t ptr, byval client_major as ubyte, byval client_minor as ubyte) as xcb_selinux_query_version_cookie_t
declare function xcb_selinux_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major as ubyte, byval client_minor as ubyte) as xcb_selinux_query_version_cookie_t
declare function xcb_selinux_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_query_version_reply_t ptr
declare function xcb_selinux_set_device_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_device_create_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_device_create_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_device_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_device_create_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_device_create_context_cookie_t
declare function xcb_selinux_get_device_create_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_device_create_context_cookie_t
declare function xcb_selinux_get_device_create_context_context(byval R as const xcb_selinux_get_device_create_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_device_create_context_context_length(byval R as const xcb_selinux_get_device_create_context_reply_t ptr) as long
declare function xcb_selinux_get_device_create_context_context_end(byval R as const xcb_selinux_get_device_create_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_device_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_device_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_device_create_context_reply_t ptr
declare function xcb_selinux_set_device_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_device_context_checked(byval c as xcb_connection_t ptr, byval device as ulong, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_device_context(byval c as xcb_connection_t ptr, byval device as ulong, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_device_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_device_context(byval c as xcb_connection_t ptr, byval device as ulong) as xcb_selinux_get_device_context_cookie_t
declare function xcb_selinux_get_device_context_unchecked(byval c as xcb_connection_t ptr, byval device as ulong) as xcb_selinux_get_device_context_cookie_t
declare function xcb_selinux_get_device_context_context(byval R as const xcb_selinux_get_device_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_device_context_context_length(byval R as const xcb_selinux_get_device_context_reply_t ptr) as long
declare function xcb_selinux_get_device_context_context_end(byval R as const xcb_selinux_get_device_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_device_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_device_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_device_context_reply_t ptr
declare function xcb_selinux_set_window_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_window_create_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_window_create_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_window_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_window_create_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_window_create_context_cookie_t
declare function xcb_selinux_get_window_create_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_window_create_context_cookie_t
declare function xcb_selinux_get_window_create_context_context(byval R as const xcb_selinux_get_window_create_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_window_create_context_context_length(byval R as const xcb_selinux_get_window_create_context_reply_t ptr) as long
declare function xcb_selinux_get_window_create_context_context_end(byval R as const xcb_selinux_get_window_create_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_window_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_window_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_window_create_context_reply_t ptr
declare function xcb_selinux_get_window_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_window_context(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_selinux_get_window_context_cookie_t
declare function xcb_selinux_get_window_context_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_selinux_get_window_context_cookie_t
declare function xcb_selinux_get_window_context_context(byval R as const xcb_selinux_get_window_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_window_context_context_length(byval R as const xcb_selinux_get_window_context_reply_t ptr) as long
declare function xcb_selinux_get_window_context_context_end(byval R as const xcb_selinux_get_window_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_window_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_window_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_window_context_reply_t ptr
declare function xcb_selinux_list_item_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_list_item_object_context(byval R as const xcb_selinux_list_item_t ptr) as zstring ptr
declare function xcb_selinux_list_item_object_context_length(byval R as const xcb_selinux_list_item_t ptr) as long
declare function xcb_selinux_list_item_object_context_end(byval R as const xcb_selinux_list_item_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_list_item_data_context(byval R as const xcb_selinux_list_item_t ptr) as zstring ptr
declare function xcb_selinux_list_item_data_context_length(byval R as const xcb_selinux_list_item_t ptr) as long
declare function xcb_selinux_list_item_data_context_end(byval R as const xcb_selinux_list_item_t ptr) as xcb_generic_iterator_t
declare sub xcb_selinux_list_item_next(byval i as xcb_selinux_list_item_iterator_t ptr)
declare function xcb_selinux_list_item_end(byval i as xcb_selinux_list_item_iterator_t) as xcb_generic_iterator_t
declare function xcb_selinux_set_property_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_property_create_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_property_create_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_property_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_property_create_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_property_create_context_cookie_t
declare function xcb_selinux_get_property_create_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_property_create_context_cookie_t
declare function xcb_selinux_get_property_create_context_context(byval R as const xcb_selinux_get_property_create_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_property_create_context_context_length(byval R as const xcb_selinux_get_property_create_context_reply_t ptr) as long
declare function xcb_selinux_get_property_create_context_context_end(byval R as const xcb_selinux_get_property_create_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_property_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_property_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_property_create_context_reply_t ptr
declare function xcb_selinux_set_property_use_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_property_use_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_property_use_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_property_use_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_property_use_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_property_use_context_cookie_t
declare function xcb_selinux_get_property_use_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_property_use_context_cookie_t
declare function xcb_selinux_get_property_use_context_context(byval R as const xcb_selinux_get_property_use_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_property_use_context_context_length(byval R as const xcb_selinux_get_property_use_context_reply_t ptr) as long
declare function xcb_selinux_get_property_use_context_context_end(byval R as const xcb_selinux_get_property_use_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_property_use_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_property_use_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_property_use_context_reply_t ptr
declare function xcb_selinux_get_property_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_property_context(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_selinux_get_property_context_cookie_t
declare function xcb_selinux_get_property_context_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_selinux_get_property_context_cookie_t
declare function xcb_selinux_get_property_context_context(byval R as const xcb_selinux_get_property_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_property_context_context_length(byval R as const xcb_selinux_get_property_context_reply_t ptr) as long
declare function xcb_selinux_get_property_context_context_end(byval R as const xcb_selinux_get_property_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_property_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_property_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_property_context_reply_t ptr
declare function xcb_selinux_get_property_data_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_property_data_context(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_selinux_get_property_data_context_cookie_t
declare function xcb_selinux_get_property_data_context_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_selinux_get_property_data_context_cookie_t
declare function xcb_selinux_get_property_data_context_context(byval R as const xcb_selinux_get_property_data_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_property_data_context_context_length(byval R as const xcb_selinux_get_property_data_context_reply_t ptr) as long
declare function xcb_selinux_get_property_data_context_context_end(byval R as const xcb_selinux_get_property_data_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_property_data_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_property_data_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_property_data_context_reply_t ptr
declare function xcb_selinux_list_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_list_properties(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_selinux_list_properties_cookie_t
declare function xcb_selinux_list_properties_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_selinux_list_properties_cookie_t
declare function xcb_selinux_list_properties_properties_length(byval R as const xcb_selinux_list_properties_reply_t ptr) as long
declare function xcb_selinux_list_properties_properties_iterator(byval R as const xcb_selinux_list_properties_reply_t ptr) as xcb_selinux_list_item_iterator_t
declare function xcb_selinux_list_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_list_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_list_properties_reply_t ptr
declare function xcb_selinux_set_selection_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_selection_create_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_selection_create_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_selection_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_selection_create_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_selection_create_context_cookie_t
declare function xcb_selinux_get_selection_create_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_selection_create_context_cookie_t
declare function xcb_selinux_get_selection_create_context_context(byval R as const xcb_selinux_get_selection_create_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_selection_create_context_context_length(byval R as const xcb_selinux_get_selection_create_context_reply_t ptr) as long
declare function xcb_selinux_get_selection_create_context_context_end(byval R as const xcb_selinux_get_selection_create_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_selection_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_selection_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_selection_create_context_reply_t ptr
declare function xcb_selinux_set_selection_use_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_set_selection_use_context_checked(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_set_selection_use_context(byval c as xcb_connection_t ptr, byval context_len as ulong, byval context as const zstring ptr) as xcb_void_cookie_t
declare function xcb_selinux_get_selection_use_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_selection_use_context(byval c as xcb_connection_t ptr) as xcb_selinux_get_selection_use_context_cookie_t
declare function xcb_selinux_get_selection_use_context_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_get_selection_use_context_cookie_t
declare function xcb_selinux_get_selection_use_context_context(byval R as const xcb_selinux_get_selection_use_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_selection_use_context_context_length(byval R as const xcb_selinux_get_selection_use_context_reply_t ptr) as long
declare function xcb_selinux_get_selection_use_context_context_end(byval R as const xcb_selinux_get_selection_use_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_selection_use_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_selection_use_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_selection_use_context_reply_t ptr
declare function xcb_selinux_get_selection_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_selection_context(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_selinux_get_selection_context_cookie_t
declare function xcb_selinux_get_selection_context_unchecked(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_selinux_get_selection_context_cookie_t
declare function xcb_selinux_get_selection_context_context(byval R as const xcb_selinux_get_selection_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_selection_context_context_length(byval R as const xcb_selinux_get_selection_context_reply_t ptr) as long
declare function xcb_selinux_get_selection_context_context_end(byval R as const xcb_selinux_get_selection_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_selection_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_selection_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_selection_context_reply_t ptr
declare function xcb_selinux_get_selection_data_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_selection_data_context(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_selinux_get_selection_data_context_cookie_t
declare function xcb_selinux_get_selection_data_context_unchecked(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_selinux_get_selection_data_context_cookie_t
declare function xcb_selinux_get_selection_data_context_context(byval R as const xcb_selinux_get_selection_data_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_selection_data_context_context_length(byval R as const xcb_selinux_get_selection_data_context_reply_t ptr) as long
declare function xcb_selinux_get_selection_data_context_context_end(byval R as const xcb_selinux_get_selection_data_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_selection_data_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_selection_data_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_selection_data_context_reply_t ptr
declare function xcb_selinux_list_selections_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_list_selections(byval c as xcb_connection_t ptr) as xcb_selinux_list_selections_cookie_t
declare function xcb_selinux_list_selections_unchecked(byval c as xcb_connection_t ptr) as xcb_selinux_list_selections_cookie_t
declare function xcb_selinux_list_selections_selections_length(byval R as const xcb_selinux_list_selections_reply_t ptr) as long
declare function xcb_selinux_list_selections_selections_iterator(byval R as const xcb_selinux_list_selections_reply_t ptr) as xcb_selinux_list_item_iterator_t
declare function xcb_selinux_list_selections_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_list_selections_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_list_selections_reply_t ptr
declare function xcb_selinux_get_client_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_selinux_get_client_context(byval c as xcb_connection_t ptr, byval resource as ulong) as xcb_selinux_get_client_context_cookie_t
declare function xcb_selinux_get_client_context_unchecked(byval c as xcb_connection_t ptr, byval resource as ulong) as xcb_selinux_get_client_context_cookie_t
declare function xcb_selinux_get_client_context_context(byval R as const xcb_selinux_get_client_context_reply_t ptr) as zstring ptr
declare function xcb_selinux_get_client_context_context_length(byval R as const xcb_selinux_get_client_context_reply_t ptr) as long
declare function xcb_selinux_get_client_context_context_end(byval R as const xcb_selinux_get_client_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_selinux_get_client_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_selinux_get_client_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_selinux_get_client_context_reply_t ptr

end extern
