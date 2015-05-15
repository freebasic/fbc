'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1998  The Open Group
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
''
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its 
''   documentation for any purpose and without fee is hereby granted, 
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in 
''   supporting documentation, and that the name of Digital not be
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
#include once "X11/Xprotostr.bi"

'' The following symbols have been renamed:
''     struct xTimecoord => xTimecoord_
''     struct xFontProp => xFontProp_
''     typedef xEvent => xEvent_
''     struct xGenericEvent => xGenericEvent_
''     struct xKeymapEvent => xKeymapEvent_

#define XPROTO_H
const sz_xSegment = 8
const sz_xPoint = 4
const sz_xRectangle = 8
const sz_xArc = 12
const sz_xConnClientPrefix = 12
const sz_xConnSetupPrefix = 8
const sz_xConnSetup = 32
const sz_xPixmapFormat = 8
const sz_xDepth = 8
const sz_xVisualType = 24
const sz_xWindowRoot = 40
const sz_xTimecoord = 8
const sz_xHostEntry = 4
const sz_xCharInfo = 12
const sz_xFontProp = 8
const sz_xTextElt = 2
const sz_xColorItem = 12
const sz_xrgb = 8
const sz_xGenericReply = 32
const sz_xGetWindowAttributesReply = 44
const sz_xGetGeometryReply = 32
const sz_xQueryTreeReply = 32
const sz_xInternAtomReply = 32
const sz_xGetAtomNameReply = 32
const sz_xGetPropertyReply = 32
const sz_xListPropertiesReply = 32
const sz_xGetSelectionOwnerReply = 32
const sz_xGrabPointerReply = 32
const sz_xQueryPointerReply = 32
const sz_xGetMotionEventsReply = 32
const sz_xTranslateCoordsReply = 32
const sz_xGetInputFocusReply = 32
const sz_xQueryKeymapReply = 40
const sz_xQueryFontReply = 60
const sz_xQueryTextExtentsReply = 32
const sz_xListFontsReply = 32
const sz_xGetFontPathReply = 32
const sz_xGetImageReply = 32
const sz_xListInstalledColormapsReply = 32
const sz_xAllocColorReply = 32
const sz_xAllocNamedColorReply = 32
const sz_xAllocColorCellsReply = 32
const sz_xAllocColorPlanesReply = 32
const sz_xQueryColorsReply = 32
const sz_xLookupColorReply = 32
const sz_xQueryBestSizeReply = 32
const sz_xQueryExtensionReply = 32
const sz_xListExtensionsReply = 32
const sz_xSetMappingReply = 32
const sz_xGetKeyboardControlReply = 52
const sz_xGetPointerControlReply = 32
const sz_xGetScreenSaverReply = 32
const sz_xListHostsReply = 32
const sz_xSetModifierMappingReply = 32
const sz_xError = 32
const sz_xEvent = 32
const sz_xKeymapEvent = 32
const sz_xReq = 4
const sz_xResourceReq = 8
const sz_xCreateWindowReq = 32
const sz_xChangeWindowAttributesReq = 12
const sz_xChangeSaveSetReq = 8
const sz_xReparentWindowReq = 16
const sz_xConfigureWindowReq = 12
const sz_xCirculateWindowReq = 8
const sz_xInternAtomReq = 8
const sz_xChangePropertyReq = 24
const sz_xDeletePropertyReq = 12
const sz_xGetPropertyReq = 24
const sz_xSetSelectionOwnerReq = 16
const sz_xConvertSelectionReq = 24
const sz_xSendEventReq = 44
const sz_xGrabPointerReq = 24
const sz_xGrabButtonReq = 24
const sz_xUngrabButtonReq = 12
const sz_xChangeActivePointerGrabReq = 16
const sz_xGrabKeyboardReq = 16
const sz_xGrabKeyReq = 16
const sz_xUngrabKeyReq = 12
const sz_xAllowEventsReq = 8
const sz_xGetMotionEventsReq = 16
const sz_xTranslateCoordsReq = 16
const sz_xWarpPointerReq = 24
const sz_xSetInputFocusReq = 12
const sz_xOpenFontReq = 12
const sz_xQueryTextExtentsReq = 8
const sz_xListFontsReq = 8
const sz_xSetFontPathReq = 8
const sz_xCreatePixmapReq = 16
const sz_xCreateGCReq = 16
const sz_xChangeGCReq = 12
const sz_xCopyGCReq = 16
const sz_xSetDashesReq = 12
const sz_xSetClipRectanglesReq = 12
const sz_xCopyAreaReq = 28
const sz_xCopyPlaneReq = 32
const sz_xPolyPointReq = 12
const sz_xPolySegmentReq = 12
const sz_xFillPolyReq = 16
const sz_xPutImageReq = 24
const sz_xGetImageReq = 20
const sz_xPolyTextReq = 16
const sz_xImageTextReq = 16
const sz_xCreateColormapReq = 16
const sz_xCopyColormapAndFreeReq = 12
const sz_xAllocColorReq = 16
const sz_xAllocNamedColorReq = 12
const sz_xAllocColorCellsReq = 12
const sz_xAllocColorPlanesReq = 16
const sz_xFreeColorsReq = 12
const sz_xStoreColorsReq = 8
const sz_xStoreNamedColorReq = 16
const sz_xQueryColorsReq = 8
const sz_xLookupColorReq = 12
const sz_xCreateCursorReq = 32
const sz_xCreateGlyphCursorReq = 32
const sz_xRecolorCursorReq = 20
const sz_xQueryBestSizeReq = 12
const sz_xQueryExtensionReq = 8
const sz_xChangeKeyboardControlReq = 8
const sz_xBellReq = 4
const sz_xChangePointerControlReq = 12
const sz_xSetScreenSaverReq = 12
const sz_xChangeHostsReq = 8
const sz_xListHostsReq = 4
const sz_xChangeModeReq = 4
const sz_xRotatePropertiesReq = 12
const sz_xReply = 32
const sz_xGrabKeyboardReply = 32
const sz_xListFontsWithInfoReply = 60
const sz_xSetPointerMappingReply = 32
const sz_xGetKeyboardMappingReply = 32
const sz_xGetPointerMappingReply = 32
const sz_xGetModifierMappingReply = 32
const sz_xListFontsWithInfoReq = 8
const sz_xPolyLineReq = 12
const sz_xPolyArcReq = 12
const sz_xPolyRectangleReq = 12
const sz_xPolyFillRectangleReq = 12
const sz_xPolyFillArcReq = 12
const sz_xPolyText8Req = 16
const sz_xPolyText16Req = 16
const sz_xImageText8Req = 16
const sz_xImageText16Req = 16
const sz_xSetPointerMappingReq = 4
const sz_xForceScreenSaverReq = 4
const sz_xSetCloseDownModeReq = 4
const sz_xClearAreaReq = 16
const sz_xSetAccessControlReq = 4
const sz_xGetKeyboardMappingReq = 8
const sz_xSetModifierMappingReq = 4
const sz_xPropIconSize = 24
const sz_xChangeKeyboardMappingReq = 8
const X_TCP_PORT = 6000
const xTrue = 1
const xFalse = 0
type KeyButMask as CARD16

