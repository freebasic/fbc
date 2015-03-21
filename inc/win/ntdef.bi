#pragma once

#include once "_mingw.bi"
#include once "crt/ctype.bi"
#include once "basetsd.bi"
#include once "excpt.bi"
#include once "sdkddkver.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     typedef INT => INT_
''     typedef CSHORT => CSHORT_
''     typedef STRING => STRING_

extern "Windows"

#define _NTDEF_

#ifdef __FB_64BIT__
	#define _AMD64_
#endif

#define NOTHING
#define CRITICAL
#define ANYSIZE_ARRAY 1
#define FALSE 0
#define TRUE 1
#define NULL64 0

#ifdef __FB_64BIT__
	#define ALIGNMENT_MACHINE
	#define MAX_NATURAL_ALIGNMENT sizeof(ULONGLONG)
	#define MEMORY_ALLOCATION_ALIGNMENT 16
#else
	#define MAX_NATURAL_ALIGNMENT sizeof(ULONG)
	#define MEMORY_ALLOCATION_ALIGNMENT 8
#endif

#define ARGUMENT_PRESENT(ArgumentPointer) (cptr(CHAR ptr, cast(ULONG_PTR, (ArgumentPointer))) <> cptr(CHAR ptr, NULL))
#define CONTAINING_RECORD(address, type, field) cptr(type ptr, cast(ULONG_PTR, address) - cast(ULONG_PTR, @cptr(type ptr, 0)->field))
#define SYSTEM_CACHE_ALIGNMENT_SIZE 64
#define min(a, b) iif((a) < (b), (a), (b))
#define max(a, b) iif((a) > (b), (a), (b))
#define BASETYPES

type PVOID as any ptr
type PVOID64 as any ptr
type HANDLE as PVOID
type PHANDLE as HANDLE ptr

#define VOID any

type CHAR as zstring
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
type BOOLEAN as UCHAR
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
type PCHAR as zstring ptr
type LPCH as zstring ptr
type PCH as zstring ptr
type LPCCH as const zstring ptr
type PCCH as const zstring ptr
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

type WCHAR as wstring
type PWCHAR as wstring ptr
type LPWCH as wstring ptr
type PWCH as wstring ptr
type LPCWCH as const wstring ptr
type PCWCH as const wstring ptr
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

#define UNICODE_NULL cast(wchar_t, 0)

type _CSTRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as const zstring ptr
end type

type CSTRING as _CSTRING
type PCSTRING as _CSTRING ptr

#define ANSI_NULL cbyte(0)

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
#define NLS_VALID_LOCALE_MASK &h000fffff
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

