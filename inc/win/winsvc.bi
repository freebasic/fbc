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

#inclib "advapi32"

#include once "_mingw.bi"
#include once "_mingw_unicode.bi"

extern "Windows"

#define _WINSVC_
#define SERVICES_ACTIVE_DATABASEW wstr("ServicesActive")
#define SERVICES_FAILED_DATABASEW wstr("ServicesFailed")
#define SERVICES_ACTIVE_DATABASEA "ServicesActive"
#define SERVICES_FAILED_DATABASEA "ServicesFailed"
#define SC_GROUP_IDENTIFIERW asc(wstr("+"))
#define SC_GROUP_IDENTIFIERA asc("+")

#ifdef UNICODE
	#define SERVICES_ACTIVE_DATABASE SERVICES_ACTIVE_DATABASEW
	#define SERVICES_FAILED_DATABASE SERVICES_FAILED_DATABASEW
	#define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERW
#else
	#define SERVICES_ACTIVE_DATABASE SERVICES_ACTIVE_DATABASEA
	#define SERVICES_FAILED_DATABASE SERVICES_FAILED_DATABASEA
	#define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERA
#endif

const SERVICE_NO_CHANGE = &hffffffff
const SERVICE_ACTIVE = &h00000001
const SERVICE_INACTIVE = &h00000002
const SERVICE_STATE_ALL = SERVICE_ACTIVE or SERVICE_INACTIVE
const SERVICE_CONTROL_STOP = &h00000001
const SERVICE_CONTROL_PAUSE = &h00000002
const SERVICE_CONTROL_CONTINUE = &h00000003
const SERVICE_CONTROL_INTERROGATE = &h00000004
const SERVICE_CONTROL_SHUTDOWN = &h00000005
const SERVICE_CONTROL_PARAMCHANGE = &h00000006
const SERVICE_CONTROL_NETBINDADD = &h00000007
const SERVICE_CONTROL_NETBINDREMOVE = &h00000008
const SERVICE_CONTROL_NETBINDENABLE = &h00000009
const SERVICE_CONTROL_NETBINDDISABLE = &h0000000A
const SERVICE_CONTROL_DEVICEEVENT = &h0000000B
const SERVICE_CONTROL_HARDWAREPROFILECHANGE = &h0000000C
const SERVICE_CONTROL_POWEREVENT = &h0000000D
const SERVICE_CONTROL_SESSIONCHANGE = &h0000000E
const SERVICE_STOPPED = &h00000001
const SERVICE_START_PENDING = &h00000002
const SERVICE_STOP_PENDING = &h00000003
const SERVICE_RUNNING = &h00000004
const SERVICE_CONTINUE_PENDING = &h00000005
const SERVICE_PAUSE_PENDING = &h00000006
const SERVICE_PAUSED = &h00000007
const SERVICE_ACCEPT_STOP = &h00000001
const SERVICE_ACCEPT_PAUSE_CONTINUE = &h00000002
const SERVICE_ACCEPT_SHUTDOWN = &h00000004
const SERVICE_ACCEPT_PARAMCHANGE = &h00000008
const SERVICE_ACCEPT_NETBINDCHANGE = &h00000010
const SERVICE_ACCEPT_HARDWAREPROFILECHANGE = &h00000020
const SERVICE_ACCEPT_POWEREVENT = &h00000040
const SERVICE_ACCEPT_SESSIONCHANGE = &h00000080
const SC_MANAGER_CONNECT = &h0001
const SC_MANAGER_CREATE_SERVICE = &h0002
const SC_MANAGER_ENUMERATE_SERVICE = &h0004
const SC_MANAGER_LOCK = &h0008
const SC_MANAGER_QUERY_LOCK_STATUS = &h0010
const SC_MANAGER_MODIFY_BOOT_CONFIG = &h0020
const SC_MANAGER_ALL_ACCESS = (((((STANDARD_RIGHTS_REQUIRED or SC_MANAGER_CONNECT) or SC_MANAGER_CREATE_SERVICE) or SC_MANAGER_ENUMERATE_SERVICE) or SC_MANAGER_LOCK) or SC_MANAGER_QUERY_LOCK_STATUS) or SC_MANAGER_MODIFY_BOOT_CONFIG
const SERVICE_QUERY_CONFIG = &h0001
const SERVICE_CHANGE_CONFIG = &h0002
const SERVICE_QUERY_STATUS = &h0004
const SERVICE_ENUMERATE_DEPENDENTS = &h0008
const SERVICE_START = &h0010
const SERVICE_STOP = &h0020
const SERVICE_PAUSE_CONTINUE = &h0040
const SERVICE_INTERROGATE = &h0080
const SERVICE_USER_DEFINED_CONTROL = &h0100
const SERVICE_ALL_ACCESS = ((((((((STANDARD_RIGHTS_REQUIRED or SERVICE_QUERY_CONFIG) or SERVICE_CHANGE_CONFIG) or SERVICE_QUERY_STATUS) or SERVICE_ENUMERATE_DEPENDENTS) or SERVICE_START) or SERVICE_STOP) or SERVICE_PAUSE_CONTINUE) or SERVICE_INTERROGATE) or SERVICE_USER_DEFINED_CONTROL
const SERVICE_RUNS_IN_SYSTEM_PROCESS = &h00000001
const SERVICE_CONFIG_DESCRIPTION = 1
const SERVICE_CONFIG_FAILURE_ACTIONS = 2

