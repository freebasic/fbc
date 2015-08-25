'' FreeBASIC binding for randrproto-1.4.1
''
'' based on the C header files:
''    Copyright © 2000 Compaq Computer Corporation
''    Copyright © 2002 Hewlett-Packard Company
''    Copyright © 2006 Intel Corporation
''    Copyright © 2008 Red Hat, Inc.
''
''    Permission to use, copy, modify, distribute, and sell this software and its
''    documentation for any purpose is hereby granted without fee, provided that
''    the above copyright notice appear in all copies and that both that copyright
''    notice and this permission notice appear in supporting documentation, and
''    that the name of the copyright holders not be used in advertising or
''    publicity pertaining to distribution of the software without specific,
''    written prior permission.  The copyright holders make no representations
''    about the suitability of this software for any purpose.  It is provided "as
''    is" without express or implied warranty.
''
''    THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''    INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''    EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''    DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
''    OF THIS SOFTWARE.
''
''    Author:  Jim Gettys, Hewlett-Packard Company, Inc.
''   	    Keith Packard, Intel Corporation
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/randr.bi"
#include once "X11/extensions/renderproto.bi"

'' The following symbols have been renamed:
''     struct _xRRModeInfo => _xRRModeInfo_
''     typedef xRRModeInfo => xRRModeInfo_
''     struct xRRScreenChangeNotifyEvent => xRRScreenChangeNotifyEvent_
''     struct xRRCrtcChangeNotifyEvent => xRRCrtcChangeNotifyEvent_
''     struct xRROutputChangeNotifyEvent => xRROutputChangeNotifyEvent_
''     struct xRROutputPropertyNotifyEvent => xRROutputPropertyNotifyEvent_
''     struct xRRProviderChangeNotifyEvent => xRRProviderChangeNotifyEvent_
''     struct xRRProviderPropertyNotifyEvent => xRRProviderPropertyNotifyEvent_
''     struct xRRResourceChangeNotifyEvent => xRRResourceChangeNotifyEvent_

#define _XRANDRP_H_

type xScreenSizes
	widthInPixels as CARD16
	heightInPixels as CARD16
	widthInMillimeters as CARD16
	heightInMillimeters as CARD16
end type

const sz_xScreenSizes = 8

type xRRQueryVersionReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	majorVersion as CARD32
	minorVersion as CARD32
end type

const sz_xRRQueryVersionReq = 12

type xRRQueryVersionReply
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

const sz_xRRQueryVersionReply = 32

type xRRGetScreenInfoReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xRRGetScreenInfoReq = 8

type xRRGetScreenInfoReply
	as UBYTE type
	setOfRotations as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	root as CARD32
	timestamp as CARD32
	configTimestamp as CARD32
	nSizes as CARD16
	sizeID as CARD16
	rotation as CARD16
	rate as CARD16
	nrateEnts as CARD16
	pad as CARD16
end type

const sz_xRRGetScreenInfoReply = 32

type xRR1_0SetScreenConfigReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	drawable as CARD32
	timestamp as CARD32
	configTimestamp as CARD32
	sizeID as CARD16
	rotation as CARD16
end type

const sz_xRR1_0SetScreenConfigReq = 20

type xRRSetScreenConfigReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	drawable as CARD32
	timestamp as CARD32
	configTimestamp as CARD32
	sizeID as CARD16
	rotation as CARD16
	rate as CARD16
	pad as CARD16
end type

const sz_xRRSetScreenConfigReq = 24

type xRRSetScreenConfigReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	newTimestamp as CARD32
	newConfigTimestamp as CARD32
	root as CARD32
	subpixelOrder as CARD16
	pad4 as CARD16
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRSetScreenConfigReply = 32

type xRRSelectInputReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
	enable as CARD16
	pad2 as CARD16
end type

const sz_xRRSelectInputReq = 12

type _xRRModeInfo_
	id as CARD32
	width as CARD16
	height as CARD16
	dotClock as CARD32
	hSyncStart as CARD16
	hSyncEnd as CARD16
	hTotal as CARD16
	hSkew as CARD16
	vSyncStart as CARD16
	vSyncEnd as CARD16
	vTotal as CARD16
	nameLength as CARD16
	modeFlags as CARD32
