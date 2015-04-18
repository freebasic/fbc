'' FreeBASIC binding for dri2proto-2.8
''
'' based on the C header files:
''   Copyright © 2008 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Soft-
''   ware"), to deal in the Software without restriction, including without
''   limitation the rights to use, copy, modify, merge, publish, distribute,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, provided that the above copyright
''   notice(s) and this permission notice appear in all copies of the Soft-
''   ware and that both the above copyright notice(s) and this permission
''   notice appear in supporting documentation.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL-
''   ITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY
''   RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN
''   THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSE-
''   QUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFOR-
''   MANCE OF THIS SOFTWARE.
''
''   Except as contained in this notice, the name of a copyright holder shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization of
''   the copyright holder.
''
''   Authors:
''     Kristian Høgsberg (krh@redhat.com)
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _DRI2_PROTO_H_
#define DRI2_NAME "DRI2"
const DRI2_MAJOR = 1
const DRI2_MINOR = 4
const DRI2NumberErrors = 0
const DRI2NumberEvents = 2
const DRI2NumberRequests = 14
const X_DRI2QueryVersion = 0
const X_DRI2Connect = 1
const X_DRI2Authenticate = 2
const X_DRI2CreateDrawable = 3
const X_DRI2DestroyDrawable = 4
const X_DRI2GetBuffers = 5
const X_DRI2CopyRegion = 6
const X_DRI2GetBuffersWithFormat = 7
const X_DRI2SwapBuffers = 8
const X_DRI2GetMSC = 9
const X_DRI2WaitMSC = 10
const X_DRI2WaitSBC = 11
const X_DRI2SwapInterval = 12
const X_DRI2GetParam = 13
const DRI2_BufferSwapComplete = 0
const DRI2_InvalidateBuffers = 1

type xDRI2Buffer
	attachment as CARD32
	name as CARD32
	pitch as CARD32
	cpp as CARD32
	flags as CARD32
end type

type xDRI2QueryVersionReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	majorVersion as CARD32
	minorVersion as CARD32
end type

const sz_xDRI2QueryVersionReq = 12

type xDRI2QueryVersionReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD32
	minorVersion as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDRI2QueryVersionReply = 32

type xDRI2ConnectReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	window as CARD32
	driverType as CARD32
end type

const sz_xDRI2ConnectReq = 12

type xDRI2ConnectReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	driverNameLength as CARD32
	deviceNameLength as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDRI2ConnectReply = 32

type xDRI2AuthenticateReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	window as CARD32
	magic as CARD32
end type

const sz_xDRI2AuthenticateReq = 12

type xDRI2AuthenticateReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	authenticated as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xDRI2AuthenticateReply = 32

type xDRI2CreateDrawableReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
end type

const sz_xDRI2CreateDrawableReq = 8

type xDRI2DestroyDrawableReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
end type

const sz_xDRI2DestroyDrawableReq = 8

type xDRI2GetBuffersReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	count as CARD32
end type

const sz_xDRI2GetBuffersReq = 12

type xDRI2GetBuffersReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	width as CARD32
	height as CARD32
	count as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xDRI2GetBuffersReply = 32

type xDRI2CopyRegionReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	region as CARD32
	dest as CARD32
	src as CARD32
end type

const sz_xDRI2CopyRegionReq = 20

type xDRI2CopyRegionReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xDRI2CopyRegionReply = 32

type xDRI2SwapBuffersReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	target_msc_hi as CARD32
	target_msc_lo as CARD32
	divisor_hi as CARD32
	divisor_lo as CARD32
	remainder_hi as CARD32
	remainder_lo as CARD32
end type

const sz_xDRI2SwapBuffersReq = 32

type xDRI2SwapBuffersReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	swap_hi as CARD32
	swap_lo as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDRI2SwapBuffersReply = 32

type xDRI2GetMSCReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
end type

const sz_xDRI2GetMSCReq = 8

type xDRI2WaitMSCReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	target_msc_hi as CARD32
	target_msc_lo as CARD32
	divisor_hi as CARD32
	divisor_lo as CARD32
	remainder_hi as CARD32
	remainder_lo as CARD32
end type

const sz_xDRI2WaitMSCReq = 32

type xDRI2WaitSBCReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	target_sbc_hi as CARD32
	target_sbc_lo as CARD32
end type

const sz_xDRI2WaitSBCReq = 16

type xDRI2MSCReply
	as CARD8 type
	pad1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	ust_hi as CARD32
	ust_lo as CARD32
	msc_hi as CARD32
	msc_lo as CARD32
	sbc_hi as CARD32
	sbc_lo as CARD32
end type

const sz_xDRI2MSCReply = 32

type xDRI2SwapIntervalReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	interval as CARD32
end type

const sz_xDRI2SwapIntervalReq = 12

type xDRI2BufferSwapComplete
	as CARD8 type
	pad as CARD8
	sequenceNumber as CARD16
	event_type as CARD16
	pad2 as CARD16
	drawable as CARD32
	ust_hi as CARD32
	ust_lo as CARD32
	msc_hi as CARD32
	msc_lo as CARD32
	sbc_hi as CARD32
	sbc_lo as CARD32
end type

const sz_xDRI2BufferSwapComplete = 32

type xDRI2BufferSwapComplete2
	as CARD8 type
	pad as CARD8
	sequenceNumber as CARD16
	event_type as CARD16
	pad2 as CARD16
	drawable as CARD32
	ust_hi as CARD32
	ust_lo as CARD32
	msc_hi as CARD32
	msc_lo as CARD32
	sbc as CARD32
end type

const sz_xDRI2BufferSwapComplete2 = 32

type xDRI2InvalidateBuffers
	as CARD8 type
	pad as CARD8
	sequenceNumber as CARD16
	drawable as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xDRI2InvalidateBuffers = 32

type xDRI2GetParamReq
	reqType as CARD8
	dri2ReqType as CARD8
	length as CARD16
	drawable as CARD32
	param as CARD32
end type

const sz_xDRI2GetParamReq = 12

type xDRI2GetParamReply
	as UBYTE type
	is_param_recognized as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	value_hi as CARD32
	value_lo as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xDRI2GetParamReply = 32