type _SERVICE_DESCRIPTIONA
	lpDescription as LPSTR
end type

type SERVICE_DESCRIPTIONA as _SERVICE_DESCRIPTIONA
type LPSERVICE_DESCRIPTIONA as _SERVICE_DESCRIPTIONA ptr

type _SERVICE_DESCRIPTIONW
	lpDescription as LPWSTR
end type

type SERVICE_DESCRIPTIONW as _SERVICE_DESCRIPTIONW
type LPSERVICE_DESCRIPTIONW as _SERVICE_DESCRIPTIONW ptr

#ifdef UNICODE
	type SERVICE_DESCRIPTION as SERVICE_DESCRIPTIONW
	type LPSERVICE_DESCRIPTION as LPSERVICE_DESCRIPTIONW
#else
	type SERVICE_DESCRIPTION as SERVICE_DESCRIPTIONA
	type LPSERVICE_DESCRIPTION as LPSERVICE_DESCRIPTIONA
#endif

type _SC_ACTION_TYPE as long
enum
	SC_ACTION_NONE = 0
	SC_ACTION_RESTART = 1
	SC_ACTION_REBOOT = 2
	SC_ACTION_RUN_COMMAND = 3
end enum

type SC_ACTION_TYPE as _SC_ACTION_TYPE

type _SC_ACTION
	as SC_ACTION_TYPE Type
	Delay as DWORD
end type

type SC_ACTION as _SC_ACTION
type LPSC_ACTION as _SC_ACTION ptr

type _SERVICE_FAILURE_ACTIONSA
	dwResetPeriod as DWORD
	lpRebootMsg as LPSTR
	lpCommand as LPSTR
	cActions as DWORD
	lpsaActions as SC_ACTION ptr
end type

type SERVICE_FAILURE_ACTIONSA as _SERVICE_FAILURE_ACTIONSA
type LPSERVICE_FAILURE_ACTIONSA as _SERVICE_FAILURE_ACTIONSA ptr

type _SERVICE_FAILURE_ACTIONSW
	dwResetPeriod as DWORD
	lpRebootMsg as LPWSTR
	lpCommand as LPWSTR
	cActions as DWORD
	lpsaActions as SC_ACTION ptr
end type

type SERVICE_FAILURE_ACTIONSW as _SERVICE_FAILURE_ACTIONSW
type LPSERVICE_FAILURE_ACTIONSW as _SERVICE_FAILURE_ACTIONSW ptr

#ifdef UNICODE
	type SERVICE_FAILURE_ACTIONS as SERVICE_FAILURE_ACTIONSW
	type LPSERVICE_FAILURE_ACTIONS as LPSERVICE_FAILURE_ACTIONSW
#else
	type SERVICE_FAILURE_ACTIONS as SERVICE_FAILURE_ACTIONSA
	type LPSERVICE_FAILURE_ACTIONS as LPSERVICE_FAILURE_ACTIONSA
#endif

type SC_HANDLE__
	unused as long
end type

type SC_HANDLE as SC_HANDLE__ ptr
type LPSC_HANDLE as SC_HANDLE ptr

type SERVICE_STATUS_HANDLE__
	unused as long
end type

type SERVICE_STATUS_HANDLE as SERVICE_STATUS_HANDLE__ ptr

type _SC_STATUS_TYPE as long
enum
	SC_STATUS_PROCESS_INFO = 0
end enum

type SC_STATUS_TYPE as _SC_STATUS_TYPE

type _SC_ENUM_TYPE as long
enum
	SC_ENUM_PROCESS_INFO = 0
end enum

type SC_ENUM_TYPE as _SC_ENUM_TYPE

type _SERVICE_STATUS
	dwServiceType as DWORD
	dwCurrentState as DWORD
	dwControlsAccepted as DWORD
	dwWin32ExitCode as DWORD
	dwServiceSpecificExitCode as DWORD
	dwCheckPoint as DWORD
	dwWaitHint as DWORD
end type

type SERVICE_STATUS as _SERVICE_STATUS
type LPSERVICE_STATUS as _SERVICE_STATUS ptr

type _SERVICE_STATUS_PROCESS
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

type SERVICE_STATUS_PROCESS as _SERVICE_STATUS_PROCESS
type LPSERVICE_STATUS_PROCESS as _SERVICE_STATUS_PROCESS ptr

type _ENUM_SERVICE_STATUSA
	lpServiceName as LPSTR
	lpDisplayName as LPSTR
	ServiceStatus as SERVICE_STATUS
end type

type ENUM_SERVICE_STATUSA as _ENUM_SERVICE_STATUSA
type LPENUM_SERVICE_STATUSA as _ENUM_SERVICE_STATUSA ptr

type _ENUM_SERVICE_STATUSW
	lpServiceName as LPWSTR
	lpDisplayName as LPWSTR
	ServiceStatus as SERVICE_STATUS
end type