end type

type xRRModeInfo_ as _xRRModeInfo_
const sz_xRRModeInfo = 32

type xRRGetScreenSizeRangeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xRRGetScreenSizeRangeReq = 8

type xRRGetScreenSizeRangeReply
	as UBYTE type
	pad as CARD8
	sequenceNumber as CARD16
	length as CARD32
	minWidth as CARD16
	minHeight as CARD16
	maxWidth as CARD16
	maxHeight as CARD16
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

const sz_xRRGetScreenSizeRangeReply = 32

type xRRSetScreenSizeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
	width as CARD16
	height as CARD16
	widthInMillimeters as CARD32
	heightInMillimeters as CARD32
end type

const sz_xRRSetScreenSizeReq = 20

type xRRGetScreenResourcesReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xRRGetScreenResourcesReq = 8

type xRRGetScreenResourcesReply
	as UBYTE type
	pad as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	configTimestamp as CARD32
	nCrtcs as CARD16
	nOutputs as CARD16
	nModes as CARD16
	nbytesNames as CARD16
	pad1 as CARD32
	pad2 as CARD32
end type

const sz_xRRGetScreenResourcesReply = 32

type xRRGetOutputInfoReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	configTimestamp as CARD32
end type

const sz_xRRGetOutputInfoReq = 12

type xRRGetOutputInfoReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	crtc as CARD32
	mmWidth as CARD32
	mmHeight as CARD32
	connection as CARD8
	subpixelOrder as CARD8
	nCrtcs as CARD16
	nModes as CARD16
	nPreferred as CARD16
	nClones as CARD16
	nameLength as CARD16
end type

const sz_xRRGetOutputInfoReply = 36

type xRRListOutputPropertiesReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
end type

const sz_xRRListOutputPropertiesReq = 8

type xRRListOutputPropertiesReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	nAtoms as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRListOutputPropertiesReply = 32

type xRRQueryOutputPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	property as CARD32
end type

const sz_xRRQueryOutputPropertyReq = 12

type xRRQueryOutputPropertyReply
	as UBYTE type
	pad0 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	pending as XBOOL
	range as XBOOL
	immutable as XBOOL
	pad1 as UBYTE
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRQueryOutputPropertyReply = 32

type xRRConfigureOutputPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	property as CARD32
	pending as XBOOL
	range as XBOOL
	pad as CARD16
end type

const sz_xRRConfigureOutputPropertyReq = 16

type xRRChangeOutputPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	property as CARD32
	as CARD32 type
	format as CARD8
	mode as CARD8
	pad as CARD16
	nUnits as CARD32
end type

const sz_xRRChangeOutputPropertyReq = 24

type xRRDeleteOutputPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	property as CARD32
end type

const sz_xRRDeleteOutputPropertyReq = 12

type xRRGetOutputPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	property as CARD32
	as CARD32 type
	longOffset as CARD32
	longLength as CARD32
	delete_ as XBOOL
	pending as XBOOL
	pad1 as CARD16
end type

const sz_xRRGetOutputPropertyReq = 28

type xRRGetOutputPropertyReply
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

const sz_xRRGetOutputPropertyReply = 32

type xRRCreateModeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
	modeInfo as xRRModeInfo_
end type

const sz_xRRCreateModeReq = 40

type xRRCreateModeReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	mode as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRCreateModeReply = 32

type xRRDestroyModeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	mode as CARD32
end type

const sz_xRRDestroyModeReq = 8

type xRRAddOutputModeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	mode as CARD32
end type

const sz_xRRAddOutputModeReq = 12

type xRRDeleteOutputModeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	output as CARD32
	mode as CARD32
end type

const sz_xRRDeleteOutputModeReq = 12

type xRRGetCrtcInfoReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
	configTimestamp as CARD32
end type

const sz_xRRGetCrtcInfoReq = 12

type xRRGetCrtcInfoReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	mode as CARD32
	rotation as CARD16
	rotations as CARD16
	nOutput as CARD16
	nPossibleOutput as CARD16
