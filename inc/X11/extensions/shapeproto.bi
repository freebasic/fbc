'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/shapeconst.bi"

#define _SHAPEPROTO_H_
const X_ShapeQueryVersion = 0
const X_ShapeRectangles = 1
const X_ShapeMask = 2
const X_ShapeCombine = 3
const X_ShapeOffset = 4
const X_ShapeQueryExtents = 5
const X_ShapeSelectInput = 6
const X_ShapeInputSelected = 7
const X_ShapeGetRectangles = 8

type _ShapeQueryVersion
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
end type

type xShapeQueryVersionReq as _ShapeQueryVersion
const sz_xShapeQueryVersionReq = 4

type xShapeQueryVersionReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xShapeQueryVersionReply = 32

type _ShapeRectangles
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	op as CARD8
	destKind as CARD8
	ordering as CARD8
	pad0 as CARD8
	dest as CARD32
	xOff as INT16
	yOff as INT16
end type

type xShapeRectanglesReq as _ShapeRectangles
const sz_xShapeRectanglesReq = 16

type _ShapeMask
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	op as CARD8
	destKind as CARD8
	junk as CARD16
	dest as CARD32
	xOff as INT16
	yOff as INT16
	src as CARD32
end type

type xShapeMaskReq as _ShapeMask
const sz_xShapeMaskReq = 20

type _ShapeCombine
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	op as CARD8
	destKind as CARD8
	srcKind as CARD8
	junk as CARD8
	dest as CARD32
	xOff as INT16
	yOff as INT16
	src as CARD32
end type

type xShapeCombineReq as _ShapeCombine
const sz_xShapeCombineReq = 20

type _ShapeOffset
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	destKind as CARD8
	junk1 as CARD8
	junk2 as CARD16
	dest as CARD32
	xOff as INT16
	yOff as INT16
end type

type xShapeOffsetReq as _ShapeOffset
const sz_xShapeOffsetReq = 16

type _ShapeQueryExtents
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	window as CARD32
end type

type xShapeQueryExtentsReq as _ShapeQueryExtents
const sz_xShapeQueryExtentsReq = 8

type xShapeQueryExtentsReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	boundingShaped as CARD8
	clipShaped as CARD8
	unused1 as CARD16
	xBoundingShape as INT16
	yBoundingShape as INT16
	widthBoundingShape as CARD16
	heightBoundingShape as CARD16
	xClipShape as INT16
	yClipShape as INT16
	widthClipShape as CARD16
	heightClipShape as CARD16
	pad1 as CARD32
end type

const sz_xShapeQueryExtentsReply = 32

type _ShapeSelectInput
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	window as CARD32
	enable as UBYTE
	pad1 as UBYTE
	pad2 as CARD16
end type

type xShapeSelectInputReq as _ShapeSelectInput
const sz_xShapeSelectInputReq = 12

type _ShapeNotify
	as UBYTE type
	kind as UBYTE
	sequenceNumber as CARD16
	window as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	time as CARD32
	shaped as UBYTE
	pad0 as UBYTE
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
end type

type xShapeNotifyEvent as _ShapeNotify
const sz_xShapeNotifyEvent = 32

type _ShapeInputSelected
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	window as CARD32
end type

type xShapeInputSelectedReq as _ShapeInputSelected
const sz_xShapeInputSelectedReq = 8

type xShapeInputSelectedReply
	as UBYTE type
	enabled as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xShapeInputSelectedReply = 32

type _ShapeGetRectangles
	reqType as CARD8
	shapeReqType as CARD8
	length as CARD16
	window as CARD32
	kind as CARD8
	junk1 as CARD8
	junk2 as CARD16
end type

type xShapeGetRectanglesReq as _ShapeGetRectangles
const sz_xShapeGetRectanglesReq = 12

type xShapeGetRectanglesReply
	as UBYTE type
	ordering as CARD8
	sequenceNumber as CARD16
	length as CARD32
	nrects as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xShapeGetRectanglesReply = 32
