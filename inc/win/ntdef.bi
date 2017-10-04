'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   ntdef.h
''
''   This file is part of the ReactOS PSDK package.
''
''   Contributors:
''     Created by Casper S. Hornstrup <chorns@users.sourceforge.net>
''
''   THIS SOFTWARE IS NOT COPYRIGHTED
''
''   This source code is offered for use in the public domain. You may
''   use, modify or distribute it freely.
''
''   This code is distributed in the hope that it will be useful but
''   WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
''   DISCLAIMED. This includes but is not limited to warranties of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "_mingw.bi"
#include once "crt/ctype.bi"
#include once "basetsd.bi"
#include once "excpt.bi"
#include once "sdkddkver.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     typedef INT => INT_
''     typedef BOOLEAN => WINBOOLEAN
''     typedef CSHORT => CSHORT_
''     typedef STRING => STRING_

extern "Windows"

#define _NTDEF_

#ifdef __FB_64BIT__
	#define _AMD64_
#endif

#define NOTHING
#define CRITICAL
const ANYSIZE_ARRAY = 1
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
const NULL64 = 0

#ifdef __FB_64BIT__
	#define ALIGNMENT_MACHINE
	#define MAX_NATURAL_ALIGNMENT sizeof(ULONGLONG)
	const MEMORY_ALLOCATION_ALIGNMENT = 16
#else
	#undef ALIGNMENT_MACHINE
	#define MAX_NATURAL_ALIGNMENT sizeof(ULONG)
	const MEMORY_ALLOCATION_ALIGNMENT = 8
#endif

#define ARGUMENT_PRESENT(ArgumentPointer) (cptr(CHAR ptr, cast(ULONG_PTR, (ArgumentPointer))) <> cptr(CHAR ptr, NULL))
#define CONTAINING_RECORD(address, type, field) cptr(type ptr, cast(ULONG_PTR, address) - cast(ULONG_PTR, @cptr(type ptr, 0)->field))
const SYSTEM_CACHE_ALIGNMENT_SIZE = 64
#define min(a, b) iif((a) < (b), (a), (b))
#define max(a, b) iif((a) > (b), (a), (b))
#define BASETYPES

type PVOID as any ptr
type PVOID64 as any ptr
type HANDLE as PVOID
type PHANDLE as HANDLE ptr
type VOID as any
type CHAR as byte
type INT_ as long
type UCHAR as ubyte
type PUCHAR as ubyte ptr
type PUSHORT as ushort ptr
type PULONG as ulong ptr
type PCUCHAR as const UCHAR ptr
type PCUSHORT as const USHORT ptr
type PCULONG as const ULONG ptr
type FCHAR as UCHAR
type FSHORT as USHORT
type FLONG as ULONG
type WINBOOLEAN as UCHAR
#ifndef BOOLEAN
	type BOOLEAN as WINBOOLEAN
#endif
type PBOOLEAN as UCHAR ptr
type LOGICAL as ULONG
type PLOGICAL as ULONG ptr
type PSHORT as SHORT ptr
type PLONG as LONG ptr
type NTSTATUS as LONG
type PNTSTATUS as NTSTATUS ptr
type SCHAR as byte
type PSCHAR as SCHAR ptr
#define _DEF_WINBOOL_
type WINBOOL as long
type BOOL as long
type PBOOL as WINBOOL ptr
type LPBOOL as WINBOOL ptr
#define _HRESULT_DEFINED
type HRESULT as LONG
#define _ULONGLONG_
type LONGLONG as longint
type PLONGLONG as longint ptr
type ULONGLONG as ulongint
type PULONGLONG as ulongint ptr
#define _DWORDLONG_
type DWORDLONG as ULONGLONG
type PDWORDLONG as ULONGLONG ptr
type USN as LONGLONG
type PCHAR as CHAR ptr
type LPCH as CHAR ptr
type PCH as CHAR ptr
type LPCCH as const CHAR ptr
type PCCH as const CHAR ptr
type NPSTR as zstring ptr
type LPSTR as zstring ptr
type PSTR as zstring ptr
type PZPSTR as PSTR ptr
type PCZPSTR as const PSTR ptr
type LPCSTR as const zstring ptr
type PCSTR as const zstring ptr
type PZPCSTR as PCSTR ptr
type PSZ as zstring ptr
type PCSZ as const zstring ptr
#define __WCHAR_DEFINED
type WCHAR as wchar_t
type PWCHAR as WCHAR ptr
type LPWCH as WCHAR ptr
type PWCH as WCHAR ptr
type LPCWCH as const WCHAR ptr
type PCWCH as const WCHAR ptr
type NWPSTR as wstring ptr
type LPWSTR as wstring ptr
type PWSTR as wstring ptr
type PZPWSTR as PWSTR ptr
type PCZPWSTR as const PWSTR ptr
type LPUWSTR as wstring ptr
type PUWSTR as wstring ptr
type LPCWSTR as const wstring ptr
type PCWSTR as const wstring ptr
type PZPCWSTR as PCWSTR ptr
type LPCUWSTR as const wstring ptr
type PCUWSTR as const wstring ptr
type CCHAR as zstring
type PCCHAR as zstring ptr
type CSHORT_ as short
type PCSHORT as short ptr
type CLONG as ULONG
type PCLONG as ULONG ptr
type LCID as ULONG
type PLCID as PULONG
type LANGID as USHORT

