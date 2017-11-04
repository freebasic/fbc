'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "kernel32"

#include once "_mingw_unicode.bi"
#include once "intrin.bi"
#include once "winapifamily.bi"
#include once "apiset.bi"
#include once "winerror.bi"

'' The following symbols have been renamed:
''     procedure Sleep => Sleep_
''     procedure Beep => Beep_
''     constant GHND => GHND_
''     constant GPTR => GPTR_

extern "Windows"

#define _WINBASE_
#define _MINWINBASE_
#define MoveMemory RtlMoveMemory
#define CopyMemory RtlCopyMemory
#define FillMemory RtlFillMemory
#define ZeroMemory RtlZeroMemory

type _SECURITY_ATTRIBUTES
	nLength as DWORD
	lpSecurityDescriptor as LPVOID
	bInheritHandle as WINBOOL
end type

type SECURITY_ATTRIBUTES as _SECURITY_ATTRIBUTES
type PSECURITY_ATTRIBUTES as _SECURITY_ATTRIBUTES ptr
type LPSECURITY_ATTRIBUTES as _SECURITY_ATTRIBUTES ptr

type _OVERLAPPED
	Internal as ULONG_PTR
	InternalHigh as ULONG_PTR

	union
		type
			Offset as DWORD
			OffsetHigh as DWORD
		end type

		Pointer as PVOID
	end union

	hEvent as HANDLE
end type

type OVERLAPPED as _OVERLAPPED
type LPOVERLAPPED as _OVERLAPPED ptr

type _OVERLAPPED_ENTRY
	lpCompletionKey as ULONG_PTR
	lpOverlapped as LPOVERLAPPED
	Internal as ULONG_PTR
	dwNumberOfBytesTransferred as DWORD
end type

type OVERLAPPED_ENTRY as _OVERLAPPED_ENTRY
type LPOVERLAPPED_ENTRY as _OVERLAPPED_ENTRY ptr
#define _SYSTEMTIME_

type _SYSTEMTIME
	wYear as WORD
	wMonth as WORD
	wDayOfWeek as WORD
	wDay as WORD
	wHour as WORD
	wMinute as WORD
	wSecond as WORD
	wMilliseconds as WORD
end type

type SYSTEMTIME as _SYSTEMTIME
type PSYSTEMTIME as _SYSTEMTIME ptr
type LPSYSTEMTIME as _SYSTEMTIME ptr

type _WIN32_FIND_DATAA
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	dwReserved0 as DWORD
	dwReserved1 as DWORD
	cFileName as zstring * 260
	cAlternateFileName as zstring * 14
end type

type WIN32_FIND_DATAA as _WIN32_FIND_DATAA
type PWIN32_FIND_DATAA as _WIN32_FIND_DATAA ptr
type LPWIN32_FIND_DATAA as _WIN32_FIND_DATAA ptr

type _WIN32_FIND_DATAW
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	dwReserved0 as DWORD
	dwReserved1 as DWORD
	cFileName as wstring * 260
	cAlternateFileName as wstring * 14
end type

type WIN32_FIND_DATAW as _WIN32_FIND_DATAW
type PWIN32_FIND_DATAW as _WIN32_FIND_DATAW ptr
type LPWIN32_FIND_DATAW as _WIN32_FIND_DATAW ptr

#ifdef UNICODE
	type WIN32_FIND_DATA as WIN32_FIND_DATAW
	type PWIN32_FIND_DATA as PWIN32_FIND_DATAW
	type LPWIN32_FIND_DATA as LPWIN32_FIND_DATAW
#else
	type WIN32_FIND_DATA as WIN32_FIND_DATAA
	type PWIN32_FIND_DATA as PWIN32_FIND_DATAA
	type LPWIN32_FIND_DATA as LPWIN32_FIND_DATAA
#endif

type _FINDEX_INFO_LEVELS as long
enum
	FindExInfoStandard
	FindExInfoBasic
	FindExInfoMaxInfoLevel
end enum

type FINDEX_INFO_LEVELS as _FINDEX_INFO_LEVELS
const FIND_FIRST_EX_CASE_SENSITIVE = &h00000001
const FIND_FIRST_EX_LARGE_FETCH = &h00000002

type _FINDEX_SEARCH_OPS as long
enum
	FindExSearchNameMatch
	FindExSearchLimitToDirectories
	FindExSearchLimitToDevices
	FindExSearchMaxSearchOp
end enum

type FINDEX_SEARCH_OPS as _FINDEX_SEARCH_OPS

type _GET_FILEEX_INFO_LEVELS as long
enum
	GetFileExInfoStandard
	GetFileExMaxInfoLevel
end enum

type GET_FILEEX_INFO_LEVELS as _GET_FILEEX_INFO_LEVELS

#if _WIN32_WINNT >= &h0600
	type _FILE_INFO_BY_HANDLE_CLASS as long
	enum
		FileBasicInfo
		FileStandardInfo
		FileNameInfo
		FileRenameInfo
		FileDispositionInfo
		FileAllocationInfo
		FileEndOfFileInfo
		FileStreamInfo
		FileCompressionInfo
		FileAttributeTagInfo
		FileIdBothDirectoryInfo
		FileIdBothDirectoryRestartInfo
		FileIoPriorityHintInfo
		FileRemoteProtocolInfo
		FileFullDirectoryInfo
		FileFullDirectoryRestartInfo

		#if _WIN32_WINNT = &h0602
			FileStorageInfo
			FileAlignmentInfo
			FileIdInfo
			FileIdExtdDirectoryInfo
			FileIdExtdDirectoryRestartInfo
		#endif

		MaximumFileInfoByHandleClass
	end enum

	type FILE_INFO_BY_HANDLE_CLASS as _FILE_INFO_BY_HANDLE_CLASS
	type PFILE_INFO_BY_HANDLE_CLASS as _FILE_INFO_BY_HANDLE_CLASS ptr
#endif

type CRITICAL_SECTION as RTL_CRITICAL_SECTION
type PCRITICAL_SECTION as PRTL_CRITICAL_SECTION
type LPCRITICAL_SECTION as PRTL_CRITICAL_SECTION
type CRITICAL_SECTION_DEBUG as RTL_CRITICAL_SECTION_DEBUG
type PCRITICAL_SECTION_DEBUG as PRTL_CRITICAL_SECTION_DEBUG
type LPCRITICAL_SECTION_DEBUG as PRTL_CRITICAL_SECTION_DEBUG
type LPOVERLAPPED_COMPLETION_ROUTINE as sub(byval dwErrorCode as DWORD, byval dwNumberOfBytesTransfered as DWORD, byval lpOverlapped as LPOVERLAPPED)
const LOCKFILE_FAIL_IMMEDIATELY = &h1
const LOCKFILE_EXCLUSIVE_LOCK = &h2

type _PROCESS_HEAP_ENTRY_Block
	hMem as HANDLE
	dwReserved(0 to 2) as DWORD
end type

type _PROCESS_HEAP_ENTRY_Region
	dwCommittedSize as DWORD
	dwUnCommittedSize as DWORD
	lpFirstBlock as LPVOID
	lpLastBlock as LPVOID
end type

type _PROCESS_HEAP_ENTRY
	lpData as PVOID
	cbData as DWORD
	cbOverhead as UBYTE
	iRegionIndex as UBYTE
	wFlags as WORD

	union
		Block as _PROCESS_HEAP_ENTRY_Block
		Region as _PROCESS_HEAP_ENTRY_Region
	end union
end type

type PROCESS_HEAP_ENTRY as _PROCESS_HEAP_ENTRY
type LPPROCESS_HEAP_ENTRY as _PROCESS_HEAP_ENTRY ptr
type PPROCESS_HEAP_ENTRY as _PROCESS_HEAP_ENTRY ptr

const PROCESS_HEAP_REGION = &h1
const PROCESS_HEAP_UNCOMMITTED_RANGE = &h2
const PROCESS_HEAP_ENTRY_BUSY = &h4
const PROCESS_HEAP_ENTRY_MOVEABLE = &h10
const PROCESS_HEAP_ENTRY_DDESHARE = &h20

type _REASON_CONTEXT_Reason_Detailed
	LocalizedReasonModule as HMODULE
	LocalizedReasonId as ULONG
	ReasonStringCount as ULONG
	ReasonStrings as LPWSTR ptr
end type

union _REASON_CONTEXT_Reason
	Detailed as _REASON_CONTEXT_Reason_Detailed
	SimpleReasonString as LPWSTR
end union

type _REASON_CONTEXT
	Version as ULONG
	Flags as DWORD
	Reason as _REASON_CONTEXT_Reason
end type

type REASON_CONTEXT as _REASON_CONTEXT
type PREASON_CONTEXT as _REASON_CONTEXT ptr
const EXCEPTION_DEBUG_EVENT = 1
const CREATE_THREAD_DEBUG_EVENT = 2
const CREATE_PROCESS_DEBUG_EVENT = 3
const EXIT_THREAD_DEBUG_EVENT = 4
const EXIT_PROCESS_DEBUG_EVENT = 5
const LOAD_DLL_DEBUG_EVENT = 6
const UNLOAD_DLL_DEBUG_EVENT = 7
const OUTPUT_DEBUG_STRING_EVENT = 8
const RIP_EVENT = 9
type PTHREAD_START_ROUTINE as function(byval lpThreadParameter as LPVOID) as DWORD
type LPTHREAD_START_ROUTINE as PTHREAD_START_ROUTINE

type _EXCEPTION_DEBUG_INFO
	ExceptionRecord as EXCEPTION_RECORD
	dwFirstChance as DWORD
end type

type EXCEPTION_DEBUG_INFO as _EXCEPTION_DEBUG_INFO
type LPEXCEPTION_DEBUG_INFO as _EXCEPTION_DEBUG_INFO ptr

type _CREATE_THREAD_DEBUG_INFO
	hThread as HANDLE
	lpThreadLocalBase as LPVOID
	lpStartAddress as LPTHREAD_START_ROUTINE
end type

type CREATE_THREAD_DEBUG_INFO as _CREATE_THREAD_DEBUG_INFO
type LPCREATE_THREAD_DEBUG_INFO as _CREATE_THREAD_DEBUG_INFO ptr

type _CREATE_PROCESS_DEBUG_INFO
	hFile as HANDLE
	hProcess as HANDLE
	hThread as HANDLE
	lpBaseOfImage as LPVOID
	dwDebugInfoFileOffset as DWORD
	nDebugInfoSize as DWORD
	lpThreadLocalBase as LPVOID
	lpStartAddress as LPTHREAD_START_ROUTINE
	lpImageName as LPVOID
	fUnicode as WORD
end type

type CREATE_PROCESS_DEBUG_INFO as _CREATE_PROCESS_DEBUG_INFO
type LPCREATE_PROCESS_DEBUG_INFO as _CREATE_PROCESS_DEBUG_INFO ptr

type _EXIT_THREAD_DEBUG_INFO
	dwExitCode as DWORD
end type

type EXIT_THREAD_DEBUG_INFO as _EXIT_THREAD_DEBUG_INFO
type LPEXIT_THREAD_DEBUG_INFO as _EXIT_THREAD_DEBUG_INFO ptr

type _EXIT_PROCESS_DEBUG_INFO
	dwExitCode as DWORD
end type

type EXIT_PROCESS_DEBUG_INFO as _EXIT_PROCESS_DEBUG_INFO
type LPEXIT_PROCESS_DEBUG_INFO as _EXIT_PROCESS_DEBUG_INFO ptr

type _LOAD_DLL_DEBUG_INFO
	hFile as HANDLE
	lpBaseOfDll as LPVOID
	dwDebugInfoFileOffset as DWORD
	nDebugInfoSize as DWORD
	lpImageName as LPVOID
	fUnicode as WORD
end type

type LOAD_DLL_DEBUG_INFO as _LOAD_DLL_DEBUG_INFO
type LPLOAD_DLL_DEBUG_INFO as _LOAD_DLL_DEBUG_INFO ptr

type _UNLOAD_DLL_DEBUG_INFO
	lpBaseOfDll as LPVOID
end type

type UNLOAD_DLL_DEBUG_INFO as _UNLOAD_DLL_DEBUG_INFO
type LPUNLOAD_DLL_DEBUG_INFO as _UNLOAD_DLL_DEBUG_INFO ptr

type _OUTPUT_DEBUG_STRING_INFO
	lpDebugStringData as LPSTR
	fUnicode as WORD
	nDebugStringLength as WORD
end type

type OUTPUT_DEBUG_STRING_INFO as _OUTPUT_DEBUG_STRING_INFO
type LPOUTPUT_DEBUG_STRING_INFO as _OUTPUT_DEBUG_STRING_INFO ptr

type _RIP_INFO
	dwError as DWORD
	dwType as DWORD
end type

type RIP_INFO as _RIP_INFO
type LPRIP_INFO as _RIP_INFO ptr

union _DEBUG_EVENT_u
	Exception as EXCEPTION_DEBUG_INFO
	CreateThread as CREATE_THREAD_DEBUG_INFO
	CreateProcessInfo as CREATE_PROCESS_DEBUG_INFO
	ExitThread as EXIT_THREAD_DEBUG_INFO
	ExitProcess as EXIT_PROCESS_DEBUG_INFO
	LoadDll as LOAD_DLL_DEBUG_INFO
	UnloadDll as UNLOAD_DLL_DEBUG_INFO
	DebugString as OUTPUT_DEBUG_STRING_INFO
	RipInfo as RIP_INFO
end union

type _DEBUG_EVENT
	dwDebugEventCode as DWORD
	dwProcessId as DWORD
	dwThreadId as DWORD
	u as _DEBUG_EVENT_u
end type

type DEBUG_EVENT as _DEBUG_EVENT
type LPDEBUG_EVENT as _DEBUG_EVENT ptr
type LPCONTEXT as PCONTEXT

const STILL_ACTIVE = STATUS_PENDING
const EXCEPTION_ACCESS_VIOLATION = STATUS_ACCESS_VIOLATION
const EXCEPTION_DATATYPE_MISALIGNMENT = STATUS_DATATYPE_MISALIGNMENT
const EXCEPTION_BREAKPOINT = STATUS_BREAKPOINT
const EXCEPTION_SINGLE_STEP = STATUS_SINGLE_STEP
const EXCEPTION_ARRAY_BOUNDS_EXCEEDED = STATUS_ARRAY_BOUNDS_EXCEEDED
const EXCEPTION_FLT_DENORMAL_OPERAND = STATUS_FLOAT_DENORMAL_OPERAND
const EXCEPTION_FLT_DIVIDE_BY_ZERO = STATUS_FLOAT_DIVIDE_BY_ZERO
const EXCEPTION_FLT_INEXACT_RESULT = STATUS_FLOAT_INEXACT_RESULT
const EXCEPTION_FLT_INVALID_OPERATION = STATUS_FLOAT_INVALID_OPERATION
const EXCEPTION_FLT_OVERFLOW = STATUS_FLOAT_OVERFLOW
const EXCEPTION_FLT_STACK_CHECK = STATUS_FLOAT_STACK_CHECK
const EXCEPTION_FLT_UNDERFLOW = STATUS_FLOAT_UNDERFLOW
const EXCEPTION_INT_DIVIDE_BY_ZERO = STATUS_INTEGER_DIVIDE_BY_ZERO
const EXCEPTION_INT_OVERFLOW = STATUS_INTEGER_OVERFLOW
const EXCEPTION_PRIV_INSTRUCTION = STATUS_PRIVILEGED_INSTRUCTION
const EXCEPTION_IN_PAGE_ERROR = STATUS_IN_PAGE_ERROR
const EXCEPTION_ILLEGAL_INSTRUCTION = STATUS_ILLEGAL_INSTRUCTION
const EXCEPTION_NONCONTINUABLE_EXCEPTION = STATUS_NONCONTINUABLE_EXCEPTION
const EXCEPTION_STACK_OVERFLOW = STATUS_STACK_OVERFLOW
const EXCEPTION_INVALID_DISPOSITION = STATUS_INVALID_DISPOSITION
const EXCEPTION_GUARD_PAGE = STATUS_GUARD_PAGE_VIOLATION
const EXCEPTION_INVALID_HANDLE = STATUS_INVALID_HANDLE
#define EXCEPTION_POSSIBLE_DEADLOCK STATUS_POSSIBLE_DEADLOCK
const CONTROL_C_EXIT = STATUS_CONTROL_C_EXIT
const LMEM_FIXED = &h0
const LMEM_MOVEABLE = &h2
const LMEM_NOCOMPACT = &h10
const LMEM_NODISCARD = &h20
const LMEM_ZEROINIT = &h40
const LMEM_MODIFY = &h80
const LMEM_DISCARDABLE = &hf00
const LMEM_VALID_FLAGS = &hf72
const LMEM_INVALID_HANDLE = &h8000
const LHND = LMEM_MOVEABLE or LMEM_ZEROINIT
const LPTR = LMEM_FIXED or LMEM_ZEROINIT
const NONZEROLHND = LMEM_MOVEABLE
const NONZEROLPTR = LMEM_FIXED
#define LocalDiscard(h) LocalReAlloc((h), 0, LMEM_MOVEABLE)
const LMEM_DISCARDED = &h4000
const LMEM_LOCKCOUNT = &hff
#define _BEM_H_

type CONTRACT_DESCRIPTION as _CONTRACT_DESCRIPTION
type BEM_REFERENCE as _BEM_REFERENCE
type BEM_FREE_INTERFACE_CALLBACK as sub(byval interfaceInstance as any ptr)

declare function BemCreateReference(byval iid as const GUID const ptr, byval interfaceInstance as any ptr, byval freeCallback as BEM_FREE_INTERFACE_CALLBACK, byval reference as BEM_REFERENCE ptr ptr) as HRESULT
declare function BemCreateContractFrom(byval dllPath as LPCWSTR, byval extensionId as const GUID const ptr, byval contractDescription as const CONTRACT_DESCRIPTION ptr, byval hostContract as any ptr, byval contract as any ptr ptr) as HRESULT
declare function BemCopyReference(byval reference as BEM_REFERENCE ptr, byval copiedReference as BEM_REFERENCE ptr ptr) as HRESULT
declare sub BemFreeReference(byval reference as BEM_REFERENCE ptr)
declare sub BemFreeContract(byval contract as any ptr)
#define _APISETDEBUG_
declare function IsDebuggerPresent() as WINBOOL
declare sub OutputDebugStringA(byval lpOutputString as LPCSTR)
declare sub OutputDebugStringW(byval lpOutputString as LPCWSTR)

#ifdef UNICODE
	declare sub OutputDebugString alias "OutputDebugStringW"(byval lpOutputString as LPCWSTR)
#else
	declare sub OutputDebugString alias "OutputDebugStringA"(byval lpOutputString as LPCSTR)
#endif

declare sub DebugBreak()
declare function ContinueDebugEvent(byval dwProcessId as DWORD, byval dwThreadId as DWORD, byval dwContinueStatus as DWORD) as WINBOOL
declare function WaitForDebugEvent(byval lpDebugEvent as LPDEBUG_EVENT, byval dwMilliseconds as DWORD) as WINBOOL
declare function DebugActiveProcess(byval dwProcessId as DWORD) as WINBOOL
declare function DebugActiveProcessStop(byval dwProcessId as DWORD) as WINBOOL
declare function CheckRemoteDebuggerPresent(byval hProcess as HANDLE, byval pbDebuggerPresent as PBOOL) as WINBOOL
#define _ERRHANDLING_H_
type PTOP_LEVEL_EXCEPTION_FILTER as function(byval ExceptionInfo as _EXCEPTION_POINTERS ptr) as LONG
type LPTOP_LEVEL_EXCEPTION_FILTER as PTOP_LEVEL_EXCEPTION_FILTER
declare function UnhandledExceptionFilter(byval ExceptionInfo as _EXCEPTION_POINTERS ptr) as LONG
declare function SetUnhandledExceptionFilter(byval lpTopLevelExceptionFilter as LPTOP_LEVEL_EXCEPTION_FILTER) as LPTOP_LEVEL_EXCEPTION_FILTER
declare function SetErrorMode(byval uMode as UINT) as UINT
declare function AddVectoredExceptionHandler(byval First as ULONG, byval Handler as PVECTORED_EXCEPTION_HANDLER) as PVOID
declare function RemoveVectoredExceptionHandler(byval Handle as PVOID) as ULONG
declare function AddVectoredContinueHandler(byval First as ULONG, byval Handler as PVECTORED_EXCEPTION_HANDLER) as PVOID
declare function RemoveVectoredContinueHandler(byval Handle as PVOID) as ULONG

#if _WIN32_WINNT >= &h0600
	declare function GetErrorMode() as UINT
#endif

declare sub RaiseException(byval dwExceptionCode as DWORD, byval dwExceptionFlags as DWORD, byval nNumberOfArguments as DWORD, byval lpArguments as const ULONG_PTR ptr)
declare function GetLastError() as DWORD
declare sub SetLastError(byval dwErrCode as DWORD)
#define _FIBERS_H_

#if _WIN32_WINNT >= &h0600
	const FLS_OUT_OF_INDEXES = cast(DWORD, &hffffffff)
	declare function FlsAlloc(byval lpCallback as PFLS_CALLBACK_FUNCTION) as DWORD
	declare function FlsGetValue(byval dwFlsIndex as DWORD) as PVOID
	declare function FlsSetValue(byval dwFlsIndex as DWORD, byval lpFlsData as PVOID) as WINBOOL
	declare function FlsFree(byval dwFlsIndex as DWORD) as WINBOOL
	declare function IsThreadAFiber() as WINBOOL
#endif

#define _APISETFILE_
const CREATE_NEW = 1
const CREATE_ALWAYS = 2
const OPEN_EXISTING = 3
const OPEN_ALWAYS = 4
const TRUNCATE_EXISTING = 5
const INVALID_FILE_SIZE = cast(DWORD, &hffffffff)
const INVALID_SET_FILE_POINTER = cast(DWORD, -1)
const INVALID_FILE_ATTRIBUTES = cast(DWORD, -1)

type _BY_HANDLE_FILE_INFORMATION
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	dwVolumeSerialNumber as DWORD
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	nNumberOfLinks as DWORD
	nFileIndexHigh as DWORD
	nFileIndexLow as DWORD
end type

type BY_HANDLE_FILE_INFORMATION as _BY_HANDLE_FILE_INFORMATION
type PBY_HANDLE_FILE_INFORMATION as _BY_HANDLE_FILE_INFORMATION ptr
type LPBY_HANDLE_FILE_INFORMATION as _BY_HANDLE_FILE_INFORMATION ptr

declare function CompareFileTime(byval lpFileTime1 as const FILETIME ptr, byval lpFileTime2 as const FILETIME ptr) as LONG
declare function CreateFileA(byval lpFileName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE) as HANDLE
declare function CreateFileW(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE) as HANDLE
declare function DefineDosDeviceW(byval dwFlags as DWORD, byval lpDeviceName as LPCWSTR, byval lpTargetPath as LPCWSTR) as WINBOOL
declare function DeleteVolumeMountPointW(byval lpszVolumeMountPoint as LPCWSTR) as WINBOOL
declare function FileTimeToLocalFileTime(byval lpFileTime as const FILETIME ptr, byval lpLocalFileTime as LPFILETIME) as WINBOOL
declare function FindCloseChangeNotification(byval hChangeHandle as HANDLE) as WINBOOL
declare function FindFirstChangeNotificationA(byval lpPathName as LPCSTR, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD) as HANDLE
declare function FindFirstChangeNotificationW(byval lpPathName as LPCWSTR, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD) as HANDLE
declare function FindFirstFileA(byval lpFileName as LPCSTR, byval lpFindFileData as LPWIN32_FIND_DATAA) as HANDLE
declare function FindFirstFileW(byval lpFileName as LPCWSTR, byval lpFindFileData as LPWIN32_FIND_DATAW) as HANDLE
declare function FindFirstVolumeW(byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as HANDLE
declare function FindNextChangeNotification(byval hChangeHandle as HANDLE) as WINBOOL
declare function FindNextVolumeW(byval hFindVolume as HANDLE, byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function FindVolumeClose(byval hFindVolume as HANDLE) as WINBOOL
declare function GetDiskFreeSpaceA(byval lpRootPathName as LPCSTR, byval lpSectorsPerCluster as LPDWORD, byval lpBytesPerSector as LPDWORD, byval lpNumberOfFreeClusters as LPDWORD, byval lpTotalNumberOfClusters as LPDWORD) as WINBOOL
declare function GetDiskFreeSpaceW(byval lpRootPathName as LPCWSTR, byval lpSectorsPerCluster as LPDWORD, byval lpBytesPerSector as LPDWORD, byval lpNumberOfFreeClusters as LPDWORD, byval lpTotalNumberOfClusters as LPDWORD) as WINBOOL
declare function GetDriveTypeA(byval lpRootPathName as LPCSTR) as UINT
declare function GetDriveTypeW(byval lpRootPathName as LPCWSTR) as UINT
declare function GetFileAttributesA(byval lpFileName as LPCSTR) as DWORD
declare function GetFileAttributesW(byval lpFileName as LPCWSTR) as DWORD
declare function GetFileInformationByHandle(byval hFile as HANDLE, byval lpFileInformation as LPBY_HANDLE_FILE_INFORMATION) as WINBOOL
declare function GetFileSize(byval hFile as HANDLE, byval lpFileSizeHigh as LPDWORD) as DWORD
declare function GetFileSizeEx(byval hFile as HANDLE, byval lpFileSize as PLARGE_INTEGER) as WINBOOL
declare function GetFileTime(byval hFile as HANDLE, byval lpCreationTime as LPFILETIME, byval lpLastAccessTime as LPFILETIME, byval lpLastWriteTime as LPFILETIME) as WINBOOL
declare function GetFileType(byval hFile as HANDLE) as DWORD
declare function GetFullPathNameA(byval lpFileName as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr) as DWORD
declare function GetFullPathNameW(byval lpFileName as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr) as DWORD
declare function GetLogicalDrives() as DWORD
declare function GetLogicalDriveStringsW(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
declare function GetLongPathNameA(byval lpszShortPath as LPCSTR, byval lpszLongPath as LPSTR, byval cchBuffer as DWORD) as DWORD
declare function GetLongPathNameW(byval lpszShortPath as LPCWSTR, byval lpszLongPath as LPWSTR, byval cchBuffer as DWORD) as DWORD
declare function GetShortPathNameW(byval lpszLongPath as LPCWSTR, byval lpszShortPath as LPWSTR, byval cchBuffer as DWORD) as DWORD
declare function GetTempFileNameW(byval lpPathName as LPCWSTR, byval lpPrefixString as LPCWSTR, byval uUnique as UINT, byval lpTempFileName as LPWSTR) as UINT
declare function GetVolumeInformationW(byval lpRootPathName as LPCWSTR, byval lpVolumeNameBuffer as LPWSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPWSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
declare function GetVolumePathNameW(byval lpszFileName as LPCWSTR, byval lpszVolumePathName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function LocalFileTimeToFileTime(byval lpLocalFileTime as const FILETIME ptr, byval lpFileTime as LPFILETIME) as WINBOOL
declare function LockFile(byval hFile as HANDLE, byval dwFileOffsetLow as DWORD, byval dwFileOffsetHigh as DWORD, byval nNumberOfBytesToLockLow as DWORD, byval nNumberOfBytesToLockHigh as DWORD) as WINBOOL
declare function QueryDosDeviceW(byval lpDeviceName as LPCWSTR, byval lpTargetPath as LPWSTR, byval ucchMax as DWORD) as DWORD
declare function ReadFileEx(byval hFile as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPOVERLAPPED_COMPLETION_ROUTINE) as WINBOOL
declare function ReadFileScatter(byval hFile as HANDLE, byval aSegmentArray as FILE_SEGMENT_ELEMENT ptr, byval nNumberOfBytesToRead as DWORD, byval lpReserved as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function SetFilePointer(byval hFile as HANDLE, byval lDistanceToMove as LONG, byval lpDistanceToMoveHigh as PLONG, byval dwMoveMethod as DWORD) as DWORD
declare function SetFileTime(byval hFile as HANDLE, byval lpCreationTime as const FILETIME ptr, byval lpLastAccessTime as const FILETIME ptr, byval lpLastWriteTime as const FILETIME ptr) as WINBOOL
declare function SetFileValidData(byval hFile as HANDLE, byval ValidDataLength as LONGLONG) as WINBOOL
declare function UnlockFile(byval hFile as HANDLE, byval dwFileOffsetLow as DWORD, byval dwFileOffsetHigh as DWORD, byval nNumberOfBytesToUnlockLow as DWORD, byval nNumberOfBytesToUnlockHigh as DWORD) as WINBOOL
declare function WriteFileEx(byval hFile as HANDLE, byval lpBuffer as LPCVOID, byval nNumberOfBytesToWrite as DWORD, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPOVERLAPPED_COMPLETION_ROUTINE) as WINBOOL
declare function WriteFileGather(byval hFile as HANDLE, byval aSegmentArray as FILE_SEGMENT_ELEMENT ptr, byval nNumberOfBytesToWrite as DWORD, byval lpReserved as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function GetTempPathW(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
declare function GetVolumeNameForVolumeMountPointW(byval lpszVolumeMountPoint as LPCWSTR, byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function GetVolumePathNamesForVolumeNameW(byval lpszVolumeName as LPCWSTR, byval lpszVolumePathNames as LPWCH, byval cchBufferLength as DWORD, byval lpcchReturnLength as PDWORD) as WINBOOL

#ifdef UNICODE
	declare function CreateFile alias "CreateFileW"(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE) as HANDLE
	declare function DefineDosDevice alias "DefineDosDeviceW"(byval dwFlags as DWORD, byval lpDeviceName as LPCWSTR, byval lpTargetPath as LPCWSTR) as WINBOOL
	declare function DeleteVolumeMountPoint alias "DeleteVolumeMountPointW"(byval lpszVolumeMountPoint as LPCWSTR) as WINBOOL
	declare function FindFirstVolume alias "FindFirstVolumeW"(byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as HANDLE
	declare function FindNextVolume alias "FindNextVolumeW"(byval hFindVolume as HANDLE, byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function GetLogicalDriveStrings alias "GetLogicalDriveStringsW"(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
	declare function GetShortPathName alias "GetShortPathNameW"(byval lpszLongPath as LPCWSTR, byval lpszShortPath as LPWSTR, byval cchBuffer as DWORD) as DWORD
	declare function GetTempFileName alias "GetTempFileNameW"(byval lpPathName as LPCWSTR, byval lpPrefixString as LPCWSTR, byval uUnique as UINT, byval lpTempFileName as LPWSTR) as UINT
	declare function GetVolumeInformation alias "GetVolumeInformationW"(byval lpRootPathName as LPCWSTR, byval lpVolumeNameBuffer as LPWSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPWSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
	declare function GetVolumePathName alias "GetVolumePathNameW"(byval lpszFileName as LPCWSTR, byval lpszVolumePathName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function QueryDosDevice alias "QueryDosDeviceW"(byval lpDeviceName as LPCWSTR, byval lpTargetPath as LPWSTR, byval ucchMax as DWORD) as DWORD
	declare function GetTempPath alias "GetTempPathW"(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
	declare function GetVolumeNameForVolumeMountPoint alias "GetVolumeNameForVolumeMountPointW"(byval lpszVolumeMountPoint as LPCWSTR, byval lpszVolumeName as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function GetVolumePathNamesForVolumeName alias "GetVolumePathNamesForVolumeNameW"(byval lpszVolumeName as LPCWSTR, byval lpszVolumePathNames as LPWCH, byval cchBufferLength as DWORD, byval lpcchReturnLength as PDWORD) as WINBOOL
	declare function FindFirstChangeNotification alias "FindFirstChangeNotificationW"(byval lpPathName as LPCWSTR, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD) as HANDLE
	declare function FindFirstFile alias "FindFirstFileW"(byval lpFileName as LPCWSTR, byval lpFindFileData as LPWIN32_FIND_DATAW) as HANDLE
	declare function GetDiskFreeSpace alias "GetDiskFreeSpaceW"(byval lpRootPathName as LPCWSTR, byval lpSectorsPerCluster as LPDWORD, byval lpBytesPerSector as LPDWORD, byval lpNumberOfFreeClusters as LPDWORD, byval lpTotalNumberOfClusters as LPDWORD) as WINBOOL
	declare function GetDriveType alias "GetDriveTypeW"(byval lpRootPathName as LPCWSTR) as UINT
	declare function GetFileAttributes alias "GetFileAttributesW"(byval lpFileName as LPCWSTR) as DWORD
	declare function GetFullPathName alias "GetFullPathNameW"(byval lpFileName as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr) as DWORD
	declare function GetLongPathName alias "GetLongPathNameW"(byval lpszShortPath as LPCWSTR, byval lpszLongPath as LPWSTR, byval cchBuffer as DWORD) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function GetFinalPathNameByHandleA(byval hFile as HANDLE, byval lpszFilePath as LPSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
	declare function GetFinalPathNameByHandleW(byval hFile as HANDLE, byval lpszFilePath as LPWSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
	declare function GetVolumeInformationByHandleW(byval hFile as HANDLE, byval lpVolumeNameBuffer as LPWSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPWSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
	declare function GetFinalPathNameByHandle alias "GetFinalPathNameByHandleW"(byval hFile as HANDLE, byval lpszFilePath as LPWSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
#elseif not defined(UNICODE)
	declare function CreateFile alias "CreateFileA"(byval lpFileName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE) as HANDLE
	declare function FindFirstChangeNotification alias "FindFirstChangeNotificationA"(byval lpPathName as LPCSTR, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD) as HANDLE
	declare function FindFirstFile alias "FindFirstFileA"(byval lpFileName as LPCSTR, byval lpFindFileData as LPWIN32_FIND_DATAA) as HANDLE
	declare function GetDiskFreeSpace alias "GetDiskFreeSpaceA"(byval lpRootPathName as LPCSTR, byval lpSectorsPerCluster as LPDWORD, byval lpBytesPerSector as LPDWORD, byval lpNumberOfFreeClusters as LPDWORD, byval lpTotalNumberOfClusters as LPDWORD) as WINBOOL
	declare function GetDriveType alias "GetDriveTypeA"(byval lpRootPathName as LPCSTR) as UINT
	declare function GetFileAttributes alias "GetFileAttributesA"(byval lpFileName as LPCSTR) as DWORD
	declare function GetFullPathName alias "GetFullPathNameA"(byval lpFileName as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr) as DWORD
	declare function GetLongPathName alias "GetLongPathNameA"(byval lpszShortPath as LPCSTR, byval lpszLongPath as LPSTR, byval cchBuffer as DWORD) as DWORD
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetFinalPathNameByHandleA(byval hFile as HANDLE, byval lpszFilePath as LPSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
	declare function GetFinalPathNameByHandleW(byval hFile as HANDLE, byval lpszFilePath as LPWSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
	declare function GetVolumeInformationByHandleW(byval hFile as HANDLE, byval lpVolumeNameBuffer as LPWSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPWSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
	declare function GetFinalPathNameByHandle alias "GetFinalPathNameByHandleA"(byval hFile as HANDLE, byval lpszFilePath as LPSTR, byval cchFilePath as DWORD, byval dwFlags as DWORD) as DWORD
#endif

type _WIN32_FILE_ATTRIBUTE_DATA
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
end type

type WIN32_FILE_ATTRIBUTE_DATA as _WIN32_FILE_ATTRIBUTE_DATA
type LPWIN32_FILE_ATTRIBUTE_DATA as _WIN32_FILE_ATTRIBUTE_DATA ptr

#if _WIN32_WINNT = &h0602
	type _CREATEFILE2_EXTENDED_PARAMETERS
		dwSize as DWORD
		dwFileAttributes as DWORD
		dwFileFlags as DWORD
		dwSecurityQosFlags as DWORD
		lpSecurityAttributes as LPSECURITY_ATTRIBUTES
		hTemplateFile as HANDLE
	end type

	type CREATEFILE2_EXTENDED_PARAMETERS as _CREATEFILE2_EXTENDED_PARAMETERS
	type PCREATEFILE2_EXTENDED_PARAMETERS as _CREATEFILE2_EXTENDED_PARAMETERS ptr
	type LPCREATEFILE2_EXTENDED_PARAMETERS as _CREATEFILE2_EXTENDED_PARAMETERS ptr
#endif

declare function CreateDirectoryA(byval lpPathName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
declare function CreateDirectoryW(byval lpPathName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
declare function DeleteFileA(byval lpFileName as LPCSTR) as WINBOOL
declare function DeleteFileW(byval lpFileName as LPCWSTR) as WINBOOL
declare function FindClose(byval hFindFile as HANDLE) as WINBOOL
declare function FindFirstFileExA(byval lpFileName as LPCSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD) as HANDLE
declare function FindFirstFileExW(byval lpFileName as LPCWSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD) as HANDLE
declare function FindNextFileA(byval hFindFile as HANDLE, byval lpFindFileData as LPWIN32_FIND_DATAA) as WINBOOL
declare function FindNextFileW(byval hFindFile as HANDLE, byval lpFindFileData as LPWIN32_FIND_DATAW) as WINBOOL
declare function FlushFileBuffers(byval hFile as HANDLE) as WINBOOL
declare function GetDiskFreeSpaceExA(byval lpDirectoryName as LPCSTR, byval lpFreeBytesAvailableToCaller as PULARGE_INTEGER, byval lpTotalNumberOfBytes as PULARGE_INTEGER, byval lpTotalNumberOfFreeBytes as PULARGE_INTEGER) as WINBOOL
declare function GetDiskFreeSpaceExW(byval lpDirectoryName as LPCWSTR, byval lpFreeBytesAvailableToCaller as PULARGE_INTEGER, byval lpTotalNumberOfBytes as PULARGE_INTEGER, byval lpTotalNumberOfFreeBytes as PULARGE_INTEGER) as WINBOOL
declare function GetFileAttributesExA(byval lpFileName as LPCSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID) as WINBOOL
declare function GetFileAttributesExW(byval lpFileName as LPCWSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID) as WINBOOL
declare function LockFileEx(byval hFile as HANDLE, byval dwFlags as DWORD, byval dwReserved as DWORD, byval nNumberOfBytesToLockLow as DWORD, byval nNumberOfBytesToLockHigh as DWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function ReadFile(byval hFile as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval lpNumberOfBytesRead as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function RemoveDirectoryA(byval lpPathName as LPCSTR) as WINBOOL
declare function RemoveDirectoryW(byval lpPathName as LPCWSTR) as WINBOOL
declare function SetEndOfFile(byval hFile as HANDLE) as WINBOOL
declare function SetFileAttributesA(byval lpFileName as LPCSTR, byval dwFileAttributes as DWORD) as WINBOOL
declare function SetFileAttributesW(byval lpFileName as LPCWSTR, byval dwFileAttributes as DWORD) as WINBOOL
declare function SetFilePointerEx(byval hFile as HANDLE, byval liDistanceToMove as LARGE_INTEGER, byval lpNewFilePointer as PLARGE_INTEGER, byval dwMoveMethod as DWORD) as WINBOOL
declare function UnlockFileEx(byval hFile as HANDLE, byval dwReserved as DWORD, byval nNumberOfBytesToUnlockLow as DWORD, byval nNumberOfBytesToUnlockHigh as DWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function WriteFile(byval hFile as HANDLE, byval lpBuffer as LPCVOID, byval nNumberOfBytesToWrite as DWORD, byval lpNumberOfBytesWritten as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL

#ifdef UNICODE
	declare function CreateDirectory alias "CreateDirectoryW"(byval lpPathName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
	declare function DeleteFile alias "DeleteFileW"(byval lpFileName as LPCWSTR) as WINBOOL
	declare function FindFirstFileEx alias "FindFirstFileExW"(byval lpFileName as LPCWSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD) as HANDLE
	declare function FindNextFile alias "FindNextFileW"(byval hFindFile as HANDLE, byval lpFindFileData as LPWIN32_FIND_DATAW) as WINBOOL
	declare function GetDiskFreeSpaceEx alias "GetDiskFreeSpaceExW"(byval lpDirectoryName as LPCWSTR, byval lpFreeBytesAvailableToCaller as PULARGE_INTEGER, byval lpTotalNumberOfBytes as PULARGE_INTEGER, byval lpTotalNumberOfFreeBytes as PULARGE_INTEGER) as WINBOOL
	declare function GetFileAttributesEx alias "GetFileAttributesExW"(byval lpFileName as LPCWSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID) as WINBOOL
	declare function RemoveDirectory alias "RemoveDirectoryW"(byval lpPathName as LPCWSTR) as WINBOOL
	declare function SetFileAttributes alias "SetFileAttributesW"(byval lpFileName as LPCWSTR, byval dwFileAttributes as DWORD) as WINBOOL

	#if _WIN32_WINNT >= &h0600
		declare function SetFileInformationByHandle(byval hFile as HANDLE, byval FileInformationClass as FILE_INFO_BY_HANDLE_CLASS, byval lpFileInformation as LPVOID, byval dwBufferSize as DWORD) as WINBOOL
	#endif
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	declare function CreateFile2(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval dwCreationDisposition as DWORD, byval pCreateExParams as LPCREATEFILE2_EXTENDED_PARAMETERS) as HANDLE
#elseif not defined(UNICODE)
	declare function CreateDirectory alias "CreateDirectoryA"(byval lpPathName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
	declare function DeleteFile alias "DeleteFileA"(byval lpFileName as LPCSTR) as WINBOOL
	declare function FindFirstFileEx alias "FindFirstFileExA"(byval lpFileName as LPCSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD) as HANDLE
	declare function FindNextFile alias "FindNextFileA"(byval hFindFile as HANDLE, byval lpFindFileData as LPWIN32_FIND_DATAA) as WINBOOL
	declare function GetDiskFreeSpaceEx alias "GetDiskFreeSpaceExA"(byval lpDirectoryName as LPCSTR, byval lpFreeBytesAvailableToCaller as PULARGE_INTEGER, byval lpTotalNumberOfBytes as PULARGE_INTEGER, byval lpTotalNumberOfFreeBytes as PULARGE_INTEGER) as WINBOOL
	declare function GetFileAttributesEx alias "GetFileAttributesExA"(byval lpFileName as LPCSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID) as WINBOOL
	declare function RemoveDirectory alias "RemoveDirectoryA"(byval lpPathName as LPCSTR) as WINBOOL
	declare function SetFileAttributes alias "SetFileAttributesA"(byval lpFileName as LPCSTR, byval dwFileAttributes as DWORD) as WINBOOL
#endif

#ifndef UNICODE
	#if _WIN32_WINNT >= &h0600
		declare function SetFileInformationByHandle(byval hFile as HANDLE, byval FileInformationClass as FILE_INFO_BY_HANDLE_CLASS, byval lpFileInformation as LPVOID, byval dwBufferSize as DWORD) as WINBOOL
	#endif

	#if _WIN32_WINNT = &h0602
		declare function CreateFile2(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval dwCreationDisposition as DWORD, byval pCreateExParams as LPCREATEFILE2_EXTENDED_PARAMETERS) as HANDLE
	#endif
#endif

#define _APISETHANDLE_
const INVALID_HANDLE_VALUE = cast(HANDLE, cast(LONG_PTR, -1))
declare function CloseHandle(byval hObject as HANDLE) as WINBOOL
declare function DuplicateHandle(byval hSourceProcessHandle as HANDLE, byval hSourceHandle as HANDLE, byval hTargetProcessHandle as HANDLE, byval lpTargetHandle as LPHANDLE, byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval dwOptions as DWORD) as WINBOOL
declare function GetHandleInformation(byval hObject as HANDLE, byval lpdwFlags as LPDWORD) as WINBOOL
declare function SetHandleInformation(byval hObject as HANDLE, byval dwMask as DWORD, byval dwFlags as DWORD) as WINBOOL
#define _HEAPAPI_H_

type _HEAP_SUMMARY
	cb as DWORD
	cbAllocated as SIZE_T_
	cbCommitted as SIZE_T_
	cbReserved as SIZE_T_
	cbMaxReserve as SIZE_T_
end type

type HEAP_SUMMARY as _HEAP_SUMMARY
type PHEAP_SUMMARY as _HEAP_SUMMARY ptr
type LPHEAP_SUMMARY as PHEAP_SUMMARY

declare function HeapCreate(byval flOptions as DWORD, byval dwInitialSize as SIZE_T_, byval dwMaximumSize as SIZE_T_) as HANDLE
declare function HeapDestroy(byval hHeap as HANDLE) as WINBOOL
declare function HeapValidate(byval hHeap as HANDLE, byval dwFlags as DWORD, byval lpMem as LPCVOID) as WINBOOL
declare function HeapCompact(byval hHeap as HANDLE, byval dwFlags as DWORD) as SIZE_T_
declare function HeapSummary(byval hHeap as HANDLE, byval dwFlags as DWORD, byval lpSummary as LPHEAP_SUMMARY) as WINBOOL
declare function GetProcessHeaps(byval NumberOfHeaps as DWORD, byval ProcessHeaps as PHANDLE) as DWORD
declare function HeapLock(byval hHeap as HANDLE) as WINBOOL
declare function HeapUnlock(byval hHeap as HANDLE) as WINBOOL
declare function HeapWalk(byval hHeap as HANDLE, byval lpEntry as LPPROCESS_HEAP_ENTRY) as WINBOOL
declare function HeapSetInformation(byval HeapHandle as HANDLE, byval HeapInformationClass as HEAP_INFORMATION_CLASS, byval HeapInformation as PVOID, byval HeapInformationLength as SIZE_T_) as WINBOOL
declare function HeapQueryInformation(byval HeapHandle as HANDLE, byval HeapInformationClass as HEAP_INFORMATION_CLASS, byval HeapInformation as PVOID, byval HeapInformationLength as SIZE_T_, byval ReturnLength as PSIZE_T) as WINBOOL
declare function HeapAlloc(byval hHeap as HANDLE, byval dwFlags as DWORD, byval dwBytes as SIZE_T_) as LPVOID
declare function HeapReAlloc(byval hHeap as HANDLE, byval dwFlags as DWORD, byval lpMem as LPVOID, byval dwBytes as SIZE_T_) as LPVOID
declare function HeapFree(byval hHeap as HANDLE, byval dwFlags as DWORD, byval lpMem as LPVOID) as WINBOOL
declare function HeapSize(byval hHeap as HANDLE, byval dwFlags as DWORD, byval lpMem as LPCVOID) as SIZE_T_
declare function GetProcessHeap() as HANDLE
#define _IO_APISET_H_
declare function GetOverlappedResult(byval hFile as HANDLE, byval lpOverlapped as LPOVERLAPPED, byval lpNumberOfBytesTransferred as LPDWORD, byval bWait as WINBOOL) as WINBOOL
declare function CreateIoCompletionPort(byval FileHandle as HANDLE, byval ExistingCompletionPort as HANDLE, byval CompletionKey as ULONG_PTR, byval NumberOfConcurrentThreads as DWORD) as HANDLE
declare function GetQueuedCompletionStatus(byval CompletionPort as HANDLE, byval lpNumberOfBytesTransferred as LPDWORD, byval lpCompletionKey as PULONG_PTR, byval lpOverlapped as LPOVERLAPPED ptr, byval dwMilliseconds as DWORD) as WINBOOL
declare function PostQueuedCompletionStatus(byval CompletionPort as HANDLE, byval dwNumberOfBytesTransferred as DWORD, byval dwCompletionKey as ULONG_PTR, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function DeviceIoControl(byval hDevice as HANDLE, byval dwIoControlCode as DWORD, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesReturned as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function CancelIo(byval hFile as HANDLE) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function GetQueuedCompletionStatusEx(byval CompletionPort as HANDLE, byval lpCompletionPortEntries as LPOVERLAPPED_ENTRY, byval ulCount as ULONG, byval ulNumEntriesRemoved as PULONG, byval dwMilliseconds as DWORD, byval fAlertable as WINBOOL) as WINBOOL
	declare function CancelIoEx(byval hFile as HANDLE, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
	declare function CancelSynchronousIo(byval hThread as HANDLE) as WINBOOL
#endif

declare function GetOverlappedResultEx(byval hFile as HANDLE, byval lpOverlapped as LPOVERLAPPED, byval lpNumberOfBytesTransferred as LPDWORD, byval dwMilliseconds as DWORD, byval bAlertable as WINBOOL) as WINBOOL
#define _INTERLOCKAPI_H_

#ifndef __FB_64BIT__
	#define InterlockedExchangePointer(Target, Value) cast(PVOID, InterlockedExchange(cast(PLONG, (Target)), cast(LONG, cast(LONG_PTR, (Value)))))
	#define InterlockedExchangePointerNoFence InterlockedExchangePointer
	#define InterlockedIncrement(lpAddend) cast(LONG, _InterlockedIncrement((lpAddend)))
	#define InterlockedDecrement(lpAddend) cast(LONG, _InterlockedDecrement((lpAddend)))
	#define InterlockedExchange(Target, Value) cast(LONG, _InterlockedExchange((Target), (Value)))
	#define InterlockedExchangeAdd(Addend, Value) cast(LONG, _InterlockedExchangeAdd((Addend), (Value)))
	#define InterlockedCompareExchange(Destination, Exchange, Comperand) cast(LONG, _InterlockedCompareExchange((Destination), (Exchange), (Comperand)))
	#define InterlockedCompareExchange64(Destination, Exchange, Comperand) cast(LONGLONG, _InterlockedCompareExchange64((Destination), (Exchange), (Comperand)))
#endif

declare sub InitializeSListHead(byval ListHead as PSLIST_HEADER)
declare function InterlockedPopEntrySList(byval ListHead as PSLIST_HEADER) as PSLIST_ENTRY
declare function InterlockedPushEntrySList(byval ListHead as PSLIST_HEADER, byval ListEntry as PSLIST_ENTRY) as PSLIST_ENTRY
declare function InterlockedFlushSList(byval ListHead as PSLIST_HEADER) as PSLIST_ENTRY
declare function QueryDepthSList(byval ListHead as PSLIST_HEADER) as USHORT

#if _WIN32_WINNT = &h0602
	declare function InterlockedPushListSListEx(byval ListHead as PSLIST_HEADER, byval List as PSLIST_ENTRY, byval ListEnd as PSLIST_ENTRY, byval Count as ULONG) as PSLIST_ENTRY
	declare function InterlockedPushListSList alias "InterlockedPushListSListEx"(byval ListHead as PSLIST_HEADER, byval List as PSLIST_ENTRY, byval ListEnd as PSLIST_ENTRY, byval Count as ULONG) as PSLIST_ENTRY
#endif

#define _JOBAPISET_H_
declare function IsProcessInJob(byval ProcessHandle as HANDLE, byval JobHandle as HANDLE, byval Result as PBOOL) as WINBOOL
#define _APISETLIBLOADER_

type tagENUMUILANG
	NumOfEnumUILang as ULONG
	SizeOfEnumUIBuffer as ULONG
	pEnumUIBuffer as LANGID ptr
end type

type ENUMUILANG as tagENUMUILANG
type PENUMUILANG as tagENUMUILANG ptr
type ENUMRESLANGPROCA as function(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval wLanguage as WORD, byval lParam as LONG_PTR) as WINBOOL
type ENUMRESLANGPROCW as function(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval wLanguage as WORD, byval lParam as LONG_PTR) as WINBOOL
type ENUMRESNAMEPROCA as function(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPSTR, byval lParam as LONG_PTR) as WINBOOL
type ENUMRESNAMEPROCW as function(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPWSTR, byval lParam as LONG_PTR) as WINBOOL
type ENUMRESTYPEPROCA as function(byval hModule as HMODULE, byval lpType as LPSTR, byval lParam as LONG_PTR) as WINBOOL
type ENUMRESTYPEPROCW as function(byval hModule as HMODULE, byval lpType as LPWSTR, byval lParam as LONG_PTR) as WINBOOL
type PGET_MODULE_HANDLE_EXA as function(byval dwFlags as DWORD, byval lpModuleName as LPCSTR, byval phModule as HMODULE ptr) as WINBOOL
type PGET_MODULE_HANDLE_EXW as function(byval dwFlags as DWORD, byval lpModuleName as LPCWSTR, byval phModule as HMODULE ptr) as WINBOOL
type DLL_DIRECTORY_COOKIE as PVOID
type PDLL_DIRECTORY_COOKIE as PVOID ptr

const FIND_RESOURCE_DIRECTORY_TYPES = &h0100
const FIND_RESOURCE_DIRECTORY_NAMES = &h0200
const FIND_RESOURCE_DIRECTORY_LANGUAGES = &h0400
const RESOURCE_ENUM_LN = &h0001
const RESOURCE_ENUM_MUI = &h0002
const RESOURCE_ENUM_MUI_SYSTEM = &h0004
const RESOURCE_ENUM_VALIDATE = &h0008
const RESOURCE_ENUM_MODULE_EXACT = &h0010
const SUPPORT_LANG_NUMBER = 32
const DONT_RESOLVE_DLL_REFERENCES = &h1
const LOAD_LIBRARY_AS_DATAFILE = &h2
const LOAD_WITH_ALTERED_SEARCH_PATH = &h8
const LOAD_IGNORE_CODE_AUTHZ_LEVEL = &h10
const LOAD_LIBRARY_AS_IMAGE_RESOURCE = &h20
const LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE = &h40
const LOAD_LIBRARY_REQUIRE_SIGNED_TARGET = &h80
const LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = &h100
const LOAD_LIBRARY_SEARCH_APPLICATION_DIR = &h200
const LOAD_LIBRARY_SEARCH_USER_DIRS = &h400
const LOAD_LIBRARY_SEARCH_SYSTEM32 = &h800
const LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = &h1000
const GET_MODULE_HANDLE_EX_FLAG_PIN = &h1
const GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT = &h2
const GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS = &h4

#ifdef UNICODE
	type ENUMRESLANGPROC as ENUMRESLANGPROCW
	type ENUMRESNAMEPROC as ENUMRESNAMEPROCW
	type ENUMRESTYPEPROC as ENUMRESTYPEPROCW
#else
	type ENUMRESLANGPROC as ENUMRESLANGPROCA
	type ENUMRESNAMEPROC as ENUMRESNAMEPROCA
	type ENUMRESTYPEPROC as ENUMRESTYPEPROCA
#endif

declare function FindResourceExW(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval wLanguage as WORD) as HRSRC
declare sub FreeLibraryAndExitThread(byval hLibModule as HMODULE, byval dwExitCode as DWORD)
declare function FreeResource(byval hResData as HGLOBAL) as WINBOOL
declare function GetModuleFileNameA(byval hModule as HMODULE, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD
declare function GetModuleFileNameW(byval hModule as HMODULE, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD
declare function GetModuleHandleA(byval lpModuleName as LPCSTR) as HMODULE
declare function GetModuleHandleW(byval lpModuleName as LPCWSTR) as HMODULE
declare function LoadLibraryExA(byval lpLibFileName as LPCSTR, byval hFile as HANDLE, byval dwFlags as DWORD) as HMODULE
declare function LoadLibraryExW(byval lpLibFileName as LPCWSTR, byval hFile as HANDLE, byval dwFlags as DWORD) as HMODULE
declare function LoadResource(byval hModule as HMODULE, byval hResInfo as HRSRC) as HGLOBAL
declare function LoadStringA(byval hInstance as HINSTANCE, byval uID as UINT, byval lpBuffer as LPSTR, byval cchBufferMax as long) as long
declare function LoadStringW(byval hInstance as HINSTANCE, byval uID as UINT, byval lpBuffer as LPWSTR, byval cchBufferMax as long) as long
declare function LockResource(byval hResData as HGLOBAL) as LPVOID
declare function SizeofResource(byval hModule as HMODULE, byval hResInfo as HRSRC) as DWORD
declare function AddDllDirectory(byval NewDirectory as PCWSTR) as DLL_DIRECTORY_COOKIE
declare function RemoveDllDirectory(byval Cookie as DLL_DIRECTORY_COOKIE) as WINBOOL
declare function SetDefaultDllDirectories(byval DirectoryFlags as DWORD) as WINBOOL
declare function GetModuleHandleExA(byval dwFlags as DWORD, byval lpModuleName as LPCSTR, byval phModule as HMODULE ptr) as WINBOOL
declare function GetModuleHandleExW(byval dwFlags as DWORD, byval lpModuleName as LPCWSTR, byval phModule as HMODULE ptr) as WINBOOL

#ifdef UNICODE
	type PGET_MODULE_HANDLE_EX as PGET_MODULE_HANDLE_EXW
	declare function GetModuleHandleEx alias "GetModuleHandleExW"(byval dwFlags as DWORD, byval lpModuleName as LPCWSTR, byval phModule as HMODULE ptr) as WINBOOL
	declare function FindResourceEx alias "FindResourceExW"(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval wLanguage as WORD) as HRSRC
	declare function LoadString alias "LoadStringW"(byval hInstance as HINSTANCE, byval uID as UINT, byval lpBuffer as LPWSTR, byval cchBufferMax as long) as long
	declare function GetModuleFileName alias "GetModuleFileNameW"(byval hModule as HMODULE, byval lpFilename as LPWSTR, byval nSize as DWORD) as DWORD
	declare function GetModuleHandle alias "GetModuleHandleW"(byval lpModuleName as LPCWSTR) as HMODULE
	declare function LoadLibraryEx alias "LoadLibraryExW"(byval lpLibFileName as LPCWSTR, byval hFile as HANDLE, byval dwFlags as DWORD) as HMODULE
	#define EnumResourceLanguages EnumResourceLanguagesW
#else
	type PGET_MODULE_HANDLE_EX as PGET_MODULE_HANDLE_EXA
	declare function GetModuleHandleEx alias "GetModuleHandleExA"(byval dwFlags as DWORD, byval lpModuleName as LPCSTR, byval phModule as HMODULE ptr) as WINBOOL
	declare function LoadString alias "LoadStringA"(byval hInstance as HINSTANCE, byval uID as UINT, byval lpBuffer as LPSTR, byval cchBufferMax as long) as long
	declare function GetModuleFileName alias "GetModuleFileNameA"(byval hModule as HMODULE, byval lpFilename as LPSTR, byval nSize as DWORD) as DWORD
	declare function GetModuleHandle alias "GetModuleHandleA"(byval lpModuleName as LPCSTR) as HMODULE
	declare function LoadLibraryEx alias "LoadLibraryExA"(byval lpLibFileName as LPCSTR, byval hFile as HANDLE, byval dwFlags as DWORD) as HMODULE
	#define EnumResourceLanguages EnumResourceLanguagesA
#endif

#if _WIN32_WINNT >= &h0600
	declare function EnumResourceLanguagesExA(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval lpEnumFunc as ENUMRESLANGPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceLanguagesExW(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval lpEnumFunc as ENUMRESLANGPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceNamesExA(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpEnumFunc as ENUMRESNAMEPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceNamesExW(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpEnumFunc as ENUMRESNAMEPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceTypesExA(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceTypesExW(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function QueryOptionalDelayLoadedAPI(byval CallerModule as HMODULE, byval lpDllName as LPCSTR, byval lpProcName as LPCSTR, byval Reserved as DWORD) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function EnumResourceLanguagesEx alias "EnumResourceLanguagesExW"(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval lpEnumFunc as ENUMRESLANGPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceNamesEx alias "EnumResourceNamesExW"(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpEnumFunc as ENUMRESNAMEPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceTypesEx alias "EnumResourceTypesExW"(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCW, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function EnumResourceLanguagesEx alias "EnumResourceLanguagesExA"(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval lpEnumFunc as ENUMRESLANGPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceNamesEx alias "EnumResourceNamesExA"(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpEnumFunc as ENUMRESNAMEPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
	declare function EnumResourceTypesEx alias "EnumResourceTypesExA"(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCA, byval lParam as LONG_PTR, byval dwFlags as DWORD, byval LangId as LANGID) as WINBOOL
#endif

declare function DisableThreadLibraryCalls(byval hLibModule as HMODULE) as WINBOOL
declare function FreeLibrary(byval hLibModule as HMODULE) as WINBOOL
declare function GetProcAddress(byval hModule as HMODULE, byval lpProcName as LPCSTR) as FARPROC

#if _WIN32_WINNT >= &h0601
	declare function FindStringOrdinal(byval dwFindStringOrdinalFlags as DWORD, byval lpStringSource as LPCWSTR, byval cchSource as long, byval lpStringValue as LPCWSTR, byval cchValue as long, byval bIgnoreCase as WINBOOL) as long
#endif

#define _MEMORYAPI_H_

type _MEMORY_RESOURCE_NOTIFICATION_TYPE as long
enum
	LowMemoryResourceNotification
	HighMemoryResourceNotification
end enum

type MEMORY_RESOURCE_NOTIFICATION_TYPE as _MEMORY_RESOURCE_NOTIFICATION_TYPE

#if _WIN32_WINNT = &h0602
	type _WIN32_MEMORY_RANGE_ENTRY
		VirtualAddress as PVOID
		NumberOfBytes as SIZE_T_
	end type

	type WIN32_MEMORY_RANGE_ENTRY as _WIN32_MEMORY_RANGE_ENTRY
	type PWIN32_MEMORY_RANGE_ENTRY as _WIN32_MEMORY_RANGE_ENTRY ptr
#endif

const FILE_MAP_WRITE = SECTION_MAP_WRITE
const FILE_MAP_READ = SECTION_MAP_READ
const FILE_MAP_ALL_ACCESS = SECTION_ALL_ACCESS
const FILE_MAP_COPY = &h1
const FILE_MAP_RESERVE = &h80000000

declare function VirtualQuery(byval lpAddress as LPCVOID, byval lpBuffer as PMEMORY_BASIC_INFORMATION, byval dwLength as SIZE_T_) as SIZE_T_
declare function FlushViewOfFile(byval lpBaseAddress as LPCVOID, byval dwNumberOfBytesToFlush as SIZE_T_) as WINBOOL
declare function UnmapViewOfFile(byval lpBaseAddress as LPCVOID) as WINBOOL
declare function CreateFileMappingFromApp(byval hFile as HANDLE, byval SecurityAttributes as PSECURITY_ATTRIBUTES, byval PageProtection as ULONG, byval MaximumSize as ULONG64, byval Name as PCWSTR) as HANDLE
declare function MapViewOfFileFromApp(byval hFileMappingObject as HANDLE, byval DesiredAccess as ULONG, byval FileOffset as ULONG64, byval NumberOfBytesToMap as SIZE_T_) as PVOID

const FILE_MAP_EXECUTE = SECTION_MAP_EXECUTE_EXPLICIT
#define FILE_CACHE_FLAGS_DEFINED
const FILE_CACHE_MAX_HARD_ENABLE = &h00000001
const FILE_CACHE_MAX_HARD_DISABLE = &h00000002
const FILE_CACHE_MIN_HARD_ENABLE = &h00000004
const FILE_CACHE_MIN_HARD_DISABLE = &h00000008

declare function VirtualAlloc(byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval flAllocationType as DWORD, byval flProtect as DWORD) as LPVOID
declare function VirtualFree(byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval dwFreeType as DWORD) as WINBOOL
declare function VirtualProtect(byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval flNewProtect as DWORD, byval lpflOldProtect as PDWORD) as WINBOOL
declare function VirtualAllocEx(byval hProcess as HANDLE, byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval flAllocationType as DWORD, byval flProtect as DWORD) as LPVOID
declare function VirtualFreeEx(byval hProcess as HANDLE, byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval dwFreeType as DWORD) as WINBOOL
declare function VirtualProtectEx(byval hProcess as HANDLE, byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval flNewProtect as DWORD, byval lpflOldProtect as PDWORD) as WINBOOL
declare function VirtualQueryEx(byval hProcess as HANDLE, byval lpAddress as LPCVOID, byval lpBuffer as PMEMORY_BASIC_INFORMATION, byval dwLength as SIZE_T_) as SIZE_T_
declare function ReadProcessMemory(byval hProcess as HANDLE, byval lpBaseAddress as LPCVOID, byval lpBuffer as LPVOID, byval nSize as SIZE_T_, byval lpNumberOfBytesRead as SIZE_T_ ptr) as WINBOOL
declare function WriteProcessMemory(byval hProcess as HANDLE, byval lpBaseAddress as LPVOID, byval lpBuffer as LPCVOID, byval nSize as SIZE_T_, byval lpNumberOfBytesWritten as SIZE_T_ ptr) as WINBOOL
declare function CreateFileMappingW(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCWSTR) as HANDLE
declare function OpenFileMappingW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function MapViewOfFile(byval hFileMappingObject as HANDLE, byval dwDesiredAccess as DWORD, byval dwFileOffsetHigh as DWORD, byval dwFileOffsetLow as DWORD, byval dwNumberOfBytesToMap as SIZE_T_) as LPVOID
declare function MapViewOfFileEx(byval hFileMappingObject as HANDLE, byval dwDesiredAccess as DWORD, byval dwFileOffsetHigh as DWORD, byval dwFileOffsetLow as DWORD, byval dwNumberOfBytesToMap as SIZE_T_, byval lpBaseAddress as LPVOID) as LPVOID
declare function GetLargePageMinimum() as SIZE_T_
declare function GetProcessWorkingSetSizeEx(byval hProcess as HANDLE, byval lpMinimumWorkingSetSize as PSIZE_T, byval lpMaximumWorkingSetSize as PSIZE_T, byval Flags as PDWORD) as WINBOOL
declare function SetProcessWorkingSetSizeEx(byval hProcess as HANDLE, byval dwMinimumWorkingSetSize as SIZE_T_, byval dwMaximumWorkingSetSize as SIZE_T_, byval Flags as DWORD) as WINBOOL
declare function VirtualLock(byval lpAddress as LPVOID, byval dwSize as SIZE_T_) as WINBOOL
declare function VirtualUnlock(byval lpAddress as LPVOID, byval dwSize as SIZE_T_) as WINBOOL
declare function GetWriteWatch(byval dwFlags as DWORD, byval lpBaseAddress as PVOID, byval dwRegionSize as SIZE_T_, byval lpAddresses as PVOID ptr, byval lpdwCount as ULONG_PTR ptr, byval lpdwGranularity as LPDWORD) as UINT
declare function ResetWriteWatch(byval lpBaseAddress as LPVOID, byval dwRegionSize as SIZE_T_) as UINT
declare function CreateMemoryResourceNotification(byval NotificationType as MEMORY_RESOURCE_NOTIFICATION_TYPE) as HANDLE
declare function QueryMemoryResourceNotification(byval ResourceNotificationHandle as HANDLE, byval ResourceState as PBOOL) as WINBOOL
declare function GetSystemFileCacheSize(byval lpMinimumFileCacheSize as PSIZE_T, byval lpMaximumFileCacheSize as PSIZE_T, byval lpFlags as PDWORD) as WINBOOL
declare function SetSystemFileCacheSize(byval MinimumFileCacheSize as SIZE_T_, byval MaximumFileCacheSize as SIZE_T_, byval Flags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CreateFileMapping alias "CreateFileMappingW"(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCWSTR) as HANDLE
	declare function OpenFileMapping alias "OpenFileMappingW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
#endif

#if _WIN32_WINNT >= &h0600
	declare function CreateFileMappingNumaW(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCWSTR, byval nndPreferred as DWORD) as HANDLE
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateFileMappingNuma alias "CreateFileMappingNumaW"(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCWSTR, byval nndPreferred as DWORD) as HANDLE
#endif

#if _WIN32_WINNT = &h0602
	declare function PrefetchVirtualMemory(byval hProcess as HANDLE, byval NumberOfEntries as ULONG_PTR, byval VirtualAddresses as PWIN32_MEMORY_RANGE_ENTRY, byval Flags as ULONG) as WINBOOL
	declare function UnmapViewOfFileEx(byval BaseAddress as PVOID, byval UnmapFlags as ULONG) as WINBOOL
#endif

#define _NAMEDPIPE_H_
declare function ImpersonateNamedPipeClient(byval hNamedPipe as HANDLE) as WINBOOL
declare function CreatePipe(byval hReadPipe as PHANDLE, byval hWritePipe as PHANDLE, byval lpPipeAttributes as LPSECURITY_ATTRIBUTES, byval nSize as DWORD) as WINBOOL
declare function ConnectNamedPipe(byval hNamedPipe as HANDLE, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function DisconnectNamedPipe(byval hNamedPipe as HANDLE) as WINBOOL
declare function SetNamedPipeHandleState(byval hNamedPipe as HANDLE, byval lpMode as LPDWORD, byval lpMaxCollectionCount as LPDWORD, byval lpCollectDataTimeout as LPDWORD) as WINBOOL
declare function PeekNamedPipe(byval hNamedPipe as HANDLE, byval lpBuffer as LPVOID, byval nBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval lpTotalBytesAvail as LPDWORD, byval lpBytesLeftThisMessage as LPDWORD) as WINBOOL
declare function TransactNamedPipe(byval hNamedPipe as HANDLE, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function CreateNamedPipeW(byval lpName as LPCWSTR, byval dwOpenMode as DWORD, byval dwPipeMode as DWORD, byval nMaxInstances as DWORD, byval nOutBufferSize as DWORD, byval nInBufferSize as DWORD, byval nDefaultTimeOut as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
declare function WaitNamedPipeW(byval lpNamedPipeName as LPCWSTR, byval nTimeOut as DWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function GetNamedPipeClientComputerNameW(byval Pipe as HANDLE, byval ClientComputerName as LPWSTR, byval ClientComputerNameLength as ULONG) as WINBOOL
#endif

#ifdef UNICODE
	declare function CreateNamedPipe alias "CreateNamedPipeW"(byval lpName as LPCWSTR, byval dwOpenMode as DWORD, byval dwPipeMode as DWORD, byval nMaxInstances as DWORD, byval nOutBufferSize as DWORD, byval nInBufferSize as DWORD, byval nDefaultTimeOut as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
	declare function WaitNamedPipe alias "WaitNamedPipeW"(byval lpNamedPipeName as LPCWSTR, byval nTimeOut as DWORD) as WINBOOL

	#if _WIN32_WINNT <= &h0502
		#define GetNamedPipeClientComputerName GetNamedPipeClientComputerNameW
	#elseif _WIN32_WINNT >= &h0600
		declare function GetNamedPipeClientComputerName alias "GetNamedPipeClientComputerNameW"(byval Pipe as HANDLE, byval ClientComputerName as LPWSTR, byval ClientComputerNameLength as ULONG) as WINBOOL
	#endif
#endif

#define _APISETNAMESPACE_
const PRIVATE_NAMESPACE_FLAG_DESTROY = &h1
declare function CreatePrivateNamespaceW(byval lpPrivateNamespaceAttributes as LPSECURITY_ATTRIBUTES, byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCWSTR) as HANDLE
declare function OpenPrivateNamespaceW(byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCWSTR) as HANDLE

#ifdef UNICODE
	declare function CreatePrivateNamespace alias "CreatePrivateNamespaceW"(byval lpPrivateNamespaceAttributes as LPSECURITY_ATTRIBUTES, byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCWSTR) as HANDLE
#endif

declare function ClosePrivateNamespace(byval Handle as HANDLE, byval Flags as ULONG) as WINBOOLEAN
declare function CreateBoundaryDescriptorW(byval Name as LPCWSTR, byval Flags as ULONG) as HANDLE

#ifdef UNICODE
	declare function CreateBoundaryDescriptor alias "CreateBoundaryDescriptorW"(byval Name as LPCWSTR, byval Flags as ULONG) as HANDLE
#endif

declare function AddSIDToBoundaryDescriptor(byval BoundaryDescriptor as HANDLE ptr, byval RequiredSid as PSID) as WINBOOL
declare sub DeleteBoundaryDescriptor(byval BoundaryDescriptor as HANDLE)
#define _PROCESSENV_
declare function GetEnvironmentStringsA alias "GetEnvironmentStrings"() as LPCH
declare function GetEnvironmentStringsW() as LPWCH
declare function SetEnvironmentStringsW(byval NewEnvironment as LPWCH) as WINBOOL

#ifdef UNICODE
	declare function GetEnvironmentStrings alias "GetEnvironmentStringsW"() as LPWCH
	declare function SetEnvironmentStrings alias "SetEnvironmentStringsW"(byval NewEnvironment as LPWCH) as WINBOOL
#else
	declare function GetEnvironmentStrings() as LPCH
#endif

declare function FreeEnvironmentStringsA(byval penv as LPCH) as WINBOOL
declare function FreeEnvironmentStringsW(byval penv as LPWCH) as WINBOOL
declare function GetStdHandle(byval nStdHandle as DWORD) as HANDLE
declare function SetStdHandle(byval nStdHandle as DWORD, byval hHandle as HANDLE) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function SetStdHandleEx(byval nStdHandle as DWORD, byval hHandle as HANDLE, byval phPrevValue as PHANDLE) as WINBOOL
#endif

declare function GetCommandLineA() as LPSTR
declare function GetCommandLineW() as LPWSTR
declare function GetEnvironmentVariableA(byval lpName as LPCSTR, byval lpBuffer as LPSTR, byval nSize as DWORD) as DWORD
declare function GetEnvironmentVariableW(byval lpName as LPCWSTR, byval lpBuffer as LPWSTR, byval nSize as DWORD) as DWORD
declare function SetEnvironmentVariableA(byval lpName as LPCSTR, byval lpValue as LPCSTR) as WINBOOL
declare function SetEnvironmentVariableW(byval lpName as LPCWSTR, byval lpValue as LPCWSTR) as WINBOOL
declare function ExpandEnvironmentStringsA(byval lpSrc as LPCSTR, byval lpDst as LPSTR, byval nSize as DWORD) as DWORD
declare function ExpandEnvironmentStringsW(byval lpSrc as LPCWSTR, byval lpDst as LPWSTR, byval nSize as DWORD) as DWORD
declare function SetCurrentDirectoryA(byval lpPathName as LPCSTR) as WINBOOL
declare function SetCurrentDirectoryW(byval lpPathName as LPCWSTR) as WINBOOL
declare function GetCurrentDirectoryA(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
declare function GetCurrentDirectoryW(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
declare function SearchPathW(byval lpPath as LPCWSTR, byval lpFileName as LPCWSTR, byval lpExtension as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr) as DWORD
declare function SearchPathA(byval lpPath as LPCSTR, byval lpFileName as LPCSTR, byval lpExtension as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr) as DWORD
declare function NeedCurrentDirectoryForExePathA(byval ExeName as LPCSTR) as WINBOOL
declare function NeedCurrentDirectoryForExePathW(byval ExeName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function ExpandEnvironmentStrings alias "ExpandEnvironmentStringsW"(byval lpSrc as LPCWSTR, byval lpDst as LPWSTR, byval nSize as DWORD) as DWORD
	declare function FreeEnvironmentStrings alias "FreeEnvironmentStringsW"(byval penv as LPWCH) as WINBOOL
	declare function GetCommandLine alias "GetCommandLineW"() as LPWSTR
	declare function GetCurrentDirectory alias "GetCurrentDirectoryW"(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
	declare function GetEnvironmentVariable alias "GetEnvironmentVariableW"(byval lpName as LPCWSTR, byval lpBuffer as LPWSTR, byval nSize as DWORD) as DWORD
	declare function NeedCurrentDirectoryForExePath alias "NeedCurrentDirectoryForExePathW"(byval ExeName as LPCWSTR) as WINBOOL
	declare function SearchPath alias "SearchPathW"(byval lpPath as LPCWSTR, byval lpFileName as LPCWSTR, byval lpExtension as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr) as DWORD
	declare function SetCurrentDirectory alias "SetCurrentDirectoryW"(byval lpPathName as LPCWSTR) as WINBOOL
	declare function SetEnvironmentVariable alias "SetEnvironmentVariableW"(byval lpName as LPCWSTR, byval lpValue as LPCWSTR) as WINBOOL
#else
	declare function ExpandEnvironmentStrings alias "ExpandEnvironmentStringsA"(byval lpSrc as LPCSTR, byval lpDst as LPSTR, byval nSize as DWORD) as DWORD
	declare function FreeEnvironmentStrings alias "FreeEnvironmentStringsA"(byval penv as LPCH) as WINBOOL
	declare function GetCommandLine alias "GetCommandLineA"() as LPSTR
	declare function GetCurrentDirectory alias "GetCurrentDirectoryA"(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
	declare function GetEnvironmentVariable alias "GetEnvironmentVariableA"(byval lpName as LPCSTR, byval lpBuffer as LPSTR, byval nSize as DWORD) as DWORD
	declare function NeedCurrentDirectoryForExePath alias "NeedCurrentDirectoryForExePathA"(byval ExeName as LPCSTR) as WINBOOL
	declare function SearchPath alias "SearchPathA"(byval lpPath as LPCSTR, byval lpFileName as LPCSTR, byval lpExtension as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr) as DWORD
	declare function SetCurrentDirectory alias "SetCurrentDirectoryA"(byval lpPathName as LPCSTR) as WINBOOL
	declare function SetEnvironmentVariable alias "SetEnvironmentVariableA"(byval lpName as LPCSTR, byval lpValue as LPCSTR) as WINBOOL
#endif

#define _PROCESSTHREADSAPI_H_

#if _WIN32_WINNT <= &h0502
	const FLS_OUT_OF_INDEXES = cast(DWORD, &hffffffff)
#endif

const TLS_OUT_OF_INDEXES = cast(DWORD, &hffffffff)

type _PROCESS_INFORMATION
	hProcess as HANDLE
	hThread as HANDLE
	dwProcessId as DWORD
	dwThreadId as DWORD
end type

type PROCESS_INFORMATION as _PROCESS_INFORMATION
type PPROCESS_INFORMATION as _PROCESS_INFORMATION ptr
type LPPROCESS_INFORMATION as _PROCESS_INFORMATION ptr

type _STARTUPINFOA
	cb as DWORD
	lpReserved as LPSTR
	lpDesktop as LPSTR
	lpTitle as LPSTR
	dwX as DWORD
	dwY as DWORD
	dwXSize as DWORD
	dwYSize as DWORD
	dwXCountChars as DWORD
	dwYCountChars as DWORD
	dwFillAttribute as DWORD
	dwFlags as DWORD
	wShowWindow as WORD
	cbReserved2 as WORD
	lpReserved2 as LPBYTE
	hStdInput as HANDLE
	hStdOutput as HANDLE
	hStdError as HANDLE
end type

type STARTUPINFOA as _STARTUPINFOA
type LPSTARTUPINFOA as _STARTUPINFOA ptr

type _STARTUPINFOW
	cb as DWORD
	lpReserved as LPWSTR
	lpDesktop as LPWSTR
	lpTitle as LPWSTR
	dwX as DWORD
	dwY as DWORD
	dwXSize as DWORD
	dwYSize as DWORD
	dwXCountChars as DWORD
	dwYCountChars as DWORD
	dwFillAttribute as DWORD
	dwFlags as DWORD
	wShowWindow as WORD
	cbReserved2 as WORD
	lpReserved2 as LPBYTE
	hStdInput as HANDLE
	hStdOutput as HANDLE
	hStdError as HANDLE
end type

type STARTUPINFOW as _STARTUPINFOW
type LPSTARTUPINFOW as _STARTUPINFOW ptr

#ifdef UNICODE
	type STARTUPINFO as STARTUPINFOW
	type LPSTARTUPINFO as LPSTARTUPINFOW
#else
	type STARTUPINFO as STARTUPINFOA
	type LPSTARTUPINFO as LPSTARTUPINFOA
#endif

type PPROC_THREAD_ATTRIBUTE_LIST as _PROC_THREAD_ATTRIBUTE_LIST ptr
type LPPROC_THREAD_ATTRIBUTE_LIST as _PROC_THREAD_ATTRIBUTE_LIST ptr
declare function QueueUserAPC(byval pfnAPC as PAPCFUNC, byval hThread as HANDLE, byval dwData as ULONG_PTR) as DWORD
declare function GetProcessTimes(byval hProcess as HANDLE, byval lpCreationTime as LPFILETIME, byval lpExitTime as LPFILETIME, byval lpKernelTime as LPFILETIME, byval lpUserTime as LPFILETIME) as WINBOOL
declare sub ExitProcess(byval uExitCode as UINT)
declare function TerminateProcess(byval hProcess as HANDLE, byval uExitCode as UINT) as WINBOOL
declare function GetExitCodeProcess(byval hProcess as HANDLE, byval lpExitCode as LPDWORD) as WINBOOL
declare function SwitchToThread() as WINBOOL
declare function CreateRemoteThread(byval hProcess as HANDLE, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval dwStackSize as SIZE_T_, byval lpStartAddress as LPTHREAD_START_ROUTINE, byval lpParameter as LPVOID, byval dwCreationFlags as DWORD, byval lpThreadId as LPDWORD) as HANDLE
declare function OpenThread(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval dwThreadId as DWORD) as HANDLE
declare function SetThreadPriorityBoost(byval hThread as HANDLE, byval bDisablePriorityBoost as WINBOOL) as WINBOOL
declare function GetThreadPriorityBoost(byval hThread as HANDLE, byval pDisablePriorityBoost as PBOOL) as WINBOOL
declare function TerminateThread(byval hThread as HANDLE, byval dwExitCode as DWORD) as WINBOOL
declare function SetProcessShutdownParameters(byval dwLevel as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function GetProcessVersion(byval ProcessId as DWORD) as DWORD
declare sub GetStartupInfoW(byval lpStartupInfo as LPSTARTUPINFOW)
declare function SetThreadToken(byval Thread as PHANDLE, byval Token as HANDLE) as WINBOOL
declare function OpenProcessToken(byval ProcessHandle as HANDLE, byval DesiredAccess as DWORD, byval TokenHandle as PHANDLE) as WINBOOL
declare function OpenThreadToken(byval ThreadHandle as HANDLE, byval DesiredAccess as DWORD, byval OpenAsSelf as WINBOOL, byval TokenHandle as PHANDLE) as WINBOOL
declare function SetPriorityClass(byval hProcess as HANDLE, byval dwPriorityClass as DWORD) as WINBOOL
declare function SetThreadStackGuarantee(byval StackSizeInBytes as PULONG) as WINBOOL
declare function GetPriorityClass(byval hProcess as HANDLE) as DWORD
declare function ProcessIdToSessionId(byval dwProcessId as DWORD, byval pSessionId as DWORD ptr) as WINBOOL
declare function GetProcessId(byval Process as HANDLE) as DWORD
declare function GetThreadId(byval Thread as HANDLE) as DWORD
declare function CreateRemoteThreadEx(byval hProcess as HANDLE, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval dwStackSize as SIZE_T_, byval lpStartAddress as LPTHREAD_START_ROUTINE, byval lpParameter as LPVOID, byval dwCreationFlags as DWORD, byval lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST, byval lpThreadId as LPDWORD) as HANDLE
declare function GetThreadContext(byval hThread as HANDLE, byval lpContext as LPCONTEXT) as WINBOOL
declare function SetThreadContext(byval hThread as HANDLE, byval lpContext as const CONTEXT ptr) as WINBOOL
declare function FlushInstructionCache(byval hProcess as HANDLE, byval lpBaseAddress as LPCVOID, byval dwSize as SIZE_T_) as WINBOOL
declare function GetThreadTimes(byval hThread as HANDLE, byval lpCreationTime as LPFILETIME, byval lpExitTime as LPFILETIME, byval lpKernelTime as LPFILETIME, byval lpUserTime as LPFILETIME) as WINBOOL
declare function OpenProcess(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval dwProcessId as DWORD) as HANDLE
declare function GetProcessHandleCount(byval hProcess as HANDLE, byval pdwHandleCount as PDWORD) as WINBOOL
declare function GetCurrentProcessorNumber() as DWORD

#ifdef UNICODE
	declare sub GetStartupInfo alias "GetStartupInfoW"(byval lpStartupInfo as LPSTARTUPINFOW)
#endif

declare function CreateProcessA(byval lpApplicationName as LPCSTR, byval lpCommandLine as LPSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCSTR, byval lpStartupInfo as LPSTARTUPINFOA, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
declare function CreateProcessW(byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL

#ifdef UNICODE
	declare function CreateProcess alias "CreateProcessW"(byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
#else
	declare function CreateProcess alias "CreateProcessA"(byval lpApplicationName as LPCSTR, byval lpCommandLine as LPSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCSTR, byval lpStartupInfo as LPSTARTUPINFOA, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
#endif

declare function CreateProcessAsUserW(byval hToken as HANDLE, byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL

#ifdef UNICODE
	declare function CreateProcessAsUser alias "CreateProcessAsUserW"(byval hToken as HANDLE, byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	const PROCESS_AFFINITY_ENABLE_AUTO_UPDATE = &h1u
	const PROC_THREAD_ATTRIBUTE_REPLACE_VALUE = &h00000001
	declare function GetProcessIdOfThread(byval Thread as HANDLE) as DWORD
	declare function InitializeProcThreadAttributeList(byval lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST, byval dwAttributeCount as DWORD, byval dwFlags as DWORD, byval lpSize as PSIZE_T) as WINBOOL
	declare sub DeleteProcThreadAttributeList(byval lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST)
	declare function SetProcessAffinityUpdateMode(byval hProcess as HANDLE, byval dwFlags as DWORD) as WINBOOL
	declare function QueryProcessAffinityUpdateMode(byval hProcess as HANDLE, byval lpdwFlags as LPDWORD) as WINBOOL
	declare function UpdateProcThreadAttribute(byval lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST, byval dwFlags as DWORD, byval Attribute as DWORD_PTR, byval lpValue as PVOID, byval cbSize as SIZE_T_, byval lpPreviousValue as PVOID, byval lpReturnSize as PSIZE_T) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function GetThreadIdealProcessorEx(byval hThread as HANDLE, byval lpIdealProcessor as PPROCESSOR_NUMBER) as WINBOOL
	declare sub GetCurrentProcessorNumberEx(byval ProcNumber as PPROCESSOR_NUMBER)
#endif

#if _WIN32_WINNT = &h0602
	declare sub GetCurrentThreadStackLimits(byval LowLimit as PULONG_PTR, byval HighLimit as PULONG_PTR)
	declare function SetProcessMitigationPolicy(byval MitigationPolicy as PROCESS_MITIGATION_POLICY, byval lpBuffer as PVOID, byval dwLength as SIZE_T_) as WINBOOL
	declare function GetProcessMitigationPolicy(byval hProcess as HANDLE, byval MitigationPolicy as PROCESS_MITIGATION_POLICY, byval lpBuffer as PVOID, byval dwLength as SIZE_T_) as WINBOOL
#endif

declare function GetCurrentProcess() as HANDLE
declare function GetCurrentProcessId() as DWORD
declare function GetCurrentThread() as HANDLE
declare function GetCurrentThreadId() as DWORD
declare function IsProcessorFeaturePresent(byval ProcessorFeature as DWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare sub FlushProcessWriteBuffers()
#endif

declare function CreateThread(byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval dwStackSize as SIZE_T_, byval lpStartAddress as LPTHREAD_START_ROUTINE, byval lpParameter as LPVOID, byval dwCreationFlags as DWORD, byval lpThreadId as LPDWORD) as HANDLE
declare function SetThreadPriority(byval hThread as HANDLE, byval nPriority as long) as WINBOOL
declare function GetThreadPriority(byval hThread as HANDLE) as long
declare sub ExitThread(byval dwExitCode as DWORD)
declare function GetExitCodeThread(byval hThread as HANDLE, byval lpExitCode as LPDWORD) as WINBOOL
declare function SuspendThread(byval hThread as HANDLE) as DWORD
declare function ResumeThread(byval hThread as HANDLE) as DWORD
declare function TlsAlloc() as DWORD
declare function TlsGetValue(byval dwTlsIndex as DWORD) as LPVOID
declare function TlsSetValue(byval dwTlsIndex as DWORD, byval lpTlsValue as LPVOID) as WINBOOL
declare function TlsFree(byval dwTlsIndex as DWORD) as WINBOOL

#if _WIN32_WINNT >= &h0601
	declare function SetThreadIdealProcessorEx(byval hThread as HANDLE, byval lpIdealProcessor as PPROCESSOR_NUMBER, byval lpPreviousIdealProcessor as PPROCESSOR_NUMBER) as WINBOOL
#endif

#define _PROCESSTOPOLOGYAPI_H_

#if _WIN32_WINNT >= &h0601
	declare function GetProcessGroupAffinity(byval hProcess as HANDLE, byval GroupCount as PUSHORT, byval GroupArray as PUSHORT) as WINBOOL
	declare function SetProcessGroupAffinity(byval hProcess as HANDLE, byval GroupAffinity as const GROUP_AFFINITY ptr, byval PreviousGroupAffinity as PGROUP_AFFINITY) as WINBOOL
	declare function GetThreadGroupAffinity(byval hThread as HANDLE, byval GroupAffinity as PGROUP_AFFINITY) as WINBOOL
	declare function SetThreadGroupAffinity(byval hThread as HANDLE, byval GroupAffinity as const GROUP_AFFINITY ptr, byval PreviousGroupAffinity as PGROUP_AFFINITY) as WINBOOL
#endif

#define _PROFILEAPI_H_
declare function QueryPerformanceCounter(byval lpPerformanceCount as LARGE_INTEGER ptr) as WINBOOL
declare function QueryPerformanceFrequency(byval lpFrequency as LARGE_INTEGER ptr) as WINBOOL
#define _APISETREALTIME_

#if _WIN32_WINNT >= &h0600
	declare function QueryThreadCycleTime(byval ThreadHandle as HANDLE, byval CycleTime as PULONG64) as WINBOOL
	declare function QueryProcessCycleTime(byval ProcessHandle as HANDLE, byval CycleTime as PULONG64) as WINBOOL
	declare function QueryIdleProcessorCycleTime(byval BufferLength as PULONG, byval ProcessorIdleCycleTime as PULONG64) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function QueryIdleProcessorCycleTimeEx(byval Group as USHORT, byval BufferLength as PULONG, byval ProcessorIdleCycleTime as PULONG64) as WINBOOL
	declare function QueryUnbiasedInterruptTime(byval UnbiasedTime as PULONGLONG) as WINBOOL
#endif

#define _APIAPPCONTAINER_

#if _WIN32_WINNT = &h0602
	declare function GetAppContainerNamedObjectPath cdecl(byval Token as HANDLE, byval AppContainerSid as PSID, byval ObjectPathLength as ULONG, byval ObjectPath as LPWSTR, byval ReturnLength as PULONG) as WINBOOL
#endif

#define _APISECUREBASE_
declare function AccessCheck(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval PrivilegeSet as PPRIVILEGE_SET, byval PrivilegeSetLength as LPDWORD, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL) as WINBOOL
declare function AccessCheckAndAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPWSTR, byval ObjectName as LPWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval DesiredAccess as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL

#ifdef UNICODE
	declare function AccessCheckAndAuditAlarm alias "AccessCheckAndAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPWSTR, byval ObjectName as LPWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval DesiredAccess as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
#endif

declare function AccessCheckByType(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval PrivilegeSet as PPRIVILEGE_SET, byval PrivilegeSetLength as LPDWORD, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL) as WINBOOL
declare function AccessCheckByTypeResultList(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval PrivilegeSet as PPRIVILEGE_SET, byval PrivilegeSetLength as LPDWORD, byval GrantedAccessList as LPDWORD, byval AccessStatusList as LPDWORD) as WINBOOL
declare function AccessCheckByTypeAndAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL

#ifdef UNICODE
	declare function AccessCheckByTypeAndAuditAlarm alias "AccessCheckByTypeAndAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
#endif

declare function AccessCheckByTypeResultListAndAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccessList as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL

#ifdef UNICODE
	declare function AccessCheckByTypeResultListAndAuditAlarm alias "AccessCheckByTypeResultListAndAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccessList as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
#endif

declare function AccessCheckByTypeResultListAndAuditAlarmByHandleW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccessList as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL

#ifdef UNICODE
	declare function AccessCheckByTypeResultListAndAuditAlarmByHandle alias "AccessCheckByTypeResultListAndAuditAlarmByHandleW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval ObjectTypeName as LPCWSTR, byval ObjectName as LPCWSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccessList as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
#endif

declare function AddAccessAllowedAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AccessMask as DWORD, byval pSid as PSID) as WINBOOL
declare function AddAccessAllowedAceEx(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval pSid as PSID) as WINBOOL
declare function AddAccessAllowedObjectAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval ObjectTypeGuid as GUID ptr, byval InheritedObjectTypeGuid as GUID ptr, byval pSid as PSID) as WINBOOL
declare function AddAccessDeniedAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AccessMask as DWORD, byval pSid as PSID) as WINBOOL
declare function AddAccessDeniedAceEx(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval pSid as PSID) as WINBOOL
declare function AddAccessDeniedObjectAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval ObjectTypeGuid as GUID ptr, byval InheritedObjectTypeGuid as GUID ptr, byval pSid as PSID) as WINBOOL
declare function AddAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval dwStartingAceIndex as DWORD, byval pAceList as LPVOID, byval nAceListLength as DWORD) as WINBOOL
declare function AddAuditAccessAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval dwAccessMask as DWORD, byval pSid as PSID, byval bAuditSuccess as WINBOOL, byval bAuditFailure as WINBOOL) as WINBOOL
declare function AddAuditAccessAceEx(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval dwAccessMask as DWORD, byval pSid as PSID, byval bAuditSuccess as WINBOOL, byval bAuditFailure as WINBOOL) as WINBOOL
declare function AddAuditAccessObjectAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval ObjectTypeGuid as GUID ptr, byval InheritedObjectTypeGuid as GUID ptr, byval pSid as PSID, byval bAuditSuccess as WINBOOL, byval bAuditFailure as WINBOOL) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function AddMandatoryAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval MandatoryPolicy as DWORD, byval pLabelSid as PSID) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	declare function AddResourceAttributeAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval pSid as PSID, byval pAttributeInfo as PCLAIM_SECURITY_ATTRIBUTES_INFORMATION, byval pReturnLength as PDWORD) as WINBOOL
	declare function AddScopedPolicyIDAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AccessMask as DWORD, byval pSid as PSID) as WINBOOL
#endif

declare function AdjustTokenGroups(byval TokenHandle as HANDLE, byval ResetToDefault as WINBOOL, byval NewState as PTOKEN_GROUPS, byval BufferLength as DWORD, byval PreviousState as PTOKEN_GROUPS, byval ReturnLength as PDWORD) as WINBOOL
declare function AdjustTokenPrivileges(byval TokenHandle as HANDLE, byval DisableAllPrivileges as WINBOOL, byval NewState as PTOKEN_PRIVILEGES, byval BufferLength as DWORD, byval PreviousState as PTOKEN_PRIVILEGES, byval ReturnLength as PDWORD) as WINBOOL
declare function AllocateAndInitializeSid(byval pIdentifierAuthority as PSID_IDENTIFIER_AUTHORITY, byval nSubAuthorityCount as UBYTE, byval nSubAuthority0 as DWORD, byval nSubAuthority1 as DWORD, byval nSubAuthority2 as DWORD, byval nSubAuthority3 as DWORD, byval nSubAuthority4 as DWORD, byval nSubAuthority5 as DWORD, byval nSubAuthority6 as DWORD, byval nSubAuthority7 as DWORD, byval pSid as PSID ptr) as WINBOOL
declare function AllocateLocallyUniqueId(byval Luid as PLUID) as WINBOOL
declare function AreAllAccessesGranted(byval GrantedAccess as DWORD, byval DesiredAccess as DWORD) as WINBOOL
declare function AreAnyAccessesGranted(byval GrantedAccess as DWORD, byval DesiredAccess as DWORD) as WINBOOL
declare function CheckTokenMembership(byval TokenHandle as HANDLE, byval SidToCheck as PSID, byval IsMember as PBOOL) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function CheckTokenCapability(byval TokenHandle as HANDLE, byval CapabilitySidToCheck as PSID, byval HasCapability as PBOOL) as WINBOOL
	declare function GetAppContainerAce(byval Acl as PACL, byval StartingAceIndex as DWORD, byval AppContainerAce as PVOID ptr, byval AppContainerAceIndex as DWORD ptr) as WINBOOL
	declare function CheckTokenMembershipEx(byval TokenHandle as HANDLE, byval SidToCheck as PSID, byval Flags as DWORD, byval IsMember as PBOOL) as WINBOOL
#endif

declare function ConvertToAutoInheritPrivateObjectSecurity(byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval CurrentSecurityDescriptor as PSECURITY_DESCRIPTOR, byval NewSecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval ObjectType as GUID ptr, byval IsDirectoryObject as WINBOOLEAN, byval GenericMapping as PGENERIC_MAPPING) as WINBOOL
declare function CopySid(byval nDestinationSidLength as DWORD, byval pDestinationSid as PSID, byval pSourceSid as PSID) as WINBOOL
declare function CreatePrivateObjectSecurity(byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval CreatorDescriptor as PSECURITY_DESCRIPTOR, byval NewDescriptor as PSECURITY_DESCRIPTOR ptr, byval IsDirectoryObject as WINBOOL, byval Token as HANDLE, byval GenericMapping as PGENERIC_MAPPING) as WINBOOL
declare function CreatePrivateObjectSecurityEx(byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval CreatorDescriptor as PSECURITY_DESCRIPTOR, byval NewDescriptor as PSECURITY_DESCRIPTOR ptr, byval ObjectType as GUID ptr, byval IsContainerObject as WINBOOL, byval AutoInheritFlags as ULONG, byval Token as HANDLE, byval GenericMapping as PGENERIC_MAPPING) as WINBOOL
declare function CreatePrivateObjectSecurityWithMultipleInheritance(byval ParentDescriptor as PSECURITY_DESCRIPTOR, byval CreatorDescriptor as PSECURITY_DESCRIPTOR, byval NewDescriptor as PSECURITY_DESCRIPTOR ptr, byval ObjectTypes as GUID ptr ptr, byval GuidCount as ULONG, byval IsContainerObject as WINBOOL, byval AutoInheritFlags as ULONG, byval Token as HANDLE, byval GenericMapping as PGENERIC_MAPPING) as WINBOOL
declare function CreateRestrictedToken(byval ExistingTokenHandle as HANDLE, byval Flags as DWORD, byval DisableSidCount as DWORD, byval SidsToDisable as PSID_AND_ATTRIBUTES, byval DeletePrivilegeCount as DWORD, byval PrivilegesToDelete as PLUID_AND_ATTRIBUTES, byval RestrictedSidCount as DWORD, byval SidsToRestrict as PSID_AND_ATTRIBUTES, byval NewTokenHandle as PHANDLE) as WINBOOL
declare function CreateWellKnownSid(byval WellKnownSidType as WELL_KNOWN_SID_TYPE, byval DomainSid as PSID, byval pSid as PSID, byval cbSid as DWORD ptr) as WINBOOL
declare function EqualDomainSid(byval pSid1 as PSID, byval pSid2 as PSID, byval pfEqual as WINBOOL ptr) as WINBOOL
declare function DeleteAce(byval pAcl as PACL, byval dwAceIndex as DWORD) as WINBOOL
declare function DestroyPrivateObjectSecurity(byval ObjectDescriptor as PSECURITY_DESCRIPTOR ptr) as WINBOOL
declare function DuplicateToken(byval ExistingTokenHandle as HANDLE, byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL, byval DuplicateTokenHandle as PHANDLE) as WINBOOL
declare function DuplicateTokenEx(byval hExistingToken as HANDLE, byval dwDesiredAccess as DWORD, byval lpTokenAttributes as LPSECURITY_ATTRIBUTES, byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL, byval TokenType as TOKEN_TYPE, byval phNewToken as PHANDLE) as WINBOOL
declare function EqualPrefixSid(byval pSid1 as PSID, byval pSid2 as PSID) as WINBOOL
declare function EqualSid(byval pSid1 as PSID, byval pSid2 as PSID) as WINBOOL
declare function FindFirstFreeAce(byval pAcl as PACL, byval pAce as LPVOID ptr) as WINBOOL
declare function FreeSid(byval pSid as PSID) as PVOID
declare function GetAce(byval pAcl as PACL, byval dwAceIndex as DWORD, byval pAce as LPVOID ptr) as WINBOOL
declare function GetAclInformation(byval pAcl as PACL, byval pAclInformation as LPVOID, byval nAclInformationLength as DWORD, byval dwAclInformationClass as ACL_INFORMATION_CLASS) as WINBOOL
declare function GetFileSecurityW(byval lpFileName as LPCWSTR, byval RequestedInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetFileSecurity alias "GetFileSecurityW"(byval lpFileName as LPCWSTR, byval RequestedInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
#endif

declare function GetKernelObjectSecurity(byval Handle as HANDLE, byval RequestedInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
declare function GetLengthSid(byval pSid as PSID) as DWORD
declare function GetPrivateObjectSecurity(byval ObjectDescriptor as PSECURITY_DESCRIPTOR, byval SecurityInformation as SECURITY_INFORMATION, byval ResultantDescriptor as PSECURITY_DESCRIPTOR, byval DescriptorLength as DWORD, byval ReturnLength as PDWORD) as WINBOOL
declare function GetSecurityDescriptorControl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pControl as PSECURITY_DESCRIPTOR_CONTROL, byval lpdwRevision as LPDWORD) as WINBOOL
declare function GetSecurityDescriptorDacl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval lpbDaclPresent as LPBOOL, byval pDacl as PACL ptr, byval lpbDaclDefaulted as LPBOOL) as WINBOOL
declare function GetSecurityDescriptorGroup(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pGroup as PSID ptr, byval lpbGroupDefaulted as LPBOOL) as WINBOOL
declare function GetSecurityDescriptorLength(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as DWORD
declare function GetSecurityDescriptorOwner(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pOwner as PSID ptr, byval lpbOwnerDefaulted as LPBOOL) as WINBOOL
declare function GetSecurityDescriptorRMControl(byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval RMControl as PUCHAR) as DWORD
declare function GetSecurityDescriptorSacl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval lpbSaclPresent as LPBOOL, byval pSacl as PACL ptr, byval lpbSaclDefaulted as LPBOOL) as WINBOOL
declare function GetSidIdentifierAuthority(byval pSid as PSID) as PSID_IDENTIFIER_AUTHORITY
declare function GetSidLengthRequired(byval nSubAuthorityCount as UCHAR) as DWORD
declare function GetSidSubAuthority(byval pSid as PSID, byval nSubAuthority as DWORD) as PDWORD
declare function GetSidSubAuthorityCount(byval pSid as PSID) as PUCHAR
declare function GetTokenInformation(byval TokenHandle as HANDLE, byval TokenInformationClass as TOKEN_INFORMATION_CLASS, byval TokenInformation as LPVOID, byval TokenInformationLength as DWORD, byval ReturnLength as PDWORD) as WINBOOL
declare function GetWindowsAccountDomainSid(byval pSid as PSID, byval pDomainSid as PSID, byval cbDomainSid as DWORD ptr) as WINBOOL
declare function ImpersonateAnonymousToken(byval ThreadHandle as HANDLE) as WINBOOL
declare function ImpersonateLoggedOnUser(byval hToken as HANDLE) as WINBOOL
declare function ImpersonateSelf(byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL) as WINBOOL
declare function InitializeAcl(byval pAcl as PACL, byval nAclLength as DWORD, byval dwAclRevision as DWORD) as WINBOOL
declare function InitializeSecurityDescriptor(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval dwRevision as DWORD) as WINBOOL
declare function InitializeSid(byval Sid as PSID, byval pIdentifierAuthority as PSID_IDENTIFIER_AUTHORITY, byval nSubAuthorityCount as UBYTE) as WINBOOL
declare function IsTokenRestricted(byval TokenHandle as HANDLE) as WINBOOL
declare function IsValidAcl(byval pAcl as PACL) as WINBOOL
declare function IsValidSecurityDescriptor(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
declare function IsValidSid(byval pSid as PSID) as WINBOOL
declare function IsWellKnownSid(byval pSid as PSID, byval WellKnownSidType as WELL_KNOWN_SID_TYPE) as WINBOOL
declare function MakeAbsoluteSD(byval pSelfRelativeSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pAbsoluteSecurityDescriptor as PSECURITY_DESCRIPTOR, byval lpdwAbsoluteSecurityDescriptorSize as LPDWORD, byval pDacl as PACL, byval lpdwDaclSize as LPDWORD, byval pSacl as PACL, byval lpdwSaclSize as LPDWORD, byval pOwner as PSID, byval lpdwOwnerSize as LPDWORD, byval pPrimaryGroup as PSID, byval lpdwPrimaryGroupSize as LPDWORD) as WINBOOL
declare function MakeSelfRelativeSD(byval pAbsoluteSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pSelfRelativeSecurityDescriptor as PSECURITY_DESCRIPTOR, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare sub MapGenericMask(byval AccessMask as PDWORD, byval GenericMapping as PGENERIC_MAPPING)
declare function ObjectCloseAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function ObjectCloseAuditAlarm alias "ObjectCloseAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
#endif

declare function ObjectDeleteAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function ObjectDeleteAuditAlarm alias "ObjectDeleteAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
#endif

declare function ObjectOpenAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPWSTR, byval ObjectName as LPWSTR, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval GrantedAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval ObjectCreation as WINBOOL, byval AccessGranted as WINBOOL, byval GenerateOnClose as LPBOOL) as WINBOOL

#ifdef UNICODE
	declare function ObjectOpenAuditAlarm alias "ObjectOpenAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPWSTR, byval ObjectName as LPWSTR, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval GrantedAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval ObjectCreation as WINBOOL, byval AccessGranted as WINBOOL, byval GenerateOnClose as LPBOOL) as WINBOOL
#endif

declare function ObjectPrivilegeAuditAlarmW(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function ObjectPrivilegeAuditAlarm alias "ObjectPrivilegeAuditAlarmW"(byval SubsystemName as LPCWSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
#endif

declare function PrivilegeCheck(byval ClientToken as HANDLE, byval RequiredPrivileges as PPRIVILEGE_SET, byval pfResult as LPBOOL) as WINBOOL
declare function PrivilegedServiceAuditAlarmW(byval SubsystemName as LPCWSTR, byval ServiceName as LPCWSTR, byval ClientToken as HANDLE, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function PrivilegedServiceAuditAlarm alias "PrivilegedServiceAuditAlarmW"(byval SubsystemName as LPCWSTR, byval ServiceName as LPCWSTR, byval ClientToken as HANDLE, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare sub QuerySecurityAccessMask(byval SecurityInformation as SECURITY_INFORMATION, byval DesiredAccess as LPDWORD)
#endif

declare function RevertToSelf() as WINBOOL
declare function SetAclInformation(byval pAcl as PACL, byval pAclInformation as LPVOID, byval nAclInformationLength as DWORD, byval dwAclInformationClass as ACL_INFORMATION_CLASS) as WINBOOL
declare function SetFileSecurityW(byval lpFileName as LPCWSTR, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL

#ifdef UNICODE
	declare function SetFileSecurity alias "SetFileSecurityW"(byval lpFileName as LPCWSTR, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
#endif

declare function SetKernelObjectSecurity(byval Handle as HANDLE, byval SecurityInformation as SECURITY_INFORMATION, byval SecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
declare function SetPrivateObjectSecurity(byval SecurityInformation as SECURITY_INFORMATION, byval ModificationDescriptor as PSECURITY_DESCRIPTOR, byval ObjectsSecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval GenericMapping as PGENERIC_MAPPING, byval Token as HANDLE) as WINBOOL
declare function SetPrivateObjectSecurityEx(byval SecurityInformation as SECURITY_INFORMATION, byval ModificationDescriptor as PSECURITY_DESCRIPTOR, byval ObjectsSecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval AutoInheritFlags as ULONG, byval GenericMapping as PGENERIC_MAPPING, byval Token as HANDLE) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare sub SetSecurityAccessMask(byval SecurityInformation as SECURITY_INFORMATION, byval DesiredAccess as LPDWORD)
#endif

declare function SetSecurityDescriptorControl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ControlBitsOfInterest as SECURITY_DESCRIPTOR_CONTROL, byval ControlBitsToSet as SECURITY_DESCRIPTOR_CONTROL) as WINBOOL
declare function SetSecurityDescriptorDacl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval bDaclPresent as WINBOOL, byval pDacl as PACL, byval bDaclDefaulted as WINBOOL) as WINBOOL
declare function SetSecurityDescriptorGroup(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pGroup as PSID, byval bGroupDefaulted as WINBOOL) as WINBOOL
declare function SetSecurityDescriptorOwner(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pOwner as PSID, byval bOwnerDefaulted as WINBOOL) as WINBOOL
declare function SetSecurityDescriptorRMControl(byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval RMControl as PUCHAR) as DWORD
declare function SetSecurityDescriptorSacl(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval bSaclPresent as WINBOOL, byval pSacl as PACL, byval bSaclDefaulted as WINBOOL) as WINBOOL
declare function SetTokenInformation(byval TokenHandle as HANDLE, byval TokenInformationClass as TOKEN_INFORMATION_CLASS, byval TokenInformation as LPVOID, byval TokenInformationLength as DWORD) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function SetCachedSigningLevel(byval SourceFiles as PHANDLE, byval SourceFileCount as ULONG, byval Flags as ULONG, byval TargetFile as HANDLE) as WINBOOL
	declare function GetCachedSigningLevel(byval File as HANDLE, byval Flags as PULONG, byval SigningLevel as PULONG, byval Thumbprint as PUCHAR, byval ThumbprintSize as PULONG, byval ThumbprintAlgorithm as PULONG) as WINBOOL
#endif

#define _SYNCHAPI_H_
#define SRWLOCK_INIT RTL_SRWLOCK_INIT
#define INIT_ONCE_STATIC_INIT RTL_RUN_ONCE_INIT
const INIT_ONCE_CHECK_ONLY = RTL_RUN_ONCE_CHECK_ONLY
const INIT_ONCE_ASYNC = RTL_RUN_ONCE_ASYNC
const INIT_ONCE_INIT_FAILED = RTL_RUN_ONCE_INIT_FAILED
const INIT_ONCE_CTX_RESERVED_BITS = RTL_RUN_ONCE_CTX_RESERVED_BITS
#define CONDITION_VARIABLE_INIT RTL_CONDITION_VARIABLE_INIT
const CONDITION_VARIABLE_LOCKMODE_SHARED = RTL_CONDITION_VARIABLE_LOCKMODE_SHARED
const MUTEX_MODIFY_STATE = MUTANT_QUERY_STATE
const MUTEX_ALL_ACCESS = MUTANT_ALL_ACCESS

type SRWLOCK as RTL_SRWLOCK
type PSRWLOCK as RTL_SRWLOCK ptr
type INIT_ONCE as RTL_RUN_ONCE
type PINIT_ONCE as PRTL_RUN_ONCE
type LPINIT_ONCE as PRTL_RUN_ONCE
type PINIT_ONCE_FN as function(byval InitOnce as PINIT_ONCE, byval Parameter as PVOID, byval Context as PVOID ptr) as WINBOOL
type CONDITION_VARIABLE as RTL_CONDITION_VARIABLE
type PCONDITION_VARIABLE as RTL_CONDITION_VARIABLE ptr

declare sub EnterCriticalSection(byval lpCriticalSection as LPCRITICAL_SECTION)
declare sub LeaveCriticalSection(byval lpCriticalSection as LPCRITICAL_SECTION)
declare function TryEnterCriticalSection(byval lpCriticalSection as LPCRITICAL_SECTION) as WINBOOL
declare sub DeleteCriticalSection(byval lpCriticalSection as LPCRITICAL_SECTION)
declare function SetEvent(byval hEvent as HANDLE) as WINBOOL
declare function ResetEvent(byval hEvent as HANDLE) as WINBOOL
declare function ReleaseSemaphore(byval hSemaphore as HANDLE, byval lReleaseCount as LONG, byval lpPreviousCount as LPLONG) as WINBOOL
declare function ReleaseMutex(byval hMutex as HANDLE) as WINBOOL
declare function WaitForSingleObjectEx(byval hHandle as HANDLE, byval dwMilliseconds as DWORD, byval bAlertable as WINBOOL) as DWORD
declare function WaitForMultipleObjectsEx(byval nCount as DWORD, byval lpHandles as const HANDLE ptr, byval bWaitAll as WINBOOL, byval dwMilliseconds as DWORD, byval bAlertable as WINBOOL) as DWORD
declare function OpenMutexW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function OpenEventA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function OpenEventW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function OpenSemaphoreW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function WaitOnAddress(byval Address as any ptr, byval CompareAddress as PVOID, byval AddressSize as SIZE_T_, byval dwMilliseconds as DWORD) as WINBOOL
declare sub WakeByAddressSingle(byval Address as PVOID)
declare sub WakeByAddressAll(byval Address as PVOID)

#if _WIN32_WINNT >= &h0600
	const CREATE_MUTEX_INITIAL_OWNER = &h1
	const CREATE_EVENT_MANUAL_RESET = &h1
	const CREATE_EVENT_INITIAL_SET = &h2

	declare sub InitializeSRWLock(byval SRWLock as PSRWLOCK)
	declare sub ReleaseSRWLockExclusive(byval SRWLock as PSRWLOCK)
	declare sub ReleaseSRWLockShared(byval SRWLock as PSRWLOCK)
	declare sub AcquireSRWLockExclusive(byval SRWLock as PSRWLOCK)
	declare sub AcquireSRWLockShared(byval SRWLock as PSRWLOCK)
	declare function TryAcquireSRWLockExclusive(byval SRWLock as PSRWLOCK) as WINBOOLEAN
	declare function TryAcquireSRWLockShared(byval SRWLock as PSRWLOCK) as WINBOOLEAN
	declare function InitializeCriticalSectionEx(byval lpCriticalSection as LPCRITICAL_SECTION, byval dwSpinCount as DWORD, byval Flags as DWORD) as WINBOOL
	declare sub InitOnceInitialize(byval InitOnce as PINIT_ONCE)
	declare function InitOnceExecuteOnce(byval InitOnce as PINIT_ONCE, byval InitFn as PINIT_ONCE_FN, byval Parameter as PVOID, byval Context as LPVOID ptr) as WINBOOL
	declare function InitOnceBeginInitialize(byval lpInitOnce as LPINIT_ONCE, byval dwFlags as DWORD, byval fPending as PBOOL, byval lpContext as LPVOID ptr) as WINBOOL
	declare function InitOnceComplete(byval lpInitOnce as LPINIT_ONCE, byval dwFlags as DWORD, byval lpContext as LPVOID) as WINBOOL
	declare sub InitializeConditionVariable(byval ConditionVariable as PCONDITION_VARIABLE)
	declare sub WakeConditionVariable(byval ConditionVariable as PCONDITION_VARIABLE)
	declare sub WakeAllConditionVariable(byval ConditionVariable as PCONDITION_VARIABLE)
	declare function SleepConditionVariableCS(byval ConditionVariable as PCONDITION_VARIABLE, byval CriticalSection as PCRITICAL_SECTION, byval dwMilliseconds as DWORD) as WINBOOL
	declare function SleepConditionVariableSRW(byval ConditionVariable as PCONDITION_VARIABLE, byval SRWLock as PSRWLOCK, byval dwMilliseconds as DWORD, byval Flags as ULONG) as WINBOOL
	declare function CreateMutexExA(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateMutexExW(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateEventExA(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateEventExW(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateSemaphoreExW(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
#endif

#ifdef UNICODE
	#if _WIN32_WINNT >= &h0600
		declare function CreateMutexEx alias "CreateMutexExW"(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
		declare function CreateEventEx alias "CreateEventExW"(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
		declare function CreateSemaphoreEx alias "CreateSemaphoreExW"(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	#endif

	declare function OpenMutex alias "OpenMutexW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
	declare function OpenSemaphore alias "OpenSemaphoreW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
	declare function OpenEvent alias "OpenEventW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function CreateMutexEx alias "CreateMutexExA"(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateEventEx alias "CreateEventExA"(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
#endif

#ifndef UNICODE
	declare function OpenEvent alias "OpenEventA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
#endif

type PTIMERAPCROUTINE as sub(byval lpArgToCompletionRoutine as LPVOID, byval dwTimerLowValue as DWORD, byval dwTimerHighValue as DWORD)
type SYNCHRONIZATION_BARRIER as RTL_BARRIER
type PSYNCHRONIZATION_BARRIER as PRTL_BARRIER
type LPSYNCHRONIZATION_BARRIER as PRTL_BARRIER

const SYNCHRONIZATION_BARRIER_FLAGS_SPIN_ONLY = &h01
const SYNCHRONIZATION_BARRIER_FLAGS_BLOCK_ONLY = &h02
const SYNCHRONIZATION_BARRIER_FLAGS_NO_DELETE = &h04

declare sub InitializeCriticalSection(byval lpCriticalSection as LPCRITICAL_SECTION)
declare function InitializeCriticalSectionAndSpinCount(byval lpCriticalSection as LPCRITICAL_SECTION, byval dwSpinCount as DWORD) as WINBOOL
declare function SetCriticalSectionSpinCount(byval lpCriticalSection as LPCRITICAL_SECTION, byval dwSpinCount as DWORD) as DWORD
declare function WaitForSingleObject(byval hHandle as HANDLE, byval dwMilliseconds as DWORD) as DWORD
declare function SleepEx(byval dwMilliseconds as DWORD, byval bAlertable as WINBOOL) as DWORD
declare function CreateMutexA(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval bInitialOwner as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function CreateMutexW(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval bInitialOwner as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function CreateEventA(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval bInitialState as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function CreateEventW(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval bInitialState as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function SetWaitableTimer(byval hTimer as HANDLE, byval lpDueTime as const LARGE_INTEGER ptr, byval lPeriod as LONG, byval pfnCompletionRoutine as PTIMERAPCROUTINE, byval lpArgToCompletionRoutine as LPVOID, byval fResume as WINBOOL) as WINBOOL
declare function CancelWaitableTimer(byval hTimer as HANDLE) as WINBOOL
declare function OpenWaitableTimerW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpTimerName as LPCWSTR) as HANDLE
declare function EnterSynchronizationBarrier(byval lpBarrier as LPSYNCHRONIZATION_BARRIER, byval dwFlags as DWORD) as WINBOOL
declare function InitializeSynchronizationBarrier(byval lpBarrier as LPSYNCHRONIZATION_BARRIER, byval lTotalThreads as LONG, byval lSpinCount as LONG) as WINBOOL
declare function DeleteSynchronizationBarrier(byval lpBarrier as LPSYNCHRONIZATION_BARRIER) as WINBOOL
declare sub Sleep_ alias "Sleep"(byval dwMilliseconds as DWORD)
declare function SignalObjectAndWait(byval hObjectToSignal as HANDLE, byval hObjectToWaitOn as HANDLE, byval dwMilliseconds as DWORD, byval bAlertable as WINBOOL) as DWORD

#if _WIN32_WINNT >= &h0600
	const CREATE_WAITABLE_TIMER_MANUAL_RESET = &h1
	declare function CreateWaitableTimerExW(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval lpTimerName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateWaitableTimerEx alias "CreateWaitableTimerExW"(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval lpTimerName as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
#endif

#if _WIN32_WINNT >= &h0601
	declare function SetWaitableTimerEx(byval hTimer as HANDLE, byval lpDueTime as const LARGE_INTEGER ptr, byval lPeriod as LONG, byval pfnCompletionRoutine as PTIMERAPCROUTINE, byval lpArgToCompletionRoutine as LPVOID, byval WakeContext as PREASON_CONTEXT, byval TolerableDelay as ULONG) as WINBOOL
#endif

#ifdef UNICODE
	declare function CreateMutex alias "CreateMutexW"(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval bInitialOwner as WINBOOL, byval lpName as LPCWSTR) as HANDLE
	declare function CreateEvent alias "CreateEventW"(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval bInitialState as WINBOOL, byval lpName as LPCWSTR) as HANDLE
	declare function OpenWaitableTimer alias "OpenWaitableTimerW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpTimerName as LPCWSTR) as HANDLE
#else
	declare function CreateMutex alias "CreateMutexA"(byval lpMutexAttributes as LPSECURITY_ATTRIBUTES, byval bInitialOwner as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function CreateEvent alias "CreateEventA"(byval lpEventAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval bInitialState as WINBOOL, byval lpName as LPCSTR) as HANDLE
#endif

#define _SYSINFOAPI_H_

type _SYSTEM_INFO
	union
		dwOemId as DWORD

		type
			wProcessorArchitecture as WORD
			wReserved as WORD
		end type
	end union

	dwPageSize as DWORD
	lpMinimumApplicationAddress as LPVOID
	lpMaximumApplicationAddress as LPVOID
	dwActiveProcessorMask as DWORD_PTR
	dwNumberOfProcessors as DWORD
	dwProcessorType as DWORD
	dwAllocationGranularity as DWORD
	wProcessorLevel as WORD
	wProcessorRevision as WORD
end type

type SYSTEM_INFO as _SYSTEM_INFO
type LPSYSTEM_INFO as _SYSTEM_INFO ptr
declare sub GetSystemTime(byval lpSystemTime as LPSYSTEMTIME)
declare sub GetSystemTimeAsFileTime(byval lpSystemTimeAsFileTime as LPFILETIME)
declare sub GetLocalTime(byval lpSystemTime as LPSYSTEMTIME)
declare sub GetNativeSystemInfo(byval lpSystemInfo as LPSYSTEM_INFO)

#if _WIN32_WINNT >= &h0600
	declare function GetTickCount64() as ULONGLONG
#endif

declare function GetVersion() as DWORD

type _MEMORYSTATUSEX
	dwLength as DWORD
	dwMemoryLoad as DWORD
	ullTotalPhys as DWORDLONG
	ullAvailPhys as DWORDLONG
	ullTotalPageFile as DWORDLONG
	ullAvailPageFile as DWORDLONG
	ullTotalVirtual as DWORDLONG
	ullAvailVirtual as DWORDLONG
	ullAvailExtendedVirtual as DWORDLONG
end type

type MEMORYSTATUSEX as _MEMORYSTATUSEX
type LPMEMORYSTATUSEX as _MEMORYSTATUSEX ptr

type _COMPUTER_NAME_FORMAT as long
enum
	ComputerNameNetBIOS
	ComputerNameDnsHostname
	ComputerNameDnsDomain
	ComputerNameDnsFullyQualified
	ComputerNamePhysicalNetBIOS
	ComputerNamePhysicalDnsHostname
	ComputerNamePhysicalDnsDomain
	ComputerNamePhysicalDnsFullyQualified
	ComputerNameMax
end enum

type COMPUTER_NAME_FORMAT as _COMPUTER_NAME_FORMAT
declare function GlobalMemoryStatusEx(byval lpBuffer as LPMEMORYSTATUSEX) as WINBOOL
declare function SetLocalTime(byval lpSystemTime as const SYSTEMTIME ptr) as WINBOOL
declare sub GetSystemInfo(byval lpSystemInfo as LPSYSTEM_INFO)
declare function GetTickCount() as DWORD
declare function GetSystemTimeAdjustment(byval lpTimeAdjustment as PDWORD, byval lpTimeIncrement as PDWORD, byval lpTimeAdjustmentDisabled as PBOOL) as WINBOOL
declare function GetSystemDirectoryA(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
declare function GetSystemDirectoryW(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
declare function GetWindowsDirectoryA(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
declare function GetWindowsDirectoryW(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
declare function GetSystemWindowsDirectoryA(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
declare function GetSystemWindowsDirectoryW(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
declare function GetComputerNameExA(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPSTR, byval nSize as LPDWORD) as WINBOOL
declare function GetComputerNameExW(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPWSTR, byval nSize as LPDWORD) as WINBOOL
declare function SetComputerNameExW(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPCWSTR) as WINBOOL
declare function SetSystemTime(byval lpSystemTime as const SYSTEMTIME ptr) as WINBOOL
declare function GetVersionExA(byval lpVersionInformation as LPOSVERSIONINFOA) as WINBOOL
declare function GetVersionExW(byval lpVersionInformation as LPOSVERSIONINFOW) as WINBOOL
declare function GetLogicalProcessorInformation(byval Buffer as PSYSTEM_LOGICAL_PROCESSOR_INFORMATION, byval ReturnedLength as PDWORD) as WINBOOL
declare sub GetSystemTimePreciseAsFileTime(byval lpSystemTimeAsFileTime as LPFILETIME)
declare function EnumSystemFirmwareTables(byval FirmwareTableProviderSignature as DWORD, byval pFirmwareTableEnumBuffer as PVOID, byval BufferSize as DWORD) as UINT
declare function GetSystemFirmwareTable(byval FirmwareTableProviderSignature as DWORD, byval FirmwareTableID as DWORD, byval pFirmwareTableBuffer as PVOID, byval BufferSize as DWORD) as UINT

#if _WIN32_WINNT >= &h0600
	declare function GetProductInfo(byval dwOSMajorVersion as DWORD, byval dwOSMinorVersion as DWORD, byval dwSpMajorVersion as DWORD, byval dwSpMinorVersion as DWORD, byval pdwReturnedProductType as PDWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function GetLogicalProcessorInformationEx(byval RelationshipType as LOGICAL_PROCESSOR_RELATIONSHIP, byval Buffer as PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX, byval ReturnedLength as PDWORD) as WINBOOL
	declare function GetOsSafeBootMode(byval Flags as PDWORD) as WINBOOL
#endif

#ifdef UNICODE
	declare function GetSystemDirectory alias "GetSystemDirectoryW"(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
	declare function GetWindowsDirectory alias "GetWindowsDirectoryW"(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
	declare function GetSystemWindowsDirectory alias "GetSystemWindowsDirectoryW"(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
	declare function GetComputerNameEx alias "GetComputerNameExW"(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPWSTR, byval nSize as LPDWORD) as WINBOOL
	declare function GetVersionEx alias "GetVersionExW"(byval lpVersionInformation as LPOSVERSIONINFOW) as WINBOOL
	declare function SetComputerNameEx alias "SetComputerNameExW"(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPCWSTR) as WINBOOL
#else
	declare function GetSystemDirectory alias "GetSystemDirectoryA"(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
	declare function GetWindowsDirectory alias "GetWindowsDirectoryA"(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
	declare function GetSystemWindowsDirectory alias "GetSystemWindowsDirectoryA"(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
	declare function GetComputerNameEx alias "GetComputerNameExA"(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPSTR, byval nSize as LPDWORD) as WINBOOL
	declare function GetVersionEx alias "GetVersionExA"(byval lpVersionInformation as LPOSVERSIONINFOA) as WINBOOL
#endif

#define _SYSTEMTOPOLOGY_H_
declare function GetNumaHighestNodeNumber(byval HighestNodeNumber as PULONG) as WINBOOL

#if _WIN32_WINNT >= &h0601
	declare function GetNumaNodeProcessorMaskEx(byval Node as USHORT, byval ProcessorMask as PGROUP_AFFINITY) as WINBOOL
#endif

#define _THREADPOOLAPISET_H_
type PTP_WIN32_IO_CALLBACK as sub(byval Instance as PTP_CALLBACK_INSTANCE, byval Context as PVOID, byval Overlapped as PVOID, byval IoResult as ULONG, byval NumberOfBytesTransferred as ULONG_PTR, byval Io as PTP_IO)

#if _WIN32_WINNT >= &h0600
	declare function CreateThreadpool(byval reserved as PVOID) as PTP_POOL
	declare sub SetThreadpoolThreadMaximum(byval ptpp as PTP_POOL, byval cthrdMost as DWORD)
	declare function SetThreadpoolThreadMinimum(byval ptpp as PTP_POOL, byval cthrdMic as DWORD) as WINBOOL
	declare function SetThreadpoolStackInformation(byval ptpp as PTP_POOL, byval ptpsi as PTP_POOL_STACK_INFORMATION) as WINBOOL
	declare function QueryThreadpoolStackInformation(byval ptpp as PTP_POOL, byval ptpsi as PTP_POOL_STACK_INFORMATION) as WINBOOL
	declare sub CloseThreadpool(byval ptpp as PTP_POOL)
	declare function CreateThreadpoolCleanupGroup() as PTP_CLEANUP_GROUP
	declare sub CloseThreadpoolCleanupGroupMembers(byval ptpcg as PTP_CLEANUP_GROUP, byval fCancelPendingCallbacks as WINBOOL, byval pvCleanupContext as PVOID)
	declare sub CloseThreadpoolCleanupGroup(byval ptpcg as PTP_CLEANUP_GROUP)
	declare sub SetEventWhenCallbackReturns(byval pci as PTP_CALLBACK_INSTANCE, byval evt as HANDLE)
	declare sub ReleaseSemaphoreWhenCallbackReturns(byval pci as PTP_CALLBACK_INSTANCE, byval sem as HANDLE, byval crel as DWORD)
	declare sub ReleaseMutexWhenCallbackReturns(byval pci as PTP_CALLBACK_INSTANCE, byval mut as HANDLE)
	declare sub LeaveCriticalSectionWhenCallbackReturns(byval pci as PTP_CALLBACK_INSTANCE, byval pcs as PCRITICAL_SECTION)
	declare sub FreeLibraryWhenCallbackReturns(byval pci as PTP_CALLBACK_INSTANCE, byval mod_ as HMODULE)
	declare function CallbackMayRunLong(byval pci as PTP_CALLBACK_INSTANCE) as WINBOOL
	declare sub DisassociateCurrentThreadFromCallback(byval pci as PTP_CALLBACK_INSTANCE)
	declare function TrySubmitThreadpoolCallback(byval pfns as PTP_SIMPLE_CALLBACK, byval pv as PVOID, byval pcbe as PTP_CALLBACK_ENVIRON) as WINBOOL
	declare function CreateThreadpoolWork(byval pfnwk as PTP_WORK_CALLBACK, byval pv as PVOID, byval pcbe as PTP_CALLBACK_ENVIRON) as PTP_WORK
	declare sub SubmitThreadpoolWork(byval pwk as PTP_WORK)
	declare sub WaitForThreadpoolWorkCallbacks(byval pwk as PTP_WORK, byval fCancelPendingCallbacks as WINBOOL)
	declare sub CloseThreadpoolWork(byval pwk as PTP_WORK)
	declare function CreateThreadpoolTimer(byval pfnti as PTP_TIMER_CALLBACK, byval pv as PVOID, byval pcbe as PTP_CALLBACK_ENVIRON) as PTP_TIMER
	declare sub SetThreadpoolTimer(byval pti as PTP_TIMER, byval pftDueTime as PFILETIME, byval msPeriod as DWORD, byval msWindowLength as DWORD)
	declare function IsThreadpoolTimerSet(byval pti as PTP_TIMER) as WINBOOL
	declare sub WaitForThreadpoolTimerCallbacks(byval pti as PTP_TIMER, byval fCancelPendingCallbacks as WINBOOL)
	declare sub CloseThreadpoolTimer(byval pti as PTP_TIMER)
	declare function CreateThreadpoolWait(byval pfnwa as PTP_WAIT_CALLBACK, byval pv as PVOID, byval pcbe as PTP_CALLBACK_ENVIRON) as PTP_WAIT
	declare sub SetThreadpoolWait(byval pwa as PTP_WAIT, byval h as HANDLE, byval pftTimeout as PFILETIME)
	declare sub WaitForThreadpoolWaitCallbacks(byval pwa as PTP_WAIT, byval fCancelPendingCallbacks as WINBOOL)
	declare sub CloseThreadpoolWait(byval pwa as PTP_WAIT)
	declare function CreateThreadpoolIo(byval fl as HANDLE, byval pfnio as PTP_WIN32_IO_CALLBACK, byval pv as PVOID, byval pcbe as PTP_CALLBACK_ENVIRON) as PTP_IO
	declare sub StartThreadpoolIo(byval pio as PTP_IO)
	declare sub CancelThreadpoolIo(byval pio as PTP_IO)
	declare sub WaitForThreadpoolIoCallbacks(byval pio as PTP_IO, byval fCancelPendingCallbacks as WINBOOL)
	declare sub CloseThreadpoolIo(byval pio as PTP_IO)
	declare function SetThreadpoolTimerEx(byval pti as PTP_TIMER, byval pftDueTime as PFILETIME, byval msPeriod as DWORD, byval msWindowLength as DWORD) as WINBOOL
	declare function SetThreadpoolWaitEx(byval pwa as PTP_WAIT, byval h as HANDLE, byval pftTimeout as PFILETIME, byval Reserved as PVOID) as WINBOOL
#endif

#define _THREADPOOLLEGACYAPISET_H_
declare function CreateTimerQueueTimer(byval phNewTimer as PHANDLE, byval TimerQueue as HANDLE, byval Callback as WAITORTIMERCALLBACK, byval Parameter as PVOID, byval DueTime as DWORD, byval Period as DWORD, byval Flags as ULONG) as WINBOOL
declare function DeleteTimerQueueTimer(byval TimerQueue as HANDLE, byval Timer as HANDLE, byval CompletionEvent as HANDLE) as WINBOOL
declare function QueueUserWorkItem(byval Function as LPTHREAD_START_ROUTINE, byval Context as PVOID, byval Flags as ULONG) as WINBOOL
declare function UnregisterWaitEx(byval WaitHandle as HANDLE, byval CompletionEvent as HANDLE) as WINBOOL
declare function CreateTimerQueue() as HANDLE
declare function ChangeTimerQueueTimer(byval TimerQueue as HANDLE, byval Timer as HANDLE, byval DueTime as ULONG, byval Period as ULONG) as WINBOOL
declare function DeleteTimerQueueEx(byval TimerQueue as HANDLE, byval CompletionEvent as HANDLE) as WINBOOL
#define _APISETUTIL_
declare function EncodePointer(byval Ptr as PVOID) as PVOID
declare function DecodePointer(byval Ptr as PVOID) as PVOID
declare function EncodeSystemPointer(byval Ptr as PVOID) as PVOID
declare function DecodeSystemPointer(byval Ptr as PVOID) as PVOID
declare function Beep_ alias "Beep"(byval dwFreq as DWORD, byval dwDuration as DWORD) as WINBOOL
#define _WOW64APISET_H_
declare function Wow64DisableWow64FsRedirection(byval OldValue as PVOID ptr) as WINBOOL
declare function Wow64RevertWow64FsRedirection(byval OlValue as PVOID) as WINBOOL
declare function IsWow64Process(byval hProcess as HANDLE, byval Wow64Process as PBOOL) as WINBOOL

#define GetCurrentTime() GetTickCount()
#define LimitEmsPages(dw)
#define SetSwapAreaSize(w) (w)
#define LockSegment(w) GlobalFix(cast(HANDLE, (w)))
#define UnlockSegment(w) GlobalUnfix(cast(HANDLE, (w)))
#define Yield()
const FILE_BEGIN = 0
const FILE_CURRENT = 1
const FILE_END = 2
const WAIT_FAILED = cast(DWORD, &hffffffff)
const WAIT_OBJECT_0 = STATUS_WAIT_0 + 0
const WAIT_ABANDONED = STATUS_ABANDONED_WAIT_0 + 0
const WAIT_ABANDONED_0 = STATUS_ABANDONED_WAIT_0 + 0
const WAIT_IO_COMPLETION = STATUS_USER_APC
declare function SecureZeroMemory alias "RtlSecureZeroMemory"(byval ptr as PVOID, byval cnt as SIZE_T_) as PVOID
declare function CaptureStackBackTrace alias "RtlCaptureStackBackTrace"(byval FramesToSkip as DWORD, byval FramesToCapture as DWORD, byval BackTrace as PVOID ptr, byval BackTraceHash as PDWORD) as WORD
const FILE_FLAG_WRITE_THROUGH = &h80000000
const FILE_FLAG_OVERLAPPED = &h40000000
const FILE_FLAG_NO_BUFFERING = &h20000000
const FILE_FLAG_RANDOM_ACCESS = &h10000000
const FILE_FLAG_SEQUENTIAL_SCAN = &h8000000
const FILE_FLAG_DELETE_ON_CLOSE = &h4000000
const FILE_FLAG_BACKUP_SEMANTICS = &h2000000
const FILE_FLAG_POSIX_SEMANTICS = &h1000000
const FILE_FLAG_SESSION_AWARE = &h800000
const FILE_FLAG_OPEN_REPARSE_POINT = &h200000
const FILE_FLAG_OPEN_NO_RECALL = &h100000
const FILE_FLAG_FIRST_PIPE_INSTANCE = &h80000

#if _WIN32_WINNT = &h0602
	const FILE_FLAG_OPEN_REQUIRING_OPLOCK = &h40000
#endif

const PROGRESS_CONTINUE = 0
const PROGRESS_CANCEL = 1
const PROGRESS_STOP = 2
const PROGRESS_QUIET = 3
const CALLBACK_CHUNK_FINISHED = &h0
const CALLBACK_STREAM_SWITCH = &h1
const COPY_FILE_FAIL_IF_EXISTS = &h1
const COPY_FILE_RESTARTABLE = &h2
const COPY_FILE_OPEN_SOURCE_FOR_WRITE = &h4
const COPY_FILE_ALLOW_DECRYPTED_DESTINATION = &h8

#if _WIN32_WINNT >= &h0600
	const COPY_FILE_COPY_SYMLINK = &h800
	const COPY_FILE_NO_BUFFERING = &h1000
#endif

#if _WIN32_WINNT = &h0602
	const COPY_FILE_REQUEST_SECURITY_PRIVILEGES = &h2000
	const COPY_FILE_RESUME_FROM_PAUSE = &h4000
	const COPY_FILE_NO_OFFLOAD = &h40000
#endif

const REPLACEFILE_WRITE_THROUGH = &h1
const REPLACEFILE_IGNORE_MERGE_ERRORS = &h2

#if _WIN32_WINNT >= &h0600
	const REPLACEFILE_IGNORE_ACL_ERRORS = &h4
#endif

const PIPE_ACCESS_INBOUND = &h1
const PIPE_ACCESS_OUTBOUND = &h2
const PIPE_ACCESS_DUPLEX = &h3
const PIPE_CLIENT_END = &h0
const PIPE_SERVER_END = &h1
const PIPE_WAIT = &h0
const PIPE_NOWAIT = &h1
const PIPE_READMODE_BYTE = &h0
const PIPE_READMODE_MESSAGE = &h2
const PIPE_TYPE_BYTE = &h0
const PIPE_TYPE_MESSAGE = &h4
const PIPE_ACCEPT_REMOTE_CLIENTS = &h0
const PIPE_REJECT_REMOTE_CLIENTS = &h8
const PIPE_UNLIMITED_INSTANCES = 255
const SECURITY_ANONYMOUS = SecurityAnonymous shl 16
const SECURITY_IDENTIFICATION = SecurityIdentification shl 16
const SECURITY_IMPERSONATION = SecurityImpersonation shl 16
const SECURITY_DELEGATION = SecurityDelegation shl 16
const SECURITY_CONTEXT_TRACKING = &h40000
const SECURITY_EFFECTIVE_ONLY = &h80000
const SECURITY_SQOS_PRESENT = &h100000
const SECURITY_VALID_SQOS_FLAGS = &h1f0000
const FAIL_FAST_GENERATE_EXCEPTION_ADDRESS = &h1
const FAIL_FAST_NO_HARD_ERROR_DLG = &h2
type PFIBER_START_ROUTINE as sub(byval lpFiberParameter as LPVOID)
type LPFIBER_START_ROUTINE as PFIBER_START_ROUTINE

#ifdef __FB_64BIT__
	type LPLDT_ENTRY as LPVOID
#else
	type LPLDT_ENTRY as PLDT_ENTRY
#endif

const SP_SERIALCOMM = cast(DWORD, &h1)
const PST_UNSPECIFIED = cast(DWORD, &h0)
const PST_RS232 = cast(DWORD, &h1)
const PST_PARALLELPORT = cast(DWORD, &h2)
const PST_RS422 = cast(DWORD, &h3)
const PST_RS423 = cast(DWORD, &h4)
const PST_RS449 = cast(DWORD, &h5)
const PST_MODEM = cast(DWORD, &h6)
const PST_FAX = cast(DWORD, &h21)
const PST_SCANNER = cast(DWORD, &h22)
const PST_NETWORK_BRIDGE = cast(DWORD, &h100)
const PST_LAT = cast(DWORD, &h101)
const PST_TCPIP_TELNET = cast(DWORD, &h102)
const PST_X25 = cast(DWORD, &h103)
const PCF_DTRDSR = cast(DWORD, &h1)
const PCF_RTSCTS = cast(DWORD, &h2)
const PCF_RLSD = cast(DWORD, &h4)
const PCF_PARITY_CHECK = cast(DWORD, &h8)
const PCF_XONXOFF = cast(DWORD, &h10)
const PCF_SETXCHAR = cast(DWORD, &h20)
const PCF_TOTALTIMEOUTS = cast(DWORD, &h40)
const PCF_INTTIMEOUTS = cast(DWORD, &h80)
const PCF_SPECIALCHARS = cast(DWORD, &h100)
const PCF_16BITMODE = cast(DWORD, &h200)
const SP_PARITY = cast(DWORD, &h1)
const SP_BAUD = cast(DWORD, &h2)
const SP_DATABITS = cast(DWORD, &h4)
const SP_STOPBITS = cast(DWORD, &h8)
const SP_HANDSHAKING = cast(DWORD, &h10)
const SP_PARITY_CHECK = cast(DWORD, &h20)
const SP_RLSD = cast(DWORD, &h40)
const BAUD_075 = cast(DWORD, &h1)
const BAUD_110 = cast(DWORD, &h2)
const BAUD_134_5 = cast(DWORD, &h4)
const BAUD_150 = cast(DWORD, &h8)
const BAUD_300 = cast(DWORD, &h10)
const BAUD_600 = cast(DWORD, &h20)
const BAUD_1200 = cast(DWORD, &h40)
const BAUD_1800 = cast(DWORD, &h80)
const BAUD_2400 = cast(DWORD, &h100)
const BAUD_4800 = cast(DWORD, &h200)
const BAUD_7200 = cast(DWORD, &h400)
const BAUD_9600 = cast(DWORD, &h800)
const BAUD_14400 = cast(DWORD, &h1000)
const BAUD_19200 = cast(DWORD, &h2000)
const BAUD_38400 = cast(DWORD, &h4000)
const BAUD_56K = cast(DWORD, &h8000)
const BAUD_128K = cast(DWORD, &h10000)
const BAUD_115200 = cast(DWORD, &h20000)
const BAUD_57600 = cast(DWORD, &h40000)
const BAUD_USER = cast(DWORD, &h10000000)
const DATABITS_5 = cast(WORD, &h1)
const DATABITS_6 = cast(WORD, &h2)
const DATABITS_7 = cast(WORD, &h4)
const DATABITS_8 = cast(WORD, &h8)
const DATABITS_16 = cast(WORD, &h10)
const DATABITS_16X = cast(WORD, &h20)
const STOPBITS_10 = cast(WORD, &h1)
const STOPBITS_15 = cast(WORD, &h2)
const STOPBITS_20 = cast(WORD, &h4)
const PARITY_NONE = cast(WORD, &h100)
const PARITY_ODD = cast(WORD, &h200)
const PARITY_EVEN = cast(WORD, &h400)
const PARITY_MARK = cast(WORD, &h800)
const PARITY_SPACE = cast(WORD, &h1000)

type _COMMPROP
	wPacketLength as WORD
	wPacketVersion as WORD
	dwServiceMask as DWORD
	dwReserved1 as DWORD
	dwMaxTxQueue as DWORD
	dwMaxRxQueue as DWORD
	dwMaxBaud as DWORD
	dwProvSubType as DWORD
	dwProvCapabilities as DWORD
	dwSettableParams as DWORD
	dwSettableBaud as DWORD
	wSettableData as WORD
	wSettableStopParity as WORD
	dwCurrentTxQueue as DWORD
	dwCurrentRxQueue as DWORD
	dwProvSpec1 as DWORD
	dwProvSpec2 as DWORD
	wcProvChar as wstring * 1
end type

type COMMPROP as _COMMPROP
type LPCOMMPROP as _COMMPROP ptr
const COMMPROP_INITIALIZED = cast(DWORD, &he73cf52e)

type _COMSTAT
	fCtsHold : 1 as DWORD
	fDsrHold : 1 as DWORD
	fRlsdHold : 1 as DWORD
	fXoffHold : 1 as DWORD
	fXoffSent : 1 as DWORD
	fEof : 1 as DWORD
	fTxim : 1 as DWORD
	fReserved : 25 as DWORD
	cbInQue as DWORD
	cbOutQue as DWORD
end type

type COMSTAT as _COMSTAT
type LPCOMSTAT as _COMSTAT ptr
const DTR_CONTROL_DISABLE = &h0
const DTR_CONTROL_ENABLE = &h1
const DTR_CONTROL_HANDSHAKE = &h2
const RTS_CONTROL_DISABLE = &h0
const RTS_CONTROL_ENABLE = &h1
const RTS_CONTROL_HANDSHAKE = &h2
const RTS_CONTROL_TOGGLE = &h3

type _DCB
	DCBlength as DWORD
	BaudRate as DWORD
	fBinary : 1 as DWORD
	fParity : 1 as DWORD
	fOutxCtsFlow : 1 as DWORD
	fOutxDsrFlow : 1 as DWORD
	fDtrControl : 2 as DWORD
	fDsrSensitivity : 1 as DWORD
	fTXContinueOnXoff : 1 as DWORD
	fOutX : 1 as DWORD
	fInX : 1 as DWORD
	fErrorChar : 1 as DWORD
	fNull : 1 as DWORD
	fRtsControl : 2 as DWORD
	fAbortOnError : 1 as DWORD
	fDummy2 : 17 as DWORD
	wReserved as WORD
	XonLim as WORD
	XoffLim as WORD
	ByteSize as UBYTE
	Parity as UBYTE
	StopBits as UBYTE
	XonChar as byte
	XoffChar as byte
	ErrorChar as byte
	EofChar as byte
	EvtChar as byte
	wReserved1 as WORD
end type

type DCB as _DCB
type LPDCB as _DCB ptr

type _COMMTIMEOUTS
	ReadIntervalTimeout as DWORD
	ReadTotalTimeoutMultiplier as DWORD
	ReadTotalTimeoutConstant as DWORD
	WriteTotalTimeoutMultiplier as DWORD
	WriteTotalTimeoutConstant as DWORD
end type

type COMMTIMEOUTS as _COMMTIMEOUTS
type LPCOMMTIMEOUTS as _COMMTIMEOUTS ptr

type _COMMCONFIG
	dwSize as DWORD
	wVersion as WORD
	wReserved as WORD
	dcb as DCB
	dwProviderSubType as DWORD
	dwProviderOffset as DWORD
	dwProviderSize as DWORD
	wcProviderData as wstring * 1
end type

type COMMCONFIG as _COMMCONFIG
type LPCOMMCONFIG as _COMMCONFIG ptr
#define FreeModule(hLibModule) FreeLibrary((hLibModule))
#define MakeProcInstance(lpProc, hInstance) (lpProc)
#define FreeProcInstance(lpProc) (lpProc)
const GMEM_FIXED = &h0
const GMEM_MOVEABLE = &h2
const GMEM_NOCOMPACT = &h10
const GMEM_NODISCARD = &h20
const GMEM_ZEROINIT = &h40
const GMEM_MODIFY = &h80
const GMEM_DISCARDABLE = &h100
const GMEM_NOT_BANKED = &h1000
const GMEM_SHARE = &h2000
const GMEM_DDESHARE = &h2000
const GMEM_NOTIFY = &h4000
const GMEM_LOWER = GMEM_NOT_BANKED
const GMEM_VALID_FLAGS = &h7f72
const GMEM_INVALID_HANDLE = &h8000
const GHND_ = GMEM_MOVEABLE or GMEM_ZEROINIT
const GPTR_ = GMEM_FIXED or GMEM_ZEROINIT
#define GlobalLRUNewest(h) cast(HANDLE, (h))
#define GlobalLRUOldest(h) cast(HANDLE, (h))
#define GlobalDiscard(h) GlobalReAlloc((h), 0, GMEM_MOVEABLE)
const GMEM_DISCARDED = &h4000
const GMEM_LOCKCOUNT = &h00ff

type _MEMORYSTATUS
	dwLength as DWORD
	dwMemoryLoad as DWORD
	dwTotalPhys as SIZE_T_
	dwAvailPhys as SIZE_T_
	dwTotalPageFile as SIZE_T_
	dwAvailPageFile as SIZE_T_
	dwTotalVirtual as SIZE_T_
	dwAvailVirtual as SIZE_T_
end type

type MEMORYSTATUS as _MEMORYSTATUS
type LPMEMORYSTATUS as _MEMORYSTATUS ptr
const NUMA_NO_PREFERRED_NODE = cast(DWORD, -1)
const DEBUG_PROCESS = &h1
const DEBUG_ONLY_THIS_PROCESS = &h2
const CREATE_SUSPENDED = &h4
const DETACHED_PROCESS = &h8
const CREATE_NEW_CONSOLE = &h10
const NORMAL_PRIORITY_CLASS = &h20
const IDLE_PRIORITY_CLASS = &h40
const HIGH_PRIORITY_CLASS = &h80
const REALTIME_PRIORITY_CLASS = &h100
const CREATE_NEW_PROCESS_GROUP = &h200
const CREATE_UNICODE_ENVIRONMENT = &h400
const CREATE_SEPARATE_WOW_VDM = &h800
const CREATE_SHARED_WOW_VDM = &h1000
const CREATE_FORCEDOS = &h2000
const BELOW_NORMAL_PRIORITY_CLASS = &h4000
const ABOVE_NORMAL_PRIORITY_CLASS = &h8000
const INHERIT_PARENT_AFFINITY = &h10000
const INHERIT_CALLER_PRIORITY = &h20000
const CREATE_PROTECTED_PROCESS = &h40000
const EXTENDED_STARTUPINFO_PRESENT = &h80000
const PROCESS_MODE_BACKGROUND_BEGIN = &h100000
const PROCESS_MODE_BACKGROUND_END = &h200000
const CREATE_BREAKAWAY_FROM_JOB = &h1000000
const CREATE_PRESERVE_CODE_AUTHZ_LEVEL = &h2000000
const CREATE_DEFAULT_ERROR_MODE = &h4000000
const CREATE_NO_WINDOW = &h8000000
const PROFILE_USER = &h10000000
const PROFILE_KERNEL = &h20000000
const PROFILE_SERVER = &h40000000
const CREATE_IGNORE_SYSTEM_DEFAULT = &h80000000
const STACK_SIZE_PARAM_IS_A_RESERVATION = &h10000
const THREAD_PRIORITY_LOWEST = THREAD_BASE_PRIORITY_MIN
const THREAD_PRIORITY_BELOW_NORMAL = THREAD_PRIORITY_LOWEST + 1
const THREAD_PRIORITY_NORMAL = 0
const THREAD_PRIORITY_HIGHEST = THREAD_BASE_PRIORITY_MAX
const THREAD_PRIORITY_ABOVE_NORMAL = THREAD_PRIORITY_HIGHEST - 1
const THREAD_PRIORITY_ERROR_RETURN = MAXLONG
const THREAD_PRIORITY_TIME_CRITICAL = THREAD_BASE_PRIORITY_LOWRT
const THREAD_PRIORITY_IDLE = THREAD_BASE_PRIORITY_IDLE
const THREAD_MODE_BACKGROUND_BEGIN = &h00010000
const THREAD_MODE_BACKGROUND_END = &h00020000
const VOLUME_NAME_DOS = &h0
const VOLUME_NAME_GUID = &h1
const VOLUME_NAME_NT = &h2
const VOLUME_NAME_NONE = &h4
const FILE_NAME_NORMALIZED = &h0
const FILE_NAME_OPENED = &h8

type _JIT_DEBUG_INFO
	dwSize as DWORD
	dwProcessorArchitecture as DWORD
	dwThreadID as DWORD
	dwReserved0 as DWORD
	lpExceptionAddress as ULONG64
	lpExceptionRecord as ULONG64
	lpContextRecord as ULONG64
end type

type JIT_DEBUG_INFO as _JIT_DEBUG_INFO
type LPJIT_DEBUG_INFO as _JIT_DEBUG_INFO ptr
type JIT_DEBUG_INFO32 as JIT_DEBUG_INFO
type LPJIT_DEBUG_INFO32 as JIT_DEBUG_INFO ptr
type JIT_DEBUG_INFO64 as JIT_DEBUG_INFO
type LPJIT_DEBUG_INFO64 as JIT_DEBUG_INFO ptr
type LPEXCEPTION_RECORD as PEXCEPTION_RECORD
type LPEXCEPTION_POINTERS as PEXCEPTION_POINTERS

const DRIVE_UNKNOWN = 0
const DRIVE_NO_ROOT_DIR = 1
const DRIVE_REMOVABLE = 2
const DRIVE_FIXED = 3
const DRIVE_REMOTE = 4
const DRIVE_CDROM = 5
const DRIVE_RAMDISK = 6
#define GetFreeSpace(w) &h100000
const FILE_TYPE_UNKNOWN = &h0
const FILE_TYPE_DISK = &h1
const FILE_TYPE_CHAR = &h2
const FILE_TYPE_PIPE = &h3
const FILE_TYPE_REMOTE = &h8000
const STD_INPUT_HANDLE = cast(DWORD, -10)
const STD_OUTPUT_HANDLE = cast(DWORD, -11)
const STD_ERROR_HANDLE = cast(DWORD, -12)
const NOPARITY = 0
const ODDPARITY = 1
const EVENPARITY = 2
const MARKPARITY = 3
const SPACEPARITY = 4
const ONESTOPBIT = 0
const ONE5STOPBITS = 1
const TWOSTOPBITS = 2
const IGNORE = 0
const INFINITE = &hffffffff
const CBR_110 = 110
const CBR_300 = 300
const CBR_600 = 600
const CBR_1200 = 1200
const CBR_2400 = 2400
const CBR_4800 = 4800
const CBR_9600 = 9600
const CBR_14400 = 14400
const CBR_19200 = 19200
const CBR_38400 = 38400
const CBR_56000 = 56000
const CBR_57600 = 57600
const CBR_115200 = 115200
const CBR_128000 = 128000
const CBR_256000 = 256000
const CE_RXOVER = &h1
const CE_OVERRUN = &h2
const CE_RXPARITY = &h4
const CE_FRAME = &h8
const CE_BREAK = &h10
const CE_TXFULL = &h100
const CE_PTO = &h200
const CE_IOE = &h400
const CE_DNS = &h800
const CE_OOP = &h1000
const CE_MODE = &h8000
const IE_BADID = -1
const IE_OPEN = -2
const IE_NOPEN = -3
const IE_MEMORY = -4
const IE_DEFAULT = -5
const IE_HARDWARE = -10
const IE_BYTESIZE = -11
const IE_BAUDRATE = -12
const EV_RXCHAR = &h1
const EV_RXFLAG = &h2
const EV_TXEMPTY = &h4
const EV_CTS = &h8
const EV_DSR = &h10
const EV_RLSD = &h20
const EV_BREAK = &h40
const EV_ERR = &h80
const EV_RING = &h100
const EV_PERR = &h200
const EV_RX80FULL = &h400
const EV_EVENT1 = &h800
const EV_EVENT2 = &h1000
const SETXOFF = 1
const SETXON = 2
const SETRTS = 3
const CLRRTS = 4
const SETDTR = 5
const CLRDTR = 6
const RESETDEV = 7
const SETBREAK = 8
const CLRBREAK = 9
const PURGE_TXABORT = &h1
const PURGE_RXABORT = &h2
const PURGE_TXCLEAR = &h4
const PURGE_RXCLEAR = &h8
const LPTx = &h80
const MS_CTS_ON = cast(DWORD, &h10)
const MS_DSR_ON = cast(DWORD, &h20)
const MS_RING_ON = cast(DWORD, &h40)
const MS_RLSD_ON = cast(DWORD, &h80)
const S_QUEUEEMPTY = 0
const S_THRESHOLD = 1
const S_ALLTHRESHOLD = 2
const S_NORMAL = 0
const S_LEGATO = 1
const S_STACCATO = 2
const S_PERIOD512 = 0
const S_PERIOD1024 = 1
const S_PERIOD2048 = 2
const S_PERIODVOICE = 3
const S_WHITE512 = 4
const S_WHITE1024 = 5
const S_WHITE2048 = 6
const S_WHITEVOICE = 7
const S_SERDVNA = -1
const S_SEROFM = -2
const S_SERMACT = -3
const S_SERQFUL = -4
const S_SERBDNT = -5
const S_SERDLN = -6
const S_SERDCC = -7
const S_SERDTP = -8
const S_SERDVL = -9
const S_SERDMD = -10
const S_SERDSH = -11
const S_SERDPT = -12
const S_SERDFQ = -13
const S_SERDDR = -14
const S_SERDSR = -15
const S_SERDST = -16
const NMPWAIT_WAIT_FOREVER = &hffffffff
const NMPWAIT_NOWAIT = &h1
const NMPWAIT_USE_DEFAULT_WAIT = &h0
const FS_CASE_IS_PRESERVED = FILE_CASE_PRESERVED_NAMES
const FS_CASE_SENSITIVE = FILE_CASE_SENSITIVE_SEARCH
const FS_UNICODE_STORED_ON_DISK = FILE_UNICODE_ON_DISK
const FS_PERSISTENT_ACLS = FILE_PERSISTENT_ACLS
const FS_VOL_IS_COMPRESSED = FILE_VOLUME_IS_COMPRESSED
const FS_FILE_COMPRESSION = FILE_FILE_COMPRESSION
const FS_FILE_ENCRYPTION = FILE_SUPPORTS_ENCRYPTION
const OF_READ = &h0
const OF_WRITE = &h1
const OF_READWRITE = &h2
const OF_SHARE_COMPAT = &h0
const OF_SHARE_EXCLUSIVE = &h10
const OF_SHARE_DENY_WRITE = &h20
const OF_SHARE_DENY_READ = &h30
const OF_SHARE_DENY_NONE = &h40
const OF_PARSE = &h100
const OF_DELETE = &h200
const OF_VERIFY = &h400
const OF_CANCEL = &h800
const OF_CREATE = &h1000
const OF_PROMPT = &h2000
const OF_EXIST = &h4000
const OF_REOPEN = &h8000
const OFS_MAXPATHNAME = 128

type _OFSTRUCT
	cBytes as UBYTE
	fFixedDisk as UBYTE
	nErrCode as WORD
	Reserved1 as WORD
	Reserved2 as WORD
	szPathName as zstring * 128
end type

type OFSTRUCT as _OFSTRUCT
type LPOFSTRUCT as _OFSTRUCT ptr
type POFSTRUCT as _OFSTRUCT ptr

#ifdef __FB_64BIT__
	#define InterlockedIncrement _InterlockedIncrement
#else
	private function InterlockedAnd64 cdecl(byval Destination as LONGLONG ptr, byval Value as LONGLONG) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Destination
		loop while InterlockedCompareExchange64(Destination, Old and Value, Old) <> Old
		return Old
	end function

	private function InterlockedOr64 cdecl(byval Destination as LONGLONG ptr, byval Value as LONGLONG) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Destination
		loop while InterlockedCompareExchange64(Destination, Old or Value, Old) <> Old
		return Old
	end function

	private function InterlockedXor64 cdecl(byval Destination as LONGLONG ptr, byval Value as LONGLONG) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Destination
		loop while InterlockedCompareExchange64(Destination, Old xor Value, Old) <> Old
		return Old
	end function

	private function InterlockedIncrement64 cdecl(byval Addend as LONGLONG ptr) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Addend
		loop while InterlockedCompareExchange64(Addend, Old + 1, Old) <> Old
		return Old + 1
	end function

	private function InterlockedDecrement64 cdecl(byval Addend as LONGLONG ptr) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Addend
		loop while InterlockedCompareExchange64(Addend, Old - 1, Old) <> Old
		return Old - 1
	end function

	private function InterlockedExchange64 cdecl(byval Target as LONGLONG ptr, byval Value as LONGLONG) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Target
		loop while InterlockedCompareExchange64(Target, Value, Old) <> Old
		return Old
	end function

	private function InterlockedExchangeAdd64 cdecl(byval Addend as LONGLONG ptr, byval Value as LONGLONG) as LONGLONG
		dim Old as LONGLONG
		do
			Old = *Addend
		loop while InterlockedCompareExchange64(Addend, Old + Value, Old) <> Old
		return Old
	end function

	#define InterlockedCompareExchangePointer(Destination, ExChange, Comperand) cast(PVOID, cast(LONG_PTR, InterlockedCompareExchange(cptr(LONG ptr, (Destination)), cast(LONG, cast(LONG_PTR, (ExChange))), cast(LONG, cast(LONG_PTR, (Comperand))))))
#endif

#define InterlockedIncrementAcquire InterlockedIncrement
#define InterlockedIncrementRelease InterlockedIncrement

#ifdef __FB_64BIT__
	#define InterlockedDecrement _InterlockedDecrement
#endif

#define InterlockedDecrementAcquire InterlockedDecrement
#define InterlockedDecrementRelease InterlockedDecrement

#ifdef __FB_64BIT__
	#define InterlockedExchange _InterlockedExchange
	#define InterlockedExchangeAdd _InterlockedExchangeAdd
	#define InterlockedCompareExchange _InterlockedCompareExchange
#else
	#define InterlockedIncrementAcquire InterlockedIncrement
	#define InterlockedIncrementRelease InterlockedIncrement
#endif

#define InterlockedCompareExchangeAcquire InterlockedCompareExchange
#define InterlockedCompareExchangeRelease InterlockedCompareExchange

#ifdef __FB_64BIT__
	#define InterlockedExchangePointer _InterlockedExchangePointer
	#define InterlockedCompareExchangePointer _InterlockedCompareExchangePointer
	#define InterlockedCompareExchangePointerAcquire _InterlockedCompareExchangePointer
	#define InterlockedCompareExchangePointerRelease _InterlockedCompareExchangePointer
	#define InterlockedAnd64 _InterlockedAnd64
	#define InterlockedOr64 _InterlockedOr64
	#define InterlockedXor64 _InterlockedXor64
	#define InterlockedIncrement64 _InterlockedIncrement64
	#define InterlockedDecrement64 _InterlockedDecrement64
	#define InterlockedExchange64 _InterlockedExchange64
	#define InterlockedExchangeAdd64 _InterlockedExchangeAdd64
	#define InterlockedCompareExchange64 _InterlockedCompareExchange64
#endif

#define InterlockedCompareExchangeAcquire64 InterlockedCompareExchange64
#define InterlockedCompareExchangeRelease64 InterlockedCompareExchange64

#ifdef __FB_64BIT__
	declare function _InterlockedAnd(byval Destination as LONG ptr, byval Value as LONG) as LONG
	declare function _InterlockedOr(byval Destination as LONG ptr, byval Value as LONG) as LONG
	declare function _InterlockedXor(byval Destination as LONG ptr, byval Value as LONG) as LONG
	declare function _InterlockedAnd8(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function InterlockedAnd8 alias "_InterlockedAnd8"(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function _InterlockedOr8(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function InterlockedOr8 alias "_InterlockedOr8"(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function _InterlockedXor8(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function InterlockedXor8 alias "_InterlockedXor8"(byval Destination as zstring ptr, byval Value as byte) as byte
	declare function _InterlockedAnd16(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
	declare function InterlockedAnd16 alias "_InterlockedAnd16"(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
	declare function _InterlockedOr16(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
	declare function InterlockedOr16 alias "_InterlockedOr16"(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
	declare function _InterlockedXor16(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
	declare function InterlockedXor16 alias "_InterlockedXor16"(byval Destination as SHORT ptr, byval Value as SHORT) as SHORT
#else
	#define InterlockedCompareExchangePointerAcquire InterlockedCompareExchangePointer
	#define InterlockedCompareExchangePointerRelease InterlockedCompareExchangePointer
#endif

const MAXINTATOM = &hc000
#define MAKEINTATOM(i) cast(LPTSTR, cast(ULONG_PTR, cast(WORD, (i))))
const INVALID_ATOM = cast(ATOM, 0)

declare function GlobalAlloc(byval uFlags as UINT, byval dwBytes as SIZE_T_) as HGLOBAL
declare function GlobalReAlloc(byval hMem as HGLOBAL, byval dwBytes as SIZE_T_, byval uFlags as UINT) as HGLOBAL
declare function GlobalSize(byval hMem as HGLOBAL) as SIZE_T_
declare function GlobalFlags(byval hMem as HGLOBAL) as UINT
declare function GlobalLock(byval hMem as HGLOBAL) as LPVOID
declare function GlobalHandle(byval pMem as LPCVOID) as HGLOBAL
declare function GlobalUnlock(byval hMem as HGLOBAL) as WINBOOL
declare function GlobalFree(byval hMem as HGLOBAL) as HGLOBAL
declare function GlobalCompact(byval dwMinFree as DWORD) as SIZE_T_
declare sub GlobalFix(byval hMem as HGLOBAL)
declare sub GlobalUnfix(byval hMem as HGLOBAL)
declare function GlobalWire(byval hMem as HGLOBAL) as LPVOID
declare function GlobalUnWire(byval hMem as HGLOBAL) as WINBOOL
declare sub GlobalMemoryStatus(byval lpBuffer as LPMEMORYSTATUS)
declare function LocalAlloc(byval uFlags as UINT, byval uBytes as SIZE_T_) as HLOCAL
declare function LocalReAlloc(byval hMem as HLOCAL, byval uBytes as SIZE_T_, byval uFlags as UINT) as HLOCAL
declare function LocalLock(byval hMem as HLOCAL) as LPVOID
declare function LocalHandle(byval pMem as LPCVOID) as HLOCAL
declare function LocalUnlock(byval hMem as HLOCAL) as WINBOOL
declare function LocalSize(byval hMem as HLOCAL) as SIZE_T_
declare function LocalFlags(byval hMem as HLOCAL) as UINT
declare function LocalFree(byval hMem as HLOCAL) as HLOCAL
declare function LocalShrink(byval hMem as HLOCAL, byval cbNewSize as UINT) as SIZE_T_
declare function LocalCompact(byval uMinFree as UINT) as SIZE_T_

#if _WIN32_WINNT >= &h0600
	declare function VirtualAllocExNuma(byval hProcess as HANDLE, byval lpAddress as LPVOID, byval dwSize as SIZE_T_, byval flAllocationType as DWORD, byval flProtect as DWORD, byval nndPreferred as DWORD) as LPVOID
#endif

#if _WIN32_WINNT >= &h0601
	declare function GetProcessorSystemCycleTime(byval Group as USHORT, byval Buffer as PSYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION, byval ReturnedLength as PDWORD) as WINBOOL
	declare function GetPhysicallyInstalledSystemMemory(byval TotalMemoryInKilobytes as PULONGLONG) as WINBOOL
#endif

const SCS_32BIT_BINARY = 0
const SCS_DOS_BINARY = 1
const SCS_WOW_BINARY = 2
const SCS_PIF_BINARY = 3
const SCS_POSIX_BINARY = 4
const SCS_OS216_BINARY = 5
const SCS_64BIT_BINARY = 6

#ifdef __FB_64BIT__
	const SCS_THIS_PLATFORM_BINARY = SCS_64BIT_BINARY
#else
	const SCS_THIS_PLATFORM_BINARY = SCS_32BIT_BINARY
#endif

declare function GetBinaryTypeA(byval lpApplicationName as LPCSTR, byval lpBinaryType as LPDWORD) as WINBOOL
declare function GetBinaryTypeW(byval lpApplicationName as LPCWSTR, byval lpBinaryType as LPDWORD) as WINBOOL
declare function GetShortPathNameA(byval lpszLongPath as LPCSTR, byval lpszShortPath as LPSTR, byval cchBuffer as DWORD) as DWORD

#if _WIN32_WINNT >= &h0600
	declare function GetLongPathNameTransactedA(byval lpszShortPath as LPCSTR, byval lpszLongPath as LPSTR, byval cchBuffer as DWORD, byval hTransaction as HANDLE) as DWORD
	declare function GetLongPathNameTransactedW(byval lpszShortPath as LPCWSTR, byval lpszLongPath as LPWSTR, byval cchBuffer as DWORD, byval hTransaction as HANDLE) as DWORD
#endif

declare function GetProcessAffinityMask(byval hProcess as HANDLE, byval lpProcessAffinityMask as PDWORD_PTR, byval lpSystemAffinityMask as PDWORD_PTR) as WINBOOL
declare function SetProcessAffinityMask(byval hProcess as HANDLE, byval dwProcessAffinityMask as DWORD_PTR) as WINBOOL
declare function GetProcessIoCounters(byval hProcess as HANDLE, byval lpIoCounters as PIO_COUNTERS) as WINBOOL
declare function GetProcessWorkingSetSize(byval hProcess as HANDLE, byval lpMinimumWorkingSetSize as PSIZE_T, byval lpMaximumWorkingSetSize as PSIZE_T) as WINBOOL
declare function SetProcessWorkingSetSize(byval hProcess as HANDLE, byval dwMinimumWorkingSetSize as SIZE_T_, byval dwMaximumWorkingSetSize as SIZE_T_) as WINBOOL
declare sub FatalExit(byval ExitCode as long)
declare function SetEnvironmentStringsA(byval NewEnvironment as LPCH) as WINBOOL

#ifdef UNICODE
	declare function GetBinaryType alias "GetBinaryTypeW"(byval lpApplicationName as LPCWSTR, byval lpBinaryType as LPDWORD) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function GetLongPathNameTransacted alias "GetLongPathNameTransactedW"(byval lpszShortPath as LPCWSTR, byval lpszLongPath as LPWSTR, byval cchBuffer as DWORD, byval hTransaction as HANDLE) as DWORD
#elseif not defined(UNICODE)
	declare function SetEnvironmentStrings alias "SetEnvironmentStringsA"(byval NewEnvironment as LPCH) as WINBOOL
	declare function GetShortPathName alias "GetShortPathNameA"(byval lpszLongPath as LPCSTR, byval lpszShortPath as LPSTR, byval cchBuffer as DWORD) as DWORD
	declare function GetBinaryType alias "GetBinaryTypeA"(byval lpApplicationName as LPCSTR, byval lpBinaryType as LPDWORD) as WINBOOL
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetLongPathNameTransacted alias "GetLongPathNameTransactedA"(byval lpszShortPath as LPCSTR, byval lpszLongPath as LPSTR, byval cchBuffer as DWORD, byval hTransaction as HANDLE) as DWORD
#endif

declare sub RaiseFailFastException(byval pExceptionRecord as PEXCEPTION_RECORD, byval pContextRecord as PCONTEXT, byval dwFlags as DWORD)
declare function SetThreadIdealProcessor(byval hThread as HANDLE, byval dwIdealProcessor as DWORD) as DWORD
const FIBER_FLAG_FLOAT_SWITCH = &h1
declare function CreateFiber(byval dwStackSize as SIZE_T_, byval lpStartAddress as LPFIBER_START_ROUTINE, byval lpParameter as LPVOID) as LPVOID
declare function CreateFiberEx(byval dwStackCommitSize as SIZE_T_, byval dwStackReserveSize as SIZE_T_, byval dwFlags as DWORD, byval lpStartAddress as LPFIBER_START_ROUTINE, byval lpParameter as LPVOID) as LPVOID
declare sub DeleteFiber(byval lpFiber as LPVOID)
declare function ConvertThreadToFiber(byval lpParameter as LPVOID) as LPVOID
declare function ConvertThreadToFiberEx(byval lpParameter as LPVOID, byval dwFlags as DWORD) as LPVOID
declare function ConvertFiberToThread() as WINBOOL
declare sub SwitchToFiber(byval lpFiber as LPVOID)
declare function SetThreadAffinityMask(byval hThread as HANDLE, byval dwThreadAffinityMask as DWORD_PTR) as DWORD_PTR

type _THREAD_INFORMATION_CLASS as long
enum
	ThreadMemoryPriority
	ThreadAbsoluteCpuPriority
	ThreadInformationClassMax
end enum

type THREAD_INFORMATION_CLASS as _THREAD_INFORMATION_CLASS

type _PROCESS_INFORMATION_CLASS as long
enum
	ProcessMemoryPriority
	ProcessInformationClassMax
end enum

type PROCESS_INFORMATION_CLASS as _PROCESS_INFORMATION_CLASS

#if _WIN32_WINNT = &h0602
	declare function GetThreadInformation(byval hThread as HANDLE, byval ThreadInformationClass as THREAD_INFORMATION_CLASS, byval ThreadInformation as LPVOID, byval ThreadInformationSize as DWORD) as WINBOOL
	declare function SetThreadInformation(byval hThread as HANDLE, byval ThreadInformationClass as THREAD_INFORMATION_CLASS, byval ThreadInformation as LPVOID, byval ThreadInformationSize as DWORD) as WINBOOL
	declare function GetProcessInformation(byval hProcess as HANDLE, byval ProcessInformationClass as PROCESS_INFORMATION_CLASS, byval ProcessInformation as LPVOID, byval ProcessInformationSize as DWORD) as WINBOOL
	declare function SetProcessInformation(byval hProcess as HANDLE, byval ProcessInformationClass as PROCESS_INFORMATION_CLASS, byval ProcessInformation as LPVOID, byval ProcessInformationSize as DWORD) as WINBOOL

	const MEMORY_PRIORITY_LOWEST = 0
	const MEMORY_PRIORITY_VERY_LOW = 1
	const MEMORY_PRIORITY_LOW = 2
	const MEMORY_PRIORITY_MEDIUM = 3
	const MEMORY_PRIORITY_BELOW_NORMAL = 4
	const MEMORY_PRIORITY_NORMAL = 5

	type _MEMORY_PRIORITY_INFORMATION
		MemoryPriority as ULONG
	end type

	type MEMORY_PRIORITY_INFORMATION as _MEMORY_PRIORITY_INFORMATION
	type PMEMORY_PRIORITY_INFORMATION as _MEMORY_PRIORITY_INFORMATION ptr
#endif

#if _WIN32_WINNT >= &h0600
	const PROCESS_DEP_ENABLE = &h00000001
	const PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION = &h00000002
	declare function SetProcessDEPPolicy(byval dwFlags as DWORD) as WINBOOL
	declare function GetProcessDEPPolicy(byval hProcess as HANDLE, byval lpFlags as LPDWORD, byval lpPermanent as PBOOL) as WINBOOL
#endif

declare function SetProcessPriorityBoost(byval hProcess as HANDLE, byval bDisablePriorityBoost as WINBOOL) as WINBOOL
declare function GetProcessPriorityBoost(byval hProcess as HANDLE, byval pDisablePriorityBoost as PBOOL) as WINBOOL
declare function RequestWakeupLatency(byval latency as LATENCY_TIME) as WINBOOL
declare function IsSystemResumeAutomatic() as WINBOOL
declare function GetThreadIOPendingFlag(byval hThread as HANDLE, byval lpIOIsPending as PBOOL) as WINBOOL
declare function GetThreadSelectorEntry(byval hThread as HANDLE, byval dwSelector as DWORD, byval lpSelectorEntry as LPLDT_ENTRY) as WINBOOL
declare function SetThreadExecutionState(byval esFlags as EXECUTION_STATE) as EXECUTION_STATE

#if _WIN32_WINNT >= &h0601
	type POWER_REQUEST_CONTEXT as REASON_CONTEXT
	type PPOWER_REQUEST_CONTEXT as REASON_CONTEXT ptr
	type LPPOWER_REQUEST_CONTEXT as REASON_CONTEXT ptr

	declare function PowerCreateRequest(byval Context as PREASON_CONTEXT) as HANDLE
	declare function PowerSetRequest(byval PowerRequest as HANDLE, byval RequestType as POWER_REQUEST_TYPE) as WINBOOL
	declare function PowerClearRequest(byval PowerRequest as HANDLE, byval RequestType as POWER_REQUEST_TYPE) as WINBOOL
#endif

#define HasOverlappedIoCompleted(lpOverlapped) (cast(DWORD, (lpOverlapped)->Internal) <> STATUS_PENDING)

#if _WIN32_WINNT >= &h0600
	const FILE_SKIP_COMPLETION_PORT_ON_SUCCESS = &h1
	const FILE_SKIP_SET_EVENT_ON_HANDLE = &h2
	declare function SetFileCompletionNotificationModes(byval FileHandle as HANDLE, byval Flags as UCHAR) as WINBOOL
	declare function SetFileIoOverlappedRange(byval FileHandle as HANDLE, byval OverlappedRangeStart as PUCHAR, byval Length as ULONG) as WINBOOL
#endif

const SEM_FAILCRITICALERRORS = &h0001
const SEM_NOGPFAULTERRORBOX = &h0002
const SEM_NOALIGNMENTFAULTEXCEPT = &h0004
const SEM_NOOPENFILEERRORBOX = &h8000
declare function GetThreadErrorMode() as DWORD
declare function SetThreadErrorMode(byval dwNewMode as DWORD, byval lpOldMode as LPDWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function Wow64GetThreadContext(byval hThread as HANDLE, byval lpContext as PWOW64_CONTEXT) as WINBOOL
	declare function Wow64SetThreadContext(byval hThread as HANDLE, byval lpContext as const WOW64_CONTEXT ptr) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function Wow64GetThreadSelectorEntry(byval hThread as HANDLE, byval dwSelector as DWORD, byval lpSelectorEntry as PWOW64_LDT_ENTRY) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function Wow64SuspendThread(byval hThread as HANDLE) as DWORD
#endif

declare function DebugSetProcessKillOnExit(byval KillOnExit as WINBOOL) as WINBOOL
declare function DebugBreakProcess(byval Process as HANDLE) as WINBOOL
const CRITICAL_SECTION_NO_DEBUG_INFO = RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO

type _DEP_SYSTEM_POLICY_TYPE as long
enum
	DEPPolicyAlwaysOff = 0
	DEPPolicyAlwaysOn
	DEPPolicyOptIn
	DEPPolicyOptOut
	DEPTotalPolicyCount
end enum

type DEP_SYSTEM_POLICY_TYPE as _DEP_SYSTEM_POLICY_TYPE
const HANDLE_FLAG_INHERIT = &h1
const HANDLE_FLAG_PROTECT_FROM_CLOSE = &h2
const HINSTANCE_ERROR = 32
const GET_TAPE_MEDIA_INFORMATION = 0
const GET_TAPE_DRIVE_INFORMATION = 1
const SET_TAPE_MEDIA_INFORMATION = 0
const SET_TAPE_DRIVE_INFORMATION = 1

declare function PulseEvent(byval hEvent as HANDLE) as WINBOOL
declare function WaitForMultipleObjects(byval nCount as DWORD, byval lpHandles as const HANDLE ptr, byval bWaitAll as WINBOOL, byval dwMilliseconds as DWORD) as DWORD
declare function GlobalDeleteAtom(byval nAtom as ATOM) as ATOM
declare function InitAtomTable(byval nSize as DWORD) as WINBOOL
declare function DeleteAtom(byval nAtom as ATOM) as ATOM
declare function SetHandleCount(byval uNumber as UINT) as UINT
declare function RequestDeviceWakeup(byval hDevice as HANDLE) as WINBOOL
declare function CancelDeviceWakeupRequest(byval hDevice as HANDLE) as WINBOOL
declare function GetDevicePowerState(byval hDevice as HANDLE, byval pfOn as WINBOOL ptr) as WINBOOL
declare function SetMessageWaitingIndicator(byval hMsgIndicator as HANDLE, byval ulMsgCount as ULONG) as WINBOOL
declare function SetFileShortNameA(byval hFile as HANDLE, byval lpShortName as LPCSTR) as WINBOOL
declare function SetFileShortNameW(byval hFile as HANDLE, byval lpShortName as LPCWSTR) as WINBOOL
declare function LoadModule(byval lpModuleName as LPCSTR, byval lpParameterBlock as LPVOID) as DWORD
declare function WinExec(byval lpCmdLine as LPCSTR, byval uCmdShow as UINT) as UINT
declare function ClearCommBreak(byval hFile as HANDLE) as WINBOOL
declare function ClearCommError(byval hFile as HANDLE, byval lpErrors as LPDWORD, byval lpStat as LPCOMSTAT) as WINBOOL
declare function SetupComm(byval hFile as HANDLE, byval dwInQueue as DWORD, byval dwOutQueue as DWORD) as WINBOOL
declare function EscapeCommFunction(byval hFile as HANDLE, byval dwFunc as DWORD) as WINBOOL
declare function GetCommConfig(byval hCommDev as HANDLE, byval lpCC as LPCOMMCONFIG, byval lpdwSize as LPDWORD) as WINBOOL
declare function GetCommMask(byval hFile as HANDLE, byval lpEvtMask as LPDWORD) as WINBOOL
declare function GetCommProperties(byval hFile as HANDLE, byval lpCommProp as LPCOMMPROP) as WINBOOL
declare function GetCommModemStatus(byval hFile as HANDLE, byval lpModemStat as LPDWORD) as WINBOOL
declare function GetCommState(byval hFile as HANDLE, byval lpDCB as LPDCB) as WINBOOL
declare function GetCommTimeouts(byval hFile as HANDLE, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
declare function PurgeComm(byval hFile as HANDLE, byval dwFlags as DWORD) as WINBOOL
declare function SetCommBreak(byval hFile as HANDLE) as WINBOOL
declare function SetCommConfig(byval hCommDev as HANDLE, byval lpCC as LPCOMMCONFIG, byval dwSize as DWORD) as WINBOOL
declare function SetCommMask(byval hFile as HANDLE, byval dwEvtMask as DWORD) as WINBOOL
declare function SetCommState(byval hFile as HANDLE, byval lpDCB as LPDCB) as WINBOOL
declare function SetCommTimeouts(byval hFile as HANDLE, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
declare function TransmitCommChar(byval hFile as HANDLE, byval cChar as byte) as WINBOOL
declare function WaitCommEvent(byval hFile as HANDLE, byval lpEvtMask as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare function SetTapePosition(byval hDevice as HANDLE, byval dwPositionMethod as DWORD, byval dwPartition as DWORD, byval dwOffsetLow as DWORD, byval dwOffsetHigh as DWORD, byval bImmediate as WINBOOL) as DWORD
declare function GetTapePosition(byval hDevice as HANDLE, byval dwPositionType as DWORD, byval lpdwPartition as LPDWORD, byval lpdwOffsetLow as LPDWORD, byval lpdwOffsetHigh as LPDWORD) as DWORD
declare function PrepareTape(byval hDevice as HANDLE, byval dwOperation as DWORD, byval bImmediate as WINBOOL) as DWORD
declare function EraseTape(byval hDevice as HANDLE, byval dwEraseType as DWORD, byval bImmediate as WINBOOL) as DWORD
declare function CreateTapePartition(byval hDevice as HANDLE, byval dwPartitionMethod as DWORD, byval dwCount as DWORD, byval dwSize as DWORD) as DWORD
declare function WriteTapemark(byval hDevice as HANDLE, byval dwTapemarkType as DWORD, byval dwTapemarkCount as DWORD, byval bImmediate as WINBOOL) as DWORD
declare function GetTapeStatus(byval hDevice as HANDLE) as DWORD
declare function GetTapeParameters(byval hDevice as HANDLE, byval dwOperation as DWORD, byval lpdwSize as LPDWORD, byval lpTapeInformation as LPVOID) as DWORD
declare function SetTapeParameters(byval hDevice as HANDLE, byval dwOperation as DWORD, byval lpTapeInformation as LPVOID) as DWORD
declare function GetSystemDEPPolicy() as DEP_SYSTEM_POLICY_TYPE
declare function GetSystemRegistryQuota(byval pdwQuotaAllowed as PDWORD, byval pdwQuotaUsed as PDWORD) as WINBOOL
declare function GetSystemTimes(byval lpIdleTime as LPFILETIME, byval lpKernelTime as LPFILETIME, byval lpUserTime as LPFILETIME) as WINBOOL
declare function FileTimeToDosDateTime(byval lpFileTime as const FILETIME ptr, byval lpFatDate as LPWORD, byval lpFatTime as LPWORD) as WINBOOL
declare function DosDateTimeToFileTime(byval wFatDate as WORD, byval wFatTime as WORD, byval lpFileTime as LPFILETIME) as WINBOOL
declare function SetSystemTimeAdjustment(byval dwTimeAdjustment as DWORD, byval bTimeAdjustmentDisabled as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function SetFileShortName alias "SetFileShortNameW"(byval hFile as HANDLE, byval lpShortName as LPCWSTR) as WINBOOL
#else
	declare function SetFileShortName alias "SetFileShortNameA"(byval hFile as HANDLE, byval lpShortName as LPCSTR) as WINBOOL
#endif

declare function MulDiv(byval nNumber as long, byval nNumerator as long, byval nDenominator as long) as long
declare function FormatMessageA(byval dwFlags as DWORD, byval lpSource as LPCVOID, byval dwMessageId as DWORD, byval dwLanguageId as DWORD, byval lpBuffer as LPSTR, byval nSize as DWORD, byval Arguments as va_list ptr) as DWORD
declare function FormatMessageW(byval dwFlags as DWORD, byval lpSource as LPCVOID, byval dwMessageId as DWORD, byval dwLanguageId as DWORD, byval lpBuffer as LPWSTR, byval nSize as DWORD, byval Arguments as va_list ptr) as DWORD

#ifdef UNICODE
	declare function FormatMessage alias "FormatMessageW"(byval dwFlags as DWORD, byval lpSource as LPCVOID, byval dwMessageId as DWORD, byval dwLanguageId as DWORD, byval lpBuffer as LPWSTR, byval nSize as DWORD, byval Arguments as va_list ptr) as DWORD
#else
	declare function FormatMessage alias "FormatMessageA"(byval dwFlags as DWORD, byval lpSource as LPCVOID, byval dwMessageId as DWORD, byval dwLanguageId as DWORD, byval lpBuffer as LPSTR, byval nSize as DWORD, byval Arguments as va_list ptr) as DWORD
#endif

const FORMAT_MESSAGE_IGNORE_INSERTS = &h00000200
const FORMAT_MESSAGE_FROM_STRING = &h00000400
const FORMAT_MESSAGE_FROM_HMODULE = &h00000800
const FORMAT_MESSAGE_FROM_SYSTEM = &h00001000
const FORMAT_MESSAGE_ARGUMENT_ARRAY = &h00002000
const FORMAT_MESSAGE_MAX_WIDTH_MASK = &h000000ff
type PFE_EXPORT_FUNC as function(byval pbData as PBYTE, byval pvCallbackContext as PVOID, byval ulLength as ULONG) as DWORD
type PFE_IMPORT_FUNC as function(byval pbData as PBYTE, byval pvCallbackContext as PVOID, byval ulLength as PULONG) as DWORD
const FILE_ENCRYPTABLE = 0
const FILE_IS_ENCRYPTED = 1
const FILE_SYSTEM_ATTR = 2
const FILE_ROOT_DIR = 3
const FILE_SYSTEM_DIR = 4
const FILE_UNKNOWN = 5
const FILE_SYSTEM_NOT_SUPPORT = 6
const FILE_USER_DISALLOWED = 7
const FILE_READ_ONLY = 8
const FILE_DIR_DISALLOWED = 9
const FORMAT_MESSAGE_ALLOCATE_BUFFER = &h00000100
const EFS_USE_RECOVERY_KEYS = &h1
const CREATE_FOR_IMPORT = 1
const CREATE_FOR_DIR = 2
const OVERWRITE_HIDDEN = 4
const EFSRPC_SECURE_ONLY = 8

declare function GetNamedPipeInfo(byval hNamedPipe as HANDLE, byval lpFlags as LPDWORD, byval lpOutBufferSize as LPDWORD, byval lpInBufferSize as LPDWORD, byval lpMaxInstances as LPDWORD) as WINBOOL
declare function CreateMailslotA(byval lpName as LPCSTR, byval nMaxMessageSize as DWORD, byval lReadTimeout as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
declare function CreateMailslotW(byval lpName as LPCWSTR, byval nMaxMessageSize as DWORD, byval lReadTimeout as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
declare function GetMailslotInfo(byval hMailslot as HANDLE, byval lpMaxMessageSize as LPDWORD, byval lpNextSize as LPDWORD, byval lpMessageCount as LPDWORD, byval lpReadTimeout as LPDWORD) as WINBOOL
declare function SetMailslotInfo(byval hMailslot as HANDLE, byval lReadTimeout as DWORD) as WINBOOL
declare function EncryptFileA(byval lpFileName as LPCSTR) as WINBOOL
declare function EncryptFileW(byval lpFileName as LPCWSTR) as WINBOOL
declare function DecryptFileA(byval lpFileName as LPCSTR, byval dwReserved as DWORD) as WINBOOL
declare function DecryptFileW(byval lpFileName as LPCWSTR, byval dwReserved as DWORD) as WINBOOL
declare function FileEncryptionStatusA(byval lpFileName as LPCSTR, byval lpStatus as LPDWORD) as WINBOOL
declare function FileEncryptionStatusW(byval lpFileName as LPCWSTR, byval lpStatus as LPDWORD) as WINBOOL
declare function OpenEncryptedFileRawA(byval lpFileName as LPCSTR, byval ulFlags as ULONG, byval pvContext as PVOID ptr) as DWORD
declare function OpenEncryptedFileRawW(byval lpFileName as LPCWSTR, byval ulFlags as ULONG, byval pvContext as PVOID ptr) as DWORD
declare function ReadEncryptedFileRaw(byval pfExportCallback as PFE_EXPORT_FUNC, byval pvCallbackContext as PVOID, byval pvContext as PVOID) as DWORD
declare function WriteEncryptedFileRaw(byval pfImportCallback as PFE_IMPORT_FUNC, byval pvCallbackContext as PVOID, byval pvContext as PVOID) as DWORD
declare sub CloseEncryptedFileRaw(byval pvContext as PVOID)
declare function lstrcmpA(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
declare function lstrcmpW(byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR) as long
declare function lstrcmpiA(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
declare function lstrcmpiW(byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR) as long
declare function lstrcpynA(byval lpString1 as LPSTR, byval lpString2 as LPCSTR, byval iMaxLength as long) as LPSTR
declare function lstrcpynW(byval lpString1 as LPWSTR, byval lpString2 as LPCWSTR, byval iMaxLength as long) as LPWSTR
declare function lstrcpyA(byval lpString1 as LPSTR, byval lpString2 as LPCSTR) as LPSTR
declare function lstrcpyW(byval lpString1 as LPWSTR, byval lpString2 as LPCWSTR) as LPWSTR
declare function lstrcatA(byval lpString1 as LPSTR, byval lpString2 as LPCSTR) as LPSTR
declare function lstrcatW(byval lpString1 as LPWSTR, byval lpString2 as LPCWSTR) as LPWSTR
declare function lstrlenA(byval lpString as LPCSTR) as long
declare function lstrlenW(byval lpString as LPCWSTR) as long
declare function OpenFile(byval lpFileName as LPCSTR, byval lpReOpenBuff as LPOFSTRUCT, byval uStyle as UINT) as HFILE
declare function _lopen(byval lpPathName as LPCSTR, byval iReadWrite as long) as HFILE
declare function _lcreat(byval lpPathName as LPCSTR, byval iAttribute as long) as HFILE
declare function _lread(byval hFile as HFILE, byval lpBuffer as LPVOID, byval uBytes as UINT) as UINT
declare function _lwrite(byval hFile as HFILE, byval lpBuffer as LPCCH, byval uBytes as UINT) as UINT
declare function _hread(byval hFile as HFILE, byval lpBuffer as LPVOID, byval lBytes as long) as long
declare function _hwrite(byval hFile as HFILE, byval lpBuffer as LPCCH, byval lBytes as long) as long
declare function _lclose(byval hFile as HFILE) as HFILE
declare function _llseek(byval hFile as HFILE, byval lOffset as LONG, byval iOrigin as long) as LONG
declare function IsTextUnicode(byval lpv as const any ptr, byval iSize as long, byval lpiResult as LPINT) as WINBOOL
declare function BackupRead(byval hFile as HANDLE, byval lpBuffer as LPBYTE, byval nNumberOfBytesToRead as DWORD, byval lpNumberOfBytesRead as LPDWORD, byval bAbort as WINBOOL, byval bProcessSecurity as WINBOOL, byval lpContext as LPVOID ptr) as WINBOOL
declare function BackupSeek(byval hFile as HANDLE, byval dwLowBytesToSeek as DWORD, byval dwHighBytesToSeek as DWORD, byval lpdwLowByteSeeked as LPDWORD, byval lpdwHighByteSeeked as LPDWORD, byval lpContext as LPVOID ptr) as WINBOOL
declare function BackupWrite(byval hFile as HANDLE, byval lpBuffer as LPBYTE, byval nNumberOfBytesToWrite as DWORD, byval lpNumberOfBytesWritten as LPDWORD, byval bAbort as WINBOOL, byval bProcessSecurity as WINBOOL, byval lpContext as LPVOID ptr) as WINBOOL

#ifdef UNICODE
	declare function CreateMailslot alias "CreateMailslotW"(byval lpName as LPCWSTR, byval nMaxMessageSize as DWORD, byval lReadTimeout as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
	declare function EncryptFile alias "EncryptFileW"(byval lpFileName as LPCWSTR) as WINBOOL
	declare function DecryptFile alias "DecryptFileW"(byval lpFileName as LPCWSTR, byval dwReserved as DWORD) as WINBOOL
	declare function FileEncryptionStatus alias "FileEncryptionStatusW"(byval lpFileName as LPCWSTR, byval lpStatus as LPDWORD) as WINBOOL
	declare function OpenEncryptedFileRaw alias "OpenEncryptedFileRawW"(byval lpFileName as LPCWSTR, byval ulFlags as ULONG, byval pvContext as PVOID ptr) as DWORD
	declare function lstrcmp alias "lstrcmpW"(byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR) as long
	declare function lstrcmpi alias "lstrcmpiW"(byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR) as long
	declare function lstrcpyn alias "lstrcpynW"(byval lpString1 as LPWSTR, byval lpString2 as LPCWSTR, byval iMaxLength as long) as LPWSTR
	#define lstrcpy lstrcpyW
	#define lstrcat lstrcatW
	declare function lstrlen alias "lstrlenW"(byval lpString as LPCWSTR) as long
#else
	declare function CreateMailslot alias "CreateMailslotA"(byval lpName as LPCSTR, byval nMaxMessageSize as DWORD, byval lReadTimeout as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
	declare function EncryptFile alias "EncryptFileA"(byval lpFileName as LPCSTR) as WINBOOL
	declare function DecryptFile alias "DecryptFileA"(byval lpFileName as LPCSTR, byval dwReserved as DWORD) as WINBOOL
	declare function FileEncryptionStatus alias "FileEncryptionStatusA"(byval lpFileName as LPCSTR, byval lpStatus as LPDWORD) as WINBOOL
	declare function OpenEncryptedFileRaw alias "OpenEncryptedFileRawA"(byval lpFileName as LPCSTR, byval ulFlags as ULONG, byval pvContext as PVOID ptr) as DWORD
	declare function lstrcmp alias "lstrcmpA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
	declare function lstrcmpi alias "lstrcmpiA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
	declare function lstrcpyn alias "lstrcpynA"(byval lpString1 as LPSTR, byval lpString2 as LPCSTR, byval iMaxLength as long) as LPSTR
	#define lstrcpy lstrcpyA
	#define lstrcat lstrcatA
	declare function lstrlen alias "lstrlenA"(byval lpString as LPCSTR) as long
#endif

type _WIN32_STREAM_ID
	dwStreamId as DWORD
	dwStreamAttributes as DWORD
	Size as LARGE_INTEGER
	dwStreamNameSize as DWORD
	cStreamName as wstring * 1
end type

type WIN32_STREAM_ID as _WIN32_STREAM_ID
type LPWIN32_STREAM_ID as _WIN32_STREAM_ID ptr
const BACKUP_INVALID = &h00000000
const BACKUP_DATA = &h00000001
const BACKUP_EA_DATA = &h00000002
const BACKUP_SECURITY_DATA = &h00000003
const BACKUP_ALTERNATE_DATA = &h00000004
const BACKUP_LINK = &h00000005
const BACKUP_PROPERTY_DATA = &h00000006
const BACKUP_OBJECT_ID = &h00000007
const BACKUP_REPARSE_DATA = &h00000008
const BACKUP_SPARSE_BLOCK = &h00000009
const BACKUP_TXFS_DATA = &h0000000a
const STREAM_NORMAL_ATTRIBUTE = &h00000000
const STREAM_MODIFIED_WHEN_READ = &h00000001
const STREAM_CONTAINS_SECURITY = &h00000002
const STREAM_CONTAINS_PROPERTIES = &h00000004
const STREAM_SPARSE_ATTRIBUTE = &h00000008
const STARTF_USESHOWWINDOW = &h00000001
const STARTF_USESIZE = &h00000002
const STARTF_USEPOSITION = &h00000004
const STARTF_USECOUNTCHARS = &h00000008
const STARTF_USEFILLATTRIBUTE = &h00000010
const STARTF_RUNFULLSCREEN = &h00000020
const STARTF_FORCEONFEEDBACK = &h00000040
const STARTF_FORCEOFFFEEDBACK = &h00000080
const STARTF_USESTDHANDLES = &h00000100
const STARTF_USEHOTKEY = &h00000200
const STARTF_TITLEISLINKNAME = &h00000800
const STARTF_TITLEISAPPID = &h00001000
const STARTF_PREVENTPINNING = &h00002000

#if _WIN32_WINNT >= &h0600
	type _STARTUPINFOEXA
		StartupInfo as STARTUPINFOA
		lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST
	end type

	type STARTUPINFOEXA as _STARTUPINFOEXA
	type LPSTARTUPINFOEXA as _STARTUPINFOEXA ptr

	type _STARTUPINFOEXW
		StartupInfo as STARTUPINFOW
		lpAttributeList as LPPROC_THREAD_ATTRIBUTE_LIST
	end type

	type STARTUPINFOEXW as _STARTUPINFOEXW
	type LPSTARTUPINFOEXW as _STARTUPINFOEXW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	type STARTUPINFOEX as STARTUPINFOEXW
	type LPSTARTUPINFOEX as LPSTARTUPINFOEXW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	type STARTUPINFOEX as STARTUPINFOEXA
	type LPSTARTUPINFOEX as LPSTARTUPINFOEXA
#endif

const SHUTDOWN_NORETRY = &h1
declare function CreateSemaphoreW(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCWSTR) as HANDLE

#ifdef UNICODE
	declare function CreateSemaphore alias "CreateSemaphoreW"(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCWSTR) as HANDLE
#endif

declare function LoadLibraryW(byval lpLibFileName as LPCWSTR) as HMODULE
declare function OpenMutexA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function CreateSemaphoreA(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCSTR) as HANDLE

#ifndef UNICODE
	declare function CreateSemaphore alias "CreateSemaphoreA"(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCSTR) as HANDLE
#endif

declare function OpenSemaphoreA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function CreateWaitableTimerA(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
declare function CreateWaitableTimerW(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval lpTimerName as LPCWSTR) as HANDLE
declare function OpenWaitableTimerA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
declare function CreateFileMappingA(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCSTR) as HANDLE

#if _WIN32_WINNT >= &h0600
	declare function CreateSemaphoreExA(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateWaitableTimerExA(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval lpTimerName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateFileMappingNumaA(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCSTR, byval nndPreferred as DWORD) as HANDLE
#endif

declare function OpenFileMappingA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function GetLogicalDriveStringsA(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
declare function LoadLibraryA(byval lpLibFileName as LPCSTR) as HMODULE

#ifdef UNICODE
	declare function CreateWaitableTimer alias "CreateWaitableTimerW"(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval lpTimerName as LPCWSTR) as HANDLE
	declare function LoadLibrary alias "LoadLibraryW"(byval lpLibFileName as LPCWSTR) as HMODULE
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	declare function LoadPackagedLibrary(byval lpwLibFileName as LPCWSTR, byval Reserved as DWORD) as HMODULE
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function OpenMutex alias "OpenMutexA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function OpenSemaphore alias "OpenSemaphoreA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function OpenWaitableTimer alias "OpenWaitableTimerA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
	declare function CreateFileMapping alias "CreateFileMappingA"(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCSTR) as HANDLE
	declare function OpenFileMapping alias "OpenFileMappingA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function GetLogicalDriveStrings alias "GetLogicalDriveStringsA"(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
	declare function CreateWaitableTimer alias "CreateWaitableTimerA"(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
	declare function LoadLibrary alias "LoadLibraryA"(byval lpLibFileName as LPCSTR) as HMODULE
	declare function CreateSemaphoreEx alias "CreateSemaphoreExA"(byval lpSemaphoreAttributes as LPSECURITY_ATTRIBUTES, byval lInitialCount as LONG, byval lMaximumCount as LONG, byval lpName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateWaitableTimerEx alias "CreateWaitableTimerExA"(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval lpTimerName as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as DWORD) as HANDLE
	declare function CreateFileMappingNuma alias "CreateFileMappingNumaA"(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCSTR, byval nndPreferred as DWORD) as HANDLE
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	declare function LoadPackagedLibrary(byval lpwLibFileName as LPCWSTR, byval Reserved as DWORD) as HMODULE
#endif

#if _WIN32_WINNT >= &h0600
	const PROCESS_NAME_NATIVE = &h00000001
	declare function QueryFullProcessImageNameA(byval hProcess as HANDLE, byval dwFlags as DWORD, byval lpExeName as LPSTR, byval lpdwSize as PDWORD) as WINBOOL
	declare function QueryFullProcessImageNameW(byval hProcess as HANDLE, byval dwFlags as DWORD, byval lpExeName as LPWSTR, byval lpdwSize as PDWORD) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function QueryFullProcessImageName alias "QueryFullProcessImageNameW"(byval hProcess as HANDLE, byval dwFlags as DWORD, byval lpExeName as LPWSTR, byval lpdwSize as PDWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function QueryFullProcessImageName alias "QueryFullProcessImageNameA"(byval hProcess as HANDLE, byval dwFlags as DWORD, byval lpExeName as LPSTR, byval lpdwSize as PDWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	const PROC_THREAD_ATTRIBUTE_NUMBER = &h0000ffff
	const PROC_THREAD_ATTRIBUTE_THREAD = &h00010000
	const PROC_THREAD_ATTRIBUTE_INPUT = &h00020000
	const PROC_THREAD_ATTRIBUTE_ADDITIVE = &h00040000

	type _PROC_THREAD_ATTRIBUTE_NUM as long
	enum
		ProcThreadAttributeParentProcess = 0
		ProcThreadAttributeHandleList = 2

		#if _WIN32_WINNT >= &h0601
			ProcThreadAttributeGroupAffinity = 3
			ProcThreadAttributePreferredNode = 4
			ProcThreadAttributeIdealProcessor = 5
			ProcThreadAttributeUmsThread = 6
			ProcThreadAttributeMitigationPolicy = 7
		#endif

		#if _WIN32_WINNT = &h0602
			ProcThreadAttributeSecurityCapabilities = 9
		#endif
	end enum

	type PROC_THREAD_ATTRIBUTE_NUM as _PROC_THREAD_ATTRIBUTE_NUM
	#define ProcThreadAttributeValue(Number, Thread, Input, Additive) (((((Number) and PROC_THREAD_ATTRIBUTE_NUMBER) or iif(Thread <> FALSE, PROC_THREAD_ATTRIBUTE_THREAD, 0)) or iif(Input <> FALSE, PROC_THREAD_ATTRIBUTE_INPUT, 0)) or iif(Additive <> FALSE, PROC_THREAD_ATTRIBUTE_ADDITIVE, 0))
	#define PROC_THREAD_ATTRIBUTE_PARENT_PROCESS ProcThreadAttributeValue(ProcThreadAttributeParentProcess, FALSE, CTRUE, FALSE)
	#define PROC_THREAD_ATTRIBUTE_HANDLE_LIST ProcThreadAttributeValue(ProcThreadAttributeHandleList, FALSE, CTRUE, FALSE)
#endif

#if _WIN32_WINNT >= &h0601
	#define PROC_THREAD_ATTRIBUTE_GROUP_AFFINITY ProcThreadAttributeValue(ProcThreadAttributeGroupAffinity, CTRUE, CTRUE, FALSE)
	#define PROC_THREAD_ATTRIBUTE_PREFERRED_NODE ProcThreadAttributeValue(ProcThreadAttributePreferredNode, FALSE, CTRUE, FALSE)
	#define PROC_THREAD_ATTRIBUTE_IDEAL_PROCESSOR ProcThreadAttributeValue(ProcThreadAttributeIdealProcessor, CTRUE, CTRUE, FALSE)
	#define PROC_THREAD_ATTRIBUTE_UMS_THREAD ProcThreadAttributeValue(ProcThreadAttributeUmsThread, CTRUE, CTRUE, FALSE)
	#define PROC_THREAD_ATTRIBUTE_MITIGATION_POLICY ProcThreadAttributeValue(ProcThreadAttributeMitigationPolicy, FALSE, CTRUE, FALSE)
	const PROCESS_CREATION_MITIGATION_POLICY_DEP_ENABLE = &h01
	const PROCESS_CREATION_MITIGATION_POLICY_DEP_ATL_THUNK_ENABLE = &h02
	const PROCESS_CREATION_MITIGATION_POLICY_SEHOP_ENABLE = &h04
#endif

#if _WIN32_WINNT = &h0602
	#define PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES ProcThreadAttributeValue(ProcThreadAttributeSecurityCapabilities, FALSE, CTRUE, FALSE)
	const PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_MASK = &h00000003 shl 8
	const PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_DEFER = &h00000000 shl 8
	const PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_ON = &h00000001 shl 8
	const PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_OFF = &h00000002 shl 8
	const PROCESS_CREATION_MITIGATION_POLICY_FORCE_RELOCATE_IMAGES_ALWAYS_ON_REQ_RELOCS = &h00000003 shl 8
	const PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_MASK = &h00000003 shl 12
	const PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_DEFER = &h00000000 shl 12
	const PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_ALWAYS_ON = &h00000001 shl 12
	const PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_ALWAYS_OFF = &h00000002 shl 12
	const PROCESS_CREATION_MITIGATION_POLICY_HEAP_TERMINATE_RESERVED = &h00000003 shl 12
	const PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_MASK = &h00000003 shl 16
	const PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_DEFER = &h00000000 shl 16
	const PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_ALWAYS_ON = &h00000001 shl 16
	const PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_ALWAYS_OFF = &h00000002 shl 16
	const PROCESS_CREATION_MITIGATION_POLICY_BOTTOM_UP_ASLR_RESERVED = &h00000003 shl 16
	const PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_MASK = &h00000003 shl 20
	const PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_DEFER = &h00000000 shl 20
	const PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_ALWAYS_ON = &h00000001 shl 20
	const PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_ALWAYS_OFF = &h00000002 shl 20
	const PROCESS_CREATION_MITIGATION_POLICY_HIGH_ENTROPY_ASLR_RESERVED = &h00000003 shl 20
	const PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_MASK = &h00000003 shl 24
	const PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_DEFER = &h00000000 shl 24
	const PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_ALWAYS_ON = &h00000001 shl 24
	const PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_ALWAYS_OFF = &h00000002 shl 24
	const PROCESS_CREATION_MITIGATION_POLICY_STRICT_HANDLE_CHECKS_RESERVED = &h00000003 shl 24
	const PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_MASK = &h00000003 shl 28
	const PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_DEFER = &h00000000 shl 28
	const PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_ALWAYS_ON = &h00000001 shl 28
	const PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_ALWAYS_OFF = &h00000002 shl 28
	const PROCESS_CREATION_MITIGATION_POLICY_WIN32K_SYSTEM_CALL_DISABLE_RESERVED = &h00000003 shl 28
	const PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_MASK = &h00000003ull shl 32
	const PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_DEFER = &h00000000ull shl 32
	const PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_ALWAYS_ON = &h00000001ull shl 32
	const PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_ALWAYS_OFF = &h00000002ull shl 32
	const PROCESS_CREATION_MITIGATION_POLICY_EXTENSION_POINT_DISABLE_RESERVED = &h00000003ull shl 32
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function OpenMutex alias "OpenMutexA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function OpenSemaphore alias "OpenSemaphoreA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function OpenWaitableTimer alias "OpenWaitableTimerA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
	declare function CreateFileMapping alias "CreateFileMappingA"(byval hFile as HANDLE, byval lpFileMappingAttributes as LPSECURITY_ATTRIBUTES, byval flProtect as DWORD, byval dwMaximumSizeHigh as DWORD, byval dwMaximumSizeLow as DWORD, byval lpName as LPCSTR) as HANDLE
	declare function OpenFileMapping alias "OpenFileMappingA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function GetLogicalDriveStrings alias "GetLogicalDriveStringsA"(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
	declare function CreateWaitableTimer alias "CreateWaitableTimerA"(byval lpTimerAttributes as LPSECURITY_ATTRIBUTES, byval bManualReset as WINBOOL, byval lpTimerName as LPCSTR) as HANDLE
	declare function LoadLibrary alias "LoadLibraryA"(byval lpLibFileName as LPCSTR) as HMODULE
#endif

const ATOM_FLAG_GLOBAL = &h2
declare function GetProcessShutdownParameters(byval lpdwLevel as LPDWORD, byval lpdwFlags as LPDWORD) as WINBOOL
declare sub FatalAppExitA(byval uAction as UINT, byval lpMessageText as LPCSTR)
declare sub FatalAppExitW(byval uAction as UINT, byval lpMessageText as LPCWSTR)
declare sub GetStartupInfoA(byval lpStartupInfo as LPSTARTUPINFOA)
declare function GetFirmwareEnvironmentVariableA(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pBuffer as PVOID, byval nSize as DWORD) as DWORD
declare function GetFirmwareEnvironmentVariableW(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pBuffer as PVOID, byval nSize as DWORD) as DWORD
declare function SetFirmwareEnvironmentVariableA(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pValue as PVOID, byval nSize as DWORD) as WINBOOL
declare function SetFirmwareEnvironmentVariableW(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pValue as PVOID, byval nSize as DWORD) as WINBOOL
declare function FindResourceA(byval hModule as HMODULE, byval lpName as LPCSTR, byval lpType as LPCSTR) as HRSRC
declare function FindResourceW(byval hModule as HMODULE, byval lpName as LPCWSTR, byval lpType as LPCWSTR) as HRSRC
declare function FindResourceExA(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval wLanguage as WORD) as HRSRC
declare function EnumResourceTypesA(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCA, byval lParam as LONG_PTR) as WINBOOL
declare function EnumResourceTypesW(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCW, byval lParam as LONG_PTR) as WINBOOL
declare function EnumResourceNamesA(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpEnumFunc as ENUMRESNAMEPROCA, byval lParam as LONG_PTR) as WINBOOL
declare function EnumResourceNamesW(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpEnumFunc as ENUMRESNAMEPROCW, byval lParam as LONG_PTR) as WINBOOL
declare function EnumResourceLanguagesA(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval lpEnumFunc as ENUMRESLANGPROCA, byval lParam as LONG_PTR) as WINBOOL
declare function EnumResourceLanguagesW(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval lpEnumFunc as ENUMRESLANGPROCW, byval lParam as LONG_PTR) as WINBOOL
declare function BeginUpdateResourceA(byval pFileName as LPCSTR, byval bDeleteExistingResources as WINBOOL) as HANDLE
declare function BeginUpdateResourceW(byval pFileName as LPCWSTR, byval bDeleteExistingResources as WINBOOL) as HANDLE
declare function UpdateResourceA(byval hUpdate as HANDLE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval wLanguage as WORD, byval lpData as LPVOID, byval cb as DWORD) as WINBOOL
declare function UpdateResourceW(byval hUpdate as HANDLE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval wLanguage as WORD, byval lpData as LPVOID, byval cb as DWORD) as WINBOOL
declare function EndUpdateResourceA(byval hUpdate as HANDLE, byval fDiscard as WINBOOL) as WINBOOL
declare function EndUpdateResourceW(byval hUpdate as HANDLE, byval fDiscard as WINBOOL) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function GetFirmwareEnvironmentVariableExA(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pBuffer as PVOID, byval nSize as DWORD, byval pdwAttribubutes as PDWORD) as DWORD
	declare function GetFirmwareEnvironmentVariableExW(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pBuffer as PVOID, byval nSize as DWORD, byval pdwAttribubutes as PDWORD) as DWORD
	declare function SetFirmwareEnvironmentVariableExA(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pValue as PVOID, byval nSize as DWORD, byval dwAttributes as DWORD) as WINBOOL
	declare function SetFirmwareEnvironmentVariableExW(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pValue as PVOID, byval nSize as DWORD, byval dwAttributes as DWORD) as WINBOOL
	declare function GetFirmwareType(byval FirmwareType as PFIRMWARE_TYPE) as WINBOOL
	declare function IsNativeVhdBoot(byval NativeVhdBoot as PBOOL) as WINBOOL
#endif

declare function GlobalAddAtomA(byval lpString as LPCSTR) as ATOM
declare function GlobalAddAtomW(byval lpString as LPCWSTR) as ATOM
declare function GlobalAddAtomExA(byval lpString as LPCSTR, byval Flags as DWORD) as ATOM
declare function GlobalAddAtomExW(byval lpString as LPCWSTR, byval Flags as DWORD) as ATOM
declare function GlobalFindAtomA(byval lpString as LPCSTR) as ATOM
declare function GlobalFindAtomW(byval lpString as LPCWSTR) as ATOM
declare function GlobalGetAtomNameA(byval nAtom as ATOM, byval lpBuffer as LPSTR, byval nSize as long) as UINT
declare function GlobalGetAtomNameW(byval nAtom as ATOM, byval lpBuffer as LPWSTR, byval nSize as long) as UINT
declare function AddAtomA(byval lpString as LPCSTR) as ATOM
declare function AddAtomW(byval lpString as LPCWSTR) as ATOM
declare function FindAtomA(byval lpString as LPCSTR) as ATOM
declare function FindAtomW(byval lpString as LPCWSTR) as ATOM
declare function GetAtomNameA(byval nAtom as ATOM, byval lpBuffer as LPSTR, byval nSize as long) as UINT
declare function GetAtomNameW(byval nAtom as ATOM, byval lpBuffer as LPWSTR, byval nSize as long) as UINT
declare function GetProfileIntA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval nDefault as INT_) as UINT
declare function GetProfileIntW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval nDefault as INT_) as UINT
declare function GetProfileStringA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpDefault as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD) as DWORD
declare function GetProfileStringW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpDefault as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD) as DWORD
declare function WriteProfileStringA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpString as LPCSTR) as WINBOOL
declare function WriteProfileStringW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpString as LPCWSTR) as WINBOOL
declare function GetProfileSectionA(byval lpAppName as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD) as DWORD
declare function GetProfileSectionW(byval lpAppName as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD) as DWORD
declare function WriteProfileSectionA(byval lpAppName as LPCSTR, byval lpString as LPCSTR) as WINBOOL
declare function WriteProfileSectionW(byval lpAppName as LPCWSTR, byval lpString as LPCWSTR) as WINBOOL
declare function GetPrivateProfileIntA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval nDefault as INT_, byval lpFileName as LPCSTR) as UINT
declare function GetPrivateProfileIntW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval nDefault as INT_, byval lpFileName as LPCWSTR) as UINT
declare function GetPrivateProfileStringA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpDefault as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
declare function GetPrivateProfileStringW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpDefault as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
declare function WritePrivateProfileStringA(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpString as LPCSTR, byval lpFileName as LPCSTR) as WINBOOL
declare function WritePrivateProfileStringW(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpString as LPCWSTR, byval lpFileName as LPCWSTR) as WINBOOL
declare function GetPrivateProfileSectionA(byval lpAppName as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
declare function GetPrivateProfileSectionW(byval lpAppName as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
declare function WritePrivateProfileSectionA(byval lpAppName as LPCSTR, byval lpString as LPCSTR, byval lpFileName as LPCSTR) as WINBOOL
declare function WritePrivateProfileSectionW(byval lpAppName as LPCWSTR, byval lpString as LPCWSTR, byval lpFileName as LPCWSTR) as WINBOOL
declare function GetPrivateProfileSectionNamesA(byval lpszReturnBuffer as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
declare function GetPrivateProfileSectionNamesW(byval lpszReturnBuffer as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
declare function GetPrivateProfileStructA(byval lpszSection as LPCSTR, byval lpszKey as LPCSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCSTR) as WINBOOL
declare function GetPrivateProfileStructW(byval lpszSection as LPCWSTR, byval lpszKey as LPCWSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCWSTR) as WINBOOL
declare function WritePrivateProfileStructA(byval lpszSection as LPCSTR, byval lpszKey as LPCSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCSTR) as WINBOOL
declare function WritePrivateProfileStructW(byval lpszSection as LPCWSTR, byval lpszKey as LPCWSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCWSTR) as WINBOOL
declare function GetTempPathA(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
declare function GetTempFileNameA(byval lpPathName as LPCSTR, byval lpPrefixString as LPCSTR, byval uUnique as UINT, byval lpTempFileName as LPSTR) as UINT

#ifdef UNICODE
	declare sub FatalAppExit alias "FatalAppExitW"(byval uAction as UINT, byval lpMessageText as LPCWSTR)
	declare function GetFirmwareEnvironmentVariable alias "GetFirmwareEnvironmentVariableW"(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pBuffer as PVOID, byval nSize as DWORD) as DWORD
	declare function SetFirmwareEnvironmentVariable alias "SetFirmwareEnvironmentVariableW"(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pValue as PVOID, byval nSize as DWORD) as WINBOOL
	declare function FindResource alias "FindResourceW"(byval hModule as HMODULE, byval lpName as LPCWSTR, byval lpType as LPCWSTR) as HRSRC
	declare function EnumResourceTypes alias "EnumResourceTypesW"(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCW, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumResourceNames alias "EnumResourceNamesW"(byval hModule as HMODULE, byval lpType as LPCWSTR, byval lpEnumFunc as ENUMRESNAMEPROCW, byval lParam as LONG_PTR) as WINBOOL
	#define EnumResourceLanguages EnumResourceLanguagesW
	declare function BeginUpdateResource alias "BeginUpdateResourceW"(byval pFileName as LPCWSTR, byval bDeleteExistingResources as WINBOOL) as HANDLE
	declare function UpdateResource alias "UpdateResourceW"(byval hUpdate as HANDLE, byval lpType as LPCWSTR, byval lpName as LPCWSTR, byval wLanguage as WORD, byval lpData as LPVOID, byval cb as DWORD) as WINBOOL
	declare function EndUpdateResource alias "EndUpdateResourceW"(byval hUpdate as HANDLE, byval fDiscard as WINBOOL) as WINBOOL
	declare function GlobalAddAtom alias "GlobalAddAtomW"(byval lpString as LPCWSTR) as ATOM
	declare function GlobalAddAtomEx alias "GlobalAddAtomExW"(byval lpString as LPCWSTR, byval Flags as DWORD) as ATOM
	declare function GlobalFindAtom alias "GlobalFindAtomW"(byval lpString as LPCWSTR) as ATOM
	declare function GlobalGetAtomName alias "GlobalGetAtomNameW"(byval nAtom as ATOM, byval lpBuffer as LPWSTR, byval nSize as long) as UINT
	declare function AddAtom alias "AddAtomW"(byval lpString as LPCWSTR) as ATOM
	declare function FindAtom alias "FindAtomW"(byval lpString as LPCWSTR) as ATOM
	declare function GetAtomName alias "GetAtomNameW"(byval nAtom as ATOM, byval lpBuffer as LPWSTR, byval nSize as long) as UINT
	declare function GetProfileInt alias "GetProfileIntW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval nDefault as INT_) as UINT
	declare function GetProfileString alias "GetProfileStringW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpDefault as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD) as DWORD
	declare function WriteProfileString alias "WriteProfileStringW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpString as LPCWSTR) as WINBOOL
	declare function GetProfileSection alias "GetProfileSectionW"(byval lpAppName as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD) as DWORD
	declare function WriteProfileSection alias "WriteProfileSectionW"(byval lpAppName as LPCWSTR, byval lpString as LPCWSTR) as WINBOOL
	declare function GetPrivateProfileInt alias "GetPrivateProfileIntW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval nDefault as INT_, byval lpFileName as LPCWSTR) as UINT
	declare function GetPrivateProfileString alias "GetPrivateProfileStringW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpDefault as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
	declare function WritePrivateProfileString alias "WritePrivateProfileStringW"(byval lpAppName as LPCWSTR, byval lpKeyName as LPCWSTR, byval lpString as LPCWSTR, byval lpFileName as LPCWSTR) as WINBOOL
	declare function GetPrivateProfileSection alias "GetPrivateProfileSectionW"(byval lpAppName as LPCWSTR, byval lpReturnedString as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
	declare function WritePrivateProfileSection alias "WritePrivateProfileSectionW"(byval lpAppName as LPCWSTR, byval lpString as LPCWSTR, byval lpFileName as LPCWSTR) as WINBOOL
	declare function GetPrivateProfileSectionNames alias "GetPrivateProfileSectionNamesW"(byval lpszReturnBuffer as LPWSTR, byval nSize as DWORD, byval lpFileName as LPCWSTR) as DWORD
	declare function GetPrivateProfileStruct alias "GetPrivateProfileStructW"(byval lpszSection as LPCWSTR, byval lpszKey as LPCWSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCWSTR) as WINBOOL
	declare function WritePrivateProfileStruct alias "WritePrivateProfileStructW"(byval lpszSection as LPCWSTR, byval lpszKey as LPCWSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCWSTR) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	declare function GetFirmwareEnvironmentVariableEx alias "GetFirmwareEnvironmentVariableExW"(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pBuffer as PVOID, byval nSize as DWORD, byval pdwAttribubutes as PDWORD) as DWORD
	declare function SetFirmwareEnvironmentVariableEx alias "SetFirmwareEnvironmentVariableExW"(byval lpName as LPCWSTR, byval lpGuid as LPCWSTR, byval pValue as PVOID, byval nSize as DWORD, byval dwAttributes as DWORD) as WINBOOL
#elseif not defined(UNICODE)
	declare sub GetStartupInfo alias "GetStartupInfoA"(byval lpStartupInfo as LPSTARTUPINFOA)
	declare function FindResourceEx alias "FindResourceExA"(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval wLanguage as WORD) as HRSRC
	declare function GetTempPath alias "GetTempPathA"(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
	declare function GetTempFileName alias "GetTempFileNameA"(byval lpPathName as LPCSTR, byval lpPrefixString as LPCSTR, byval uUnique as UINT, byval lpTempFileName as LPSTR) as UINT
	declare sub FatalAppExit alias "FatalAppExitA"(byval uAction as UINT, byval lpMessageText as LPCSTR)
	declare function GetFirmwareEnvironmentVariable alias "GetFirmwareEnvironmentVariableA"(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pBuffer as PVOID, byval nSize as DWORD) as DWORD
	declare function SetFirmwareEnvironmentVariable alias "SetFirmwareEnvironmentVariableA"(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pValue as PVOID, byval nSize as DWORD) as WINBOOL
	declare function FindResource alias "FindResourceA"(byval hModule as HMODULE, byval lpName as LPCSTR, byval lpType as LPCSTR) as HRSRC
	declare function EnumResourceTypes alias "EnumResourceTypesA"(byval hModule as HMODULE, byval lpEnumFunc as ENUMRESTYPEPROCA, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumResourceNames alias "EnumResourceNamesA"(byval hModule as HMODULE, byval lpType as LPCSTR, byval lpEnumFunc as ENUMRESNAMEPROCA, byval lParam as LONG_PTR) as WINBOOL
	#define EnumResourceLanguages EnumResourceLanguagesA
	declare function BeginUpdateResource alias "BeginUpdateResourceA"(byval pFileName as LPCSTR, byval bDeleteExistingResources as WINBOOL) as HANDLE
	declare function UpdateResource alias "UpdateResourceA"(byval hUpdate as HANDLE, byval lpType as LPCSTR, byval lpName as LPCSTR, byval wLanguage as WORD, byval lpData as LPVOID, byval cb as DWORD) as WINBOOL
	declare function EndUpdateResource alias "EndUpdateResourceA"(byval hUpdate as HANDLE, byval fDiscard as WINBOOL) as WINBOOL
	declare function GlobalAddAtom alias "GlobalAddAtomA"(byval lpString as LPCSTR) as ATOM
	declare function GlobalAddAtomEx alias "GlobalAddAtomExA"(byval lpString as LPCSTR, byval Flags as DWORD) as ATOM
	declare function GlobalFindAtom alias "GlobalFindAtomA"(byval lpString as LPCSTR) as ATOM
	declare function GlobalGetAtomName alias "GlobalGetAtomNameA"(byval nAtom as ATOM, byval lpBuffer as LPSTR, byval nSize as long) as UINT
	declare function AddAtom alias "AddAtomA"(byval lpString as LPCSTR) as ATOM
	declare function FindAtom alias "FindAtomA"(byval lpString as LPCSTR) as ATOM
	declare function GetAtomName alias "GetAtomNameA"(byval nAtom as ATOM, byval lpBuffer as LPSTR, byval nSize as long) as UINT
	declare function GetProfileInt alias "GetProfileIntA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval nDefault as INT_) as UINT
	declare function GetProfileString alias "GetProfileStringA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpDefault as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD) as DWORD
	declare function WriteProfileString alias "WriteProfileStringA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpString as LPCSTR) as WINBOOL
	declare function GetProfileSection alias "GetProfileSectionA"(byval lpAppName as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD) as DWORD
	declare function WriteProfileSection alias "WriteProfileSectionA"(byval lpAppName as LPCSTR, byval lpString as LPCSTR) as WINBOOL
	declare function GetPrivateProfileInt alias "GetPrivateProfileIntA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval nDefault as INT_, byval lpFileName as LPCSTR) as UINT
	declare function GetPrivateProfileString alias "GetPrivateProfileStringA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpDefault as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
	declare function WritePrivateProfileString alias "WritePrivateProfileStringA"(byval lpAppName as LPCSTR, byval lpKeyName as LPCSTR, byval lpString as LPCSTR, byval lpFileName as LPCSTR) as WINBOOL
	declare function GetPrivateProfileSection alias "GetPrivateProfileSectionA"(byval lpAppName as LPCSTR, byval lpReturnedString as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
	declare function WritePrivateProfileSection alias "WritePrivateProfileSectionA"(byval lpAppName as LPCSTR, byval lpString as LPCSTR, byval lpFileName as LPCSTR) as WINBOOL
	declare function GetPrivateProfileSectionNames alias "GetPrivateProfileSectionNamesA"(byval lpszReturnBuffer as LPSTR, byval nSize as DWORD, byval lpFileName as LPCSTR) as DWORD
	declare function GetPrivateProfileStruct alias "GetPrivateProfileStructA"(byval lpszSection as LPCSTR, byval lpszKey as LPCSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCSTR) as WINBOOL
	declare function WritePrivateProfileStruct alias "WritePrivateProfileStructA"(byval lpszSection as LPCSTR, byval lpszKey as LPCSTR, byval lpStruct as LPVOID, byval uSizeStruct as UINT, byval szFile as LPCSTR) as WINBOOL
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	declare function GetFirmwareEnvironmentVariableEx alias "GetFirmwareEnvironmentVariableExA"(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pBuffer as PVOID, byval nSize as DWORD, byval pdwAttribubutes as PDWORD) as DWORD
	declare function SetFirmwareEnvironmentVariableEx alias "SetFirmwareEnvironmentVariableExA"(byval lpName as LPCSTR, byval lpGuid as LPCSTR, byval pValue as PVOID, byval nSize as DWORD, byval dwAttributes as DWORD) as WINBOOL
#endif

declare function GetSystemWow64DirectoryA(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
declare function GetSystemWow64DirectoryW(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT

#ifdef UNICODE
	declare function GetSystemWow64Directory alias "GetSystemWow64DirectoryW"(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
#else
	declare function GetSystemWow64Directory alias "GetSystemWow64DirectoryA"(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
#endif

declare function Wow64EnableWow64FsRedirection(byval Wow64FsEnableRedirection as WINBOOLEAN) as WINBOOLEAN
type PGET_SYSTEM_WOW64_DIRECTORY_A as function(byval lpBuffer as LPSTR, byval uSize as UINT) as UINT
type PGET_SYSTEM_WOW64_DIRECTORY_W as function(byval lpBuffer as LPWSTR, byval uSize as UINT) as UINT
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_A_A "GetSystemWow64DirectoryA"
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_A_W wstr("GetSystemWow64DirectoryA")
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_A_T __TEXT("GetSystemWow64DirectoryA")
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_W_A "GetSystemWow64DirectoryW"
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_W_W wstr("GetSystemWow64DirectoryW")
#define GET_SYSTEM_WOW64_DIRECTORY_NAME_W_T __TEXT("GetSystemWow64DirectoryW")

#ifdef UNICODE
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_A GET_SYSTEM_WOW64_DIRECTORY_NAME_W_A
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_W GET_SYSTEM_WOW64_DIRECTORY_NAME_W_W
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_T GET_SYSTEM_WOW64_DIRECTORY_NAME_W_T
#else
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_A GET_SYSTEM_WOW64_DIRECTORY_NAME_A_A
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_W GET_SYSTEM_WOW64_DIRECTORY_NAME_A_W
	#define GET_SYSTEM_WOW64_DIRECTORY_NAME_T_T GET_SYSTEM_WOW64_DIRECTORY_NAME_A_T
#endif

declare function SetDllDirectoryA(byval lpPathName as LPCSTR) as WINBOOL
declare function SetDllDirectoryW(byval lpPathName as LPCWSTR) as WINBOOL
declare function GetDllDirectoryA(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
declare function GetDllDirectoryW(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD

#ifdef UNICODE
	declare function SetDllDirectory alias "SetDllDirectoryW"(byval lpPathName as LPCWSTR) as WINBOOL
	declare function GetDllDirectory alias "GetDllDirectoryW"(byval nBufferLength as DWORD, byval lpBuffer as LPWSTR) as DWORD
#else
	declare function SetDllDirectory alias "SetDllDirectoryA"(byval lpPathName as LPCSTR) as WINBOOL
	declare function GetDllDirectory alias "GetDllDirectoryA"(byval nBufferLength as DWORD, byval lpBuffer as LPSTR) as DWORD
#endif

const BASE_SEARCH_PATH_ENABLE_SAFE_SEARCHMODE = &h1
const BASE_SEARCH_PATH_DISABLE_SAFE_SEARCHMODE = &h10000
const BASE_SEARCH_PATH_PERMANENT = &h8000
const BASE_SEARCH_PATH_INVALID_FLAGS = not &h18001

declare function SetSearchPathMode(byval Flags as DWORD) as WINBOOL
declare function CreateDirectoryExA(byval lpTemplateDirectory as LPCSTR, byval lpNewDirectory as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
declare function CreateDirectoryExW(byval lpTemplateDirectory as LPCWSTR, byval lpNewDirectory as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL

#ifdef UNICODE
	declare function CreateDirectoryEx alias "CreateDirectoryExW"(byval lpTemplateDirectory as LPCWSTR, byval lpNewDirectory as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#elseif (not defined(UNICODE)) and (defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)))
	declare function CreateDirectoryEx alias "CreateDirectoryExA"(byval lpTemplateDirectory as LPCSTR, byval lpNewDirectory as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function CreateDirectoryTransactedA(byval lpTemplateDirectory as LPCSTR, byval lpNewDirectory as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
	declare function CreateDirectoryTransactedW(byval lpTemplateDirectory as LPCWSTR, byval lpNewDirectory as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
	declare function RemoveDirectoryTransactedA(byval lpPathName as LPCSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function RemoveDirectoryTransactedW(byval lpPathName as LPCWSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFullPathNameTransactedA(byval lpFileName as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr, byval hTransaction as HANDLE) as DWORD
	declare function GetFullPathNameTransactedW(byval lpFileName as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr, byval hTransaction as HANDLE) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateDirectoryTransacted alias "CreateDirectoryTransactedW"(byval lpTemplateDirectory as LPCWSTR, byval lpNewDirectory as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
	declare function RemoveDirectoryTransacted alias "RemoveDirectoryTransactedW"(byval lpPathName as LPCWSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFullPathNameTransacted alias "GetFullPathNameTransactedW"(byval lpFileName as LPCWSTR, byval nBufferLength as DWORD, byval lpBuffer as LPWSTR, byval lpFilePart as LPWSTR ptr, byval hTransaction as HANDLE) as DWORD
#elseif (not defined(__FB_64BIT__)) and (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function CreateDirectoryEx alias "CreateDirectoryExA"(byval lpTemplateDirectory as LPCSTR, byval lpNewDirectory as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function CreateDirectoryTransacted alias "CreateDirectoryTransactedA"(byval lpTemplateDirectory as LPCSTR, byval lpNewDirectory as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
	declare function RemoveDirectoryTransacted alias "RemoveDirectoryTransactedA"(byval lpPathName as LPCSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFullPathNameTransacted alias "GetFullPathNameTransactedA"(byval lpFileName as LPCSTR, byval nBufferLength as DWORD, byval lpBuffer as LPSTR, byval lpFilePart as LPSTR ptr, byval hTransaction as HANDLE) as DWORD
#endif

const DDD_RAW_TARGET_PATH = &h00000001
const DDD_REMOVE_DEFINITION = &h00000002
const DDD_EXACT_MATCH_ON_REMOVE = &h00000004
const DDD_NO_BROADCAST_SYSTEM = &h00000008
const DDD_LUID_BROADCAST_DRIVE = &h00000010
declare function DefineDosDeviceA(byval dwFlags as DWORD, byval lpDeviceName as LPCSTR, byval lpTargetPath as LPCSTR) as WINBOOL
declare function QueryDosDeviceA(byval lpDeviceName as LPCSTR, byval lpTargetPath as LPSTR, byval ucchMax as DWORD) as DWORD

#ifndef UNICODE
	declare function DefineDosDevice alias "DefineDosDeviceA"(byval dwFlags as DWORD, byval lpDeviceName as LPCSTR, byval lpTargetPath as LPCSTR) as WINBOOL
	declare function QueryDosDevice alias "QueryDosDeviceA"(byval lpDeviceName as LPCSTR, byval lpTargetPath as LPSTR, byval ucchMax as DWORD) as DWORD
#endif

#define EXPAND_LOCAL_DRIVES

#if _WIN32_WINNT >= &h0600
	declare function CreateFileTransactedA(byval lpFileName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE, byval hTransaction as HANDLE, byval pusMiniVersion as PUSHORT, byval lpExtendedParameter as PVOID) as HANDLE
	declare function CreateFileTransactedW(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE, byval hTransaction as HANDLE, byval pusMiniVersion as PUSHORT, byval lpExtendedParameter as PVOID) as HANDLE
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateFileTransacted alias "CreateFileTransactedW"(byval lpFileName as LPCWSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE, byval hTransaction as HANDLE, byval pusMiniVersion as PUSHORT, byval lpExtendedParameter as PVOID) as HANDLE
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function CreateFileTransacted alias "CreateFileTransactedA"(byval lpFileName as LPCSTR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwCreationDisposition as DWORD, byval dwFlagsAndAttributes as DWORD, byval hTemplateFile as HANDLE, byval hTransaction as HANDLE, byval pusMiniVersion as PUSHORT, byval lpExtendedParameter as PVOID) as HANDLE
#endif

declare function ReOpenFile(byval hOriginalFile as HANDLE, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval dwFlagsAndAttributes as DWORD) as HANDLE

#if _WIN32_WINNT >= &h0600
	declare function SetFileAttributesTransactedA(byval lpFileName as LPCSTR, byval dwFileAttributes as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function SetFileAttributesTransactedW(byval lpFileName as LPCWSTR, byval dwFileAttributes as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFileAttributesTransactedA(byval lpFileName as LPCSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFileAttributesTransactedW(byval lpFileName as LPCWSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID, byval hTransaction as HANDLE) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function SetFileAttributesTransacted alias "SetFileAttributesTransactedW"(byval lpFileName as LPCWSTR, byval dwFileAttributes as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFileAttributesTransacted alias "GetFileAttributesTransactedW"(byval lpFileName as LPCWSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID, byval hTransaction as HANDLE) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function SetFileAttributesTransacted alias "SetFileAttributesTransactedA"(byval lpFileName as LPCSTR, byval dwFileAttributes as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function GetFileAttributesTransacted alias "GetFileAttributesTransactedA"(byval lpFileName as LPCSTR, byval fInfoLevelId as GET_FILEEX_INFO_LEVELS, byval lpFileInformation as LPVOID, byval hTransaction as HANDLE) as WINBOOL
#endif

declare function GetCompressedFileSizeA(byval lpFileName as LPCSTR, byval lpFileSizeHigh as LPDWORD) as DWORD
declare function GetCompressedFileSizeW(byval lpFileName as LPCWSTR, byval lpFileSizeHigh as LPDWORD) as DWORD

#ifdef UNICODE
	declare function GetCompressedFileSize alias "GetCompressedFileSizeW"(byval lpFileName as LPCWSTR, byval lpFileSizeHigh as LPDWORD) as DWORD
#elseif (not defined(UNICODE)) and (defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)))
	declare function GetCompressedFileSize alias "GetCompressedFileSizeA"(byval lpFileName as LPCSTR, byval lpFileSizeHigh as LPDWORD) as DWORD
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetCompressedFileSizeTransactedA(byval lpFileName as LPCSTR, byval lpFileSizeHigh as LPDWORD, byval hTransaction as HANDLE) as DWORD
	declare function GetCompressedFileSizeTransactedW(byval lpFileName as LPCWSTR, byval lpFileSizeHigh as LPDWORD, byval hTransaction as HANDLE) as DWORD
	declare function DeleteFileTransactedA(byval lpFileName as LPCSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function DeleteFileTransactedW(byval lpFileName as LPCWSTR, byval hTransaction as HANDLE) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function DeleteFileTransacted alias "DeleteFileTransactedW"(byval lpFileName as LPCWSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function GetCompressedFileSizeTransacted alias "GetCompressedFileSizeTransactedW"(byval lpFileName as LPCWSTR, byval lpFileSizeHigh as LPDWORD, byval hTransaction as HANDLE) as DWORD
#elseif (not defined(__FB_64BIT__)) and (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function GetCompressedFileSize alias "GetCompressedFileSizeA"(byval lpFileName as LPCSTR, byval lpFileSizeHigh as LPDWORD) as DWORD
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function DeleteFileTransacted alias "DeleteFileTransactedA"(byval lpFileName as LPCSTR, byval hTransaction as HANDLE) as WINBOOL
	declare function GetCompressedFileSizeTransacted alias "GetCompressedFileSizeTransactedA"(byval lpFileName as LPCSTR, byval lpFileSizeHigh as LPDWORD, byval hTransaction as HANDLE) as DWORD
#endif

type LPPROGRESS_ROUTINE as function(byval TotalFileSize as LARGE_INTEGER, byval TotalBytesTransferred as LARGE_INTEGER, byval StreamSize as LARGE_INTEGER, byval StreamBytesTransferred as LARGE_INTEGER, byval dwStreamNumber as DWORD, byval dwCallbackReason as DWORD, byval hSourceFile as HANDLE, byval hDestinationFile as HANDLE, byval lpData as LPVOID) as DWORD
declare function CheckNameLegalDOS8Dot3A(byval lpName as LPCSTR, byval lpOemName as LPSTR, byval OemNameSize as DWORD, byval pbNameContainsSpaces as PBOOL, byval pbNameLegal as PBOOL) as WINBOOL
declare function CheckNameLegalDOS8Dot3W(byval lpName as LPCWSTR, byval lpOemName as LPSTR, byval OemNameSize as DWORD, byval pbNameContainsSpaces as PBOOL, byval pbNameLegal as PBOOL) as WINBOOL
declare function CopyFileA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval bFailIfExists as WINBOOL) as WINBOOL
declare function CopyFileW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval bFailIfExists as WINBOOL) as WINBOOL
declare function CopyFileExA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD) as WINBOOL
declare function CopyFileExW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function FindFirstFileTransactedA(byval lpFileName as LPCSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
	declare function FindFirstFileTransactedW(byval lpFileName as LPCWSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
	declare function CopyFileTransactedA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function CopyFileTransactedW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
#endif

#ifdef UNICODE
	#if _WIN32_WINNT >= &h0600
		declare function FindFirstFileTransacted alias "FindFirstFileTransactedW"(byval lpFileName as LPCWSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
		declare function CopyFileTransacted alias "CopyFileTransactedW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
	#endif

	declare function CheckNameLegalDOS8Dot3 alias "CheckNameLegalDOS8Dot3W"(byval lpName as LPCWSTR, byval lpOemName as LPSTR, byval OemNameSize as DWORD, byval pbNameContainsSpaces as PBOOL, byval pbNameLegal as PBOOL) as WINBOOL
	declare function CopyFile alias "CopyFileW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval bFailIfExists as WINBOOL) as WINBOOL
	declare function CopyFileEx alias "CopyFileExW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0601)
	declare function FindFirstFileTransacted alias "FindFirstFileTransactedA"(byval lpFileName as LPCSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
	declare function CopyFileTransacted alias "CopyFileTransactedA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function CheckNameLegalDOS8Dot3 alias "CheckNameLegalDOS8Dot3A"(byval lpName as LPCSTR, byval lpOemName as LPSTR, byval OemNameSize as DWORD, byval pbNameContainsSpaces as PBOOL, byval pbNameLegal as PBOOL) as WINBOOL
	declare function CopyFile alias "CopyFileA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval bFailIfExists as WINBOOL) as WINBOOL
	declare function CopyFileEx alias "CopyFileExA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	type _COPYFILE2_MESSAGE_TYPE as long
	enum
		COPYFILE2_CALLBACK_NONE = 0
		COPYFILE2_CALLBACK_CHUNK_STARTED
		COPYFILE2_CALLBACK_CHUNK_FINISHED
		COPYFILE2_CALLBACK_STREAM_STARTED
		COPYFILE2_CALLBACK_STREAM_FINISHED
		COPYFILE2_CALLBACK_POLL_CONTINUE
		COPYFILE2_CALLBACK_ERROR
		COPYFILE2_CALLBACK_MAX
	end enum

	type COPYFILE2_MESSAGE_TYPE as _COPYFILE2_MESSAGE_TYPE

	type _COPYFILE2_MESSAGE_ACTION as long
	enum
		COPYFILE2_PROGRESS_CONTINUE = 0
		COPYFILE2_PROGRESS_CANCEL
		COPYFILE2_PROGRESS_STOP
		COPYFILE2_PROGRESS_QUIET
		COPYFILE2_PROGRESS_PAUSE
	end enum

	type COPYFILE2_MESSAGE_ACTION as _COPYFILE2_MESSAGE_ACTION

	type _COPYFILE2_COPY_PHASE as long
	enum
		COPYFILE2_PHASE_NONE = 0
		COPYFILE2_PHASE_PREPARE_SOURCE
		COPYFILE2_PHASE_PREPARE_DEST
		COPYFILE2_PHASE_READ_SOURCE
		COPYFILE2_PHASE_WRITE_DESTINATION
		COPYFILE2_PHASE_SERVER_COPY
		COPYFILE2_PHASE_NAMEGRAFT_COPY
		COPYFILE2_PHASE_MAX
	end enum

	type COPYFILE2_COPY_PHASE as _COPYFILE2_COPY_PHASE
	const COPYFILE2_MESSAGE_COPY_OFFLOAD = &h00000001

	type COPYFILE2_MESSAGE_Info_ChunkStarted
		dwStreamNumber as DWORD
		dwReserved as DWORD
		hSourceFile as HANDLE
		hDestinationFile as HANDLE
		uliChunkNumber as ULARGE_INTEGER
		uliChunkSize as ULARGE_INTEGER
		uliStreamSize as ULARGE_INTEGER
		uliTotalFileSize as ULARGE_INTEGER
	end type

	type COPYFILE2_MESSAGE_Info_ChunkFinished
		dwStreamNumber as DWORD
		dwFlags as DWORD
		hSourceFile as HANDLE
		hDestinationFile as HANDLE
		uliChunkNumber as ULARGE_INTEGER
		uliChunkSize as ULARGE_INTEGER
		uliStreamSize as ULARGE_INTEGER
		uliStreamBytesTransferred as ULARGE_INTEGER
		uliTotalFileSize as ULARGE_INTEGER
		uliTotalBytesTransferred as ULARGE_INTEGER
	end type

	type COPYFILE2_MESSAGE_Info_StreamStarted
		dwStreamNumber as DWORD
		dwReserved as DWORD
		hSourceFile as HANDLE
		hDestinationFile as HANDLE
		uliStreamSize as ULARGE_INTEGER
		uliTotalFileSize as ULARGE_INTEGER
	end type

	type COPYFILE2_MESSAGE_Info_StreamFinished
		dwStreamNumber as DWORD
		dwReserved as DWORD
		hSourceFile as HANDLE
		hDestinationFile as HANDLE
		uliStreamSize as ULARGE_INTEGER
		uliStreamBytesTransferred as ULARGE_INTEGER
		uliTotalFileSize as ULARGE_INTEGER
		uliTotalBytesTransferred as ULARGE_INTEGER
	end type

	type COPYFILE2_MESSAGE_Info_PollContinue
		dwReserved as DWORD
	end type

	type COPYFILE2_MESSAGE_Info_Error
		CopyPhase as COPYFILE2_COPY_PHASE
		dwStreamNumber as DWORD
		hrFailure as HRESULT
		dwReserved as DWORD
		uliChunkNumber as ULARGE_INTEGER
		uliStreamSize as ULARGE_INTEGER
		uliStreamBytesTransferred as ULARGE_INTEGER
		uliTotalFileSize as ULARGE_INTEGER
		uliTotalBytesTransferred as ULARGE_INTEGER
	end type

	union COPYFILE2_MESSAGE_Info
		ChunkStarted as COPYFILE2_MESSAGE_Info_ChunkStarted
		ChunkFinished as COPYFILE2_MESSAGE_Info_ChunkFinished
		StreamStarted as COPYFILE2_MESSAGE_Info_StreamStarted
		StreamFinished as COPYFILE2_MESSAGE_Info_StreamFinished
		PollContinue as COPYFILE2_MESSAGE_Info_PollContinue
		Error as COPYFILE2_MESSAGE_Info_Error
	end union

	type COPYFILE2_MESSAGE
		as COPYFILE2_MESSAGE_TYPE Type
		dwPadding as DWORD
		Info as COPYFILE2_MESSAGE_Info
	end type

	type PCOPYFILE2_PROGRESS_ROUTINE as function(byval pMessage as const COPYFILE2_MESSAGE ptr, byval pvCallbackContext as PVOID) as COPYFILE2_MESSAGE_ACTION

	type COPYFILE2_EXTENDED_PARAMETERS
		dwSize as DWORD
		dwCopyFlags as DWORD
		pfCancel as WINBOOL ptr
		pProgressRoutine as PCOPYFILE2_PROGRESS_ROUTINE
		pvCallbackContext as PVOID
	end type

	declare function CopyFile2(byval pwszExistingFileName as PCWSTR, byval pwszNewFileName as PCWSTR, byval pExtendedParameters as COPYFILE2_EXTENDED_PARAMETERS ptr) as HRESULT
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0600)
	declare function FindFirstFileTransacted alias "FindFirstFileTransactedA"(byval lpFileName as LPCSTR, byval fInfoLevelId as FINDEX_INFO_LEVELS, byval lpFindFileData as LPVOID, byval fSearchOp as FINDEX_SEARCH_OPS, byval lpSearchFilter as LPVOID, byval dwAdditionalFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
	declare function CopyFileTransacted alias "CopyFileTransactedA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT <= &h0600)
	declare function CheckNameLegalDOS8Dot3 alias "CheckNameLegalDOS8Dot3A"(byval lpName as LPCSTR, byval lpOemName as LPSTR, byval OemNameSize as DWORD, byval pbNameContainsSpaces as PBOOL, byval pbNameLegal as PBOOL) as WINBOOL
	declare function CopyFile alias "CopyFileA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval bFailIfExists as WINBOOL) as WINBOOL
	declare function CopyFileEx alias "CopyFileExA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval pbCancel as LPBOOL, byval dwCopyFlags as DWORD) as WINBOOL
#endif

declare function MoveFileA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR) as WINBOOL
declare function MoveFileW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function MoveFile alias "MoveFileW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR) as WINBOOL
#else
	declare function MoveFile alias "MoveFileA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR) as WINBOOL
#endif

declare function MoveFileExA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval dwFlags as DWORD) as WINBOOL
declare function MoveFileExW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function MoveFileEx alias "MoveFileExW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval dwFlags as DWORD) as WINBOOL
#else
	declare function MoveFileEx alias "MoveFileExA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval dwFlags as DWORD) as WINBOOL
#endif

declare function MoveFileWithProgressA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD) as WINBOOL
declare function MoveFileWithProgressW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function MoveFileWithProgress alias "MoveFileWithProgressW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)))
	declare function MoveFileWithProgress alias "MoveFileWithProgressA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function MoveFileTransactedA(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
	declare function MoveFileTransactedW(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function MoveFileTransacted alias "MoveFileTransactedW"(byval lpExistingFileName as LPCWSTR, byval lpNewFileName as LPCWSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
#elseif (not defined(__FB_64BIT__)) and (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function MoveFileWithProgress alias "MoveFileWithProgressA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function MoveFileTransacted alias "MoveFileTransactedA"(byval lpExistingFileName as LPCSTR, byval lpNewFileName as LPCSTR, byval lpProgressRoutine as LPPROGRESS_ROUTINE, byval lpData as LPVOID, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOL
#endif

const MOVEFILE_REPLACE_EXISTING = &h00000001
const MOVEFILE_COPY_ALLOWED = &h00000002
const MOVEFILE_DELAY_UNTIL_REBOOT = &h00000004
const MOVEFILE_WRITE_THROUGH = &h00000008
const MOVEFILE_CREATE_HARDLINK = &h00000010
const MOVEFILE_FAIL_IF_NOT_TRACKABLE = &h00000020

declare function ReplaceFileA(byval lpReplacedFileName as LPCSTR, byval lpReplacementFileName as LPCSTR, byval lpBackupFileName as LPCSTR, byval dwReplaceFlags as DWORD, byval lpExclude as LPVOID, byval lpReserved as LPVOID) as WINBOOL
declare function ReplaceFileW(byval lpReplacedFileName as LPCWSTR, byval lpReplacementFileName as LPCWSTR, byval lpBackupFileName as LPCWSTR, byval dwReplaceFlags as DWORD, byval lpExclude as LPVOID, byval lpReserved as LPVOID) as WINBOOL
declare function CreateHardLinkA(byval lpFileName as LPCSTR, byval lpExistingFileName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
declare function CreateHardLinkW(byval lpFileName as LPCWSTR, byval lpExistingFileName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL

#ifdef UNICODE
	declare function ReplaceFile alias "ReplaceFileW"(byval lpReplacedFileName as LPCWSTR, byval lpReplacementFileName as LPCWSTR, byval lpBackupFileName as LPCWSTR, byval dwReplaceFlags as DWORD, byval lpExclude as LPVOID, byval lpReserved as LPVOID) as WINBOOL
	declare function CreateHardLink alias "CreateHardLinkW"(byval lpFileName as LPCWSTR, byval lpExistingFileName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#elseif (not defined(UNICODE)) and (defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)))
	declare function ReplaceFile alias "ReplaceFileA"(byval lpReplacedFileName as LPCSTR, byval lpReplacementFileName as LPCSTR, byval lpBackupFileName as LPCSTR, byval dwReplaceFlags as DWORD, byval lpExclude as LPVOID, byval lpReserved as LPVOID) as WINBOOL
	declare function CreateHardLink alias "CreateHardLinkA"(byval lpFileName as LPCSTR, byval lpExistingFileName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function CreateHardLinkTransactedA(byval lpFileName as LPCSTR, byval lpExistingFileName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
	declare function CreateHardLinkTransactedW(byval lpFileName as LPCWSTR, byval lpExistingFileName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateHardLinkTransacted alias "CreateHardLinkTransactedW"(byval lpFileName as LPCWSTR, byval lpExistingFileName as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
#elseif (not defined(__FB_64BIT__)) and (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function ReplaceFile alias "ReplaceFileA"(byval lpReplacedFileName as LPCSTR, byval lpReplacementFileName as LPCSTR, byval lpBackupFileName as LPCSTR, byval dwReplaceFlags as DWORD, byval lpExclude as LPVOID, byval lpReserved as LPVOID) as WINBOOL
	declare function CreateHardLink alias "CreateHardLinkA"(byval lpFileName as LPCSTR, byval lpExistingFileName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function CreateHardLinkTransacted alias "CreateHardLinkTransactedA"(byval lpFileName as LPCSTR, byval lpExistingFileName as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval hTransaction as HANDLE) as WINBOOL
#endif

type _STREAM_INFO_LEVELS as long
enum
	FindStreamInfoStandard
	FindStreamInfoMaxInfoLevel
end enum

type STREAM_INFO_LEVELS as _STREAM_INFO_LEVELS

type _WIN32_FIND_STREAM_DATA
	StreamSize as LARGE_INTEGER
	cStreamName as wstring * 260 + 36
end type

type WIN32_FIND_STREAM_DATA as _WIN32_FIND_STREAM_DATA
type PWIN32_FIND_STREAM_DATA as _WIN32_FIND_STREAM_DATA ptr
declare function FindFirstStreamW(byval lpFileName as LPCWSTR, byval InfoLevel as STREAM_INFO_LEVELS, byval lpFindStreamData as LPVOID, byval dwFlags as DWORD) as HANDLE
declare function FindNextStreamW(byval hFindStream as HANDLE, byval lpFindStreamData as LPVOID) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function FindFirstStreamTransactedW(byval lpFileName as LPCWSTR, byval InfoLevel as STREAM_INFO_LEVELS, byval lpFindStreamData as LPVOID, byval dwFlags as DWORD, byval hTransaction as HANDLE) as HANDLE
	declare function FindFirstFileNameW(byval lpFileName as LPCWSTR, byval dwFlags as DWORD, byval StringLength as LPDWORD, byval LinkName as PWSTR) as HANDLE
	declare function FindNextFileNameW(byval hFindStream as HANDLE, byval StringLength as LPDWORD, byval LinkName as PWSTR) as WINBOOL
	declare function FindFirstFileNameTransactedW(byval lpFileName as LPCWSTR, byval dwFlags as DWORD, byval StringLength as LPDWORD, byval LinkName as PWSTR, byval hTransaction as HANDLE) as HANDLE
	declare function GetNamedPipeClientComputerNameA(byval Pipe as HANDLE, byval ClientComputerName as LPSTR, byval ClientComputerNameLength as ULONG) as WINBOOL
	declare function GetNamedPipeClientProcessId(byval Pipe as HANDLE, byval ClientProcessId as PULONG) as WINBOOL
	declare function GetNamedPipeClientSessionId(byval Pipe as HANDLE, byval ClientSessionId as PULONG) as WINBOOL
	declare function GetNamedPipeServerProcessId(byval Pipe as HANDLE, byval ServerProcessId as PULONG) as WINBOOL
	declare function GetNamedPipeServerSessionId(byval Pipe as HANDLE, byval ServerSessionId as PULONG) as WINBOOL
	declare function SetFileBandwidthReservation(byval hFile as HANDLE, byval nPeriodMilliseconds as DWORD, byval nBytesPerPeriod as DWORD, byval bDiscardable as WINBOOL, byval lpTransferSize as LPDWORD, byval lpNumOutstandingRequests as LPDWORD) as WINBOOL
	declare function GetFileBandwidthReservation(byval hFile as HANDLE, byval lpPeriodMilliseconds as LPDWORD, byval lpBytesPerPeriod as LPDWORD, byval pDiscardable as LPBOOL, byval lpTransferSize as LPDWORD, byval lpNumOutstandingRequests as LPDWORD) as WINBOOL
#endif

declare function CreateNamedPipeA(byval lpName as LPCSTR, byval dwOpenMode as DWORD, byval dwPipeMode as DWORD, byval nMaxInstances as DWORD, byval nOutBufferSize as DWORD, byval nInBufferSize as DWORD, byval nDefaultTimeOut as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
declare function GetNamedPipeHandleStateA(byval hNamedPipe as HANDLE, byval lpState as LPDWORD, byval lpCurInstances as LPDWORD, byval lpMaxCollectionCount as LPDWORD, byval lpCollectDataTimeout as LPDWORD, byval lpUserName as LPSTR, byval nMaxUserNameSize as DWORD) as WINBOOL
declare function GetNamedPipeHandleStateW(byval hNamedPipe as HANDLE, byval lpState as LPDWORD, byval lpCurInstances as LPDWORD, byval lpMaxCollectionCount as LPDWORD, byval lpCollectDataTimeout as LPDWORD, byval lpUserName as LPWSTR, byval nMaxUserNameSize as DWORD) as WINBOOL
declare function CallNamedPipeA(byval lpNamedPipeName as LPCSTR, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval nTimeOut as DWORD) as WINBOOL
declare function CallNamedPipeW(byval lpNamedPipeName as LPCWSTR, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval nTimeOut as DWORD) as WINBOOL
declare function WaitNamedPipeA(byval lpNamedPipeName as LPCSTR, byval nTimeOut as DWORD) as WINBOOL
declare function SetVolumeLabelA(byval lpRootPathName as LPCSTR, byval lpVolumeName as LPCSTR) as WINBOOL
declare function SetVolumeLabelW(byval lpRootPathName as LPCWSTR, byval lpVolumeName as LPCWSTR) as WINBOOL
declare sub SetFileApisToOEM()
declare sub SetFileApisToANSI()
declare function AreFileApisANSI() as WINBOOL
declare function GetVolumeInformationA(byval lpRootPathName as LPCSTR, byval lpVolumeNameBuffer as LPSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
declare function ClearEventLogA(byval hEventLog as HANDLE, byval lpBackupFileName as LPCSTR) as WINBOOL
declare function ClearEventLogW(byval hEventLog as HANDLE, byval lpBackupFileName as LPCWSTR) as WINBOOL
declare function BackupEventLogA(byval hEventLog as HANDLE, byval lpBackupFileName as LPCSTR) as WINBOOL
declare function BackupEventLogW(byval hEventLog as HANDLE, byval lpBackupFileName as LPCWSTR) as WINBOOL
declare function CloseEventLog(byval hEventLog as HANDLE) as WINBOOL
declare function DeregisterEventSource(byval hEventLog as HANDLE) as WINBOOL
declare function NotifyChangeEventLog(byval hEventLog as HANDLE, byval hEvent as HANDLE) as WINBOOL
declare function GetNumberOfEventLogRecords(byval hEventLog as HANDLE, byval NumberOfRecords as PDWORD) as WINBOOL
declare function GetOldestEventLogRecord(byval hEventLog as HANDLE, byval OldestRecord as PDWORD) as WINBOOL
declare function OpenEventLogA(byval lpUNCServerName as LPCSTR, byval lpSourceName as LPCSTR) as HANDLE
declare function OpenEventLogW(byval lpUNCServerName as LPCWSTR, byval lpSourceName as LPCWSTR) as HANDLE
declare function RegisterEventSourceA(byval lpUNCServerName as LPCSTR, byval lpSourceName as LPCSTR) as HANDLE
declare function RegisterEventSourceW(byval lpUNCServerName as LPCWSTR, byval lpSourceName as LPCWSTR) as HANDLE
declare function OpenBackupEventLogA(byval lpUNCServerName as LPCSTR, byval lpFileName as LPCSTR) as HANDLE
declare function OpenBackupEventLogW(byval lpUNCServerName as LPCWSTR, byval lpFileName as LPCWSTR) as HANDLE
declare function ReadEventLogA(byval hEventLog as HANDLE, byval dwReadFlags as DWORD, byval dwRecordOffset as DWORD, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval pnBytesRead as DWORD ptr, byval pnMinNumberOfBytesNeeded as DWORD ptr) as WINBOOL
declare function ReadEventLogW(byval hEventLog as HANDLE, byval dwReadFlags as DWORD, byval dwRecordOffset as DWORD, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval pnBytesRead as DWORD ptr, byval pnMinNumberOfBytesNeeded as DWORD ptr) as WINBOOL
declare function ReportEventA(byval hEventLog as HANDLE, byval wType as WORD, byval wCategory as WORD, byval dwEventID as DWORD, byval lpUserSid as PSID, byval wNumStrings as WORD, byval dwDataSize as DWORD, byval lpStrings as LPCSTR ptr, byval lpRawData as LPVOID) as WINBOOL
declare function ReportEventW(byval hEventLog as HANDLE, byval wType as WORD, byval wCategory as WORD, byval dwEventID as DWORD, byval lpUserSid as PSID, byval wNumStrings as WORD, byval dwDataSize as DWORD, byval lpStrings as LPCWSTR ptr, byval lpRawData as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function GetNamedPipeHandleState alias "GetNamedPipeHandleStateW"(byval hNamedPipe as HANDLE, byval lpState as LPDWORD, byval lpCurInstances as LPDWORD, byval lpMaxCollectionCount as LPDWORD, byval lpCollectDataTimeout as LPDWORD, byval lpUserName as LPWSTR, byval nMaxUserNameSize as DWORD) as WINBOOL
	declare function CallNamedPipe alias "CallNamedPipeW"(byval lpNamedPipeName as LPCWSTR, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval nTimeOut as DWORD) as WINBOOL
	declare function SetVolumeLabel alias "SetVolumeLabelW"(byval lpRootPathName as LPCWSTR, byval lpVolumeName as LPCWSTR) as WINBOOL
	declare function ClearEventLog alias "ClearEventLogW"(byval hEventLog as HANDLE, byval lpBackupFileName as LPCWSTR) as WINBOOL
	declare function BackupEventLog alias "BackupEventLogW"(byval hEventLog as HANDLE, byval lpBackupFileName as LPCWSTR) as WINBOOL
	declare function OpenEventLog alias "OpenEventLogW"(byval lpUNCServerName as LPCWSTR, byval lpSourceName as LPCWSTR) as HANDLE
	declare function RegisterEventSource alias "RegisterEventSourceW"(byval lpUNCServerName as LPCWSTR, byval lpSourceName as LPCWSTR) as HANDLE
	declare function OpenBackupEventLog alias "OpenBackupEventLogW"(byval lpUNCServerName as LPCWSTR, byval lpFileName as LPCWSTR) as HANDLE
	declare function ReadEventLog alias "ReadEventLogW"(byval hEventLog as HANDLE, byval dwReadFlags as DWORD, byval dwRecordOffset as DWORD, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval pnBytesRead as DWORD ptr, byval pnMinNumberOfBytesNeeded as DWORD ptr) as WINBOOL
	declare function ReportEvent alias "ReportEventW"(byval hEventLog as HANDLE, byval wType as WORD, byval wCategory as WORD, byval dwEventID as DWORD, byval lpUserSid as PSID, byval wNumStrings as WORD, byval dwDataSize as DWORD, byval lpStrings as LPCWSTR ptr, byval lpRawData as LPVOID) as WINBOOL
#else
	declare function CreateNamedPipe alias "CreateNamedPipeA"(byval lpName as LPCSTR, byval dwOpenMode as DWORD, byval dwPipeMode as DWORD, byval nMaxInstances as DWORD, byval nOutBufferSize as DWORD, byval nInBufferSize as DWORD, byval nDefaultTimeOut as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as HANDLE
	declare function WaitNamedPipe alias "WaitNamedPipeA"(byval lpNamedPipeName as LPCSTR, byval nTimeOut as DWORD) as WINBOOL
	declare function GetVolumeInformation alias "GetVolumeInformationA"(byval lpRootPathName as LPCSTR, byval lpVolumeNameBuffer as LPSTR, byval nVolumeNameSize as DWORD, byval lpVolumeSerialNumber as LPDWORD, byval lpMaximumComponentLength as LPDWORD, byval lpFileSystemFlags as LPDWORD, byval lpFileSystemNameBuffer as LPSTR, byval nFileSystemNameSize as DWORD) as WINBOOL
	declare function GetNamedPipeHandleState alias "GetNamedPipeHandleStateA"(byval hNamedPipe as HANDLE, byval lpState as LPDWORD, byval lpCurInstances as LPDWORD, byval lpMaxCollectionCount as LPDWORD, byval lpCollectDataTimeout as LPDWORD, byval lpUserName as LPSTR, byval nMaxUserNameSize as DWORD) as WINBOOL
	declare function CallNamedPipe alias "CallNamedPipeA"(byval lpNamedPipeName as LPCSTR, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesRead as LPDWORD, byval nTimeOut as DWORD) as WINBOOL
	declare function SetVolumeLabel alias "SetVolumeLabelA"(byval lpRootPathName as LPCSTR, byval lpVolumeName as LPCSTR) as WINBOOL
	declare function ClearEventLog alias "ClearEventLogA"(byval hEventLog as HANDLE, byval lpBackupFileName as LPCSTR) as WINBOOL
	declare function BackupEventLog alias "BackupEventLogA"(byval hEventLog as HANDLE, byval lpBackupFileName as LPCSTR) as WINBOOL
	declare function OpenEventLog alias "OpenEventLogA"(byval lpUNCServerName as LPCSTR, byval lpSourceName as LPCSTR) as HANDLE
	declare function RegisterEventSource alias "RegisterEventSourceA"(byval lpUNCServerName as LPCSTR, byval lpSourceName as LPCSTR) as HANDLE
	declare function OpenBackupEventLog alias "OpenBackupEventLogA"(byval lpUNCServerName as LPCSTR, byval lpFileName as LPCSTR) as HANDLE
	declare function ReadEventLog alias "ReadEventLogA"(byval hEventLog as HANDLE, byval dwReadFlags as DWORD, byval dwRecordOffset as DWORD, byval lpBuffer as LPVOID, byval nNumberOfBytesToRead as DWORD, byval pnBytesRead as DWORD ptr, byval pnMinNumberOfBytesNeeded as DWORD ptr) as WINBOOL
	declare function ReportEvent alias "ReportEventA"(byval hEventLog as HANDLE, byval wType as WORD, byval wCategory as WORD, byval dwEventID as DWORD, byval lpUserSid as PSID, byval wNumStrings as WORD, byval dwDataSize as DWORD, byval lpStrings as LPCSTR ptr, byval lpRawData as LPVOID) as WINBOOL
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetNamedPipeClientComputerName alias "GetNamedPipeClientComputerNameA"(byval Pipe as HANDLE, byval ClientComputerName as LPSTR, byval ClientComputerNameLength as ULONG) as WINBOOL
#endif

const EVENTLOG_FULL_INFO = 0

type _EVENTLOG_FULL_INFORMATION
	dwFull as DWORD
end type

type EVENTLOG_FULL_INFORMATION as _EVENTLOG_FULL_INFORMATION
type LPEVENTLOG_FULL_INFORMATION as _EVENTLOG_FULL_INFORMATION ptr
declare function GetEventLogInformation(byval hEventLog as HANDLE, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval cbBufSize as DWORD, byval pcbBytesNeeded as LPDWORD) as WINBOOL

#if _WIN32_WINNT = &h0602
	const OPERATION_API_VERSION = 1
	type OPERATION_ID as ULONG

	type _OPERATION_START_PARAMETERS
		Version as ULONG
		OperationId as OPERATION_ID
		Flags as ULONG
	end type

	type OPERATION_START_PARAMETERS as _OPERATION_START_PARAMETERS
	type POPERATION_START_PARAMETERS as _OPERATION_START_PARAMETERS ptr
	const OPERATION_START_TRACE_CURRENT_THREAD = &h1

	type _OPERATION_END_PARAMETERS
		Version as ULONG
		OperationId as OPERATION_ID
		Flags as ULONG
	end type

	type OPERATION_END_PARAMETERS as _OPERATION_END_PARAMETERS
	type POPERATION_END_PARAMETERS as _OPERATION_END_PARAMETERS ptr
	const OPERATION_END_DISCARD = &h1
	declare function OperationStart(byval OperationStartParams as OPERATION_START_PARAMETERS ptr) as WINBOOL
	declare function OperationEnd(byval OperationEndParams as OPERATION_END_PARAMETERS ptr) as WINBOOL
#endif

declare function AccessCheckAndAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPSTR, byval ObjectName as LPSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval DesiredAccess as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
declare function AccessCheckByTypeAndAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
declare function AccessCheckByTypeResultListAndAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
declare function AccessCheckByTypeResultListAndAuditAlarmByHandleA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
declare function ObjectOpenAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPSTR, byval ObjectName as LPSTR, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval GrantedAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval ObjectCreation as WINBOOL, byval AccessGranted as WINBOOL, byval GenerateOnClose as LPBOOL) as WINBOOL
declare function ObjectPrivilegeAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
declare function ObjectCloseAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
declare function ObjectDeleteAuditAlarmA(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
declare function PrivilegedServiceAuditAlarmA(byval SubsystemName as LPCSTR, byval ServiceName as LPCSTR, byval ClientToken as HANDLE, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
declare function SetFileSecurityA(byval lpFileName as LPCSTR, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
declare function GetFileSecurityA(byval lpFileName as LPCSTR, byval RequestedInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
declare function ReadDirectoryChangesW(byval hDirectory as HANDLE, byval lpBuffer as LPVOID, byval nBufferLength as DWORD, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD, byval lpBytesReturned as LPDWORD, byval lpOverlapped as LPOVERLAPPED, byval lpCompletionRoutine as LPOVERLAPPED_COMPLETION_ROUTINE) as WINBOOL
declare function IsBadReadPtr(byval lp as const any ptr, byval ucb as UINT_PTR) as WINBOOL
declare function IsBadWritePtr(byval lp as LPVOID, byval ucb as UINT_PTR) as WINBOOL
declare function IsBadHugeReadPtr(byval lp as const any ptr, byval ucb as UINT_PTR) as WINBOOL
declare function IsBadHugeWritePtr(byval lp as LPVOID, byval ucb as UINT_PTR) as WINBOOL
declare function IsBadCodePtr(byval lpfn as FARPROC) as WINBOOL
declare function IsBadStringPtrA(byval lpsz as LPCSTR, byval ucchMax as UINT_PTR) as WINBOOL
declare function IsBadStringPtrW(byval lpsz as LPCWSTR, byval ucchMax as UINT_PTR) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function MapViewOfFileExNuma(byval hFileMappingObject as HANDLE, byval dwDesiredAccess as DWORD, byval dwFileOffsetHigh as DWORD, byval dwFileOffsetLow as DWORD, byval dwNumberOfBytesToMap as SIZE_T_, byval lpBaseAddress as LPVOID, byval nndPreferred as DWORD) as LPVOID
#endif

#if _WIN32_WINNT >= &h0601
	declare function AddConditionalAce(byval pAcl as PACL, byval dwAceRevision as DWORD, byval AceFlags as DWORD, byval AceType as UCHAR, byval AccessMask as DWORD, byval pSid as PSID, byval ConditionStr as PWCHAR, byval ReturnLength as DWORD ptr) as WINBOOL
#endif

declare function LookupAccountSidA(byval lpSystemName as LPCSTR, byval Sid as PSID, byval Name as LPSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
declare function LookupAccountSidW(byval lpSystemName as LPCWSTR, byval Sid as PSID, byval Name as LPWSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
declare function LookupAccountNameA(byval lpSystemName as LPCSTR, byval lpAccountName as LPCSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
declare function LookupAccountNameW(byval lpSystemName as LPCWSTR, byval lpAccountName as LPCWSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL

#ifdef UNICODE
	declare function IsBadStringPtr alias "IsBadStringPtrW"(byval lpsz as LPCWSTR, byval ucchMax as UINT_PTR) as WINBOOL
	declare function LookupAccountSid alias "LookupAccountSidW"(byval lpSystemName as LPCWSTR, byval Sid as PSID, byval Name as LPWSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountName alias "LookupAccountNameW"(byval lpSystemName as LPCWSTR, byval lpAccountName as LPCWSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
#else
	declare function AccessCheckAndAuditAlarm alias "AccessCheckAndAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPSTR, byval ObjectName as LPSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval DesiredAccess as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
	declare function AccessCheckByTypeAndAuditAlarm alias "AccessCheckByTypeAndAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatus as LPBOOL, byval pfGenerateOnClose as LPBOOL) as WINBOOL
	declare function AccessCheckByTypeResultListAndAuditAlarm alias "AccessCheckByTypeResultListAndAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
	declare function AccessCheckByTypeResultListAndAuditAlarmByHandle alias "AccessCheckByTypeResultListAndAuditAlarmByHandleA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval ObjectTypeName as LPCSTR, byval ObjectName as LPCSTR, byval SecurityDescriptor as PSECURITY_DESCRIPTOR, byval PrincipalSelfSid as PSID, byval DesiredAccess as DWORD, byval AuditType as AUDIT_EVENT_TYPE, byval Flags as DWORD, byval ObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval GenericMapping as PGENERIC_MAPPING, byval ObjectCreation as WINBOOL, byval GrantedAccess as LPDWORD, byval AccessStatusList as LPDWORD, byval pfGenerateOnClose as LPBOOL) as WINBOOL
	declare function ObjectOpenAuditAlarm alias "ObjectOpenAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ObjectTypeName as LPSTR, byval ObjectName as LPSTR, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval GrantedAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval ObjectCreation as WINBOOL, byval AccessGranted as WINBOOL, byval GenerateOnClose as LPBOOL) as WINBOOL
	declare function ObjectPrivilegeAuditAlarm alias "ObjectPrivilegeAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval ClientToken as HANDLE, byval DesiredAccess as DWORD, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
	declare function ObjectCloseAuditAlarm alias "ObjectCloseAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
	declare function ObjectDeleteAuditAlarm alias "ObjectDeleteAuditAlarmA"(byval SubsystemName as LPCSTR, byval HandleId as LPVOID, byval GenerateOnClose as WINBOOL) as WINBOOL
	declare function PrivilegedServiceAuditAlarm alias "PrivilegedServiceAuditAlarmA"(byval SubsystemName as LPCSTR, byval ServiceName as LPCSTR, byval ClientToken as HANDLE, byval Privileges as PPRIVILEGE_SET, byval AccessGranted as WINBOOL) as WINBOOL
	declare function SetFileSecurity alias "SetFileSecurityA"(byval lpFileName as LPCSTR, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOL
	declare function GetFileSecurity alias "GetFileSecurityA"(byval lpFileName as LPCSTR, byval RequestedInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
	declare function IsBadStringPtr alias "IsBadStringPtrA"(byval lpsz as LPCSTR, byval ucchMax as UINT_PTR) as WINBOOL
	declare function LookupAccountSid alias "LookupAccountSidA"(byval lpSystemName as LPCSTR, byval Sid as PSID, byval Name as LPSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountName alias "LookupAccountNameA"(byval lpSystemName as LPCSTR, byval lpAccountName as LPCSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
#endif

#if _WIN32_WINNT <= &h0600
	#define LookupAccountNameLocalA(n, s, cs, d, cd, u) LookupAccountNameA(NULL, n, s, cs, d, cd, u)
	#define LookupAccountNameLocalW(n, s, cs, d, cd, u) LookupAccountNameW(NULL, n, s, cs, d, cd, u)
#endif

#if defined(UNICODE) and (_WIN32_WINNT <= &h0600)
	#define LookupAccountNameLocal(n, s, cs, d, cd, u) LookupAccountNameW(NULL, n, s, cs, d, cd, u)
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0600)
	#define LookupAccountNameLocal(n, s, cs, d, cd, u) LookupAccountNameA(NULL, n, s, cs, d, cd, u)
#endif

#if _WIN32_WINNT <= &h0600
	#define LookupAccountSidLocalA(s, n, cn, d, cd, u) LookupAccountSidA(NULL, s, n, cn, d, cd, u)
	#define LookupAccountSidLocalW(s, n, cn, d, cd, u) LookupAccountSidW(NULL, s, n, cn, d, cd, u)
#endif

#if defined(UNICODE) and (_WIN32_WINNT <= &h0600)
	#define LookupAccountSidLocal(s, n, cn, d, cd, u) LookupAccountSidW(NULL, s, n, cn, d, cd, u)
#elseif _WIN32_WINNT >= &h0601
	declare function LookupAccountNameLocalA(byval lpAccountName as LPCSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountNameLocalW(byval lpAccountName as LPCWSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountSidLocalA(byval Sid as PSID, byval Name as LPSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountSidLocalW(byval Sid as PSID, byval Name as LPWSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0601)
	declare function LookupAccountNameLocal alias "LookupAccountNameLocalW"(byval lpAccountName as LPCWSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountSidLocal alias "LookupAccountSidLocalW"(byval Sid as PSID, byval Name as LPWSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPWSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0600)
	#define LookupAccountSidLocal(s, n, cn, d, cd, u) LookupAccountSidA(NULL, s, n, cn, d, cd, u)
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0601)
	declare function LookupAccountNameLocal alias "LookupAccountNameLocalA"(byval lpAccountName as LPCSTR, byval Sid as PSID, byval cbSid as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
	declare function LookupAccountSidLocal alias "LookupAccountSidLocalA"(byval Sid as PSID, byval Name as LPSTR, byval cchName as LPDWORD, byval ReferencedDomainName as LPSTR, byval cchReferencedDomainName as LPDWORD, byval peUse as PSID_NAME_USE) as WINBOOL
#endif

declare function LookupPrivilegeValueA(byval lpSystemName as LPCSTR, byval lpName as LPCSTR, byval lpLuid as PLUID) as WINBOOL
declare function LookupPrivilegeValueW(byval lpSystemName as LPCWSTR, byval lpName as LPCWSTR, byval lpLuid as PLUID) as WINBOOL
declare function LookupPrivilegeNameA(byval lpSystemName as LPCSTR, byval lpLuid as PLUID, byval lpName as LPSTR, byval cchName as LPDWORD) as WINBOOL
declare function LookupPrivilegeNameW(byval lpSystemName as LPCWSTR, byval lpLuid as PLUID, byval lpName as LPWSTR, byval cchName as LPDWORD) as WINBOOL
declare function LookupPrivilegeDisplayNameA(byval lpSystemName as LPCSTR, byval lpName as LPCSTR, byval lpDisplayName as LPSTR, byval cchDisplayName as LPDWORD, byval lpLanguageId as LPDWORD) as WINBOOL
declare function LookupPrivilegeDisplayNameW(byval lpSystemName as LPCWSTR, byval lpName as LPCWSTR, byval lpDisplayName as LPWSTR, byval cchDisplayName as LPDWORD, byval lpLanguageId as LPDWORD) as WINBOOL
declare function BuildCommDCBA(byval lpDef as LPCSTR, byval lpDCB as LPDCB) as WINBOOL
declare function BuildCommDCBW(byval lpDef as LPCWSTR, byval lpDCB as LPDCB) as WINBOOL
declare function BuildCommDCBAndTimeoutsA(byval lpDef as LPCSTR, byval lpDCB as LPDCB, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
declare function BuildCommDCBAndTimeoutsW(byval lpDef as LPCWSTR, byval lpDCB as LPDCB, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
declare function CommConfigDialogA(byval lpszName as LPCSTR, byval hWnd as HWND, byval lpCC as LPCOMMCONFIG) as WINBOOL
declare function CommConfigDialogW(byval lpszName as LPCWSTR, byval hWnd as HWND, byval lpCC as LPCOMMCONFIG) as WINBOOL
declare function GetDefaultCommConfigA(byval lpszName as LPCSTR, byval lpCC as LPCOMMCONFIG, byval lpdwSize as LPDWORD) as WINBOOL
declare function GetDefaultCommConfigW(byval lpszName as LPCWSTR, byval lpCC as LPCOMMCONFIG, byval lpdwSize as LPDWORD) as WINBOOL
declare function SetDefaultCommConfigA(byval lpszName as LPCSTR, byval lpCC as LPCOMMCONFIG, byval dwSize as DWORD) as WINBOOL
declare function SetDefaultCommConfigW(byval lpszName as LPCWSTR, byval lpCC as LPCOMMCONFIG, byval dwSize as DWORD) as WINBOOL

#ifdef UNICODE
	declare function LookupPrivilegeValue alias "LookupPrivilegeValueW"(byval lpSystemName as LPCWSTR, byval lpName as LPCWSTR, byval lpLuid as PLUID) as WINBOOL
	declare function LookupPrivilegeName alias "LookupPrivilegeNameW"(byval lpSystemName as LPCWSTR, byval lpLuid as PLUID, byval lpName as LPWSTR, byval cchName as LPDWORD) as WINBOOL
	declare function LookupPrivilegeDisplayName alias "LookupPrivilegeDisplayNameW"(byval lpSystemName as LPCWSTR, byval lpName as LPCWSTR, byval lpDisplayName as LPWSTR, byval cchDisplayName as LPDWORD, byval lpLanguageId as LPDWORD) as WINBOOL
	declare function BuildCommDCB alias "BuildCommDCBW"(byval lpDef as LPCWSTR, byval lpDCB as LPDCB) as WINBOOL
	declare function BuildCommDCBAndTimeouts alias "BuildCommDCBAndTimeoutsW"(byval lpDef as LPCWSTR, byval lpDCB as LPDCB, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
	declare function CommConfigDialog alias "CommConfigDialogW"(byval lpszName as LPCWSTR, byval hWnd as HWND, byval lpCC as LPCOMMCONFIG) as WINBOOL
	declare function GetDefaultCommConfig alias "GetDefaultCommConfigW"(byval lpszName as LPCWSTR, byval lpCC as LPCOMMCONFIG, byval lpdwSize as LPDWORD) as WINBOOL
	declare function SetDefaultCommConfig alias "SetDefaultCommConfigW"(byval lpszName as LPCWSTR, byval lpCC as LPCOMMCONFIG, byval dwSize as DWORD) as WINBOOL
#else
	declare function LookupPrivilegeValue alias "LookupPrivilegeValueA"(byval lpSystemName as LPCSTR, byval lpName as LPCSTR, byval lpLuid as PLUID) as WINBOOL
	declare function LookupPrivilegeName alias "LookupPrivilegeNameA"(byval lpSystemName as LPCSTR, byval lpLuid as PLUID, byval lpName as LPSTR, byval cchName as LPDWORD) as WINBOOL
	declare function LookupPrivilegeDisplayName alias "LookupPrivilegeDisplayNameA"(byval lpSystemName as LPCSTR, byval lpName as LPCSTR, byval lpDisplayName as LPSTR, byval cchDisplayName as LPDWORD, byval lpLanguageId as LPDWORD) as WINBOOL
	declare function BuildCommDCB alias "BuildCommDCBA"(byval lpDef as LPCSTR, byval lpDCB as LPDCB) as WINBOOL
	declare function BuildCommDCBAndTimeouts alias "BuildCommDCBAndTimeoutsA"(byval lpDef as LPCSTR, byval lpDCB as LPDCB, byval lpCommTimeouts as LPCOMMTIMEOUTS) as WINBOOL
	declare function CommConfigDialog alias "CommConfigDialogA"(byval lpszName as LPCSTR, byval hWnd as HWND, byval lpCC as LPCOMMCONFIG) as WINBOOL
	declare function GetDefaultCommConfig alias "GetDefaultCommConfigA"(byval lpszName as LPCSTR, byval lpCC as LPCOMMCONFIG, byval lpdwSize as LPDWORD) as WINBOOL
	declare function SetDefaultCommConfig alias "SetDefaultCommConfigA"(byval lpszName as LPCSTR, byval lpCC as LPCOMMCONFIG, byval dwSize as DWORD) as WINBOOL
#endif

const MAX_COMPUTERNAME_LENGTH = 15
declare function GetComputerNameA(byval lpBuffer as LPSTR, byval nSize as LPDWORD) as WINBOOL
declare function GetComputerNameW(byval lpBuffer as LPWSTR, byval nSize as LPDWORD) as WINBOOL
declare function SetComputerNameA(byval lpComputerName as LPCSTR) as WINBOOL
declare function SetComputerNameW(byval lpComputerName as LPCWSTR) as WINBOOL
declare function SetComputerNameExA(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPCTSTR) as WINBOOL
declare function DnsHostnameToComputerNameA(byval Hostname as LPCSTR, byval ComputerName as LPSTR, byval nSize as LPDWORD) as WINBOOL
declare function DnsHostnameToComputerNameW(byval Hostname as LPCWSTR, byval ComputerName as LPWSTR, byval nSize as LPDWORD) as WINBOOL
declare function GetUserNameA(byval lpBuffer as LPSTR, byval pcbBuffer as LPDWORD) as WINBOOL
declare function GetUserNameW(byval lpBuffer as LPWSTR, byval pcbBuffer as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetComputerName alias "GetComputerNameW"(byval lpBuffer as LPWSTR, byval nSize as LPDWORD) as WINBOOL
	declare function SetComputerName alias "SetComputerNameW"(byval lpComputerName as LPCWSTR) as WINBOOL
	declare function DnsHostnameToComputerName alias "DnsHostnameToComputerNameW"(byval Hostname as LPCWSTR, byval ComputerName as LPWSTR, byval nSize as LPDWORD) as WINBOOL
	declare function GetUserName alias "GetUserNameW"(byval lpBuffer as LPWSTR, byval pcbBuffer as LPDWORD) as WINBOOL
#else
	declare function SetComputerNameEx alias "SetComputerNameExA"(byval NameType as COMPUTER_NAME_FORMAT, byval lpBuffer as LPCTSTR) as WINBOOL
	declare function GetComputerName alias "GetComputerNameA"(byval lpBuffer as LPSTR, byval nSize as LPDWORD) as WINBOOL
	declare function SetComputerName alias "SetComputerNameA"(byval lpComputerName as LPCSTR) as WINBOOL
	declare function DnsHostnameToComputerName alias "DnsHostnameToComputerNameA"(byval Hostname as LPCSTR, byval ComputerName as LPSTR, byval nSize as LPDWORD) as WINBOOL
	declare function GetUserName alias "GetUserNameA"(byval lpBuffer as LPSTR, byval pcbBuffer as LPDWORD) as WINBOOL
#endif

const LOGON32_LOGON_INTERACTIVE = 2
const LOGON32_LOGON_NETWORK = 3
const LOGON32_LOGON_BATCH = 4
const LOGON32_LOGON_SERVICE = 5
const LOGON32_LOGON_UNLOCK = 7
const LOGON32_LOGON_NETWORK_CLEARTEXT = 8
const LOGON32_LOGON_NEW_CREDENTIALS = 9
const LOGON32_PROVIDER_DEFAULT = 0
const LOGON32_PROVIDER_WINNT35 = 1
const LOGON32_PROVIDER_WINNT40 = 2
const LOGON32_PROVIDER_WINNT50 = 3

#if _WIN32_WINNT >= &h0600
	const LOGON32_PROVIDER_VIRTUAL = 4
#endif

declare function LogonUserA(byval lpszUsername as LPCSTR, byval lpszDomain as LPCSTR, byval lpszPassword as LPCSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE) as WINBOOL
declare function LogonUserW(byval lpszUsername as LPCWSTR, byval lpszDomain as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE) as WINBOOL
declare function LogonUserExA(byval lpszUsername as LPCSTR, byval lpszDomain as LPCSTR, byval lpszPassword as LPCSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE, byval ppLogonSid as PSID ptr, byval ppProfileBuffer as PVOID ptr, byval pdwProfileLength as LPDWORD, byval pQuotaLimits as PQUOTA_LIMITS) as WINBOOL
declare function LogonUserExW(byval lpszUsername as LPCWSTR, byval lpszDomain as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE, byval ppLogonSid as PSID ptr, byval ppProfileBuffer as PVOID ptr, byval pdwProfileLength as LPDWORD, byval pQuotaLimits as PQUOTA_LIMITS) as WINBOOL
declare function CreateProcessAsUserA(byval hToken as HANDLE, byval lpApplicationName as LPCSTR, byval lpCommandLine as LPSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCSTR, byval lpStartupInfo as LPSTARTUPINFOA, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL

#ifdef UNICODE
	declare function LogonUser alias "LogonUserW"(byval lpszUsername as LPCWSTR, byval lpszDomain as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE) as WINBOOL
	declare function LogonUserEx alias "LogonUserExW"(byval lpszUsername as LPCWSTR, byval lpszDomain as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE, byval ppLogonSid as PSID ptr, byval ppProfileBuffer as PVOID ptr, byval pdwProfileLength as LPDWORD, byval pQuotaLimits as PQUOTA_LIMITS) as WINBOOL
#else
	declare function CreateProcessAsUser alias "CreateProcessAsUserA"(byval hToken as HANDLE, byval lpApplicationName as LPCSTR, byval lpCommandLine as LPSTR, byval lpProcessAttributes as LPSECURITY_ATTRIBUTES, byval lpThreadAttributes as LPSECURITY_ATTRIBUTES, byval bInheritHandles as WINBOOL, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCSTR, byval lpStartupInfo as LPSTARTUPINFOA, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
	declare function LogonUser alias "LogonUserA"(byval lpszUsername as LPCSTR, byval lpszDomain as LPCSTR, byval lpszPassword as LPCSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE) as WINBOOL
	declare function LogonUserEx alias "LogonUserExA"(byval lpszUsername as LPCSTR, byval lpszDomain as LPCSTR, byval lpszPassword as LPCSTR, byval dwLogonType as DWORD, byval dwLogonProvider as DWORD, byval phToken as PHANDLE, byval ppLogonSid as PSID ptr, byval ppProfileBuffer as PVOID ptr, byval pdwProfileLength as LPDWORD, byval pQuotaLimits as PQUOTA_LIMITS) as WINBOOL
#endif

const LOGON_WITH_PROFILE = &h00000001
const LOGON_NETCREDENTIALS_ONLY = &h00000002
const LOGON_ZERO_PASSWORD_BUFFER = &h80000000

declare function CreateProcessWithLogonW(byval lpUsername as LPCWSTR, byval lpDomain as LPCWSTR, byval lpPassword as LPCWSTR, byval dwLogonFlags as DWORD, byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
declare function CreateProcessWithTokenW(byval hToken as HANDLE, byval dwLogonFlags as DWORD, byval lpApplicationName as LPCWSTR, byval lpCommandLine as LPWSTR, byval dwCreationFlags as DWORD, byval lpEnvironment as LPVOID, byval lpCurrentDirectory as LPCWSTR, byval lpStartupInfo as LPSTARTUPINFOW, byval lpProcessInformation as LPPROCESS_INFORMATION) as WINBOOL
declare function IsTokenUntrusted(byval TokenHandle as HANDLE) as WINBOOL
declare function RegisterWaitForSingleObject(byval phNewWaitObject as PHANDLE, byval hObject as HANDLE, byval Callback as WAITORTIMERCALLBACK, byval Context as PVOID, byval dwMilliseconds as ULONG, byval dwFlags as ULONG) as WINBOOL
declare function UnregisterWait(byval WaitHandle as HANDLE) as WINBOOL
declare function BindIoCompletionCallback(byval FileHandle as HANDLE, byval Function as LPOVERLAPPED_COMPLETION_ROUTINE, byval Flags as ULONG) as WINBOOL
declare function SetTimerQueueTimer(byval TimerQueue as HANDLE, byval Callback as WAITORTIMERCALLBACK, byval Parameter as PVOID, byval DueTime as DWORD, byval Period as DWORD, byval PreferIo as WINBOOL) as HANDLE
declare function CancelTimerQueueTimer(byval TimerQueue as HANDLE, byval Timer as HANDLE) as WINBOOL
declare function DeleteTimerQueue(byval TimerQueue as HANDLE) as WINBOOL
declare function CreatePrivateNamespaceA(byval lpPrivateNamespaceAttributes as LPSECURITY_ATTRIBUTES, byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCSTR) as HANDLE
declare function OpenPrivateNamespaceA(byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCSTR) as HANDLE
declare function CreateBoundaryDescriptorA(byval Name as LPCSTR, byval Flags as ULONG) as HANDLE
declare function AddIntegrityLabelToBoundaryDescriptor(byval BoundaryDescriptor as HANDLE ptr, byval IntegrityLabel as PSID) as WINBOOL

#ifdef UNICODE
	declare function OpenPrivateNamespace alias "OpenPrivateNamespaceW"(byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCWSTR) as HANDLE
#else
	declare function CreatePrivateNamespace alias "CreatePrivateNamespaceA"(byval lpPrivateNamespaceAttributes as LPSECURITY_ATTRIBUTES, byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCSTR) as HANDLE
	declare function OpenPrivateNamespace alias "OpenPrivateNamespaceA"(byval lpBoundaryDescriptor as LPVOID, byval lpAliasPrefix as LPCSTR) as HANDLE
	declare function CreateBoundaryDescriptor alias "CreateBoundaryDescriptorA"(byval Name as LPCSTR, byval Flags as ULONG) as HANDLE
#endif

const HW_PROFILE_GUIDLEN = 39
const MAX_PROFILE_LEN = 80
const DOCKINFO_UNDOCKED = &h1
const DOCKINFO_DOCKED = &h2
const DOCKINFO_USER_SUPPLIED = &h4
const DOCKINFO_USER_UNDOCKED = DOCKINFO_USER_SUPPLIED or DOCKINFO_UNDOCKED
const DOCKINFO_USER_DOCKED = DOCKINFO_USER_SUPPLIED or DOCKINFO_DOCKED

type tagHW_PROFILE_INFOA
	dwDockInfo as DWORD
	szHwProfileGuid as zstring * 39
	szHwProfileName as zstring * 80
end type

type HW_PROFILE_INFOA as tagHW_PROFILE_INFOA
type LPHW_PROFILE_INFOA as tagHW_PROFILE_INFOA ptr

type tagHW_PROFILE_INFOW
	dwDockInfo as DWORD
	szHwProfileGuid as wstring * 39
	szHwProfileName as wstring * 80
end type

type HW_PROFILE_INFOW as tagHW_PROFILE_INFOW
type LPHW_PROFILE_INFOW as tagHW_PROFILE_INFOW ptr

#ifdef UNICODE
	type HW_PROFILE_INFO as HW_PROFILE_INFOW
	type LPHW_PROFILE_INFO as LPHW_PROFILE_INFOW
#else
	type HW_PROFILE_INFO as HW_PROFILE_INFOA
	type LPHW_PROFILE_INFO as LPHW_PROFILE_INFOA
#endif

declare function GetCurrentHwProfileA(byval lpHwProfileInfo as LPHW_PROFILE_INFOA) as WINBOOL
declare function GetCurrentHwProfileW(byval lpHwProfileInfo as LPHW_PROFILE_INFOW) as WINBOOL
declare function VerifyVersionInfoA(byval lpVersionInformation as LPOSVERSIONINFOEXA, byval dwTypeMask as DWORD, byval dwlConditionMask as DWORDLONG) as WINBOOL
declare function VerifyVersionInfoW(byval lpVersionInformation as LPOSVERSIONINFOEXW, byval dwTypeMask as DWORD, byval dwlConditionMask as DWORDLONG) as WINBOOL

#ifdef UNICODE
	declare function GetCurrentHwProfile alias "GetCurrentHwProfileW"(byval lpHwProfileInfo as LPHW_PROFILE_INFOW) as WINBOOL
	declare function VerifyVersionInfo alias "VerifyVersionInfoW"(byval lpVersionInformation as LPOSVERSIONINFOEXW, byval dwTypeMask as DWORD, byval dwlConditionMask as DWORDLONG) as WINBOOL
#else
	declare function GetCurrentHwProfile alias "GetCurrentHwProfileA"(byval lpHwProfileInfo as LPHW_PROFILE_INFOA) as WINBOOL
	declare function VerifyVersionInfo alias "VerifyVersionInfoA"(byval lpVersionInformation as LPOSVERSIONINFOEXA, byval dwTypeMask as DWORD, byval dwlConditionMask as DWORDLONG) as WINBOOL
#endif

#define _TIMEZONEAPI_H_
const TIME_ZONE_ID_INVALID = cast(DWORD, &hffffffff)

type _TIME_ZONE_INFORMATION
	Bias as LONG
	StandardName as wstring * 32
	StandardDate as SYSTEMTIME
	StandardBias as LONG
	DaylightName as wstring * 32
	DaylightDate as SYSTEMTIME
	DaylightBias as LONG
end type

type TIME_ZONE_INFORMATION as _TIME_ZONE_INFORMATION
type PTIME_ZONE_INFORMATION as _TIME_ZONE_INFORMATION ptr
type LPTIME_ZONE_INFORMATION as _TIME_ZONE_INFORMATION ptr

type _TIME_DYNAMIC_ZONE_INFORMATION
	Bias as LONG
	StandardName as wstring * 32
	StandardDate as SYSTEMTIME
	StandardBias as LONG
	DaylightName as wstring * 32
	DaylightDate as SYSTEMTIME
	DaylightBias as LONG
	TimeZoneKeyName as wstring * 128
	DynamicDaylightTimeDisabled as WINBOOLEAN
end type

type DYNAMIC_TIME_ZONE_INFORMATION as _TIME_DYNAMIC_ZONE_INFORMATION
type PDYNAMIC_TIME_ZONE_INFORMATION as _TIME_DYNAMIC_ZONE_INFORMATION ptr
declare function SystemTimeToTzSpecificLocalTime(byval lpTimeZoneInformation as const TIME_ZONE_INFORMATION ptr, byval lpUniversalTime as const SYSTEMTIME ptr, byval lpLocalTime as LPSYSTEMTIME) as WINBOOL
declare function TzSpecificLocalTimeToSystemTime(byval lpTimeZoneInformation as const TIME_ZONE_INFORMATION ptr, byval lpLocalTime as const SYSTEMTIME ptr, byval lpUniversalTime as LPSYSTEMTIME) as WINBOOL
declare function FileTimeToSystemTime(byval lpFileTime as const FILETIME ptr, byval lpSystemTime as LPSYSTEMTIME) as WINBOOL
declare function SystemTimeToFileTime(byval lpSystemTime as const SYSTEMTIME ptr, byval lpFileTime as LPFILETIME) as WINBOOL
declare function GetTimeZoneInformation(byval lpTimeZoneInformation as LPTIME_ZONE_INFORMATION) as DWORD

#if _WIN32_WINNT >= &h0600
	declare function GetDynamicTimeZoneInformation(byval pTimeZoneInformation as PDYNAMIC_TIME_ZONE_INFORMATION) as DWORD
#endif

#if _WIN32_WINNT >= &h0601
	declare function GetTimeZoneInformationForYear(byval wYear as USHORT, byval pdtzi as PDYNAMIC_TIME_ZONE_INFORMATION, byval ptzi as LPTIME_ZONE_INFORMATION) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	declare function EnumDynamicTimeZoneInformation(byval dwIndex as const DWORD, byval lpTimeZoneInformation as PDYNAMIC_TIME_ZONE_INFORMATION) as DWORD
	declare function GetDynamicTimeZoneInformationEffectiveYears(byval lpTimeZoneInformation as const PDYNAMIC_TIME_ZONE_INFORMATION, byval FirstYear as LPDWORD, byval LastYear as LPDWORD) as DWORD
	declare function SystemTimeToTzSpecificLocalTimeEx(byval lpTimeZoneInformation as const DYNAMIC_TIME_ZONE_INFORMATION ptr, byval lpUniversalTime as const SYSTEMTIME ptr, byval lpLocalTime as LPSYSTEMTIME) as WINBOOL
	declare function TzSpecificLocalTimeToSystemTimeEx(byval lpTimeZoneInformation as const DYNAMIC_TIME_ZONE_INFORMATION ptr, byval lpLocalTime as const SYSTEMTIME ptr, byval lpUniversalTime as LPSYSTEMTIME) as WINBOOL
#endif

declare function SetTimeZoneInformation(byval lpTimeZoneInformation as const TIME_ZONE_INFORMATION ptr) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function SetDynamicTimeZoneInformation(byval lpTimeZoneInformation as const DYNAMIC_TIME_ZONE_INFORMATION ptr) as WINBOOL
#endif

const TC_NORMAL = 0
const TC_HARDERR = 1
const TC_GP_TRAP = 2
const TC_SIGNAL = 3
const AC_LINE_OFFLINE = &h00
const AC_LINE_ONLINE = &h01
const AC_LINE_BACKUP_POWER = &h02
const AC_LINE_UNKNOWN = &hff
const BATTERY_FLAG_HIGH = &h01
const BATTERY_FLAG_LOW = &h02
const BATTERY_FLAG_CRITICAL = &h04
const BATTERY_FLAG_CHARGING = &h08
const BATTERY_FLAG_NO_BATTERY = &h80
const BATTERY_FLAG_UNKNOWN = &hff
const BATTERY_PERCENTAGE_UNKNOWN = &hff
const BATTERY_LIFE_UNKNOWN = &hffffffff

type _SYSTEM_POWER_STATUS
	ACLineStatus as UBYTE
	BatteryFlag as UBYTE
	BatteryLifePercent as UBYTE
	Reserved1 as UBYTE
	BatteryLifeTime as DWORD
	BatteryFullLifeTime as DWORD
end type

type SYSTEM_POWER_STATUS as _SYSTEM_POWER_STATUS
type LPSYSTEM_POWER_STATUS as _SYSTEM_POWER_STATUS ptr
declare function GetSystemPowerStatus(byval lpSystemPowerStatus as LPSYSTEM_POWER_STATUS) as WINBOOL
declare function SetSystemPowerState(byval fSuspend as WINBOOL, byval fForce as WINBOOL) as WINBOOL

#if _WIN32_WINNT = &h0602
	type PBAD_MEMORY_CALLBACK_ROUTINE as sub()
	declare function RegisterBadMemoryNotification(byval Callback as PBAD_MEMORY_CALLBACK_ROUTINE) as PVOID
	declare function UnregisterBadMemoryNotification(byval RegistrationHandle as PVOID) as WINBOOL
	declare function GetMemoryErrorHandlingCapabilities(byval Capabilities as PULONG) as WINBOOL
	const MEHC_PATROL_SCRUBBER_PRESENT = &h1
#endif

declare function AllocateUserPhysicalPages(byval hProcess as HANDLE, byval NumberOfPages as PULONG_PTR, byval PageArray as PULONG_PTR) as WINBOOL
declare function FreeUserPhysicalPages(byval hProcess as HANDLE, byval NumberOfPages as PULONG_PTR, byval PageArray as PULONG_PTR) as WINBOOL
declare function MapUserPhysicalPages(byval VirtualAddress as PVOID, byval NumberOfPages as ULONG_PTR, byval PageArray as PULONG_PTR) as WINBOOL
declare function MapUserPhysicalPagesScatter(byval VirtualAddresses as PVOID ptr, byval NumberOfPages as ULONG_PTR, byval PageArray as PULONG_PTR) as WINBOOL
declare function CreateJobObjectA(byval lpJobAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR) as HANDLE
declare function CreateJobObjectW(byval lpJobAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR) as HANDLE
declare function OpenJobObjectA(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
declare function OpenJobObjectW(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
declare function AssignProcessToJobObject(byval hJob as HANDLE, byval hProcess as HANDLE) as WINBOOL
declare function TerminateJobObject(byval hJob as HANDLE, byval uExitCode as UINT) as WINBOOL
declare function QueryInformationJobObject(byval hJob as HANDLE, byval JobObjectInformationClass as JOBOBJECTINFOCLASS, byval lpJobObjectInformation as LPVOID, byval cbJobObjectInformationLength as DWORD, byval lpReturnLength as LPDWORD) as WINBOOL
declare function SetInformationJobObject(byval hJob as HANDLE, byval JobObjectInformationClass as JOBOBJECTINFOCLASS, byval lpJobObjectInformation as LPVOID, byval cbJobObjectInformationLength as DWORD) as WINBOOL
declare function CreateJobSet(byval NumJob as ULONG, byval UserJobSet as PJOB_SET_ARRAY, byval Flags as ULONG) as WINBOOL
declare function FindFirstVolumeA(byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as HANDLE
declare function FindNextVolumeA(byval hFindVolume as HANDLE, byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function FindFirstVolumeMountPointA(byval lpszRootPathName as LPCSTR, byval lpszVolumeMountPoint as LPSTR, byval cchBufferLength as DWORD) as HANDLE
declare function FindFirstVolumeMountPointW(byval lpszRootPathName as LPCWSTR, byval lpszVolumeMountPoint as LPWSTR, byval cchBufferLength as DWORD) as HANDLE
declare function FindNextVolumeMountPointA(byval hFindVolumeMountPoint as HANDLE, byval lpszVolumeMountPoint as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function FindNextVolumeMountPointW(byval hFindVolumeMountPoint as HANDLE, byval lpszVolumeMountPoint as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function FindVolumeMountPointClose(byval hFindVolumeMountPoint as HANDLE) as WINBOOL
declare function SetVolumeMountPointA(byval lpszVolumeMountPoint as LPCSTR, byval lpszVolumeName as LPCSTR) as WINBOOL
declare function SetVolumeMountPointW(byval lpszVolumeMountPoint as LPCWSTR, byval lpszVolumeName as LPCWSTR) as WINBOOL
declare function DeleteVolumeMountPointA(byval lpszVolumeMountPoint as LPCSTR) as WINBOOL
declare function GetVolumeNameForVolumeMountPointA(byval lpszVolumeMountPoint as LPCSTR, byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function GetVolumePathNameA(byval lpszFileName as LPCSTR, byval lpszVolumePathName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
declare function GetVolumePathNamesForVolumeNameA(byval lpszVolumeName as LPCSTR, byval lpszVolumePathNames as LPCH, byval cchBufferLength as DWORD, byval lpcchReturnLength as PDWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function AllocateUserPhysicalPagesNuma(byval hProcess as HANDLE, byval NumberOfPages as PULONG_PTR, byval PageArray as PULONG_PTR, byval nndPreferred as DWORD) as WINBOOL
#endif

#ifdef UNICODE
	declare function CreateJobObject alias "CreateJobObjectW"(byval lpJobAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCWSTR) as HANDLE
	declare function OpenJobObject alias "OpenJobObjectW"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCWSTR) as HANDLE
	declare function FindFirstVolumeMountPoint alias "FindFirstVolumeMountPointW"(byval lpszRootPathName as LPCWSTR, byval lpszVolumeMountPoint as LPWSTR, byval cchBufferLength as DWORD) as HANDLE
	declare function FindNextVolumeMountPoint alias "FindNextVolumeMountPointW"(byval hFindVolumeMountPoint as HANDLE, byval lpszVolumeMountPoint as LPWSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function SetVolumeMountPoint alias "SetVolumeMountPointW"(byval lpszVolumeMountPoint as LPCWSTR, byval lpszVolumeName as LPCWSTR) as WINBOOL
#else
	declare function FindFirstVolume alias "FindFirstVolumeA"(byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as HANDLE
	declare function FindNextVolume alias "FindNextVolumeA"(byval hFindVolume as HANDLE, byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function DeleteVolumeMountPoint alias "DeleteVolumeMountPointA"(byval lpszVolumeMountPoint as LPCSTR) as WINBOOL
	declare function GetVolumeNameForVolumeMountPoint alias "GetVolumeNameForVolumeMountPointA"(byval lpszVolumeMountPoint as LPCSTR, byval lpszVolumeName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function GetVolumePathName alias "GetVolumePathNameA"(byval lpszFileName as LPCSTR, byval lpszVolumePathName as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function GetVolumePathNamesForVolumeName alias "GetVolumePathNamesForVolumeNameA"(byval lpszVolumeName as LPCSTR, byval lpszVolumePathNames as LPCH, byval cchBufferLength as DWORD, byval lpcchReturnLength as PDWORD) as WINBOOL
	declare function CreateJobObject alias "CreateJobObjectA"(byval lpJobAttributes as LPSECURITY_ATTRIBUTES, byval lpName as LPCSTR) as HANDLE
	declare function OpenJobObject alias "OpenJobObjectA"(byval dwDesiredAccess as DWORD, byval bInheritHandle as WINBOOL, byval lpName as LPCSTR) as HANDLE
	declare function FindFirstVolumeMountPoint alias "FindFirstVolumeMountPointA"(byval lpszRootPathName as LPCSTR, byval lpszVolumeMountPoint as LPSTR, byval cchBufferLength as DWORD) as HANDLE
	declare function FindNextVolumeMountPoint alias "FindNextVolumeMountPointA"(byval hFindVolumeMountPoint as HANDLE, byval lpszVolumeMountPoint as LPSTR, byval cchBufferLength as DWORD) as WINBOOL
	declare function SetVolumeMountPoint alias "SetVolumeMountPointA"(byval lpszVolumeMountPoint as LPCSTR, byval lpszVolumeName as LPCSTR) as WINBOOL
#endif

const ACTCTX_FLAG_PROCESSOR_ARCHITECTURE_VALID = &h00000001
const ACTCTX_FLAG_LANGID_VALID = &h00000002
const ACTCTX_FLAG_ASSEMBLY_DIRECTORY_VALID = &h00000004
const ACTCTX_FLAG_RESOURCE_NAME_VALID = &h00000008
const ACTCTX_FLAG_SET_PROCESS_DEFAULT = &h00000010
const ACTCTX_FLAG_APPLICATION_NAME_VALID = &h00000020
const ACTCTX_FLAG_SOURCE_IS_ASSEMBLYREF = &h00000040
const ACTCTX_FLAG_HMODULE_VALID = &h00000080

type tagACTCTXA
	cbSize as ULONG
	dwFlags as DWORD
	lpSource as LPCSTR
	wProcessorArchitecture as USHORT
	wLangId as LANGID
	lpAssemblyDirectory as LPCSTR
	lpResourceName as LPCSTR
	lpApplicationName as LPCSTR
	hModule as HMODULE
end type

type ACTCTXA as tagACTCTXA
type PACTCTXA as tagACTCTXA ptr

type tagACTCTXW
	cbSize as ULONG
	dwFlags as DWORD
	lpSource as LPCWSTR
	wProcessorArchitecture as USHORT
	wLangId as LANGID
	lpAssemblyDirectory as LPCWSTR
	lpResourceName as LPCWSTR
	lpApplicationName as LPCWSTR
	hModule as HMODULE
end type

type ACTCTXW as tagACTCTXW
type PACTCTXW as tagACTCTXW ptr

#ifdef UNICODE
	type ACTCTX as ACTCTXW
	type PACTCTX as PACTCTXW
#else
	type ACTCTX as ACTCTXA
	type PACTCTX as PACTCTXA
#endif

type PCACTCTXA as const ACTCTXA ptr
type PCACTCTXW as const ACTCTXW ptr

#ifdef UNICODE
	type PCACTCTX as PCACTCTXW
#else
	type PCACTCTX as PCACTCTXA
#endif

declare function CreateActCtxA(byval pActCtx as PCACTCTXA) as HANDLE
declare function CreateActCtxW(byval pActCtx as PCACTCTXW) as HANDLE
declare sub AddRefActCtx(byval hActCtx as HANDLE)
declare sub ReleaseActCtx(byval hActCtx as HANDLE)
declare function ZombifyActCtx(byval hActCtx as HANDLE) as WINBOOL
declare function ActivateActCtx(byval hActCtx as HANDLE, byval lpCookie as ULONG_PTR ptr) as WINBOOL
declare function DeactivateActCtx(byval dwFlags as DWORD, byval ulCookie as ULONG_PTR) as WINBOOL
declare function GetCurrentActCtx(byval lphActCtx as HANDLE ptr) as WINBOOL

#ifdef UNICODE
	declare function CreateActCtx alias "CreateActCtxW"(byval pActCtx as PCACTCTXW) as HANDLE
#else
	declare function CreateActCtx alias "CreateActCtxA"(byval pActCtx as PCACTCTXA) as HANDLE
#endif

const DEACTIVATE_ACTCTX_FLAG_FORCE_EARLY_DEACTIVATION = &h00000001

type tagACTCTX_SECTION_KEYED_DATA_2600
	cbSize as ULONG
	ulDataFormatVersion as ULONG
	lpData as PVOID
	ulLength as ULONG
	lpSectionGlobalData as PVOID
	ulSectionGlobalDataLength as ULONG
	lpSectionBase as PVOID
	ulSectionTotalLength as ULONG
	hActCtx as HANDLE
	ulAssemblyRosterIndex as ULONG
end type

type ACTCTX_SECTION_KEYED_DATA_2600 as tagACTCTX_SECTION_KEYED_DATA_2600
type PACTCTX_SECTION_KEYED_DATA_2600 as tagACTCTX_SECTION_KEYED_DATA_2600 ptr
type PCACTCTX_SECTION_KEYED_DATA_2600 as const ACTCTX_SECTION_KEYED_DATA_2600 ptr

type tagACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
	lpInformation as PVOID
	lpSectionBase as PVOID
	ulSectionLength as ULONG
	lpSectionGlobalDataBase as PVOID
	ulSectionGlobalDataLength as ULONG
end type

type ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA as tagACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
type PACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA as tagACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA ptr
type PCACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA as const ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA ptr

type tagACTCTX_SECTION_KEYED_DATA
	cbSize as ULONG
	ulDataFormatVersion as ULONG
	lpData as PVOID
	ulLength as ULONG
	lpSectionGlobalData as PVOID
	ulSectionGlobalDataLength as ULONG
	lpSectionBase as PVOID
	ulSectionTotalLength as ULONG
	hActCtx as HANDLE
	ulAssemblyRosterIndex as ULONG
	ulFlags as ULONG
	AssemblyMetadata as ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
end type

type ACTCTX_SECTION_KEYED_DATA as tagACTCTX_SECTION_KEYED_DATA
type PACTCTX_SECTION_KEYED_DATA as tagACTCTX_SECTION_KEYED_DATA ptr
type PCACTCTX_SECTION_KEYED_DATA as const ACTCTX_SECTION_KEYED_DATA ptr

const FIND_ACTCTX_SECTION_KEY_RETURN_HACTCTX = &h00000001
const FIND_ACTCTX_SECTION_KEY_RETURN_FLAGS = &h00000002
const FIND_ACTCTX_SECTION_KEY_RETURN_ASSEMBLY_METADATA = &h00000004

declare function FindActCtxSectionStringA(byval dwFlags as DWORD, byval lpExtensionGuid as const GUID ptr, byval ulSectionId as ULONG, byval lpStringToFind as LPCSTR, byval ReturnedData as PACTCTX_SECTION_KEYED_DATA) as WINBOOL
declare function FindActCtxSectionStringW(byval dwFlags as DWORD, byval lpExtensionGuid as const GUID ptr, byval ulSectionId as ULONG, byval lpStringToFind as LPCWSTR, byval ReturnedData as PACTCTX_SECTION_KEYED_DATA) as WINBOOL
declare function FindActCtxSectionGuid(byval dwFlags as DWORD, byval lpExtensionGuid as const GUID ptr, byval ulSectionId as ULONG, byval lpGuidToFind as const GUID ptr, byval ReturnedData as PACTCTX_SECTION_KEYED_DATA) as WINBOOL

#ifdef UNICODE
	declare function FindActCtxSectionString alias "FindActCtxSectionStringW"(byval dwFlags as DWORD, byval lpExtensionGuid as const GUID ptr, byval ulSectionId as ULONG, byval lpStringToFind as LPCWSTR, byval ReturnedData as PACTCTX_SECTION_KEYED_DATA) as WINBOOL
#else
	declare function FindActCtxSectionString alias "FindActCtxSectionStringA"(byval dwFlags as DWORD, byval lpExtensionGuid as const GUID ptr, byval ulSectionId as ULONG, byval lpStringToFind as LPCSTR, byval ReturnedData as PACTCTX_SECTION_KEYED_DATA) as WINBOOL
#endif

type _ACTIVATION_CONTEXT_BASIC_INFORMATION
	hActCtx as HANDLE
	dwFlags as DWORD
end type

type ACTIVATION_CONTEXT_BASIC_INFORMATION as _ACTIVATION_CONTEXT_BASIC_INFORMATION
type PACTIVATION_CONTEXT_BASIC_INFORMATION as _ACTIVATION_CONTEXT_BASIC_INFORMATION ptr
type PCACTIVATION_CONTEXT_BASIC_INFORMATION as const _ACTIVATION_CONTEXT_BASIC_INFORMATION ptr

const ACTIVATION_CONTEXT_BASIC_INFORMATION_DEFINED = 1
const QUERY_ACTCTX_FLAG_USE_ACTIVE_ACTCTX = &h00000004
const QUERY_ACTCTX_FLAG_ACTCTX_IS_HMODULE = &h00000008
const QUERY_ACTCTX_FLAG_ACTCTX_IS_ADDRESS = &h00000010
const QUERY_ACTCTX_FLAG_NO_ADDREF = &h80000000
declare function QueryActCtxW(byval dwFlags as DWORD, byval hActCtx as HANDLE, byval pvSubInstance as PVOID, byval ulInfoClass as ULONG, byval pvBuffer as PVOID, byval cbBuffer as SIZE_T_, byval pcbWrittenOrRequired as SIZE_T_ ptr) as WINBOOL
type PQUERYACTCTXW_FUNC as function(byval dwFlags as DWORD, byval hActCtx as HANDLE, byval pvSubInstance as PVOID, byval ulInfoClass as ULONG, byval pvBuffer as PVOID, byval cbBuffer as SIZE_T_, byval pcbWrittenOrRequired as SIZE_T_ ptr) as WINBOOL

declare function WTSGetActiveConsoleSessionId() as DWORD
declare function GetNumaProcessorNode(byval Processor as UCHAR, byval NodeNumber as PUCHAR) as WINBOOL
declare function GetNumaNodeProcessorMask(byval Node as UCHAR, byval ProcessorMask as PULONGLONG) as WINBOOL
declare function GetNumaAvailableMemoryNode(byval Node as UCHAR, byval AvailableBytes as PULONGLONG) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function GetNumaProximityNode(byval ProximityId as ULONG, byval NodeNumber as PUCHAR) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function GetActiveProcessorGroupCount() as WORD
	declare function GetMaximumProcessorGroupCount() as WORD
	declare function GetActiveProcessorCount(byval GroupNumber as WORD) as DWORD
	declare function GetMaximumProcessorCount(byval GroupNumber as WORD) as DWORD
	declare function GetNumaNodeNumberFromHandle(byval hFile as HANDLE, byval NodeNumber as PUSHORT) as WINBOOL
	declare function GetNumaProcessorNodeEx(byval Processor as PPROCESSOR_NUMBER, byval NodeNumber as PUSHORT) as WINBOOL
	declare function GetNumaAvailableMemoryNodeEx(byval Node as USHORT, byval AvailableBytes as PULONGLONG) as WINBOOL
	declare function GetNumaProximityNodeEx(byval ProximityId as ULONG, byval NodeNumber as PUSHORT) as WINBOOL
#endif

type APPLICATION_RECOVERY_CALLBACK as function(byval pvParameter as PVOID) as DWORD
const RESTART_MAX_CMD_LINE = 1024
const RESTART_NO_CRASH = 1
const RESTART_NO_HANG = 2
const RESTART_NO_PATCH = 4
const RESTART_NO_REBOOT = 8
const RECOVERY_DEFAULT_PING_INTERVAL = 5000
const RECOVERY_MAX_PING_INTERVAL = (5 * 60) * 1000

#if _WIN32_WINNT >= &h0600
	declare function RegisterApplicationRecoveryCallback(byval pRecoveyCallback as APPLICATION_RECOVERY_CALLBACK, byval pvParameter as PVOID, byval dwPingInterval as DWORD, byval dwFlags as DWORD) as HRESULT
	declare function UnregisterApplicationRecoveryCallback() as HRESULT
	declare function RegisterApplicationRestart(byval pwzCommandline as PCWSTR, byval dwFlags as DWORD) as HRESULT
	declare function UnregisterApplicationRestart() as HRESULT
	declare function GetApplicationRecoveryCallback(byval hProcess as HANDLE, byval pRecoveryCallback as APPLICATION_RECOVERY_CALLBACK ptr, byval ppvParameter as PVOID ptr, byval pdwPingInterval as PDWORD, byval pdwFlags as PDWORD) as HRESULT
	declare function GetApplicationRestartSettings(byval hProcess as HANDLE, byval pwzCommandline as PWSTR, byval pcchSize as PDWORD, byval pdwFlags as PDWORD) as HRESULT
	declare function ApplicationRecoveryInProgress(byval pbCancelled as PBOOL) as HRESULT
	declare sub ApplicationRecoveryFinished(byval bSuccess as WINBOOL)

	type _FILE_BASIC_INFO
		CreationTime as LARGE_INTEGER
		LastAccessTime as LARGE_INTEGER
		LastWriteTime as LARGE_INTEGER
		ChangeTime as LARGE_INTEGER
		FileAttributes as DWORD
	end type

	type FILE_BASIC_INFO as _FILE_BASIC_INFO
	type PFILE_BASIC_INFO as _FILE_BASIC_INFO ptr

	type _FILE_STANDARD_INFO
		AllocationSize as LARGE_INTEGER
		EndOfFile as LARGE_INTEGER
		NumberOfLinks as DWORD
		DeletePending as WINBOOLEAN
		Directory as WINBOOLEAN
	end type

	type FILE_STANDARD_INFO as _FILE_STANDARD_INFO
	type PFILE_STANDARD_INFO as _FILE_STANDARD_INFO ptr

	type _FILE_NAME_INFO
		FileNameLength as DWORD
		FileName as wstring * 1
	end type

	type FILE_NAME_INFO as _FILE_NAME_INFO
	type PFILE_NAME_INFO as _FILE_NAME_INFO ptr

	type _FILE_RENAME_INFO
		ReplaceIfExists as WINBOOLEAN
		RootDirectory as HANDLE
		FileNameLength as DWORD
		FileName as wstring * 1
	end type

	type FILE_RENAME_INFO as _FILE_RENAME_INFO
	type PFILE_RENAME_INFO as _FILE_RENAME_INFO ptr

	type _FILE_ALLOCATION_INFO
		AllocationSize as LARGE_INTEGER
	end type

	type FILE_ALLOCATION_INFO as _FILE_ALLOCATION_INFO
	type PFILE_ALLOCATION_INFO as _FILE_ALLOCATION_INFO ptr

	type _FILE_END_OF_FILE_INFO
		EndOfFile as LARGE_INTEGER
	end type

	type FILE_END_OF_FILE_INFO as _FILE_END_OF_FILE_INFO
	type PFILE_END_OF_FILE_INFO as _FILE_END_OF_FILE_INFO ptr

	type _FILE_STREAM_INFO
		NextEntryOffset as DWORD
		StreamNameLength as DWORD
		StreamSize as LARGE_INTEGER
		StreamAllocationSize as LARGE_INTEGER
		StreamName as wstring * 1
	end type

	type FILE_STREAM_INFO as _FILE_STREAM_INFO
	type PFILE_STREAM_INFO as _FILE_STREAM_INFO ptr

	type _FILE_COMPRESSION_INFO
		CompressedFileSize as LARGE_INTEGER
		CompressionFormat as WORD
		CompressionUnitShift as UCHAR
		ChunkShift as UCHAR
		ClusterShift as UCHAR
		Reserved(0 to 2) as UCHAR
	end type

	type FILE_COMPRESSION_INFO as _FILE_COMPRESSION_INFO
	type PFILE_COMPRESSION_INFO as _FILE_COMPRESSION_INFO ptr

	type _FILE_ATTRIBUTE_TAG_INFO
		FileAttributes as DWORD
		ReparseTag as DWORD
	end type

	type FILE_ATTRIBUTE_TAG_INFO as _FILE_ATTRIBUTE_TAG_INFO
	type PFILE_ATTRIBUTE_TAG_INFO as _FILE_ATTRIBUTE_TAG_INFO ptr

	type _FILE_DISPOSITION_INFO
		#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
			DeleteFileW as WINBOOLEAN
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
			DeleteFileA as WINBOOLEAN
		#endif
	end type

	type FILE_DISPOSITION_INFO as _FILE_DISPOSITION_INFO
	type PFILE_DISPOSITION_INFO as _FILE_DISPOSITION_INFO ptr

	type _FILE_ID_BOTH_DIR_INFO
		NextEntryOffset as DWORD
		FileIndex as DWORD
		CreationTime as LARGE_INTEGER
		LastAccessTime as LARGE_INTEGER
		LastWriteTime as LARGE_INTEGER
		ChangeTime as LARGE_INTEGER
		EndOfFile as LARGE_INTEGER
		AllocationSize as LARGE_INTEGER
		FileAttributes as DWORD
		FileNameLength as DWORD
		EaSize as DWORD
		ShortNameLength as byte
		ShortName as wstring * 12
		FileId as LARGE_INTEGER
		FileName as wstring * 1
	end type

	type FILE_ID_BOTH_DIR_INFO as _FILE_ID_BOTH_DIR_INFO
	type PFILE_ID_BOTH_DIR_INFO as _FILE_ID_BOTH_DIR_INFO ptr

	type _FILE_FULL_DIR_INFO
		NextEntryOffset as ULONG
		FileIndex as ULONG
		CreationTime as LARGE_INTEGER
		LastAccessTime as LARGE_INTEGER
		LastWriteTime as LARGE_INTEGER
		ChangeTime as LARGE_INTEGER
		EndOfFile as LARGE_INTEGER
		AllocationSize as LARGE_INTEGER
		FileAttributes as ULONG
		FileNameLength as ULONG
		EaSize as ULONG
		FileName as wstring * 1
	end type

	type FILE_FULL_DIR_INFO as _FILE_FULL_DIR_INFO
	type PFILE_FULL_DIR_INFO as _FILE_FULL_DIR_INFO ptr

	type _PRIORITY_HINT as long
	enum
		IoPriorityHintVeryLow = 0
		IoPriorityHintLow
		IoPriorityHintNormal
		MaximumIoPriorityHintType
	end enum

	type PRIORITY_HINT as _PRIORITY_HINT

	type _FILE_IO_PRIORITY_HINT_INFO
		PriorityHint as PRIORITY_HINT
	end type

	type FILE_IO_PRIORITY_HINT_INFO as _FILE_IO_PRIORITY_HINT_INFO
	type PFILE_IO_PRIORITY_HINT_INFO as _FILE_IO_PRIORITY_HINT_INFO ptr
#endif

#if _WIN32_WINNT = &h0602
	type _FILE_ALIGNMENT_INFO
		AlignmentRequirement as ULONG
	end type

	type FILE_ALIGNMENT_INFO as _FILE_ALIGNMENT_INFO
	type PFILE_ALIGNMENT_INFO as _FILE_ALIGNMENT_INFO ptr
	const STORAGE_INFO_FLAGS_ALIGNED_DEVICE = &h00000001
	const STORAGE_INFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE = &h00000002
	const STORAGE_INFO_OFFSET_UNKNOWN = &hffffffff

	type _FILE_STORAGE_INFO
		LogicalBytesPerSector as ULONG
		PhysicalBytesPerSectorForAtomicity as ULONG
		PhysicalBytesPerSectorForPerformance as ULONG
		FileSystemEffectivePhysicalBytesPerSectorForAtomicity as ULONG
		Flags as ULONG
		ByteOffsetForSectorAlignment as ULONG
		ByteOffsetForPartitionAlignment as ULONG
	end type

	type FILE_STORAGE_INFO as _FILE_STORAGE_INFO
	type PFILE_STORAGE_INFO as _FILE_STORAGE_INFO ptr

	type _FILE_ID_INFO
		VolumeSerialNumber as ULONGLONG
		FileId as FILE_ID_128
	end type

	type FILE_ID_INFO as _FILE_ID_INFO
	type PFILE_ID_INFO as _FILE_ID_INFO ptr

	type _FILE_ID_EXTD_DIR_INFO
		NextEntryOffset as ULONG
		FileIndex as ULONG
		CreationTime as LARGE_INTEGER
		LastAccessTime as LARGE_INTEGER
		LastWriteTime as LARGE_INTEGER
		ChangeTime as LARGE_INTEGER
		EndOfFile as LARGE_INTEGER
		AllocationSize as LARGE_INTEGER
		FileAttributes as ULONG
		FileNameLength as ULONG
		EaSize as ULONG
		ReparsePointTag as ULONG
		FileId as FILE_ID_128
		FileName as wstring * 1
	end type

	type FILE_ID_EXTD_DIR_INFO as _FILE_ID_EXTD_DIR_INFO
	type PFILE_ID_EXTD_DIR_INFO as _FILE_ID_EXTD_DIR_INFO ptr
#endif

#if _WIN32_WINNT >= &h0600
	const REMOTE_PROTOCOL_INFO_FLAG_LOOPBACK = &h00000001
	const REMOTE_PROTOCOL_INFO_FLAG_OFFLINE = &h00000002
#endif

#if _WIN32_WINNT = &h0602
	const REMOTE_PROTOCOL_INFO_FLAG_PERSISTENT_HANDLE = &h00000004
	const RPI_FLAG_SMB2_SHARECAP_TIMEWARP = &h00000002
	const RPI_FLAG_SMB2_SHARECAP_DFS = &h00000008
	const RPI_FLAG_SMB2_SHARECAP_CONTINUOUS_AVAILABILITY = &h00000010
	const RPI_FLAG_SMB2_SHARECAP_SCALEOUT = &h00000020
	const RPI_FLAG_SMB2_SHARECAP_CLUSTER = &h00000040
	const RPI_SMB2_FLAG_SERVERCAP_DFS = &h00000001
	const RPI_SMB2_FLAG_SERVERCAP_LEASING = &h00000002
	const RPI_SMB2_FLAG_SERVERCAP_LARGEMTU = &h00000004
	const RPI_SMB2_FLAG_SERVERCAP_MULTICHANNEL = &h00000008
	const RPI_SMB2_FLAG_SERVERCAP_PERSISTENT_HANDLES = &h00000010
	const RPI_SMB2_FLAG_SERVERCAP_DIRECTORY_LEASING = &h00000020
#endif

#if _WIN32_WINNT >= &h0600
	type _FILE_REMOTE_PROTOCOL_INFO_GenericReserved
		Reserved(0 to 7) as ULONG
	end type
#endif

#if (_WIN32_WINNT = &h0600) or (_WIN32_WINNT = &h0601)
	type _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecificReserved
		Reserved(0 to 15) as ULONG
	end type
#elseif _WIN32_WINNT = &h0602
	type _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Server
		Capabilities as ULONG
	end type

	type _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Share
		Capabilities as ULONG
		CachingFlags as ULONG
	end type

	type _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2
		Server as _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Server
		Share as _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2_Share
	end type

	union _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific
		Smb2 as _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific_Smb2
		Reserved(0 to 15) as ULONG
	end union
#endif

#if _WIN32_WINNT >= &h0600
	type _FILE_REMOTE_PROTOCOL_INFO
		StructureVersion as USHORT
		StructureSize as USHORT
		Protocol as ULONG
		ProtocolMajorVersion as USHORT
		ProtocolMinorVersion as USHORT
		ProtocolRevision as USHORT
		Reserved as USHORT
		Flags as ULONG
		GenericReserved as _FILE_REMOTE_PROTOCOL_INFO_GenericReserved

		#if (_WIN32_WINNT = &h0600) or (_WIN32_WINNT = &h0601)
			ProtocolSpecificReserved as _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecificReserved
		#elseif _WIN32_WINNT = &h0602
			ProtocolSpecific as _FILE_REMOTE_PROTOCOL_INFO_ProtocolSpecific
		#endif
	end type

	type FILE_REMOTE_PROTOCOL_INFO as _FILE_REMOTE_PROTOCOL_INFO
	type PFILE_REMOTE_PROTOCOL_INFO as _FILE_REMOTE_PROTOCOL_INFO ptr
	declare function GetFileInformationByHandleEx(byval hFile as HANDLE, byval FileInformationClass as FILE_INFO_BY_HANDLE_CLASS, byval lpFileInformation as LPVOID, byval dwBufferSize as DWORD) as WINBOOL

	type _FILE_ID_TYPE as long
	enum
		FileIdType
		ObjectIdType
		ExtendedFileIdType
		MaximumFileIdType
	end enum

	type FILE_ID_TYPE as _FILE_ID_TYPE
	type PFILE_ID_TYPE as _FILE_ID_TYPE ptr

	type FILE_ID_DESCRIPTOR
		dwSize as DWORD
		as FILE_ID_TYPE Type

		union
			FileId as LARGE_INTEGER
			ObjectId as GUID

			#if _WIN32_WINNT = &h0602
				ExtendedFileId as FILE_ID_128
			#endif
		end union
	end type

	type LPFILE_ID_DESCRIPTOR as FILE_ID_DESCRIPTOR ptr
	declare function OpenFileById(byval hVolumeHint as HANDLE, byval lpFileId as LPFILE_ID_DESCRIPTOR, byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval dwFlagsAndAttributes as DWORD) as HANDLE
	const SYMBOLIC_LINK_FLAG_DIRECTORY = &h1
	const VALID_SYMBOLIC_LINK_FLAGS = SYMBOLIC_LINK_FLAG_DIRECTORY
	declare function CreateSymbolicLinkA(byval lpSymlinkFileName as LPCSTR, byval lpTargetFileName as LPCSTR, byval dwFlags as DWORD) as WINBOOLEAN
	declare function CreateSymbolicLinkW(byval lpSymlinkFileName as LPCWSTR, byval lpTargetFileName as LPCWSTR, byval dwFlags as DWORD) as WINBOOLEAN
	declare function CreateSymbolicLinkTransactedA(byval lpSymlinkFileName as LPCSTR, byval lpTargetFileName as LPCSTR, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOLEAN
	declare function CreateSymbolicLinkTransactedW(byval lpSymlinkFileName as LPCWSTR, byval lpTargetFileName as LPCWSTR, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOLEAN
	declare function QueryActCtxSettingsW(byval dwFlags as DWORD, byval hActCtx as HANDLE, byval settingsNameSpace as PCWSTR, byval settingName as PCWSTR, byval pvBuffer as PWSTR, byval dwBuffer as SIZE_T_, byval pdwWrittenOrRequired as SIZE_T_ ptr) as WINBOOL
	declare function ReplacePartitionUnit(byval TargetPartition as PWSTR, byval SparePartition as PWSTR, byval Flags as ULONG) as WINBOOL
	declare function AddSecureMemoryCacheCallback(byval pfnCallBack as PSECURE_MEMORY_CACHE_CALLBACK) as WINBOOL
	declare function RemoveSecureMemoryCacheCallback(byval pfnCallBack as PSECURE_MEMORY_CACHE_CALLBACK) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function CreateSymbolicLink alias "CreateSymbolicLinkW"(byval lpSymlinkFileName as LPCWSTR, byval lpTargetFileName as LPCWSTR, byval dwFlags as DWORD) as WINBOOLEAN
	declare function CreateSymbolicLinkTransacted alias "CreateSymbolicLinkTransactedW"(byval lpSymlinkFileName as LPCWSTR, byval lpTargetFileName as LPCWSTR, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOLEAN
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function CreateSymbolicLink alias "CreateSymbolicLinkA"(byval lpSymlinkFileName as LPCSTR, byval lpTargetFileName as LPCSTR, byval dwFlags as DWORD) as WINBOOLEAN
	declare function CreateSymbolicLinkTransacted alias "CreateSymbolicLinkTransactedA"(byval lpSymlinkFileName as LPCSTR, byval lpTargetFileName as LPCSTR, byval dwFlags as DWORD, byval hTransaction as HANDLE) as WINBOOLEAN
#endif

declare function CopyContext(byval Destination as PCONTEXT, byval ContextFlags as DWORD, byval Source as PCONTEXT) as WINBOOL
declare function InitializeContext(byval Buffer as PVOID, byval ContextFlags as DWORD, byval Context as PCONTEXT ptr, byval ContextLength as PDWORD) as WINBOOL
declare function GetEnabledXStateFeatures() as DWORD64
declare function GetXStateFeaturesMask(byval Context as PCONTEXT, byval FeatureMask as PDWORD64) as WINBOOL
declare function LocateXStateFeature(byval Context as PCONTEXT, byval FeatureId as DWORD, byval Length as PDWORD) as PVOID
declare function SetXStateFeaturesMask(byval Context as PCONTEXT, byval FeatureMask as DWORD64) as WINBOOL

#if _WIN32_WINNT >= &h0601
	declare function EnableThreadProfiling(byval ThreadHandle as HANDLE, byval Flags as DWORD, byval HardwareCounters as DWORD64, byval PerformanceDataHandle as HANDLE ptr) as DWORD
	declare function DisableThreadProfiling(byval PerformanceDataHandle as HANDLE) as DWORD
	declare function QueryThreadProfiling(byval ThreadHandle as HANDLE, byval Enabled as PBOOLEAN) as DWORD
	declare function ReadThreadProfilingData(byval PerformanceDataHandle as HANDLE, byval Flags as DWORD, byval PerformanceData as PPERFORMANCE_DATA) as DWORD
#endif

#define MICROSOFT_WINDOWS_WINBASE_INTERLOCKED_CPLUSPLUS_H_INCLUDED
#define MICROSOFT_WINDOWS_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS ((_WIN32_WINNT >= &h0502) orelse (defined(_WINBASE_) = 0))
#undef MICROSOFT_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS
const MICROSOFT_WINBASE_H_DEFINE_INTERLOCKED_CPLUSPLUS_OVERLOADS = 0

end extern
