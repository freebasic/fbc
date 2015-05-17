'' FreeBASIC binding for kbproto-1.0.6
''
'' based on the C header files:
''   **********************************************************
''   Copyright (c) 1993 by Silicon Graphics Computer Systems, Inc.
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be 
''   used in advertising or publicity pertaining to distribution 
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability 
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL 
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, 
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE 
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xmd.bi"
#include once "X11/extensions/XKB.bi"

'' The following symbols have been renamed:
''     struct _xkbAnyEvent => _xkbAnyEvent_
''     typedef xkbAnyEvent => xkbAnyEvent_
''     struct _xkbNewKeyboardNotify => _xkbNewKeyboardNotify_
''     typedef xkbNewKeyboardNotify => xkbNewKeyboardNotify_
''     struct _xkbControlsNotify => _xkbControlsNotify_
''     typedef xkbControlsNotify => xkbControlsNotify_
''     struct _xkbIndicatorNotify => _xkbIndicatorNotify_
''     typedef xkbIndicatorNotify => xkbIndicatorNotify_
''     struct _xkbNamesNotify => _xkbNamesNotify_
''     typedef xkbNamesNotify => xkbNamesNotify_
''     struct _xkbCompatMapNotify => _xkbCompatMapNotify_
''     typedef xkbCompatMapNotify => xkbCompatMapNotify_
''     struct _xkbBellNotify => _xkbBellNotify_
''     typedef xkbBellNotify => xkbBellNotify_
''     struct _xkbActionMessage => _xkbActionMessage_
''     typedef xkbActionMessage => xkbActionMessage_
''     struct _xkbAccessXNotify => _xkbAccessXNotify_
''     typedef xkbAccessXNotify => xkbAccessXNotify_
''     struct _xkbExtensionDeviceNotify => _xkbExtensionDeviceNotify_
''     typedef xkbExtensionDeviceNotify => xkbExtensionDeviceNotify_
''     struct _xkbEvent => _xkbEvent_
''     typedef xkbEvent => xkbEvent_

#define _XKBPROTO_H_
#define XkbPaddedSize(n) culng(culng(culng(culng(n) + 3) shr 2) shl 2)

type _xkbUseExtension
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	wantedMajor as CARD16
	wantedMinor as CARD16
end type

type xkbUseExtensionReq as _xkbUseExtension
const sz_xkbUseExtensionReq = 8

type _xkbUseExtensionReply
	as UBYTE type
	supported as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	serverMajor as CARD16
	serverMinor as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xkbUseExtensionReply as _xkbUseExtensionReply
const sz_xkbUseExtensionReply = 32

type _xkbSelectEvents
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	affectWhich as CARD16
	clear as CARD16
	selectAll as CARD16
	affectMap as CARD16
	map as CARD16
end type

type xkbSelectEventsReq as _xkbSelectEvents
const sz_xkbSelectEventsReq = 16

type _xkbBell
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	bellClass as CARD16
	bellID as CARD16
	percent as INT8
	forceSound as XBOOL
	eventOnly as XBOOL
	pad1 as CARD8
	pitch as INT16
	duration as INT16
	pad2 as CARD16
	name as CARD32
	window as CARD32
end type

type xkbBellReq as _xkbBell
const sz_xkbBellReq = 28

type _xkbGetState
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad as CARD16
end type

type xkbGetStateReq as _xkbGetState
const sz_xkbGetStateReq = 8

type _xkbGetStateReply
	as UBYTE type
	deviceID as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	mods as CARD8
	baseMods as CARD8
	latchedMods as CARD8
	lockedMods as CARD8
	group as CARD8
	lockedGroup as CARD8
	baseGroup as INT16
	latchedGroup as INT16
	compatState as CARD8
	grabMods as CARD8
	compatGrabMods as CARD8
	lookupMods as CARD8
	compatLookupMods as CARD8
	pad1 as CARD8
	ptrBtnState as CARD16
	pad2 as CARD16
	pad3 as CARD32
end type

type xkbGetStateReply as _xkbGetStateReply
const sz_xkbGetStateReply = 32

type _xkbLatchLockState
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	affectModLocks as CARD8
	modLocks as CARD8
	lockGroup as XBOOL
	groupLock as CARD8
	affectModLatches as CARD8
	modLatches as CARD8
	pad as CARD8
	latchGroup as XBOOL
	groupLatch as INT16