type _QUAD
	union
		UseThisFieldToCopy as longint
		DoNotUseThisField as double
	end union
end type

type QUAD as _QUAD
type PQUAD as _QUAD ptr
type UQUAD as _QUAD
type PUQUAD as _QUAD ptr
#define _LARGE_INTEGER_DEFINED

type _LARGE_INTEGER_u
	LowPart as ULONG
	HighPart as LONG
end type

union _LARGE_INTEGER
	type
		LowPart as ULONG
		HighPart as LONG
	end type

	u as _LARGE_INTEGER_u
	QuadPart as LONGLONG
end union

type LARGE_INTEGER as _LARGE_INTEGER
type PLARGE_INTEGER as _LARGE_INTEGER ptr

type _ULARGE_INTEGER_u
	LowPart as ULONG
	HighPart as ULONG
end type

union _ULARGE_INTEGER
	type
		LowPart as ULONG
		HighPart as ULONG
	end type

	u as _ULARGE_INTEGER_u
	QuadPart as ULONGLONG
end union

type ULARGE_INTEGER as _ULARGE_INTEGER
type PULARGE_INTEGER as _ULARGE_INTEGER ptr

type _LUID
	LowPart as ULONG
	HighPart as LONG
end type

type LUID as _LUID
type PLUID as _LUID ptr
type PHYSICAL_ADDRESS as LARGE_INTEGER
type PPHYSICAL_ADDRESS as LARGE_INTEGER ptr

#define NT_SUCCESS(Status) (cast(NTSTATUS, (Status)) >= 0)
#define NT_INFORMATION(Status) ((cast(ULONG, (Status)) shr 30) = 1)
#define NT_WARNING(Status) ((cast(ULONG, (Status)) shr 30) = 2)
#define NT_ERROR(Status) ((cast(ULONG, (Status)) shr 30) = 3)

#ifndef __UNICODE_STRING_DEFINED
#define __UNICODE_STRING_DEFINED
type _UNICODE_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PWSTR
end type
type UNICODE_STRING as _UNICODE_STRING
type PUNICODE_STRING as _UNICODE_STRING ptr
#endif

type PCUNICODE_STRING as const UNICODE_STRING ptr
const UNICODE_NULL = cast(WCHAR, 0)

type _CSTRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as const zstring ptr
end type

type CSTRING as _CSTRING
type PCSTRING as _CSTRING ptr
const ANSI_NULL = cast(CHAR, 0)
#ifndef __STRING_DEFINED
#define __STRING_DEFINED
type _STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PCHAR
end type
type STRING_ as _STRING
type PSTRING as _STRING ptr
#endif
type ANSI_STRING as STRING_
type PANSI_STRING as PSTRING
type OEM_STRING as STRING_
type POEM_STRING as PSTRING
type PCOEM_STRING as const STRING_ ptr
type CANSI_STRING as STRING_
type PCANSI_STRING as PSTRING

type _STRING32
	Length as USHORT
	MaximumLength as USHORT
	Buffer as ULONG
end type

type STRING32 as _STRING32
type PSTRING32 as _STRING32 ptr
type UNICODE_STRING32 as _STRING32
type PUNICODE_STRING32 as _STRING32 ptr
type ANSI_STRING32 as _STRING32
type PANSI_STRING32 as _STRING32 ptr

type _STRING64
	Length as USHORT
	MaximumLength as USHORT
	Buffer as ULONGLONG
end type

type STRING64 as _STRING64
type PSTRING64 as _STRING64 ptr
type UNICODE_STRING64 as _STRING64
type PUNICODE_STRING64 as _STRING64 ptr
type ANSI_STRING64 as _STRING64
type PANSI_STRING64 as _STRING64 ptr

