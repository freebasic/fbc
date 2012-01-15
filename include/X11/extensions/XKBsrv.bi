''
''
'' XKBsrv -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XKBsrv_bi__
#define __XKBsrv_bi__

type _XkbInterest
	dev as DeviceIntPtr
	client as ClientPtr
	resource as XID
	next as _XkbInterest ptr
	extDevNotifyMask as CARD16
	stateNotifyMask as CARD16
	namesNotifyMask as CARD16
	ctrlsNotifyMask as CARD32
	compatNotifyMask as CARD8
	bellNotifyMask as BOOL
	actionMessageMask as BOOL
	accessXNotifyMask as CARD16
	iStateNotifyMask as CARD32
	iMapNotifyMask as CARD32
	altSymsNotifyMask as CARD16
	autoCtrls as CARD32
	autoCtrlValues as CARD32
end type

type XkbInterestRec as _XkbInterest
type XkbInterestPtr as _XkbInterest ptr

type _XkbRadioGroup
	flags as CARD8
	nMembers as CARD8
	dfltDown as CARD8
	currentDown as CARD8
	members(0 to XkbRGMaxMembers-1) as CARD8
end type

type XkbRadioGroupRec as _XkbRadioGroup
type XkbRadioGroupPtr as _XkbRadioGroup ptr

type _XkbEventCause
	kc as CARD8
	event as CARD8
	mjr as CARD8
	mnr as CARD8
	client as ClientPtr
end type

type XkbEventCauseRec as _XkbEventCause
type XkbEventCausePtr as _XkbEventCause ptr

#define _OFF_TIMER 0
#define _KRG_WARN_TIMER 1
#define _KRG_TIMER 2
#define _SK_TIMEOUT_TIMER 3
#define _ALL_TIMEOUT_TIMER 4
#define _BEEP_NONE 0
#define _BEEP_FEATURE_ON 1
#define _BEEP_FEATURE_OFF 2
#define _BEEP_FEATURE_CHANGE 3
#define _BEEP_SLOW_WARN 4
#define _BEEP_SLOW_PRESS 5
#define _BEEP_SLOW_ACCEPT 6
#define _BEEP_SLOW_REJECT 7
#define _BEEP_SLOW_RELEASE 8
#define _BEEP_STICKY_LATCH 9
#define _BEEP_STICKY_LOCK 10
#define _BEEP_STICKY_UNLOCK 11
#define _BEEP_LED_ON 12
#define _BEEP_LED_OFF 13
#define _BEEP_LED_CHANGE 14
#define _BEEP_BOUNCE_REJECT 15

type _XkbSrvInfo
	prev_state as XkbStateRec
	state as XkbStateRec
	desc as XkbDescPtr
	device as DeviceIntPtr
	kbdProc as KbdCtrlProcPtr
	radioGroups as XkbRadioGroupPtr
	nRadioGroups as CARD8
	clearMods as CARD8
	setMods as CARD8
	groupChange as INT16
	dfltPtrDelta as CARD16
	mouseKeysCurve as double
	mouseKeysCurveFactor as double
	mouseKeysDX as INT16
	mouseKeysDY as INT16
	mouseKeysFlags as CARD8
	mouseKeysAccel as Bool
	mouseKeysCounter as CARD8
	lockedPtrButtons as CARD8
	shiftKeyCount as CARD8
	mouseKey as KeyCode
	inactiveKey as KeyCode
	slowKey as KeyCode
	repeatKey as KeyCode
	krgTimerActive as CARD8
	beepType as CARD8
	beepCount as CARD8
	flags as CARD32
	lastPtrEventTime as CARD32
	lastShiftEventTime as CARD32
	beepTimer as OsTimerPtr
	mouseKeyTimer as OsTimerPtr
	slowKeysTimer as OsTimerPtr
	bounceKeysTimer as OsTimerPtr
	repeatKeyTimer as OsTimerPtr
	krgTimer as OsTimerPtr
end type

type XkbSrvInfoRec as _XkbSrvInfo
type XkbSrvInfoPtr as _XkbSrvInfo ptr

