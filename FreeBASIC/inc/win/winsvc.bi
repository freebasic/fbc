''
''
'' winsvc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winsvc_bi__
#define __win_winsvc_bi__

#inclib "advapi32"

#define SERVICES_ACTIVE_DATABASE "ServicesActive"
#define SERVICES_FAILED_DATABASE "ServicesFailed"
#define SC_GROUP_IDENTIFIERA asc("+")
#define SC_GROUP_IDENTIFIERW asc(wstr("+"))
#define SC_MANAGER_ALL_ACCESS &hf003f
#define SC_MANAGER_CONNECT 1
#define SC_MANAGER_CREATE_SERVICE 2
#define SC_MANAGER_ENUMERATE_SERVICE 4
#define SC_MANAGER_LOCK 8
#define SC_MANAGER_QUERY_LOCK_STATUS 16
#define SC_MANAGER_MODIFY_BOOT_CONFIG 32
#define SERVICE_NO_CHANGE &hffffffff
#define SERVICE_STOPPED 1
#define SERVICE_START_PENDING 2
#define SERVICE_STOP_PENDING 3
#define SERVICE_RUNNING 4
#define SERVICE_CONTINUE_PENDING 5
#define SERVICE_PAUSE_PENDING 6
#define SERVICE_PAUSED 7
#define SERVICE_ACCEPT_STOP 1
#define SERVICE_ACCEPT_PAUSE_CONTINUE 2
#define SERVICE_ACCEPT_SHUTDOWN 4
#define SERVICE_ACCEPT_PARAMCHANGE 8
#define SERVICE_ACCEPT_NETBINDCHANGE 16
#define SERVICE_ACCEPT_HARDWAREPROFILECHANGE 32
#define SERVICE_ACCEPT_POWEREVENT 64
#define SERVICE_ACCEPT_SESSIONCHANGE 128
#define SERVICE_CONTROL_STOP 1
#define SERVICE_CONTROL_PAUSE 2
#define SERVICE_CONTROL_CONTINUE 3
#define SERVICE_CONTROL_INTERROGATE 4
#define SERVICE_CONTROL_SHUTDOWN 5
#define SERVICE_CONTROL_PARAMCHANGE 6
#define SERVICE_CONTROL_NETBINDADD 7
#define SERVICE_CONTROL_NETBINDREMOVE 8
#define SERVICE_CONTROL_NETBINDENABLE 9
#define SERVICE_CONTROL_NETBINDDISABLE 10
#define SERVICE_CONTROL_DEVICEEVENT 11
#define SERVICE_CONTROL_HARDWAREPROFILECHANGE 12
#define SERVICE_CONTROL_POWEREVENT 13
#define SERVICE_CONTROL_SESSIONCHANGE 14
#define SERVICE_ACTIVE 1
#define SERVICE_INACTIVE 2
#define SERVICE_STATE_ALL 3
#define SERVICE_QUERY_CONFIG 1
#define SERVICE_CHANGE_CONFIG 2
#define SERVICE_QUERY_STATUS 4
#define SERVICE_ENUMERATE_DEPENDENTS 8
#define SERVICE_START 16
#define SERVICE_STOP 32
#define SERVICE_PAUSE_CONTINUE 64
#define SERVICE_INTERROGATE 128
#define SERVICE_USER_DEFINED_CONTROL 256
#define SERVICE_ALL_ACCESS (&hF0000 or 1 or 2 or 4 or 8 or 16 or 32 or 64 or 128 or 256)
#define SERVICE_RUNS_IN_SYSTEM_PROCESS 1
#define SERVICE_CONFIG_DESCRIPTION 1
#define SERVICE_CONFIG_FAILURE_ACTIONS 2

type SERVICE_STATUS
	dwServiceType as DWORD
	dwCurrentState as DWORD
	dwControlsAccepted as DWORD
	dwWin32ExitCode as DWORD
	dwServiceSpecificExitCode as DWORD
	dwCheckPoint as DWORD
	dwWaitHint as DWORD
end type

type LPSERVICE_STATUS as SERVICE_STATUS ptr

