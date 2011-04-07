''
''
'' tlhelp32 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_tlhelp32_bi__
#define __win_tlhelp32_bi__

#inclib "kernel32"

#define HF32_DEFAULT 1
#define HF32_SHARED 2
#define LF32_FIXED &h1
#define LF32_FREE &h2
#define LF32_MOVEABLE &h4
#define MAX_MODULE_NAME32 255
#define TH32CS_SNAPHEAPLIST &h1
#define TH32CS_SNAPPROCESS &h2
#define TH32CS_SNAPTHREAD &h4
#define TH32CS_SNAPMODULE &h8
#define TH32CS_SNAPALL (&h1 or &h2 or &h4 or &h8)
#define TH32CS_INHERIT &h80000000

type HEAPLIST32
	dwSize as DWORD
	th32ProcessID as DWORD
	th32HeapID as DWORD
	dwFlags as DWORD
end type

type PHEAPLIST32 as HEAPLIST32 ptr
type LPHEAPLIST32 as HEAPLIST32 ptr

type HEAPENTRY32
	dwSize as DWORD
	hHandle as HANDLE
	dwAddress as DWORD
	dwBlockSize as DWORD
	dwFlags as DWORD
	dwLockCount as DWORD
	dwResvd as DWORD
	th32ProcessID as DWORD
	th32HeapID as DWORD
end type

type PHEAPENTRY32 as HEAPENTRY32 ptr
type LPHEAPENTRY32 as HEAPENTRY32 ptr

#ifdef UNICODE
type PROCESSENTRY32W
	dwSize as DWORD
	cntUsage as DWORD
	th32ProcessID as DWORD
	th32DefaultHeapID as DWORD
	th32ModuleID as DWORD
	cntThreads as DWORD
	th32ParentProcessID as DWORD
	pcPriClassBase as LONG
	dwFlags as DWORD
	szExeFile as wstring * 260
end type

type PPROCESSENTRY32W as PROCESSENTRY32W ptr
type LPPROCESSENTRY32W as PROCESSENTRY32W ptr

#else ''UNICODE
type PROCESSENTRY32
	dwSize as DWORD
	cntUsage as DWORD
	th32ProcessID as DWORD
	th32DefaultHeapID as DWORD
	th32ModuleID as DWORD
	cntThreads as DWORD
	th32ParentProcessID as DWORD
	pcPriClassBase as LONG
	dwFlags as DWORD
	szExeFile as zstring * 260
end type

type PPROCESSENTRY32 as PROCESSENTRY32 ptr
type LPPROCESSENTRY32 as PROCESSENTRY32 ptr
#endif ''UNICODE

type THREADENTRY32
	dwSize as DWORD
	cntUsage as DWORD
	th32ThreadID as DWORD
	th32OwnerProcessID as DWORD
	tpBasePri as LONG
	tpDeltaPri as LONG
	dwFlags as DWORD
end type

type PTHREADENTRY32 as THREADENTRY32 ptr
type LPTHREADENTRY32 as THREADENTRY32 ptr

#ifdef UNICODE
type MODULEENTRY32W
	dwSize as DWORD
	th32ModuleID as DWORD
	th32ProcessID as DWORD
	GlblcntUsage as DWORD
	ProccntUsage as DWORD
	modBaseAddr as UBYTE ptr
	modBaseSize as DWORD
	hModule as HMODULE
	szModule as wstring * 255+1
	szExePath as wstring * 260
end type

type PMODULEENTRY32W as MODULEENTRY32W ptr
type LPMODULEENTRY32W as MODULEENTRY32W ptr

#else ''UNICODE
type MODULEENTRY32
	dwSize as DWORD
	th32ModuleID as DWORD
	th32ProcessID as DWORD
	GlblcntUsage as DWORD
	ProccntUsage as DWORD
	modBaseAddr as UBYTE ptr
	modBaseSize as DWORD
	hModule as HMODULE
	szModule as zstring * 255+1
	szExePath as zstring * 260
end type

type PMODULEENTRY32 as MODULEENTRY32 ptr
type LPMODULEENTRY32 as MODULEENTRY32 ptr
#endif ''UNICODE

declare function Heap32First alias "Heap32First" (byval as LPHEAPENTRY32, byval as DWORD, byval as DWORD) as BOOL
declare function Heap32ListFirst alias "Heap32ListFirst" (byval as HANDLE, byval as LPHEAPLIST32) as BOOL
declare function Heap32ListNext alias "Heap32ListNext" (byval as HANDLE, byval as LPHEAPLIST32) as BOOL
declare function Heap32Next alias "Heap32Next" (byval as LPHEAPENTRY32) as BOOL
declare function Thread32First alias "Thread32First" (byval as HANDLE, byval as LPTHREADENTRY32) as BOOL
declare function Thread32Next alias "Thread32Next" (byval as HANDLE, byval as LPTHREADENTRY32) as BOOL
declare function Toolhelp32ReadProcessMemory alias "Toolhelp32ReadProcessMemory" (byval as DWORD, byval as LPCVOID, byval as LPVOID, byval as DWORD, byval as LPDWORD) as BOOL
declare function CreateToolhelp32Snapshot alias "CreateToolhelp32Snapshot" (byval as DWORD, byval as DWORD) as HANDLE

#ifdef UNICODE
declare function Module32First alias "Module32FirstW" (byval as HANDLE, byval as LPMODULEENTRY32W) as BOOL
declare function Module32Next alias "Module32NextW" (byval as HANDLE, byval as LPMODULEENTRY32W) as BOOL
declare function Process32First alias "Process32FirstW" (byval as HANDLE, byval as LPPROCESSENTRY32W) as BOOL

declare function Process32Next alias "Process32NextW" (byval as HANDLE, byval as LPPROCESSENTRY32W) as BOOL
#else ''UNICODE
declare function Module32First alias "Module32First" (byval as HANDLE, byval as LPMODULEENTRY32) as BOOL
declare function Module32Next alias "Module32Next" (byval as HANDLE, byval as LPMODULEENTRY32) as BOOL
declare function Process32First alias "Process32First" (byval as HANDLE, byval as LPPROCESSENTRY32) as BOOL
declare function Process32Next alias "Process32Next" (byval as HANDLE, byval as LPPROCESSENTRY32) as BOOL
#endif ''UNICODE

#endif