end type

const sz_xRRGetCrtcInfoReply = 32

type xRRSetCrtcConfigReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
	timestamp as CARD32
	configTimestamp as CARD32
	x as INT16
	y as INT16
	mode as CARD32
	rotation as CARD16
	pad as CARD16
end type

const sz_xRRSetCrtcConfigReq = 28

type xRRSetCrtcConfigReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	newTimestamp as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRSetCrtcConfigReply = 32

type xRRGetCrtcGammaSizeReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
end type

const sz_xRRGetCrtcGammaSizeReq = 8

type xRRGetCrtcGammaSizeReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	size as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRGetCrtcGammaSizeReply = 32

type xRRGetCrtcGammaReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
end type

const sz_xRRGetCrtcGammaReq = 8

type xRRGetCrtcGammaReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	size as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRGetCrtcGammaReply = 32

type xRRSetCrtcGammaReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
	size as CARD16
	pad1 as CARD16
end type

const sz_xRRSetCrtcGammaReq = 12
type xRRGetScreenResourcesCurrentReq as xRRGetScreenResourcesReq
const sz_xRRGetScreenResourcesCurrentReq = sz_xRRGetScreenResourcesReq
type xRRGetScreenResourcesCurrentReply as xRRGetScreenResourcesReply
const sz_xRRGetScreenResourcesCurrentReply = sz_xRRGetScreenResourcesReply

type xRRSetCrtcTransformReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
	transform as xRenderTransform
	nbytesFilter as CARD16
	pad as CARD16
end type

const sz_xRRSetCrtcTransformReq = 48

type xRRGetCrtcTransformReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
end type

const sz_xRRGetCrtcTransformReq = 8

type xRRGetCrtcTransformReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pendingTransform as xRenderTransform
	hasTransforms as UBYTE
	pad0 as CARD8
	pad1 as CARD16
	currentTransform as xRenderTransform
	pad2 as CARD32
	pendingNbytesFilter as CARD16
	pendingNparamsFilter as CARD16
	currentNbytesFilter as CARD16
	currentNparamsFilter as CARD16
end type

const sz_xRRGetCrtcTransformReply = 96

type xRRSetOutputPrimaryReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
	output as CARD32
end type

const sz_xRRSetOutputPrimaryReq = 12

type xRRGetOutputPrimaryReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xRRGetOutputPrimaryReq = 8

type xRRGetOutputPrimaryReply
	as UBYTE type
	pad as CARD8
	sequenceNumber as CARD16
	length as CARD32
	output as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRGetOutputPrimaryReply = 32

type xRRGetProvidersReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	window as CARD32
end type

const sz_xRRGetProvidersReq = 8

type xRRGetProvidersReply
	as UBYTE type
	pad as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	nProviders as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRGetProvidersReply = 32

type xRRGetProviderInfoReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	configTimestamp as CARD32
end type

const sz_xRRGetProviderInfoReq = 12

type xRRGetProviderInfoReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	capabilities as CARD32
	nCrtcs as CARD16
	nOutputs as CARD16
	nAssociatedProviders as CARD16
	nameLength as CARD16
	pad1 as CARD32
	pad2 as CARD32
end type

const sz_xRRGetProviderInfoReply = 32

type xRRSetProviderOutputSourceReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	source_provider as CARD32
	configTimestamp as CARD32
end type

const sz_xRRSetProviderOutputSourceReq = 16

type xRRSetProviderOffloadSinkReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	sink_provider as CARD32
	configTimestamp as CARD32
end type

const sz_xRRSetProviderOffloadSinkReq = 16

type xRRListProviderPropertiesReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
end type

const sz_xRRListProviderPropertiesReq = 8

type xRRListProviderPropertiesReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	nAtoms as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRListProviderPropertiesReply = 32

type xRRQueryProviderPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	property as CARD32
end type

const sz_xRRQueryProviderPropertyReq = 12

