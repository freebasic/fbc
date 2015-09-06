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

#inclib "psapi"

#include once "_mingw_unicode.bi"

extern "Windows"

#define _PSAPI_H_

#ifdef UNICODE
	type PENUM_PAGE_FILE_CALLBACK as PENUM_PAGE_FILE_CALLBACKW
#else
	type PENUM_PAGE_FILE_CALLBACK as PENUM_PAGE_FILE_CALLBACKA
#endif

const LIST_MODULES_DEFAULT = &h0
const LIST_MODULES_32BIT = &h01
const LIST_MODULES_64BIT = &h02
const LIST_MODULES_ALL = LIST_MODULES_32BIT or LIST_MODULES_64BIT

declare function EnumProcesses(byval lpidProcess as DWORD ptr, byval cb as DWORD, byval cbNeeded as DWORD ptr) as WINBOOL
declare function EnumProcessModules(byval hProcess as HANDLE, byval lphModule as HMODULE ptr, byval cb as DWORD, byval lpcbNeeded as LPDWORD) as WINBOOL
declare function GetModuleBaseNameA(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpBaseName as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetModuleBaseName alias "GetModuleBaseNameA"(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpBaseName as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetModuleBaseNameW(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpBaseName as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetModuleBaseName alias "GetModuleBaseNameW"(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpBaseName as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetModuleFileNameExA(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetModuleFileNameEx alias "GetModuleFileNameExA"(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetModuleFileNameExW(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetModuleFileNameEx alias "GetModuleFileNameExW"(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD
#endif

type _MODULEINFO
	lpBaseOfDll as LPVOID
	SizeOfImage as DWORD
	EntryPoint as LPVOID
end type

type MODULEINFO as _MODULEINFO
type LPMODULEINFO as _MODULEINFO ptr
declare function GetModuleInformation(byval hProcess as HANDLE, byval hModule as HMODULE, byval lpmodinfo as LPMODULEINFO, byval cb as DWORD) as WINBOOL
declare function EmptyWorkingSet(byval hProcess as HANDLE) as WINBOOL
declare function QueryWorkingSet(byval hProcess as HANDLE, byval pv as PVOID, byval cb as DWORD) as WINBOOL
declare function QueryWorkingSetEx(byval hProcess as HANDLE, byval pv as PVOID, byval cb as DWORD) as WINBOOL
declare function InitializeProcessForWsWatch(byval hProcess as HANDLE) as WINBOOL

type _PSAPI_WS_WATCH_INFORMATION
	FaultingPc as LPVOID
	FaultingVa as LPVOID
end type

type PSAPI_WS_WATCH_INFORMATION as _PSAPI_WS_WATCH_INFORMATION
type PPSAPI_WS_WATCH_INFORMATION as _PSAPI_WS_WATCH_INFORMATION ptr
declare function GetWsChanges(byval hProcess as HANDLE, byval lpWatchInfo as PPSAPI_WS_WATCH_INFORMATION, byval cb as DWORD) as WINBOOL
declare function GetMappedFileNameW(byval hProcess as HANDLE, byval lpv as LPVOID, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetMappedFileName alias "GetMappedFileNameW"(byval hProcess as HANDLE, byval lpv as LPVOID, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetMappedFileNameA(byval hProcess as HANDLE, byval lpv as LPVOID, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetMappedFileName alias "GetMappedFileNameA"(byval hProcess as HANDLE, byval lpv as LPVOID, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function EnumDeviceDrivers(byval lpImageBase as LPVOID ptr, byval cb as DWORD, byval lpcbNeeded as LPDWORD) as WINBOOL
declare function GetDeviceDriverBaseNameA(byval ImageBase as LPVOID, byval lpBaseName as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetDeviceDriverBaseName alias "GetDeviceDriverBaseNameA"(byval ImageBase as LPVOID, byval lpBaseName as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetDeviceDriverBaseNameW(byval ImageBase as LPVOID, byval lpBaseName as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetDeviceDriverBaseName alias "GetDeviceDriverBaseNameW"(byval ImageBase as LPVOID, byval lpBaseName as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetDeviceDriverFileNameA(byval ImageBase as LPVOID, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetDeviceDriverFileName alias "GetDeviceDriverFileNameA"(byval ImageBase as LPVOID, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetDeviceDriverFileNameW(byval ImageBase as LPVOID, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetDeviceDriverFileName alias "GetDeviceDriverFileNameW"(byval ImageBase as LPVOID, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD
#endif

type _PROCESS_MEMORY_COUNTERS
	cb as DWORD
	PageFaultCount as DWORD
	PeakWorkingSetSize as SIZE_T_
	WorkingSetSize as SIZE_T_
	QuotaPeakPagedPoolUsage as SIZE_T_
	QuotaPagedPoolUsage as SIZE_T_
	QuotaPeakNonPagedPoolUsage as SIZE_T_
	QuotaNonPagedPoolUsage as SIZE_T_
	PagefileUsage as SIZE_T_
	PeakPagefileUsage as SIZE_T_
end type

type PROCESS_MEMORY_COUNTERS as _PROCESS_MEMORY_COUNTERS
type PPROCESS_MEMORY_COUNTERS as PROCESS_MEMORY_COUNTERS ptr

type _PROCESS_MEMORY_COUNTERS_EX
	cb as DWORD
	PageFaultCount as DWORD
	PeakWorkingSetSize as SIZE_T_
	WorkingSetSize as SIZE_T_
	QuotaPeakPagedPoolUsage as SIZE_T_
	QuotaPagedPoolUsage as SIZE_T_
	QuotaPeakNonPagedPoolUsage as SIZE_T_
	QuotaNonPagedPoolUsage as SIZE_T_
	PagefileUsage as SIZE_T_
	PeakPagefileUsage as SIZE_T_
	PrivateUsage as SIZE_T_
end type

type PROCESS_MEMORY_COUNTERS_EX as _PROCESS_MEMORY_COUNTERS_EX
type PPROCESS_MEMORY_COUNTERS_EX as PROCESS_MEMORY_COUNTERS_EX ptr
declare function GetProcessMemoryInfo(byval Process as HANDLE, byval ppsmemCounters as PPROCESS_MEMORY_COUNTERS, byval cb as DWORD) as WINBOOL

type _PERFORMANCE_INFORMATION
	cb as DWORD
	CommitTotal as SIZE_T_
	CommitLimit as SIZE_T_
	CommitPeak as SIZE_T_
	PhysicalTotal as SIZE_T_
	PhysicalAvailable as SIZE_T_
	SystemCache as SIZE_T_
	KernelTotal as SIZE_T_
	KernelPaged as SIZE_T_
	KernelNonpaged as SIZE_T_
	PageSize as SIZE_T_
	HandleCount as DWORD
	ProcessCount as DWORD
	ThreadCount as DWORD
end type

type PERFORMANCE_INFORMATION as _PERFORMANCE_INFORMATION
type PPERFORMANCE_INFORMATION as _PERFORMANCE_INFORMATION ptr
type PERFORMACE_INFORMATION as _PERFORMANCE_INFORMATION
type PPERFORMACE_INFORMATION as _PERFORMANCE_INFORMATION ptr
declare function GetPerformanceInfo(byval pPerformanceInformation as PPERFORMACE_INFORMATION, byval cb as DWORD) as WINBOOL

type _ENUM_PAGE_FILE_INFORMATION
	cb as DWORD
	Reserved as DWORD
	TotalSize as SIZE_T_
	TotalInUse as SIZE_T_
	PeakUsage as SIZE_T_
end type

type ENUM_PAGE_FILE_INFORMATION as _ENUM_PAGE_FILE_INFORMATION
type PENUM_PAGE_FILE_INFORMATION as _ENUM_PAGE_FILE_INFORMATION ptr
type PENUM_PAGE_FILE_CALLBACKW as function cdecl(byval pContext as LPVOID, byval pPageFileInfo as PENUM_PAGE_FILE_INFORMATION, byval lpFilename as LPCWSTR) as WINBOOL
type PENUM_PAGE_FILE_CALLBACKA as function cdecl(byval pContext as LPVOID, byval pPageFileInfo as PENUM_PAGE_FILE_INFORMATION, byval lpFilename as LPCSTR) as WINBOOL
declare function EnumPageFilesW(byval pCallBackRoutine as PENUM_PAGE_FILE_CALLBACKW, byval pContext as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function EnumPageFiles alias "EnumPageFilesW"(byval pCallBackRoutine as PENUM_PAGE_FILE_CALLBACKW, byval pContext as LPVOID) as WINBOOL
#endif

declare function EnumPageFilesA(byval pCallBackRoutine as PENUM_PAGE_FILE_CALLBACKA, byval pContext as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function EnumPageFiles alias "EnumPageFilesA"(byval pCallBackRoutine as PENUM_PAGE_FILE_CALLBACKA, byval pContext as LPVOID) as WINBOOL
#endif

declare function GetProcessImageFileNameA(byval hProcess as HANDLE, byval lpImageFileName as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetProcessImageFileName alias "GetProcessImageFileNameA"(byval hProcess as HANDLE, byval lpImageFileName as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetProcessImageFileNameW(byval hProcess as HANDLE, byval lpImageFileName as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetProcessImageFileName alias "GetProcessImageFileNameW"(byval hProcess as HANDLE, byval lpImageFileName as LPWSTR, byval nSize as DWORD) as DWORD
#endif

type _PSAPI_WS_WATCH_INFORMATION_EX
	BasicInfo as PSAPI_WS_WATCH_INFORMATION
	FaultingThreadId as ULONG_PTR
	Flags as ULONG_PTR
end type

type PSAPI_WS_WATCH_INFORMATION_EX as _PSAPI_WS_WATCH_INFORMATION_EX
type PPSAPI_WS_WATCH_INFORMATION_EX as _PSAPI_WS_WATCH_INFORMATION_EX ptr
declare function GetWsChangesEx(byval hProcess as HANDLE, byval lpWatchInfoEx as PPSAPI_WS_WATCH_INFORMATION_EX, byval cb as DWORD) as WINBOOL
declare function EnumProcessModulesEx(byval hProcess as HANDLE, byval lphModule as HMODULE ptr, byval cb as DWORD, byval lpcbNeeded as LPDWORD, byval dwFilterFlag as DWORD) as WINBOOL

union _PSAPI_WORKING_SET_BLOCK
	Flags as ULONG_PTR

	type
		Protection : 5 as ULONG_PTR
		ShareCount : 3 as ULONG_PTR
		Shared : 1 as ULONG_PTR
		Reserved : 3 as ULONG_PTR

		#ifdef __FB_64BIT__
			VirtualPage : 52 as ULONG_PTR
		#else
			VirtualPage : 20 as ULONG_PTR
		#endif
	end type
end union

type PSAPI_WORKING_SET_BLOCK as _PSAPI_WORKING_SET_BLOCK
type PPSAPI_WORKING_SET_BLOCK as _PSAPI_WORKING_SET_BLOCK ptr

type _PSAPI_WORKING_SET_INFORMATION
	NumberOfEntries as ULONG_PTR
	WorkingSetInfo(0 to 0) as PSAPI_WORKING_SET_BLOCK
end type

type PSAPI_WORKING_SET_INFORMATION as _PSAPI_WORKING_SET_INFORMATION
type PPSAPI_WORKING_SET_INFORMATION as _PSAPI_WORKING_SET_INFORMATION ptr

union _PSAPI_WORKING_SET_EX_BLOCK
	Flags as ULONG_PTR

	type
		Valid : 1 as ULONG_PTR
		ShareCount : 3 as ULONG_PTR
		Win32Protection : 11 as ULONG_PTR
		Shared : 1 as ULONG_PTR
		Node : 6 as ULONG_PTR
		Locked : 1 as ULONG_PTR
		LargePage : 1 as ULONG_PTR
	end type
end union

type PSAPI_WORKING_SET_EX_BLOCK as _PSAPI_WORKING_SET_EX_BLOCK
type PPSAPI_WORKING_SET_EX_BLOCK as _PSAPI_WORKING_SET_EX_BLOCK ptr

type _PSAPI_WORKING_SET_EX_INFORMATION
	VirtualAddress as PVOID
	VirtualAttributes as PSAPI_WORKING_SET_EX_BLOCK
end type

type PSAPI_WORKING_SET_EX_INFORMATION as _PSAPI_WORKING_SET_EX_INFORMATION
type PPSAPI_WORKING_SET_EX_INFORMATION as _PSAPI_WORKING_SET_EX_INFORMATION ptr

end extern
