''
''
'' XKBlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XKBlib_bi__
#define __XKBlib_bi__

type _XkbAnyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as uinteger
end type

type XkbAnyEvent as _XkbAnyEvent

type _XkbNewKeyboardNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	old_device as integer
	min_key_code as integer
	max_key_code as integer
	old_min_key_code as integer
	old_max_key_code as integer
	changed as uinteger
	req_major as byte
	req_minor as byte
end type

type XkbNewKeyboardNotifyEvent as _XkbNewKeyboardNotify

type _XkbMapNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed as uinteger
	flags as uinteger
	first_type as integer
	num_types as integer
	min_key_code as KeyCode
	max_key_code as KeyCode
	first_key_sym as KeyCode
	first_key_act as KeyCode
	first_key_behavior as KeyCode
	first_key_explicit as KeyCode
	first_modmap_key as KeyCode
	first_vmodmap_key as KeyCode
	num_key_syms as integer
	num_key_acts as integer
	num_key_behaviors as integer
	num_key_explicit as integer
	num_modmap_keys as integer
	num_vmodmap_keys as integer
	vmods as uinteger
end type

type XkbMapNotifyEvent as _XkbMapNotifyEvent

type _XkbStateNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed as uinteger
	group as integer
	base_group as integer
	latched_group as integer
	locked_group as integer
	mods as uinteger
	base_mods as uinteger
	latched_mods as uinteger
	locked_mods as uinteger
	compat_state as integer
	grab_mods as ubyte
	compat_grab_mods as ubyte
	lookup_mods as ubyte
	compat_lookup_mods as ubyte
	ptr_buttons as integer
	keycode as KeyCode
	event_type as byte
	req_major as byte
	req_minor as byte
end type

type XkbStateNotifyEvent as _XkbStateNotifyEvent

type _XkbControlsNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed_ctrls as uinteger
	enabled_ctrls as uinteger
	enabled_ctrl_changes as uinteger
	num_groups as integer
	keycode as KeyCode
	event_type as byte
	req_major as byte
	req_minor as byte
end type

type XkbControlsNotifyEvent as _XkbControlsNotify

type _XkbIndicatorNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed as uinteger
	state as uinteger
end type

type XkbIndicatorNotifyEvent as _XkbIndicatorNotify

type _XkbNamesNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed as uinteger
	first_type as integer
	num_types as integer
	first_lvl as integer
	num_lvls as integer
	num_aliases as integer
	num_radio_groups as integer
	changed_vmods as uinteger
	changed_groups as uinteger
	changed_indicators as uinteger
	first_key as integer
	num_keys as integer
end type

type XkbNamesNotifyEvent as _XkbNamesNotify

type _XkbCompatMapNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	changed_groups as uinteger
	first_si as integer
	num_si as integer
	num_total_si as integer
end type

type XkbCompatMapNotifyEvent as _XkbCompatMapNotify

type _XkbBellNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	percent as integer
	pitch as integer
	duration as integer
	bell_class as integer
	bell_id as integer
	name as Atom
	window as Window
	event_only as Bool
end type

type XkbBellNotifyEvent as _XkbBellNotify

type _XkbActionMessage
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	keycode as KeyCode
	press as Bool
	key_event_follows as Bool
	group as integer
	mods as uinteger
	message as zstring * XkbActionMessageLength+1
end type

type XkbActionMessageEvent as _XkbActionMessage

type _XkbAccessXNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	detail as integer
	keycode as integer
	sk_delay as integer
	debounce_delay as integer
end type

type XkbAccessXNotifyEvent as _XkbAccessXNotify

type _XkbExtensionDeviceNotify
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	time as Time
	xkb_type as integer
	device as integer
	reason as uinteger
	supported as uinteger
	unsupported as uinteger
	first_btn as integer
	num_btns as integer
	leds_defined as uinteger
	led_state as uinteger
	led_class as integer
	led_id as integer
end type

type XkbExtensionDeviceNotifyEvent as _XkbExtensionDeviceNotify

union _XkbEvent
	type as integer
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

#define XkbOD_Success 0
#define XkbOD_BadLibraryVersion 1
#define XkbOD_ConnectionRefused 2
#define XkbOD_NonXkbServer 3
#define XkbOD_BadServerVersion 4
#define XkbLC_ForceLatin1Lookup (1 shl 0)
#define XkbLC_ConsumeLookupMods (1 shl 1)
#define XkbLC_AlwaysConsumeShiftAndLock (1 shl 2)
#define XkbLC_IgnoreNewKeyboards (1 shl 3)
#define XkbLC_ControlFallback (1 shl 4)
#define XkbLC_ConsumeKeysOnComposeFail (1 shl 29)
#define XkbLC_ComposeLED (1 shl 30)
#define XkbLC_BeepOnComposeFail (1 shl 31)
#define XkbLC_AllComposeControls (&hc0000000)
#define XkbLC_AllControls (&hc000001f)

