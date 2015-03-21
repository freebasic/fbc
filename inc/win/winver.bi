#pragma once

#include once "_mingw.bi"
#include once "_mingw_unicode.bi"

#inclib "version"

extern "Windows"

#define VER_H
#define VS_FILE_INFO RT_VERSION
#define VS_VERSION_INFO 1
#define VS_USER_DEFINED 100
#define VS_FFI_SIGNATURE __MSABI_LONG(&hFEEF04BD)
#define VS_FFI_STRUCVERSION __MSABI_LONG(&h00010000)
#define VS_FFI_FILEFLAGSMASK __MSABI_LONG(&h0000003F)
#define VS_FF_DEBUG __MSABI_LONG(&h00000001)
#define VS_FF_PRERELEASE __MSABI_LONG(&h00000002)
#define VS_FF_PATCHED __MSABI_LONG(&h00000004)
#define VS_FF_PRIVATEBUILD __MSABI_LONG(&h00000008)
#define VS_FF_INFOINFERRED __MSABI_LONG(&h00000010)
#define VS_FF_SPECIALBUILD __MSABI_LONG(&h00000020)
#define VOS_UNKNOWN __MSABI_LONG(&h00000000)
#define VOS_DOS __MSABI_LONG(&h00010000)
#define VOS_OS216 __MSABI_LONG(&h00020000)
#define VOS_OS232 __MSABI_LONG(&h00030000)
#define VOS_NT __MSABI_LONG(&h00040000)
#define VOS_WINCE __MSABI_LONG(&h00050000)
#define VOS__BASE __MSABI_LONG(&h00000000)
#define VOS__WINDOWS16 __MSABI_LONG(&h00000001)
#define VOS__PM16 __MSABI_LONG(&h00000002)
#define VOS__PM32 __MSABI_LONG(&h00000003)
#define VOS__WINDOWS32 __MSABI_LONG(&h00000004)
#define VOS_DOS_WINDOWS16 __MSABI_LONG(&h00010001)
#define VOS_DOS_WINDOWS32 __MSABI_LONG(&h00010004)
#define VOS_OS216_PM16 __MSABI_LONG(&h00020002)
#define VOS_OS232_PM32 __MSABI_LONG(&h00030003)
#define VOS_NT_WINDOWS32 __MSABI_LONG(&h00040004)
#define VFT_UNKNOWN __MSABI_LONG(&h00000000)
#define VFT_APP __MSABI_LONG(&h00000001)
#define VFT_DLL __MSABI_LONG(&h00000002)
#define VFT_DRV __MSABI_LONG(&h00000003)
#define VFT_FONT __MSABI_LONG(&h00000004)
#define VFT_VXD __MSABI_LONG(&h00000005)
#define VFT_STATIC_LIB __MSABI_LONG(&h00000007)
#define VFT2_UNKNOWN __MSABI_LONG(&h00000000)
#define VFT2_DRV_PRINTER __MSABI_LONG(&h00000001)
#define VFT2_DRV_KEYBOARD __MSABI_LONG(&h00000002)
#define VFT2_DRV_LANGUAGE __MSABI_LONG(&h00000003)
#define VFT2_DRV_DISPLAY __MSABI_LONG(&h00000004)
#define VFT2_DRV_MOUSE __MSABI_LONG(&h00000005)
#define VFT2_DRV_NETWORK __MSABI_LONG(&h00000006)
#define VFT2_DRV_SYSTEM __MSABI_LONG(&h00000007)
#define VFT2_DRV_INSTALLABLE __MSABI_LONG(&h00000008)
#define VFT2_DRV_SOUND __MSABI_LONG(&h00000009)
#define VFT2_DRV_COMM __MSABI_LONG(&h0000000A)
#define VFT2_DRV_INPUTMETHOD __MSABI_LONG(&h0000000B)
#define VFT2_DRV_VERSIONED_PRINTER __MSABI_LONG(&h0000000C)
#define VFT2_FONT_RASTER __MSABI_LONG(&h00000001)
#define VFT2_FONT_VECTOR __MSABI_LONG(&h00000002)
#define VFT2_FONT_TRUETYPE __MSABI_LONG(&h00000003)
#define VFFF_ISSHAREDFILE &h0001
#define VFF_CURNEDEST &h0001
#define VFF_FILEINUSE &h0002
#define VFF_BUFFTOOSMALL &h0004
#define VIFF_FORCEINSTALL &h0001
#define VIFF_DONTDELETEOLD &h0002
#define VIF_TEMPFILE __MSABI_LONG(&h00000001)
#define VIF_MISMATCH __MSABI_LONG(&h00000002)
#define VIF_SRCOLD __MSABI_LONG(&h00000004)
#define VIF_DIFFLANG __MSABI_LONG(&h00000008)
#define VIF_DIFFCODEPG __MSABI_LONG(&h00000010)
#define VIF_DIFFTYPE __MSABI_LONG(&h00000020)
#define VIF_WRITEPROT __MSABI_LONG(&h00000040)
#define VIF_FILEINUSE __MSABI_LONG(&h00000080)
#define VIF_OUTOFSPACE __MSABI_LONG(&h00000100)
#define VIF_ACCESSVIOLATION __MSABI_LONG(&h00000200)
#define VIF_SHARINGVIOLATION __MSABI_LONG(&h00000400)
#define VIF_CANNOTCREATE __MSABI_LONG(&h00000800)
#define VIF_CANNOTDELETE __MSABI_LONG(&h00001000)
#define VIF_CANNOTRENAME __MSABI_LONG(&h00002000)
#define VIF_CANNOTDELETECUR __MSABI_LONG(&h00004000)
#define VIF_OUTOFMEMORY __MSABI_LONG(&h00008000)
#define VIF_CANNOTREADSRC __MSABI_LONG(&h00010000)
#define VIF_CANNOTREADDST __MSABI_LONG(&h00020000)
#define VIF_BUFFTOOSMALL __MSABI_LONG(&h00040000)
#define VIF_CANNOTLOADLZ32 __MSABI_LONG(&h00080000)
#define VIF_CANNOTLOADCABINET __MSABI_LONG(&h00100000)

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

