'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2005 Jeremy Kolb.
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person ob/Sintaining a copy
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
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_RECORD_QUERY_VERSION => XCB_RECORD_QUERY_VERSION_
''     constant XCB_RECORD_CREATE_CONTEXT => XCB_RECORD_CREATE_CONTEXT_
''     constant XCB_RECORD_REGISTER_CLIENTS => XCB_RECORD_REGISTER_CLIENTS_
''     constant XCB_RECORD_UNREGISTER_CLIENTS => XCB_RECORD_UNREGISTER_CLIENTS_
''     constant XCB_RECORD_GET_CONTEXT => XCB_RECORD_GET_CONTEXT_
''     constant XCB_RECORD_ENABLE_CONTEXT => XCB_RECORD_ENABLE_CONTEXT_
''     constant XCB_RECORD_DISABLE_CONTEXT => XCB_RECORD_DISABLE_CONTEXT_
''     constant XCB_RECORD_FREE_CONTEXT => XCB_RECORD_FREE_CONTEXT_

extern "C"

#define __RECORD_H
const XCB_RECORD_MAJOR_VERSION = 1
const XCB_RECORD_MINOR_VERSION = 13
extern xcb_record_id as xcb_extension_t
type xcb_record_context_t as ulong

type xcb_record_context_iterator_t
	data as xcb_record_context_t ptr
	as long rem
	index as long
end type

type xcb_record_range_8_t
	first as ubyte
	last as ubyte
end type

type xcb_record_range_8_iterator_t
	data as xcb_record_range_8_t ptr
	as long rem
	index as long
end type

type xcb_record_range_16_t
	first as ushort
	last as ushort
end type

type xcb_record_range_16_iterator_t
	data as xcb_record_range_16_t ptr
	as long rem
	index as long
end type

type xcb_record_ext_range_t
	major as xcb_record_range_8_t
	minor as xcb_record_range_16_t
end type

type xcb_record_ext_range_iterator_t
	data as xcb_record_ext_range_t ptr
	as long rem
	index as long
end type

type xcb_record_range_t
	core_requests as xcb_record_range_8_t
	core_replies as xcb_record_range_8_t
	ext_requests as xcb_record_ext_range_t
	ext_replies as xcb_record_ext_range_t
	delivered_events as xcb_record_range_8_t
	device_events as xcb_record_range_8_t
	errors as xcb_record_range_8_t
	client_started as ubyte
	client_died as ubyte
end type

type xcb_record_range_iterator_t
	data as xcb_record_range_t ptr
	as long rem
	index as long
end type

type xcb_record_element_header_t as ubyte

type xcb_record_element_header_iterator_t
	data as xcb_record_element_header_t ptr
	as long rem
	index as long
end type

type xcb_record_h_type_t as long
enum
	XCB_RECORD_H_TYPE_FROM_SERVER_TIME = 1
	XCB_RECORD_H_TYPE_FROM_CLIENT_TIME = 2
	XCB_RECORD_H_TYPE_FROM_CLIENT_SEQUENCE = 4
end enum

type xcb_record_client_spec_t as ulong

type xcb_record_client_spec_iterator_t
	data as xcb_record_client_spec_t ptr
	as long rem
	index as long
end type

type xcb_record_cs_t as long
enum
	XCB_RECORD_CS_CURRENT_CLIENTS = 1
	XCB_RECORD_CS_FUTURE_CLIENTS = 2
	XCB_RECORD_CS_ALL_CLIENTS = 3
end enum

type xcb_record_client_info_t
	client_resource as xcb_record_client_spec_t
	num_ranges as ulong
end type

type xcb_record_client_info_iterator_t
	data as xcb_record_client_info_t ptr
	as long rem
	index as long
end type

const XCB_RECORD_BAD_CONTEXT = 0

type xcb_record_bad_context_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	invalid_record as ulong
end type

type xcb_record_query_version_cookie_t
	sequence as ulong
end type

const XCB_RECORD_QUERY_VERSION_ = 0

type xcb_record_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ushort
	minor_version as ushort
end type

type xcb_record_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
end type

const XCB_RECORD_CREATE_CONTEXT_ = 1

type xcb_record_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
	element_header as xcb_record_element_header_t
	pad0(0 to 2) as ubyte
	num_client_specs as ulong
	num_ranges as ulong
end type

const XCB_RECORD_REGISTER_CLIENTS_ = 2

type xcb_record_register_clients_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
	element_header as xcb_record_element_header_t
	pad0(0 to 2) as ubyte
	num_client_specs as ulong
	num_ranges as ulong
end type

const XCB_RECORD_UNREGISTER_CLIENTS_ = 3

type xcb_record_unregister_clients_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
	num_client_specs as ulong
end type

type xcb_record_get_context_cookie_t
	sequence as ulong
end type

const XCB_RECORD_GET_CONTEXT_ = 4

type xcb_record_get_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
end type

type xcb_record_get_context_reply_t
	response_type as ubyte
	enabled as ubyte
	sequence as ushort
	length as ulong
	element_header as xcb_record_element_header_t
	pad0(0 to 2) as ubyte
	num_intercepted_clients as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_record_enable_context_cookie_t
	sequence as ulong
end type

const XCB_RECORD_ENABLE_CONTEXT_ = 5

type xcb_record_enable_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
end type

