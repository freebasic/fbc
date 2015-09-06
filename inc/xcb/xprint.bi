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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_X_PRINT_PRINT_QUERY_VERSION => XCB_X_PRINT_PRINT_QUERY_VERSION_
''     constant XCB_X_PRINT_PRINT_GET_PRINTER_LIST => XCB_X_PRINT_PRINT_GET_PRINTER_LIST_
''     constant XCB_X_PRINT_PRINT_REHASH_PRINTER_LIST => XCB_X_PRINT_PRINT_REHASH_PRINTER_LIST_
''     constant XCB_X_PRINT_CREATE_CONTEXT => XCB_X_PRINT_CREATE_CONTEXT_
''     constant XCB_X_PRINT_PRINT_SET_CONTEXT => XCB_X_PRINT_PRINT_SET_CONTEXT_
''     constant XCB_X_PRINT_PRINT_GET_CONTEXT => XCB_X_PRINT_PRINT_GET_CONTEXT_
''     constant XCB_X_PRINT_PRINT_DESTROY_CONTEXT => XCB_X_PRINT_PRINT_DESTROY_CONTEXT_
''     constant XCB_X_PRINT_PRINT_GET_SCREEN_OF_CONTEXT => XCB_X_PRINT_PRINT_GET_SCREEN_OF_CONTEXT_
''     constant XCB_X_PRINT_PRINT_START_JOB => XCB_X_PRINT_PRINT_START_JOB_
''     constant XCB_X_PRINT_PRINT_END_JOB => XCB_X_PRINT_PRINT_END_JOB_
''     constant XCB_X_PRINT_PRINT_START_DOC => XCB_X_PRINT_PRINT_START_DOC_
''     constant XCB_X_PRINT_PRINT_END_DOC => XCB_X_PRINT_PRINT_END_DOC_
''     constant XCB_X_PRINT_PRINT_PUT_DOCUMENT_DATA => XCB_X_PRINT_PRINT_PUT_DOCUMENT_DATA_
''     constant XCB_X_PRINT_PRINT_GET_DOCUMENT_DATA => XCB_X_PRINT_PRINT_GET_DOCUMENT_DATA_
''     constant XCB_X_PRINT_PRINT_START_PAGE => XCB_X_PRINT_PRINT_START_PAGE_
''     constant XCB_X_PRINT_PRINT_END_PAGE => XCB_X_PRINT_PRINT_END_PAGE_
''     constant XCB_X_PRINT_PRINT_SELECT_INPUT => XCB_X_PRINT_PRINT_SELECT_INPUT_
''     constant XCB_X_PRINT_PRINT_INPUT_SELECTED => XCB_X_PRINT_PRINT_INPUT_SELECTED_
''     constant XCB_X_PRINT_PRINT_GET_ATTRIBUTES => XCB_X_PRINT_PRINT_GET_ATTRIBUTES_
''     constant XCB_X_PRINT_PRINT_GET_ONE_ATTRIBUTES => XCB_X_PRINT_PRINT_GET_ONE_ATTRIBUTES_
''     constant XCB_X_PRINT_PRINT_SET_ATTRIBUTES => XCB_X_PRINT_PRINT_SET_ATTRIBUTES_
''     constant XCB_X_PRINT_PRINT_GET_PAGE_DIMENSIONS => XCB_X_PRINT_PRINT_GET_PAGE_DIMENSIONS_
''     constant XCB_X_PRINT_PRINT_QUERY_SCREENS => XCB_X_PRINT_PRINT_QUERY_SCREENS_
''     constant XCB_X_PRINT_PRINT_SET_IMAGE_RESOLUTION => XCB_X_PRINT_PRINT_SET_IMAGE_RESOLUTION_
''     constant XCB_X_PRINT_PRINT_GET_IMAGE_RESOLUTION => XCB_X_PRINT_PRINT_GET_IMAGE_RESOLUTION_

extern "C"

#define __XPRINT_H
const XCB_XPRINT_MAJOR_VERSION = 1
const XCB_XPRINT_MINOR_VERSION = 0
extern xcb_x_print_id as xcb_extension_t
type xcb_x_print_string8_t as zstring