type xConnClientPrefix
	byteOrder as CARD8
	pad as UBYTE
	majorVersion as CARD16
	minorVersion as CARD16
	nbytesAuthProto as CARD16
	nbytesAuthString as CARD16
	pad2 as CARD16
end type

type xConnSetupPrefix
	success as CARD8
	lengthReason as UBYTE
	majorVersion as CARD16
	minorVersion as CARD16
	length as CARD16
end type

type xConnSetup
	release as CARD32
	ridBase as CARD32
	ridMask as CARD32
	motionBufferSize as CARD32
	nbytesVendor as CARD16
	maxRequestSize as CARD16
	numRoots as CARD8
	numFormats as CARD8
	imageByteOrder as CARD8
	bitmapBitOrder as CARD8
	bitmapScanlineUnit as CARD8
	bitmapScanlinePad as CARD8
	minKeyCode as CARD8
	maxKeyCode as CARD8
	pad2 as CARD32
end type

type xPixmapFormat
	depth as CARD8
	bitsPerPixel as CARD8
	scanLinePad as CARD8
	pad1 as CARD8
	pad2 as CARD32
end type

type xDepth
	depth as CARD8
	pad1 as CARD8
	nVisuals as CARD16
	pad2 as CARD32
end type

type xVisualType
	visualID as CARD32
	class as CARD8
	bitsPerRGB as CARD8
	colormapEntries as CARD16
	redMask as CARD32
	greenMask as CARD32
	blueMask as CARD32
	pad as CARD32
end type

type xWindowRoot
	windowId as CARD32
	defaultColormap as CARD32
	whitePixel as CARD32
	blackPixel as CARD32
	currentInputMask as CARD32
	pixWidth as CARD16
	pixHeight as CARD16
	mmWidth as CARD16
	mmHeight as CARD16
	minInstalledMaps as CARD16
	maxInstalledMaps as CARD16
	rootVisualID as CARD32
	backingStore as CARD8
	saveUnders as XBOOL
	rootDepth as CARD8
	nDepths as CARD8
end type

type xTimecoord_
	time as CARD32
	x as INT16
	y as INT16
end type

type xHostEntry
	family as CARD8
	pad as UBYTE
	length as CARD16
end type

type xCharInfo
	leftSideBearing as INT16
	rightSideBearing as INT16
	characterWidth as INT16
	ascent as INT16
	descent as INT16
	attributes as CARD16
end type

type xFontProp_
	name as CARD32
	value as CARD32
end type

type xTextElt
	len as CARD8
	delta as INT8
end type

type xColorItem
	pixel as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	flags as CARD8
	pad as CARD8
end type

type xrgb
	red as CARD16
	green as CARD16
	blue as CARD16
	pad as CARD16
end type

type KEYCODE as CARD8

