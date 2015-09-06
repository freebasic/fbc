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

#inclib "kernel32"

extern "Windows"

#define _INC_TOOLHELP32
const MAX_MODULE_NAME32 = 255
declare function CreateToolhelp32Snapshot(byval dwFlags as DWORD, byval th32ProcessID as DWORD) as HANDLE
const TH32CS_SNAPHEAPLIST = &h00000001
const TH32CS_SNAPPROCESS = &h00000002
const TH32CS_SNAPTHREAD = &h00000004
const TH32CS_SNAPMODULE = &h00000008
const TH32CS_SNAPMODULE32 = &h00000010
const TH32CS_SNAPALL = ((TH32CS_SNAPHEAPLIST or TH32CS_SNAPPROCESS) or TH32CS_SNAPTHREAD) or TH32CS_SNAPMODULE
const TH32CS_INHERIT = &h80000000

type tagHEAPLIST32
	dwSize as SIZE_T_
	th32ProcessID as DWORD
	th32HeapID as ULONG_PTR
	dwFlags as DWORD
end type

type HEAPLIST32 as tagHEAPLIST32
type PHEAPLIST32 as HEAPLIST32 ptr
type LPHEAPLIST32 as HEAPLIST32 ptr
const HF32_DEFAULT = 1
const HF32_SHARED = 2
declare function Heap32ListFirst(byval hSnapshot as HANDLE, byval lphl as LPHEAPLIST32) as WINBOOL
declare function Heap32ListNext(byval hSnapshot as HANDLE, byval lphl as LPHEAPLIST32) as WINBOOL

type tagHEAPENTRY32
	dwSize as SIZE_T_
	hHandle as HANDLE
	dwAddress as ULONG_PTR
	dwBlockSize as SIZE_T_
	dwFlags as DWORD
	dwLockCount as DWORD
	dwResvd as DWORD
	th32ProcessID as DWORD
	th32HeapID as ULONG_PTR
end type

type HEAPENTRY32 as tagHEAPENTRY32
type PHEAPENTRY32 as HEAPENTRY32 ptr
type LPHEAPENTRY32 as HEAPENTRY32 ptr

const LF32_FIXED = &h00000001
const LF32_FREE = &h00000002
const LF32_MOVEABLE = &h00000004

declare function Heap32First(byval lphe as LPHEAPENTRY32, byval th32ProcessID as DWORD, byval th32HeapID as ULONG_PTR) as WINBOOL
declare function Heap32Next(byval lphe as LPHEAPENTRY32) as WINBOOL
declare function Toolhelp32ReadProcessMemory(byval th32ProcessID as DWORD, byval lpBaseAddress as LPCVOID, byval lpBuffer as LPVOID, byval cbRead as SIZE_T_, byval lpNumberOfBytesRead as SIZE_T_ ptr) as WINBOOL

type tagPROCESSENTRY32W
	dwSize as DWORD
	cntUsage as DWORD
	th32ProcessID as DWORD
	th32DefaultHeapID as ULONG_PTR
	th32ModuleID as DWORD
	cntThreads as DWORD
	th32ParentProcessID as DWORD
	pcPriClassBase as LONG
	dwFlags as DWORD
	szExeFile as wstring * 260
end type

type PROCESSENTRY32W as tagPROCESSENTRY32W
type PPROCESSENTRY32W as PROCESSENTRY32W ptr
type LPPROCESSENTRY32W as PROCESSENTRY32W ptr
declare function Process32FirstW(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32W) as WINBOOL
declare function Process32NextW(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32W) as WINBOOL

type tagPROCESSENTRY32A alias "tagPROCESSENTRY32"
	dwSize as DWORD
	cntUsage as DWORD
	th32ProcessID as DWORD
	th32DefaultHeapID as ULONG_PTR
	th32ModuleID as DWORD
	cntThreads as DWORD
	th32ParentProcessID as DWORD
	pcPriClassBase as LONG
	dwFlags as DWORD
	szExeFile as zstring * 260
end type

