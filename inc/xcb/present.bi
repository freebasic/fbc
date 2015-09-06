'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright © 2013 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting documentation, and
''   that the name of the copyright holders not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  The copyright holders make no representations
''   about the suitability of this software for any purpose.  It is provided "as
''   is" without express or implied warranty.
''
''   THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
''   OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xproto.bi"
#include once "randr.bi"
#include once "xfixes.bi"
#include once "sync.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_PRESENT_QUERY_VERSION => XCB_PRESENT_QUERY_VERSION_
''     constant XCB_PRESENT_PIXMAP => XCB_PRESENT_PIXMAP_
''     constant XCB_PRESENT_NOTIFY_MSC => XCB_PRESENT_NOTIFY_MSC_
''     constant XCB_PRESENT_SELECT_INPUT => XCB_PRESENT_SELECT_INPUT_
''     constant XCB_PRESENT_QUERY_CAPABILITIES => XCB_PRESENT_QUERY_CAPABILITIES_

extern "C"

#define __PRESENT_H
const XCB_PRESENT_MAJOR_VERSION = 1
const XCB_PRESENT_MINOR_VERSION = 0
extern xcb_present_id as xcb_extension_t

type xcb_present_event_enum_t as long
enum
	XCB_PRESENT_EVENT_CONFIGURE_NOTIFY = 0
	XCB_PRESENT_EVENT_COMPLETE_NOTIFY = 1
	XCB_PRESENT_EVENT_IDLE_NOTIFY = 2
	XCB_PRESENT_EVENT_REDIRECT_NOTIFY = 3
end enum

type xcb_present_event_mask_t as long
enum
	XCB_PRESENT_EVENT_MASK_NO_EVENT = 0
	XCB_PRESENT_EVENT_MASK_CONFIGURE_NOTIFY = 1
	XCB_PRESENT_EVENT_MASK_COMPLETE_NOTIFY = 2
	XCB_PRESENT_EVENT_MASK_IDLE_NOTIFY = 4
	XCB_PRESENT_EVENT_MASK_REDIRECT_NOTIFY = 8
end enum

type xcb_present_option_t as long
enum
	XCB_PRESENT_OPTION_NONE = 0
	XCB_PRESENT_OPTION_ASYNC = 1
	XCB_PRESENT_OPTION_COPY = 2
	XCB_PRESENT_OPTION_UST = 4
end enum

type xcb_present_capability_t as long
enum
	XCB_PRESENT_CAPABILITY_NONE = 0
	XCB_PRESENT_CAPABILITY_ASYNC = 1
	XCB_PRESENT_CAPABILITY_FENCE = 2
	XCB_PRESENT_CAPABILITY_UST = 4
end enum

type xcb_present_complete_kind_t as long
enum
	XCB_PRESENT_COMPLETE_KIND_PIXMAP = 0
	XCB_PRESENT_COMPLETE_KIND_NOTIFY_MSC = 1
end enum

type xcb_present_complete_mode_t as long
enum
	XCB_PRESENT_COMPLETE_MODE_COPY = 0
	XCB_PRESENT_COMPLETE_MODE_FLIP = 1
	XCB_PRESENT_COMPLETE_MODE_SKIP = 2
end enum

type xcb_present_notify_t
	window as xcb_window_t
	serial as ulong
end type

type xcb_present_notify_iterator_t
	data as xcb_present_notify_t ptr
	as long rem
	index as long
end type

type xcb_present_query_version_cookie_t
	sequence as ulong
end type

const XCB_PRESENT_QUERY_VERSION_ = 0

type xcb_present_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
end type

type xcb_present_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
end type

const XCB_PRESENT_PIXMAP_ = 1

type xcb_present_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	pixmap as xcb_pixmap_t
	serial as ulong
	valid as xcb_xfixes_region_t
	update as xcb_xfixes_region_t
	x_off as short
	y_off as short
	target_crtc as xcb_randr_crtc_t
	wait_fence as xcb_sync_fence_t
	idle_fence as xcb_sync_fence_t
	options as ulong
	pad0(0 to 3) as ubyte
	target_msc as ulongint
	divisor as ulongint
	remainder as ulongint
end type

const XCB_PRESENT_NOTIFY_MSC_ = 2

type xcb_present_notify_msc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	serial as ulong
	pad0(0 to 3) as ubyte
	target_msc as ulongint
	divisor as ulongint
	remainder as ulongint
end type

type xcb_present_event_t as ulong

type xcb_present_event_iterator_t
	data as xcb_present_event_t ptr
	as long rem
	index as long
end type

const XCB_PRESENT_SELECT_INPUT_ = 3

type xcb_present_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	eid as xcb_present_event_t
	window as xcb_window_t
	event_mask as ulong
end type

type xcb_present_query_capabilities_cookie_t
	sequence as ulong
end type

const XCB_PRESENT_QUERY_CAPABILITIES_ = 4

type xcb_present_query_capabilities_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	target as ulong
end type

type xcb_present_query_capabilities_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	capabilities as ulong
end type

const XCB_PRESENT_GENERIC = 0

