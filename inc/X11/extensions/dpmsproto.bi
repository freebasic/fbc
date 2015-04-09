'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "X11/extensions/dpmsconst.bi"

#define _DPMSPROTO_H_
const X_DPMSGetVersion = 0
const X_DPMSCapable = 1
const X_DPMSGetTimeouts = 2
const X_DPMSSetTimeouts = 3
const X_DPMSEnable = 4
const X_DPMSDisable = 5
const X_DPMSForceLevel = 6
const X_DPMSInfo = 7
const DPMSNumberEvents = 0
const DPMSNumberErrors = 0

type xDPMSGetVersionReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
	majorVersion as CARD16
	minorVersion as CARD16
end type

const sz_xDPMSGetVersionReq = 8

type xDPMSGetVersionReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDPMSGetVersionReply = 32

type xDPMSCapableReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
end type

const sz_xDPMSCapableReq = 4

type xDPMSCapableReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	capable as XBOOL
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xDPMSCapableReply = 32

type xDPMSGetTimeoutsReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
end type

const sz_xDPMSGetTimeoutsReq = 4

type xDPMSGetTimeoutsReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	standby as CARD16
	suspend as CARD16
	off as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDPMSGetTimeoutsReply = 32

type xDPMSSetTimeoutsReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
	standby as CARD16
	suspend as CARD16
	off as CARD16
	pad0 as CARD16
end type

const sz_xDPMSSetTimeoutsReq = 12

type xDPMSEnableReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
end type

const sz_xDPMSEnableReq = 4

type xDPMSDisableReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
end type

const sz_xDPMSDisableReq = 4

type xDPMSForceLevelReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
	level as CARD16
	pad0 as CARD16
end type

const sz_xDPMSForceLevelReq = 8

type xDPMSInfoReq
	reqType as CARD8
	dpmsReqType as CARD8
	length as CARD16
end type

const sz_xDPMSInfoReq = 4

type xDPMSInfoReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	power_level as CARD16
	state as XBOOL
	pad1 as CARD8
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xDPMSInfoReply = 32