type xGenericReply
	as UBYTE type
	data1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	data00 as CARD32
	data01 as CARD32
	data02 as CARD32
	data03 as CARD32
	data04 as CARD32
	data05 as CARD32
end type

type xGetWindowAttributesReply
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
	pad as CARD16
end type

type xGetGeometryReply
	as UBYTE type
	depth as CARD8
	sequenceNumber as CARD16
	length as CARD32
	root as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
end type

type xQueryTreeReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	root as CARD32
	parent as CARD32
	nChildren as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xInternAtomReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	atom as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xGetAtomNameReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nameLength as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xGetPropertyReply
	as UBYTE type
	format as CARD8
	sequenceNumber as CARD16
	length as CARD32
	propertyType as CARD32
	bytesAfter as CARD32
	nItems as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xListPropertiesReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nProperties as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xGetSelectionOwnerReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	owner as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xGrabPointerReply
	as UBYTE type
	status as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xGrabKeyboardReply as xGrabPointerReply

type xQueryPointerReply
	as UBYTE type
	sameScreen as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	root as CARD32
	child as CARD32
	rootX as INT16
	rootY as INT16
	winX as INT16
	winY as INT16
	mask as CARD16
	pad1 as CARD16
	pad as CARD32
end type

type xGetMotionEventsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nEvents as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xTranslateCoordsReply
	as UBYTE type
	sameScreen as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	child as CARD32
	dstX as INT16
	dstY as INT16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xGetInputFocusReply
	as UBYTE type
	revertTo as CARD8
	sequenceNumber as CARD16
	length as CARD32
	focus as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xQueryKeymapReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	map(0 to 31) as UBYTE
end type

type _xQueryFontReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
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

type xQueryFontReply as _xQueryFontReply

type xQueryTextExtentsReply
	as UBYTE type
	drawDirection as CARD8
	sequenceNumber as CARD16
	length as CARD32
	fontAscent as INT16
	fontDescent as INT16
	overallAscent as INT16
	overallDescent as INT16
	overallWidth as INT32
	overallLeft as INT32
	overallRight as INT32
	pad as CARD32
end type

type xListFontsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nFonts as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xListFontsWithInfoReply
	as UBYTE type
	nameLength as CARD8
	sequenceNumber as CARD16
	length as CARD32
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
	nReplies as CARD32
end type

type xGetFontPathReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nPaths as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xGetImageReply
	as UBYTE type
	depth as CARD8
	sequenceNumber as CARD16
	length as CARD32
	visual as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xListInstalledColormapsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nColormaps as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xAllocColorReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	pad2 as CARD16
	pixel as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xAllocNamedColorReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	pixel as CARD32
	exactRed as CARD16
	exactGreen as CARD16
	exactBlue as CARD16
	screenRed as CARD16
	screenGreen as CARD16
	screenBlue as CARD16
	pad2 as CARD32
	pad3 as CARD32
end type

type xAllocColorCellsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nPixels as CARD16
	nMasks as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xAllocColorPlanesReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nPixels as CARD16
	pad2 as CARD16
	redMask as CARD32
	greenMask as CARD32
	blueMask as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xQueryColorsReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	nColors as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xLookupColorReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	exactRed as CARD16
	exactGreen as CARD16
	exactBlue as CARD16
	screenRed as CARD16
	screenGreen as CARD16
	screenBlue as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xQueryBestSizeReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	width as CARD16
	height as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xQueryExtensionReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	present as XBOOL
	major_opcode as CARD8
	first_event as CARD8
	first_error as CARD8
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xListExtensionsReply
	as UBYTE type
	nExtensions as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xSetMappingReply
	as UBYTE type
	success as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xSetPointerMappingReply as xSetMappingReply
type xSetModifierMappingReply as xSetMappingReply

type xGetPointerMappingReply
	as UBYTE type
	nElts as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xGetKeyboardMappingReply
	as UBYTE type
	keySymsPerKeyCode as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xGetModifierMappingReply
	as UBYTE type
	numKeyPerModifier as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xGetKeyboardControlReply
	as UBYTE type
	globalAutoRepeat as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	ledMask as CARD32
	keyClickPercent as CARD8
	bellPercent as CARD8
	bellPitch as CARD16
	bellDuration as CARD16
	pad as CARD16
	map(0 to 31) as UBYTE
end type

type xGetPointerControlReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	accelNumerator as CARD16
	accelDenominator as CARD16
	threshold as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xGetScreenSaverReply
	as UBYTE type
	pad1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	timeout as CARD16
	interval as CARD16
	preferBlanking as XBOOL
	allowExposures as XBOOL
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

type xListHostsReply
	as UBYTE type
	enabled as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	nHosts as CARD16
	pad1 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xError
	as UBYTE type
	errorCode as UBYTE
	sequenceNumber as CARD16
	resourceID as CARD32
	minorCode as CARD16
	majorCode as CARD8
	pad1 as UBYTE
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type _xEvent_u_u
	as UBYTE type
	detail as UBYTE
	sequenceNumber as CARD16