#define MAKELANGID(p, s) ((cast(USHORT, (s)) shl 10) or cast(USHORT, (p)))
#define PRIMARYLANGID(lgid) (cast(USHORT, (lgid)) and &h3ff)
#define SUBLANGID(lgid) (cast(USHORT, (lgid)) shr 10)
const NLS_VALID_LOCALE_MASK = &h000fffff
#define MAKELCID(lgid, srtid) cast(ULONG, (cast(ULONG, cast(USHORT, (srtid))) shl 16) or cast(ULONG, cast(USHORT, (lgid))))
#define MAKESORTLCID(lgid, srtid, ver) cast(ULONG, MAKELCID(lgid, srtid) or (cast(ULONG, cast(USHORT, (ver))) shl 20))
#define LANGIDFROMLCID(lcid) cast(USHORT, (lcid))
#define SORTIDFROMLCID(lcid) cast(USHORT, (cast(ULONG, (lcid)) shr 16) and &hf)
#define SORTVERSIONFROMLCID(lcid) cast(USHORT, (cast(ULONG, (lcid)) shr 20) and &hf)
#define __OBJECT_ATTRIBUTES_DEFINED

type _OBJECT_ATTRIBUTES
	Length as ULONG
	RootDirectory as HANDLE
	ObjectName as PUNICODE_STRING
	Attributes as ULONG
	SecurityDescriptor as PVOID
	SecurityQualityOfService as PVOID
end type

type OBJECT_ATTRIBUTES as _OBJECT_ATTRIBUTES
type POBJECT_ATTRIBUTES as _OBJECT_ATTRIBUTES ptr
type PCOBJECT_ATTRIBUTES as const OBJECT_ATTRIBUTES ptr

const OBJ_INHERIT = &h00000002
const OBJ_PERMANENT = &h00000010
const OBJ_EXCLUSIVE = &h00000020
const OBJ_CASE_INSENSITIVE = &h00000040
const OBJ_OPENIF = &h00000080
const OBJ_OPENLINK = &h00000100
const OBJ_KERNEL_HANDLE = &h00000200
const OBJ_FORCE_ACCESS_CHECK = &h00000400
const OBJ_VALID_ATTRIBUTES = &h000007F2
#macro InitializeObjectAttributes(p, n, a, r, s)
	scope
		(p)->Length = sizeof(OBJECT_ATTRIBUTES)
		(p)->RootDirectory = (r)
		(p)->Attributes = (a)
		(p)->ObjectName = (n)
		(p)->SecurityDescriptor = (s)
		(p)->SecurityQualityOfService = NULL
	end scope
#endmacro

type _NT_PRODUCT_TYPE as long
enum
	NtProductWinNt = 1
	NtProductLanManNt
	NtProductServer
end enum

type NT_PRODUCT_TYPE as _NT_PRODUCT_TYPE
type PNT_PRODUCT_TYPE as _NT_PRODUCT_TYPE ptr

type _EVENT_TYPE as long
enum
	NotificationEvent
	SynchronizationEvent
end enum

type EVENT_TYPE as _EVENT_TYPE

type _TIMER_TYPE as long
enum
	NotificationTimer
	SynchronizationTimer
end enum

type TIMER_TYPE as _TIMER_TYPE

type _WAIT_TYPE as long
enum
	WaitAll
	WaitAny
end enum

type WAIT_TYPE as _WAIT_TYPE
#define _LIST_ENTRY_DEFINED

type _LIST_ENTRY
	Flink as _LIST_ENTRY ptr
	Blink as _LIST_ENTRY ptr
end type

type LIST_ENTRY as _LIST_ENTRY
type PLIST_ENTRY as _LIST_ENTRY ptr
type PRLIST_ENTRY as _LIST_ENTRY ptr

type LIST_ENTRY32
	Flink as ULONG
	Blink as ULONG
end type

type PLIST_ENTRY32 as LIST_ENTRY32 ptr

type LIST_ENTRY64
	Flink as ULONGLONG
	Blink as ULONGLONG
end type

type PLIST_ENTRY64 as LIST_ENTRY64 ptr

type _SINGLE_LIST_ENTRY
	Next as _SINGLE_LIST_ENTRY ptr
end type

type SINGLE_LIST_ENTRY as _SINGLE_LIST_ENTRY
type PSINGLE_LIST_ENTRY as _SINGLE_LIST_ENTRY ptr
#define ___PROCESSOR_NUMBER_DEFINED

