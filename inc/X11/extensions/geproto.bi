'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "X11/Xproto.bi"
#include once "X11/X.bi"
#include once "X11/extensions/ge.bi"

#define _GEPROTO_H_
const X_GEGetExtensionVersion = 1

type xGEReq
	reqType as CARD8
	ReqType_ as CARD8
	length as CARD16
end type

type xGEQueryVersionReq
	reqType as CARD8
	ReqType_ as CARD8
	length as CARD16
	majorVersion as CARD16
	minorVersion as CARD16
end type

const sz_xGEQueryVersionReq = 8

type xGEQueryVersionReply
	repType as CARD8
	RepType_ as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad00 as CARD32
	pad01 as CARD32
	pad02 as CARD32
	pad03 as CARD32
	pad04 as CARD32
end type

const sz_xGEQueryVersionReply = 32
