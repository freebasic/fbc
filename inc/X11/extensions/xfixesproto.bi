'' FreeBASIC binding for fixesproto-5.0
''
'' based on the C header files:
''   Copyright (c) 2006, Oracle and/or its affiliates. All rights reserved.
''   Copyright 2010 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"
#include once "X11/extensions/xfixeswire.bi"
#include once "X11/extensions/shapeconst.bi"

#define _XFIXESPROTO_H_

type xXFixesReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
end type

type xXFixesQueryVersionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	majorVersion as CARD32
	minorVersion as CARD32
end type

const sz_xXFixesQueryVersionReq = 12

type xXFixesQueryVersionReply
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

const sz_xXFixesQueryVersionReply = 32

type xXFixesChangeSaveSetReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	mode as UBYTE
	target as UBYTE
	map as UBYTE
	pad1 as UBYTE
	window as CARD32
end type

const sz_xXFixesChangeSaveSetReq = 12

type xXFixesSelectSelectionInputReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	window as CARD32
	selection as CARD32
	eventMask as CARD32
end type

const sz_xXFixesSelectSelectionInputReq = 16

type xXFixesSelectionNotifyEvent
	as CARD8 type
	subtype as CARD8
	sequenceNumber as CARD16
	window as CARD32
	owner as CARD32
	selection as CARD32
	timestamp as CARD32
	selectionTimestamp as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xXFixesSelectCursorInputReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	window as CARD32
	eventMask as CARD32
end type

const sz_xXFixesSelectCursorInputReq = 12

type xXFixesCursorNotifyEvent
	as CARD8 type
	subtype as CARD8
	sequenceNumber as CARD16
	window as CARD32
	cursorSerial as CARD32
	timestamp as CARD32
	name as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xXFixesGetCursorImageReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
end type

const sz_xXFixesGetCursorImageReq = 4

type xXFixesGetCursorImageReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	xhot as CARD16
	yhot as CARD16
	cursorSerial as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

const sz_xXFixesGetCursorImageReply = 32

type xXFixesCreateRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
end type

const sz_xXFixesCreateRegionReq = 8

type xXFixesCreateRegionFromBitmapReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
	bitmap as CARD32
end type

const sz_xXFixesCreateRegionFromBitmapReq = 12

type xXFixesCreateRegionFromWindowReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
	window as CARD32
	kind as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xXFixesCreateRegionFromWindowReq = 16

type xXFixesCreateRegionFromGCReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
	gc as CARD32
end type

const sz_xXFixesCreateRegionFromGCReq = 12

type xXFixesCreateRegionFromPictureReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
	picture as CARD32
end type

const sz_xXFixesCreateRegionFromPictureReq = 12

type xXFixesDestroyRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
end type

const sz_xXFixesDestroyRegionReq = 8

type xXFixesSetRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
end type

const sz_xXFixesSetRegionReq = 8

type xXFixesCopyRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	destination as CARD32
end type

const sz_xXFixesCopyRegionReq = 12

type xXFixesCombineRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source1 as CARD32
	source2 as CARD32
	destination as CARD32
end type

type xXFixesUnionRegionReq as xXFixesCombineRegionReq
type xXFixesIntersectRegionReq as xXFixesCombineRegionReq
type xXFixesSubtractRegionReq as xXFixesCombineRegionReq

const sz_xXFixesCombineRegionReq = 16
const sz_xXFixesUnionRegionReq = sz_xXFixesCombineRegionReq
const sz_xXFixesIntersectRegionReq = sz_xXFixesCombineRegionReq
const sz_xXFixesSubtractRegionReq = sz_xXFixesCombineRegionReq

type xXFixesInvertRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	destination as CARD32
end type

const sz_xXFixesInvertRegionReq = 20

type xXFixesTranslateRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
	dx as INT16
	dy as INT16
end type

const sz_xXFixesTranslateRegionReq = 12

type xXFixesRegionExtentsReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	destination as CARD32
end type

const sz_xXFixesRegionExtentsReq = 12

type xXFixesFetchRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	region as CARD32
end type

const sz_xXFixesFetchRegionReq = 8

type xXFixesFetchRegionReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXFixesFetchRegionReply = 32

type xXFixesSetGCClipRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	gc as CARD32
	region as CARD32
	xOrigin as INT16
	yOrigin as INT16
end type

const sz_xXFixesSetGCClipRegionReq = 16

type xXFixesSetWindowShapeRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	dest as CARD32
	destKind as UBYTE
	pad1 as CARD8
	pad2 as CARD16
	xOff as INT16
	yOff as INT16
	region as CARD32
end type

const sz_xXFixesSetWindowShapeRegionReq = 20

type xXFixesSetPictureClipRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	picture as CARD32
	region as CARD32
	xOrigin as INT16
	yOrigin as INT16
end type

const sz_xXFixesSetPictureClipRegionReq = 16

type xXFixesSetCursorNameReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	cursor as CARD32
	nbytes as CARD16
	pad as CARD16
end type

const sz_xXFixesSetCursorNameReq = 12

type xXFixesGetCursorNameReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	cursor as CARD32
end type

const sz_xXFixesGetCursorNameReq = 8

type xXFixesGetCursorNameReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	atom as CARD32
	nbytes as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXFixesGetCursorNameReply = 32

type xXFixesGetCursorImageAndNameReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
end type

const sz_xXFixesGetCursorImageAndNameReq = 4

type xXFixesGetCursorImageAndNameReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	xhot as CARD16
	yhot as CARD16
	cursorSerial as CARD32
	cursorName as CARD32
	nbytes as CARD16
	pad as CARD16
end type

const sz_xXFixesGetCursorImageAndNameReply = 32

type xXFixesChangeCursorReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	destination as CARD32
end type

const sz_xXFixesChangeCursorReq = 12

type xXFixesChangeCursorByNameReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	nbytes as CARD16
	pad as CARD16
end type

const sz_xXFixesChangeCursorByNameReq = 12

type xXFixesExpandRegionReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	source as CARD32
	destination as CARD32
	left as CARD16
	right as CARD16
	top as CARD16
	bottom as CARD16
end type

const sz_xXFixesExpandRegionReq = 20

type xXFixesHideCursorReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	window as CARD32
end type

#define sz_xXFixesHideCursorReq sizeof(xXFixesHideCursorReq)

type xXFixesShowCursorReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	window as CARD32
end type

#define sz_xXFixesShowCursorReq sizeof(xXFixesShowCursorReq)

type xXFixesCreatePointerBarrierReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	barrier as CARD32
	window as CARD32
	x1 as INT16
	y1 as INT16
	x2 as INT16
	y2 as INT16
	directions as CARD32
	pad as CARD16
	num_devices as CARD16
end type

const sz_xXFixesCreatePointerBarrierReq = 28

type xXFixesDestroyPointerBarrierReq
	reqType as CARD8
	xfixesReqType as CARD8
	length as CARD16
	barrier as CARD32
end type

const sz_xXFixesDestroyPointerBarrierReq = 8