type _PROCESSOR_NUMBER
	Group as USHORT
	Number as UCHAR
	Reserved as UCHAR
end type

type PROCESSOR_NUMBER as _PROCESSOR_NUMBER
type PPROCESSOR_NUMBER as _PROCESSOR_NUMBER ptr
#define __PEXCEPTION_ROUTINE_DEFINED
type PEXCEPTION_ROUTINE as function(byval ExceptionRecord as _EXCEPTION_RECORD ptr, byval EstablisherFrame as PVOID, byval ContextRecord as _CONTEXT ptr, byval DispatcherContext as PVOID) as long
#define ___GROUP_AFFINITY_DEFINED

type _GROUP_AFFINITY
	Mask as KAFFINITY
	Group as USHORT
	Reserved(0 to 2) as USHORT
end type

type GROUP_AFFINITY as _GROUP_AFFINITY
type PGROUP_AFFINITY as _GROUP_AFFINITY ptr
#define RTL_FIELD_TYPE(type, field) cptr(type ptr, 0)->field
#define RTL_BITS_OF(sizeOfArg) (sizeof(sizeOfArg) * 8)
#define RTL_BITS_OF_FIELD(type, field) RTL_BITS_OF(RTL_FIELD_TYPE(type, field))
#define RTL_CONSTANT_STRING(s) (sizeof(s) - sizeof((s)[0]), sizeof(s), s)
#define RTL_FIELD_SIZE(type, field) sizeof(cptr(type ptr, 0)->field)
#define RTL_SIZEOF_THROUGH_FIELD(type, field) (FIELD_OFFSET(type, field) + RTL_FIELD_SIZE(type, field))
#define RTL_CONTAINS_FIELD(Struct, Size, Field) ((cast(PCHAR, @(Struct)->Field) + sizeof((Struct)->Field)) <= (cast(PCHAR, (Struct)) + (Size)))
#define RTL_NUMBER_OF_V1(A) (ubound(A) - lbound(A) + 1)
#define RTL_NUMBER_OF_V2(A) RTL_NUMBER_OF_V1(A)
#define RTL_NUMBER_OF(A) RTL_NUMBER_OF_V1(A)
#define ARRAYSIZE(A) RTL_NUMBER_OF_V2(A)
const MINCHAR = &h80
const MAXCHAR = &h7f
const MINSHORT = &h8000
const MAXSHORT = &h7fff
const MINLONG = &h80000000
const MAXLONG = &h7fffffff
const MAXUCHAR = &hff
const MAXUSHORT = &hffff
const MAXULONG = &hffffffff
const MAXLONGLONG = &h7fffffffffffffffll
#define Int32x32To64(a, b) (cast(LONGLONG, (a)) * cast(LONGLONG, (b)))
#define UInt32x32To64(a, b) (cast(ULONGLONG, (a)) * cast(ULONGLONG, (b)))
#define Int64ShllMod32(a, b) (cast(ULONGLONG, (a)) shl (b))
#define Int64ShraMod32(a, b) (cast(LONGLONG, (a)) shr (b))
#define Int64ShrlMod32(a, b) (cast(ULONGLONG, (a)) shr (b))
const VER_WORKSTATION_NT = &h40000000
const VER_SERVER_NT = &h80000000
const VER_SUITE_SMALLBUSINESS = &h00000001
const VER_SUITE_ENTERPRISE = &h00000002
const VER_SUITE_BACKOFFICE = &h00000004
const VER_SUITE_COMMUNICATIONS = &h00000008
const VER_SUITE_TERMINAL = &h00000010
const VER_SUITE_SMALLBUSINESS_RESTRICTED = &h00000020
const VER_SUITE_EMBEDDEDNT = &h00000040
const VER_SUITE_DATACENTER = &h00000080
const VER_SUITE_SINGLEUSERTS = &h00000100
const VER_SUITE_PERSONAL = &h00000200
const VER_SUITE_BLADE = &h00000400
const VER_SUITE_EMBEDDED_RESTRICTED = &h00000800
const VER_SUITE_SECURITY_APPLIANCE = &h00001000
const VER_SUITE_STORAGE_SERVER = &h00002000
const VER_SUITE_COMPUTE_SERVER = &h00004000
const VER_SUITE_WH_SERVER = &h00008000
const LANG_NEUTRAL = &h00
const LANG_INVARIANT = &h7f
const LANG_AFRIKAANS = &h36
const LANG_ALBANIAN = &h1c
const LANG_ALSATIAN = &h84
const LANG_AMHARIC = &h5e
const LANG_ARABIC = &h01
const LANG_ARMENIAN = &h2b
const LANG_ASSAMESE = &h4d
const LANG_AZERI = &h2c
const LANG_BASHKIR = &h6d
const LANG_BASQUE = &h2d
const LANG_BELARUSIAN = &h23
const LANG_BENGALI = &h45
const LANG_BRETON = &h7e
const LANG_BOSNIAN = &h1a
const LANG_BOSNIAN_NEUTRAL = &h781a
const LANG_BULGARIAN = &h02
const LANG_CATALAN = &h03
const LANG_CHINESE = &h04
const LANG_CHINESE_SIMPLIFIED = &h04
const LANG_CHINESE_TRADITIONAL = &h7c04
const LANG_CORSICAN = &h83
const LANG_CROATIAN = &h1a
const LANG_CZECH = &h05
const LANG_DANISH = &h06
const LANG_DARI = &h8c
const LANG_DIVEHI = &h65
const LANG_DUTCH = &h13
const LANG_ENGLISH = &h09
const LANG_ESTONIAN = &h25
const LANG_FAEROESE = &h38
const LANG_FARSI = &h29
const LANG_FILIPINO = &h64
const LANG_FINNISH = &h0b
const LANG_FRENCH = &h0c
const LANG_FRISIAN = &h62
const LANG_GALICIAN = &h56
const LANG_GEORGIAN = &h37
const LANG_GERMAN = &h07
const LANG_GREEK = &h08
const LANG_GREENLANDIC = &h6f
const LANG_GUJARATI = &h47
const LANG_HAUSA = &h68
const LANG_HEBREW = &h0d
const LANG_HINDI = &h39
const LANG_HUNGARIAN = &h0e
const LANG_ICELANDIC = &h0f
const LANG_IGBO = &h70
const LANG_INDONESIAN = &h21
const LANG_INUKTITUT = &h5d
const LANG_IRISH = &h3c
const LANG_ITALIAN = &h10
const LANG_JAPANESE = &h11
const LANG_KANNADA = &h4b
const LANG_KASHMIRI = &h60
const LANG_KAZAK = &h3f
const LANG_KHMER = &h53
const LANG_KICHE = &h86
const LANG_KINYARWANDA = &h87
const LANG_KONKANI = &h57
const LANG_KOREAN = &h12
const LANG_KYRGYZ = &h40
const LANG_LAO = &h54
const LANG_LATVIAN = &h26
const LANG_LITHUANIAN = &h27
const LANG_LOWER_SORBIAN = &h2e
const LANG_LUXEMBOURGISH = &h6e
const LANG_MACEDONIAN = &h2f
const LANG_MALAY = &h3e
const LANG_MALAYALAM = &h4c
const LANG_MALTESE = &h3a
const LANG_MANIPURI = &h58
const LANG_MAORI = &h81
const LANG_MAPUDUNGUN = &h7a
const LANG_MARATHI = &h4e
const LANG_MOHAWK = &h7c
const LANG_MONGOLIAN = &h50
const LANG_NEPALI = &h61
const LANG_NORWEGIAN = &h14
const LANG_OCCITAN = &h82
const LANG_ORIYA = &h48
const LANG_PASHTO = &h63
const LANG_PERSIAN = &h29
const LANG_POLISH = &h15
const LANG_PORTUGUESE = &h16
const LANG_PUNJABI = &h46
const LANG_QUECHUA = &h6b
const LANG_ROMANIAN = &h18
const LANG_ROMANSH = &h17
const LANG_RUSSIAN = &h19
const LANG_SAMI = &h3b
const LANG_SANSKRIT = &h4f
const LANG_SERBIAN = &h1a
const LANG_SERBIAN_NEUTRAL = &h7c1a
const LANG_SINDHI = &h59
const LANG_SINHALESE = &h5b
const LANG_SLOVAK = &h1b
const LANG_SLOVENIAN = &h24
const LANG_SOTHO = &h6c
const LANG_SPANISH = &h0a
const LANG_SWAHILI = &h41
const LANG_SWEDISH = &h1d
const LANG_SYRIAC = &h5a
const LANG_TAJIK = &h28
const LANG_TAMAZIGHT = &h5f
const LANG_TAMIL = &h49
const LANG_TATAR = &h44
const LANG_TELUGU = &h4a
const LANG_THAI = &h1e
const LANG_TIBETAN = &h51
const LANG_TIGRIGNA = &h73
const LANG_TSWANA = &h32
const LANG_TURKISH = &h1f
const LANG_TURKMEN = &h42
const LANG_UIGHUR = &h80
const LANG_UKRAINIAN = &h22
const LANG_UPPER_SORBIAN = &h2e
const LANG_URDU = &h20
const LANG_UZBEK = &h43
const LANG_VIETNAMESE = &h2a
const LANG_WELSH = &h52
const LANG_WOLOF = &h88
const LANG_XHOSA = &h34
const LANG_YAKUT = &h85
const LANG_YI = &h78
const LANG_YORUBA = &h6a
const LANG_ZULU = &h35
const FILE_ATTRIBUTE_VALID_FLAGS = &h00007fb7
#define FILE_SHARE_VALID_FLAGS ((FILE_SHARE_READ or FILE_SHARE_WRITE) or FILE_SHARE_DELETE)
const FILE_SUPERSEDE = &h00000000
const FILE_OPEN = &h00000001
const FILE_CREATE = &h00000002
const FILE_OPEN_IF = &h00000003
const FILE_OVERWRITE = &h00000004
const FILE_OVERWRITE_IF = &h00000005
const FILE_MAXIMUM_DISPOSITION = &h00000005
const FILE_DIRECTORY_FILE = &h00000001
const FILE_WRITE_THROUGH = &h00000002
const FILE_SEQUENTIAL_ONLY = &h00000004
const FILE_NO_INTERMEDIATE_BUFFERING = &h00000008
const FILE_SYNCHRONOUS_IO_ALERT = &h00000010
const FILE_SYNCHRONOUS_IO_NONALERT = &h00000020
const FILE_NON_DIRECTORY_FILE = &h00000040
const FILE_CREATE_TREE_CONNECTION = &h00000080
const FILE_COMPLETE_IF_OPLOCKED = &h00000100
const FILE_NO_EA_KNOWLEDGE = &h00000200
const FILE_OPEN_REMOTE_INSTANCE = &h00000400
const FILE_RANDOM_ACCESS = &h00000800
const FILE_DELETE_ON_CLOSE = &h00001000
const FILE_OPEN_BY_FILE_ID = &h00002000
const FILE_OPEN_FOR_BACKUP_INTENT = &h00004000
const FILE_NO_COMPRESSION = &h00008000