type xcb_present_generic_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	evtype as ushort
	pad0(0 to 1) as ubyte
	event as xcb_present_event_t
end type

const XCB_PRESENT_CONFIGURE_NOTIFY = 0

type xcb_present_configure_notify_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	pad0(0 to 1) as ubyte
	event as xcb_present_event_t
	window as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	off_x as short
	off_y as short
	full_sequence as ulong
	pixmap_width as ushort
	pixmap_height as ushort
	pixmap_flags as ulong
end type

const XCB_PRESENT_COMPLETE_NOTIFY = 1

type xcb_present_complete_notify_event_t field = 1
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	kind as ubyte
	mode as ubyte
	event as xcb_present_event_t
	window as xcb_window_t
	serial as ulong
	ust as ulongint
	full_sequence as ulong
	msc as ulongint
end type

const XCB_PRESENT_IDLE_NOTIFY = 2

type xcb_present_idle_notify_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	pad0(0 to 1) as ubyte
	event as xcb_present_event_t
	window as xcb_window_t
	serial as ulong
	pixmap as xcb_pixmap_t
	idle_fence as xcb_sync_fence_t
	full_sequence as ulong
end type

const XCB_PRESENT_REDIRECT_NOTIFY = 3

type xcb_present_redirect_notify_event_t field = 1
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	update_window as ubyte
	pad0 as ubyte
	event as xcb_present_event_t
	event_window as xcb_window_t
	window as xcb_window_t
	pixmap as xcb_pixmap_t
	serial as ulong
	full_sequence as ulong
	valid_region as xcb_xfixes_region_t
	update_region as xcb_xfixes_region_t
	valid_rect as xcb_rectangle_t
	update_rect as xcb_rectangle_t
	x_off as short
	y_off as short
	target_crtc as xcb_randr_crtc_t
	wait_fence as xcb_sync_fence_t
	idle_fence as xcb_sync_fence_t
	options as ulong
	pad1(0 to 3) as ubyte
	target_msc as ulongint
	divisor as ulongint
	remainder as ulongint
end type

declare sub xcb_present_notify_next(byval i as xcb_present_notify_iterator_t ptr)
declare function xcb_present_notify_end(byval i as xcb_present_notify_iterator_t) as xcb_generic_iterator_t
declare function xcb_present_query_version(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_present_query_version_cookie_t
declare function xcb_present_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_present_query_version_cookie_t
declare function xcb_present_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_present_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_present_query_version_reply_t ptr
declare function xcb_present_pixmap_sizeof(byval _buffer as const any ptr, byval notifies_len as ulong) as long
declare function xcb_present_pixmap_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval pixmap as xcb_pixmap_t, byval serial as ulong, byval valid as xcb_xfixes_region_t, byval update as xcb_xfixes_region_t, byval x_off as short, byval y_off as short, byval target_crtc as xcb_randr_crtc_t, byval wait_fence as xcb_sync_fence_t, byval idle_fence as xcb_sync_fence_t, byval options as ulong, byval target_msc as ulongint, byval divisor as ulongint, byval remainder as ulongint, byval notifies_len as ulong, byval notifies as const xcb_present_notify_t ptr) as xcb_void_cookie_t
declare function xcb_present_pixmap(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval pixmap as xcb_pixmap_t, byval serial as ulong, byval valid as xcb_xfixes_region_t, byval update as xcb_xfixes_region_t, byval x_off as short, byval y_off as short, byval target_crtc as xcb_randr_crtc_t, byval wait_fence as xcb_sync_fence_t, byval idle_fence as xcb_sync_fence_t, byval options as ulong, byval target_msc as ulongint, byval divisor as ulongint, byval remainder as ulongint, byval notifies_len as ulong, byval notifies as const xcb_present_notify_t ptr) as xcb_void_cookie_t
declare function xcb_present_notify_msc_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval serial as ulong, byval target_msc as ulongint, byval divisor as ulongint, byval remainder as ulongint) as xcb_void_cookie_t
declare function xcb_present_notify_msc(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval serial as ulong, byval target_msc as ulongint, byval divisor as ulongint, byval remainder as ulongint) as xcb_void_cookie_t
declare sub xcb_present_event_next(byval i as xcb_present_event_iterator_t ptr)
declare function xcb_present_event_end(byval i as xcb_present_event_iterator_t) as xcb_generic_iterator_t
declare function xcb_present_select_input_checked(byval c as xcb_connection_t ptr, byval eid as xcb_present_event_t, byval window as xcb_window_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_present_select_input(byval c as xcb_connection_t ptr, byval eid as xcb_present_event_t, byval window as xcb_window_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_present_query_capabilities(byval c as xcb_connection_t ptr, byval target as ulong) as xcb_present_query_capabilities_cookie_t
declare function xcb_present_query_capabilities_unchecked(byval c as xcb_connection_t ptr, byval target as ulong) as xcb_present_query_capabilities_cookie_t
declare function xcb_present_query_capabilities_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_present_query_capabilities_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_present_query_capabilities_reply_t ptr
declare function xcb_present_redirect_notify_sizeof(byval _buffer as const any ptr, byval notifies_len as ulong) as long

end extern
