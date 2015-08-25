'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1992 Network Computing Devices
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of NCD. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  NCD. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   NCD. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL NCD.
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/lbx.bi"

#define _LBXPROTO_H_
const X_LbxQueryVersion = 0
const X_LbxStartProxy = 1
const X_LbxStopProxy = 2
const X_LbxSwitch = 3
const X_LbxNewClient = 4
const X_LbxCloseClient = 5
const X_LbxModifySequence = 6
const X_LbxAllowMotion = 7
const X_LbxIncrementPixel = 8
const X_LbxDelta = 9
const X_LbxGetModifierMapping = 10
const X_LbxInvalidateTag = 12
const X_LbxPolyPoint = 13
const X_LbxPolyLine = 14
const X_LbxPolySegment = 15
const X_LbxPolyRectangle = 16
const X_LbxPolyArc = 17
const X_LbxFillPoly = 18
const X_LbxPolyFillRectangle = 19
const X_LbxPolyFillArc = 20
const X_LbxGetKeyboardMapping = 21
const X_LbxQueryFont = 22
const X_LbxChangeProperty = 23
const X_LbxGetProperty = 24
const X_LbxTagData = 25
const X_LbxCopyArea = 26
const X_LbxCopyPlane = 27
const X_LbxPolyText8 = 28
const X_LbxPolyText16 = 29
const X_LbxImageText8 = 30
const X_LbxImageText16 = 31
const X_LbxQueryExtension = 32
const X_LbxPutImage = 33
const X_LbxGetImage = 34
const X_LbxBeginLargeRequest = 35
const X_LbxLargeRequestData = 36
const X_LbxEndLargeRequest = 37
const X_LbxInternAtoms = 38
const X_LbxGetWinAttrAndGeom = 39
const X_LbxGrabCmap = 40
const X_LbxReleaseCmap = 41
const X_LbxAllocColor = 42
const X_LbxSync = 43

type xLbxConnSetupPrefix
	success as XBOOL
	changeType as XBOOL
	majorVersion as CARD16
	minorVersion as CARD16
	length as CARD16
	tag as CARD32
end type

type _LbxQueryVersion
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxQueryVersionReq as _LbxQueryVersion
const sz_xLbxQueryVersionReq = 4

type xLbxQueryVersionReply
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

const sz_xLbxQueryVersionReply = 32

type _LbxStartProxy
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxStartProxyReq as _LbxStartProxy
const sz_xLbxStartProxyReq = 4

type _LbxStopProxy
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxStopProxyReq as _LbxStopProxy
const sz_xLbxStopProxyReq = 4

type _LbxSwitch
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	client as CARD32
end type

type xLbxSwitchReq as _LbxSwitch
const sz_xLbxSwitchReq = 8

type _LbxNewClient
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	client as CARD32
end type

type xLbxNewClientReq as _LbxNewClient
const sz_xLbxNewClientReq = 8

type _LbxCloseClient
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	client as CARD32
end type

type xLbxCloseClientReq as _LbxCloseClient
const sz_xLbxCloseClientReq = 8

type _LbxModifySequence
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	adjust as CARD32
end type

type xLbxModifySequenceReq as _LbxModifySequence
const sz_xLbxModifySequenceReq = 8

type _LbxAllowMotion
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	num as CARD32
end type

type xLbxAllowMotionReq as _LbxAllowMotion
const sz_xLbxAllowMotionReq = 8

type xLbxGrabCmapReq
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cmap as CARD32
end type

const sz_xLbxGrabCmapReq = 8
const LBX_SMART_GRAB = &h80
const LBX_AUTO_RELEASE = &h40
const LBX_3CHANNELS = &h20
const LBX_2BYTE_PIXELS = &h10
const LBX_RGB_BITS_MASK = &h0f
const LBX_LIST_END = 0
const LBX_PIXEL_PRIVATE = 1
const LBX_PIXEL_SHARED = 2
const LBX_PIXEL_RANGE_PRIVATE = 3
const LBX_PIXEL_RANGE_SHARED = 4
const LBX_NEXT_CHANNEL = 5