#define OBJ_INHERIT &h00000002
#define OBJ_PERMANENT &h00000010
#define OBJ_EXCLUSIVE &h00000020
#define OBJ_CASE_INSENSITIVE &h00000040
#define OBJ_OPENIF &h00000080
#define OBJ_OPENLINK &h00000100
#define OBJ_KERNEL_HANDLE &h00000200
#define OBJ_FORCE_ACCESS_CHECK &h00000400
#define OBJ_VALID_ATTRIBUTES &h000007F2
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
#define RTL_BITS_OF(sizeOfArg) (sizeof((sizeOfArg)) * 8)
#define RTL_BITS_OF_FIELD(type, field) RTL_BITS_OF(RTL_FIELD_TYPE(type, field))
#define RTL_CONSTANT_STRING(s) (sizeof((s)) - sizeof((s)[0]), sizeof((s)), s)
#define RTL_FIELD_SIZE(type, field) sizeof(cptr(type ptr, 0)->field)
#define RTL_SIZEOF_THROUGH_FIELD(type, field) (FIELD_OFFSET(type, field) + RTL_FIELD_SIZE(type, field))
#define RTL_CONTAINS_FIELD(Struct, Size, Field) ((cast(PCHAR, @(Struct)->Field) + sizeof((Struct)->Field)) <= (cast(PCHAR, (Struct)) + (Size)))
#define RTL_NUMBER_OF_V1(A) (sizeof((A)) / sizeof((A)[0]))
#define RTL_NUMBER_OF_V2(A) RTL_NUMBER_OF_V1(A)
#define RTL_NUMBER_OF(A) RTL_NUMBER_OF_V1(A)
#define ARRAYSIZE(A) RTL_NUMBER_OF_V2(A)
#define MINCHAR &h80
#define MAXCHAR &h7f
#define MINSHORT &h8000
#define MAXSHORT &h7fff
#define MINLONG &h80000000
#define MAXLONG &h7fffffff
#define MAXUCHAR &hff
#define MAXUSHORT &hffff
#define MAXULONG &hffffffff
#define MAXLONGLONG &h7fffffffffffffffll
#define Int32x32To64(a, b) (cast(LONGLONG, (a)) * cast(LONGLONG, (b)))
#define UInt32x32To64(a, b) (cast(ULONGLONG, (a)) * cast(ULONGLONG, (b)))
#define Int64ShllMod32(a, b) (cast(ULONGLONG, (a)) shl (b))
#define Int64ShraMod32(a, b) (cast(LONGLONG, (a)) shr (b))
#define Int64ShrlMod32(a, b) (cast(ULONGLONG, (a)) shr (b))
#define VER_WORKSTATION_NT &h40000000
#define VER_SERVER_NT &h80000000
#define VER_SUITE_SMALLBUSINESS &h00000001
#define VER_SUITE_ENTERPRISE &h00000002
#define VER_SUITE_BACKOFFICE &h00000004
#define VER_SUITE_COMMUNICATIONS &h00000008
#define VER_SUITE_TERMINAL &h00000010
#define VER_SUITE_SMALLBUSINESS_RESTRICTED &h00000020
#define VER_SUITE_EMBEDDEDNT &h00000040
#define VER_SUITE_DATACENTER &h00000080
#define VER_SUITE_SINGLEUSERTS &h00000100
#define VER_SUITE_PERSONAL &h00000200
#define VER_SUITE_BLADE &h00000400
#define VER_SUITE_EMBEDDED_RESTRICTED &h00000800
#define VER_SUITE_SECURITY_APPLIANCE &h00001000
#define VER_SUITE_STORAGE_SERVER &h00002000
#define VER_SUITE_COMPUTE_SERVER &h00004000
#define VER_SUITE_WH_SERVER &h00008000
#define LANG_NEUTRAL &h00
#define LANG_INVARIANT &h7f
#define LANG_AFRIKAANS &h36
#define LANG_ALBANIAN &h1c
#define LANG_ALSATIAN &h84
#define LANG_AMHARIC &h5e
#define LANG_ARABIC &h01
#define LANG_ARMENIAN &h2b
#define LANG_ASSAMESE &h4d
#define LANG_AZERI &h2c
#define LANG_BASHKIR &h6d
#define LANG_BASQUE &h2d
#define LANG_BELARUSIAN &h23
#define LANG_BENGALI &h45
#define LANG_BRETON &h7e
#define LANG_BOSNIAN &h1a
#define LANG_BOSNIAN_NEUTRAL &h781a
#define LANG_BULGARIAN &h02
#define LANG_CATALAN &h03
#define LANG_CHINESE &h04
#define LANG_CHINESE_SIMPLIFIED &h04
#define LANG_CHINESE_TRADITIONAL &h7c04
#define LANG_CORSICAN &h83
#define LANG_CROATIAN &h1a
#define LANG_CZECH &h05
#define LANG_DANISH &h06
#define LANG_DARI &h8c
#define LANG_DIVEHI &h65
#define LANG_DUTCH &h13
#define LANG_ENGLISH &h09
#define LANG_ESTONIAN &h25
#define LANG_FAEROESE &h38
#define LANG_FARSI &h29
#define LANG_FILIPINO &h64
#define LANG_FINNISH &h0b
#define LANG_FRENCH &h0c
#define LANG_FRISIAN &h62
#define LANG_GALICIAN &h56
#define LANG_GEORGIAN &h37
#define LANG_GERMAN &h07
#define LANG_GREEK &h08
#define LANG_GREENLANDIC &h6f
#define LANG_GUJARATI &h47
#define LANG_HAUSA &h68
#define LANG_HEBREW &h0d
#define LANG_HINDI &h39
#define LANG_HUNGARIAN &h0e
#define LANG_ICELANDIC &h0f
#define LANG_IGBO &h70
#define LANG_INDONESIAN &h21
#define LANG_INUKTITUT &h5d
#define LANG_IRISH &h3c
#define LANG_ITALIAN &h10
#define LANG_JAPANESE &h11
#define LANG_KANNADA &h4b
#define LANG_KASHMIRI &h60
#define LANG_KAZAK &h3f
#define LANG_KHMER &h53
#define LANG_KICHE &h86
#define LANG_KINYARWANDA &h87
#define LANG_KONKANI &h57
#define LANG_KOREAN &h12
#define LANG_KYRGYZ &h40
#define LANG_LAO &h54
#define LANG_LATVIAN &h26
#define LANG_LITHUANIAN &h27
#define LANG_LOWER_SORBIAN &h2e
#define LANG_LUXEMBOURGISH &h6e
#define LANG_MACEDONIAN &h2f
#define LANG_MALAY &h3e
#define LANG_MALAYALAM &h4c
#define LANG_MALTESE &h3a
#define LANG_MANIPURI &h58
#define LANG_MAORI &h81
#define LANG_MAPUDUNGUN &h7a
#define LANG_MARATHI &h4e
#define LANG_MOHAWK &h7c
#define LANG_MONGOLIAN &h50
#define LANG_NEPALI &h61
#define LANG_NORWEGIAN &h14
#define LANG_OCCITAN &h82
#define LANG_ORIYA &h48
#define LANG_PASHTO &h63
#define LANG_PERSIAN &h29
#define LANG_POLISH &h15
#define LANG_PORTUGUESE &h16
#define LANG_PUNJABI &h46
#define LANG_QUECHUA &h6b
#define LANG_ROMANIAN &h18
#define LANG_ROMANSH &h17
#define LANG_RUSSIAN &h19
#define LANG_SAMI &h3b
#define LANG_SANSKRIT &h4f
#define LANG_SERBIAN &h1a
#define LANG_SERBIAN_NEUTRAL &h7c1a
#define LANG_SINDHI &h59
#define LANG_SINHALESE &h5b
#define LANG_SLOVAK &h1b
#define LANG_SLOVENIAN &h24
#define LANG_SOTHO &h6c
#define LANG_SPANISH &h0a
#define LANG_SWAHILI &h41
#define LANG_SWEDISH &h1d
#define LANG_SYRIAC &h5a
#define LANG_TAJIK &h28
#define LANG_TAMAZIGHT &h5f
#define LANG_TAMIL &h49
#define LANG_TATAR &h44
#define LANG_TELUGU &h4a
#define LANG_THAI &h1e
#define LANG_TIBETAN &h51
#define LANG_TIGRIGNA &h73
#define LANG_TSWANA &h32
#define LANG_TURKISH &h1f
#define LANG_TURKMEN &h42
#define LANG_UIGHUR &h80
#define LANG_UKRAINIAN &h22
#define LANG_UPPER_SORBIAN &h2e
#define LANG_URDU &h20
#define LANG_UZBEK &h43
#define LANG_VIETNAMESE &h2a
#define LANG_WELSH &h52
#define LANG_WOLOF &h88
#define LANG_XHOSA &h34
#define LANG_YAKUT &h85
#define LANG_YI &h78
#define LANG_YORUBA &h6a
#define LANG_ZULU &h35
#define FILE_ATTRIBUTE_VALID_FLAGS &h00007fb7
#define FILE_SHARE_VALID_FLAGS ((FILE_SHARE_READ or FILE_SHARE_WRITE) or FILE_SHARE_DELETE)
#define FILE_SUPERSEDE &h00000000
#define FILE_OPEN &h00000001
#define FILE_CREATE &h00000002
#define FILE_OPEN_IF &h00000003
#define FILE_OVERWRITE &h00000004
#define FILE_OVERWRITE_IF &h00000005
#define FILE_MAXIMUM_DISPOSITION &h00000005
#define FILE_DIRECTORY_FILE &h00000001
#define FILE_WRITE_THROUGH &h00000002
#define FILE_SEQUENTIAL_ONLY &h00000004
#define FILE_NO_INTERMEDIATE_BUFFERING &h00000008
#define FILE_SYNCHRONOUS_IO_ALERT &h00000010
#define FILE_SYNCHRONOUS_IO_NONALERT &h00000020
#define FILE_NON_DIRECTORY_FILE &h00000040
#define FILE_CREATE_TREE_CONNECTION &h00000080
#define FILE_COMPLETE_IF_OPLOCKED &h00000100
#define FILE_NO_EA_KNOWLEDGE &h00000200
#define FILE_OPEN_REMOTE_INSTANCE &h00000400
#define FILE_RANDOM_ACCESS &h00000800
#define FILE_DELETE_ON_CLOSE &h00001000
#define FILE_OPEN_BY_FILE_ID &h00002000
#define FILE_OPEN_FOR_BACKUP_INTENT &h00004000
#define FILE_NO_COMPRESSION &h00008000

#if _WIN32_WINNT = &h0602
	#define FILE_OPEN_REQUIRING_OPLOCK &h00010000
	#define FILE_DISALLOW_EXCLUSIVE &h00020000
#endif

#define FILE_RESERVE_OPFILTER &h00100000
#define FILE_OPEN_REPARSE_POINT &h00200000
#define FILE_OPEN_NO_RECALL &h00400000
#define FILE_OPEN_FOR_FREE_SPACE_QUERY &h00800000

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