end type

type _xEvent_u_keyButtonPointer
	pad00 as CARD32
	time as CARD32
	root as CARD32
	event as CARD32
	child as CARD32
	rootX as INT16
	rootY as INT16
	eventX as INT16
	eventY as INT16
	state as KeyButMask
	sameScreen as XBOOL
	pad1 as UBYTE
end type

type _xEvent_u_enterLeave
	pad00 as CARD32
	time as CARD32
	root as CARD32
	event as CARD32
	child as CARD32
	rootX as INT16
	rootY as INT16
	eventX as INT16
	eventY as INT16
	state as KeyButMask
	mode as UBYTE
	flags as UBYTE
end type

type _xEvent_u_focus
	pad00 as CARD32
	window as CARD32
	mode as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_expose
	pad00 as CARD32
	window as CARD32
	x as CARD16
	y as CARD16
	width as CARD16
	height as CARD16
	count as CARD16
	pad2 as CARD16
end type

type _xEvent_u_graphicsExposure
	pad00 as CARD32
	drawable as CARD32
	x as CARD16
	y as CARD16
	width as CARD16
	height as CARD16
	minorEvent as CARD16
	count as CARD16
	majorEvent as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_noExposure
	pad00 as CARD32
	drawable as CARD32
	minorEvent as CARD16
	majorEvent as UBYTE
	bpad as UBYTE
end type

type _xEvent_u_visibility
	pad00 as CARD32
	window as CARD32
	state as CARD8
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_createNotify
	pad00 as CARD32
	parent as CARD32
	window as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	override as XBOOL
	bpad as UBYTE
end type

type _xEvent_u_destroyNotify
	pad00 as CARD32
	event as CARD32
	window as CARD32
end type

type _xEvent_u_unmapNotify
	pad00 as CARD32
	event as CARD32
	window as CARD32
	fromConfigure as XBOOL
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_mapNotify
	pad00 as CARD32
	event as CARD32
	window as CARD32
	override as XBOOL
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_mapRequest
	pad00 as CARD32
	parent as CARD32
	window as CARD32
end type

type _xEvent_u_reparent
	pad00 as CARD32
	event as CARD32
	window as CARD32
	parent as CARD32
	x as INT16
	y as INT16
	override as XBOOL
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_configureNotify
	pad00 as CARD32
	event as CARD32
	window as CARD32
	aboveSibling as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	override as XBOOL
	bpad as UBYTE
end type

type _xEvent_u_configureRequest
	pad00 as CARD32
	parent as CARD32
	window as CARD32
	sibling as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	valueMask as CARD16
	pad1 as CARD32
end type

type _xEvent_u_gravity
	pad00 as CARD32
	event as CARD32
	window as CARD32
	x as INT16
	y as INT16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type _xEvent_u_resizeRequest
	pad00 as CARD32
	window as CARD32
	width as CARD16
	height as CARD16
end type

type _xEvent_u_circulate
	pad00 as CARD32
	event as CARD32
	window as CARD32
	parent as CARD32
	place as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type _xEvent_u_property
	pad00 as CARD32
	window as CARD32
	atom as CARD32
	time as CARD32
	state as UBYTE
	pad1 as UBYTE
	pad2 as CARD16
end type

type _xEvent_u_selectionClear
	pad00 as CARD32
	time as CARD32
	window as CARD32
	atom as CARD32
end type

type _xEvent_u_selectionRequest
	pad00 as CARD32
	time as CARD32
	owner as CARD32
	requestor as CARD32
	selection as CARD32
	target as CARD32
	property as CARD32
end type

type _xEvent_u_selectionNotify
	pad00 as CARD32
	time as CARD32
	requestor as CARD32
	selection as CARD32
	target as CARD32
	property as CARD32
end type

type _xEvent_u_colormap
	pad00 as CARD32
	window as CARD32
	colormap as CARD32
	new_ as XBOOL
	state as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
end type

type _xEvent_u_mappingNotify
	pad00 as CARD32
	request as CARD8
	firstKeyCode as CARD8
	count as CARD8
	pad1 as UBYTE
end type

type _xEvent_u_clientMessage_u_l
	as CARD32 type
	longs0 as INT32
	longs1 as INT32
	longs2 as INT32
	longs3 as INT32
	longs4 as INT32
end type

type _xEvent_u_clientMessage_u_s
	as CARD32 type
	shorts0 as INT16
	shorts1 as INT16
	shorts2 as INT16
	shorts3 as INT16
	shorts4 as INT16
	shorts5 as INT16
	shorts6 as INT16
	shorts7 as INT16
	shorts8 as INT16
	shorts9 as INT16
end type

type _xEvent_u_clientMessage_u_b
	as CARD32 type
	bytes(0 to 19) as INT8
end type

union _xEvent_u_clientMessage_u
	l as _xEvent_u_clientMessage_u_l
	s as _xEvent_u_clientMessage_u_s
	b as _xEvent_u_clientMessage_u_b