type SERVICE_STATUS_PROCESS
	dwServiceType as DWORD
	dwCurrentState as DWORD
	dwControlsAccepted as DWORD
	dwWin32ExitCode as DWORD
	dwServiceSpecificExitCode as DWORD
	dwCheckPoint as DWORD
	dwWaitHint as DWORD
	dwProcessId as DWORD
	dwServiceFlags as DWORD
end type

type LPSERVICE_STATUS_PROCESS as SERVICE_STATUS_PROCESS ptr

enum SC_STATUS_TYPE
	SC_STATUS_PROCESS_INFO = 0
end enum

enum SC_ENUM_TYPE
	SC_ENUM_PROCESS_INFO = 0
end enum

#ifndef UNICODE
type ENUM_SERVICE_STATUSA
	lpServiceName as LPSTR
	lpDisplayName as LPSTR
	ServiceStatus as SERVICE_STATUS
end type

type LPENUM_SERVICE_STATUSA as ENUM_SERVICE_STATUSA ptr

#else ''UNICODE
type ENUM_SERVICE_STATUSW
	lpServiceName as LPWSTR
	lpDisplayName as LPWSTR
	ServiceStatus as SERVICE_STATUS
end type

type LPENUM_SERVICE_STATUSW as ENUM_SERVICE_STATUSW ptr
#endif ''UNICODE

#ifndef UNICODE
type ENUM_SERVICE_STATUS_PROCESSA
	lpServiceName as LPSTR
	lpDisplayName as LPSTR
	ServiceStatusProcess as SERVICE_STATUS_PROCESS
end type

type LPENUM_SERVICE_STATUS_PROCESSA as ENUM_SERVICE_STATUS_PROCESSA ptr

#else ''UNICODE
type ENUM_SERVICE_STATUS_PROCESSW
	lpServiceName as LPWSTR
	lpDisplayName as LPWSTR
	ServiceStatusProcess as SERVICE_STATUS_PROCESS
end type

type LPENUM_SERVICE_STATUS_PROCESSW as ENUM_SERVICE_STATUS_PROCESSW ptr
#endif ''UNICODE

#ifndef UNICODE
type QUERY_SERVICE_CONFIGA
	dwServiceType as DWORD
	dwStartType as DWORD
	dwErrorControl as DWORD
	lpBinaryPathName as LPSTR
	lpLoadOrderGroup as LPSTR
	dwTagId as DWORD
	lpDependencies as LPSTR
	lpServiceStartName as LPSTR
	lpDisplayName as LPSTR
end type

type LPQUERY_SERVICE_CONFIGA as QUERY_SERVICE_CONFIGA ptr

#else ''UNICODE
type QUERY_SERVICE_CONFIGW
	dwServiceType as DWORD
	dwStartType as DWORD
	dwErrorControl as DWORD
	lpBinaryPathName as LPWSTR
	lpLoadOrderGroup as LPWSTR
	dwTagId as DWORD
	lpDependencies as LPWSTR
	lpServiceStartName as LPWSTR
	lpDisplayName as LPWSTR
end type

type LPQUERY_SERVICE_CONFIGW as QUERY_SERVICE_CONFIGW ptr
#endif ''UNICODE

#ifndef UNICODE
type QUERY_SERVICE_LOCK_STATUSA
	fIsLocked as DWORD
	lpLockOwner as LPSTR
	dwLockDuration as DWORD
end type

type LPQUERY_SERVICE_LOCK_STATUSA as QUERY_SERVICE_LOCK_STATUSA ptr
type LPSERVICE_MAIN_FUNCTIONA as sub (byval as DWORD, byval as LPSTR ptr)

#else ''UNICODE
type QUERY_SERVICE_LOCK_STATUSW
	fIsLocked as DWORD
	lpLockOwner as LPWSTR
	dwLockDuration as DWORD
end type

type LPQUERY_SERVICE_LOCK_STATUSW as QUERY_SERVICE_LOCK_STATUSW ptr
type LPSERVICE_MAIN_FUNCTIONW as sub (byval as DWORD, byval as LPWSTR ptr)
#endif ''UNICODE

