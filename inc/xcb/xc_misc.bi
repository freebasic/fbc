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
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XC_MISC_GET_VERSION => XCB_XC_MISC_GET_VERSION_
''     constant XCB_XC_MISC_GET_XID_RANGE => XCB_XC_MISC_GET_XID_RANGE_
''     constant XCB_XC_MISC_GET_XID_LIST => XCB_XC_MISC_GET_XID_LIST_

extern "C"

#define __XC_MISC_H
const XCB_XCMISC_MAJOR_VERSION = 1
const XCB_XCMISC_MINOR_VERSION = 1
extern xcb_xc_misc_id as xcb_extension_t

type xcb_xc_misc_get_version_cookie_t
	sequence as ulong
end type

const XCB_XC_MISC_GET_VERSION_ = 0

type xcb_xc_misc_get_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ushort
	client_minor_version as ushort
end type

type xcb_xc_misc_get_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major_version as ushort
	server_minor_version as ushort
end type

type xcb_xc_misc_get_xid_range_cookie_t
	sequence as ulong
end type

const XCB_XC_MISC_GET_XID_RANGE_ = 1

type xcb_xc_misc_get_xid_range_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xc_misc_get_xid_range_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	start_id as ulong
	count as ulong
end type

type xcb_xc_misc_get_xid_list_cookie_t
	sequence as ulong
end type

const XCB_XC_MISC_GET_XID_LIST_ = 2

type xcb_xc_misc_get_xid_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	count as ulong
end type

type xcb_xc_misc_get_xid_list_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ids_len as ulong
	pad1(0 to 19) as ubyte
end type

declare function xcb_xc_misc_get_version(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_xc_misc_get_version_cookie_t
declare function xcb_xc_misc_get_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_xc_misc_get_version_cookie_t
declare function xcb_xc_misc_get_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xc_misc_get_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xc_misc_get_version_reply_t ptr
declare function xcb_xc_misc_get_xid_range(byval c as xcb_connection_t ptr) as xcb_xc_misc_get_xid_range_cookie_t
declare function xcb_xc_misc_get_xid_range_unchecked(byval c as xcb_connection_t ptr) as xcb_xc_misc_get_xid_range_cookie_t
declare function xcb_xc_misc_get_xid_range_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xc_misc_get_xid_range_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xc_misc_get_xid_range_reply_t ptr
declare function xcb_xc_misc_get_xid_list_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xc_misc_get_xid_list(byval c as xcb_connection_t ptr, byval count as ulong) as xcb_xc_misc_get_xid_list_cookie_t
declare function xcb_xc_misc_get_xid_list_unchecked(byval c as xcb_connection_t ptr, byval count as ulong) as xcb_xc_misc_get_xid_list_cookie_t
declare function xcb_xc_misc_get_xid_list_ids(byval R as const xcb_xc_misc_get_xid_list_reply_t ptr) as ulong ptr
declare function xcb_xc_misc_get_xid_list_ids_length(byval R as const xcb_xc_misc_get_xid_list_reply_t ptr) as long
declare function xcb_xc_misc_get_xid_list_ids_end(byval R as const xcb_xc_misc_get_xid_list_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xc_misc_get_xid_list_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xc_misc_get_xid_list_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xc_misc_get_xid_list_reply_t ptr

end extern
