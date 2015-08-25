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

#inclib "url"

#include once "_mingw_unicode.bi"
#include once "isguids.bi"

extern "Windows"

#define __INTSHCUT_H__
#define E_FLAGS MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h1000)
#define IS_E_EXEC_FAILED MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h2002)
#define URL_E_INVALID_SYNTAX MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h1001)
#define URL_E_UNREGISTERED_PROTOCOL MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h1002)

type IURL_SETURL_FLAGS as long
enum
	IURL_SETURL_FL_GUESS_PROTOCOL = &h0001
	IURL_SETURL_FL_USE_DEFAULT_PROTOCOL = &h0002
end enum

type IURL_INVOKECOMMAND_FLAGS as long
enum
	IURL_INVOKECOMMAND_FL_ALLOW_UI = &h0001
	IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB = &h0002
	IURL_INVOKECOMMAND_FL_DDEWAIT = &h0004
end enum

type URLINVOKECOMMANDINFOA
	dwcbSize as DWORD
	dwFlags as DWORD
	hwndParent as HWND
	pcszVerb as LPCSTR
end type

type PURLINVOKECOMMANDINFOA as URLINVOKECOMMANDINFOA ptr
type CURLINVOKECOMMANDINFOA as const URLINVOKECOMMANDINFOA
type PCURLINVOKECOMMANDINFOA as const URLINVOKECOMMANDINFOA ptr

type URLINVOKECOMMANDINFOW
	dwcbSize as DWORD
	dwFlags as DWORD
	hwndParent as HWND
	pcszVerb as LPCWSTR
end type

type PURLINVOKECOMMANDINFOW as URLINVOKECOMMANDINFOW ptr
type CURLINVOKECOMMANDINFOW as const URLINVOKECOMMANDINFOW
type PCURLINVOKECOMMANDINFOW as const URLINVOKECOMMANDINFOW ptr

#ifdef UNICODE
	type URLINVOKECOMMANDINFO as URLINVOKECOMMANDINFOW
	type PURLINVOKECOMMANDINFO as PURLINVOKECOMMANDINFOW
	type CURLINVOKECOMMANDINFO as CURLINVOKECOMMANDINFOW
	type PCURLINVOKECOMMANDINFO as PCURLINVOKECOMMANDINFOW
#else
	type URLINVOKECOMMANDINFO as URLINVOKECOMMANDINFOA
	type PURLINVOKECOMMANDINFO as PURLINVOKECOMMANDINFOA
	type CURLINVOKECOMMANDINFO as CURLINVOKECOMMANDINFOA
	type PCURLINVOKECOMMANDINFO as PCURLINVOKECOMMANDINFOA
#endif

type IUniformResourceLocatorAVtbl as IUniformResourceLocatorAVtbl_

type IUniformResourceLocatorA
	lpVtbl as IUniformResourceLocatorAVtbl ptr
end type

type IUniformResourceLocatorAVtbl_
	QueryInterface as function(byval This as IUniformResourceLocatorA ptr, byval riid as const IID const ptr, byval ppvObject as PVOID ptr) as HRESULT
	AddRef as function(byval This as IUniformResourceLocatorA ptr) as ULONG
	Release as function(byval This as IUniformResourceLocatorA ptr) as ULONG
	SetURL as function(byval This as IUniformResourceLocatorA ptr, byval pcszURL as LPCSTR, byval dwInFlags as DWORD) as HRESULT
	GetURL as function(byval This as IUniformResourceLocatorA ptr, byval ppszURL as LPSTR ptr) as HRESULT
	InvokeCommand as function(byval This as IUniformResourceLocatorA ptr, byval purlici as PURLINVOKECOMMANDINFOA) as HRESULT
end type

type IUniformResourceLocatorWVtbl as IUniformResourceLocatorWVtbl_

type IUniformResourceLocatorW
	lpVtbl as IUniformResourceLocatorWVtbl ptr
end type

type IUniformResourceLocatorWVtbl_
	QueryInterface as function(byval This as IUniformResourceLocatorW ptr, byval riid as const IID const ptr, byval ppvObject as PVOID ptr) as HRESULT
	AddRef as function(byval This as IUniformResourceLocatorW ptr) as ULONG
	Release as function(byval This as IUniformResourceLocatorW ptr) as ULONG
	SetURL as function(byval This as IUniformResourceLocatorW ptr, byval pcszURL as LPCWSTR, byval dwInFlags as DWORD) as HRESULT
	GetURL as function(byval This as IUniformResourceLocatorW ptr, byval ppszURL as LPWSTR ptr) as HRESULT
	InvokeCommand as function(byval This as IUniformResourceLocatorW ptr, byval purlici as PURLINVOKECOMMANDINFOW) as HRESULT
