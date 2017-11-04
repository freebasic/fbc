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

#inclib "shlwapi"

#include once "_mingw_unicode.bi"
#include once "objbase.bi"
#include once "shtypes.bi"
#include once "shlobj.bi"

extern "Windows"

#define _INC_SHLWAPI
declare function StrChrA(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrChrW(byval lpStart as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
declare function StrChrIA(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrChrIW(byval lpStart as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
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
declare function StrRChrW(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
declare function StrRChrIA(byval lpStart as LPCSTR, byval lpEnd as LPCSTR, byval wMatch as WORD) as LPSTR
declare function StrRChrIW(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
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

#if _WIN32_WINNT >= &h0501
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
declare function ChrCmpIW(byval w1 as WCHAR, byval w2 as WCHAR) as WINBOOL
declare function wvnsprintfA(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, byval arglist as va_list) as long
declare function wvnsprintfW(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, byval arglist as va_list) as long
declare function wnsprintfA cdecl(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, ...) as long
declare function wnsprintfW cdecl(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, ...) as long

#define StrIntlEqNA(s1, s2, nChar) StrIsIntlEqualA(CTRUE, s1, s2, nChar)
#define StrIntlEqNW(s1, s2, nChar) StrIsIntlEqualW(CTRUE, s1, s2, nChar)
#define StrIntlEqNIA(s1, s2, nChar) StrIsIntlEqualA(FALSE, s1, s2, nChar)
#define StrIntlEqNIW(s1, s2, nChar) StrIsIntlEqualW(FALSE, s1, s2, nChar)
declare function StrRetToStrA(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPSTR ptr) as HRESULT

#ifndef UNICODE
	declare function StrRetToStr alias "StrRetToStrA"(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPSTR ptr) as HRESULT
#endif

declare function StrRetToStrW(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPWSTR ptr) as HRESULT

#ifdef UNICODE
	declare function StrRetToStr alias "StrRetToStrW"(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval ppsz as LPWSTR ptr) as HRESULT
#endif

declare function StrRetToBufA(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPSTR, byval cchBuf as UINT) as HRESULT

#ifndef UNICODE
	declare function StrRetToBuf alias "StrRetToBufA"(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPSTR, byval cchBuf as UINT) as HRESULT
#endif

declare function StrRetToBufW(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPWSTR, byval cchBuf as UINT) as HRESULT

#ifdef UNICODE
	declare function StrRetToBuf alias "StrRetToBufW"(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pszBuf as LPWSTR, byval cchBuf as UINT) as HRESULT
#endif

declare function StrRetToBSTR(byval pstr as STRRET ptr, byval pidl as LPCITEMIDLIST, byval pbstr as BSTR ptr) as HRESULT
declare function SHStrDupA(byval psz as LPCSTR, byval ppwsz as wstring ptr ptr) as HRESULT

#ifndef UNICODE
	declare function SHStrDup alias "SHStrDupA"(byval psz as LPCSTR, byval ppwsz as wstring ptr ptr) as HRESULT
#endif

declare function SHStrDupW(byval psz as LPCWSTR, byval ppwsz as wstring ptr ptr) as HRESULT

#ifdef UNICODE
	declare function SHStrDup alias "SHStrDupW"(byval psz as LPCWSTR, byval ppwsz as wstring ptr ptr) as HRESULT
#endif

declare function StrCmpLogicalW(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
declare function StrCatChainW(byval pszDst as LPWSTR, byval cchDst as DWORD, byval ichAt as DWORD, byval pszSrc as LPCWSTR) as DWORD
declare function SHLoadIndirectString(byval pszSource as LPCWSTR, byval pszOutBuf as LPWSTR, byval cchOutBuf as UINT, byval ppvReserved as any ptr ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function IsCharSpaceA(byval wch as CHAR) as WINBOOL
	declare function IsCharSpaceW(byval wch as WCHAR) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function IsCharSpace alias "IsCharSpaceW"(byval wch as WCHAR) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function IsCharSpace alias "IsCharSpaceA"(byval wch as CHAR) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function StrCmpCA(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
	declare function StrCmpCW(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function StrCmpC alias "StrCmpCW"(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function StrCmpC alias "StrCmpCA"(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
#endif

#if _WIN32_WINNT >= &h0600
	declare function StrCmpICA(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
	declare function StrCmpICW(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function StrCmpIC alias "StrCmpICW"(byval pszStr1 as LPCWSTR, byval pszStr2 as LPCWSTR) as long
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function StrCmpIC alias "StrCmpICA"(byval pszStr1 as LPCSTR, byval pszStr2 as LPCSTR) as long
#endif

#undef StrChr

#ifdef UNICODE
	declare function StrChr alias "StrChrW"(byval lpStart as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
#else
	declare function StrChr alias "StrChrA"(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
#endif

#undef StrRChr

#ifdef UNICODE
	declare function StrRChr alias "StrRChrW"(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
	declare function StrChrI alias "StrChrIW"(byval lpStart as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
	declare function StrRChrI alias "StrRChrIW"(byval lpStart as LPCWSTR, byval lpEnd as LPCWSTR, byval wMatch as WCHAR) as LPWSTR
	declare function StrCmpN alias "StrCmpNW"(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
	declare function StrCmpNI alias "StrCmpNIW"(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
#else
	declare function StrRChr alias "StrRChrA"(byval lpStart as LPCSTR, byval lpEnd as LPCSTR, byval wMatch as WORD) as LPSTR
	declare function StrChrI alias "StrChrIA"(byval lpStart as LPCSTR, byval wMatch as WORD) as LPSTR
	declare function StrRChrI alias "StrRChrIA"(byval lpStart as LPCSTR, byval lpEnd as LPCSTR, byval wMatch as WORD) as LPSTR
	declare function StrCmpN alias "StrCmpNA"(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
	declare function StrCmpNI alias "StrCmpNIA"(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
#endif

#undef StrStr

#ifdef UNICODE
	declare function StrStr alias "StrStrW"(byval lpFirst as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
	declare function StrStrI alias "StrStrIW"(byval lpFirst as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
	declare function StrDup alias "StrDupW"(byval lpSrch as LPCWSTR) as LPWSTR
	declare function StrRStrI alias "StrRStrIW"(byval lpSource as LPCWSTR, byval lpLast as LPCWSTR, byval lpSrch as LPCWSTR) as LPWSTR
#else
	declare function StrStr alias "StrStrA"(byval lpFirst as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
	declare function StrStrI alias "StrStrIA"(byval lpFirst as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
	declare function StrDup alias "StrDupA"(byval lpSrch as LPCSTR) as LPSTR
	declare function StrRStrI alias "StrRStrIA"(byval lpSource as LPCSTR, byval lpLast as LPCSTR, byval lpSrch as LPCSTR) as LPSTR
#endif

#undef StrCSpn

#ifdef UNICODE
	declare function StrCSpn alias "StrCSpnW"(byval lpStr as LPCWSTR, byval lpSet as LPCWSTR) as long
	declare function StrCSpnI alias "StrCSpnIW"(byval lpStr as LPCWSTR, byval lpSet as LPCWSTR) as long
#else
	declare function StrCSpn alias "StrCSpnA"(byval lpStr as LPCSTR, byval lpSet as LPCSTR) as long
	declare function StrCSpnI alias "StrCSpnIA"(byval lpStr as LPCSTR, byval lpSet as LPCSTR) as long
#endif

#undef StrSpn

#ifdef UNICODE
	declare function StrSpn alias "StrSpnW"(byval psz as LPCWSTR, byval pszSet as LPCWSTR) as long
	declare function StrToInt alias "StrToIntW"(byval lpSrc as LPCWSTR) as long
#else
	declare function StrSpn alias "StrSpnA"(byval psz as LPCSTR, byval pszSet as LPCSTR) as long
	declare function StrToInt alias "StrToIntA"(byval lpSrc as LPCSTR) as long
#endif

#undef StrPBrk

#ifdef UNICODE
	declare function StrPBrk alias "StrPBrkW"(byval psz as LPCWSTR, byval pszSet as LPCWSTR) as LPWSTR
	declare function StrToIntEx alias "StrToIntExW"(byval pszString as LPCWSTR, byval dwFlags as DWORD, byval piRet as long ptr) as WINBOOL

	#if _WIN32_WINNT >= &h0501
		declare function StrToInt64Ex alias "StrToInt64ExW"(byval pszString as LPCWSTR, byval dwFlags as DWORD, byval pllRet as LONGLONG ptr) as WINBOOL
	#endif

	declare function StrFromTimeInterval alias "StrFromTimeIntervalW"(byval pszOut as LPWSTR, byval cchMax as UINT, byval dwTimeMS as DWORD, byval digits as long) as long
	#define StrIntlEqN StrIntlEqNW
	#define StrIntlEqNI StrIntlEqNIW
	declare function StrFormatByteSize alias "StrFormatByteSizeW"(byval qdw as LONGLONG, byval szBuf as LPWSTR, byval uiBufSize as UINT) as LPWSTR
	declare function StrFormatKBSize alias "StrFormatKBSizeW"(byval qdw as LONGLONG, byval szBuf as LPWSTR, byval uiBufSize as UINT) as LPWSTR
#else
	declare function StrPBrk alias "StrPBrkA"(byval psz as LPCSTR, byval pszSet as LPCSTR) as LPSTR
	declare function StrToIntEx alias "StrToIntExA"(byval pszString as LPCSTR, byval dwFlags as DWORD, byval piRet as long ptr) as WINBOOL
#endif

#ifndef UNICODE
	#if _WIN32_WINNT >= &h0501
		declare function StrToInt64Ex alias "StrToInt64ExA"(byval pszString as LPCSTR, byval dwFlags as DWORD, byval pllRet as LONGLONG ptr) as WINBOOL
	#endif

	declare function StrFromTimeInterval alias "StrFromTimeIntervalA"(byval pszOut as LPSTR, byval cchMax as UINT, byval dwTimeMS as DWORD, byval digits as long) as long
	#define StrIntlEqN StrIntlEqNA
	#define StrIntlEqNI StrIntlEqNIA
	declare function StrFormatByteSize alias "StrFormatByteSizeA"(byval dw as DWORD, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
	declare function StrFormatKBSize alias "StrFormatKBSizeA"(byval qdw as LONGLONG, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
#endif

#undef StrNCat

#ifdef UNICODE
	#define StrNCat StrNCatW
	declare function StrTrim alias "StrTrimW"(byval psz as LPWSTR, byval pszTrimChars as LPCWSTR) as WINBOOL
	declare function StrCatBuff alias "StrCatBuffW"(byval pszDest as LPWSTR, byval pszSrc as LPCWSTR, byval cchDestBuffSize as long) as LPWSTR
	declare function ChrCmpI alias "ChrCmpIW"(byval w1 as WCHAR, byval w2 as WCHAR) as WINBOOL
	declare function wvnsprintf alias "wvnsprintfW"(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, byval arglist as va_list) as long
	declare function wnsprintf cdecl alias "wnsprintfW"(byval lpOut as LPWSTR, byval cchLimitIn as long, byval lpFmt as LPCWSTR, ...) as long
	declare function StrIsIntlEqual alias "StrIsIntlEqualW"(byval fCaseSens as WINBOOL, byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR, byval nChar as long) as WINBOOL
	declare function StrFormatByteSize64 alias "StrFormatByteSizeW"(byval qdw as LONGLONG, byval szBuf as LPWSTR, byval uiBufSize as UINT) as LPWSTR
#else
	#define StrNCat StrNCatA
	declare function StrTrim alias "StrTrimA"(byval psz as LPSTR, byval pszTrimChars as LPCSTR) as WINBOOL
	declare function StrCatBuff alias "StrCatBuffA"(byval pszDest as LPSTR, byval pszSrc as LPCSTR, byval cchDestBuffSize as long) as LPSTR
	declare function ChrCmpI alias "ChrCmpIA"(byval w1 as WORD, byval w2 as WORD) as WINBOOL
	declare function wvnsprintf alias "wvnsprintfA"(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, byval arglist as va_list) as long
	declare function wnsprintf cdecl alias "wnsprintfA"(byval lpOut as LPSTR, byval cchLimitIn as long, byval lpFmt as LPCSTR, ...) as long
	declare function StrIsIntlEqual alias "StrIsIntlEqualA"(byval fCaseSens as WINBOOL, byval lpString1 as LPCSTR, byval lpString2 as LPCSTR, byval nChar as long) as WINBOOL
	declare function StrFormatByteSize64 alias "StrFormatByteSize64A"(byval qdw as LONGLONG, byval szBuf as LPSTR, byval uiBufSize as UINT) as LPSTR
#endif

declare function IntlStrEqWorkerA(byval fCaseSens as WINBOOL, byval lpString1 as LPCSTR, byval lpString2 as LPCSTR, byval nChar as long) as WINBOOL
declare function IntlStrEqWorkerW(byval fCaseSens as WINBOOL, byval lpString1 as LPCWSTR, byval lpString2 as LPCWSTR, byval nChar as long) as WINBOOL
#define IntlStrEqNA(s1, s2, nChar) IntlStrEqWorkerA(CTRUE, s1, s2, nChar)
#define IntlStrEqNW(s1, s2, nChar) IntlStrEqWorkerW(CTRUE, s1, s2, nChar)
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
const STIF_DEFAULT = &h00000000
const STIF_SUPPORT_HEX = &h00000001
#define StrCatA lstrcatA
declare function StrCmpA alias "lstrcmpA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
declare function StrCmpIA alias "lstrcmpiA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
#define StrCpyA lstrcpyA
declare function StrCpyNA alias "lstrcpynA"(byval lpString1 as LPSTR, byval lpString2 as LPCSTR, byval iMaxLength as long) as LPSTR

#ifdef UNICODE
	declare function StrToLong alias "StrToIntW"(byval lpSrc as LPCWSTR) as long
#else
	declare function StrToLong alias "StrToIntA"(byval lpSrc as LPCSTR) as long
#endif

#undef StrNCmp

#ifdef UNICODE
	declare function StrNCmp alias "StrCmpNW"(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
	declare function StrNCmpI alias "StrCmpNIW"(byval lpStr1 as LPCWSTR, byval lpStr2 as LPCWSTR, byval nChar as long) as long
#else
	declare function StrNCmp alias "StrCmpNA"(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
	declare function StrNCmpI alias "StrCmpNIA"(byval lpStr1 as LPCSTR, byval lpStr2 as LPCSTR, byval nChar as long) as long
#endif

#define StrCatN StrNCat
#undef StrCat

#ifdef UNICODE
	#define StrCat StrCatW
#else
	#define StrCat lstrcatA
#endif

#undef StrCmp

#ifdef UNICODE
	declare function StrCmp alias "StrCmpW"(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
	declare function StrCmpI alias "StrCmpIW"(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR) as long
#else
	declare function StrCmp alias "lstrcmpA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
	declare function StrCmpI alias "lstrcmpiA"(byval lpString1 as LPCSTR, byval lpString2 as LPCSTR) as long
#endif

#undef StrCpy

#ifdef UNICODE
	#define StrCpy StrCpyW
	declare function StrCpyN alias "StrCpyNW"(byval psz1 as LPWSTR, byval psz2 as LPCWSTR, byval cchMax as long) as LPWSTR
#else
	#define StrCpy lstrcpyA
	declare function StrCpyN alias "lstrcpynA"(byval lpString1 as LPSTR, byval lpString2 as LPCSTR, byval iMaxLength as long) as LPSTR
#endif

#undef StrNCpy

#ifdef UNICODE
	declare function StrNCpy alias "StrCpyNW"(byval psz1 as LPWSTR, byval psz2 as LPCWSTR, byval cchMax as long) as LPWSTR
#else
	declare function StrNCpy alias "lstrcpynA"(byval lpString1 as LPSTR, byval lpString2 as LPCSTR, byval iMaxLength as long) as LPSTR
#endif

declare function PathAddBackslashA(byval pszPath as LPSTR) as LPSTR
declare function PathAddBackslashW(byval pszPath as LPWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathAddBackslash alias "PathAddBackslashW"(byval pszPath as LPWSTR) as LPWSTR
#else
	declare function PathAddBackslash alias "PathAddBackslashA"(byval pszPath as LPSTR) as LPSTR
#endif

declare function PathAddExtensionA(byval pszPath as LPSTR, byval pszExt as LPCSTR) as WINBOOL
declare function PathAddExtensionW(byval pszPath as LPWSTR, byval pszExt as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathAddExtension alias "PathAddExtensionW"(byval pszPath as LPWSTR, byval pszExt as LPCWSTR) as WINBOOL
#else
	declare function PathAddExtension alias "PathAddExtensionA"(byval pszPath as LPSTR, byval pszExt as LPCSTR) as WINBOOL
#endif

declare function PathAppendA(byval pszPath as LPSTR, byval pMore as LPCSTR) as WINBOOL
declare function PathAppendW(byval pszPath as LPWSTR, byval pMore as LPCWSTR) as WINBOOL
declare function PathBuildRootA(byval pszRoot as LPSTR, byval iDrive as long) as LPSTR
declare function PathBuildRootW(byval pszRoot as LPWSTR, byval iDrive as long) as LPWSTR

#ifdef UNICODE
	declare function PathBuildRoot alias "PathBuildRootW"(byval pszRoot as LPWSTR, byval iDrive as long) as LPWSTR
#else
	declare function PathBuildRoot alias "PathBuildRootA"(byval pszRoot as LPSTR, byval iDrive as long) as LPSTR
#endif

declare function PathCanonicalizeA(byval pszBuf as LPSTR, byval pszPath as LPCSTR) as WINBOOL
declare function PathCanonicalizeW(byval pszBuf as LPWSTR, byval pszPath as LPCWSTR) as WINBOOL
declare function PathCombineA(byval pszDest as LPSTR, byval pszDir as LPCSTR, byval pszFile as LPCSTR) as LPSTR
declare function PathCombineW(byval pszDest as LPWSTR, byval pszDir as LPCWSTR, byval pszFile as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathCombine alias "PathCombineW"(byval pszDest as LPWSTR, byval pszDir as LPCWSTR, byval pszFile as LPCWSTR) as LPWSTR
#else
	declare function PathCombine alias "PathCombineA"(byval pszDest as LPSTR, byval pszDir as LPCSTR, byval pszFile as LPCSTR) as LPSTR
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
	declare function PathFileExists alias "PathFileExistsW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathFileExists alias "PathFileExistsA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathFindExtensionA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindExtensionW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathFindExtension alias "PathFindExtensionW"(byval pszPath as LPCWSTR) as LPWSTR
#else
	declare function PathFindExtension alias "PathFindExtensionA"(byval pszPath as LPCSTR) as LPSTR
#endif

declare function PathFindFileNameA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindFileNameW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathFindFileName alias "PathFindFileNameW"(byval pszPath as LPCWSTR) as LPWSTR
#else
	declare function PathFindFileName alias "PathFindFileNameA"(byval pszPath as LPCSTR) as LPSTR
#endif

declare function PathFindNextComponentA(byval pszPath as LPCSTR) as LPSTR
declare function PathFindNextComponentW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathFindNextComponent alias "PathFindNextComponentW"(byval pszPath as LPCWSTR) as LPWSTR
#else
	declare function PathFindNextComponent alias "PathFindNextComponentA"(byval pszPath as LPCSTR) as LPSTR
#endif

declare function PathFindOnPathA(byval pszPath as LPSTR, byval ppszOtherDirs as LPCSTR ptr) as WINBOOL
declare function PathFindOnPathW(byval pszPath as LPWSTR, byval ppszOtherDirs as LPCWSTR ptr) as WINBOOL
declare function PathGetArgsA(byval pszPath as LPCSTR) as LPSTR
declare function PathGetArgsW(byval pszPath as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function PathGetArgs alias "PathGetArgsW"(byval pszPath as LPCWSTR) as LPWSTR
#else
	declare function PathGetArgs alias "PathGetArgsA"(byval pszPath as LPCSTR) as LPSTR
#endif

declare function PathFindSuffixArrayA(byval pszPath as LPCSTR, byval apszSuffix as const LPCSTR ptr, byval iArraySize as long) as LPCSTR
declare function PathFindSuffixArrayW(byval pszPath as LPCWSTR, byval apszSuffix as const LPCWSTR ptr, byval iArraySize as long) as LPCWSTR

#ifdef UNICODE
	declare function PathFindSuffixArray alias "PathFindSuffixArrayW"(byval pszPath as LPCWSTR, byval apszSuffix as const LPCWSTR ptr, byval iArraySize as long) as LPCWSTR
#else
	declare function PathFindSuffixArray alias "PathFindSuffixArrayA"(byval pszPath as LPCSTR, byval apszSuffix as const LPCSTR ptr, byval iArraySize as long) as LPCSTR
#endif

declare function PathIsLFNFileSpecA(byval lpName as LPCSTR) as WINBOOL
declare function PathIsLFNFileSpecW(byval lpName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsLFNFileSpec alias "PathIsLFNFileSpecW"(byval lpName as LPCWSTR) as WINBOOL
#else
	declare function PathIsLFNFileSpec alias "PathIsLFNFileSpecA"(byval lpName as LPCSTR) as WINBOOL
#endif

declare function PathGetCharTypeA(byval ch as UCHAR) as UINT
declare function PathGetCharTypeW(byval ch as WCHAR) as UINT
const GCT_INVALID = &h0000
const GCT_LFNCHAR = &h0001
const GCT_SHORTCHAR = &h0002
const GCT_WILD = &h0004
const GCT_SEPARATOR = &h0008
declare function PathGetDriveNumberA(byval pszPath as LPCSTR) as long
declare function PathGetDriveNumberW(byval pszPath as LPCWSTR) as long

#ifdef UNICODE
	declare function PathGetDriveNumber alias "PathGetDriveNumberW"(byval pszPath as LPCWSTR) as long
#else
	declare function PathGetDriveNumber alias "PathGetDriveNumberA"(byval pszPath as LPCSTR) as long
#endif

declare function PathIsDirectoryA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsDirectoryW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsDirectory alias "PathIsDirectoryW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsDirectory alias "PathIsDirectoryA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsDirectoryEmptyA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsDirectoryEmptyW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsDirectoryEmpty alias "PathIsDirectoryEmptyW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsDirectoryEmpty alias "PathIsDirectoryEmptyA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsFileSpecA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsFileSpecW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsFileSpec alias "PathIsFileSpecW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsFileSpec alias "PathIsFileSpecA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsPrefixA(byval pszPrefix as LPCSTR, byval pszPath as LPCSTR) as WINBOOL
declare function PathIsPrefixW(byval pszPrefix as LPCWSTR, byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsPrefix alias "PathIsPrefixW"(byval pszPrefix as LPCWSTR, byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsPrefix alias "PathIsPrefixA"(byval pszPrefix as LPCSTR, byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsRelativeA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsRelativeW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsRelative alias "PathIsRelativeW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsRelative alias "PathIsRelativeA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsRootA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsRootW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsRoot alias "PathIsRootW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsRoot alias "PathIsRootA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsSameRootA(byval pszPath1 as LPCSTR, byval pszPath2 as LPCSTR) as WINBOOL
declare function PathIsSameRootW(byval pszPath1 as LPCWSTR, byval pszPath2 as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsSameRoot alias "PathIsSameRootW"(byval pszPath1 as LPCWSTR, byval pszPath2 as LPCWSTR) as WINBOOL
#else
	declare function PathIsSameRoot alias "PathIsSameRootA"(byval pszPath1 as LPCSTR, byval pszPath2 as LPCSTR) as WINBOOL
#endif

declare function PathIsUNCA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsUNC alias "PathIsUNCW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsUNC alias "PathIsUNCA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsNetworkPathA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsNetworkPathW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsNetworkPath alias "PathIsNetworkPathW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsNetworkPath alias "PathIsNetworkPathA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsUNCServerA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCServerW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsUNCServer alias "PathIsUNCServerW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsUNCServer alias "PathIsUNCServerA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsUNCServerShareA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsUNCServerShareW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsUNCServerShare alias "PathIsUNCServerShareW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsUNCServerShare alias "PathIsUNCServerShareA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsContentTypeA(byval pszPath as LPCSTR, byval pszContentType as LPCSTR) as WINBOOL
declare function PathIsContentTypeW(byval pszPath as LPCWSTR, byval pszContentType as LPCWSTR) as WINBOOL
declare function PathIsURLA(byval pszPath as LPCSTR) as WINBOOL
declare function PathIsURLW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathIsURL alias "PathIsURLW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathIsURL alias "PathIsURLA"(byval pszPath as LPCSTR) as WINBOOL
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
	declare function PathRemoveBackslash alias "PathRemoveBackslashW"(byval pszPath as LPWSTR) as LPWSTR
#else
	declare function PathRemoveBackslash alias "PathRemoveBackslashA"(byval pszPath as LPSTR) as LPSTR
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
	declare function PathSkipRoot alias "PathSkipRootW"(byval pszPath as LPCWSTR) as LPWSTR
#else
	declare function PathSkipRoot alias "PathSkipRootA"(byval pszPath as LPCSTR) as LPSTR
#endif

declare sub PathStripPathA(byval pszPath as LPSTR)
declare sub PathStripPathW(byval pszPath as LPWSTR)

#ifdef UNICODE
	declare sub PathStripPath alias "PathStripPathW"(byval pszPath as LPWSTR)
#else
	declare sub PathStripPath alias "PathStripPathA"(byval pszPath as LPSTR)
#endif

declare function PathStripToRootA(byval pszPath as LPSTR) as WINBOOL
declare function PathStripToRootW(byval pszPath as LPWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathStripToRoot alias "PathStripToRootW"(byval pszPath as LPWSTR) as WINBOOL
#else
	declare function PathStripToRoot alias "PathStripToRootA"(byval pszPath as LPSTR) as WINBOOL
#endif

declare sub PathUnquoteSpacesA(byval lpsz as LPSTR)
declare sub PathUnquoteSpacesW(byval lpsz as LPWSTR)
declare function PathMakeSystemFolderA(byval pszPath as LPCSTR) as WINBOOL
declare function PathMakeSystemFolderW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathMakeSystemFolder alias "PathMakeSystemFolderW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathMakeSystemFolder alias "PathMakeSystemFolderA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathUnmakeSystemFolderA(byval pszPath as LPCSTR) as WINBOOL
declare function PathUnmakeSystemFolderW(byval pszPath as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function PathUnmakeSystemFolder alias "PathUnmakeSystemFolderW"(byval pszPath as LPCWSTR) as WINBOOL
#else
	declare function PathUnmakeSystemFolder alias "PathUnmakeSystemFolderA"(byval pszPath as LPCSTR) as WINBOOL
#endif

declare function PathIsSystemFolderA(byval pszPath as LPCSTR, byval dwAttrb as DWORD) as WINBOOL
declare function PathIsSystemFolderW(byval pszPath as LPCWSTR, byval dwAttrb as DWORD) as WINBOOL

#ifdef UNICODE
	declare function PathIsSystemFolder alias "PathIsSystemFolderW"(byval pszPath as LPCWSTR, byval dwAttrb as DWORD) as WINBOOL
#else
	declare function PathIsSystemFolder alias "PathIsSystemFolderA"(byval pszPath as LPCSTR, byval dwAttrb as DWORD) as WINBOOL
#endif

declare sub PathUndecorateA(byval pszPath as LPSTR)
declare sub PathUndecorateW(byval pszPath as LPWSTR)

#ifdef UNICODE
	declare sub PathUndecorate alias "PathUndecorateW"(byval pszPath as LPWSTR)
#else
	declare sub PathUndecorate alias "PathUndecorateA"(byval pszPath as LPSTR)
#endif

declare function PathUnExpandEnvStringsA(byval pszPath as LPCSTR, byval pszBuf as LPSTR, byval cchBuf as UINT) as WINBOOL
declare function PathUnExpandEnvStringsW(byval pszPath as LPCWSTR, byval pszBuf as LPWSTR, byval cchBuf as UINT) as WINBOOL

#ifdef UNICODE
	declare function PathUnExpandEnvStrings alias "PathUnExpandEnvStringsW"(byval pszPath as LPCWSTR, byval pszBuf as LPWSTR, byval cchBuf as UINT) as WINBOOL
	declare function PathAppend alias "PathAppendW"(byval pszPath as LPWSTR, byval pMore as LPCWSTR) as WINBOOL
	declare function PathCanonicalize alias "PathCanonicalizeW"(byval pszBuf as LPWSTR, byval pszPath as LPCWSTR) as WINBOOL
	declare function PathCompactPath alias "PathCompactPathW"(byval hDC as HDC, byval pszPath as LPWSTR, byval dx as UINT) as WINBOOL
	declare function PathCompactPathEx alias "PathCompactPathExW"(byval pszOut as LPWSTR, byval pszSrc as LPCWSTR, byval cchMax as UINT, byval dwFlags as DWORD) as WINBOOL
	declare function PathCommonPrefix alias "PathCommonPrefixW"(byval pszFile1 as LPCWSTR, byval pszFile2 as LPCWSTR, byval achPath as LPWSTR) as long
	declare function PathFindOnPath alias "PathFindOnPathW"(byval pszPath as LPWSTR, byval ppszOtherDirs as LPCWSTR ptr) as WINBOOL
	declare function PathGetCharType alias "PathGetCharTypeW"(byval ch as WCHAR) as UINT
	declare function PathIsContentType alias "PathIsContentTypeW"(byval pszPath as LPCWSTR, byval pszContentType as LPCWSTR) as WINBOOL
	#define PathIsHTMLFile PathIsHTMLFileW
	declare function PathMakePretty alias "PathMakePrettyW"(byval pszPath as LPWSTR) as WINBOOL
	declare function PathMatchSpec alias "PathMatchSpecW"(byval pszFile as LPCWSTR, byval pszSpec as LPCWSTR) as WINBOOL
	declare function PathParseIconLocation alias "PathParseIconLocationW"(byval pszIconFile as LPWSTR) as long
	declare sub PathQuoteSpaces alias "PathQuoteSpacesW"(byval lpsz as LPWSTR)
	declare function PathRelativePathTo alias "PathRelativePathToW"(byval pszPath as LPWSTR, byval pszFrom as LPCWSTR, byval dwAttrFrom as DWORD, byval pszTo as LPCWSTR, byval dwAttrTo as DWORD) as WINBOOL
	declare sub PathRemoveArgs alias "PathRemoveArgsW"(byval pszPath as LPWSTR)
	declare sub PathRemoveBlanks alias "PathRemoveBlanksW"(byval pszPath as LPWSTR)
	declare sub PathRemoveExtension alias "PathRemoveExtensionW"(byval pszPath as LPWSTR)
	declare function PathRemoveFileSpec alias "PathRemoveFileSpecW"(byval pszPath as LPWSTR) as WINBOOL
	declare function PathRenameExtension alias "PathRenameExtensionW"(byval pszPath as LPWSTR, byval pszExt as LPCWSTR) as WINBOOL
	declare function PathSearchAndQualify alias "PathSearchAndQualifyW"(byval pszPath as LPCWSTR, byval pszBuf as LPWSTR, byval cchBuf as UINT) as WINBOOL
	declare sub PathSetDlgItemPath alias "PathSetDlgItemPathW"(byval hDlg as HWND, byval id as long, byval pszPath as LPCWSTR)
	declare sub PathUnquoteSpaces alias "PathUnquoteSpacesW"(byval lpsz as LPWSTR)
#else
	declare function PathUnExpandEnvStrings alias "PathUnExpandEnvStringsA"(byval pszPath as LPCSTR, byval pszBuf as LPSTR, byval cchBuf as UINT) as WINBOOL
	declare function PathAppend alias "PathAppendA"(byval pszPath as LPSTR, byval pMore as LPCSTR) as WINBOOL
	declare function PathCanonicalize alias "PathCanonicalizeA"(byval pszBuf as LPSTR, byval pszPath as LPCSTR) as WINBOOL
	declare function PathCompactPath alias "PathCompactPathA"(byval hDC as HDC, byval pszPath as LPSTR, byval dx as UINT) as WINBOOL
	declare function PathCompactPathEx alias "PathCompactPathExA"(byval pszOut as LPSTR, byval pszSrc as LPCSTR, byval cchMax as UINT, byval dwFlags as DWORD) as WINBOOL
	declare function PathCommonPrefix alias "PathCommonPrefixA"(byval pszFile1 as LPCSTR, byval pszFile2 as LPCSTR, byval achPath as LPSTR) as long
	declare function PathFindOnPath alias "PathFindOnPathA"(byval pszPath as LPSTR, byval ppszOtherDirs as LPCSTR ptr) as WINBOOL
	declare function PathGetCharType alias "PathGetCharTypeA"(byval ch as UCHAR) as UINT
	declare function PathIsContentType alias "PathIsContentTypeA"(byval pszPath as LPCSTR, byval pszContentType as LPCSTR) as WINBOOL
	#define PathIsHTMLFile PathIsHTMLFileA
	declare function PathMakePretty alias "PathMakePrettyA"(byval pszPath as LPSTR) as WINBOOL
	declare function PathMatchSpec alias "PathMatchSpecA"(byval pszFile as LPCSTR, byval pszSpec as LPCSTR) as WINBOOL
	declare function PathParseIconLocation alias "PathParseIconLocationA"(byval pszIconFile as LPSTR) as long
	declare sub PathQuoteSpaces alias "PathQuoteSpacesA"(byval lpsz as LPSTR)
	declare function PathRelativePathTo alias "PathRelativePathToA"(byval pszPath as LPSTR, byval pszFrom as LPCSTR, byval dwAttrFrom as DWORD, byval pszTo as LPCSTR, byval dwAttrTo as DWORD) as WINBOOL
	declare sub PathRemoveArgs alias "PathRemoveArgsA"(byval pszPath as LPSTR)
	declare sub PathRemoveBlanks alias "PathRemoveBlanksA"(byval pszPath as LPSTR)
	declare sub PathRemoveExtension alias "PathRemoveExtensionA"(byval pszPath as LPSTR)
	declare function PathRemoveFileSpec alias "PathRemoveFileSpecA"(byval pszPath as LPSTR) as WINBOOL
	declare function PathRenameExtension alias "PathRenameExtensionA"(byval pszPath as LPSTR, byval pszExt as LPCSTR) as WINBOOL
	declare function PathSearchAndQualify alias "PathSearchAndQualifyA"(byval pszPath as LPCSTR, byval pszBuf as LPSTR, byval cchBuf as UINT) as WINBOOL
	declare sub PathSetDlgItemPath alias "PathSetDlgItemPathA"(byval hDlg as HWND, byval id as long, byval pszPath as LPCSTR)
	declare sub PathUnquoteSpaces alias "PathUnquoteSpacesA"(byval lpsz as LPSTR)
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
const URL_DONT_UNESCAPE_EXTRA_INFO = URL_DONT_ESCAPE_EXTRA_INFO
const URL_BROWSER_MODE = URL_DONT_ESCAPE_EXTRA_INFO
const URL_ESCAPE_SPACES_ONLY = &h04000000
const URL_DONT_SIMPLIFY = &h08000000
const URL_NO_META = URL_DONT_SIMPLIFY
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
	declare function UrlCompare alias "UrlCompareW"(byval psz1 as LPCWSTR, byval psz2 as LPCWSTR, byval fIgnoreSlash as WINBOOL) as long
	declare function UrlCombine alias "UrlCombineW"(byval pszBase as LPCWSTR, byval pszRelative as LPCWSTR, byval pszCombined as LPWSTR, byval pcchCombined as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlCanonicalize alias "UrlCanonicalizeW"(byval pszUrl as LPCWSTR, byval pszCanonicalized as LPWSTR, byval pcchCanonicalized as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlIsOpaque alias "UrlIsOpaqueW"(byval pszURL as LPCWSTR) as WINBOOL
	#define UrlIsFileUrl UrlIsFileUrlW
	declare function UrlGetLocation alias "UrlGetLocationW"(byval psz1 as LPCWSTR) as LPCWSTR
	declare function UrlUnescape alias "UrlUnescapeW"(byval pszUrl as LPWSTR, byval pszUnescaped as LPWSTR, byval pcchUnescaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlEscape alias "UrlEscapeW"(byval pszUrl as LPCWSTR, byval pszEscaped as LPWSTR, byval pcchEscaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlCreateFromPath alias "UrlCreateFromPathW"(byval pszPath as LPCWSTR, byval pszUrl as LPWSTR, byval pcchUrl as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function PathCreateFromUrl alias "PathCreateFromUrlW"(byval pszUrl as LPCWSTR, byval pszPath as LPWSTR, byval pcchPath as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlHash alias "UrlHashW"(byval pszUrl as LPCWSTR, byval pbHash as LPBYTE, byval cbHash as DWORD) as HRESULT
	declare function UrlGetPart alias "UrlGetPartW"(byval pszIn as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as LPDWORD, byval dwPart as DWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlApplyScheme alias "UrlApplySchemeW"(byval pszIn as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlIs alias "UrlIsW"(byval pszUrl as LPCWSTR, byval UrlIs as URLIS) as WINBOOL
#else
	declare function UrlCompare alias "UrlCompareA"(byval psz1 as LPCSTR, byval psz2 as LPCSTR, byval fIgnoreSlash as WINBOOL) as long
	declare function UrlCombine alias "UrlCombineA"(byval pszBase as LPCSTR, byval pszRelative as LPCSTR, byval pszCombined as LPSTR, byval pcchCombined as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlCanonicalize alias "UrlCanonicalizeA"(byval pszUrl as LPCSTR, byval pszCanonicalized as LPSTR, byval pcchCanonicalized as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlIsOpaque alias "UrlIsOpaqueA"(byval pszURL as LPCSTR) as WINBOOL
	#define UrlIsFileUrl UrlIsFileUrlA
	declare function UrlGetLocation alias "UrlGetLocationA"(byval psz1 as LPCSTR) as LPCSTR
	declare function UrlUnescape alias "UrlUnescapeA"(byval pszUrl as LPSTR, byval pszUnescaped as LPSTR, byval pcchUnescaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlEscape alias "UrlEscapeA"(byval pszUrl as LPCSTR, byval pszEscaped as LPSTR, byval pcchEscaped as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlCreateFromPath alias "UrlCreateFromPathA"(byval pszPath as LPCSTR, byval pszUrl as LPSTR, byval pcchUrl as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function PathCreateFromUrl alias "PathCreateFromUrlA"(byval pszUrl as LPCSTR, byval pszPath as LPSTR, byval pcchPath as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlHash alias "UrlHashA"(byval pszUrl as LPCSTR, byval pbHash as LPBYTE, byval cbHash as DWORD) as HRESULT
	declare function UrlGetPart alias "UrlGetPartA"(byval pszIn as LPCSTR, byval pszOut as LPSTR, byval pcchOut as LPDWORD, byval dwPart as DWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlApplyScheme alias "UrlApplySchemeA"(byval pszIn as LPCSTR, byval pszOut as LPSTR, byval pcchOut as LPDWORD, byval dwFlags as DWORD) as HRESULT
	declare function UrlIs alias "UrlIsA"(byval pszUrl as LPCSTR, byval UrlIs as URLIS) as WINBOOL
#endif

#define UrlEscapeSpaces(pszUrl, pszEscaped, pcchEscaped) UrlCanonicalize(pszUrl, pszEscaped, pcchEscaped, URL_ESCAPE_SPACES_ONLY or URL_DONT_ESCAPE_EXTRA_INFO)
#define UrlUnescapeInPlace(pszUrl, dwFlags) UrlUnescape(pszUrl, NULL, NULL, dwFlags or URL_UNESCAPE_INPLACE)
declare function SHDeleteEmptyKeyA(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
declare function SHDeleteEmptyKeyW(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD

#ifdef UNICODE
	declare function SHDeleteEmptyKey alias "SHDeleteEmptyKeyW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD
#else
	declare function SHDeleteEmptyKey alias "SHDeleteEmptyKeyA"(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
#endif

declare function SHDeleteKeyA(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
declare function SHDeleteKeyW(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD

#ifdef UNICODE
	declare function SHDeleteKey alias "SHDeleteKeyW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR) as DWORD
#else
	declare function SHDeleteKey alias "SHDeleteKeyA"(byval hkey as HKEY, byval pszSubKey as LPCSTR) as DWORD
#endif

declare function SHRegDuplicateHKey(byval hkey as HKEY) as HKEY
declare function SHDeleteValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR) as DWORD
declare function SHDeleteValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR) as DWORD

#ifdef UNICODE
	declare function SHDeleteValue alias "SHDeleteValueW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR) as DWORD
#else
	declare function SHDeleteValue alias "SHDeleteValueA"(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR) as DWORD
#endif

declare function SHGetValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
declare function SHGetValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD

#ifdef UNICODE
	declare function SHGetValue alias "SHGetValueW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
#else
	declare function SHGetValue alias "SHGetValueA"(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
#endif

declare function SHSetValueA(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD
declare function SHSetValueW(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD

#ifdef UNICODE
	declare function SHSetValue alias "SHSetValueW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD
#elseif (not defined(UNICODE)) and (defined(__FB_64BIT__) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0502)))
	declare function SHSetValue alias "SHSetValueA"(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD
#endif

#if _WIN32_WINNT >= &h0502
	type SRRF as DWORD
	const SRRF_RT_REG_NONE = &h00000001
	const SRRF_RT_REG_SZ = &h00000002
	const SRRF_RT_REG_EXPAND_SZ = &h00000004
	const SRRF_RT_REG_BINARY = &h00000008
	const SRRF_RT_REG_DWORD = &h00000010
	const SRRF_RT_REG_MULTI_SZ = &h00000020
	const SRRF_RT_REG_QWORD = &h00000040
	const SRRF_RT_DWORD = SRRF_RT_REG_BINARY or SRRF_RT_REG_DWORD
	const SRRF_RT_QWORD = SRRF_RT_REG_BINARY or SRRF_RT_REG_QWORD
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

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	declare function SHRegGetValue alias "SHRegGetValueW"(byval hkey as HKEY, byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval dwFlags as SRRF, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as LONG
#elseif (not defined(__FB_64BIT__)) and (not defined(UNICODE)) and (_WIN32_WINNT <= &h0501)
	declare function SHSetValue alias "SHSetValueA"(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as LPCVOID, byval cbData as DWORD) as DWORD
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	declare function SHRegGetValue alias "SHRegGetValueA"(byval hkey as HKEY, byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwFlags as SRRF, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as LONG
#endif

declare function SHQueryValueExA(byval hkey as HKEY, byval pszValue as LPCSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD

#ifndef UNICODE
	declare function SHQueryValueEx alias "SHQueryValueExA"(byval hkey as HKEY, byval pszValue as LPCSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
#endif

declare function SHQueryValueExW(byval hkey as HKEY, byval pszValue as LPCWSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD

#ifdef UNICODE
	declare function SHQueryValueEx alias "SHQueryValueExW"(byval hkey as HKEY, byval pszValue as LPCWSTR, byval pdwReserved as DWORD ptr, byval pdwType as DWORD ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as DWORD
#endif

declare function SHEnumKeyExA(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPSTR, byval pcchName as LPDWORD) as LONG

#ifndef UNICODE
	declare function SHEnumKeyEx alias "SHEnumKeyExA"(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPSTR, byval pcchName as LPDWORD) as LONG
#endif

declare function SHEnumKeyExW(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPWSTR, byval pcchName as LPDWORD) as LONG

#ifdef UNICODE
	declare function SHEnumKeyEx alias "SHEnumKeyExW"(byval hkey as HKEY, byval dwIndex as DWORD, byval pszName as LPWSTR, byval pcchName as LPDWORD) as LONG
#endif

declare function SHEnumValueA(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG

#ifndef UNICODE
	declare function SHEnumValue alias "SHEnumValueA"(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG
#endif

declare function SHEnumValueW(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPWSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG

#ifdef UNICODE
	declare function SHEnumValue alias "SHEnumValueW"(byval hkey as HKEY, byval dwIndex as DWORD, byval pszValueName as LPWSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD) as LONG
#endif

declare function SHQueryInfoKeyA(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG

#ifndef UNICODE
	declare function SHQueryInfoKey alias "SHQueryInfoKeyA"(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG
#endif

declare function SHQueryInfoKeyW(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG

#ifdef UNICODE
	declare function SHQueryInfoKey alias "SHQueryInfoKeyW"(byval hkey as HKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD) as LONG
#endif

declare function SHCopyKeyA(byval hkeySrc as HKEY, byval szSrcSubKey as LPCSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD

#ifndef UNICODE
	declare function SHCopyKey alias "SHCopyKeyA"(byval hkeySrc as HKEY, byval szSrcSubKey as LPCSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD
#endif

declare function SHCopyKeyW(byval hkeySrc as HKEY, byval wszSrcSubKey as LPCWSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD

#ifdef UNICODE
	declare function SHCopyKey alias "SHCopyKeyW"(byval hkeySrc as HKEY, byval wszSrcSubKey as LPCWSTR, byval hkeyDest as HKEY, byval fReserved as DWORD) as DWORD
#endif

declare function SHRegGetPathA(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pszPath as LPSTR, byval dwFlags as DWORD) as DWORD

#ifndef UNICODE
	declare function SHRegGetPath alias "SHRegGetPathA"(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pszPath as LPSTR, byval dwFlags as DWORD) as DWORD
#endif

declare function SHRegGetPathW(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pszPath as LPWSTR, byval dwFlags as DWORD) as DWORD

#ifdef UNICODE
	declare function SHRegGetPath alias "SHRegGetPathW"(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pszPath as LPWSTR, byval dwFlags as DWORD) as DWORD
#endif

declare function SHRegSetPathA(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pcszPath as LPCSTR, byval dwFlags as DWORD) as DWORD

#ifndef UNICODE
	declare function SHRegSetPath alias "SHRegSetPathA"(byval hKey as HKEY, byval pcszSubKey as LPCSTR, byval pcszValue as LPCSTR, byval pcszPath as LPCSTR, byval dwFlags as DWORD) as DWORD
#endif

declare function SHRegSetPathW(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pcszPath as LPCWSTR, byval dwFlags as DWORD) as DWORD

#ifdef UNICODE
	declare function SHRegSetPath alias "SHRegSetPathW"(byval hKey as HKEY, byval pcszSubKey as LPCWSTR, byval pcszValue as LPCWSTR, byval pcszPath as LPCWSTR, byval dwFlags as DWORD) as DWORD
#endif

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
const SHREGSET_DEFAULT = SHREGSET_FORCE_HKCU or SHREGSET_HKLM
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
	declare function SHRegCreateUSKey alias "SHRegCreateUSKeyW"(byval pwzPath as LPCWSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval dwFlags as DWORD) as LONG
	declare function SHRegOpenUSKey alias "SHRegOpenUSKeyW"(byval pwzPath as LPCWSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval fIgnoreHKCU as WINBOOL) as LONG
	declare function SHRegQueryUSValue alias "SHRegQueryUSValueW"(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
	declare function SHRegWriteUSValue alias "SHRegWriteUSValueW"(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
	declare function SHRegDeleteUSValue alias "SHRegDeleteUSValueW"(byval hUSKey as HUSKEY, byval pwzValue as LPCWSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
	declare function SHRegDeleteEmptyUSKey alias "SHRegDeleteEmptyUSKeyW"(byval hUSKey as HUSKEY, byval pwzSubKey as LPCWSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
	declare function SHRegEnumUSKey alias "SHRegEnumUSKeyW"(byval hUSKey as HUSKEY, byval dwIndex as DWORD, byval pwzName as LPWSTR, byval pcchName as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegEnumUSValue alias "SHRegEnumUSValueW"(byval hUSkey as HUSKEY, byval dwIndex as DWORD, byval pszValueName as LPWSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegQueryInfoUSKey alias "SHRegQueryInfoUSKeyW"(byval hUSKey as HUSKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegGetUSValue alias "SHRegGetUSValueW"(byval pwzSubKey as LPCWSTR, byval pwzValue as LPCWSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
	declare function SHRegSetUSValue alias "SHRegSetUSValueW"(byval pwzSubKey as LPCWSTR, byval pwzValue as LPCWSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
	declare function SHRegGetInt alias "SHRegGetIntW"(byval hk as HKEY, byval pwzKey as LPCWSTR, byval iDefault as long) as long
#else
	declare function SHRegCreateUSKey alias "SHRegCreateUSKeyA"(byval pszPath as LPCSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval dwFlags as DWORD) as LONG
	declare function SHRegOpenUSKey alias "SHRegOpenUSKeyA"(byval pszPath as LPCSTR, byval samDesired as REGSAM, byval hRelativeUSKey as HUSKEY, byval phNewUSKey as PHUSKEY, byval fIgnoreHKCU as WINBOOL) as LONG
	declare function SHRegQueryUSValue alias "SHRegQueryUSValueA"(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
	declare function SHRegWriteUSValue alias "SHRegWriteUSValueA"(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
	declare function SHRegDeleteUSValue alias "SHRegDeleteUSValueA"(byval hUSKey as HUSKEY, byval pszValue as LPCSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
	declare function SHRegDeleteEmptyUSKey alias "SHRegDeleteEmptyUSKeyA"(byval hUSKey as HUSKEY, byval pszSubKey as LPCSTR, byval delRegFlags as SHREGDEL_FLAGS) as LONG
	declare function SHRegEnumUSKey alias "SHRegEnumUSKeyA"(byval hUSKey as HUSKEY, byval dwIndex as DWORD, byval pszName as LPSTR, byval pcchName as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegEnumUSValue alias "SHRegEnumUSValueA"(byval hUSkey as HUSKEY, byval dwIndex as DWORD, byval pszValueName as LPSTR, byval pcchValueName as LPDWORD, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegQueryInfoUSKey alias "SHRegQueryInfoUSKeyA"(byval hUSKey as HUSKEY, byval pcSubKeys as LPDWORD, byval pcchMaxSubKeyLen as LPDWORD, byval pcValues as LPDWORD, byval pcchMaxValueNameLen as LPDWORD, byval enumRegFlags as SHREGENUM_FLAGS) as LONG
	declare function SHRegGetUSValue alias "SHRegGetUSValueA"(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval pdwType as LPDWORD, byval pvData as any ptr, byval pcbData as LPDWORD, byval fIgnoreHKCU as WINBOOL, byval pvDefaultData as any ptr, byval dwDefaultDataSize as DWORD) as LONG
	declare function SHRegSetUSValue alias "SHRegSetUSValueA"(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval dwType as DWORD, byval pvData as const any ptr, byval cbData as DWORD, byval dwFlags as DWORD) as LONG
	#define SHRegGetInt SHRegGetIntA
#endif

declare function SHRegGetBoolUSValueA(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL

#ifndef UNICODE
	declare function SHRegGetBoolUSValue alias "SHRegGetBoolUSValueA"(byval pszSubKey as LPCSTR, byval pszValue as LPCSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL
#endif

declare function SHRegGetBoolUSValueW(byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function SHRegGetBoolUSValue alias "SHRegGetBoolUSValueW"(byval pszSubKey as LPCWSTR, byval pszValue as LPCWSTR, byval fIgnoreHKCU as WINBOOL, byval fDefault as WINBOOL) as WINBOOL
#endif

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

	#if _WIN32_WINNT >= &h0601
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

declare function AssocCreate(byval clsid as CLSID, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function AssocQueryStringA(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT

#ifndef UNICODE
	declare function AssocQueryString alias "AssocQueryStringA"(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT
#endif

declare function AssocQueryStringW(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT

#ifdef UNICODE
	declare function AssocQueryString alias "AssocQueryStringW"(byval flags as ASSOCF, byval str as ASSOCSTR, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT
#endif

declare function AssocQueryStringByKeyA(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT

#ifndef UNICODE
	declare function AssocQueryStringByKey alias "AssocQueryStringByKeyA"(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCSTR, byval pszOut as LPSTR, byval pcchOut as DWORD ptr) as HRESULT
#endif

declare function AssocQueryStringByKeyW(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT

#ifdef UNICODE
	declare function AssocQueryStringByKey alias "AssocQueryStringByKeyW"(byval flags as ASSOCF, byval str as ASSOCSTR, byval hkAssoc as HKEY, byval pszExtra as LPCWSTR, byval pszOut as LPWSTR, byval pcchOut as DWORD ptr) as HRESULT
#endif

declare function AssocQueryKeyA(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval phkeyOut as HKEY ptr) as HRESULT

#ifndef UNICODE
	declare function AssocQueryKey alias "AssocQueryKeyA"(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCSTR, byval pszExtra as LPCSTR, byval phkeyOut as HKEY ptr) as HRESULT
#endif

declare function AssocQueryKeyW(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval phkeyOut as HKEY ptr) as HRESULT

#ifdef UNICODE
	declare function AssocQueryKey alias "AssocQueryKeyW"(byval flags as ASSOCF, byval key as ASSOCKEY, byval pszAssoc as LPCWSTR, byval pszExtra as LPCWSTR, byval phkeyOut as HKEY ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0502
	declare function AssocIsDangerous(byval pszAssoc as LPCWSTR) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function AssocGetPerceivedType(byval pszExt as LPCWSTR, byval ptype as PERCEIVED ptr, byval pflag as PERCEIVEDFLAG ptr, byval ppszType as LPWSTR ptr) as HRESULT
#endif

declare function SHOpenRegStreamA(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr

#ifndef UNICODE
	declare function SHOpenRegStream alias "SHOpenRegStreamA"(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr
#endif

declare function SHOpenRegStreamW(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr

#ifdef UNICODE
	declare function SHOpenRegStream alias "SHOpenRegStreamW"(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr
#endif

declare function SHOpenRegStream2A(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr

#ifndef UNICODE
	declare function SHOpenRegStream2 alias "SHOpenRegStream2A"(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr
#endif

declare function SHOpenRegStream2W(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr

#ifdef UNICODE
	declare function SHOpenRegStream2 alias "SHOpenRegStream2W"(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr
#endif

#undef SHOpenRegStream

#ifdef UNICODE
	declare function SHOpenRegStream alias "SHOpenRegStream2W"(byval hkey as HKEY, byval pszSubkey as LPCWSTR, byval pszValue as LPCWSTR, byval grfMode as DWORD) as IStream ptr
#else
	declare function SHOpenRegStream alias "SHOpenRegStream2A"(byval hkey as HKEY, byval pszSubkey as LPCSTR, byval pszValue as LPCSTR, byval grfMode as DWORD) as IStream ptr
#endif

declare function SHCreateStreamOnFileA(byval pszFile as LPCSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT

#ifndef UNICODE
	declare function SHCreateStreamOnFile alias "SHCreateStreamOnFileA"(byval pszFile as LPCSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT
#endif

declare function SHCreateStreamOnFileW(byval pszFile as LPCWSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT

#ifdef UNICODE
	declare function SHCreateStreamOnFile alias "SHCreateStreamOnFileW"(byval pszFile as LPCWSTR, byval grfMode as DWORD, byval ppstm as IStream ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0501
	declare function SHCreateStreamOnFileEx(byval pszFile as LPCWSTR, byval grfMode as DWORD, byval dwAttributes as DWORD, byval fCreate as WINBOOL, byval pstmTemplate as IStream ptr, byval ppstm as IStream ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetAcceptLanguagesA(byval psz as LPSTR, byval pcch as DWORD ptr) as HRESULT
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetAcceptLanguages alias "GetAcceptLanguagesA"(byval psz as LPSTR, byval pcch as DWORD ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetAcceptLanguagesW(byval psz as LPWSTR, byval pcch as DWORD ptr) as HRESULT
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function GetAcceptLanguages alias "GetAcceptLanguagesW"(byval psz as LPWSTR, byval pcch as DWORD ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0502
	const SHGVSPB_PERUSER = &h00000001
	const SHGVSPB_ALLUSERS = &h00000002
	const SHGVSPB_PERFOLDER = &h00000004
	const SHGVSPB_ALLFOLDERS = &h00000008
	const SHGVSPB_INHERIT = &h00000010
	const SHGVSPB_ROAM = &h00000020
	const SHGVSPB_NOAUTODEFAULTS = &h80000000
	const SHGVSPB_FOLDER = SHGVSPB_PERUSER or SHGVSPB_PERFOLDER
	const SHGVSPB_FOLDERNODEFAULTS = (SHGVSPB_PERUSER or SHGVSPB_PERFOLDER) or SHGVSPB_NOAUTODEFAULTS
	const SHGVSPB_USERDEFAULTS = SHGVSPB_PERUSER or SHGVSPB_ALLFOLDERS
	const SHGVSPB_GLOBALDEAFAULTS = SHGVSPB_ALLUSERS or SHGVSPB_ALLFOLDERS
	declare function SHGetViewStatePropertyBag(byval pidl as LPCITEMIDLIST, byval pszBagName as LPCWSTR, byval dwFlags as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
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

#if _WIN32_WINNT >= &h0501
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

#if _WIN32_WINNT >= &h0600
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

#if _WIN32_WINNT >= &h0502
	declare function IsInternetESCEnabled() as WINBOOL
#endif

end extern
