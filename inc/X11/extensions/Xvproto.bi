'' FreeBASIC binding for videoproto-2.3.2
''
'' based on the C header files:
''   *********************************************************
''   Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts,
''   and the Massachusetts Institute of Technology, Cambridge, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the names of Digital or MIT not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"

'' The following symbols have been renamed:
''     struct xvRational => xvRational_
''     struct xvAdaptorInfo => xvAdaptorInfo_
''     struct xvEncodingInfo => xvEncodingInfo_
''     struct xvFormat => xvFormat_
''     struct xvEvent => xvEvent_

#define XVPROTO_H

type xvRational_
	numerator as INT32
	denominator as INT32
end type

const sz_xvRational = 8

type xvAdaptorInfo_
	base_id as CARD32
	name_size as CARD16
	num_ports as CARD16
	num_formats as CARD16
	as CARD8 type
	pad as CARD8
end type

const sz_xvAdaptorInfo = 12

type xvEncodingInfo_
	encoding as CARD32
	name_size as CARD16
	width as CARD16
	height as CARD16
	pad as CARD16
	rate as xvRational_
end type

const sz_xvEncodingInfo = 12 + sz_xvRational

type xvFormat_
	visual as CARD32
	depth as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xvFormat = 8

type xvAttributeInfo
	flags as CARD32
	min as INT32
	max as INT32
	size as CARD32
end type

const sz_xvAttributeInfo = 16

type xvImageFormatInfo
	id as CARD32
	as CARD8 type
	byte_order as CARD8
	pad1 as CARD16
	guid(0 to 15) as CARD8
	bpp as CARD8
	num_planes as CARD8
	pad2 as CARD16
	depth as CARD8
	pad3 as CARD8
	pad4 as CARD16
	red_mask as CARD32
	green_mask as CARD32
	blue_mask as CARD32
	format as CARD8
	pad5 as CARD8
	pad6 as CARD16
	y_sample_bits as CARD32
	u_sample_bits as CARD32
	v_sample_bits as CARD32
	horz_y_period as CARD32
	horz_u_period as CARD32
	horz_v_period as CARD32
	vert_y_period as CARD32
	vert_u_period as CARD32
	vert_v_period as CARD32
	comp_order(0 to 31) as CARD8
	scanline_order as CARD8
	pad7 as CARD8
	pad8 as CARD16
	pad9 as CARD32
	pad10 as CARD32
end type

const sz_xvImageFormatInfo = 128
const xv_QueryExtension = 0
const xv_QueryAdaptors = 1
const xv_QueryEncodings = 2
const xv_GrabPort = 3
const xv_UngrabPort = 4
const xv_PutVideo = 5
const xv_PutStill = 6
const xv_GetVideo = 7
const xv_GetStill = 8
const xv_StopVideo = 9
const xv_SelectVideoNotify = 10
const xv_SelectPortNotify = 11
const xv_QueryBestSize = 12
const xv_SetPortAttribute = 13
const xv_GetPortAttribute = 14
const xv_QueryPortAttributes = 15
const xv_ListImageFormats = 16
const xv_QueryImageAttributes = 17
const xv_PutImage = 18
const xv_ShmPutImage = 19
const xv_LastRequest = xv_ShmPutImage
const xvNumRequests = xv_LastRequest + 1

type xvQueryExtensionReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
end type

const sz_xvQueryExtensionReq = 4

type xvQueryAdaptorsReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xvQueryAdaptorsReq = 8

type xvQueryEncodingsReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
end type

const sz_xvQueryEncodingsReq = 8

type xvPutVideoReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	vid_x as INT16
	vid_y as INT16
	vid_w as CARD16
	vid_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
end type

const sz_xvPutVideoReq = 32

type xvPutStillReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	vid_x as INT16
	vid_y as INT16
	vid_w as CARD16
	vid_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
end type

const sz_xvPutStillReq = 32

type xvGetVideoReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	vid_x as INT16
	vid_y as INT16
	vid_w as CARD16
	vid_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
end type

const sz_xvGetVideoReq = 32

type xvGetStillReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	vid_x as INT16
	vid_y as INT16
	vid_w as CARD16
	vid_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
end type

const sz_xvGetStillReq = 32

type xvGrabPortReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	time as CARD32
end type

const sz_xvGrabPortReq = 12

type xvUngrabPortReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	time as CARD32
end type

const sz_xvUngrabPortReq = 12

type xvSelectVideoNotifyReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	drawable as CARD32
	onoff as XBOOL
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xvSelectVideoNotifyReq = 12

type xvSelectPortNotifyReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	onoff as XBOOL
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xvSelectPortNotifyReq = 12

type xvStopVideoReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
end type

const sz_xvStopVideoReq = 12

type xvSetPortAttributeReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	attribute as CARD32
	value as INT32
end type

const sz_xvSetPortAttributeReq = 16

type xvGetPortAttributeReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	attribute as CARD32
end type

const sz_xvGetPortAttributeReq = 12

type xvQueryBestSizeReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	vid_w as CARD16
	vid_h as CARD16
	drw_w as CARD16
	drw_h as CARD16
	motion as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xvQueryBestSizeReq = 20

type xvQueryPortAttributesReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
end type

const sz_xvQueryPortAttributesReq = 8

type xvPutImageReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	id as CARD32
	src_x as INT16
	src_y as INT16
	src_w as CARD16
	src_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
	width as CARD16
	height as CARD16
end type

const sz_xvPutImageReq = 40

type xvShmPutImageReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	drawable as CARD32
	gc as CARD32
	shmseg as CARD32
	id as CARD32
	offset as CARD32
	src_x as INT16
	src_y as INT16
	src_w as CARD16
	src_h as CARD16
	drw_x as INT16
	drw_y as INT16
	drw_w as CARD16
	drw_h as CARD16
	width as CARD16
	height as CARD16
	send_event as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xvShmPutImageReq = 52

type xvListImageFormatsReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
end type

const sz_xvListImageFormatsReq = 8

type xvQueryImageAttributesReq
	reqType as CARD8
	xvReqType as CARD8
	length as CARD16
	port as CARD32
	id as CARD32
	width as CARD16
	height as CARD16
end type

const sz_xvQueryImageAttributesReq = 16

type _QueryExtensionReply
	as UBYTE type
	padb1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	version as CARD16
	revision as CARD16
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

type xvQueryExtensionReply as _QueryExtensionReply
const sz_xvQueryExtensionReply = 32

type _QueryAdaptorsReply
	as UBYTE type
	padb1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	num_adaptors as CARD16
	pads3 as CARD16
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

type xvQueryAdaptorsReply as _QueryAdaptorsReply
const sz_xvQueryAdaptorsReply = 32

type _QueryEncodingsReply
	as UBYTE type
	padb1 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	num_encodings as CARD16
	padl3 as CARD16
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

type xvQueryEncodingsReply as _QueryEncodingsReply
const sz_xvQueryEncodingsReply = 32

type xvGrabPortReply
	as UBYTE type
	result as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	padl3 as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvGrabPortReply = 32

type xvGetPortAttributeReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	value as INT32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvGetPortAttributeReply = 32

type xvQueryBestSizeReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	actual_width as CARD16
	actual_height as CARD16
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvQueryBestSizeReply = 32

type xvQueryPortAttributesReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	num_attributes as CARD32
	text_size as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvQueryPortAttributesReply = 32

type xvListImageFormatsReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	num_formats as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvListImageFormatsReply = 32

type xvQueryImageAttributesReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	num_planes as CARD32
	data_size as CARD32
	width as CARD16
	height as CARD16
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

const sz_xvQueryImageAttributesReply = 32

type xvEvent_u_u
	as UBYTE type
	detail as UBYTE
	sequenceNumber as CARD16
end type

type xvEvent_u_videoNotify
	as UBYTE type
	reason as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	drawable as CARD32
	port as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

type xvEvent_u_portNotify
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	port as CARD32
	attribute as CARD32
	value as INT32
	padl6 as CARD32
	padl7 as CARD32
	padl8 as CARD32
end type

union xvEvent_u
	u as xvEvent_u_u
	videoNotify as xvEvent_u_videoNotify
	portNotify as xvEvent_u_portNotify
end union

type xvEvent_
	u as xvEvent_u
end type
