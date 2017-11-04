'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "powrprof"

extern "Windows"

type _GLOBAL_MACHINE_POWER_POLICY
	Revision as ULONG
	LidOpenWakeAc as SYSTEM_POWER_STATE
	LidOpenWakeDc as SYSTEM_POWER_STATE
	BroadcastCapacityResolution as ULONG
end type

type GLOBAL_MACHINE_POWER_POLICY as _GLOBAL_MACHINE_POWER_POLICY
type PGLOBAL_MACHINE_POWER_POLICY as _GLOBAL_MACHINE_POWER_POLICY ptr

type _GLOBAL_USER_POWER_POLICY
	Revision as ULONG
	PowerButtonAc as POWER_ACTION_POLICY
	PowerButtonDc as POWER_ACTION_POLICY
	SleepButtonAc as POWER_ACTION_POLICY
	SleepButtonDc as POWER_ACTION_POLICY
	LidCloseAc as POWER_ACTION_POLICY
	LidCloseDc as POWER_ACTION_POLICY
	DischargePolicy(0 to 3) as SYSTEM_POWER_LEVEL
	GlobalFlags as ULONG
end type

type GLOBAL_USER_POWER_POLICY as _GLOBAL_USER_POWER_POLICY
type PGLOBAL_USER_POWER_POLICY as _GLOBAL_USER_POWER_POLICY ptr

type _GLOBAL_POWER_POLICY
	user as GLOBAL_USER_POWER_POLICY
	mach as GLOBAL_MACHINE_POWER_POLICY
end type

type GLOBAL_POWER_POLICY as _GLOBAL_POWER_POLICY
type PGLOBAL_POWER_POLICY as _GLOBAL_POWER_POLICY ptr

type _MACHINE_POWER_POLICY
	Revision as ULONG
	MinSleepAc as SYSTEM_POWER_STATE
	MinSleepDc as SYSTEM_POWER_STATE
	ReducedLatencySleepAc as SYSTEM_POWER_STATE
	ReducedLatencySleepDc as SYSTEM_POWER_STATE
	DozeTimeoutAc as ULONG
	DozeTimeoutDc as ULONG
	DozeS4TimeoutAc as ULONG
	DozeS4TimeoutDc as ULONG
	MinThrottleAc as UCHAR
	MinThrottleDc as UCHAR
	pad1(0 to 1) as UCHAR
	OverThrottledAc as POWER_ACTION_POLICY
	OverThrottledDc as POWER_ACTION_POLICY
end type

type MACHINE_POWER_POLICY as _MACHINE_POWER_POLICY
type PMACHINE_POWER_POLICY as _MACHINE_POWER_POLICY ptr

type _MACHINE_PROCESSOR_POWER_POLICY
	Revision as ULONG
	ProcessorPolicyAc as PROCESSOR_POWER_POLICY
	ProcessorPolicyDc as PROCESSOR_POWER_POLICY
end type

type MACHINE_PROCESSOR_POWER_POLICY as _MACHINE_PROCESSOR_POWER_POLICY
type PMACHINE_PROCESSOR_POWER_POLICY as _MACHINE_PROCESSOR_POWER_POLICY ptr

type _USER_POWER_POLICY
	Revision as ULONG
	IdleAc as POWER_ACTION_POLICY
	IdleDc as POWER_ACTION_POLICY
	IdleTimeoutAc as ULONG
	IdleTimeoutDc as ULONG
	IdleSensitivityAc as UCHAR
	IdleSensitivityDc as UCHAR
	ThrottlePolicyAc as UCHAR
	ThrottlePolicyDc as UCHAR
	MaxSleepAc as SYSTEM_POWER_STATE
	MaxSleepDc as SYSTEM_POWER_STATE
	Reserved(0 to 1) as ULONG
	VideoTimeoutAc as ULONG
	VideoTimeoutDc as ULONG
	SpindownTimeoutAc as ULONG
	SpindownTimeoutDc as ULONG
	OptimizeForPowerAc as WINBOOLEAN
	OptimizeForPowerDc as WINBOOLEAN
	FanThrottleToleranceAc as UCHAR
	FanThrottleToleranceDc as UCHAR
	ForcedThrottleAc as UCHAR
	ForcedThrottleDc as UCHAR