#define XkbSLI_IsDefault (1L shl 0)
#define XkbSLI_HasOwnState (1L shl 1)

type _XkbSrvLedInfo
	flags as CARD16
	class as CARD16
	id as CARD16
	physIndicators as CARD32
	autoState as CARD32
	explicitState as CARD32
	effectiveState as CARD32
	mapsPresent as CARD32
	namesPresent as CARD32
	maps as XkbIndicatorMapPtr
	names as Atom ptr
	usesBase as CARD32
	usesLatched as CARD32
	usesLocked as CARD32
	usesEffective as CARD32
	usesCompat as CARD32
	usesControls as CARD32
	usedComponents as CARD32
	fb as XkbSrvLedInfoRec__NESTED__fb
end type

type XkbSrvLedInfoRec as _XkbSrvLedInfo
type XkbSrvLedInfoPtr as _XkbSrvLedInfo ptr

union XkbSrvLedInfoRec__NESTED__fb
	kf as KbdFeedbackPtr
	lf as LedFeedbackPtr
end union

#define _XkbClientInitialized (1 shl 15)
#define _XkbStateNotifyInProgress (1 shl 0)

type xkbDeviceInfoRec
	processInputProc as ProcessInputProc
	realInputProc as ProcessInputProc
	unwrapProc as DeviceUnwrapProc
end type

type xkbDeviceInfoPtr as xkbDeviceInfoRec ptr
extern XkbReqCode alias "XkbReqCode" as integer
extern XkbEventBase alias "XkbEventBase" as integer
extern XkbKeyboardErrorCode alias "XkbKeyboardErrorCode" as integer
extern XkbDisableLockActions alias "XkbDisableLockActions" as integer
extern XkbBaseDirectory alias "XkbBaseDirectory" as zstring ptr
extern XkbBinDirectory alias "XkbBinDirectory" as zstring ptr
extern XkbInitialMap alias "XkbInitialMap" as zstring ptr
extern _XkbClientMajor alias "_XkbClientMajor" as integer
extern _XkbClientMinor alias "_XkbClientMinor" as integer
extern XkbXIUnsupported alias "XkbXIUnsupported" as uinteger
extern XkbModelUsed alias "XkbModelUsed" as zstring ptr
extern XkbLayoutUsed alias "XkbLayoutUsed" as zstring ptr
extern XkbVariantUsed alias "XkbVariantUsed" as zstring ptr
extern XkbOptionsUsed alias "XkbOptionsUsed" as zstring ptr
extern noXkbExtension alias "noXkbExtension" as Bool
extern XkbWantRulesProp alias "XkbWantRulesProp" as Bool
extern XkbLastRepeatEvent alias "XkbLastRepeatEvent" as pointer
extern xkbDebugFlags alias "xkbDebugFlags" as CARD32
extern xkbDebugCtrls alias "xkbDebugCtrls" as CARD32
extern DeviceKeyPress alias "DeviceKeyPress" as integer
extern DeviceKeyRelease alias "DeviceKeyRelease" as integer
extern DeviceButtonPress alias "DeviceButtonPress" as integer
extern DeviceButtonRelease alias "DeviceButtonRelease" as integer

#define True 1
#define False 0
#define PATH_MAX 1024

