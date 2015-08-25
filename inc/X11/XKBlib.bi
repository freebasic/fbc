'' FreeBASIC binding for libX11-1.6.3
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
#include once "X11/Xlib.bi"
#include once "X11/extensions/XKBstr.bi"

extern "C"

#define _X11_XKBLIB_H_

type _XkbAnyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as ulong
end type

type XkbAnyEvent as _XkbAnyEvent

type _XkbNewKeyboardNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	old_device as long
	min_key_code as long
	max_key_code as long
	old_min_key_code as long
	old_max_key_code as long
	changed as ulong
	req_major as byte
	req_minor as byte
end type

type XkbNewKeyboardNotifyEvent as _XkbNewKeyboardNotify

type _XkbMapNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed as ulong
	flags as ulong
	first_type as long
	num_types as long
	min_key_code as KeyCode
	max_key_code as KeyCode
	first_key_sym as KeyCode
	first_key_act as KeyCode
	first_key_behavior as KeyCode
	first_key_explicit as KeyCode
	first_modmap_key as KeyCode
	first_vmodmap_key as KeyCode
	num_key_syms as long
	num_key_acts as long
	num_key_behaviors as long
	num_key_explicit as long
	num_modmap_keys as long
	num_vmodmap_keys as long
	vmods as ulong
end type

type XkbMapNotifyEvent as _XkbMapNotifyEvent

type _XkbStateNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed as ulong
	group as long
	base_group as long
	latched_group as long
	locked_group as long
	mods as ulong
	base_mods as ulong
	latched_mods as ulong
	locked_mods as ulong
	compat_state as long
	grab_mods as ubyte
	compat_grab_mods as ubyte
	lookup_mods as ubyte
	compat_lookup_mods as ubyte
	ptr_buttons as long
	keycode as KeyCode
	event_type as byte
	req_major as byte
	req_minor as byte
end type

type XkbStateNotifyEvent as _XkbStateNotifyEvent

type _XkbControlsNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed_ctrls as ulong
	enabled_ctrls as ulong
	enabled_ctrl_changes as ulong
	num_groups as long
	keycode as KeyCode
	event_type as byte
	req_major as byte
	req_minor as byte
end type

type XkbControlsNotifyEvent as _XkbControlsNotify

type _XkbIndicatorNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed as ulong
	state as ulong
end type

type XkbIndicatorNotifyEvent as _XkbIndicatorNotify

type _XkbNamesNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed as ulong
	first_type as long
	num_types as long
	first_lvl as long
	num_lvls as long
	num_aliases as long
	num_radio_groups as long
	changed_vmods as ulong
	changed_groups as ulong
	changed_indicators as ulong
	first_key as long
	num_keys as long
end type

type XkbNamesNotifyEvent as _XkbNamesNotify

type _XkbCompatMapNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	changed_groups as ulong
	first_si as long
	num_si as long
	num_total_si as long
end type

type XkbCompatMapNotifyEvent as _XkbCompatMapNotify

type _XkbBellNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	percent as long
	pitch as long
	duration as long
	bell_class as long
	bell_id as long
	name as XAtom
	window as Window
	event_only as long
end type

type XkbBellNotifyEvent as _XkbBellNotify

type _XkbActionMessage
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	keycode as KeyCode
	press as long
	key_event_follows as long
	group as long
	mods as ulong
	message as zstring * 6 + 1
end type

type XkbActionMessageEvent as _XkbActionMessage

type _XkbAccessXNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	detail as long
	keycode as long
	sk_delay as long
	debounce_delay as long
end type

type XkbAccessXNotifyEvent as _XkbAccessXNotify

type _XkbExtensionDeviceNotify
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	time as Time
	xkb_type as long
	device as long
	reason as ulong
	supported as ulong
	unsupported as ulong
	first_btn as long
	num_btns as long
	leds_defined as ulong
	led_state as ulong
	led_class as long
	led_id as long
end type

type XkbExtensionDeviceNotifyEvent as _XkbExtensionDeviceNotify

union _XkbEvent
	as long type
	any as XkbAnyEvent
	new_kbd as XkbNewKeyboardNotifyEvent
	map as XkbMapNotifyEvent
	state as XkbStateNotifyEvent
	ctrls as XkbControlsNotifyEvent
	indicators as XkbIndicatorNotifyEvent
	names as XkbNamesNotifyEvent
	compat as XkbCompatMapNotifyEvent
	bell as XkbBellNotifyEvent
	message as XkbActionMessageEvent
	accessx as XkbAccessXNotifyEvent
	device as XkbExtensionDeviceNotifyEvent
	core as XEvent
end union

type XkbEvent as _XkbEvent
type XkbKbdDpyStateRec as _XkbKbdDpyState
type XkbKbdDpyStatePtr as _XkbKbdDpyState ptr