type ENUM_SERVICE_STATUSW as _ENUM_SERVICE_STATUSW
type LPENUM_SERVICE_STATUSW as _ENUM_SERVICE_STATUSW ptr

#ifdef UNICODE
	type ENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSW
	type LPENUM_SERVICE_STATUS as LPENUM_SERVICE_STATUSW
#else
	type ENUM_SERVICE_STATUS as ENUM_SERVICE_STATUSA
	type LPENUM_SERVICE_STATUS as LPENUM_SERVICE_STATUSA
#endif

type _ENUM_SERVICE_STATUS_PROCESSA
	lpServiceName as LPSTR
	lpDisplayName as LPSTR
	ServiceStatusProcess as SERVICE_STATUS_PROCESS
end type

type ENUM_SERVICE_STATUS_PROCESSA as _ENUM_SERVICE_STATUS_PROCESSA
type LPENUM_SERVICE_STATUS_PROCESSA as _ENUM_SERVICE_STATUS_PROCESSA ptr

type _ENUM_SERVICE_STATUS_PROCESSW
	lpServiceName as LPWSTR
	lpDisplayName as LPWSTR
	ServiceStatusProcess as SERVICE_STATUS_PROCESS
end type

type ENUM_SERVICE_STATUS_PROCESSW as _ENUM_SERVICE_STATUS_PROCESSW
type LPENUM_SERVICE_STATUS_PROCESSW as _ENUM_SERVICE_STATUS_PROCESSW ptr

#ifdef UNICODE
	type ENUM_SERVICE_STATUS_PROCESS as ENUM_SERVICE_STATUS_PROCESSW
	type LPENUM_SERVICE_STATUS_PROCESS as LPENUM_SERVICE_STATUS_PROCESSW
#else
	type ENUM_SERVICE_STATUS_PROCESS as ENUM_SERVICE_STATUS_PROCESSA
	type LPENUM_SERVICE_STATUS_PROCESS as LPENUM_SERVICE_STATUS_PROCESSA
#endif

type SC_LOCK as LPVOID

type _QUERY_SERVICE_LOCK_STATUSA
	fIsLocked as DWORD
	lpLockOwner as LPSTR
	dwLockDuration as DWORD
end type

type QUERY_SERVICE_LOCK_STATUSA as _QUERY_SERVICE_LOCK_STATUSA
type LPQUERY_SERVICE_LOCK_STATUSA as _QUERY_SERVICE_LOCK_STATUSA ptr

type _QUERY_SERVICE_LOCK_STATUSW
	fIsLocked as DWORD
	lpLockOwner as LPWSTR
	dwLockDuration as DWORD
end type

type QUERY_SERVICE_LOCK_STATUSW as _QUERY_SERVICE_LOCK_STATUSW
type LPQUERY_SERVICE_LOCK_STATUSW as _QUERY_SERVICE_LOCK_STATUSW ptr

#ifdef UNICODE
	type QUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSW
	type LPQUERY_SERVICE_LOCK_STATUS as LPQUERY_SERVICE_LOCK_STATUSW
#else
	type QUERY_SERVICE_LOCK_STATUS as QUERY_SERVICE_LOCK_STATUSA
	type LPQUERY_SERVICE_LOCK_STATUS as LPQUERY_SERVICE_LOCK_STATUSA
#endif

type _QUERY_SERVICE_CONFIGA
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

type QUERY_SERVICE_CONFIGA as _QUERY_SERVICE_CONFIGA
type LPQUERY_SERVICE_CONFIGA as _QUERY_SERVICE_CONFIGA ptr

type _QUERY_SERVICE_CONFIGW
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

type QUERY_SERVICE_CONFIGW as _QUERY_SERVICE_CONFIGW
type LPQUERY_SERVICE_CONFIGW as _QUERY_SERVICE_CONFIGW ptr

#ifdef UNICODE
	type QUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGW
	type LPQUERY_SERVICE_CONFIG as LPQUERY_SERVICE_CONFIGW
#else
	type QUERY_SERVICE_CONFIG as QUERY_SERVICE_CONFIGA
	type LPQUERY_SERVICE_CONFIG as LPQUERY_SERVICE_CONFIGA
#endif

type LPSERVICE_MAIN_FUNCTIONW as sub(byval dwNumServicesArgs as DWORD, byval lpServiceArgVectors as LPWSTR ptr)
type LPSERVICE_MAIN_FUNCTIONA as sub(byval dwNumServicesArgs as DWORD, byval lpServiceArgVectors as LPSTR ptr)

#ifdef UNICODE
	type LPSERVICE_MAIN_FUNCTION as LPSERVICE_MAIN_FUNCTIONW
#else
	type LPSERVICE_MAIN_FUNCTION as LPSERVICE_MAIN_FUNCTIONA
#endif

type _SERVICE_TABLE_ENTRYA
	lpServiceName as LPSTR
	lpServiceProc as LPSERVICE_MAIN_FUNCTIONA
end type

type SERVICE_TABLE_ENTRYA as _SERVICE_TABLE_ENTRYA
type LPSERVICE_TABLE_ENTRYA as _SERVICE_TABLE_ENTRYA ptr

