''
''
'' shlwapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_shlwapi_bi__
#define __win_shlwapi_bi__

#include once "win/objbase.bi"
#include once "win/shlobj.bi"

#inclib "shlwapi"

#define DLLVER_PLATFORM_WINDOWS &h00000001
#define DLLVER_PLATFORM_NT &h00000002
#define URL_DONT_ESCAPE_EXTRA_INFO &h02000000
#define URL_DONT_SIMPLIFY &h08000000
#define URL_ESCAPE_PERCENT &h00001000
#define URL_ESCAPE_SEGMENT_ONLY &h00002000
#define URL_ESCAPE_SPACES_ONLY &h04000000
#define URL_ESCAPE_UNSAFE &h20000000
#define URL_INTERNAL_PATH &h00800000
#define URL_PARTFLAG_KEEPSCHEME &h00000001
#define URL_PLUGGABLE_PROTOCOL &h40000000
#define URL_UNESCAPE &h10000000
#define URL_UNESCAPE_HIGH_ANSI_ONLY &h00400000
#define URL_UNESCAPE_INPLACE &h00100000

type DLLVERSIONINFO field=1
	cbSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformID as DWORD
end type

type DLLVERSIONINFO2 field=1
	info1 as DLLVERSIONINFO
	dwFlags as DWORD
	ullVersion as ULONGLONG
end type

#define MAKEDLLVERULL(major, minor, build, qfe) ((culngint(major) shl 48) or (culngint(minor) shl 32) or (culngint(build) shl 16) or (culngint(  qfe) shl  0))

enum ASSOCSTR
	ASSOCSTR_COMMAND
	ASSOCSTR_EXECUTABLE
	ASSOCSTR_FRIENDLYDOCNAME
	ASSOCSTR_FRIENDLYAPPNAME
	ASSOCSTR_NOOPEN
	ASSOCSTR_SHELLNEWVALUE
	ASSOCSTR_DDECOMMAND
	ASSOCSTR_DDEIFEXEC
	ASSOCSTR_DDEAPPLICATION
	ASSOCSTR_DDETOPIC
end enum


enum ASSOCKEY
	ASSOCKEY_SHELLEXECCLASS = 1
	ASSOCKEY_APP
	ASSOCKEY_CLASS
	ASSOCKEY_BASECLASS
end enum


enum ASSOCDATA
	ASSOCDATA_MSIDESCRIPTOR = 1
	ASSOCDATA_NOACTIVATEHANDLER
	ASSOCDATA_QUERYCLASSSTORE
end enum

type ASSOCF as DWORD

enum SHREGDEL_FLAGS
	SHREGDEL_DEFAULT = &h00000000
	SHREGDEL_HKCU = &h00000001
	SHREGDEL_HKLM = &h00000010
	SHREGDEL_BOTH = &h00000011
end enum


enum SHREGENUM_FLAGS
	SHREGENUM_DEFAULT = &h00000000
	SHREGENUM_HKCU = &h00000001
	SHREGENUM_HKLM = &h00000010
	SHREGENUM_BOTH = &h00000011
end enum


enum URLIS_
	URLIS_URL
	URLIS_OPAQUE
	URLIS_NOHISTORY
	URLIS_FILEURL
	URLIS_APPLIABLE
	URLIS_DIRECTORY
	URLIS_HASQUERY
end enum

type HUSKEY as HANDLE
type PHUSKEY as HANDLE ptr
type DLLGETVERSIONPROC as function (byval as DLLVERSIONINFO ptr) as HRESULT

#define IntlStrEqNA(pStr1, pStr2, nChar) IntlStrEqWorkerA(TRUE, pStr1, pStr2, nChar);
#define IntlStrEqNW(pStr1, pStr2, nChar) IntlStrEqWorkerW(TRUE, pStr1, pStr2, nChar);
#define IntlStrEqNIA(pStr1, pStr2, nChar) IntlStrEqWorkerA(FALSE, pStr1, pStr2, nChar);
#define IntlStrEqNIW(pStr1, pStr2, nChar) IntlStrEqWorkerW(FALSE, pStr1, pStr2, nChar);

