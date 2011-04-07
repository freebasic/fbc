''
''
'' msacm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_msacm_bi__
#define __win_msacm_bi__

#inclib "msacm32"

#include once "win/mmsystem.bi"

type HACMDRIVERID as HANDLE
type HACMDRIVER as HANDLE
type LPHACMDRIVER as HANDLE ptr

#define ACMDRIVERDETAILS_SHORTNAME_CHARS 32
#define ACMDRIVERDETAILS_LONGNAME_CHARS 128
#define ACMDRIVERDETAILS_COPYRIGHT_CHARS 80
#define ACMDRIVERDETAILS_LICENSING_CHARS 128
#define ACMFORMATDETAILS_FORMAT_CHARS 256
#define ACMFORMATTAGDETAILS_FORMATTAG_CHARS 256
#define ACMDRIVERDETAILS_FEATURES_CHARS 256

#ifndef UNICODE
type ACMFORMATDETAILSA
	cbStruct as DWORD
	dwFormatIndex as DWORD
	dwFormatTag as DWORD
	fdwSupport as DWORD
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	szFormat as zstring * 256
end type

type LPACMFORMATDETAILSA as ACMFORMATDETAILSA ptr

#else
type ACMFORMATDETAILSW
	cbStruct as DWORD
	dwFormatIndex as DWORD
	dwFormatTag as DWORD
	fdwSupport as DWORD
	pwfx as LPWAVEFORMATEX
	cbwfx as DWORD
	szFormat as wstring * 256
end type

type LPACMFORMATDETAILSW as ACMFORMATDETAILSW ptr
#endif

#ifndef UNICODE
type ACMFORMATTAGDETAILSA
	cbStruct as DWORD
	dwFormatTagIndex as DWORD
	dwFormatTag as DWORD
	cbFormatSize as DWORD
	fdwSupport as DWORD
	cStandardFormats as DWORD
	szFormatTag as zstring * 256
end type

type LPACMFORMATTAGDETAILSA as ACMFORMATTAGDETAILSA ptr

#else
type ACMFORMATTAGDETAILSW
	cbStruct as DWORD
	dwFormatTagIndex as DWORD
	dwFormatTag as DWORD
	cbFormatSize as DWORD
	fdwSupport as DWORD
	cStandardFormats as DWORD
	szFormatTag as wstring * 256
end type

type LPACMFORMATTAGDETAILSW as ACMFORMATTAGDETAILSW ptr
#endif

#ifndef UNICODE
type ACMDRIVERDETAILSA
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
	szFeatures as zstring * 256
end type

type LPACMDRIVERDETAILSA as ACMDRIVERDETAILSA ptr
type ACMFORMATENUMCBA as function(byval as HACMDRIVERID, byval as LPACMFORMATDETAILSA, byval as DWORD_PTR, byval as DWORD) as BOOL
type ACMFORMATTAGENUMCBA as function(byval as HACMDRIVERID, byval as LPACMFORMATTAGDETAILSA, byval as DWORD_PTR, byval as DWORD) as BOOL

#else
type ACMDRIVERDETAILSW
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
	szFeatures as wstring * 256
end type

type LPACMDRIVERDETAILSW as ACMDRIVERDETAILSW ptr
type ACMFORMATENUMCBW as function(byval as HACMDRIVERID, byval as LPACMFORMATDETAILSW, byval as DWORD_PTR, byval as DWORD) as BOOL
type ACMFORMATTAGENUMCBW as function(byval as HACMDRIVERID, byval as LPACMFORMATTAGDETAILSW, byval as DWORD_PTR, byval as DWORD) as BOOL
#endif

type ACMDRIVERENUMCB as function(byval as HACMDRIVERID, byval as DWORD_PTR, byval as DWORD) as BOOL

declare function acmDriverOpen alias "acmDriverOpen" (byval phad as LPHACMDRIVER, byval hadid as HACMDRIVERID, byval fdwOpen as DWORD) as MMRESULT
declare function acmDriverEnum alias "acmDriverEnum" (byval fnCallback as ACMDRIVERENUMCB, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmDriverClose alias "acmDriverClose" (byval had as HACMDRIVER, byval fdwClose as DWORD) as MMRESULT

#ifdef UNICODE
type ACMFORMATDETAILS as ACMFORMATDETAILSW
type LPACMFORMATDETAILS as ACMFORMATDETAILSW ptr
type ACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSw
type LPACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSW ptr
type ACMDRIVERDETAILS as ACMDRIVERDETAILSW
type LPACMDRIVERDETAILS as ACMDRIVERDETAILSW ptr
type ACMFORMATENUMCB as ACMFORMATENUMCBW
type ACMFORMATTAGENUMCB as ACMFORMATTAGENUMCBW

declare function acmFormatEnum alias "acmFormatEnumW" (byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSW, byval fnCallback as ACMFORMATENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmDriverDetails alias "acmDriverDetailsW" (byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSW, byval fdwDetails as DWORD) as MMRESULT
declare function acmFormatTagEnum alias "acmFormatTagEnumW" (byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSW, byval fnCallback as ACMFORMATTAGENUMCBW, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT

#else
type ACMFORMATDETAILS as ACMFORMATDETAILSA
type LPACMFORMATDETAILS as ACMFORMATDETAILSA ptr
type ACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSA
type LPACMFORMATTAGDETAILS as ACMFORMATTAGDETAILSA ptr
type ACMDRIVERDETAILS as ACMDRIVERDETAILSA
type LPACMDRIVERDETAILS as ACMDRIVERDETAILSA ptr
type ACMFORMATENUMCB as ACMFORMATENUMCBA
type ACMFORMATTAGENUMCB as ACMFORMATTAGENUMCBA

declare function acmFormatEnum alias "acmFormatEnumA" (byval had as HACMDRIVER, byval pafd as LPACMFORMATDETAILSA, byval fnCallback as ACMFORMATENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
declare function acmDriverDetails alias "acmDriverDetailsA" (byval hadid as HACMDRIVERID, byval padd as LPACMDRIVERDETAILSA, byval fdwDetails as DWORD) as MMRESULT
declare function acmFormatTagEnum alias "acmFormatTagEnumA" (byval had as HACMDRIVER, byval paftd as LPACMFORMATTAGDETAILSA, byval fnCallback as ACMFORMATTAGENUMCBA, byval dwInstance as DWORD_PTR, byval fdwEnum as DWORD) as MMRESULT
#endif


#endif