end type

type xkbLatchLockStateReq as _xkbLatchLockState
const sz_xkbLatchLockStateReq = 16

type _xkbGetControls
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad as CARD16
end type

type xkbGetControlsReq as _xkbGetControls
const sz_xkbGetControlsReq = 8

type _xkbGetControlsReply
	as UBYTE type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	mkDfltBtn as CARD8
	numGroups as CARD8
	groupsWrap as CARD8
	internalMods as CARD8
	ignoreLockMods as CARD8
	internalRealMods as CARD8
	ignoreLockRealMods as CARD8
	pad1 as CARD8
	internalVMods as CARD16
	ignoreLockVMods as CARD16
	repeatDelay as CARD16
	repeatInterval as CARD16
	slowKeysDelay as CARD16
	debounceDelay as CARD16
	mkDelay as CARD16
	mkInterval as CARD16
	mkTimeToMax as CARD16
	mkMaxSpeed as CARD16
	mkCurve as INT16
	axOptions as CARD16
	axTimeout as CARD16
	axtOptsMask as CARD16
	axtOptsValues as CARD16
	pad2 as CARD16
	axtCtrlsMask as CARD32
	axtCtrlsValues as CARD32
	enabledCtrls as CARD32
	perKeyRepeat(0 to ((255 + 1) / 8) - 1) as UBYTE
end type

type xkbGetControlsReply as _xkbGetControlsReply
const sz_xkbGetControlsReply = 92

type _xkbSetControls
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	affectInternalMods as CARD8
	internalMods as CARD8
	affectIgnoreLockMods as CARD8
	ignoreLockMods as CARD8
	affectInternalVMods as CARD16
	internalVMods as CARD16
	affectIgnoreLockVMods as CARD16
	ignoreLockVMods as CARD16
	mkDfltBtn as CARD8
	groupsWrap as CARD8
	axOptions as CARD16
	pad1 as CARD16
	affectEnabledCtrls as CARD32
	enabledCtrls as CARD32
	changeCtrls as CARD32
	repeatDelay as CARD16
	repeatInterval as CARD16
	slowKeysDelay as CARD16
	debounceDelay as CARD16
	mkDelay as CARD16
	mkInterval as CARD16
	mkTimeToMax as CARD16
	mkMaxSpeed as CARD16
	mkCurve as INT16
	axTimeout as CARD16
	axtCtrlsMask as CARD32
	axtCtrlsValues as CARD32
	axtOptsMask as CARD16
	axtOptsValues as CARD16
	perKeyRepeat(0 to ((255 + 1) / 8) - 1) as UBYTE
end type

type xkbSetControlsReq as _xkbSetControls
const sz_xkbSetControlsReq = 100

type _xkbKTMapEntryWireDesc
	active as XBOOL
	mask as CARD8
	level as CARD8
	realMods as CARD8
	virtualMods as CARD16
	pad as CARD16
end type

type xkbKTMapEntryWireDesc as _xkbKTMapEntryWireDesc
const sz_xkbKTMapEntryWireDesc = 8

type _xkbKTSetMapEntryWireDesc
	level as CARD8
	realMods as CARD8
	virtualMods as CARD16
end type

type xkbKTSetMapEntryWireDesc as _xkbKTSetMapEntryWireDesc
const sz_xkbKTSetMapEntryWireDesc = 4

type _xkbModsWireDesc
	mask as CARD8
	realMods as CARD8
	virtualMods as CARD16
end type

type xkbModsWireDesc as _xkbModsWireDesc
const sz_xkbModsWireDesc = 4

type _xkbKeyTypeWireDesc
	mask as CARD8
	realMods as CARD8
	virtualMods as CARD16
	numLevels as CARD8
	nMapEntries as CARD8
	preserve as XBOOL
	pad as CARD8
end type

type xkbKeyTypeWireDesc as _xkbKeyTypeWireDesc
const sz_xkbKeyTypeWireDesc = 8

type _xkbSymMapWireDesc
	ktIndex(0 to 3) as CARD8
	groupInfo as CARD8
	width as CARD8
	nSyms as CARD16
end type

type xkbSymMapWireDesc as _xkbSymMapWireDesc
const sz_xkbSymMapWireDesc = 8

