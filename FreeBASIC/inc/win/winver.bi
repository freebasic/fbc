''
''
'' winver -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winver_bi__
#define __win_winver_bi__

#inclib "version"

#define VS_VERSION_INFO 1
#define VS_USER_DEFINED 100
#define VS_FFI_SIGNATURE &hFEEF04BD
#define VS_FFI_STRUCVERSION &h10000
#define VS_FFI_FILEFLAGSMASK &h3F
#define VS_FF_DEBUG 1
#define VS_FF_PRERELEASE 2
#define VS_FF_PATCHED 4
#define VS_FF_PRIVATEBUILD 8
#define VS_FF_INFOINFERRED 16
#define VS_FF_SPECIALBUILD 32
#define VOS_UNKNOWN 0
#define VOS_DOS &h10000
#define VOS_OS216 &h20000
#define VOS_OS232 &h30000
#define VOS_NT &h40000
#define VOS__BASE 0
#define VOS__WINDOWS16 1
#define VOS__PM16 2
#define VOS__PM32 3
#define VOS__WINDOWS32 4
#define VOS_DOS_WINDOWS16 &h10001
#define VOS_DOS_WINDOWS32 &h10004
#define VOS_OS216_PM16 &h20002
#define VOS_OS232_PM32 &h30003
#define VOS_NT_WINDOWS32 &h40004
#define VFT_UNKNOWN 0
#define VFT_APP 1
#define VFT_DLL 2
#define VFT_DRV 3
#define VFT_FONT 4
#define VFT_VXD 5
#define VFT_STATIC_LIB 7
#define VFT2_UNKNOWN 0
#define VFT2_DRV_PRINTER 1
#define VFT2_DRV_KEYBOARD 2
#define VFT2_DRV_LANGUAGE 3
#define VFT2_DRV_DISPLAY 4
#define VFT2_DRV_MOUSE 5
#define VFT2_DRV_NETWORK 6
#define VFT2_DRV_SYSTEM 7
#define VFT2_DRV_INSTALLABLE 8
#define VFT2_DRV_SOUND 9
#define VFT2_DRV_COMM 10
#define VFT2_DRV_INPUTMETHOD 11
#define VFT2_FONT_RASTER 1
#define VFT2_FONT_VECTOR 2
#define VFT2_FONT_TRUETYPE 3
#define VFFF_ISSHAREDFILE 1
#define VFF_CURNEDEST 1
#define VFF_FILEINUSE 2
#define VFF_BUFFTOOSMALL 4
#define VIFF_FORCEINSTALL 1
#define VIFF_DONTDELETEOLD 2
#define VIF_TEMPFILE 1
#define VIF_MISMATCH 2
#define VIF_SRCOLD 4
#define VIF_DIFFLANG 8
#define VIF_DIFFCODEPG 16
#define VIF_DIFFTYPE 32
#define VIF_WRITEPROT 64
#define VIF_FILEINUSE 128
#define VIF_OUTOFSPACE 256
#define VIF_ACCESSVIOLATION 512
#define VIF_SHARINGVIOLATION 1024
#define VIF_CANNOTCREATE 2048
#define VIF_CANNOTDELETE 4096
#define VIF_CANNOTRENAME 8192
#define VIF_CANNOTDELETECUR 16384
#define VIF_OUTOFMEMORY 32768
#define VIF_CANNOTREADSRC 65536
#define VIF_CANNOTREADDST &h20000
#define VIF_BUFFTOOSMALL &h40000

type VS_FIXEDFILEINFO
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

#ifdef UNICODE
declare function VerFindFile alias "VerFindFileW" (byval as DWORD, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as PUINT, byval as LPWSTR, byval as PUINT) as DWORD
declare function VerInstallFile alias "VerInstallFileW" (byval as DWORD, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as PUINT) as DWORD
declare function GetFileVersionInfoSize alias "GetFileVersionInfoSizeW" (byval as LPWSTR, byval as PDWORD) as DWORD
declare function GetFileVersionInfo alias "GetFileVersionInfoW" (byval as LPWSTR, byval as DWORD, byval as DWORD, byval as PVOID) as BOOL
declare function VerLanguageName alias "VerLanguageNameW" (byval as DWORD, byval as LPWSTR, byval as DWORD) as DWORD
declare function VerQueryValue alias "VerQueryValueW" (byval as LPVOID, byval as LPWSTR, byval as LPVOID ptr, byval as PUINT) as BOOL

#else ''UNICODE
declare function VerFindFile alias "VerFindFileA" (byval as DWORD, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as PUINT, byval as LPSTR, byval as PUINT) as DWORD
declare function VerInstallFile alias "VerInstallFileA" (byval as DWORD, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as PUINT) as DWORD
declare function GetFileVersionInfoSize alias "GetFileVersionInfoSizeA" (byval as LPSTR, byval as PDWORD) as DWORD
declare function GetFileVersionInfo alias "GetFileVersionInfoA" (byval as LPSTR, byval as DWORD, byval as DWORD, byval as PVOID) as BOOL
declare function VerLanguageName alias "VerLanguageNameA" (byval as DWORD, byval as LPSTR, byval as DWORD) as DWORD
declare function VerQueryValue alias "VerQueryValueA" (byval as LPVOID, byval as LPSTR, byval as LPVOID ptr, byval as PUINT) as BOOL

#endif ''UNICODE

#endif