type xLbxGrabCmapReply
	as UBYTE type
	flags as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xLbxGrabCmapReply = 32
const sz_xLbxGrabCmapReplyHdr = 8

type xLbxReleaseCmapReq
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cmap as CARD32
end type

const sz_xLbxReleaseCmapReq = 8

type xLbxAllocColorReq
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cmap as CARD32
	pixel as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	pad as CARD16
end type

const sz_xLbxAllocColorReq = 20

type _LbxIncrementPixel
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cmap as CARD32
	pixel as CARD32
end type

type xLbxIncrementPixelReq as _LbxIncrementPixel
const sz_xLbxIncrementPixelReq = 12

type _LbxDelta
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	diffs as CARD8
	cindex as CARD8
end type

type xLbxDeltaReq as _LbxDelta
const sz_xLbxDeltaReq = 6

type _LbxGetModifierMapping
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxGetModifierMappingReq as _LbxGetModifierMapping
const sz_xLbxGetModifierMappingReq = 4

type xLbxGetModifierMappingReply
	as UBYTE type
	keyspermod as CARD8
	sequenceNumber as CARD16
	length as CARD32
	tag as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxGetModifierMappingReply = 32

type _LbxGetKeyboardMapping
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	firstKeyCode as KeyCode
	count as CARD8
	pad1 as CARD16
end type

type xLbxGetKeyboardMappingReq as _LbxGetKeyboardMapping
const sz_xLbxGetKeyboardMappingReq = 8

type xLbxGetKeyboardMappingReply
	as UBYTE type
	keysperkeycode as CARD8
	sequenceNumber as CARD16
	length as CARD32
	tag as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxGetKeyboardMappingReply = 32

type _LbxQueryFont
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	fid as CARD32
end type

type xLbxQueryFontReq as _LbxQueryFont
const sz_xLbxQueryFontReq = 8

type _LbxInternAtoms
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	num as CARD16
end type

type xLbxInternAtomsReq as _LbxInternAtoms
const sz_xLbxInternAtomsReq = 6

type xLbxInternAtomsReply
	as UBYTE type
	unused as CARD8
	sequenceNumber as CARD16
	length as CARD32
	atomsStart as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxInternAtomsReply = 32
const sz_xLbxInternAtomsReplyHdr = 8

type _LbxGetWinAttrAndGeom
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	id as CARD32
end type

type xLbxGetWinAttrAndGeomReq as _LbxGetWinAttrAndGeom
const sz_xLbxGetWinAttrAndGeomReq = 8

type xLbxGetWinAttrAndGeomReply
	as UBYTE type
	backingStore as CARD8
	sequenceNumber as CARD16
	length as CARD32
	visualID as CARD32
	class as CARD16
	bitGravity as CARD8
	winGravity as CARD8
	backingBitPlanes as CARD32
	backingPixel as CARD32
	saveUnder as XBOOL
	mapInstalled as XBOOL
	mapState as CARD8
	override as XBOOL
	colormap as CARD32
	allEventMasks as CARD32
	yourEventMask as CARD32
	doNotPropagateMask as CARD16
	pad1 as CARD16
	root as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	depth as CARD8
	pad2 as CARD8
end type

const sz_xLbxGetWinAttrAndGeomReply = 60

type xLbxSyncReq
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

const sz_xLbxSyncReq = 4

type xLbxSyncReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xLbxSyncReply = 32
const LBX_WIDTH_SHIFT = 26
const LBX_LEFT_SHIFT = 20
const LBX_RIGHT_SHIFT = 13
const LBX_ASCENT_SHIFT = 7
const LBX_DESCENT_SHIFT = 0
const LBX_WIDTH_BITS = 6
const LBX_LEFT_BITS = 6
const LBX_RIGHT_BITS = 7
const LBX_ASCENT_BITS = 6
const LBX_DESCENT_BITS = 7
const LBX_WIDTH_MASK = &hfc000000
const LBX_LEFT_MASK = &h03f00000
const LBX_RIGHT_MASK = &h000fe000
const LBX_ASCENT_MASK = &h00001f80
const LBX_DESCENT_MASK = &h0000007f
#define LBX_MASK_BITS(val, n) culng((val) and ((1 shl (n)) - 1))