type _xkbVModMapWireDesc
	key as CARD8
	pad as CARD8
	vmods as CARD16
end type

type xkbVModMapWireDesc as _xkbVModMapWireDesc
const sz_xkbVModMapWireDesc = 4

type _xkbBehaviorWireDesc
	key as CARD8
	as CARD8 type
	data as CARD8
	pad as CARD8
end type

type xkbBehaviorWireDesc as _xkbBehaviorWireDesc
const sz_xkbBehaviorWireDesc = 4

type _xkbActionWireDesc
	as CARD8 type
	data(0 to 6) as CARD8
end type

type xkbActionWireDesc as _xkbActionWireDesc
const sz_xkbActionWireDesc = 8

type _xkbGetMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	full as CARD16
	partial as CARD16
	firstType as CARD8
	nTypes as CARD8
	firstKeySym as CARD8
	nKeySyms as CARD8
	firstKeyAct as CARD8
	nKeyActs as CARD8
	firstKeyBehavior as CARD8
	nKeyBehaviors as CARD8
	virtualMods as CARD16
	firstKeyExplicit as CARD8
	nKeyExplicit as CARD8
	firstModMapKey as CARD8
	nModMapKeys as CARD8
	firstVModMapKey as CARD8
	nVModMapKeys as CARD8
	pad1 as CARD16
end type

type xkbGetMapReq as _xkbGetMap
const sz_xkbGetMapReq = 28

type _xkbGetMapReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad1 as CARD16
	minKeyCode as CARD8
	maxKeyCode as CARD8
	present as CARD16
	firstType as CARD8
	nTypes as CARD8
	totalTypes as CARD8
	firstKeySym as CARD8
	totalSyms as CARD16
	nKeySyms as CARD8
	firstKeyAct as CARD8
	totalActs as CARD16
	nKeyActs as CARD8
	firstKeyBehavior as CARD8
	nKeyBehaviors as CARD8
	totalKeyBehaviors as CARD8
	firstKeyExplicit as CARD8
	nKeyExplicit as CARD8
	totalKeyExplicit as CARD8
	firstModMapKey as CARD8
	nModMapKeys as CARD8
	totalModMapKeys as CARD8
	firstVModMapKey as CARD8
	nVModMapKeys as CARD8
	totalVModMapKeys as CARD8
	pad2 as CARD8
	virtualMods as CARD16
end type

type xkbGetMapReply as _xkbGetMapReply
const sz_xkbGetMapReply = 40
const XkbSetMapResizeTypes = cast(clong, 1) shl 0
const XkbSetMapRecomputeActions = cast(clong, 1) shl 1
const XkbSetMapAllFlags = &h3

type _xkbSetMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	present as CARD16
	flags as CARD16
	minKeyCode as CARD8
	maxKeyCode as CARD8
	firstType as CARD8
	nTypes as CARD8
	firstKeySym as CARD8
	nKeySyms as CARD8
	totalSyms as CARD16
	firstKeyAct as CARD8
	nKeyActs as CARD8
	totalActs as CARD16
	firstKeyBehavior as CARD8
	nKeyBehaviors as CARD8
	totalKeyBehaviors as CARD8
	firstKeyExplicit as CARD8
	nKeyExplicit as CARD8
	totalKeyExplicit as CARD8
	firstModMapKey as CARD8
	nModMapKeys as CARD8
	totalModMapKeys as CARD8
	firstVModMapKey as CARD8
	nVModMapKeys as CARD8
	totalVModMapKeys as CARD8
	virtualMods as CARD16
end type

type xkbSetMapReq as _xkbSetMap
const sz_xkbSetMapReq = 36

type _xkbSymInterpretWireDesc
	sym as CARD32
	mods as CARD8
	match as CARD8
	virtualMod as CARD8
	flags as CARD8
	act as xkbActionWireDesc
end type

type xkbSymInterpretWireDesc as _xkbSymInterpretWireDesc
const sz_xkbSymInterpretWireDesc = 16

type _xkbGetCompatMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	groups as CARD8
	getAllSI as XBOOL
	firstSI as CARD16
	nSI as CARD16
end type

type xkbGetCompatMapReq as _xkbGetCompatMap
const sz_xkbGetCompatMapReq = 12