declare function XkbOpenDisplay cdecl alias "XkbOpenDisplay" (byval as zstring ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as Display ptr
declare function XkbQueryExtension cdecl alias "XkbQueryExtension" (byval as Display ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as Bool
declare function XkbUseExtension cdecl alias "XkbUseExtension" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Bool
declare function XkbLibraryVersion cdecl alias "XkbLibraryVersion" (byval as integer ptr, byval as integer ptr) as Bool
declare function XkbSetXlibControls cdecl alias "XkbSetXlibControls" (byval as Display ptr, byval as uinteger, byval as uinteger) as uinteger
declare function XkbGetXlibControls cdecl alias "XkbGetXlibControls" (byval as Display ptr) as uinteger
declare function XkbXlibControlsImplemented cdecl alias "XkbXlibControlsImplemented" () as uinteger

type XkbGetAtomNameFunc as function cdecl(byval as Display ptr, byval as Atom) as byte ptr

declare sub XkbSetAtomFuncs cdecl alias "XkbSetAtomFuncs" (byval as XkbInternAtomFunc, byval as XkbGetAtomNameFunc)
declare function XkbKeycodeToKeysym cdecl alias "XkbKeycodeToKeysym" (byval as Display ptr, byval as KeyCode, byval as integer, byval as integer) as KeySym
declare function XkbKeysymToModifiers cdecl alias "XkbKeysymToModifiers" (byval as Display ptr, byval as KeySym) as uinteger
declare function XkbLookupKeySym cdecl alias "XkbLookupKeySym" (byval as Display ptr, byval as KeyCode, byval as uinteger, byval as uinteger ptr, byval as KeySym ptr) as Bool
declare function XkbLookupKeyBinding cdecl alias "XkbLookupKeyBinding" (byval as Display ptr, byval as KeySym, byval as uinteger, byval as zstring ptr, byval as integer, byval as integer ptr) as integer
declare function XkbTranslateKeyCode cdecl alias "XkbTranslateKeyCode" (byval as XkbDescPtr, byval as KeyCode, byval as uinteger, byval as uinteger ptr, byval as KeySym ptr) as Bool
declare function XkbTranslateKeySym cdecl alias "XkbTranslateKeySym" (byval as Display ptr, byval as KeySym ptr, byval as uinteger, byval as zstring ptr, byval as integer, byval as integer ptr) as integer
declare function XkbSetAutoRepeatRate cdecl alias "XkbSetAutoRepeatRate" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbGetAutoRepeatRate cdecl alias "XkbGetAutoRepeatRate" (byval as Display ptr, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as Bool
declare function XkbChangeEnabledControls cdecl alias "XkbChangeEnabledControls" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbDeviceBell cdecl alias "XkbDeviceBell" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as integer, byval as Atom) as Bool
declare function XkbForceDeviceBell cdecl alias "XkbForceDeviceBell" (byval as Display ptr, byval as integer, byval as integer, byval as integer, byval as integer) as Bool
declare function XkbDeviceBellEvent cdecl alias "XkbDeviceBellEvent" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as integer, byval as Atom) as Bool
declare function XkbBell cdecl alias "XkbBell" (byval as Display ptr, byval as Window, byval as integer, byval as Atom) as Bool
declare function XkbForceBell cdecl alias "XkbForceBell" (byval as Display ptr, byval as integer) as Bool
declare function XkbBellEvent cdecl alias "XkbBellEvent" (byval as Display ptr, byval as Window, byval as integer, byval as Atom) as Bool
declare function XkbSelectEvents cdecl alias "XkbSelectEvents" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbSelectEventDetails cdecl alias "XkbSelectEventDetails" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare sub XkbNoteMapChanges cdecl alias "XkbNoteMapChanges" (byval as XkbMapChangesPtr, byval as XkbMapNotifyEvent ptr, byval as uinteger)
declare sub XkbNoteNameChanges cdecl alias "XkbNoteNameChanges" (byval as XkbNameChangesPtr, byval as XkbNamesNotifyEvent ptr, byval as uinteger)
declare function XkbGetIndicatorState cdecl alias "XkbGetIndicatorState" (byval as Display ptr, byval as uinteger, byval as uinteger ptr) as Status
declare function XkbGetDeviceIndicatorState cdecl alias "XkbGetDeviceIndicatorState" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger ptr) as Status
declare function XkbGetIndicatorMap cdecl alias "XkbGetIndicatorMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbSetIndicatorMap cdecl alias "XkbSetIndicatorMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Bool
declare function XkbGetNamedIndicator cdecl alias "XkbGetNamedIndicator" (byval as Display ptr, byval as Atom, byval as integer ptr, byval as Bool ptr, byval as XkbIndicatorMapPtr, byval as Bool ptr) as Bool
declare function XkbGetNamedDeviceIndicator cdecl alias "XkbGetNamedDeviceIndicator" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as Atom, byval as integer ptr, byval as Bool ptr, byval as XkbIndicatorMapPtr, byval as Bool ptr) as Bool
declare function XkbSetNamedIndicator cdecl alias "XkbSetNamedIndicator" (byval as Display ptr, byval as Atom, byval as Bool, byval as Bool, byval as Bool, byval as XkbIndicatorMapPtr) as Bool
declare function XkbSetNamedDeviceIndicator cdecl alias "XkbSetNamedDeviceIndicator" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as Atom, byval as Bool, byval as Bool, byval as Bool, byval as XkbIndicatorMapPtr) as Bool
declare function XkbLockModifiers cdecl alias "XkbLockModifiers" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbLatchModifiers cdecl alias "XkbLatchModifiers" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbLockGroup cdecl alias "XkbLockGroup" (byval as Display ptr, byval as uinteger, byval as uinteger) as Bool
declare function XkbLatchGroup cdecl alias "XkbLatchGroup" (byval as Display ptr, byval as uinteger, byval as uinteger) as Bool
declare function XkbSetServerInternalMods cdecl alias "XkbSetServerInternalMods" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbSetIgnoreLockMods cdecl alias "XkbSetIgnoreLockMods" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbVirtualModsToReal cdecl alias "XkbVirtualModsToReal" (byval as XkbDescPtr, byval as uinteger, byval as uinteger ptr) as Bool
declare function XkbComputeEffectiveMap cdecl alias "XkbComputeEffectiveMap" (byval as XkbDescPtr, byval as XkbKeyTypePtr, byval as ubyte ptr) as Bool
declare function XkbInitCanonicalKeyTypes cdecl alias "XkbInitCanonicalKeyTypes" (byval as XkbDescPtr, byval as uinteger, byval as integer) as Status
declare function XkbAllocKeyboard cdecl alias "XkbAllocKeyboard" () as XkbDescPtr
declare sub XkbFreeKeyboard cdecl alias "XkbFreeKeyboard" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbAllocClientMap cdecl alias "XkbAllocClientMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as Status
declare function XkbAllocServerMap cdecl alias "XkbAllocServerMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as Status
declare sub XkbFreeClientMap cdecl alias "XkbFreeClientMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare sub XkbFreeServerMap cdecl alias "XkbFreeServerMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbAddKeyType cdecl alias "XkbAddKeyType" (byval as XkbDescPtr, byval as Atom, byval as integer, byval as Bool, byval as integer) as XkbKeyTypePtr
declare function XkbAllocIndicatorMaps cdecl alias "XkbAllocIndicatorMaps" (byval as XkbDescPtr) as Status
declare sub XkbFreeIndicatorMaps cdecl alias "XkbFreeIndicatorMaps" (byval as XkbDescPtr)
declare function XkbGetMap cdecl alias "XkbGetMap" (byval as Display ptr, byval as uinteger, byval as uinteger) as XkbDescPtr
declare function XkbGetUpdatedMap cdecl alias "XkbGetUpdatedMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetMapChanges cdecl alias "XkbGetMapChanges" (byval as Display ptr, byval as XkbDescPtr, byval as XkbMapChangesPtr) as Status
declare function XkbRefreshKeyboardMapping cdecl alias "XkbRefreshKeyboardMapping" (byval as XkbMapNotifyEvent ptr) as Status
declare function XkbGetKeyTypes cdecl alias "XkbGetKeyTypes" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeySyms cdecl alias "XkbGetKeySyms" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeyActions cdecl alias "XkbGetKeyActions" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeyBehaviors cdecl alias "XkbGetKeyBehaviors" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetVirtualMods cdecl alias "XkbGetVirtualMods" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeyExplicitComponents cdecl alias "XkbGetKeyExplicitComponents" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeyModifierMap cdecl alias "XkbGetKeyModifierMap" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbGetKeyVirtualModMap cdecl alias "XkbGetKeyVirtualModMap" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbAllocControls cdecl alias "XkbAllocControls" (byval as XkbDescPtr, byval as uinteger) as Status
declare sub XkbFreeControls cdecl alias "XkbFreeControls" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbGetControls cdecl alias "XkbGetControls" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbSetControls cdecl alias "XkbSetControls" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Bool
declare sub XkbNoteControlsChanges cdecl alias "XkbNoteControlsChanges" (byval as XkbControlsChangesPtr, byval as XkbControlsNotifyEvent ptr, byval as uinteger)
declare function XkbAllocCompatMap cdecl alias "XkbAllocCompatMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as Status
declare sub XkbFreeCompatMap cdecl alias "XkbFreeCompatMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbGetCompatMap cdecl alias "XkbGetCompatMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbSetCompatMap cdecl alias "XkbSetCompatMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr, byval as Bool) as Bool
declare function XkbAddSymInterpret cdecl alias "XkbAddSymInterpret" (byval as XkbDescPtr, byval as XkbSymInterpretPtr, byval as Bool, byval as XkbChangesPtr) as XkbSymInterpretPtr
declare function XkbAllocNames cdecl alias "XkbAllocNames" (byval as XkbDescPtr, byval as uinteger, byval as integer, byval as integer) as Status
declare function XkbGetNames cdecl alias "XkbGetNames" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Status
declare function XkbSetNames cdecl alias "XkbSetNames" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as XkbDescPtr) as Bool
declare function XkbChangeNames cdecl alias "XkbChangeNames" (byval as Display ptr, byval as XkbDescPtr, byval as XkbNameChangesPtr) as Bool
declare sub XkbFreeNames cdecl alias "XkbFreeNames" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbGetState cdecl alias "XkbGetState" (byval as Display ptr, byval as uinteger, byval as XkbStatePtr) as Status
declare function XkbSetMap cdecl alias "XkbSetMap" (byval as Display ptr, byval as uinteger, byval as XkbDescPtr) as Bool
declare function XkbChangeMap cdecl alias "XkbChangeMap" (byval as Display ptr, byval as XkbDescPtr, byval as XkbMapChangesPtr) as Bool
declare function XkbSetDetectableAutoRepeat cdecl alias "XkbSetDetectableAutoRepeat" (byval as Display ptr, byval as Bool, byval as Bool ptr) as Bool
declare function XkbGetDetectableAutoRepeat cdecl alias "XkbGetDetectableAutoRepeat" (byval as Display ptr, byval as Bool ptr) as Bool
declare function XkbSetAutoResetControls cdecl alias "XkbSetAutoResetControls" (byval as Display ptr, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as Bool
declare function XkbGetAutoResetControls cdecl alias "XkbGetAutoResetControls" (byval as Display ptr, byval as uinteger ptr, byval as uinteger ptr) as Bool
declare function XkbSetPerClientControls cdecl alias "XkbSetPerClientControls" (byval as Display ptr, byval as uinteger, byval as uinteger ptr) as Bool
declare function XkbGetPerClientControls cdecl alias "XkbGetPerClientControls" (byval as Display ptr, byval as uinteger ptr) as Bool
declare function XkbCopyKeyType cdecl alias "XkbCopyKeyType" (byval as XkbKeyTypePtr, byval as XkbKeyTypePtr) as Status
declare function XkbCopyKeyTypes cdecl alias "XkbCopyKeyTypes" (byval as XkbKeyTypePtr, byval as XkbKeyTypePtr, byval as integer) as Status
declare function XkbResizeKeyType cdecl alias "XkbResizeKeyType" (byval as XkbDescPtr, byval as integer, byval as integer, byval as Bool, byval as integer) as Status
declare function XkbResizeKeySyms cdecl alias "XkbResizeKeySyms" (byval as XkbDescPtr, byval as integer, byval as integer) as KeySym ptr
declare function XkbResizeKeyActions cdecl alias "XkbResizeKeyActions" (byval as XkbDescPtr, byval as integer, byval as integer) as XkbAction ptr
declare function XkbChangeTypesOfKey cdecl alias "XkbChangeTypesOfKey" (byval as XkbDescPtr, byval as integer, byval as integer, byval as uinteger, byval as integer ptr, byval as XkbMapChangesPtr) as Status
declare function XkbChangeKeycodeRange cdecl alias "XkbChangeKeycodeRange" (byval as XkbDescPtr, byval as integer, byval as integer, byval as XkbChangesPtr) as Status
declare function XkbListComponents cdecl alias "XkbListComponents" (byval as Display ptr, byval as uinteger, byval as XkbComponentNamesPtr, byval as integer ptr) as XkbComponentListPtr
declare sub XkbFreeComponentList cdecl alias "XkbFreeComponentList" (byval as XkbComponentListPtr)
declare function XkbGetKeyboard cdecl alias "XkbGetKeyboard" (byval as Display ptr, byval as uinteger, byval as uinteger) as XkbDescPtr
declare function XkbGetKeyboardByName cdecl alias "XkbGetKeyboardByName" (byval as Display ptr, byval as uinteger, byval as XkbComponentNamesPtr, byval as uinteger, byval as uinteger, byval as Bool) as XkbDescPtr
declare function XkbKeyTypesForCoreSymbols cdecl alias "XkbKeyTypesForCoreSymbols" (byval as XkbDescPtr, byval as integer, byval as KeySym ptr, byval as uinteger, byval as integer ptr, byval as KeySym ptr) as integer
declare function XkbApplyCompatMapToKey cdecl alias "XkbApplyCompatMapToKey" (byval as XkbDescPtr, byval as KeyCode, byval as XkbChangesPtr) as Bool
declare function XkbUpdateMapFromCore cdecl alias "XkbUpdateMapFromCore" (byval as XkbDescPtr, byval as KeyCode, byval as integer, byval as integer, byval as KeySym ptr, byval as XkbChangesPtr) as Bool
declare function XkbAddDeviceLedInfo cdecl alias "XkbAddDeviceLedInfo" (byval as XkbDeviceInfoPtr, byval as uinteger, byval as uinteger) as XkbDeviceLedInfoPtr
declare function XkbResizeDeviceButtonActions cdecl alias "XkbResizeDeviceButtonActions" (byval as XkbDeviceInfoPtr, byval as uinteger) as Status
declare function XkbAllocDeviceInfo cdecl alias "XkbAllocDeviceInfo" (byval as uinteger, byval as uinteger, byval as uinteger) as XkbDeviceInfoPtr
declare sub XkbFreeDeviceInfo cdecl alias "XkbFreeDeviceInfo" (byval as XkbDeviceInfoPtr, byval as uinteger, byval as Bool)
declare sub XkbNoteDeviceChanges cdecl alias "XkbNoteDeviceChanges" (byval as XkbDeviceChangesPtr, byval as XkbExtensionDeviceNotifyEvent ptr, byval as uinteger)
declare function XkbGetDeviceInfo cdecl alias "XkbGetDeviceInfo" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as XkbDeviceInfoPtr
declare function XkbGetDeviceInfoChanges cdecl alias "XkbGetDeviceInfoChanges" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as XkbDeviceChangesPtr) as Status
declare function XkbGetDeviceButtonActions cdecl alias "XkbGetDeviceButtonActions" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as Bool, byval as uinteger, byval as uinteger) as Status
declare function XkbGetDeviceLedInfo cdecl alias "XkbGetDeviceLedInfo" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as uinteger, byval as uinteger, byval as uinteger) as Status
declare function XkbSetDeviceInfo cdecl alias "XkbSetDeviceInfo" (byval as Display ptr, byval as uinteger, byval as XkbDeviceInfoPtr) as Bool
declare function XkbChangeDeviceInfo cdecl alias "XkbChangeDeviceInfo" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as XkbDeviceChangesPtr) as Bool
declare function XkbSetDeviceLedInfo cdecl alias "XkbSetDeviceLedInfo" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as uinteger, byval as uinteger, byval as uinteger) as Bool
declare function XkbSetDeviceButtonActions cdecl alias "XkbSetDeviceButtonActions" (byval as Display ptr, byval as XkbDeviceInfoPtr, byval as uinteger, byval as uinteger) as Bool
declare function XkbToControl cdecl alias "XkbToControl" (byval as byte) as byte
declare function XkbSetDebuggingFlags cdecl alias "XkbSetDebuggingFlags" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as zstring ptr, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as Bool
declare function XkbApplyVirtualModChanges cdecl alias "XkbApplyVirtualModChanges" (byval as XkbDescPtr, byval as uinteger, byval as XkbChangesPtr) as Bool
declare function XkbUpdateActionVirtualMods cdecl alias "XkbUpdateActionVirtualMods" (byval as XkbDescPtr, byval as XkbAction ptr, byval as uinteger) as Bool
declare sub XkbUpdateKeyTypeVirtualMods cdecl alias "XkbUpdateKeyTypeVirtualMods" (byval as XkbDescPtr, byval as XkbKeyTypePtr, byval as uinteger, byval as XkbChangesPtr)

#endif