declare function PathIsUNCA alias "PathIsUNCA" (byval as LPCSTR) as BOOL
declare function SHCreateThread alias "SHCreateThread" (byval as LPTHREAD_START_ROUTINE, byval as any ptr, byval as DWORD, byval as LPTHREAD_START_ROUTINE) as BOOL
declare function SHGetThreadRef alias "SHGetThreadRef" (byval as IUnknown ptr ptr) as HRESULT
declare function SHSetThreadRef alias "SHSetThreadRef" (byval as IUnknown ptr) as HRESULT
declare function SHSkipJunction alias "SHSkipJunction" (byval as IBindCtx ptr, byval as CLSID ptr) as BOOL
declare function AssocCreate alias "AssocCreate" (byval as CLSID, byval as IID ptr, byval as LPVOID ptr) as HRESULT
declare function SHRegCloseUSKey alias "SHRegCloseUSKey" (byval as HUSKEY) as DWORD
declare function SHRegDuplicateHKey alias "SHRegDuplicateHKey" (byval as HKEY) as HKEY
declare function HashData alias "HashData" (byval as LPBYTE, byval as DWORD, byval as LPBYTE, byval as DWORD) as HRESULT
declare function SHCreateShellPalette alias "SHCreateShellPalette" (byval as HDC) as HPALETTE
declare function ColorHLSToRGB alias "ColorHLSToRGB" (byval as WORD, byval as WORD, byval as WORD) as COLORREF
declare function ColorAdjustLuma alias "ColorAdjustLuma" (byval as COLORREF, byval as integer, byval as BOOL) as COLORREF
declare sub ColorRGBToHLS alias "ColorRGBToHLS" (byval as COLORREF, byval as WORD ptr, byval as WORD ptr, byval as WORD ptr)
declare function SHAutoComplete alias "SHAutoComplete" (byval as HWND, byval as DWORD) as HRESULT
declare function DllInstall alias "DllInstall" (byval as BOOL, byval as LPCWSTR) as HRESULT