declare function XkbProcessArguments cdecl alias "XkbProcessArguments" (byval as integer, byval as byte ptr ptr, byval as integer) as integer
declare sub XkbSetExtension cdecl alias "XkbSetExtension" (byval device as DeviceIntPtr, byval proc as ProcessInputProc)
declare sub XkbFreeCompatMap cdecl alias "XkbFreeCompatMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare sub XkbFreeNames cdecl alias "XkbFreeNames" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function _XkbLookupAnyDevice cdecl alias "_XkbLookupAnyDevice" (byval as integer, byval as integer ptr) as DeviceIntPtr
declare function _XkbLookupKeyboard cdecl alias "_XkbLookupKeyboard" (byval as integer, byval as integer ptr) as DeviceIntPtr
declare function _XkbLookupBellDevice cdecl alias "_XkbLookupBellDevice" (byval as integer, byval as integer ptr) as DeviceIntPtr
declare function _XkbLookupLedDevice cdecl alias "_XkbLookupLedDevice" (byval as integer, byval as integer ptr) as DeviceIntPtr
declare function _XkbLookupButtonDevice cdecl alias "_XkbLookupButtonDevice" (byval as integer, byval as integer ptr) as DeviceIntPtr
declare function XkbAllocKeyboard cdecl alias "XkbAllocKeyboard" () as XkbDescPtr
declare function XkbAllocClientMap cdecl alias "XkbAllocClientMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as integer
declare function XkbAllocServerMap cdecl alias "XkbAllocServerMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as integer
declare sub XkbFreeClientMap cdecl alias "XkbFreeClientMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare sub XkbFreeServerMap cdecl alias "XkbFreeServerMap" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare function XkbAllocIndicatorMaps cdecl alias "XkbAllocIndicatorMaps" (byval as XkbDescPtr) as integer
declare function XkbAllocCompatMap cdecl alias "XkbAllocCompatMap" (byval as XkbDescPtr, byval as uinteger, byval as uinteger) as integer
declare function XkbAllocNames cdecl alias "XkbAllocNames" (byval as XkbDescPtr, byval as uinteger, byval as integer, byval as integer) as integer
declare function XkbAllocControls cdecl alias "XkbAllocControls" (byval as XkbDescPtr, byval as uinteger) as integer
declare function XkbCopyKeyType cdecl alias "XkbCopyKeyType" (byval as XkbKeyTypePtr, byval as XkbKeyTypePtr) as integer
declare function XkbCopyKeyTypes cdecl alias "XkbCopyKeyTypes" (byval as XkbKeyTypePtr, byval as XkbKeyTypePtr, byval as integer) as integer
declare function XkbResizeKeyType cdecl alias "XkbResizeKeyType" (byval as XkbDescPtr, byval as integer, byval as integer, byval as Bool, byval as integer) as integer
declare sub XkbFreeKeyboard cdecl alias "XkbFreeKeyboard" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare sub XkbSetActionKeyMods cdecl alias "XkbSetActionKeyMods" (byval as XkbDescPtr, byval as XkbAction ptr, byval as uinteger)
declare function XkbCheckActionVMods cdecl alias "XkbCheckActionVMods" (byval as XkbDescPtr, byval as XkbAction ptr, byval as uinteger) as Bool
declare function XkbApplyVModChanges cdecl alias "XkbApplyVModChanges" (byval as XkbSrvInfoPtr, byval as uinteger, byval as XkbChangesPtr, byval as uinteger ptr, byval as XkbEventCausePtr) as Bool
declare sub XkbApplyVModChangesToAllDevices cdecl alias "XkbApplyVModChangesToAllDevices" (byval as DeviceIntPtr, byval as XkbDescPtr, byval as uinteger, byval as XkbEventCausePtr)
declare function XkbMaskForVMask cdecl alias "XkbMaskForVMask" (byval as XkbDescPtr, byval as uinteger) as uinteger
declare function XkbVirtualModsToReal cdecl alias "XkbVirtualModsToReal" (byval as XkbDescPtr, byval as uinteger, byval as uinteger ptr) as Bool
declare function XkbAdjustGroup cdecl alias "XkbAdjustGroup" (byval as integer, byval as XkbControlsPtr) as uinteger
declare function XkbResizeKeySyms cdecl alias "XkbResizeKeySyms" (byval as XkbDescPtr, byval as integer, byval as integer) as KeySym ptr
declare function XkbResizeKeyActions cdecl alias "XkbResizeKeyActions" (byval as XkbDescPtr, byval as integer, byval as integer) as XkbAction ptr
declare sub XkbUpdateKeyTypesFromCore cdecl alias "XkbUpdateKeyTypesFromCore" (byval as DeviceIntPtr, byval as KeyCode, byval as CARD8, byval as XkbChangesPtr)
declare sub XkbUpdateDescActions cdecl alias "XkbUpdateDescActions" (byval as XkbDescPtr, byval as KeyCode, byval as CARD8, byval as XkbChangesPtr)
declare sub XkbUpdateActions cdecl alias "XkbUpdateActions" (byval as DeviceIntPtr, byval as KeyCode, byval as CARD8, byval as XkbChangesPtr, byval as uinteger ptr, byval as XkbEventCausePtr)
declare sub XkbUpdateCoreDescription cdecl alias "XkbUpdateCoreDescription" (byval as DeviceIntPtr, byval as Bool)
declare sub XkbApplyMappingChange cdecl alias "XkbApplyMappingChange" (byval as DeviceIntPtr, byval as CARD8, byval as KeyCode, byval as CARD8, byval as ClientPtr)
declare sub XkbSetIndicators cdecl alias "XkbSetIndicators" (byval as DeviceIntPtr, byval as CARD32, byval as CARD32, byval as XkbEventCausePtr)
declare sub XkbUpdateIndicators cdecl alias "XkbUpdateIndicators" (byval as DeviceIntPtr, byval as CARD32, byval as Bool, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare function XkbAllocSrvLedInfo cdecl alias "XkbAllocSrvLedInfo" (byval as DeviceIntPtr, byval as KbdFeedbackPtr, byval as LedFeedbackPtr, byval as uinteger) as XkbSrvLedInfoPtr
declare function XkbFindSrvLedInfo cdecl alias "XkbFindSrvLedInfo" (byval as DeviceIntPtr, byval as uinteger, byval as uinteger, byval as uinteger) as XkbSrvLedInfoPtr
declare sub XkbApplyLedNameChanges cdecl alias "XkbApplyLedNameChanges" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as uinteger, byval as xkbExtensionDeviceNotify ptr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbApplyLedMapChanges cdecl alias "XkbApplyLedMapChanges" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as uinteger, byval as xkbExtensionDeviceNotify ptr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbApplyLedStateChanges cdecl alias "XkbApplyLedStateChanges" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as uinteger, byval as xkbExtensionDeviceNotify ptr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbUpdateLedAutoState cdecl alias "XkbUpdateLedAutoState" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as uinteger, byval as xkbExtensionDeviceNotify ptr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbFlushLedEvents cdecl alias "XkbFlushLedEvents" (byval as DeviceIntPtr, byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as xkbExtensionDeviceNotify ptr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbUpdateAllDeviceIndicators cdecl alias "XkbUpdateAllDeviceIndicators" (byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare function XkbIndicatorsToUpdate cdecl alias "XkbIndicatorsToUpdate" (byval as DeviceIntPtr, byval as uinteger, byval as Bool) as uinteger
declare sub XkbComputeDerivedState cdecl alias "XkbComputeDerivedState" (byval as XkbSrvInfoPtr)
declare sub XkbCheckSecondaryEffects cdecl alias "XkbCheckSecondaryEffects" (byval as XkbSrvInfoPtr, byval as uinteger, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbCheckIndicatorMaps cdecl alias "XkbCheckIndicatorMaps" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as uinteger)
declare function XkbStateChangedFlags cdecl alias "XkbStateChangedFlags" (byval as XkbStatePtr, byval as XkbStatePtr) as uinteger
declare sub XkbSendStateNotify cdecl alias "XkbSendStateNotify" (byval as DeviceIntPtr, byval as xkbStateNotify ptr)
declare sub XkbSendMapNotify cdecl alias "XkbSendMapNotify" (byval as DeviceIntPtr, byval as xkbMapNotify ptr)
declare function XkbComputeControlsNotify cdecl alias "XkbComputeControlsNotify" (byval as DeviceIntPtr, byval as XkbControlsPtr, byval as XkbControlsPtr, byval as xkbControlsNotify ptr, byval as Bool) as integer
declare sub XkbSendControlsNotify cdecl alias "XkbSendControlsNotify" (byval as DeviceIntPtr, byval as xkbControlsNotify ptr)
declare sub XkbSendCompatMapNotify cdecl alias "XkbSendCompatMapNotify" (byval as DeviceIntPtr, byval as xkbCompatMapNotify ptr)
declare sub XkbSendIndicatorNotify cdecl alias "XkbSendIndicatorNotify" (byval as DeviceIntPtr, byval as integer, byval as xkbIndicatorNotify ptr)
declare sub XkbHandleBell cdecl alias "XkbHandleBell" (byval as BOOL, byval as BOOL, byval as DeviceIntPtr, byval as CARD8, byval as pointer, byval as CARD8, byval as Atom, byval as WindowPtr, byval as ClientPtr)
declare sub XkbSendAccessXNotify cdecl alias "XkbSendAccessXNotify" (byval as DeviceIntPtr, byval as xkbAccessXNotify ptr)
declare sub XkbSendNamesNotify cdecl alias "XkbSendNamesNotify" (byval as DeviceIntPtr, byval as xkbNamesNotify ptr)
declare sub XkbSendCompatNotify cdecl alias "XkbSendCompatNotify" (byval as DeviceIntPtr, byval as xkbCompatMapNotify ptr)
declare sub XkbSendActionMessage cdecl alias "XkbSendActionMessage" (byval as DeviceIntPtr, byval as xkbActionMessage ptr)
declare sub XkbSendExtensionDeviceNotify cdecl alias "XkbSendExtensionDeviceNotify" (byval as DeviceIntPtr, byval as ClientPtr, byval as xkbExtensionDeviceNotify ptr)
declare sub XkbSendNotification cdecl alias "XkbSendNotification" (byval as DeviceIntPtr, byval as XkbChangesPtr, byval as XkbEventCausePtr)
declare sub XkbProcessKeyboardEvent cdecl alias "XkbProcessKeyboardEvent" (byval as _xEvent ptr, byval as DeviceIntPtr, byval as integer)
declare sub XkbProcessOtherEvent cdecl alias "XkbProcessOtherEvent" (byval as _xEvent ptr, byval as DeviceIntPtr, byval as integer)
declare sub XkbHandleActions cdecl alias "XkbHandleActions" (byval as DeviceIntPtr, byval as DeviceIntPtr, byval as _xEvent ptr, byval as integer)
declare function XkbEnableDisableControls cdecl alias "XkbEnableDisableControls" (byval as XkbSrvInfoPtr, byval as uinteger, byval as uinteger, byval as XkbChangesPtr, byval as XkbEventCausePtr) as Bool
declare sub AccessXInit cdecl alias "AccessXInit" (byval as DeviceIntPtr)
declare function AccessXFilterPressEvent cdecl alias "AccessXFilterPressEvent" (byval as _xEvent ptr, byval as DeviceIntPtr, byval as integer) as Bool
declare function AccessXFilterReleaseEvent cdecl alias "AccessXFilterReleaseEvent" (byval as _xEvent ptr, byval as DeviceIntPtr, byval as integer) as Bool
declare sub AccessXCancelRepeatKey cdecl alias "AccessXCancelRepeatKey" (byval as XkbSrvInfoPtr, byval as KeyCode)
declare sub AccessXComputeCurveFactor cdecl alias "AccessXComputeCurveFactor" (byval as XkbSrvInfoPtr, byval as XkbControlsPtr)
declare function XkbAddDeviceLedInfo cdecl alias "XkbAddDeviceLedInfo" (byval as XkbDeviceInfoPtr, byval as uinteger, byval as uinteger) as XkbDeviceLedInfoPtr
declare function XkbAllocDeviceInfo cdecl alias "XkbAllocDeviceInfo" (byval as uinteger, byval as uinteger, byval as uinteger) as XkbDeviceInfoPtr
declare sub XkbFreeDeviceInfo cdecl alias "XkbFreeDeviceInfo" (byval as XkbDeviceInfoPtr, byval as uinteger, byval as Bool)
declare function XkbResizeDeviceButtonActions cdecl alias "XkbResizeDeviceButtonActions" (byval as XkbDeviceInfoPtr, byval as uinteger) as integer
declare function XkbFindClientResource cdecl alias "XkbFindClientResource" (byval as DevicePtr, byval as ClientPtr) as XkbInterestPtr
declare function XkbAddClientResource cdecl alias "XkbAddClientResource" (byval as DevicePtr, byval as ClientPtr, byval as XID) as XkbInterestPtr
declare function XkbRemoveClient cdecl alias "XkbRemoveClient" (byval as DevicePtr, byval as ClientPtr) as integer
declare function XkbRemoveResourceClient cdecl alias "XkbRemoveResourceClient" (byval as DevicePtr, byval as XID) as integer
declare function XkbDDXInitDevice cdecl alias "XkbDDXInitDevice" (byval as DeviceIntPtr) as integer
declare function XkbDDXAccessXBeep cdecl alias "XkbDDXAccessXBeep" (byval as DeviceIntPtr, byval as uinteger, byval as uinteger) as integer
declare sub XkbDDXKeyClick cdecl alias "XkbDDXKeyClick" (byval as DeviceIntPtr, byval as integer, byval as integer)
declare function XkbDDXUsesSoftRepeat cdecl alias "XkbDDXUsesSoftRepeat" (byval as DeviceIntPtr) as integer
declare sub XkbDDXKeybdCtrlProc cdecl alias "XkbDDXKeybdCtrlProc" (byval as DeviceIntPtr, byval as KeybdCtrl ptr)
declare sub XkbDDXChangeControls cdecl alias "XkbDDXChangeControls" (byval as DeviceIntPtr, byval as XkbControlsPtr, byval as XkbControlsPtr)
declare sub XkbDDXUpdateIndicators cdecl alias "XkbDDXUpdateIndicators" (byval as DeviceIntPtr, byval as CARD32)
declare sub XkbDDXUpdateDeviceIndicators cdecl alias "XkbDDXUpdateDeviceIndicators" (byval as DeviceIntPtr, byval as XkbSrvLedInfoPtr, byval as CARD32)
declare sub XkbDDXFakePointerButton cdecl alias "XkbDDXFakePointerButton" (byval as integer, byval as integer)
declare sub XkbDDXFakePointerMotion cdecl alias "XkbDDXFakePointerMotion" (byval as uinteger, byval as integer, byval as integer)
declare sub XkbDDXFakeDeviceButton cdecl alias "XkbDDXFakeDeviceButton" (byval as DeviceIntPtr, byval as Bool, byval as integer)
declare function XkbDDXTerminateServer cdecl alias "XkbDDXTerminateServer" (byval as DeviceIntPtr, byval as KeyCode, byval as XkbAction ptr) as integer
declare function XkbDDXSwitchScreen cdecl alias "XkbDDXSwitchScreen" (byval as DeviceIntPtr, byval as KeyCode, byval as XkbAction ptr) as integer
declare function XkbDDXPrivate cdecl alias "XkbDDXPrivate" (byval as DeviceIntPtr, byval as KeyCode, byval as XkbAction ptr) as integer
declare sub XkbDisableComputedAutoRepeats cdecl alias "XkbDisableComputedAutoRepeats" (byval as DeviceIntPtr, byval as uinteger)
declare sub XkbSetRepeatKeys cdecl alias "XkbSetRepeatKeys" (byval as DeviceIntPtr, byval as integer, byval as integer)
declare function XkbLatchModifiers cdecl alias "XkbLatchModifiers" (byval as DeviceIntPtr, byval as CARD8, byval as CARD8) as integer
declare function XkbLatchGroup cdecl alias "XkbLatchGroup" (byval as DeviceIntPtr, byval as integer) as integer
declare sub XkbClearAllLatchesAndLocks cdecl alias "XkbClearAllLatchesAndLocks" (byval as DeviceIntPtr, byval as XkbSrvInfoPtr, byval as Bool, byval as XkbEventCausePtr)
declare sub XkbSetRulesDflts cdecl alias "XkbSetRulesDflts" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare sub XkbInitDevice cdecl alias "XkbInitDevice" (byval as DeviceIntPtr)
declare function XkbInitKeyboardDeviceStruct cdecl alias "XkbInitKeyboardDeviceStruct" (byval as DeviceIntPtr, byval as XkbComponentNamesPtr, byval as KeySymsPtr, byval as CARD8 ptr, byval as BellProcPtr, byval as KbdCtrlProcPtr) as Bool
declare function SProcXkbDispatch cdecl alias "SProcXkbDispatch" (byval as ClientPtr) as integer
declare function XkbLookupNamedGeometry cdecl alias "XkbLookupNamedGeometry" (byval as DeviceIntPtr, byval as Atom, byval as Bool ptr) as XkbGeometryPtr
declare function _XkbDupString cdecl alias "_XkbDupString" (byval as zstring ptr) as zstring ptr
declare sub XkbConvertCase cdecl alias "XkbConvertCase" (byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
declare function XkbChangeKeycodeRange cdecl alias "XkbChangeKeycodeRange" (byval as XkbDescPtr, byval as integer, byval as integer, byval as XkbChangesPtr) as integer
declare function XkbFinishDeviceInit cdecl alias "XkbFinishDeviceInit" (byval as DeviceIntPtr) as integer
declare sub XkbFreeSrvLedInfo cdecl alias "XkbFreeSrvLedInfo" (byval as XkbSrvLedInfoPtr)
declare sub XkbFreeInfo cdecl alias "XkbFreeInfo" (byval as XkbSrvInfoPtr)
declare function XkbChangeTypesOfKey cdecl alias "XkbChangeTypesOfKey" (byval as XkbDescPtr, byval as integer, byval as integer, byval as uinteger, byval as integer ptr, byval as XkbMapChangesPtr) as integer
declare function XkbAddKeyType cdecl alias "XkbAddKeyType" (byval as XkbDescPtr, byval as Atom, byval as integer, byval as Bool, byval as integer) as XkbKeyTypePtr
declare function XkbInitCanonicalKeyTypes cdecl alias "XkbInitCanonicalKeyTypes" (byval as XkbDescPtr, byval as uinteger, byval as integer) as integer
declare function XkbKeyTypesForCoreSymbols cdecl alias "XkbKeyTypesForCoreSymbols" (byval as XkbDescPtr, byval as integer, byval as KeySym ptr, byval as uinteger, byval as integer ptr, byval as KeySym ptr) as integer
declare function XkbApplyCompatMapToKey cdecl alias "XkbApplyCompatMapToKey" (byval as XkbDescPtr, byval as KeyCode, byval as XkbChangesPtr) as Bool
declare function XkbUpdateMapFromCore cdecl alias "XkbUpdateMapFromCore" (byval as XkbDescPtr, byval as KeyCode, byval as integer, byval as integer, byval as KeySym ptr, byval as XkbChangesPtr) as Bool
declare sub XkbFreeControls cdecl alias "XkbFreeControls" (byval as XkbDescPtr, byval as uinteger, byval as Bool)
declare sub XkbFreeIndicatorMaps cdecl alias "XkbFreeIndicatorMaps" (byval as XkbDescPtr)
declare function XkbApplyVirtualModChanges cdecl alias "XkbApplyVirtualModChanges" (byval as XkbDescPtr, byval as uinteger, byval as XkbChangesPtr) as Bool
declare function XkbUpdateActionVirtualMods cdecl alias "XkbUpdateActionVirtualMods" (byval as XkbDescPtr, byval as XkbAction ptr, byval as uinteger) as Bool
declare sub XkbUpdateKeyTypeVirtualMods cdecl alias "XkbUpdateKeyTypeVirtualMods" (byval as XkbDescPtr, byval as XkbKeyTypePtr, byval as uinteger, byval as XkbChangesPtr)
declare sub XkbSendNewKeyboardNotify cdecl alias "XkbSendNewKeyboardNotify" (byval as DeviceIntPtr, byval as xkbNewKeyboardNotify ptr)

#endif
