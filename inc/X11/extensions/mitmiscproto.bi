'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "X11/extensions/mitmiscconst.bi"

#define _MITMISCPROTO_H_
const X_MITSetBugMode = 0
const X_MITGetBugMode = 1

type _SetBugMode
	reqType as CARD8
	mitReqType as CARD8
	length as CARD16
	onOff as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
end type

type xMITSetBugModeReq as _SetBugMode
const sz_xMITSetBugModeReq = 8

type _GetBugMode
	reqType as CARD8
	mitReqType as CARD8
	length as CARD16
end type

type xMITGetBugModeReq as _GetBugMode
const sz_xMITGetBugModeReq = 4

type xMITGetBugModeReply
	as UBYTE type
	onOff as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xMITGetBugModeReply = 32