#ifdef UNICODE
declare function ChrCmpI alias "ChrCmpIW" (byval as WCHAR, byval as WCHAR) as BOOL
declare function IntlStrEqWorker alias "IntlStrEqWorkerW" (byval as BOOL, byval as LPCWSTR, byval as LPCWSTR, byval as integer) as BOOL
declare function SHStrDup alias "SHStrDupW" (byval as LPCWSTR, byval as LPWSTR ptr) as HRESULT
declare function StrCat alias "StrCatW" (byval as LPWSTR, byval as LPCWSTR) as LPWSTR
declare function StrCatBuff alias "StrCatBuffW" (byval as LPWSTR, byval as LPCWSTR, byval as integer) as LPWSTR
declare function StrCatChain alias "StrCatChainW" (byval as LPWSTR, byval as DWORD, byval as DWORD, byval as LPCWSTR) as DWORD
declare function StrChr alias "StrChrW" (byval as LPCWSTR, byval as WCHAR) as LPWSTR
declare function StrChrI alias "StrChrIW" (byval as LPCWSTR, byval as WCHAR) as LPWSTR
declare function StrCmpI alias "StrCmpIW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function StrCmp alias "StrCmpW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function StrCpy alias "StrCpyW" (byval as LPWSTR, byval as LPCWSTR) as LPWSTR
declare function StrCpyN alias "StrCpyNW" (byval as LPWSTR, byval as LPCWSTR, byval as integer) as LPWSTR
declare function StrCmpN alias "StrCmpNW" (byval as LPCWSTR, byval as LPCWSTR, byval as integer) as integer
declare function StrCmpNI alias "StrCmpNIW" (byval as LPCWSTR, byval as LPCWSTR, byval as integer) as integer
declare function StrCSpn alias "StrCSpnW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function StrCSpnI alias "StrCSpnIW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function StrDup alias "StrDupW" (byval as LPCWSTR) as LPWSTR
declare function StrFormatByteSize alias "StrFormatByteSizeW" (byval as LONGLONG, byval as LPWSTR, byval as UINT) as LPWSTR
declare function StrFormatKBSize alias "StrFormatKBSizeW" (byval as LONGLONG, byval as LPWSTR, byval as UINT) as LPWSTR
declare function StrFromTimeInterval alias "StrFromTimeIntervalW" (byval as LPWSTR, byval as UINT, byval as DWORD, byval as integer) as integer
declare function StrIsIntlEqual alias "StrIsIntlEqualW" (byval as BOOL, byval as LPCWSTR, byval as LPCWSTR, byval as integer) as BOOL
declare function StrNCat alias "StrNCatW" (byval as LPWSTR, byval as LPCWSTR, byval as integer) as LPWSTR
declare function StrPBrk alias "StrPBrkW" (byval as LPCWSTR, byval as LPCWSTR) as LPWSTR
declare function StrRChr alias "StrRChrW" (byval as LPCWSTR, byval as LPCWSTR, byval as WCHAR) as LPWSTR
declare function StrRChrI alias "StrRChrIW" (byval as LPCWSTR, byval as LPCWSTR, byval as WCHAR) as LPWSTR
declare function StrRetToBuf alias "StrRetToBufW" (byval as LPSTRRET, byval as LPCITEMIDLIST, byval as LPWSTR, byval as UINT) as HRESULT
declare function StrRetToStr alias "StrRetToStrW" (byval as LPSTRRET, byval as LPCITEMIDLIST, byval as LPWSTR ptr) as HRESULT
declare function StrRStrI alias "StrRStrIW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as LPWSTR
declare function StrSpn alias "StrSpnW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function StrStrI alias "StrStrIW" (byval as LPCWSTR, byval as LPCWSTR) as LPWSTR
declare function StrStr alias "StrStrW" (byval as LPCWSTR, byval as LPCWSTR) as LPWSTR
declare function StrToInt alias "StrToIntW" (byval as LPCWSTR) as integer
declare function StrToIntEx alias "StrToIntExW" (byval as LPCWSTR, byval as DWORD, byval as integer ptr) as BOOL
declare function StrTrim alias "StrTrimW" (byval as LPWSTR, byval as LPCWSTR) as BOOL
declare function PathAddBackslash alias "PathAddBackslashW" (byval as LPWSTR) as LPWSTR
declare function PathAddExtension alias "PathAddExtensionW" (byval as LPWSTR, byval as LPCWSTR) as BOOL
declare function PathAppend alias "PathAppendW" (byval as LPWSTR, byval as LPCWSTR) as BOOL
declare function PathBuildRoot alias "PathBuildRootW" (byval as LPWSTR, byval as integer) as LPWSTR
declare function PathCanonicalize alias "PathCanonicalizeW" (byval as LPWSTR, byval as LPCWSTR) as BOOL
declare function PathCombine alias "PathCombineW" (byval as LPWSTR, byval as LPCWSTR, byval as LPCWSTR) as LPWSTR
declare function PathCommonPrefix alias "PathCommonPrefixW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR) as integer
declare function PathCompactPath alias "PathCompactPathW" (byval as HDC, byval as LPWSTR, byval as UINT) as BOOL
declare function PathCompactPathEx alias "PathCompactPathExW" (byval as LPWSTR, byval as LPCWSTR, byval as UINT, byval as DWORD) as BOOL
declare function PathCreateFromUrl alias "PathCreateFromUrlW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function PathFileExists alias "PathFileExistsW" (byval as LPCWSTR) as BOOL
declare function PathFindExtension alias "PathFindExtensionW" (byval as LPCWSTR) as LPWSTR
declare function PathFindFileName alias "PathFindFileNameW" (byval as LPCWSTR) as LPWSTR
declare function PathFindNextComponent alias "PathFindNextComponentW" (byval as LPCWSTR) as LPWSTR
declare function PathFindOnPath alias "PathFindOnPathW" (byval as LPWSTR, byval as LPCWSTR ptr) as BOOL
declare function PathFindSuffixArray alias "PathFindSuffixArrayW" (byval as LPCWSTR, byval as LPCWSTR ptr, byval as integer) as LPCWSTR
declare function PathGetArgs alias "PathGetArgsW" (byval as LPCWSTR) as LPWSTR
declare function PathGetCharType alias "PathGetCharTypeW" (byval as WCHAR) as UINT
declare function PathGetDriveNumber alias "PathGetDriveNumberW" (byval as LPCWSTR) as integer
declare function PathIsContentType alias "PathIsContentTypeW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function PathIsDirectoryEmpty alias "PathIsDirectoryEmptyW" (byval as LPCWSTR) as BOOL
declare function PathIsDirectory alias "PathIsDirectoryW" (byval as LPCWSTR) as BOOL
declare function PathIsFileSpec alias "PathIsFileSpecW" (byval as LPCWSTR) as BOOL
declare function PathIsLFNFileSpec alias "PathIsLFNFileSpecW" (byval as LPCWSTR) as BOOL
declare function PathIsNetworkPath alias "PathIsNetworkPathW" (byval as LPCWSTR) as BOOL
declare function PathIsPrefix alias "PathIsPrefixW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function PathIsRelative alias "PathIsRelativeW" (byval as LPCWSTR) as BOOL
declare function PathIsRoot alias "PathIsRootW" (byval as LPCWSTR) as BOOL
declare function PathIsSameRoot alias "PathIsSameRootW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function PathIsSystemFolder alias "PathIsSystemFolderW" (byval as LPCWSTR, byval as DWORD) as BOOL
declare function PathIsUNCServerShare alias "PathIsUNCServerShareW" (byval as LPCWSTR) as BOOL
declare function PathIsUNCServer alias "PathIsUNCServerW" (byval as LPCWSTR) as BOOL
declare function PathIsUNC alias "PathIsUNCW" (byval as LPCWSTR) as BOOL
declare function PathIsURL alias "PathIsURLW" (byval as LPCWSTR) as BOOL
declare function PathMakePretty alias "PathMakePrettyW" (byval as LPWSTR) as BOOL
declare function PathMakeSystemFolder alias "PathMakeSystemFolderW" (byval as LPWSTR) as BOOL
declare function PathMatchSpec alias "PathMatchSpecW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function PathParseIconLocation alias "PathParseIconLocationW" (byval as LPWSTR) as integer
declare sub PathQuoteSpaces alias "PathQuoteSpacesW" (byval as LPWSTR)
declare function PathRelativePathTo alias "PathRelativePathToW" (byval as LPWSTR, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as DWORD) as BOOL
declare sub PathRemoveArgs alias "PathRemoveArgsW" (byval as LPWSTR)
declare function PathRemoveBackslash alias "PathRemoveBackslashW" (byval as LPWSTR) as LPWSTR
declare sub PathRemoveBlanks alias "PathRemoveBlanksW" (byval as LPWSTR)
declare sub PathRemoveExtension alias "PathRemoveExtensionW" (byval as LPWSTR)
declare function PathRemoveFileSpec alias "PathRemoveFileSpecW" (byval as LPWSTR) as BOOL
declare function PathRenameExtension alias "PathRenameExtensionW" (byval as LPWSTR, byval as LPCWSTR) as BOOL
declare function PathSearchAndQualify alias "PathSearchAndQualifyW" (byval as LPCWSTR, byval as LPWSTR, byval as UINT) as BOOL
declare sub PathSetDlgItemPath alias "PathSetDlgItemPathW" (byval as HWND, byval as integer, byval as LPCWSTR)
declare function PathSkipRoot alias "PathSkipRootW" (byval as LPCWSTR) as LPWSTR
declare sub PathStripPath alias "PathStripPathW" (byval as LPWSTR)
declare function PathStripToRoot alias "PathStripToRootW" (byval as LPWSTR) as BOOL
declare sub PathUndecorate alias "PathUndecorateW" (byval as LPWSTR)
declare function PathUnExpandEnvStrings alias "PathUnExpandEnvStringsW" (byval as LPCWSTR, byval as LPWSTR, byval as UINT) as BOOL
declare function PathUnmakeSystemFolder alias "PathUnmakeSystemFolderW" (byval as LPWSTR) as BOOL
declare sub PathUnquoteSpaces alias "PathUnquoteSpacesW" (byval as LPWSTR)
declare function SHCreateStreamOnFile alias "SHCreateStreamOnFileW" (byval as LPCWSTR, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare function SHOpenRegStream2 alias "SHOpenRegStream2W" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as IStream ptr
declare function SHOpenRegStream alias "SHOpenRegStreamW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as IStream ptr
declare function SHCopyKey alias "SHCopyKeyW" (byval as HKEY, byval as LPCWSTR, byval as HKEY, byval as DWORD) as DWORD
declare function SHDeleteEmptyKey alias "SHDeleteEmptyKeyW" (byval as HKEY, byval as LPCWSTR) as DWORD
declare function SHDeleteKey alias "SHDeleteKeyW" (byval as HKEY, byval as LPCWSTR) as DWORD
declare function SHEnumKeyEx alias "SHEnumKeyExW" (byval as HKEY, byval as DWORD, byval as LPWSTR, byval as LPDWORD) as DWORD
declare function SHQueryInfoKey alias "SHQueryInfoKeyW" (byval as HKEY, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function SHQueryValueEx alias "SHQueryValueExW" (byval as HKEY, byval as LPCWSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHEnumValue alias "SHEnumValueW" (byval as HKEY, byval as DWORD, byval as LPWSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHGetValue alias "SHGetValueW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHSetValue alias "SHSetValueW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPCVOID, byval as DWORD) as DWORD
declare function SHDeleteValue alias "SHDeleteValueW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR) as DWORD
declare function AssocQueryKey alias "AssocQueryKeyW" (byval as ASSOCF, byval as ASSOCKEY, byval as LPCWSTR, byval as LPCWSTR, byval as HKEY ptr) as HRESULT
declare function AssocQueryStringByKey alias "AssocQueryStringByKeyW" (byval as ASSOCF, byval as ASSOCSTR, byval as HKEY, byval as LPCWSTR, byval as LPWSTR, byval as DWORD ptr) as HRESULT
declare function AssocQueryString alias "AssocQueryStringW" (byval as ASSOCF, byval as ASSOCSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as DWORD ptr) as HRESULT
declare function UrlApplyScheme alias "UrlApplySchemeW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCanonicalize alias "UrlCanonicalizeW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCombine alias "UrlCombineW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCompare alias "UrlCompareW" (byval as LPCWSTR, byval as LPCWSTR, byval as BOOL) as integer
declare function UrlCreateFromPath alias "UrlCreateFromPathW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlEscape alias "UrlEscapeW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlGetLocation alias "UrlGetLocationW" (byval as LPCWSTR) as LPCWSTR
declare function UrlGetPart alias "UrlGetPartW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD, byval as DWORD) as HRESULT
declare function UrlHash alias "UrlHashW" (byval as LPCWSTR, byval as LPBYTE, byval as DWORD) as HRESULT
declare function UrlIs alias "UrlIsW" (byval as LPCWSTR, byval as URLIS_) as BOOL
declare function UrlIsNoHistory alias "UrlIsNoHistoryW" (byval as LPCWSTR) as BOOL
declare function UrlIsOpaque alias "UrlIsOpaqueW" (byval as LPCWSTR) as BOOL
declare function UrlUnescape alias "UrlUnescapeW" (byval as LPWSTR, byval as LPWSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function SHRegCreateUSKey alias "SHRegCreateUSKeyW" (byval as LPCWSTR, byval as REGSAM, byval as HUSKEY, byval as PHUSKEY, byval as DWORD) as LONG
declare function SHRegDeleteEmptyUSKey alias "SHRegDeleteEmptyUSKeyW" (byval as HUSKEY, byval as LPCWSTR, byval as SHREGDEL_FLAGS) as LONG
declare function SHRegDeleteUSValue alias "SHRegDeleteUSValueW" (byval as HUSKEY, byval as LPCWSTR, byval as SHREGDEL_FLAGS) as LONG
declare function SHRegEnumUSKey alias "SHRegEnumUSKeyW" (byval as HUSKEY, byval as DWORD, byval as LPWSTR, byval as LPDWORD, byval as SHREGENUM_FLAGS) as DWORD
declare function SHRegEnumUSValue alias "SHRegEnumUSValueW" (byval as HUSKEY, byval as DWORD, byval as LPWSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as SHREGENUM_FLAGS) as DWORD
declare function SHRegGetBoolUSValue alias "SHRegGetBoolUSValueW" (byval as LPCWSTR, byval as LPCWSTR, byval as BOOL, byval as BOOL) as BOOL
declare function SHRegGetPath alias "SHRegGetPathW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function SHRegGetUSValue alias "SHRegGetUSValueW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as BOOL, byval as LPVOID, byval as DWORD) as LONG
declare function SHRegOpenUSKey alias "SHRegOpenUSKeyW" (byval as LPCWSTR, byval as REGSAM, byval as HUSKEY, byval as PHUSKEY, byval as BOOL) as LONG
declare function SHRegQueryInfoUSKey alias "SHRegQueryInfoUSKeyW" (byval as HUSKEY, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function SHRegQueryUSValue alias "SHRegQueryUSValueW" (byval as HUSKEY, byval as LPCWSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as BOOL, byval as LPVOID, byval as DWORD) as LONG
declare function SHRegSetPath alias "SHRegSetPathW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as DWORD
declare function SHRegSetUSValue alias "SHRegSetUSValueW" (byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as LONG
declare function SHRegWriteUSValue alias "SHRegWriteUSValueW" (byval as HUSKEY, byval as LPCWSTR, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as LONG
declare function wnsprintf cdecl alias "wnsprintfW" (byval as LPWSTR, byval as integer, byval as LPCWSTR, ...) as integer
''''''' declare function wvnsprintf alias "wvnsprintfW" (byval as LPWSTR, byval as integer, byval as LPCWSTR, byval as va_list) as integer
declare function MLLoadLibrary alias "MLLoadLibraryW" (byval as LPCWSTR, byval as HANDLE, byval as DWORD, byval as LPCWSTR, byval as BOOL) as HINSTANCE

#else ''UNICODE
declare function ChrCmpI alias "ChrCmpIA" (byval as WORD, byval as WORD) as BOOL
declare function IntlStrEqWorker alias "IntlStrEqWorkerA" (byval as BOOL, byval as LPCSTR, byval as LPCSTR, byval as integer) as BOOL
declare function SHStrDup alias "SHStrDupA" (byval as LPCSTR, byval as LPWSTR ptr) as HRESULT
declare function StrCat alias "StrCatA" (byval as LPSTR, byval as LPCSTR) as LPSTR
declare function StrCatBuff alias "StrCatBuffA" (byval as LPSTR, byval as LPCSTR, byval as integer) as LPSTR
declare function StrChr alias "StrChrA" (byval as LPCSTR, byval as WORD) as LPSTR
declare function StrChrI alias "StrChrIA" (byval as LPCSTR, byval as WORD) as LPSTR
declare function StrCmpN alias "StrCmpNA" (byval as LPCSTR, byval as LPCSTR, byval as integer) as integer
declare function StrCmpNI alias "StrCmpNIA" (byval as LPCSTR, byval as LPCSTR, byval as integer) as integer
declare function StrCSpn alias "StrCSpnA" (byval as LPCSTR, byval as LPCSTR) as integer
declare function StrCSpnI alias "StrCSpnIA" (byval as LPCSTR, byval as LPCSTR) as integer
declare function StrDup alias "StrDupA" (byval as LPCSTR) as LPSTR
declare function StrFormatByteSize64 alias "StrFormatByteSize64A" (byval as LONGLONG, byval as LPSTR, byval as UINT) as LPSTR
declare function StrFormatByteSize alias "StrFormatByteSizeA" (byval as DWORD, byval as LPSTR, byval as UINT) as LPSTR
declare function StrFormatKBSize alias "StrFormatKBSizeA" (byval as LONGLONG, byval as LPSTR, byval as UINT) as LPSTR
declare function StrFromTimeInterval alias "StrFromTimeIntervalA" (byval as LPSTR, byval as UINT, byval as DWORD, byval as integer) as integer
declare function StrIsIntlEqual alias "StrIsIntlEqualA" (byval as BOOL, byval as LPCSTR, byval as LPCSTR, byval as integer) as BOOL
declare function StrNCat alias "StrNCatA" (byval as LPSTR, byval as LPCSTR, byval as integer) as LPSTR
declare function StrPBrk alias "StrPBrkA" (byval as LPCSTR, byval as LPCSTR) as LPSTR
declare function StrRChr alias "StrRChrA" (byval as LPCSTR, byval as LPCSTR, byval as WORD) as LPSTR
declare function StrRChrI alias "StrRChrIA" (byval as LPCSTR, byval as LPCSTR, byval as WORD) as LPSTR
declare function StrRetToBuf alias "StrRetToBufA" (byval as LPSTRRET, byval as LPCITEMIDLIST, byval as LPSTR, byval as UINT) as HRESULT
declare function StrRetToStr alias "StrRetToStrA" (byval as LPSTRRET, byval as LPCITEMIDLIST, byval as LPSTR ptr) as HRESULT
declare function StrRStrI alias "StrRStrIA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as LPSTR
declare function StrSpn alias "StrSpnA" (byval as LPCSTR, byval as LPCSTR) as integer
declare function StrStr alias "StrStrA" (byval as LPCSTR, byval as LPCSTR) as LPSTR
declare function StrStrI alias "StrStrIA" (byval as LPCSTR, byval as LPCSTR) as LPSTR
declare function StrToInt alias "StrToIntA" (byval as LPCSTR) as integer
declare function StrToIntEx alias "StrToIntExA" (byval as LPCSTR, byval as DWORD, byval as integer ptr) as BOOL
declare function StrTrim alias "StrTrimA" (byval as LPSTR, byval as LPCSTR) as BOOL
declare function PathAddBackslash alias "PathAddBackslashA" (byval as LPSTR) as LPSTR
declare function PathAddExtension alias "PathAddExtensionA" (byval as LPSTR, byval as LPCSTR) as BOOL
declare function PathAppend alias "PathAppendA" (byval as LPSTR, byval as LPCSTR) as BOOL
declare function PathBuildRoot alias "PathBuildRootA" (byval as LPSTR, byval as integer) as LPSTR
declare function PathCanonicalize alias "PathCanonicalizeA" (byval as LPSTR, byval as LPCSTR) as BOOL
declare function PathCombine alias "PathCombineA" (byval as LPSTR, byval as LPCSTR, byval as LPCSTR) as LPSTR
declare function PathCommonPrefix alias "PathCommonPrefixA" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR) as integer
declare function PathCompactPath alias "PathCompactPathA" (byval as HDC, byval as LPSTR, byval as UINT) as BOOL
declare function PathCompactPathEx alias "PathCompactPathExA" (byval as LPSTR, byval as LPCSTR, byval as UINT, byval as DWORD) as BOOL
declare function PathCreateFromUrl alias "PathCreateFromUrlA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function PathFileExists alias "PathFileExistsA" (byval as LPCSTR) as BOOL
declare function PathFindExtension alias "PathFindExtensionA" (byval as LPCSTR) as LPSTR
declare function PathFindFileName alias "PathFindFileNameA" (byval as LPCSTR) as LPSTR
declare function PathFindNextComponent alias "PathFindNextComponentA" (byval as LPCSTR) as LPSTR
declare function PathFindOnPath alias "PathFindOnPathA" (byval as LPSTR, byval as LPCSTR ptr) as BOOL
declare function PathFindSuffixArray alias "PathFindSuffixArrayA" (byval as LPCSTR, byval as LPCSTR ptr, byval as integer) as LPCSTR
declare function PathGetArgs alias "PathGetArgsA" (byval as LPCSTR) as LPSTR
declare function PathGetCharType alias "PathGetCharTypeA" (byval as UCHAR) as UINT
declare function PathGetDriveNumber alias "PathGetDriveNumberA" (byval as LPCSTR) as integer
declare function PathIsContentType alias "PathIsContentTypeA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function PathIsDirectory alias "PathIsDirectoryA" (byval as LPCSTR) as BOOL
declare function PathIsDirectoryEmpty alias "PathIsDirectoryEmptyA" (byval as LPCSTR) as BOOL
declare function PathIsFileSpec alias "PathIsFileSpecA" (byval as LPCSTR) as BOOL
declare function PathIsLFNFileSpec alias "PathIsLFNFileSpecA" (byval as LPCSTR) as BOOL
declare function PathIsNetworkPath alias "PathIsNetworkPathA" (byval as LPCSTR) as BOOL
declare function PathIsPrefix alias "PathIsPrefixA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function PathIsRelative alias "PathIsRelativeA" (byval as LPCSTR) as BOOL
declare function PathIsRoot alias "PathIsRootA" (byval as LPCSTR) as BOOL
declare function PathIsSameRoot alias "PathIsSameRootA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function PathIsSystemFolder alias "PathIsSystemFolderA" (byval as LPCSTR, byval as DWORD) as BOOL
declare function PathIsUNC alias "PathIsUNCA" (byval as LPCSTR) as BOOL
declare function PathIsUNCServer alias "PathIsUNCServerA" (byval as LPCSTR) as BOOL
declare function PathIsUNCServerShare alias "PathIsUNCServerShareA" (byval as LPCSTR) as BOOL
declare function PathIsURL alias "PathIsURLA" (byval as LPCSTR) as BOOL
declare function PathMakePretty alias "PathMakePrettyA" (byval as LPSTR) as BOOL
declare function PathMakeSystemFolder alias "PathMakeSystemFolderA" (byval as LPSTR) as BOOL
declare function PathMatchSpec alias "PathMatchSpecA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function PathParseIconLocation alias "PathParseIconLocationA" (byval as LPSTR) as integer
declare sub PathQuoteSpaces alias "PathQuoteSpacesA" (byval as LPSTR)
declare function PathRelativePathTo alias "PathRelativePathToA" (byval as LPSTR, byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as DWORD) as BOOL
declare sub PathRemoveArgs alias "PathRemoveArgsA" (byval as LPSTR)
declare function PathRemoveBackslash alias "PathRemoveBackslashA" (byval as LPSTR) as LPSTR
declare sub PathRemoveBlanks alias "PathRemoveBlanksA" (byval as LPSTR)
declare sub PathRemoveExtension alias "PathRemoveExtensionA" (byval as LPSTR)
declare function PathRemoveFileSpec alias "PathRemoveFileSpecA" (byval as LPSTR) as BOOL
declare function PathRenameExtension alias "PathRenameExtensionA" (byval as LPSTR, byval as LPCSTR) as BOOL
declare function PathSearchAndQualify alias "PathSearchAndQualifyA" (byval as LPCSTR, byval as LPSTR, byval as UINT) as BOOL
declare sub PathSetDlgItemPath alias "PathSetDlgItemPathA" (byval as HWND, byval as integer, byval as LPCSTR)
declare function PathSkipRoot alias "PathSkipRootA" (byval as LPCSTR) as LPSTR
declare sub PathStripPath alias "PathStripPathA" (byval as LPSTR)
declare function PathStripToRoot alias "PathStripToRootA" (byval as LPSTR) as BOOL
declare sub PathUndecorate alias "PathUndecorateA" (byval as LPSTR)
declare function PathUnExpandEnvStrings alias "PathUnExpandEnvStringsA" (byval as LPCSTR, byval as LPSTR, byval as UINT) as BOOL
declare function PathUnmakeSystemFolder alias "PathUnmakeSystemFolderA" (byval as LPSTR) as BOOL
declare sub PathUnquoteSpaces alias "PathUnquoteSpacesA" (byval as LPSTR)
declare function SHCreateStreamOnFile alias "SHCreateStreamOnFileA" (byval as LPCSTR, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare function SHOpenRegStream2 alias "SHOpenRegStream2A" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as IStream ptr
declare function SHOpenRegStream alias "SHOpenRegStreamA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as IStream ptr
declare function SHCopyKey alias "SHCopyKeyA" (byval as HKEY, byval as LPCSTR, byval as HKEY, byval as DWORD) as DWORD
declare function SHDeleteEmptyKey alias "SHDeleteEmptyKeyA" (byval as HKEY, byval as LPCSTR) as DWORD
declare function SHDeleteKey alias "SHDeleteKeyA" (byval as HKEY, byval as LPCSTR) as DWORD
declare function SHEnumKeyEx alias "SHEnumKeyExA" (byval as HKEY, byval as DWORD, byval as LPSTR, byval as LPDWORD) as DWORD
declare function SHQueryInfoKey alias "SHQueryInfoKeyA" (byval as HKEY, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function SHQueryValueEx alias "SHQueryValueExA" (byval as HKEY, byval as LPCSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHEnumValue alias "SHEnumValueA" (byval as HKEY, byval as DWORD, byval as LPSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHGetValue alias "SHGetValueA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD) as DWORD
declare function SHSetValue alias "SHSetValueA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPCVOID, byval as DWORD) as DWORD
declare function SHDeleteValue alias "SHDeleteValueA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR) as DWORD
declare function AssocQueryKey alias "AssocQueryKeyA" (byval as ASSOCF, byval as ASSOCKEY, byval as LPCSTR, byval as LPCSTR, byval as HKEY ptr) as HRESULT
declare function AssocQueryString alias "AssocQueryStringA" (byval as ASSOCF, byval as ASSOCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as DWORD ptr) as HRESULT
declare function AssocQueryStringByKey alias "AssocQueryStringByKeyA" (byval as ASSOCF, byval as ASSOCSTR, byval as HKEY, byval as LPCSTR, byval as LPSTR, byval as DWORD ptr) as HRESULT
declare function UrlApplyScheme alias "UrlApplySchemeA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCanonicalize alias "UrlCanonicalizeA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCombine alias "UrlCombineA" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlCompare alias "UrlCompareA" (byval as LPCSTR, byval as LPCSTR, byval as BOOL) as integer
declare function UrlCreateFromPath alias "UrlCreateFromPathA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlEscape alias "UrlEscapeA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function UrlGetLocation alias "UrlGetLocationA" (byval as LPCSTR) as LPCSTR
declare function UrlGetPart alias "UrlGetPartA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD, byval as DWORD) as HRESULT
declare function UrlHash alias "UrlHashA" (byval as LPCSTR, byval as LPBYTE, byval as DWORD) as HRESULT
declare function UrlIs alias "UrlIsA" (byval as LPCSTR, byval as URLIS_) as BOOL
declare function UrlIsNoHistory alias "UrlIsNoHistoryA" (byval as LPCSTR) as BOOL
declare function UrlIsOpaque alias "UrlIsOpaqueA" (byval as LPCSTR) as BOOL
declare function UrlUnescape alias "UrlUnescapeA" (byval as LPSTR, byval as LPSTR, byval as LPDWORD, byval as DWORD) as HRESULT
declare function SHRegCreateUSKey alias "SHRegCreateUSKeyA" (byval as LPCSTR, byval as REGSAM, byval as HUSKEY, byval as PHUSKEY, byval as DWORD) as LONG
declare function SHRegDeleteEmptyUSKey alias "SHRegDeleteEmptyUSKeyA" (byval as HUSKEY, byval as LPCSTR, byval as SHREGDEL_FLAGS) as LONG
declare function SHRegDeleteUSValue alias "SHRegDeleteUSValueA" (byval as HUSKEY, byval as LPCSTR, byval as SHREGDEL_FLAGS) as LONG
declare function SHRegEnumUSKey alias "SHRegEnumUSKeyA" (byval as HUSKEY, byval as DWORD, byval as LPSTR, byval as LPDWORD, byval as SHREGENUM_FLAGS) as DWORD
declare function SHRegEnumUSValue alias "SHRegEnumUSValueA" (byval as HUSKEY, byval as DWORD, byval as LPSTR, byval as LPDWORD, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as SHREGENUM_FLAGS) as DWORD
declare function SHRegGetBoolUSValue alias "SHRegGetBoolUSValueA" (byval as LPCSTR, byval as LPCSTR, byval as BOOL, byval as BOOL) as BOOL
declare function SHRegGetPath alias "SHRegGetPathA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function SHRegGetUSValue alias "SHRegGetUSValueA" (byval as LPCSTR, byval as LPCSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as BOOL, byval as LPVOID, byval as DWORD) as LONG
declare function SHRegOpenUSKey alias "SHRegOpenUSKeyA" (byval as LPCSTR, byval as REGSAM, byval as HUSKEY, byval as PHUSKEY, byval as BOOL) as LONG
declare function SHRegQueryInfoUSKey alias "SHRegQueryInfoUSKeyA" (byval as HUSKEY, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD) as DWORD
declare function SHRegQueryUSValue alias "SHRegQueryUSValueA" (byval as HUSKEY, byval as LPCSTR, byval as LPDWORD, byval as LPVOID, byval as LPDWORD, byval as BOOL, byval as LPVOID, byval as DWORD) as LONG
declare function SHRegSetPath alias "SHRegSetPathA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as DWORD) as DWORD
declare function SHRegSetUSValue alias "SHRegSetUSValueA" (byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as LONG
declare function SHRegWriteUSValue alias "SHRegWriteUSValueA" (byval as HUSKEY, byval as LPCSTR, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as LONG
declare function wnsprintf cdecl alias "wnsprintfA" (byval as LPSTR, byval as integer, byval as LPCSTR, ...) as integer
''''''' declare function wvnsprintf alias "wvnsprintfA" (byval as LPSTR, byval as integer, byval as LPCSTR, byval as va_list) as integer
declare function MLLoadLibrary alias "MLLoadLibraryA" (byval as LPCSTR, byval as HANDLE, byval as DWORD, byval as LPCSTR, byval as BOOL) as HINSTANCE
#endif ''UNICODE

#define UrlUnescapeInPlace(pszUrl,dwFlags ) UrlUnescape(pszUrl, NULL, NULL, dwFlags or URL_UNESCAPE_INPLACE)
#define UrlUnescapeInPlaceW(pszUrl,dwFlags ) UrlUnescapeW(pszUrl, NULL, NULL, dwFlags or URL_UNESCAPE_INPLACE)

#endif
