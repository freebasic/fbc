''
''
'' powrprof -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_powrprof_bi__
#define __win_powrprof_bi__

#inclib "powrprof"

#define EnableMultiBatteryDisplay 2
#define EnablePasswordLogon 4
#define EnableSysTrayBatteryMeter 1
#define EnableWakeOnRing 8
#define EnableVideoDimDisplay 16
#define NEWSCHEME cUINT(-1)

#include once "win/ntdef.bi"

type GLOBAL_MACHINE_POWER_POLICY
	Revision as ULONG
	LidOpenWakeAc as SYSTEM_POWER_STATE
	LidOpenWakeDc as SYSTEM_POWER_STATE
	BroadcastCapacityResolution as ULONG
end type

type PGLOBAL_MACHINE_POWER_POLICY as GLOBAL_MACHINE_POWER_POLICY ptr

type GLOBAL_USER_POWER_POLICY
	Revision as ULONG
	PowerButtonAc as POWER_ACTION_POLICY
	PowerButtonDc as POWER_ACTION_POLICY
	SleepButtonAc as POWER_ACTION_POLICY
	SleepButtonDc as POWER_ACTION_POLICY
	LidCloseAc as POWER_ACTION_POLICY
	LidCloseDc as POWER_ACTION_POLICY
	DischargePolicy(0 to 4-1) as SYSTEM_POWER_LEVEL
	GlobalFlags as ULONG
end type

type PGLOBAL_USER_POWER_POLICY as GLOBAL_USER_POWER_POLICY ptr

type GLOBAL_POWER_POLICY
	user as GLOBAL_USER_POWER_POLICY
	mach as GLOBAL_MACHINE_POWER_POLICY
end type

type PGLOBAL_POWER_POLICY as GLOBAL_POWER_POLICY ptr

type MACHINE_POWER_POLICY
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
	pad1(0 to 2-1) as UCHAR
	OverThrottledAc as POWER_ACTION_POLICY
	OverThrottledDc as POWER_ACTION_POLICY
end type

type PMACHINE_POWER_POLICY as MACHINE_POWER_POLICY ptr

type MACHINE_PROCESSOR_POWER_POLICY
	Revision as ULONG
	ProcessorPolicyAc as PROCESSOR_POWER_POLICY
	ProcessorPolicyDc as PROCESSOR_POWER_POLICY
end type

type PMACHINE_PROCESSOR_POWER_POLICY as MACHINE_PROCESSOR_POWER_POLICY ptr

type USER_POWER_POLICY
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
	Reserved(0 to 2-1) as ULONG
	VideoTimeoutAc as ULONG
	VideoTimeoutDc as ULONG
	SpindownTimeoutAc as ULONG
	SpindownTimeoutDc as ULONG
	OptimizeForPowerAc as BOOLEAN
	OptimizeForPowerDc as BOOLEAN
	FanThrottleToleranceAc as UCHAR
	FanThrottleToleranceDc as UCHAR
	ForcedThrottleAc as UCHAR
	ForcedThrottleDc as UCHAR
end type

type PUSER_POWER_POLICY as USER_POWER_POLICY ptr

type POWER_POLICY
	user as USER_POWER_POLICY
	mach as MACHINE_POWER_POLICY
end type

type PPOWER_POLICY as POWER_POLICY ptr

type PWRSCHEMESENUMPROC as function (byval as UINT, byval as DWORD, byval as LPTSTR, byval as DWORD, byval as LPTSTR, byval as PPOWER_POLICY, byval as LPARAM) as BOOLEAN
type PFNNTINITIATEPWRACTION as function (byval as POWER_ACTION, byval as SYSTEM_POWER_STATE, byval as ULONG, byval as BOOLEAN) as BOOLEAN

declare function CallNtPowerInformation alias "CallNtPowerInformation" (byval as POWER_INFORMATION_LEVEL, byval as PVOID, byval as ULONG, byval as PVOID, byval as ULONG) as NTSTATUS
declare function CanUserWritePwrScheme alias "CanUserWritePwrScheme" () as BOOLEAN
declare function DeletePwrScheme alias "DeletePwrScheme" (byval as UINT) as BOOLEAN
declare function EnumPwrSchemes alias "EnumPwrSchemes" (byval as PWRSCHEMESENUMPROC, byval as LPARAM) as BOOLEAN
declare function GetActivePwrScheme alias "GetActivePwrScheme" (byval as PUINT) as BOOLEAN
declare function GetCurrentPowerPolicies alias "GetCurrentPowerPolicies" (byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as BOOLEAN
declare function GetPwrCapabilities alias "GetPwrCapabilities" (byval as PSYSTEM_POWER_CAPABILITIES) as BOOLEAN
declare function GetPwrDiskSpindownRange alias "GetPwrDiskSpindownRange" (byval as PUINT, byval as PUINT) as BOOLEAN
declare function IsAdminOverrideActive alias "IsAdminOverrideActive" (byval as PADMINISTRATOR_POWER_POLICY) as BOOLEAN
declare function IsPwrHibernateAllowed alias "IsPwrHibernateAllowed" () as BOOLEAN
declare function IsPwrShutdownAllowed alias "IsPwrShutdownAllowed" () as BOOLEAN
declare function IsPwrSuspendAllowed alias "IsPwrSuspendAllowed" () as BOOLEAN
declare function ReadGlobalPwrPolicy alias "ReadGlobalPwrPolicy" (byval as PGLOBAL_POWER_POLICY) as BOOLEAN
declare function ReadProcessorPwrScheme alias "ReadProcessorPwrScheme" (byval as UINT, byval as PMACHINE_PROCESSOR_POWER_POLICY) as BOOLEAN
declare function ReadPwrScheme alias "ReadPwrScheme" (byval as UINT, byval as PPOWER_POLICY) as BOOLEAN
declare function SetActivePwrScheme alias "SetActivePwrScheme" (byval as UINT, byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as BOOLEAN
declare function SetSuspendState alias "SetSuspendState" (byval as BOOLEAN, byval as BOOLEAN, byval as BOOLEAN) as BOOLEAN
declare function WriteGlobalPwrPolicy alias "WriteGlobalPwrPolicy" (byval as PGLOBAL_POWER_POLICY) as BOOLEAN
declare function WriteProcessorPwrScheme alias "WriteProcessorPwrScheme" (byval as UINT, byval as PMACHINE_PROCESSOR_POWER_POLICY) as BOOLEAN
declare function ValidatePowerPolicies alias "ValidatePowerPolicies" (byval as PGLOBAL_POWER_POLICY, byval as PPOWER_POLICY) as BOOLEAN
declare function WritePwrScheme alias "WritePwrScheme" (byval as PUINT, byval as LPTSTR, byval as LPTSTR, byval as PPOWER_POLICY) as BOOLEAN

#endif