#ifndef UNICODE
type SERVICE_TABLE_ENTRYA
	lpServiceName as LPSTR
	lpServiceProc as LPSERVICE_MAIN_FUNCTIONA
end type

type LPSERVICE_TABLE_ENTRYA as SERVICE_TABLE_ENTRYA ptr

#else ''UNICODE
type SERVICE_TABLE_ENTRYW
	lpServiceName as LPWSTR
	lpServiceProc as LPSERVICE_MAIN_FUNCTIONW
end type

type LPSERVICE_TABLE_ENTRYW as SERVICE_TABLE_ENTRYW ptr
#endif ''UNICODE

type SC_HANDLE__
	i as integer
end type

type SC_HANDLE as SC_HANDLE__ ptr
type LPSC_HANDLE as SC_HANDLE ptr
type SC_LOCK as PVOID
type SERVICE_STATUS_HANDLE as DWORD
type LPHANDLER_FUNCTION as sub (byval as DWORD)
type LPHANDLER_FUNCTION_EX as function (byval as DWORD, byval as DWORD, byval as LPVOID, byval as LPVOID) as DWORD

#ifndef UNICODE
type SERVICE_DESCRIPTIONA
	lpDescription as LPSTR
end type

type LPSERVICE_DESCRIPTIONA as SERVICE_DESCRIPTIONA ptr

#else ''UNICODE
type SERVICE_DESCRIPTIONW
	lpDescription as LPWSTR
end type

type LPSERVICE_DESCRIPTIONW as SERVICE_DESCRIPTIONW ptr
#endif ''UNICODE

enum SC_ACTION_TYPE
	SC_ACTION_NONE = 0
	SC_ACTION_RESTART = 1
	SC_ACTION_REBOOT = 2
	SC_ACTION_RUN_COMMAND = 3
end enum

type SC_ACTION
	Type as SC_ACTION_TYPE
	Delay as DWORD
end type

type LPSC_ACTION as SC_ACTION ptr

#ifndef UNICODE
type SERVICE_FAILURE_ACTIONSA
	dwResetPeriod as DWORD
	lpRebootMsg as LPSTR
	lpCommand as LPSTR
	cActions as DWORD
	lpsaActions as SC_ACTION ptr
end type

type LPSERVICE_FAILURE_ACTIONSA as SERVICE_FAILURE_ACTIONSA ptr

#else ''UNICODE
type SERVICE_FAILURE_ACTIONSW
	dwResetPeriod as DWORD
	lpRebootMsg as LPWSTR
	lpCommand as LPWSTR
	cActions as DWORD
	lpsaActions as SC_ACTION ptr
end type

type LPSERVICE_FAILURE_ACTIONSW as SERVICE_FAILURE_ACTIONSW ptr
#endif ''UNICODE