type xRRQueryProviderPropertyReply
	as UBYTE type
	pad0 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	pending as XBOOL
	range as XBOOL
	immutable as XBOOL
	pad1 as UBYTE
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xRRQueryProviderPropertyReply = 32

type xRRConfigureProviderPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	property as CARD32
	pending as XBOOL
	range as XBOOL
	pad as CARD16
end type

const sz_xRRConfigureProviderPropertyReq = 16

type xRRChangeProviderPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	property as CARD32
	as CARD32 type
	format as CARD8
	mode as CARD8
	pad as CARD16
	nUnits as CARD32
end type

const sz_xRRChangeProviderPropertyReq = 24

type xRRDeleteProviderPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	property as CARD32
end type

const sz_xRRDeleteProviderPropertyReq = 12

type xRRGetProviderPropertyReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	provider as CARD32
	property as CARD32
	as CARD32 type
	longOffset as CARD32
	longLength as CARD32
	delete_ as XBOOL
	pending as XBOOL
	pad1 as CARD16
end type

const sz_xRRGetProviderPropertyReq = 28

type xRRGetProviderPropertyReply
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

const sz_xRRGetProviderPropertyReply = 32

type xRRScreenChangeNotifyEvent_
	as CARD8 type
	rotation as CARD8
	sequenceNumber as CARD16
	timestamp as CARD32
	configTimestamp as CARD32
	root as CARD32
	window as CARD32
	sizeID as CARD16
	subpixelOrder as CARD16
	widthInPixels as CARD16
	heightInPixels as CARD16
	widthInMillimeters as CARD16
	heightInMillimeters as CARD16
end type

const sz_xRRScreenChangeNotifyEvent = 32

type xRRCrtcChangeNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	timestamp as CARD32
	window as CARD32
	crtc as CARD32
	mode as CARD32
	rotation as CARD16
	pad1 as CARD16
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
end type

const sz_xRRCrtcChangeNotifyEvent = 32

type xRROutputChangeNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	timestamp as CARD32
	configTimestamp as CARD32
	window as CARD32
	output as CARD32
	crtc as CARD32
	mode as CARD32
	rotation as CARD16
	connection as CARD8
	subpixelOrder as CARD8
end type

const sz_xRROutputChangeNotifyEvent = 32

type xRROutputPropertyNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	window as CARD32
	output as CARD32
	atom as CARD32
	timestamp as CARD32
	state as CARD8
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xRROutputPropertyNotifyEvent = 32

type xRRProviderChangeNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	timestamp as CARD32
	window as CARD32
	provider as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xRRProviderChangeNotifyEvent = 32

type xRRProviderPropertyNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	window as CARD32
	provider as CARD32
	atom as CARD32
	timestamp as CARD32
	state as CARD8
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xRRProviderPropertyNotifyEvent = 32

type xRRResourceChangeNotifyEvent_
	as CARD8 type
	subCode as CARD8
	sequenceNumber as CARD16
	timestamp as CARD32
	window as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRResourceChangeNotifyEvent = 32

type xRRGetPanningReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
end type

const sz_xRRGetPanningReq = 8

type xRRGetPanningReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	timestamp as CARD32
	left as CARD16
	top as CARD16
	width as CARD16
	height as CARD16
	track_left as CARD16
	track_top as CARD16
	track_width as CARD16
	track_height as CARD16
	border_left as INT16
	border_top as INT16
	border_right as INT16
	border_bottom as INT16
end type

const sz_xRRGetPanningReply = 36

type xRRSetPanningReq
	reqType as CARD8
	randrReqType as CARD8
	length as CARD16
	crtc as CARD32
	timestamp as CARD32
	left as CARD16
	top as CARD16
	width as CARD16
	height as CARD16
	track_left as CARD16
	track_top as CARD16
	track_width as CARD16
	track_height as CARD16
	border_left as INT16
	border_top as INT16
	border_right as INT16
	border_bottom as INT16
end type

const sz_xRRSetPanningReq = 36

type xRRSetPanningReply
	as UBYTE type
	status as CARD8
	sequenceNumber as CARD16
	length as CARD32
	newTimestamp as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xRRSetPanningReply = 32