end union

type _xEvent_u_clientMessage
	pad00 as CARD32
	window as CARD32
	u as _xEvent_u_clientMessage_u
end type

union _xEvent_u
	u as _xEvent_u_u
	keyButtonPointer as _xEvent_u_keyButtonPointer
	enterLeave as _xEvent_u_enterLeave
	focus as _xEvent_u_focus
	expose as _xEvent_u_expose
	graphicsExposure as _xEvent_u_graphicsExposure
	noExposure as _xEvent_u_noExposure
	visibility as _xEvent_u_visibility
	createNotify as _xEvent_u_createNotify
	destroyNotify as _xEvent_u_destroyNotify
	unmapNotify as _xEvent_u_unmapNotify
	mapNotify as _xEvent_u_mapNotify
	mapRequest as _xEvent_u_mapRequest
	reparent as _xEvent_u_reparent
	configureNotify as _xEvent_u_configureNotify
	configureRequest as _xEvent_u_configureRequest
	gravity as _xEvent_u_gravity
	resizeRequest as _xEvent_u_resizeRequest
	circulate as _xEvent_u_circulate
	property as _xEvent_u_property
	selectionClear as _xEvent_u_selectionClear
	selectionRequest as _xEvent_u_selectionRequest
	selectionNotify as _xEvent_u_selectionNotify
	colormap as _xEvent_u_colormap
	mappingNotify as _xEvent_u_mappingNotify
	clientMessage as _xEvent_u_clientMessage
end union

type xEvent_
	u as _xEvent_u
end type

const ELFlagFocus = 1 shl 0
const ELFlagSameScreen = 1 shl 1

type xGenericEvent_
	as UBYTE type
	extension as CARD8
	sequenceNumber as CARD16
	length as CARD32
	evtype as CARD16
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xKeymapEvent_
	as UBYTE type
	map(0 to 30) as UBYTE
end type

#define XEventSize sizeof(xEvent_)

union xReply
	generic as xGenericReply
	geom as xGetGeometryReply
	tree as xQueryTreeReply
	atom as xInternAtomReply
	atomName as xGetAtomNameReply
	property as xGetPropertyReply
	listProperties as xListPropertiesReply
	selection as xGetSelectionOwnerReply
	grabPointer as xGrabPointerReply
	grabKeyboard as xGrabKeyboardReply
	pointer as xQueryPointerReply
	motionEvents as xGetMotionEventsReply
	coords as xTranslateCoordsReply
	inputFocus as xGetInputFocusReply
	textExtents as xQueryTextExtentsReply
	fonts as xListFontsReply
	fontPath as xGetFontPathReply
	image as xGetImageReply
	colormaps as xListInstalledColormapsReply
	allocColor as xAllocColorReply
	allocNamedColor as xAllocNamedColorReply
	colorCells as xAllocColorCellsReply
	colorPlanes as xAllocColorPlanesReply
	colors as xQueryColorsReply
	lookupColor as xLookupColorReply
	bestSize as xQueryBestSizeReply
	extension as xQueryExtensionReply
	extensions as xListExtensionsReply
	setModifierMapping as xSetModifierMappingReply
	getModifierMapping as xGetModifierMappingReply
	setPointerMapping as xSetPointerMappingReply
	getKeyboardMapping as xGetKeyboardMappingReply
	getPointerMapping as xGetPointerMappingReply
	pointerControl as xGetPointerControlReply
	screenSaver as xGetScreenSaverReply
	hosts as xListHostsReply
	error as xError
	event as xEvent_
end union

type _xReq
	reqType as CARD8
	data as CARD8
	length as CARD16
end type

type xReq as _xReq

type xResourceReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	id as CARD32
end type

type xCreateWindowReq
	reqType as CARD8
	depth as CARD8
	length as CARD16
	wid as CARD32
	parent as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	borderWidth as CARD16
	class as CARD16
	visual as CARD32
	mask as CARD32
end type

type xChangeWindowAttributesReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	valueMask as CARD32
end type

type xChangeSaveSetReq
	reqType as CARD8
	mode as UBYTE
	length as CARD16
	window as CARD32
end type

type xReparentWindowReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	parent as CARD32
	x as INT16
	y as INT16
end type

type xConfigureWindowReq
	reqType as CARD8
	pad as CARD8
	length as CARD16
	window as CARD32
	mask as CARD16
	pad2 as CARD16
end type

type xCirculateWindowReq
	reqType as CARD8
	direction as CARD8
	length as CARD16
	window as CARD32
end type

type xInternAtomReq
	reqType as CARD8
	onlyIfExists as XBOOL
	length as CARD16
	nbytes as CARD16
	pad as CARD16
end type

type xChangePropertyReq
	reqType as CARD8
	mode as CARD8
	length as CARD16
	window as CARD32
	property as CARD32
	as CARD32 type
	format as CARD8
	pad(0 to 2) as UBYTE
	nUnits as CARD32
end type

type xDeletePropertyReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	property as CARD32
end type

