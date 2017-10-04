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

#include once "crt/mem.bi"
#include once "_mingw_unicode.bi"
#include once "_mingw.bi"
#include once "crt/ctype.bi"
#include once "winapifamily.bi"
#include once "apiset.bi"
#include once "intrin.bi"
#include once "basetsd.bi"
#include once "guiddef.bi"
#include once "windef.bi"

'' The following symbols have been renamed:
''     typedef INT => INT_
''     typedef BOOLEAN => WINBOOLEAN
''     constant DELETE => DELETE__

extern "Windows"

#define _WINNT_
const ANYSIZE_ARRAY = 1
#define RESTRICTED_POINTER

#ifdef __FB_64BIT__
	#define ALIGNMENT_MACHINE
	#define MAX_NATURAL_ALIGNMENT sizeof(ULONGLONG)
	const MEMORY_ALLOCATION_ALIGNMENT = 16
#else
	#undef ALIGNMENT_MACHINE
	#define MAX_NATURAL_ALIGNMENT sizeof(DWORD)
	const MEMORY_ALLOCATION_ALIGNMENT = 8
#endif

const SYSTEM_CACHE_ALIGNMENT_SIZE = 64
const PRAGMA_DEPRECATED_DDK = 0
type PVOID as any ptr
type PVOID64 as any ptr
type VOID as any
type CHAR as byte
type INT_ as long
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
type PZZWSTR as wstring ptr
type PCZZWSTR as const wstring ptr
type PUZZWSTR as wstring ptr
type PCUZZWSTR as const wstring ptr
type PNZWCH as WCHAR ptr
type PCNZWCH as const WCHAR ptr
type PUNZWCH as WCHAR ptr
type PCUNZWCH as const WCHAR ptr

#if _WIN32_WINNT >= &h0600
	type LPCWCHAR as const WCHAR ptr
	type PCWCHAR as const WCHAR ptr
	type LPCUWCHAR as const WCHAR ptr
	type PCUWCHAR as const WCHAR ptr
	type UCSCHAR as ulong

	const UCSCHAR_INVALID_CHARACTER = &hffffffff
	const MIN_UCSCHAR = 0
	const MAX_UCSCHAR = &h0010ffff

	type PUCSCHAR as UCSCHAR ptr
	type PCUCSCHAR as const UCSCHAR ptr
	type PUCSSTR as UCSCHAR ptr
	type PUUCSSTR as UCSCHAR ptr
	type PCUCSSTR as const UCSCHAR ptr
	type PCUUCSSTR as const UCSCHAR ptr
	type PUUCSCHAR as UCSCHAR ptr
	type PCUUCSCHAR as const UCSCHAR ptr
#endif

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
type PZZSTR as zstring ptr
type PCZZSTR as const zstring ptr
type PNZCH as CHAR ptr
type PCNZCH as const CHAR ptr
#define _TCHAR_DEFINED

#ifdef UNICODE
	type TCHAR as WCHAR
	type PTCHAR as WCHAR ptr
	type TBYTE as WCHAR
	type PTBYTE as WCHAR ptr
	type LPTCH as LPWSTR
	type PTCH as LPWSTR
	type PTSTR as LPWSTR
	type LPTSTR as LPWSTR
	type PCTSTR as LPCWSTR
	type LPCTSTR as LPCWSTR
	type PUTSTR as LPUWSTR
	type LPUTSTR as LPUWSTR
	type PCUTSTR as LPCUWSTR
	type LPCUTSTR as LPCUWSTR
	type LP as LPWSTR
	type PZZTSTR as PZZWSTR
	type PCZZTSTR as PCZZWSTR
	type PUZZTSTR as PUZZWSTR
	type PCUZZTSTR as PCUZZWSTR
	type PZPTSTR as PZPWSTR
	type PNZTCH as PNZWCH
	type PCNZTCH as PCNZWCH
	type PUNZTCH as PUNZWCH
	type PCUNZTCH as PCUNZWCH
	#define __TEXT(quote) wstr(quote)
#else
	type TCHAR as byte
	type PTCHAR as byte ptr
	type TBYTE as ubyte
	type PTBYTE as ubyte ptr
	type LPTCH as LPSTR
	type PTCH as LPSTR
	type LPCTCH as LPCCH
	type PCTCH as LPCCH
	type PTSTR as LPSTR
	type LPTSTR as LPSTR
	type PUTSTR as LPSTR
	type LPUTSTR as LPSTR
	type PCTSTR as LPCSTR
	type LPCTSTR as LPCSTR
	type PCUTSTR as LPCSTR
	type LPCUTSTR as LPCSTR
	type PZZTSTR as PZZSTR
	type PUZZTSTR as PZZSTR
	type PCZZTSTR as PCZZSTR
	type PCUZZTSTR as PCZZSTR
	type PZPTSTR as PZPSTR
	type PNZTCH as PNZCH
	type PUNZTCH as PNZCH
	type PCNZTCH as PCNZCH
	type PCUNZTCH as PCNZCH
	#define __TEXT(quote) quote
#endif

type PSHORT as SHORT ptr
type PLONG as LONG ptr
#define ___GROUP_AFFINITY_DEFINED

type _GROUP_AFFINITY
	Mask as KAFFINITY
	Group as WORD
	Reserved(0 to 2) as WORD
end type

type GROUP_AFFINITY as _GROUP_AFFINITY
type PGROUP_AFFINITY as _GROUP_AFFINITY ptr
type HANDLE as any ptr
type PHANDLE as HANDLE ptr
type FCHAR as UBYTE
type FSHORT as WORD
type FLONG as DWORD
#define _HRESULT_DEFINED
type HRESULT as LONG
type CCHAR as zstring
#define _LCID_DEFINED
type LCID as DWORD
type PLCID as PDWORD
#define _LANGID_DEFINED
type LANGID as WORD
#define __COMPARTMENT_ID_DEFINED__

type COMPARTMENT_ID as long
enum
	UNSPECIFIED_COMPARTMENT_ID = 0
	DEFAULT_COMPARTMENT_ID
end enum

type PCOMPARTMENT_ID as COMPARTMENT_ID ptr
const APPLICATION_ERROR_MASK = &h20000000
const ERROR_SEVERITY_SUCCESS = &h00000000
const ERROR_SEVERITY_INFORMATIONAL = &h40000000
const ERROR_SEVERITY_WARNING = &h80000000
const ERROR_SEVERITY_ERROR = &hC0000000

type _FLOAT128
	LowPart as longint
	HighPart as longint
end type

type FLOAT128 as _FLOAT128
type PFLOAT128 as FLOAT128 ptr
#define _ULONGLONG_
type LONGLONG as longint
type ULONGLONG as ulongint
const MAXLONGLONG = &h7fffffffffffffffll
type PLONGLONG as LONGLONG ptr
type PULONGLONG as ULONGLONG ptr
type USN as LONGLONG
#define _LARGE_INTEGER_DEFINED

type _LARGE_INTEGER_u
	LowPart as DWORD
	HighPart as LONG
end type

union _LARGE_INTEGER
	type
		LowPart as DWORD
		HighPart as LONG
	end type

	u as _LARGE_INTEGER_u
	QuadPart as LONGLONG
end union

type LARGE_INTEGER as _LARGE_INTEGER
type PLARGE_INTEGER as LARGE_INTEGER ptr

type _ULARGE_INTEGER_u
	LowPart as DWORD
	HighPart as DWORD
end type

union _ULARGE_INTEGER
	type
		LowPart as DWORD
		HighPart as DWORD
	end type

	u as _ULARGE_INTEGER_u
	QuadPart as ULONGLONG
end union

type ULARGE_INTEGER as _ULARGE_INTEGER
type PULARGE_INTEGER as ULARGE_INTEGER ptr

type _LUID
	LowPart as DWORD
	HighPart as LONG
end type

type LUID as _LUID
type PLUID as _LUID ptr
#define _DWORDLONG_
type DWORDLONG as ULONGLONG
type PDWORDLONG as DWORDLONG ptr
#define Int32x32To64(a, b) (cast(LONGLONG, cast(LONG, (a))) * cast(LONGLONG, cast(LONG, (b))))
#define UInt32x32To64(a, b) (cast(ULONGLONG, culng(a)) * cast(ULONGLONG, culng(b)))
#define Int64ShllMod32(a, b) (cast(ULONGLONG, (a)) shl (b))
#define Int64ShraMod32(a, b) (cast(LONGLONG, (a)) shr (b))
#define Int64ShrlMod32(a, b) (cast(ULONGLONG, (a)) shr (b))

#ifdef __FB_64BIT__
	declare function _rotl8(byval Value as ubyte, byval Shift as ubyte) as ubyte
	declare function RotateLeft8 alias "_rotl8"(byval Value as ubyte, byval Shift as ubyte) as ubyte
	declare function _rotl16(byval Value as ushort, byval Shift as ubyte) as ushort
	declare function RotateLeft16 alias "_rotl16"(byval Value as ushort, byval Shift as ubyte) as ushort
	declare function _rotr8(byval Value as ubyte, byval Shift as ubyte) as ubyte
	declare function RotateRight8 alias "_rotr8"(byval Value as ubyte, byval Shift as ubyte) as ubyte
	declare function _rotr16(byval Value as ushort, byval Shift as ubyte) as ushort
	declare function RotateRight16 alias "_rotr16"(byval Value as ushort, byval Shift as ubyte) as ushort
#endif

#define RotateLeft32 _rotl
#define RotateLeft64 _rotl64
#define RotateRight32 _rotr
#define RotateRight64 _rotr64
#undef _rotl
#undef _rotr
declare function _rotl cdecl(byval Value as ulong, byval Shift as long) as ulong
declare function _rotr cdecl(byval Value as ulong, byval Shift as long) as ulong
#undef _rotl64
#undef _rotr64
declare function _rotl64 cdecl(byval Value as ulongint, byval Shift as long) as ulongint
declare function _rotr64 cdecl(byval Value as ulongint, byval Shift as long) as ulongint
const ANSI_NULL = cast(CHAR, 0)
const UNICODE_NULL = cast(WCHAR, 0)
const UNICODE_STRING_MAX_BYTES = cast(WORD, 65534)
const UNICODE_STRING_MAX_CHARS = 32767
#define _BOOLEAN_
type WINBOOLEAN as UBYTE
#ifndef BOOLEAN
	type BOOLEAN as WINBOOLEAN
#endif
type PBOOLEAN as WINBOOLEAN ptr
#define _LIST_ENTRY_DEFINED

type _LIST_ENTRY
	Flink as _LIST_ENTRY ptr
	Blink as _LIST_ENTRY ptr
end type

type LIST_ENTRY as _LIST_ENTRY
type PLIST_ENTRY as _LIST_ENTRY ptr
type PRLIST_ENTRY as _LIST_ENTRY ptr

type _SINGLE_LIST_ENTRY
	Next as _SINGLE_LIST_ENTRY ptr
end type

type SINGLE_LIST_ENTRY as _SINGLE_LIST_ENTRY
type PSINGLE_LIST_ENTRY as _SINGLE_LIST_ENTRY ptr

type LIST_ENTRY32
	Flink as DWORD
	Blink as DWORD
end type

type PLIST_ENTRY32 as LIST_ENTRY32 ptr

type LIST_ENTRY64
	Flink as ULONGLONG
	Blink as ULONGLONG
end type

type PLIST_ENTRY64 as LIST_ENTRY64 ptr
#define __OBJECTID_DEFINED

type _OBJECTID
	Lineage as GUID
	Uniquifier as DWORD
end type

type OBJECTID as _OBJECTID
const MINCHAR = &h80
const MAXCHAR = &h7f
const MINSHORT = &h8000
const MAXSHORT = &h7fff
const MINLONG = &h80000000
const MAXLONG = &h7fffffff
const MAXBYTE = &hff
const MAXWORD = &hffff
const MAXDWORD = &hffffffff
#define FIELD_OFFSET(type, field) cast(LONG, cast(LONG_PTR, @cptr(type ptr, 0)->field))
#define RTL_FIELD_SIZE(type, field) sizeof(cptr(type ptr, 0)->field)
#define RTL_SIZEOF_THROUGH_FIELD(type, field) (FIELD_OFFSET(type, field) + RTL_FIELD_SIZE(type, field))
#define RTL_CONTAINS_FIELD(Struct, Size, Field) ((cast(PCHAR, @(Struct)->Field) + sizeof((Struct)->Field)) <= (cast(PCHAR, (Struct)) + (Size)))
#define RTL_NUMBER_OF_V1(A) (ubound(A) - lbound(A) + 1)
#define RTL_NUMBER_OF_V2(A) RTL_NUMBER_OF_V1(A)
#define RTL_NUMBER_OF(A) RTL_NUMBER_OF_V1(A)
#define ARRAYSIZE(A) RTL_NUMBER_OF_V2(A)
#define _ARRAYSIZE(A) RTL_NUMBER_OF_V1(A)
#define RTL_FIELD_TYPE(type, field) cptr(type ptr, 0)->field
#define RTL_NUMBER_OF_FIELD(type, field) RTL_NUMBER_OF(RTL_FIELD_TYPE(type, field))
#define RTL_PADDING_BETWEEN_FIELDS(T, F1, F2) iif(FIELD_OFFSET(T, F2) > FIELD_OFFSET(T, F1), (FIELD_OFFSET(T, F2) - FIELD_OFFSET(T, F1)) - RTL_FIELD_SIZE(T, F1), (FIELD_OFFSET(T, F1) - FIELD_OFFSET(T, F2)) - RTL_FIELD_SIZE(T, F2))
#define RTL_CONST_CAST(type) (type)
#define DEFINE_ENUM_FLAG_OPERATORS(ENUMTYPE)
#define COMPILETIME_OR_2FLAGS(a, b) (cast(UINT, (a)) or cast(UINT, (b)))
#define COMPILETIME_OR_3FLAGS(a, b, c) ((cast(UINT, (a)) or cast(UINT, (b))) or cast(UINT, (c)))
#define COMPILETIME_OR_4FLAGS(a, b, c, d) (((cast(UINT, (a)) or cast(UINT, (b))) or cast(UINT, (c))) or cast(UINT, (d)))
#define COMPILETIME_OR_5FLAGS(a, b, c, d, e) ((((cast(UINT, (a)) or cast(UINT, (b))) or cast(UINT, (c))) or cast(UINT, (d))) or cast(UINT, (e)))
#define RTL_BITS_OF(sizeOfArg) (sizeof(sizeOfArg) * 8)
#define RTL_BITS_OF_FIELD(type, field) RTL_BITS_OF(RTL_FIELD_TYPE(type, field))
#define CONTAINING_RECORD(address, type, field) cptr(type ptr, cast(PCHAR, (address)) - cast(ULONG_PTR, @cptr(type ptr, 0)->field))
#define __PEXCEPTION_ROUTINE_DEFINED
type _EXCEPTION_RECORD as _EXCEPTION_RECORD_
type _CONTEXT as _CONTEXT_
type PEXCEPTION_ROUTINE as function(byval ExceptionRecord as _EXCEPTION_RECORD ptr, byval EstablisherFrame as PVOID, byval ContextRecord as _CONTEXT ptr, byval DispatcherContext as PVOID) as long
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
const PRODUCT_UNDEFINED = &h0
const PRODUCT_ULTIMATE = &h1
const PRODUCT_HOME_BASIC = &h2
const PRODUCT_HOME_PREMIUM = &h3
const PRODUCT_ENTERPRISE = &h4
const PRODUCT_HOME_BASIC_N = &h5
const PRODUCT_BUSINESS = &h6
const PRODUCT_STANDARD_SERVER = &h7
const PRODUCT_DATACENTER_SERVER = &h8
const PRODUCT_SMALLBUSINESS_SERVER = &h9
const PRODUCT_ENTERPRISE_SERVER = &ha
const PRODUCT_STARTER = &hb
const PRODUCT_DATACENTER_SERVER_CORE = &hc
const PRODUCT_STANDARD_SERVER_CORE = &hd
const PRODUCT_ENTERPRISE_SERVER_CORE = &he
const PRODUCT_ENTERPRISE_SERVER_IA64 = &hf
const PRODUCT_BUSINESS_N = &h10
const PRODUCT_WEB_SERVER = &h11
const PRODUCT_CLUSTER_SERVER = &h12
const PRODUCT_HOME_SERVER = &h13
const PRODUCT_STORAGE_EXPRESS_SERVER = &h14
const PRODUCT_STORAGE_STANDARD_SERVER = &h15
const PRODUCT_STORAGE_WORKGROUP_SERVER = &h16
const PRODUCT_STORAGE_ENTERPRISE_SERVER = &h17
const PRODUCT_SERVER_FOR_SMALLBUSINESS = &h18
const PRODUCT_SMALLBUSINESS_SERVER_PREMIUM = &h19
const PRODUCT_HOME_PREMIUM_N = &h1a
const PRODUCT_ENTERPRISE_N = &h1b
const PRODUCT_ULTIMATE_N = &h1c
const PRODUCT_WEB_SERVER_CORE = &h1d
const PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT = &h1e
const PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY = &h1f
const PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING = &h20
const PRODUCT_SERVER_FOUNDATION = &h21
const PRODUCT_HOME_PREMIUM_SERVER = &h22
const PRODUCT_SERVER_FOR_SMALLBUSINESS_V = &h23
const PRODUCT_STANDARD_SERVER_V = &h24
const PRODUCT_DATACENTER_SERVER_V = &h25
const PRODUCT_ENTERPRISE_SERVER_V = &h26
const PRODUCT_DATACENTER_SERVER_CORE_V = &h27
const PRODUCT_STANDARD_SERVER_CORE_V = &h28
const PRODUCT_ENTERPRISE_SERVER_CORE_V = &h29
const PRODUCT_HYPERV = &h2a
const PRODUCT_STORAGE_EXPRESS_SERVER_CORE = &h2b
const PRODUCT_STORAGE_STANDARD_SERVER_CORE = &h2c
const PRODUCT_STORAGE_WORKGROUP_SERVER_CORE = &h2d
const PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE = &h2e
const PRODUCT_STARTER_N = &h2f
const PRODUCT_PROFESSIONAL = &h30
const PRODUCT_PROFESSIONAL_N = &h31
const PRODUCT_SB_SOLUTION_SERVER = &h32
const PRODUCT_SERVER_FOR_SB_SOLUTIONS = &h33
const PRODUCT_STANDARD_SERVER_SOLUTIONS = &h34
const PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE = &h35
const PRODUCT_SB_SOLUTION_SERVER_EM = &h36
const PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM = &h37
const PRODUCT_SOLUTION_EMBEDDEDSERVER = &h38
const PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE = &h39
const PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT = &h3B
const PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL = &h3C
const PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC = &h3D
const PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC = &h3E
const PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE = &h3f
const PRODUCT_CLUSTER_SERVER_V = &h40
const PRODUCT_EMBEDDED = &h41
const PRODUCT_STARTER_E = &h42
const PRODUCT_HOME_BASIC_E = &h43
const PRODUCT_HOME_PREMIUM_E = &h44
const PRODUCT_PROFESSIONAL_E = &h45
const PRODUCT_ENTERPRISE_E = &h46
const PRODUCT_ULTIMATE_E = &h47
const PRODUCT_ENTERPRISE_EVALUATION = &h48
const PRODUCT_MULTIPOINT_STANDARD_SERVER = &h4C
const PRODUCT_MULTIPOINT_PREMIUM_SERVER = &h4D
const PRODUCT_STANDARD_EVALUATION_SERVER = &h4F
const PRODUCT_DATACENTER_EVALUATION_SERVER = &h50
const PRODUCT_ENTERPRISE_N_EVALUATION = &h54
const PRODUCT_EMBEDDED_AUTOMOTIVE = &h55
const PRODUCT_EMBEDDED_INDUSTRY_A = &h56
const PRODUCT_THINPC = &h57
const PRODUCT_EMBEDDED_A = &h58
const PRODUCT_EMBEDDED_INDUSTRY = &h59
const PRODUCT_EMBEDDED_E = &h5A
const PRODUCT_EMBEDDED_INDUSTRY_E = &h5B
const PRODUCT_EMBEDDED_INDUSTRY_A_E = &h5C
const PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER = &h5F
const PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER = &h60
const PRODUCT_CORE_ARM = &h61
const PRODUCT_CORE_N = &h62
const PRODUCT_CORE_COUNTRYSPECIFIC = &h63
const PRODUCT_CORE_SINGLELANGUAGE = &h64
const PRODUCT_CORE = &h65
const PRODUCT_PROFESSIONAL_WMC = &h67
const PRODUCT_MOBILE_CORE = &h68
const PRODUCT_UNLICENSED = &habcdabcd
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
const LANG_AZERBAIJANI = &h2c
const LANG_BANGLA = &h45
const LANG_BASHKIR = &h6d
const LANG_BASQUE = &h2d
const LANG_BELARUSIAN = &h23
const LANG_BENGALI = &h45
const LANG_BRETON = &h7e
const LANG_BOSNIAN = &h1a
const LANG_BOSNIAN_NEUTRAL = &h781a
const LANG_BULGARIAN = &h02
const LANG_CATALAN = &h03
const LANG_CENTRAL_KURDISH = &h92
const LANG_CHEROKEE = &h5c
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
const LANG_FULAH = &h67
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
const LANG_ODIA = &h48
const LANG_ORIYA = &h48
const LANG_PASHTO = &h63
const LANG_PERSIAN = &h29
const LANG_POLISH = &h15
const LANG_PORTUGUESE = &h16
const LANG_PULAR = &h67
const LANG_PUNJABI = &h46
const LANG_QUECHUA = &h6b
const LANG_ROMANIAN = &h18
const LANG_ROMANSH = &h17
const LANG_RUSSIAN = &h19
const LANG_SAKHA = &h85
const LANG_SAMI = &h3b
const LANG_SANSKRIT = &h4f
const LANG_SCOTTISH_GAELIC = &h91
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
const LANG_TIGRINYA = &h73
const LANG_TSWANA = &h32
const LANG_TURKISH = &h1f
const LANG_TURKMEN = &h42
const LANG_UIGHUR = &h80
const LANG_UKRAINIAN = &h22
const LANG_UPPER_SORBIAN = &h2e
const LANG_URDU = &h20
const LANG_UZBEK = &h43
const LANG_VALENCIAN = &h03
const LANG_VIETNAMESE = &h2a
const LANG_WELSH = &h52
const LANG_WOLOF = &h88
const LANG_XHOSA = &h34
const LANG_YAKUT = &h85
const LANG_YI = &h78
const LANG_YORUBA = &h6a
const LANG_ZULU = &h35
const SUBLANG_NEUTRAL = &h00
const SUBLANG_DEFAULT = &h01
const SUBLANG_SYS_DEFAULT = &h02
const SUBLANG_CUSTOM_DEFAULT = &h03
const SUBLANG_CUSTOM_UNSPECIFIED = &h04
const SUBLANG_UI_CUSTOM_DEFAULT = &h05
const SUBLANG_AFRIKAANS_SOUTH_AFRICA = &h01
const SUBLANG_ALBANIAN_ALBANIA = &h01
const SUBLANG_ALSATIAN_FRANCE = &h01
const SUBLANG_AMHARIC_ETHIOPIA = &h01
const SUBLANG_ARABIC_SAUDI_ARABIA = &h01
const SUBLANG_ARABIC_IRAQ = &h02
const SUBLANG_ARABIC_EGYPT = &h03
const SUBLANG_ARABIC_LIBYA = &h04
const SUBLANG_ARABIC_ALGERIA = &h05
const SUBLANG_ARABIC_MOROCCO = &h06
const SUBLANG_ARABIC_TUNISIA = &h07
const SUBLANG_ARABIC_OMAN = &h08
const SUBLANG_ARABIC_YEMEN = &h09
const SUBLANG_ARABIC_SYRIA = &h0a
const SUBLANG_ARABIC_JORDAN = &h0b
const SUBLANG_ARABIC_LEBANON = &h0c
const SUBLANG_ARABIC_KUWAIT = &h0d
const SUBLANG_ARABIC_UAE = &h0e
const SUBLANG_ARABIC_BAHRAIN = &h0f
const SUBLANG_ARABIC_QATAR = &h10
const SUBLANG_ARMENIAN_ARMENIA = &h01
const SUBLANG_ASSAMESE_INDIA = &h01
const SUBLANG_AZERI_LATIN = &h01
const SUBLANG_AZERI_CYRILLIC = &h02
const SUBLANG_AZERBAIJANI_AZERBAIJAN_LATIN = &h01
const SUBLANG_AZERBAIJANI_AZERBAIJAN_CYRILLIC = &h02
const SUBLANG_BANGLA_INDIA = &h01
const SUBLANG_BANGLA_BANGLADESH = &h02
const SUBLANG_BASHKIR_RUSSIA = &h01
const SUBLANG_BASQUE_BASQUE = &h01
const SUBLANG_BELARUSIAN_BELARUS = &h01
const SUBLANG_BENGALI_INDIA = &h01
const SUBLANG_BENGALI_BANGLADESH = &h02
const SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_LATIN = &h05
const SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_CYRILLIC = &h08
const SUBLANG_BRETON_FRANCE = &h01
const SUBLANG_BULGARIAN_BULGARIA = &h01
const SUBLANG_CATALAN_CATALAN = &h01
const SUBLANG_CENTRAL_KURDISH_IRAQ = &h01
const SUBLANG_CHEROKEE_CHEROKEE = &h01
const SUBLANG_CHINESE_TRADITIONAL = &h01
const SUBLANG_CHINESE_SIMPLIFIED = &h02
const SUBLANG_CHINESE_HONGKONG = &h03
const SUBLANG_CHINESE_SINGAPORE = &h04
const SUBLANG_CHINESE_MACAU = &h05
const SUBLANG_CORSICAN_FRANCE = &h01
const SUBLANG_CZECH_CZECH_REPUBLIC = &h01
const SUBLANG_CROATIAN_CROATIA = &h01
const SUBLANG_CROATIAN_BOSNIA_HERZEGOVINA_LATIN = &h04
const SUBLANG_DANISH_DENMARK = &h01
const SUBLANG_DARI_AFGHANISTAN = &h01
const SUBLANG_DIVEHI_MALDIVES = &h01
const SUBLANG_DUTCH = &h01
const SUBLANG_DUTCH_BELGIAN = &h02
const SUBLANG_ENGLISH_US = &h01
const SUBLANG_ENGLISH_UK = &h02
const SUBLANG_ENGLISH_AUS = &h03
const SUBLANG_ENGLISH_CAN = &h04
const SUBLANG_ENGLISH_NZ = &h05
const SUBLANG_ENGLISH_IRELAND = &h06
const SUBLANG_ENGLISH_EIRE = &h06
const SUBLANG_ENGLISH_SOUTH_AFRICA = &h07
const SUBLANG_ENGLISH_JAMAICA = &h08
const SUBLANG_ENGLISH_CARIBBEAN = &h09
const SUBLANG_ENGLISH_BELIZE = &h0a
const SUBLANG_ENGLISH_TRINIDAD = &h0b
const SUBLANG_ENGLISH_ZIMBABWE = &h0c
const SUBLANG_ENGLISH_PHILIPPINES = &h0d
const SUBLANG_ENGLISH_INDIA = &h10
const SUBLANG_ENGLISH_MALAYSIA = &h11
const SUBLANG_ENGLISH_SINGAPORE = &h12
const SUBLANG_ESTONIAN_ESTONIA = &h01
const SUBLANG_FAEROESE_FAROE_ISLANDS = &h01
const SUBLANG_FILIPINO_PHILIPPINES = &h01
const SUBLANG_FINNISH_FINLAND = &h01
const SUBLANG_FRENCH = &h01
const SUBLANG_FRENCH_BELGIAN = &h02
const SUBLANG_FRENCH_CANADIAN = &h03
const SUBLANG_FRENCH_SWISS = &h04
const SUBLANG_FRENCH_LUXEMBOURG = &h05
const SUBLANG_FRENCH_MONACO = &h06
const SUBLANG_FRISIAN_NETHERLANDS = &h01
const SUBLANG_FULAH_SENEGAL = &h02
const SUBLANG_GALICIAN_GALICIAN = &h01
const SUBLANG_GEORGIAN_GEORGIA = &h01
const SUBLANG_GERMAN = &h01
const SUBLANG_GERMAN_SWISS = &h02
const SUBLANG_GERMAN_AUSTRIAN = &h03
const SUBLANG_GERMAN_LUXEMBOURG = &h04
const SUBLANG_GERMAN_LIECHTENSTEIN = &h05
const SUBLANG_GREEK_GREECE = &h01
const SUBLANG_GREENLANDIC_GREENLAND = &h01
const SUBLANG_GUJARATI_INDIA = &h01
const SUBLANG_HAUSA_NIGERIA_LATIN = &h01
const SUBLANG_HAUSA_NIGERIA = SUBLANG_HAUSA_NIGERIA_LATIN
const SUBLANG_HAWAIIAN_US = &h01
const SUBLANG_HEBREW_ISRAEL = &h01
const SUBLANG_HINDI_INDIA = &h01
const SUBLANG_HUNGARIAN_HUNGARY = &h01
const SUBLANG_ICELANDIC_ICELAND = &h01
const SUBLANG_IGBO_NIGERIA = &h01
const SUBLANG_INDONESIAN_INDONESIA = &h01
const SUBLANG_INUKTITUT_CANADA = &h01
const SUBLANG_INUKTITUT_CANADA_LATIN = &h02
const SUBLANG_IRISH_IRELAND = &h02
const SUBLANG_ITALIAN = &h01
const SUBLANG_ITALIAN_SWISS = &h02
const SUBLANG_JAPANESE_JAPAN = &h01
const SUBLANG_KANNADA_INDIA = &h01
const SUBLANG_KASHMIRI_INDIA = &h02
const SUBLANG_KASHMIRI_SASIA = &h02
const SUBLANG_KAZAK_KAZAKHSTAN = &h01
const SUBLANG_KHMER_CAMBODIA = &h01
const SUBLANG_KICHE_GUATEMALA = &h01
const SUBLANG_KINYARWANDA_RWANDA = &h01
const SUBLANG_KONKANI_INDIA = &h01
const SUBLANG_KOREAN = &h01
const SUBLANG_KYRGYZ_KYRGYZSTAN = &h01
const SUBLANG_LAO_LAO = &h01
const SUBLANG_LAO_LAO_PDR = SUBLANG_LAO_LAO
const SUBLANG_LATVIAN_LATVIA = &h01

#if _WIN32_WINNT >= &h0600
	const SUBLANG_LITHUANIAN_LITHUANIA = &h01
#endif

const SUBLANG_LITHUANIAN = &h01
const SUBLANG_LOWER_SORBIAN_GERMANY = &h02
const SUBLANG_LUXEMBOURGISH_LUXEMBOURG = &h01
const SUBLANG_MACEDONIAN_MACEDONIA = &h01
const SUBLANG_MALAY_MALAYSIA = &h01
const SUBLANG_MALAY_BRUNEI_DARUSSALAM = &h02
const SUBLANG_MALAYALAM_INDIA = &h01
const SUBLANG_MALTESE_MALTA = &h01
const SUBLANG_MAORI_NEW_ZEALAND = &h01
const SUBLANG_MAPUDUNGUN_CHILE = &h01
const SUBLANG_MARATHI_INDIA = &h01
const SUBLANG_MOHAWK_MOHAWK = &h01
const SUBLANG_MONGOLIAN_CYRILLIC_MONGOLIA = &h01
const SUBLANG_MONGOLIAN_PRC = &h02
const SUBLANG_NEPALI_NEPAL = &h01
const SUBLANG_NEPALI_INDIA = &h02
const SUBLANG_NORWEGIAN_BOKMAL = &h01
const SUBLANG_NORWEGIAN_NYNORSK = &h02
const SUBLANG_OCCITAN_FRANCE = &h01
const SUBLANG_ORIYA_INDIA = &h01
const SUBLANG_PASHTO_AFGHANISTAN = &h01
const SUBLANG_PERSIAN_IRAN = &h01
const SUBLANG_POLISH_POLAND = &h01
const SUBLANG_PORTUGUESE_BRAZILIAN = &h01

#if _WIN32_WINNT >= &h0600
	const SUBLANG_PORTUGUESE_PORTUGAL = &h02
#endif

const SUBLANG_PORTUGUESE = &h02
const SUBLANG_PULAR_SENEGAL = &h02
const SUBLANG_PUNJABI_INDIA = &h01
const SUBLANG_PUNJABI_PAKISTAN = &h02
const SUBLANG_QUECHUA_BOLIVIA = &h01
const SUBLANG_QUECHUA_ECUADOR = &h02
const SUBLANG_QUECHUA_PERU = &h03
const SUBLANG_ROMANIAN_ROMANIA = &h01
const SUBLANG_ROMANSH_SWITZERLAND = &h01
const SUBLANG_RUSSIAN_RUSSIA = &h01
const SUBLANG_SAKHA_RUSSIA = &h01
const SUBLANG_SAMI_NORTHERN_NORWAY = &h01
const SUBLANG_SAMI_NORTHERN_SWEDEN = &h02
const SUBLANG_SAMI_NORTHERN_FINLAND = &h03
const SUBLANG_SAMI_LULE_NORWAY = &h04
const SUBLANG_SAMI_LULE_SWEDEN = &h05
const SUBLANG_SAMI_SOUTHERN_NORWAY = &h06
const SUBLANG_SAMI_SOUTHERN_SWEDEN = &h07
const SUBLANG_SAMI_SKOLT_FINLAND = &h08
const SUBLANG_SAMI_INARI_FINLAND = &h09
const SUBLANG_SANSKRIT_INDIA = &h01
const SUBLANG_SCOTTISH_GAELIC = &h01
const SUBLANG_SERBIAN_LATIN = &h02
const SUBLANG_SERBIAN_CYRILLIC = &h03
const SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_LATIN = &h06
const SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_CYRILLIC = &h07
const SUBLANG_SERBIAN_MONTENEGRO_LATIN = &h0b
const SUBLANG_SERBIAN_MONTENEGRO_CYRILLIC = &h0c
const SUBLANG_SERBIAN_SERBIA_LATIN = &h09
const SUBLANG_SERBIAN_SERBIA_CYRILLIC = &h0a
const SUBLANG_SINDHI_INDIA = &h01
const SUBLANG_SINDHI_AFGHANISTAN = &h02
const SUBLANG_SINDHI_PAKISTAN = &h02
const SUBLANG_SINHALESE_SRI_LANKA = &h01
const SUBLANG_SOTHO_NORTHERN_SOUTH_AFRICA = &h01
const SUBLANG_SLOVAK_SLOVAKIA = &h01
const SUBLANG_SLOVENIAN_SLOVENIA = &h01
const SUBLANG_SPANISH = &h01
const SUBLANG_SPANISH_MEXICAN = &h02
const SUBLANG_SPANISH_MODERN = &h03
const SUBLANG_SPANISH_GUATEMALA = &h04
const SUBLANG_SPANISH_COSTA_RICA = &h05
const SUBLANG_SPANISH_PANAMA = &h06
const SUBLANG_SPANISH_DOMINICAN_REPUBLIC = &h07
const SUBLANG_SPANISH_VENEZUELA = &h08
const SUBLANG_SPANISH_COLOMBIA = &h09
const SUBLANG_SPANISH_PERU = &h0a
const SUBLANG_SPANISH_ARGENTINA = &h0b
const SUBLANG_SPANISH_ECUADOR = &h0c
const SUBLANG_SPANISH_CHILE = &h0d
const SUBLANG_SPANISH_URUGUAY = &h0e
const SUBLANG_SPANISH_PARAGUAY = &h0f
const SUBLANG_SPANISH_BOLIVIA = &h10
const SUBLANG_SPANISH_EL_SALVADOR = &h11
const SUBLANG_SPANISH_HONDURAS = &h12
const SUBLANG_SPANISH_NICARAGUA = &h13
const SUBLANG_SPANISH_PUERTO_RICO = &h14
const SUBLANG_SPANISH_US = &h15
const SUBLANG_SWAHILI_KENYA = &h01

#if _WIN32_WINNT >= &h0600
	const SUBLANG_SWEDISH_SWEDEN = &h01
#endif

const SUBLANG_SWEDISH = &h01
const SUBLANG_SWEDISH_FINLAND = &h02
const SUBLANG_SYRIAC = &h01
const SUBLANG_SYRIAC_SYRIA = SUBLANG_SYRIAC
const SUBLANG_TAJIK_TAJIKISTAN = &h01
const SUBLANG_TAMAZIGHT_ALGERIA_LATIN = &h02
const SUBLANG_TAMAZIGHT_MOROCCO_TIFINAGH = &h04
const SUBLANG_TAMIL_INDIA = &h01
const SUBLANG_TAMIL_SRI_LANKA = &h02
const SUBLANG_TATAR_RUSSIA = &h01
const SUBLANG_TELUGU_INDIA = &h01
const SUBLANG_THAI_THAILAND = &h01
const SUBLANG_TIBETAN_PRC = &h01
const SUBLANG_TIBETAN_BHUTAN = &h02
const SUBLANG_TIGRIGNA_ERITREA = &h02
const SUBLANG_TIGRINYA_ERITREA = &h02
const SUBLANG_TIGRINYA_ETHIOPIA = &h01
const SUBLANG_TSWANA_BOTSWANA = &h02
const SUBLANG_TSWANA_SOUTH_AFRICA = &h01
const SUBLANG_TURKISH_TURKEY = &h01
const SUBLANG_TURKMEN_TURKMENISTAN = &h01
const SUBLANG_UIGHUR_PRC = &h01
const SUBLANG_UKRAINIAN_UKRAINE = &h01
const SUBLANG_UPPER_SORBIAN_GERMANY = &h01
const SUBLANG_URDU_PAKISTAN = &h01
const SUBLANG_URDU_INDIA = &h02
const SUBLANG_UZBEK_LATIN = &h01
const SUBLANG_UZBEK_CYRILLIC = &h02
const SUBLANG_VALENCIAN_VALENCIA = &h02
const SUBLANG_VIETNAMESE_VIETNAM = &h01
const SUBLANG_WELSH_UNITED_KINGDOM = &h01
const SUBLANG_WOLOF_SENEGAL = &h01
const SUBLANG_YORUBA_NIGERIA = &h01
const SUBLANG_XHOSA_SOUTH_AFRICA = &h01
const SUBLANG_YAKUT_RUSSIA = &h01
const SUBLANG_YI_PRC = &h01
const SUBLANG_ZULU_SOUTH_AFRICA = &h01
const SORT_DEFAULT = &h0
const SORT_INVARIANT_MATH = &h1
const SORT_JAPANESE_XJIS = &h0
const SORT_JAPANESE_UNICODE = &h1
const SORT_JAPANESE_RADICALSTROKE = &h4
const SORT_CHINESE_BIG5 = &h0
const SORT_CHINESE_PRCP = &h0
const SORT_CHINESE_UNICODE = &h1
const SORT_CHINESE_PRC = &h2
const SORT_CHINESE_BOPOMOFO = &h3
const SORT_CHINESE_RADICALSTROKE = &h4
const SORT_KOREAN_KSC = &h0
const SORT_KOREAN_UNICODE = &h1
const SORT_GERMAN_PHONE_BOOK = &h1
const SORT_HUNGARIAN_DEFAULT = &h0
const SORT_HUNGARIAN_TECHNICAL = &h1
const SORT_GEORGIAN_TRADITIONAL = &h0
const SORT_GEORGIAN_MODERN = &h1
#define MAKELANGID(p, s) ((cast(WORD, (s)) shl 10) or cast(WORD, (p)))
#define PRIMARYLANGID(lgid) (cast(WORD, (lgid)) and &h3ff)
#define SUBLANGID(lgid) (cast(WORD, (lgid)) shr 10)
const NLS_VALID_LOCALE_MASK = &h000fffff
#define MAKELCID(lgid, srtid) cast(DWORD, (cast(DWORD, cast(WORD, (srtid))) shl 16) or cast(DWORD, cast(WORD, (lgid))))
#define MAKESORTLCID(lgid, srtid, ver) cast(DWORD, MAKELCID(lgid, srtid) or (cast(DWORD, cast(WORD, (ver))) shl 20))
#define LANGIDFROMLCID(lcid) cast(WORD, (lcid))
#define SORTIDFROMLCID(lcid) cast(WORD, (cast(DWORD, (lcid)) shr 16) and &hf)
#define SORTVERSIONFROMLCID(lcid) cast(WORD, (cast(DWORD, (lcid)) shr 20) and &hf)
const LOCALE_NAME_MAX_LENGTH = 85
#define LANG_SYSTEM_DEFAULT MAKELANGID(LANG_NEUTRAL, SUBLANG_SYS_DEFAULT)
#define LANG_USER_DEFAULT MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT)
#define LOCALE_SYSTEM_DEFAULT MAKELCID(LANG_SYSTEM_DEFAULT, SORT_DEFAULT)
#define LOCALE_USER_DEFAULT MAKELCID(LANG_USER_DEFAULT, SORT_DEFAULT)
#define LOCALE_NEUTRAL MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL), SORT_DEFAULT)
#define LOCALE_CUSTOM_DEFAULT MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_CUSTOM_DEFAULT), SORT_DEFAULT)
#define LOCALE_CUSTOM_UNSPECIFIED MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_CUSTOM_UNSPECIFIED), SORT_DEFAULT)
#define LOCALE_CUSTOM_UI_DEFAULT MAKELCID(MAKELANGID(LANG_NEUTRAL, SUBLANG_UI_CUSTOM_DEFAULT), SORT_DEFAULT)
#define LOCALE_INVARIANT MAKELCID(MAKELANGID(LANG_INVARIANT, SUBLANG_NEUTRAL), SORT_DEFAULT)
#define DEFAULT_UNREACHABLE
const STATUS_WAIT_0 = cast(DWORD, &h00000000)
const STATUS_ABANDONED_WAIT_0 = cast(DWORD, &h00000080)
const STATUS_USER_APC = cast(DWORD, &h000000C0)
const STATUS_TIMEOUT = cast(DWORD, &h00000102)
const STATUS_PENDING = cast(DWORD, &h00000103)
const DBG_EXCEPTION_HANDLED = cast(DWORD, &h00010001)
const DBG_CONTINUE = cast(DWORD, &h00010002)
const STATUS_SEGMENT_NOTIFICATION = cast(DWORD, &h40000005)
const STATUS_FATAL_APP_EXIT = cast(DWORD, &h40000015)
const DBG_TERMINATE_THREAD = cast(DWORD, &h40010003)
const DBG_TERMINATE_PROCESS = cast(DWORD, &h40010004)
const DBG_CONTROL_C = cast(DWORD, &h40010005)
const DBG_PRINTEXCEPTION_C = cast(DWORD, &h40010006)
const DBG_RIPEXCEPTION = cast(DWORD, &h40010007)
const DBG_CONTROL_BREAK = cast(DWORD, &h40010008)
const DBG_COMMAND_EXCEPTION = cast(DWORD, &h40010009)
const STATUS_GUARD_PAGE_VIOLATION = cast(DWORD, &h80000001)
const STATUS_DATATYPE_MISALIGNMENT = cast(DWORD, &h80000002)
const STATUS_BREAKPOINT = cast(DWORD, &h80000003)
const STATUS_SINGLE_STEP = cast(DWORD, &h80000004)
const STATUS_LONGJUMP = cast(DWORD, &h80000026)
const STATUS_UNWIND_CONSOLIDATE = cast(DWORD, &h80000029)
const DBG_EXCEPTION_NOT_HANDLED = cast(DWORD, &h80010001)
const STATUS_ACCESS_VIOLATION = cast(DWORD, &hC0000005)
const STATUS_IN_PAGE_ERROR = cast(DWORD, &hC0000006)
const STATUS_INVALID_HANDLE = cast(DWORD, &hC0000008)
const STATUS_INVALID_PARAMETER = cast(DWORD, &hC000000D)
const STATUS_NO_MEMORY = cast(DWORD, &hC0000017)
const STATUS_ILLEGAL_INSTRUCTION = cast(DWORD, &hC000001D)
const STATUS_NONCONTINUABLE_EXCEPTION = cast(DWORD, &hC0000025)
const STATUS_INVALID_DISPOSITION = cast(DWORD, &hC0000026)
const STATUS_ARRAY_BOUNDS_EXCEEDED = cast(DWORD, &hC000008C)
const STATUS_FLOAT_DENORMAL_OPERAND = cast(DWORD, &hC000008D)
const STATUS_FLOAT_DIVIDE_BY_ZERO = cast(DWORD, &hC000008E)
const STATUS_FLOAT_INEXACT_RESULT = cast(DWORD, &hC000008F)
const STATUS_FLOAT_INVALID_OPERATION = cast(DWORD, &hC0000090)
const STATUS_FLOAT_OVERFLOW = cast(DWORD, &hC0000091)
const STATUS_FLOAT_STACK_CHECK = cast(DWORD, &hC0000092)
const STATUS_FLOAT_UNDERFLOW = cast(DWORD, &hC0000093)
const STATUS_INTEGER_DIVIDE_BY_ZERO = cast(DWORD, &hC0000094)
const STATUS_INTEGER_OVERFLOW = cast(DWORD, &hC0000095)
const STATUS_PRIVILEGED_INSTRUCTION = cast(DWORD, &hC0000096)
const STATUS_STACK_OVERFLOW = cast(DWORD, &hC00000FD)
const STATUS_DLL_NOT_FOUND = cast(DWORD, &hC0000135)
const STATUS_ORDINAL_NOT_FOUND = cast(DWORD, &hC0000138)
const STATUS_ENTRYPOINT_NOT_FOUND = cast(DWORD, &hC0000139)
const STATUS_CONTROL_C_EXIT = cast(DWORD, &hC000013A)
const STATUS_DLL_INIT_FAILED = cast(DWORD, &hC0000142)
const STATUS_FLOAT_MULTIPLE_FAULTS = cast(DWORD, &hC00002B4)
const STATUS_FLOAT_MULTIPLE_TRAPS = cast(DWORD, &hC00002B5)
const STATUS_REG_NAT_CONSUMPTION = cast(DWORD, &hC00002C9)
const STATUS_STACK_BUFFER_OVERRUN = cast(DWORD, &hC0000409)
const STATUS_INVALID_CRUNTIME_PARAMETER = cast(DWORD, &hC0000417)
const STATUS_ASSERTION_FAILURE = cast(DWORD, &hC0000420)
const STATUS_SXS_EARLY_DEACTIVATION = cast(DWORD, &hC015000F)
const STATUS_SXS_INVALID_DEACTIVATION = cast(DWORD, &hC0150010)
const MAXIMUM_WAIT_OBJECTS = 64
const MAXIMUM_SUSPEND_COUNT = MAXCHAR
type KSPIN_LOCK as ULONG_PTR
type PKSPIN_LOCK as KSPIN_LOCK ptr

type _M128A
	Low as ULONGLONG
	High as LONGLONG
end type

type M128A as _M128A
type PM128A as _M128A ptr

type _XSAVE_FORMAT
	ControlWord as WORD
	StatusWord as WORD
	TagWord as UBYTE
	Reserved1 as UBYTE
	ErrorOpcode as WORD
	ErrorOffset as DWORD
	ErrorSelector as WORD
	Reserved2 as WORD
	DataOffset as DWORD
	DataSelector as WORD
	Reserved3 as WORD
	MxCsr as DWORD
	MxCsr_Mask as DWORD
	FloatRegisters(0 to 7) as M128A

	#ifdef __FB_64BIT__
		XmmRegisters(0 to 15) as M128A
		Reserved4(0 to 95) as UBYTE
	#else
		XmmRegisters(0 to 7) as M128A
		Reserved4(0 to 219) as UBYTE
		Cr0NpxState as DWORD
	#endif
end type

type XSAVE_FORMAT as _XSAVE_FORMAT
type PXSAVE_FORMAT as _XSAVE_FORMAT ptr

type _XSAVE_AREA_HEADER
	Mask as DWORD64
	Reserved(0 to 6) as DWORD64
end type

type XSAVE_AREA_HEADER as _XSAVE_AREA_HEADER
type PXSAVE_AREA_HEADER as _XSAVE_AREA_HEADER ptr

type _XSAVE_AREA
	LegacyState as XSAVE_FORMAT
	Header as XSAVE_AREA_HEADER
end type

type XSAVE_AREA as _XSAVE_AREA
type PXSAVE_AREA as _XSAVE_AREA ptr

type _XSTATE_CONTEXT
	Mask as DWORD64
	Length as DWORD
	Reserved1 as DWORD
	Area as PXSAVE_AREA

	#ifndef __FB_64BIT__
		Reserved2 as DWORD
	#endif

	Buffer as PVOID

	#ifndef __FB_64BIT__
		Reserved3 as DWORD
	#endif
end type

type XSTATE_CONTEXT as _XSTATE_CONTEXT
type PXSTATE_CONTEXT as _XSTATE_CONTEXT ptr

type _SCOPE_TABLE_AMD64_ScopeRecord
	BeginAddress as DWORD
	EndAddress as DWORD
	HandlerAddress as DWORD
	JumpTarget as DWORD
end type

type _SCOPE_TABLE_AMD64
	Count as DWORD
	ScopeRecord(0 to 0) as _SCOPE_TABLE_AMD64_ScopeRecord
end type

type SCOPE_TABLE_AMD64 as _SCOPE_TABLE_AMD64
type PSCOPE_TABLE_AMD64 as _SCOPE_TABLE_AMD64 ptr
#define BitTest _bittest
#define BitTestAndComplement _bittestandcomplement
#define BitTestAndSet _bittestandset
#define BitTestAndReset _bittestandreset

#ifdef __FB_64BIT__
	#define BitTest64 _bittest64
	#define BitTestAndComplement64 _bittestandcomplement64
	#define BitTestAndSet64 _bittestandset64
	#define BitTestAndReset64 _bittestandreset64
#endif

#define BitScanForward _BitScanForward
#define BitScanReverse _BitScanReverse

#ifdef __FB_64BIT__
	#define BitScanForward64 _BitScanForward64
	#define BitScanReverse64 _BitScanReverse64
	#define InterlockedIncrement16 _InterlockedIncrement16
	#define InterlockedDecrement16 _InterlockedDecrement16
#endif

#define InterlockedCompareExchange16 _InterlockedCompareExchange16

type _TEB as _TEB_

#ifdef __FB_64BIT__
	#define InterlockedAnd _InterlockedAnd
	#define InterlockedOr _InterlockedOr
	#define InterlockedXor _InterlockedXor
	#define InterlockedIncrement _InterlockedIncrement
	#define InterlockedIncrementAcquire InterlockedIncrement
	#define InterlockedIncrementRelease InterlockedIncrement
	#define InterlockedDecrement _InterlockedDecrement
	#define InterlockedDecrementAcquire InterlockedDecrement
	#define InterlockedDecrementRelease InterlockedDecrement
	#define InterlockedAdd _InterlockedAdd
	#define InterlockedExchange _InterlockedExchange
	#define InterlockedExchangeAdd _InterlockedExchangeAdd
	#define InterlockedCompareExchange _InterlockedCompareExchange
	#define InterlockedCompareExchangeAcquire InterlockedCompareExchange
	#define InterlockedCompareExchangeRelease InterlockedCompareExchange
	#define InterlockedAnd64 _InterlockedAnd64
	#define InterlockedAndAffinity InterlockedAnd64
	#define InterlockedOr64 _InterlockedOr64
	#define InterlockedOrAffinity InterlockedOr64
	#define InterlockedXor64 _InterlockedXor64
	#define InterlockedIncrement64 _InterlockedIncrement64
	#define InterlockedDecrement64 _InterlockedDecrement64
	#define InterlockedAdd64 _InterlockedAdd64
	#define InterlockedExchange64 _InterlockedExchange64
	#define InterlockedExchangeAcquire64 InterlockedExchange64
	#define InterlockedExchangeAdd64 _InterlockedExchangeAdd64
	#define InterlockedCompareExchange64 _InterlockedCompareExchange64
	#define InterlockedCompareExchangeAcquire64 InterlockedCompareExchange64
	#define InterlockedCompareExchangeRelease64 InterlockedCompareExchange64
	#define InterlockedExchangePointer _InterlockedExchangePointer
	#define InterlockedCompareExchangePointer _InterlockedCompareExchangePointer
	#define InterlockedCompareExchangePointerAcquire _InterlockedCompareExchangePointer
	#define InterlockedCompareExchangePointerRelease _InterlockedCompareExchangePointer
	#define InterlockedExchangeAddSizeT(a, b) InterlockedExchangeAdd64(cptr(LONG64 ptr, a), b)
	#define InterlockedIncrementSizeT(a) InterlockedIncrement64(cptr(LONG64 ptr, a))
	#define InterlockedDecrementSizeT(a) InterlockedDecrement64(cptr(LONG64 ptr, a))
	declare function _InterlockedAdd(byval Addend as LONG ptr, byval Value as LONG) as LONG
	private function _InterlockedAdd(byval Addend as LONG ptr, byval Value as LONG) as LONG
		return _InterlockedExchangeAdd(Addend, Value) + Value
	end function
	declare function _InterlockedAdd64(byval Addend as LONG64 ptr, byval Value as LONG64) as LONG64
	private function _InterlockedAdd64(byval Addend as LONG64 ptr, byval Value as LONG64) as LONG64
		return _InterlockedExchangeAdd64(Addend, Value) + Value
	end function
#else
	const PcTeb = &h18
	#define NtCurrentTeb() cptr(_TEB ptr, __readfsdword(&h18))
	#define GetCurrentFiber() cast(PVOID, __readfsdword(&h10))
	#define GetFiberData() cast(PVOID, *cptr(PVOID ptr, GetCurrentFiber()))
#endif

#ifdef __FB_64BIT__
	#define GetCallersEflags() __getcallerseflags()
	declare function __getcallerseflags() as ulong
	declare function __segmentlimit(byval Selector as DWORD) as DWORD
	declare function GetSegmentLimit alias "__segmentlimit"(byval Selector as DWORD) as DWORD
	#define ReadTimeStampCounter() __rdtsc()
	declare function __mulh(byval Multiplier as LONGLONG, byval Multiplicand as LONGLONG) as LONGLONG
	declare function MultiplyHigh alias "__mulh"(byval Multiplier as LONGLONG, byval Multiplicand as LONGLONG) as LONGLONG
	declare function __umulh(byval Multiplier as ULONGLONG, byval Multiplicand as ULONGLONG) as ULONGLONG
	declare function UnsignedMultiplyHigh alias "__umulh"(byval Multiplier as ULONGLONG, byval Multiplicand as ULONGLONG) as ULONGLONG
	declare function __shiftleft128(byval LowPart as DWORD64, byval HighPart as DWORD64, byval Shift as UBYTE) as DWORD64
	declare function ShiftLeft128 alias "__shiftleft128"(byval LowPart as DWORD64, byval HighPart as DWORD64, byval Shift as UBYTE) as DWORD64
	declare function __shiftright128(byval LowPart as DWORD64, byval HighPart as DWORD64, byval Shift as UBYTE) as DWORD64
	declare function ShiftRight128 alias "__shiftright128"(byval LowPart as DWORD64, byval HighPart as DWORD64, byval Shift as UBYTE) as DWORD64
	declare function _mul128(byval Multiplier as LONG64, byval Multiplicand as LONG64, byval HighProduct as LONG64 ptr) as LONG64
	declare function Multiply128 alias "_mul128"(byval Multiplier as LONG64, byval Multiplicand as LONG64, byval HighProduct as LONG64 ptr) as LONG64
	declare function _umul128(byval Multiplier as DWORD64, byval Multiplicand as DWORD64, byval HighProduct as DWORD64 ptr) as DWORD64
	declare function UnsignedMultiply128 alias "_umul128"(byval Multiplier as DWORD64, byval Multiplicand as DWORD64, byval HighProduct as DWORD64 ptr) as DWORD64
	declare function MultiplyExtract128(byval Multiplier as LONG64, byval Multiplicand as LONG64, byval Shift as UBYTE) as LONG64
	declare function UnsignedMultiplyExtract128(byval Multiplier as DWORD64, byval Multiplicand as DWORD64, byval Shift as UBYTE) as DWORD64
#endif

const EXCEPTION_READ_FAULT = 0
const EXCEPTION_WRITE_FAULT = 1
const EXCEPTION_EXECUTE_FAULT = 8

#ifdef __FB_64BIT__
	const CONTEXT_AMD64 = &h100000
	const CONTEXT_CONTROL = CONTEXT_AMD64 or &h1
	const CONTEXT_INTEGER = CONTEXT_AMD64 or &h2
	const CONTEXT_SEGMENTS = CONTEXT_AMD64 or &h4
	const CONTEXT_FLOATING_POINT = CONTEXT_AMD64 or &h8
	const CONTEXT_DEBUG_REGISTERS = CONTEXT_AMD64 or &h10
	const CONTEXT_FULL = (CONTEXT_CONTROL or CONTEXT_INTEGER) or CONTEXT_FLOATING_POINT
	const CONTEXT_ALL = (((CONTEXT_CONTROL or CONTEXT_INTEGER) or CONTEXT_SEGMENTS) or CONTEXT_FLOATING_POINT) or CONTEXT_DEBUG_REGISTERS
	const CONTEXT_EXCEPTION_ACTIVE = &h8000000
	const CONTEXT_SERVICE_ACTIVE = &h10000000
	const CONTEXT_EXCEPTION_REQUEST = &h40000000
	const CONTEXT_EXCEPTION_REPORTING = &h80000000
	const INITIAL_MXCSR = &h1f80
	const INITIAL_FPCSR = &h027f

	type _XMM_SAVE_AREA32
		ControlWord as WORD
		StatusWord as WORD
		TagWord as UBYTE
		Reserved1 as UBYTE
		ErrorOpcode as WORD
		ErrorOffset as DWORD
		ErrorSelector as WORD
		Reserved2 as WORD
		DataOffset as DWORD
		DataSelector as WORD
		Reserved3 as WORD
		MxCsr as DWORD
		MxCsr_Mask as DWORD
		FloatRegisters(0 to 7) as M128A
		XmmRegisters(0 to 15) as M128A
		Reserved4(0 to 95) as UBYTE
	end type

	type XMM_SAVE_AREA32 as _XMM_SAVE_AREA32
	type PXMM_SAVE_AREA32 as _XMM_SAVE_AREA32 ptr
	#define LEGACY_SAVE_AREA_LENGTH sizeof(XMM_SAVE_AREA32)
#else
	const SIZE_OF_80387_REGISTERS = 80
	const CONTEXT_i386 = &h00010000
	const CONTEXT_i486 = &h00010000
	const CONTEXT_CONTROL = CONTEXT_i386 or &h00000001
	const CONTEXT_INTEGER = CONTEXT_i386 or &h00000002
	const CONTEXT_SEGMENTS = CONTEXT_i386 or &h00000004
	const CONTEXT_FLOATING_POINT = CONTEXT_i386 or &h00000008
	const CONTEXT_DEBUG_REGISTERS = CONTEXT_i386 or &h00000010
	const CONTEXT_EXTENDED_REGISTERS = CONTEXT_i386 or &h00000020
	const CONTEXT_FULL = (CONTEXT_CONTROL or CONTEXT_INTEGER) or CONTEXT_SEGMENTS
	const CONTEXT_ALL = ((((CONTEXT_CONTROL or CONTEXT_INTEGER) or CONTEXT_SEGMENTS) or CONTEXT_FLOATING_POINT) or CONTEXT_DEBUG_REGISTERS) or CONTEXT_EXTENDED_REGISTERS
	const MAXIMUM_SUPPORTED_EXTENSION = 512

	type _FLOATING_SAVE_AREA
		ControlWord as DWORD
		StatusWord as DWORD
		TagWord as DWORD
		ErrorOffset as DWORD
		ErrorSelector as DWORD
		DataOffset as DWORD
		DataSelector as DWORD
		RegisterArea(0 to 79) as UBYTE
		Cr0NpxState as DWORD
	end type

	type FLOATING_SAVE_AREA as _FLOATING_SAVE_AREA
	type PFLOATING_SAVE_AREA as FLOATING_SAVE_AREA ptr
#endif

type _CONTEXT_
	#ifdef __FB_64BIT__
		P1Home as DWORD64
		P2Home as DWORD64
		P3Home as DWORD64
		P4Home as DWORD64
		P5Home as DWORD64
		P6Home as DWORD64
	#endif

	ContextFlags as DWORD

	#ifdef __FB_64BIT__
		MxCsr as DWORD
		SegCs as WORD
		SegDs as WORD
		SegEs as WORD
		SegFs as WORD
		SegGs as WORD
		SegSs as WORD
	#else
		Dr0 as DWORD
		Dr1 as DWORD
		Dr2 as DWORD
		Dr3 as DWORD
		Dr6 as DWORD
		Dr7 as DWORD
		FloatSave as FLOATING_SAVE_AREA
		SegGs as DWORD
		SegFs as DWORD
		SegEs as DWORD
		SegDs as DWORD
		Edi as DWORD
		Esi as DWORD
		Ebx as DWORD
		Edx as DWORD
		Ecx as DWORD
		Eax as DWORD
		Ebp as DWORD
		Eip as DWORD
		SegCs as DWORD
	#endif

	EFlags as DWORD

	#ifdef __FB_64BIT__
		Dr0 as DWORD64
		Dr1 as DWORD64
		Dr2 as DWORD64
		Dr3 as DWORD64
		Dr6 as DWORD64
		Dr7 as DWORD64
		Rax as DWORD64
		Rcx as DWORD64
		Rdx as DWORD64
		Rbx as DWORD64
		Rsp as DWORD64
		Rbp as DWORD64
		Rsi as DWORD64
		Rdi as DWORD64
		R8 as DWORD64
		R9 as DWORD64
		R10 as DWORD64
		R11 as DWORD64
		R12 as DWORD64
		R13 as DWORD64
		R14 as DWORD64
		R15 as DWORD64
		Rip as DWORD64

		union
			FltSave as XMM_SAVE_AREA32
			FloatSave as XMM_SAVE_AREA32

			type
				Header(0 to 1) as M128A
				Legacy(0 to 7) as M128A
				Xmm0 as M128A
				Xmm1 as M128A
				Xmm2 as M128A
				Xmm3 as M128A
				Xmm4 as M128A
				Xmm5 as M128A
				Xmm6 as M128A
				Xmm7 as M128A
				Xmm8 as M128A
				Xmm9 as M128A
				Xmm10 as M128A
				Xmm11 as M128A
				Xmm12 as M128A
				Xmm13 as M128A
				Xmm14 as M128A
				Xmm15 as M128A
			end type
		end union

		VectorRegister(0 to 25) as M128A
		VectorControl as DWORD64
		DebugControl as DWORD64
		LastBranchToRip as DWORD64
		LastBranchFromRip as DWORD64
		LastExceptionToRip as DWORD64
		LastExceptionFromRip as DWORD64
	#else
		Esp as DWORD
		SegSs as DWORD
		ExtendedRegisters(0 to 511) as UBYTE
	#endif
end type

type CONTEXT as _CONTEXT

#ifdef __FB_64BIT__
	type PCONTEXT as _CONTEXT ptr
	const RUNTIME_FUNCTION_INDIRECT = &h1

	type _RUNTIME_FUNCTION
		BeginAddress as DWORD
		EndAddress as DWORD
		UnwindData as DWORD
	end type

	type RUNTIME_FUNCTION as _RUNTIME_FUNCTION
	type PRUNTIME_FUNCTION as _RUNTIME_FUNCTION ptr
	type PGET_RUNTIME_FUNCTION_CALLBACK as function(byval ControlPc as DWORD64, byval Context as PVOID) as PRUNTIME_FUNCTION
	type POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK as function(byval Process as HANDLE, byval TableAddress as PVOID, byval Entries as PDWORD, byval Functions as PRUNTIME_FUNCTION ptr) as DWORD

	#define OUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK_EXPORT_NAME "OutOfProcessFunctionTableCallback"
	const UNW_FLAG_NHANDLER = &h00
	const UNW_FLAG_EHANDLER = &h01
	const UNW_FLAG_UHANDLER = &h02
	const UNW_FLAG_CHAININFO = &h04
#else
	type PCONTEXT as CONTEXT ptr
#endif

#define _LDT_ENTRY_DEFINED

type _LDT_ENTRY_HighWord_Bytes
	BaseMid as UBYTE
	Flags1 as UBYTE
	Flags2 as UBYTE
	BaseHi as UBYTE
end type

type _LDT_ENTRY_HighWord_Bits
	BaseMid : 8 as DWORD
	as DWORD Type : 5
	Dpl : 2 as DWORD
	Pres : 1 as DWORD
	LimitHi : 4 as DWORD
	Sys : 1 as DWORD
	Reserved_0 : 1 as DWORD
	Default_Big : 1 as DWORD
	Granularity : 1 as DWORD
	BaseHi : 8 as DWORD
end type

union _LDT_ENTRY_HighWord
	Bytes as _LDT_ENTRY_HighWord_Bytes
	Bits as _LDT_ENTRY_HighWord_Bits
end union

type _LDT_ENTRY
	LimitLow as WORD
	BaseLow as WORD
	HighWord as _LDT_ENTRY_HighWord
end type

type LDT_ENTRY as _LDT_ENTRY
type PLDT_ENTRY as _LDT_ENTRY ptr
const EXCEPTION_NONCONTINUABLE = &h1
const EXCEPTION_UNWINDING = &h2
const EXCEPTION_EXIT_UNWIND = &h4
const EXCEPTION_STACK_INVALID = &h8
const EXCEPTION_NESTED_CALL = &h10
const EXCEPTION_TARGET_UNWIND = &h20
const EXCEPTION_COLLIDED_UNWIND = &h40
const EXCEPTION_UNWIND = &h66
#define IS_UNWINDING(f) ((f and EXCEPTION_UNWIND) <> 0)
#define IS_DISPATCHING(f) ((f and EXCEPTION_UNWIND) = 0)
#define IS_TARGET_UNWIND(f) ((f and EXCEPTION_TARGET_UNWIND) <> 0)
const EXCEPTION_MAXIMUM_PARAMETERS = 15

type _EXCEPTION_RECORD_
	ExceptionCode as DWORD
	ExceptionFlags as DWORD
	ExceptionRecord as _EXCEPTION_RECORD ptr
	ExceptionAddress as PVOID
	NumberParameters as DWORD
	ExceptionInformation(0 to 14) as ULONG_PTR
end type

type EXCEPTION_RECORD as _EXCEPTION_RECORD
type PEXCEPTION_RECORD as EXCEPTION_RECORD ptr

type _EXCEPTION_RECORD32
	ExceptionCode as DWORD
	ExceptionFlags as DWORD
	ExceptionRecord as DWORD
	ExceptionAddress as DWORD
	NumberParameters as DWORD
	ExceptionInformation(0 to 14) as DWORD
end type

type EXCEPTION_RECORD32 as _EXCEPTION_RECORD32
type PEXCEPTION_RECORD32 as _EXCEPTION_RECORD32 ptr

type _EXCEPTION_RECORD64
	ExceptionCode as DWORD
	ExceptionFlags as DWORD
	ExceptionRecord as DWORD64
	ExceptionAddress as DWORD64
	NumberParameters as DWORD
	__unusedAlignment as DWORD
	ExceptionInformation(0 to 14) as DWORD64
end type

type EXCEPTION_RECORD64 as _EXCEPTION_RECORD64
type PEXCEPTION_RECORD64 as _EXCEPTION_RECORD64 ptr

type _EXCEPTION_POINTERS
	ExceptionRecord as PEXCEPTION_RECORD
	ContextRecord as PCONTEXT
end type

type EXCEPTION_POINTERS as _EXCEPTION_POINTERS
type PEXCEPTION_POINTERS as _EXCEPTION_POINTERS ptr

#ifdef __FB_64BIT__
	const UNWIND_HISTORY_TABLE_SIZE = 12

	type _UNWIND_HISTORY_TABLE_ENTRY
		ImageBase as ULONG64
		FunctionEntry as PRUNTIME_FUNCTION
	end type

	type UNWIND_HISTORY_TABLE_ENTRY as _UNWIND_HISTORY_TABLE_ENTRY
	type PUNWIND_HISTORY_TABLE_ENTRY as _UNWIND_HISTORY_TABLE_ENTRY ptr
	const UNWIND_HISTORY_TABLE_NONE = 0
	const UNWIND_HISTORY_TABLE_GLOBAL = 1
	const UNWIND_HISTORY_TABLE_LOCAL = 2

	type _UNWIND_HISTORY_TABLE
		Count as ULONG
		Search as UCHAR
		LowAddress as ULONG64
		HighAddress as ULONG64
		Entry(0 to 11) as UNWIND_HISTORY_TABLE_ENTRY
	end type

	type UNWIND_HISTORY_TABLE as _UNWIND_HISTORY_TABLE
	type PUNWIND_HISTORY_TABLE as _UNWIND_HISTORY_TABLE ptr
	type DISPATCHER_CONTEXT as _DISPATCHER_CONTEXT
	type PDISPATCHER_CONTEXT as _DISPATCHER_CONTEXT ptr

	type _DISPATCHER_CONTEXT
		ControlPc as ULONG64
		ImageBase as ULONG64
		FunctionEntry as PRUNTIME_FUNCTION
		EstablisherFrame as ULONG64
		TargetIp as ULONG64
		ContextRecord as PCONTEXT
		LanguageHandler as PEXCEPTION_ROUTINE
		HandlerData as PVOID
		HistoryTable as PUNWIND_HISTORY_TABLE
		ScopeIndex as ULONG
		Fill0 as ULONG
	end type

	type _KNONVOLATILE_CONTEXT_POINTERS
		FloatingContext(0 to 15) as PM128A
		IntegerContext(0 to 15) as PULONG64
	end type

	type KNONVOLATILE_CONTEXT_POINTERS as _KNONVOLATILE_CONTEXT_POINTERS
	type PKNONVOLATILE_CONTEXT_POINTERS as _KNONVOLATILE_CONTEXT_POINTERS ptr
#endif

type PACCESS_TOKEN as PVOID
type PSECURITY_DESCRIPTOR as PVOID
type PSID as PVOID
type PCLAIMS_BLOB as PVOID
type ACCESS_MASK as DWORD
type PACCESS_MASK as ACCESS_MASK ptr

const DELETE__ = &h00010000
const READ_CONTROL = &h00020000
const WRITE_DAC = &h00040000
const WRITE_OWNER = &h00080000
const SYNCHRONIZE = &h00100000
const STANDARD_RIGHTS_REQUIRED = &h000F0000
const STANDARD_RIGHTS_READ = READ_CONTROL
const STANDARD_RIGHTS_WRITE = READ_CONTROL
const STANDARD_RIGHTS_EXECUTE = READ_CONTROL
const STANDARD_RIGHTS_ALL = &h001F0000
const SPECIFIC_RIGHTS_ALL = &h0000FFFF
const ACCESS_SYSTEM_SECURITY = &h01000000
const MAXIMUM_ALLOWED = &h02000000
const GENERIC_READ = &h80000000
const GENERIC_WRITE = &h40000000
const GENERIC_EXECUTE = &h20000000
const GENERIC_ALL = &h10000000

type _GENERIC_MAPPING
	GenericRead as ACCESS_MASK
	GenericWrite as ACCESS_MASK
	GenericExecute as ACCESS_MASK
	GenericAll as ACCESS_MASK
end type

type GENERIC_MAPPING as _GENERIC_MAPPING
type PGENERIC_MAPPING as GENERIC_MAPPING ptr

type _LUID_AND_ATTRIBUTES field = 4
	Luid as LUID
	Attributes as DWORD
end type

type LUID_AND_ATTRIBUTES as _LUID_AND_ATTRIBUTES
type PLUID_AND_ATTRIBUTES as _LUID_AND_ATTRIBUTES ptr
type PLUID_AND_ATTRIBUTES_ARRAY as LUID_AND_ATTRIBUTES ptr
#define SID_IDENTIFIER_AUTHORITY_DEFINED

type _SID_IDENTIFIER_AUTHORITY
	Value(0 to 5) as UBYTE
end type

type SID_IDENTIFIER_AUTHORITY as _SID_IDENTIFIER_AUTHORITY
type PSID_IDENTIFIER_AUTHORITY as _SID_IDENTIFIER_AUTHORITY ptr
#define SID_DEFINED

type _SID
	Revision as UBYTE
	SubAuthorityCount as UBYTE
	IdentifierAuthority as SID_IDENTIFIER_AUTHORITY
	SubAuthority(0 to 0) as DWORD
end type

type SID as _SID
type PISID as _SID ptr
const SID_REVISION = 1
const SID_MAX_SUB_AUTHORITIES = 15
const SID_RECOMMENDED_SUB_AUTHORITIES = 1
#define SECURITY_MAX_SID_SIZE ((sizeof(SID) - sizeof(DWORD)) + (SID_MAX_SUB_AUTHORITIES * sizeof(DWORD)))
const SID_HASH_SIZE = 32

type _SID_NAME_USE as long
enum
	SidTypeUser = 1
	SidTypeGroup
	SidTypeDomain
	SidTypeAlias
	SidTypeWellKnownGroup
	SidTypeDeletedAccount
	SidTypeInvalid
	SidTypeUnknown
	SidTypeComputer
	SidTypeLabel
end enum

type SID_NAME_USE as _SID_NAME_USE
type PSID_NAME_USE as _SID_NAME_USE ptr

type _SID_AND_ATTRIBUTES
	Sid as PSID
	Attributes as DWORD
end type

type SID_AND_ATTRIBUTES as _SID_AND_ATTRIBUTES
type PSID_AND_ATTRIBUTES as _SID_AND_ATTRIBUTES ptr
type PSID_AND_ATTRIBUTES_ARRAY as SID_AND_ATTRIBUTES ptr
type SID_HASH_ENTRY as ULONG_PTR
type PSID_HASH_ENTRY as ULONG_PTR ptr

type _SID_AND_ATTRIBUTES_HASH
	SidCount as DWORD
	SidAttr as PSID_AND_ATTRIBUTES
	Hash(0 to 31) as SID_HASH_ENTRY
end type

type SID_AND_ATTRIBUTES_HASH as _SID_AND_ATTRIBUTES_HASH
type PSID_AND_ATTRIBUTES_HASH as _SID_AND_ATTRIBUTES_HASH ptr
#define SECURITY_NULL_SID_AUTHORITY ({0, 0, 0, 0, 0, 0})
#define SECURITY_WORLD_SID_AUTHORITY ({0, 0, 0, 0, 0, 1})
#define SECURITY_LOCAL_SID_AUTHORITY ({0, 0, 0, 0, 0, 2})
#define SECURITY_CREATOR_SID_AUTHORITY ({0, 0, 0, 0, 0, 3})
#define SECURITY_NON_UNIQUE_AUTHORITY ({0, 0, 0, 0, 0, 4})
#define SECURITY_RESOURCE_MANAGER_AUTHORITY ({0, 0, 0, 0, 0, 9})
const SECURITY_NULL_RID = &h00000000
const SECURITY_WORLD_RID = &h00000000
const SECURITY_LOCAL_RID = &h00000000
const SECURITY_LOCAL_LOGON_RID = &h00000001
const SECURITY_CREATOR_OWNER_RID = &h00000000
const SECURITY_CREATOR_GROUP_RID = &h00000001
const SECURITY_CREATOR_OWNER_SERVER_RID = &h00000002
const SECURITY_CREATOR_GROUP_SERVER_RID = &h00000003
const SECURITY_CREATOR_OWNER_RIGHTS_RID = &h00000004
#define SECURITY_NT_AUTHORITY ({0, 0, 0, 0, 0, 5})
const SECURITY_DIALUP_RID = &h00000001
const SECURITY_NETWORK_RID = &h00000002
const SECURITY_BATCH_RID = &h00000003
const SECURITY_INTERACTIVE_RID = &h00000004
const SECURITY_LOGON_IDS_RID = &h00000005
const SECURITY_LOGON_IDS_RID_COUNT = 3
const SECURITY_SERVICE_RID = &h00000006
const SECURITY_ANONYMOUS_LOGON_RID = &h00000007
const SECURITY_PROXY_RID = &h00000008
const SECURITY_ENTERPRISE_CONTROLLERS_RID = &h00000009
const SECURITY_SERVER_LOGON_RID = SECURITY_ENTERPRISE_CONTROLLERS_RID
const SECURITY_PRINCIPAL_SELF_RID = &h0000000A
const SECURITY_AUTHENTICATED_USER_RID = &h0000000B
const SECURITY_RESTRICTED_CODE_RID = &h0000000C
const SECURITY_TERMINAL_SERVER_RID = &h0000000D
const SECURITY_REMOTE_LOGON_RID = &h0000000E
const SECURITY_THIS_ORGANIZATION_RID = &h0000000F
const SECURITY_IUSER_RID = &h00000011
const SECURITY_LOCAL_SYSTEM_RID = &h00000012
const SECURITY_LOCAL_SERVICE_RID = &h00000013
const SECURITY_NETWORK_SERVICE_RID = &h00000014
const SECURITY_NT_NON_UNIQUE = &h00000015
const SECURITY_NT_NON_UNIQUE_SUB_AUTH_COUNT = 3
const SECURITY_ENTERPRISE_READONLY_CONTROLLERS_RID = &h00000016
const SECURITY_BUILTIN_DOMAIN_RID = &h00000020
const SECURITY_WRITE_RESTRICTED_CODE_RID = &h00000021
const SECURITY_PACKAGE_BASE_RID = &h00000040
const SECURITY_PACKAGE_RID_COUNT = 2
const SECURITY_PACKAGE_NTLM_RID = &h0000000A
const SECURITY_PACKAGE_SCHANNEL_RID = &h0000000E
const SECURITY_PACKAGE_DIGEST_RID = &h00000015
const SECURITY_CRED_TYPE_BASE_RID = &h00000041
const SECURITY_CRED_TYPE_RID_COUNT = 2
const SECURITY_CRED_TYPE_THIS_ORG_CERT_RID = &h00000001
const SECURITY_MIN_BASE_RID = &h00000050
const SECURITY_SERVICE_ID_BASE_RID = &h00000050
const SECURITY_SERVICE_ID_RID_COUNT = 6
const SECURITY_RESERVED_ID_BASE_RID = &h00000051
const SECURITY_APPPOOL_ID_BASE_RID = &h00000052
const SECURITY_APPPOOL_ID_RID_COUNT = 6
const SECURITY_VIRTUALSERVER_ID_BASE_RID = &h00000053
const SECURITY_VIRTUALSERVER_ID_RID_COUNT = 6
const SECURITY_USERMODEDRIVERHOST_ID_BASE_RID = &h00000054
const SECURITY_USERMODEDRIVERHOST_ID_RID_COUNT = 6
const SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_BASE_RID = &h00000055
const SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_RID_COUNT = 6
const SECURITY_WMIHOST_ID_BASE_RID = &h00000056
const SECURITY_WMIHOST_ID_RID_COUNT = 6
const SECURITY_TASK_ID_BASE_RID = &h00000057
const SECURITY_NFS_ID_BASE_RID = &h00000058
const SECURITY_COM_ID_BASE_RID = &h00000059
const SECURITY_WINDOW_MANAGER_BASE_RID = &h0000005a
const SECURITY_RDV_GFX_BASE_RID = &h0000005b
const SECURITY_DASHOST_ID_BASE_RID = &h0000005c
const SECURITY_DASHOST_ID_RID_COUNT = 6
const SECURITY_VIRTUALACCOUNT_ID_RID_COUNT = 6
const SECURITY_MAX_BASE_RID = &h0000006f
const SECURITY_MAX_ALWAYS_FILTERED = &h000003E7
const SECURITY_MIN_NEVER_FILTERED = &h000003E8
const SECURITY_OTHER_ORGANIZATION_RID = &h000003E8
const SECURITY_WINDOWSMOBILE_ID_BASE_RID = &h00000070
const DOMAIN_GROUP_RID_AUTHORIZATION_DATA_IS_COMPOUNDED = &h000001f0
const DOMAIN_GROUP_RID_AUTHORIZATION_DATA_CONTAINS_CLAIMS = &h000001f1
const DOMAIN_GROUP_RID_ENTERPRISE_READONLY_DOMAIN_CONTROLLERS = &h000001f2
const FOREST_USER_RID_MAX = &h000001F3
const DOMAIN_USER_RID_ADMIN = &h000001F4
const DOMAIN_USER_RID_GUEST = &h000001F5
const DOMAIN_USER_RID_KRBTGT = &h000001F6
const DOMAIN_USER_RID_MAX = &h000003E7
const DOMAIN_GROUP_RID_ADMINS = &h00000200
const DOMAIN_GROUP_RID_USERS = &h00000201
const DOMAIN_GROUP_RID_GUESTS = &h00000202
const DOMAIN_GROUP_RID_COMPUTERS = &h00000203
const DOMAIN_GROUP_RID_CONTROLLERS = &h00000204
const DOMAIN_GROUP_RID_CERT_ADMINS = &h00000205
const DOMAIN_GROUP_RID_SCHEMA_ADMINS = &h00000206
const DOMAIN_GROUP_RID_ENTERPRISE_ADMINS = &h00000207
const DOMAIN_GROUP_RID_POLICY_ADMINS = &h00000208
const DOMAIN_GROUP_RID_READONLY_CONTROLLERS = &h00000209
const DOMAIN_GROUP_RID_CLONEABLE_CONTROLLERS = &h0000020a
const DOMAIN_ALIAS_RID_ADMINS = &h00000220
const DOMAIN_ALIAS_RID_USERS = &h00000221
const DOMAIN_ALIAS_RID_GUESTS = &h00000222
const DOMAIN_ALIAS_RID_POWER_USERS = &h00000223
const DOMAIN_ALIAS_RID_ACCOUNT_OPS = &h00000224
const DOMAIN_ALIAS_RID_SYSTEM_OPS = &h00000225
const DOMAIN_ALIAS_RID_PRINT_OPS = &h00000226
const DOMAIN_ALIAS_RID_BACKUP_OPS = &h00000227
const DOMAIN_ALIAS_RID_REPLICATOR = &h00000228
const DOMAIN_ALIAS_RID_RAS_SERVERS = &h00000229
const DOMAIN_ALIAS_RID_PREW2KCOMPACCESS = &h0000022A
const DOMAIN_ALIAS_RID_REMOTE_DESKTOP_USERS = &h0000022B
const DOMAIN_ALIAS_RID_NETWORK_CONFIGURATION_OPS = &h0000022C
const DOMAIN_ALIAS_RID_INCOMING_FOREST_TRUST_BUILDERS = &h0000022D
const DOMAIN_ALIAS_RID_MONITORING_USERS = &h0000022E
const DOMAIN_ALIAS_RID_LOGGING_USERS = &h0000022F
const DOMAIN_ALIAS_RID_AUTHORIZATIONACCESS = &h00000230
const DOMAIN_ALIAS_RID_TS_LICENSE_SERVERS = &h00000231
const DOMAIN_ALIAS_RID_DCOM_USERS = &h00000232
const DOMAIN_ALIAS_RID_IUSERS = &h00000238
const DOMAIN_ALIAS_RID_CRYPTO_OPERATORS = &h00000239
const DOMAIN_ALIAS_RID_CACHEABLE_PRINCIPALS_GROUP = &h0000023B
const DOMAIN_ALIAS_RID_NON_CACHEABLE_PRINCIPALS_GROUP = &h0000023C
const DOMAIN_ALIAS_RID_EVENT_LOG_READERS_GROUP = &h0000023D
const DOMAIN_ALIAS_RID_CERTSVC_DCOM_ACCESS_GROUP = &h0000023e
const DOMAIN_ALIAS_RID_RDS_REMOTE_ACCESS_SERVERS = &h0000023f
const DOMAIN_ALIAS_RID_RDS_ENDPOINT_SERVERS = &h00000240
const DOMAIN_ALIAS_RID_RDS_MANAGEMENT_SERVERS = &h00000241
const DOMAIN_ALIAS_RID_HYPER_V_ADMINS = &h00000242
const DOMAIN_ALIAS_RID_ACCESS_CONTROL_ASSISTANCE_OPS = &h00000243
const DOMAIN_ALIAS_RID_REMOTE_MANAGEMENT_USERS = &h00000244
#define SECURITY_APP_PACKAGE_AUTHORITY ({0, 0, 0, 0, 0, 15})
const SECURITY_APP_PACKAGE_BASE_RID = &h00000002
const SECURITY_BUILTIN_APP_PACKAGE_RID_COUNT = 2
const SECURITY_APP_PACKAGE_RID_COUNT = 8
const SECURITY_CAPABILITY_BASE_RID = &h00000003
const SECURITY_BUILTIN_CAPABILITY_RID_COUNT = 2
const SECURITY_CAPABILITY_RID_COUNT = 5
const SECURITY_BUILTIN_PACKAGE_ANY_PACKAGE = &h00000001
const SECURITY_CAPABILITY_INTERNET_CLIENT = &h00000001
const SECURITY_CAPABILITY_INTERNET_CLIENT_SERVER = &h00000002
const SECURITY_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = &h00000003
const SECURITY_CAPABILITY_PICTURES_LIBRARY = &h00000004
const SECURITY_CAPABILITY_VIDEOS_LIBRARY = &h00000005
const SECURITY_CAPABILITY_MUSIC_LIBRARY = &h00000006
const SECURITY_CAPABILITY_DOCUMENTS_LIBRARY = &h00000007
const SECURITY_CAPABILITY_ENTERPRISE_AUTHENTICATION = &h00000008
const SECURITY_CAPABILITY_SHARED_USER_CERTIFICATES = &h00000009
const SECURITY_CAPABILITY_REMOVABLE_STORAGE = &h0000000a
const SECURITY_CAPABILITY_INTERNET_EXPLORER = &h00001000
#define SECURITY_MANDATORY_LABEL_AUTHORITY ({0, 0, 0, 0, 0, 16})
const SECURITY_MANDATORY_UNTRUSTED_RID = &h00000000
const SECURITY_MANDATORY_LOW_RID = &h00001000
const SECURITY_MANDATORY_MEDIUM_RID = &h00002000
const SECURITY_MANDATORY_HIGH_RID = &h00003000
const SECURITY_MANDATORY_SYSTEM_RID = &h00004000
const SECURITY_MANDATORY_PROTECTED_PROCESS_RID = &h00005000
const SECURITY_MANDATORY_MAXIMUM_USER_RID = SECURITY_MANDATORY_SYSTEM_RID
#define MANDATORY_LEVEL_TO_MANDATORY_RID(IL) (IL * &h1000)
#define SECURITY_SCOPED_POLICY_ID_AUTHORITY ({0, 0, 0, 0, 0, 17})
#define SECURITY_AUTHENTICATION_AUTHORITY ({0, 0, 0, 0, 0, 18})
const SECURITY_AUTHENTICATION_AUTHORITY_RID_COUNT = 1
const SECURITY_AUTHENTICATION_AUTHORITY_ASSERTED_RID = &h00000001
const SECURITY_AUTHENTICATION_SERVICE_ASSERTED_RID = &h00000002
const SECURITY_TRUSTED_INSTALLER_RID1 = 956008885
const SECURITY_TRUSTED_INSTALLER_RID2 = 3418522649
const SECURITY_TRUSTED_INSTALLER_RID3 = 1831038044
const SECURITY_TRUSTED_INSTALLER_RID4 = 1853292631
const SECURITY_TRUSTED_INSTALLER_RID5 = 2271478464

type WELL_KNOWN_SID_TYPE as long
enum
	WinNullSid = 0
	WinWorldSid = 1
	WinLocalSid = 2
	WinCreatorOwnerSid = 3
	WinCreatorGroupSid = 4
	WinCreatorOwnerServerSid = 5
	WinCreatorGroupServerSid = 6
	WinNtAuthoritySid = 7
	WinDialupSid = 8
	WinNetworkSid = 9
	WinBatchSid = 10
	WinInteractiveSid = 11
	WinServiceSid = 12
	WinAnonymousSid = 13
	WinProxySid = 14
	WinEnterpriseControllersSid = 15
	WinSelfSid = 16
	WinAuthenticatedUserSid = 17
	WinRestrictedCodeSid = 18
	WinTerminalServerSid = 19
	WinRemoteLogonIdSid = 20
	WinLogonIdsSid = 21
	WinLocalSystemSid = 22
	WinLocalServiceSid = 23
	WinNetworkServiceSid = 24
	WinBuiltinDomainSid = 25
	WinBuiltinAdministratorsSid = 26
	WinBuiltinUsersSid = 27
	WinBuiltinGuestsSid = 28
	WinBuiltinPowerUsersSid = 29
	WinBuiltinAccountOperatorsSid = 30
	WinBuiltinSystemOperatorsSid = 31
	WinBuiltinPrintOperatorsSid = 32
	WinBuiltinBackupOperatorsSid = 33
	WinBuiltinReplicatorSid = 34
	WinBuiltinPreWindows2000CompatibleAccessSid = 35
	WinBuiltinRemoteDesktopUsersSid = 36
	WinBuiltinNetworkConfigurationOperatorsSid = 37
	WinAccountAdministratorSid = 38
	WinAccountGuestSid = 39
	WinAccountKrbtgtSid = 40
	WinAccountDomainAdminsSid = 41
	WinAccountDomainUsersSid = 42
	WinAccountDomainGuestsSid = 43
	WinAccountComputersSid = 44
	WinAccountControllersSid = 45
	WinAccountCertAdminsSid = 46
	WinAccountSchemaAdminsSid = 47
	WinAccountEnterpriseAdminsSid = 48
	WinAccountPolicyAdminsSid = 49
	WinAccountRasAndIasServersSid = 50
	WinNTLMAuthenticationSid = 51
	WinDigestAuthenticationSid = 52
	WinSChannelAuthenticationSid = 53
	WinThisOrganizationSid = 54
	WinOtherOrganizationSid = 55
	WinBuiltinIncomingForestTrustBuildersSid = 56
	WinBuiltinPerfMonitoringUsersSid = 57
	WinBuiltinPerfLoggingUsersSid = 58
	WinBuiltinAuthorizationAccessSid = 59
	WinBuiltinTerminalServerLicenseServersSid = 60
	WinBuiltinDCOMUsersSid = 61
	WinBuiltinIUsersSid = 62
	WinIUserSid = 63
	WinBuiltinCryptoOperatorsSid = 64
	WinUntrustedLabelSid = 65
	WinLowLabelSid = 66
	WinMediumLabelSid = 67
	WinHighLabelSid = 68
	WinSystemLabelSid = 69
	WinWriteRestrictedCodeSid = 70
	WinCreatorOwnerRightsSid = 71
	WinCacheablePrincipalsGroupSid = 72
	WinNonCacheablePrincipalsGroupSid = 73
	WinEnterpriseReadonlyControllersSid = 74
	WinAccountReadonlyControllersSid = 75
	WinBuiltinEventLogReadersGroup = 76
	WinNewEnterpriseReadonlyControllersSid = 77
	WinBuiltinCertSvcDComAccessGroup = 78
	WinMediumPlusLabelSid = 79
	WinLocalLogonSid = 80
	WinConsoleLogonSid = 81
	WinThisOrganizationCertificateSid = 82
	WinApplicationPackageAuthoritySid = 83
	WinBuiltinAnyPackageSid = 84
	WinCapabilityInternetClientSid = 85
	WinCapabilityInternetClientServerSid = 86
	WinCapabilityPrivateNetworkClientServerSid = 87
	WinCapabilityPicturesLibrarySid = 88
	WinCapabilityVideosLibrarySid = 89
	WinCapabilityMusicLibrarySid = 90
	WinCapabilityDocumentsLibrarySid = 91
	WinCapabilitySharedUserCertificatesSid = 92
	WinCapabilityEnterpriseAuthenticationSid = 93
	WinCapabilityRemovableStorageSid = 94
	WinBuiltinRDSRemoteAccessServersSid = 95
	WinBuiltinRDSEndpointServersSid = 96
	WinBuiltinRDSManagementServersSid = 97
	WinUserModeDriversSid = 98
	WinBuiltinHyperVAdminsSid = 99
	WinAccountCloneableControllersSid = 100
	WinBuiltinAccessControlAssistanceOperatorsSid = 101
	WinBuiltinRemoteManagementUsersSid = 102
	WinAuthenticationAuthorityAssertedSid = 103
	WinAuthenticationServiceAssertedSid = 104
end enum

#define SYSTEM_LUID (&h3e7, &h0)
#define ANONYMOUS_LOGON_LUID (&h3e6, &h0)
#define LOCALSERVICE_LUID (&h3e5, &h0)
#define NETWORKSERVICE_LUID (&h3e4, &h0)
#define IUSER_LUID (&h3e3, &h0)
const SE_GROUP_MANDATORY = &h00000001
const SE_GROUP_ENABLED_BY_DEFAULT = &h00000002
const SE_GROUP_ENABLED = &h00000004
const SE_GROUP_OWNER = &h00000008
const SE_GROUP_USE_FOR_DENY_ONLY = &h00000010
const SE_GROUP_INTEGRITY = &h00000020
const SE_GROUP_INTEGRITY_ENABLED = &h00000040
const SE_GROUP_LOGON_ID = &hC0000000
const SE_GROUP_RESOURCE = &h20000000
const SE_GROUP_VALID_ATTRIBUTES = (((((((SE_GROUP_MANDATORY or SE_GROUP_ENABLED_BY_DEFAULT) or SE_GROUP_ENABLED) or SE_GROUP_OWNER) or SE_GROUP_USE_FOR_DENY_ONLY) or SE_GROUP_LOGON_ID) or SE_GROUP_RESOURCE) or SE_GROUP_INTEGRITY) or SE_GROUP_INTEGRITY_ENABLED
const ACL_REVISION = 2
const ACL_REVISION_DS = 4
const ACL_REVISION1 = 1
const ACL_REVISION2 = 2
const MIN_ACL_REVISION = ACL_REVISION2
const ACL_REVISION3 = 3
const ACL_REVISION4 = 4
const MAX_ACL_REVISION = ACL_REVISION4

type _ACL
	AclRevision as UBYTE
	Sbz1 as UBYTE
	AclSize as WORD
	AceCount as WORD
	Sbz2 as WORD
end type

type ACL as _ACL
type PACL as ACL ptr

type _ACE_HEADER
	AceType as UBYTE
	AceFlags as UBYTE
	AceSize as WORD
end type

type ACE_HEADER as _ACE_HEADER
type PACE_HEADER as ACE_HEADER ptr
const ACCESS_MIN_MS_ACE_TYPE = &h0
const ACCESS_ALLOWED_ACE_TYPE = &h0
const ACCESS_DENIED_ACE_TYPE = &h1
const SYSTEM_AUDIT_ACE_TYPE = &h2
const SYSTEM_ALARM_ACE_TYPE = &h3
const ACCESS_MAX_MS_V2_ACE_TYPE = &h3
const ACCESS_ALLOWED_COMPOUND_ACE_TYPE = &h4
const ACCESS_MAX_MS_V3_ACE_TYPE = &h4
const ACCESS_MIN_MS_OBJECT_ACE_TYPE = &h5
const ACCESS_ALLOWED_OBJECT_ACE_TYPE = &h5
const ACCESS_DENIED_OBJECT_ACE_TYPE = &h6
const SYSTEM_AUDIT_OBJECT_ACE_TYPE = &h7
const SYSTEM_ALARM_OBJECT_ACE_TYPE = &h8
const ACCESS_MAX_MS_OBJECT_ACE_TYPE = &h8
const ACCESS_MAX_MS_V4_ACE_TYPE = &h8
const ACCESS_MAX_MS_ACE_TYPE = &h8
const ACCESS_ALLOWED_CALLBACK_ACE_TYPE = &h9
const ACCESS_DENIED_CALLBACK_ACE_TYPE = &hA
const ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE = &hB
const ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE = &hC
const SYSTEM_AUDIT_CALLBACK_ACE_TYPE = &hD
const SYSTEM_ALARM_CALLBACK_ACE_TYPE = &hE
const SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE = &hF
const SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE = &h10
const SYSTEM_MANDATORY_LABEL_ACE_TYPE = &h11
const SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE = &h12
const SYSTEM_SCOPED_POLICY_ID_ACE_TYPE = &h13
const ACCESS_MAX_MS_V5_ACE_TYPE = &h13
const OBJECT_INHERIT_ACE = &h1
const CONTAINER_INHERIT_ACE = &h2
const NO_PROPAGATE_INHERIT_ACE = &h4
const INHERIT_ONLY_ACE = &h8
const INHERITED_ACE = &h10
const VALID_INHERIT_FLAGS = &h1F
const SUCCESSFUL_ACCESS_ACE_FLAG = &h40
const FAILED_ACCESS_ACE_FLAG = &h80

type _ACCESS_ALLOWED_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type ACCESS_ALLOWED_ACE as _ACCESS_ALLOWED_ACE
type PACCESS_ALLOWED_ACE as ACCESS_ALLOWED_ACE ptr

type _ACCESS_DENIED_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type ACCESS_DENIED_ACE as _ACCESS_DENIED_ACE
type PACCESS_DENIED_ACE as ACCESS_DENIED_ACE ptr

type _SYSTEM_AUDIT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_AUDIT_ACE as _SYSTEM_AUDIT_ACE
type PSYSTEM_AUDIT_ACE as SYSTEM_AUDIT_ACE ptr

type _SYSTEM_ALARM_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_ALARM_ACE as _SYSTEM_ALARM_ACE
type PSYSTEM_ALARM_ACE as SYSTEM_ALARM_ACE ptr

type _SYSTEM_RESOURCE_ATTRIBUTE_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_RESOURCE_ATTRIBUTE_ACE as _SYSTEM_RESOURCE_ATTRIBUTE_ACE
type PSYSTEM_RESOURCE_ATTRIBUTE_ACE as _SYSTEM_RESOURCE_ATTRIBUTE_ACE ptr

type _SYSTEM_SCOPED_POLICY_ID_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_SCOPED_POLICY_ID_ACE as _SYSTEM_SCOPED_POLICY_ID_ACE
type PSYSTEM_SCOPED_POLICY_ID_ACE as _SYSTEM_SCOPED_POLICY_ID_ACE ptr

type _SYSTEM_MANDATORY_LABEL_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_MANDATORY_LABEL_ACE as _SYSTEM_MANDATORY_LABEL_ACE
type PSYSTEM_MANDATORY_LABEL_ACE as _SYSTEM_MANDATORY_LABEL_ACE ptr
const SYSTEM_MANDATORY_LABEL_NO_WRITE_UP = &h1
const SYSTEM_MANDATORY_LABEL_NO_READ_UP = &h2
const SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP = &h4
const SYSTEM_MANDATORY_LABEL_VALID_MASK = (SYSTEM_MANDATORY_LABEL_NO_WRITE_UP or SYSTEM_MANDATORY_LABEL_NO_READ_UP) or SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP

type _ACCESS_ALLOWED_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type ACCESS_ALLOWED_OBJECT_ACE as _ACCESS_ALLOWED_OBJECT_ACE
type PACCESS_ALLOWED_OBJECT_ACE as _ACCESS_ALLOWED_OBJECT_ACE ptr

type _ACCESS_DENIED_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type ACCESS_DENIED_OBJECT_ACE as _ACCESS_DENIED_OBJECT_ACE
type PACCESS_DENIED_OBJECT_ACE as _ACCESS_DENIED_OBJECT_ACE ptr

type _SYSTEM_AUDIT_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type SYSTEM_AUDIT_OBJECT_ACE as _SYSTEM_AUDIT_OBJECT_ACE
type PSYSTEM_AUDIT_OBJECT_ACE as _SYSTEM_AUDIT_OBJECT_ACE ptr

type _SYSTEM_ALARM_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type SYSTEM_ALARM_OBJECT_ACE as _SYSTEM_ALARM_OBJECT_ACE
type PSYSTEM_ALARM_OBJECT_ACE as _SYSTEM_ALARM_OBJECT_ACE ptr

type _ACCESS_ALLOWED_CALLBACK_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type ACCESS_ALLOWED_CALLBACK_ACE as _ACCESS_ALLOWED_CALLBACK_ACE
type PACCESS_ALLOWED_CALLBACK_ACE as _ACCESS_ALLOWED_CALLBACK_ACE ptr

type _ACCESS_DENIED_CALLBACK_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type ACCESS_DENIED_CALLBACK_ACE as _ACCESS_DENIED_CALLBACK_ACE
type PACCESS_DENIED_CALLBACK_ACE as _ACCESS_DENIED_CALLBACK_ACE ptr

type _SYSTEM_AUDIT_CALLBACK_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_AUDIT_CALLBACK_ACE as _SYSTEM_AUDIT_CALLBACK_ACE
type PSYSTEM_AUDIT_CALLBACK_ACE as _SYSTEM_AUDIT_CALLBACK_ACE ptr

type _SYSTEM_ALARM_CALLBACK_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	SidStart as DWORD
end type

type SYSTEM_ALARM_CALLBACK_ACE as _SYSTEM_ALARM_CALLBACK_ACE
type PSYSTEM_ALARM_CALLBACK_ACE as _SYSTEM_ALARM_CALLBACK_ACE ptr

type _ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type ACCESS_ALLOWED_CALLBACK_OBJECT_ACE as _ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
type PACCESS_ALLOWED_CALLBACK_OBJECT_ACE as _ACCESS_ALLOWED_CALLBACK_OBJECT_ACE ptr

type _ACCESS_DENIED_CALLBACK_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type ACCESS_DENIED_CALLBACK_OBJECT_ACE as _ACCESS_DENIED_CALLBACK_OBJECT_ACE
type PACCESS_DENIED_CALLBACK_OBJECT_ACE as _ACCESS_DENIED_CALLBACK_OBJECT_ACE ptr

type _SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type SYSTEM_AUDIT_CALLBACK_OBJECT_ACE as _SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
type PSYSTEM_AUDIT_CALLBACK_OBJECT_ACE as _SYSTEM_AUDIT_CALLBACK_OBJECT_ACE ptr

type _SYSTEM_ALARM_CALLBACK_OBJECT_ACE
	Header as ACE_HEADER
	Mask as ACCESS_MASK
	Flags as DWORD
	ObjectType as GUID
	InheritedObjectType as GUID
	SidStart as DWORD
end type

type SYSTEM_ALARM_CALLBACK_OBJECT_ACE as _SYSTEM_ALARM_CALLBACK_OBJECT_ACE
type PSYSTEM_ALARM_CALLBACK_OBJECT_ACE as _SYSTEM_ALARM_CALLBACK_OBJECT_ACE ptr
const ACE_OBJECT_TYPE_PRESENT = &h1
const ACE_INHERITED_OBJECT_TYPE_PRESENT = &h2

type _ACL_INFORMATION_CLASS as long
enum
	AclRevisionInformation = 1
	AclSizeInformation
end enum

type ACL_INFORMATION_CLASS as _ACL_INFORMATION_CLASS

type _ACL_REVISION_INFORMATION
	AclRevision as DWORD
end type

type ACL_REVISION_INFORMATION as _ACL_REVISION_INFORMATION
type PACL_REVISION_INFORMATION as ACL_REVISION_INFORMATION ptr

type _ACL_SIZE_INFORMATION
	AceCount as DWORD
	AclBytesInUse as DWORD
	AclBytesFree as DWORD
end type

type ACL_SIZE_INFORMATION as _ACL_SIZE_INFORMATION
type PACL_SIZE_INFORMATION as ACL_SIZE_INFORMATION ptr
const SECURITY_DESCRIPTOR_REVISION = 1
const SECURITY_DESCRIPTOR_REVISION1 = 1
#define SECURITY_DESCRIPTOR_MIN_LENGTH sizeof(SECURITY_DESCRIPTOR)
type SECURITY_DESCRIPTOR_CONTROL as WORD
type PSECURITY_DESCRIPTOR_CONTROL as WORD ptr
const SE_OWNER_DEFAULTED = &h0001
const SE_GROUP_DEFAULTED = &h0002
const SE_DACL_PRESENT = &h0004
const SE_DACL_DEFAULTED = &h0008
const SE_SACL_PRESENT = &h0010
const SE_SACL_DEFAULTED = &h0020
const SE_DACL_AUTO_INHERIT_REQ = &h0100
const SE_SACL_AUTO_INHERIT_REQ = &h0200
const SE_DACL_AUTO_INHERITED = &h0400
const SE_SACL_AUTO_INHERITED = &h0800
const SE_DACL_PROTECTED = &h1000
const SE_SACL_PROTECTED = &h2000
const SE_RM_CONTROL_VALID = &h4000
const SE_SELF_RELATIVE = &h8000

type _SECURITY_DESCRIPTOR_RELATIVE
	Revision as UBYTE
	Sbz1 as UBYTE
	Control as SECURITY_DESCRIPTOR_CONTROL
	Owner as DWORD
	Group as DWORD
	Sacl as DWORD
	Dacl as DWORD
end type

type SECURITY_DESCRIPTOR_RELATIVE as _SECURITY_DESCRIPTOR_RELATIVE
type PISECURITY_DESCRIPTOR_RELATIVE as _SECURITY_DESCRIPTOR_RELATIVE ptr

type _SECURITY_DESCRIPTOR
	Revision as UBYTE
	Sbz1 as UBYTE
	Control as SECURITY_DESCRIPTOR_CONTROL
	Owner as PSID
	Group as PSID
	Sacl as PACL
	Dacl as PACL
end type

type SECURITY_DESCRIPTOR as _SECURITY_DESCRIPTOR
type PISECURITY_DESCRIPTOR as _SECURITY_DESCRIPTOR ptr

type _OBJECT_TYPE_LIST
	Level as WORD
	Sbz as WORD
	ObjectType as GUID ptr
end type

type OBJECT_TYPE_LIST as _OBJECT_TYPE_LIST
type POBJECT_TYPE_LIST as _OBJECT_TYPE_LIST ptr
const ACCESS_OBJECT_GUID = 0
const ACCESS_PROPERTY_SET_GUID = 1
const ACCESS_PROPERTY_GUID = 2
const ACCESS_MAX_LEVEL = 4

type _AUDIT_EVENT_TYPE as long
enum
	AuditEventObjectAccess
	AuditEventDirectoryServiceAccess
end enum

type AUDIT_EVENT_TYPE as _AUDIT_EVENT_TYPE
type PAUDIT_EVENT_TYPE as _AUDIT_EVENT_TYPE ptr
const AUDIT_ALLOW_NO_PRIVILEGE = &h1
#define ACCESS_DS_SOURCE_A "DS"
#define ACCESS_DS_SOURCE_W wstr("DS")
#define ACCESS_DS_OBJECT_TYPE_NAME_A "Directory Service Object"
#define ACCESS_DS_OBJECT_TYPE_NAME_W wstr("Directory Service Object")
const SE_PRIVILEGE_ENABLED_BY_DEFAULT = &h00000001
const SE_PRIVILEGE_ENABLED = &h00000002
const SE_PRIVILEGE_REMOVED = &h00000004
const SE_PRIVILEGE_USED_FOR_ACCESS = &h80000000
const SE_PRIVILEGE_VALID_ATTRIBUTES = ((SE_PRIVILEGE_ENABLED_BY_DEFAULT or SE_PRIVILEGE_ENABLED) or SE_PRIVILEGE_REMOVED) or SE_PRIVILEGE_USED_FOR_ACCESS
const PRIVILEGE_SET_ALL_NECESSARY = 1

type _PRIVILEGE_SET
	PrivilegeCount as DWORD
	Control as DWORD
	Privilege(0 to 0) as LUID_AND_ATTRIBUTES
end type

type PRIVILEGE_SET as _PRIVILEGE_SET
type PPRIVILEGE_SET as _PRIVILEGE_SET ptr
const ACCESS_REASON_TYPE_MASK = &h00ff0000
const ACCESS_REASON_DATA_MASK = &h0000ffff
const ACCESS_REASON_STAGING_MASK = &h80000000
const ACCESS_REASON_EXDATA_MASK = &h7f000000

type _ACCESS_REASON_TYPE as long
enum
	AccessReasonNone = &h00000000
	AccessReasonAllowedAce = &h00010000
	AccessReasonDeniedAce = &h00020000
	AccessReasonAllowedParentAce = &h00030000
	AccessReasonDeniedParentAce = &h00040000
	AccessReasonNotGrantedByCape = &h00050000
	AccessReasonNotGrantedByParentCape = &h00060000
	AccessReasonNotGrantedToAppContainer = &h00070000
	AccessReasonMissingPrivilege = &h00100000
	AccessReasonFromPrivilege = &h00200000
	AccessReasonIntegrityLevel = &h00300000
	AccessReasonOwnership = &h00400000
	AccessReasonNullDacl = &h00500000
	AccessReasonEmptyDacl = &h00600000
	AccessReasonNoSD = &h00700000
	AccessReasonNoGrant = &h00800000
end enum

type ACCESS_REASON_TYPE as _ACCESS_REASON_TYPE
type ACCESS_REASON as DWORD

type _ACCESS_REASONS
	Data(0 to 31) as ACCESS_REASON
end type

type ACCESS_REASONS as _ACCESS_REASONS
type PACCESS_REASONS as _ACCESS_REASONS ptr
const SE_SECURITY_DESCRIPTOR_FLAG_NO_OWNER_ACE = &h00000001
const SE_SECURITY_DESCRIPTOR_FLAG_NO_LABEL_ACE = &h00000002
const SE_SECURITY_DESCRIPTOR_VALID_FLAGS = &h00000003

type _SE_SECURITY_DESCRIPTOR
	Size as DWORD
	Flags as DWORD
	SecurityDescriptor as PSECURITY_DESCRIPTOR
end type

type SE_SECURITY_DESCRIPTOR as _SE_SECURITY_DESCRIPTOR
type PSE_SECURITY_DESCRIPTOR as _SE_SECURITY_DESCRIPTOR ptr

type _SE_ACCESS_REQUEST
	Size as DWORD
	SeSecurityDescriptor as PSE_SECURITY_DESCRIPTOR
	DesiredAccess as ACCESS_MASK
	PreviouslyGrantedAccess as ACCESS_MASK
	PrincipalSelfSid as PSID
	GenericMapping as PGENERIC_MAPPING
	ObjectTypeListCount as DWORD
	ObjectTypeList as POBJECT_TYPE_LIST
end type

type SE_ACCESS_REQUEST as _SE_ACCESS_REQUEST
type PSE_ACCESS_REQUEST as _SE_ACCESS_REQUEST ptr

type _SE_ACCESS_REPLY
	Size as DWORD
	ResultListCount as DWORD
	GrantedAccess as PACCESS_MASK
	AccessStatus as PDWORD
	AccessReason as PACCESS_REASONS
	Privileges as PPRIVILEGE_SET ptr
end type

type SE_ACCESS_REPLY as _SE_ACCESS_REPLY
type PSE_ACCESS_REPLY as _SE_ACCESS_REPLY ptr
#define SE_CREATE_TOKEN_NAME __TEXT("SeCreateTokenPrivilege")
#define SE_ASSIGNPRIMARYTOKEN_NAME __TEXT("SeAssignPrimaryTokenPrivilege")
#define SE_LOCK_MEMORY_NAME __TEXT("SeLockMemoryPrivilege")
#define SE_INCREASE_QUOTA_NAME __TEXT("SeIncreaseQuotaPrivilege")
#define SE_UNSOLICITED_INPUT_NAME __TEXT("SeUnsolicitedInputPrivilege")
#define SE_MACHINE_ACCOUNT_NAME __TEXT("SeMachineAccountPrivilege")
#define SE_TCB_NAME __TEXT("SeTcbPrivilege")
#define SE_SECURITY_NAME __TEXT("SeSecurityPrivilege")
#define SE_TAKE_OWNERSHIP_NAME __TEXT("SeTakeOwnershipPrivilege")
#define SE_LOAD_DRIVER_NAME __TEXT("SeLoadDriverPrivilege")
#define SE_SYSTEM_PROFILE_NAME __TEXT("SeSystemProfilePrivilege")
#define SE_SYSTEMTIME_NAME __TEXT("SeSystemtimePrivilege")
#define SE_PROF_SINGLE_PROCESS_NAME __TEXT("SeProfileSingleProcessPrivilege")
#define SE_INC_BASE_PRIORITY_NAME __TEXT("SeIncreaseBasePriorityPrivilege")
#define SE_CREATE_PAGEFILE_NAME __TEXT("SeCreatePagefilePrivilege")
#define SE_CREATE_PERMANENT_NAME __TEXT("SeCreatePermanentPrivilege")
#define SE_BACKUP_NAME __TEXT("SeBackupPrivilege")
#define SE_RESTORE_NAME __TEXT("SeRestorePrivilege")
#define SE_SHUTDOWN_NAME __TEXT("SeShutdownPrivilege")
#define SE_DEBUG_NAME __TEXT("SeDebugPrivilege")
#define SE_AUDIT_NAME __TEXT("SeAuditPrivilege")
#define SE_SYSTEM_ENVIRONMENT_NAME __TEXT("SeSystemEnvironmentPrivilege")
#define SE_CHANGE_NOTIFY_NAME __TEXT("SeChangeNotifyPrivilege")
#define SE_REMOTE_SHUTDOWN_NAME __TEXT("SeRemoteShutdownPrivilege")
#define SE_UNDOCK_NAME __TEXT("SeUndockPrivilege")
#define SE_SYNC_AGENT_NAME __TEXT("SeSyncAgentPrivilege")
#define SE_ENABLE_DELEGATION_NAME __TEXT("SeEnableDelegationPrivilege")
#define SE_MANAGE_VOLUME_NAME __TEXT("SeManageVolumePrivilege")
#define SE_IMPERSONATE_NAME __TEXT("SeImpersonatePrivilege")
#define SE_CREATE_GLOBAL_NAME __TEXT("SeCreateGlobalPrivilege")
#define SE_TRUSTED_CREDMAN_ACCESS_NAME __TEXT("SeTrustedCredManAccessPrivilege")
#define SE_RELABEL_NAME __TEXT("SeRelabelPrivilege")
#define SE_INC_WORKING_SET_NAME __TEXT("SeIncreaseWorkingSetPrivilege")
#define SE_TIME_ZONE_NAME __TEXT("SeTimeZonePrivilege")
#define SE_CREATE_SYMBOLIC_LINK_NAME __TEXT("SeCreateSymbolicLinkPrivilege")

type _SECURITY_IMPERSONATION_LEVEL as long
enum
	SecurityAnonymous
	SecurityIdentification
	SecurityImpersonation
	SecurityDelegation
end enum

type SECURITY_IMPERSONATION_LEVEL as _SECURITY_IMPERSONATION_LEVEL
type PSECURITY_IMPERSONATION_LEVEL as _SECURITY_IMPERSONATION_LEVEL ptr
const SECURITY_MAX_IMPERSONATION_LEVEL = SecurityDelegation
const SECURITY_MIN_IMPERSONATION_LEVEL = SecurityAnonymous
const DEFAULT_IMPERSONATION_LEVEL = SecurityImpersonation
#define VALID_IMPERSONATION_LEVEL(L) (((L) >= SECURITY_MIN_IMPERSONATION_LEVEL) andalso ((L) <= SECURITY_MAX_IMPERSONATION_LEVEL))
const TOKEN_ASSIGN_PRIMARY = &h0001
const TOKEN_DUPLICATE = &h0002
const TOKEN_IMPERSONATE = &h0004
const TOKEN_QUERY = &h0008
const TOKEN_QUERY_SOURCE = &h0010
const TOKEN_ADJUST_PRIVILEGES = &h0020
const TOKEN_ADJUST_GROUPS = &h0040
const TOKEN_ADJUST_DEFAULT = &h0080
const TOKEN_ADJUST_SESSIONID = &h0100
const TOKEN_ALL_ACCESS_P = (((((((STANDARD_RIGHTS_REQUIRED or TOKEN_ASSIGN_PRIMARY) or TOKEN_DUPLICATE) or TOKEN_IMPERSONATE) or TOKEN_QUERY) or TOKEN_QUERY_SOURCE) or TOKEN_ADJUST_PRIVILEGES) or TOKEN_ADJUST_GROUPS) or TOKEN_ADJUST_DEFAULT
const TOKEN_ALL_ACCESS = TOKEN_ALL_ACCESS_P or TOKEN_ADJUST_SESSIONID
const TOKEN_READ = STANDARD_RIGHTS_READ or TOKEN_QUERY
const TOKEN_WRITE = ((STANDARD_RIGHTS_WRITE or TOKEN_ADJUST_PRIVILEGES) or TOKEN_ADJUST_GROUPS) or TOKEN_ADJUST_DEFAULT
const TOKEN_EXECUTE = STANDARD_RIGHTS_EXECUTE

type _TOKEN_TYPE as long
enum
	TokenPrimary = 1
	TokenImpersonation
end enum

type TOKEN_TYPE as _TOKEN_TYPE
type PTOKEN_TYPE as TOKEN_TYPE ptr

type _TOKEN_ELEVATION_TYPE as long
enum
	TokenElevationTypeDefault = 1
	TokenElevationTypeFull
	TokenElevationTypeLimited
end enum

type TOKEN_ELEVATION_TYPE as _TOKEN_ELEVATION_TYPE
type PTOKEN_ELEVATION_TYPE as _TOKEN_ELEVATION_TYPE ptr

type _TOKEN_INFORMATION_CLASS as long
enum
	TokenUser = 1
	TokenGroups
	TokenPrivileges
	TokenOwner
	TokenPrimaryGroup
	TokenDefaultDacl
	TokenSource
	TokenType
	TokenImpersonationLevel
	TokenStatistics
	TokenRestrictedSids
	TokenSessionId
	TokenGroupsAndPrivileges
	TokenSessionReference
	TokenSandBoxInert
	TokenAuditPolicy
	TokenOrigin
	TokenElevationType
	TokenLinkedToken
	TokenElevation
	TokenHasRestrictions
	TokenAccessInformation
	TokenVirtualizationAllowed
	TokenVirtualizationEnabled
	TokenIntegrityLevel
	TokenUIAccess
	TokenMandatoryPolicy
	TokenLogonSid
	TokenIsAppContainer
	TokenCapabilities
	TokenAppContainerSid
	TokenAppContainerNumber
	TokenUserClaimAttributes
	TokenDeviceClaimAttributes
	TokenRestrictedUserClaimAttributes
	TokenRestrictedDeviceClaimAttributes
	TokenDeviceGroups
	TokenRestrictedDeviceGroups
	TokenSecurityAttributes
	TokenIsRestricted
	MaxTokenInfoClass
end enum

type TOKEN_INFORMATION_CLASS as _TOKEN_INFORMATION_CLASS
type PTOKEN_INFORMATION_CLASS as _TOKEN_INFORMATION_CLASS ptr

type _TOKEN_USER
	User as SID_AND_ATTRIBUTES
end type

type TOKEN_USER as _TOKEN_USER
type PTOKEN_USER as _TOKEN_USER ptr

type _TOKEN_GROUPS
	GroupCount as DWORD
	Groups(0 to 0) as SID_AND_ATTRIBUTES
end type

type TOKEN_GROUPS as _TOKEN_GROUPS
type PTOKEN_GROUPS as _TOKEN_GROUPS ptr

type _TOKEN_PRIVILEGES
	PrivilegeCount as DWORD
	Privileges(0 to 0) as LUID_AND_ATTRIBUTES
end type

type TOKEN_PRIVILEGES as _TOKEN_PRIVILEGES
type PTOKEN_PRIVILEGES as _TOKEN_PRIVILEGES ptr

type _TOKEN_OWNER
	Owner as PSID
end type

type TOKEN_OWNER as _TOKEN_OWNER
type PTOKEN_OWNER as _TOKEN_OWNER ptr

type _TOKEN_PRIMARY_GROUP
	PrimaryGroup as PSID
end type

type TOKEN_PRIMARY_GROUP as _TOKEN_PRIMARY_GROUP
type PTOKEN_PRIMARY_GROUP as _TOKEN_PRIMARY_GROUP ptr

type _TOKEN_DEFAULT_DACL
	DefaultDacl as PACL
end type

type TOKEN_DEFAULT_DACL as _TOKEN_DEFAULT_DACL
type PTOKEN_DEFAULT_DACL as _TOKEN_DEFAULT_DACL ptr

type _TOKEN_USER_CLAIMS
	UserClaims as PCLAIMS_BLOB
end type

type TOKEN_USER_CLAIMS as _TOKEN_USER_CLAIMS
type PTOKEN_USER_CLAIMS as _TOKEN_USER_CLAIMS ptr

type _TOKEN_DEVICE_CLAIMS
	DeviceClaims as PCLAIMS_BLOB
end type

type TOKEN_DEVICE_CLAIMS as _TOKEN_DEVICE_CLAIMS
type PTOKEN_DEVICE_CLAIMS as _TOKEN_DEVICE_CLAIMS ptr

type _TOKEN_GROUPS_AND_PRIVILEGES
	SidCount as DWORD
	SidLength as DWORD
	Sids as PSID_AND_ATTRIBUTES
	RestrictedSidCount as DWORD
	RestrictedSidLength as DWORD
	RestrictedSids as PSID_AND_ATTRIBUTES
	PrivilegeCount as DWORD
	PrivilegeLength as DWORD
	Privileges as PLUID_AND_ATTRIBUTES
	AuthenticationId as LUID
end type

type TOKEN_GROUPS_AND_PRIVILEGES as _TOKEN_GROUPS_AND_PRIVILEGES
type PTOKEN_GROUPS_AND_PRIVILEGES as _TOKEN_GROUPS_AND_PRIVILEGES ptr

type _TOKEN_LINKED_TOKEN
	LinkedToken as HANDLE
end type

type TOKEN_LINKED_TOKEN as _TOKEN_LINKED_TOKEN
type PTOKEN_LINKED_TOKEN as _TOKEN_LINKED_TOKEN ptr

type _TOKEN_ELEVATION
	TokenIsElevated as DWORD
end type

type TOKEN_ELEVATION as _TOKEN_ELEVATION
type PTOKEN_ELEVATION as _TOKEN_ELEVATION ptr

type _TOKEN_MANDATORY_LABEL
	Label as SID_AND_ATTRIBUTES
end type

type TOKEN_MANDATORY_LABEL as _TOKEN_MANDATORY_LABEL
type PTOKEN_MANDATORY_LABEL as _TOKEN_MANDATORY_LABEL ptr
const TOKEN_MANDATORY_POLICY_OFF = &h0
const TOKEN_MANDATORY_POLICY_NO_WRITE_UP = &h1
const TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN = &h2
const TOKEN_MANDATORY_POLICY_VALID_MASK = TOKEN_MANDATORY_POLICY_NO_WRITE_UP or TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN

type _TOKEN_MANDATORY_POLICY
	Policy as DWORD
end type

type TOKEN_MANDATORY_POLICY as _TOKEN_MANDATORY_POLICY
type PTOKEN_MANDATORY_POLICY as _TOKEN_MANDATORY_POLICY ptr

type _TOKEN_ACCESS_INFORMATION
	SidHash as PSID_AND_ATTRIBUTES_HASH
	RestrictedSidHash as PSID_AND_ATTRIBUTES_HASH
	Privileges as PTOKEN_PRIVILEGES
	AuthenticationId as LUID
	TokenType as TOKEN_TYPE
	ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL
	MandatoryPolicy as TOKEN_MANDATORY_POLICY
	Flags as DWORD
	AppContainerNumber as DWORD
	PackageSid as PSID
	CapabilitiesHash as PSID_AND_ATTRIBUTES_HASH
end type

type TOKEN_ACCESS_INFORMATION as _TOKEN_ACCESS_INFORMATION
type PTOKEN_ACCESS_INFORMATION as _TOKEN_ACCESS_INFORMATION ptr
const POLICY_AUDIT_SUBCATEGORY_COUNT = 56

type _TOKEN_AUDIT_POLICY
	PerUserPolicy(0 to ((56 shr 1) + 1) - 1) as UCHAR
end type

type TOKEN_AUDIT_POLICY as _TOKEN_AUDIT_POLICY
type PTOKEN_AUDIT_POLICY as _TOKEN_AUDIT_POLICY ptr
const TOKEN_SOURCE_LENGTH = 8

type _TOKEN_SOURCE
	SourceName as zstring * 8
	SourceIdentifier as LUID
end type

type TOKEN_SOURCE as _TOKEN_SOURCE
type PTOKEN_SOURCE as _TOKEN_SOURCE ptr

type _TOKEN_STATISTICS
	TokenId as LUID
	AuthenticationId as LUID
	ExpirationTime as LARGE_INTEGER
	TokenType as TOKEN_TYPE
	ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL
	DynamicCharged as DWORD
	DynamicAvailable as DWORD
	GroupCount as DWORD
	PrivilegeCount as DWORD
	ModifiedId as LUID
end type

type TOKEN_STATISTICS as _TOKEN_STATISTICS
type PTOKEN_STATISTICS as _TOKEN_STATISTICS ptr

type _TOKEN_CONTROL
	TokenId as LUID
	AuthenticationId as LUID
	ModifiedId as LUID
	TokenSource as TOKEN_SOURCE
end type

type TOKEN_CONTROL as _TOKEN_CONTROL
type PTOKEN_CONTROL as _TOKEN_CONTROL ptr

type _TOKEN_ORIGIN
	OriginatingLogonSession as LUID
end type

type TOKEN_ORIGIN as _TOKEN_ORIGIN
type PTOKEN_ORIGIN as _TOKEN_ORIGIN ptr

type _MANDATORY_LEVEL as long
enum
	MandatoryLevelUntrusted = 0
	MandatoryLevelLow
	MandatoryLevelMedium
	MandatoryLevelHigh
	MandatoryLevelSystem
	MandatoryLevelSecureProcess
	MandatoryLevelCount
end enum

type MANDATORY_LEVEL as _MANDATORY_LEVEL
type PMANDATORY_LEVEL as _MANDATORY_LEVEL ptr

type _TOKEN_APPCONTAINER_INFORMATION
	TokenAppContainer as PSID
end type

type TOKEN_APPCONTAINER_INFORMATION as _TOKEN_APPCONTAINER_INFORMATION
type PTOKEN_APPCONTAINER_INFORMATION as _TOKEN_APPCONTAINER_INFORMATION ptr
const CLAIM_SECURITY_ATTRIBUTE_TYPE_INVALID = &h00
const CLAIM_SECURITY_ATTRIBUTE_TYPE_INT64 = &h01
const CLAIM_SECURITY_ATTRIBUTE_TYPE_UINT64 = &h02
const CLAIM_SECURITY_ATTRIBUTE_TYPE_STRING = &h03
const CLAIM_SECURITY_ATTRIBUTE_TYPE_FQBN = &h04
const CLAIM_SECURITY_ATTRIBUTE_TYPE_SID = &h05
const CLAIM_SECURITY_ATTRIBUTE_TYPE_BOOLEAN = &h06

type _CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
	Version as DWORD64
	Name as PWSTR
end type

type CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE as _CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
type PCLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE as _CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE ptr

type _CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
	pValue as PVOID
	ValueLength as DWORD
end type

type CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE as _CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
type PCLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE as _CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE ptr
const CLAIM_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING = &h10
const CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE = &h0001
const CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE = &h0002
const CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY = &h0004
const CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT = &h0008
const CLAIM_SECURITY_ATTRIBUTE_DISABLED = &h0010
const CLAIM_SECURITY_ATTRIBUTE_MANDATORY = &h0020
const CLAIM_SECURITY_ATTRIBUTE_VALID_FLAGS = ((((CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE or CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE) or CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY) or CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT) or CLAIM_SECURITY_ATTRIBUTE_DISABLED) or CLAIM_SECURITY_ATTRIBUTE_MANDATORY
const CLAIM_SECURITY_ATTRIBUTE_CUSTOM_FLAGS = &hffff0000

union _CLAIM_SECURITY_ATTRIBUTE_V1_Values
	pInt64 as PLONG64
	pUint64 as PDWORD64
	ppString as PWSTR ptr
	pFqbn as PCLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
	pOctetString as PCLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
end union

type _CLAIM_SECURITY_ATTRIBUTE_V1
	Name as PWSTR
	ValueType as WORD
	Reserved as WORD
	Flags as DWORD
	ValueCount as DWORD
	Values as _CLAIM_SECURITY_ATTRIBUTE_V1_Values
end type

type CLAIM_SECURITY_ATTRIBUTE_V1 as _CLAIM_SECURITY_ATTRIBUTE_V1
type PCLAIM_SECURITY_ATTRIBUTE_V1 as _CLAIM_SECURITY_ATTRIBUTE_V1 ptr

union _CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1_Values
	pInt64(0 to 0) as DWORD
	pUint64(0 to 0) as DWORD
	ppString(0 to 0) as DWORD
	pFqbn(0 to 0) as DWORD
	pOctetString(0 to 0) as DWORD
end union

type _CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
	Name as DWORD
	ValueType as WORD
	Reserved as WORD
	Flags as DWORD
	ValueCount as DWORD
	Values as _CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1_Values
end type

type CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1 as _CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
type PCLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1 as _CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1 ptr
const CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1 = 1
const CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION = CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1

union _CLAIM_SECURITY_ATTRIBUTES_INFORMATION_Attribute
	pAttributeV1 as PCLAIM_SECURITY_ATTRIBUTE_V1
end union

type _CLAIM_SECURITY_ATTRIBUTES_INFORMATION
	Version as WORD
	Reserved as WORD
	AttributeCount as DWORD
	Attribute as _CLAIM_SECURITY_ATTRIBUTES_INFORMATION_Attribute
end type

type CLAIM_SECURITY_ATTRIBUTES_INFORMATION as _CLAIM_SECURITY_ATTRIBUTES_INFORMATION
type PCLAIM_SECURITY_ATTRIBUTES_INFORMATION as _CLAIM_SECURITY_ATTRIBUTES_INFORMATION ptr
const SECURITY_DYNAMIC_TRACKING = CTRUE
const SECURITY_STATIC_TRACKING = FALSE
type SECURITY_CONTEXT_TRACKING_MODE as WINBOOLEAN
type PSECURITY_CONTEXT_TRACKING_MODE as WINBOOLEAN ptr

type _SECURITY_QUALITY_OF_SERVICE
	Length as DWORD
	ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL
	ContextTrackingMode as SECURITY_CONTEXT_TRACKING_MODE
	EffectiveOnly as WINBOOLEAN
end type

type SECURITY_QUALITY_OF_SERVICE as _SECURITY_QUALITY_OF_SERVICE
type PSECURITY_QUALITY_OF_SERVICE as _SECURITY_QUALITY_OF_SERVICE ptr

type _SE_IMPERSONATION_STATE
	Token as PACCESS_TOKEN
	CopyOnOpen as WINBOOLEAN
	EffectiveOnly as WINBOOLEAN
	Level as SECURITY_IMPERSONATION_LEVEL
end type

type SE_IMPERSONATION_STATE as _SE_IMPERSONATION_STATE
type PSE_IMPERSONATION_STATE as _SE_IMPERSONATION_STATE ptr
const DISABLE_MAX_PRIVILEGE = &h1
const SANDBOX_INERT = &h2
const LUA_TOKEN = &h4
const WRITE_RESTRICTED = &h8
type SECURITY_INFORMATION as DWORD
type PSECURITY_INFORMATION as DWORD ptr
const OWNER_SECURITY_INFORMATION = &h00000001
const GROUP_SECURITY_INFORMATION = &h00000002
const DACL_SECURITY_INFORMATION = &h00000004
const SACL_SECURITY_INFORMATION = &h00000008
const LABEL_SECURITY_INFORMATION = &h00000010
const ATTRIBUTE_SECURITY_INFORMATION = &h00000020
const SCOPE_SECURITY_INFORMATION = &h00000040
const BACKUP_SECURITY_INFORMATION = &h00010000
const PROTECTED_DACL_SECURITY_INFORMATION = &h80000000
const PROTECTED_SACL_SECURITY_INFORMATION = &h40000000
const UNPROTECTED_DACL_SECURITY_INFORMATION = &h20000000
const UNPROTECTED_SACL_SECURITY_INFORMATION = &h10000000

type _SE_LEARNING_MODE_DATA_TYPE as long
enum
	SeLearningModeInvalidType = 0
	SeLearningModeSettings
	SeLearningModeMax
end enum

type SE_LEARNING_MODE_DATA_TYPE as _SE_LEARNING_MODE_DATA_TYPE
const SE_LEARNING_MODE_FLAG_PERMISSIVE = &h00000001

type _SECURITY_CAPABILITIES
	AppContainerSid as PSID
	Capabilities as PSID_AND_ATTRIBUTES
	CapabilityCount as DWORD
	Reserved as DWORD
end type

type SECURITY_CAPABILITIES as _SECURITY_CAPABILITIES
type PSECURITY_CAPABILITIES as _SECURITY_CAPABILITIES ptr
type LPSECURITY_CAPABILITIES as _SECURITY_CAPABILITIES ptr

const PROCESS_TERMINATE = &h0001
const PROCESS_CREATE_THREAD = &h0002
const PROCESS_SET_SESSIONID = &h0004
const PROCESS_VM_OPERATION = &h0008
const PROCESS_VM_READ = &h0010
const PROCESS_VM_WRITE = &h0020
const PROCESS_DUP_HANDLE = &h0040
const PROCESS_CREATE_PROCESS = &h0080
const PROCESS_SET_QUOTA = &h0100
const PROCESS_SET_INFORMATION = &h0200
const PROCESS_QUERY_INFORMATION = &h0400
const PROCESS_SUSPEND_RESUME = &h0800
const PROCESS_QUERY_LIMITED_INFORMATION = &h1000

#if _WIN32_WINNT <= &h0502
	const PROCESS_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &hfff
#else
	const PROCESS_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &hffff
#endif

#ifdef __FB_64BIT__
	const MAXIMUM_PROC_PER_GROUP = 64
#else
	const MAXIMUM_PROC_PER_GROUP = 32
#endif

const MAXIMUM_PROCESSORS = MAXIMUM_PROC_PER_GROUP
const THREAD_TERMINATE = &h0001
const THREAD_SUSPEND_RESUME = &h0002
const THREAD_GET_CONTEXT = &h0008
const THREAD_SET_CONTEXT = &h0010
const THREAD_SET_INFORMATION = &h0020
const THREAD_QUERY_INFORMATION = &h0040
const THREAD_SET_THREAD_TOKEN = &h0080
const THREAD_IMPERSONATE = &h0100
const THREAD_DIRECT_IMPERSONATION = &h0200
const THREAD_SET_LIMITED_INFORMATION = &h0400
const THREAD_QUERY_LIMITED_INFORMATION = &h0800

#if _WIN32_WINNT <= &h0502
	const THREAD_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h3ff
#else
	const THREAD_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &hffff
#endif

const JOB_OBJECT_ASSIGN_PROCESS = &h0001
const JOB_OBJECT_SET_ATTRIBUTES = &h0002
const JOB_OBJECT_QUERY = &h0004
const JOB_OBJECT_TERMINATE = &h0008
const JOB_OBJECT_SET_SECURITY_ATTRIBUTES = &h0010
const JOB_OBJECT_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h1F

type _JOB_SET_ARRAY
	JobHandle as HANDLE
	MemberLevel as DWORD
	Flags as DWORD
end type

type JOB_SET_ARRAY as _JOB_SET_ARRAY
type PJOB_SET_ARRAY as _JOB_SET_ARRAY ptr
const FLS_MAXIMUM_AVAILABLE = 128
const TLS_MINIMUM_AVAILABLE = 64

type _EXCEPTION_REGISTRATION_RECORD
	union
		Next as _EXCEPTION_REGISTRATION_RECORD ptr
		prev as _EXCEPTION_REGISTRATION_RECORD ptr
	end union

	union
		Handler as PEXCEPTION_ROUTINE
	end union
end type

type EXCEPTION_REGISTRATION_RECORD as _EXCEPTION_REGISTRATION_RECORD
type PEXCEPTION_REGISTRATION_RECORD as EXCEPTION_REGISTRATION_RECORD ptr
type EXCEPTION_REGISTRATION as EXCEPTION_REGISTRATION_RECORD
type PEXCEPTION_REGISTRATION as PEXCEPTION_REGISTRATION_RECORD
#define _NT_TIB_DEFINED

type _NT_TIB
	ExceptionList as _EXCEPTION_REGISTRATION_RECORD ptr
	StackBase as PVOID
	StackLimit as PVOID
	SubSystemTib as PVOID

	union
		FiberData as PVOID
		Version as DWORD
	end union

	ArbitraryUserPointer as PVOID
	Self as _NT_TIB ptr
end type

type NT_TIB as _NT_TIB
type PNT_TIB as NT_TIB ptr

type _NT_TIB32
	ExceptionList as DWORD
	StackBase as DWORD
	StackLimit as DWORD
	SubSystemTib as DWORD

	union
		FiberData as DWORD
		Version as DWORD
	end union

	ArbitraryUserPointer as DWORD
	Self as DWORD
end type

type NT_TIB32 as _NT_TIB32
type PNT_TIB32 as _NT_TIB32 ptr

type _NT_TIB64
	ExceptionList as DWORD64
	StackBase as DWORD64
	StackLimit as DWORD64
	SubSystemTib as DWORD64

	union
		FiberData as DWORD64
		Version as DWORD
	end union

	ArbitraryUserPointer as DWORD64
	Self as DWORD64
end type

type NT_TIB64 as _NT_TIB64
type PNT_TIB64 as _NT_TIB64 ptr
const THREAD_BASE_PRIORITY_LOWRT = 15
const THREAD_BASE_PRIORITY_MAX = 2
const THREAD_BASE_PRIORITY_MIN = -2
const THREAD_BASE_PRIORITY_IDLE = -15

type _UMS_CREATE_THREAD_ATTRIBUTES
	UmsVersion as DWORD
	UmsContext as PVOID
	UmsCompletionList as PVOID
end type

type UMS_CREATE_THREAD_ATTRIBUTES as _UMS_CREATE_THREAD_ATTRIBUTES
type PUMS_CREATE_THREAD_ATTRIBUTES as _UMS_CREATE_THREAD_ATTRIBUTES ptr

type _QUOTA_LIMITS
	PagedPoolLimit as SIZE_T_
	NonPagedPoolLimit as SIZE_T_
	MinimumWorkingSetSize as SIZE_T_
	MaximumWorkingSetSize as SIZE_T_
	PagefileLimit as SIZE_T_
	TimeLimit as LARGE_INTEGER
end type

type QUOTA_LIMITS as _QUOTA_LIMITS
type PQUOTA_LIMITS as _QUOTA_LIMITS ptr
const QUOTA_LIMITS_HARDWS_MIN_ENABLE = &h00000001
const QUOTA_LIMITS_HARDWS_MIN_DISABLE = &h00000002
const QUOTA_LIMITS_HARDWS_MAX_ENABLE = &h00000004
const QUOTA_LIMITS_HARDWS_MAX_DISABLE = &h00000008
const QUOTA_LIMITS_USE_DEFAULT_LIMITS = &h00000010

union _RATE_QUOTA_LIMIT
	RateData as DWORD

	type
		RatePercent : 7 as DWORD
		Reserved0 : 25 as DWORD
	end type
end union

type RATE_QUOTA_LIMIT as _RATE_QUOTA_LIMIT
type PRATE_QUOTA_LIMIT as _RATE_QUOTA_LIMIT ptr

type _QUOTA_LIMITS_EX
	PagedPoolLimit as SIZE_T_
	NonPagedPoolLimit as SIZE_T_
	MinimumWorkingSetSize as SIZE_T_
	MaximumWorkingSetSize as SIZE_T_
	PagefileLimit as SIZE_T_
	TimeLimit as LARGE_INTEGER
	WorkingSetLimit as SIZE_T_
	Reserved2 as SIZE_T_
	Reserved3 as SIZE_T_
	Reserved4 as SIZE_T_
	Flags as DWORD
	CpuRateLimit as RATE_QUOTA_LIMIT
end type

type QUOTA_LIMITS_EX as _QUOTA_LIMITS_EX
type PQUOTA_LIMITS_EX as _QUOTA_LIMITS_EX ptr

type _IO_COUNTERS
	ReadOperationCount as ULONGLONG
	WriteOperationCount as ULONGLONG
	OtherOperationCount as ULONGLONG
	ReadTransferCount as ULONGLONG
	WriteTransferCount as ULONGLONG
	OtherTransferCount as ULONGLONG
end type

type IO_COUNTERS as _IO_COUNTERS
type PIO_COUNTERS as IO_COUNTERS ptr
const MAX_HW_COUNTERS = 16
const THREAD_PROFILING_FLAG_DISPATCH = &h1

type _HARDWARE_COUNTER_TYPE as long
enum
	PMCCounter
	MaxHardwareCounterType
end enum

type HARDWARE_COUNTER_TYPE as _HARDWARE_COUNTER_TYPE
type PHARDWARE_COUNTER_TYPE as _HARDWARE_COUNTER_TYPE ptr

type _PROCESS_MITIGATION_POLICY as long
enum
	ProcessDEPPolicy
	ProcessASLRPolicy
	ProcessReserved1MitigationPolicy
	ProcessStrictHandleCheckPolicy
	ProcessSystemCallDisablePolicy
	ProcessMitigationOptionsMask
	ProcessExtensionPointDisablePolicy
	MaxProcessMitigationPolicy
end enum

type PROCESS_MITIGATION_POLICY as _PROCESS_MITIGATION_POLICY
type PPROCESS_MITIGATION_POLICY as _PROCESS_MITIGATION_POLICY ptr

type _PROCESS_MITIGATION_ASLR_POLICY
	union
		Flags as DWORD

		type
			EnableBottomUpRandomization : 1 as DWORD
			EnableForceRelocateImages : 1 as DWORD
			EnableHighEntropy : 1 as DWORD
			DisallowStrippedImages : 1 as DWORD
			ReservedFlags : 28 as DWORD
		end type
	end union
end type

type PROCESS_MITIGATION_ASLR_POLICY as _PROCESS_MITIGATION_ASLR_POLICY
type PPROCESS_MITIGATION_ASLR_POLICY as _PROCESS_MITIGATION_ASLR_POLICY ptr

type _PROCESS_MITIGATION_DEP_POLICY
	union
		Flags as DWORD

		type
			Enable : 1 as DWORD
			DisableAtlThunkEmulation : 1 as DWORD
			ReservedFlags : 30 as DWORD
		end type
	end union

	Permanent as WINBOOLEAN
end type

type PROCESS_MITIGATION_DEP_POLICY as _PROCESS_MITIGATION_DEP_POLICY
type PPROCESS_MITIGATION_DEP_POLICY as _PROCESS_MITIGATION_DEP_POLICY ptr

type _PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
	union
		Flags as DWORD

		type
			RaiseExceptionOnInvalidHandleReference : 1 as DWORD
			HandleExceptionsPermanentlyEnabled : 1 as DWORD
			ReservedFlags : 30 as DWORD
		end type
	end union
end type

type PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY as _PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
type PPROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY as _PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY ptr

type _PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
	union
		Flags as DWORD

		type
			DisallowWin32kSystemCalls : 1 as DWORD
			ReservedFlags : 31 as DWORD
		end type
	end union
end type

type PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY as _PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
type PPROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY as _PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY ptr

type _PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
	union
		Flags as DWORD

		type
			DisableExtensionPoints : 1 as DWORD
			ReservedFlags : 31 as DWORD
		end type
	end union
end type

type PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY as _PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
type PPROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY as _PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY ptr

type _JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
	TotalUserTime as LARGE_INTEGER
	TotalKernelTime as LARGE_INTEGER
	ThisPeriodTotalUserTime as LARGE_INTEGER
	ThisPeriodTotalKernelTime as LARGE_INTEGER
	TotalPageFaultCount as DWORD
	TotalProcesses as DWORD
	ActiveProcesses as DWORD
	TotalTerminatedProcesses as DWORD
end type

type JOBOBJECT_BASIC_ACCOUNTING_INFORMATION as _JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
type PJOBOBJECT_BASIC_ACCOUNTING_INFORMATION as _JOBOBJECT_BASIC_ACCOUNTING_INFORMATION ptr

type _JOBOBJECT_BASIC_LIMIT_INFORMATION
	PerProcessUserTimeLimit as LARGE_INTEGER
	PerJobUserTimeLimit as LARGE_INTEGER
	LimitFlags as DWORD
	MinimumWorkingSetSize as SIZE_T_
	MaximumWorkingSetSize as SIZE_T_
	ActiveProcessLimit as DWORD
	Affinity as ULONG_PTR
	PriorityClass as DWORD
	SchedulingClass as DWORD
end type

type JOBOBJECT_BASIC_LIMIT_INFORMATION as _JOBOBJECT_BASIC_LIMIT_INFORMATION
type PJOBOBJECT_BASIC_LIMIT_INFORMATION as _JOBOBJECT_BASIC_LIMIT_INFORMATION ptr

type _JOBOBJECT_EXTENDED_LIMIT_INFORMATION
	BasicLimitInformation as JOBOBJECT_BASIC_LIMIT_INFORMATION
	IoInfo as IO_COUNTERS
	ProcessMemoryLimit as SIZE_T_
	JobMemoryLimit as SIZE_T_
	PeakProcessMemoryUsed as SIZE_T_
	PeakJobMemoryUsed as SIZE_T_
end type

type JOBOBJECT_EXTENDED_LIMIT_INFORMATION as _JOBOBJECT_EXTENDED_LIMIT_INFORMATION
type PJOBOBJECT_EXTENDED_LIMIT_INFORMATION as _JOBOBJECT_EXTENDED_LIMIT_INFORMATION ptr

type _JOBOBJECT_BASIC_PROCESS_ID_LIST
	NumberOfAssignedProcesses as DWORD
	NumberOfProcessIdsInList as DWORD
	ProcessIdList(0 to 0) as ULONG_PTR
end type

type JOBOBJECT_BASIC_PROCESS_ID_LIST as _JOBOBJECT_BASIC_PROCESS_ID_LIST
type PJOBOBJECT_BASIC_PROCESS_ID_LIST as _JOBOBJECT_BASIC_PROCESS_ID_LIST ptr

type _JOBOBJECT_BASIC_UI_RESTRICTIONS
	UIRestrictionsClass as DWORD
end type

type JOBOBJECT_BASIC_UI_RESTRICTIONS as _JOBOBJECT_BASIC_UI_RESTRICTIONS
type PJOBOBJECT_BASIC_UI_RESTRICTIONS as _JOBOBJECT_BASIC_UI_RESTRICTIONS ptr

type _JOBOBJECT_SECURITY_LIMIT_INFORMATION
	SecurityLimitFlags as DWORD
	JobToken as HANDLE
	SidsToDisable as PTOKEN_GROUPS
	PrivilegesToDelete as PTOKEN_PRIVILEGES
	RestrictedSids as PTOKEN_GROUPS
end type

type JOBOBJECT_SECURITY_LIMIT_INFORMATION as _JOBOBJECT_SECURITY_LIMIT_INFORMATION
type PJOBOBJECT_SECURITY_LIMIT_INFORMATION as _JOBOBJECT_SECURITY_LIMIT_INFORMATION ptr

type _JOBOBJECT_END_OF_JOB_TIME_INFORMATION
	EndOfJobTimeAction as DWORD
end type

type JOBOBJECT_END_OF_JOB_TIME_INFORMATION as _JOBOBJECT_END_OF_JOB_TIME_INFORMATION
type PJOBOBJECT_END_OF_JOB_TIME_INFORMATION as _JOBOBJECT_END_OF_JOB_TIME_INFORMATION ptr

type _JOBOBJECT_ASSOCIATE_COMPLETION_PORT
	CompletionKey as PVOID
	CompletionPort as HANDLE
end type

type JOBOBJECT_ASSOCIATE_COMPLETION_PORT as _JOBOBJECT_ASSOCIATE_COMPLETION_PORT
type PJOBOBJECT_ASSOCIATE_COMPLETION_PORT as _JOBOBJECT_ASSOCIATE_COMPLETION_PORT ptr

type _JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
	BasicInfo as JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
	IoInfo as IO_COUNTERS
end type

type JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION as _JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
type PJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION as _JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION ptr

type _JOBOBJECT_JOBSET_INFORMATION
	MemberLevel as DWORD
end type

type JOBOBJECT_JOBSET_INFORMATION as _JOBOBJECT_JOBSET_INFORMATION
type PJOBOBJECT_JOBSET_INFORMATION as _JOBOBJECT_JOBSET_INFORMATION ptr

type _JOBOBJECT_RATE_CONTROL_TOLERANCE as long
enum
	ToleranceLow = 1
	ToleranceMedium
	ToleranceHigh
end enum

type JOBOBJECT_RATE_CONTROL_TOLERANCE as _JOBOBJECT_RATE_CONTROL_TOLERANCE

type _JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL as long
enum
	ToleranceIntervalShort = 1
	ToleranceIntervalMedium
	ToleranceIntervalLong
end enum

type JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL as _JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL

type _JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION
	IoReadBytesLimit as DWORD64
	IoWriteBytesLimit as DWORD64
	PerJobUserTimeLimit as LARGE_INTEGER
	JobMemoryLimit as DWORD64
	RateControlTolerance as JOBOBJECT_RATE_CONTROL_TOLERANCE
	RateControlToleranceInterval as JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
	LimitFlags as DWORD
end type

type JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION as _JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION
type PJOBOBJECT_NOTIFICATION_LIMIT_INFORMATION as _JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION ptr

type _JOBOBJECT_LIMIT_VIOLATION_INFORMATION
	LimitFlags as DWORD
	ViolationLimitFlags as DWORD
	IoReadBytes as DWORD64
	IoReadBytesLimit as DWORD64
	IoWriteBytes as DWORD64
	IoWriteBytesLimit as DWORD64
	PerJobUserTime as LARGE_INTEGER
	PerJobUserTimeLimit as LARGE_INTEGER
	JobMemory as DWORD64
	JobMemoryLimit as DWORD64
	RateControlTolerance as JOBOBJECT_RATE_CONTROL_TOLERANCE
	RateControlToleranceLimit as JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
end type

type JOBOBJECT_LIMIT_VIOLATION_INFORMATION as _JOBOBJECT_LIMIT_VIOLATION_INFORMATION
type PJOBOBJECT_LIMIT_VIOLATION_INFORMATION as _JOBOBJECT_LIMIT_VIOLATION_INFORMATION ptr

type _JOBOBJECT_CPU_RATE_CONTROL_INFORMATION
	ControlFlags as DWORD

	union
		CpuRate as DWORD
		Weight as DWORD
	end union
end type

type JOBOBJECT_CPU_RATE_CONTROL_INFORMATION as _JOBOBJECT_CPU_RATE_CONTROL_INFORMATION
type PJOBOBJECT_CPU_RATE_CONTROL_INFORMATION as _JOBOBJECT_CPU_RATE_CONTROL_INFORMATION ptr
const JOB_OBJECT_TERMINATE_AT_END_OF_JOB = 0
const JOB_OBJECT_POST_AT_END_OF_JOB = 1
const JOB_OBJECT_MSG_END_OF_JOB_TIME = 1
const JOB_OBJECT_MSG_END_OF_PROCESS_TIME = 2
const JOB_OBJECT_MSG_ACTIVE_PROCESS_LIMIT = 3
const JOB_OBJECT_MSG_ACTIVE_PROCESS_ZERO = 4
const JOB_OBJECT_MSG_NEW_PROCESS = 6
const JOB_OBJECT_MSG_EXIT_PROCESS = 7
const JOB_OBJECT_MSG_ABNORMAL_EXIT_PROCESS = 8
const JOB_OBJECT_MSG_PROCESS_MEMORY_LIMIT = 9
const JOB_OBJECT_MSG_JOB_MEMORY_LIMIT = 10
const JOB_OBJECT_MSG_NOTIFICATION_LIMIT = 11
const JOB_OBJECT_MSG_JOB_CYCLE_TIME_LIMIT = 12
const JOB_OBJECT_MSG_MINIMUM = 1
const JOB_OBJECT_MSG_MAXIMUM = 12
const JOB_OBJECT_LIMIT_WORKINGSET = &h00000001
const JOB_OBJECT_LIMIT_PROCESS_TIME = &h00000002
const JOB_OBJECT_LIMIT_JOB_TIME = &h00000004
const JOB_OBJECT_LIMIT_ACTIVE_PROCESS = &h00000008
const JOB_OBJECT_LIMIT_AFFINITY = &h00000010
const JOB_OBJECT_LIMIT_PRIORITY_CLASS = &h00000020
const JOB_OBJECT_LIMIT_PRESERVE_JOB_TIME = &h00000040
const JOB_OBJECT_LIMIT_SCHEDULING_CLASS = &h00000080
const JOB_OBJECT_LIMIT_PROCESS_MEMORY = &h00000100
const JOB_OBJECT_LIMIT_JOB_MEMORY = &h00000200
const JOB_OBJECT_LIMIT_DIE_ON_UNHANDLED_EXCEPTION = &h00000400
const JOB_OBJECT_LIMIT_BREAKAWAY_OK = &h00000800
const JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK = &h00001000
const JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = &h00002000
const JOB_OBJECT_LIMIT_SUBSET_AFFINITY = &h00004000
const JOB_OBJECT_LIMIT_RESERVED3 = &h00008000
const JOB_OBJECT_LIMIT_JOB_READ_BYTES = &h00010000
const JOB_OBJECT_LIMIT_JOB_WRITE_BYTES = &h00020000
const JOB_OBJECT_LIMIT_RATE_CONTROL = &h00040000
const JOB_OBJECT_LIMIT_RESERVED3 = &h00008000
const JOB_OBJECT_LIMIT_RESERVED4 = &h00010000
const JOB_OBJECT_LIMIT_RESERVED5 = &h00020000
const JOB_OBJECT_LIMIT_RESERVED6 = &h00040000
const JOB_OBJECT_LIMIT_VALID_FLAGS = &h0007ffff
const JOB_OBJECT_BASIC_LIMIT_VALID_FLAGS = &h000000ff
const JOB_OBJECT_EXTENDED_LIMIT_VALID_FLAGS = &h00007fff
const JOB_OBJECT_RESERVED_LIMIT_VALID_FLAGS = &h0007ffff
const JOB_OBJECT_NOTIFICATION_LIMIT_VALID_FLAGS = &h00070204
const JOB_OBJECT_UILIMIT_NONE = &h00000000
const JOB_OBJECT_UILIMIT_HANDLES = &h00000001
const JOB_OBJECT_UILIMIT_READCLIPBOARD = &h00000002
const JOB_OBJECT_UILIMIT_WRITECLIPBOARD = &h00000004
const JOB_OBJECT_UILIMIT_SYSTEMPARAMETERS = &h00000008
const JOB_OBJECT_UILIMIT_DISPLAYSETTINGS = &h00000010
const JOB_OBJECT_UILIMIT_GLOBALATOMS = &h00000020
const JOB_OBJECT_UILIMIT_DESKTOP = &h00000040
const JOB_OBJECT_UILIMIT_EXITWINDOWS = &h00000080
const JOB_OBJECT_UILIMIT_ALL = &h000000FF
const JOB_OBJECT_UI_VALID_FLAGS = &h000000FF
const JOB_OBJECT_SECURITY_NO_ADMIN = &h00000001
const JOB_OBJECT_SECURITY_RESTRICTED_TOKEN = &h00000002
const JOB_OBJECT_SECURITY_ONLY_TOKEN = &h00000004
const JOB_OBJECT_SECURITY_FILTER_TOKENS = &h00000008
const JOB_OBJECT_SECURITY_VALID_FLAGS = &h0000000f
const JOB_OBJECT_CPU_RATE_CONTROL_ENABLE = &h1
const JOB_OBJECT_CPU_RATE_CONTROL_WEIGHT_BASED = &h2
const JOB_OBJECT_CPU_RATE_CONTROL_HARD_CAP = &h4
const JOB_OBJECT_CPU_RATE_CONTROL_NOTIFY = &h8
const JOB_OBJECT_CPU_RATE_CONTROL_VALID_FLAGS = &hf

type _JOBOBJECTINFOCLASS as long
enum
	JobObjectBasicAccountingInformation = 1
	JobObjectBasicLimitInformation
	JobObjectBasicProcessIdList
	JobObjectBasicUIRestrictions
	JobObjectSecurityLimitInformation
	JobObjectEndOfJobTimeInformation
	JobObjectAssociateCompletionPortInformation
	JobObjectBasicAndIoAccountingInformation
	JobObjectExtendedLimitInformation
	JobObjectJobSetInformation
	JobObjectGroupInformation
	JobObjectNotificationLimitInformation
	JobObjectLimitViolationInformation
	JobObjectGroupInformationEx
	JobObjectCpuRateControlInformation
	JobObjectCompletionFilter
	JobObjectCompletionCounter
	JobObjectReserved1Information = 18
	JobObjectReserved2Information
	JobObjectReserved3Information
	JobObjectReserved4Information
	JobObjectReserved5Information
	JobObjectReserved6Information
	JobObjectReserved7Information
	JobObjectReserved8Information
	MaxJobObjectInfoClass
end enum

type JOBOBJECTINFOCLASS as _JOBOBJECTINFOCLASS

type _FIRMWARE_TYPE as long
enum
	FirmwareTypeUnknown
	FirmwareTypeBios
	FirmwareTypeUefi
	FirmwareTypeMax
end enum

type FIRMWARE_TYPE as _FIRMWARE_TYPE
type PFIRMWARE_TYPE as _FIRMWARE_TYPE ptr
const EVENT_MODIFY_STATE = &h0002
const EVENT_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h3
const MUTANT_QUERY_STATE = &h0001
const MUTANT_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or MUTANT_QUERY_STATE
const SEMAPHORE_MODIFY_STATE = &h0002
const SEMAPHORE_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h3
const TIMER_QUERY_STATE = &h0001
const TIMER_MODIFY_STATE = &h0002
const TIMER_ALL_ACCESS = ((STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or TIMER_QUERY_STATE) or TIMER_MODIFY_STATE
const TIME_ZONE_ID_UNKNOWN = 0
const TIME_ZONE_ID_STANDARD = 1
const TIME_ZONE_ID_DAYLIGHT = 2

type _LOGICAL_PROCESSOR_RELATIONSHIP as long
enum
	RelationProcessorCore
	RelationNumaNode
	RelationCache
	RelationProcessorPackage
	RelationGroup
	RelationAll = &hffff
end enum

type LOGICAL_PROCESSOR_RELATIONSHIP as _LOGICAL_PROCESSOR_RELATIONSHIP
const LTP_PC_SMT = &h1

type _PROCESSOR_CACHE_TYPE as long
enum
	CacheUnified
	CacheInstruction
	CacheData
	CacheTrace
end enum

type PROCESSOR_CACHE_TYPE as _PROCESSOR_CACHE_TYPE
const CACHE_FULLY_ASSOCIATIVE = &hFF

type _CACHE_DESCRIPTOR
	Level as UBYTE
	Associativity as UBYTE
	LineSize as WORD
	Size as DWORD
	as PROCESSOR_CACHE_TYPE Type
end type

type CACHE_DESCRIPTOR as _CACHE_DESCRIPTOR
type PCACHE_DESCRIPTOR as _CACHE_DESCRIPTOR ptr

type _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_ProcessorCore
	Flags as UBYTE
end type

type _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_NumaNode
	NodeNumber as DWORD
end type

type _SYSTEM_LOGICAL_PROCESSOR_INFORMATION
	ProcessorMask as ULONG_PTR
	Relationship as LOGICAL_PROCESSOR_RELATIONSHIP

	union
		ProcessorCore as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_ProcessorCore
		NumaNode as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_NumaNode
		Cache as CACHE_DESCRIPTOR
		Reserved(0 to 1) as ULONGLONG
	end union
end type

type SYSTEM_LOGICAL_PROCESSOR_INFORMATION as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION
type PSYSTEM_LOGICAL_PROCESSOR_INFORMATION as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION ptr

type _PROCESSOR_RELATIONSHIP
	Flags as UBYTE
	Reserved(0 to 20) as UBYTE
	GroupCount as WORD
	GroupMask(0 to 0) as GROUP_AFFINITY
end type

type PROCESSOR_RELATIONSHIP as _PROCESSOR_RELATIONSHIP
type PPROCESSOR_RELATIONSHIP as _PROCESSOR_RELATIONSHIP ptr

type _NUMA_NODE_RELATIONSHIP
	NodeNumber as DWORD
	Reserved(0 to 19) as UBYTE
	GroupMask as GROUP_AFFINITY
end type

type NUMA_NODE_RELATIONSHIP as _NUMA_NODE_RELATIONSHIP
type PNUMA_NODE_RELATIONSHIP as _NUMA_NODE_RELATIONSHIP ptr

type _CACHE_RELATIONSHIP
	Level as UBYTE
	Associativity as UBYTE
	LineSize as WORD
	CacheSize as DWORD
	as PROCESSOR_CACHE_TYPE Type
	Reserved(0 to 19) as UBYTE
	GroupMask as GROUP_AFFINITY
end type

type CACHE_RELATIONSHIP as _CACHE_RELATIONSHIP
type PCACHE_RELATIONSHIP as _CACHE_RELATIONSHIP ptr

type _PROCESSOR_GROUP_INFO
	MaximumProcessorCount as UBYTE
	ActiveProcessorCount as UBYTE
	Reserved(0 to 37) as UBYTE
	ActiveProcessorMask as KAFFINITY
end type

type PROCESSOR_GROUP_INFO as _PROCESSOR_GROUP_INFO
type PPROCESSOR_GROUP_INFO as _PROCESSOR_GROUP_INFO ptr

type _GROUP_RELATIONSHIP
	MaximumGroupCount as WORD
	ActiveGroupCount as WORD
	Reserved(0 to 19) as UBYTE
	GroupInfo(0 to 0) as PROCESSOR_GROUP_INFO
end type

type GROUP_RELATIONSHIP as _GROUP_RELATIONSHIP
type PGROUP_RELATIONSHIP as _GROUP_RELATIONSHIP ptr

type _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
	Relationship as LOGICAL_PROCESSOR_RELATIONSHIP
	Size as DWORD

	union
		Processor as PROCESSOR_RELATIONSHIP
		NumaNode as NUMA_NODE_RELATIONSHIP
		Cache as CACHE_RELATIONSHIP
		Group as GROUP_RELATIONSHIP
	end union
end type

type SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
type PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX as _SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX ptr

type _SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
	CycleTime as DWORD64
end type

type SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION as _SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
type PSYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION as _SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION ptr
const PROCESSOR_INTEL_386 = 386
const PROCESSOR_INTEL_486 = 486
const PROCESSOR_INTEL_PENTIUM = 586
const PROCESSOR_INTEL_IA64 = 2200
const PROCESSOR_AMD_X8664 = 8664
const PROCESSOR_MIPS_R4000 = 4000
const PROCESSOR_ALPHA_21064 = 21064
const PROCESSOR_PPC_601 = 601
const PROCESSOR_PPC_603 = 603
const PROCESSOR_PPC_604 = 604
const PROCESSOR_PPC_620 = 620
const PROCESSOR_HITACHI_SH3 = 10003
const PROCESSOR_HITACHI_SH3E = 10004
const PROCESSOR_HITACHI_SH4 = 10005
const PROCESSOR_MOTOROLA_821 = 821
const PROCESSOR_SHx_SH3 = 103
const PROCESSOR_SHx_SH4 = 104
const PROCESSOR_STRONGARM = 2577
const PROCESSOR_ARM720 = 1824
const PROCESSOR_ARM820 = 2080
const PROCESSOR_ARM920 = 2336
const PROCESSOR_ARM_7TDMI = 70001
const PROCESSOR_OPTIL = &h494f
const PROCESSOR_ARCHITECTURE_INTEL = 0
const PROCESSOR_ARCHITECTURE_MIPS = 1
const PROCESSOR_ARCHITECTURE_ALPHA = 2
const PROCESSOR_ARCHITECTURE_PPC = 3
const PROCESSOR_ARCHITECTURE_SHX = 4
const PROCESSOR_ARCHITECTURE_ARM = 5
const PROCESSOR_ARCHITECTURE_IA64 = 6
const PROCESSOR_ARCHITECTURE_ALPHA64 = 7
const PROCESSOR_ARCHITECTURE_MSIL = 8
const PROCESSOR_ARCHITECTURE_AMD64 = 9
const PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 = 10
const PROCESSOR_ARCHITECTURE_NEUTRAL = 11
const PROCESSOR_ARCHITECTURE_UNKNOWN = &hffff
const PF_FLOATING_POINT_PRECISION_ERRATA = 0
const PF_FLOATING_POINT_EMULATED = 1
const PF_COMPARE_EXCHANGE_DOUBLE = 2
const PF_MMX_INSTRUCTIONS_AVAILABLE = 3
const PF_PPC_MOVEMEM_64BIT_OK = 4
const PF_ALPHA_BYTE_INSTRUCTIONS = 5
const PF_XMMI_INSTRUCTIONS_AVAILABLE = 6
const PF_3DNOW_INSTRUCTIONS_AVAILABLE = 7
const PF_RDTSC_INSTRUCTION_AVAILABLE = 8
const PF_PAE_ENABLED = 9
const PF_XMMI64_INSTRUCTIONS_AVAILABLE = 10
const PF_SSE_DAZ_MODE_AVAILABLE = 11
const PF_NX_ENABLED = 12
const PF_SSE3_INSTRUCTIONS_AVAILABLE = 13
const PF_COMPARE_EXCHANGE128 = 14
const PF_COMPARE64_EXCHANGE128 = 15
const PF_CHANNELS_ENABLED = 16
const PF_XSAVE_ENABLED = 17
const PF_ARM_VFP_32_REGISTERS_AVAILABLE = 18
const PF_ARM_NEON_INSTRUCTIONS_AVAILABLE = 19
const PF_SECOND_LEVEL_ADDRESS_TRANSLATION = 20
const PF_VIRT_FIRMWARE_ENABLED = 21
const PF_RDWRFSGSBASE_AVAILABLE = 22
const PF_FASTFAIL_AVAILABLE = 23
const PF_ARM_DIVIDE_INSTRUCTION_AVAILABLE = 24
const PF_ARM_64BIT_LOADSTORE_ATOMIC = 25
const PF_ARM_EXTERNAL_CACHE_AVAILABLE = 26
const PF_ARM_FMAC_INSTRUCTIONS_AVAILABLE = 27
const XSTATE_LEGACY_FLOATING_POINT = 0
const XSTATE_LEGACY_SSE = 1
const XSTATE_GSSE = 2
const XSTATE_AVX = XSTATE_GSSE
const XSTATE_MASK_LEGACY_FLOATING_POINT = 1ull shl XSTATE_LEGACY_FLOATING_POINT
const XSTATE_MASK_LEGACY_SSE = 1ull shl XSTATE_LEGACY_SSE
const XSTATE_MASK_LEGACY = XSTATE_MASK_LEGACY_FLOATING_POINT or XSTATE_MASK_LEGACY_SSE
const XSTATE_MASK_GSSE = 1ull shl XSTATE_GSSE
const XSTATE_MASK_AVX = XSTATE_MASK_GSSE
const MAXIMUM_XSTATE_FEATURES = 64

type _XSTATE_FEATURE
	Offset as DWORD
	Size as DWORD
end type

type XSTATE_FEATURE as _XSTATE_FEATURE
type PXSTATE_FEATURE as _XSTATE_FEATURE ptr

type _XSTATE_CONFIGURATION
	EnabledFeatures as DWORD64
	EnabledVolatileFeatures as DWORD64
	Size as DWORD
	OptimizedSave : 1 as DWORD
	Features(0 to 63) as XSTATE_FEATURE
end type

type XSTATE_CONFIGURATION as _XSTATE_CONFIGURATION
type PXSTATE_CONFIGURATION as _XSTATE_CONFIGURATION ptr

type _MEMORY_BASIC_INFORMATION
	BaseAddress as PVOID
	AllocationBase as PVOID
	AllocationProtect as DWORD
	RegionSize as SIZE_T_
	State as DWORD
	Protect as DWORD
	as DWORD Type
end type

type MEMORY_BASIC_INFORMATION as _MEMORY_BASIC_INFORMATION
type PMEMORY_BASIC_INFORMATION as _MEMORY_BASIC_INFORMATION ptr

type _MEMORY_BASIC_INFORMATION32
	BaseAddress as DWORD
	AllocationBase as DWORD
	AllocationProtect as DWORD
	RegionSize as DWORD
	State as DWORD
	Protect as DWORD
	as DWORD Type
end type

type MEMORY_BASIC_INFORMATION32 as _MEMORY_BASIC_INFORMATION32
type PMEMORY_BASIC_INFORMATION32 as _MEMORY_BASIC_INFORMATION32 ptr

type _MEMORY_BASIC_INFORMATION64
	BaseAddress as ULONGLONG
	AllocationBase as ULONGLONG
	AllocationProtect as DWORD
	__alignment1 as DWORD
	RegionSize as ULONGLONG
	State as DWORD
	Protect as DWORD
	as DWORD Type
	__alignment2 as DWORD
end type

type MEMORY_BASIC_INFORMATION64 as _MEMORY_BASIC_INFORMATION64
type PMEMORY_BASIC_INFORMATION64 as _MEMORY_BASIC_INFORMATION64 ptr
const SECTION_QUERY = &h0001
const SECTION_MAP_WRITE = &h0002
const SECTION_MAP_READ = &h0004
const SECTION_MAP_EXECUTE = &h0008
const SECTION_EXTEND_SIZE = &h0010
const SECTION_MAP_EXECUTE_EXPLICIT = &h0020
const SECTION_ALL_ACCESS = ((((STANDARD_RIGHTS_REQUIRED or SECTION_QUERY) or SECTION_MAP_WRITE) or SECTION_MAP_READ) or SECTION_MAP_EXECUTE) or SECTION_EXTEND_SIZE
const SESSION_QUERY_ACCESS = &h1
const SESSION_MODIFY_ACCESS = &h2
const SESSION_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SESSION_QUERY_ACCESS) or SESSION_MODIFY_ACCESS
const PAGE_NOACCESS = &h01
const PAGE_READONLY = &h02
const PAGE_READWRITE = &h04
const PAGE_WRITECOPY = &h08
const PAGE_EXECUTE = &h10
const PAGE_EXECUTE_READ = &h20
const PAGE_EXECUTE_READWRITE = &h40
const PAGE_EXECUTE_WRITECOPY = &h80
const PAGE_GUARD = &h100
const PAGE_NOCACHE = &h200
const PAGE_WRITECOMBINE = &h400
const MEM_COMMIT = &h1000
const MEM_RESERVE = &h2000
const MEM_DECOMMIT = &h4000
const MEM_RELEASE = &h8000
const MEM_FREE = &h10000
const MEM_PRIVATE = &h20000
const MEM_MAPPED = &h40000
const MEM_RESET = &h80000
const MEM_TOP_DOWN = &h100000
const MEM_WRITE_WATCH = &h200000
const MEM_PHYSICAL = &h400000
const MEM_ROTATE = &h800000
const MEM_LARGE_PAGES = &h20000000
const MEM_4MB_PAGES = &h80000000
const SEC_FILE = &h800000
const SEC_IMAGE = &h1000000
const SEC_PROTECTED_IMAGE = &h2000000
const SEC_RESERVE = &h4000000
const SEC_COMMIT = &h8000000
const SEC_NOCACHE = &h10000000
const SEC_WRITECOMBINE = &h40000000
const SEC_LARGE_PAGES = &h80000000
const SEC_IMAGE_NO_EXECUTE = SEC_IMAGE or SEC_NOCACHE
const MEM_IMAGE = SEC_IMAGE
const WRITE_WATCH_FLAG_RESET = &h01
const MEM_UNMAP_WITH_TRANSIENT_BOOST = &h01
const FILE_READ_DATA = &h0001
const FILE_LIST_DIRECTORY = &h0001
const FILE_WRITE_DATA = &h0002
const FILE_ADD_FILE = &h0002
const FILE_APPEND_DATA = &h0004
const FILE_ADD_SUBDIRECTORY = &h0004
const FILE_CREATE_PIPE_INSTANCE = &h0004
const FILE_READ_EA = &h0008
const FILE_WRITE_EA = &h0010
const FILE_EXECUTE = &h0020
const FILE_TRAVERSE = &h0020
const FILE_DELETE_CHILD = &h0040
const FILE_READ_ATTRIBUTES = &h0080
const FILE_WRITE_ATTRIBUTES = &h0100
const FILE_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h1FF
const FILE_GENERIC_READ = (((STANDARD_RIGHTS_READ or FILE_READ_DATA) or FILE_READ_ATTRIBUTES) or FILE_READ_EA) or SYNCHRONIZE
const FILE_GENERIC_WRITE = ((((STANDARD_RIGHTS_WRITE or FILE_WRITE_DATA) or FILE_WRITE_ATTRIBUTES) or FILE_WRITE_EA) or FILE_APPEND_DATA) or SYNCHRONIZE
const FILE_GENERIC_EXECUTE = ((STANDARD_RIGHTS_EXECUTE or FILE_READ_ATTRIBUTES) or FILE_EXECUTE) or SYNCHRONIZE
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
const FILE_SHARE_READ = &h00000001
const FILE_SHARE_WRITE = &h00000002
const FILE_SHARE_DELETE = &h00000004
const FILE_SHARE_VALID_FLAGS = &h00000007
const FILE_ATTRIBUTE_READONLY = &h00000001
const FILE_ATTRIBUTE_HIDDEN = &h00000002
const FILE_ATTRIBUTE_SYSTEM = &h00000004
const FILE_ATTRIBUTE_DIRECTORY = &h00000010
const FILE_ATTRIBUTE_ARCHIVE = &h00000020
const FILE_ATTRIBUTE_DEVICE = &h00000040
const FILE_ATTRIBUTE_NORMAL = &h00000080
const FILE_ATTRIBUTE_TEMPORARY = &h00000100
const FILE_ATTRIBUTE_SPARSE_FILE = &h00000200
const FILE_ATTRIBUTE_REPARSE_POINT = &h00000400
const FILE_ATTRIBUTE_COMPRESSED = &h00000800
const FILE_ATTRIBUTE_OFFLINE = &h00001000
const FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = &h00002000
const FILE_ATTRIBUTE_ENCRYPTED = &h00004000
const FILE_ATTRIBUTE_VIRTUAL = &h00010000
const FILE_NOTIFY_CHANGE_FILE_NAME = &h00000001
const FILE_NOTIFY_CHANGE_DIR_NAME = &h00000002
const FILE_NOTIFY_CHANGE_ATTRIBUTES = &h00000004
const FILE_NOTIFY_CHANGE_SIZE = &h00000008
const FILE_NOTIFY_CHANGE_LAST_WRITE = &h00000010
const FILE_NOTIFY_CHANGE_LAST_ACCESS = &h00000020
const FILE_NOTIFY_CHANGE_CREATION = &h00000040
const FILE_NOTIFY_CHANGE_SECURITY = &h00000100
const FILE_ACTION_ADDED = &h00000001
const FILE_ACTION_REMOVED = &h00000002
const FILE_ACTION_MODIFIED = &h00000003
const FILE_ACTION_RENAMED_OLD_NAME = &h00000004
const FILE_ACTION_RENAMED_NEW_NAME = &h00000005
const MAILSLOT_NO_MESSAGE = cast(DWORD, -1)
const MAILSLOT_WAIT_FOREVER = cast(DWORD, -1)
const FILE_CASE_SENSITIVE_SEARCH = &h00000001
const FILE_CASE_PRESERVED_NAMES = &h00000002
const FILE_UNICODE_ON_DISK = &h00000004
const FILE_PERSISTENT_ACLS = &h00000008
const FILE_FILE_COMPRESSION = &h00000010
const FILE_VOLUME_QUOTAS = &h00000020
const FILE_SUPPORTS_SPARSE_FILES = &h00000040
const FILE_SUPPORTS_REPARSE_POINTS = &h00000080
const FILE_SUPPORTS_REMOTE_STORAGE = &h00000100
const FILE_VOLUME_IS_COMPRESSED = &h00008000
const FILE_SUPPORTS_OBJECT_IDS = &h00010000
const FILE_SUPPORTS_ENCRYPTION = &h00020000
const FILE_NAMED_STREAMS = &h00040000
const FILE_READ_ONLY_VOLUME = &h00080000
const FILE_SEQUENTIAL_WRITE_ONCE = &h00100000
const FILE_SUPPORTS_TRANSACTIONS = &h00200000
const FILE_SUPPORTS_HARD_LINKS = &h00400000
const FILE_SUPPORTS_EXTENDED_ATTRIBUTES = &h00800000
const FILE_SUPPORTS_OPEN_BY_FILE_ID = &h01000000
const FILE_SUPPORTS_USN_JOURNAL = &h02000000
const FILE_SUPPORTS_INTEGRITY_STREAMS = &h04000000

type FILE_ID_128
	LowPart as ULONGLONG
	HighPart as ULONGLONG
end type

type PFILE_ID_128 as FILE_ID_128 ptr

type _FILE_NOTIFY_INFORMATION
	NextEntryOffset as DWORD
	Action as DWORD
	FileNameLength as DWORD
	FileName as wstring * 1
end type

type FILE_NOTIFY_INFORMATION as _FILE_NOTIFY_INFORMATION
type PFILE_NOTIFY_INFORMATION as _FILE_NOTIFY_INFORMATION ptr

union _FILE_SEGMENT_ELEMENT
	Buffer as PVOID64
	Alignment as ULONGLONG
end union

type FILE_SEGMENT_ELEMENT as _FILE_SEGMENT_ELEMENT
type PFILE_SEGMENT_ELEMENT as _FILE_SEGMENT_ELEMENT ptr

type _REPARSE_GUID_DATA_BUFFER_GenericReparseBuffer
	DataBuffer(0 to 0) as UBYTE
end type

type _REPARSE_GUID_DATA_BUFFER
	ReparseTag as DWORD
	ReparseDataLength as WORD
	Reserved as WORD
	ReparseGuid as GUID
	GenericReparseBuffer as _REPARSE_GUID_DATA_BUFFER_GenericReparseBuffer
end type

type REPARSE_GUID_DATA_BUFFER as _REPARSE_GUID_DATA_BUFFER
type PREPARSE_GUID_DATA_BUFFER as _REPARSE_GUID_DATA_BUFFER ptr
#define REPARSE_GUID_DATA_BUFFER_HEADER_SIZE FIELD_OFFSET(REPARSE_GUID_DATA_BUFFER, GenericReparseBuffer)
const MAXIMUM_REPARSE_DATA_BUFFER_SIZE = 16 * 1024
const SYMLINK_FLAG_RELATIVE = 1
const IO_REPARSE_TAG_RESERVED_ZERO = 0
const IO_REPARSE_TAG_RESERVED_ONE = 1
const IO_REPARSE_TAG_RESERVED_RANGE = IO_REPARSE_TAG_RESERVED_ONE
#define IsReparseTagMicrosoft(_tag) ((_tag) and &h80000000)
#define IsReparseTagNameSurrogate(_tag) ((_tag) and &h20000000)
const IO_REPARSE_TAG_MOUNT_POINT = &hA0000003
const IO_REPARSE_TAG_HSM = &hC0000004
const IO_REPARSE_TAG_HSM2 = &h80000006
const IO_REPARSE_TAG_SIS = &h80000007
const IO_REPARSE_TAG_WIM = &h80000008
const IO_REPARSE_TAG_CSV = &h80000009
const IO_REPARSE_TAG_DFS = &h8000000A
const IO_REPARSE_TAG_FILTER_MANAGER = &h8000000B
const IO_REPARSE_TAG_DFSR = &h80000012
const IO_REPARSE_TAG_SYMLINK = &hA000000C
const IO_REPARSE_TAG_IIS_CACHE = &hA0000010
const IO_REPARSE_TAG_DRIVE_EXTENDER = &h80000005
const IO_REPARSE_TAG_DEDUP = &h80000013
const IO_REPARSE_TAG_NFS = &h80000014

#if _WIN32_WINNT = &h0602
	const SCRUB_DATA_INPUT_FLAG_RESUME = &h00000001
	const SCRUB_DATA_INPUT_FLAG_SKIP_IN_SYNC = &h00000002
	const SCRUB_DATA_INPUT_FLAG_SKIP_NON_INTEGRITY_DATA = &h00000004
	const SCRUB_DATA_OUTPUT_FLAG_INCOMPLETE = &h00000001
	const SCRUB_DATA_OUTPUT_FLAG_NON_USER_DATA_RANGE = &h00010000

	type _SCRUB_DATA_INPUT
		Size as DWORD
		Flags as DWORD
		MaximumIos as DWORD
		Reserved(0 to 16) as DWORD
		ResumeContext(0 to 815) as UBYTE
	end type

	type SCRUB_DATA_INPUT as _SCRUB_DATA_INPUT
	type PSCRUB_DATA_INPUT as _SCRUB_DATA_INPUT ptr

	type _SCRUB_DATA_OUTPUT
		Size as DWORD
		Flags as DWORD
		Status as DWORD
		ErrorFileOffset as ULONGLONG
		ErrorLength as ULONGLONG
		NumberOfBytesRepaired as ULONGLONG
		NumberOfBytesFailed as ULONGLONG
		InternalFileReference as ULONGLONG
		Reserved(0 to 5) as DWORD
		ResumeContext(0 to 815) as UBYTE
	end type

	type SCRUB_DATA_OUTPUT as _SCRUB_DATA_OUTPUT
	type PSCRUB_DATA_OUTPUT as _SCRUB_DATA_OUTPUT ptr
#endif

const IO_COMPLETION_MODIFY_STATE = &h0002
const IO_COMPLETION_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE) or &h3
const DUPLICATE_CLOSE_SOURCE = &h00000001
const DUPLICATE_SAME_ACCESS = &h00000002
const POWERBUTTON_ACTION_INDEX_NOTHING = 0
const POWERBUTTON_ACTION_INDEX_SLEEP = 1
const POWERBUTTON_ACTION_INDEX_HIBERNATE = 2
const POWERBUTTON_ACTION_INDEX_SHUTDOWN = 3
const POWERBUTTON_ACTION_VALUE_NOTHING = 0
const POWERBUTTON_ACTION_VALUE_SLEEP = 2
const POWERBUTTON_ACTION_VALUE_HIBERNATE = 3
const POWERBUTTON_ACTION_VALUE_SHUTDOWN = 6
const PERFSTATE_POLICY_CHANGE_IDEAL = 0
const PERFSTATE_POLICY_CHANGE_SINGLE = 1
const PERFSTATE_POLICY_CHANGE_ROCKET = 2
const PERFSTATE_POLICY_CHANGE_MAX = PERFSTATE_POLICY_CHANGE_ROCKET
const PROCESSOR_PERF_BOOST_POLICY_DISABLED = 0
const PROCESSOR_PERF_BOOST_POLICY_MAX = 100
const PROCESSOR_PERF_BOOST_MODE_DISABLED = 0
const PROCESSOR_PERF_BOOST_MODE_ENABLED = 1
const PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE = 2
const PROCESSOR_PERF_BOOST_MODE_EFFICIENT_ENABLED = 3
const PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE = 4
const PROCESSOR_PERF_BOOST_MODE_MAX = PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE
const CORE_PARKING_POLICY_CHANGE_IDEAL = 0
const CORE_PARKING_POLICY_CHANGE_SINGLE = 1
const CORE_PARKING_POLICY_CHANGE_ROCKET = 2
const CORE_PARKING_POLICY_CHANGE_MULTISTEP = 3
const CORE_PARKING_POLICY_CHANGE_MAX = CORE_PARKING_POLICY_CHANGE_MULTISTEP
const POWER_DEVICE_IDLE_POLICY_PERFORMANCE = 0
const POWER_DEVICE_IDLE_POLICY_CONSERVATIVE = 1

extern GUID_MAX_POWER_SAVINGS as const GUID
extern GUID_MIN_POWER_SAVINGS as const GUID
extern GUID_TYPICAL_POWER_SAVINGS as const GUID
extern NO_SUBGROUP_GUID as const GUID
extern ALL_POWERSCHEMES_GUID as const GUID
extern GUID_POWERSCHEME_PERSONALITY as const GUID
extern GUID_ACTIVE_POWERSCHEME as const GUID
extern GUID_IDLE_RESILIENCY_SUBGROUP as const GUID
extern GUID_IDLE_RESILIENCY_PERIOD as const GUID
extern GUID_DISK_COALESCING_POWERDOWN_TIMEOUT as const GUID
extern GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT as const GUID
extern GUID_VIDEO_SUBGROUP as const GUID
extern GUID_VIDEO_POWERDOWN_TIMEOUT as const GUID
extern GUID_VIDEO_ANNOYANCE_TIMEOUT as const GUID
extern GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE as const GUID
extern GUID_VIDEO_DIM_TIMEOUT as const GUID
extern GUID_VIDEO_ADAPTIVE_POWERDOWN as const GUID
extern GUID_MONITOR_POWER_ON as const GUID
extern GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS as const GUID
extern GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS as const GUID
extern GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS as const GUID
extern GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS as const GUID
extern GUID_CONSOLE_DISPLAY_STATE as const GUID
extern GUID_ALLOW_DISPLAY_REQUIRED as const GUID
extern GUID_VIDEO_CONSOLE_LOCK_TIMEOUT as const GUID
extern GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP as const GUID
extern GUID_NON_ADAPTIVE_INPUT_TIMEOUT as const GUID
extern GUID_DISK_SUBGROUP as const GUID
extern GUID_DISK_POWERDOWN_TIMEOUT as const GUID
extern GUID_DISK_IDLE_TIMEOUT as const GUID
extern GUID_DISK_BURST_IGNORE_THRESHOLD as const GUID
extern GUID_DISK_ADAPTIVE_POWERDOWN as const GUID
extern GUID_SLEEP_SUBGROUP as const GUID
extern GUID_SLEEP_IDLE_THRESHOLD as const GUID
extern GUID_STANDBY_TIMEOUT as const GUID
extern GUID_UNATTEND_SLEEP_TIMEOUT as const GUID
extern GUID_HIBERNATE_TIMEOUT as const GUID
extern GUID_HIBERNATE_FASTS4_POLICY as const GUID
extern GUID_CRITICAL_POWER_TRANSITION as const GUID
extern GUID_SYSTEM_AWAYMODE as const GUID
extern GUID_ALLOW_AWAYMODE as const GUID
extern GUID_ALLOW_STANDBY_STATES as const GUID
extern GUID_ALLOW_RTC_WAKE as const GUID
extern GUID_ALLOW_SYSTEM_REQUIRED as const GUID
extern GUID_SYSTEM_BUTTON_SUBGROUP as const GUID
extern GUID_POWERBUTTON_ACTION as const GUID
extern GUID_SLEEPBUTTON_ACTION as const GUID
extern GUID_USERINTERFACEBUTTON_ACTION as const GUID
extern GUID_LIDCLOSE_ACTION as const GUID
extern GUID_LIDOPEN_POWERSTATE as const GUID
extern GUID_BATTERY_SUBGROUP as const GUID
extern GUID_BATTERY_DISCHARGE_ACTION_0 as const GUID
extern GUID_BATTERY_DISCHARGE_LEVEL_0 as const GUID
extern GUID_BATTERY_DISCHARGE_FLAGS_0 as const GUID
extern GUID_BATTERY_DISCHARGE_ACTION_1 as const GUID
extern GUID_BATTERY_DISCHARGE_LEVEL_1 as const GUID
extern GUID_BATTERY_DISCHARGE_FLAGS_1 as const GUID
extern GUID_BATTERY_DISCHARGE_ACTION_2 as const GUID
extern GUID_BATTERY_DISCHARGE_LEVEL_2 as const GUID
extern GUID_BATTERY_DISCHARGE_FLAGS_2 as const GUID
extern GUID_BATTERY_DISCHARGE_ACTION_3 as const GUID
extern GUID_BATTERY_DISCHARGE_LEVEL_3 as const GUID
extern GUID_BATTERY_DISCHARGE_FLAGS_3 as const GUID
extern GUID_PROCESSOR_SETTINGS_SUBGROUP as const GUID
extern GUID_PROCESSOR_THROTTLE_POLICY as const GUID
extern GUID_PROCESSOR_THROTTLE_MAXIMUM as const GUID
extern GUID_PROCESSOR_THROTTLE_MINIMUM as const GUID
extern GUID_PROCESSOR_ALLOW_THROTTLING as const GUID
extern GUID_PROCESSOR_IDLESTATE_POLICY as const GUID
extern GUID_PROCESSOR_PERFSTATE_POLICY as const GUID
extern GUID_PROCESSOR_PERF_INCREASE_THRESHOLD as const GUID
extern GUID_PROCESSOR_PERF_DECREASE_THRESHOLD as const GUID
extern GUID_PROCESSOR_PERF_INCREASE_POLICY as const GUID
extern GUID_PROCESSOR_PERF_DECREASE_POLICY as const GUID
extern GUID_PROCESSOR_PERF_INCREASE_TIME as const GUID
extern GUID_PROCESSOR_PERF_DECREASE_TIME as const GUID
extern GUID_PROCESSOR_PERF_TIME_CHECK as const GUID
extern GUID_PROCESSOR_PERF_BOOST_POLICY as const GUID
extern GUID_PROCESSOR_PERF_BOOST_MODE as const GUID
extern GUID_PROCESSOR_IDLE_ALLOW_SCALING as const GUID
extern GUID_PROCESSOR_IDLE_DISABLE as const GUID
extern GUID_PROCESSOR_IDLE_STATE_MAXIMUM as const GUID
extern GUID_PROCESSOR_IDLE_TIME_CHECK as const GUID
extern GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD as const GUID
extern GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD as const GUID
extern GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD as const GUID
extern GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD as const GUID
extern GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY as const GUID
extern GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY as const GUID
extern GUID_PROCESSOR_CORE_PARKING_MAX_CORES as const GUID
extern GUID_PROCESSOR_CORE_PARKING_MIN_CORES as const GUID
extern GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME as const GUID
extern GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME as const GUID
extern GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR as const GUID
extern GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD as const GUID
extern GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING as const GUID
extern GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR as const GUID
extern GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD as const GUID
extern GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING as const GUID
extern GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD as const GUID
extern GUID_PROCESSOR_PARKING_CORE_OVERRIDE as const GUID
extern GUID_PROCESSOR_PARKING_PERF_STATE as const GUID
extern GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD as const GUID
extern GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD as const GUID
extern GUID_PROCESSOR_PERF_HISTORY as const GUID
extern GUID_PROCESSOR_PERF_LATENCY_HINT as const GUID
extern GUID_PROCESSOR_DISTRIBUTE_UTILITY as const GUID
extern GUID_SYSTEM_COOLING_POLICY as const GUID
extern GUID_LOCK_CONSOLE_ON_WAKE as const GUID
extern GUID_DEVICE_IDLE_POLICY as const GUID
extern GUID_ACDC_POWER_SOURCE as const GUID
extern GUID_LIDSWITCH_STATE_CHANGE as const GUID
extern GUID_BATTERY_PERCENTAGE_REMAINING as const GUID
extern GUID_GLOBAL_USER_PRESENCE as const GUID
extern GUID_SESSION_DISPLAY_STATUS as const GUID
extern GUID_SESSION_USER_PRESENCE as const GUID
extern GUID_IDLE_BACKGROUND_TASK as const GUID
extern GUID_BACKGROUND_TASK_NOTIFICATION as const GUID
extern GUID_APPLAUNCH_BUTTON as const GUID
extern GUID_PCIEXPRESS_SETTINGS_SUBGROUP as const GUID
extern GUID_PCIEXPRESS_ASPM_POLICY as const GUID
extern GUID_ENABLE_SWITCH_FORCED_SHUTDOWN as const GUID

type _SYSTEM_POWER_STATE as long
enum
	PowerSystemUnspecified = 0
	PowerSystemWorking = 1
	PowerSystemSleeping1 = 2
	PowerSystemSleeping2 = 3
	PowerSystemSleeping3 = 4
	PowerSystemHibernate = 5
	PowerSystemShutdown = 6
	PowerSystemMaximum = 7
end enum

type SYSTEM_POWER_STATE as _SYSTEM_POWER_STATE
type PSYSTEM_POWER_STATE as _SYSTEM_POWER_STATE ptr
const POWER_SYSTEM_MAXIMUM = 7

type POWER_ACTION as long
enum
	PowerActionNone = 0
	PowerActionReserved
	PowerActionSleep
	PowerActionHibernate
	PowerActionShutdown
	PowerActionShutdownReset
	PowerActionShutdownOff
	PowerActionWarmEject
end enum

type PPOWER_ACTION as POWER_ACTION ptr

type _DEVICE_POWER_STATE as long
enum
	PowerDeviceUnspecified = 0
	PowerDeviceD0
	PowerDeviceD1
	PowerDeviceD2
	PowerDeviceD3
	PowerDeviceMaximum
end enum

type DEVICE_POWER_STATE as _DEVICE_POWER_STATE
type PDEVICE_POWER_STATE as _DEVICE_POWER_STATE ptr

type _MONITOR_DISPLAY_STATE as long
enum
	PowerMonitorOff = 0
	PowerMonitorOn
	PowerMonitorDim
end enum

type MONITOR_DISPLAY_STATE as _MONITOR_DISPLAY_STATE
type PMONITOR_DISPLAY_STATE as _MONITOR_DISPLAY_STATE ptr

type _USER_ACTIVITY_PRESENCE as long
enum
	PowerUserPresent = 0
	PowerUserNotPresent
	PowerUserInactive
	PowerUserMaximum
	PowerUserInvalid = PowerUserMaximum
end enum

type USER_ACTIVITY_PRESENCE as _USER_ACTIVITY_PRESENCE
type PUSER_ACTIVITY_PRESENCE as _USER_ACTIVITY_PRESENCE ptr
const ES_SYSTEM_REQUIRED = cast(DWORD, &h00000001)
const ES_DISPLAY_REQUIRED = cast(DWORD, &h00000002)
const ES_USER_PRESENT = cast(DWORD, &h00000004)
const ES_AWAYMODE_REQUIRED = cast(DWORD, &h00000040)
const ES_CONTINUOUS = cast(DWORD, &h80000000)
type EXECUTION_STATE as DWORD
type PEXECUTION_STATE as DWORD ptr

type LATENCY_TIME as long
enum
	LT_DONT_CARE
	LT_LOWEST_LATENCY
end enum

const DIAGNOSTIC_REASON_VERSION = 0
const POWER_REQUEST_CONTEXT_VERSION = 0
const DIAGNOSTIC_REASON_SIMPLE_STRING = &h00000001
const DIAGNOSTIC_REASON_DETAILED_STRING = &h00000002
const DIAGNOSTIC_REASON_NOT_SPECIFIED = &h80000000
const DIAGNOSTIC_REASON_INVALID_FLAGS = not &h80000003
const POWER_REQUEST_CONTEXT_SIMPLE_STRING = &h00000001
const POWER_REQUEST_CONTEXT_DETAILED_STRING = &h00000002

type _POWER_REQUEST_TYPE as long
enum
	PowerRequestDisplayRequired
	PowerRequestSystemRequired
	PowerRequestAwayModeRequired
	PowerRequestExecutionRequired
end enum

type POWER_REQUEST_TYPE as _POWER_REQUEST_TYPE
type PPOWER_REQUEST_TYPE as _POWER_REQUEST_TYPE ptr
const PDCAP_D0_SUPPORTED = &h00000001
const PDCAP_D1_SUPPORTED = &h00000002
const PDCAP_D2_SUPPORTED = &h00000004
const PDCAP_D3_SUPPORTED = &h00000008
const PDCAP_WAKE_FROM_D0_SUPPORTED = &h00000010
const PDCAP_WAKE_FROM_D1_SUPPORTED = &h00000020
const PDCAP_WAKE_FROM_D2_SUPPORTED = &h00000040
const PDCAP_WAKE_FROM_D3_SUPPORTED = &h00000080
const PDCAP_WARM_EJECT_SUPPORTED = &h00000100

type CM_Power_Data_s
	PD_Size as DWORD
	PD_MostRecentPowerState as DEVICE_POWER_STATE
	PD_Capabilities as DWORD
	PD_D1Latency as DWORD
	PD_D2Latency as DWORD
	PD_D3Latency as DWORD
	PD_PowerStateMapping(0 to 6) as DEVICE_POWER_STATE
	PD_DeepestSystemWake as SYSTEM_POWER_STATE
end type

type CM_POWER_DATA as CM_Power_Data_s
type PCM_POWER_DATA as CM_Power_Data_s ptr

type POWER_INFORMATION_LEVEL as long
enum
	SystemPowerPolicyAc
	SystemPowerPolicyDc
	VerifySystemPolicyAc
	VerifySystemPolicyDc
	SystemPowerCapabilities
	SystemBatteryState
	SystemPowerStateHandler
	ProcessorStateHandler
	SystemPowerPolicyCurrent
	AdministratorPowerPolicy
	SystemReserveHiberFile
	ProcessorInformation
	SystemPowerInformation
	ProcessorStateHandler2
	LastWakeTime
	LastSleepTime
	SystemExecutionState
	SystemPowerStateNotifyHandler
	ProcessorPowerPolicyAc
	ProcessorPowerPolicyDc
	VerifyProcessorPowerPolicyAc
	VerifyProcessorPowerPolicyDc
	ProcessorPowerPolicyCurrent
	SystemPowerStateLogging
	SystemPowerLoggingEntry
	SetPowerSettingValue
	NotifyUserPowerSetting
	PowerInformationLevelUnused0
	SystemMonitorHiberBootPowerOff
	SystemVideoState
	TraceApplicationPowerMessage
	TraceApplicationPowerMessageEnd
	ProcessorPerfStates
	ProcessorIdleStates
	ProcessorCap
	SystemWakeSource
	SystemHiberFileInformation
	TraceServicePowerMessage
	ProcessorLoad
	PowerShutdownNotification
	MonitorCapabilities
	SessionPowerInit
	SessionDisplayState
	PowerRequestCreate
	PowerRequestAction
	GetPowerRequestList
	ProcessorInformationEx
	NotifyUserModeLegacyPowerEvent
	GroupPark
	ProcessorIdleDomains
	WakeTimerList
	SystemHiberFileSize
	ProcessorIdleStatesHv
	ProcessorPerfStatesHv
	ProcessorPerfCapHv
	ProcessorSetIdle
	LogicalProcessorIdling
	UserPresence
	PowerSettingNotificationName
	GetPowerSettingValue
	IdleResiliency
	SessionRITState
	SessionConnectNotification
	SessionPowerCleanup
	SessionLockState
	SystemHiberbootState
	PlatformInformation
	PdcInvocation
	MonitorInvocation
	FirmwareTableInformationRegistered
	SetShutdownSelectedTime
	SuspendResumeInvocation
	PlmPowerRequestCreate
	ScreenOff
	CsDeviceNotification
	PlatformRole
	LastResumePerformance
	DisplayBurst
	ExitLatencySamplingPercentage
	ApplyLowPowerScenarioSettings
	PowerInformationLevelMaximum
end enum

type POWER_USER_PRESENCE_TYPE as long
enum
	UserNotPresent = 0
	UserPresent = 1
	UserUnknown = &hff
end enum

type PPOWER_USER_PRESENCE_TYPE as POWER_USER_PRESENCE_TYPE ptr

type _POWER_USER_PRESENCE
	UserPresence as POWER_USER_PRESENCE_TYPE
end type

type POWER_USER_PRESENCE as _POWER_USER_PRESENCE
type PPOWER_USER_PRESENCE as _POWER_USER_PRESENCE ptr

type _POWER_SESSION_CONNECT
	Connected as WINBOOLEAN
	Console as WINBOOLEAN
end type

type POWER_SESSION_CONNECT as _POWER_SESSION_CONNECT
type PPOWER_SESSION_CONNECT as _POWER_SESSION_CONNECT ptr

type _POWER_SESSION_TIMEOUTS
	InputTimeout as DWORD
	DisplayTimeout as DWORD
end type

type POWER_SESSION_TIMEOUTS as _POWER_SESSION_TIMEOUTS
type PPOWER_SESSION_TIMEOUTS as _POWER_SESSION_TIMEOUTS ptr

type _POWER_SESSION_RIT_STATE
	Active as WINBOOLEAN
	LastInputTime as DWORD
end type

type POWER_SESSION_RIT_STATE as _POWER_SESSION_RIT_STATE
type PPOWER_SESSION_RIT_STATE as _POWER_SESSION_RIT_STATE ptr

type _POWER_SESSION_WINLOGON
	SessionId as DWORD
	Console as WINBOOLEAN
	Locked as WINBOOLEAN
end type

type POWER_SESSION_WINLOGON as _POWER_SESSION_WINLOGON
type PPOWER_SESSION_WINLOGON as _POWER_SESSION_WINLOGON ptr

type _POWER_IDLE_RESILIENCY
	CoalescingTimeout as DWORD
	IdleResiliencyPeriod as DWORD
end type

type POWER_IDLE_RESILIENCY as _POWER_IDLE_RESILIENCY
type PPOWER_IDLE_RESILIENCY as _POWER_IDLE_RESILIENCY ptr

type POWER_MONITOR_REQUEST_REASON as long
enum
	MonitorRequestReasonUnknown
	MonitorRequestReasonPowerButton
	MonitorRequestReasonRemoteConnection
	MonitorRequestReasonScMonitorpower
	MonitorRequestReasonUserInput
	MonitorRequestReasonAcDcDisplayBurst
	MonitorRequestReasonUserDisplayBurst
	MonitorRequestReasonPoSetSystemState
	MonitorRequestReasonSetThreadExecutionState
	MonitorRequestReasonFullWake
	MonitorRequestReasonSessionUnlock
	MonitorRequestReasonScreenOffRequest
	MonitorRequestReasonIdleTimeout
	MonitorRequestReasonPolicyChange
	MonitorRequestReasonMax
end enum

type _POWER_MONITOR_INVOCATION
	On as WINBOOLEAN
	Console as WINBOOLEAN
	RequestReason as POWER_MONITOR_REQUEST_REASON
end type

type POWER_MONITOR_INVOCATION as _POWER_MONITOR_INVOCATION
type PPOWER_MONITOR_INVOCATION as _POWER_MONITOR_INVOCATION ptr

type _RESUME_PERFORMANCE
	PostTimeMs as DWORD
	TotalResumeTimeMs as ULONGLONG
	ResumeCompleteTimestamp as ULONGLONG
end type

type RESUME_PERFORMANCE as _RESUME_PERFORMANCE
type PRESUME_PERFORMANCE as _RESUME_PERFORMANCE ptr

type SYSTEM_POWER_CONDITION as long
enum
	PoAc
	PoDc
	PoHot
	PoConditionMaximum
end enum

type SET_POWER_SETTING_VALUE
	Version as DWORD
	Guid as GUID
	PowerCondition as SYSTEM_POWER_CONDITION
	DataLength as DWORD
	Data(0 to 0) as UBYTE
end type

type PSET_POWER_SETTING_VALUE as SET_POWER_SETTING_VALUE ptr
const POWER_SETTING_VALUE_VERSION = &h1

type NOTIFY_USER_POWER_SETTING
	Guid as GUID
end type

type PNOTIFY_USER_POWER_SETTING as NOTIFY_USER_POWER_SETTING ptr

type _APPLICATIONLAUNCH_SETTING_VALUE
	ActivationTime as LARGE_INTEGER
	Flags as DWORD
	ButtonInstanceID as DWORD
end type

type APPLICATIONLAUNCH_SETTING_VALUE as _APPLICATIONLAUNCH_SETTING_VALUE
type PAPPLICATIONLAUNCH_SETTING_VALUE as _APPLICATIONLAUNCH_SETTING_VALUE ptr

type _POWER_PLATFORM_ROLE as long
enum
	PlatformRoleUnspecified = 0
	PlatformRoleDesktop
	PlatformRoleMobile
	PlatformRoleWorkstation
	PlatformRoleEnterpriseServer
	PlatformRoleSOHOServer
	PlatformRoleAppliancePC
	PlatformRolePerformanceServer
	PlatformRoleSlate
	PlatformRoleMaximum
end enum

type POWER_PLATFORM_ROLE as _POWER_PLATFORM_ROLE
type PPOWER_PLATFORM_ROLE as _POWER_PLATFORM_ROLE ptr

type _POWER_PLATFORM_INFORMATION
	AoAc as WINBOOLEAN
end type

type POWER_PLATFORM_INFORMATION as _POWER_PLATFORM_INFORMATION
type PPOWER_PLATFORM_INFORMATION as _POWER_PLATFORM_INFORMATION ptr
const POWER_PLATFORM_ROLE_V1 = &h00000001
const POWER_PLATFORM_ROLE_V1_MAX = PlatformRolePerformanceServer + 1
const POWER_PLATFORM_ROLE_V2 = &h00000002
const POWER_PLATFORM_ROLE_V2_MAX = PlatformRoleSlate + 1

#if _WIN32_WINNT = &h0602
	const POWER_PLATFORM_ROLE_VERSION = POWER_PLATFORM_ROLE_V2
	const POWER_PLATFORM_ROLE_VERSION_MAX = POWER_PLATFORM_ROLE_V2_MAX
#else
	const POWER_PLATFORM_ROLE_VERSION = POWER_PLATFORM_ROLE_V1
	const POWER_PLATFORM_ROLE_VERSION_MAX = POWER_PLATFORM_ROLE_V1_MAX
#endif

type BATTERY_REPORTING_SCALE
	Granularity as DWORD
	Capacity as DWORD
end type

type PBATTERY_REPORTING_SCALE as BATTERY_REPORTING_SCALE ptr

type PPM_WMI_LEGACY_PERFSTATE
	Frequency as DWORD
	Flags as DWORD
	PercentFrequency as DWORD
end type

type PPPM_WMI_LEGACY_PERFSTATE as PPM_WMI_LEGACY_PERFSTATE ptr

type PPM_WMI_IDLE_STATE
	Latency as DWORD
	Power as DWORD
	TimeCheck as DWORD
	PromotePercent as UBYTE
	DemotePercent as UBYTE
	StateType as UBYTE
	Reserved as UBYTE
	StateFlags as DWORD
	Context as DWORD
	IdleHandler as DWORD
	Reserved1 as DWORD
end type

type PPPM_WMI_IDLE_STATE as PPM_WMI_IDLE_STATE ptr

type PPM_WMI_IDLE_STATES
	as DWORD Type
	Count as DWORD
	TargetState as DWORD
	OldState as DWORD
	TargetProcessors as DWORD64
	State(0 to 0) as PPM_WMI_IDLE_STATE
end type

type PPPM_WMI_IDLE_STATES as PPM_WMI_IDLE_STATES ptr

type PPM_WMI_IDLE_STATES_EX
	as DWORD Type
	Count as DWORD
	TargetState as DWORD
	OldState as DWORD
	TargetProcessors as PVOID
	State(0 to 0) as PPM_WMI_IDLE_STATE
end type

type PPPM_WMI_IDLE_STATES_EX as PPM_WMI_IDLE_STATES_EX ptr

type PPM_WMI_PERF_STATE
	Frequency as DWORD
	Power as DWORD
	PercentFrequency as UBYTE
	IncreaseLevel as UBYTE
	DecreaseLevel as UBYTE
	as UBYTE Type
	IncreaseTime as DWORD
	DecreaseTime as DWORD
	Control as DWORD64
	Status as DWORD64
	HitCount as DWORD
	Reserved1 as DWORD
	Reserved2 as DWORD64
	Reserved3 as DWORD64
end type

type PPPM_WMI_PERF_STATE as PPM_WMI_PERF_STATE ptr

type PPM_WMI_PERF_STATES
	Count as DWORD
	MaxFrequency as DWORD
	CurrentState as DWORD
	MaxPerfState as DWORD
	MinPerfState as DWORD
	LowestPerfState as DWORD
	ThermalConstraint as DWORD
	BusyAdjThreshold as UBYTE
	PolicyType as UBYTE
	as UBYTE Type
	Reserved as UBYTE
	TimerInterval as DWORD
	TargetProcessors as DWORD64
	PStateHandler as DWORD
	PStateContext as DWORD
	TStateHandler as DWORD
	TStateContext as DWORD
	FeedbackHandler as DWORD
	Reserved1 as DWORD
	Reserved2 as DWORD64
	State(0 to 0) as PPM_WMI_PERF_STATE
end type

type PPPM_WMI_PERF_STATES as PPM_WMI_PERF_STATES ptr

type PPM_WMI_PERF_STATES_EX
	Count as DWORD
	MaxFrequency as DWORD
	CurrentState as DWORD
	MaxPerfState as DWORD
	MinPerfState as DWORD
	LowestPerfState as DWORD
	ThermalConstraint as DWORD
	BusyAdjThreshold as UBYTE
	PolicyType as UBYTE
	as UBYTE Type
	Reserved as UBYTE
	TimerInterval as DWORD
	TargetProcessors as PVOID
	PStateHandler as DWORD
	PStateContext as DWORD
	TStateHandler as DWORD
	TStateContext as DWORD
	FeedbackHandler as DWORD
	Reserved1 as DWORD
	Reserved2 as DWORD64
	State(0 to 0) as PPM_WMI_PERF_STATE
end type

type PPPM_WMI_PERF_STATES_EX as PPM_WMI_PERF_STATES_EX ptr
const PROC_IDLE_BUCKET_COUNT = 6
const PROC_IDLE_BUCKET_COUNT_EX = 16

type PPM_IDLE_STATE_ACCOUNTING
	IdleTransitions as DWORD
	FailedTransitions as DWORD
	InvalidBucketIndex as DWORD
	TotalTime as DWORD64
	IdleTimeBuckets(0 to 5) as DWORD
end type

type PPPM_IDLE_STATE_ACCOUNTING as PPM_IDLE_STATE_ACCOUNTING ptr

type PPM_IDLE_ACCOUNTING
	StateCount as DWORD
	TotalTransitions as DWORD
	ResetCount as DWORD
	StartTime as DWORD64
	State(0 to 0) as PPM_IDLE_STATE_ACCOUNTING
end type

type PPPM_IDLE_ACCOUNTING as PPM_IDLE_ACCOUNTING ptr

type PPM_IDLE_STATE_BUCKET_EX
	TotalTimeUs as DWORD64
	MinTimeUs as DWORD
	MaxTimeUs as DWORD
	Count as DWORD
end type

type PPPM_IDLE_STATE_BUCKET_EX as PPM_IDLE_STATE_BUCKET_EX ptr

type PPM_IDLE_STATE_ACCOUNTING_EX
	TotalTime as DWORD64
	IdleTransitions as DWORD
	FailedTransitions as DWORD
	InvalidBucketIndex as DWORD
	MinTimeUs as DWORD
	MaxTimeUs as DWORD
	CancelledTransitions as DWORD
	IdleTimeBuckets(0 to 15) as PPM_IDLE_STATE_BUCKET_EX
end type

type PPPM_IDLE_STATE_ACCOUNTING_EX as PPM_IDLE_STATE_ACCOUNTING_EX ptr

type PPM_IDLE_ACCOUNTING_EX
	StateCount as DWORD
	TotalTransitions as DWORD
	ResetCount as DWORD
	AbortCount as DWORD
	StartTime as DWORD64
	State(0 to 0) as PPM_IDLE_STATE_ACCOUNTING_EX
end type

type PPPM_IDLE_ACCOUNTING_EX as PPM_IDLE_ACCOUNTING_EX ptr
const ACPI_PPM_SOFTWARE_ALL = &hfc
const ACPI_PPM_SOFTWARE_ANY = &hfd
const ACPI_PPM_HARDWARE_ALL = &hfe
const MS_PPM_SOFTWARE_ALL = &h1
const PPM_FIRMWARE_ACPI1C2 = &h1
const PPM_FIRMWARE_ACPI1C3 = &h2
const PPM_FIRMWARE_ACPI1TSTATES = &h4
const PPM_FIRMWARE_CST = &h8
const PPM_FIRMWARE_CSD = &h10
const PPM_FIRMWARE_PCT = &h20
const PPM_FIRMWARE_PSS = &h40
const PPM_FIRMWARE_XPSS = &h80
const PPM_FIRMWARE_PPC = &h100
const PPM_FIRMWARE_PSD = &h200
const PPM_FIRMWARE_PTC = &h400
const PPM_FIRMWARE_TSS = &h800
const PPM_FIRMWARE_TPC = &h1000
const PPM_FIRMWARE_TSD = &h2000
const PPM_FIRMWARE_PCCH = &h4000
const PPM_FIRMWARE_PCCP = &h8000
const PPM_FIRMWARE_OSC = &h10000
const PPM_FIRMWARE_PDC = &h20000
const PPM_FIRMWARE_CPC = &h40000
const PPM_PERFORMANCE_IMPLEMENTATION_NONE = 0
const PPM_PERFORMANCE_IMPLEMENTATION_PSTATES = 1
const PPM_PERFORMANCE_IMPLEMENTATION_PCCV1 = 2
const PPM_PERFORMANCE_IMPLEMENTATION_CPPC = 3
const PPM_PERFORMANCE_IMPLEMENTATION_PEP = 4
const PPM_IDLE_IMPLEMENTATION_NONE = &h0
const PPM_IDLE_IMPLEMENTATION_CSTATES = &h1
const PPM_IDLE_IMPLEMENTATION_PEP = &h2

type PPM_PERFSTATE_EVENT
	State as DWORD
	Status as DWORD
	Latency as DWORD
	Speed as DWORD
	Processor as DWORD
end type

type PPPM_PERFSTATE_EVENT as PPM_PERFSTATE_EVENT ptr

type PPM_PERFSTATE_DOMAIN_EVENT
	State as DWORD
	Latency as DWORD
	Speed as DWORD
	Processors as DWORD64
end type

type PPPM_PERFSTATE_DOMAIN_EVENT as PPM_PERFSTATE_DOMAIN_EVENT ptr

type PPM_IDLESTATE_EVENT
	NewState as DWORD
	OldState as DWORD
	Processors as DWORD64
end type

type PPPM_IDLESTATE_EVENT as PPM_IDLESTATE_EVENT ptr

type PPM_THERMALCHANGE_EVENT
	ThermalConstraint as DWORD
	Processors as DWORD64
end type

type PPPM_THERMALCHANGE_EVENT as PPM_THERMALCHANGE_EVENT ptr

type PPM_THERMAL_POLICY_EVENT
	Mode as UBYTE
	Processors as DWORD64
end type

type PPPM_THERMAL_POLICY_EVENT as PPM_THERMAL_POLICY_EVENT ptr
extern PPM_PERFSTATE_CHANGE_GUID as const GUID
extern PPM_PERFSTATE_DOMAIN_CHANGE_GUID as const GUID
extern PPM_IDLESTATE_CHANGE_GUID as const GUID
extern PPM_PERFSTATES_DATA_GUID as const GUID
extern PPM_IDLESTATES_DATA_GUID as const GUID
extern PPM_IDLE_ACCOUNTING_GUID as const GUID
extern PPM_IDLE_ACCOUNTING_EX_GUID as const GUID
extern PPM_THERMALCONSTRAINT_GUID as const GUID
extern PPM_PERFMON_PERFSTATE_GUID as const GUID
extern PPM_THERMAL_POLICY_CHANGE_GUID as const GUID

type POWER_ACTION_POLICY
	Action as POWER_ACTION
	Flags as DWORD
	EventCode as DWORD
end type

type PPOWER_ACTION_POLICY as POWER_ACTION_POLICY ptr
const POWER_ACTION_QUERY_ALLOWED = &h00000001
const POWER_ACTION_UI_ALLOWED = &h00000002
const POWER_ACTION_OVERRIDE_APPS = &h00000004
const POWER_ACTION_HIBERBOOT = &h00000008
const POWER_ACTION_PSEUDO_TRANSITION = &h08000000
const POWER_ACTION_LIGHTEST_FIRST = &h10000000
const POWER_ACTION_LOCK_CONSOLE = &h20000000
const POWER_ACTION_DISABLE_WAKES = &h40000000
const POWER_ACTION_CRITICAL = &h80000000
const POWER_LEVEL_USER_NOTIFY_TEXT = &h00000001
const POWER_LEVEL_USER_NOTIFY_SOUND = &h00000002
const POWER_LEVEL_USER_NOTIFY_EXEC = &h00000004
const POWER_USER_NOTIFY_BUTTON = &h00000008
const POWER_USER_NOTIFY_SHUTDOWN = &h00000010
const POWER_USER_NOTIFY_FORCED_SHUTDOWN = &h00000020
const POWER_FORCE_TRIGGER_RESET = &h80000000
const BATTERY_DISCHARGE_FLAGS_EVENTCODE_MASK = &h00000007
const BATTERY_DISCHARGE_FLAGS_ENABLE = &h80000000
const DISCHARGE_POLICY_CRITICAL = 0
const DISCHARGE_POLICY_LOW = 1
const NUM_DISCHARGE_POLICIES = 4
const PROCESSOR_IDLESTATE_POLICY_COUNT = &h3

type PROCESSOR_IDLESTATE_INFO
	TimeCheck as DWORD
	DemotePercent as UBYTE
	PromotePercent as UBYTE
	Spare(0 to 1) as UBYTE
end type

type PPROCESSOR_IDLESTATE_INFO as PROCESSOR_IDLESTATE_INFO ptr

type SYSTEM_POWER_LEVEL
	Enable as WINBOOLEAN
	Spare(0 to 2) as UBYTE
	BatteryLevel as DWORD
	PowerPolicy as POWER_ACTION_POLICY
	MinSystemState as SYSTEM_POWER_STATE
end type

type PSYSTEM_POWER_LEVEL as SYSTEM_POWER_LEVEL ptr

type _SYSTEM_POWER_POLICY
	Revision as DWORD
	PowerButton as POWER_ACTION_POLICY
	SleepButton as POWER_ACTION_POLICY
	LidClose as POWER_ACTION_POLICY
	LidOpenWake as SYSTEM_POWER_STATE
	Reserved as DWORD
	Idle as POWER_ACTION_POLICY
	IdleTimeout as DWORD
	IdleSensitivity as UBYTE
	DynamicThrottle as UBYTE
	Spare2(0 to 1) as UBYTE
	MinSleep as SYSTEM_POWER_STATE
	MaxSleep as SYSTEM_POWER_STATE
	ReducedLatencySleep as SYSTEM_POWER_STATE
	WinLogonFlags as DWORD
	Spare3 as DWORD
	DozeS4Timeout as DWORD
	BroadcastCapacityResolution as DWORD
	DischargePolicy(0 to 3) as SYSTEM_POWER_LEVEL
	VideoTimeout as DWORD
	VideoDimDisplay as WINBOOLEAN
	VideoReserved(0 to 2) as DWORD
	SpindownTimeout as DWORD
	OptimizeForPower as WINBOOLEAN
	FanThrottleTolerance as UBYTE
	ForcedThrottle as UBYTE
	MinThrottle as UBYTE
	OverThrottled as POWER_ACTION_POLICY
end type

type SYSTEM_POWER_POLICY as _SYSTEM_POWER_POLICY
type PSYSTEM_POWER_POLICY as _SYSTEM_POWER_POLICY ptr
const PO_THROTTLE_NONE = 0
const PO_THROTTLE_CONSTANT = 1
const PO_THROTTLE_DEGRADE = 2
const PO_THROTTLE_ADAPTIVE = 3
const PO_THROTTLE_MAXIMUM = 4

union PROCESSOR_IDLESTATE_POLICY_Flags
	AsWORD as WORD

	type
		AllowScaling : 1 as WORD
		Disabled : 1 as WORD
		Reserved : 14 as WORD
	end type
end union

type PROCESSOR_IDLESTATE_POLICY
	Revision as WORD
	Flags as PROCESSOR_IDLESTATE_POLICY_Flags
	PolicyCount as DWORD
	Policy(0 to 2) as PROCESSOR_IDLESTATE_INFO
end type

type PPROCESSOR_IDLESTATE_POLICY as PROCESSOR_IDLESTATE_POLICY ptr

type _PROCESSOR_POWER_POLICY_INFO
	TimeCheck as DWORD
	DemoteLimit as DWORD
	PromoteLimit as DWORD
	DemotePercent as UBYTE
	PromotePercent as UBYTE
	Spare(0 to 1) as UBYTE
	AllowDemotion : 1 as DWORD
	AllowPromotion : 1 as DWORD
	Reserved : 30 as DWORD
end type

type PROCESSOR_POWER_POLICY_INFO as _PROCESSOR_POWER_POLICY_INFO
type PPROCESSOR_POWER_POLICY_INFO as _PROCESSOR_POWER_POLICY_INFO ptr

type _PROCESSOR_POWER_POLICY
	Revision as DWORD
	DynamicThrottle as UBYTE
	Spare(0 to 2) as UBYTE
	DisableCStates : 1 as DWORD
	Reserved : 31 as DWORD
	PolicyCount as DWORD
	Policy(0 to 2) as PROCESSOR_POWER_POLICY_INFO
end type

type PROCESSOR_POWER_POLICY as _PROCESSOR_POWER_POLICY
type PPROCESSOR_POWER_POLICY as _PROCESSOR_POWER_POLICY ptr

union PROCESSOR_PERFSTATE_POLICY_Flags
	AsBYTE as UBYTE

	type
		NoDomainAccounting : 1 as UBYTE
		IncreasePolicy : 2 as UBYTE
		DecreasePolicy : 2 as UBYTE
		Reserved : 3 as UBYTE
	end type
end union

type PROCESSOR_PERFSTATE_POLICY
	Revision as DWORD
	MaxThrottle as UBYTE
	MinThrottle as UBYTE
	BusyAdjThreshold as UBYTE

	union
		Spare as UBYTE
		Flags as PROCESSOR_PERFSTATE_POLICY_Flags
	end union

	TimeCheck as DWORD
	IncreaseTime as DWORD
	DecreaseTime as DWORD
	IncreasePercent as DWORD
	DecreasePercent as DWORD
end type

type PPROCESSOR_PERFSTATE_POLICY as PROCESSOR_PERFSTATE_POLICY ptr

type _ADMINISTRATOR_POWER_POLICY
	MinSleep as SYSTEM_POWER_STATE
	MaxSleep as SYSTEM_POWER_STATE
	MinVideoTimeout as DWORD
	MaxVideoTimeout as DWORD
	MinSpindownTimeout as DWORD
	MaxSpindownTimeout as DWORD
end type

type ADMINISTRATOR_POWER_POLICY as _ADMINISTRATOR_POWER_POLICY
type PADMINISTRATOR_POWER_POLICY as _ADMINISTRATOR_POWER_POLICY ptr

type SYSTEM_POWER_CAPABILITIES
	PowerButtonPresent as WINBOOLEAN
	SleepButtonPresent as WINBOOLEAN
	LidPresent as WINBOOLEAN
	SystemS1 as WINBOOLEAN
	SystemS2 as WINBOOLEAN
	SystemS3 as WINBOOLEAN
	SystemS4 as WINBOOLEAN
	SystemS5 as WINBOOLEAN
	HiberFilePresent as WINBOOLEAN
	FullWake as WINBOOLEAN
	VideoDimPresent as WINBOOLEAN
	ApmPresent as WINBOOLEAN
	UpsPresent as WINBOOLEAN
	ThermalControl as WINBOOLEAN
	ProcessorThrottle as WINBOOLEAN
	ProcessorMinThrottle as UBYTE
	ProcessorMaxThrottle as UBYTE
	FastSystemS4 as WINBOOLEAN
	spare2(0 to 2) as UBYTE
	DiskSpinDown as WINBOOLEAN
	spare3(0 to 7) as UBYTE
	SystemBatteriesPresent as WINBOOLEAN
	BatteriesAreShortTerm as WINBOOLEAN
	BatteryScale(0 to 2) as BATTERY_REPORTING_SCALE
	AcOnLineWake as SYSTEM_POWER_STATE
	SoftLidWake as SYSTEM_POWER_STATE
	RtcWake as SYSTEM_POWER_STATE
	MinDeviceWakeState as SYSTEM_POWER_STATE
	DefaultLowLatencyWake as SYSTEM_POWER_STATE
end type

type PSYSTEM_POWER_CAPABILITIES as SYSTEM_POWER_CAPABILITIES ptr

type SYSTEM_BATTERY_STATE
	AcOnLine as WINBOOLEAN
	BatteryPresent as WINBOOLEAN
	Charging as WINBOOLEAN
	Discharging as WINBOOLEAN
	Spare1(0 to 3) as WINBOOLEAN
	MaxCapacity as DWORD
	RemainingCapacity as DWORD
	Rate as DWORD
	EstimatedTime as DWORD
	DefaultAlert1 as DWORD
	DefaultAlert2 as DWORD
end type

type PSYSTEM_BATTERY_STATE as SYSTEM_BATTERY_STATE ptr
const IMAGE_DOS_SIGNATURE = &h5A4D
const IMAGE_OS2_SIGNATURE = &h454E
const IMAGE_OS2_SIGNATURE_LE = &h454C
const IMAGE_VXD_SIGNATURE = &h454C
const IMAGE_NT_SIGNATURE = &h00004550

type _IMAGE_DOS_HEADER field = 2
	e_magic as WORD
	e_cblp as WORD
	e_cp as WORD
	e_crlc as WORD
	e_cparhdr as WORD
	e_minalloc as WORD
	e_maxalloc as WORD
	e_ss as WORD
	e_sp as WORD
	e_csum as WORD
	e_ip as WORD
	e_cs as WORD
	e_lfarlc as WORD
	e_ovno as WORD
	e_res(0 to 3) as WORD
	e_oemid as WORD
	e_oeminfo as WORD
	e_res2(0 to 9) as WORD
	e_lfanew as LONG
end type

type IMAGE_DOS_HEADER as _IMAGE_DOS_HEADER
type PIMAGE_DOS_HEADER as _IMAGE_DOS_HEADER ptr

type _IMAGE_OS2_HEADER field = 2
	ne_magic as WORD
	ne_ver as CHAR
	ne_rev as CHAR
	ne_enttab as WORD
	ne_cbenttab as WORD
	ne_crc as LONG
	ne_flags as WORD
	ne_autodata as WORD
	ne_heap as WORD
	ne_stack as WORD
	ne_csip as LONG
	ne_sssp as LONG
	ne_cseg as WORD
	ne_cmod as WORD
	ne_cbnrestab as WORD
	ne_segtab as WORD
	ne_rsrctab as WORD
	ne_restab as WORD
	ne_modtab as WORD
	ne_imptab as WORD
	ne_nrestab as LONG
	ne_cmovent as WORD
	ne_align as WORD
	ne_cres as WORD
	ne_exetyp as UBYTE
	ne_flagsothers as UBYTE
	ne_pretthunks as WORD
	ne_psegrefbytes as WORD
	ne_swaparea as WORD
	ne_expver as WORD
end type

type IMAGE_OS2_HEADER as _IMAGE_OS2_HEADER
type PIMAGE_OS2_HEADER as _IMAGE_OS2_HEADER ptr

type _IMAGE_VXD_HEADER field = 2
	e32_magic as WORD
	e32_border as UBYTE
	e32_worder as UBYTE
	e32_level as DWORD
	e32_cpu as WORD
	e32_os as WORD
	e32_ver as DWORD
	e32_mflags as DWORD
	e32_mpages as DWORD
	e32_startobj as DWORD
	e32_eip as DWORD
	e32_stackobj as DWORD
	e32_esp as DWORD
	e32_pagesize as DWORD
	e32_lastpagesize as DWORD
	e32_fixupsize as DWORD
	e32_fixupsum as DWORD
	e32_ldrsize as DWORD
	e32_ldrsum as DWORD
	e32_objtab as DWORD
	e32_objcnt as DWORD
	e32_objmap as DWORD
	e32_itermap as DWORD
	e32_rsrctab as DWORD
	e32_rsrccnt as DWORD
	e32_restab as DWORD
	e32_enttab as DWORD
	e32_dirtab as DWORD
	e32_dircnt as DWORD
	e32_fpagetab as DWORD
	e32_frectab as DWORD
	e32_impmod as DWORD
	e32_impmodcnt as DWORD
	e32_impproc as DWORD
	e32_pagesum as DWORD
	e32_datapage as DWORD
	e32_preload as DWORD
	e32_nrestab as DWORD
	e32_cbnrestab as DWORD
	e32_nressum as DWORD
	e32_autodata as DWORD
	e32_debuginfo as DWORD
	e32_debuglen as DWORD
	e32_instpreload as DWORD
	e32_instdemand as DWORD
	e32_heapsize as DWORD
	e32_res3(0 to 11) as UBYTE
	e32_winresoff as DWORD
	e32_winreslen as DWORD
	e32_devid as WORD
	e32_ddkver as WORD
end type

type IMAGE_VXD_HEADER as _IMAGE_VXD_HEADER
type PIMAGE_VXD_HEADER as _IMAGE_VXD_HEADER ptr

type _IMAGE_FILE_HEADER field = 4
	Machine as WORD
	NumberOfSections as WORD
	TimeDateStamp as DWORD
	PointerToSymbolTable as DWORD
	NumberOfSymbols as DWORD
	SizeOfOptionalHeader as WORD
	Characteristics as WORD
end type

type IMAGE_FILE_HEADER as _IMAGE_FILE_HEADER
type PIMAGE_FILE_HEADER as _IMAGE_FILE_HEADER ptr
const IMAGE_SIZEOF_FILE_HEADER = 20
const IMAGE_FILE_RELOCS_STRIPPED = &h0001
const IMAGE_FILE_EXECUTABLE_IMAGE = &h0002
const IMAGE_FILE_LINE_NUMS_STRIPPED = &h0004
const IMAGE_FILE_LOCAL_SYMS_STRIPPED = &h0008
const IMAGE_FILE_AGGRESIVE_WS_TRIM = &h0010
const IMAGE_FILE_LARGE_ADDRESS_AWARE = &h0020
const IMAGE_FILE_BYTES_REVERSED_LO = &h0080
const IMAGE_FILE_32BIT_MACHINE = &h0100
const IMAGE_FILE_DEBUG_STRIPPED = &h0200
const IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP = &h0400
const IMAGE_FILE_NET_RUN_FROM_SWAP = &h0800
const IMAGE_FILE_SYSTEM = &h1000
const IMAGE_FILE_DLL = &h2000
const IMAGE_FILE_UP_SYSTEM_ONLY = &h4000
const IMAGE_FILE_BYTES_REVERSED_HI = &h8000
const IMAGE_FILE_MACHINE_UNKNOWN = 0
const IMAGE_FILE_MACHINE_I386 = &h014c
const IMAGE_FILE_MACHINE_R3000 = &h0162
const IMAGE_FILE_MACHINE_R4000 = &h0166
const IMAGE_FILE_MACHINE_R10000 = &h0168
const IMAGE_FILE_MACHINE_WCEMIPSV2 = &h0169
const IMAGE_FILE_MACHINE_ALPHA = &h0184
const IMAGE_FILE_MACHINE_SH3 = &h01a2
const IMAGE_FILE_MACHINE_SH3DSP = &h01a3
const IMAGE_FILE_MACHINE_SH3E = &h01a4
const IMAGE_FILE_MACHINE_SH4 = &h01a6
const IMAGE_FILE_MACHINE_SH5 = &h01a8
const IMAGE_FILE_MACHINE_ARM = &h01c0
const IMAGE_FILE_MACHINE_ARMV7 = &h01c4
const IMAGE_FILE_MACHINE_ARMNT = &h01c4
const IMAGE_FILE_MACHINE_THUMB = &h01c2
const IMAGE_FILE_MACHINE_AM33 = &h01d3
const IMAGE_FILE_MACHINE_POWERPC = &h01F0
const IMAGE_FILE_MACHINE_POWERPCFP = &h01f1
const IMAGE_FILE_MACHINE_IA64 = &h0200
const IMAGE_FILE_MACHINE_MIPS16 = &h0266
const IMAGE_FILE_MACHINE_ALPHA64 = &h0284
const IMAGE_FILE_MACHINE_MIPSFPU = &h0366
const IMAGE_FILE_MACHINE_MIPSFPU16 = &h0466
const IMAGE_FILE_MACHINE_AXP64 = IMAGE_FILE_MACHINE_ALPHA64
const IMAGE_FILE_MACHINE_TRICORE = &h0520
const IMAGE_FILE_MACHINE_CEF = &h0CEF
const IMAGE_FILE_MACHINE_EBC = &h0EBC
const IMAGE_FILE_MACHINE_AMD64 = &h8664
const IMAGE_FILE_MACHINE_M32R = &h9041
const IMAGE_FILE_MACHINE_CEE = &hc0ee

type _IMAGE_DATA_DIRECTORY field = 4
	VirtualAddress as DWORD
	Size as DWORD
end type

type IMAGE_DATA_DIRECTORY as _IMAGE_DATA_DIRECTORY
type PIMAGE_DATA_DIRECTORY as _IMAGE_DATA_DIRECTORY ptr
const IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16

type _IMAGE_OPTIONAL_HEADER field = 4
	Magic as WORD
	MajorLinkerVersion as UBYTE
	MinorLinkerVersion as UBYTE
	SizeOfCode as DWORD
	SizeOfInitializedData as DWORD
	SizeOfUninitializedData as DWORD
	AddressOfEntryPoint as DWORD
	BaseOfCode as DWORD
	BaseOfData as DWORD
	ImageBase as DWORD
	SectionAlignment as DWORD
	FileAlignment as DWORD
	MajorOperatingSystemVersion as WORD
	MinorOperatingSystemVersion as WORD
	MajorImageVersion as WORD
	MinorImageVersion as WORD
	MajorSubsystemVersion as WORD
	MinorSubsystemVersion as WORD
	Win32VersionValue as DWORD
	SizeOfImage as DWORD
	SizeOfHeaders as DWORD
	CheckSum as DWORD
	Subsystem as WORD
	DllCharacteristics as WORD
	SizeOfStackReserve as DWORD
	SizeOfStackCommit as DWORD
	SizeOfHeapReserve as DWORD
	SizeOfHeapCommit as DWORD
	LoaderFlags as DWORD
	NumberOfRvaAndSizes as DWORD
	DataDirectory(0 to 15) as IMAGE_DATA_DIRECTORY
end type

type IMAGE_OPTIONAL_HEADER32 as _IMAGE_OPTIONAL_HEADER
type PIMAGE_OPTIONAL_HEADER32 as _IMAGE_OPTIONAL_HEADER ptr

type _IMAGE_ROM_OPTIONAL_HEADER field = 4
	Magic as WORD
	MajorLinkerVersion as UBYTE
	MinorLinkerVersion as UBYTE
	SizeOfCode as DWORD
	SizeOfInitializedData as DWORD
	SizeOfUninitializedData as DWORD
	AddressOfEntryPoint as DWORD
	BaseOfCode as DWORD
	BaseOfData as DWORD
	BaseOfBss as DWORD
	GprMask as DWORD
	CprMask(0 to 3) as DWORD
	GpValue as DWORD
end type

type IMAGE_ROM_OPTIONAL_HEADER as _IMAGE_ROM_OPTIONAL_HEADER
type PIMAGE_ROM_OPTIONAL_HEADER as _IMAGE_ROM_OPTIONAL_HEADER ptr

type _IMAGE_OPTIONAL_HEADER64 field = 4
	Magic as WORD
	MajorLinkerVersion as UBYTE
	MinorLinkerVersion as UBYTE
	SizeOfCode as DWORD
	SizeOfInitializedData as DWORD
	SizeOfUninitializedData as DWORD
	AddressOfEntryPoint as DWORD
	BaseOfCode as DWORD
	ImageBase as ULONGLONG
	SectionAlignment as DWORD
	FileAlignment as DWORD
	MajorOperatingSystemVersion as WORD
	MinorOperatingSystemVersion as WORD
	MajorImageVersion as WORD
	MinorImageVersion as WORD
	MajorSubsystemVersion as WORD
	MinorSubsystemVersion as WORD
	Win32VersionValue as DWORD
	SizeOfImage as DWORD
	SizeOfHeaders as DWORD
	CheckSum as DWORD
	Subsystem as WORD
	DllCharacteristics as WORD
	SizeOfStackReserve as ULONGLONG
	SizeOfStackCommit as ULONGLONG
	SizeOfHeapReserve as ULONGLONG
	SizeOfHeapCommit as ULONGLONG
	LoaderFlags as DWORD
	NumberOfRvaAndSizes as DWORD
	DataDirectory(0 to 15) as IMAGE_DATA_DIRECTORY
end type

type IMAGE_OPTIONAL_HEADER64 as _IMAGE_OPTIONAL_HEADER64
type PIMAGE_OPTIONAL_HEADER64 as _IMAGE_OPTIONAL_HEADER64 ptr
const IMAGE_SIZEOF_ROM_OPTIONAL_HEADER = 56
const IMAGE_SIZEOF_STD_OPTIONAL_HEADER = 28
const IMAGE_SIZEOF_NT_OPTIONAL32_HEADER = 224
const IMAGE_SIZEOF_NT_OPTIONAL64_HEADER = 240
const IMAGE_NT_OPTIONAL_HDR32_MAGIC = &h10b
const IMAGE_NT_OPTIONAL_HDR64_MAGIC = &h20b
const IMAGE_ROM_OPTIONAL_HDR_MAGIC = &h107

#ifdef __FB_64BIT__
	type IMAGE_OPTIONAL_HEADER as IMAGE_OPTIONAL_HEADER64
	type PIMAGE_OPTIONAL_HEADER as PIMAGE_OPTIONAL_HEADER64
	const IMAGE_SIZEOF_NT_OPTIONAL_HEADER = IMAGE_SIZEOF_NT_OPTIONAL64_HEADER
	const IMAGE_NT_OPTIONAL_HDR_MAGIC = IMAGE_NT_OPTIONAL_HDR64_MAGIC
#else
	type IMAGE_OPTIONAL_HEADER as IMAGE_OPTIONAL_HEADER32
	type PIMAGE_OPTIONAL_HEADER as PIMAGE_OPTIONAL_HEADER32
	const IMAGE_SIZEOF_NT_OPTIONAL_HEADER = IMAGE_SIZEOF_NT_OPTIONAL32_HEADER
	const IMAGE_NT_OPTIONAL_HDR_MAGIC = IMAGE_NT_OPTIONAL_HDR32_MAGIC
#endif

type _IMAGE_NT_HEADERS64 field = 4
	Signature as DWORD
	FileHeader as IMAGE_FILE_HEADER
	OptionalHeader as IMAGE_OPTIONAL_HEADER64
end type

type IMAGE_NT_HEADERS64 as _IMAGE_NT_HEADERS64
type PIMAGE_NT_HEADERS64 as _IMAGE_NT_HEADERS64 ptr

type _IMAGE_NT_HEADERS field = 4
	Signature as DWORD
	FileHeader as IMAGE_FILE_HEADER
	OptionalHeader as IMAGE_OPTIONAL_HEADER32
end type

type IMAGE_NT_HEADERS32 as _IMAGE_NT_HEADERS
type PIMAGE_NT_HEADERS32 as _IMAGE_NT_HEADERS ptr

type _IMAGE_ROM_HEADERS field = 4
	FileHeader as IMAGE_FILE_HEADER
	OptionalHeader as IMAGE_ROM_OPTIONAL_HEADER
end type

type IMAGE_ROM_HEADERS as _IMAGE_ROM_HEADERS
type PIMAGE_ROM_HEADERS as _IMAGE_ROM_HEADERS ptr

#ifdef __FB_64BIT__
	type IMAGE_NT_HEADERS as IMAGE_NT_HEADERS64
	type PIMAGE_NT_HEADERS as PIMAGE_NT_HEADERS64
#else
	type IMAGE_NT_HEADERS as IMAGE_NT_HEADERS32
	type PIMAGE_NT_HEADERS as PIMAGE_NT_HEADERS32
#endif

#define IMAGE_FIRST_SECTION(ntheader) cast(PIMAGE_SECTION_HEADER, (cast(ULONG_PTR, ntheader) + FIELD_OFFSET(IMAGE_NT_HEADERS, OptionalHeader)) + cast(PIMAGE_NT_HEADERS, (ntheader))->FileHeader.SizeOfOptionalHeader)
const IMAGE_SUBSYSTEM_UNKNOWN = 0
const IMAGE_SUBSYSTEM_NATIVE = 1
const IMAGE_SUBSYSTEM_WINDOWS_GUI = 2
const IMAGE_SUBSYSTEM_WINDOWS_CUI = 3
const IMAGE_SUBSYSTEM_OS2_CUI = 5
const IMAGE_SUBSYSTEM_POSIX_CUI = 7
const IMAGE_SUBSYSTEM_NATIVE_WINDOWS = 8
const IMAGE_SUBSYSTEM_WINDOWS_CE_GUI = 9
const IMAGE_SUBSYSTEM_EFI_APPLICATION = 10
const IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER = 11
const IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER = 12
const IMAGE_SUBSYSTEM_EFI_ROM = 13
const IMAGE_SUBSYSTEM_XBOX = 14
const IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION = 16
const IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE = &h0040
const IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY = &h0080
const IMAGE_DLLCHARACTERISTICS_NX_COMPAT = &h0100
const IMAGE_DLLCHARACTERISTICS_NO_ISOLATION = &h0200
const IMAGE_DLLCHARACTERISTICS_NO_SEH = &h0400
const IMAGE_DLLCHARACTERISTICS_NO_BIND = &h0800
const IMAGE_DLLCHARACTERISTICS_APPCONTAINER = &h1000
const IMAGE_DLLCHARACTERISTICS_WDM_DRIVER = &h2000
const IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = &h8000
const IMAGE_DIRECTORY_ENTRY_EXPORT = 0
const IMAGE_DIRECTORY_ENTRY_IMPORT = 1
const IMAGE_DIRECTORY_ENTRY_RESOURCE = 2
const IMAGE_DIRECTORY_ENTRY_EXCEPTION = 3
const IMAGE_DIRECTORY_ENTRY_SECURITY = 4
const IMAGE_DIRECTORY_ENTRY_BASERELOC = 5
const IMAGE_DIRECTORY_ENTRY_DEBUG = 6
const IMAGE_DIRECTORY_ENTRY_ARCHITECTURE = 7
const IMAGE_DIRECTORY_ENTRY_GLOBALPTR = 8
const IMAGE_DIRECTORY_ENTRY_TLS = 9
const IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG = 10
const IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT = 11
const IMAGE_DIRECTORY_ENTRY_IAT = 12
const IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT = 13
const IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR = 14

type ANON_OBJECT_HEADER field = 4
	Sig1 as WORD
	Sig2 as WORD
	Version as WORD
	Machine as WORD
	TimeDateStamp as DWORD
	ClassID as CLSID
	SizeOfData as DWORD
end type

type ANON_OBJECT_HEADER_V2 field = 4
	Sig1 as WORD
	Sig2 as WORD
	Version as WORD
	Machine as WORD
	TimeDateStamp as DWORD
	ClassID as CLSID
	SizeOfData as DWORD
	Flags as DWORD
	MetaDataSize as DWORD
	MetaDataOffset as DWORD
end type

type ANON_OBJECT_HEADER_BIGOBJ field = 4
	Sig1 as WORD
	Sig2 as WORD
	Version as WORD
	Machine as WORD
	TimeDateStamp as DWORD
	ClassID as CLSID
	SizeOfData as DWORD
	Flags as DWORD
	MetaDataSize as DWORD
	MetaDataOffset as DWORD
	NumberOfSections as DWORD
	PointerToSymbolTable as DWORD
	NumberOfSymbols as DWORD
end type

const IMAGE_SIZEOF_SHORT_NAME = 8

union _IMAGE_SECTION_HEADER_Misc field = 4
	PhysicalAddress as DWORD
	VirtualSize as DWORD
end union

type _IMAGE_SECTION_HEADER field = 4
	Name(0 to 7) as UBYTE
	Misc as _IMAGE_SECTION_HEADER_Misc
	VirtualAddress as DWORD
	SizeOfRawData as DWORD
	PointerToRawData as DWORD
	PointerToRelocations as DWORD
	PointerToLinenumbers as DWORD
	NumberOfRelocations as WORD
	NumberOfLinenumbers as WORD
	Characteristics as DWORD
end type

type IMAGE_SECTION_HEADER as _IMAGE_SECTION_HEADER
type PIMAGE_SECTION_HEADER as _IMAGE_SECTION_HEADER ptr
const IMAGE_SIZEOF_SECTION_HEADER = 40
const IMAGE_SCN_TYPE_NO_PAD = &h00000008
const IMAGE_SCN_CNT_CODE = &h00000020
const IMAGE_SCN_CNT_INITIALIZED_DATA = &h00000040
const IMAGE_SCN_CNT_UNINITIALIZED_DATA = &h00000080
const IMAGE_SCN_LNK_OTHER = &h00000100
const IMAGE_SCN_LNK_INFO = &h00000200
const IMAGE_SCN_LNK_REMOVE = &h00000800
const IMAGE_SCN_LNK_COMDAT = &h00001000
const IMAGE_SCN_NO_DEFER_SPEC_EXC = &h00004000
const IMAGE_SCN_GPREL = &h00008000
const IMAGE_SCN_MEM_FARDATA = &h00008000
const IMAGE_SCN_MEM_PURGEABLE = &h00020000
const IMAGE_SCN_MEM_16BIT = &h00020000
const IMAGE_SCN_MEM_LOCKED = &h00040000
const IMAGE_SCN_MEM_PRELOAD = &h00080000
const IMAGE_SCN_ALIGN_1BYTES = &h00100000
const IMAGE_SCN_ALIGN_2BYTES = &h00200000
const IMAGE_SCN_ALIGN_4BYTES = &h00300000
const IMAGE_SCN_ALIGN_8BYTES = &h00400000
const IMAGE_SCN_ALIGN_16BYTES = &h00500000
const IMAGE_SCN_ALIGN_32BYTES = &h00600000
const IMAGE_SCN_ALIGN_64BYTES = &h00700000
const IMAGE_SCN_ALIGN_128BYTES = &h00800000
const IMAGE_SCN_ALIGN_256BYTES = &h00900000
const IMAGE_SCN_ALIGN_512BYTES = &h00A00000
const IMAGE_SCN_ALIGN_1024BYTES = &h00B00000
const IMAGE_SCN_ALIGN_2048BYTES = &h00C00000
const IMAGE_SCN_ALIGN_4096BYTES = &h00D00000
const IMAGE_SCN_ALIGN_8192BYTES = &h00E00000
const IMAGE_SCN_ALIGN_MASK = &h00F00000
const IMAGE_SCN_LNK_NRELOC_OVFL = &h01000000
const IMAGE_SCN_MEM_DISCARDABLE = &h02000000
const IMAGE_SCN_MEM_NOT_CACHED = &h04000000
const IMAGE_SCN_MEM_NOT_PAGED = &h08000000
const IMAGE_SCN_MEM_SHARED = &h10000000
const IMAGE_SCN_MEM_EXECUTE = &h20000000
const IMAGE_SCN_MEM_READ = &h40000000
const IMAGE_SCN_MEM_WRITE = &h80000000
const IMAGE_SCN_SCALE_INDEX = &h00000001

type _IMAGE_SYMBOL_N_Name field = 2
	Short as DWORD
	Long as DWORD
end type

union _IMAGE_SYMBOL_N field = 2
	ShortName(0 to 7) as UBYTE
	Name as _IMAGE_SYMBOL_N_Name
	LongName(0 to 1) as DWORD
end union

type _IMAGE_SYMBOL field = 2
	N as _IMAGE_SYMBOL_N
	Value as DWORD
	SectionNumber as SHORT
	as WORD Type
	StorageClass as UBYTE
	NumberOfAuxSymbols as UBYTE
end type

type IMAGE_SYMBOL as _IMAGE_SYMBOL
type PIMAGE_SYMBOL as IMAGE_SYMBOL ptr
const IMAGE_SIZEOF_SYMBOL = 18

type _IMAGE_SYMBOL_EX_N_Name field = 2
	Short as DWORD
	Long as DWORD
end type

union _IMAGE_SYMBOL_EX_N field = 2
	ShortName(0 to 7) as UBYTE
	Name as _IMAGE_SYMBOL_EX_N_Name
	LongName(0 to 1) as DWORD
end union

type _IMAGE_SYMBOL_EX field = 2
	N as _IMAGE_SYMBOL_EX_N
	Value as DWORD
	SectionNumber as LONG
	as WORD Type
	StorageClass as UBYTE
	NumberOfAuxSymbols as UBYTE
end type

type IMAGE_SYMBOL_EX as _IMAGE_SYMBOL_EX
type PIMAGE_SYMBOL_EX as _IMAGE_SYMBOL_EX ptr
#define IMAGE_SYM_UNDEFINED cast(SHORT, 0)
#define IMAGE_SYM_ABSOLUTE cast(SHORT, -1)
#define IMAGE_SYM_DEBUG cast(SHORT, -2)
const IMAGE_SYM_SECTION_MAX = &hFEFF
const IMAGE_SYM_SECTION_MAX_EX = MAXLONG
const IMAGE_SYM_TYPE_NULL = &h0000
const IMAGE_SYM_TYPE_VOID = &h0001
const IMAGE_SYM_TYPE_CHAR = &h0002
const IMAGE_SYM_TYPE_SHORT = &h0003
const IMAGE_SYM_TYPE_INT = &h0004
const IMAGE_SYM_TYPE_LONG = &h0005
const IMAGE_SYM_TYPE_FLOAT = &h0006
const IMAGE_SYM_TYPE_DOUBLE = &h0007
const IMAGE_SYM_TYPE_STRUCT = &h0008
const IMAGE_SYM_TYPE_UNION = &h0009
const IMAGE_SYM_TYPE_ENUM = &h000A
const IMAGE_SYM_TYPE_MOE = &h000B
const IMAGE_SYM_TYPE_BYTE = &h000C
const IMAGE_SYM_TYPE_WORD = &h000D
const IMAGE_SYM_TYPE_UINT = &h000E
const IMAGE_SYM_TYPE_DWORD = &h000F
const IMAGE_SYM_TYPE_PCODE = &h8000
const IMAGE_SYM_DTYPE_NULL = 0
const IMAGE_SYM_DTYPE_POINTER = 1
const IMAGE_SYM_DTYPE_FUNCTION = 2
const IMAGE_SYM_DTYPE_ARRAY = 3
const IMAGE_SYM_CLASS_END_OF_FUNCTION = cast(UBYTE, -1)
const IMAGE_SYM_CLASS_NULL = &h0000
const IMAGE_SYM_CLASS_AUTOMATIC = &h0001
const IMAGE_SYM_CLASS_EXTERNAL = &h0002
const IMAGE_SYM_CLASS_STATIC = &h0003
const IMAGE_SYM_CLASS_REGISTER = &h0004
const IMAGE_SYM_CLASS_EXTERNAL_DEF = &h0005
const IMAGE_SYM_CLASS_LABEL = &h0006
const IMAGE_SYM_CLASS_UNDEFINED_LABEL = &h0007
const IMAGE_SYM_CLASS_MEMBER_OF_STRUCT = &h0008
const IMAGE_SYM_CLASS_ARGUMENT = &h0009
const IMAGE_SYM_CLASS_STRUCT_TAG = &h000A
const IMAGE_SYM_CLASS_MEMBER_OF_UNION = &h000B
const IMAGE_SYM_CLASS_UNION_TAG = &h000C
const IMAGE_SYM_CLASS_TYPE_DEFINITION = &h000D
const IMAGE_SYM_CLASS_UNDEFINED_STATIC = &h000E
const IMAGE_SYM_CLASS_ENUM_TAG = &h000F
const IMAGE_SYM_CLASS_MEMBER_OF_ENUM = &h0010
const IMAGE_SYM_CLASS_REGISTER_PARAM = &h0011
const IMAGE_SYM_CLASS_BIT_FIELD = &h0012
const IMAGE_SYM_CLASS_FAR_EXTERNAL = &h0044
const IMAGE_SYM_CLASS_BLOCK = &h0064
const IMAGE_SYM_CLASS_FUNCTION = &h0065
const IMAGE_SYM_CLASS_END_OF_STRUCT = &h0066
const IMAGE_SYM_CLASS_FILE = &h0067
const IMAGE_SYM_CLASS_SECTION = &h0068
const IMAGE_SYM_CLASS_WEAK_EXTERNAL = &h0069
const IMAGE_SYM_CLASS_CLR_TOKEN = &h006B
const N_BTMASK = &h000F
const N_TMASK = &h0030
const N_TMASK1 = &h00C0
const N_TMASK2 = &h00F0
const N_BTSHFT = 4
const N_TSHIFT = 2
#define BTYPE(x) ((x) and N_BTMASK)
#define ISPTR(x) (((x) and N_TMASK) = (IMAGE_SYM_DTYPE_POINTER shl N_BTSHFT))
#define ISFCN(x) (((x) and N_TMASK) = (IMAGE_SYM_DTYPE_FUNCTION shl N_BTSHFT))
#define ISARY(x) (((x) and N_TMASK) = (IMAGE_SYM_DTYPE_ARRAY shl N_BTSHFT))
#define ISTAG(x) ((((x) = IMAGE_SYM_CLASS_STRUCT_TAG) orelse ((x) = IMAGE_SYM_CLASS_UNION_TAG)) orelse ((x) = IMAGE_SYM_CLASS_ENUM_TAG))
#define INCREF(x) (((((x) and (not N_BTMASK)) shl N_TSHIFT) or (IMAGE_SYM_DTYPE_POINTER shl N_BTSHFT)) or ((x) and N_BTMASK))
#define DECREF(x) ((((x) shr N_TSHIFT) and (not N_BTMASK)) or ((x) and N_BTMASK))

type IMAGE_AUX_SYMBOL_TOKEN_DEF field = 2
	bAuxType as UBYTE
	bReserved as UBYTE
	SymbolTableIndex as DWORD
	rgbReserved(0 to 11) as UBYTE
end type

type PIMAGE_AUX_SYMBOL_TOKEN_DEF as IMAGE_AUX_SYMBOL_TOKEN_DEF ptr

type _IMAGE_AUX_SYMBOL_Sym_Misc_LnSz field = 2
	Linenumber as WORD
	Size as WORD
end type

union _IMAGE_AUX_SYMBOL_Sym_Misc field = 2
	LnSz as _IMAGE_AUX_SYMBOL_Sym_Misc_LnSz
	TotalSize as DWORD
end union

type _IMAGE_AUX_SYMBOL_Sym_FcnAry_Function field = 2
	PointerToLinenumber as DWORD
	PointerToNextFunction as DWORD
end type

type _IMAGE_AUX_SYMBOL_Sym_FcnAry_Array field = 2
	Dimension(0 to 3) as WORD
end type

union _IMAGE_AUX_SYMBOL_Sym_FcnAry field = 2
	Function as _IMAGE_AUX_SYMBOL_Sym_FcnAry_Function
	Array as _IMAGE_AUX_SYMBOL_Sym_FcnAry_Array
end union

type _IMAGE_AUX_SYMBOL_Sym field = 2
	TagIndex as DWORD
	Misc as _IMAGE_AUX_SYMBOL_Sym_Misc
	FcnAry as _IMAGE_AUX_SYMBOL_Sym_FcnAry
	TvIndex as WORD
end type

type _IMAGE_AUX_SYMBOL_File field = 2
	Name(0 to 17) as UBYTE
end type

type _IMAGE_AUX_SYMBOL_Section field = 2
	Length as DWORD
	NumberOfRelocations as WORD
	NumberOfLinenumbers as WORD
	CheckSum as DWORD
	Number as SHORT
	Selection as UBYTE
end type

type _IMAGE_AUX_SYMBOL_CRC field = 2
	crc as DWORD
	rgbReserved(0 to 13) as UBYTE
end type

union _IMAGE_AUX_SYMBOL field = 2
	Sym as _IMAGE_AUX_SYMBOL_Sym
	File as _IMAGE_AUX_SYMBOL_File
	Section as _IMAGE_AUX_SYMBOL_Section
	TokenDef as IMAGE_AUX_SYMBOL_TOKEN_DEF
	CRC as _IMAGE_AUX_SYMBOL_CRC
end union

type IMAGE_AUX_SYMBOL as _IMAGE_AUX_SYMBOL
type PIMAGE_AUX_SYMBOL as _IMAGE_AUX_SYMBOL ptr

type _IMAGE_AUX_SYMBOL_EX_Sym field = 2
	WeakDefaultSymIndex as DWORD
	WeakSearchType as DWORD
	rgbReserved(0 to 11) as UBYTE
end type

type _IMAGE_AUX_SYMBOL_EX_File field = 2
	Name(0 to sizeof(IMAGE_SYMBOL_EX) - 1) as UBYTE
end type

type _IMAGE_AUX_SYMBOL_EX_Section field = 2
	Length as DWORD
	NumberOfRelocations as WORD
	NumberOfLinenumbers as WORD
	CheckSum as DWORD
	Number as SHORT
	Selection as UBYTE
	bReserved as UBYTE
	HighNumber as SHORT
	rgbReserved(0 to 1) as UBYTE
end type

type _IMAGE_AUX_SYMBOL_EX_CRC field = 2
	crc as DWORD
	rgbReserved(0 to 15) as UBYTE
end type

union _IMAGE_AUX_SYMBOL_EX field = 2
	Sym as _IMAGE_AUX_SYMBOL_EX_Sym
	File as _IMAGE_AUX_SYMBOL_EX_File
	Section as _IMAGE_AUX_SYMBOL_EX_Section

	type field = 2
		TokenDef as IMAGE_AUX_SYMBOL_TOKEN_DEF
		rgbReserved(0 to 1) as UBYTE
	end type

	CRC as _IMAGE_AUX_SYMBOL_EX_CRC
end union

type IMAGE_AUX_SYMBOL_EX as _IMAGE_AUX_SYMBOL_EX
type PIMAGE_AUX_SYMBOL_EX as _IMAGE_AUX_SYMBOL_EX ptr
const IMAGE_SIZEOF_AUX_SYMBOL = 18

type IMAGE_AUX_SYMBOL_TYPE as long
enum
	IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF = 1
end enum

const IMAGE_COMDAT_SELECT_NODUPLICATES = 1
const IMAGE_COMDAT_SELECT_ANY = 2
const IMAGE_COMDAT_SELECT_SAME_SIZE = 3
const IMAGE_COMDAT_SELECT_EXACT_MATCH = 4
const IMAGE_COMDAT_SELECT_ASSOCIATIVE = 5
const IMAGE_COMDAT_SELECT_LARGEST = 6
const IMAGE_COMDAT_SELECT_NEWEST = 7
const IMAGE_WEAK_EXTERN_SEARCH_NOLIBRARY = 1
const IMAGE_WEAK_EXTERN_SEARCH_LIBRARY = 2
const IMAGE_WEAK_EXTERN_SEARCH_ALIAS = 3

type _IMAGE_RELOCATION field = 2
	union field = 2
		VirtualAddress as DWORD
		RelocCount as DWORD
	end union

	SymbolTableIndex as DWORD
	as WORD Type
end type

type IMAGE_RELOCATION as _IMAGE_RELOCATION
type PIMAGE_RELOCATION as IMAGE_RELOCATION ptr
const IMAGE_SIZEOF_RELOCATION = 10
const IMAGE_REL_I386_ABSOLUTE = &h0000
const IMAGE_REL_I386_DIR16 = &h0001
const IMAGE_REL_I386_REL16 = &h0002
const IMAGE_REL_I386_DIR32 = &h0006
const IMAGE_REL_I386_DIR32NB = &h0007
const IMAGE_REL_I386_SEG12 = &h0009
const IMAGE_REL_I386_SECTION = &h000A
const IMAGE_REL_I386_SECREL = &h000B
const IMAGE_REL_I386_TOKEN = &h000C
const IMAGE_REL_I386_SECREL7 = &h000D
const IMAGE_REL_I386_REL32 = &h0014
const IMAGE_REL_MIPS_ABSOLUTE = &h0000
const IMAGE_REL_MIPS_REFHALF = &h0001
const IMAGE_REL_MIPS_REFWORD = &h0002
const IMAGE_REL_MIPS_JMPADDR = &h0003
const IMAGE_REL_MIPS_REFHI = &h0004
const IMAGE_REL_MIPS_REFLO = &h0005
const IMAGE_REL_MIPS_GPREL = &h0006
const IMAGE_REL_MIPS_LITERAL = &h0007
const IMAGE_REL_MIPS_SECTION = &h000A
const IMAGE_REL_MIPS_SECREL = &h000B
const IMAGE_REL_MIPS_SECRELLO = &h000C
const IMAGE_REL_MIPS_SECRELHI = &h000D
const IMAGE_REL_MIPS_TOKEN = &h000E
const IMAGE_REL_MIPS_JMPADDR16 = &h0010
const IMAGE_REL_MIPS_REFWORDNB = &h0022
const IMAGE_REL_MIPS_PAIR = &h0025
const IMAGE_REL_ALPHA_ABSOLUTE = &h0000
const IMAGE_REL_ALPHA_REFLONG = &h0001
const IMAGE_REL_ALPHA_REFQUAD = &h0002
const IMAGE_REL_ALPHA_GPREL32 = &h0003
const IMAGE_REL_ALPHA_LITERAL = &h0004
const IMAGE_REL_ALPHA_LITUSE = &h0005
const IMAGE_REL_ALPHA_GPDISP = &h0006
const IMAGE_REL_ALPHA_BRADDR = &h0007
const IMAGE_REL_ALPHA_HINT = &h0008
const IMAGE_REL_ALPHA_INLINE_REFLONG = &h0009
const IMAGE_REL_ALPHA_REFHI = &h000A
const IMAGE_REL_ALPHA_REFLO = &h000B
const IMAGE_REL_ALPHA_PAIR = &h000C
const IMAGE_REL_ALPHA_MATCH = &h000D
const IMAGE_REL_ALPHA_SECTION = &h000E
const IMAGE_REL_ALPHA_SECREL = &h000F
const IMAGE_REL_ALPHA_REFLONGNB = &h0010
const IMAGE_REL_ALPHA_SECRELLO = &h0011
const IMAGE_REL_ALPHA_SECRELHI = &h0012
const IMAGE_REL_ALPHA_REFQ3 = &h0013
const IMAGE_REL_ALPHA_REFQ2 = &h0014
const IMAGE_REL_ALPHA_REFQ1 = &h0015
const IMAGE_REL_ALPHA_GPRELLO = &h0016
const IMAGE_REL_ALPHA_GPRELHI = &h0017
const IMAGE_REL_PPC_ABSOLUTE = &h0000
const IMAGE_REL_PPC_ADDR64 = &h0001
const IMAGE_REL_PPC_ADDR32 = &h0002
const IMAGE_REL_PPC_ADDR24 = &h0003
const IMAGE_REL_PPC_ADDR16 = &h0004
const IMAGE_REL_PPC_ADDR14 = &h0005
const IMAGE_REL_PPC_REL24 = &h0006
const IMAGE_REL_PPC_REL14 = &h0007
const IMAGE_REL_PPC_TOCREL16 = &h0008
const IMAGE_REL_PPC_TOCREL14 = &h0009
const IMAGE_REL_PPC_ADDR32NB = &h000A
const IMAGE_REL_PPC_SECREL = &h000B
const IMAGE_REL_PPC_SECTION = &h000C
const IMAGE_REL_PPC_IFGLUE = &h000D
const IMAGE_REL_PPC_IMGLUE = &h000E
const IMAGE_REL_PPC_SECREL16 = &h000F
const IMAGE_REL_PPC_REFHI = &h0010
const IMAGE_REL_PPC_REFLO = &h0011
const IMAGE_REL_PPC_PAIR = &h0012
const IMAGE_REL_PPC_SECRELLO = &h0013
const IMAGE_REL_PPC_SECRELHI = &h0014
const IMAGE_REL_PPC_GPREL = &h0015
const IMAGE_REL_PPC_TOKEN = &h0016
const IMAGE_REL_PPC_TYPEMASK = &h00FF
const IMAGE_REL_PPC_NEG = &h0100
const IMAGE_REL_PPC_BRTAKEN = &h0200
const IMAGE_REL_PPC_BRNTAKEN = &h0400
const IMAGE_REL_PPC_TOCDEFN = &h0800
const IMAGE_REL_SH3_ABSOLUTE = &h0000
const IMAGE_REL_SH3_DIRECT16 = &h0001
const IMAGE_REL_SH3_DIRECT32 = &h0002
const IMAGE_REL_SH3_DIRECT8 = &h0003
const IMAGE_REL_SH3_DIRECT8_WORD = &h0004
const IMAGE_REL_SH3_DIRECT8_LONG = &h0005
const IMAGE_REL_SH3_DIRECT4 = &h0006
const IMAGE_REL_SH3_DIRECT4_WORD = &h0007
const IMAGE_REL_SH3_DIRECT4_LONG = &h0008
const IMAGE_REL_SH3_PCREL8_WORD = &h0009
const IMAGE_REL_SH3_PCREL8_LONG = &h000A
const IMAGE_REL_SH3_PCREL12_WORD = &h000B
const IMAGE_REL_SH3_STARTOF_SECTION = &h000C
const IMAGE_REL_SH3_SIZEOF_SECTION = &h000D
const IMAGE_REL_SH3_SECTION = &h000E
const IMAGE_REL_SH3_SECREL = &h000F
const IMAGE_REL_SH3_DIRECT32_NB = &h0010
const IMAGE_REL_SH3_GPREL4_LONG = &h0011
const IMAGE_REL_SH3_TOKEN = &h0012
const IMAGE_REL_SHM_PCRELPT = &h0013
const IMAGE_REL_SHM_REFLO = &h0014
const IMAGE_REL_SHM_REFHALF = &h0015
const IMAGE_REL_SHM_RELLO = &h0016
const IMAGE_REL_SHM_RELHALF = &h0017
const IMAGE_REL_SHM_PAIR = &h0018
const IMAGE_REL_SH_NOMODE = &h8000
const IMAGE_REL_ARM_ABSOLUTE = &h0000
const IMAGE_REL_ARM_ADDR32 = &h0001
const IMAGE_REL_ARM_ADDR32NB = &h0002
const IMAGE_REL_ARM_BRANCH24 = &h0003
const IMAGE_REL_ARM_BRANCH11 = &h0004
const IMAGE_REL_ARM_TOKEN = &h0005
const IMAGE_REL_ARM_GPREL12 = &h0006
const IMAGE_REL_ARM_GPREL7 = &h0007
const IMAGE_REL_ARM_BLX24 = &h0008
const IMAGE_REL_ARM_BLX11 = &h0009
const IMAGE_REL_ARM_SECTION = &h000E
const IMAGE_REL_ARM_SECREL = &h000F
const IMAGE_REL_ARM_MOV32A = &h0010
const IMAGE_REL_ARM_MOV32 = &h0010
const IMAGE_REL_ARM_MOV32T = &h0011
const IMAGE_REL_THUMB_MOV32 = &h0011
const IMAGE_REL_ARM_BRANCH20T = &h0012
const IMAGE_REL_THUMB_BRANCH20 = &h0012
const IMAGE_REL_ARM_BRANCH24T = &h0014
const IMAGE_REL_THUMB_BRANCH24 = &h0014
const IMAGE_REL_ARM_BLX23T = &h0015
const IMAGE_REL_THUMB_BLX23 = &h0015
const IMAGE_REL_AM_ABSOLUTE = &h0000
const IMAGE_REL_AM_ADDR32 = &h0001
const IMAGE_REL_AM_ADDR32NB = &h0002
const IMAGE_REL_AM_CALL32 = &h0003
const IMAGE_REL_AM_FUNCINFO = &h0004
const IMAGE_REL_AM_REL32_1 = &h0005
const IMAGE_REL_AM_REL32_2 = &h0006
const IMAGE_REL_AM_SECREL = &h0007
const IMAGE_REL_AM_SECTION = &h0008
const IMAGE_REL_AM_TOKEN = &h0009
const IMAGE_REL_AMD64_ABSOLUTE = &h0000
const IMAGE_REL_AMD64_ADDR64 = &h0001
const IMAGE_REL_AMD64_ADDR32 = &h0002
const IMAGE_REL_AMD64_ADDR32NB = &h0003
const IMAGE_REL_AMD64_REL32 = &h0004
const IMAGE_REL_AMD64_REL32_1 = &h0005
const IMAGE_REL_AMD64_REL32_2 = &h0006
const IMAGE_REL_AMD64_REL32_3 = &h0007
const IMAGE_REL_AMD64_REL32_4 = &h0008
const IMAGE_REL_AMD64_REL32_5 = &h0009
const IMAGE_REL_AMD64_SECTION = &h000A
const IMAGE_REL_AMD64_SECREL = &h000B
const IMAGE_REL_AMD64_SECREL7 = &h000C
const IMAGE_REL_AMD64_TOKEN = &h000D
const IMAGE_REL_AMD64_SREL32 = &h000E
const IMAGE_REL_AMD64_PAIR = &h000F
const IMAGE_REL_AMD64_SSPAN32 = &h0010
const IMAGE_REL_IA64_ABSOLUTE = &h0000
const IMAGE_REL_IA64_IMM14 = &h0001
const IMAGE_REL_IA64_IMM22 = &h0002
const IMAGE_REL_IA64_IMM64 = &h0003
const IMAGE_REL_IA64_DIR32 = &h0004
const IMAGE_REL_IA64_DIR64 = &h0005
const IMAGE_REL_IA64_PCREL21B = &h0006
const IMAGE_REL_IA64_PCREL21M = &h0007
const IMAGE_REL_IA64_PCREL21F = &h0008
const IMAGE_REL_IA64_GPREL22 = &h0009
const IMAGE_REL_IA64_LTOFF22 = &h000A
const IMAGE_REL_IA64_SECTION = &h000B
const IMAGE_REL_IA64_SECREL22 = &h000C
const IMAGE_REL_IA64_SECREL64I = &h000D
const IMAGE_REL_IA64_SECREL32 = &h000E
const IMAGE_REL_IA64_DIR32NB = &h0010
const IMAGE_REL_IA64_SREL14 = &h0011
const IMAGE_REL_IA64_SREL22 = &h0012
const IMAGE_REL_IA64_SREL32 = &h0013
const IMAGE_REL_IA64_UREL32 = &h0014
const IMAGE_REL_IA64_PCREL60X = &h0015
const IMAGE_REL_IA64_PCREL60B = &h0016
const IMAGE_REL_IA64_PCREL60F = &h0017
const IMAGE_REL_IA64_PCREL60I = &h0018
const IMAGE_REL_IA64_PCREL60M = &h0019
const IMAGE_REL_IA64_IMMGPREL64 = &h001A
const IMAGE_REL_IA64_TOKEN = &h001B
const IMAGE_REL_IA64_GPREL32 = &h001C
const IMAGE_REL_IA64_ADDEND = &h001F
const IMAGE_REL_CEF_ABSOLUTE = &h0000
const IMAGE_REL_CEF_ADDR32 = &h0001
const IMAGE_REL_CEF_ADDR64 = &h0002
const IMAGE_REL_CEF_ADDR32NB = &h0003
const IMAGE_REL_CEF_SECTION = &h0004
const IMAGE_REL_CEF_SECREL = &h0005
const IMAGE_REL_CEF_TOKEN = &h0006
const IMAGE_REL_CEE_ABSOLUTE = &h0000
const IMAGE_REL_CEE_ADDR32 = &h0001
const IMAGE_REL_CEE_ADDR64 = &h0002
const IMAGE_REL_CEE_ADDR32NB = &h0003
const IMAGE_REL_CEE_SECTION = &h0004
const IMAGE_REL_CEE_SECREL = &h0005
const IMAGE_REL_CEE_TOKEN = &h0006
const IMAGE_REL_M32R_ABSOLUTE = &h0000
const IMAGE_REL_M32R_ADDR32 = &h0001
const IMAGE_REL_M32R_ADDR32NB = &h0002
const IMAGE_REL_M32R_ADDR24 = &h0003
const IMAGE_REL_M32R_GPREL16 = &h0004
const IMAGE_REL_M32R_PCREL24 = &h0005
const IMAGE_REL_M32R_PCREL16 = &h0006
const IMAGE_REL_M32R_PCREL8 = &h0007
const IMAGE_REL_M32R_REFHALF = &h0008
const IMAGE_REL_M32R_REFHI = &h0009
const IMAGE_REL_M32R_REFLO = &h000A
const IMAGE_REL_M32R_PAIR = &h000B
const IMAGE_REL_M32R_SECTION = &h000C
const IMAGE_REL_M32R_SECREL32 = &h000D
const IMAGE_REL_M32R_TOKEN = &h000E
const IMAGE_REL_EBC_ABSOLUTE = &h0000
const IMAGE_REL_EBC_ADDR32NB = &h0001
const IMAGE_REL_EBC_REL32 = &h0002
const IMAGE_REL_EBC_SECTION = &h0003
const IMAGE_REL_EBC_SECREL = &h0004
#define EXT_IMM64(Value, Address, Size, InstPos, ValPos) scope : Value or= cast(ULONGLONG, ((*(Address)) shr InstPos) and ((cast(ULONGLONG, 1) shl Size) - 1)) shl ValPos : end scope
#define INS_IMM64(Value, Address, Size, InstPos, ValPos) scope : (*cast(PDWORD, Address)) = ((*cast(PDWORD, Address)) and (not (((1 shl Size) - 1) shl InstPos))) or (cast(DWORD, (cast(ULONGLONG, Value) shr ValPos) and ((cast(ULONGLONG, 1) shl Size) - 1)) shl InstPos) : end scope
const EMARCH_ENC_I17_IMM7B_INST_WORD_X = 3
const EMARCH_ENC_I17_IMM7B_SIZE_X = 7
const EMARCH_ENC_I17_IMM7B_INST_WORD_POS_X = 4
const EMARCH_ENC_I17_IMM7B_VAL_POS_X = 0
const EMARCH_ENC_I17_IMM9D_INST_WORD_X = 3
const EMARCH_ENC_I17_IMM9D_SIZE_X = 9
const EMARCH_ENC_I17_IMM9D_INST_WORD_POS_X = 18
const EMARCH_ENC_I17_IMM9D_VAL_POS_X = 7
const EMARCH_ENC_I17_IMM5C_INST_WORD_X = 3
const EMARCH_ENC_I17_IMM5C_SIZE_X = 5
const EMARCH_ENC_I17_IMM5C_INST_WORD_POS_X = 13
const EMARCH_ENC_I17_IMM5C_VAL_POS_X = 16
const EMARCH_ENC_I17_IC_INST_WORD_X = 3
const EMARCH_ENC_I17_IC_SIZE_X = 1
const EMARCH_ENC_I17_IC_INST_WORD_POS_X = 12
const EMARCH_ENC_I17_IC_VAL_POS_X = 21
const EMARCH_ENC_I17_IMM41a_INST_WORD_X = 1
const EMARCH_ENC_I17_IMM41a_SIZE_X = 10
const EMARCH_ENC_I17_IMM41a_INST_WORD_POS_X = 14
const EMARCH_ENC_I17_IMM41a_VAL_POS_X = 22
const EMARCH_ENC_I17_IMM41b_INST_WORD_X = 1
const EMARCH_ENC_I17_IMM41b_SIZE_X = 8
const EMARCH_ENC_I17_IMM41b_INST_WORD_POS_X = 24
const EMARCH_ENC_I17_IMM41b_VAL_POS_X = 32
const EMARCH_ENC_I17_IMM41c_INST_WORD_X = 2
const EMARCH_ENC_I17_IMM41c_SIZE_X = 23
const EMARCH_ENC_I17_IMM41c_INST_WORD_POS_X = 0
const EMARCH_ENC_I17_IMM41c_VAL_POS_X = 40
const EMARCH_ENC_I17_SIGN_INST_WORD_X = 3
const EMARCH_ENC_I17_SIGN_SIZE_X = 1
const EMARCH_ENC_I17_SIGN_INST_WORD_POS_X = 27
const EMARCH_ENC_I17_SIGN_VAL_POS_X = 63
const X3_OPCODE_INST_WORD_X = 3
const X3_OPCODE_SIZE_X = 4
const X3_OPCODE_INST_WORD_POS_X = 28
const X3_OPCODE_SIGN_VAL_POS_X = 0
const X3_I_INST_WORD_X = 3
const X3_I_SIZE_X = 1
const X3_I_INST_WORD_POS_X = 27
const X3_I_SIGN_VAL_POS_X = 59
const X3_D_WH_INST_WORD_X = 3
const X3_D_WH_SIZE_X = 3
const X3_D_WH_INST_WORD_POS_X = 24
const X3_D_WH_SIGN_VAL_POS_X = 0
const X3_IMM20_INST_WORD_X = 3
const X3_IMM20_SIZE_X = 20
const X3_IMM20_INST_WORD_POS_X = 4
const X3_IMM20_SIGN_VAL_POS_X = 0
const X3_IMM39_1_INST_WORD_X = 2
const X3_IMM39_1_SIZE_X = 23
const X3_IMM39_1_INST_WORD_POS_X = 0
const X3_IMM39_1_SIGN_VAL_POS_X = 36
const X3_IMM39_2_INST_WORD_X = 1
const X3_IMM39_2_SIZE_X = 16
const X3_IMM39_2_INST_WORD_POS_X = 16
const X3_IMM39_2_SIGN_VAL_POS_X = 20
const X3_P_INST_WORD_X = 3
const X3_P_SIZE_X = 4
const X3_P_INST_WORD_POS_X = 0
const X3_P_SIGN_VAL_POS_X = 0
const X3_TMPLT_INST_WORD_X = 0
const X3_TMPLT_SIZE_X = 4
const X3_TMPLT_INST_WORD_POS_X = 0
const X3_TMPLT_SIGN_VAL_POS_X = 0
const X3_BTYPE_QP_INST_WORD_X = 2
const X3_BTYPE_QP_SIZE_X = 9
const X3_BTYPE_QP_INST_WORD_POS_X = 23
const X3_BTYPE_QP_INST_VAL_POS_X = 0
const X3_EMPTY_INST_WORD_X = 1
const X3_EMPTY_SIZE_X = 2
const X3_EMPTY_INST_WORD_POS_X = 14
const X3_EMPTY_INST_VAL_POS_X = 0

union _IMAGE_LINENUMBER_Type field = 2
	SymbolTableIndex as DWORD
	VirtualAddress as DWORD
end union

type _IMAGE_LINENUMBER field = 2
	as _IMAGE_LINENUMBER_Type Type
	Linenumber as WORD
end type

type IMAGE_LINENUMBER as _IMAGE_LINENUMBER
type PIMAGE_LINENUMBER as IMAGE_LINENUMBER ptr
const IMAGE_SIZEOF_LINENUMBER = 6

type _IMAGE_BASE_RELOCATION field = 4
	VirtualAddress as DWORD
	SizeOfBlock as DWORD
end type

type IMAGE_BASE_RELOCATION as _IMAGE_BASE_RELOCATION
type PIMAGE_BASE_RELOCATION as IMAGE_BASE_RELOCATION ptr
const IMAGE_SIZEOF_BASE_RELOCATION = 8
const IMAGE_REL_BASED_ABSOLUTE = 0
const IMAGE_REL_BASED_HIGH = 1
const IMAGE_REL_BASED_LOW = 2
const IMAGE_REL_BASED_HIGHLOW = 3
const IMAGE_REL_BASED_HIGHADJ = 4
const IMAGE_REL_BASED_MIPS_JMPADDR = 5
const IMAGE_REL_BASED_ARM_MOV32 = 5
const IMAGE_REL_BASED_THUMB_MOV32 = 7
const IMAGE_REL_BASED_MIPS_JMPADDR16 = 9
const IMAGE_REL_BASED_IA64_IMM64 = 9
const IMAGE_REL_BASED_DIR64 = 10
const IMAGE_ARCHIVE_START_SIZE = 8
#define IMAGE_ARCHIVE_START !"!<arch>\n"
#define IMAGE_ARCHIVE_END !"`\n"
#define IMAGE_ARCHIVE_PAD !"\n"
#define IMAGE_ARCHIVE_LINKER_MEMBER "/               "
#define IMAGE_ARCHIVE_LONGNAMES_MEMBER "//              "

type _IMAGE_ARCHIVE_MEMBER_HEADER field = 4
	Name(0 to 15) as UBYTE
	Date(0 to 11) as UBYTE
	UserID(0 to 5) as UBYTE
	GroupID(0 to 5) as UBYTE
	Mode(0 to 7) as UBYTE
	Size(0 to 9) as UBYTE
	EndHeader(0 to 1) as UBYTE
end type

type IMAGE_ARCHIVE_MEMBER_HEADER as _IMAGE_ARCHIVE_MEMBER_HEADER
type PIMAGE_ARCHIVE_MEMBER_HEADER as _IMAGE_ARCHIVE_MEMBER_HEADER ptr
const IMAGE_SIZEOF_ARCHIVE_MEMBER_HDR = 60

type _IMAGE_EXPORT_DIRECTORY field = 4
	Characteristics as DWORD
	TimeDateStamp as DWORD
	MajorVersion as WORD
	MinorVersion as WORD
	Name as DWORD
	Base as DWORD
	NumberOfFunctions as DWORD
	NumberOfNames as DWORD
	AddressOfFunctions as DWORD
	AddressOfNames as DWORD
	AddressOfNameOrdinals as DWORD
end type

type IMAGE_EXPORT_DIRECTORY as _IMAGE_EXPORT_DIRECTORY
type PIMAGE_EXPORT_DIRECTORY as _IMAGE_EXPORT_DIRECTORY ptr

type _IMAGE_IMPORT_BY_NAME field = 4
	Hint as WORD
	Name(0 to 0) as UBYTE
end type

type IMAGE_IMPORT_BY_NAME as _IMAGE_IMPORT_BY_NAME
type PIMAGE_IMPORT_BY_NAME as _IMAGE_IMPORT_BY_NAME ptr

union _IMAGE_THUNK_DATA64_u1
	ForwarderString as ULONGLONG
	Function as ULONGLONG
	Ordinal as ULONGLONG
	AddressOfData as ULONGLONG
end union

type _IMAGE_THUNK_DATA64
	u1 as _IMAGE_THUNK_DATA64_u1
end type

type IMAGE_THUNK_DATA64 as _IMAGE_THUNK_DATA64
type PIMAGE_THUNK_DATA64 as IMAGE_THUNK_DATA64 ptr

union _IMAGE_THUNK_DATA32_u1 field = 4
	ForwarderString as DWORD
	Function as DWORD
	Ordinal as DWORD
	AddressOfData as DWORD
end union

type _IMAGE_THUNK_DATA32 field = 4
	u1 as _IMAGE_THUNK_DATA32_u1
end type

type IMAGE_THUNK_DATA32 as _IMAGE_THUNK_DATA32
type PIMAGE_THUNK_DATA32 as IMAGE_THUNK_DATA32 ptr
const IMAGE_ORDINAL_FLAG64 = &h8000000000000000ull
const IMAGE_ORDINAL_FLAG32 = &h80000000
#define IMAGE_ORDINAL64(Ordinal) (Ordinal and &hffffull)
#define IMAGE_ORDINAL32(Ordinal) (Ordinal and &hffff)
#define IMAGE_SNAP_BY_ORDINAL64(Ordinal) ((Ordinal and IMAGE_ORDINAL_FLAG64) <> 0)
#define IMAGE_SNAP_BY_ORDINAL32(Ordinal) ((Ordinal and IMAGE_ORDINAL_FLAG32) <> 0)
type PIMAGE_TLS_CALLBACK as sub(byval DllHandle as PVOID, byval Reason as DWORD, byval Reserved as PVOID)

type _IMAGE_TLS_DIRECTORY64 field = 4
	StartAddressOfRawData as ULONGLONG
	EndAddressOfRawData as ULONGLONG
	AddressOfIndex as ULONGLONG
	AddressOfCallBacks as ULONGLONG
	SizeOfZeroFill as DWORD
	Characteristics as DWORD
end type

type IMAGE_TLS_DIRECTORY64 as _IMAGE_TLS_DIRECTORY64
type PIMAGE_TLS_DIRECTORY64 as IMAGE_TLS_DIRECTORY64 ptr

type _IMAGE_TLS_DIRECTORY32 field = 4
	StartAddressOfRawData as DWORD
	EndAddressOfRawData as DWORD
	AddressOfIndex as DWORD
	AddressOfCallBacks as DWORD
	SizeOfZeroFill as DWORD
	Characteristics as DWORD
end type

type IMAGE_TLS_DIRECTORY32 as _IMAGE_TLS_DIRECTORY32
type PIMAGE_TLS_DIRECTORY32 as IMAGE_TLS_DIRECTORY32 ptr

#ifdef __FB_64BIT__
	const IMAGE_ORDINAL_FLAG = IMAGE_ORDINAL_FLAG64
	#define IMAGE_ORDINAL(Ordinal) IMAGE_ORDINAL64(Ordinal)
	type IMAGE_THUNK_DATA as IMAGE_THUNK_DATA64
	type PIMAGE_THUNK_DATA as PIMAGE_THUNK_DATA64
	#define IMAGE_SNAP_BY_ORDINAL(Ordinal) IMAGE_SNAP_BY_ORDINAL64(Ordinal)
	type IMAGE_TLS_DIRECTORY as IMAGE_TLS_DIRECTORY64
	type PIMAGE_TLS_DIRECTORY as PIMAGE_TLS_DIRECTORY64
#else
	const IMAGE_ORDINAL_FLAG = IMAGE_ORDINAL_FLAG32
	#define IMAGE_ORDINAL(Ordinal) IMAGE_ORDINAL32(Ordinal)
	type IMAGE_THUNK_DATA as IMAGE_THUNK_DATA32
	type PIMAGE_THUNK_DATA as PIMAGE_THUNK_DATA32
	#define IMAGE_SNAP_BY_ORDINAL(Ordinal) IMAGE_SNAP_BY_ORDINAL32(Ordinal)
	type IMAGE_TLS_DIRECTORY as IMAGE_TLS_DIRECTORY32
	type PIMAGE_TLS_DIRECTORY as PIMAGE_TLS_DIRECTORY32
#endif

type _IMAGE_IMPORT_DESCRIPTOR field = 4
	union field = 4
		Characteristics as DWORD
		OriginalFirstThunk as DWORD
	end union

	TimeDateStamp as DWORD
	ForwarderChain as DWORD
	Name as DWORD
	FirstThunk as DWORD
end type

type IMAGE_IMPORT_DESCRIPTOR as _IMAGE_IMPORT_DESCRIPTOR
type PIMAGE_IMPORT_DESCRIPTOR as IMAGE_IMPORT_DESCRIPTOR ptr

type _IMAGE_BOUND_IMPORT_DESCRIPTOR field = 4
	TimeDateStamp as DWORD
	OffsetModuleName as WORD
	NumberOfModuleForwarderRefs as WORD
end type

type IMAGE_BOUND_IMPORT_DESCRIPTOR as _IMAGE_BOUND_IMPORT_DESCRIPTOR
type PIMAGE_BOUND_IMPORT_DESCRIPTOR as _IMAGE_BOUND_IMPORT_DESCRIPTOR ptr

type _IMAGE_BOUND_FORWARDER_REF field = 4
	TimeDateStamp as DWORD
	OffsetModuleName as WORD
	Reserved as WORD
end type

type IMAGE_BOUND_FORWARDER_REF as _IMAGE_BOUND_FORWARDER_REF
type PIMAGE_BOUND_FORWARDER_REF as _IMAGE_BOUND_FORWARDER_REF ptr

union _IMAGE_DELAYLOAD_DESCRIPTOR_Attributes field = 4
	AllAttributes as DWORD

	type field = 4
		RvaBased : 1 as DWORD
		ReservedAttributes : 31 as DWORD
	end type
end union

type _IMAGE_DELAYLOAD_DESCRIPTOR field = 4
	Attributes as _IMAGE_DELAYLOAD_DESCRIPTOR_Attributes
	DllNameRVA as DWORD
	ModuleHandleRVA as DWORD
	ImportAddressTableRVA as DWORD
	ImportNameTableRVA as DWORD
	BoundImportAddressTableRVA as DWORD
	UnloadInformationTableRVA as DWORD
	TimeDateStamp as DWORD
end type

type IMAGE_DELAYLOAD_DESCRIPTOR as _IMAGE_DELAYLOAD_DESCRIPTOR
type PIMAGE_DELAYLOAD_DESCRIPTOR as _IMAGE_DELAYLOAD_DESCRIPTOR ptr
type PCIMAGE_DELAYLOAD_DESCRIPTOR as const IMAGE_DELAYLOAD_DESCRIPTOR ptr

type _IMAGE_RESOURCE_DIRECTORY field = 4
	Characteristics as DWORD
	TimeDateStamp as DWORD
	MajorVersion as WORD
	MinorVersion as WORD
	NumberOfNamedEntries as WORD
	NumberOfIdEntries as WORD
end type

type IMAGE_RESOURCE_DIRECTORY as _IMAGE_RESOURCE_DIRECTORY
type PIMAGE_RESOURCE_DIRECTORY as _IMAGE_RESOURCE_DIRECTORY ptr
const IMAGE_RESOURCE_NAME_IS_STRING = &h80000000
const IMAGE_RESOURCE_DATA_IS_DIRECTORY = &h80000000

type _IMAGE_RESOURCE_DIRECTORY_ENTRY field = 4
	union field = 4
		type field = 4
			NameOffset : 31 as DWORD
			NameIsString : 1 as DWORD
		end type

		Name as DWORD
		Id as WORD
	end union

	union field = 4
		OffsetToData as DWORD

		type field = 4
			OffsetToDirectory : 31 as DWORD
			DataIsDirectory : 1 as DWORD
		end type
	end union
end type

type IMAGE_RESOURCE_DIRECTORY_ENTRY as _IMAGE_RESOURCE_DIRECTORY_ENTRY
type PIMAGE_RESOURCE_DIRECTORY_ENTRY as _IMAGE_RESOURCE_DIRECTORY_ENTRY ptr

type _IMAGE_RESOURCE_DIRECTORY_STRING field = 4
	Length as WORD
	NameString as zstring * 1
end type

type IMAGE_RESOURCE_DIRECTORY_STRING as _IMAGE_RESOURCE_DIRECTORY_STRING
type PIMAGE_RESOURCE_DIRECTORY_STRING as _IMAGE_RESOURCE_DIRECTORY_STRING ptr

type _IMAGE_RESOURCE_DIR_STRING_U field = 4
	Length as WORD
	NameString as wstring * 1
end type

type IMAGE_RESOURCE_DIR_STRING_U as _IMAGE_RESOURCE_DIR_STRING_U
type PIMAGE_RESOURCE_DIR_STRING_U as _IMAGE_RESOURCE_DIR_STRING_U ptr

type _IMAGE_RESOURCE_DATA_ENTRY field = 4
	OffsetToData as DWORD
	Size as DWORD
	CodePage as DWORD
	Reserved as DWORD
end type

type IMAGE_RESOURCE_DATA_ENTRY as _IMAGE_RESOURCE_DATA_ENTRY
type PIMAGE_RESOURCE_DATA_ENTRY as _IMAGE_RESOURCE_DATA_ENTRY ptr

type IMAGE_LOAD_CONFIG_DIRECTORY32 field = 4
	Size as DWORD
	TimeDateStamp as DWORD
	MajorVersion as WORD
	MinorVersion as WORD
	GlobalFlagsClear as DWORD
	GlobalFlagsSet as DWORD
	CriticalSectionDefaultTimeout as DWORD
	DeCommitFreeBlockThreshold as DWORD
	DeCommitTotalFreeThreshold as DWORD
	LockPrefixTable as DWORD
	MaximumAllocationSize as DWORD
	VirtualMemoryThreshold as DWORD
	ProcessHeapFlags as DWORD
	ProcessAffinityMask as DWORD
	CSDVersion as WORD
	Reserved1 as WORD
	EditList as DWORD
	SecurityCookie as DWORD
	SEHandlerTable as DWORD
	SEHandlerCount as DWORD
end type

type PIMAGE_LOAD_CONFIG_DIRECTORY32 as IMAGE_LOAD_CONFIG_DIRECTORY32 ptr

type IMAGE_LOAD_CONFIG_DIRECTORY64 field = 4
	Size as DWORD
	TimeDateStamp as DWORD
	MajorVersion as WORD
	MinorVersion as WORD
	GlobalFlagsClear as DWORD
	GlobalFlagsSet as DWORD
	CriticalSectionDefaultTimeout as DWORD
	DeCommitFreeBlockThreshold as ULONGLONG
	DeCommitTotalFreeThreshold as ULONGLONG
	LockPrefixTable as ULONGLONG
	MaximumAllocationSize as ULONGLONG
	VirtualMemoryThreshold as ULONGLONG
	ProcessAffinityMask as ULONGLONG
	ProcessHeapFlags as DWORD
	CSDVersion as WORD
	Reserved1 as WORD
	EditList as ULONGLONG
	SecurityCookie as ULONGLONG
	SEHandlerTable as ULONGLONG
	SEHandlerCount as ULONGLONG
end type

type PIMAGE_LOAD_CONFIG_DIRECTORY64 as IMAGE_LOAD_CONFIG_DIRECTORY64 ptr

#ifdef __FB_64BIT__
	type IMAGE_LOAD_CONFIG_DIRECTORY as IMAGE_LOAD_CONFIG_DIRECTORY64
	type PIMAGE_LOAD_CONFIG_DIRECTORY as PIMAGE_LOAD_CONFIG_DIRECTORY64
#else
	type IMAGE_LOAD_CONFIG_DIRECTORY as IMAGE_LOAD_CONFIG_DIRECTORY32
	type PIMAGE_LOAD_CONFIG_DIRECTORY as PIMAGE_LOAD_CONFIG_DIRECTORY32
#endif

type _IMAGE_CE_RUNTIME_FUNCTION_ENTRY field = 4
	FuncStart as DWORD
	PrologLen : 8 as DWORD
	FuncLen : 22 as DWORD
	ThirtyTwoBit : 1 as DWORD
	ExceptionFlag : 1 as DWORD
end type

type IMAGE_CE_RUNTIME_FUNCTION_ENTRY as _IMAGE_CE_RUNTIME_FUNCTION_ENTRY
type PIMAGE_CE_RUNTIME_FUNCTION_ENTRY as _IMAGE_CE_RUNTIME_FUNCTION_ENTRY ptr

type _IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY field = 4
	BeginAddress as ULONGLONG
	EndAddress as ULONGLONG
	ExceptionHandler as ULONGLONG
	HandlerData as ULONGLONG
	PrologEndAddress as ULONGLONG
end type

type IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY as _IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY
type PIMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY as _IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY ptr

type _IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY field = 4
	BeginAddress as DWORD
	EndAddress as DWORD
	ExceptionHandler as DWORD
	HandlerData as DWORD
	PrologEndAddress as DWORD
end type

type IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY as _IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY
type PIMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY as _IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY ptr

type _IMAGE_ARM_RUNTIME_FUNCTION_ENTRY field = 4
	BeginAddress as DWORD

	union field = 4
		UnwindData as DWORD

		type field = 4
			Flag : 2 as DWORD
			FunctionLength : 11 as DWORD
			Ret : 2 as DWORD
			H : 1 as DWORD
			Reg : 3 as DWORD
			R : 1 as DWORD
			L : 1 as DWORD
			C : 1 as DWORD
			StackAdjust : 10 as DWORD
		end type
	end union
end type

type IMAGE_ARM_RUNTIME_FUNCTION_ENTRY as _IMAGE_ARM_RUNTIME_FUNCTION_ENTRY
type PIMAGE_ARM_RUNTIME_FUNCTION_ENTRY as _IMAGE_ARM_RUNTIME_FUNCTION_ENTRY ptr

type _IMAGE_RUNTIME_FUNCTION_ENTRY field = 4
	BeginAddress as DWORD
	EndAddress as DWORD

	union field = 4
		UnwindInfoAddress as DWORD
		UnwindData as DWORD
	end union
end type

type _PIMAGE_RUNTIME_FUNCTION_ENTRY as _IMAGE_RUNTIME_FUNCTION_ENTRY ptr
type IMAGE_IA64_RUNTIME_FUNCTION_ENTRY as _IMAGE_RUNTIME_FUNCTION_ENTRY
type PIMAGE_IA64_RUNTIME_FUNCTION_ENTRY as _PIMAGE_RUNTIME_FUNCTION_ENTRY
type IMAGE_RUNTIME_FUNCTION_ENTRY as _IMAGE_RUNTIME_FUNCTION_ENTRY
type PIMAGE_RUNTIME_FUNCTION_ENTRY as _PIMAGE_RUNTIME_FUNCTION_ENTRY

type _IMAGE_DEBUG_DIRECTORY field = 4
	Characteristics as DWORD
	TimeDateStamp as DWORD
	MajorVersion as WORD
	MinorVersion as WORD
	as DWORD Type
	SizeOfData as DWORD
	AddressOfRawData as DWORD
	PointerToRawData as DWORD
end type

type IMAGE_DEBUG_DIRECTORY as _IMAGE_DEBUG_DIRECTORY
type PIMAGE_DEBUG_DIRECTORY as _IMAGE_DEBUG_DIRECTORY ptr
const IMAGE_DEBUG_TYPE_UNKNOWN = 0
const IMAGE_DEBUG_TYPE_COFF = 1
const IMAGE_DEBUG_TYPE_CODEVIEW = 2
const IMAGE_DEBUG_TYPE_FPO = 3
const IMAGE_DEBUG_TYPE_MISC = 4
const IMAGE_DEBUG_TYPE_EXCEPTION = 5
const IMAGE_DEBUG_TYPE_FIXUP = 6
const IMAGE_DEBUG_TYPE_OMAP_TO_SRC = 7
const IMAGE_DEBUG_TYPE_OMAP_FROM_SRC = 8
const IMAGE_DEBUG_TYPE_BORLAND = 9
const IMAGE_DEBUG_TYPE_RESERVED10 = 10
const IMAGE_DEBUG_TYPE_CLSID = 11

type _IMAGE_COFF_SYMBOLS_HEADER field = 4
	NumberOfSymbols as DWORD
	LvaToFirstSymbol as DWORD
	NumberOfLinenumbers as DWORD
	LvaToFirstLinenumber as DWORD
	RvaToFirstByteOfCode as DWORD
	RvaToLastByteOfCode as DWORD
	RvaToFirstByteOfData as DWORD
	RvaToLastByteOfData as DWORD
end type

type IMAGE_COFF_SYMBOLS_HEADER as _IMAGE_COFF_SYMBOLS_HEADER
type PIMAGE_COFF_SYMBOLS_HEADER as _IMAGE_COFF_SYMBOLS_HEADER ptr
const FRAME_FPO = 0
const FRAME_TRAP = 1
const FRAME_TSS = 2
const FRAME_NONFPO = 3

type _FPO_DATA field = 4
	ulOffStart as DWORD
	cbProcSize as DWORD
	cdwLocals as DWORD
	cdwParams as WORD
	cbProlog : 8 as WORD
	cbRegs : 3 as WORD
	fHasSEH : 1 as WORD
	fUseBP : 1 as WORD
	reserved : 1 as WORD
	cbFrame : 2 as WORD
end type

type FPO_DATA as _FPO_DATA
type PFPO_DATA as _FPO_DATA ptr
const SIZEOF_RFPO_DATA = 16
const IMAGE_DEBUG_MISC_EXENAME = 1

type _IMAGE_DEBUG_MISC field = 4
	DataType as DWORD
	Length as DWORD
	Unicode_ as WINBOOLEAN
	Reserved(0 to 2) as UBYTE
	Data(0 to 0) as UBYTE
end type

type IMAGE_DEBUG_MISC as _IMAGE_DEBUG_MISC
type PIMAGE_DEBUG_MISC as _IMAGE_DEBUG_MISC ptr

type _IMAGE_FUNCTION_ENTRY field = 4
	StartingAddress as DWORD
	EndingAddress as DWORD
	EndOfPrologue as DWORD
end type

type IMAGE_FUNCTION_ENTRY as _IMAGE_FUNCTION_ENTRY
type PIMAGE_FUNCTION_ENTRY as _IMAGE_FUNCTION_ENTRY ptr

type _IMAGE_FUNCTION_ENTRY64 field = 4
	StartingAddress as ULONGLONG
	EndingAddress as ULONGLONG

	union field = 4
		EndOfPrologue as ULONGLONG
		UnwindInfoAddress as ULONGLONG
	end union
end type

type IMAGE_FUNCTION_ENTRY64 as _IMAGE_FUNCTION_ENTRY64
type PIMAGE_FUNCTION_ENTRY64 as _IMAGE_FUNCTION_ENTRY64 ptr

type _IMAGE_SEPARATE_DEBUG_HEADER field = 4
	Signature as WORD
	Flags as WORD
	Machine as WORD
	Characteristics as WORD
	TimeDateStamp as DWORD
	CheckSum as DWORD
	ImageBase as DWORD
	SizeOfImage as DWORD
	NumberOfSections as DWORD
	ExportedNamesSize as DWORD
	DebugDirectorySize as DWORD
	SectionAlignment as DWORD
	Reserved(0 to 1) as DWORD
end type

type IMAGE_SEPARATE_DEBUG_HEADER as _IMAGE_SEPARATE_DEBUG_HEADER
type PIMAGE_SEPARATE_DEBUG_HEADER as _IMAGE_SEPARATE_DEBUG_HEADER ptr

type _NON_PAGED_DEBUG_INFO field = 4
	Signature as WORD
	Flags as WORD
	Size as DWORD
	Machine as WORD
	Characteristics as WORD
	TimeDateStamp as DWORD
	CheckSum as DWORD
	SizeOfImage as DWORD
	ImageBase as ULONGLONG
end type

type NON_PAGED_DEBUG_INFO as _NON_PAGED_DEBUG_INFO
type PNON_PAGED_DEBUG_INFO as _NON_PAGED_DEBUG_INFO ptr
const IMAGE_SEPARATE_DEBUG_SIGNATURE = &h4944
const NON_PAGED_DEBUG_SIGNATURE = &h494E
const IMAGE_SEPARATE_DEBUG_FLAGS_MASK = &h8000
const IMAGE_SEPARATE_DEBUG_MISMATCH = &h8000

type _ImageArchitectureHeader field = 4
	AmaskValue : 1 as ulong
	Adummy1 : 7 as long
	AmaskShift : 8 as ulong
	Adummy2 : 16 as long
	FirstEntryRVA as DWORD
end type

type IMAGE_ARCHITECTURE_HEADER as _ImageArchitectureHeader
type PIMAGE_ARCHITECTURE_HEADER as _ImageArchitectureHeader ptr

type _ImageArchitectureEntry field = 4
	FixupInstRVA as DWORD
	NewInst as DWORD
end type

type IMAGE_ARCHITECTURE_ENTRY as _ImageArchitectureEntry
type PIMAGE_ARCHITECTURE_ENTRY as _ImageArchitectureEntry ptr
const IMPORT_OBJECT_HDR_SIG2 = &hffff

type IMPORT_OBJECT_HEADER
	Sig1 as WORD
	Sig2 as WORD
	Version as WORD
	Machine as WORD
	TimeDateStamp as DWORD
	SizeOfData as DWORD

	union
		Ordinal as WORD
		Hint as WORD
	end union

	as WORD Type : 2
	NameType : 3 as WORD
	Reserved : 11 as WORD
end type

type IMPORT_OBJECT_TYPE as long
enum
	IMPORT_OBJECT_CODE = 0
	IMPORT_OBJECT_DATA = 1
	IMPORT_OBJECT_CONST = 2
end enum

type IMPORT_OBJECT_NAME_TYPE as long
enum
	IMPORT_OBJECT_ORDINAL = 0
	IMPORT_OBJECT_NAME = 1
	IMPORT_OBJECT_NAME_NO_PREFIX = 2
	IMPORT_OBJECT_NAME_UNDECORATE = 3
end enum

#define __IMAGE_COR20_HEADER_DEFINED__

type ReplacesCorHdrNumericDefines as long
enum
	COMIMAGE_FLAGS_ILONLY = &h00000001
	COMIMAGE_FLAGS_32BITREQUIRED = &h00000002
	COMIMAGE_FLAGS_IL_LIBRARY = &h00000004
	COMIMAGE_FLAGS_STRONGNAMESIGNED = &h00000008
	COMIMAGE_FLAGS_TRACKDEBUGDATA = &h00010000
	COR_VERSION_MAJOR_V2 = 2
	COR_VERSION_MAJOR = COR_VERSION_MAJOR_V2
	COR_VERSION_MINOR = 0
	COR_DELETED_NAME_LENGTH = 8
	COR_VTABLEGAP_NAME_LENGTH = 8
	NATIVE_TYPE_MAX_CB = 1
	COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE = &hFF
	IMAGE_COR_MIH_METHODRVA = &h01
	IMAGE_COR_MIH_EHRVA = &h02
	IMAGE_COR_MIH_BASICBLOCK = &h08
	COR_VTABLE_32BIT = &h01
	COR_VTABLE_64BIT = &h02
	COR_VTABLE_FROM_UNMANAGED = &h04
	COR_VTABLE_CALL_MOST_DERIVED = &h10
	IMAGE_COR_EATJ_THUNK_SIZE = 32
	MAX_CLASS_NAME = 1024
	MAX_PACKAGE_NAME = 1024
end enum

type IMAGE_COR20_HEADER
	cb as DWORD
	MajorRuntimeVersion as WORD
	MinorRuntimeVersion as WORD
	MetaData as IMAGE_DATA_DIRECTORY
	Flags as DWORD

	union
		EntryPointToken as DWORD
		EntryPointRVA as DWORD
	end union

	Resources as IMAGE_DATA_DIRECTORY
	StrongNameSignature as IMAGE_DATA_DIRECTORY
	CodeManagerTable as IMAGE_DATA_DIRECTORY
	VTableFixups as IMAGE_DATA_DIRECTORY
	ExportAddressTableJumps as IMAGE_DATA_DIRECTORY
	ManagedNativeHeader as IMAGE_DATA_DIRECTORY
end type

type PIMAGE_COR20_HEADER as IMAGE_COR20_HEADER ptr
declare function RtlCaptureStackBackTrace(byval FramesToSkip as DWORD, byval FramesToCapture as DWORD, byval BackTrace as PVOID ptr, byval BackTraceHash as PDWORD) as WORD
declare sub RtlCaptureContext(byval ContextRecord as PCONTEXT)
declare function RtlCompareMemory(byval Source1 as const any ptr, byval Source2 as const any ptr, byval Length as SIZE_T_) as SIZE_T_

#ifdef __FB_64BIT__
	#if _WIN32_WINNT = &h0602
		declare function RtlAddGrowableFunctionTable(byval DynamicTable as PVOID ptr, byval FunctionTable as PRUNTIME_FUNCTION, byval EntryCount as DWORD, byval MaximumEntryCount as DWORD, byval RangeBase as ULONG_PTR, byval RangeEnd as ULONG_PTR) as DWORD
		declare sub RtlGrowFunctionTable(byval DynamicTable as PVOID, byval NewEntryCount as DWORD)
		declare sub RtlDeleteGrowableFunctionTable(byval DynamicTable as PVOID)
	#endif

	declare function RtlAddFunctionTable(byval FunctionTable as PRUNTIME_FUNCTION, byval EntryCount as DWORD, byval BaseAddress as DWORD64) as WINBOOLEAN
	declare function RtlDeleteFunctionTable(byval FunctionTable as PRUNTIME_FUNCTION) as WINBOOLEAN
	declare function RtlInstallFunctionTableCallback(byval TableIdentifier as DWORD64, byval BaseAddress as DWORD64, byval Length as DWORD, byval Callback as PGET_RUNTIME_FUNCTION_CALLBACK, byval Context as PVOID, byval OutOfProcessCallbackDll as PCWSTR) as WINBOOLEAN
	declare sub RtlRestoreContext(byval ContextRecord as PCONTEXT, byval ExceptionRecord as _EXCEPTION_RECORD ptr)
	declare function RtlVirtualUnwind(byval HandlerType as DWORD, byval ImageBase as DWORD64, byval ControlPc as DWORD64, byval FunctionEntry as PRUNTIME_FUNCTION, byval ContextRecord as PCONTEXT, byval HandlerData as PVOID ptr, byval EstablisherFrame as PDWORD64, byval ContextPointers as PKNONVOLATILE_CONTEXT_POINTERS) as PEXCEPTION_ROUTINE
#endif

declare sub RtlUnwind(byval TargetFrame as PVOID, byval TargetIp as PVOID, byval ExceptionRecord as PEXCEPTION_RECORD, byval ReturnValue as PVOID)
declare function RtlPcToFileHeader(byval PcValue as PVOID, byval BaseOfImage as PVOID ptr) as PVOID

#ifdef __FB_64BIT__
	declare function RtlLookupFunctionEntry(byval ControlPc as DWORD64, byval ImageBase as PDWORD64, byval HistoryTable as PUNWIND_HISTORY_TABLE) as PRUNTIME_FUNCTION
	declare sub RtlUnwindEx(byval TargetFrame as PVOID, byval TargetIp as PVOID, byval ExceptionRecord as PEXCEPTION_RECORD, byval ReturnValue as PVOID, byval ContextRecord as PCONTEXT, byval HistoryTable as PUNWIND_HISTORY_TABLE)
#endif

#define _SLIST_HEADER_

#ifdef __FB_64BIT__
	type _SLIST_ENTRY
		Next as _SLIST_ENTRY ptr
	end type

	type SLIST_ENTRY as _SLIST_ENTRY
	type PSLIST_ENTRY as _SLIST_ENTRY ptr

	type _SLIST_HEADER_Header8
		Depth : 16 as ULONGLONG
		Sequence : 9 as ULONGLONG
		NextEntry : 39 as ULONGLONG
		HeaderType : 1 as ULONGLONG
		Init : 1 as ULONGLONG
		Reserved : 59 as ULONGLONG
		Region : 3 as ULONGLONG
	end type

	type _SLIST_HEADER_HeaderX64
		Depth : 16 as ULONGLONG
		Sequence : 48 as ULONGLONG
		HeaderType : 1 as ULONGLONG
		Reserved : 3 as ULONGLONG
		NextEntry : 60 as ULONGLONG
	end type
#else
	type SLIST_ENTRY as _SINGLE_LIST_ENTRY
	type PSLIST_ENTRY as _SINGLE_LIST_ENTRY ptr
#endif

union _SLIST_HEADER
	#ifndef __FB_64BIT__
		Alignment as ULONGLONG
	#endif

	type
		#ifdef __FB_64BIT__
			Alignment as ULONGLONG
			Region as ULONGLONG
		#else
			Next as SLIST_ENTRY
			Depth as WORD
			Sequence as WORD
		#endif
	end type

	#ifdef __FB_64BIT__
		Header8 as _SLIST_HEADER_Header8
		HeaderX64 as _SLIST_HEADER_HeaderX64
	#endif
end union

type SLIST_HEADER as _SLIST_HEADER
type PSLIST_HEADER as _SLIST_HEADER ptr
declare sub RtlInitializeSListHead(byval ListHead as PSLIST_HEADER)
declare function RtlFirstEntrySList(byval ListHead as const SLIST_HEADER ptr) as PSLIST_ENTRY
declare function RtlInterlockedPopEntrySList(byval ListHead as PSLIST_HEADER) as PSLIST_ENTRY
declare function RtlInterlockedPushEntrySList(byval ListHead as PSLIST_HEADER, byval ListEntry as PSLIST_ENTRY) as PSLIST_ENTRY
declare function RtlInterlockedPushListSListEx(byval ListHead as PSLIST_HEADER, byval List as PSLIST_ENTRY, byval ListEnd as PSLIST_ENTRY, byval Count as DWORD) as PSLIST_ENTRY
declare function RtlInterlockedFlushSList(byval ListHead as PSLIST_HEADER) as PSLIST_ENTRY
declare function RtlQueryDepthSList(byval ListHead as PSLIST_HEADER) as WORD
const _RTL_RUN_ONCE_DEF = 1

type _RTL_RUN_ONCE
	Ptr as PVOID
end type

type RTL_RUN_ONCE as _RTL_RUN_ONCE
type PRTL_RUN_ONCE as _RTL_RUN_ONCE ptr
type PRTL_RUN_ONCE_INIT_FN as function(byval as PRTL_RUN_ONCE, byval as PVOID, byval as PVOID ptr) as DWORD

#define RTL_RUN_ONCE_INIT (0)
const RTL_RUN_ONCE_CHECK_ONLY = 1u
const RTL_RUN_ONCE_ASYNC = 2u
const RTL_RUN_ONCE_INIT_FAILED = 4u
const RTL_RUN_ONCE_CTX_RESERVED_BITS = 2

type _RTL_BARRIER
	Reserved1 as DWORD
	Reserved2 as DWORD
	Reserved3(0 to 1) as ULONG_PTR
	Reserved4 as DWORD
	Reserved5 as DWORD
end type

type RTL_BARRIER as _RTL_BARRIER
type PRTL_BARRIER as _RTL_BARRIER ptr
const FAST_FAIL_LEGACY_GS_VIOLATION = 0
const FAST_FAIL_VTGUARD_CHECK_FAILURE = 1
const FAST_FAIL_STACK_COOKIE_CHECK_FAILURE = 2
const FAST_FAIL_CORRUPT_LIST_ENTRY = 3
const FAST_FAIL_INCORRECT_STACK = 4
const FAST_FAIL_INVALID_ARG = 5
const FAST_FAIL_GS_COOKIE_INIT = 6
const FAST_FAIL_FATAL_APP_EXIT = 7
const FAST_FAIL_RANGE_CHECK_FAILURE = 8
const FAST_FAIL_UNSAFE_REGISTRY_ACCESS = 9
const FAST_FAIL_INVALID_FAST_FAIL_CODE = &hffffffff
const HEAP_NO_SERIALIZE = &h00000001
const HEAP_GROWABLE = &h00000002
const HEAP_GENERATE_EXCEPTIONS = &h00000004
const HEAP_ZERO_MEMORY = &h00000008
const HEAP_REALLOC_IN_PLACE_ONLY = &h00000010
const HEAP_TAIL_CHECKING_ENABLED = &h00000020
const HEAP_FREE_CHECKING_ENABLED = &h00000040
const HEAP_DISABLE_COALESCE_ON_FREE = &h00000080
const HEAP_CREATE_ALIGN_16 = &h00010000
const HEAP_CREATE_ENABLE_TRACING = &h00020000
const HEAP_CREATE_ENABLE_EXECUTE = &h00040000
const HEAP_MAXIMUM_TAG = &h0FFF
const HEAP_PSEUDO_TAG_FLAG = &h8000
const HEAP_TAG_SHIFT = 18
#define HEAP_MAKE_TAG_FLAGS(b, o) cast(DWORD, (b) + ((o) shl 18))
const IS_TEXT_UNICODE_ASCII16 = &h0001
const IS_TEXT_UNICODE_REVERSE_ASCII16 = &h0010
const IS_TEXT_UNICODE_STATISTICS = &h0002
const IS_TEXT_UNICODE_REVERSE_STATISTICS = &h0020
const IS_TEXT_UNICODE_CONTROLS = &h0004
const IS_TEXT_UNICODE_REVERSE_CONTROLS = &h0040
const IS_TEXT_UNICODE_SIGNATURE = &h0008
const IS_TEXT_UNICODE_REVERSE_SIGNATURE = &h0080
const IS_TEXT_UNICODE_ILLEGAL_CHARS = &h0100
const IS_TEXT_UNICODE_ODD_LENGTH = &h0200
const IS_TEXT_UNICODE_DBCS_LEADBYTE = &h0400
const IS_TEXT_UNICODE_NULL_BYTES = &h1000
const IS_TEXT_UNICODE_UNICODE_MASK = &h000F
const IS_TEXT_UNICODE_REVERSE_MASK = &h00F0
const IS_TEXT_UNICODE_NOT_UNICODE_MASK = &h0F00
const IS_TEXT_UNICODE_NOT_ASCII_MASK = &hF000
const COMPRESSION_FORMAT_NONE = &h0000
const COMPRESSION_FORMAT_DEFAULT = &h0001
const COMPRESSION_FORMAT_LZNT1 = &h0002
const COMPRESSION_FORMAT_XPRESS = &h0003
const COMPRESSION_FORMAT_XPRESS_HUFF = &h0004
const COMPRESSION_ENGINE_STANDARD = &h0000
const COMPRESSION_ENGINE_MAXIMUM = &h0100
const COMPRESSION_ENGINE_HIBER = &h0200
#define RtlEqualMemory(Destination, Source, Length) (memcmp((Destination), (Source), (Length)) = 0)
#define RtlMoveMemory(Destination, Source, Length) memmove((Destination), (Source), (Length))
#define RtlCopyMemory(Destination, Source, Length) memcpy((Destination), (Source), (Length))
#define RtlFillMemory(Destination, Length, Fill) memset((Destination), (Fill), (Length))
#define RtlZeroMemory(Destination, Length) memset((Destination), 0, (Length))
declare function RtlSecureZeroMemory(byval ptr as PVOID, byval cnt as SIZE_T_) as PVOID

type _MESSAGE_RESOURCE_ENTRY
	Length as WORD
	Flags as WORD
	Text(0 to 0) as UBYTE
end type

type MESSAGE_RESOURCE_ENTRY as _MESSAGE_RESOURCE_ENTRY
type PMESSAGE_RESOURCE_ENTRY as _MESSAGE_RESOURCE_ENTRY ptr
const SEF_DACL_AUTO_INHERIT = &h01
const SEF_SACL_AUTO_INHERIT = &h02
const SEF_DEFAULT_DESCRIPTOR_FOR_OBJECT = &h04
const SEF_AVOID_PRIVILEGE_CHECK = &h08
const SEF_AVOID_OWNER_CHECK = &h10
const SEF_DEFAULT_OWNER_FROM_PARENT = &h20
const SEF_DEFAULT_GROUP_FROM_PARENT = &h40
const SEF_MACL_NO_WRITE_UP = &h100
const SEF_MACL_NO_READ_UP = &h200
const SEF_MACL_NO_EXECUTE_UP = &h400
const SEF_AVOID_OWNER_RESTRICTION = &h1000
const SEF_MACL_VALID_FLAGS = (SEF_MACL_NO_WRITE_UP or SEF_MACL_NO_READ_UP) or SEF_MACL_NO_EXECUTE_UP
const MESSAGE_RESOURCE_UNICODE = &h0001

type _MESSAGE_RESOURCE_BLOCK
	LowId as DWORD
	HighId as DWORD
	OffsetToEntries as DWORD
end type

type MESSAGE_RESOURCE_BLOCK as _MESSAGE_RESOURCE_BLOCK
type PMESSAGE_RESOURCE_BLOCK as _MESSAGE_RESOURCE_BLOCK ptr

type _MESSAGE_RESOURCE_DATA
	NumberOfBlocks as DWORD
	Blocks(0 to 0) as MESSAGE_RESOURCE_BLOCK
end type

type MESSAGE_RESOURCE_DATA as _MESSAGE_RESOURCE_DATA
type PMESSAGE_RESOURCE_DATA as _MESSAGE_RESOURCE_DATA ptr

type _OSVERSIONINFOA
	dwOSVersionInfoSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformId as DWORD
	szCSDVersion as zstring * 128
end type

type OSVERSIONINFOA as _OSVERSIONINFOA
type POSVERSIONINFOA as _OSVERSIONINFOA ptr
type LPOSVERSIONINFOA as _OSVERSIONINFOA ptr

type _OSVERSIONINFOW
	dwOSVersionInfoSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformId as DWORD
	szCSDVersion as wstring * 128
end type

type OSVERSIONINFOW as _OSVERSIONINFOW
type POSVERSIONINFOW as _OSVERSIONINFOW ptr
type LPOSVERSIONINFOW as _OSVERSIONINFOW ptr
type RTL_OSVERSIONINFOW as _OSVERSIONINFOW
type PRTL_OSVERSIONINFOW as _OSVERSIONINFOW ptr

#ifdef UNICODE
	type OSVERSIONINFO as OSVERSIONINFOW
	type POSVERSIONINFO as POSVERSIONINFOW
	type LPOSVERSIONINFO as LPOSVERSIONINFOW
#else
	type OSVERSIONINFO as OSVERSIONINFOA
	type POSVERSIONINFO as POSVERSIONINFOA
	type LPOSVERSIONINFO as LPOSVERSIONINFOA
#endif

type _OSVERSIONINFOEXA
	dwOSVersionInfoSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformId as DWORD
	szCSDVersion as zstring * 128
	wServicePackMajor as WORD
	wServicePackMinor as WORD
	wSuiteMask as WORD
	wProductType as UBYTE
	wReserved as UBYTE
end type

type OSVERSIONINFOEXA as _OSVERSIONINFOEXA
type POSVERSIONINFOEXA as _OSVERSIONINFOEXA ptr
type LPOSVERSIONINFOEXA as _OSVERSIONINFOEXA ptr

type _OSVERSIONINFOEXW
	dwOSVersionInfoSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformId as DWORD
	szCSDVersion as wstring * 128
	wServicePackMajor as WORD
	wServicePackMinor as WORD
	wSuiteMask as WORD
	wProductType as UBYTE
	wReserved as UBYTE
end type

type OSVERSIONINFOEXW as _OSVERSIONINFOEXW
type POSVERSIONINFOEXW as _OSVERSIONINFOEXW ptr
type LPOSVERSIONINFOEXW as _OSVERSIONINFOEXW ptr
type RTL_OSVERSIONINFOEXW as _OSVERSIONINFOEXW
type PRTL_OSVERSIONINFOEXW as _OSVERSIONINFOEXW ptr

#ifdef UNICODE
	type OSVERSIONINFOEX as OSVERSIONINFOEXW
	type POSVERSIONINFOEX as POSVERSIONINFOEXW
	type LPOSVERSIONINFOEX as LPOSVERSIONINFOEXW
#else
	type OSVERSIONINFOEX as OSVERSIONINFOEXA
	type POSVERSIONINFOEX as POSVERSIONINFOEXA
	type LPOSVERSIONINFOEX as LPOSVERSIONINFOEXA
#endif

const VER_EQUAL = 1
const VER_GREATER = 2
const VER_GREATER_EQUAL = 3
const VER_LESS = 4
const VER_LESS_EQUAL = 5
const VER_AND = 6
const VER_OR = 7
const VER_CONDITION_MASK = 7
const VER_NUM_BITS_PER_CONDITION_MASK = 3
const VER_MINORVERSION = &h0000001
const VER_MAJORVERSION = &h0000002
const VER_BUILDNUMBER = &h0000004
const VER_PLATFORMID = &h0000008
const VER_SERVICEPACKMINOR = &h0000010
const VER_SERVICEPACKMAJOR = &h0000020
const VER_SUITENAME = &h0000040
const VER_PRODUCT_TYPE = &h0000080
const VER_NT_WORKSTATION = &h0000001
const VER_NT_DOMAIN_CONTROLLER = &h0000002
const VER_NT_SERVER = &h0000003
const VER_PLATFORM_WIN32s = 0
const VER_PLATFORM_WIN32_WINDOWS = 1
const VER_PLATFORM_WIN32_NT = 2
declare function VerSetConditionMask(byval ConditionMask as ULONGLONG, byval TypeMask as DWORD, byval Condition as UBYTE) as ULONGLONG
#define VER_SET_CONDITION(_m_, _t_, _c_) scope : (_m_) = VerSetConditionMask((_m_), (_t_), (_c_)) : end scope

#if _WIN32_WINNT >= &h0600
	declare function RtlGetProductInfo(byval OSMajorVersion as DWORD, byval OSMinorVersion as DWORD, byval SpMajorVersion as DWORD, byval SpMinorVersion as DWORD, byval ReturnedProductType as PDWORD) as WINBOOLEAN
#endif

const RTL_UMS_VERSION = &h0100

type _RTL_UMS_THREAD_INFO_CLASS as long
enum
	UmsThreadInvalidInfoClass = 0
	UmsThreadUserContext
	UmsThreadPriority
	UmsThreadAffinity
	UmsThreadTeb
	UmsThreadIsSuspended
	UmsThreadIsTerminated
	UmsThreadMaxInfoClass
end enum

type RTL_UMS_THREAD_INFO_CLASS as _RTL_UMS_THREAD_INFO_CLASS
type PRTL_UMS_THREAD_INFO_CLASS as _RTL_UMS_THREAD_INFO_CLASS ptr

type _RTL_UMS_SCHEDULER_REASON as long
enum
	UmsSchedulerStartup = 0
	UmsSchedulerThreadBlocked
	UmsSchedulerThreadYield
end enum

type RTL_UMS_SCHEDULER_REASON as _RTL_UMS_SCHEDULER_REASON
type PRTL_UMS_SCHEDULER_REASON as _RTL_UMS_SCHEDULER_REASON ptr
type PRTL_UMS_SCHEDULER_ENTRY_POINT as sub(byval Reason as RTL_UMS_SCHEDULER_REASON, byval ActivationPayload as ULONG_PTR, byval SchedulerParam as PVOID)

#if _WIN32_WINNT = &h0602
	#define IS_VALIDATION_ENABLED(C, L) ((L) and (C))
	const VRL_PREDEFINED_CLASS_BEGIN = 1
	const VRL_CUSTOM_CLASS_BEGIN = 1 shl 8
	const VRL_CLASS_CONSISTENCY = VRL_PREDEFINED_CLASS_BEGIN
	const VRL_ENABLE_KERNEL_BREAKS = 1 shl 31
	const CTMF_INCLUDE_APPCONTAINER = &h1u
	const CTMF_VALID_FLAGS = CTMF_INCLUDE_APPCONTAINER
	declare function RtlCrc32(byval Buffer as const any ptr, byval Size as uinteger, byval InitialCrc as DWORD) as DWORD
	declare function RtlCrc64(byval Buffer as const any ptr, byval Size as uinteger, byval InitialCrc as ULONGLONG) as ULONGLONG
#endif

type _RTL_CRITICAL_SECTION as _RTL_CRITICAL_SECTION_

type _RTL_CRITICAL_SECTION_DEBUG
	as WORD Type
	CreatorBackTraceIndex as WORD
	CriticalSection as _RTL_CRITICAL_SECTION ptr
	ProcessLocksList as LIST_ENTRY
	EntryCount as DWORD
	ContentionCount as DWORD
	Flags as DWORD
	CreatorBackTraceIndexHigh as WORD
	SpareWORD as WORD
end type

type RTL_CRITICAL_SECTION_DEBUG as _RTL_CRITICAL_SECTION_DEBUG
type PRTL_CRITICAL_SECTION_DEBUG as _RTL_CRITICAL_SECTION_DEBUG ptr
type RTL_RESOURCE_DEBUG as _RTL_CRITICAL_SECTION_DEBUG
type PRTL_RESOURCE_DEBUG as _RTL_CRITICAL_SECTION_DEBUG ptr

const RTL_CRITSECT_TYPE = 0
const RTL_RESOURCE_TYPE = 1
const RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO = &h01000000
const RTL_CRITICAL_SECTION_FLAG_DYNAMIC_SPIN = &h02000000
const RTL_CRITICAL_SECTION_FLAG_STATIC_INIT = &h04000000
const RTL_CRITICAL_SECTION_FLAG_RESOURCE_TYPE = &h08000000
const RTL_CRITICAL_SECTION_FLAG_FORCE_DEBUG_INFO = &h10000000
const RTL_CRITICAL_SECTION_ALL_FLAG_BITS = &hff000000
const RTL_CRITICAL_SECTION_FLAG_RESERVED = RTL_CRITICAL_SECTION_ALL_FLAG_BITS and (not ((((RTL_CRITICAL_SECTION_FLAG_NO_DEBUG_INFO or RTL_CRITICAL_SECTION_FLAG_DYNAMIC_SPIN) or RTL_CRITICAL_SECTION_FLAG_STATIC_INIT) or RTL_CRITICAL_SECTION_FLAG_RESOURCE_TYPE) or RTL_CRITICAL_SECTION_FLAG_FORCE_DEBUG_INFO))
const RTL_CRITICAL_SECTION_DEBUG_FLAG_STATIC_INIT = &h00000001

type _RTL_CRITICAL_SECTION_
	DebugInfo as PRTL_CRITICAL_SECTION_DEBUG
	LockCount as LONG
	RecursionCount as LONG
	OwningThread as HANDLE
	LockSemaphore as HANDLE
	SpinCount as ULONG_PTR
end type

type RTL_CRITICAL_SECTION as _RTL_CRITICAL_SECTION
type PRTL_CRITICAL_SECTION as _RTL_CRITICAL_SECTION ptr

type _RTL_SRWLOCK
	Ptr as PVOID
end type

type RTL_SRWLOCK as _RTL_SRWLOCK
type PRTL_SRWLOCK as _RTL_SRWLOCK ptr

type _RTL_CONDITION_VARIABLE
	Ptr as PVOID
end type

type RTL_CONDITION_VARIABLE as _RTL_CONDITION_VARIABLE
type PRTL_CONDITION_VARIABLE as _RTL_CONDITION_VARIABLE ptr
#define RTL_SRWLOCK_INIT (0)
#define RTL_CONDITION_VARIABLE_INIT (0)
const RTL_CONDITION_VARIABLE_LOCKMODE_SHARED = &h1
type PAPCFUNC as sub(byval Parameter as ULONG_PTR)
type PVECTORED_EXCEPTION_HANDLER as function(byval ExceptionInfo as _EXCEPTION_POINTERS ptr) as LONG

type _HEAP_INFORMATION_CLASS as long
enum
	HeapCompatibilityInformation
	HeapEnableTerminationOnCorruption
end enum

type HEAP_INFORMATION_CLASS as _HEAP_INFORMATION_CLASS
type WORKERCALLBACKFUNC as sub(byval as PVOID)
type APC_CALLBACK_FUNCTION as sub(byval as DWORD, byval as PVOID, byval as PVOID)
type WAITORTIMERCALLBACKFUNC as sub(byval as PVOID, byval as WINBOOLEAN)
type WAITORTIMERCALLBACK as WAITORTIMERCALLBACKFUNC
type PFLS_CALLBACK_FUNCTION as sub(byval lpFlsData as PVOID)
type PSECURE_MEMORY_CACHE_CALLBACK as function(byval Addr as PVOID, byval Range as SIZE_T_) as WINBOOLEAN

const WT_EXECUTEDEFAULT = &h00000000
const WT_EXECUTEINIOTHREAD = &h00000001
const WT_EXECUTEINUITHREAD = &h00000002
const WT_EXECUTEINWAITTHREAD = &h00000004
const WT_EXECUTEONLYONCE = &h00000008
const WT_EXECUTEINTIMERTHREAD = &h00000020
const WT_EXECUTELONGFUNCTION = &h00000010
const WT_EXECUTEINPERSISTENTIOTHREAD = &h00000040
const WT_EXECUTEINPERSISTENTTHREAD = &h00000080
const WT_TRANSFER_IMPERSONATION = &h00000100
#define WT_SET_MAX_THREADPOOL_THREADS(Flags, Limit) scope : (Flags) or= (Limit) shl 16 : end scope
const WT_EXECUTEDELETEWAIT = &h00000008
const WT_EXECUTEINLONGTHREAD = &h00000010

type _ACTIVATION_CONTEXT_INFO_CLASS as long
enum
	ActivationContextBasicInformation = 1
	ActivationContextDetailedInformation = 2
	AssemblyDetailedInformationInActivationContext = 3
	FileInformationInAssemblyOfAssemblyInActivationContext = 4
	RunlevelInformationInActivationContext = 5
	CompatibilityInformationInActivationContext = 6
	ActivationContextManifestResourceName = 7
	MaxActivationContextInfoClass
	AssemblyDetailedInformationInActivationContxt = 3
	FileInformationInAssemblyOfAssemblyInActivationContxt = 4
end enum

type ACTIVATION_CONTEXT_INFO_CLASS as _ACTIVATION_CONTEXT_INFO_CLASS

type ACTCTX_REQUESTED_RUN_LEVEL as long
enum
	ACTCTX_RUN_LEVEL_UNSPECIFIED = 0
	ACTCTX_RUN_LEVEL_AS_INVOKER
	ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE
	ACTCTX_RUN_LEVEL_REQUIRE_ADMIN
	ACTCTX_RUN_LEVEL_NUMBERS
end enum

type ACTCTX_COMPATIBILITY_ELEMENT_TYPE as long
enum
	ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN = 0
	ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS
	ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION
end enum

type _ACTIVATION_CONTEXT_QUERY_INDEX
	ulAssemblyIndex as DWORD
	ulFileIndexInAssembly as DWORD
end type

type ACTIVATION_CONTEXT_QUERY_INDEX as _ACTIVATION_CONTEXT_QUERY_INDEX
type PACTIVATION_CONTEXT_QUERY_INDEX as _ACTIVATION_CONTEXT_QUERY_INDEX ptr

type _ASSEMBLY_FILE_DETAILED_INFORMATION
	ulFlags as DWORD
	ulFilenameLength as DWORD
	ulPathLength as DWORD
	lpFileName as PCWSTR
	lpFilePath as PCWSTR
end type

type ASSEMBLY_FILE_DETAILED_INFORMATION as _ASSEMBLY_FILE_DETAILED_INFORMATION
type PASSEMBLY_FILE_DETAILED_INFORMATION as _ASSEMBLY_FILE_DETAILED_INFORMATION ptr

type _ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
	ulFlags as DWORD
	ulEncodedAssemblyIdentityLength as DWORD
	ulManifestPathType as DWORD
	ulManifestPathLength as DWORD
	liManifestLastWriteTime as LARGE_INTEGER
	ulPolicyPathType as DWORD
	ulPolicyPathLength as DWORD
	liPolicyLastWriteTime as LARGE_INTEGER
	ulMetadataSatelliteRosterIndex as DWORD
	ulManifestVersionMajor as DWORD
	ulManifestVersionMinor as DWORD
	ulPolicyVersionMajor as DWORD
	ulPolicyVersionMinor as DWORD
	ulAssemblyDirectoryNameLength as DWORD
	lpAssemblyEncodedAssemblyIdentity as PCWSTR
	lpAssemblyManifestPath as PCWSTR
	lpAssemblyPolicyPath as PCWSTR
	lpAssemblyDirectoryName as PCWSTR
	ulFileCount as DWORD
end type

type ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION as _ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION
type PACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION as _ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION ptr

type _ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
	ulFlags as DWORD
	RunLevel as ACTCTX_REQUESTED_RUN_LEVEL
	UiAccess as DWORD
end type

type ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION as _ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION
type PACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION as _ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION ptr

type _COMPATIBILITY_CONTEXT_ELEMENT
	Id as GUID
	as ACTCTX_COMPATIBILITY_ELEMENT_TYPE Type
end type

type COMPATIBILITY_CONTEXT_ELEMENT as _COMPATIBILITY_CONTEXT_ELEMENT
type PCOMPATIBILITY_CONTEXT_ELEMENT as _COMPATIBILITY_CONTEXT_ELEMENT ptr

type _ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
	ElementCount as DWORD
	Elements(0 to 0) as COMPATIBILITY_CONTEXT_ELEMENT
end type

type ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION as _ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION
type PACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION as _ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION ptr
const MAX_SUPPORTED_OS_NUM = 4

type _SUPPORTED_OS_INFO
	OsCount as WORD
	MitigationExist as WORD
	OsList(0 to 3) as WORD
end type

type SUPPORTED_OS_INFO as _SUPPORTED_OS_INFO
type PSUPPORTED_OS_INFO as _SUPPORTED_OS_INFO ptr

type _ACTIVATION_CONTEXT_DETAILED_INFORMATION
	dwFlags as DWORD
	ulFormatVersion as DWORD
	ulAssemblyCount as DWORD
	ulRootManifestPathType as DWORD
	ulRootManifestPathChars as DWORD
	ulRootConfigurationPathType as DWORD
	ulRootConfigurationPathChars as DWORD
	ulAppDirPathType as DWORD
	ulAppDirPathChars as DWORD
	lpRootManifestPath as PCWSTR
	lpRootConfigurationPath as PCWSTR
	lpAppDirPath as PCWSTR
end type

type ACTIVATION_CONTEXT_DETAILED_INFORMATION as _ACTIVATION_CONTEXT_DETAILED_INFORMATION
type PACTIVATION_CONTEXT_DETAILED_INFORMATION as _ACTIVATION_CONTEXT_DETAILED_INFORMATION ptr
type PCACTIVATION_CONTEXT_QUERY_INDEX as const _ACTIVATION_CONTEXT_QUERY_INDEX ptr
type PCASSEMBLY_FILE_DETAILED_INFORMATION as const ASSEMBLY_FILE_DETAILED_INFORMATION ptr
type PCACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION as const _ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION ptr
type PCACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION as const _ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION ptr
type PCCOMPATIBILITY_CONTEXT_ELEMENT as const _COMPATIBILITY_CONTEXT_ELEMENT ptr
type PCACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION as const _ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION ptr
type PCACTIVATION_CONTEXT_DETAILED_INFORMATION as const _ACTIVATION_CONTEXT_DETAILED_INFORMATION ptr
type ACTIVATIONCONTEXTINFOCLASS as ACTIVATION_CONTEXT_INFO_CLASS

const ACTIVATION_CONTEXT_PATH_TYPE_NONE = 1
const ACTIVATION_CONTEXT_PATH_TYPE_WIN32_FILE = 2
const ACTIVATION_CONTEXT_PATH_TYPE_URL = 3
const ACTIVATION_CONTEXT_PATH_TYPE_ASSEMBLYREF = 4

type _ASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION as _ASSEMBLY_FILE_DETAILED_INFORMATION
type ASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION as ASSEMBLY_FILE_DETAILED_INFORMATION
type PASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION as PASSEMBLY_FILE_DETAILED_INFORMATION
type PCASSEMBLY_DLL_REDIRECTION_DETAILED_INFORMATION as PCASSEMBLY_FILE_DETAILED_INFORMATION
const INVALID_OS_COUNT = &hffff
const CREATE_BOUNDARY_DESCRIPTOR_ADD_APPCONTAINER_SID = &h1
type RTL_VERIFIER_DLL_LOAD_CALLBACK as sub(byval DllName as PWSTR, byval DllBase as PVOID, byval DllSize as SIZE_T_, byval Reserved as PVOID)
type RTL_VERIFIER_DLL_UNLOAD_CALLBACK as sub(byval DllName as PWSTR, byval DllBase as PVOID, byval DllSize as SIZE_T_, byval Reserved as PVOID)
type RTL_VERIFIER_NTDLLHEAPFREE_CALLBACK as sub(byval AllocationBase as PVOID, byval AllocationSize as SIZE_T_)

type _RTL_VERIFIER_THUNK_DESCRIPTOR
	ThunkName as PCHAR
	ThunkOldAddress as PVOID
	ThunkNewAddress as PVOID
end type

type RTL_VERIFIER_THUNK_DESCRIPTOR as _RTL_VERIFIER_THUNK_DESCRIPTOR
type PRTL_VERIFIER_THUNK_DESCRIPTOR as _RTL_VERIFIER_THUNK_DESCRIPTOR ptr

type _RTL_VERIFIER_DLL_DESCRIPTOR
	DllName as PWCHAR
	DllFlags as DWORD
	DllAddress as PVOID
	DllThunks as PRTL_VERIFIER_THUNK_DESCRIPTOR
end type

type RTL_VERIFIER_DLL_DESCRIPTOR as _RTL_VERIFIER_DLL_DESCRIPTOR
type PRTL_VERIFIER_DLL_DESCRIPTOR as _RTL_VERIFIER_DLL_DESCRIPTOR ptr

type _RTL_VERIFIER_PROVIDER_DESCRIPTOR
	Length as DWORD
	ProviderDlls as PRTL_VERIFIER_DLL_DESCRIPTOR
	ProviderDllLoadCallback as RTL_VERIFIER_DLL_LOAD_CALLBACK
	ProviderDllUnloadCallback as RTL_VERIFIER_DLL_UNLOAD_CALLBACK
	VerifierImage as PWSTR
	VerifierFlags as DWORD
	VerifierDebug as DWORD
	RtlpGetStackTraceAddress as PVOID
	RtlpDebugPageHeapCreate as PVOID
	RtlpDebugPageHeapDestroy as PVOID
	ProviderNtdllHeapFreeCallback as RTL_VERIFIER_NTDLLHEAPFREE_CALLBACK
end type

type RTL_VERIFIER_PROVIDER_DESCRIPTOR as _RTL_VERIFIER_PROVIDER_DESCRIPTOR
type PRTL_VERIFIER_PROVIDER_DESCRIPTOR as _RTL_VERIFIER_PROVIDER_DESCRIPTOR ptr
const RTL_VRF_FLG_FULL_PAGE_HEAP = &h00000001
const RTL_VRF_FLG_RESERVED_DONOTUSE = &h00000002
const RTL_VRF_FLG_HANDLE_CHECKS = &h00000004
const RTL_VRF_FLG_STACK_CHECKS = &h00000008
const RTL_VRF_FLG_APPCOMPAT_CHECKS = &h00000010
const RTL_VRF_FLG_TLS_CHECKS = &h00000020
const RTL_VRF_FLG_DIRTY_STACKS = &h00000040
const RTL_VRF_FLG_RPC_CHECKS = &h00000080
const RTL_VRF_FLG_COM_CHECKS = &h00000100
const RTL_VRF_FLG_DANGEROUS_APIS = &h00000200
const RTL_VRF_FLG_RACE_CHECKS = &h00000400
const RTL_VRF_FLG_DEADLOCK_CHECKS = &h00000800
const RTL_VRF_FLG_FIRST_CHANCE_EXCEPTION_CHECKS = &h00001000
const RTL_VRF_FLG_VIRTUAL_MEM_CHECKS = &h00002000
const RTL_VRF_FLG_ENABLE_LOGGING = &h00004000
const RTL_VRF_FLG_FAST_FILL_HEAP = &h00008000
const RTL_VRF_FLG_VIRTUAL_SPACE_TRACKING = &h00010000
const RTL_VRF_FLG_ENABLED_SYSTEM_WIDE = &h00020000
const RTL_VRF_FLG_MISCELLANEOUS_CHECKS = &h00020000
const RTL_VRF_FLG_LOCK_CHECKS = &h00040000
const APPLICATION_VERIFIER_INTERNAL_ERROR = &h80000000
const APPLICATION_VERIFIER_INTERNAL_WARNING = &h40000000
const APPLICATION_VERIFIER_NO_BREAK = &h20000000
const APPLICATION_VERIFIER_CONTINUABLE_BREAK = &h10000000
const APPLICATION_VERIFIER_UNKNOWN_ERROR = &h0001
const APPLICATION_VERIFIER_ACCESS_VIOLATION = &h0002
const APPLICATION_VERIFIER_UNSYNCHRONIZED_ACCESS = &h0003
const APPLICATION_VERIFIER_EXTREME_SIZE_REQUEST = &h0004
const APPLICATION_VERIFIER_BAD_HEAP_HANDLE = &h0005
const APPLICATION_VERIFIER_SWITCHED_HEAP_HANDLE = &h0006
const APPLICATION_VERIFIER_DOUBLE_FREE = &h0007
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK = &h0008
const APPLICATION_VERIFIER_DESTROY_PROCESS_HEAP = &h0009
const APPLICATION_VERIFIER_UNEXPECTED_EXCEPTION = &h000A
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_EXCEPTION_RAISED_FOR_HEADER = &h000B
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_EXCEPTION_RAISED_FOR_PROBING = &h000C
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_HEADER = &h000D
const APPLICATION_VERIFIER_CORRUPTED_FREED_HEAP_BLOCK = &h000E
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_SUFFIX = &h000F
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_START_STAMP = &h0010
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_END_STAMP = &h0011
const APPLICATION_VERIFIER_CORRUPTED_HEAP_BLOCK_PREFIX = &h0012
const APPLICATION_VERIFIER_FIRST_CHANCE_ACCESS_VIOLATION = &h0013
const APPLICATION_VERIFIER_CORRUPTED_HEAP_LIST = &h0014
const APPLICATION_VERIFIER_TERMINATE_THREAD_CALL = &h0100
const APPLICATION_VERIFIER_STACK_OVERFLOW = &h0101
const APPLICATION_VERIFIER_INVALID_EXIT_PROCESS_CALL = &h0102
const APPLICATION_VERIFIER_EXIT_THREAD_OWNS_LOCK = &h0200
const APPLICATION_VERIFIER_LOCK_IN_UNLOADED_DLL = &h0201
const APPLICATION_VERIFIER_LOCK_IN_FREED_HEAP = &h0202
const APPLICATION_VERIFIER_LOCK_DOUBLE_INITIALIZE = &h0203
const APPLICATION_VERIFIER_LOCK_IN_FREED_MEMORY = &h0204
const APPLICATION_VERIFIER_LOCK_CORRUPTED = &h0205
const APPLICATION_VERIFIER_LOCK_INVALID_OWNER = &h0206
const APPLICATION_VERIFIER_LOCK_INVALID_RECURSION_COUNT = &h0207
const APPLICATION_VERIFIER_LOCK_INVALID_LOCK_COUNT = &h0208
const APPLICATION_VERIFIER_LOCK_OVER_RELEASED = &h0209
const APPLICATION_VERIFIER_LOCK_NOT_INITIALIZED = &h0210
const APPLICATION_VERIFIER_LOCK_ALREADY_INITIALIZED = &h0211
const APPLICATION_VERIFIER_LOCK_IN_FREED_VMEM = &h0212
const APPLICATION_VERIFIER_LOCK_IN_UNMAPPED_MEM = &h0213
const APPLICATION_VERIFIER_THREAD_NOT_LOCK_OWNER = &h0214
const APPLICATION_VERIFIER_INVALID_HANDLE = &h0300
const APPLICATION_VERIFIER_INVALID_TLS_VALUE = &h0301
const APPLICATION_VERIFIER_INCORRECT_WAIT_CALL = &h0302
const APPLICATION_VERIFIER_NULL_HANDLE = &h0303
const APPLICATION_VERIFIER_WAIT_IN_DLLMAIN = &h0304
const APPLICATION_VERIFIER_COM_ERROR = &h0400
const APPLICATION_VERIFIER_COM_API_IN_DLLMAIN = &h0401
const APPLICATION_VERIFIER_COM_UNHANDLED_EXCEPTION = &h0402
const APPLICATION_VERIFIER_COM_UNBALANCED_COINIT = &h0403
const APPLICATION_VERIFIER_COM_UNBALANCED_OLEINIT = &h0404
const APPLICATION_VERIFIER_COM_UNBALANCED_SWC = &h0405
const APPLICATION_VERIFIER_COM_NULL_DACL = &h0406
const APPLICATION_VERIFIER_COM_UNSAFE_IMPERSONATION = &h0407
const APPLICATION_VERIFIER_COM_SMUGGLED_WRAPPER = &h0408
const APPLICATION_VERIFIER_COM_SMUGGLED_PROXY = &h0409
const APPLICATION_VERIFIER_COM_CF_SUCCESS_WITH_NULL = &h040A
const APPLICATION_VERIFIER_COM_GCO_SUCCESS_WITH_NULL = &h040B
const APPLICATION_VERIFIER_COM_OBJECT_IN_FREED_MEMORY = &h040C
const APPLICATION_VERIFIER_COM_OBJECT_IN_UNLOADED_DLL = &h040D
const APPLICATION_VERIFIER_COM_VTBL_IN_FREED_MEMORY = &h040E
const APPLICATION_VERIFIER_COM_VTBL_IN_UNLOADED_DLL = &h040F
const APPLICATION_VERIFIER_COM_HOLDING_LOCKS_ON_CALL = &h0410
const APPLICATION_VERIFIER_RPC_ERROR = &h0500
const APPLICATION_VERIFIER_INVALID_FREEMEM = &h0600
const APPLICATION_VERIFIER_INVALID_ALLOCMEM = &h0601
const APPLICATION_VERIFIER_INVALID_MAPVIEW = &h0602
const APPLICATION_VERIFIER_PROBE_INVALID_ADDRESS = &h0603
const APPLICATION_VERIFIER_PROBE_FREE_MEM = &h0604
const APPLICATION_VERIFIER_PROBE_GUARD_PAGE = &h0605
const APPLICATION_VERIFIER_PROBE_NULL = &h0606
const APPLICATION_VERIFIER_PROBE_INVALID_START_OR_SIZE = &h0607
const APPLICATION_VERIFIER_SIZE_HEAP_UNEXPECTED_EXCEPTION = &h0618
#define VERIFIER_STOP(Code, Msg, P1, S1, P2, S2, P3, S3, P4, S4) scope : RtlApplicationVerifierStop((Code), (Msg), cast(ULONG_PTR, (P1)), (S1), cast(ULONG_PTR, (P2)), (S2), cast(ULONG_PTR, (P3)), (S3), cast(ULONG_PTR, (P4)), (S4)) : end scope

declare sub RtlApplicationVerifierStop(byval Code as ULONG_PTR, byval Message as PSTR, byval Param1 as ULONG_PTR, byval Description1 as PSTR, byval Param2 as ULONG_PTR, byval Description2 as PSTR, byval Param3 as ULONG_PTR, byval Description3 as PSTR, byval Param4 as ULONG_PTR, byval Description4 as PSTR)
declare function RtlSetHeapInformation(byval HeapHandle as PVOID, byval HeapInformationClass as HEAP_INFORMATION_CLASS, byval HeapInformation as PVOID, byval HeapInformationLength as SIZE_T_) as DWORD
declare function RtlQueryHeapInformation(byval HeapHandle as PVOID, byval HeapInformationClass as HEAP_INFORMATION_CLASS, byval HeapInformation as PVOID, byval HeapInformationLength as SIZE_T_, byval ReturnLength as PSIZE_T) as DWORD
declare function RtlMultipleAllocateHeap(byval HeapHandle as PVOID, byval Flags as DWORD, byval Size as SIZE_T_, byval Count as DWORD, byval Array as PVOID ptr) as DWORD
declare function RtlMultipleFreeHeap(byval HeapHandle as PVOID, byval Flags as DWORD, byval Count as DWORD, byval Array as PVOID ptr) as DWORD

type _HARDWARE_COUNTER_DATA
	as HARDWARE_COUNTER_TYPE Type
	Reserved as DWORD
	Value as DWORD64
end type

type HARDWARE_COUNTER_DATA as _HARDWARE_COUNTER_DATA
type PHARDWARE_COUNTER_DATA as _HARDWARE_COUNTER_DATA ptr

type _PERFORMANCE_DATA
	Size as WORD
	Version as UBYTE
	HwCountersCount as UBYTE
	ContextSwitchCount as DWORD
	WaitReasonBitMap as DWORD64
	CycleTime as DWORD64
	RetryCount as DWORD
	Reserved as DWORD
	HwCounters(0 to 15) as HARDWARE_COUNTER_DATA
end type

type PERFORMANCE_DATA as _PERFORMANCE_DATA
type PPERFORMANCE_DATA as _PERFORMANCE_DATA ptr
const PERFORMANCE_DATA_VERSION = 1
const READ_THREAD_PROFILING_FLAG_DISPATCHING = &h00000001
const READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS = &h00000002
const DLL_PROCESS_ATTACH = 1
const DLL_THREAD_ATTACH = 2
const DLL_THREAD_DETACH = 3
const DLL_PROCESS_DETACH = 0
const DLL_PROCESS_VERIFIER = 4
const EVENTLOG_SEQUENTIAL_READ = &h0001
const EVENTLOG_SEEK_READ = &h0002
const EVENTLOG_FORWARDS_READ = &h0004
const EVENTLOG_BACKWARDS_READ = &h0008
const EVENTLOG_SUCCESS = &h0000
const EVENTLOG_ERROR_TYPE = &h0001
const EVENTLOG_WARNING_TYPE = &h0002
const EVENTLOG_INFORMATION_TYPE = &h0004
const EVENTLOG_AUDIT_SUCCESS = &h0008
const EVENTLOG_AUDIT_FAILURE = &h0010
const EVENTLOG_START_PAIRED_EVENT = &h0001
const EVENTLOG_END_PAIRED_EVENT = &h0002
const EVENTLOG_END_ALL_PAIRED_EVENTS = &h0004
const EVENTLOG_PAIRED_EVENT_ACTIVE = &h0008
const EVENTLOG_PAIRED_EVENT_INACTIVE = &h0010

type _EVENTLOGRECORD
	Length as DWORD
	Reserved as DWORD
	RecordNumber as DWORD
	TimeGenerated as DWORD
	TimeWritten as DWORD
	EventID as DWORD
	EventType as WORD
	NumStrings as WORD
	EventCategory as WORD
	ReservedFlags as WORD
	ClosingRecordNumber as DWORD
	StringOffset as DWORD
	UserSidLength as DWORD
	UserSidOffset as DWORD
	DataLength as DWORD
	DataOffset as DWORD
end type

type EVENTLOGRECORD as _EVENTLOGRECORD
type PEVENTLOGRECORD as _EVENTLOGRECORD ptr
const MAXLOGICALLOGNAMESIZE = 256

type _EVENTSFORLOGFILE
	ulSize as DWORD
	szLogicalLogFile as wstring * 256
	ulNumRecords as DWORD
	pEventLogRecords(0 to 0) as EVENTLOGRECORD
end type

type EVENTSFORLOGFILE as _EVENTSFORLOGFILE
type PEVENTSFORLOGFILE as _EVENTSFORLOGFILE ptr

type _PACKEDEVENTINFO
	ulSize as DWORD
	ulNumEventsForLogFile as DWORD
	ulOffsets(0 to 0) as DWORD
end type

type PACKEDEVENTINFO as _PACKEDEVENTINFO
type PPACKEDEVENTINFO as _PACKEDEVENTINFO ptr
const KEY_QUERY_VALUE = &h0001
const KEY_SET_VALUE = &h0002
const KEY_CREATE_SUB_KEY = &h0004
const KEY_ENUMERATE_SUB_KEYS = &h0008
const KEY_NOTIFY = &h0010
const KEY_CREATE_LINK = &h0020
const KEY_WOW64_64KEY = &h0100
const KEY_WOW64_32KEY = &h0200
const KEY_WOW64_RES = &h0300
const KEY_READ = (((STANDARD_RIGHTS_READ or KEY_QUERY_VALUE) or KEY_ENUMERATE_SUB_KEYS) or KEY_NOTIFY) and (not SYNCHRONIZE)
const KEY_WRITE = ((STANDARD_RIGHTS_WRITE or KEY_SET_VALUE) or KEY_CREATE_SUB_KEY) and (not SYNCHRONIZE)
const KEY_EXECUTE = KEY_READ and (not SYNCHRONIZE)
const KEY_ALL_ACCESS = ((((((STANDARD_RIGHTS_ALL or KEY_QUERY_VALUE) or KEY_SET_VALUE) or KEY_CREATE_SUB_KEY) or KEY_ENUMERATE_SUB_KEYS) or KEY_NOTIFY) or KEY_CREATE_LINK) and (not SYNCHRONIZE)
const REG_OPTION_RESERVED = &h00000000
const REG_OPTION_NON_VOLATILE = &h00000000
const REG_OPTION_VOLATILE = &h00000001
const REG_OPTION_CREATE_LINK = &h00000002
const REG_OPTION_BACKUP_RESTORE = &h00000004
const REG_OPTION_OPEN_LINK = &h00000008
const REG_LEGAL_OPTION = ((((REG_OPTION_RESERVED or REG_OPTION_NON_VOLATILE) or REG_OPTION_VOLATILE) or REG_OPTION_CREATE_LINK) or REG_OPTION_BACKUP_RESTORE) or REG_OPTION_OPEN_LINK
const REG_CREATED_NEW_KEY = &h00000001
const REG_OPENED_EXISTING_KEY = &h00000002
const REG_STANDARD_FORMAT = 1
const REG_LATEST_FORMAT = 2
const REG_NO_COMPRESSION = 4
const REG_WHOLE_HIVE_VOLATILE = &h00000001
const REG_REFRESH_HIVE = &h00000002
const REG_NO_LAZY_FLUSH = &h00000004
const REG_FORCE_RESTORE = &h00000008
const REG_APP_HIVE = &h00000010
const REG_PROCESS_PRIVATE = &h00000020
const REG_START_JOURNAL = &h00000040
const REG_HIVE_EXACT_FILE_GROWTH = &h00000080
const REG_HIVE_NO_RM = &h00000100
const REG_HIVE_SINGLE_LOG = &h00000200
const REG_BOOT_HIVE = &h00000400
const REG_FORCE_UNLOAD = 1
const REG_NOTIFY_CHANGE_NAME = &h00000001
const REG_NOTIFY_CHANGE_ATTRIBUTES = &h00000002
const REG_NOTIFY_CHANGE_LAST_SET = &h00000004
const REG_NOTIFY_CHANGE_SECURITY = &h00000008
const REG_NOTIFY_THREAD_AGNOSTIC = &h10000000
const REG_LEGAL_CHANGE_FILTER = (((REG_NOTIFY_CHANGE_NAME or REG_NOTIFY_CHANGE_ATTRIBUTES) or REG_NOTIFY_CHANGE_LAST_SET) or REG_NOTIFY_CHANGE_SECURITY) or REG_NOTIFY_THREAD_AGNOSTIC
const REG_NONE = 0
const REG_SZ = 1
const REG_EXPAND_SZ = 2
const REG_BINARY = 3
const REG_DWORD = 4
const REG_DWORD_LITTLE_ENDIAN = 4
const REG_DWORD_BIG_ENDIAN = 5
const REG_LINK = 6
const REG_MULTI_SZ = 7
const REG_RESOURCE_LIST = 8
const REG_FULL_RESOURCE_DESCRIPTOR = 9
const REG_RESOURCE_REQUIREMENTS_LIST = 10
const REG_QWORD = 11
const REG_QWORD_LITTLE_ENDIAN = 11
const SERVICE_KERNEL_DRIVER = &h00000001
const SERVICE_FILE_SYSTEM_DRIVER = &h00000002
const SERVICE_ADAPTER = &h00000004
const SERVICE_RECOGNIZER_DRIVER = &h00000008
const SERVICE_DRIVER = (SERVICE_KERNEL_DRIVER or SERVICE_FILE_SYSTEM_DRIVER) or SERVICE_RECOGNIZER_DRIVER
const SERVICE_WIN32_OWN_PROCESS = &h00000010
const SERVICE_WIN32_SHARE_PROCESS = &h00000020
const SERVICE_WIN32 = SERVICE_WIN32_OWN_PROCESS or SERVICE_WIN32_SHARE_PROCESS
const SERVICE_INTERACTIVE_PROCESS = &h00000100
const SERVICE_TYPE_ALL = ((SERVICE_WIN32 or SERVICE_ADAPTER) or SERVICE_DRIVER) or SERVICE_INTERACTIVE_PROCESS
const SERVICE_BOOT_START = &h00000000
const SERVICE_SYSTEM_START = &h00000001
const SERVICE_AUTO_START = &h00000002
const SERVICE_DEMAND_START = &h00000003
const SERVICE_DISABLED = &h00000004
const SERVICE_ERROR_IGNORE = &h00000000
const SERVICE_ERROR_NORMAL = &h00000001
const SERVICE_ERROR_SEVERE = &h00000002
const SERVICE_ERROR_CRITICAL = &h00000003

type _CM_SERVICE_NODE_TYPE as long
enum
	DriverType = &h00000001
	FileSystemType = &h00000002
	Win32ServiceOwnProcess = &h00000010
	Win32ServiceShareProcess = &h00000020
	AdapterType = &h00000004
	RecognizerType = &h00000008
end enum

type SERVICE_NODE_TYPE as _CM_SERVICE_NODE_TYPE

type _CM_SERVICE_LOAD_TYPE as long
enum
	BootLoad = &h00000000
	SystemLoad = &h00000001
	AutoLoad = &h00000002
	DemandLoad = &h00000003
	DisableLoad = &h00000004
end enum

type SERVICE_LOAD_TYPE as _CM_SERVICE_LOAD_TYPE

type _CM_ERROR_CONTROL_TYPE as long
enum
	IgnoreError = &h00000000
	NormalError = &h00000001
	SevereError = &h00000002
	CriticalError = &h00000003
end enum

type SERVICE_ERROR_TYPE as _CM_ERROR_CONTROL_TYPE
const CM_SERVICE_NETWORK_BOOT_LOAD = &h00000001
const CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD = &h00000002
const CM_SERVICE_USB_DISK_BOOT_LOAD = &h00000004
const CM_SERVICE_SD_DISK_BOOT_LOAD = &h00000008
const CM_SERVICE_USB3_DISK_BOOT_LOAD = &h00000010
const CM_SERVICE_MEASURED_BOOT_LOAD = &h00000020
const CM_SERVICE_VERIFIER_BOOT_LOAD = &h00000040
const CM_SERVICE_WINPE_BOOT_LOAD = &h00000080
const CM_SERVICE_VALID_PROMOTION_MASK = ((((((CM_SERVICE_NETWORK_BOOT_LOAD or CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD) or CM_SERVICE_USB_DISK_BOOT_LOAD) or CM_SERVICE_SD_DISK_BOOT_LOAD) or CM_SERVICE_USB3_DISK_BOOT_LOAD) or CM_SERVICE_MEASURED_BOOT_LOAD) or CM_SERVICE_VERIFIER_BOOT_LOAD) or CM_SERVICE_WINPE_BOOT_LOAD
#define _NTDDTAPE_WINNT_
const TAPE_ERASE_SHORT = 0
const TAPE_ERASE_LONG = 1

type _TAPE_ERASE
	as DWORD Type
	Immediate as WINBOOLEAN
end type

type TAPE_ERASE as _TAPE_ERASE
type PTAPE_ERASE as _TAPE_ERASE ptr
const TAPE_LOAD = 0
const TAPE_UNLOAD = 1
const TAPE_TENSION = 2
const TAPE_LOCK = 3
const TAPE_UNLOCK = 4
const TAPE_FORMAT = 5

type _TAPE_PREPARE
	Operation as DWORD
	Immediate as WINBOOLEAN
end type

type TAPE_PREPARE as _TAPE_PREPARE
type PTAPE_PREPARE as _TAPE_PREPARE ptr
const TAPE_SETMARKS = 0
const TAPE_FILEMARKS = 1
const TAPE_SHORT_FILEMARKS = 2
const TAPE_LONG_FILEMARKS = 3

type _TAPE_WRITE_MARKS
	as DWORD Type
	Count as DWORD
	Immediate as WINBOOLEAN
end type

type TAPE_WRITE_MARKS as _TAPE_WRITE_MARKS
type PTAPE_WRITE_MARKS as _TAPE_WRITE_MARKS ptr
const TAPE_ABSOLUTE_POSITION = 0
const TAPE_LOGICAL_POSITION = 1
const TAPE_PSEUDO_LOGICAL_POSITION = 2

type _TAPE_GET_POSITION
	as DWORD Type
	Partition as DWORD
	Offset as LARGE_INTEGER
end type

type TAPE_GET_POSITION as _TAPE_GET_POSITION
type PTAPE_GET_POSITION as _TAPE_GET_POSITION ptr
const TAPE_REWIND = 0
const TAPE_ABSOLUTE_BLOCK = 1
const TAPE_LOGICAL_BLOCK = 2
const TAPE_PSEUDO_LOGICAL_BLOCK = 3
const TAPE_SPACE_END_OF_DATA = 4
const TAPE_SPACE_RELATIVE_BLOCKS = 5
const TAPE_SPACE_FILEMARKS = 6
const TAPE_SPACE_SEQUENTIAL_FMKS = 7
const TAPE_SPACE_SETMARKS = 8
const TAPE_SPACE_SEQUENTIAL_SMKS = 9

type _TAPE_SET_POSITION
	Method as DWORD
	Partition as DWORD
	Offset as LARGE_INTEGER
	Immediate as WINBOOLEAN
end type

type TAPE_SET_POSITION as _TAPE_SET_POSITION
type PTAPE_SET_POSITION as _TAPE_SET_POSITION ptr
const TAPE_DRIVE_FIXED = &h00000001
const TAPE_DRIVE_SELECT = &h00000002
const TAPE_DRIVE_INITIATOR = &h00000004
const TAPE_DRIVE_ERASE_SHORT = &h00000010
const TAPE_DRIVE_ERASE_LONG = &h00000020
const TAPE_DRIVE_ERASE_BOP_ONLY = &h00000040
const TAPE_DRIVE_ERASE_IMMEDIATE = &h00000080
const TAPE_DRIVE_TAPE_CAPACITY = &h00000100
const TAPE_DRIVE_TAPE_REMAINING = &h00000200
const TAPE_DRIVE_FIXED_BLOCK = &h00000400
const TAPE_DRIVE_VARIABLE_BLOCK = &h00000800
const TAPE_DRIVE_WRITE_PROTECT = &h00001000
const TAPE_DRIVE_EOT_WZ_SIZE = &h00002000
const TAPE_DRIVE_ECC = &h00010000
const TAPE_DRIVE_COMPRESSION = &h00020000
const TAPE_DRIVE_PADDING = &h00040000
const TAPE_DRIVE_REPORT_SMKS = &h00080000
const TAPE_DRIVE_GET_ABSOLUTE_BLK = &h00100000
const TAPE_DRIVE_GET_LOGICAL_BLK = &h00200000
const TAPE_DRIVE_SET_EOT_WZ_SIZE = &h00400000
const TAPE_DRIVE_EJECT_MEDIA = &h01000000
const TAPE_DRIVE_CLEAN_REQUESTS = &h02000000
const TAPE_DRIVE_SET_CMP_BOP_ONLY = &h04000000
const TAPE_DRIVE_RESERVED_BIT = &h80000000
const TAPE_DRIVE_LOAD_UNLOAD = &h80000001
const TAPE_DRIVE_TENSION = &h80000002
const TAPE_DRIVE_LOCK_UNLOCK = &h80000004
const TAPE_DRIVE_REWIND_IMMEDIATE = &h80000008
const TAPE_DRIVE_SET_BLOCK_SIZE = &h80000010
const TAPE_DRIVE_LOAD_UNLD_IMMED = &h80000020
const TAPE_DRIVE_TENSION_IMMED = &h80000040
const TAPE_DRIVE_LOCK_UNLK_IMMED = &h80000080
const TAPE_DRIVE_SET_ECC = &h80000100
const TAPE_DRIVE_SET_COMPRESSION = &h80000200
const TAPE_DRIVE_SET_PADDING = &h80000400
const TAPE_DRIVE_SET_REPORT_SMKS = &h80000800
const TAPE_DRIVE_ABSOLUTE_BLK = &h80001000
const TAPE_DRIVE_ABS_BLK_IMMED = &h80002000
const TAPE_DRIVE_LOGICAL_BLK = &h80004000
const TAPE_DRIVE_LOG_BLK_IMMED = &h80008000
const TAPE_DRIVE_END_OF_DATA = &h80010000
const TAPE_DRIVE_RELATIVE_BLKS = &h80020000
const TAPE_DRIVE_FILEMARKS = &h80040000
const TAPE_DRIVE_SEQUENTIAL_FMKS = &h80080000
const TAPE_DRIVE_SETMARKS = &h80100000
const TAPE_DRIVE_SEQUENTIAL_SMKS = &h80200000
const TAPE_DRIVE_REVERSE_POSITION = &h80400000
const TAPE_DRIVE_SPACE_IMMEDIATE = &h80800000
const TAPE_DRIVE_WRITE_SETMARKS = &h81000000
const TAPE_DRIVE_WRITE_FILEMARKS = &h82000000
const TAPE_DRIVE_WRITE_SHORT_FMKS = &h84000000
const TAPE_DRIVE_WRITE_LONG_FMKS = &h88000000
const TAPE_DRIVE_WRITE_MARK_IMMED = &h90000000
const TAPE_DRIVE_FORMAT = &hA0000000
const TAPE_DRIVE_FORMAT_IMMEDIATE = &hC0000000
const TAPE_DRIVE_HIGH_FEATURES = &h80000000

type _TAPE_GET_DRIVE_PARAMETERS
	ECC as WINBOOLEAN
	Compression as WINBOOLEAN
	DataPadding as WINBOOLEAN
	ReportSetmarks as WINBOOLEAN
	DefaultBlockSize as DWORD
	MaximumBlockSize as DWORD
	MinimumBlockSize as DWORD
	MaximumPartitionCount as DWORD
	FeaturesLow as DWORD
	FeaturesHigh as DWORD
	EOTWarningZoneSize as DWORD
end type

type TAPE_GET_DRIVE_PARAMETERS as _TAPE_GET_DRIVE_PARAMETERS
type PTAPE_GET_DRIVE_PARAMETERS as _TAPE_GET_DRIVE_PARAMETERS ptr

type _TAPE_SET_DRIVE_PARAMETERS
	ECC as WINBOOLEAN
	Compression as WINBOOLEAN
	DataPadding as WINBOOLEAN
	ReportSetmarks as WINBOOLEAN
	EOTWarningZoneSize as DWORD
end type

type TAPE_SET_DRIVE_PARAMETERS as _TAPE_SET_DRIVE_PARAMETERS
type PTAPE_SET_DRIVE_PARAMETERS as _TAPE_SET_DRIVE_PARAMETERS ptr

type _TAPE_GET_MEDIA_PARAMETERS
	Capacity as LARGE_INTEGER
	Remaining as LARGE_INTEGER
	BlockSize as DWORD
	PartitionCount as DWORD
	WriteProtected as WINBOOLEAN
end type

type TAPE_GET_MEDIA_PARAMETERS as _TAPE_GET_MEDIA_PARAMETERS
type PTAPE_GET_MEDIA_PARAMETERS as _TAPE_GET_MEDIA_PARAMETERS ptr

type _TAPE_SET_MEDIA_PARAMETERS
	BlockSize as DWORD
end type

type TAPE_SET_MEDIA_PARAMETERS as _TAPE_SET_MEDIA_PARAMETERS
type PTAPE_SET_MEDIA_PARAMETERS as _TAPE_SET_MEDIA_PARAMETERS ptr
const TAPE_FIXED_PARTITIONS = 0
const TAPE_SELECT_PARTITIONS = 1
const TAPE_INITIATOR_PARTITIONS = 2

type _TAPE_CREATE_PARTITION
	Method as DWORD
	Count as DWORD
	Size as DWORD
end type

type TAPE_CREATE_PARTITION as _TAPE_CREATE_PARTITION
type PTAPE_CREATE_PARTITION as _TAPE_CREATE_PARTITION ptr
const TAPE_QUERY_DRIVE_PARAMETERS = 0
const TAPE_QUERY_MEDIA_CAPACITY = 1
const TAPE_CHECK_FOR_DRIVE_PROBLEM = 2
const TAPE_QUERY_IO_ERROR_DATA = 3
const TAPE_QUERY_DEVICE_ERROR_DATA = 4

type _TAPE_WMI_OPERATIONS
	Method as DWORD
	DataBufferSize as DWORD
	DataBuffer as PVOID
end type

type TAPE_WMI_OPERATIONS as _TAPE_WMI_OPERATIONS
type PTAPE_WMI_OPERATIONS as _TAPE_WMI_OPERATIONS ptr

type _TAPE_DRIVE_PROBLEM_TYPE as long
enum
	TapeDriveProblemNone
	TapeDriveReadWriteWarning
	TapeDriveReadWriteError
	TapeDriveReadWarning
	TapeDriveWriteWarning
	TapeDriveReadError
	TapeDriveWriteError
	TapeDriveHardwareError
	TapeDriveUnsupportedMedia
	TapeDriveScsiConnectionError
	TapeDriveTimetoClean
	TapeDriveCleanDriveNow
	TapeDriveMediaLifeExpired
	TapeDriveSnappedTape
end enum

type TAPE_DRIVE_PROBLEM_TYPE as _TAPE_DRIVE_PROBLEM_TYPE
type TP_VERSION as DWORD
type PTP_VERSION as DWORD ptr
type TP_CALLBACK_INSTANCE as _TP_CALLBACK_INSTANCE
type PTP_CALLBACK_INSTANCE as _TP_CALLBACK_INSTANCE ptr
type PTP_SIMPLE_CALLBACK as sub(byval Instance as PTP_CALLBACK_INSTANCE, byval Context as PVOID)
type TP_POOL as _TP_POOL
type PTP_POOL as _TP_POOL ptr

type _TP_CALLBACK_PRIORITY as long
enum
	TP_CALLBACK_PRIORITY_HIGH
	TP_CALLBACK_PRIORITY_NORMAL
	TP_CALLBACK_PRIORITY_LOW
	TP_CALLBACK_PRIORITY_INVALID
	TP_CALLBACK_PRIORITY_COUNT = TP_CALLBACK_PRIORITY_INVALID
end enum

type TP_CALLBACK_PRIORITY as _TP_CALLBACK_PRIORITY

type _TP_POOL_STACK_INFORMATION
	StackReserve as SIZE_T_
	StackCommit as SIZE_T_
end type

type TP_POOL_STACK_INFORMATION as _TP_POOL_STACK_INFORMATION
type PTP_POOL_STACK_INFORMATION as _TP_POOL_STACK_INFORMATION ptr
type TP_CLEANUP_GROUP as _TP_CLEANUP_GROUP
type PTP_CLEANUP_GROUP as _TP_CLEANUP_GROUP ptr
type PTP_CLEANUP_GROUP_CANCEL_CALLBACK as sub(byval ObjectContext as PVOID, byval CleanupContext as PVOID)

#if _WIN32_WINNT <= &h0600
	type _TP_CALLBACK_ENVIRON_V1_u_s
		LongFunction : 1 as DWORD
		Persistent : 1 as DWORD
		as DWORD Private : 30
	end type

	union _TP_CALLBACK_ENVIRON_V1_u
		Flags as DWORD
		s as _TP_CALLBACK_ENVIRON_V1_u_s
	end union
#else
	type _TP_CALLBACK_ENVIRON_V3_u_s
		LongFunction : 1 as DWORD
		Persistent : 1 as DWORD
		as DWORD Private : 30
	end type

	union _TP_CALLBACK_ENVIRON_V3_u
		Flags as DWORD
		s as _TP_CALLBACK_ENVIRON_V3_u_s
	end union
#endif

type _ACTIVATION_CONTEXT as _ACTIVATION_CONTEXT_

#if _WIN32_WINNT <= &h0600
	type _TP_CALLBACK_ENVIRON_V1
		Version as TP_VERSION
		Pool as PTP_POOL
		CleanupGroup as PTP_CLEANUP_GROUP
		CleanupGroupCancelCallback as PTP_CLEANUP_GROUP_CANCEL_CALLBACK
		RaceDll as PVOID
		ActivationContext as _ACTIVATION_CONTEXT ptr
		FinalizationCallback as PTP_SIMPLE_CALLBACK
		u as _TP_CALLBACK_ENVIRON_V1_u
	end type

	type TP_CALLBACK_ENVIRON_V1 as _TP_CALLBACK_ENVIRON_V1
	type TP_CALLBACK_ENVIRON as TP_CALLBACK_ENVIRON_V1
	type PTP_CALLBACK_ENVIRON as TP_CALLBACK_ENVIRON_V1 ptr
#else
	type _TP_CALLBACK_ENVIRON_V3
		Version as TP_VERSION
		Pool as PTP_POOL
		CleanupGroup as PTP_CLEANUP_GROUP
		CleanupGroupCancelCallback as PTP_CLEANUP_GROUP_CANCEL_CALLBACK
		RaceDll as PVOID
		ActivationContext as _ACTIVATION_CONTEXT ptr
		FinalizationCallback as PTP_SIMPLE_CALLBACK
		u as _TP_CALLBACK_ENVIRON_V3_u
		CallbackPriority as TP_CALLBACK_PRIORITY
		Size as DWORD
	end type

	type TP_CALLBACK_ENVIRON_V3 as _TP_CALLBACK_ENVIRON_V3
	type TP_CALLBACK_ENVIRON as TP_CALLBACK_ENVIRON_V3
	type PTP_CALLBACK_ENVIRON as TP_CALLBACK_ENVIRON_V3 ptr
#endif

type TP_WORK as _TP_WORK
type PTP_WORK as _TP_WORK ptr
type PTP_WORK_CALLBACK as sub(byval Instance as PTP_CALLBACK_INSTANCE, byval Context as PVOID, byval Work as PTP_WORK)
type TP_TIMER as _TP_TIMER
type PTP_TIMER as _TP_TIMER ptr
type PTP_TIMER_CALLBACK as sub(byval Instance as PTP_CALLBACK_INSTANCE, byval Context as PVOID, byval Timer as PTP_TIMER)
type TP_WAIT_RESULT as DWORD
type TP_WAIT as _TP_WAIT
type PTP_WAIT as _TP_WAIT ptr
type PTP_WAIT_CALLBACK as sub(byval Instance as PTP_CALLBACK_INSTANCE, byval Context as PVOID, byval Wait as PTP_WAIT, byval WaitResult as TP_WAIT_RESULT)
type TP_IO as _TP_IO
type PTP_IO as _TP_IO ptr

#if _WIN32_WINNT <= &h0600
	private sub TpInitializeCallbackEnviron cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
		cbe->Pool = cptr(any ptr, 0)
		cbe->CleanupGroup = cptr(any ptr, 0)
		cbe->CleanupGroupCancelCallback = cptr(any ptr, 0)
		cbe->RaceDll = cptr(any ptr, 0)
		cbe->ActivationContext = cptr(any ptr, 0)
		cbe->FinalizationCallback = cptr(any ptr, 0)
		cbe->u.Flags = 0
		cbe->Version = 1
	end sub
#else
	private sub TpInitializeCallbackEnviron cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
		cbe->Pool = cptr(any ptr, 0)
		cbe->CleanupGroup = cptr(any ptr, 0)
		cbe->CleanupGroupCancelCallback = cptr(any ptr, 0)
		cbe->RaceDll = cptr(any ptr, 0)
		cbe->ActivationContext = cptr(any ptr, 0)
		cbe->FinalizationCallback = cptr(any ptr, 0)
		cbe->u.Flags = 0
		cbe->Version = 3
		cbe->CallbackPriority = TP_CALLBACK_PRIORITY_NORMAL
		cbe->Size = sizeof(TP_CALLBACK_ENVIRON)
	end sub
#endif

private sub TpSetCallbackThreadpool cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval pool as PTP_POOL)
	cbe->Pool = pool
end sub

private sub TpSetCallbackCleanupGroup cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval cleanup_group as PTP_CLEANUP_GROUP, byval cleanup_group_cb as PTP_CLEANUP_GROUP_CANCEL_CALLBACK)
	cbe->CleanupGroup = cleanup_group
	cbe->CleanupGroupCancelCallback = cleanup_group_cb
end sub

private sub TpSetCallbackActivationContext cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval actx as _ACTIVATION_CONTEXT ptr)
	cbe->ActivationContext = actx
end sub

private sub TpSetCallbackNoActivationContext cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
	cbe->ActivationContext = cptr(_ACTIVATION_CONTEXT ptr, cast(LONG_PTR, -1))
end sub

private sub TpSetCallbackLongFunction cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
	cbe->u.s.LongFunction = 1
end sub

private sub TpSetCallbackRaceWithDll cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval h as PVOID)
	cbe->RaceDll = h
end sub

private sub TpSetCallbackFinalizationCallback cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval fini_cb as PTP_SIMPLE_CALLBACK)
	cbe->FinalizationCallback = fini_cb
end sub

#if _WIN32_WINNT >= &h0601
	private sub TpSetCallbackPriority cdecl(byval cbe as PTP_CALLBACK_ENVIRON, byval prio as TP_CALLBACK_PRIORITY)
		cbe->CallbackPriority = prio
	end sub
#endif

private sub TpSetCallbackPersistent cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
	cbe->u.s.Persistent = 1
end sub

private sub TpDestroyCallbackEnviron cdecl(byval cbe as PTP_CALLBACK_ENVIRON)
	cbe = cbe
end sub

#ifdef __FB_64BIT__
	#define NtCurrentTeb() cptr(_TEB ptr, __readgsqword(cast(LONG, offsetof(NT_TIB, Self))))
	#define GetCurrentFiber() cast(PVOID, __readgsqword(cast(LONG, offsetof(NT_TIB, FiberData))))
	#define GetFiberData() cast(PVOID, *cptr(PVOID ptr, GetCurrentFiber()))
#endif

#define _NTTMAPI_
const TRANSACTIONMANAGER_QUERY_INFORMATION = &h00001
const TRANSACTIONMANAGER_SET_INFORMATION = &h00002
const TRANSACTIONMANAGER_RECOVER = &h00004
const TRANSACTIONMANAGER_RENAME = &h00008
const TRANSACTIONMANAGER_CREATE_RM = &h00010
const TRANSACTIONMANAGER_BIND_TRANSACTION = &h00020
const TRANSACTIONMANAGER_GENERIC_READ = STANDARD_RIGHTS_READ or TRANSACTIONMANAGER_QUERY_INFORMATION
const TRANSACTIONMANAGER_GENERIC_WRITE = (((STANDARD_RIGHTS_WRITE or TRANSACTIONMANAGER_SET_INFORMATION) or TRANSACTIONMANAGER_RECOVER) or TRANSACTIONMANAGER_RENAME) or TRANSACTIONMANAGER_CREATE_RM
const TRANSACTIONMANAGER_GENERIC_EXECUTE = STANDARD_RIGHTS_EXECUTE
const TRANSACTIONMANAGER_ALL_ACCESS = (((STANDARD_RIGHTS_REQUIRED or TRANSACTIONMANAGER_GENERIC_READ) or TRANSACTIONMANAGER_GENERIC_WRITE) or TRANSACTIONMANAGER_GENERIC_EXECUTE) or TRANSACTIONMANAGER_BIND_TRANSACTION
const TRANSACTION_QUERY_INFORMATION = &h0001
const TRANSACTION_SET_INFORMATION = &h0002
const TRANSACTION_ENLIST = &h0004
const TRANSACTION_COMMIT = &h0008
const TRANSACTION_ROLLBACK = &h0010
const TRANSACTION_PROPAGATE = &h0020
const TRANSACTION_RIGHT_RESERVED1 = &h0040
const TRANSACTION_GENERIC_READ = (STANDARD_RIGHTS_READ or TRANSACTION_QUERY_INFORMATION) or SYNCHRONIZE
const TRANSACTION_GENERIC_WRITE = (((((STANDARD_RIGHTS_WRITE or TRANSACTION_SET_INFORMATION) or TRANSACTION_COMMIT) or TRANSACTION_ENLIST) or TRANSACTION_ROLLBACK) or TRANSACTION_PROPAGATE) or SYNCHRONIZE
const TRANSACTION_GENERIC_EXECUTE = ((STANDARD_RIGHTS_EXECUTE or TRANSACTION_COMMIT) or TRANSACTION_ROLLBACK) or SYNCHRONIZE
const TRANSACTION_ALL_ACCESS = ((STANDARD_RIGHTS_REQUIRED or TRANSACTION_GENERIC_READ) or TRANSACTION_GENERIC_WRITE) or TRANSACTION_GENERIC_EXECUTE
const TRANSACTION_RESOURCE_MANAGER_RIGHTS = (((((TRANSACTION_GENERIC_READ or STANDARD_RIGHTS_WRITE) or TRANSACTION_SET_INFORMATION) or TRANSACTION_ENLIST) or TRANSACTION_ROLLBACK) or TRANSACTION_PROPAGATE) or SYNCHRONIZE
const RESOURCEMANAGER_QUERY_INFORMATION = &h0001
const RESOURCEMANAGER_SET_INFORMATION = &h0002
const RESOURCEMANAGER_RECOVER = &h0004
const RESOURCEMANAGER_ENLIST = &h0008
const RESOURCEMANAGER_GET_NOTIFICATION = &h0010
const RESOURCEMANAGER_REGISTER_PROTOCOL = &h0020
const RESOURCEMANAGER_COMPLETE_PROPAGATION = &h0040
const RESOURCEMANAGER_GENERIC_READ = (STANDARD_RIGHTS_READ or RESOURCEMANAGER_QUERY_INFORMATION) or SYNCHRONIZE
const RESOURCEMANAGER_GENERIC_WRITE = ((((((STANDARD_RIGHTS_WRITE or RESOURCEMANAGER_SET_INFORMATION) or RESOURCEMANAGER_RECOVER) or RESOURCEMANAGER_ENLIST) or RESOURCEMANAGER_GET_NOTIFICATION) or RESOURCEMANAGER_REGISTER_PROTOCOL) or RESOURCEMANAGER_COMPLETE_PROPAGATION) or SYNCHRONIZE
const RESOURCEMANAGER_GENERIC_EXECUTE = ((((STANDARD_RIGHTS_EXECUTE or RESOURCEMANAGER_RECOVER) or RESOURCEMANAGER_ENLIST) or RESOURCEMANAGER_GET_NOTIFICATION) or RESOURCEMANAGER_COMPLETE_PROPAGATION) or SYNCHRONIZE
const RESOURCEMANAGER_ALL_ACCESS = ((STANDARD_RIGHTS_REQUIRED or RESOURCEMANAGER_GENERIC_READ) or RESOURCEMANAGER_GENERIC_WRITE) or RESOURCEMANAGER_GENERIC_EXECUTE
const ENLISTMENT_QUERY_INFORMATION = 1
const ENLISTMENT_SET_INFORMATION = 2
const ENLISTMENT_RECOVER = 4
const ENLISTMENT_SUBORDINATE_RIGHTS = 8
const ENLISTMENT_SUPERIOR_RIGHTS = &h10
const ENLISTMENT_GENERIC_READ = STANDARD_RIGHTS_READ or ENLISTMENT_QUERY_INFORMATION
const ENLISTMENT_GENERIC_WRITE = (((STANDARD_RIGHTS_WRITE or ENLISTMENT_SET_INFORMATION) or ENLISTMENT_RECOVER) or ENLISTMENT_SUBORDINATE_RIGHTS) or ENLISTMENT_SUPERIOR_RIGHTS
const ENLISTMENT_GENERIC_EXECUTE = ((STANDARD_RIGHTS_EXECUTE or ENLISTMENT_RECOVER) or ENLISTMENT_SUBORDINATE_RIGHTS) or ENLISTMENT_SUPERIOR_RIGHTS
const ENLISTMENT_ALL_ACCESS = ((STANDARD_RIGHTS_REQUIRED or ENLISTMENT_GENERIC_READ) or ENLISTMENT_GENERIC_WRITE) or ENLISTMENT_GENERIC_EXECUTE

type _TRANSACTION_OUTCOME as long
enum
	TransactionOutcomeUndetermined = 1
	TransactionOutcomeCommitted
	TransactionOutcomeAborted
end enum

type TRANSACTION_OUTCOME as _TRANSACTION_OUTCOME

type _TRANSACTION_STATE as long
enum
	TransactionStateNormal = 1
	TransactionStateIndoubt
	TransactionStateCommittedNotify
end enum

type TRANSACTION_STATE as _TRANSACTION_STATE

type _TRANSACTION_BASIC_INFORMATION
	TransactionId as GUID
	State as DWORD
	Outcome as DWORD
end type

type TRANSACTION_BASIC_INFORMATION as _TRANSACTION_BASIC_INFORMATION
type PTRANSACTION_BASIC_INFORMATION as _TRANSACTION_BASIC_INFORMATION ptr

type _TRANSACTIONMANAGER_BASIC_INFORMATION
	TmIdentity as GUID
	VirtualClock as LARGE_INTEGER
end type

type TRANSACTIONMANAGER_BASIC_INFORMATION as _TRANSACTIONMANAGER_BASIC_INFORMATION
type PTRANSACTIONMANAGER_BASIC_INFORMATION as _TRANSACTIONMANAGER_BASIC_INFORMATION ptr

type _TRANSACTIONMANAGER_LOG_INFORMATION
	LogIdentity as GUID
end type

type TRANSACTIONMANAGER_LOG_INFORMATION as _TRANSACTIONMANAGER_LOG_INFORMATION
type PTRANSACTIONMANAGER_LOG_INFORMATION as _TRANSACTIONMANAGER_LOG_INFORMATION ptr

type _TRANSACTIONMANAGER_LOGPATH_INFORMATION
	LogPathLength as DWORD
	LogPath as wstring * 1
end type

type TRANSACTIONMANAGER_LOGPATH_INFORMATION as _TRANSACTIONMANAGER_LOGPATH_INFORMATION
type PTRANSACTIONMANAGER_LOGPATH_INFORMATION as _TRANSACTIONMANAGER_LOGPATH_INFORMATION ptr

type _TRANSACTIONMANAGER_RECOVERY_INFORMATION
	LastRecoveredLsn as ULONGLONG
end type

type TRANSACTIONMANAGER_RECOVERY_INFORMATION as _TRANSACTIONMANAGER_RECOVERY_INFORMATION
type PTRANSACTIONMANAGER_RECOVERY_INFORMATION as _TRANSACTIONMANAGER_RECOVERY_INFORMATION ptr

type _TRANSACTIONMANAGER_OLDEST_INFORMATION
	OldestTransactionGuid as GUID
end type

type TRANSACTIONMANAGER_OLDEST_INFORMATION as _TRANSACTIONMANAGER_OLDEST_INFORMATION
type PTRANSACTIONMANAGER_OLDEST_INFORMATION as _TRANSACTIONMANAGER_OLDEST_INFORMATION ptr

type _TRANSACTION_PROPERTIES_INFORMATION
	IsolationLevel as DWORD
	IsolationFlags as DWORD
	Timeout as LARGE_INTEGER
	Outcome as DWORD
	DescriptionLength as DWORD
	Description as wstring * 1
end type

type TRANSACTION_PROPERTIES_INFORMATION as _TRANSACTION_PROPERTIES_INFORMATION
type PTRANSACTION_PROPERTIES_INFORMATION as _TRANSACTION_PROPERTIES_INFORMATION ptr

type _TRANSACTION_BIND_INFORMATION
	TmHandle as HANDLE
end type

type TRANSACTION_BIND_INFORMATION as _TRANSACTION_BIND_INFORMATION
type PTRANSACTION_BIND_INFORMATION as _TRANSACTION_BIND_INFORMATION ptr

type _TRANSACTION_ENLISTMENT_PAIR
	EnlistmentId as GUID
	ResourceManagerId as GUID
end type

type TRANSACTION_ENLISTMENT_PAIR as _TRANSACTION_ENLISTMENT_PAIR
type PTRANSACTION_ENLISTMENT_PAIR as _TRANSACTION_ENLISTMENT_PAIR ptr

type _TRANSACTION_ENLISTMENTS_INFORMATION
	NumberOfEnlistments as DWORD
	EnlistmentPair(0 to 0) as TRANSACTION_ENLISTMENT_PAIR
end type

type TRANSACTION_ENLISTMENTS_INFORMATION as _TRANSACTION_ENLISTMENTS_INFORMATION
type PTRANSACTION_ENLISTMENTS_INFORMATION as _TRANSACTION_ENLISTMENTS_INFORMATION ptr

type _TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
	SuperiorEnlistmentPair as TRANSACTION_ENLISTMENT_PAIR
end type

type TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION as _TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
type PTRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION as _TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION ptr

type _RESOURCEMANAGER_BASIC_INFORMATION
	ResourceManagerId as GUID
	DescriptionLength as DWORD
	Description as wstring * 1
end type

type RESOURCEMANAGER_BASIC_INFORMATION as _RESOURCEMANAGER_BASIC_INFORMATION
type PRESOURCEMANAGER_BASIC_INFORMATION as _RESOURCEMANAGER_BASIC_INFORMATION ptr

type _RESOURCEMANAGER_COMPLETION_INFORMATION
	IoCompletionPortHandle as HANDLE
	CompletionKey as ULONG_PTR
end type

type RESOURCEMANAGER_COMPLETION_INFORMATION as _RESOURCEMANAGER_COMPLETION_INFORMATION
type PRESOURCEMANAGER_COMPLETION_INFORMATION as _RESOURCEMANAGER_COMPLETION_INFORMATION ptr

type _TRANSACTION_INFORMATION_CLASS as long
enum
	TransactionBasicInformation
	TransactionPropertiesInformation
	TransactionEnlistmentInformation
	TransactionSuperiorEnlistmentInformation
	TransactionBindInformation
	TransactionDTCPrivateInformation
end enum

type TRANSACTION_INFORMATION_CLASS as _TRANSACTION_INFORMATION_CLASS

type _TRANSACTIONMANAGER_INFORMATION_CLASS as long
enum
	TransactionManagerBasicInformation
	TransactionManagerLogInformation
	TransactionManagerLogPathInformation
	TransactionManagerOnlineProbeInformation = 3
	TransactionManagerRecoveryInformation = 4
	TransactionManagerOldestTransactionInformation = 5
end enum

type TRANSACTIONMANAGER_INFORMATION_CLASS as _TRANSACTIONMANAGER_INFORMATION_CLASS

type _RESOURCEMANAGER_INFORMATION_CLASS as long
enum
	ResourceManagerBasicInformation
	ResourceManagerCompletionInformation
end enum

type RESOURCEMANAGER_INFORMATION_CLASS as _RESOURCEMANAGER_INFORMATION_CLASS

type _ENLISTMENT_BASIC_INFORMATION
	EnlistmentId as GUID
	TransactionId as GUID
	ResourceManagerId as GUID
end type

type ENLISTMENT_BASIC_INFORMATION as _ENLISTMENT_BASIC_INFORMATION
type PENLISTMENT_BASIC_INFORMATION as _ENLISTMENT_BASIC_INFORMATION ptr

type _ENLISTMENT_CRM_INFORMATION
	CrmTransactionManagerId as GUID
	CrmResourceManagerId as GUID
	CrmEnlistmentId as GUID
end type

type ENLISTMENT_CRM_INFORMATION as _ENLISTMENT_CRM_INFORMATION
type PENLISTMENT_CRM_INFORMATION as _ENLISTMENT_CRM_INFORMATION ptr

type _ENLISTMENT_INFORMATION_CLASS as long
enum
	EnlistmentBasicInformation
	EnlistmentRecoveryInformation
	EnlistmentCrmInformation
end enum

type ENLISTMENT_INFORMATION_CLASS as _ENLISTMENT_INFORMATION_CLASS

type _TRANSACTION_LIST_ENTRY
	UOW as GUID
end type

type TRANSACTION_LIST_ENTRY as _TRANSACTION_LIST_ENTRY
type PTRANSACTION_LIST_ENTRY as _TRANSACTION_LIST_ENTRY ptr

type _TRANSACTION_LIST_INFORMATION
	NumberOfTransactions as DWORD
	TransactionInformation(0 to 0) as TRANSACTION_LIST_ENTRY
end type

type TRANSACTION_LIST_INFORMATION as _TRANSACTION_LIST_INFORMATION
type PTRANSACTION_LIST_INFORMATION as _TRANSACTION_LIST_INFORMATION ptr

type _KTMOBJECT_TYPE as long
enum
	KTMOBJECT_TRANSACTION
	KTMOBJECT_TRANSACTION_MANAGER
	KTMOBJECT_RESOURCE_MANAGER
	KTMOBJECT_ENLISTMENT
	KTMOBJECT_INVALID
end enum

type KTMOBJECT_TYPE as _KTMOBJECT_TYPE
type PKTMOBJECT_TYPE as _KTMOBJECT_TYPE ptr

type _KTMOBJECT_CURSOR
	LastQuery as GUID
	ObjectIdCount as DWORD
	ObjectIds(0 to 0) as GUID
end type

type KTMOBJECT_CURSOR as _KTMOBJECT_CURSOR
type PKTMOBJECT_CURSOR as _KTMOBJECT_CURSOR ptr
const WOW64_CONTEXT_i386 = &h00010000
const WOW64_CONTEXT_i486 = &h00010000
const WOW64_CONTEXT_CONTROL = WOW64_CONTEXT_i386 or &h00000001
const WOW64_CONTEXT_INTEGER = WOW64_CONTEXT_i386 or &h00000002
const WOW64_CONTEXT_SEGMENTS = WOW64_CONTEXT_i386 or &h00000004
const WOW64_CONTEXT_FLOATING_POINT = WOW64_CONTEXT_i386 or &h00000008
const WOW64_CONTEXT_DEBUG_REGISTERS = WOW64_CONTEXT_i386 or &h00000010
const WOW64_CONTEXT_EXTENDED_REGISTERS = WOW64_CONTEXT_i386 or &h00000020
const WOW64_CONTEXT_FULL = (WOW64_CONTEXT_CONTROL or WOW64_CONTEXT_INTEGER) or WOW64_CONTEXT_SEGMENTS
const WOW64_CONTEXT_ALL = ((((WOW64_CONTEXT_CONTROL or WOW64_CONTEXT_INTEGER) or WOW64_CONTEXT_SEGMENTS) or WOW64_CONTEXT_FLOATING_POINT) or WOW64_CONTEXT_DEBUG_REGISTERS) or WOW64_CONTEXT_EXTENDED_REGISTERS
const WOW64_CONTEXT_XSTATE = WOW64_CONTEXT_i386 or &h00000040
const WOW64_CONTEXT_EXCEPTION_ACTIVE = &h08000000
const WOW64_CONTEXT_SERVICE_ACTIVE = &h10000000
const WOW64_CONTEXT_EXCEPTION_REQUEST = &h40000000
const WOW64_CONTEXT_EXCEPTION_REPORTING = &h80000000
const WOW64_SIZE_OF_80387_REGISTERS = 80
const WOW64_MAXIMUM_SUPPORTED_EXTENSION = 512

type _WOW64_FLOATING_SAVE_AREA
	ControlWord as DWORD
	StatusWord as DWORD
	TagWord as DWORD
	ErrorOffset as DWORD
	ErrorSelector as DWORD
	DataOffset as DWORD
	DataSelector as DWORD
	RegisterArea(0 to 79) as UBYTE
	Cr0NpxState as DWORD
end type

type WOW64_FLOATING_SAVE_AREA as _WOW64_FLOATING_SAVE_AREA
type PWOW64_FLOATING_SAVE_AREA as _WOW64_FLOATING_SAVE_AREA ptr

type _WOW64_CONTEXT field = 4
	ContextFlags as DWORD
	Dr0 as DWORD
	Dr1 as DWORD
	Dr2 as DWORD
	Dr3 as DWORD
	Dr6 as DWORD
	Dr7 as DWORD
	FloatSave as WOW64_FLOATING_SAVE_AREA
	SegGs as DWORD
	SegFs as DWORD
	SegEs as DWORD
	SegDs as DWORD
	Edi as DWORD
	Esi as DWORD
	Ebx as DWORD
	Edx as DWORD
	Ecx as DWORD
	Eax as DWORD
	Ebp as DWORD
	Eip as DWORD
	SegCs as DWORD
	EFlags as DWORD
	Esp as DWORD
	SegSs as DWORD
	ExtendedRegisters(0 to 511) as UBYTE
end type

type WOW64_CONTEXT as _WOW64_CONTEXT
type PWOW64_CONTEXT as _WOW64_CONTEXT ptr

type _WOW64_LDT_ENTRY_HighWord_Bytes
	BaseMid as UBYTE
	Flags1 as UBYTE
	Flags2 as UBYTE
	BaseHi as UBYTE
end type

type _WOW64_LDT_ENTRY_HighWord_Bits
	BaseMid : 8 as DWORD
	as DWORD Type : 5
	Dpl : 2 as DWORD
	Pres : 1 as DWORD
	LimitHi : 4 as DWORD
	Sys : 1 as DWORD
	Reserved_0 : 1 as DWORD
	Default_Big : 1 as DWORD
	Granularity : 1 as DWORD
	BaseHi : 8 as DWORD
end type

union _WOW64_LDT_ENTRY_HighWord
	Bytes as _WOW64_LDT_ENTRY_HighWord_Bytes
	Bits as _WOW64_LDT_ENTRY_HighWord_Bits
end union

type _WOW64_LDT_ENTRY
	LimitLow as WORD
	BaseLow as WORD
	HighWord as _WOW64_LDT_ENTRY_HighWord
end type

type WOW64_LDT_ENTRY as _WOW64_LDT_ENTRY
type PWOW64_LDT_ENTRY as _WOW64_LDT_ENTRY ptr

type _WOW64_DESCRIPTOR_TABLE_ENTRY
	Selector as DWORD
	Descriptor as WOW64_LDT_ENTRY
end type

type WOW64_DESCRIPTOR_TABLE_ENTRY as _WOW64_DESCRIPTOR_TABLE_ENTRY
type PWOW64_DESCRIPTOR_TABLE_ENTRY as _WOW64_DESCRIPTOR_TABLE_ENTRY ptr

#if _WIN32_WINNT >= &h0601
	#define ___PROCESSOR_NUMBER_DEFINED

	type _PROCESSOR_NUMBER
		Group as WORD
		Number as UBYTE
		Reserved as UBYTE
	end type

	type PROCESSOR_NUMBER as _PROCESSOR_NUMBER
	type PPROCESSOR_NUMBER as _PROCESSOR_NUMBER ptr
	const ALL_PROCESSOR_GROUPS = &hffff
#endif

const ACTIVATION_CONTEXT_SECTION_ASSEMBLY_INFORMATION = 1
const ACTIVATION_CONTEXT_SECTION_DLL_REDIRECTION = 2
const ACTIVATION_CONTEXT_SECTION_WINDOW_CLASS_REDIRECTION = 3
const ACTIVATION_CONTEXT_SECTION_COM_SERVER_REDIRECTION = 4
const ACTIVATION_CONTEXT_SECTION_COM_INTERFACE_REDIRECTION = 5
const ACTIVATION_CONTEXT_SECTION_COM_TYPE_LIBRARY_REDIRECTION = 6
const ACTIVATION_CONTEXT_SECTION_COM_PROGID_REDIRECTION = 7
const ACTIVATION_CONTEXT_SECTION_GLOBAL_OBJECT_RENAME_TABLE = 8
const ACTIVATION_CONTEXT_SECTION_CLR_SURROGATES = 9
const ACTIVATION_CONTEXT_SECTION_APPLICATION_SETTINGS = 10
const ACTIVATION_CONTEXT_SECTION_COMPATIBILITY_INFO = 11

end extern

#include once "ktmtypes.bi"
