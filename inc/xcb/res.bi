'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2006 Jeremy Kolb
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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_RES_QUERY_VERSION => XCB_RES_QUERY_VERSION_
''     constant XCB_RES_QUERY_CLIENTS => XCB_RES_QUERY_CLIENTS_
''     constant XCB_RES_QUERY_CLIENT_RESOURCES => XCB_RES_QUERY_CLIENT_RESOURCES_
''     constant XCB_RES_QUERY_CLIENT_PIXMAP_BYTES => XCB_RES_QUERY_CLIENT_PIXMAP_BYTES_
''     constant XCB_RES_QUERY_CLIENT_IDS => XCB_RES_QUERY_CLIENT_IDS_
''     constant XCB_RES_QUERY_RESOURCE_BYTES => XCB_RES_QUERY_RESOURCE_BYTES_

extern "C"

#define __RES_H
const XCB_RES_MAJOR_VERSION = 1
const XCB_RES_MINOR_VERSION = 2
extern xcb_res_id as xcb_extension_t

type xcb_res_client_t
	resource_base as ulong
	resource_mask as ulong
end type

type xcb_res_client_iterator_t
	data as xcb_res_client_t ptr
	as long rem
	index as long
end type

type xcb_res_type_t
	resource_type as xcb_atom_t
	count as ulong
end type

type xcb_res_type_iterator_t
	data as xcb_res_type_t ptr
	as long rem
	index as long
end type

type xcb_res_client_id_mask_t as long
enum
	XCB_RES_CLIENT_ID_MASK_CLIENT_XID = 1
	XCB_RES_CLIENT_ID_MASK_LOCAL_CLIENT_PID = 2
end enum

type xcb_res_client_id_spec_t
	client as ulong
	mask as ulong
end type

type xcb_res_client_id_spec_iterator_t
	data as xcb_res_client_id_spec_t ptr
	as long rem
	index as long
end type

type xcb_res_client_id_value_t
	spec as xcb_res_client_id_spec_t
	length as ulong
end type

type xcb_res_client_id_value_iterator_t
	data as xcb_res_client_id_value_t ptr
	as long rem
	index as long
end type

type xcb_res_resource_id_spec_t
	resource as ulong
	as ulong type
end type

type xcb_res_resource_id_spec_iterator_t
	data as xcb_res_resource_id_spec_t ptr
	as long rem
	index as long
end type

type xcb_res_resource_size_spec_t
	spec as xcb_res_resource_id_spec_t
	bytes as ulong
	ref_count as ulong
	use_count as ulong
end type

type xcb_res_resource_size_spec_iterator_t
	data as xcb_res_resource_size_spec_t ptr
	as long rem
	index as long
end type

type xcb_res_resource_size_value_t
	size as xcb_res_resource_size_spec_t
	num_cross_references as ulong
end type

type xcb_res_resource_size_value_iterator_t
	data as xcb_res_resource_size_value_t ptr
	as long rem
	index as long
end type

type xcb_res_query_version_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_VERSION_ = 0

type xcb_res_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major as ubyte
	client_minor as ubyte
end type

type xcb_res_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major as ushort
	server_minor as ushort
end type

type xcb_res_query_clients_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_CLIENTS_ = 1

type xcb_res_query_clients_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_res_query_clients_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_clients as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_res_query_client_resources_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_CLIENT_RESOURCES_ = 2

type xcb_res_query_client_resources_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	xid as ulong
end type

type xcb_res_query_client_resources_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_types as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_res_query_client_pixmap_bytes_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_CLIENT_PIXMAP_BYTES_ = 3

type xcb_res_query_client_pixmap_bytes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	xid as ulong
end type

type xcb_res_query_client_pixmap_bytes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	bytes as ulong
	bytes_overflow as ulong
end type

type xcb_res_query_client_ids_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_CLIENT_IDS_ = 4

type xcb_res_query_client_ids_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	num_specs as ulong
end type

type xcb_res_query_client_ids_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_ids as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_res_query_resource_bytes_cookie_t
	sequence as ulong
end type

const XCB_RES_QUERY_RESOURCE_BYTES_ = 5

type xcb_res_query_resource_bytes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client as ulong
	num_specs as ulong
end type

type xcb_res_query_resource_bytes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_sizes as ulong
	pad1(0 to 19) as ubyte
end type