type xcb_x_print_string8_iterator_t
	data as xcb_x_print_string8_t ptr
	as long rem
	index as long
end type

type xcb_x_print_printer_t
	nameLen as ulong
	descLen as ulong
end type

type xcb_x_print_printer_iterator_t
	data as xcb_x_print_printer_t ptr
	as long rem
	index as long
end type

type xcb_x_print_pcontext_t as ulong

type xcb_x_print_pcontext_iterator_t
	data as xcb_x_print_pcontext_t ptr
	as long rem
	index as long
end type

type xcb_x_print_get_doc_t as long
enum
	XCB_X_PRINT_GET_DOC_FINISHED = 0
	XCB_X_PRINT_GET_DOC_SECOND_CONSUMER = 1
end enum

type xcb_x_print_ev_mask_t as long
enum
	XCB_X_PRINT_EV_MASK_NO_EVENT_MASK = 0
	XCB_X_PRINT_EV_MASK_PRINT_MASK = 1
	XCB_X_PRINT_EV_MASK_ATTRIBUTE_MASK = 2
end enum

type xcb_x_print_detail_t as long
enum
	XCB_X_PRINT_DETAIL_START_JOB_NOTIFY = 1
	XCB_X_PRINT_DETAIL_END_JOB_NOTIFY = 2
	XCB_X_PRINT_DETAIL_START_DOC_NOTIFY = 3
	XCB_X_PRINT_DETAIL_END_DOC_NOTIFY = 4
	XCB_X_PRINT_DETAIL_START_PAGE_NOTIFY = 5
	XCB_X_PRINT_DETAIL_END_PAGE_NOTIFY = 6
end enum

type xcb_x_print_attr_t as long
enum
	XCB_X_PRINT_ATTR_JOB_ATTR = 1
	XCB_X_PRINT_ATTR_DOC_ATTR = 2
	XCB_X_PRINT_ATTR_PAGE_ATTR = 3
	XCB_X_PRINT_ATTR_PRINTER_ATTR = 4
	XCB_X_PRINT_ATTR_SERVER_ATTR = 5
	XCB_X_PRINT_ATTR_MEDIUM_ATTR = 6
	XCB_X_PRINT_ATTR_SPOOLER_ATTR = 7
end enum

type xcb_x_print_print_query_version_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_QUERY_VERSION_ = 0

type xcb_x_print_print_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_x_print_print_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
end type

type xcb_x_print_print_get_printer_list_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_PRINTER_LIST_ = 1

type xcb_x_print_print_get_printer_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	printerNameLen as ulong
	localeLen as ulong
end type

type xcb_x_print_print_get_printer_list_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	listCount as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_X_PRINT_PRINT_REHASH_PRINTER_LIST_ = 20

type xcb_x_print_print_rehash_printer_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

const XCB_X_PRINT_CREATE_CONTEXT_ = 2

type xcb_x_print_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_id as ulong
	printerNameLen as ulong
	localeLen as ulong
end type

const XCB_X_PRINT_PRINT_SET_CONTEXT_ = 3

type xcb_x_print_print_set_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as ulong
end type

type xcb_x_print_print_get_context_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_CONTEXT_ = 4

type xcb_x_print_print_get_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_x_print_print_get_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context as ulong
end type

const XCB_X_PRINT_PRINT_DESTROY_CONTEXT_ = 5

type xcb_x_print_print_destroy_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as ulong
end type

type xcb_x_print_print_get_screen_of_context_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_SCREEN_OF_CONTEXT_ = 6

type xcb_x_print_print_get_screen_of_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_x_print_print_get_screen_of_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
end type

const XCB_X_PRINT_PRINT_START_JOB_ = 7

type xcb_x_print_print_start_job_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output_mode as ubyte
end type

const XCB_X_PRINT_PRINT_END_JOB_ = 8

type xcb_x_print_print_end_job_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cancel as ubyte
end type

const XCB_X_PRINT_PRINT_START_DOC_ = 9

type xcb_x_print_print_start_doc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	driver_mode as ubyte
end type

