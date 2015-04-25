'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#inclib "shlwapi"

#include once "_mingw_unicode.bi"
#include once "objbase.bi"
#include once "shtypes.bi"
#include once "shlobj.bi"

extern "Windows"

#define _INC_SHLWAPI
declare function StrChrA(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrChrW(byval lpStart as LPCWSTR, byval wMatch as wchar_t) as LPWSTR
declare function StrChrIA(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrChrIW(byval lpStart as LPCWSTR, byval wMatch as wchar_t) as LPWSTR
declare function StrCmpNA(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
declare function StrCmpNW(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
declare function StrCmpNIA(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
declare function StrCmpNIW(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
declare function StrCSpnA(byval lpStr as LPCSTR, byval lpSet as LPCSTR) as long
declare function StrCSpnW(byval lpStr as LPCWSTR, byval lpSet as LPCWSTR) as long
declare function StrCSpnIA(byval lpStr as LPCSTR, byval lpSet as LPCSTR) as long
declare function StrCSpnIW(byval lpStr as LPCWSTR, byval lpSet as LPCWSTR) as long
declare function StrDupA(byval lpSrch as LPCSTR) as LPSTR
declare function StrDupW(byval lpSrch as LPCWSTR) as LPWSTR
declare function StrFormatByteSizeA(byval dw as DWORD, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
declare function StrFormatByteSize64A(byval qdw as LONGLONG, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
declare function StrFormatByteSizeW(byval qdw as LONGLONG, byval szBuf as LPWSTR, byval uiBufSize as UINT) as LPWSTR
declare function StrFormatKBSizeW(byval qdw as LONGLONG, byval szBuf as LPWSTR, byval uiBufSize as UINT) as LPWSTR
declare function StrFormatKBSizeA(byval qdw as LONGLONG, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
declare function StrFromTimeIntervalA(byval pszOut as LPSTR, byval cchMax as UINT, byval dwTimeMS as DWORD, byval digits as long) as long
declare function StrFromTimeIntervalW(byval pszOut as LPWSTR, byval cchMax as UINT, byval dwTimeMS as DWORD, byval digits as long) as long
declare function StrIsIntlEqualA(byval fCaseSens as WINBOOL, byval lpString1 as LPCSTR, byval lpString2 as LPCSTR, byval nChar as long) as WINBOOL
declare function StrIsIntlEqualW(byval fCaseSens as WINBOOL, byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR, byval nChar as long) as WINBOOL
declare function StrNCatA(byval psz1 as LPSTR, byval psz2 as LPCSTR, byval cchMax as long) as LPSTR
declare function StrNCatW(byval psz1 as LPWSTR, byval psz2 as LPCWSTR, byval cchMax as long) as LPWSTR
declare function StrPBrkA(byval psz as LPCSTR, byval pszSet as LPCSTR) as LPSTR
declare function StrPBrkW(byval psz as LPCWSTR, byval pszSet as LPCWSTR) as LPWSTR
declare function StrRChrA(byval lpStart as LPCSTR, byval lpEnd as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrRChrW(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as wchar_t) as LPWSTR
declare function StrRChrIA(byval lpStart as LPCSTR, byval lpEnd as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrRChrIW(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as wchar_t) as LPWSTR
declare function StrRStrIA(byval lpSource as LPCSTR, byval lpLast as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
declare function StrRStrIW(byval lpSource as LPCWSTR, byval lpLast as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
declare function StrSpnA(byval psz as LPCSTR, byval pszSet as LPCSTR) as long
declare function StrSpnW(byval psz as LPCWSTR, byval pszSet as LPCWSTR) as long
declare function StrStrA(byval lpFirst as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
declare function StrStrW(byval lpFirst as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
declare function StrStrIA(byval lpFirst as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
declare function StrStrIW(byval lpFirst as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
declare function StrToIntA(byval lpSrc as LPCSTR) as long
declare function StrToIntW(byval lpSrc as LPCWSTR) as long
declare function StrToIntExA(byval pszString as LPCSTR, byval dwFlags as DWORD, byval piRet as long ptr) as WINBOOL
declare function StrToIntExW(byval pszString as LPCWSTR, byval dwFlags as DWORD, byval piRet as long ptr) as WINBOOL

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	declare function StrToInt64ExA(byval pszString as LPCSTR, byval dwFlags as DWORD, byval pllRet as LONGLONG ptr) as WINBOOL
	declare function StrToInt64ExW(byval pszString as LPCWSTR, byval dwFlags as DWORD, byval pllRet as LONGLONG ptr) as WINBOOL
#endif

declare function StrTrimA(byval psz as LPSTR, byval pszTrimChars as LPCSTR) as WINBOOL
declare function StrTrimW(byval psz as LPWSTR, byval pszTrimChars as LPCWSTR) as WINBOOL
declare function StrCatW(byval psz1 as LPWSTR, byval psz2 as LPCWSTR) as LPWSTR
declare function StrCmpW(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
declare function StrCmpIW(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
declare function StrCpyW(byval psz1 as LPWSTR, byval psz2 as LPCWSTR) as LPWSTR
declare function StrCpyNW(byval psz1 as LPWSTR, byval psz2 as LPCWSTR, byval cchMax as long) as LPWSTR
declare function StrCatBuffW(byval pszDest as LPWSTR, byval pszSrc as LPCWSTR, byval cchDestBuffSize as long) as LPWSTR
declare function StrCatBuffA(byval pszDest as LPSTR, byval pszSrc as LPCSTR, byval cchDestBuffSize as long) as LPSTR
declare function ChrCmpIA(byval w1 as WORD, byval w2 as WORD) as WINBOOL
declare function ChrCmpIW(byval w1 as wchar_t, byval w2 as wchar_t) as WINBOOL
declare function wvnsprintfA(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, byval arglist as va_list) as long
declare function wvnsprintfW(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, byval arglist as va_list) as long
declare function wnsprintfA cdecl(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, ...) as long
declare function wnsprintfW cdecl(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, ...) as long

#define StrIntlEqNA(s1, s2, nChar) StrIsIntlEqualA(TRUE, s1, s2, nChar)
#define StrIntlEqNW(s1, s2, nChar) StrIsIntlEqualW(TRUE, s1, s2, nChar)
#define StrIntlEqNIA(s1, s2, nChar) StrIsIntlEqualA(FALSE, s1, s2, nChar)
#define StrIntlEqNIW(s1, s2, nChar) StrIsIntlEqualW(FALSE, s1, s2, nChar)

#ifdef UNICODE
	#define StrRetToStr StrRetToStrW
	#define StrRetToBuf StrRetToBufW
	#define SHStrDup SHStrDupW
#else
	#define StrRetToStr StrRetToStrA
	#define StrRetToBuf StrRetToBufA
	#define SHStrDup SHStrDupA
#endif

declare function StrRetToStrA(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPSTR ptr) as HRESULT
declare function StrRetToStrW(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPWSTR ptr) as HRESULT
declare function StrRetToBufA(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPSTR, byval cchBuf as UINT) as HRESULT
declare function StrRetToBufW(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPWSTR, byval cchBuf as UINT) as HRESULT
declare function StrRetToBSTR(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pbstr as BSTR ptr) as HRESULT
declare function SHStrDupA(byval psz as LPCSTR, byval ppwsz as wstring ptr ptr) as HRESULT
declare function SHStrDupW(byval psz as LPCWSTR, byval ppwsz as wstring ptr ptr) as HRESULT
declare function StrCmpLogicalW(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
declare function StrCatChainW(byval pszDst as LPWSTR, byval cchDst as DWORD, byval ichAt as DWORD, byval pszSrc as LPCWSTR) as DWORD
declare function SHLoadIndirectString(byval pszSource as LPCWSTR, byval pszOutBuf as LPWSTR, byval cchOutBuf as UINT, byval ppvReserved as any ptr ptr) as HRESULT

#if _WIN32_WINNT = &h0602
	declare function IsCharSpaceA(byval wch as byte) as WINBOOL
	declare function IsCharSpaceW(byval wch as wchar_t) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define IsCharSpace IsCharSpaceW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define IsCharSpace IsCharSpaceA
#endif

#if _WIN32_WINNT = &h0602
	declare function StrCmpCA(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
	declare function StrCmpCW(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define StrCmpC StrCmpCW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define StrCmpC StrCmpCA
#endif

#if _WIN32_WINNT = &h0602
	declare function StrCmpICA(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
	declare function StrCmpICW(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define StrCmpIC StrCmpICW
#endif

#ifdef UNICODE
	#define StrChr StrChrW
	#define StrRChr StrRChrW
	#define StrChrI StrChrIW
	#define StrRChrI StrRChrIW
	#define StrCmpN StrCmpNW
	#define StrCmpNI StrCmpNIW
	#define StrStr StrStrW
	#define StrStrI StrStrIW
	#define StrDup StrDupW
	#define StrRStrI StrRStrIW
	#define StrCSpn StrCSpnW
	#define StrCSpnI StrCSpnIW
	#define StrSpn StrSpnW
	#define StrToInt StrToIntW
	#define StrPBrk StrPBrkW
	#define StrToIntEx StrToIntExW
#endif

#if defined(UNICODE) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define StrToInt64Ex StrToInt64ExW
#endif

#ifdef UNICODE
	#define StrFromTimeInterval StrFromTimeIntervalW
	#define StrIntlEqN StrIntlEqNW
	#define StrIntlEqNI StrIntlEqNIW
	#define StrFormatByteSize StrFormatByteSizeW
	#define StrFormatKBSize StrFormatKBSizeW
	#define StrTrim StrTrimW
	#define ChrCmpI ChrCmpIW
	#define wvnsprintf wvnsprintfW
	#define wnsprintf wnsprintfW
	#define StrIsIntlEqual StrIsIntlEqualW
	#define StrFormatByteSize64 StrFormatByteSizeW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define StrCmpIC StrCmpICA
#endif

#ifndef UNICODE
	#define StrChr StrChrA
	#define StrRChr StrRChrA
	#define StrChrI StrChrIA
	#define StrRChrI StrRChrIA
	#define StrCmpN StrCmpNA
	#define StrCmpNI StrCmpNIA
	#define StrStr StrStrA
	#define StrStrI StrStrIA
	#define StrDup StrDupA
	#define StrRStrI StrRStrIA
	#define StrCSpn StrCSpnA
	#define StrCSpnI StrCSpnIA
	#define StrSpn StrSpnA
	#define StrToInt StrToIntA
	#define StrPBrk StrPBrkA
	#define StrToIntEx StrToIntExA
#endif

#if (not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define StrToInt64Ex StrToInt64ExA
#endif

#ifndef UNICODE
	#define StrFromTimeInterval StrFromTimeIntervalA
	#define StrIntlEqN StrIntlEqNA
	#define StrIntlEqNI StrIntlEqNIA
	#define StrFormatByteSize StrFormatByteSizeA
	#define StrFormatKBSize StrFormatKBSizeA
	#define StrTrim StrTrimA
	#define ChrCmpI ChrCmpIA
	#define wvnsprintf wvnsprintfA
	#define wnsprintf wnsprintfA
	#define StrIsIntlEqual StrIsIntlEqualA
	#define StrFormatByteSize64 StrFormatByteSize64A
#endif

declare function IntlStrEqWorkerA(byval fCaseSens as WINBOOL, byval lpString1 as LPCSTR, byval lpString2 as LPCSTR, byval nChar as long) as WINBOOL
declare function IntlStrEqWorkerW(byval fCaseSens as WINBOOL, byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR, byval nChar as long) as WINBOOL
#define IntlStrEqNA(s1, s2, nChar) IntlStrEqWorkerA(TRUE, s1, s2, nChar)
#define IntlStrEqNW(s1, s2, nChar) IntlStrEqWorkerW(TRUE, s1, s2, nChar)
#define IntlStrEqNIA(s1, s2, nChar) IntlStrEqWorkerA(FALSE, s1, s2, nChar)
#define IntlStrEqNIW(s1, s2, nChar) IntlStrEqWorkerW(FALSE, s1, s2, nChar)

#ifdef UNICODE
	#define IntlStrEqN IntlStrEqNW
	#define IntlStrEqNI IntlStrEqNIW
#else
	#define IntlStrEqN IntlStrEqNA
	#define IntlStrEqNI IntlStrEqNIA
#endif

#define SZ_CONTENTTYPE_HTMLA "text/html"
#define SZ_CONTENTTYPE_HTMLW wstr("text/html")
#define SZ_CONTENTTYPE_CDFA "application/x-cdf"
#define SZ_CONTENTTYPE_CDFW wstr("application/x-cdf")

#ifdef UNICODE
	#define SZ_CONTENTTYPE_HTML SZ_CONTENTTYPE_HTMLW
	#define SZ_CONTENTTYPE_CDF SZ_CONTENTTYPE_CDFW
#else
	#define SZ_CONTENTTYPE_HTML SZ_CONTENTTYPE_HTMLA
	#define SZ_CONTENTTYPE_CDF SZ_CONTENTTYPE_CDFA
#endif

#define PathIsHTMLFileA(pszPath) PathIsContentTypeA(pszPath, SZ_CONTENTTYPE_HTMLA)
#define PathIsHTMLFileW(pszPath) PathIsContentTypeW(pszPath, SZ_CONTENTTYPE_HTMLW)
#define STIF_DEFAULT __MSABI_LONG(&h00000000)
#define STIF_SUPPORT_HEX __MSABI_LONG(&h00000001)
#define StrCmpA lstrcmpA
#define StrCmpIA lstrcmpiA
#define StrCpyNA lstrcpynA
#define StrToLong StrToInt
#define StrNCmp StrCmpN
#define StrNCmpI StrCmpNI
#define StrNCpy StrCpyN

#ifdef UNICODE
	#define StrCatBuff StrCatBuffW
	#define StrCmp StrCmpW
	#define StrCmpI StrCmpIW
	#define StrCpyN StrCpyNW
#else
	#define StrCatBuff StrCatBuffA
	#define StrCmp lstrcmpA
	#define StrCmpI lstrcmpiA
	#define StrCpyN lstrcpynA
#endif

declare function PathAddBackslashA(byval pszPath as LPSTR) as LPSTR
declare function PathAddBackslashW(byval pszPath as LPWSTR) as LPWSTR

#ifdef UNICODE
	#define PathAddBackslash PathAddBackslashW
#else
	#define PathAddBackslash PathAddBackslashA
#endif

declare function PathAddExtensionA(byval pszPath as LPSTR, byval pszExt as LPCSTR) as WINBOOL
declare function PathAddExtensionW(byval pszPath as LPWSTR, byval pszExt as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathAddExtension PathAddExtensionW
#else
	#define PathAddExtension PathAddExtensionA
#endif

declare function PathAppendA(byval pszPath as LPSTR, byval pMore as LPCSTR) as WINBOOL
declare function PathAppendW(byval pszPath as LPWSTR, byval pMore as LPCWSTR) as WINBOOL
declare function PathBuildRootA(byval pszRoot as LPSTR, byval iDrive as long) as LPSTR
declare function PathBuildRootW(byval pszRoot as LPWSTR, byval iDrive as long) as LPWSTR

#ifdef UNICODE
	#define PathBuildRoot PathBuildRootW
#else
	#define PathBuildRoot PathBuildRootA
#endif

declare function PathCanonicalizeA(byval pszBuf as LPSTR, byval pszPath as LPCSTR) as WINBOOL
declare function PathCanonicalizeW(byval pszBuf as LPWSTR, byval pszPath as LPCWSTR) as WINBOOL
declare function PathCombineA(byval pszDest as LPSTR, byval pszDir as LPCSTR, byval pszFile as LPCSTR) as LPSTR
declare function PathCombineW(byval pszDest as LPWSTR, byval pszDir as LPCWSTR, byval pszFile as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathCombine PathCombineW
#else
	#define PathCombine PathCombineA
#endif

declare function PathCompactPathA(byval hDC as HDC, byval pszPath as LPSTR, byval dx as UINT) as WINBOOL
declare function PathCompactPathW(byval hDC as HDC, byval pszPath as LPWSTR, byval dx as UINT) as WINBOOL
declare function PathCompactPathExA(byval pszOut as LPSTR, byval pszSrc as LPCSTR, byval cchMax as UINT, byval dwFlags as DWORD) as WINBOOL
declare function PathCompactPathExW(byval pszOut as LPWSTR, byval pszSrc as LPCWSTR, byval cchMax as UINT, byval dwFlags as DWORD) as WINBOOL
declare function PathCommonPrefixA(byval pszFile1 as LPCSTR, byval pszFile2 as LPCSTR, byval achPath as LPSTR) as long
declare function PathCommonPrefixW(byval pszFile1 as LPCWSTR, byval pszFile2 as LPCWSTR, byval achPath as LPWSTR) as long
declare function PathFileExistsA(byval pszPath as LPCSTR) as WINBOOL
declare function PathFileExistsW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathFileExists PathFileExistsW
#else
	#define PathFileExists PathFileExistsA
#endif

declare function PathFindExtensionA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindExtensionW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathFindExtension PathFindExtensionW
#else
	#define PathFindExtension PathFindExtensionA
#endif

declare function PathFindFileNameA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindFileNameW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathFindFileName PathFindFileNameW
#else
	#define PathFindFileName PathFindFileNameA
#endif

declare function PathFindNextComponentA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindNextComponentW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathFindNextComponent PathFindNextComponentW
#else
	#define PathFindNextComponent PathFindNextComponentA
#endif

declare function PathFindOnPathA(byval pszPath as LPSTR, byval ppszOtherDirs as LPCSTR ptr) as WINBOOL
declare function PathFindOnPathW(byval pszPath as LPWSTR, byval ppszOtherDirs as LPCWSTR ptr) as WINBOOL
declare function PathGetArgsA(byval pszPath as LPCSTR) as LPSTR
declare function PathGetArgsW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathGetArgs PathGetArgsW
#else
	#define PathGetArgs PathGetArgsA
#endif

declare function PathFindSuffixArrayA(byval pszPath as LPCSTR, byval apszSuffix as const LPCSTR ptr, byval iArraySize as long) as LPCSTR
declare function PathFindSuffixArrayW(byval pszPath as LPCWSTR, byval apszSuffix as const LPCWSTR ptr, byval iArraySize as long) as LPCWSTR

#ifdef UNICODE
	#define PathFindSuffixArray PathFindSuffixArrayW
#else
	#define PathFindSuffixArray PathFindSuffixArrayA
#endif

declare function PathIsLFNFileSpecA(byval lpName as LPCSTR) as WINBOOL
declare function PathIsLFNFileSpecW(byval lpName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsLFNFileSpec PathIsLFNFileSpecW
#else
	#define PathIsLFNFileSpec PathIsLFNFileSpecA
#endif

declare function PathGetCharTypeA(byval ch as UCHAR) as UINT
declare function PathGetCharTypeW(byval ch as wchar_t) as UINT
const GCT_INVALID = &h0000
const GCT_LFNCHAR = &h0001
const GCT_SHORTCHAR = &h0002
const GCT_WILD = &h0004
const GCT_SEPARATOR = &h0008
declare function PathGetDriveNumberA(byval pszPath as LPCSTR) as long
declare function PathGetDriveNumberW(byval pszPath as LPCWSTR) as long

#ifdef UNICODE
	#define PathGetDriveNumber PathGetDriveNumberW
#else
	#define PathGetDriveNumber PathGetDriveNumberA
#endif

declare function PathIsDirectoryA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsDirectoryW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsDirectory PathIsDirectoryW
#else
	#define PathIsDirectory PathIsDirectoryA
#endif

declare function PathIsDirectoryEmptyA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsDirectoryEmptyW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsDirectoryEmpty PathIsDirectoryEmptyW
#else
	#define PathIsDirectoryEmpty PathIsDirectoryEmptyA
#endif

declare function PathIsFileSpecA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsFileSpecW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsFileSpec PathIsFileSpecW
#else
	#define PathIsFileSpec PathIsFileSpecA
#endif

declare function PathIsPrefixA(byval pszPrefix as LPCSTR, byval pszPath as LPCSTR) as WINBOOL
declare function PathIsPrefixW(byval pszPrefix as LPCWSTR, byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsPrefix PathIsPrefixW
#else
	#define PathIsPrefix PathIsPrefixA
#endif

declare function PathIsRelativeA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsRelativeW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsRelative PathIsRelativeW
#else
	#define PathIsRelative PathIsRelativeA
#endif

declare function PathIsRootA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsRootW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsRoot PathIsRootW
#else
	#define PathIsRoot PathIsRootA
#endif

declare function PathIsSameRootA(byval pszPath1 as LPCSTR, byval pszPath2 as LPCSTR) as WINBOOL
declare function PathIsSameRootW(byval pszPath1 as LPCWSTR, byval pszPath2 as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsSameRoot PathIsSameRootW
#else
	#define PathIsSameRoot PathIsSameRootA
#endif

declare function PathIsUNCA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsUNC PathIsUNCW
#else
	#define PathIsUNC PathIsUNCA
#endif

declare function PathIsNetworkPathA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsNetworkPathW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsNetworkPath PathIsNetworkPathW
#else
	#define PathIsNetworkPath PathIsNetworkPathA
#endif

declare function PathIsUNCServerA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCServerW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsUNCServer PathIsUNCServerW
#else
	#define PathIsUNCServer PathIsUNCServerA
#endif

declare function PathIsUNCServerShareA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCServerShareW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsUNCServerShare PathIsUNCServerShareW
#else
	#define PathIsUNCServerShare PathIsUNCServerShareA
#endif

declare function PathIsContentTypeA(byval pszPath as LPCSTR, byval pszContentType as LPCSTR) as WINBOOL
declare function PathIsContentTypeW(byval pszPath as LPCWSTR, byval pszContentType as LPCWSTR) as WINBOOL
declare function PathIsURLA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsURLW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathIsURL PathIsURLW
#else
	#define PathIsURL PathIsURLA
#endif

declare function PathMakePrettyA(byval pszPath as LPSTR) as WINBOOL
declare function PathMakePrettyW(byval pszPath as LPWSTR) as WINBOOL
declare function PathMatchSpecA(byval pszFile as LPCSTR, byval pszSpec as LPCSTR) as WINBOOL
declare function PathMatchSpecW(byval pszFile as LPCWSTR, byval pszSpec as LPCWSTR) as WINBOOL
declare function PathParseIconLocationA(byval pszIconFile as LPSTR) as long
declare function PathParseIconLocationW(byval pszIconFile as LPWSTR) as long
declare sub PathQuoteSpacesA(byval lpsz as LPSTR)
declare sub PathQuoteSpacesW(byval lpsz as LPWSTR)
declare function PathRelativePathToA(byval pszPath as LPSTR, byval pszFrom as LPCSTR, byval dwAttrFrom as DWORD, byval pszTo as LPCSTR, byval dwAttrTo as DWORD) as WINBOOL
declare function PathRelativePathToW(byval pszPath as LPWSTR, byval pszFrom as LPCWSTR, byval dwAttrFrom as DWORD, byval pszTo as LPCWSTR, byval dwAttrTo as DWORD) as WINBOOL
declare sub PathRemoveArgsA(byval pszPath as LPSTR)
declare sub PathRemoveArgsW(byval pszPath as LPWSTR)
declare function PathRemoveBackslashA(byval pszPath as LPSTR) as LPSTR
declare function PathRemoveBackslashW(byval pszPath as LPWSTR) as LPWSTR

#ifdef UNICODE
	#define PathRemoveBackslash PathRemoveBackslashW
#else
	#define PathRemoveBackslash PathRemoveBackslashA
#endif

declare sub PathRemoveBlanksA(byval pszPath as LPSTR)
declare sub PathRemoveBlanksW(byval pszPath as LPWSTR)
declare sub PathRemoveExtensionA(byval pszPath as LPSTR)
declare sub PathRemoveExtensionW(byval pszPath as LPWSTR)
declare function PathRemoveFileSpecA(byval pszPath as LPSTR) as WINBOOL
declare function PathRemoveFileSpecW(byval pszPath as LPWSTR) as WINBOOL
declare function PathRenameExtensionA(byval pszPath as LPSTR, byval pszExt as LPCSTR) as WINBOOL
declare function PathRenameExtensionW(byval pszPath as LPWSTR, byval pszExt as LPCWSTR) as WINBOOL
declare function PathSearchAndQualifyA(byval pszPath as LPCSTR, byval pszBuf as LPSTR, byval cchBuf as UINT) as WINBOOL
declare function PathSearchAndQualifyW(byval pszPath as LPCWSTR, byval pszBuf as LPWSTR, byval cchBuf as UINT) as WINBOOL
declare sub PathSetDlgItemPathA(byval hDlg as HWND, byval id as long, byval pszPath as LPCSTR)
declare sub PathSetDlgItemPathW(byval hDlg as HWND, byval id as long, byval pszPath as LPCWSTR)
declare function PathSkipRootA(byval pszPath as LPCSTR) as LPSTR
declare function PathSkipRootW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	#define PathSkipRoot PathSkipRootW
#else
	#define PathSkipRoot PathSkipRootA
#endif

declare sub PathStripPathA(byval pszPath as LPSTR)
declare sub PathStripPathW(byval pszPath as LPWSTR)

#ifdef UNICODE
	#define PathStripPath PathStripPathW
#else
	#define PathStripPath PathStripPathA
#endif

declare function PathStripToRootA(byval pszPath as LPSTR) as WINBOOL
declare function PathStripToRootW(byval pszPath as LPWSTR) as WINBOOL

#ifdef UNICODE
	#define PathStripToRoot PathStripToRootW
#else
	#define PathStripToRoot PathStripToRootA
#endif

declare sub PathUnquoteSpacesA(byval lpsz as LPSTR)
declare sub PathUnquoteSpacesW(byval lpsz as LPWSTR)
declare function PathMakeSystemFolderA(byval pszPath as LPCSTR) as WINBOOL
declare function PathMakeSystemFolderW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathMakeSystemFolder PathMakeSystemFolderW
#else
	#define PathMakeSystemFolder PathMakeSystemFolderA
#endif

declare function PathUnmakeSystemFolderA(byval pszPath as LPCSTR) as WINBOOL
declare function PathUnmakeSystemFolderW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define PathUnmakeSystemFolder PathUnmakeSystemFolderW
#else
	#define PathUnmakeSystemFolder PathUnmakeSystemFolderA
#endif

declare function PathIsSystemFolderA(byval pszPath as LPCSTR, byval dwAttrb as DWORD) as WINBOOL
declare function PathIsSystemFolderW(byval pszPath as LPCWSTR, byval dwAttrb as DWORD) as WINBOOL

#ifdef UNICODE
	#define PathIsSystemFolder PathIsSystemFolderW
#else
	#define PathIsSystemFolder PathIsSystemFolderA
#endif

declare sub PathUndecorateA(byval pszPath as LPSTR)
declare sub PathUndecorateW(byval pszPath as LPWSTR)

#ifdef UNICODE
	#define PathUndecorate PathUndecorateW
#else
	#define PathUndecorate PathUndecorateA
#endif

declare function PathUnExpandEnvStringsA(byval pszPath as LPCSTR, byval pszBuf as LPSTR, byval cchBuf as UINT) as WINBOOL
declare function PathUnExpandEnvStringsW(byval pszPath as LPCWSTR, byval pszBuf as LPWSTR, byval cchBuf as UINT) as WINBOOL

#ifdef UNICODE
	#define PathUnExpandEnvStrings PathUnExpandEnvStringsW
	#define PathAppend PathAppendW
	#define PathCanonicalize PathCanonicalizeW
	#define PathCompactPath PathCompactPathW
	#define PathCompactPathEx PathCompactPathExW
	#define PathCommonPrefix PathCommonPrefixW
	#define PathFindOnPath PathFindOnPathW
	#define PathGetCharType PathGetCharTypeW
	#define PathIsContentType PathIsContentTypeW
	#define PathIsHTMLFile PathIsHTMLFileW
	#define PathMakePretty PathMakePrettyW
	#define PathMatchSpec PathMatchSpecW
	#define PathParseIconLocation PathParseIconLocationW
	#define PathQuoteSpaces PathQuoteSpacesW
	#define PathRelativePathTo PathRelativePathToW
	#define PathRemoveArgs PathRemoveArgsW
	#define PathRemoveBlanks PathRemoveBlanksW
	#define PathRemoveExtension PathRemoveExtensionW
	#define PathRemoveFileSpec PathRemoveFileSpecW
	#define PathRenameExtension PathRenameExtensionW
	#define PathSearchAndQualify PathSearchAndQualifyW
	#define PathSetDlgItemPath PathSetDlgItemPathW
	#define PathUnquoteSpaces PathUnquoteSpacesW
#else
	#define PathUnExpandEnvStrings PathUnExpandEnvStringsA
	#define PathAppend PathAppendA
	#define PathCanonicalize PathCanonicalizeA
	#define PathCompactPath PathCompactPathA
	#define PathCompactPathEx PathCompactPathExA
	#define PathCommonPrefix PathCommonPrefixA
	#define PathFindOnPath PathFindOnPathA
	#define PathGetCharType PathGetCharTypeA
	#define PathIsContentType PathIsContentTypeA
	#define PathIsHTMLFile PathIsHTMLFileA
	#define PathMakePretty PathMakePrettyA
	#define PathMatchSpec PathMatchSpecA
	#define PathParseIconLocation PathParseIconLocationA
	#define PathQuoteSpaces PathQuoteSpacesA
	#define PathRelativePathTo PathRelativePathToA
	#define PathRemoveArgs PathRemoveArgsA
	#define PathRemoveBlanks PathRemoveBlanksA
	#define PathRemoveExtension PathRemoveExtensionA
	#define PathRemoveFileSpec PathRemoveFileSpecA
	#define PathRenameExtension PathRenameExtensionA
	#define PathSearchAndQualify PathSearchAndQualifyA
	#define PathSetDlgItemPath PathSetDlgItemPathA
	#define PathUnquoteSpaces PathUnquoteSpacesA
#endif

type URL_SCHEME as long
enum
	URL_SCHEME_INVALID = -1
	URL_SCHEME_UNKNOWN = 0
	URL_SCHEME_FTP
	URL_SCHEME_HTTP
	URL_SCHEME_GOPHER
	URL_SCHEME_MAILTO
	URL_SCHEME_NEWS
	URL_SCHEME_NNTP
	URL_SCHEME_TELNET
	URL_SCHEME_WAIS
	URL_SCHEME_FILE
	URL_SCHEME_MK
	URL_SCHEME_HTTPS
	URL_SCHEME_SHELL
	URL_SCHEME_SNEWS
	URL_SCHEME_LOCAL
	URL_SCHEME_JAVASCRIPT
	URL_SCHEME_VBSCRIPT
	URL_SCHEME_ABOUT
	URL_SCHEME_RES
	URL_SCHEME_MSSHELLROOTED
	URL_SCHEME_MSSHELLIDLIST
	URL_SCHEME_MSHELP
	URL_SCHEME_MAXVALUE
end enum

type URL_PART as long
enum
	URL_PART_NONE = 0
	URL_PART_SCHEME = 1
	URL_PART_HOSTNAME
	URL_PART_USERNAME
	URL_PART_PASSWORD
	URL_PART_PORT
	URL_PART_QUERY
end enum

type URLIS as long
enum
	URLIS_URL
	URLIS_OPAQUE
	URLIS_NOHISTORY
	URLIS_FILEURL
	URLIS_APPLIABLE
	URLIS_DIRECTORY
	URLIS_HASQUERY
end enum

const URL_UNESCAPE = &h10000000
const URL_ESCAPE_UNSAFE = &h20000000
const URL_PLUGGABLE_PROTOCOL = &h40000000
const URL_WININET_COMPATIBILITY = &h80000000
const URL_DONT_ESCAPE_EXTRA_INFO = &h02000000
#define URL_DONT_UNESCAPE_EXTRA_INFO URL_DONT_ESCAPE_EXTRA_INFO
#define URL_BROWSER_MODE URL_DONT_ESCAPE_EXTRA_INFO
const URL_ESCAPE_SPACES_ONLY = &h04000000
const URL_DONT_SIMPLIFY = &h08000000
#define URL_NO_META URL_DONT_SIMPLIFY
const URL_UNESCAPE_INPLACE = &h00100000
const URL_CONVERT_IF_DOSPATH = &h00200000
const URL_UNESCAPE_HIGH_ANSI_ONLY = &h00400000
const URL_INTERNAL_PATH = &h00800000
const URL_FILE_USE_PATHURL = &h00010000
const URL_DONT_UNESCAPE = &h00020000
const URL_ESCAPE_PERCENT = &h00001000
const URL_ESCAPE_SEGMENT_ONLY = &h00002000
const URL_PARTFLAG_KEEPSCHEME = &h00000001
const URL_APPLY_DEFAULT = &h00000001
const URL_APPLY_GUESSSCHEME = &h00000002
const URL_APPLY_GUESSFILE = &h00000004
const URL_APPLY_FORCEAPPLY = &h00000008

declare function UrlCompareA(byval psz1 as LPCSTR, byval psz2 as LPCSTR, byval fIgnoreSlash as WINBOOL) as long
declare function UrlCompareW(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR, byval fIgnoreSlash as WINBOOL) as long
declare function UrlCombineA(byval pszBase as LPCSTR, byval pszRelative as LPCSTR, byval pszCombined as LPSTR, byval pcchCombined as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlCombineW(byval pszBase as LPCWSTR, byval pszRelative as LPCWSTR, byval pszCombined as LPWSTR, byval pcchCombined as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlCanonicalizeA(byval pszUrl as LPCSTR, byval pszCanonicalized as LPSTR, byval pcchCanonicalized as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlCanonicalizeW(byval pszUrl as LPCWSTR, byval pszCanonicalized as LPWSTR, byval pcchCanonicalized as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlIsOpaqueA(byval pszURL as LPCSTR) as WINBOOL
declare function UrlIsOpaqueW(byval pszURL as LPCWSTR) as WINBOOL
declare function UrlIsNoHistoryA(byval pszURL as LPCSTR) as WINBOOL
declare function UrlIsNoHistoryW(byval pszURL as LPCWSTR) as WINBOOL
#define UrlIsFileUrlA(pszURL) UrlIsA(pszURL, URLIS_FILEURL)
#define UrlIsFileUrlW(pszURL) UrlIsW(pszURL, URLIS_FILEURL)
declare function UrlIsA(byval pszUrl as LPCSTR, byval UrlIs as URLIS) as WINBOOL
declare function UrlIsW(byval pszUrl as LPCWSTR, byval UrlIs as URLIS) as WINBOOL
declare function UrlGetLocationA(byval psz1 as LPCSTR) as LPCSTR
declare function UrlGetLocationW(byval psz1 as LPCWSTR) as LPCWSTR
declare function UrlUnescapeA(byval pszUrl as LPSTR, byval pszUnescaped as LPSTR, byval pcchUnescaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlUnescapeW(byval pszUrl as LPWSTR, byval pszUnescaped as LPWSTR, byval pcchUnescaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlEscapeA(byval pszUrl as LPCSTR, byval pszEscaped as LPSTR, byval pcchEscaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlEscapeW(byval pszUrl as LPCWSTR, byval pszEscaped as LPWSTR, byval pcchEscaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlCreateFromPathA(byval pszPath as LPCSTR, byval pszUrl as LPSTR, byval pcchUrl as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlCreateFromPathW(byval pszPath as LPCWSTR, byval pszUrl as LPWSTR, byval pcchUrl as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function PathCreateFromUrlA(byval pszUrl as LPCSTR, byval pszPath as LPSTR, byval pcchPath as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function PathCreateFromUrlW(byval pszUrl as LPCWSTR, byval pszPath as LPWSTR, byval pcchPath as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlHashA(byval pszUrl as LPCSTR, byval pbHash as LPBYTE, byval cbHash as DWORD) as HRESULT
declare function UrlHashW(byval pszUrl as LPCWSTR, byval pbHash as LPBYTE, byval cbHash as DWORD) as HRESULT
declare function UrlGetPartW(byval pszIn as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as LPDWORD, byval dwPart as DWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlGetPartA(byval pszIn as LPCSTR, byval pszOut as LPSTR, byval pcchOut as LPDWORD, byval dwPart as DWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlApplySchemeA(byval pszIn as LPCSTR, byval pszOut as LPSTR, byval pcchOut as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function UrlApplySchemeW(byval pszIn as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as LPDWORD, byval dwFlags as DWORD) as HRESULT
declare function HashData(byval pbData as LPBYTE, byval cbData as DWORD, byval pbHash as LPBYTE, byval cbHash as DWORD) as HRESULT

#ifdef UNICODE
	#define UrlCompare UrlCompareW
	#define UrlCombine UrlCombineW
	#define UrlCanonicalize UrlCanonicalizeW
	#define UrlIsOpaque UrlIsOpaqueW
	#define UrlIsFileUrl UrlIsFileUrlW
	#define UrlGetLocation UrlGetLocationW
	#define UrlUnescape UrlUnescapeW
	#define UrlEscape UrlEscapeW
	#define UrlCreateFromPath UrlCreateFromPathW
	#define PathCreateFromUrl PathCreateFromUrlW
	#define UrlHash UrlHashW
	#define UrlGetPart UrlGetPartW
	#define UrlApplyScheme UrlApplySchemeW
	declare function UrlIs alias "UrlIsW"(byval pszUrl as LPCWSTR, byval UrlIs as URLIS) as WINBOOL
#else
	#define UrlCompare UrlCompareA
	#define UrlCombine UrlCombineA
	#define UrlCanonicalize UrlCanonicalizeA
	#define UrlIsOpaque UrlIsOpaqueA
	#define UrlIsFileUrl UrlIsFileUrlA
	#define UrlGetLocation UrlGetLocationA
	#define UrlUnescape UrlUnescapeA
	#define UrlEscape UrlEscapeA
	#define UrlCreateFromPath UrlCreateFromPathA
	#define PathCreateFromUrl PathCreateFromUrlA
	#define UrlHash UrlHashA
	#define UrlGetPart UrlGetPartA
	#define UrlApplyScheme UrlApplySchemeA
	declare function UrlIs alias "UrlIsA"(byval pszUrl as LPCSTR, byval UrlIs as URLIS) as WINBOOL
#endif

#define UrlEscapeSpaces(pszUrl, pszEscaped, pcchEscaped) UrlCanonicalize(pszUrl, pszEscaped, pcchEscaped, URL_ESCAPE_SPACES_ONLY or URL_DONT_ESCAPE_EXTRA_INFO)
#define UrlUnescapeInPlace(pszUrl, dwFlags) UrlUnescape(pszUrl, NULL, NULL, dwFlags or URL_UNESCAPE_INPLACE)
declare function SHDeleteEmptyKeyA(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
declare function SHDeleteEmptyKeyW(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD

#ifdef UNICODE
	#define SHDeleteEmptyKey SHDeleteEmptyKeyW
#else
	#define SHDeleteEmptyKey SHDeleteEmptyKeyA
#endif

declare function SHDeleteKeyA(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
declare function SHDeleteKeyW(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD

#ifdef UNICODE
	#define SHDeleteKey SHDeleteKeyW
#else
	#define SHDeleteKey SHDeleteKeyA
#endif

declare function SHRegDuplicateHKey(byval hkey as HKEY) as HKEY
declare function SHDeleteValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR) as DWORD
declare function SHDeleteValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR) as DWORD

#ifdef UNICODE
	#define SHDeleteValue SHDeleteValueW
#else
	#define SHDeleteValue SHDeleteValueA
#endif

declare function SHGetValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
declare function SHGetValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD

#ifdef UNICODE
	#define SHGetValue SHGetValueW
#else
	#define SHGetValue SHGetValueA
#endif

declare function SHSetValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD
declare function SHSetValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD

#ifdef UNICODE
	#define SHSetValue SHSetValueW
#elseif (not defined(UNICODE)) and ((not defined(__FB_64BIT__)) or (defined(__FB_64BIT__) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))))
	#define SHSetValue SHSetValueA
#endif

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	type SRRF as DWORD
	const SRRF_RT_REG_NONE = &h00000001
	const SRRF_RT_REG_SZ = &h00000002
	const SRRF_RT_REG_EXPAND_SZ = &h00000004
	const SRRF_RT_REG_BINARY = &h00000008
	const SRRF_RT_REG_DWORD = &h00000010
	const SRRF_RT_REG_MULTI_SZ = &h00000020
	const SRRF_RT_REG_QWORD = &h00000040
	#define SRRF_RT_DWORD (SRRF_RT_REG_BINARY or SRRF_RT_REG_DWORD)
	#define SRRF_RT_QWORD (SRRF_RT_REG_BINARY or SRRF_RT_REG_QWORD)
	const SRRF_RT_ANY = &h0000ffff
	const SRRF_RM_ANY = &h00000000
	const SRRF_RM_NORMAL = &h00010000
	const SRRF_RM_SAFE = &h00020000
	const SRRF_RM_SAFENETWORK = &h00040000
	const SRRF_NOEXPAND = &h10000000
	const SRRF_ZEROONFAILURE = &h20000000
	declare function SHRegGetValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwFlags as SRRF, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as LONG
	declare function SHRegGetValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval dwFlags as SRRF, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as LONG
#endif

#if defined(UNICODE) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define SHRegGetValue SHRegGetValueW
#endif

#ifdef UNICODE
	#define SHQueryValueEx SHQueryValueExW
	#define SHEnumKeyEx SHEnumKeyExW
	#define SHEnumValue SHEnumValueW
	#define SHQueryInfoKey SHQueryInfoKeyW
	#define SHCopyKey SHCopyKeyW
	#define SHRegGetPath SHRegGetPathW
	#define SHRegSetPath SHRegSetPathW
#elseif defined(__FB_64BIT__) and (not defined(UNICODE)) and (_WIN32_WINNT = &h0400)
	#define SHSetValue SHSetValueA
#elseif (not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define SHRegGetValue SHRegGetValueA
#endif

#ifndef UNICODE
	#define SHQueryValueEx SHQueryValueExA
	#define SHEnumKeyEx SHEnumKeyExA
	#define SHEnumValue SHEnumValueA
	#define SHQueryInfoKey SHQueryInfoKeyA
	#define SHCopyKey SHCopyKeyA
	#define SHRegGetPath SHRegGetPathA
	#define SHRegSetPath SHRegSetPathA
#endif

declare function SHQueryValueExA(byval hkey as HKEY, byval pszValue as LPCSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
declare function SHQueryValueExW(byval hkey as HKEY, byval pszValue as LPCWSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
declare function SHEnumKeyExA(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPSTR, byval pcchName as LPDWORD) as LONG
declare function SHEnumKeyExW(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPWSTR, byval pcchName as LPDWORD) as LONG
declare function SHEnumValueA(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG
declare function SHEnumValueW(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPWSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG
declare function SHQueryInfoKeyA(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG
declare function SHQueryInfoKeyW(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG
declare function SHCopyKeyA(byval hkeySrc as HKEY, byval szSrcSubKey as LPCSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD
declare function SHCopyKeyW(byval hkeySrc as HKEY, byval wszSrcSubKey as LPCWSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD
declare function SHRegGetPathA(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pszPath as LPSTR, byval dwFlags as DWORD) as DWORD
declare function SHRegGetPathW(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pszPath as LPWSTR, byval dwFlags as DWORD) as DWORD
declare function SHRegSetPathA(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pcszPath as LPCSTR, byval dwFlags as DWORD) as DWORD
declare function SHRegSetPathW(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pcszPath as LPCWSTR, byval dwFlags as DWORD) as DWORD

type SHREGDEL_FLAGS as long
enum
	SHREGDEL_DEFAULT = &h00000000
	SHREGDEL_HKCU = &h00000001
	SHREGDEL_HKLM = &h00000010
	SHREGDEL_BOTH = &h00000011
end enum

type SHREGENUM_FLAGS as long
enum
	SHREGENUM_DEFAULT = &h00000000
	SHREGENUM_HKCU = &h00000001
	SHREGENUM_HKLM = &h00000010
	SHREGENUM_BOTH = &h00000011
end enum

const SHREGSET_HKCU = &h00000001
const SHREGSET_FORCE_HKCU = &h00000002
const SHREGSET_HKLM = &h00000004
const SHREGSET_FORCE_HKLM = &h00000008
#define SHREGSET_DEFAULT (SHREGSET_FORCE_HKCU or SHREGSET_HKLM)
type HUSKEY as HANDLE
type PHUSKEY as HUSKEY ptr

declare function SHRegCreateUSKeyA(byval pszPath as LPCSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval dwFlags as DWORD) as LONG
declare function SHRegCreateUSKeyW(byval pwzPath as LPCWSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval dwFlags as DWORD) as LONG
declare function SHRegOpenUSKeyA(byval pszPath as LPCSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval fIgnoreHKCU as WINBOOL) as LONG
declare function SHRegOpenUSKeyW(byval pwzPath as LPCWSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval fIgnoreHKCU as WINBOOL) as LONG
declare function SHRegQueryUSValueA(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
declare function SHRegQueryUSValueW(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
declare function SHRegWriteUSValueA(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
declare function SHRegWriteUSValueW(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
declare function SHRegDeleteUSValueA(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
declare function SHRegDeleteEmptyUSKeyW(byval hUSKey as HUSKEY, byval pwzSubKey as LPCWSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
declare function SHRegDeleteEmptyUSKeyA(byval hUSKey as HUSKEY, byval pszSubKey as LPCSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
declare function SHRegDeleteUSValueW(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
declare function SHRegEnumUSKeyA(byval hUSKey as HUSKEY, byval dwIndex as DWORD, byval pszName as LPSTR, byval pcchName as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegEnumUSKeyW(byval hUSKey as HUSKEY, byval dwIndex as DWORD, byval pwzName as LPWSTR, byval pcchName as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegEnumUSValueA(byval hUSkey as HUSKEY, byval dwIndex as DWORD, byval pszValueName as LPSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegEnumUSValueW(byval hUSkey as HUSKEY, byval dwIndex as DWORD, byval pszValueName as LPWSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegQueryInfoUSKeyA(byval hUSKey as HUSKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegQueryInfoUSKeyW(byval hUSKey as HUSKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
declare function SHRegCloseUSKey(byval hUSKey as HUSKEY) as LONG
declare function SHRegGetUSValueA(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
declare function SHRegGetUSValueW(byval pwzSubKey as LPCWSTR, byval pwzValue as LPCWSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
declare function SHRegSetUSValueA(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
declare function SHRegSetUSValueW(byval pwzSubKey as LPCWSTR, byval pwzValue as LPCWSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
declare function SHRegGetIntW(byval hk as HKEY, byval pwzKey as LPCWSTR, byval iDefault as long) as long

#ifdef UNICODE
	#define SHRegCreateUSKey SHRegCreateUSKeyW
	#define SHRegOpenUSKey SHRegOpenUSKeyW
	#define SHRegQueryUSValue SHRegQueryUSValueW
	#define SHRegWriteUSValue SHRegWriteUSValueW
	#define SHRegDeleteUSValue SHRegDeleteUSValueW
	#define SHRegDeleteEmptyUSKey SHRegDeleteEmptyUSKeyW
	#define SHRegEnumUSKey SHRegEnumUSKeyW
	#define SHRegEnumUSValue SHRegEnumUSValueW
	#define SHRegQueryInfoUSKey SHRegQueryInfoUSKeyW
	#define SHRegGetUSValue SHRegGetUSValueW
	#define SHRegSetUSValue SHRegSetUSValueW
	#define SHRegGetInt SHRegGetIntW
	#define SHRegGetBoolUSValue SHRegGetBoolUSValueW
#else
	#define SHRegCreateUSKey SHRegCreateUSKeyA
	#define SHRegOpenUSKey SHRegOpenUSKeyA
	#define SHRegQueryUSValue SHRegQueryUSValueA
	#define SHRegWriteUSValue SHRegWriteUSValueA
	#define SHRegDeleteUSValue SHRegDeleteUSValueA
	#define SHRegDeleteEmptyUSKey SHRegDeleteEmptyUSKeyA
	#define SHRegEnumUSKey SHRegEnumUSKeyA
	#define SHRegEnumUSValue SHRegEnumUSValueA
	#define SHRegQueryInfoUSKey SHRegQueryInfoUSKeyA
	#define SHRegGetUSValue SHRegGetUSValueA
	#define SHRegSetUSValue SHRegSetUSValueA
	#define SHRegGetInt SHRegGetIntA
	#define SHRegGetBoolUSValue SHRegGetBoolUSValueA
#endif

declare function SHRegGetBoolUSValueA(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL
declare function SHRegGetBoolUSValueW(byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL

enum
	ASSOCF_INIT_NOREMAPCLSID = &h00000001
	ASSOCF_INIT_BYEXENAME = &h00000002
	ASSOCF_OPEN_BYEXENAME = &h00000002
	ASSOCF_INIT_DEFAULTTOSTAR = &h00000004
	ASSOCF_INIT_DEFAULTTOFOLDER = &h00000008
	ASSOCF_NOUSERSETTINGS = &h00000010
	ASSOCF_NOTRUNCATE = &h00000020
	ASSOCF_VERIFY = &h00000040
	ASSOCF_REMAPRUNDLL = &h00000080
	ASSOCF_NOFIXUPS = &h00000100
	ASSOCF_IGNOREBASECLASS = &h00000200
	ASSOCF_INIT_IGNOREUNKNOWN = &h00000400
end enum

type ASSOCF as DWORD

type ASSOCSTR as long
enum
	ASSOCSTR_COMMAND = 1
	ASSOCSTR_EXECUTABLE
	ASSOCSTR_FRIENDLYDOCNAME
	ASSOCSTR_FRIENDLYAPPNAME
	ASSOCSTR_NOOPEN
	ASSOCSTR_SHELLNEWVALUE
	ASSOCSTR_DDECOMMAND
	ASSOCSTR_DDEIFEXEC
	ASSOCSTR_DDEAPPLICATION
	ASSOCSTR_DDETOPIC
	ASSOCSTR_INFOTIP
	ASSOCSTR_QUICKTIP
	ASSOCSTR_TILEINFO
	ASSOCSTR_CONTENTTYPE
	ASSOCSTR_DEFAULTICON
	ASSOCSTR_SHELLEXTENSION

	#if _WIN32_WINNT = &h0602
		ASSOCSTR_DROPTARGET
		ASSOCSTR_DELEGATEEXECUTE
	#endif

	ASSOCSTR_MAX
end enum

type ASSOCKEY as long
enum
	ASSOCKEY_SHELLEXECCLASS = 1
	ASSOCKEY_APP
	ASSOCKEY_CLASS
	ASSOCKEY_BASECLASS
	ASSOCKEY_MAX
end enum

type ASSOCDATA as long
enum
	ASSOCDATA_MSIDESCRIPTOR = 1
	ASSOCDATA_NOACTIVATEHANDLER
	ASSOCDATA_QUERYCLASSSTORE
	ASSOCDATA_HASPERUSERASSOC
	ASSOCDATA_EDITFLAGS
	ASSOCDATA_VALUE
	ASSOCDATA_MAX
end enum

type ASSOCENUM as long
enum
	ASSOCENUM_NONE
end enum

type IQueryAssociationsVtbl as IQueryAssociationsVtbl_

type IQueryAssociations
	lpVtbl as IQueryAssociationsVtbl ptr
end type

type IQueryAssociationsVtbl_
	QueryInterface as function(byval This as IQueryAssociations ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueryAssociations ptr) as ULONG
	Release as function(byval This as IQueryAssociations ptr) as ULONG
	Init as function(byval This as IQueryAssociations ptr, byval flags as ASSOCF, byval pszAssoc as LPCWSTR, byval hkProgid as HKEY, byval hwnd as HWND) as HRESULT
	GetString as function(byval This as IQueryAssociations ptr, byval flags as ASSOCF, byval str as ASSOCSTR, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT
	GetKey as function(byval This as IQueryAssociations ptr, byval flags as ASSOCF, byval key as ASSOCKEY, byval pszExtra as LPCWSTR, byval phkeyOut as HKEY ptr) as HRESULT
	GetData as function(byval This as IQueryAssociations ptr, byval flags as ASSOCF, byval data as ASSOCDATA, byval pszExtra as LPCWSTR, byval pvOut as LPVOID, byval pcbOut as DWORD ptr) as HRESULT
	GetEnum as function(byval This as IQueryAssociations ptr, byval flags as ASSOCF, byval assocenum as ASSOCENUM, byval pszExtra as LPCWSTR, byval riid as const IID const ptr, byval ppvOut as LPVOID ptr) as HRESULT
end type

#ifdef UNICODE
	#define AssocQueryString AssocQueryStringW
	#define AssocQueryStringByKey AssocQueryStringByKeyW
	#define AssocQueryKey AssocQueryKeyW
#else
	#define AssocQueryString AssocQueryStringA
	#define AssocQueryStringByKey AssocQueryStringByKeyA
	#define AssocQueryKey AssocQueryKeyA
#endif

declare function AssocCreate(byval clsid as CLSID, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function AssocQueryStringA(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT
declare function AssocQueryStringW(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT
declare function AssocQueryStringByKeyA(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT
declare function AssocQueryStringByKeyW(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT
declare function AssocQueryKeyA(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval phkeyOut as HKEY ptr) as HRESULT
declare function AssocQueryKeyW(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval phkeyOut as HKEY ptr) as HRESULT

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	declare function AssocIsDangerous(byval pszAssoc as LPCWSTR) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	declare function AssocGetPerceivedType(byval pszExt as LPCWSTR, byval ptype as PERCEIVED ptr, byval pflag as PERCEIVEDFLAG ptr, byval ppszType as LPWSTR ptr) as HRESULT
#endif

#ifdef UNICODE
	#define SHOpenRegStream2 SHOpenRegStream2W
	#define SHCreateStreamOnFile SHCreateStreamOnFileW
#else
	#define SHOpenRegStream2 SHOpenRegStream2A
	#define SHCreateStreamOnFile SHCreateStreamOnFileA
#endif

declare function SHOpenRegStreamA(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr
declare function SHOpenRegStreamW(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr
declare function SHOpenRegStream2A(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr
declare function SHOpenRegStream2W(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr
#define SHOpenRegStream SHOpenRegStream2
declare function SHCreateStreamOnFileA(byval pszFile as LPCSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT
declare function SHCreateStreamOnFileW(byval pszFile as LPCWSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	declare function SHCreateStreamOnFileEx(byval pszFile as LPCWSTR, byval grfMode as DWORD, byval dwAttributes as DWORD, byval fCreate as WINBOOL, byval pstmTemplate as IStream ptr, byval ppstm as IStream ptr ptr) as HRESULT
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define GetAcceptLanguages GetAcceptLanguagesW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define GetAcceptLanguages GetAcceptLanguagesA
#endif

#if _WIN32_WINNT = &h0602
	declare function GetAcceptLanguagesA(byval psz as LPSTR, byval pcch as DWORD ptr) as HRESULT
	declare function GetAcceptLanguagesW(byval psz as LPWSTR, byval pcch as DWORD ptr) as HRESULT
#endif

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	const SHGVSPB_PERUSER = &h00000001
	const SHGVSPB_ALLUSERS = &h00000002
	const SHGVSPB_PERFOLDER = &h00000004
	const SHGVSPB_ALLFOLDERS = &h00000008
	const SHGVSPB_INHERIT = &h00000010
	const SHGVSPB_ROAM = &h00000020
	const SHGVSPB_NOAUTODEFAULTS = &h80000000
	#define SHGVSPB_FOLDER (SHGVSPB_PERUSER or SHGVSPB_PERFOLDER)
	#define SHGVSPB_FOLDERNODEFAULTS ((SHGVSPB_PERUSER or SHGVSPB_PERFOLDER) or SHGVSPB_NOAUTODEFAULTS)
	#define SHGVSPB_USERDEFAULTS (SHGVSPB_PERUSER or SHGVSPB_ALLFOLDERS)
	#define SHGVSPB_GLOBALDEAFAULTS (SHGVSPB_ALLUSERS or SHGVSPB_ALLFOLDERS)
	declare function SHGetViewStatePropertyBag(byval pidl as LPCITEMIDLIST, byval pszBagName as LPCWSTR, byval dwFlags as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT = &h0602
	declare function SHAllocShared(byval pvData as const any ptr, byval dwSize as DWORD, byval dwProcessId as DWORD) as HANDLE
	declare function SHFreeShared(byval hData as HANDLE, byval dwProcessId as DWORD) as WINBOOL
	declare function SHLockShared(byval hData as HANDLE, byval dwProcessId as DWORD) as any ptr
	declare function SHUnlockShared(byval pvData as any ptr) as WINBOOL
#endif

const SHACF_DEFAULT = &h00000000
const SHACF_FILESYSTEM = &h00000001
#define SHACF_URLALL (SHACF_URLHISTORY or SHACF_URLMRU)
const SHACF_URLHISTORY = &h00000002
const SHACF_URLMRU = &h00000004
const SHACF_USETAB = &h00000008
const SHACF_FILESYS_ONLY = &h00000010

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	const SHACF_FILESYS_DIRS = &h00000020
#endif

const SHACF_AUTOSUGGEST_FORCE_ON = &h10000000
const SHACF_AUTOSUGGEST_FORCE_OFF = &h20000000
const SHACF_AUTOAPPEND_FORCE_ON = &h40000000
const SHACF_AUTOAPPEND_FORCE_OFF = &h80000000

declare function SHAutoComplete(byval hwndEdit as HWND, byval dwFlags as DWORD) as HRESULT
declare function SHSetThreadRef(byval punk as IUnknown ptr) as HRESULT
declare function SHGetThreadRef(byval ppunk as IUnknown ptr ptr) as HRESULT
declare function SHSkipJunction(byval pbc as IBindCtx ptr, byval pclsid as const CLSID ptr) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function SHCreateThreadRef(byval pcRef as LONG ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
#endif

const CTF_INSIST = &h00000001
const CTF_THREAD_REF = &h00000002
const CTF_PROCESS_REF = &h00000004
const CTF_COINIT = &h00000008
const CTF_FREELIBANDEXIT = &h00000010
const CTF_REF_COUNTED = &h00000020
const CTF_WAIT_ALLOWCOM = &h00000040

declare function SHCreateThread(byval pfnThreadProc as LPTHREAD_START_ROUTINE, byval pData as any ptr, byval dwFlags as DWORD, byval pfnCallback as LPTHREAD_START_ROUTINE) as WINBOOL
declare function SHReleaseThreadRef() as HRESULT
declare function SHCreateShellPalette(byval hdc as HDC) as HPALETTE
declare sub ColorRGBToHLS(byval clrRGB as COLORREF, byval pwHue as WORD ptr, byval pwLuminance as WORD ptr, byval pwSaturation as WORD ptr)
declare function ColorHLSToRGB(byval wHue as WORD, byval wLuminance as WORD, byval wSaturation as WORD) as COLORREF
declare function ColorAdjustLuma(byval clrRGB as COLORREF, byval n as long, byval fScale as WINBOOL) as COLORREF

type _DLLVERSIONINFO
	cbSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	dwBuildNumber as DWORD
	dwPlatformID as DWORD
end type

type DLLVERSIONINFO as _DLLVERSIONINFO
const DLLVER_PLATFORM_WINDOWS = &h00000001
const DLLVER_PLATFORM_NT = &h00000002

type _DLLVERSIONINFO2
	info1 as DLLVERSIONINFO
	dwFlags as DWORD
	ullVersion as ULONGLONG
end type

type DLLVERSIONINFO2 as _DLLVERSIONINFO2
const DLLVER_MAJOR_MASK = &hFFFF000000000000
const DLLVER_MINOR_MASK = &h0000FFFF00000000
const DLLVER_BUILD_MASK = &h00000000FFFF0000
const DLLVER_QFE_MASK = &h000000000000FFFF
#define MAKEDLLVERULL(major, minor, build, qfe) ((((cast(ULONGLONG, (major)) shl 48) or (cast(ULONGLONG, (minor)) shl 32)) or (cast(ULONGLONG, (build)) shl 16)) or (cast(ULONGLONG, (qfe)) shl 0))
type DLLGETVERSIONPROC as function(byval as DLLVERSIONINFO ptr) as HRESULT
declare function DllInstall(byval bInstall as WINBOOL, byval pszCmdLine as LPCWSTR) as HRESULT

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	declare function IsInternetESCEnabled() as WINBOOL
#endif

end extern
