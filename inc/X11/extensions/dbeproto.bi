'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   ***************************************************************************
''
''    Copyright (c) 1994, 1995  Hewlett-Packard Company
''
''    Permission is hereby granted, free of charge, to any person obtaining
''    a copy of this software and associated documentation files (the
''    "Software"), to deal in the Software without restriction, including
''    without limitation the rights to use, copy, modify, merge, publish,
''    distribute, sublicense, and/or sell copies of the Software, and to
''    permit persons to whom the Software is furnished to do so, subject to
''    the following conditions:
''
''    The above copyright notice and this permission notice shall be included
''    in all copies or substantial portions of the Software.
''
''    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''    IN NO EVENT SHALL HEWLETT-PACKARD COMPANY BE LIABLE FOR ANY CLAIM,
''    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
''    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
''    THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''    Except as contained in this notice, the name of the Hewlett-Packard
''    Company shall not be used in advertising or otherwise to promote the
''    sale, use or other dealings in this Software without prior written
''    authorization from the Hewlett-Packard Company.
''
''        Header file for Xlib-related DBE
''
''   ***************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/dbe.bi"

'' The following symbols have been renamed:
''     typedef xDbeBackBuffer => xDbeBackBuffer_
''     struct xDbeSwapInfo => xDbeSwapInfo_

#define DBE_PROTO_H
const X_DbeGetVersion = 0
const X_DbeAllocateBackBufferName = 1
const X_DbeDeallocateBackBufferName = 2
const X_DbeSwapBuffers = 3
const X_DbeBeginIdiom = 4
const X_DbeEndIdiom = 5
const X_DbeGetVisualInfo = 6
const X_DbeGetBackBufferAttributes = 7
type xDbeSwapAction as CARD8
type xDbeBackBuffer_ as CARD32

type xDbeSwapInfo_
	window as CARD32
	swapAction as xDbeSwapAction
	pad1 as CARD8
	pad2 as CARD16
end type

type xDbeVisInfo
	visualID as CARD32
	depth as CARD8
	perfLevel as CARD8
	pad1 as CARD16
end type

const sz_xDbeVisInfo = 8

type xDbeScreenVisInfo
	n as CARD32
end type

type xDbeBufferAttributes
	window as CARD32
end type

type xDbeGetVersionReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	majorVersion as CARD8
	minorVersion as CARD8
	unused as CARD16
end type

const sz_xDbeGetVersionReq = 8

type xDbeGetVersionReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD8
	minorVersion as CARD8
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xDbeGetVersionReply = 32

type xDbeAllocateBackBufferNameReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	window as CARD32
	buffer as xDbeBackBuffer_
	swapAction as xDbeSwapAction
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xDbeAllocateBackBufferNameReq = 16

type xDbeDeallocateBackBufferNameReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	buffer as xDbeBackBuffer_
end type

const sz_xDbeDeallocateBackBufferNameReq = 8

type xDbeSwapBuffersReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	n as CARD32
end type

const sz_xDbeSwapBuffersReq = 8

type xDbeBeginIdiomReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
end type

const sz_xDbeBeginIdiomReq = 4

type xDbeEndIdiomReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
end type

const sz_xDbeEndIdiomReq = 4

type xDbeGetVisualInfoReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	n as CARD32
end type

const sz_xDbeGetVisualInfoReq = 8

type xDbeGetVisualInfoReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	m as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDbeGetVisualInfoReply = 32

type xDbeGetBackBufferAttributesReq
	reqType as CARD8
	dbeReqType as CARD8
	length as CARD16
	buffer as xDbeBackBuffer_
end type

const sz_xDbeGetBackBufferAttributesReq = 8

type xDbeGetBackBufferAttributesReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	attributes as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xDbeGetBackBufferAttributesReply = 32