declare sub xcb_res_client_next(byval i as xcb_res_client_iterator_t ptr)
declare function xcb_res_client_end(byval i as xcb_res_client_iterator_t) as xcb_generic_iterator_t
declare sub xcb_res_type_next(byval i as xcb_res_type_iterator_t ptr)
declare function xcb_res_type_end(byval i as xcb_res_type_iterator_t) as xcb_generic_iterator_t
declare sub xcb_res_client_id_spec_next(byval i as xcb_res_client_id_spec_iterator_t ptr)
declare function xcb_res_client_id_spec_end(byval i as xcb_res_client_id_spec_iterator_t) as xcb_generic_iterator_t
declare function xcb_res_client_id_value_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_client_id_value_value(byval R as const xcb_res_client_id_value_t ptr) as ulong ptr
declare function xcb_res_client_id_value_value_length(byval R as const xcb_res_client_id_value_t ptr) as long
declare function xcb_res_client_id_value_value_end(byval R as const xcb_res_client_id_value_t ptr) as xcb_generic_iterator_t
declare sub xcb_res_client_id_value_next(byval i as xcb_res_client_id_value_iterator_t ptr)
declare function xcb_res_client_id_value_end(byval i as xcb_res_client_id_value_iterator_t) as xcb_generic_iterator_t
declare sub xcb_res_resource_id_spec_next(byval i as xcb_res_resource_id_spec_iterator_t ptr)
declare function xcb_res_resource_id_spec_end(byval i as xcb_res_resource_id_spec_iterator_t) as xcb_generic_iterator_t
declare sub xcb_res_resource_size_spec_next(byval i as xcb_res_resource_size_spec_iterator_t ptr)
declare function xcb_res_resource_size_spec_end(byval i as xcb_res_resource_size_spec_iterator_t) as xcb_generic_iterator_t
declare function xcb_res_resource_size_value_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_resource_size_value_cross_references(byval R as const xcb_res_resource_size_value_t ptr) as xcb_res_resource_size_spec_t ptr
declare function xcb_res_resource_size_value_cross_references_length(byval R as const xcb_res_resource_size_value_t ptr) as long
declare function xcb_res_resource_size_value_cross_references_iterator(byval R as const xcb_res_resource_size_value_t ptr) as xcb_res_resource_size_spec_iterator_t
declare sub xcb_res_resource_size_value_next(byval i as xcb_res_resource_size_value_iterator_t ptr)
declare function xcb_res_resource_size_value_end(byval i as xcb_res_resource_size_value_iterator_t) as xcb_generic_iterator_t
declare function xcb_res_query_version(byval c as xcb_connection_t ptr, byval client_major as ubyte, byval client_minor as ubyte) as xcb_res_query_version_cookie_t
declare function xcb_res_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major as ubyte, byval client_minor as ubyte) as xcb_res_query_version_cookie_t
declare function xcb_res_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_version_reply_t ptr
declare function xcb_res_query_clients_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_query_clients(byval c as xcb_connection_t ptr) as xcb_res_query_clients_cookie_t
declare function xcb_res_query_clients_unchecked(byval c as xcb_connection_t ptr) as xcb_res_query_clients_cookie_t
declare function xcb_res_query_clients_clients(byval R as const xcb_res_query_clients_reply_t ptr) as xcb_res_client_t ptr
declare function xcb_res_query_clients_clients_length(byval R as const xcb_res_query_clients_reply_t ptr) as long
declare function xcb_res_query_clients_clients_iterator(byval R as const xcb_res_query_clients_reply_t ptr) as xcb_res_client_iterator_t
declare function xcb_res_query_clients_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_clients_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_clients_reply_t ptr
declare function xcb_res_query_client_resources_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_query_client_resources(byval c as xcb_connection_t ptr, byval xid as ulong) as xcb_res_query_client_resources_cookie_t
declare function xcb_res_query_client_resources_unchecked(byval c as xcb_connection_t ptr, byval xid as ulong) as xcb_res_query_client_resources_cookie_t
declare function xcb_res_query_client_resources_types(byval R as const xcb_res_query_client_resources_reply_t ptr) as xcb_res_type_t ptr
declare function xcb_res_query_client_resources_types_length(byval R as const xcb_res_query_client_resources_reply_t ptr) as long
declare function xcb_res_query_client_resources_types_iterator(byval R as const xcb_res_query_client_resources_reply_t ptr) as xcb_res_type_iterator_t
declare function xcb_res_query_client_resources_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_client_resources_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_client_resources_reply_t ptr
declare function xcb_res_query_client_pixmap_bytes(byval c as xcb_connection_t ptr, byval xid as ulong) as xcb_res_query_client_pixmap_bytes_cookie_t
declare function xcb_res_query_client_pixmap_bytes_unchecked(byval c as xcb_connection_t ptr, byval xid as ulong) as xcb_res_query_client_pixmap_bytes_cookie_t
declare function xcb_res_query_client_pixmap_bytes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_client_pixmap_bytes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_client_pixmap_bytes_reply_t ptr
declare function xcb_res_query_client_ids_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_query_client_ids(byval c as xcb_connection_t ptr, byval num_specs as ulong, byval specs as const xcb_res_client_id_spec_t ptr) as xcb_res_query_client_ids_cookie_t
declare function xcb_res_query_client_ids_unchecked(byval c as xcb_connection_t ptr, byval num_specs as ulong, byval specs as const xcb_res_client_id_spec_t ptr) as xcb_res_query_client_ids_cookie_t
declare function xcb_res_query_client_ids_ids_length(byval R as const xcb_res_query_client_ids_reply_t ptr) as long
declare function xcb_res_query_client_ids_ids_iterator(byval R as const xcb_res_query_client_ids_reply_t ptr) as xcb_res_client_id_value_iterator_t
declare function xcb_res_query_client_ids_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_client_ids_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_client_ids_reply_t ptr
declare function xcb_res_query_resource_bytes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_res_query_resource_bytes(byval c as xcb_connection_t ptr, byval client as ulong, byval num_specs as ulong, byval specs as const xcb_res_resource_id_spec_t ptr) as xcb_res_query_resource_bytes_cookie_t
declare function xcb_res_query_resource_bytes_unchecked(byval c as xcb_connection_t ptr, byval client as ulong, byval num_specs as ulong, byval specs as const xcb_res_resource_id_spec_t ptr) as xcb_res_query_resource_bytes_cookie_t
declare function xcb_res_query_resource_bytes_sizes_length(byval R as const xcb_res_query_resource_bytes_reply_t ptr) as long
declare function xcb_res_query_resource_bytes_sizes_iterator(byval R as const xcb_res_query_resource_bytes_reply_t ptr) as xcb_res_resource_size_value_iterator_t
declare function xcb_res_query_resource_bytes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_res_query_resource_bytes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_res_query_resource_bytes_reply_t ptr

end extern