declare function CloseServiceHandle alias "CloseServiceHandle" (byval as SC_HANDLE) as BOOL
declare function ControlService alias "ControlService" (byval as SC_HANDLE, byval as DWORD, byval as LPSERVICE_STATUS) as BOOL
declare function DeleteService alias "DeleteService" (byval as SC_HANDLE) as BOOL
declare function LockServiceDatabase alias "LockServiceDatabase" (byval as SC_HANDLE) as SC_LOCK
declare function NotifyBootConfigStatus alias "NotifyBootConfigStatus" (byval as BOOL) as BOOL
declare function QueryServiceObjectSecurity alias "QueryServiceObjectSecurity" (byval as SC_HANDLE, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as LPDWORD) as BOOL
declare function QueryServiceStatus alias "QueryServiceStatus" (byval as SC_HANDLE, byval as LPSERVICE_STATUS) as BOOL
declare function QueryServiceStatusEx alias "QueryServiceStatusEx" (byval as SC_HANDLE, byval as SC_STATUS_TYPE, byval as LPBYTE, byval as DWORD, byval as LPDWORD) as BOOL
declare function SetServiceObjectSecurity alias "SetServiceObjectSecurity" (byval as SC_HANDLE, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as BOOL
declare function SetServiceStatus alias "SetServiceStatus" (byval as SERVICE_STATUS_HANDLE, byval as LPSERVICE_STATUS) as BOOL
declare function UnlockServiceDatabase alias "UnlockServiceDatabase" (byval as SC_LOCK) as BOOL

#ifdef UNICODE
type ENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSW
type LPENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSW ptr
type ENUM_SERVICE_STATUS_PROCESS as ENUM_SERVICE_STATUS_PROCESSW
type LPENUM_SERVICE_STATUS_PROCESS as LPENUM_SERVICE_STATUS_PROCESSW
type QUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGW
type LPQUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGW ptr
type QUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSW
type LPQUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSW ptr
type SERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYW
type LPSERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYW ptr
type LPSERVICE_MAIN_FUNCTION as LPSERVICE_MAIN_FUNCTIONW
type SERVICE_DESCRIPTION as SERVICE_DESCRIPTIONW
type LPSERVICE_DESCRIPTION as LPSERVICE_DESCRIPTIONW
type SERVICE_FAILURE_ACTIONS as SERVICE_FAILURE_ACTIONSW
type LPSERVICE_FAILURE_ACTIONS as LPSERVICE_FAILURE_ACTIONSW

#define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERW

declare function ChangeServiceConfig alias "ChangeServiceConfigW" (byval as SC_HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCWSTR, byval as LPCWSTR, byval as LPDWORD, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function ChangeServiceConfig2 alias "ChangeServiceConfig2W" (byval as SC_HANDLE, byval as DWORD, byval as LPVOID) as BOOL
declare function CreateService alias "CreateServiceW" (byval as SC_HANDLE, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCWSTR, byval as LPCWSTR, byval as PDWORD, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as SC_HANDLE
declare function EnumDependentServices alias "EnumDependentServicesW" (byval as SC_HANDLE, byval as DWORD, byval as LPENUM_SERVICE_STATUSW, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumServicesStatus alias "EnumServicesStatusW" (byval as SC_HANDLE, byval as DWORD, byval as DWORD, byval as LPENUM_SERVICE_STATUSW, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumServicesStatusEx alias "EnumServicesStatusExW" (byval as SC_HANDLE, byval as SC_ENUM_TYPE, byval as DWORD, byval as DWORD, byval as LPBYTE, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPCWSTR) as BOOL
declare function GetServiceDisplayName alias "GetServiceDisplayNameW" (byval as SC_HANDLE, byval as LPCWSTR, byval as LPWSTR, byval as PDWORD) as BOOL
declare function GetServiceKeyName alias "GetServiceKeyNameW" (byval as SC_HANDLE, byval as LPCWSTR, byval as LPWSTR, byval as PDWORD) as BOOL
declare function OpenSCManager alias "OpenSCManagerW" (byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as SC_HANDLE
declare function OpenService alias "OpenServiceW" (byval as SC_HANDLE, byval as LPCWSTR, byval as DWORD) as SC_HANDLE
declare function QueryServiceConfig alias "QueryServiceConfigW" (byval as SC_HANDLE, byval as LPQUERY_SERVICE_CONFIGW, byval as DWORD, byval as PDWORD) as BOOL
declare function QueryServiceConfig2 alias "QueryServiceConfig2W" (byval as SC_HANDLE, byval as DWORD, byval as LPBYTE, byval as DWORD, byval as LPDWORD) as BOOL
declare function QueryServiceLockStatus alias "QueryServiceLockStatusW" (byval as SC_HANDLE, byval as LPQUERY_SERVICE_LOCK_STATUSW, byval as DWORD, byval as PDWORD) as BOOL
declare function RegisterServiceCtrlHandler alias "RegisterServiceCtrlHandlerW" (byval as LPCWSTR, byval as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE
declare function RegisterServiceCtrlHandlerEx alias "RegisterServiceCtrlHandlerExW" (byval as LPCWSTR, byval as LPHANDLER_FUNCTION_EX, byval as LPVOID) as SERVICE_STATUS_HANDLE
declare function StartServiceCtrlDispatcher alias "StartServiceCtrlDispatcherW" (byval as LPSERVICE_TABLE_ENTRYW) as BOOL
declare function StartService alias "StartServiceW" (byval as SC_HANDLE, byval as DWORD, byval as LPCWSTR ptr) as BOOL

#else ''UNICODE
type ENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSA
type LPENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSA ptr
type ENUM_SERVICE_STATUS_PROCESS as ENUM_SERVICE_STATUS_PROCESSA
type LPENUM_SERVICE_STATUS_PROCESS as LPENUM_SERVICE_STATUS_PROCESSA
type QUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGA
type LPQUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGA ptr
type QUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSA
type LPQUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSA ptr
type SERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYA
type LPSERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYA ptr
type LPSERVICE_MAIN_FUNCTION as LPSERVICE_MAIN_FUNCTIONA
type SERVICE_DESCRIPTION as SERVICE_DESCRIPTIONA
type LPSERVICE_DESCRIPTION as LPSERVICE_DESCRIPTIONA
type SERVICE_FAILURE_ACTIONS as SERVICE_FAILURE_ACTIONSA
type LPSERVICE_FAILURE_ACTIONS as LPSERVICE_FAILURE_ACTIONSA

#define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERA

declare function ChangeServiceConfig alias "ChangeServiceConfigA" (byval as SC_HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCSTR, byval as LPCSTR, byval as LPDWORD, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function ChangeServiceConfig2 alias "ChangeServiceConfig2A" (byval as SC_HANDLE, byval as DWORD, byval as LPVOID) as BOOL
declare function CreateService alias "CreateServiceA" (byval as SC_HANDLE, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCSTR, byval as LPCSTR, byval as PDWORD, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as SC_HANDLE
declare function EnumDependentServices alias "EnumDependentServicesA" (byval as SC_HANDLE, byval as DWORD, byval as LPENUM_SERVICE_STATUSA, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumServicesStatus alias "EnumServicesStatusA" (byval as SC_HANDLE, byval as DWORD, byval as DWORD, byval as LPENUM_SERVICE_STATUSA, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumServicesStatusEx alias "EnumServicesStatusExA" (byval as SC_HANDLE, byval as SC_ENUM_TYPE, byval as DWORD, byval as DWORD, byval as LPBYTE, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPCSTR) as BOOL
declare function GetServiceDisplayName alias "GetServiceDisplayNameA" (byval as SC_HANDLE, byval as LPCSTR, byval as LPSTR, byval as PDWORD) as BOOL
declare function GetServiceKeyName alias "GetServiceKeyNameA" (byval as SC_HANDLE, byval as LPCSTR, byval as LPSTR, byval as PDWORD) as BOOL
declare function OpenSCManager alias "OpenSCManagerA" (byval as LPCSTR, byval as LPCSTR, byval as DWORD) as SC_HANDLE
declare function OpenService alias "OpenServiceA" (byval as SC_HANDLE, byval as LPCSTR, byval as DWORD) as SC_HANDLE
declare function QueryServiceConfig alias "QueryServiceConfigA" (byval as SC_HANDLE, byval as LPQUERY_SERVICE_CONFIGA, byval as DWORD, byval as PDWORD) as BOOL
declare function QueryServiceConfig2 alias "QueryServiceConfig2A" (byval as SC_HANDLE, byval as DWORD, byval as LPBYTE, byval as DWORD, byval as LPDWORD) as BOOL
declare function QueryServiceLockStatus alias "QueryServiceLockStatusA" (byval as SC_HANDLE, byval as LPQUERY_SERVICE_LOCK_STATUSA, byval as DWORD, byval as PDWORD) as BOOL
declare function RegisterServiceCtrlHandler alias "RegisterServiceCtrlHandlerA" (byval as LPCSTR, byval as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE
declare function RegisterServiceCtrlHandlerEx alias "RegisterServiceCtrlHandlerExA" (byval as LPCSTR, byval as LPHANDLER_FUNCTION_EX, byval as LPVOID) as SERVICE_STATUS_HANDLE
declare function StartService alias "StartServiceA" (byval as SC_HANDLE, byval as DWORD, byval as LPCSTR ptr) as BOOL
declare function StartServiceCtrlDispatcher alias "StartServiceCtrlDispatcherA" (byval as LPSERVICE_TABLE_ENTRYA) as BOOL

#endif ''UNICODE

#endif