type PROCESSENTRY32A as tagPROCESSENTRY32A '' alias "PROCESSENTRY32"
type PPROCESSENTRY32A as PROCESSENTRY32A ptr '' alias "PPROCESSENTRY32"
type LPPROCESSENTRY32A as PROCESSENTRY32A ptr '' alias "LPPROCESSENTRY32"
declare function Process32FirstA alias "Process32First"(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32A) as WINBOOL
declare function Process32NextA alias "Process32Next"(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32A) as WINBOOL

#ifdef UNICODE
	declare function Process32First alias "Process32FirstW"(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32W) as WINBOOL
	declare function Process32Next alias "Process32NextW"(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32W) as WINBOOL
	type PROCESSENTRY32 as PROCESSENTRY32W
	type PPROCESSENTRY32 as PPROCESSENTRY32W
	type LPPROCESSENTRY32 as LPPROCESSENTRY32W
#else
	declare function Process32First(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32A) as WINBOOL
	declare function Process32Next(byval hSnapshot as HANDLE, byval lppe as LPPROCESSENTRY32A) as WINBOOL
	type PROCESSENTRY32 as PROCESSENTRY32A
	type PPROCESSENTRY32 as PPROCESSENTRY32A
	type LPPROCESSENTRY32 as LPPROCESSENTRY32A
#endif

type tagTHREADENTRY32
	dwSize as DWORD
	cntUsage as DWORD
	th32ThreadID as DWORD
	th32OwnerProcessID as DWORD
	tpBasePri as LONG
	tpDeltaPri as LONG
	dwFlags as DWORD
end type

type THREADENTRY32 as tagTHREADENTRY32
type PTHREADENTRY32 as THREADENTRY32 ptr
type LPTHREADENTRY32 as THREADENTRY32 ptr
declare function Thread32First(byval hSnapshot as HANDLE, byval lpte as LPTHREADENTRY32) as WINBOOL
declare function Thread32Next(byval hSnapshot as HANDLE, byval lpte as LPTHREADENTRY32) as WINBOOL

type tagMODULEENTRY32W
	dwSize as DWORD
	th32ModuleID as DWORD
	th32ProcessID as DWORD
	GlblcntUsage as DWORD
	ProccntUsage as DWORD
	modBaseAddr as UBYTE ptr
	modBaseSize as DWORD
	hModule as HMODULE
	szModule as wstring * 255 + 1
	szExePath as wstring * 260
end type

type MODULEENTRY32W as tagMODULEENTRY32W
type PMODULEENTRY32W as MODULEENTRY32W ptr
type LPMODULEENTRY32W as MODULEENTRY32W ptr
declare function Module32FirstW(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32W) as WINBOOL
declare function Module32NextW(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32W) as WINBOOL

type tagMODULEENTRY32A alias "tagMODULEENTRY32"
	dwSize as DWORD
	th32ModuleID as DWORD
	th32ProcessID as DWORD
	GlblcntUsage as DWORD
	ProccntUsage as DWORD
	modBaseAddr as UBYTE ptr
	modBaseSize as DWORD
	hModule as HMODULE
	szModule as zstring * 255 + 1
	szExePath as zstring * 260
end type

type MODULEENTRY32A as tagMODULEENTRY32A '' alias "MODULEENTRY32"
type PMODULEENTRY32A as MODULEENTRY32A ptr '' alias "PMODULEENTRY32"
type LPMODULEENTRY32A as MODULEENTRY32A ptr '' alias "LPMODULEENTRY32"
declare function Module32FirstA alias "Module32First"(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32A) as WINBOOL
declare function Module32NextA alias "Module32Next"(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32A) as WINBOOL

#ifdef UNICODE
	declare function Module32First alias "Module32FirstW"(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32W) as WINBOOL
	declare function Module32Next alias "Module32NextW"(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32W) as WINBOOL
	type MODULEENTRY32 as MODULEENTRY32W
	type PMODULEENTRY32 as PMODULEENTRY32W
	type LPMODULEENTRY32 as LPMODULEENTRY32W
#else
	declare function Module32First(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32A) as WINBOOL
	declare function Module32Next(byval hSnapshot as HANDLE, byval lpme as LPMODULEENTRY32A) as WINBOOL
	type MODULEENTRY32 as MODULEENTRY32A
	type PMODULEENTRY32 as PMODULEENTRY32A
	type LPMODULEENTRY32 as LPMODULEENTRY32A
#endif

end extern
