#pragma once

#include once "X11/extensions/xtestext1const.bi"

'' The following symbols have been renamed:
''     struct xTestInputActionEvent => xTestInputActionEvent_
''     struct xTestFakeAckEvent => xTestFakeAckEvent_

const _XTESTEXT1PROTO_H = 1
const X_TestFakeInput = 1
const X_TestGetInput = 2
const X_TestStopInput = 3
const X_TestReset = 4
const X_TestQueryInputSize = 5

type xTestFakeInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
	ack as CARD32
	action_list(0 to 63) as CARD8
end type

#define sz_xTestFakeInputReq (XTestMAX_ACTION_LIST_SIZE + 8)

type xTestGetInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
	mode as CARD32
end type

const sz_xTestGetInputReq = 8

type xTestStopInputReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestStopInputReq = 4

type xTestResetReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestResetReq = 4

type xTestQueryInputSizeReq
	reqType as CARD8
	XTestReqType as CARD8
	length as CARD16
end type

const sz_xTestQueryInputSizeReq = 4

type xTestQueryInputSizeReply
	as CARD8 type
	pad1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	size_return as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xTestInputActionEvent_
	as CARD8 type
	pad00 as CARD8
	sequenceNumber as CARD16
	actions(0 to 27) as CARD8
end type

type xTestFakeAckEvent_
	as CARD8 type
	pad00 as CARD8
	sequenceNumber as CARD16
	pad02 as CARD32
	pad03 as CARD32
	pad04 as CARD32
	pad05 as CARD32
	pad06 as CARD32
	pad07 as CARD32
	pad08 as CARD32
end type

type XTestKeyInfo
	header as CARD8
	keycode as CARD8
	delay_time as CARD16
end type

type XTestJumpInfo
	header as CARD8
	pad1 as CARD8
	jumpx as CARD16
	jumpy as CARD16
	delay_time as CARD16
end type

type XTestMotionInfo
	header as CARD8
	motion_data as CARD8
	delay_time as CARD16
end type

type XTestDelayInfo
	header as CARD8
	pad1 as CARD8
	pad2 as CARD16
	delay_time as CARD32
end type