type _xkbGetCompatMapReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	groups as CARD8
	pad1 as CARD8
	firstSI as CARD16
	nSI as CARD16
	nTotalSI as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xkbGetCompatMapReply as _xkbGetCompatMapReply
const sz_xkbGetCompatMapReply = 32

type _xkbSetCompatMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad1 as CARD8
	recomputeActions as XBOOL
	truncateSI as XBOOL
	groups as CARD8
	firstSI as CARD16
	nSI as CARD16
	pad2 as CARD16
end type

type xkbSetCompatMapReq as _xkbSetCompatMap
const sz_xkbSetCompatMapReq = 16

type _xkbGetIndicatorState
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad1 as CARD16
end type

type xkbGetIndicatorStateReq as _xkbGetIndicatorState
const sz_xkbGetIndicatorStateReq = 8

type _xkbGetIndicatorStateReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	state as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xkbGetIndicatorStateReply as _xkbGetIndicatorStateReply
const sz_xkbGetIndicatorStateReply = 32

type _xkbGetIndicatorMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad as CARD16
	which as CARD32
end type

type xkbGetIndicatorMapReq as _xkbGetIndicatorMap
const sz_xkbGetIndicatorMapReq = 12

type _xkbGetIndicatorMapReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	which as CARD32
	realIndicators as CARD32
	nIndicators as CARD8
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xkbGetIndicatorMapReply as _xkbGetIndicatorMapReply
const sz_xkbGetIndicatorMapReply = 32

type _xkbIndicatorMapWireDesc
	flags as CARD8
	whichGroups as CARD8
	groups as CARD8
	whichMods as CARD8
	mods as CARD8
	realMods as CARD8
	virtualMods as CARD16
	ctrls as CARD32
end type

type xkbIndicatorMapWireDesc as _xkbIndicatorMapWireDesc
const sz_xkbIndicatorMapWireDesc = 12

type _xkbSetIndicatorMap
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad1 as CARD16
	which as CARD32
end type

type xkbSetIndicatorMapReq as _xkbSetIndicatorMap
const sz_xkbSetIndicatorMapReq = 12

type _xkbGetNamedIndicator
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	ledClass as CARD16
	ledID as CARD16
	pad1 as CARD16
	indicator as CARD32
end type

type xkbGetNamedIndicatorReq as _xkbGetNamedIndicator
const sz_xkbGetNamedIndicatorReq = 16

type _xkbGetNamedIndicatorReply
	as UBYTE type
	deviceID as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	indicator as CARD32
	found as XBOOL
	on as XBOOL
	realIndicator as XBOOL
	ndx as CARD8
	flags as CARD8
	whichGroups as CARD8
	groups as CARD8
	whichMods as CARD8
	mods as CARD8
	realMods as CARD8
	virtualMods as CARD16
	ctrls as CARD32
	supported as XBOOL
	pad1 as CARD8
	pad2 as CARD16
end type

type xkbGetNamedIndicatorReply as _xkbGetNamedIndicatorReply
const sz_xkbGetNamedIndicatorReply = 32

type _xkbSetNamedIndicator
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	ledClass as CARD16
	ledID as CARD16
	pad1 as CARD16
	indicator as CARD32
	setState as XBOOL
	on as XBOOL
	setMap as XBOOL
	createMap as XBOOL
	pad2 as CARD8
	flags as CARD8
	whichGroups as CARD8
	groups as CARD8
	whichMods as CARD8
	realMods as CARD8
	virtualMods as CARD16
	ctrls as CARD32
end type

type xkbSetNamedIndicatorReq as _xkbSetNamedIndicator
const sz_xkbSetNamedIndicatorReq = 32

type _xkbGetNames
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad as CARD16
	which as CARD32
end type

type xkbGetNamesReq as _xkbGetNames
const sz_xkbGetNamesReq = 12

type _xkbGetNamesReply
	as UBYTE type
	deviceID as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	which as CARD32
	minKeyCode as CARD8
	maxKeyCode as CARD8
	nTypes as CARD8
	groupNames as CARD8
	virtualMods as CARD16
	firstKey as CARD8
	nKeys as CARD8
	indicators as CARD32
	nRadioGroups as CARD8
	nKeyAliases as CARD8
	nKTLevels as CARD16
	pad3 as CARD32
end type