const XCB_X_PRINT_PRINT_END_DOC_ = 10

type xcb_x_print_print_end_doc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cancel as ubyte
end type

const XCB_X_PRINT_PRINT_PUT_DOCUMENT_DATA_ = 11

type xcb_x_print_print_put_document_data_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	len_data as ulong
	len_fmt as ushort
	len_options as ushort
end type

type xcb_x_print_print_get_document_data_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_DOCUMENT_DATA_ = 12

type xcb_x_print_print_get_document_data_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	max_bytes as ulong
end type

type xcb_x_print_print_get_document_data_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	status_code as ulong
	finished_flag as ulong
	dataLen as ulong
	pad1(0 to 11) as ubyte
end type

const XCB_X_PRINT_PRINT_START_PAGE_ = 13

type xcb_x_print_print_start_page_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_X_PRINT_PRINT_END_PAGE_ = 14

type xcb_x_print_print_end_page_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cancel as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_X_PRINT_PRINT_SELECT_INPUT_ = 15

type xcb_x_print_print_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	event_mask as ulong
end type

type xcb_x_print_print_input_selected_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_INPUT_SELECTED_ = 16

type xcb_x_print_print_input_selected_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
end type

type xcb_x_print_print_input_selected_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	event_mask as ulong
	all_events_mask as ulong
end type

type xcb_x_print_print_get_attributes_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_ATTRIBUTES_ = 17

type xcb_x_print_print_get_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	pool as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_x_print_print_get_attributes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	stringLen as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_x_print_print_get_one_attributes_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_ONE_ATTRIBUTES_ = 19

type xcb_x_print_print_get_one_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	nameLen as ulong
	pool as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_x_print_print_get_one_attributes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	valueLen as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_X_PRINT_PRINT_SET_ATTRIBUTES_ = 18

type xcb_x_print_print_set_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	stringLen as ulong
	pool as ubyte
	rule as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_x_print_print_get_page_dimensions_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_PAGE_DIMENSIONS_ = 21

type xcb_x_print_print_get_page_dimensions_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
end type

type xcb_x_print_print_get_page_dimensions_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width as ushort
	height as ushort
	offset_x as ushort
	offset_y as ushort
	reproducible_width as ushort
	reproducible_height as ushort
end type

type xcb_x_print_print_query_screens_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_QUERY_SCREENS_ = 22

type xcb_x_print_print_query_screens_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_x_print_print_query_screens_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	listCount as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_x_print_print_set_image_resolution_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_SET_IMAGE_RESOLUTION_ = 23

type xcb_x_print_print_set_image_resolution_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
	image_resolution as ushort
end type

type xcb_x_print_print_set_image_resolution_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	previous_resolutions as ushort
end type

type xcb_x_print_print_get_image_resolution_cookie_t
	sequence as ulong
end type

const XCB_X_PRINT_PRINT_GET_IMAGE_RESOLUTION_ = 24

type xcb_x_print_print_get_image_resolution_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_x_print_pcontext_t
end type

type xcb_x_print_print_get_image_resolution_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	image_resolution as ushort
end type

const XCB_X_PRINT_NOTIFY = 0

type xcb_x_print_notify_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	context as xcb_x_print_pcontext_t
	cancel as ubyte
end type

const XCB_X_PRINT_ATTRIBUT_NOTIFY = 1

type xcb_x_print_attribut_notify_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	context as xcb_x_print_pcontext_t
end type

const XCB_X_PRINT_BAD_CONTEXT = 0

type xcb_x_print_bad_context_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_X_PRINT_BAD_SEQUENCE = 1

type xcb_x_print_bad_sequence_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