type xGetPropertyReq
	reqType as CARD8
	delete_ as XBOOL
	length as CARD16
	window as CARD32
	property as CARD32
	as CARD32 type
	longOffset as CARD32
	longLength as CARD32
end type

type xSetSelectionOwnerReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	selection as CARD32
	time as CARD32
end type

type xConvertSelectionReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	requestor as CARD32
	selection as CARD32
	target as CARD32
	property as CARD32
	time as CARD32
end type

type xSendEventReq
	reqType as CARD8
	propagate as XBOOL
	length as CARD16
	destination as CARD32
	eventMask as CARD32
	event as xEvent_
end type

type xGrabPointerReq
	reqType as CARD8
	ownerEvents as XBOOL
	length as CARD16
	grabWindow as CARD32
	eventMask as CARD16
	pointerMode as UBYTE
	keyboardMode as UBYTE
	confineTo as CARD32
	cursor as CARD32
	time as CARD32
end type

type xGrabButtonReq
	reqType as CARD8
	ownerEvents as XBOOL
	length as CARD16
	grabWindow as CARD32
	eventMask as CARD16
	pointerMode as UBYTE
	keyboardMode as UBYTE
	confineTo as CARD32
	cursor as CARD32
	button as CARD8
	pad as UBYTE
	modifiers as CARD16
end type

type xUngrabButtonReq
	reqType as CARD8
	button as CARD8
	length as CARD16
	grabWindow as CARD32
	modifiers as CARD16
	pad as CARD16
end type

type xChangeActivePointerGrabReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cursor as CARD32
	time as CARD32
	eventMask as CARD16
	pad2 as CARD16
end type

type xGrabKeyboardReq
	reqType as CARD8
	ownerEvents as XBOOL
	length as CARD16
	grabWindow as CARD32
	time as CARD32
	pointerMode as UBYTE
	keyboardMode as UBYTE
	pad as CARD16
end type

type xGrabKeyReq
	reqType as CARD8
	ownerEvents as XBOOL
	length as CARD16
	grabWindow as CARD32
	modifiers as CARD16
	key as CARD8
	pointerMode as UBYTE
	keyboardMode as UBYTE
	pad1 as UBYTE
	pad2 as UBYTE
	pad3 as UBYTE
end type

type xUngrabKeyReq
	reqType as CARD8
	key as CARD8
	length as CARD16
	grabWindow as CARD32
	modifiers as CARD16
	pad as CARD16
end type

type xAllowEventsReq
	reqType as CARD8
	mode as CARD8
	length as CARD16
	time as CARD32
end type

type xGetMotionEventsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	start as CARD32
	stop as CARD32
end type

type xTranslateCoordsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	srcWid as CARD32
	dstWid as CARD32
	srcX as INT16
	srcY as INT16
end type

type xWarpPointerReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	srcWid as CARD32
	dstWid as CARD32
	srcX as INT16
	srcY as INT16
	srcWidth as CARD16
	srcHeight as CARD16
	dstX as INT16
	dstY as INT16
end type

type xSetInputFocusReq
	reqType as CARD8
	revertTo as CARD8
	length as CARD16
	focus as CARD32
	time as CARD32
end type

type xOpenFontReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	fid as CARD32
	nbytes as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xQueryTextExtentsReq
	reqType as CARD8
	oddLength as XBOOL
	length as CARD16
	fid as CARD32
end type

type xListFontsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	maxNames as CARD16
	nbytes as CARD16
end type

type xListFontsWithInfoReq as xListFontsReq

type xSetFontPathReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	nFonts as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xCreatePixmapReq
	reqType as CARD8
	depth as CARD8
	length as CARD16
	pid as CARD32
	drawable as CARD32
	width as CARD16
	height as CARD16
end type

type xCreateGCReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	gc as CARD32
	drawable as CARD32
	mask as CARD32
end type

type xChangeGCReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	gc as CARD32
	mask as CARD32
end type

type xCopyGCReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	srcGC as CARD32
	dstGC as CARD32
	mask as CARD32
end type

type xSetDashesReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	gc as CARD32
	dashOffset as CARD16
	nDashes as CARD16
end type

type xSetClipRectanglesReq
	reqType as CARD8
	ordering as UBYTE
	length as CARD16
	gc as CARD32
	xOrigin as INT16
	yOrigin as INT16
end type

type xClearAreaReq
	reqType as CARD8
	exposures as XBOOL
	length as CARD16
	window as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
end type

type xCopyAreaReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	srcDrawable as CARD32
	dstDrawable as CARD32
	gc as CARD32
	srcX as INT16
	srcY as INT16
	dstX as INT16
	dstY as INT16
	width as CARD16
	height as CARD16
end type

type xCopyPlaneReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	srcDrawable as CARD32
	dstDrawable as CARD32
	gc as CARD32
	srcX as INT16
	srcY as INT16
	dstX as INT16
	dstY as INT16
	width as CARD16
	height as CARD16
	bitPlane as CARD32
end type