type xkbGetNamesReply as _xkbGetNamesReply
const sz_xkbGetNamesReply = 32

type _xkbSetNames
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	virtualMods as CARD16
	which as CARD32
	firstType as CARD8
	nTypes as CARD8
	firstKTLevel as CARD8
	nKTLevels as CARD8
	indicators as CARD32
	groupNames as CARD8
	nRadioGroups as CARD8
	firstKey as CARD8
	nKeys as CARD8
	nKeyAliases as CARD8
	pad1 as CARD8
	totalKTLevelNames as CARD16
end type

type xkbSetNamesReq as _xkbSetNames
const sz_xkbSetNamesReq = 28

type _xkbPointWireDesc
	x as INT16
	y as INT16
end type

type xkbPointWireDesc as _xkbPointWireDesc
const sz_xkbPointWireDesc = 4

type _xkbOutlineWireDesc
	nPoints as CARD8
	cornerRadius as CARD8
	pad as CARD16
end type

type xkbOutlineWireDesc as _xkbOutlineWireDesc
const sz_xkbOutlineWireDesc = 4

type _xkbShapeWireDesc
	name as CARD32
	nOutlines as CARD8
	primaryNdx as CARD8
	approxNdx as CARD8
	pad as CARD8
end type

type xkbShapeWireDesc as _xkbShapeWireDesc
const sz_xkbShapeWireDesc = 8

type _xkbSectionWireDesc
	name as CARD32
	top as INT16
	left as INT16
	width as CARD16
	height as CARD16
	angle as INT16
	priority as CARD8
	nRows as CARD8
	nDoodads as CARD8
	nOverlays as CARD8
	pad as CARD16
end type

type xkbSectionWireDesc as _xkbSectionWireDesc
const sz_xkbSectionWireDesc = 20

type _xkbRowWireDesc
	top as INT16
	left as INT16
	nKeys as CARD8
	vertical as XBOOL
	pad as CARD16
end type

type xkbRowWireDesc as _xkbRowWireDesc
const sz_xkbRowWireDesc = 8

type _xkbKeyWireDesc
	name(0 to 3) as CARD8
	gap as INT16
	shapeNdx as CARD8
	colorNdx as CARD8
end type

type xkbKeyWireDesc as _xkbKeyWireDesc
const sz_xkbKeyWireDesc = 8

type _xkbOverlayWireDesc
	name as CARD32
	nRows as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

type xkbOverlayWireDesc as _xkbOverlayWireDesc
const sz_xkbOverlayWireDesc = 8

type _xkbOverlayRowWireDesc
	rowUnder as CARD8
	nKeys as CARD8
	pad1 as CARD16
end type

type xkbOverlayRowWireDesc as _xkbOverlayRowWireDesc
const sz_xkbOverlayRowWireDesc = 4

type _xkbOverlayKeyWireDesc
	over(0 to 3) as CARD8
	under(0 to 3) as CARD8
end type

type xkbOverlayKeyWireDesc as _xkbOverlayKeyWireDesc
const sz_xkbOverlayKeyWireDesc = 8

type _xkbShapeDoodadWireDesc
	name as CARD32
	as CARD8 type
	priority as CARD8
	top as INT16
	left as INT16
	angle as INT16
	colorNdx as CARD8
	shapeNdx as CARD8
	pad1 as CARD16
	pad2 as CARD32
end type

type xkbShapeDoodadWireDesc as _xkbShapeDoodadWireDesc
const sz_xkbShapeDoodadWireDesc = 20

type _xkbTextDoodadWireDesc
	name as CARD32
	as CARD8 type
	priority as CARD8
	top as INT16
	left as INT16
	angle as INT16
	width as CARD16
	height as CARD16
	colorNdx as CARD8
	pad1 as CARD8
	pad2 as CARD16
end type

type xkbTextDoodadWireDesc as _xkbTextDoodadWireDesc
const sz_xkbTextDoodadWireDesc = 20

type _xkbIndicatorDoodadWireDesc
	name as CARD32
	as CARD8 type
	priority as CARD8
	top as INT16
	left as INT16
	angle as INT16
	shapeNdx as CARD8
	onColorNdx as CARD8
	offColorNdx as CARD8
	pad1 as CARD8
	pad2 as CARD32
end type