type _SERVICE_TABLE_ENTRYW
	lpServiceName as LPWSTR
	lpServiceProc as LPSERVICE_MAIN_FUNCTIONW
end type

type SERVICE_TABLE_ENTRYW as _SERVICE_TABLE_ENTRYW
type LPSERVICE_TABLE_ENTRYW as _SERVICE_TABLE_ENTRYW ptr

#ifdef UNICODE
	type SERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYW
	type LPSERVICE_TABLE_ENTRY as LPSERVICE_TABLE_ENTRYW
#else
	type SERVICE_TABLE_ENTRY as SERVICE_TABLE_ENTRYA
	type LPSERVICE_TABLE_ENTRY as LPSERVICE_TABLE_ENTRYA
#endif

type LPHANDLER_FUNCTION as sub(byval dwControl as DWORD)
type LPHANDLER_FUNCTION_EX as function(byval dwControl as DWORD, byval dwEventType as DWORD, byval lpEventData as LPVOID, byval lpContext as LPVOID) as DWORD
declare function ChangeServiceConfigA(byval hService as SC_HANDLE, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCSTR, byval lpLoadOrderGroup as LPCSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCSTR, byval lpServiceStartName as LPCSTR, byval lpPassword as LPCSTR, byval lpDisplayName as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function ChangeServiceConfig alias "ChangeServiceConfigA"(byval hService as SC_HANDLE, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCSTR, byval lpLoadOrderGroup as LPCSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCSTR, byval lpServiceStartName as LPCSTR, byval lpPassword as LPCSTR, byval lpDisplayName as LPCSTR) as WINBOOL
#endif

declare function ChangeServiceConfigW(byval hService as SC_HANDLE, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCWSTR, byval lpLoadOrderGroup as LPCWSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCWSTR, byval lpServiceStartName as LPCWSTR, byval lpPassword as LPCWSTR, byval lpDisplayName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function ChangeServiceConfig alias "ChangeServiceConfigW"(byval hService as SC_HANDLE, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCWSTR, byval lpLoadOrderGroup as LPCWSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCWSTR, byval lpServiceStartName as LPCWSTR, byval lpPassword as LPCWSTR, byval lpDisplayName as LPCWSTR) as WINBOOL
#endif

declare function ChangeServiceConfig2A(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpInfo as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function ChangeServiceConfig2 alias "ChangeServiceConfig2A"(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpInfo as LPVOID) as WINBOOL
#endif

declare function ChangeServiceConfig2W(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpInfo as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function ChangeServiceConfig2 alias "ChangeServiceConfig2W"(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpInfo as LPVOID) as WINBOOL
#endif

declare function CloseServiceHandle(byval hSCObject as SC_HANDLE) as WINBOOL
declare function ControlService(byval hService as SC_HANDLE, byval dwControl as DWORD, byval lpServiceStatus as LPSERVICE_STATUS) as WINBOOL
declare function CreateServiceA(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval lpDisplayName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCSTR, byval lpLoadOrderGroup as LPCSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCSTR, byval lpServiceStartName as LPCSTR, byval lpPassword as LPCSTR) as SC_HANDLE

#ifndef UNICODE
	declare function CreateService alias "CreateServiceA"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval lpDisplayName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCSTR, byval lpLoadOrderGroup as LPCSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCSTR, byval lpServiceStartName as LPCSTR, byval lpPassword as LPCSTR) as SC_HANDLE
#endif

declare function CreateServiceW(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval lpDisplayName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCWSTR, byval lpLoadOrderGroup as LPCWSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCWSTR, byval lpServiceStartName as LPCWSTR, byval lpPassword as LPCWSTR) as SC_HANDLE

#ifdef UNICODE
	declare function CreateService alias "CreateServiceW"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval lpDisplayName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwServiceType as DWORD, byval dwStartType as DWORD, byval dwErrorControl as DWORD, byval lpBinaryPathName as LPCWSTR, byval lpLoadOrderGroup as LPCWSTR, byval lpdwTagId as LPDWORD, byval lpDependencies as LPCWSTR, byval lpServiceStartName as LPCWSTR, byval lpPassword as LPCWSTR) as SC_HANDLE
#endif

declare function DeleteService(byval hService as SC_HANDLE) as WINBOOL
declare function EnumDependentServicesA(byval hService as SC_HANDLE, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function EnumDependentServices alias "EnumDependentServicesA"(byval hService as SC_HANDLE, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD) as WINBOOL
#endif

declare function EnumDependentServicesW(byval hService as SC_HANDLE, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function EnumDependentServices alias "EnumDependentServicesW"(byval hService as SC_HANDLE, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD) as WINBOOL
#endif

declare function EnumServicesStatusA(byval hSCManager as SC_HANDLE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function EnumServicesStatus alias "EnumServicesStatusA"(byval hSCManager as SC_HANDLE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD) as WINBOOL
#endif

declare function EnumServicesStatusW(byval hSCManager as SC_HANDLE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function EnumServicesStatus alias "EnumServicesStatusW"(byval hSCManager as SC_HANDLE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPENUM_SERVICE_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD) as WINBOOL
#endif

declare function EnumServicesStatusExA(byval hSCManager as SC_HANDLE, byval InfoLevel as SC_ENUM_TYPE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD, byval pszGroupName as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function EnumServicesStatusEx alias "EnumServicesStatusExA"(byval hSCManager as SC_HANDLE, byval InfoLevel as SC_ENUM_TYPE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD, byval pszGroupName as LPCSTR) as WINBOOL
#endif

declare function EnumServicesStatusExW(byval hSCManager as SC_HANDLE, byval InfoLevel as SC_ENUM_TYPE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD, byval pszGroupName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function EnumServicesStatusEx alias "EnumServicesStatusExW"(byval hSCManager as SC_HANDLE, byval InfoLevel as SC_ENUM_TYPE, byval dwServiceType as DWORD, byval dwServiceState as DWORD, byval lpServices as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD, byval lpServicesReturned as LPDWORD, byval lpResumeHandle as LPDWORD, byval pszGroupName as LPCWSTR) as WINBOOL
#endif

declare function GetServiceKeyNameA(byval hSCManager as SC_HANDLE, byval lpDisplayName as LPCSTR, byval lpServiceName as LPSTR, byval lpcchBuffer as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetServiceKeyName alias "GetServiceKeyNameA"(byval hSCManager as SC_HANDLE, byval lpDisplayName as LPCSTR, byval lpServiceName as LPSTR, byval lpcchBuffer as LPDWORD) as WINBOOL
#endif

declare function GetServiceKeyNameW(byval hSCManager as SC_HANDLE, byval lpDisplayName as LPCWSTR, byval lpServiceName as LPWSTR, byval lpcchBuffer as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetServiceKeyName alias "GetServiceKeyNameW"(byval hSCManager as SC_HANDLE, byval lpDisplayName as LPCWSTR, byval lpServiceName as LPWSTR, byval lpcchBuffer as LPDWORD) as WINBOOL
#endif

declare function GetServiceDisplayNameA(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval lpDisplayName as LPSTR, byval lpcchBuffer as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetServiceDisplayName alias "GetServiceDisplayNameA"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval lpDisplayName as LPSTR, byval lpcchBuffer as LPDWORD) as WINBOOL
#endif

declare function GetServiceDisplayNameW(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval lpDisplayName as LPWSTR, byval lpcchBuffer as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetServiceDisplayName alias "GetServiceDisplayNameW"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval lpDisplayName as LPWSTR, byval lpcchBuffer as LPDWORD) as WINBOOL
#endif

declare function LockServiceDatabase(byval hSCManager as SC_HANDLE) as SC_LOCK
declare function NotifyBootConfigStatus(byval BootAcceptable as WINBOOL) as WINBOOL
declare function OpenSCManagerA(byval lpMachineName as LPCSTR, byval lpDatabaseName as LPCSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE

#ifndef UNICODE
	declare function OpenSCManager alias "OpenSCManagerA"(byval lpMachineName as LPCSTR, byval lpDatabaseName as LPCSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE
#endif

declare function OpenSCManagerW(byval lpMachineName as LPCWSTR, byval lpDatabaseName as LPCWSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE

#ifdef UNICODE
	declare function OpenSCManager alias "OpenSCManagerW"(byval lpMachineName as LPCWSTR, byval lpDatabaseName as LPCWSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE
#endif

declare function OpenServiceA(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE

#ifndef UNICODE
	declare function OpenService alias "OpenServiceA"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE
#endif

declare function OpenServiceW(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE

#ifdef UNICODE
	declare function OpenService alias "OpenServiceW"(byval hSCManager as SC_HANDLE, byval lpServiceName as LPCWSTR, byval dwDesiredAccess as DWORD) as SC_HANDLE
#endif

declare function QueryServiceConfigA(byval hService as SC_HANDLE, byval lpServiceConfig as LPQUERY_SERVICE_CONFIGA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function QueryServiceConfig alias "QueryServiceConfigA"(byval hService as SC_HANDLE, byval lpServiceConfig as LPQUERY_SERVICE_CONFIGA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceConfigW(byval hService as SC_HANDLE, byval lpServiceConfig as LPQUERY_SERVICE_CONFIGW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function QueryServiceConfig alias "QueryServiceConfigW"(byval hService as SC_HANDLE, byval lpServiceConfig as LPQUERY_SERVICE_CONFIGW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceConfig2A(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpBuffer as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function QueryServiceConfig2 alias "QueryServiceConfig2A"(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpBuffer as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceConfig2W(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpBuffer as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function QueryServiceConfig2 alias "QueryServiceConfig2W"(byval hService as SC_HANDLE, byval dwInfoLevel as DWORD, byval lpBuffer as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceLockStatusA(byval hSCManager as SC_HANDLE, byval lpLockStatus as LPQUERY_SERVICE_LOCK_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function QueryServiceLockStatus alias "QueryServiceLockStatusA"(byval hSCManager as SC_HANDLE, byval lpLockStatus as LPQUERY_SERVICE_LOCK_STATUSA, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceLockStatusW(byval hSCManager as SC_HANDLE, byval lpLockStatus as LPQUERY_SERVICE_LOCK_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function QueryServiceLockStatus alias "QueryServiceLockStatusW"(byval hSCManager as SC_HANDLE, byval lpLockStatus as LPQUERY_SERVICE_LOCK_STATUSW, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
#endif

declare function QueryServiceObjectSecurity(byval hService as SC_HANDLE, byval dwSecurityInformation as SECURITY_INFORMATION, byval lpSecurityDescriptor as PSECURITY_DESCRIPTOR, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
declare function QueryServiceStatus(byval hService as SC_HANDLE, byval lpServiceStatus as LPSERVICE_STATUS) as WINBOOL
declare function QueryServiceStatusEx(byval hService as SC_HANDLE, byval InfoLevel as SC_STATUS_TYPE, byval lpBuffer as LPBYTE, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL
declare function RegisterServiceCtrlHandlerA(byval lpServiceName as LPCSTR, byval lpHandlerProc as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE

#ifndef UNICODE
	declare function RegisterServiceCtrlHandler alias "RegisterServiceCtrlHandlerA"(byval lpServiceName as LPCSTR, byval lpHandlerProc as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE
#endif

declare function RegisterServiceCtrlHandlerW(byval lpServiceName as LPCWSTR, byval lpHandlerProc as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE

#ifdef UNICODE
	declare function RegisterServiceCtrlHandler alias "RegisterServiceCtrlHandlerW"(byval lpServiceName as LPCWSTR, byval lpHandlerProc as LPHANDLER_FUNCTION) as SERVICE_STATUS_HANDLE
#endif

declare function RegisterServiceCtrlHandlerExA(byval lpServiceName as LPCSTR, byval lpHandlerProc as LPHANDLER_FUNCTION_EX, byval lpContext as LPVOID) as SERVICE_STATUS_HANDLE

#ifndef UNICODE
	declare function RegisterServiceCtrlHandlerEx alias "RegisterServiceCtrlHandlerExA"(byval lpServiceName as LPCSTR, byval lpHandlerProc as LPHANDLER_FUNCTION_EX, byval lpContext as LPVOID) as SERVICE_STATUS_HANDLE
#endif

declare function RegisterServiceCtrlHandlerExW(byval lpServiceName as LPCWSTR, byval lpHandlerProc as LPHANDLER_FUNCTION_EX, byval lpContext as LPVOID) as SERVICE_STATUS_HANDLE

#ifdef UNICODE
	declare function RegisterServiceCtrlHandlerEx alias "RegisterServiceCtrlHandlerExW"(byval lpServiceName as LPCWSTR, byval lpHandlerProc as LPHANDLER_FUNCTION_EX, byval lpContext as LPVOID) as SERVICE_STATUS_HANDLE
#endif

declare function SetServiceObjectSecurity(byval hService as SC_HANDLE, byval dwSecurityInformation as SECURITY_INFORMATION, byval lpSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
declare function SetServiceStatus(byval hServiceStatus as SERVICE_STATUS_HANDLE, byval lpServiceStatus as LPSERVICE_STATUS) as WINBOOL
declare function StartServiceCtrlDispatcherA(byval lpServiceStartTable as const SERVICE_TABLE_ENTRYA ptr) as WINBOOL

#ifndef UNICODE
	declare function StartServiceCtrlDispatcher alias "StartServiceCtrlDispatcherA"(byval lpServiceStartTable as const SERVICE_TABLE_ENTRYA ptr) as WINBOOL
#endif

declare function StartServiceCtrlDispatcherW(byval lpServiceStartTable as const SERVICE_TABLE_ENTRYW ptr) as WINBOOL

#ifdef UNICODE
	declare function StartServiceCtrlDispatcher alias "StartServiceCtrlDispatcherW"(byval lpServiceStartTable as const SERVICE_TABLE_ENTRYW ptr) as WINBOOL
#endif

declare function StartServiceA(byval hService as SC_HANDLE, byval dwNumServiceArgs as DWORD, byval lpServiceArgVectors as LPCSTR ptr) as WINBOOL

#ifndef UNICODE
	declare function StartService alias "StartServiceA"(byval hService as SC_HANDLE, byval dwNumServiceArgs as DWORD, byval lpServiceArgVectors as LPCSTR ptr) as WINBOOL
#endif

declare function StartServiceW(byval hService as SC_HANDLE, byval dwNumServiceArgs as DWORD, byval lpServiceArgVectors as LPCWSTR ptr) as WINBOOL

#ifdef UNICODE
	declare function StartService alias "StartServiceW"(byval hService as SC_HANDLE, byval dwNumServiceArgs as DWORD, byval lpServiceArgVectors as LPCWSTR ptr) as WINBOOL
#endif

declare function UnlockServiceDatabase(byval ScLock as SC_LOCK) as WINBOOL

#if _WIN32_WINNT >= &h0600
	type PFN_SC_NOTIFY_CALLBACK as sub(byval pParameter as PVOID)

	type _SERVICE_CONTROL_STATUS_REASON_PARAMSA
		dwReason as DWORD
		pszComment as LPSTR
		ServiceStatus as SERVICE_STATUS_PROCESS
	end type

	type SERVICE_CONTROL_STATUS_REASON_PARAMSA as _SERVICE_CONTROL_STATUS_REASON_PARAMSA
	type PSERVICE_CONTROL_STATUS_REASON_PARAMSA as _SERVICE_CONTROL_STATUS_REASON_PARAMSA ptr

	type _SERVICE_CONTROL_STATUS_REASON_PARAMSW
		dwReason as DWORD
		pszComment as LPWSTR
		ServiceStatus as SERVICE_STATUS_PROCESS
	end type

	type SERVICE_CONTROL_STATUS_REASON_PARAMSW as _SERVICE_CONTROL_STATUS_REASON_PARAMSW
	type PSERVICE_CONTROL_STATUS_REASON_PARAMSW as _SERVICE_CONTROL_STATUS_REASON_PARAMSW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	type SERVICE_CONTROL_STATUS_REASON_PARAMS as SERVICE_CONTROL_STATUS_REASON_PARAMSW
	type PSERVICE_CONTROL_STATUS_REASON_PARAMS as PSERVICE_CONTROL_STATUS_REASON_PARAMSW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	type SERVICE_CONTROL_STATUS_REASON_PARAMS as SERVICE_CONTROL_STATUS_REASON_PARAMSA
	type PSERVICE_CONTROL_STATUS_REASON_PARAMS as PSERVICE_CONTROL_STATUS_REASON_PARAMSA
#endif

#if _WIN32_WINNT >= &h0600
	const SERVICE_STOP_REASON_FLAG_CUSTOM = &h20000000
	const SERVICE_STOP_REASON_FLAG_PLANNED = &h40000000
	const SERVICE_STOP_REASON_FLAG_UNPLANNED = &h10000000
	const SERVICE_STOP_REASON_MAJOR_APPLICATION = &h00050000
	const SERVICE_STOP_REASON_MAJOR_HARDWARE = &h00020000
	const SERVICE_STOP_REASON_MAJOR_NONE = &h00060000
	const SERVICE_STOP_REASON_MAJOR_OPERATINGSYSTEM = &h00030000
	const SERVICE_STOP_REASON_MAJOR_OTHER = &h00010000
	const SERVICE_STOP_REASON_MAJOR_SOFTWARE = &h00040000
	const SERVICE_STOP_REASON_MINOR_DISK = &h00000008
	const SERVICE_STOP_REASON_MINOR_ENVIRONMENT = &h0000000a
	const SERVICE_STOP_REASON_MINOR_HARDWARE_DRIVER = &h0000000b
	const SERVICE_STOP_REASON_MINOR_HUNG = &h00000006
	const SERVICE_STOP_REASON_MINOR_INSTALLATION = &h00000003
	const SERVICE_STOP_REASON_MINOR_MAINTENANCE = &h00000002
	const SERVICE_STOP_REASON_MINOR_MMC = &h00000016
	const SERVICE_STOP_REASON_MINOR_NETWORK_CONNECTIVITY = &h00000011
	const SERVICE_STOP_REASON_MINOR_NETWORKCARD = &h00000009
	const SERVICE_STOP_REASON_MINOR_NONE = &h00060000
	const SERVICE_STOP_REASON_MINOR_OTHER = &h00000001
	const SERVICE_STOP_REASON_MINOR_OTHERDRIVER = &h0000000c
	const SERVICE_STOP_REASON_MINOR_RECONFIG = &h00000005
	const SERVICE_STOP_REASON_MINOR_SECURITY = &h00000010
	const SERVICE_STOP_REASON_MINOR_SECURITYFIX = &h0000000f
	const SERVICE_STOP_REASON_MINOR_SECURITYFIX_UNINSTALL = &h00000015
	const SERVICE_STOP_REASON_MINOR_SERVICEPACK = &h0000000d
	const SERVICE_STOP_REASON_MINOR_SERVICEPACK_UNINSTALL = &h00000013
	const SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE = &h0000000e
	const SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE_UNINSTALL = &h0000000e
	const SERVICE_STOP_REASON_MINOR_UNSTABLE = &h00000007
	const SERVICE_STOP_REASON_MINOR_UPGRADE = &h00000004
	const SERVICE_STOP_REASON_MINOR_WMI = &h00000012

	type _SERVICE_NOTIFYA
		dwVersion as DWORD
		pfnNotifyCallback as PFN_SC_NOTIFY_CALLBACK
		pContext as PVOID
		dwNotificationStatus as DWORD
		ServiceStatus as SERVICE_STATUS_PROCESS
		dwNotificationTriggered as DWORD
		pszServiceNames as LPSTR
	end type

	type SERVICE_NOTIFYA as _SERVICE_NOTIFYA
	type PSERVICE_NOTIFYA as _SERVICE_NOTIFYA ptr

	type _SERVICE_NOTIFYW
		dwVersion as DWORD
		pfnNotifyCallback as PFN_SC_NOTIFY_CALLBACK
		pContext as PVOID
		dwNotificationStatus as DWORD
		ServiceStatus as SERVICE_STATUS_PROCESS
		dwNotificationTriggered as DWORD
		pszServiceNames as LPWSTR
	end type

	type SERVICE_NOTIFYW as _SERVICE_NOTIFYW
	type PSERVICE_NOTIFYW as _SERVICE_NOTIFYW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	type SERVICE_NOTIFY as SERVICE_NOTIFYW
	type PSERVICE_NOTIFY as PSERVICE_NOTIFYW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	type SERVICE_NOTIFY as SERVICE_NOTIFYA
	type PSERVICE_NOTIFY as PSERVICE_NOTIFYA
#endif

#if _WIN32_WINNT >= &h0600
	const SERVICE_CONFIG_DELAYED_AUTO_START_INFO = 3
	const SERVICE_CONFIG_FAILURE_ACTIONS_FLAG = 4
	const SERVICE_CONFIG_SERVICE_SID_INFO = 5
	const SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO = 6
	const SERVICE_CONFIG_PRESHUTDOWN_INFO = 7

	type _SERVICE_DELAYED_AUTO_START_INFO
		fDelayedAutostart as WINBOOL
	end type

	type SERVICE_DELAYED_AUTO_START_INFO as _SERVICE_DELAYED_AUTO_START_INFO
	type LPSERVICE_DELAYED_AUTO_START_INFO as _SERVICE_DELAYED_AUTO_START_INFO ptr

	type _SERVICE_FAILURE_ACTIONS_FLAG
		fFailureActionsOnNonCrashFailures as WINBOOL
	end type

	type SERVICE_FAILURE_ACTIONS_FLAG as _SERVICE_FAILURE_ACTIONS_FLAG
	type LPSERVICE_FAILURE_ACTIONS_FLAG as _SERVICE_FAILURE_ACTIONS_FLAG ptr

	type _SERVICE_PRESHUTDOWN_INFO
		dwPreshutdownTimeout as DWORD
	end type

	type SERVICE_PRESHUTDOWN_INFO as _SERVICE_PRESHUTDOWN_INFO
	type LPSERVICE_PRESHUTDOWN_INFO as _SERVICE_PRESHUTDOWN_INFO ptr

	type _SERVICE_REQUIRED_PRIVILEGES_INFOA
		pmszRequiredPrivileges as LPSTR
	end type

	type SERVICE_REQUIRED_PRIVILEGES_INFOA as _SERVICE_REQUIRED_PRIVILEGES_INFOA
	type LPSERVICE_REQUIRED_PRIVILEGES_INFOA as _SERVICE_REQUIRED_PRIVILEGES_INFOA ptr

	type _SERVICE_REQUIRED_PRIVILEGES_INFOW
		pmszRequiredPrivileges as LPWSTR
	end type

	type SERVICE_REQUIRED_PRIVILEGES_INFOW as _SERVICE_REQUIRED_PRIVILEGES_INFOW
	type LPSERVICE_REQUIRED_PRIVILEGES_INFOW as _SERVICE_REQUIRED_PRIVILEGES_INFOW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	type SERVICE_REQUIRED_PRIVILEGES_INFO as SERVICE_REQUIRED_PRIVILEGES_INFOW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	type SERVICE_REQUIRED_PRIVILEGES_INFO as SERVICE_REQUIRED_PRIVILEGES_INFOA
#endif

#if _WIN32_WINNT >= &h0600
	const SERVICE_SID_TYPE_NONE = &h00000000
	const SERVICE_SID_TYPE_RESTRICTED = &h00000003
	const SERVICE_SID_TYPE_UNRESTRICTED = &h00000001

	type _SERVICE_SID_INFO
		dwServiceSidType as DWORD
	end type

	type SERVICE_SID_INFO as _SERVICE_SID_INFO
	type LPSERVICE_SID_INFO as _SERVICE_SID_INFO ptr
	declare function ControlServiceExA(byval hService as SC_HANDLE, byval dwControl as DWORD, byval dwInfoLevel as DWORD, byval pControlParams as PVOID) as WINBOOL
	declare function ControlServiceExW(byval hService as SC_HANDLE, byval dwControl as DWORD, byval dwInfoLevel as DWORD, byval pControlParams as PVOID) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function ControlServiceEx alias "ControlServiceExW"(byval hService as SC_HANDLE, byval dwControl as DWORD, byval dwInfoLevel as DWORD, byval pControlParams as PVOID) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function ControlServiceEx alias "ControlServiceExA"(byval hService as SC_HANDLE, byval dwControl as DWORD, byval dwInfoLevel as DWORD, byval pControlParams as PVOID) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function NotifyServiceStatusChangeA(byval hService as SC_HANDLE, byval dwNotifyMask as DWORD, byval pNotifyBuffer as PSERVICE_NOTIFYA) as DWORD
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function NotifyServiceStatusChange alias "NotifyServiceStatusChangeA"(byval hService as SC_HANDLE, byval dwNotifyMask as DWORD, byval pNotifyBuffer as PSERVICE_NOTIFYA) as DWORD
#endif

#if _WIN32_WINNT >= &h0600
	declare function NotifyServiceStatusChangeW(byval hService as SC_HANDLE, byval dwNotifyMask as DWORD, byval pNotifyBuffer as PSERVICE_NOTIFYW) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function NotifyServiceStatusChange alias "NotifyServiceStatusChangeW"(byval hService as SC_HANDLE, byval dwNotifyMask as DWORD, byval pNotifyBuffer as PSERVICE_NOTIFYW) as DWORD
#endif

end extern