type xcb_record_enable_context_reply_t
	response_type as ubyte
	category as ubyte
	sequence as ushort
	length as ulong
	element_header as xcb_record_element_header_t
	client_swapped as ubyte
	pad0(0 to 1) as ubyte
	xid_base as ulong
	server_time as ulong
	rec_sequence_num as ulong
	pad1(0 to 7) as ubyte
end type

const XCB_RECORD_DISABLE_CONTEXT_ = 6

type xcb_record_disable_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
end type

const XCB_RECORD_FREE_CONTEXT_ = 7

type xcb_record_free_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_record_context_t
end type

declare sub xcb_record_context_next(byval i as xcb_record_context_iterator_t ptr)
declare function xcb_record_context_end(byval i as xcb_record_context_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_range_8_next(byval i as xcb_record_range_8_iterator_t ptr)
declare function xcb_record_range_8_end(byval i as xcb_record_range_8_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_range_16_next(byval i as xcb_record_range_16_iterator_t ptr)
declare function xcb_record_range_16_end(byval i as xcb_record_range_16_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_ext_range_next(byval i as xcb_record_ext_range_iterator_t ptr)
declare function xcb_record_ext_range_end(byval i as xcb_record_ext_range_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_range_next(byval i as xcb_record_range_iterator_t ptr)
declare function xcb_record_range_end(byval i as xcb_record_range_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_element_header_next(byval i as xcb_record_element_header_iterator_t ptr)
declare function xcb_record_element_header_end(byval i as xcb_record_element_header_iterator_t) as xcb_generic_iterator_t
declare sub xcb_record_client_spec_next(byval i as xcb_record_client_spec_iterator_t ptr)
declare function xcb_record_client_spec_end(byval i as xcb_record_client_spec_iterator_t) as xcb_generic_iterator_t
declare function xcb_record_client_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_client_info_ranges(byval R as const xcb_record_client_info_t ptr) as xcb_record_range_t ptr
declare function xcb_record_client_info_ranges_length(byval R as const xcb_record_client_info_t ptr) as long
declare function xcb_record_client_info_ranges_iterator(byval R as const xcb_record_client_info_t ptr) as xcb_record_range_iterator_t
declare sub xcb_record_client_info_next(byval i as xcb_record_client_info_iterator_t ptr)
declare function xcb_record_client_info_end(byval i as xcb_record_client_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_record_query_version(byval c as xcb_connection_t ptr, byval major_version as ushort, byval minor_version as ushort) as xcb_record_query_version_cookie_t
declare function xcb_record_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ushort, byval minor_version as ushort) as xcb_record_query_version_cookie_t
declare function xcb_record_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_record_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_record_query_version_reply_t ptr
declare function xcb_record_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_create_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval element_header as xcb_record_element_header_t, byval num_client_specs as ulong, byval num_ranges as ulong, byval client_specs as const xcb_record_client_spec_t ptr, byval ranges as const xcb_record_range_t ptr) as xcb_void_cookie_t
declare function xcb_record_create_context(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval element_header as xcb_record_element_header_t, byval num_client_specs as ulong, byval num_ranges as ulong, byval client_specs as const xcb_record_client_spec_t ptr, byval ranges as const xcb_record_range_t ptr) as xcb_void_cookie_t
declare function xcb_record_register_clients_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_register_clients_checked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval element_header as xcb_record_element_header_t, byval num_client_specs as ulong, byval num_ranges as ulong, byval client_specs as const xcb_record_client_spec_t ptr, byval ranges as const xcb_record_range_t ptr) as xcb_void_cookie_t
declare function xcb_record_register_clients(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval element_header as xcb_record_element_header_t, byval num_client_specs as ulong, byval num_ranges as ulong, byval client_specs as const xcb_record_client_spec_t ptr, byval ranges as const xcb_record_range_t ptr) as xcb_void_cookie_t
declare function xcb_record_unregister_clients_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_unregister_clients_checked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval num_client_specs as ulong, byval client_specs as const xcb_record_client_spec_t ptr) as xcb_void_cookie_t
declare function xcb_record_unregister_clients(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t, byval num_client_specs as ulong, byval client_specs as const xcb_record_client_spec_t ptr) as xcb_void_cookie_t
declare function xcb_record_get_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_get_context(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_record_get_context_cookie_t
declare function xcb_record_get_context_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_record_get_context_cookie_t
declare function xcb_record_get_context_intercepted_clients_length(byval R as const xcb_record_get_context_reply_t ptr) as long
declare function xcb_record_get_context_intercepted_clients_iterator(byval R as const xcb_record_get_context_reply_t ptr) as xcb_record_client_info_iterator_t
declare function xcb_record_get_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_record_get_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_record_get_context_reply_t ptr
declare function xcb_record_enable_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_record_enable_context(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_record_enable_context_cookie_t
declare function xcb_record_enable_context_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_record_enable_context_cookie_t
declare function xcb_record_enable_context_data(byval R as const xcb_record_enable_context_reply_t ptr) as ubyte ptr
declare function xcb_record_enable_context_data_length(byval R as const xcb_record_enable_context_reply_t ptr) as long
declare function xcb_record_enable_context_data_end(byval R as const xcb_record_enable_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_record_enable_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_record_enable_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_record_enable_context_reply_t ptr
declare function xcb_record_disable_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_void_cookie_t
declare function xcb_record_disable_context(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_void_cookie_t
declare function xcb_record_free_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_void_cookie_t
declare function xcb_record_free_context(byval c as xcb_connection_t ptr, byval context as xcb_record_context_t) as xcb_void_cookie_t

end extern