type xkbIndicatorDoodadWireDesc as _xkbIndicatorDoodadWireDesc
const sz_xkbIndicatorDoodadWireDesc = 20

type _xkbLogoDoodadWireDesc
	name as CARD32
	as CARD8 type
	priority as CARD8
	top as INT16
	left as INT16
	angle as INT16
	colorNdx as CARD8
	shapeNdx as CARD8
	pad1 as CARD16
	pad2 as CARD32
end type

type xkbLogoDoodadWireDesc as _xkbLogoDoodadWireDesc
const sz_xkbLogoDoodadWireDesc = 20

type _xkbAnyDoodadWireDesc
	name as CARD32
	as CARD8 type
	priority as CARD8
	top as INT16
	left as INT16
	angle as INT16
	pad2 as CARD32
	pad3 as CARD32
end type

type xkbAnyDoodadWireDesc as _xkbAnyDoodadWireDesc
const sz_xkbAnyDoodadWireDesc = 20

union _xkbDoodadWireDesc
	any as xkbAnyDoodadWireDesc
	shape as xkbShapeDoodadWireDesc
	text as xkbTextDoodadWireDesc
	indicator as xkbIndicatorDoodadWireDesc
	logo as xkbLogoDoodadWireDesc
end union

type xkbDoodadWireDesc as _xkbDoodadWireDesc
const sz_xkbDoodadWireDesc = 20

type _xkbGetGeometry
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad as CARD16
	name as CARD32
end type

type xkbGetGeometryReq as _xkbGetGeometry
const sz_xkbGetGeometryReq = 12

type _xkbGetGeometryReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	name as CARD32
	found as XBOOL
	pad as CARD8
	widthMM as CARD16
	heightMM as CARD16
	nProperties as CARD16
	nColors as CARD16
	nShapes as CARD16
	nSections as CARD16
	nDoodads as CARD16
	nKeyAliases as CARD16
	baseColorNdx as CARD8
	labelColorNdx as CARD8
end type

type xkbGetGeometryReply as _xkbGetGeometryReply
const sz_xkbGetGeometryReply = 32

type _xkbSetGeometry
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	nShapes as CARD8
	nSections as CARD8
	name as CARD32
	widthMM as CARD16
	heightMM as CARD16
	nProperties as CARD16
	nColors as CARD16
	nDoodads as CARD16
	nKeyAliases as CARD16
	baseColorNdx as CARD8
	labelColorNdx as CARD8
	pad as CARD16
end type

type xkbSetGeometryReq as _xkbSetGeometry
const sz_xkbSetGeometryReq = 28

type _xkbPerClientFlags
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	pad1 as CARD16
	change as CARD32
	value as CARD32
	ctrlsToChange as CARD32
	autoCtrls as CARD32
	autoCtrlValues as CARD32
end type

type xkbPerClientFlagsReq as _xkbPerClientFlags
const sz_xkbPerClientFlagsReq = 28

type _xkbPerClientFlagsReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	supported as CARD32
	value as CARD32
	autoCtrls as CARD32
	autoCtrlValues as CARD32
	pad1 as CARD32
	pad2 as CARD32
end type

type xkbPerClientFlagsReply as _xkbPerClientFlagsReply
const sz_xkbPerClientFlagsReply = 32

type _xkbListComponents
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	maxNames as CARD16
end type

type xkbListComponentsReq as _xkbListComponents
const sz_xkbListComponentsReq = 8

type _xkbListComponentsReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	nKeymaps as CARD16
	nKeycodes as CARD16
	nTypes as CARD16
	nCompatMaps as CARD16
	nSymbols as CARD16
	nGeometries as CARD16
	extra as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
end type

type xkbListComponentsReply as _xkbListComponentsReply
const sz_xkbListComponentsReply = 32

type _xkbGetKbdByName
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	need as CARD16
	want as CARD16
	load as XBOOL
	pad as CARD8
end type

type xkbGetKbdByNameReq as _xkbGetKbdByName
const sz_xkbGetKbdByNameReq = 12

type _xkbGetKbdByNameReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	minKeyCode as CARD8
	maxKeyCode as CARD8
	loaded as XBOOL
	newKeyboard as XBOOL
	found as CARD16
	reported as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xkbGetKbdByNameReply as _xkbGetKbdByNameReply