end type

type USER_POWER_POLICY as _USER_POWER_POLICY
type PUSER_POWER_POLICY as _USER_POWER_POLICY ptr

type _POWER_POLICY
	user as USER_POWER_POLICY
	mach as MACHINE_POWER_POLICY
end type

type POWER_POLICY as _POWER_POLICY
type PPOWER_POLICY as _POWER_POLICY ptr
const EnableSysTrayBatteryMeter = &h01
const EnableMultiBatteryDisplay = &h02
const EnablePasswordLogon = &h04
const EnableWakeOnRing = &h08
const EnableVideoDimDisplay = &h10
const NEWSCHEME = cast(UINT, -1)
type PWRSCHEMESENUMPROC as function(byval as UINT, byval as DWORD, byval as LPTSTR, byval as DWORD, byval as LPTSTR, byval as PPOWER_POLICY, byval as LPARAM) as WINBOOLEAN
type PFNNTINITIATEPWRACTION as function(byval as POWER_ACTION, byval as SYSTEM_POWER_STATE, byval as ULONG, byval as WINBOOLEAN) as WINBOOLEAN

declare function GetPwrDiskSpindownRange(byval as PUINT, byval as PUINT) as WINBOOLEAN
declare function EnumPwrSchemes(byval as PWRSCHEMESENUMPROC, byval as LPARAM) as WINBOOLEAN
declare function ReadGlobalPwrPolicy(byval as PGLOBAL_POWER_POLICY) as WINBOOLEAN
declare function ReadPwrScheme(byval as UINT, byval as PPOWER_POLICY) as WINBOOLEAN
declare function WritePwrScheme(byval as PUINT, byval as LPTSTR, byval as LPTSTR, byval as PPOWER_POLICY) as WINBOOLEAN
declare function WriteGlobalPwrPolicy(byval as PGLOBAL_POWER_POLICY) as WINBOOLEAN
declare function DeletePwrScheme(byval as UINT) as WINBOOLEAN
declare function GetActivePwrScheme(byval as PUINT) as WINBOOLEAN
declare function SetActivePwrScheme(byval as UINT, byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as WINBOOLEAN
declare function GetPwrCapabilities(byval as PSYSTEM_POWER_CAPABILITIES) as WINBOOLEAN
declare function IsPwrSuspendAllowed() as WINBOOLEAN
declare function IsPwrHibernateAllowed() as WINBOOLEAN
declare function IsPwrShutdownAllowed() as WINBOOLEAN
declare function IsAdminOverrideActive(byval as PADMINISTRATOR_POWER_POLICY) as WINBOOLEAN
declare function SetSuspendState(byval as WINBOOLEAN, byval as WINBOOLEAN, byval as WINBOOLEAN) as WINBOOLEAN
declare function GetCurrentPowerPolicies(byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as WINBOOLEAN
declare function CanUserWritePwrScheme() as WINBOOLEAN
declare function ReadProcessorPwrScheme(byval as UINT, byval as PMACHINE_PROCESSOR_POWER_POLICY) as WINBOOLEAN
declare function WriteProcessorPwrScheme(byval as UINT, byval as PMACHINE_PROCESSOR_POWER_POLICY) as WINBOOLEAN
declare function ValidatePowerPolicies(byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as WINBOOLEAN

#if _WIN32_WINNT >= &h0600
	const DEVICEPOWER_HARDWAREID = &h80000000
	const DEVICEPOWER_FILTER_DEVICES_PRESENT = &h20000000
	const DEVICEPOWER_AND_OPERATION = &h40000000
	const DEVICEPOWER_FILTER_WAKEENABLED = &h08000000
	const DEVICEPOWER_FILTER_ON_NAME = &h02000000
	const PDCAP_D0_SUPPORTED = &h00000001
	const PDCAP_D1_SUPPORTED = &h00000002
	const PDCAP_D2_SUPPORTED = &h00000004
	const PDCAP_D3_SUPPORTED = &h00000008
	const PDCAP_S0_SUPPORTED = &h00010000
	const PDCAP_S1_SUPPORTED = &h00020000
	const PDCAP_S2_SUPPORTED = &h00040000
	const PDCAP_S3_SUPPORTED = &h00080000
	const PDCAP_S4_SUPPORTED = &h01000000
	const PDCAP_S5_SUPPORTED = &h02000000
	const PDCAP_WAKE_FROM_D0_SUPPORTED = &h00000010
	const PDCAP_WAKE_FROM_D1_SUPPORTED = &h00000020
	const PDCAP_WAKE_FROM_D2_SUPPORTED = &h00000040
	const PDCAP_WAKE_FROM_D3_SUPPORTED = &h00000080
	const PDCAP_WAKE_FROM_S0_SUPPORTED = &h00100000
	const PDCAP_WAKE_FROM_S1_SUPPORTED = &h00200000
	const PDCAP_WAKE_FROM_S2_SUPPORTED = &h00400000
	const PDCAP_WAKE_FROM_S3_SUPPORTED = &h00800000
	const PDCAP_WARM_EJECT_SUPPORTED = &h00000100
	const DEVICEPOWER_SET_WAKEENABLED = &h00000001
	const DEVICEPOWER_CLEAR_WAKEENABLED = &h00000002

	type _POWER_DATA_ACCESSOR as long
	enum
		ACCESS_AC_POWER_SETTING_INDEX = 0
		ACCESS_DC_POWER_SETTING_INDEX = 1
		ACCESS_SCHEME = 16
		ACCESS_SUBGROUP = 17
		ACCESS_INDIVIDUAL_SETTING = 18
		ACCESS_ACTIVE_SCHEME = 19
		ACCESS_CREATE_SCHEME = 20
	end enum

	type POWER_DATA_ACCESSOR as _POWER_DATA_ACCESSOR
	type PPOWER_DATA_ACCESSOR as _POWER_DATA_ACCESSOR ptr
	declare function DevicePowerClose() as WINBOOLEAN
	declare function DevicePowerEnumDevices(byval QueryIndex as ULONG, byval QueryInterpretationFlags as ULONG, byval QueryFlags as ULONG, byval pReturnBuffer as PBYTE, byval pBufferSize as PULONG) as WINBOOLEAN
	declare function DevicePowerOpen(byval Flags as ULONG) as WINBOOLEAN
	declare function DevicePowerSetDeviceState(byval DeviceDescription as LPCWSTR, byval SetFlags as ULONG, byval SetData as LPCVOID) as DWORD
	declare function PowerCanRestoreIndividualDefaultPowerScheme(byval SchemeGuid as const GUID ptr) as DWORD
	declare function PowerCreatePossibleSetting(byval RootSystemPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval PossibleSettingIndex as ULONG) as DWORD
	declare function PowerCreateSetting(byval RootSystemPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr) as DWORD
	declare function PowerDeleteScheme(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr) as DWORD
	declare function PowerDeterminePlatformRole() as POWER_PLATFORM_ROLE
	declare function PowerDuplicateScheme(byval RootPowerKey as HKEY, byval SourceSchemeGuid as const GUID ptr, byval DestinationSchemeGuid as GUID ptr ptr) as DWORD
	declare function PowerEnumerate(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval AccessFlags as POWER_DATA_ACCESSOR, byval Index as ULONG, byval Buffer as UCHAR ptr, byval BufferSize as DWORD ptr) as DWORD
	declare function PowerGetActiveScheme(byval UserRootPowerKey as HKEY, byval ActivePolicyGuid as GUID ptr ptr) as DWORD
	declare function PowerImportPowerScheme(byval RootPowerKey as HKEY, byval ImportFileNamePath as LPCWSTR, byval DestinationSchemeGuid as GUID ptr ptr) as DWORD
	declare function PowerReadACDefaultIndex(byval RootPowerKey as HKEY, byval SchemePersonalityGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval AcDefaultIndex as LPDWORD) as DWORD
	declare function PowerReadACValue(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Type as PULONG, byval Buffer as LPBYTE, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadACValueIndex(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval AcValueIndex as LPDWORD) as DWORD
	declare function PowerReadDCDefaultIndex(byval RootPowerKey as HKEY, byval SchemePersonalityGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval DcDefaultIndex as LPDWORD) as DWORD
	declare function PowerReadDCValue(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Type as PULONG, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadDCValueIndex(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval DcValueIndex as LPDWORD) as DWORD
	declare function PowerReadDescription(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadFriendlyName(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadIconResourceSpecifier(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadPossibleDescription(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval PossibleSettingIndex as ULONG, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadPossibleFriendlyName(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval PossibleSettingIndex as ULONG, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadPossibleValue(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Type as PULONG, byval PossibleSettingIndex as ULONG, byval Buffer as PUCHAR, byval BufferSize as LPDWORD) as DWORD
	declare function PowerReadSettingAttributes(byval SubGroupGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr) as DWORD
	declare function PowerReadValueIncrement(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueIncrement as LPDWORD) as DWORD
	declare function PowerReadValueMax(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueMaximum as LPDWORD) as DWORD
	declare function PowerReadValueMin(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueMinimum as LPDWORD) as DWORD
	declare function PowerReadValueUnitsSpecifier(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as UCHAR ptr, byval BufferSize as LPDWORD) as DWORD
	declare function PowerRemovePowerSetting(byval PowerSettingSubKeyGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr) as DWORD
	declare function PowerReplaceDefaultPowerSchemes() as DWORD
	declare function PowerRestoreDefaultPowerSchemes() as DWORD
	declare function PowerRestoreIndividualDefaultPowerScheme(byval SchemeGuid as const GUID ptr) as DWORD
	declare function PowerSetActiveScheme(byval UserRootPowerKey as HKEY, byval SchemeGuid as const GUID ptr) as DWORD
	declare function PowerSettingAccessCheck(byval AccessFlags as POWER_DATA_ACCESSOR, byval PowerGuid as const GUID ptr) as DWORD
	declare function PowerWriteACDefaultIndex(byval RootSystemPowerKey as HKEY, byval SchemePersonalityGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval DefaultAcIndex as DWORD) as DWORD
	declare function PowerWriteACValueIndex(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval AcValueIndex as DWORD) as DWORD
	declare function PowerWriteDCDefaultIndex(byval RootSystemPowerKey as HKEY, byval SchemePersonalityGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval DefaultDcIndex as DWORD) as DWORD
	declare function PowerWriteDCValueIndex(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval DcValueIndex as DWORD) as DWORD
	declare function PowerWriteDescription(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	declare function PowerWriteFriendlyName(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	declare function PowerWriteIconResourceSpecifier(byval RootPowerKey as HKEY, byval SchemeGuid as const GUID ptr, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	declare function PowerWritePossibleDescription(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval PossibleSettingIndex as ULONG, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	declare function PowerWritePossibleFriendlyName(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval PossibleSettingIndex as ULONG, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	declare function PowerWritePossibleValue(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Type as ULONG, byval PossibleSettingIndex as ULONG, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
	const POWER_ATTRIBUTE_HIDE = 1
	declare function PowerWriteSettingAttributes(byval SubGroupGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Attributes as DWORD) as DWORD
	declare function PowerWriteValueIncrement(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueIncrement as DWORD) as DWORD
	declare function PowerWriteValueMax(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueMaximum as DWORD) as DWORD
	declare function PowerWriteValueMin(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval ValueMinimum as DWORD) as DWORD
	declare function PowerWriteValueUnitsSpecifier(byval RootPowerKey as HKEY, byval SubGroupOfPowerSettingsGuid as const GUID ptr, byval PowerSettingGuid as const GUID ptr, byval Buffer as UCHAR ptr, byval BufferSize as DWORD) as DWORD
#endif

declare function CallNtPowerInformation(byval as POWER_INFORMATION_LEVEL, byval as PVOID, byval as ULONG, byval as PVOID, byval as ULONG) as LONG

end extern
