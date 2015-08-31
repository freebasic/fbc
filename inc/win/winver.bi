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

#inclib "version"

#include once "_mingw.bi"
#include once "_mingw_unicode.bi"

extern "Windows"

#define VER_H
#define VS_FILE_INFO RT_VERSION
const VS_VERSION_INFO = 1
const VS_USER_DEFINED = 100
const VS_FFI_SIGNATURE = &hFEEF04BD
const VS_FFI_STRUCVERSION = &h00010000
const VS_FFI_FILEFLAGSMASK = &h0000003F
const VS_FF_DEBUG = &h00000001
const VS_FF_PRERELEASE = &h00000002
const VS_FF_PATCHED = &h00000004
const VS_FF_PRIVATEBUILD = &h00000008
const VS_FF_INFOINFERRED = &h00000010
const VS_FF_SPECIALBUILD = &h00000020
const VOS_UNKNOWN = &h00000000
const VOS_DOS = &h00010000
const VOS_OS216 = &h00020000
const VOS_OS232 = &h00030000
const VOS_NT = &h00040000
const VOS_WINCE = &h00050000
const VOS__BASE = &h00000000
const VOS__WINDOWS16 = &h00000001
const VOS__PM16 = &h00000002
const VOS__PM32 = &h00000003
const VOS__WINDOWS32 = &h00000004
const VOS_DOS_WINDOWS16 = &h00010001
const VOS_DOS_WINDOWS32 = &h00010004
const VOS_OS216_PM16 = &h00020002
const VOS_OS232_PM32 = &h00030003
const VOS_NT_WINDOWS32 = &h00040004
const VFT_UNKNOWN = &h00000000
const VFT_APP = &h00000001
const VFT_DLL = &h00000002
const VFT_DRV = &h00000003
const VFT_FONT = &h00000004
const VFT_VXD = &h00000005
const VFT_STATIC_LIB = &h00000007
const VFT2_UNKNOWN = &h00000000
const VFT2_DRV_PRINTER = &h00000001
const VFT2_DRV_KEYBOARD = &h00000002
const VFT2_DRV_LANGUAGE = &h00000003
const VFT2_DRV_DISPLAY = &h00000004
const VFT2_DRV_MOUSE = &h00000005
const VFT2_DRV_NETWORK = &h00000006
const VFT2_DRV_SYSTEM = &h00000007
const VFT2_DRV_INSTALLABLE = &h00000008
const VFT2_DRV_SOUND = &h00000009
const VFT2_DRV_COMM = &h0000000A
const VFT2_DRV_INPUTMETHOD = &h0000000B
const VFT2_DRV_VERSIONED_PRINTER = &h0000000C
const VFT2_FONT_RASTER = &h00000001
const VFT2_FONT_VECTOR = &h00000002
const VFT2_FONT_TRUETYPE = &h00000003
const VFFF_ISSHAREDFILE = &h0001
const VFF_CURNEDEST = &h0001
const VFF_FILEINUSE = &h0002
const VFF_BUFFTOOSMALL = &h0004
const VIFF_FORCEINSTALL = &h0001
const VIFF_DONTDELETEOLD = &h0002
const VIF_TEMPFILE = &h00000001
const VIF_MISMATCH = &h00000002
const VIF_SRCOLD = &h00000004
const VIF_DIFFLANG = &h00000008
const VIF_DIFFCODEPG = &h00000010
const VIF_DIFFTYPE = &h00000020
const VIF_WRITEPROT = &h00000040
const VIF_FILEINUSE = &h00000080
const VIF_OUTOFSPACE = &h00000100
const VIF_ACCESSVIOLATION = &h00000200
const VIF_SHARINGVIOLATION = &h00000400
const VIF_CANNOTCREATE = &h00000800
const VIF_CANNOTDELETE = &h00001000
const VIF_CANNOTRENAME = &h00002000
const VIF_CANNOTDELETECUR = &h00004000
const VIF_OUTOFMEMORY = &h00008000
const VIF_CANNOTREADSRC = &h00010000
const VIF_CANNOTREADDST = &h00020000
const VIF_BUFFTOOSMALL = &h00040000
const VIF_CANNOTLOADLZ32 = &h00080000
const VIF_CANNOTLOADCABINET = &h00100000

type tagVS_FIXEDFILEINFO
	dwSignature as DWORD
	dwStrucVersion as DWORD
	dwFileVersionMS as DWORD
	dwFileVersionLS as DWORD
	dwProductVersionMS as DWORD
	dwProductVersionLS as DWORD
	dwFileFlagsMask as DWORD
	dwFileFlags as DWORD
	dwFileOS as DWORD
	dwFileType as DWORD
	dwFileSubtype as DWORD
	dwFileDateMS as DWORD
	dwFileDateLS as DWORD
end type