type xLbxCharInfo
	metrics as CARD32
end type

type xLbxFontInfo
	minBounds as xCharInfo
	walign1 as CARD32
	maxBounds as xCharInfo
	walign2 as CARD32
	minCharOrByte2 as CARD16
	maxCharOrByte2 as CARD16
	defaultChar as CARD16
	nFontProps as CARD16
	drawDirection as CARD8
	minByte1 as CARD8
	maxByte1 as CARD8
	allCharsExist as XBOOL
	fontAscent as INT16
	fontDescent as INT16
	nCharInfos as CARD32
end type

type xLbxQueryFontReply
	as UBYTE type
	compression as CARD8
	sequenceNumber as CARD16
	length as CARD32
	tag as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxQueryFontReply = 32

type _LbxChangeProperty
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	window as CARD32
	property as CARD32
	as CARD32 type
	format as CARD8
	mode as CARD8
	pad(0 to 1) as UBYTE
	nUnits as CARD32
end type

type xLbxChangePropertyReq as _LbxChangeProperty
const sz_xLbxChangePropertyReq = 24

type xLbxChangePropertyReply
	as UBYTE type
	pad as CARD8
	sequenceNumber as CARD16
	length as CARD32
	tag as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxChangePropertyReply = 32

type _LbxGetProperty
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	window as CARD32
	property as CARD32
	as CARD32 type
	delete_ as CARD8
	pad(0 to 2) as UBYTE
	longOffset as CARD32
	longLength as CARD32
end type

type xLbxGetPropertyReq as _LbxGetProperty
const sz_xLbxGetPropertyReq = 28

type xLbxGetPropertyReply
	as UBYTE type
	format as CARD8
	sequenceNumber as CARD16
	length as CARD32
	propertyType as CARD32
	bytesAfter as CARD32
	nItems as CARD32
	tag as CARD32
	pad1 as CARD32
	pad2 as CARD32
end type

const sz_xLbxGetPropertyReply = 32

type _LbxTagData
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	tag as CARD32
	real_length as CARD32
end type

type xLbxTagDataReq as _LbxTagData
const sz_xLbxTagDataReq = 12

type _LbxInvalidateTag
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	tag as CARD32
end type

type xLbxInvalidateTagReq as _LbxInvalidateTag
const sz_xLbxInvalidateTagReq = 8

type _LbxPutImage
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	compressionMethod as CARD8
	cacheEnts as CARD8
	bitPacked as CARD8
end type

type xLbxPutImageReq as _LbxPutImage
const sz_xLbxPutImageReq = 7

type xLbxGetImageReq
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	drawable as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	planeMask as CARD32
	format as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

const sz_xLbxGetImageReq = 24

type xLbxGetImageReply
	as UBYTE type
	depth as CARD8
	sequenceNumber as CARD16
	lbxLength as CARD32
	xLength as CARD32
	visual as CARD32
	compressionMethod as CARD8
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xLbxGetImageReply = 32
const GFX_CACHE_SIZE = 15
#define GFXdCacheEnt(e) ((e) and &hf)
#define GFXgCacheEnt(e) (((e) shr 4) and &hf)
#define GFXCacheEnts(d, g) (((d) and &hf) or (((g) and &hf) shl 4))
const GFXCacheNone = &hf

type _LbxPolyPoint
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cacheEnts as CARD8
	padBytes as CARD8
end type

type xLbxPolyPointReq as _LbxPolyPoint
const sz_xLbxPolyPointReq = 6
type xLbxPolyLineReq as xLbxPolyPointReq
type xLbxPolySegmentReq as xLbxPolyPointReq
type xLbxPolyRectangleReq as xLbxPolyPointReq
type xLbxPolyArcReq as xLbxPolyPointReq
type xLbxPolyFillRectangleReq as xLbxPolyPointReq
type xLbxPolyFillArcReq as xLbxPolyPointReq