const XkbOD_Success = 0
const XkbOD_BadLibraryVersion = 1
const XkbOD_ConnectionRefused = 2
const XkbOD_NonXkbServer = 3
const XkbOD_BadServerVersion = 4
const XkbLC_ForceLatin1Lookup = 1 shl 0
const XkbLC_ConsumeLookupMods = 1 shl 1
const XkbLC_AlwaysConsumeShiftAndLock = 1 shl 2
const XkbLC_IgnoreNewKeyboards = 1 shl 3
const XkbLC_ControlFallback = 1 shl 4
const XkbLC_ConsumeKeysOnComposeFail = 1 shl 29
const XkbLC_ComposeLED = 1 shl 30
const XkbLC_BeepOnComposeFail = 1 shl 31
const XkbLC_AllComposeControls = &hc0000000
const XkbLC_AllControls = &hc000001f

declare function XkbIgnoreExtension(byval as long) as long
declare function XkbOpenDisplay(byval as zstring ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as Display ptr
declare function XkbQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XkbUseExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XkbLibraryVersion(byval as long ptr, byval as long ptr) as long
declare function XkbSetXlibControls(byval as Display ptr, byval as ulong, byval as ulong) as ulong
declare function XkbGetXlibControls(byval as Display ptr) as ulong
declare function XkbXlibControlsImplemented() as ulong
type XkbInternAtomFunc as function(byval as Display ptr, byval as const zstring ptr, byval as long) as XAtom
type XkbGetAtomNameFunc as function(byval as Display ptr, byval as XAtom) as zstring ptr
declare sub XkbSetAtomFuncs(byval as XkbInternAtomFunc, byval as XkbGetAtomNameFunc)
declare function XkbKeycodeToKeysym(byval as Display ptr, byval as KeyCode, byval as long, byval as long) as KeySym
declare function XkbKeysymToModifiers(byval as Display ptr, byval as KeySym) as ulong
declare function XkbLookupKeySym(byval as Display ptr, byval as KeyCode, byval as ulong, byval as ulong ptr, byval as KeySym ptr) as long
declare function XkbLookupKeyBinding(byval as Display ptr, byval as KeySym, byval as ulong, byval as zstring ptr, byval as long, byval as long ptr) as long
declare function XkbTranslateKeyCode(byval as XkbDescPtr, byval as KeyCode, byval as ulong, byval as ulong ptr, byval as KeySym ptr) as long
declare function XkbTranslateKeySym(byval as Display ptr, byval as KeySym ptr, byval as ulong, byval as zstring ptr, byval as long, byval as long ptr) as long
declare function XkbSetAutoRepeatRate(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbGetAutoRepeatRate(byval as Display ptr, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XkbChangeEnabledControls(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbDeviceBell(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as long, byval as XAtom) as long
declare function XkbForceDeviceBell(byval as Display ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function XkbDeviceBellEvent(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as long, byval as XAtom) as long
declare function XkbBell(byval as Display ptr, byval as Window, byval as long, byval as XAtom) as long
declare function XkbForceBell(byval as Display ptr, byval as long) as long
declare function XkbBellEvent(byval as Display ptr, byval as Window, byval as long, byval as XAtom) as long
declare function XkbSelectEvents(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbSelectEventDetails(byval as Display ptr, byval as ulong, byval as ulong, byval as culong, byval as culong) as long
declare sub XkbNoteMapChanges(byval as XkbMapChangesPtr, byval as XkbMapNotifyEvent ptr, byval as ulong)
declare sub XkbNoteNameChanges(byval as XkbNameChangesPtr, byval as XkbNamesNotifyEvent ptr, byval as ulong)
declare function XkbGetIndicatorState(byval as Display ptr, byval as ulong, byval as ulong ptr) as long
declare function XkbGetDeviceIndicatorState(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as ulong ptr) as long
declare function XkbGetIndicatorMap(byval as Display ptr, byval as culong, byval as XkbDescPtr) as long
declare function XkbSetIndicatorMap(byval as Display ptr, byval as culong, byval as XkbDescPtr) as long

#define XkbNoteIndicatorMapChanges(o, n, w) scope : (o)->map_changes or= (n)->map_changes and (w) : end scope
#define XkbNoteIndicatorStateChanges(o, n, w) scope : (o)->state_changes or= (n)->state_changes and (w) : end scope
#define XkbGetIndicatorMapChanges(d, x, c) XkbGetIndicatorMap((d), (c)->map_changes, x)
#define XkbChangeIndicatorMaps(d, x, c) XkbSetIndicatorMap((d), (c)->map_changes, x)

declare function XkbGetNamedIndicator(byval as Display ptr, byval as XAtom, byval as long ptr, byval as long ptr, byval as XkbIndicatorMapPtr, byval as long ptr) as long
declare function XkbGetNamedDeviceIndicator(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as XAtom, byval as long ptr, byval as long ptr, byval as XkbIndicatorMapPtr, byval as long ptr) as long
declare function XkbSetNamedIndicator(byval as Display ptr, byval as XAtom, byval as long, byval as long, byval as long, byval as XkbIndicatorMapPtr) as long
declare function XkbSetNamedDeviceIndicator(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as XAtom, byval as long, byval as long, byval as long, byval as XkbIndicatorMapPtr) as long
declare function XkbLockModifiers(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbLatchModifiers(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbLockGroup(byval as Display ptr, byval as ulong, byval as ulong) as long
declare function XkbLatchGroup(byval as Display ptr, byval as ulong, byval as ulong) as long
declare function XkbSetServerInternalMods(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbSetIgnoreLockMods(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbVirtualModsToReal(byval as XkbDescPtr, byval as ulong, byval as ulong ptr) as long
declare function XkbComputeEffectiveMap(byval as XkbDescPtr, byval as XkbKeyTypePtr, byval as ubyte ptr) as long
declare function XkbInitCanonicalKeyTypes(byval as XkbDescPtr, byval as ulong, byval as long) as long
declare function XkbAllocKeyboard() as XkbDescPtr
declare sub XkbFreeKeyboard(byval as XkbDescPtr, byval as ulong, byval as long)
declare function XkbAllocClientMap(byval as XkbDescPtr, byval as ulong, byval as ulong) as long
declare function XkbAllocServerMap(byval as XkbDescPtr, byval as ulong, byval as ulong) as long
declare sub XkbFreeClientMap(byval as XkbDescPtr, byval as ulong, byval as long)
declare sub XkbFreeServerMap(byval as XkbDescPtr, byval as ulong, byval as long)
declare function XkbAddKeyType(byval as XkbDescPtr, byval as XAtom, byval as long, byval as long, byval as long) as XkbKeyTypePtr
declare function XkbAllocIndicatorMaps(byval as XkbDescPtr) as long
declare sub XkbFreeIndicatorMaps(byval as XkbDescPtr)
declare function XkbGetMap(byval as Display ptr, byval as ulong, byval as ulong) as XkbDescPtr
declare function XkbGetUpdatedMap(byval as Display ptr, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetMapChanges(byval as Display ptr, byval as XkbDescPtr, byval as XkbMapChangesPtr) as long
declare function XkbRefreshKeyboardMapping(byval as XkbMapNotifyEvent ptr) as long
declare function XkbGetKeyTypes(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeySyms(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeyActions(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeyBehaviors(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetVirtualMods(byval as Display ptr, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeyExplicitComponents(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeyModifierMap(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbGetKeyVirtualModMap(byval as Display ptr, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbAllocControls(byval as XkbDescPtr, byval as ulong) as long
declare sub XkbFreeControls(byval as XkbDescPtr, byval as ulong, byval as long)
declare function XkbGetControls(byval as Display ptr, byval as culong, byval as XkbDescPtr) as long
declare function XkbSetControls(byval as Display ptr, byval as culong, byval as XkbDescPtr) as long
declare sub XkbNoteControlsChanges(byval as XkbControlsChangesPtr, byval as XkbControlsNotifyEvent ptr, byval as ulong)
#define XkbGetControlsChanges(d, x, c) XkbGetControls(d, (c)->changed_ctrls, x)
#define XkbChangeControls(d, x, c) XkbSetControls(d, (c)->changed_ctrls, x)
declare function XkbAllocCompatMap(byval as XkbDescPtr, byval as ulong, byval as ulong) as long
declare sub XkbFreeCompatMap(byval as XkbDescPtr, byval as ulong, byval as long)
declare function XkbGetCompatMap(byval as Display ptr, byval as ulong, byval as XkbDescPtr) as long
declare function XkbSetCompatMap(byval as Display ptr, byval as ulong, byval as XkbDescPtr, byval as long) as long
declare function XkbAddSymInterpret(byval as XkbDescPtr, byval as XkbSymInterpretPtr, byval as long, byval as XkbChangesPtr) as XkbSymInterpretPtr
declare function XkbAllocNames(byval as XkbDescPtr, byval as ulong, byval as long, byval as long) as long
declare function XkbGetNames(byval as Display ptr, byval as ulong, byval as XkbDescPtr) as long
declare function XkbSetNames(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as XkbDescPtr) as long
declare function XkbChangeNames(byval as Display ptr, byval as XkbDescPtr, byval as XkbNameChangesPtr) as long
declare sub XkbFreeNames(byval as XkbDescPtr, byval as ulong, byval as long)
declare function XkbGetState(byval as Display ptr, byval as ulong, byval as XkbStatePtr) as long
declare function XkbSetMap(byval as Display ptr, byval as ulong, byval as XkbDescPtr) as long
declare function XkbChangeMap(byval as Display ptr, byval as XkbDescPtr, byval as XkbMapChangesPtr) as long
declare function XkbSetDetectableAutoRepeat(byval as Display ptr, byval as long, byval as long ptr) as long
declare function XkbGetDetectableAutoRepeat(byval as Display ptr, byval as long ptr) as long
declare function XkbSetAutoResetControls(byval as Display ptr, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XkbGetAutoResetControls(byval as Display ptr, byval as ulong ptr, byval as ulong ptr) as long
declare function XkbSetPerClientControls(byval as Display ptr, byval as ulong, byval as ulong ptr) as long
declare function XkbGetPerClientControls(byval as Display ptr, byval as ulong ptr) as long
declare function XkbCopyKeyType(byval as XkbKeyTypePtr, byval as XkbKeyTypePtr) as long
declare function XkbCopyKeyTypes(byval as XkbKeyTypePtr, byval as XkbKeyTypePtr, byval as long) as long
declare function XkbResizeKeyType(byval as XkbDescPtr, byval as long, byval as long, byval as long, byval as long) as long
declare function XkbResizeKeySyms(byval as XkbDescPtr, byval as long, byval as long) as KeySym ptr
declare function XkbResizeKeyActions(byval as XkbDescPtr, byval as long, byval as long) as XkbAction ptr
declare function XkbChangeTypesOfKey(byval as XkbDescPtr, byval as long, byval as long, byval as ulong, byval as long ptr, byval as XkbMapChangesPtr) as long
declare function XkbChangeKeycodeRange(byval as XkbDescPtr, byval as long, byval as long, byval as XkbChangesPtr) as long
declare function XkbListComponents(byval as Display ptr, byval as ulong, byval as XkbComponentNamesPtr, byval as long ptr) as XkbComponentListPtr
declare sub XkbFreeComponentList(byval as XkbComponentListPtr)
declare function XkbGetKeyboard(byval as Display ptr, byval as ulong, byval as ulong) as XkbDescPtr
declare function XkbGetKeyboardByName(byval as Display ptr, byval as ulong, byval as XkbComponentNamesPtr, byval as ulong, byval as ulong, byval as long) as XkbDescPtr
declare function XkbKeyTypesForCoreSymbols(byval as XkbDescPtr, byval as long, byval as KeySym ptr, byval as ulong, byval as long ptr, byval as KeySym ptr) as long
declare function XkbApplyCompatMapToKey(byval as XkbDescPtr, byval as KeyCode, byval as XkbChangesPtr) as long
declare function XkbUpdateMapFromCore(byval as XkbDescPtr, byval as KeyCode, byval as long, byval as long, byval as KeySym ptr, byval as XkbChangesPtr) as long
declare function XkbAddDeviceLedInfo(byval as XkbDeviceInfoPtr, byval as ulong, byval as ulong) as XkbDeviceLedInfoPtr
declare function XkbResizeDeviceButtonActions(byval as XkbDeviceInfoPtr, byval as ulong) as long
declare function XkbAllocDeviceInfo(byval as ulong, byval as ulong, byval as ulong) as XkbDeviceInfoPtr
declare sub XkbFreeDeviceInfo(byval as XkbDeviceInfoPtr, byval as ulong, byval as long)
declare sub XkbNoteDeviceChanges(byval as XkbDeviceChangesPtr, byval as XkbExtensionDeviceNotifyEvent ptr, byval as ulong)
declare function XkbGetDeviceInfo(byval as Display ptr, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as XkbDeviceInfoPtr
declare function XkbGetDeviceInfoChanges(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as XkbDeviceChangesPtr) as long
declare function XkbGetDeviceButtonActions(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as long, byval as ulong, byval as ulong) as long
declare function XkbGetDeviceLedInfo(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbSetDeviceInfo(byval as Display ptr, byval as ulong, byval as XkbDeviceInfoPtr) as long
declare function XkbChangeDeviceInfo(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as XkbDeviceChangesPtr) as long
declare function XkbSetDeviceLedInfo(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as ulong, byval as ulong, byval as ulong) as long
declare function XkbSetDeviceButtonActions(byval as Display ptr, byval as XkbDeviceInfoPtr, byval as ulong, byval as ulong) as long
declare function XkbToControl(byval as byte) as byte
declare function XkbSetDebuggingFlags(byval as Display ptr, byval as ulong, byval as ulong, byval as zstring ptr, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XkbApplyVirtualModChanges(byval as XkbDescPtr, byval as ulong, byval as XkbChangesPtr) as long
declare function XkbUpdateActionVirtualMods(byval as XkbDescPtr, byval as XkbAction ptr, byval as ulong) as long
declare sub XkbUpdateKeyTypeVirtualMods(byval as XkbDescPtr, byval as XkbKeyTypePtr, byval as ulong, byval as XkbChangesPtr)

end extern
