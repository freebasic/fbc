'' FreeBASIC binding for xf86dgaproto-2.1
''
'' based on the C header files:
''
''   Copyright (c) 1995  Jon Tombs
''   Copyright (c) 1995  XFree86 Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
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
''   XFREE86 PROJECT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of the XFree86 Project shall not
''   be used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from the XFree86 Project.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/xf86dga1proto.bi"
#include once "X11/extensions/xf86dgaconst.bi"

#define _XF86DGAPROTO_H_
#define XF86DGANAME "XFree86-DGA"
const XDGA_MAJOR_VERSION = 2
const XDGA_MINOR_VERSION = 0

type _XDGAQueryVersion
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
end type

type xXDGAQueryVersionReq as _XDGAQueryVersion
const sz_xXDGAQueryVersionReq = 4

type xXDGAQueryVersionReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXDGAQueryVersionReply = 32

type _XDGAQueryModes
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXDGAQueryModesReq as _XDGAQueryModes
const sz_xXDGAQueryModesReq = 8

type xXDGAQueryModesReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	number as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXDGAQueryModesReply = 32

type _XDGASetMode
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	mode as CARD32
	pid as CARD32
end type

type xXDGASetModeReq as _XDGASetMode
const sz_xXDGASetModeReq = 16

type xXDGASetModeReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	offset as CARD32
	flags as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXDGASetModeReply = 32

type xXDGAModeInfo
	byte_order as CARD8
	depth as CARD8
	num as CARD16
	bpp as CARD16
	name_size as CARD16
	vsync_num as CARD32
	vsync_den as CARD32
	flags as CARD32
	image_width as CARD16
	image_height as CARD16
	pixmap_width as CARD16
	pixmap_height as CARD16
	bytes_per_scanline as CARD32
	red_mask as CARD32
	green_mask as CARD32
	blue_mask as CARD32
	visual_class as CARD16
	pad1 as CARD16
	viewport_width as CARD16
	viewport_height as CARD16
	viewport_xstep as CARD16
	viewport_ystep as CARD16
	viewport_xmax as CARD16
	viewport_ymax as CARD16
	viewport_flags as CARD32
	reserved1 as CARD32
	reserved2 as CARD32
end type

const sz_xXDGAModeInfo = 72

type _XDGAOpenFramebuffer
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXDGAOpenFramebufferReq as _XDGAOpenFramebuffer
const sz_xXDGAOpenFramebufferReq = 8

type xXDGAOpenFramebufferReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	mem1 as CARD32
	mem2 as CARD32
	size as CARD32
	offset as CARD32
	extra as CARD32
	pad2 as CARD32
end type

const sz_xXDGAOpenFramebufferReply = 32

type _XDGACloseFramebuffer
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXDGACloseFramebufferReq as _XDGACloseFramebuffer
const sz_xXDGACloseFramebufferReq = 8

type _XDGASetViewport
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	x as CARD16
	y as CARD16
	flags as CARD32
end type

type xXDGASetViewportReq as _XDGASetViewport
const sz_xXDGASetViewportReq = 16

type _XDGAInstallColormap
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	cmap as CARD32
end type

type xXDGAInstallColormapReq as _XDGAInstallColormap
const sz_xXDGAInstallColormapReq = 12

type _XDGASelectInput
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	mask as CARD32
end type

type xXDGASelectInputReq as _XDGASelectInput
const sz_xXDGASelectInputReq = 12

type _XDGAFillRectangle
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	x as CARD16
	y as CARD16
	width as CARD16
	height as CARD16
	color as CARD32
end type

type xXDGAFillRectangleReq as _XDGAFillRectangle
const sz_xXDGAFillRectangleReq = 20

type _XDGACopyArea
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	srcx as CARD16
	srcy as CARD16
	width as CARD16
	height as CARD16
	dstx as CARD16
	dsty as CARD16
end type

type xXDGACopyAreaReq as _XDGACopyArea
const sz_xXDGACopyAreaReq = 20

type _XDGACopyTransparentArea
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	srcx as CARD16
	srcy as CARD16
	width as CARD16
	height as CARD16
	dstx as CARD16
	dsty as CARD16
	key as CARD32
end type

type xXDGACopyTransparentAreaReq as _XDGACopyTransparentArea
const sz_xXDGACopyTransparentAreaReq = 24

type _XDGAGetViewportStatus
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXDGAGetViewportStatusReq as _XDGAGetViewportStatus
const sz_xXDGAGetViewportStatusReq = 8

type xXDGAGetViewportStatusReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	status as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXDGAGetViewportStatusReply = 32

type _XDGASync
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
end type

type xXDGASyncReq as _XDGASync
const sz_xXDGASyncReq = 8

type xXDGASyncReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xXDGASyncReply = 32

type _XDGASetClientVersion
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	major as CARD16
	minor as CARD16
end type

type xXDGASetClientVersionReq as _XDGASetClientVersion
const sz_xXDGASetClientVersionReq = 8

type xXDGAChangePixmapModeReq
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	x as CARD16
	y as CARD16
	flags as CARD32
end type

const sz_xXDGAChangePixmapModeReq = 16

type xXDGAChangePixmapModeReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	x as CARD16
	y as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xXDGAChangePixmapModeReply = 32

type _XDGACreateColormap
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD32
	id as CARD32
	mode as CARD32
	alloc as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

type xXDGACreateColormapReq as _XDGACreateColormap
const sz_xXDGACreateColormapReq = 20

type dgaEvent_u_u
	as UBYTE type
	detail as UBYTE
	sequenceNumber as CARD16
end type

type dgaEvent_u_event
	pad0 as CARD32
	time as CARD32
	dx as INT16
	dy as INT16
	screen as INT16
	state as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

union dgaEvent_u
	u as dgaEvent_u_u
	event as dgaEvent_u_event
end union

type dgaEvent
	u as dgaEvent_u
end type