const sz_xkbGetKbdByNameReply = 32

type _xkbDeviceLedsWireDesc
	ledClass as CARD16
	ledID as CARD16
	namesPresent as CARD32
	mapsPresent as CARD32
	physIndicators as CARD32
	state as CARD32
end type

type xkbDeviceLedsWireDesc as _xkbDeviceLedsWireDesc
const sz_xkbDeviceLedsWireDesc = 20

type _xkbGetDeviceInfo
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	wanted as CARD16
	allBtns as XBOOL
	firstBtn as CARD8
	nBtns as CARD8
	pad as CARD8
	ledClass as CARD16
	ledID as CARD16
end type

type xkbGetDeviceInfoReq as _xkbGetDeviceInfo
const sz_xkbGetDeviceInfoReq = 16

type _xkbGetDeviceInfoReply
	as CARD8 type
	deviceID as CARD8
	sequenceNumber as CARD16
	length as CARD32
	present as CARD16
	supported as CARD16
	unsupported as CARD16
	nDeviceLedFBs as CARD16
	firstBtnWanted as CARD8
	nBtnsWanted as CARD8
	firstBtnRtrn as CARD8
	nBtnsRtrn as CARD8
	totalBtns as CARD8
	hasOwnState as XBOOL
	dfltKbdFB as CARD16
	dfltLedFB as CARD16
	pad as CARD16
	devType as CARD32
end type

type xkbGetDeviceInfoReply as _xkbGetDeviceInfoReply
const sz_xkbGetDeviceInfoReply = 32

type _xkbSetDeviceInfo
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	deviceSpec as CARD16
	firstBtn as CARD8
	nBtns as CARD8
	change as CARD16
	nDeviceLedFBs as CARD16
end type

type xkbSetDeviceInfoReq as _xkbSetDeviceInfo
const sz_xkbSetDeviceInfoReq = 12

type _xkbSetDebuggingFlags
	reqType as CARD8
	xkbReqType as CARD8
	length as CARD16
	msgLength as CARD16
	pad as CARD16
	affectFlags as CARD32
	flags as CARD32
	affectCtrls as CARD32
	ctrls as CARD32
end type

type xkbSetDebuggingFlagsReq as _xkbSetDebuggingFlags
const sz_xkbSetDebuggingFlagsReq = 24

type _xkbSetDebuggingFlagsReply
	as UBYTE type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	currentFlags as CARD32
	currentCtrls as CARD32
	supportedFlags as CARD32
	supportedCtrls as CARD32
	pad1 as CARD32
	pad2 as CARD32
end type

type xkbSetDebuggingFlagsReply as _xkbSetDebuggingFlagsReply
const sz_xkbSetDebuggingFlagsReply = 32

type _xkbAnyEvent_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

type xkbAnyEvent_ as _xkbAnyEvent_
const sz_xkbAnyEvent = 32

type _xkbNewKeyboardNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	oldDeviceID as CARD8
	minKeyCode as CARD8
	maxKeyCode as CARD8
	oldMinKeyCode as CARD8
	oldMaxKeyCode as CARD8
	requestMajor as CARD8
	requestMinor as CARD8
	changed as CARD16
	detail as CARD8
	pad1 as CARD8
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xkbNewKeyboardNotify_ as _xkbNewKeyboardNotify_
const sz_xkbNewKeyboardNotify = 32

type _xkbMapNotify
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	ptrBtnActions as CARD8
	changed as CARD16
	minKeyCode as CARD8
	maxKeyCode as CARD8
	firstType as CARD8
	nTypes as CARD8
	firstKeySym as CARD8
	nKeySyms as CARD8
	firstKeyAct as CARD8
	nKeyActs as CARD8
	firstKeyBehavior as CARD8
	nKeyBehaviors as CARD8
	firstKeyExplicit as CARD8
	nKeyExplicit as CARD8
	firstModMapKey as CARD8
	nModMapKeys as CARD8
	firstVModMapKey as CARD8
	nVModMapKeys as CARD8
	virtualMods as CARD16
	pad1 as CARD16
end type

type xkbMapNotify as _xkbMapNotify
const sz_xkbMapNotify = 32

