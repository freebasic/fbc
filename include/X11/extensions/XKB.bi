''
''
'' XKB -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XKB_bi__
#define __XKB_bi__

#define X_kbUseExtension 0
#define X_kbSelectEvents 1
#define X_kbBell 3
#define X_kbGetState 4
#define X_kbLatchLockState 5
#define X_kbGetControls 6
#define X_kbSetControls 7
#define X_kbGetMap 8
#define X_kbSetMap 9
#define X_kbGetCompatMap 10
#define X_kbSetCompatMap 11
#define X_kbGetIndicatorState 12
#define X_kbGetIndicatorMap 13
#define X_kbSetIndicatorMap 14
#define X_kbGetNamedIndicator 15
#define X_kbSetNamedIndicator 16
#define X_kbGetNames 17
#define X_kbSetNames 18
#define X_kbGetGeometry 19
#define X_kbSetGeometry 20
#define X_kbPerClientFlags 21
#define X_kbListComponents 22
#define X_kbGetKbdByName 23
#define X_kbGetDeviceInfo 24
#define X_kbSetDeviceInfo 25
#define X_kbSetDebuggingFlags 101
#define XkbEventCode 0
#define XkbNumberEvents (0+1)
#define XkbNewKeyboardNotify 0
#define XkbMapNotify 1
#define XkbStateNotify 2
#define XkbControlsNotify 3
#define XkbIndicatorStateNotify 4
#define XkbIndicatorMapNotify 5
#define XkbNamesNotify 6
#define XkbCompatMapNotify 7
#define XkbBellNotify 8
#define XkbActionMessage 9
#define XkbAccessXNotify 10
#define XkbExtensionDeviceNotify 11
#define XkbNewKeyboardNotifyMask (1L shl 0)
#define XkbMapNotifyMask (1L shl 1)
#define XkbStateNotifyMask (1L shl 2)
#define XkbControlsNotifyMask (1L shl 3)
#define XkbIndicatorStateNotifyMask (1L shl 4)
#define XkbIndicatorMapNotifyMask (1L shl 5)
#define XkbNamesNotifyMask (1L shl 6)
#define XkbCompatMapNotifyMask (1L shl 7)
#define XkbBellNotifyMask (1L shl 8)
#define XkbActionMessageMask (1L shl 9)
#define XkbAccessXNotifyMask (1L shl 10)
#define XkbExtensionDeviceNotifyMask (1L shl 11)
#define XkbAllEventsMask (&hFFF)
#define XkbNKN_KeycodesMask (1L shl 0)
#define XkbNKN_GeometryMask (1L shl 1)
#define XkbNKN_DeviceIDMask (1L shl 2)
#define XkbAllNewKeyboardEventsMask (&h7)
#define XkbAXN_SKPress 0
#define XkbAXN_SKAccept 1
#define XkbAXN_SKReject 2
#define XkbAXN_SKRelease 3
#define XkbAXN_BKAccept 4
#define XkbAXN_BKReject 5
#define XkbAXN_AXKWarning 6
#define XkbAXN_SKPressMask (1L shl 0)
#define XkbAXN_SKAcceptMask (1L shl 1)
#define XkbAXN_SKRejectMask (1L shl 2)
#define XkbAXN_SKReleaseMask (1L shl 3)
#define XkbAXN_BKAcceptMask (1L shl 4)
#define XkbAXN_BKRejectMask (1L shl 5)
#define XkbAXN_AXKWarningMask (1L shl 6)
#define XkbAllAccessXEventsMask (&hf)
#define XkbAllBellEventsMask (1L shl 0)
#define XkbAllActionMessagesMask (1L shl 0)
#define XkbKeyboard 0
#define XkbNumberErrors 1
#define XkbErr_BadDevice &hff
#define XkbErr_BadClass &hfe
#define XkbErr_BadId &hfd
#define XkbClientMapMask (1L shl 0)
#define XkbServerMapMask (1L shl 1)
#define XkbCompatMapMask (1L shl 2)
#define XkbIndicatorMapMask (1L shl 3)
#define XkbNamesMask (1L shl 4)
#define XkbGeometryMask (1L shl 5)
#define XkbControlsMask (1L shl 6)
#define XkbAllComponentsMask (&h7f)
#define XkbModifierStateMask (1L shl 0)
#define XkbModifierBaseMask (1L shl 1)
#define XkbModifierLatchMask (1L shl 2)
#define XkbModifierLockMask (1L shl 3)
#define XkbGroupStateMask (1L shl 4)
#define XkbGroupBaseMask (1L shl 5)
#define XkbGroupLatchMask (1L shl 6)
#define XkbGroupLockMask (1L shl 7)
#define XkbCompatStateMask (1L shl 8)
#define XkbGrabModsMask (1L shl 9)
#define XkbCompatGrabModsMask (1L shl 10)
#define XkbLookupModsMask (1L shl 11)
#define XkbCompatLookupModsMask (1L shl 12)
#define XkbPointerButtonMask (1L shl 13)
#define XkbAllStateComponentsMask (&h3fff)
#define XkbRepeatKeysMask (1L shl 0)
#define XkbSlowKeysMask (1L shl 1)
#define XkbBounceKeysMask (1L shl 2)
#define XkbStickyKeysMask (1L shl 3)
#define XkbMouseKeysMask (1L shl 4)
#define XkbMouseKeysAccelMask (1L shl 5)
#define XkbAccessXKeysMask (1L shl 6)
#define XkbAccessXTimeoutMask (1L shl 7)
#define XkbAccessXFeedbackMask (1L shl 8)
#define XkbAudibleBellMask (1L shl 9)
#define XkbOverlay1Mask (1L shl 10)
#define XkbOverlay2Mask (1L shl 11)
#define XkbIgnoreGroupLockMask (1L shl 12)
#define XkbGroupsWrapMask (1L shl 27)
#define XkbInternalModsMask (1L shl 28)
#define XkbIgnoreLockModsMask (1L shl 29)
#define XkbPerKeyRepeatMask (1L shl 30)
#define XkbControlsEnabledMask (1L shl 31)
#define XkbAccessXOptionsMask ((1L shl 3) or (1L shl 8))
#define XkbAllBooleanCtrlsMask (&h00001FFF)
#define XkbAllControlsMask (&hF8001FFF)
#define XkbAllControlEventsMask (&hF8001FFF)
#define XkbAX_SKPressFBMask (1L shl 0)
#define XkbAX_SKAcceptFBMask (1L shl 1)
#define XkbAX_FeatureFBMask (1L shl 2)
#define XkbAX_SlowWarnFBMask (1L shl 3)
#define XkbAX_IndicatorFBMask (1L shl 4)
#define XkbAX_StickyKeysFBMask (1L shl 5)
#define XkbAX_TwoKeysMask (1L shl 6)
#define XkbAX_LatchToLockMask (1L shl 7)
#define XkbAX_SKReleaseFBMask (1L shl 8)
#define XkbAX_SKRejectFBMask (1L shl 9)
#define XkbAX_BKRejectFBMask (1L shl 10)
#define XkbAX_DumbBellFBMask (1L shl 11)
#define XkbAX_FBOptionsMask (&hF3F)
#define XkbAX_SKOptionsMask (&h0C0)
#define XkbAX_AllOptionsMask (&hFFF)
#define XkbUseCoreKbd &h0100
#define XkbUseCorePtr &h0200
#define XkbDfltXIClass &h0300
#define XkbDfltXIId &h0400
#define XkbAllXIClasses &h0500
#define XkbAllXIIds &h0600
#define XkbXINone &hff00
#define XkbNoModifier &hff
#define XkbNoShiftLevel &hff
#define XkbNoShape &hff
#define XkbNoIndicator &hff
#define XkbNoModifierMask 0
#define XkbAllModifiersMask &hff
#define XkbAllVirtualModsMask &hffff
#define XkbNumKbdGroups 4
#define XkbMaxKbdGroup (4-1)
#define XkbMaxMouseKeysBtn 4
#define XkbGroup1Index 0
#define XkbGroup2Index 1
#define XkbGroup3Index 2
#define XkbGroup4Index 3
#define XkbAnyGroup 254
#define XkbAllGroups 255
#define XkbGroup1Mask (1 shl 0)
#define XkbGroup2Mask (1 shl 1)
#define XkbGroup3Mask (1 shl 2)
#define XkbGroup4Mask (1 shl 3)
#define XkbAnyGroupMask (1 shl 7)
#define XkbAllGroupsMask (&hf)
#define XkbWrapIntoRange (&h00)
#define XkbClampIntoRange (&h40)
#define XkbRedirectIntoRange (&h80)
#define XkbSA_ClearLocks (1L shl 0)
#define XkbSA_LatchToLock (1L shl 1)
#define XkbSA_LockNoLock (1L shl 0)
#define XkbSA_LockNoUnlock (1L shl 1)
#define XkbSA_UseModMapMods (1L shl 2)
#define XkbSA_GroupAbsolute (1L shl 2)
#define XkbSA_UseDfltButton 0
#define XkbSA_NoAcceleration (1L shl 0)
#define XkbSA_MoveAbsoluteX (1L shl 1)
#define XkbSA_MoveAbsoluteY (1L shl 2)
#define XkbSA_ISODfltIsGroup (1L shl 7)
#define XkbSA_ISONoAffectMods (1L shl 6)
#define XkbSA_ISONoAffectGroup (1L shl 5)
#define XkbSA_ISONoAffectPtr (1L shl 4)
#define XkbSA_ISONoAffectCtrls (1L shl 3)
#define XkbSA_ISOAffectMask (&h78)
#define XkbSA_MessageOnPress (1L shl 0)
#define XkbSA_MessageOnRelease (1L shl 1)
#define XkbSA_MessageGenKeyEvent (1L shl 2)
#define XkbSA_AffectDfltBtn 1
#define XkbSA_DfltBtnAbsolute (1L shl 2)
#define XkbSA_SwitchApplication (1L shl 0)
#define XkbSA_SwitchAbsolute (1L shl 2)
#define XkbSA_IgnoreVal (&h00)
#define XkbSA_SetValMin (&h10)
#define XkbSA_SetValCenter (&h20)
#define XkbSA_SetValMax (&h30)
#define XkbSA_SetValRelative (&h40)
#define XkbSA_SetValAbsolute (&h50)
#define XkbSA_ValOpMask (&h70)
#define XkbSA_ValScaleMask (&h07)
#define XkbSA_NoAction &h00
#define XkbSA_SetMods &h01
#define XkbSA_LatchMods &h02
#define XkbSA_LockMods &h03
#define XkbSA_SetGroup &h04
#define XkbSA_LatchGroup &h05
#define XkbSA_LockGroup &h06
#define XkbSA_MovePtr &h07
#define XkbSA_PtrBtn &h08
#define XkbSA_LockPtrBtn &h09
#define XkbSA_SetPtrDflt &h0a
#define XkbSA_ISOLock &h&b
#define XkbSA_Terminate &h0c
#define XkbSA_SwitchScreen &h0d
#define XkbSA_SetControls &h0e
#define XkbSA_LockControls &h0f
#define XkbSA_ActionMessage &h10
#define XkbSA_RedirectKey &h11
#define XkbSA_DeviceBtn &h12
#define XkbSA_LockDeviceBtn &h13
#define XkbSA_DeviceValuator &h14
#define XkbSA_LastAction &h14
#define XkbSA_NumActions (&h14+1)
#define XkbSA_XFree86Private &h86
#define XkbSA_BreakLatch ((1 shl &h00) or (1 shl &h08) or (1 shl &h09) or (1 shl &h0c) or (1 shl &h0d) or (1 shl &h0e) or (1 shl &h0f) or (1 shl &h10) or (1 shl &h11) or (1 shl &h12) or (1 shl &h13))
#define XkbKB_Permanent &h80
#define XkbKB_OpMask &h7f
#define XkbKB_Default &h00
#define XkbKB_Lock &h01
#define XkbKB_RadioGroup &h02
#define XkbKB_Overlay1 &h03
#define XkbKB_Overlay2 &h04
#define XkbKB_RGAllowNone &h80
#define XkbMinLegalKeyCode 8
#define XkbMaxLegalKeyCode 255
#define XkbMaxKeyCount (255-8+1)
#define XkbPerKeyBitArraySize ((255+1)/8)
#define XkbNumModifiers 8
#define XkbNumVirtualMods 16
#define XkbNumIndicators 32
#define XkbAllIndicatorsMask (&hffffffff)
#define XkbMaxRadioGroups 32
#define XkbAllRadioGroupsMask (&hffffffff)
#define XkbMaxShiftLevel 63
#define XkbMaxSymsPerKey (63*4)
#define XkbRGMaxMembers 12
#define XkbActionMessageLength 6
#define XkbKeyNameLength 4
#define XkbMaxRedirectCount 8
#define XkbGeomPtsPerMM 10
#define XkbGeomMaxColors 32
#define XkbGeomMaxLabelColors 3
#define XkbGeomMaxPriority 255
#define XkbOneLevelIndex 0
#define XkbTwoLevelIndex 1
#define XkbAlphabeticIndex 2
#define XkbKeypadIndex 3
#define XkbLastRequiredType 3
#define XkbNumRequiredTypes (3+1)
#define XkbMaxKeyTypes 255
#define XkbOneLevelMask (1 shl 0)
#define XkbTwoLevelMask (1 shl 1)
#define XkbAlphabeticMask (1 shl 2)
#define XkbKeypadMask (1 shl 3)
#define XkbAllRequiredTypes (&hf)
#define XkbName "XKEYBOARD"
#define XkbMajorVersion 1
#define XkbMinorVersion 0
#define XkbExplicitKeyTypesMask (&h0f)
#define XkbExplicitKeyType1Mask (1 shl 0)
#define XkbExplicitKeyType2Mask (1 shl 1)
#define XkbExplicitKeyType3Mask (1 shl 2)
#define XkbExplicitKeyType4Mask (1 shl 3)
#define XkbExplicitInterpretMask (1 shl 4)
#define XkbExplicitAutoRepeatMask (1 shl 5)
#define XkbExplicitBehaviorMask (1 shl 6)
#define XkbExplicitVModMapMask (1 shl 7)
#define XkbAllExplicitMask (&hff)
#define XkbKeyTypesMask (1 shl 0)
#define XkbKeySymsMask (1 shl 1)
#define XkbModifierMapMask (1 shl 2)
#define XkbExplicitComponentsMask (1 shl 3)
#define XkbKeyActionsMask (1 shl 4)
#define XkbKeyBehaviorsMask (1 shl 5)
#define XkbVirtualModsMask (1 shl 6)
#define XkbVirtualModMapMask (1 shl 7)
#define XkbAllClientInfoMask ((1 shl 0) or (1 shl 1) or (1 shl 2))
#define XkbAllServerInfoMask ((1 shl 3) or (1 shl 4) or (1 shl 5) or (1 shl 6) or (1 shl 7))
#define XkbAllMapComponentsMask (((1 shl 0) or (1 shl 1) or (1 shl 2)) or ((1 shl 3) or (1 shl 4) or (1 shl 5) or (1 shl 6) or (1 shl 7)))
#define XkbSI_AutoRepeat (1 shl 0)
#define XkbSI_LockingKey (1 shl 1)
#define XkbSI_LevelOneOnly (&h80)
#define XkbSI_OpMask (&h7f)
#define XkbSI_NoneOf (0)
#define XkbSI_AnyOfOrNone (1)
#define XkbSI_AnyOf (2)
#define XkbSI_AllOf (3)
#define XkbSI_Exactly (4)
#define XkbIM_NoExplicit (1L shl 7)
#define XkbIM_NoAutomatic (1L shl 6)
#define XkbIM_LEDDrivesKB (1L shl 5)
#define XkbIM_UseBase (1L shl 0)
#define XkbIM_UseLatched (1L shl 1)
#define XkbIM_UseLocked (1L shl 2)
#define XkbIM_UseEffective (1L shl 3)
#define XkbIM_UseCompat (1L shl 4)
#define XkbIM_UseNone 0
#define XkbIM_UseAnyGroup ((1L shl 0) or (1L shl 1) or (1L shl 2) or (1L shl 3))
#define XkbIM_UseAnyMods (((1L shl 0) or (1L shl 1) or (1L shl 2) or (1L shl 3)) or (1L shl 4))
#define XkbSymInterpMask (1 shl 0)
#define XkbGroupCompatMask (1 shl 1)
#define XkbAllCompatMask (&h3)
#define XkbKeycodesNameMask (1 shl 0)
#define XkbGeometryNameMask (1 shl 1)
#define XkbSymbolsNameMask (1 shl 2)
#define XkbPhysSymbolsNameMask (1 shl 3)
#define XkbTypesNameMask (1 shl 4)
#define XkbCompatNameMask (1 shl 5)
#define XkbKeyTypeNamesMask (1 shl 6)
#define XkbKTLevelNamesMask (1 shl 7)
#define XkbIndicatorNamesMask (1 shl 8)
#define XkbKeyNamesMask (1 shl 9)
#define XkbKeyAliasesMask (1 shl 10)
#define XkbVirtualModNamesMask (1 shl 11)
#define XkbGroupNamesMask (1 shl 12)
#define XkbRGNamesMask (1 shl 13)
#define XkbComponentNamesMask (&h3f)
#define XkbAllNamesMask (&h3fff)
#define XkbGBN_TypesMask (1L shl 0)
#define XkbGBN_CompatMapMask (1L shl 1)
#define XkbGBN_ClientSymbolsMask (1L shl 2)
#define XkbGBN_ServerSymbolsMask (1L shl 3)
#define XkbGBN_SymbolsMask ((1L shl 2) or (1L shl 3))
#define XkbGBN_IndicatorMapMask (1L shl 4)
#define XkbGBN_KeyNamesMask (1L shl 5)
#define XkbGBN_GeometryMask (1L shl 6)
#define XkbGBN_OtherNamesMask (1L shl 7)
#define XkbGBN_AllComponentsMask (&hff)
#define XkbLC_Hidden (1L shl 0)
#define XkbLC_Default (1L shl 1)
#define XkbLC_Partial (1L shl 2)
#define XkbLC_AlphanumericKeys (1L shl 8)
#define XkbLC_ModifierKeys (1L shl 9)
#define XkbLC_KeypadKeys (1L shl 10)
#define XkbLC_FunctionKeys (1L shl 11)
#define XkbLC_AlternateGroup (1L shl 12)
#define XkbXI_KeyboardsMask (1L shl 0)
#define XkbXI_ButtonActionsMask (1L shl 1)
#define XkbXI_IndicatorNamesMask (1L shl 2)
#define XkbXI_IndicatorMapsMask (1L shl 3)
#define XkbXI_IndicatorStateMask (1L shl 4)
#define XkbXI_UnsupportedFeatureMask (1L shl 15)
#define XkbXI_AllFeaturesMask (&h001f)
#define XkbXI_AllDeviceFeaturesMask (&h001e)
#define XkbXI_IndicatorsMask (&h001c)
#define XkbAllExtensionDeviceEventsMask (&h801f)
#define XkbPCF_DetectableAutoRepeatMask (1L shl 0)
#define XkbPCF_GrabsUseXKBStateMask (1L shl 1)
#define XkbPCF_AutoResetControlsMask (1L shl 2)
#define XkbPCF_LookupStateWhenGrabbed (1L shl 3)
#define XkbPCF_SendEventUsesXKBState (1L shl 4)
#define XkbPCF_AllFlagsMask (&h1F)
#define XkbDF_DisableLocks (1 shl 0)

#endif
