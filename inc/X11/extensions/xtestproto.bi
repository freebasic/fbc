'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "X11/extensions/xtestconst.bi"

#define _XTESTPROTO_H_
const X_XTestGetVersion = 0
const X_XTestCompareCursor = 1
const X_XTestFakeInput = 2
const X_XTestGrabControl = 3

type xXTestGetVersionReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	majorVersion as CARD8
	pad as CARD8
	minorVersion as CARD16
end type

const sz_xXTestGetVersionReq = 8

type xXTestGetVersionReply
	as UBYTE type
	majorVersion as CARD8
	sequenceNumber as CARD16
	length as CARD32
	minorVersion as CARD16
	pad0 as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXTestGetVersionReply = 32

type xXTestCompareCursorReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	window as CARD32
	cursor as CARD32
end type

const sz_xXTestCompareCursorReq = 12

type xXTestCompareCursorReply
	as UBYTE type
	same as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXTestCompareCursorReply = 32

type xXTestFakeInputReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	as UBYTE type
	detail as UBYTE
	pad0 as CARD16
	time as CARD32
	root as CARD32
	pad1 as CARD32
	pad2 as CARD32
	rootX as INT16
	rootY as INT16
	pad3 as CARD32
	pad4 as CARD16
	pad5 as CARD8
	deviceid as CARD8
end type

const sz_xXTestFakeInputReq = 36

type xXTestGrabControlReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	impervious as XBOOL
	pad0 as CARD8
	pad1 as CARD8
	pad2 as CARD8
end type

const sz_xXTestGrabControlReq = 8