#if _WIN32_WINNT >= &h0601
	const FILE_OPEN_REQUIRING_OPLOCK = &h00010000
	const FILE_DISALLOW_EXCLUSIVE = &h00020000
#endif

const FILE_RESERVE_OPFILTER = &h00100000
const FILE_OPEN_REPARSE_POINT = &h00200000
const FILE_OPEN_NO_RECALL = &h00400000
const FILE_OPEN_FOR_FREE_SPACE_QUERY = &h00800000

type _REPARSE_DATA_BUFFER_SymbolicLinkReparseBuffer
	SubstituteNameOffset as USHORT
	SubstituteNameLength as USHORT
	PrintNameOffset as USHORT
	PrintNameLength as USHORT
	Flags as ULONG
	PathBuffer as wstring * 1
end type

type _REPARSE_DATA_BUFFER_MountPointReparseBuffer
	SubstituteNameOffset as USHORT
	SubstituteNameLength as USHORT
	PrintNameOffset as USHORT
	PrintNameLength as USHORT
	PathBuffer as wstring * 1
end type

type _REPARSE_DATA_BUFFER_GenericReparseBuffer
	DataBuffer(0 to 0) as UCHAR
end type

type _REPARSE_DATA_BUFFER
	ReparseTag as ULONG
	ReparseDataLength as USHORT
	Reserved as USHORT

	union
		SymbolicLinkReparseBuffer as _REPARSE_DATA_BUFFER_SymbolicLinkReparseBuffer
		MountPointReparseBuffer as _REPARSE_DATA_BUFFER_MountPointReparseBuffer
		GenericReparseBuffer as _REPARSE_DATA_BUFFER_GenericReparseBuffer
	end union
end type

type REPARSE_DATA_BUFFER as _REPARSE_DATA_BUFFER
type PREPARSE_DATA_BUFFER as _REPARSE_DATA_BUFFER ptr
#define REPARSE_DATA_BUFFER_HEADER_SIZE FIELD_OFFSET(REPARSE_DATA_BUFFER, GenericReparseBuffer)

end extern