#ifdef UNICODE
	#define VerFindFile VerFindFileW
	#define VerInstallFile VerInstallFileW
	#define GetFileVersionInfoSize GetFileVersionInfoSizeW
	#define GetFileVersionInfo GetFileVersionInfoW
	#define VerLanguageName VerLanguageNameW
	#define VerQueryValue VerQueryValueW
#else
	#define VerFindFile VerFindFileA
	#define VerInstallFile VerInstallFileA
	#define GetFileVersionInfoSize GetFileVersionInfoSizeA
	#define GetFileVersionInfo GetFileVersionInfoA
	#define VerLanguageName VerLanguageNameA
	#define VerQueryValue VerQueryValueA
#endif

declare function VerFindFileA(byval uFlags as DWORD, byval szFileName as LPSTR, byval szWinDir as LPSTR, byval szAppDir as LPSTR, byval szCurDir as LPSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPSTR, byval lpuDestDirLen as PUINT) as DWORD
declare function VerFindFileW(byval uFlags as DWORD, byval szFileName as LPWSTR, byval szWinDir as LPWSTR, byval szAppDir as LPWSTR, byval szCurDir as LPWSTR, byval lpuCurDirLen as PUINT, byval szDestDir as LPWSTR, byval lpuDestDirLen as PUINT) as DWORD
declare function VerInstallFileA(byval uFlags as DWORD, byval szSrcFileName as LPSTR, byval szDestFileName as LPSTR, byval szSrcDir as LPSTR, byval szDestDir as LPSTR, byval szCurDir as LPSTR, byval szTmpFile as LPSTR, byval lpuTmpFileLen as PUINT) as DWORD
declare function VerInstallFileW(byval uFlags as DWORD, byval szSrcFileName as LPWSTR, byval szDestFileName as LPWSTR, byval szSrcDir as LPWSTR, byval szDestDir as LPWSTR, byval szCurDir as LPWSTR, byval szTmpFile as LPWSTR, byval lpuTmpFileLen as PUINT) as DWORD
declare function GetFileVersionInfoSizeA(byval lptstrFilename as LPCSTR, byval lpdwHandle as LPDWORD) as DWORD
declare function GetFileVersionInfoSizeW(byval lptstrFilename as LPCWSTR, byval lpdwHandle as LPDWORD) as DWORD
declare function GetFileVersionInfoA(byval lptstrFilename as LPCSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL
declare function GetFileVersionInfoW(byval lptstrFilename as LPCWSTR, byval dwHandle as DWORD, byval dwLen as DWORD, byval lpData as LPVOID) as WINBOOL
declare function VerLanguageNameA(byval wLang as DWORD, byval szLang as LPSTR, byval nSize as DWORD) as DWORD
declare function VerLanguageNameW(byval wLang as DWORD, byval szLang as LPWSTR, byval nSize as DWORD) as DWORD
declare function VerQueryValueA(byval pBlock as const LPVOID, byval lpSubBlock as LPCSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL
declare function VerQueryValueW(byval pBlock as const LPVOID, byval lpSubBlock as LPCWSTR, byval lplpBuffer as LPVOID ptr, byval puLen as PUINT) as WINBOOL

end extern
