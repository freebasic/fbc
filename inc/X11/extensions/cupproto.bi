'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "X11/extensions/cup.bi"

#define _XCUPPROTO_H_
const X_XcupQueryVersion = 0
const X_XcupGetReservedColormapEntries = 1
const X_XcupStoreColors = 2

type _XcupQueryVersion
	reqType as CARD8
	xcupReqType as CARD8
	length as CARD16
	client_major_version as CARD16
	client_minor_version as CARD16
end type

type xXcupQueryVersionReq as _XcupQueryVersion
const sz_xXcupQueryVersionReq = 8

type xXcupQueryVersionReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	server_major_version as CARD16
	server_minor_version as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXcupQueryVersionReply = 32

type _XcupGetReservedColormapEntries
	reqType as CARD8
	xcupReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXcupGetReservedColormapEntriesReq as _XcupGetReservedColormapEntries
const sz_xXcupGetReservedColormapEntriesReq = 8

type xXcupGetReservedColormapEntriesReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xXcupGetReservedColormapEntriesReply = 32

type _XcupStoreColors
	reqType as CARD8
	xcupReqType as CARD8
	length as CARD16
	cmap as CARD32
end type

type xXcupStoreColorsReq as _XcupStoreColors
const sz_xXcupStoreColorsReq = 8

type xXcupStoreColorsReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xXcupStoreColorsReply = 32
