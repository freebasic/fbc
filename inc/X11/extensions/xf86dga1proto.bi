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

#include once "X11/extensions/xf86dga1const.bi"

#define _XF86DGAPROTO1_H_

type _XF86DGAQueryVersion
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
end type

type xXF86DGAQueryVersionReq as _XF86DGAQueryVersion
const sz_xXF86DGAQueryVersionReq = 4

type xXF86DGAQueryVersionReply
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

const sz_xXF86DGAQueryVersionReply = 32

type _XF86DGAGetVideoLL
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86DGAGetVideoLLReq as _XF86DGAGetVideoLL
const sz_xXF86DGAGetVideoLLReq = 8

type _XF86DGAInstallColormap
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad2 as CARD16
	id as CARD32
end type

type xXF86DGAInstallColormapReq as _XF86DGAInstallColormap
const sz_xXF86DGAInstallColormapReq = 12

type xXF86DGAGetVideoLLReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	offset as CARD32
	width as CARD32
	bank_size as CARD32
	ram_size as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86DGAGetVideoLLReply = 32

type _XF86DGADirectVideo
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	enable as CARD16
end type

type xXF86DGADirectVideoReq as _XF86DGADirectVideo
const sz_xXF86DGADirectVideoReq = 8

type _XF86DGAGetViewPortSize
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86DGAGetViewPortSizeReq as _XF86DGAGetViewPortSize
const sz_xXF86DGAGetViewPortSizeReq = 8

type xXF86DGAGetViewPortSizeReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	width as CARD32
	height as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86DGAGetViewPortSizeReply = 32

type _XF86DGASetViewPort
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
	x as CARD32
	y as CARD32
end type

type xXF86DGASetViewPortReq as _XF86DGASetViewPort
const sz_xXF86DGASetViewPortReq = 16

type _XF86DGAGetVidPage
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86DGAGetVidPageReq as _XF86DGAGetVidPage
const sz_xXF86DGAGetVidPageReq = 8

type xXF86DGAGetVidPageReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	vpage as CARD32
	pad as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86DGAGetVidPageReply = 32

type _XF86DGASetVidPage
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	vpage as CARD16
end type

type xXF86DGASetVidPageReq as _XF86DGASetVidPage
const sz_xXF86DGASetVidPageReq = 8

type _XF86DGAQueryDirectVideo
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	pad as CARD16
end type

type xXF86DGAQueryDirectVideoReq as _XF86DGAQueryDirectVideo
const sz_xXF86DGAQueryDirectVideoReq = 8

type xXF86DGAQueryDirectVideoReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	flags as CARD32
	pad as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86DGAQueryDirectVideoReply = 32

type _XF86DGAViewPortChanged
	reqType as CARD8
	dgaReqType as CARD8
	length as CARD16
	screen as CARD16
	n as CARD16
end type

type xXF86DGAViewPortChangedReq as _XF86DGAViewPortChanged
const sz_xXF86DGAViewPortChangedReq = 8

type xXF86DGAViewPortChangedReply
	as UBYTE type
	pad1 as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	result as CARD32
	pad as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXF86DGAViewPortChangedReply = 32
