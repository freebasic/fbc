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

#inclib "msacm32"

extern "Windows"

#define _INC_ACM
const DRV_MAPPER_PREFERRED_INPUT_GET = DRV_USER + 0
const DRV_MAPPER_PREFERRED_OUTPUT_GET = DRV_USER + 2
const DRVM_MAPPER = &h2000
const DRVM_MAPPER_STATUS = DRVM_MAPPER + 0
const WIDM_MAPPER_STATUS = DRVM_MAPPER_STATUS + 0
const WAVEIN_MAPPER_STATUS_DEVICE = 0
const WAVEIN_MAPPER_STATUS_MAPPED = 1
const WAVEIN_MAPPER_STATUS_FORMAT = 2
const WODM_MAPPER_STATUS = DRVM_MAPPER_STATUS + 0
const WAVEOUT_MAPPER_STATUS_DEVICE = 0
const WAVEOUT_MAPPER_STATUS_MAPPED = 1
const WAVEOUT_MAPPER_STATUS_FORMAT = 2

type HACMDRIVERID__ field = 1
	unused as long
end type

type HACMDRIVERID as HACMDRIVERID__ ptr
type PHACMDRIVERID as HACMDRIVERID ptr
type LPHACMDRIVERID as HACMDRIVERID ptr

type HACMDRIVER__ field = 1
	unused as long
end type

type HACMDRIVER as HACMDRIVER__ ptr
type PHACMDRIVER as HACMDRIVER ptr
type LPHACMDRIVER as HACMDRIVER ptr

type HACMSTREAM__ field = 1
	unused as long
end type

type HACMSTREAM as HACMSTREAM__ ptr
type PHACMSTREAM as HACMSTREAM ptr
type LPHACMSTREAM as HACMSTREAM ptr

type HACMOBJ__ field = 1
	unused as long
end type

type HACMOBJ as HACMOBJ__ ptr
type PHACMOBJ as HACMOBJ ptr
type LPHACMOBJ as HACMOBJ ptr

