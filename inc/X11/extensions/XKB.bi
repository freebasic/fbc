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

#define _XKB_H_
const X_kbUseExtension = 0
const X_kbSelectEvents = 1
const X_kbBell = 3
const X_kbGetState = 4
const X_kbLatchLockState = 5
const X_kbGetControls = 6
const X_kbSetControls = 7
const X_kbGetMap = 8
const X_kbSetMap = 9
const X_kbGetCompatMap = 10
const X_kbSetCompatMap = 11
const X_kbGetIndicatorState = 12
const X_kbGetIndicatorMap = 13
const X_kbSetIndicatorMap = 14
const X_kbGetNamedIndicator = 15
const X_kbSetNamedIndicator = 16
const X_kbGetNames = 17
const X_kbSetNames = 18
const X_kbGetGeometry = 19
const X_kbSetGeometry = 20
const X_kbPerClientFlags = 21
const X_kbListComponents = 22
const X_kbGetKbdByName = 23
const X_kbGetDeviceInfo = 24
const X_kbSetDeviceInfo = 25
const X_kbSetDebuggingFlags = 101
const XkbEventCode = 0
const XkbNumberEvents = XkbEventCode + 1
const XkbNewKeyboardNotify = 0
const XkbMapNotify = 1
const XkbStateNotify = 2
const XkbControlsNotify = 3
const XkbIndicatorStateNotify = 4
const XkbIndicatorMapNotify = 5
const XkbNamesNotify = 6
const XkbCompatMapNotify = 7
const XkbBellNotify = 8
const XkbActionMessage = 9
const XkbAccessXNotify = 10
const XkbExtensionDeviceNotify = 11
const XkbNewKeyboardNotifyMask = cast(clong, 1) shl 0
const XkbMapNotifyMask = cast(clong, 1) shl 1
const XkbStateNotifyMask = cast(clong, 1) shl 2
const XkbControlsNotifyMask = cast(clong, 1) shl 3
const XkbIndicatorStateNotifyMask = cast(clong, 1) shl 4
const XkbIndicatorMapNotifyMask = cast(clong, 1) shl 5
const XkbNamesNotifyMask = cast(clong, 1) shl 6
const XkbCompatMapNotifyMask = cast(clong, 1) shl 7
const XkbBellNotifyMask = cast(clong, 1) shl 8
const XkbActionMessageMask = cast(clong, 1) shl 9
const XkbAccessXNotifyMask = cast(clong, 1) shl 10
const XkbExtensionDeviceNotifyMask = cast(clong, 1) shl 11
const XkbAllEventsMask = &hFFF
const XkbNKN_KeycodesMask = cast(clong, 1) shl 0
const XkbNKN_GeometryMask = cast(clong, 1) shl 1
const XkbNKN_DeviceIDMask = cast(clong, 1) shl 2
const XkbAllNewKeyboardEventsMask = &h7
const XkbAXN_SKPress = 0
const XkbAXN_SKAccept = 1
const XkbAXN_SKReject = 2
const XkbAXN_SKRelease = 3
const XkbAXN_BKAccept = 4
const XkbAXN_BKReject = 5
const XkbAXN_AXKWarning = 6
const XkbAXN_SKPressMask = cast(clong, 1) shl 0
const XkbAXN_SKAcceptMask = cast(clong, 1) shl 1
const XkbAXN_SKRejectMask = cast(clong, 1) shl 2
const XkbAXN_SKReleaseMask = cast(clong, 1) shl 3
const XkbAXN_BKAcceptMask = cast(clong, 1) shl 4
const XkbAXN_BKRejectMask = cast(clong, 1) shl 5
const XkbAXN_AXKWarningMask = cast(clong, 1) shl 6
const XkbAllAccessXEventsMask = &h7f
const XkbAllBellEventsMask = cast(clong, 1) shl 0
const XkbAllActionMessagesMask = cast(clong, 1) shl 0
const XkbKeyboard = 0
const XkbNumberErrors = 1
const XkbErr_BadDevice = &hff
const XkbErr_BadClass = &hfe
const XkbErr_BadId = &hfd
const XkbClientMapMask = cast(clong, 1) shl 0
const XkbServerMapMask = cast(clong, 1) shl 1
const XkbCompatMapMask = cast(clong, 1) shl 2
const XkbIndicatorMapMask = cast(clong, 1) shl 3
const XkbNamesMask = cast(clong, 1) shl 4
const XkbGeometryMask = cast(clong, 1) shl 5
const XkbControlsMask = cast(clong, 1) shl 6
const XkbAllComponentsMask = &h7f
const XkbModifierStateMask = cast(clong, 1) shl 0
const XkbModifierBaseMask = cast(clong, 1) shl 1
const XkbModifierLatchMask = cast(clong, 1) shl 2
const XkbModifierLockMask = cast(clong, 1) shl 3
const XkbGroupStateMask = cast(clong, 1) shl 4
const XkbGroupBaseMask = cast(clong, 1) shl 5
const XkbGroupLatchMask = cast(clong, 1) shl 6
const XkbGroupLockMask = cast(clong, 1) shl 7
const XkbCompatStateMask = cast(clong, 1) shl 8
const XkbGrabModsMask = cast(clong, 1) shl 9
const XkbCompatGrabModsMask = cast(clong, 1) shl 10
const XkbLookupModsMask = cast(clong, 1) shl 11
const XkbCompatLookupModsMask = cast(clong, 1) shl 12
const XkbPointerButtonMask = cast(clong, 1) shl 13
const XkbAllStateComponentsMask = &h3fff
const XkbAllStateEventsMask = XkbAllStateComponentsMask
const XkbRepeatKeysMask = cast(clong, 1) shl 0
const XkbSlowKeysMask = cast(clong, 1) shl 1
const XkbBounceKeysMask = cast(clong, 1) shl 2
const XkbStickyKeysMask = cast(clong, 1) shl 3
const XkbMouseKeysMask = cast(clong, 1) shl 4
const XkbMouseKeysAccelMask = cast(clong, 1) shl 5
const XkbAccessXKeysMask = cast(clong, 1) shl 6
const XkbAccessXTimeoutMask = cast(clong, 1) shl 7
const XkbAccessXFeedbackMask = cast(clong, 1) shl 8
const XkbAudibleBellMask = cast(clong, 1) shl 9
const XkbOverlay1Mask = cast(clong, 1) shl 10
const XkbOverlay2Mask = cast(clong, 1) shl 11
const XkbIgnoreGroupLockMask = cast(clong, 1) shl 12
const XkbGroupsWrapMask = cast(clong, 1) shl 27
const XkbInternalModsMask = cast(clong, 1) shl 28
const XkbIgnoreLockModsMask = cast(clong, 1) shl 29
const XkbPerKeyRepeatMask = cast(clong, 1) shl 30
const XkbControlsEnabledMask = cast(clong, 1) shl 31
const XkbAccessXOptionsMask = XkbStickyKeysMask or XkbAccessXFeedbackMask
const XkbAllBooleanCtrlsMask = &h00001FFF
const XkbAllControlsMask = &hF8001FFF
const XkbAllControlEventsMask = XkbAllControlsMask
const XkbAllControlEventsMask = XkbAllControlsMask
const XkbAX_SKPressFBMask = cast(clong, 1) shl 0
const XkbAX_SKAcceptFBMask = cast(clong, 1) shl 1
const XkbAX_FeatureFBMask = cast(clong, 1) shl 2
const XkbAX_SlowWarnFBMask = cast(clong, 1) shl 3
const XkbAX_IndicatorFBMask = cast(clong, 1) shl 4
const XkbAX_StickyKeysFBMask = cast(clong, 1) shl 5
const XkbAX_TwoKeysMask = cast(clong, 1) shl 6
const XkbAX_LatchToLockMask = cast(clong, 1) shl 7
const XkbAX_SKReleaseFBMask = cast(clong, 1) shl 8
const XkbAX_SKRejectFBMask = cast(clong, 1) shl 9
const XkbAX_BKRejectFBMask = cast(clong, 1) shl 10
const XkbAX_DumbBellFBMask = cast(clong, 1) shl 11
const XkbAX_FBOptionsMask = &hF3F
const XkbAX_SKOptionsMask = &h0C0
const XkbAX_AllOptionsMask = &hFFF
const XkbUseCoreKbd = &h0100
const XkbUseCorePtr = &h0200
const XkbDfltXIClass = &h0300
const XkbDfltXIId = &h0400
const XkbAllXIClasses = &h0500
const XkbAllXIIds = &h0600
const XkbXINone = &hff00
#define XkbLegalXILedClass(c) (((((c) = KbdFeedbackClass) orelse ((c) = LedFeedbackClass)) orelse ((c) = XkbDfltXIClass)) orelse ((c) = XkbAllXIClasses))
#define XkbLegalXIBellClass(c) (((((c) = KbdFeedbackClass) orelse ((c) = BellFeedbackClass)) orelse ((c) = XkbDfltXIClass)) orelse ((c) = XkbAllXIClasses))
#define XkbExplicitXIDevice(c) (((c) and (not &hff)) = 0)
#define XkbExplicitXIClass(c) (((c) and (not &hff)) = 0)
#define XkbExplicitXIId(c) (((c) and (not &hff)) = 0)
#define XkbSingleXIClass(c) ((((c) and (not &hff)) = 0) orelse ((c) = XkbDfltXIClass))
#define XkbSingleXIId(c) ((((c) and (not &hff)) = 0) orelse ((c) = XkbDfltXIId))
const XkbNoModifier = &hff
const XkbNoShiftLevel = &hff
const XkbNoShape = &hff
const XkbNoIndicator = &hff
const XkbNoModifierMask = 0
const XkbAllModifiersMask = &hff
const XkbAllVirtualModsMask = &hffff
const XkbNumKbdGroups = 4
const XkbMaxKbdGroup = XkbNumKbdGroups - 1
const XkbMaxMouseKeysBtn = 4
const XkbGroup1Index = 0
const XkbGroup2Index = 1
const XkbGroup3Index = 2
const XkbGroup4Index = 3
const XkbAnyGroup = 254
const XkbAllGroups = 255
const XkbGroup1Mask = 1 shl 0
const XkbGroup2Mask = 1 shl 1
const XkbGroup3Mask = 1 shl 2
const XkbGroup4Mask = 1 shl 3
const XkbAnyGroupMask = 1 shl 7
const XkbAllGroupsMask = &hf
#define XkbBuildCoreState(m, g) ((((g) and &h3) shl 13) or ((m) and &hff))
#define XkbGroupForCoreState(s) (((s) shr 13) and &h3)
#define XkbIsLegalGroup(g) (((g) >= 0) andalso ((g) < XkbNumKbdGroups))
const XkbWrapIntoRange = &h00
const XkbClampIntoRange = &h40
const XkbRedirectIntoRange = &h80
const XkbSA_ClearLocks = cast(clong, 1) shl 0
const XkbSA_LatchToLock = cast(clong, 1) shl 1
const XkbSA_LockNoLock = cast(clong, 1) shl 0
const XkbSA_LockNoUnlock = cast(clong, 1) shl 1
const XkbSA_UseModMapMods = cast(clong, 1) shl 2
const XkbSA_GroupAbsolute = cast(clong, 1) shl 2
const XkbSA_UseDfltButton = 0
const XkbSA_NoAcceleration = cast(clong, 1) shl 0
const XkbSA_MoveAbsoluteX = cast(clong, 1) shl 1
const XkbSA_MoveAbsoluteY = cast(clong, 1) shl 2
const XkbSA_ISODfltIsGroup = cast(clong, 1) shl 7
const XkbSA_ISONoAffectMods = cast(clong, 1) shl 6
const XkbSA_ISONoAffectGroup = cast(clong, 1) shl 5
const XkbSA_ISONoAffectPtr = cast(clong, 1) shl 4
const XkbSA_ISONoAffectCtrls = cast(clong, 1) shl 3
const XkbSA_ISOAffectMask = &h78
const XkbSA_MessageOnPress = cast(clong, 1) shl 0
const XkbSA_MessageOnRelease = cast(clong, 1) shl 1
const XkbSA_MessageGenKeyEvent = cast(clong, 1) shl 2
const XkbSA_AffectDfltBtn = 1
const XkbSA_DfltBtnAbsolute = cast(clong, 1) shl 2
const XkbSA_SwitchApplication = cast(clong, 1) shl 0
const XkbSA_SwitchAbsolute = cast(clong, 1) shl 2
const XkbSA_IgnoreVal = &h00
const XkbSA_SetValMin = &h10
const XkbSA_SetValCenter = &h20
const XkbSA_SetValMax = &h30
const XkbSA_SetValRelative = &h40
const XkbSA_SetValAbsolute = &h50
const XkbSA_ValOpMask = &h70
const XkbSA_ValScaleMask = &h07
#define XkbSA_ValOp(a) ((a) and XkbSA_ValOpMask)
#define XkbSA_ValScale(a) ((a) and XkbSA_ValScaleMask)
const XkbSA_NoAction = &h00
const XkbSA_SetMods = &h01
const XkbSA_LatchMods = &h02
const XkbSA_LockMods = &h03
const XkbSA_SetGroup = &h04
const XkbSA_LatchGroup = &h05
const XkbSA_LockGroup = &h06
const XkbSA_MovePtr = &h07
const XkbSA_PtrBtn = &h08
const XkbSA_LockPtrBtn = &h09
const XkbSA_SetPtrDflt = &h0a
const XkbSA_ISOLock = &h0b
const XkbSA_Terminate = &h0c
const XkbSA_SwitchScreen = &h0d
const XkbSA_SetControls = &h0e
const XkbSA_LockControls = &h0f
const XkbSA_ActionMessage = &h10
const XkbSA_RedirectKey = &h11
const XkbSA_DeviceBtn = &h12
const XkbSA_LockDeviceBtn = &h13
const XkbSA_DeviceValuator = &h14
const XkbSA_LastAction = XkbSA_DeviceValuator
const XkbSA_NumActions = XkbSA_LastAction + 1
const XkbSA_XFree86Private = &h86
const XkbSA_BreakLatch = ((((((((((1 shl XkbSA_NoAction) or (1 shl XkbSA_PtrBtn)) or (1 shl XkbSA_LockPtrBtn)) or (1 shl XkbSA_Terminate)) or (1 shl XkbSA_SwitchScreen)) or (1 shl XkbSA_SetControls)) or (1 shl XkbSA_LockControls)) or (1 shl XkbSA_ActionMessage)) or (1 shl XkbSA_RedirectKey)) or (1 shl XkbSA_DeviceBtn)) or (1 shl XkbSA_LockDeviceBtn)
#define XkbIsModAction(a) (((a)->type >= Xkb_SASetMods) andalso ((a)->type <= XkbSA_LockMods))
#define XkbIsGroupAction(a) (((a)->type >= XkbSA_SetGroup) andalso ((a)->type <= XkbSA_LockGroup))
#define XkbIsPtrAction(a) (((a)->type >= XkbSA_MovePtr) andalso ((a)->type <= XkbSA_SetPtrDflt))
const XkbKB_Permanent = &h80
const XkbKB_OpMask = &h7f
const XkbKB_Default = &h00
const XkbKB_Lock = &h01
const XkbKB_RadioGroup = &h02
const XkbKB_Overlay1 = &h03
const XkbKB_Overlay2 = &h04
const XkbKB_RGAllowNone = &h80
const XkbMinLegalKeyCode = 8
const XkbMaxLegalKeyCode = 255
const XkbMaxKeyCount = (XkbMaxLegalKeyCode - XkbMinLegalKeyCode) + 1
const XkbPerKeyBitArraySize = (XkbMaxLegalKeyCode + 1) / 8
#define XkbIsLegalKeycode(k) ((k) >= XkbMinLegalKeyCode)
const XkbNumModifiers = 8
const XkbNumVirtualMods = 16
const XkbNumIndicators = 32
const XkbAllIndicatorsMask = &hffffffff
const XkbAllIndicatorEventsMask = XkbAllIndicatorsMask
const XkbMaxRadioGroups = 32
const XkbAllRadioGroupsMask = &hffffffff
const XkbMaxShiftLevel = 63
const XkbMaxSymsPerKey = XkbMaxShiftLevel * XkbNumKbdGroups
const XkbRGMaxMembers = 12
const XkbActionMessageLength = 6
const XkbKeyNameLength = 4
const XkbMaxRedirectCount = 8
const XkbGeomPtsPerMM = 10
const XkbGeomMaxColors = 32
const XkbGeomMaxLabelColors = 3
const XkbGeomMaxPriority = 255
const XkbOneLevelIndex = 0
const XkbTwoLevelIndex = 1
const XkbAlphabeticIndex = 2
const XkbKeypadIndex = 3
const XkbLastRequiredType = XkbKeypadIndex
const XkbNumRequiredTypes = XkbLastRequiredType + 1
const XkbMaxKeyTypes = 255
const XkbOneLevelMask = 1 shl 0
const XkbTwoLevelMask = 1 shl 1
const XkbAlphabeticMask = 1 shl 2
const XkbKeypadMask = 1 shl 3
const XkbAllRequiredTypes = &hf
#define XkbShiftLevel(n) ((n) - 1)
#define XkbShiftLevelMask(n) (1 shl ((n) - 1))
#define XkbName "XKEYBOARD"
const XkbMajorVersion = 1
const XkbMinorVersion = 0
const XkbExplicitKeyTypesMask = &h0f
const XkbExplicitKeyType1Mask = 1 shl 0
const XkbExplicitKeyType2Mask = 1 shl 1
const XkbExplicitKeyType3Mask = 1 shl 2
const XkbExplicitKeyType4Mask = 1 shl 3
const XkbExplicitInterpretMask = 1 shl 4
const XkbExplicitAutoRepeatMask = 1 shl 5
const XkbExplicitBehaviorMask = 1 shl 6
const XkbExplicitVModMapMask = 1 shl 7
const XkbAllExplicitMask = &hff
const XkbKeyTypesMask = 1 shl 0
const XkbKeySymsMask = 1 shl 1
const XkbModifierMapMask = 1 shl 2
const XkbExplicitComponentsMask = 1 shl 3
const XkbKeyActionsMask = 1 shl 4
const XkbKeyBehaviorsMask = 1 shl 5
const XkbVirtualModsMask = 1 shl 6
const XkbVirtualModMapMask = 1 shl 7
const XkbAllClientInfoMask = (XkbKeyTypesMask or XkbKeySymsMask) or XkbModifierMapMask
const XkbAllServerInfoMask = (((XkbExplicitComponentsMask or XkbKeyActionsMask) or XkbKeyBehaviorsMask) or XkbVirtualModsMask) or XkbVirtualModMapMask
const XkbAllMapComponentsMask = XkbAllClientInfoMask or XkbAllServerInfoMask
const XkbAllMapEventsMask = XkbAllMapComponentsMask
const XkbSI_AutoRepeat = 1 shl 0
const XkbSI_LockingKey = 1 shl 1
const XkbSI_LevelOneOnly = &h80
const XkbSI_OpMask = &h7f
const XkbSI_NoneOf = 0
const XkbSI_AnyOfOrNone = 1
const XkbSI_AnyOf = 2
const XkbSI_AllOf = 3
const XkbSI_Exactly = 4
const XkbIM_NoExplicit = cast(clong, 1) shl 7
const XkbIM_NoAutomatic = cast(clong, 1) shl 6
const XkbIM_LEDDrivesKB = cast(clong, 1) shl 5
const XkbIM_UseBase = cast(clong, 1) shl 0
const XkbIM_UseLatched = cast(clong, 1) shl 1
const XkbIM_UseLocked = cast(clong, 1) shl 2
const XkbIM_UseEffective = cast(clong, 1) shl 3
const XkbIM_UseCompat = cast(clong, 1) shl 4
const XkbIM_UseNone = 0
const XkbIM_UseAnyGroup = ((XkbIM_UseBase or XkbIM_UseLatched) or XkbIM_UseLocked) or XkbIM_UseEffective
const XkbIM_UseAnyMods = XkbIM_UseAnyGroup or XkbIM_UseCompat
const XkbSymInterpMask = 1 shl 0
const XkbGroupCompatMask = 1 shl 1
const XkbAllCompatMask = &h3
const XkbAllCompatMapEventsMask = XkbAllCompatMask
const XkbKeycodesNameMask = 1 shl 0
const XkbGeometryNameMask = 1 shl 1
const XkbSymbolsNameMask = 1 shl 2
const XkbPhysSymbolsNameMask = 1 shl 3
const XkbTypesNameMask = 1 shl 4
const XkbCompatNameMask = 1 shl 5
const XkbKeyTypeNamesMask = 1 shl 6
const XkbKTLevelNamesMask = 1 shl 7
const XkbIndicatorNamesMask = 1 shl 8
const XkbKeyNamesMask = 1 shl 9
const XkbKeyAliasesMask = 1 shl 10
const XkbVirtualModNamesMask = 1 shl 11
const XkbGroupNamesMask = 1 shl 12
const XkbRGNamesMask = 1 shl 13
const XkbComponentNamesMask = &h3f
const XkbAllNamesMask = &h3fff
const XkbAllNameEventsMask = XkbAllNamesMask
const XkbGBN_TypesMask = cast(clong, 1) shl 0
const XkbGBN_CompatMapMask = cast(clong, 1) shl 1
const XkbGBN_ClientSymbolsMask = cast(clong, 1) shl 2
const XkbGBN_ServerSymbolsMask = cast(clong, 1) shl 3
const XkbGBN_SymbolsMask = XkbGBN_ClientSymbolsMask or XkbGBN_ServerSymbolsMask
const XkbGBN_IndicatorMapMask = cast(clong, 1) shl 4
const XkbGBN_KeyNamesMask = cast(clong, 1) shl 5
const XkbGBN_GeometryMask = cast(clong, 1) shl 6
const XkbGBN_OtherNamesMask = cast(clong, 1) shl 7
const XkbGBN_AllComponentsMask = &hff
const XkbLC_Hidden = cast(clong, 1) shl 0
const XkbLC_Default = cast(clong, 1) shl 1
const XkbLC_Partial = cast(clong, 1) shl 2
const XkbLC_AlphanumericKeys = cast(clong, 1) shl 8
const XkbLC_ModifierKeys = cast(clong, 1) shl 9
const XkbLC_KeypadKeys = cast(clong, 1) shl 10
const XkbLC_FunctionKeys = cast(clong, 1) shl 11
const XkbLC_AlternateGroup = cast(clong, 1) shl 12
const XkbXI_KeyboardsMask = cast(clong, 1) shl 0
const XkbXI_ButtonActionsMask = cast(clong, 1) shl 1
const XkbXI_IndicatorNamesMask = cast(clong, 1) shl 2
const XkbXI_IndicatorMapsMask = cast(clong, 1) shl 3
const XkbXI_IndicatorStateMask = cast(clong, 1) shl 4
const XkbXI_UnsupportedFeatureMask = cast(clong, 1) shl 15
const XkbXI_AllFeaturesMask = &h001f
const XkbXI_AllDeviceFeaturesMask = &h001e
const XkbXI_IndicatorsMask = &h001c
const XkbAllExtensionDeviceEventsMask = &h801f
const XkbPCF_DetectableAutoRepeatMask = cast(clong, 1) shl 0
const XkbPCF_GrabsUseXKBStateMask = cast(clong, 1) shl 1
const XkbPCF_AutoResetControlsMask = cast(clong, 1) shl 2
const XkbPCF_LookupStateWhenGrabbed = cast(clong, 1) shl 3
const XkbPCF_SendEventUsesXKBState = cast(clong, 1) shl 4
const XkbPCF_AllFlagsMask = &h1F
const XkbDF_DisableLocks = 1 shl 0
