'' FreeBASIC binding for inputproto-2.3.1
''
'' based on the C header files:
''   Copyright © 2009 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xproto.bi"
#include once "X11/X.bi"
#include once "X11/extensions/XI2.bi"
#include once "crt/stdint.bi"

#define _XI2PROTO_H_
const X_XIQueryPointer = 40
const X_XIWarpPointer = 41
const X_XIChangeCursor = 42
const X_XIChangeHierarchy = 43
const X_XISetClientPointer = 44
const X_XIGetClientPointer = 45
const X_XISelectEvents = 46
const X_XIQueryVersion = 47
const X_XIQueryDevice = 48
const X_XISetFocus = 49
const X_XIGetFocus = 50
const X_XIGrabDevice = 51
const X_XIUngrabDevice = 52
const X_XIAllowEvents = 53
const X_XIPassiveGrabDevice = 54
const X_XIPassiveUngrabDevice = 55
const X_XIListProperties = 56
const X_XIChangeProperty = 57
const X_XIDeleteProperty = 58
const X_XIGetProperty = 59
const X_XIGetSelectedEvents = 60
const X_XIBarrierReleasePointer = 61
const XI2REQUESTS = (X_XIBarrierReleasePointer - X_XIQueryPointer) + 1
const XI2EVENTS = XI_LASTEVENT + 1
type FP1616 as long

type FP3232
	integral as long
	frac as ulong
end type

type xXIDeviceInfo
	deviceid as ushort
	use as ushort
	attachment as ushort
	num_classes as ushort
	name_len as ushort
	enabled as ubyte
	pad as ubyte
end type

type xXIAnyInfo
	as ushort type
	length as ushort
	sourceid as ushort
	pad as ushort
end type

type xXIButtonInfo
	as ushort type
	length as ushort
	sourceid as ushort
	num_buttons as ushort
end type

type xXIKeyInfo
	as ushort type
	length as ushort
	sourceid as ushort
	num_keycodes as ushort
end type

type xXIValuatorInfo
	as ushort type
	length as ushort
	sourceid as ushort
	number as ushort
	label as ulong
	min as FP3232
	max as FP3232
	value as FP3232
	resolution as ulong
	mode as ubyte
	pad1 as ubyte
	pad2 as ushort
end type

type xXIScrollInfo
	as ushort type
	length as ushort
	sourceid as ushort
	number as ushort
	scroll_type as ushort
	pad0 as ushort
	flags as ulong
	increment as FP3232
end type

type xXITouchInfo
	as ushort type
	length as ushort
	sourceid as ushort
	mode as ubyte
	num_touches as ubyte
end type

type xXIEventMask
	deviceid as ushort
	mask_len as ushort
end type

type xXIModifierInfo
	base_mods as ulong
	latched_mods as ulong
	locked_mods as ulong
	effective_mods as ulong
end type

type xXIGroupInfo
	base_group as ubyte
	latched_group as ubyte
	locked_group as ubyte
	effective_group as ubyte
end type

type xXIQueryVersionReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	major_version as ushort
	minor_version as ushort
end type

const sz_xXIQueryVersionReq = 8

type xXIQueryVersionReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIQueryVersionReply = 32

type xXIQueryDeviceReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	pad as ushort
end type

const sz_xXIQueryDeviceReq = 8

type xXIQueryDeviceReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	num_devices as ushort
	pad0 as ushort
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIQueryDeviceReply = 32

type xXISelectEventsReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
	num_masks as ushort
	pad as ushort
end type

const sz_xXISelectEventsReq = 12

type xXIGetSelectedEventsReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
end type

const sz_xXIGetSelectedEventsReq = 8

type xXIGetSelectedEventsReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	num_masks as ushort
	pad0 as ushort
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIGetSelectedEventsReply = 32

type xXIQueryPointerReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
	deviceid as ushort
	pad1 as ushort
end type

const sz_xXIQueryPointerReq = 12

type xXIQueryPointerReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	root as ulong
	child as ulong
	root_x as FP1616
	root_y as FP1616
	win_x as FP1616
	win_y as FP1616
	same_screen as ubyte
	pad0 as ubyte
	buttons_len as ushort
	mods as xXIModifierInfo
	group as xXIGroupInfo
end type

const sz_xXIQueryPointerReply = 56

type xXIWarpPointerReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	src_win as ulong
	dst_win as ulong
	src_x as FP1616
	src_y as FP1616
	src_width as ushort
	src_height as ushort
	dst_x as FP1616
	dst_y as FP1616
	deviceid as ushort
	pad1 as ushort
end type

const sz_xXIWarpPointerReq = 36

type xXIChangeCursorReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
	cursor as ulong
	deviceid as ushort
	pad1 as ushort
end type

const sz_xXIChangeCursorReq = 16

type xXIChangeHierarchyReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	num_changes as ubyte
	pad0 as ubyte
	pad1 as ushort
end type

const sz_xXIChangeHierarchyReq = 8

type xXIAnyHierarchyChangeInfo
	as ushort type
	length as ushort
end type

type xXIAddMasterInfo
	as ushort type
	length as ushort
	name_len as ushort
	send_core as ubyte
	enable as ubyte
end type

type xXIRemoveMasterInfo
	as ushort type
	length as ushort
	deviceid as ushort
	return_mode as ubyte
	pad as ubyte
	return_pointer as ushort
	return_keyboard as ushort
end type

type xXIAttachSlaveInfo
	as ushort type
	length as ushort
	deviceid as ushort
	new_master as ushort
end type

type xXIDetachSlaveInfo
	as ushort type
	length as ushort
	deviceid as ushort
	pad as ushort
end type

type xXISetClientPointerReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
	deviceid as ushort
	pad1 as ushort
end type

const sz_xXISetClientPointerReq = 12

type xXIGetClientPointerReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	win as ulong
end type

const sz_xXIGetClientPointerReq = 8

type xXIGetClientPointerReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	set as XBOOL
	pad0 as ubyte
	deviceid as ushort
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIGetClientPointerReply = 32

type xXISetFocusReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	focus as ulong
	time as ulong
	deviceid as ushort
	pad0 as ushort
end type

const sz_xXISetFocusReq = 16

type xXIGetFocusReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	pad0 as ushort
end type

const sz_xXIGetFocusReq = 8

type xXIGetFocusReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	focus as ulong
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIGetFocusReply = 32

type xXIGrabDeviceReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	grab_window as ulong
	time as ulong
	cursor as ulong
	deviceid as ushort
	grab_mode as ubyte
	paired_device_mode as ubyte
	owner_events as ubyte
	pad as ubyte
	mask_len as ushort
end type

const sz_xXIGrabDeviceReq = 24

type xXIGrabModifierInfo
	modifiers as ulong
	status as ubyte
	pad0 as ubyte
	pad1 as ushort
end type

type xXIGrabDeviceReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	status as ubyte
	pad0 as ubyte
	pad1 as ushort
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
	pad6 as ulong
end type

const sz_xXIGrabDeviceReply = 32

type xXIUngrabDeviceReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	time as ulong
	deviceid as ushort
	pad as ushort
end type

const sz_xXIUngrabDeviceReq = 12

type xXIAllowEventsReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	time as ulong
	deviceid as ushort
	mode as ubyte
	pad as ubyte
end type

const sz_xXIAllowEventsReq = 12

type xXI2_2AllowEventsReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	time as ulong
	deviceid as ushort
	mode as ubyte
	pad as ubyte
	touchid as ulong
	grab_window as ulong
end type

const sz_xXI2_2AllowEventsReq = 20

type xXIPassiveGrabDeviceReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	time as ulong
	grab_window as ulong
	cursor as ulong
	detail as ulong
	deviceid as ushort
	num_modifiers as ushort
	mask_len as ushort
	grab_type as ubyte
	grab_mode as ubyte
	paired_device_mode as ubyte
	owner_events as ubyte
	pad1 as ushort
end type

const sz_xXIPassiveGrabDeviceReq = 32

type xXIPassiveGrabDeviceReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	num_modifiers as ushort
	pad1 as ushort
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
	pad6 as ulong
end type

const sz_xXIPassiveGrabDeviceReply = 32

type xXIPassiveUngrabDeviceReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	grab_window as ulong
	detail as ulong
	deviceid as ushort
	num_modifiers as ushort
	grab_type as ubyte
	pad0 as ubyte
	pad1 as ushort
end type

const sz_xXIPassiveUngrabDeviceReq = 20

type xXIListPropertiesReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	pad as ushort
end type

const sz_xXIListPropertiesReq = 8

type xXIListPropertiesReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	num_properties as ushort
	pad0 as ushort
	pad1 as ulong
	pad2 as ulong
	pad3 as ulong
	pad4 as ulong
	pad5 as ulong
end type

const sz_xXIListPropertiesReply = 32

type xXIChangePropertyReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	mode as ubyte
	format as ubyte
	property as ulong
	as ulong type
	num_items as ulong
end type

const sz_xXIChangePropertyReq = 20

type xXIDeletePropertyReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	pad0 as ushort
	property as ulong
end type

const sz_xXIDeletePropertyReq = 12

type xXIGetPropertyReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	deviceid as ushort
	delete_ as ubyte
	pad0 as ubyte
	property as ulong
	as ulong type
	offset as ulong
	len as ulong
end type

const sz_xXIGetPropertyReq = 24

type xXIGetPropertyReply
	repType as ubyte
	RepType_ as ubyte
	sequenceNumber as ushort
	length as ulong
	as ulong type
	bytes_after as ulong
	num_items as ulong
	format as ubyte
	pad0 as ubyte
	pad1 as ushort
	pad2 as ulong
	pad3 as ulong
end type

const sz_xXIGetPropertyReply = 32

type xXIBarrierReleasePointerInfo
	deviceid as ushort
	pad as ushort
	barrier as ulong
	eventid as ulong
end type

type xXIBarrierReleasePointerReq
	reqType as ubyte
	ReqType_ as ubyte
	length as ushort
	num_barriers as ulong
end type

const sz_xXIBarrierReleasePointerReq = 8

type xXIGenericDeviceEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
end type

type xXIHierarchyInfo
	deviceid as ushort
	attachment as ushort
	use as ubyte
	enabled as XBOOL
	pad as ushort
	flags as ulong
end type

type xXIHierarchyEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	flags as ulong
	num_info as ushort
	pad0 as ushort
	pad1 as ulong
	pad2 as ulong
end type

type xXIDeviceChangedEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	num_classes as ushort
	sourceid as ushort
	reason as ubyte
	pad0 as ubyte
	pad1 as ushort
	pad2 as ulong
	pad3 as ulong
end type

type xXITouchOwnershipEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	touchid as ulong
	root as ulong
	event as ulong
	child as ulong
	sourceid as ushort
	pad0 as ushort
	flags as ulong
	pad1 as ulong
	pad2 as ulong
end type

type xXIDeviceEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	detail as ulong
	root as ulong
	event as ulong
	child as ulong
	root_x as FP1616
	root_y as FP1616
	event_x as FP1616
	event_y as FP1616
	buttons_len as ushort
	valuators_len as ushort
	sourceid as ushort
	pad0 as ushort
	flags as ulong
	mods as xXIModifierInfo
	group as xXIGroupInfo
end type

type xXIRawEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	detail as ulong
	sourceid as ushort
	valuators_len as ushort
	flags as ulong
	pad2 as ulong
end type

type xXIEnterEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	sourceid as ushort
	mode as ubyte
	detail as ubyte
	root as ulong
	event as ulong
	child as ulong
	root_x as FP1616
	root_y as FP1616
	event_x as FP1616
	event_y as FP1616
	same_screen as XBOOL
	focus as XBOOL
	buttons_len as ushort
	mods as xXIModifierInfo
	group as xXIGroupInfo
end type

type xXILeaveEvent as xXIEnterEvent
type xXIFocusInEvent as xXIEnterEvent
type xXIFocusOutEvent as xXIEnterEvent

type xXIPropertyEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	property as ulong
	what as ubyte
	pad0 as ubyte
	pad1 as ushort
	pad2 as ulong
	pad3 as ulong
end type

type xXIBarrierEvent
	as ubyte type
	extension as ubyte
	sequenceNumber as ushort
	length as ulong
	evtype as ushort
	deviceid as ushort
	time as ulong
	eventid as ulong
	root as ulong
	event as ulong
	barrier as ulong
	dtime as ulong
	flags as ulong
	sourceid as ushort
	pad as short
	root_x as FP1616
	root_y as FP1616
	dx as FP3232
	dy as FP3232
end type

type xXIBarrierHitEvent as xXIBarrierEvent
type xXIBarrierPointerReleasedEvent as xXIBarrierEvent
type xXIBarrierLeaveEvent as xXIBarrierEvent
