''
''
'' intshcut -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_intshcut_bi__
#define __win_intshcut_bi__

#inclib "url"

#include once "win/objbase.bi"
#include once "win/isguids.bi"

enum IURL_SETURL_FLAGS
	IURL_SETURL_FL_GUESS_PROTOCOL = 1
	IURL_SETURL_FL_USE_DEFAULT_PROTOCOL
	ALL_IURL_SETURL_FLAGS = (IURL_SETURL_FL_GUESS_PROTOCOL or IURL_SETURL_FL_USE_DEFAULT_PROTOCOL)
end enum

enum IURL_INVOKECOMMAND_FLAGS
	IURL_INVOKECOMMAND_FL_ALLOW_UI = 1
	IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB
	ALL_IURL_INVOKECOMMAND_FLAGS = (IURL_INVOKECOMMAND_FL_ALLOW_UI or IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB)
end enum

enum TRANSLATEURL_IN_FLAGS
	TRANSLATEURL_FL_GUESS_PROTOCOL = 1
	TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL
	ALL_TRANSLATEURL_FLAGS = (TRANSLATEURL_FL_GUESS_PROTOCOL or TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL)
end enum

enum URLASSOCIATIONDIALOG_IN_FLAGS
	URLASSOCDLG_FL_USE_DEFAULT_NAME = 1
	URLASSOCDLG_FL_REGISTER_ASSOC
	ALL_URLASSOCDLG_FLAGS = (URLASSOCDLG_FL_USE_DEFAULT_NAME or URLASSOCDLG_FL_REGISTER_ASSOC)
end enum

enum MIMEASSOCIATIONDIALOG_IN_FLAGS
	MIMEASSOCDLG_FL_REGISTER_ASSOC = 1
	ALL_MIMEASSOCDLG_FLAGS = MIMEASSOCDLG_FL_REGISTER_ASSOC
end enum

type URLINVOKECOMMANDINFO
	dwcbSize as DWORD
	dwFlags as DWORD
	hwndParent as HWND
	pcszVerb as PCSTR
end type

type PURLINVOKECOMMANDINFO as URLINVOKECOMMANDINFO ptr
type CURLINVOKECOMMANDINFO as URLINVOKECOMMANDINFO
type PCURLINVOKECOMMANDINFO as URLINVOKECOMMANDINFO ptr

type IUniformResourceLocatorVtbl_ as IUniformResourceLocatorVtbl

type IUniformResourceLocator
	lpVtbl as IUniformResourceLocatorVtbl_ ptr
end type

type IUniformResourceLocatorVtbl
	QueryInterface as function(byval as IUniformResourceLocator ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IUniformResourceLocator ptr) as ULONG
	Release as function(byval as IUniformResourceLocator ptr) as ULONG
	SetURL as function(byval as IUniformResourceLocator ptr, byval as PCSTR, byval as DWORD) as HRESULT
	GetURL as function(byval as IUniformResourceLocator ptr, byval as PSTR ptr) as HRESULT
	InvokeCommand as function(byval as IUniformResourceLocator ptr, byval as PURLINVOKECOMMANDINFO) as HRESULT
end type

type PIUniformResourceLocator as IUniformResourceLocator ptr
type CIUniformResourceLocator as IUniformResourceLocator
type PCIUniformResourceLocator as IUniformResourceLocator ptr

declare function InetIsOffline alias "InetIsOffline" (byval as DWORD) as BOOL

#ifdef UNICODE
declare function MIMEAssociationDialog alias "MIMEAssociationDialogW" (byval as HWND, byval as DWORD, byval as PCWSTR, byval as PCWSTR, byval as PWSTR, byval as UINT) as HRESULT
declare function TranslateURL alias "TranslateURLW" (byval as PCWSTR, byval as DWORD, byval as PWSTR ptr) as HRESULT
declare function URLAssociationDialog alias "URLAssociationDialogW" (byval as HWND, byval as DWORD, byval as PCWSTR, byval as PCWSTR, byval as PWSTR, byval as UINT) as HRESULT

#else
declare function MIMEAssociationDialog alias "MIMEAssociationDialogA" (byval as HWND, byval as DWORD, byval as PCSTR, byval as PCSTR, byval as PSTR, byval as UINT) as HRESULT
declare function TranslateURL alias "TranslateURLA" (byval as PCSTR, byval as DWORD, byval as PSTR ptr) as HRESULT
declare function URLAssociationDialog alias "URLAssociationDialogA" (byval as HWND, byval as DWORD, byval as PCSTR, byval as PCSTR, byval as PSTR, byval as UINT) as HRESULT
#endif

#endif