type _xkbStateNotify
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	mods as CARD8
	baseMods as CARD8
	latchedMods as CARD8
	lockedMods as CARD8
	group as CARD8
	baseGroup as INT16
	latchedGroup as INT16
	lockedGroup as CARD8
	compatState as CARD8
	grabMods as CARD8
	compatGrabMods as CARD8
	lookupMods as CARD8
	compatLookupMods as CARD8
	ptrBtnState as CARD16
	changed as CARD16
	keycode as CARD8
	eventType as CARD8
	requestMajor as CARD8
	requestMinor as CARD8
end type

type xkbStateNotify as _xkbStateNotify
const sz_xkbStateNotify = 32

type _xkbControlsNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	numGroups as CARD8
	pad1 as CARD16
	changedControls as CARD32
	enabledControls as CARD32
	enabledControlChanges as CARD32
	keycode as CARD8
	eventType as CARD8
	requestMajor as CARD8
	requestMinor as CARD8
	pad2 as CARD32
end type

type xkbControlsNotify_ as _xkbControlsNotify_
const sz_xkbControlsNotify = 32

type _xkbIndicatorNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	pad1 as CARD8
	pad2 as CARD16
	state as CARD32
	changed as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xkbIndicatorNotify_ as _xkbIndicatorNotify_
const sz_xkbIndicatorNotify = 32

type _xkbNamesNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	pad1 as CARD8
	changed as CARD16
	firstType as CARD8
	nTypes as CARD8
	firstLevelName as CARD8
	nLevelNames as CARD8
	pad2 as CARD8
	nRadioGroups as CARD8
	nAliases as CARD8
	changedGroupNames as CARD8
	changedVirtualMods as CARD16
	firstKey as CARD8
	nKeys as CARD8
	changedIndicators as CARD32
	pad3 as CARD32
end type

type xkbNamesNotify_ as _xkbNamesNotify_
const sz_xkbNamesNotify = 32

type _xkbCompatMapNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	changedGroups as CARD8
	firstSI as CARD16
	nSI as CARD16
	nTotalSI as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xkbCompatMapNotify_ as _xkbCompatMapNotify_
const sz_xkbCompatMapNotify = 32

type _xkbBellNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	bellClass as CARD8
	bellID as CARD8
	percent as CARD8
	pitch as CARD16
	duration as CARD16
	name as CARD32
	window as CARD32
	eventOnly as XBOOL
	pad1 as CARD8
	pad2 as CARD16
	pad3 as CARD32
end type

type xkbBellNotify_ as _xkbBellNotify_
const sz_xkbBellNotify = 32

type _xkbActionMessage_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	keycode as CARD8
	press as XBOOL
	keyEventFollows as XBOOL
	mods as CARD8
	group as CARD8
	message(0 to 7) as CARD8
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
end type

type xkbActionMessage_ as _xkbActionMessage_
const sz_xkbActionMessage = 32

type _xkbAccessXNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	keycode as CARD8
	detail as CARD16
	slowKeysDelay as CARD16
	debounceDelay as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

type xkbAccessXNotify_ as _xkbAccessXNotify_
const sz_xkbAccessXNotify = 32

type _xkbExtensionDeviceNotify_
	as UBYTE type
	xkbType as UBYTE
	sequenceNumber as CARD16
	time as CARD32
	deviceID as CARD8
	pad1 as CARD8
	reason as CARD16
	ledClass as CARD16
	ledID as CARD16
	ledsDefined as CARD32
	ledState as CARD32
	firstBtn as CARD8
	nBtns as CARD8
	supported as CARD16
	unsupported as CARD16
	pad3 as CARD16
end type

type xkbExtensionDeviceNotify_ as _xkbExtensionDeviceNotify_
const sz_xkbExtensionDeviceNotify = 32

union _xkbEvent_u
	any as xkbAnyEvent_
	new_kbd as xkbNewKeyboardNotify_
	map as xkbMapNotify
	state as xkbStateNotify
	ctrls as xkbControlsNotify_
	indicators as xkbIndicatorNotify_
	names as xkbNamesNotify_
	compat as xkbCompatMapNotify_
	bell as xkbBellNotify_
	message as xkbActionMessage_
	accessx as xkbAccessXNotify_
	device as xkbExtensionDeviceNotify_
end union

type _xkbEvent_
	u as _xkbEvent_u
end type

type xkbEvent_ as _xkbEvent_
const sz_xkbEvent = 32