type xPolyPointReq
	reqType as CARD8
	coordMode as UBYTE
	length as CARD16
	drawable as CARD32
	gc as CARD32
end type

type xPolyLineReq as xPolyPointReq

type xPolySegmentReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	drawable as CARD32
	gc as CARD32
end type

type xPolyArcReq as xPolySegmentReq
type xPolyRectangleReq as xPolySegmentReq
type xPolyFillRectangleReq as xPolySegmentReq
type xPolyFillArcReq as xPolySegmentReq

type _FillPolyReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	drawable as CARD32
	gc as CARD32
	shape as UBYTE
	coordMode as UBYTE
	pad1 as CARD16
end type

type xFillPolyReq as _FillPolyReq

type _PutImageReq
	reqType as CARD8
	format as CARD8
	length as CARD16
	drawable as CARD32
	gc as CARD32
	width as CARD16
	height as CARD16
	dstX as INT16
	dstY as INT16
	leftPad as CARD8
	depth as CARD8
	pad as CARD16
end type

type xPutImageReq as _PutImageReq

type xGetImageReq
	reqType as CARD8
	format as CARD8
	length as CARD16
	drawable as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	planeMask as CARD32
end type

type xPolyTextReq
	reqType as CARD8
	pad as CARD8
	length as CARD16
	drawable as CARD32
	gc as CARD32
	x as INT16
	y as INT16
end type

type xPolyText8Req as xPolyTextReq
type xPolyText16Req as xPolyTextReq

type xImageTextReq
	reqType as CARD8
	nChars as UBYTE
	length as CARD16
	drawable as CARD32
	gc as CARD32
	x as INT16
	y as INT16
end type

type xImageText8Req as xImageTextReq
type xImageText16Req as xImageTextReq

type xCreateColormapReq
	reqType as CARD8
	alloc as UBYTE
	length as CARD16
	mid as CARD32
	window as CARD32
	visual as CARD32
end type

type xCopyColormapAndFreeReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	mid as CARD32
	srcCmap as CARD32
end type

type xAllocColorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	pad2 as CARD16
end type

type xAllocNamedColorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
	nbytes as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xAllocColorCellsReq
	reqType as CARD8
	contiguous as XBOOL
	length as CARD16
	cmap as CARD32
	colors as CARD16
	planes as CARD16
end type

type xAllocColorPlanesReq
	reqType as CARD8
	contiguous as XBOOL
	length as CARD16
	cmap as CARD32
	colors as CARD16
	red as CARD16
	green as CARD16
	blue as CARD16
end type

type xFreeColorsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
	planeMask as CARD32
end type

type xStoreColorsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
end type

type xStoreNamedColorReq
	reqType as CARD8
	flags as CARD8
	length as CARD16
	cmap as CARD32
	pixel as CARD32
	nbytes as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xQueryColorsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
end type

type xLookupColorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cmap as CARD32
	nbytes as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xCreateCursorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cid as CARD32
	source as CARD32
	mask as CARD32
	foreRed as CARD16
	foreGreen as CARD16
	foreBlue as CARD16
	backRed as CARD16
	backGreen as CARD16
	backBlue as CARD16
	x as CARD16
	y as CARD16
end type

type xCreateGlyphCursorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cid as CARD32
	source as CARD32
	mask as CARD32
	sourceChar as CARD16
	maskChar as CARD16
	foreRed as CARD16
	foreGreen as CARD16
	foreBlue as CARD16
	backRed as CARD16
	backGreen as CARD16
	backBlue as CARD16
end type

type xRecolorCursorReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	cursor as CARD32
	foreRed as CARD16
	foreGreen as CARD16
	foreBlue as CARD16
	backRed as CARD16
	backGreen as CARD16
	backBlue as CARD16
end type

type xQueryBestSizeReq
	reqType as CARD8
	class as CARD8
	length as CARD16
	drawable as CARD32
	width as CARD16
	height as CARD16
end type

type xQueryExtensionReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	nbytes as CARD16
	pad1 as UBYTE
	pad2 as UBYTE
end type

type xSetModifierMappingReq
	reqType as CARD8
	numKeyPerModifier as CARD8
	length as CARD16
end type

type xSetPointerMappingReq
	reqType as CARD8
	nElts as CARD8
	length as CARD16
end type

type xGetKeyboardMappingReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	firstKeyCode as CARD8
	count as CARD8
	pad1 as CARD16
end type

type xChangeKeyboardMappingReq
	reqType as CARD8
	keyCodes as CARD8
	length as CARD16
	firstKeyCode as CARD8
	keySymsPerKeyCode as CARD8
	pad1 as CARD16
end type

type xChangeKeyboardControlReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	mask as CARD32
end type

type xBellReq
	reqType as CARD8
	percent as INT8
	length as CARD16
end type

type xChangePointerControlReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	accelNum as INT16
	accelDenum as INT16
	threshold as INT16
	doAccel as XBOOL
	doThresh as XBOOL
end type

type xSetScreenSaverReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	timeout as INT16
	interval as INT16
	preferBlank as UBYTE
	allowExpose as UBYTE
	pad2 as CARD16
end type

type xChangeHostsReq
	reqType as CARD8
	mode as UBYTE
	length as CARD16
	hostFamily as CARD8
	pad as UBYTE
	hostLength as CARD16
end type

type xListHostsReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
end type

type xChangeModeReq
	reqType as CARD8
	mode as UBYTE
	length as CARD16
end type

type xSetAccessControlReq as xChangeModeReq
type xSetCloseDownModeReq as xChangeModeReq
type xForceScreenSaverReq as xChangeModeReq

type xRotatePropertiesReq
	reqType as CARD8
	pad as UBYTE
	length as CARD16
	window as CARD32
	nAtoms as CARD16
	nPositions as INT16
end type

const X_Reply = 1
const X_Error = 0
const X_CreateWindow = 1
const X_ChangeWindowAttributes = 2
const X_GetWindowAttributes = 3
const X_DestroyWindow = 4
const X_DestroySubwindows = 5
const X_ChangeSaveSet = 6
const X_ReparentWindow = 7
const X_MapWindow = 8
const X_MapSubwindows = 9
const X_UnmapWindow = 10
const X_UnmapSubwindows = 11
const X_ConfigureWindow = 12
const X_CirculateWindow = 13
const X_GetGeometry = 14
const X_QueryTree = 15
const X_InternAtom = 16
const X_GetAtomName = 17
const X_ChangeProperty = 18
const X_DeleteProperty = 19
const X_GetProperty = 20
const X_ListProperties = 21
const X_SetSelectionOwner = 22
const X_GetSelectionOwner = 23
const X_ConvertSelection = 24
const X_SendEvent = 25
const X_GrabPointer = 26
const X_UngrabPointer = 27
const X_GrabButton = 28
const X_UngrabButton = 29
const X_ChangeActivePointerGrab = 30
const X_GrabKeyboard = 31
const X_UngrabKeyboard = 32
const X_GrabKey = 33
const X_UngrabKey = 34
const X_AllowEvents = 35
const X_GrabServer = 36
const X_UngrabServer = 37
const X_QueryPointer = 38
const X_GetMotionEvents = 39
const X_TranslateCoords = 40
const X_WarpPointer = 41
const X_SetInputFocus = 42
const X_GetInputFocus = 43
const X_QueryKeymap = 44
const X_OpenFont = 45
const X_CloseFont = 46
const X_QueryFont = 47
const X_QueryTextExtents = 48
const X_ListFonts = 49
const X_ListFontsWithInfo = 50
const X_SetFontPath = 51
const X_GetFontPath = 52
const X_CreatePixmap = 53
const X_FreePixmap = 54
const X_CreateGC = 55
const X_ChangeGC = 56
const X_CopyGC = 57
const X_SetDashes = 58
const X_SetClipRectangles = 59
const X_FreeGC = 60
const X_ClearArea = 61
const X_CopyArea = 62
const X_CopyPlane = 63
const X_PolyPoint = 64
const X_PolyLine = 65
const X_PolySegment = 66
const X_PolyRectangle = 67
const X_PolyArc = 68
const X_FillPoly = 69
const X_PolyFillRectangle = 70
const X_PolyFillArc = 71
const X_PutImage = 72
const X_GetImage = 73
const X_PolyText8 = 74
const X_PolyText16 = 75
const X_ImageText8 = 76
const X_ImageText16 = 77
const X_CreateColormap = 78
const X_FreeColormap = 79
const X_CopyColormapAndFree = 80
const X_InstallColormap = 81
const X_UninstallColormap = 82
const X_ListInstalledColormaps = 83
const X_AllocColor = 84
const X_AllocNamedColor = 85
const X_AllocColorCells = 86
const X_AllocColorPlanes = 87
const X_FreeColors = 88
const X_StoreColors = 89
const X_StoreNamedColor = 90
const X_QueryColors = 91
const X_LookupColor = 92
const X_CreateCursor = 93
const X_CreateGlyphCursor = 94
const X_FreeCursor = 95
const X_RecolorCursor = 96
const X_QueryBestSize = 97
const X_QueryExtension = 98
const X_ListExtensions = 99
const X_ChangeKeyboardMapping = 100
const X_GetKeyboardMapping = 101
const X_ChangeKeyboardControl = 102
const X_GetKeyboardControl = 103
const X_Bell = 104
const X_ChangePointerControl = 105
const X_GetPointerControl = 106
const X_SetScreenSaver = 107
const X_GetScreenSaver = 108
const X_ChangeHosts = 109
const X_ListHosts = 110
const X_SetAccessControl = 111
const X_SetCloseDownMode = 112
const X_KillClient = 113
const X_RotateProperties = 114
const X_ForceScreenSaver = 115
const X_SetPointerMapping = 116
const X_GetPointerMapping = 117
const X_SetModifierMapping = 118
const X_GetModifierMapping = 119
const X_NoOperation = 127