const sz_xLbxPolyLineReq = sz_xLbxPolyPointReq
const sz_xLbxPolySegmentReq = sz_xLbxPolyPointReq
const sz_xLbxPolyRectangleReq = sz_xLbxPolyPointReq
const sz_xLbxPolyArcReq = sz_xLbxPolyPointReq
const sz_xLbxPolyFillRectangleReq = sz_xLbxPolyPointReq
const sz_xLbxPolyFillArc = sz_xLbxPolyPointReq

type _LbxFillPoly
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cacheEnts as CARD8
	shape as UBYTE
	padBytes as CARD8
end type

type xLbxFillPolyReq as _LbxFillPoly
const sz_xLbxFillPolyReq = 7

type _LbxCopyArea
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	srcCache as CARD8
	cacheEnts as CARD8
end type

type xLbxCopyAreaReq as _LbxCopyArea
const sz_xLbxCopyAreaReq = 6

type _LbxCopyPlane
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	bitPlane as CARD32
	srcCache as CARD8
	cacheEnts as CARD8
end type

type xLbxCopyPlaneReq as _LbxCopyPlane
const sz_xLbxCopyPlaneReq = 10

type _LbxPolyText
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cacheEnts as CARD8
end type

type xLbxPolyTextReq as _LbxPolyText
const sz_xLbxPolyTextReq = 5
type xLbxPolyText8Req as xLbxPolyTextReq
type xLbxPolyText16Req as xLbxPolyTextReq
const sz_xLbxPolyTextReq = 5
const sz_xLbxPolyText8Req = 5
const sz_xLbxPolyText16Req = 5

type _LbxImageText
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	cacheEnts as CARD8
	nChars as CARD8
end type

type xLbxImageTextReq as _LbxImageText
type xLbxImageText8Req as xLbxImageTextReq
type xLbxImageText16Req as xLbxImageTextReq

const sz_xLbxImageTextReq = 6
const sz_xLbxImageText8Req = 6
const sz_xLbxImageText16Req = 6

type xLbxDiffItem
	offset as CARD8
	diff as CARD8
end type

const sz_xLbxDiffItem = 2

type xLbxStartReply
	as UBYTE type
	nOpts as CARD8
	sequenceNumber as CARD16
	length as CARD32
	optDataStart as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xLbxStartReply = 32
const sz_xLbxStartReplyHdr = 8

type _LbxQueryExtension
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	nbytes as CARD32
end type

type xLbxQueryExtensionReq as _LbxQueryExtension
const sz_xLbxQueryExtensionReq = 8

type _LbxQueryExtensionReply
	as UBYTE type
	numReqs as CARD8
	sequenceNumber as CARD16
	length as CARD32
	present as XBOOL
	major_opcode as CARD8
	first_event as CARD8
	first_error as CARD8
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xLbxQueryExtensionReply as _LbxQueryExtensionReply
const sz_xLbxQueryExtensionReply = 32

type _LbxBeginLargeRequest
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
	largeReqLength as CARD32
end type

type xLbxBeginLargeRequestReq as _LbxBeginLargeRequest
const sz_BeginLargeRequestReq = 8

type _LbxLargeRequestData
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxLargeRequestDataReq as _LbxLargeRequestData
const sz_LargeRequestDataReq = 4

type _LbxEndLargeRequest
	reqType as CARD8
	lbxReqType as CARD8
	length as CARD16
end type

type xLbxEndLargeRequestReq as _LbxEndLargeRequest
const sz_EndLargeRequestReq = 4

type _LbxSwitchEvent
	as UBYTE type
	lbxType as UBYTE
	pad as CARD16
	client as CARD32
end type

type xLbxSwitchEvent as _LbxSwitchEvent
const sz_xLbxSwitchEvent = 8