type VS_FIXEDFILEINFO as tagVS_FIXEDFILEINFO
declare function VerFindFileA(byval uFlags as DWORD, byval szFileName as LPSTR, byval szWinDir as LPSTR, byval szAppDir as LPSTR, byval szCurDir as LPSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPSTR, byval lpuDestDirLen as PUINT) as DWORD

#ifndef UNICODE
	declare function VerFindFile alias "VerFindFileA"(byval uFlags as DWORD, byval szFileName as LPSTR, byval szWinDir as LPSTR, byval szAppDir as LPSTR, byval szCurDir as LPSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPSTR, byval lpuDestDirLen as PUINT) as DWORD
#endif

declare function VerFindFileW(byval uFlags as DWORD, byval szFileName as LPWSTR, byval szWinDir as LPWSTR, byval szAppDir as LPWSTR, byval szCurDir as LPWSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPWSTR, byval lpuDestDirLen as PUINT) as DWORD

#ifdef UNICODE
	declare function VerFindFile alias "VerFindFileW"(byval uFlags as DWORD, byval szFileName as LPWSTR, byval szWinDir as LPWSTR, byval szAppDir as LPWSTR, byval szCurDir as LPWSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPWSTR, byval lpuDestDirLen as PUINT) as DWORD
#endif

declare function VerInstallFileA(byval uFlags as DWORD, byval szSrcFileName as LPSTR, byval szDestFileName as LPSTR, byval szSrcDir as LPSTR, byval szDestDir as LPSTR, byval szCurDir as LPSTR, byval szTmpFile as LPSTR, byval lpuTmpFileLen as PUINT) as DWORD

#ifndef UNICODE
	declare function VerInstallFile alias "VerInstallFileA"(byval uFlags as DWORD, byval szSrcFileName as LPSTR, byval szDestFileName as LPSTR, byval szSrcDir as LPSTR, byval szDestDir as LPSTR, byval szCurDir as LPSTR, byval szTmpFile as LPSTR, byval lpuTmpFileLen as PUINT) as DWORD
#endif

declare function VerInstallFileW(byval uFlags as DWORD, byval szSrcFileName as LPWSTR, byval szDestFileName as LPWSTR, byval szSrcDir as LPWSTR, byval szDestDir as LPWSTR, byval szCurDir as LPWSTR, byval szTmpFile as LPWSTR, byval lpuTmpFileLen as PUINT) as DWORD

#ifdef UNICODE
	declare function VerInstallFile alias "VerInstallFileW"(byval uFlags as DWORD, byval szSrcFileName as LPWSTR, byval szDestFileName as LPWSTR, byval szSrcDir as LPWSTR, byval szDestDir as LPWSTR, byval szCurDir as LPWSTR, byval szTmpFile as LPWSTR, byval lpuTmpFileLen as PUINT) as DWORD
#endif

declare function GetFileVersionInfoSizeA(byval lptstrFilename as LPCSTR, byval lpdwHandle as LPDWORD) as DWORD

#ifndef UNICODE
	declare function GetFileVersionInfoSize alias "GetFileVersionInfoSizeA"(byval lptstrFilename as LPCSTR, byval lpdwHandle as LPDWORD) as DWORD
#endif

declare function GetFileVersionInfoSizeW(byval lptstrFilename as LPCWSTR, byval lpdwHandle as LPDWORD) as DWORD

#ifdef UNICODE
	declare function GetFileVersionInfoSize alias "GetFileVersionInfoSizeW"(byval lptstrFilename as LPCWSTR, byval lpdwHandle as LPDWORD) as DWORD
#endif

declare function GetFileVersionInfoA(byval lptstrFilename as LPCSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function GetFileVersionInfo alias "GetFileVersionInfoA"(byval lptstrFilename as LPCSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL
#endif

declare function GetFileVersionInfoW(byval lptstrFilename as LPCWSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function GetFileVersionInfo alias "GetFileVersionInfoW"(byval lptstrFilename as LPCWSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL
#endif

declare function VerLanguageNameA(byval wLang as DWORD, byval szLang as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function VerLanguageName alias "VerLanguageNameA"(byval wLang as DWORD, byval szLang as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function VerLanguageNameW(byval wLang as DWORD, byval szLang as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function VerLanguageName alias "VerLanguageNameW"(byval wLang as DWORD, byval szLang as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function VerQueryValueA(byval pBlock as const LPVOID, byval lpSubBlock as LPCSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL

#ifndef UNICODE
	declare function VerQueryValue alias "VerQueryValueA"(byval pBlock as const LPVOID, byval lpSubBlock as LPCSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL
#endif

declare function VerQueryValueW(byval pBlock as const LPVOID, byval lpSubBlock as LPCWSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL

#ifdef UNICODE
	declare function VerQueryValue alias "VerQueryValueW"(byval pBlock as const LPVOID, byval lpSubBlock as LPCWSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL
#endif

end extern