end type

#ifdef UNICODE
	type IUniformResourceLocator as IUniformResourceLocatorW
	type IUniformResourceLocatorVtbl as IUniformResourceLocatorWVtbl
	type PIUniformResourceLocator as IUniformResourceLocatorW ptr
	type CIUniformResourceLocator as const IUniformResourceLocatorW
	type PCIUniformResourceLocator as const IUniformResourceLocatorW ptr
#else
	type IUniformResourceLocator as IUniformResourceLocatorA
	type IUniformResourceLocatorVtbl as IUniformResourceLocatorAVtbl
	type PIUniformResourceLocator as IUniformResourceLocatorA ptr
	type CIUniformResourceLocator as const IUniformResourceLocatorA
	type PCIUniformResourceLocator as const IUniformResourceLocatorA ptr
#endif

type TRANSLATEURL_IN_FLAGS as long
enum
	TRANSLATEURL_FL_GUESS_PROTOCOL = &h0001
	TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL = &h0002
end enum

declare function TranslateURLA(byval pcszURL as PCSTR, byval dwInFlags as DWORD, byval ppszTranslatedURL as PSTR ptr) as HRESULT
declare function TranslateURLW(byval pcszURL as PCWSTR, byval dwInFlags as DWORD, byval ppszTranslatedURL as PWSTR ptr) as HRESULT

#ifdef UNICODE
	declare function TranslateURL alias "TranslateURLW"(byval pcszURL as PCWSTR, byval dwInFlags as DWORD, byval ppszTranslatedURL as PWSTR ptr) as HRESULT
#else
	declare function TranslateURL alias "TranslateURLA"(byval pcszURL as PCSTR, byval dwInFlags as DWORD, byval ppszTranslatedURL as PSTR ptr) as HRESULT
#endif

type URLASSOCIATIONDIALOG_IN_FLAGS as long
enum
	URLASSOCDLG_FL_USE_DEFAULT_NAME = &h0001
	URLASSOCDLG_FL_REGISTER_ASSOC = &h0002
end enum

declare function URLAssociationDialogA(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCSTR, byval pcszURL as PCSTR, byval pszAppBuf as PSTR, byval ucAppBufLen as UINT) as HRESULT
declare function URLAssociationDialogW(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCWSTR, byval pcszURL as PCWSTR, byval pszAppBuf as PWSTR, byval ucAppBufLen as UINT) as HRESULT

#ifdef UNICODE
	declare function URLAssociationDialog alias "URLAssociationDialogW"(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCWSTR, byval pcszURL as PCWSTR, byval pszAppBuf as PWSTR, byval ucAppBufLen as UINT) as HRESULT
#else
	declare function URLAssociationDialog alias "URLAssociationDialogA"(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCSTR, byval pcszURL as PCSTR, byval pszAppBuf as PSTR, byval ucAppBufLen as UINT) as HRESULT
#endif

type MIMEASSOCIATIONDIALOG_IN_FLAGS as long
enum
	MIMEASSOCDLG_FL_REGISTER_ASSOC = &h0001
end enum

declare function MIMEAssociationDialogA(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCSTR, byval pcszMIMEContentType as PCSTR, byval pszAppBuf as PSTR, byval ucAppBufLen as UINT) as HRESULT
declare function MIMEAssociationDialogW(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCWSTR, byval pcszMIMEContentType as PCWSTR, byval pszAppBuf as PWSTR, byval ucAppBufLen as UINT) as HRESULT

#ifdef UNICODE
	declare function MIMEAssociationDialog alias "MIMEAssociationDialogW"(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCWSTR, byval pcszMIMEContentType as PCWSTR, byval pszAppBuf as PWSTR, byval ucAppBufLen as UINT) as HRESULT
#else
	declare function MIMEAssociationDialog alias "MIMEAssociationDialogA"(byval hwndParent as HWND, byval dwInFlags as DWORD, byval pcszFile as PCSTR, byval pcszMIMEContentType as PCSTR, byval pszAppBuf as PSTR, byval ucAppBufLen as UINT) as HRESULT
#endif

declare function InetIsOffline(byval dwFlags as DWORD) as WINBOOL

end extern