type _LbxCloseEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	client as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xLbxCloseEvent as _LbxCloseEvent
const sz_xLbxCloseEvent = 32

type _LbxInvalidateTagEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	tag as CARD32
	tagType as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xLbxInvalidateTagEvent as _LbxInvalidateTagEvent
const sz_xLbxInvalidateTagEvent = 32

type _LbxSendTagDataEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	tag as CARD32
	tagType as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xLbxSendTagDataEvent as _LbxSendTagDataEvent
const sz_xLbxSendTagDataEvent = 32

type _LbxListenToOneEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	client as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xLbxListenToOneEvent as _LbxListenToOneEvent
const sz_xLbxListenToOneEvent = 32

type _LbxListenToAllEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xLbxListenToAllEvent as _LbxListenToAllEvent
const sz_xLbxListenToOneEvent = 32

type _LbxReleaseCmapEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	colormap as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xLbxReleaseCmapEvent as _LbxReleaseCmapEvent
const sz_xLbxReleaseCmapEvent = 32

type _LbxFreeCellsEvent
	as UBYTE type
	lbxType as UBYTE
	sequenceNumber as CARD16
	colormap as CARD32
	pixelStart as CARD32
	pixelEnd as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xLbxFreeCellsEvent as _LbxFreeCellsEvent
const sz_xLbxFreeCellsEvent = 32
const lbxsz_KeyButtonEvent = 32
const lbxupsz_KeyButtonEvent = 31
const lbxsz_EnterLeaveEvent = 32
const lbxupsz_EnterLeaveEvent = 32
const lbxsz_FocusEvent = 12
const lbxupsz_FocusEvent = 9
const lbxsz_KeymapEvent = 32
const lbxupsz_KeymapEvent = 32
const lbxsz_ExposeEvent = 20
const lbxupsz_ExposeEvent = 18
const lbxsz_GfxExposeEvent = 24
const lbxupsz_GfxExposeEvent = 21
const lbxsz_NoExposeEvent = 12
const lbxupsz_NoExposeEvent = 11
const lbxsz_VisibilityEvent = 12
const lbxupsz_VisibilityEvent = 9
const lbxsz_CreateNotifyEvent = 24
const lbxupsz_CreateNotifyEvent = 23
const lbxsz_DestroyNotifyEvent = 12
const lbxupsz_DestroyNotifyEvent = 12
const lbxsz_UnmapNotifyEvent = 16
const lbxupsz_UnmapNotifyEvent = 13
const lbxsz_MapNotifyEvent = 16
const lbxupsz_MapNotifyEvent = 13
const lbxsz_MapRequestEvent = 12
const lbxupsz_MapRequestEvent = 12
const lbxsz_ReparentEvent = 24
const lbxupsz_ReparentEvent = 21
const lbxsz_ConfigureNotifyEvent = 28
const lbxupsz_ConfigureNotifyEvent = 27
const lbxsz_ConfigureRequestEvent = 28
const lbxupsz_ConfigureRequestEvent = 28
const lbxsz_GravityEvent = 16
const lbxupsz_GravityEvent = 16
const lbxsz_ResizeRequestEvent = 12
const lbxupsz_ResizeRequestEvent = 12
const lbxsz_CirculateEvent = 20
const lbxupsz_CirculateEvent = 17
const lbxsz_PropertyEvent = 20
const lbxupsz_PropertyEvent = 17
const lbxsz_SelectionClearEvent = 16
const lbxupsz_SelectionClearEvent = 16
const lbxsz_SelectionRequestEvent = 28
const lbxupsz_SelectionRequestEvent = 28
const lbxsz_SelectionNotifyEvent = 24
const lbxupsz_SelectionNotifyEvent = 24
const lbxsz_ColormapEvent = 16
const lbxupsz_ColormapEvent = 14
const lbxsz_MappingNotifyEvent = 8
const lbxupsz_MappingNotifyEvent = 7
const lbxsz_ClientMessageEvent = 32
const lbxupsz_ClientMessageEvent = 32
const lbxsz_UnknownEvent = 32