declare sub xcb_x_print_string8_next(byval i as xcb_x_print_string8_iterator_t ptr)
declare function xcb_x_print_string8_end(byval i as xcb_x_print_string8_iterator_t) as xcb_generic_iterator_t
declare function xcb_x_print_printer_serialize(byval _buffer as any ptr ptr, byval _aux as const xcb_x_print_printer_t ptr, byval name as const xcb_x_print_string8_t ptr, byval description as const xcb_x_print_string8_t ptr) as long
declare function xcb_x_print_printer_unserialize(byval _buffer as const any ptr, byval _aux as xcb_x_print_printer_t ptr ptr) as long
declare function xcb_x_print_printer_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_printer_name(byval R as const xcb_x_print_printer_t ptr) as xcb_x_print_string8_t ptr
declare function xcb_x_print_printer_name_length(byval R as const xcb_x_print_printer_t ptr) as long
declare function xcb_x_print_printer_name_end(byval R as const xcb_x_print_printer_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_printer_description(byval R as const xcb_x_print_printer_t ptr) as xcb_x_print_string8_t ptr
declare function xcb_x_print_printer_description_length(byval R as const xcb_x_print_printer_t ptr) as long
declare function xcb_x_print_printer_description_end(byval R as const xcb_x_print_printer_t ptr) as xcb_generic_iterator_t
declare sub xcb_x_print_printer_next(byval i as xcb_x_print_printer_iterator_t ptr)
declare function xcb_x_print_printer_end(byval i as xcb_x_print_printer_iterator_t) as xcb_generic_iterator_t
declare sub xcb_x_print_pcontext_next(byval i as xcb_x_print_pcontext_iterator_t ptr)
declare function xcb_x_print_pcontext_end(byval i as xcb_x_print_pcontext_iterator_t) as xcb_generic_iterator_t
declare function xcb_x_print_print_query_version(byval c as xcb_connection_t ptr) as xcb_x_print_print_query_version_cookie_t
declare function xcb_x_print_print_query_version_unchecked(byval c as xcb_connection_t ptr) as xcb_x_print_print_query_version_cookie_t
declare function xcb_x_print_print_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_query_version_reply_t ptr
declare function xcb_x_print_print_get_printer_list_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_get_printer_list(byval c as xcb_connection_t ptr, byval printerNameLen as ulong, byval localeLen as ulong, byval printer_name as const xcb_x_print_string8_t ptr, byval locale as const xcb_x_print_string8_t ptr) as xcb_x_print_print_get_printer_list_cookie_t
declare function xcb_x_print_print_get_printer_list_unchecked(byval c as xcb_connection_t ptr, byval printerNameLen as ulong, byval localeLen as ulong, byval printer_name as const xcb_x_print_string8_t ptr, byval locale as const xcb_x_print_string8_t ptr) as xcb_x_print_print_get_printer_list_cookie_t
declare function xcb_x_print_print_get_printer_list_printers_length(byval R as const xcb_x_print_print_get_printer_list_reply_t ptr) as long
declare function xcb_x_print_print_get_printer_list_printers_iterator(byval R as const xcb_x_print_print_get_printer_list_reply_t ptr) as xcb_x_print_printer_iterator_t
declare function xcb_x_print_print_get_printer_list_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_printer_list_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_printer_list_reply_t ptr
declare function xcb_x_print_print_rehash_printer_list_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_rehash_printer_list(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_create_context_checked(byval c as xcb_connection_t ptr, byval context_id as ulong, byval printerNameLen as ulong, byval localeLen as ulong, byval printerName as const xcb_x_print_string8_t ptr, byval locale as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_create_context(byval c as xcb_connection_t ptr, byval context_id as ulong, byval printerNameLen as ulong, byval localeLen as ulong, byval printerName as const xcb_x_print_string8_t ptr, byval locale as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_set_context_checked(byval c as xcb_connection_t ptr, byval context as ulong) as xcb_void_cookie_t
declare function xcb_x_print_print_set_context(byval c as xcb_connection_t ptr, byval context as ulong) as xcb_void_cookie_t
declare function xcb_x_print_print_get_context(byval c as xcb_connection_t ptr) as xcb_x_print_print_get_context_cookie_t
declare function xcb_x_print_print_get_context_unchecked(byval c as xcb_connection_t ptr) as xcb_x_print_print_get_context_cookie_t
declare function xcb_x_print_print_get_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_context_reply_t ptr
declare function xcb_x_print_print_destroy_context_checked(byval c as xcb_connection_t ptr, byval context as ulong) as xcb_void_cookie_t
declare function xcb_x_print_print_destroy_context(byval c as xcb_connection_t ptr, byval context as ulong) as xcb_void_cookie_t
declare function xcb_x_print_print_get_screen_of_context(byval c as xcb_connection_t ptr) as xcb_x_print_print_get_screen_of_context_cookie_t
declare function xcb_x_print_print_get_screen_of_context_unchecked(byval c as xcb_connection_t ptr) as xcb_x_print_print_get_screen_of_context_cookie_t
declare function xcb_x_print_print_get_screen_of_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_screen_of_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_screen_of_context_reply_t ptr
declare function xcb_x_print_print_start_job_checked(byval c as xcb_connection_t ptr, byval output_mode as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_start_job(byval c as xcb_connection_t ptr, byval output_mode as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_end_job_checked(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_end_job(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_start_doc_checked(byval c as xcb_connection_t ptr, byval driver_mode as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_start_doc(byval c as xcb_connection_t ptr, byval driver_mode as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_end_doc_checked(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_end_doc(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_put_document_data_sizeof(byval _buffer as const any ptr, byval doc_format_len as ulong, byval options_len as ulong) as long
declare function xcb_x_print_print_put_document_data_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval len_data as ulong, byval len_fmt as ushort, byval len_options as ushort, byval data as const ubyte ptr, byval doc_format_len as ulong, byval doc_format as const xcb_x_print_string8_t ptr, byval options_len as ulong, byval options as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_put_document_data(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval len_data as ulong, byval len_fmt as ushort, byval len_options as ushort, byval data as const ubyte ptr, byval doc_format_len as ulong, byval doc_format as const xcb_x_print_string8_t ptr, byval options_len as ulong, byval options as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_get_document_data_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_get_document_data(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval max_bytes as ulong) as xcb_x_print_print_get_document_data_cookie_t
declare function xcb_x_print_print_get_document_data_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval max_bytes as ulong) as xcb_x_print_print_get_document_data_cookie_t
declare function xcb_x_print_print_get_document_data_data(byval R as const xcb_x_print_print_get_document_data_reply_t ptr) as ubyte ptr
declare function xcb_x_print_print_get_document_data_data_length(byval R as const xcb_x_print_print_get_document_data_reply_t ptr) as long
declare function xcb_x_print_print_get_document_data_data_end(byval R as const xcb_x_print_print_get_document_data_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_get_document_data_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_document_data_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_document_data_reply_t ptr
declare function xcb_x_print_print_start_page_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_x_print_print_start_page(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_x_print_print_end_page_checked(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_end_page(byval c as xcb_connection_t ptr, byval cancel as ubyte) as xcb_void_cookie_t
declare function xcb_x_print_print_select_input_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_select_input_checked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval event_mask as ulong, byval event_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_select_input(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval event_mask as ulong, byval event_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_input_selected_serialize(byval _buffer as any ptr ptr, byval _aux as const xcb_x_print_print_input_selected_reply_t ptr, byval event_list as const ulong ptr, byval all_events_list as const ulong ptr) as long
declare function xcb_x_print_print_input_selected_unserialize(byval _buffer as const any ptr, byval _aux as xcb_x_print_print_input_selected_reply_t ptr ptr) as long
declare function xcb_x_print_print_input_selected_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_input_selected(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_input_selected_cookie_t
declare function xcb_x_print_print_input_selected_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_input_selected_cookie_t
declare function xcb_x_print_print_input_selected_event_list(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as ulong ptr
declare function xcb_x_print_print_input_selected_event_list_length(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as long
declare function xcb_x_print_print_input_selected_event_list_end(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_input_selected_all_events_list(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as ulong ptr
declare function xcb_x_print_print_input_selected_all_events_list_length(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as long
declare function xcb_x_print_print_input_selected_all_events_list_end(byval R as const xcb_x_print_print_input_selected_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_input_selected_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_input_selected_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_input_selected_reply_t ptr
declare function xcb_x_print_print_get_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_get_attributes(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval pool as ubyte) as xcb_x_print_print_get_attributes_cookie_t
declare function xcb_x_print_print_get_attributes_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval pool as ubyte) as xcb_x_print_print_get_attributes_cookie_t
declare function xcb_x_print_print_get_attributes_attributes(byval R as const xcb_x_print_print_get_attributes_reply_t ptr) as xcb_x_print_string8_t ptr
declare function xcb_x_print_print_get_attributes_attributes_length(byval R as const xcb_x_print_print_get_attributes_reply_t ptr) as long
declare function xcb_x_print_print_get_attributes_attributes_end(byval R as const xcb_x_print_print_get_attributes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_get_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_attributes_reply_t ptr
declare function xcb_x_print_print_get_one_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_get_one_attributes(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval nameLen as ulong, byval pool as ubyte, byval name as const xcb_x_print_string8_t ptr) as xcb_x_print_print_get_one_attributes_cookie_t
declare function xcb_x_print_print_get_one_attributes_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval nameLen as ulong, byval pool as ubyte, byval name as const xcb_x_print_string8_t ptr) as xcb_x_print_print_get_one_attributes_cookie_t
declare function xcb_x_print_print_get_one_attributes_value(byval R as const xcb_x_print_print_get_one_attributes_reply_t ptr) as xcb_x_print_string8_t ptr
declare function xcb_x_print_print_get_one_attributes_value_length(byval R as const xcb_x_print_print_get_one_attributes_reply_t ptr) as long
declare function xcb_x_print_print_get_one_attributes_value_end(byval R as const xcb_x_print_print_get_one_attributes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_get_one_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_one_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_one_attributes_reply_t ptr
declare function xcb_x_print_print_set_attributes_sizeof(byval _buffer as const any ptr, byval attributes_len as ulong) as long
declare function xcb_x_print_print_set_attributes_checked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval stringLen as ulong, byval pool as ubyte, byval rule as ubyte, byval attributes_len as ulong, byval attributes as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_set_attributes(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval stringLen as ulong, byval pool as ubyte, byval rule as ubyte, byval attributes_len as ulong, byval attributes as const xcb_x_print_string8_t ptr) as xcb_void_cookie_t
declare function xcb_x_print_print_get_page_dimensions(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_get_page_dimensions_cookie_t
declare function xcb_x_print_print_get_page_dimensions_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_get_page_dimensions_cookie_t
declare function xcb_x_print_print_get_page_dimensions_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_page_dimensions_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_page_dimensions_reply_t ptr
declare function xcb_x_print_print_query_screens_sizeof(byval _buffer as const any ptr) as long
declare function xcb_x_print_print_query_screens(byval c as xcb_connection_t ptr) as xcb_x_print_print_query_screens_cookie_t
declare function xcb_x_print_print_query_screens_unchecked(byval c as xcb_connection_t ptr) as xcb_x_print_print_query_screens_cookie_t
declare function xcb_x_print_print_query_screens_roots(byval R as const xcb_x_print_print_query_screens_reply_t ptr) as xcb_window_t ptr
declare function xcb_x_print_print_query_screens_roots_length(byval R as const xcb_x_print_print_query_screens_reply_t ptr) as long
declare function xcb_x_print_print_query_screens_roots_end(byval R as const xcb_x_print_print_query_screens_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_x_print_print_query_screens_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_query_screens_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_query_screens_reply_t ptr
declare function xcb_x_print_print_set_image_resolution(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval image_resolution as ushort) as xcb_x_print_print_set_image_resolution_cookie_t
declare function xcb_x_print_print_set_image_resolution_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t, byval image_resolution as ushort) as xcb_x_print_print_set_image_resolution_cookie_t
declare function xcb_x_print_print_set_image_resolution_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_set_image_resolution_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_set_image_resolution_reply_t ptr
declare function xcb_x_print_print_get_image_resolution(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_get_image_resolution_cookie_t
declare function xcb_x_print_print_get_image_resolution_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_x_print_pcontext_t) as xcb_x_print_print_get_image_resolution_cookie_t
declare function xcb_x_print_print_get_image_resolution_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_x_print_print_get_image_resolution_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_x_print_print_get_image_resolution_reply_t ptr

end extern
