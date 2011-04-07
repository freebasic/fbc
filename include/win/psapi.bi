''
''
'' psapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_psapi_bi__
#define __win_psapi_bi__

#inclib "psapi"

type MODULEINFO
	lpBaseOfDll as LPVOID
	SizeOfImage as DWORD
	EntryPoint as LPVOID
end type

type LPMODULEINFO as MODULEINFO ptr

type PSAPI_WS_WATCH_INFORMATION
	FaultingPc as LPVOID
	FaultingVa as LPVOID
end type

type PPSAPI_WS_WATCH_INFORMATION as PSAPI_WS_WATCH_INFORMATION ptr

type PROCESS_MEMORY_COUNTERS
	cb as DWORD
	PageFaultCount as DWORD
	PeakWorkingSetSize as DWORD
	WorkingSetSize as DWORD
	QuotaPeakPagedPoolUsage as DWORD
	QuotaPagedPoolUsage as DWORD
	QuotaPeakNonPagedPoolUsage as DWORD
	QuotaNonPagedPoolUsage as DWORD
	PagefileUsage as DWORD
	PeakPagefileUsage as DWORD
end type

type PPROCESS_MEMORY_COUNTERS as PROCESS_MEMORY_COUNTERS ptr

declare function EnumProcesses alias "EnumProcesses" (byval as DWORD ptr, byval as DWORD, byval as DWORD ptr) as BOOL
declare function EnumProcessModules alias "EnumProcessModules" (byval as HANDLE, byval as HMODULE ptr, byval as DWORD, byval as LPDWORD) as BOOL
declare function GetModuleInformation alias "GetModuleInformation" (byval as HANDLE, byval as HMODULE, byval as LPMODULEINFO, byval as DWORD) as BOOL
declare function EmptyWorkingSet alias "EmptyWorkingSet" (byval as HANDLE) as BOOL
declare function QueryWorkingSet alias "QueryWorkingSet" (byval as HANDLE, byval as PVOID, byval as DWORD) as BOOL
declare function InitializeProcessForWsWatch alias "InitializeProcessForWsWatch" (byval as HANDLE) as BOOL
declare function GetWsChanges alias "GetWsChanges" (byval as HANDLE, byval as PPSAPI_WS_WATCH_INFORMATION, byval as DWORD) as BOOL
declare function EnumDeviceDrivers alias "EnumDeviceDrivers" (byval as LPVOID ptr, byval as DWORD, byval as LPDWORD) as BOOL
declare function GetProcessMemoryInfo alias "GetProcessMemoryInfo" (byval as HANDLE, byval as PPROCESS_MEMORY_COUNTERS, byval as DWORD) as BOOL

#ifdef UNICODE
declare function GetModuleBaseName alias "GetModuleBaseNameW" (byval as HANDLE, byval as HMODULE, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetModuleFileNameEx alias "GetModuleFileNameExW" (byval as HANDLE, byval as HMODULE, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetMappedFileName alias "GetMappedFileNameW" (byval as HANDLE, byval as LPVOID, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetDeviceDriverBaseName alias "GetDeviceDriverBaseNameW" (byval as LPVOID, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetDeviceDriverFileName alias "GetDeviceDriverFileNameW" (byval as LPVOID, byval as LPWSTR, byval as DWORD) as DWORD

#else
declare function GetModuleBaseName alias "GetModuleBaseNameA" (byval as HANDLE, byval as HMODULE, byval as LPSTR, byval as DWORD) as DWORD
declare function GetModuleFileNameEx alias "GetModuleFileNameExA" (byval as HANDLE, byval as HMODULE, byval as LPSTR, byval as DWORD) as DWORD
declare function GetMappedFileName alias "GetMappedFileNameA" (byval as HANDLE, byval as LPVOID, byval as LPSTR, byval as DWORD) as DWORD
declare function GetDeviceDriverBaseName alias "GetDeviceDriverBaseNameA" (byval as LPVOID, byval as LPSTR, byval as DWORD) as DWORD
declare function GetDeviceDriverFileName alias "GetDeviceDriverFileNameA" (byval as LPVOID, byval as LPSTR, byval as DWORD) as DWORD
#endif

#endif