const ACMERR_BASE = 512
const ACMERR_NOTPOSSIBLE = ACMERR_BASE + 0
const ACMERR_BUSY = ACMERR_BASE + 1
const ACMERR_UNPREPARED = ACMERR_BASE + 2
const ACMERR_CANCELED = ACMERR_BASE + 3
const MM_ACM_OPEN = MM_STREAM_OPEN
const MM_ACM_CLOSE = MM_STREAM_CLOSE
const MM_ACM_DONE = MM_STREAM_DONE
declare function acmGetVersion() as DWORD
declare function acmMetrics(byval hao as HACMOBJ, byval uMetric as UINT, byval pMetric as LPVOID) as MMRESULT
const ACM_METRIC_COUNT_DRIVERS = 1
const ACM_METRIC_COUNT_CODECS = 2
const ACM_METRIC_COUNT_CONVERTERS = 3
const ACM_METRIC_COUNT_FILTERS = 4
const ACM_METRIC_COUNT_DISABLED = 5
const ACM_METRIC_COUNT_HARDWARE = 6
const ACM_METRIC_COUNT_LOCAL_DRIVERS = 20
const ACM_METRIC_COUNT_LOCAL_CODECS = 21
const ACM_METRIC_COUNT_LOCAL_CONVERTERS = 22
const ACM_METRIC_COUNT_LOCAL_FILTERS = 23
const ACM_METRIC_COUNT_LOCAL_DISABLED = 24
const ACM_METRIC_HARDWARE_WAVE_INPUT = 30
const ACM_METRIC_HARDWARE_WAVE_OUTPUT = 31
const ACM_METRIC_MAX_SIZE_FORMAT = 50
const ACM_METRIC_MAX_SIZE_FILTER = 51
const ACM_METRIC_DRIVER_SUPPORT = 100
const ACM_METRIC_DRIVER_PRIORITY = 101
type ACMDRIVERENUMCB as function(byval hadid as HACMDRIVERID, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
declare function acmDriverEnum(byval fnCallback as ACMDRIVERENUMCB, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
const ACM_DRIVERENUMF_NOLOCAL = &h40000000
const ACM_DRIVERENUMF_DISABLED = &h80000000

declare function acmDriverID(byval hao as HACMOBJ, byval phadid as LPHACMDRIVERID, byval fdwDriverID as DWORD) as MMRESULT
declare function acmDriverAddA(byval phadid as LPHACMDRIVERID, byval hinstModule as HINSTANCE, byval lParam as LPARAM, byval dwPriority as DWORD, byval fdwAdd as DWORD) as MMRESULT
declare function acmDriverAddW(byval phadid as LPHACMDRIVERID, byval hinstModule as HINSTANCE, byval lParam as LPARAM, byval dwPriority as DWORD, byval fdwAdd as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmDriverAdd alias "acmDriverAddW"(byval phadid as LPHACMDRIVERID, byval hinstModule as HINSTANCE, byval lParam as LPARAM, byval dwPriority as DWORD, byval fdwAdd as DWORD) as MMRESULT
#else
	declare function acmDriverAdd alias "acmDriverAddA"(byval phadid as LPHACMDRIVERID, byval hinstModule as HINSTANCE, byval lParam as LPARAM, byval dwPriority as DWORD, byval fdwAdd as DWORD) as MMRESULT
#endif

const ACM_DRIVERADDF_NAME = &h00000001
const ACM_DRIVERADDF_FUNCTION = &h00000003
const ACM_DRIVERADDF_NOTIFYHWND = &h00000004
const ACM_DRIVERADDF_TYPEMASK = &h00000007
const ACM_DRIVERADDF_LOCAL = &h00000000
const ACM_DRIVERADDF_GLOBAL = &h00000008
type ACMDRIVERPROC as function(byval as DWORD_PTR, byval as HACMDRIVERID, byval as UINT, byval as LPARAM, byval as LPARAM) as LRESULT
type LPACMDRIVERPROC as ACMDRIVERPROC ptr

declare function acmDriverRemove(byval hadid as HACMDRIVERID, byval fdwRemove as DWORD) as MMRESULT
declare function acmDriverOpen(byval phad as LPHACMDRIVER, byval hadid as HACMDRIVERID, byval fdwOpen as DWORD) as MMRESULT
declare function acmDriverClose(byval had as HACMDRIVER, byval fdwClose as DWORD) as MMRESULT
declare function acmDriverMessage(byval had as HACMDRIVER, byval uMsg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT

const ACMDM_USER = DRV_USER + &h0000
const ACMDM_RESERVED_LOW = DRV_USER + &h2000
const ACMDM_RESERVED_HIGH = DRV_USER + &h2FFF
const ACMDM_BASE = ACMDM_RESERVED_LOW
const ACMDM_DRIVER_ABOUT = ACMDM_BASE + 11
declare function acmDriverPriority(byval hadid as HACMDRIVERID, byval dwPriority as DWORD, byval fdwPriority as DWORD) as MMRESULT
const ACM_DRIVERPRIORITYF_ENABLE = &h00000001
const ACM_DRIVERPRIORITYF_DISABLE = &h00000002
const ACM_DRIVERPRIORITYF_ABLEMASK = &h00000003
const ACM_DRIVERPRIORITYF_BEGIN = &h00010000
const ACM_DRIVERPRIORITYF_END = &h00020000
const ACM_DRIVERPRIORITYF_DEFERMASK = &h00030000
const ACMDRIVERDETAILS_SHORTNAME_CHARS = 32
const ACMDRIVERDETAILS_LONGNAME_CHARS = 128
const ACMDRIVERDETAILS_COPYRIGHT_CHARS = 80
const ACMDRIVERDETAILS_LICENSING_CHARS = 128
const ACMDRIVERDETAILS_FEATURES_CHARS = 512

type tACMDRIVERDETAILSA field = 1
	cbStruct as DWORD
	fccType as FOURCC
	fccComp as FOURCC
	wMid as WORD
	wPid as WORD
	vdwACM as DWORD
	vdwDriver as DWORD
	fdwSupport as DWORD
	cFormatTags as DWORD
	cFilterTags as DWORD
	hicon as HICON
	szShortName as zstring * 32
	szLongName as zstring * 128
	szCopyright as zstring * 80
	szLicensing as zstring * 128
	szFeatures as zstring * 512
end type

type ACMDRIVERDETAILSA as tACMDRIVERDETAILSA
type PACMDRIVERDETAILSA as tACMDRIVERDETAILSA ptr
type LPACMDRIVERDETAILSA as tACMDRIVERDETAILSA ptr

type tACMDRIVERDETAILSW field = 1
	cbStruct as DWORD
	fccType as FOURCC
	fccComp as FOURCC
	wMid as WORD
	wPid as WORD
	vdwACM as DWORD
	vdwDriver as DWORD
	fdwSupport as DWORD
	cFormatTags as DWORD
	cFilterTags as DWORD
	hicon as HICON
	szShortName as wstring * 32
	szLongName as wstring * 128
	szCopyright as wstring * 80
	szLicensing as wstring * 128
	szFeatures as wstring * 512
end type

type ACMDRIVERDETAILSW as tACMDRIVERDETAILSW
type PACMDRIVERDETAILSW as tACMDRIVERDETAILSW ptr
type LPACMDRIVERDETAILSW as tACMDRIVERDETAILSW ptr

#ifdef UNICODE
	type ACMDRIVERDETAILS as ACMDRIVERDETAILSW
	type PACMDRIVERDETAILS as PACMDRIVERDETAILSW
	type LPACMDRIVERDETAILS as LPACMDRIVERDETAILSW
#else
	type ACMDRIVERDETAILS as ACMDRIVERDETAILSA
	type PACMDRIVERDETAILS as PACMDRIVERDETAILSA
	type LPACMDRIVERDETAILS as LPACMDRIVERDETAILSA
#endif

#define ACMDRIVERDETAILS_FCCTYPE_AUDIOCODEC mmioFOURCC(asc("a"), asc("u"), asc("d"), asc("c"))
#define ACMDRIVERDETAILS_FCCCOMP_UNDEFINED mmioFOURCC(asc(!"\0"), asc(!"\0"), asc(!"\0"), asc(!"\0"))
const ACMDRIVERDETAILS_SUPPORTF_CODEC = &h00000001
const ACMDRIVERDETAILS_SUPPORTF_CONVERTER = &h00000002
const ACMDRIVERDETAILS_SUPPORTF_FILTER = &h00000004
const ACMDRIVERDETAILS_SUPPORTF_HARDWARE = &h00000008
const ACMDRIVERDETAILS_SUPPORTF_ASYNC = &h00000010
const ACMDRIVERDETAILS_SUPPORTF_LOCAL = &h40000000
const ACMDRIVERDETAILS_SUPPORTF_DISABLED = &h80000000
declare function acmDriverDetailsA(byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmDriverDetailsW(byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSW, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmDriverDetails alias "acmDriverDetailsW"(byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSW, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function acmDriverDetails alias "acmDriverDetailsA"(byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSA, byval fdwDetails as DWORD) as MMRESULT
#endif

const ACMFORMATTAGDETAILS_FORMATTAG_CHARS = 48

type tACMFORMATTAGDETAILSA field = 1
	cbStruct as DWORD
	dwFormatTagIndex as DWORD
	dwFormatTag as DWORD
	cbFormatSize as DWORD
	fdwSupport as DWORD
	cStandardFormats as DWORD
	szFormatTag as zstring * 48
end type

type ACMFORMATTAGDETAILSA as tACMFORMATTAGDETAILSA
type PACMFORMATTAGDETAILSA as tACMFORMATTAGDETAILSA ptr
type LPACMFORMATTAGDETAILSA as tACMFORMATTAGDETAILSA ptr

type tACMFORMATTAGDETAILSW field = 1
	cbStruct as DWORD
	dwFormatTagIndex as DWORD
	dwFormatTag as DWORD
	cbFormatSize as DWORD
	fdwSupport as DWORD
	cStandardFormats as DWORD
	szFormatTag as wstring * 48
end type

type ACMFORMATTAGDETAILSW as tACMFORMATTAGDETAILSW
type PACMFORMATTAGDETAILSW as tACMFORMATTAGDETAILSW ptr
type LPACMFORMATTAGDETAILSW as tACMFORMATTAGDETAILSW ptr

#ifdef UNICODE
	type ACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSW
	type PACMFORMATTAGDETAILS as PACMFORMATTAGDETAILSW
	type LPACMFORMATTAGDETAILS as LPACMFORMATTAGDETAILSW
#else
	type ACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSA
	type PACMFORMATTAGDETAILS as PACMFORMATTAGDETAILSA
	type LPACMFORMATTAGDETAILS as LPACMFORMATTAGDETAILSA
#endif

declare function acmFormatTagDetailsA(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmFormatTagDetailsW(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSW, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmFormatTagDetails alias "acmFormatTagDetailsW"(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSW, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function acmFormatTagDetails alias "acmFormatTagDetailsA"(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSA, byval fdwDetails as DWORD) as MMRESULT
#endif

const ACM_FORMATTAGDETAILSF_INDEX = &h00000000
const ACM_FORMATTAGDETAILSF_FORMATTAG = &h00000001
const ACM_FORMATTAGDETAILSF_LARGESTSIZE = &h00000002
const ACM_FORMATTAGDETAILSF_QUERYMASK = &h0000000F
type ACMFORMATTAGENUMCBA as function(byval hadid as HACMDRIVERID, byval paftd as LPACMFORMATTAGDETAILSA, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
type ACMFORMATTAGENUMCBW as function(byval hadid as HACMDRIVERID, byval paftd as LPACMFORMATTAGDETAILSW, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
declare function acmFormatTagEnumA(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSA, byval fnCallback as ACMFORMATTAGENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmFormatTagEnumW(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSW, byval fnCallback as ACMFORMATTAGENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT

#ifdef UNICODE
	type ACMFORMATTAGENUMCB as ACMFORMATTAGENUMCBW
	declare function acmFormatTagEnum alias "acmFormatTagEnumW"(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSW, byval fnCallback as ACMFORMATTAGENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#else
	type ACMFORMATTAGENUMCB as ACMFORMATTAGENUMCBA
	declare function acmFormatTagEnum alias "acmFormatTagEnumA"(byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSA, byval fnCallback as ACMFORMATTAGENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#endif

const ACMFORMATDETAILS_FORMAT_CHARS = 128

type tACMFORMATDETAILSA field = 1
	cbStruct as DWORD
	dwFormatIndex as DWORD
	dwFormatTag as DWORD
	fdwSupport as DWORD
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	szFormat as zstring * 128
end type

type ACMFORMATDETAILSA as tACMFORMATDETAILSA
type PACMFORMATDETAILSA as tACMFORMATDETAILSA ptr
type LPACMFORMATDETAILSA as tACMFORMATDETAILSA ptr

type tACMFORMATDETAILSW field = 1
	cbStruct as DWORD
	dwFormatIndex as DWORD
	dwFormatTag as DWORD
	fdwSupport as DWORD
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	szFormat as wstring * 128
end type

type ACMFORMATDETAILSW as tACMFORMATDETAILSW
type PACMFORMATDETAILSW as tACMFORMATDETAILSW ptr
type LPACMFORMATDETAILSW as tACMFORMATDETAILSW ptr

#ifdef UNICODE
	type ACMFORMATDETAILS as ACMFORMATDETAILSW
	type PACMFORMATDETAILS as PACMFORMATDETAILSW
	type LPACMFORMATDETAILS as LPACMFORMATDETAILSW
#else
	type ACMFORMATDETAILS as ACMFORMATDETAILSA
	type PACMFORMATDETAILS as PACMFORMATDETAILSA
	type LPACMFORMATDETAILS as LPACMFORMATDETAILSA
#endif

declare function acmFormatDetailsA(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmFormatDetailsW(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSW, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmFormatDetails alias "acmFormatDetailsW"(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSW, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function acmFormatDetails alias "acmFormatDetailsA"(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSA, byval fdwDetails as DWORD) as MMRESULT
#endif

const ACM_FORMATDETAILSF_INDEX = &h00000000
const ACM_FORMATDETAILSF_FORMAT = &h00000001
const ACM_FORMATDETAILSF_QUERYMASK = &h0000000F
type ACMFORMATENUMCBA as function(byval hadid as HACMDRIVERID, byval pafd as LPACMFORMATDETAILSA, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
type ACMFORMATENUMCBW as function(byval hadid as HACMDRIVERID, byval pafd as LPACMFORMATDETAILSW, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
declare function acmFormatEnumA(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSA, byval fnCallback as ACMFORMATENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmFormatEnumW(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSW, byval fnCallback as ACMFORMATENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT

#ifdef UNICODE
	type ACMFORMATENUMCB as ACMFORMATENUMCBW
	declare function acmFormatEnum alias "acmFormatEnumW"(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSW, byval fnCallback as ACMFORMATENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#else
	type ACMFORMATENUMCB as ACMFORMATENUMCBA
	declare function acmFormatEnum alias "acmFormatEnumA"(byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSA, byval fnCallback as ACMFORMATENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#endif

const ACM_FORMATENUMF_WFORMATTAG = &h00010000
const ACM_FORMATENUMF_NCHANNELS = &h00020000
const ACM_FORMATENUMF_NSAMPLESPERSEC = &h00040000
const ACM_FORMATENUMF_WBITSPERSAMPLE = &h00080000
const ACM_FORMATENUMF_CONVERT = &h00100000
const ACM_FORMATENUMF_SUGGEST = &h00200000
const ACM_FORMATENUMF_HARDWARE = &h00400000
const ACM_FORMATENUMF_INPUT = &h00800000
const ACM_FORMATENUMF_OUTPUT = &h01000000
declare function acmFormatSuggest(byval had as HACMDRIVER, byval pwfxSrc as LPWAVEFORMATEX, byval pwfxDst as LPWAVEFORMATEX, byval cbwfxDst as DWORD, byval fdwSuggest as DWORD) as MMRESULT
const ACM_FORMATSUGGESTF_WFORMATTAG = &h00010000
const ACM_FORMATSUGGESTF_NCHANNELS = &h00020000
const ACM_FORMATSUGGESTF_NSAMPLESPERSEC = &h00040000
const ACM_FORMATSUGGESTF_WBITSPERSAMPLE = &h00080000
const ACM_FORMATSUGGESTF_TYPEMASK = &h00FF0000
#define ACMHELPMSGSTRINGA "acmchoose_help"
#define ACMHELPMSGSTRINGW wstr("acmchoose_help")
#define ACMHELPMSGCONTEXTMENUA "acmchoose_contextmenu"
#define ACMHELPMSGCONTEXTMENUW wstr("acmchoose_contextmenu")
#define ACMHELPMSGCONTEXTHELPA "acmchoose_contexthelp"
#define ACMHELPMSGCONTEXTHELPW wstr("acmchoose_contexthelp")

#ifdef UNICODE
	#define ACMHELPMSGSTRING ACMHELPMSGSTRINGW
	#define ACMHELPMSGCONTEXTMENU ACMHELPMSGCONTEXTMENUW
	#define ACMHELPMSGCONTEXTHELP ACMHELPMSGCONTEXTHELPW
#else
	#define ACMHELPMSGSTRING ACMHELPMSGSTRINGA
	#define ACMHELPMSGCONTEXTMENU ACMHELPMSGCONTEXTMENUA
	#define ACMHELPMSGCONTEXTHELP ACMHELPMSGCONTEXTHELPA
#endif

const MM_ACM_FORMATCHOOSE = &h8000
const FORMATCHOOSE_MESSAGE = 0
const FORMATCHOOSE_FORMATTAG_VERIFY = FORMATCHOOSE_MESSAGE + 0
const FORMATCHOOSE_FORMAT_VERIFY = FORMATCHOOSE_MESSAGE + 1
const FORMATCHOOSE_CUSTOM_VERIFY = FORMATCHOOSE_MESSAGE + 2
type ACMFORMATCHOOSEHOOKPROCA as function(byval hwnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as UINT
type ACMFORMATCHOOSEHOOKPROCW as function(byval hwnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as UINT

#ifdef UNICODE
	type ACMFORMATCHOOSEHOOKPROC as ACMFORMATCHOOSEHOOKPROCW
#else
	type ACMFORMATCHOOSEHOOKPROC as ACMFORMATCHOOSEHOOKPROCA
#endif

type tACMFORMATCHOOSEA field = 1
	cbStruct as DWORD
	fdwStyle as DWORD
	hwndOwner as HWND
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	pszTitle as LPCSTR
	szFormatTag as zstring * 48
	szFormat as zstring * 128
	pszName as LPSTR
	cchName as DWORD
	fdwEnum as DWORD
	pwfxEnum as LPWAVEFORMATEX
	hInstance as HINSTANCE
	pszTemplateName as LPCSTR
	lCustData as LPARAM
	pfnHook as ACMFORMATCHOOSEHOOKPROCA
end type

type ACMFORMATCHOOSEA as tACMFORMATCHOOSEA
type PACMFORMATCHOOSEA as tACMFORMATCHOOSEA ptr
type LPACMFORMATCHOOSEA as tACMFORMATCHOOSEA ptr

type tACMFORMATCHOOSEW field = 1
	cbStruct as DWORD
	fdwStyle as DWORD
	hwndOwner as HWND
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	pszTitle as LPCWSTR
	szFormatTag as wstring * 48
	szFormat as wstring * 128
	pszName as LPWSTR
	cchName as DWORD
	fdwEnum as DWORD
	pwfxEnum as LPWAVEFORMATEX
	hInstance as HINSTANCE
	pszTemplateName as LPCWSTR
	lCustData as LPARAM
	pfnHook as ACMFORMATCHOOSEHOOKPROCW
end type

type ACMFORMATCHOOSEW as tACMFORMATCHOOSEW
type PACMFORMATCHOOSEW as tACMFORMATCHOOSEW ptr
type LPACMFORMATCHOOSEW as tACMFORMATCHOOSEW ptr

#ifdef UNICODE
	type ACMFORMATCHOOSE as ACMFORMATCHOOSEW
	type PACMFORMATCHOOSE as PACMFORMATCHOOSEW
	type LPACMFORMATCHOOSE as LPACMFORMATCHOOSEW
#else
	type ACMFORMATCHOOSE as ACMFORMATCHOOSEA
	type PACMFORMATCHOOSE as PACMFORMATCHOOSEA
	type LPACMFORMATCHOOSE as LPACMFORMATCHOOSEA
#endif

const ACMFORMATCHOOSE_STYLEF_SHOWHELP = &h00000004
const ACMFORMATCHOOSE_STYLEF_ENABLEHOOK = &h00000008
const ACMFORMATCHOOSE_STYLEF_ENABLETEMPLATE = &h00000010
const ACMFORMATCHOOSE_STYLEF_ENABLETEMPLATEHANDLE = &h00000020
const ACMFORMATCHOOSE_STYLEF_INITTOWFXSTRUCT = &h00000040
const ACMFORMATCHOOSE_STYLEF_CONTEXTHELP = &h00000080
declare function acmFormatChooseA(byval pafmtc as LPACMFORMATCHOOSEA) as MMRESULT
declare function acmFormatChooseW(byval pafmtc as LPACMFORMATCHOOSEW) as MMRESULT

#ifdef UNICODE
	declare function acmFormatChoose alias "acmFormatChooseW"(byval pafmtc as LPACMFORMATCHOOSEW) as MMRESULT
#else
	declare function acmFormatChoose alias "acmFormatChooseA"(byval pafmtc as LPACMFORMATCHOOSEA) as MMRESULT
#endif

const ACMFILTERTAGDETAILS_FILTERTAG_CHARS = 48

type tACMFILTERTAGDETAILSA field = 1
	cbStruct as DWORD
	dwFilterTagIndex as DWORD
	dwFilterTag as DWORD
	cbFilterSize as DWORD
	fdwSupport as DWORD
	cStandardFilters as DWORD
	szFilterTag as zstring * 48
end type

type ACMFILTERTAGDETAILSA as tACMFILTERTAGDETAILSA
type PACMFILTERTAGDETAILSA as tACMFILTERTAGDETAILSA ptr
type LPACMFILTERTAGDETAILSA as tACMFILTERTAGDETAILSA ptr

type tACMFILTERTAGDETAILSW field = 1
	cbStruct as DWORD
	dwFilterTagIndex as DWORD
	dwFilterTag as DWORD
	cbFilterSize as DWORD
	fdwSupport as DWORD
	cStandardFilters as DWORD
	szFilterTag as wstring * 48
end type

type ACMFILTERTAGDETAILSW as tACMFILTERTAGDETAILSW
type PACMFILTERTAGDETAILSW as tACMFILTERTAGDETAILSW ptr
type LPACMFILTERTAGDETAILSW as tACMFILTERTAGDETAILSW ptr

#ifdef UNICODE
	type ACMFILTERTAGDETAILS as ACMFILTERTAGDETAILSW
	type PACMFILTERTAGDETAILS as PACMFILTERTAGDETAILSW
	type LPACMFILTERTAGDETAILS as LPACMFILTERTAGDETAILSW
#else
	type ACMFILTERTAGDETAILS as ACMFILTERTAGDETAILSA
	type PACMFILTERTAGDETAILS as PACMFILTERTAGDETAILSA
	type LPACMFILTERTAGDETAILS as LPACMFILTERTAGDETAILSA
#endif

declare function acmFilterTagDetailsA(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmFilterTagDetailsW(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSW, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmFilterTagDetails alias "acmFilterTagDetailsW"(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSW, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function acmFilterTagDetails alias "acmFilterTagDetailsA"(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSA, byval fdwDetails as DWORD) as MMRESULT
#endif

const ACM_FILTERTAGDETAILSF_INDEX = &h00000000
const ACM_FILTERTAGDETAILSF_FILTERTAG = &h00000001
const ACM_FILTERTAGDETAILSF_LARGESTSIZE = &h00000002
const ACM_FILTERTAGDETAILSF_QUERYMASK = &h0000000F
type ACMFILTERTAGENUMCBA as function(byval hadid as HACMDRIVERID, byval paftd as LPACMFILTERTAGDETAILSA, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
type ACMFILTERTAGENUMCBW as function(byval hadid as HACMDRIVERID, byval paftd as LPACMFILTERTAGDETAILSW, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
declare function acmFilterTagEnumA(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSA, byval fnCallback as ACMFILTERTAGENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmFilterTagEnumW(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSW, byval fnCallback as ACMFILTERTAGENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT

#ifdef UNICODE
	type ACMFILTERTAGENUMCB as ACMFILTERTAGENUMCBW
	declare function acmFilterTagEnum alias "acmFilterTagEnumW"(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSW, byval fnCallback as ACMFILTERTAGENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#else
	type ACMFILTERTAGENUMCB as ACMFILTERTAGENUMCBA
	declare function acmFilterTagEnum alias "acmFilterTagEnumA"(byval had as HACMDRIVER, byval paftd as LPACMFILTERTAGDETAILSA, byval fnCallback as ACMFILTERTAGENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#endif

const ACMFILTERDETAILS_FILTER_CHARS = 128

type tACMFILTERDETAILSA field = 1
	cbStruct as DWORD
	dwFilterIndex as DWORD
	dwFilterTag as DWORD
	fdwSupport as DWORD
	pwfltr as LPWAVEFILTER
	cbwfltr as DWORD
	szFilter as zstring * 128
end type

type ACMFILTERDETAILSA as tACMFILTERDETAILSA
type PACMFILTERDETAILSA as tACMFILTERDETAILSA ptr
type LPACMFILTERDETAILSA as tACMFILTERDETAILSA ptr

type tACMFILTERDETAILSW field = 1
	cbStruct as DWORD
	dwFilterIndex as DWORD
	dwFilterTag as DWORD
	fdwSupport as DWORD
	pwfltr as LPWAVEFILTER
	cbwfltr as DWORD
	szFilter as wstring * 128
end type

type ACMFILTERDETAILSW as tACMFILTERDETAILSW
type PACMFILTERDETAILSW as tACMFILTERDETAILSW ptr
type LPACMFILTERDETAILSW as tACMFILTERDETAILSW ptr

#ifdef UNICODE
	type ACMFILTERDETAILS as ACMFILTERDETAILSW
	type PACMFILTERDETAILS as PACMFILTERDETAILSW
	type LPACMFILTERDETAILS as LPACMFILTERDETAILSW
#else
	type ACMFILTERDETAILS as ACMFILTERDETAILSA
	type PACMFILTERDETAILS as PACMFILTERDETAILSA
	type LPACMFILTERDETAILS as LPACMFILTERDETAILSA
#endif

declare function acmFilterDetailsA(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmFilterDetailsW(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSW, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function acmFilterDetails alias "acmFilterDetailsW"(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSW, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function acmFilterDetails alias "acmFilterDetailsA"(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSA, byval fdwDetails as DWORD) as MMRESULT
#endif

const ACM_FILTERDETAILSF_INDEX = &h00000000
const ACM_FILTERDETAILSF_FILTER = &h00000001
const ACM_FILTERDETAILSF_QUERYMASK = &h0000000F
type ACMFILTERENUMCBA as function(byval hadid as HACMDRIVERID, byval pafd as LPACMFILTERDETAILSA, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
type ACMFILTERENUMCBW as function(byval hadid as HACMDRIVERID, byval pafd as LPACMFILTERDETAILSW, byval dwInstance as DWORD_PTR, byval fdwSupport as DWORD) as WINBOOL
declare function acmFilterEnumA(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSA, byval fnCallback as ACMFILTERENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmFilterEnumW(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSW, byval fnCallback as ACMFILTERENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT

#ifdef UNICODE
	type ACMFILTERENUMCB as ACMFILTERENUMCBW
	declare function acmFilterEnum alias "acmFilterEnumW"(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSW, byval fnCallback as ACMFILTERENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#else
	type ACMFILTERENUMCB as ACMFILTERENUMCBA
	declare function acmFilterEnum alias "acmFilterEnumA"(byval had as HACMDRIVER, byval pafd as LPACMFILTERDETAILSA, byval fnCallback as ACMFILTERENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#endif

const ACM_FILTERENUMF_DWFILTERTAG = &h00010000
const MM_ACM_FILTERCHOOSE = &h8000
const FILTERCHOOSE_MESSAGE = 0
const FILTERCHOOSE_FILTERTAG_VERIFY = FILTERCHOOSE_MESSAGE + 0
const FILTERCHOOSE_FILTER_VERIFY = FILTERCHOOSE_MESSAGE + 1
const FILTERCHOOSE_CUSTOM_VERIFY = FILTERCHOOSE_MESSAGE + 2
type ACMFILTERCHOOSEHOOKPROCA as function(byval hwnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as UINT
type ACMFILTERCHOOSEHOOKPROCW as function(byval hwnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as UINT

#ifdef UNICODE
	type ACMFILTERCHOOSEHOOKPROC as ACMFILTERCHOOSEHOOKPROCW
#else
	type ACMFILTERCHOOSEHOOKPROC as ACMFILTERCHOOSEHOOKPROCA
#endif

type tACMFILTERCHOOSEA field = 1
	cbStruct as DWORD
	fdwStyle as DWORD
	hwndOwner as HWND
	pwfltr as LPWAVEFILTER
	cbwfltr as DWORD
	pszTitle as LPCSTR
	szFilterTag as zstring * 48
	szFilter as zstring * 128
	pszName as LPSTR
	cchName as DWORD
	fdwEnum as DWORD
	pwfltrEnum as LPWAVEFILTER
	hInstance as HINSTANCE
	pszTemplateName as LPCSTR
	lCustData as LPARAM
	pfnHook as ACMFILTERCHOOSEHOOKPROCA
end type

type ACMFILTERCHOOSEA as tACMFILTERCHOOSEA
type PACMFILTERCHOOSEA as tACMFILTERCHOOSEA ptr
type LPACMFILTERCHOOSEA as tACMFILTERCHOOSEA ptr

type tACMFILTERCHOOSEW field = 1
	cbStruct as DWORD
	fdwStyle as DWORD
	hwndOwner as HWND
	pwfltr as LPWAVEFILTER
	cbwfltr as DWORD
	pszTitle as LPCWSTR
	szFilterTag as wstring * 48
	szFilter as wstring * 128
	pszName as LPWSTR
	cchName as DWORD
	fdwEnum as DWORD
	pwfltrEnum as LPWAVEFILTER
	hInstance as HINSTANCE
	pszTemplateName as LPCWSTR
	lCustData as LPARAM
	pfnHook as ACMFILTERCHOOSEHOOKPROCW
end type

type ACMFILTERCHOOSEW as tACMFILTERCHOOSEW
type PACMFILTERCHOOSEW as tACMFILTERCHOOSEW ptr
type LPACMFILTERCHOOSEW as tACMFILTERCHOOSEW ptr

#ifdef UNICODE
	type ACMFILTERCHOOSE as ACMFILTERCHOOSEW
	type PACMFILTERCHOOSE as PACMFILTERCHOOSEW
	type LPACMFILTERCHOOSE as LPACMFILTERCHOOSEW
#else
	type ACMFILTERCHOOSE as ACMFILTERCHOOSEA
	type PACMFILTERCHOOSE as PACMFILTERCHOOSEA
	type LPACMFILTERCHOOSE as LPACMFILTERCHOOSEA
#endif

const ACMFILTERCHOOSE_STYLEF_SHOWHELP = &h00000004
const ACMFILTERCHOOSE_STYLEF_ENABLEHOOK = &h00000008
const ACMFILTERCHOOSE_STYLEF_ENABLETEMPLATE = &h00000010
const ACMFILTERCHOOSE_STYLEF_ENABLETEMPLATEHANDLE = &h00000020
const ACMFILTERCHOOSE_STYLEF_INITTOFILTERSTRUCT = &h00000040
const ACMFILTERCHOOSE_STYLEF_CONTEXTHELP = &h00000080
declare function acmFilterChooseA(byval pafltrc as LPACMFILTERCHOOSEA) as MMRESULT
declare function acmFilterChooseW(byval pafltrc as LPACMFILTERCHOOSEW) as MMRESULT

#ifdef UNICODE
	declare function acmFilterChoose alias "acmFilterChooseW"(byval pafltrc as LPACMFILTERCHOOSEW) as MMRESULT
#else
	declare function acmFilterChoose alias "acmFilterChooseA"(byval pafltrc as LPACMFILTERCHOOSEA) as MMRESULT
#endif

#ifdef __FB_64BIT__
	const _DRVRESERVED = 15
#else
	const _DRVRESERVED = 10
#endif

type tACMSTREAMHEADER field = 1
	cbStruct as DWORD
	fdwStatus as DWORD
	dwUser as DWORD_PTR
	pbSrc as LPBYTE
	cbSrcLength as DWORD
	cbSrcLengthUsed as DWORD
	dwSrcUser as DWORD_PTR
	pbDst as LPBYTE
	cbDstLength as DWORD
	cbDstLengthUsed as DWORD
	dwDstUser as DWORD_PTR

	#ifdef __FB_64BIT__
		dwReservedDriver(0 to 14) as DWORD
	#else
		dwReservedDriver(0 to 9) as DWORD
	#endif
end type

type ACMSTREAMHEADER as tACMSTREAMHEADER
type PACMSTREAMHEADER as tACMSTREAMHEADER ptr
type LPACMSTREAMHEADER as tACMSTREAMHEADER ptr

const ACMSTREAMHEADER_STATUSF_DONE = &h00010000
const ACMSTREAMHEADER_STATUSF_PREPARED = &h00020000
const ACMSTREAMHEADER_STATUSF_INQUEUE = &h00100000
declare function acmStreamOpen(byval phas as LPHACMSTREAM, byval had as HACMDRIVER, byval pwfxSrc as LPWAVEFORMATEX, byval pwfxDst as LPWAVEFORMATEX, byval pwfltr as LPWAVEFILTER, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
const ACM_STREAMOPENF_QUERY = &h00000001
const ACM_STREAMOPENF_ASYNC = &h00000002
const ACM_STREAMOPENF_NONREALTIME = &h00000004
declare function acmStreamClose(byval has as HACMSTREAM, byval fdwClose as DWORD) as MMRESULT
declare function acmStreamSize(byval has as HACMSTREAM, byval cbInput as DWORD, byval pdwOutputBytes as LPDWORD, byval fdwSize as DWORD) as MMRESULT
const ACM_STREAMSIZEF_SOURCE = &h00000000
const ACM_STREAMSIZEF_DESTINATION = &h00000001
const ACM_STREAMSIZEF_QUERYMASK = &h0000000F

declare function acmStreamReset(byval has as HACMSTREAM, byval fdwReset as DWORD) as MMRESULT
declare function acmStreamMessage(byval has as HACMSTREAM, byval uMsg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as MMRESULT
declare function acmStreamConvert(byval has as HACMSTREAM, byval pash as LPACMSTREAMHEADER, byval fdwConvert as DWORD) as MMRESULT

const ACM_STREAMCONVERTF_BLOCKALIGN = &h00000004
const ACM_STREAMCONVERTF_START = &h00000010
const ACM_STREAMCONVERTF_END = &h00000020
declare function acmStreamPrepareHeader(byval has as HACMSTREAM, byval pash as LPACMSTREAMHEADER, byval fdwPrepare as DWORD) as MMRESULT
declare function acmStreamUnprepareHeader(byval has as HACMSTREAM, byval pash as LPACMSTREAMHEADER, byval fdwUnprepare as DWORD) as MMRESULT

end extern
