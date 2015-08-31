'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "ocidl.bi"
#include once "objidl.bi"
#include once "oleidl.bi"
#include once "oaidl.bi"
#include once "docobj.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __mshtmhst_h__
#define __IHostDialogHelper_FWD_DEFINED__
#define __HostDialogHelper_FWD_DEFINED__
#define __IDocHostUIHandler_FWD_DEFINED__
#define __IDocHostUIHandler2_FWD_DEFINED__
#define __ICustomDoc_FWD_DEFINED__
#define __IDocHostShowUI_FWD_DEFINED__
#define __IClassFactoryEx_FWD_DEFINED__
#define __IHTMLOMWindowServices_FWD_DEFINED__
#define MSHTMHST_H
const CONTEXT_MENU_DEFAULT = 0
const CONTEXT_MENU_IMAGE = 1
const CONTEXT_MENU_CONTROL = 2
const CONTEXT_MENU_TABLE = 3
const CONTEXT_MENU_TEXTSELECT = 4
const CONTEXT_MENU_ANCHOR = 5
const CONTEXT_MENU_UNKNOWN = 6
const CONTEXT_MENU_IMGDYNSRC = 7
const CONTEXT_MENU_DEBUG = 8
const CONTEXT_MENU_VSCROLL = 9
const CONTEXT_MENU_HSCROLL = 10
const CONTEXT_MENU_MEDIA = 11
const MENUEXT_SHOWDIALOG = &h1
const CMDID_SCRIPTSITE_URL = 0
const CMDID_SCRIPTSITE_HTMLDLGTRUST = 1
const CMDID_SCRIPTSITE_SECSTATE = 2
const CMDID_SCRIPTSITE_SID = 3
const CMDID_SCRIPTSITE_TRUSTEDDOC = 4
const CMDID_SCRIPTSITE_SECURITY_WINDOW = 5
const CMDID_SCRIPTSITE_NAMESPACE = 6
const CMDID_SCRIPTSITE_IURI = 7
const CMDID_HOSTCONTEXT_URL = 8
const CMDID_SCRIPTSITE_ALLOWRECOVERY = 9
const HTMLDLG_NOUI = &h10
const HTMLDLG_MODAL = &h20
const HTMLDLG_MODELESS = &h40
const HTMLDLG_PRINT_TEMPLATE = &h80
const HTMLDLG_VERIFY = &h100
const HTMLDLG_ALLOW_UNKNOWN_THREAD = &h200
const PRINT_DONTBOTHERUSER = &h1
const PRINT_WAITFORCOMPLETION = &h2
#define CMDSETID_Forms3 CGID_MSHTML
#define SZ_HTML_CLIENTSITE_OBJECTPARAM wstr("{d4db6850-5385-11d0-89e9-00a0c90a90ac}")

extern CGID_ScriptSite as const GUID
extern CGID_MSHTML as const GUID
extern CLSID_HostDialogHelper as const GUID
extern CGID_DocHostCommandHandler as const GUID
#define __IHTMLWindow2_FWD_DEFINED__
declare function ShowHTMLDialog(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as LPWSTR, byval pvarArgOut as VARIANT ptr) as HRESULT
declare function ShowHTMLDialogEx(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval dwDialogFlags as DWORD, byval pvarArgIn as VARIANT ptr, byval pchOptions as LPWSTR, byval pvarArgOut as VARIANT ptr) as HRESULT
type IHTMLWindow2 as IHTMLWindow2_

declare function ShowModelessHTMLDialog(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pvarOptions as VARIANT ptr, byval ppWindow as IHTMLWindow2 ptr ptr) as HRESULT
declare function RunHTMLApplication(byval hinst as HINSTANCE, byval hPrevInst as HINSTANCE, byval szCmdLine as LPSTR, byval nCmdShow as long) as HRESULT
declare function CreateHTMLPropertyPage(byval pmk as IMoniker ptr, byval ppPP as IPropertyPage ptr ptr) as HRESULT
declare function EarlyStartDisplaySystem() as HRESULT
declare function IERegisterXMLNS(byval lpszURI as LPCWSTR, byval clsid as GUID, byval fMachine as BOOL) as HRESULT
declare function IEIsXMLNSRegistered(byval lpszURI as LPCWSTR, byval pCLSID as GUID ptr) as HRESULT
declare function GetColorValueFromString(byval lpszColor as LPCWSTR, byval fStrictCSS1 as BOOL, byval fIsStandardsCSS as BOOL, byval pColor as COLORREF ptr) as HRESULT

type tagDOCHOSTUIDBLCLK as long
enum
	DOCHOSTUIDBLCLK_DEFAULT = 0
	DOCHOSTUIDBLCLK_SHOWPROPERTIES = 1
	DOCHOSTUIDBLCLK_SHOWCODE = 2
end enum

type DOCHOSTUIDBLCLK as tagDOCHOSTUIDBLCLK

type tagDOCHOSTUIFLAG as long
enum
	DOCHOSTUIFLAG_DIALOG = &h1
	DOCHOSTUIFLAG_DISABLE_HELP_MENU = &h2
	DOCHOSTUIFLAG_NO3DBORDER = &h4
	DOCHOSTUIFLAG_SCROLL_NO = &h8
	DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE = &h10
	DOCHOSTUIFLAG_OPENNEWWIN = &h20
	DOCHOSTUIFLAG_DISABLE_OFFSCREEN = &h40
	DOCHOSTUIFLAG_FLAT_SCROLLBAR = &h80
	DOCHOSTUIFLAG_DIV_BLOCKDEFAULT = &h100
	DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY = &h200
	DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY = &h400
	DOCHOSTUIFLAG_CODEPAGELINKEDFONTS = &h800
	DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8 = &h1000
	DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8 = &h2000
	DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE = &h4000
	DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION = &h10000
	DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION = &h20000
	DOCHOSTUIFLAG_THEME = &h40000
	DOCHOSTUIFLAG_NOTHEME = &h80000
	DOCHOSTUIFLAG_NOPICS = &h100000
	DOCHOSTUIFLAG_NO3DOUTERBORDER = &h200000
	DOCHOSTUIFLAG_DISABLE_EDIT_NS_FIXUP = &h400000
	DOCHOSTUIFLAG_LOCAL_MACHINE_ACCESS_CHECK = &h800000
	DOCHOSTUIFLAG_DISABLE_UNTRUSTEDPROTOCOL = &h1000000
	DOCHOSTUIFLAG_HOST_NAVIGATES = &h2000000
	DOCHOSTUIFLAG_ENABLE_REDIRECT_NOTIFICATION = &h4000000
	DOCHOSTUIFLAG_USE_WINDOWLESS_SELECTCONTROL = &h8000000
	DOCHOSTUIFLAG_USE_WINDOWED_SELECTCONTROL = &h10000000
	DOCHOSTUIFLAG_ENABLE_ACTIVEX_INACTIVATE_MODE = &h20000000
	DOCHOSTUIFLAG_DPI_AWARE = &h40000000
end enum

type DOCHOSTUIFLAG as tagDOCHOSTUIFLAG
const DOCHOSTUIFLAG_BROWSER = DOCHOSTUIFLAG_DISABLE_HELP_MENU or DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE

type tagDOCHOSTUITYPE as long
enum
	DOCHOSTUITYPE_BROWSE = 0
	DOCHOSTUITYPE_AUTHOR = 1
end enum

type DOCHOSTUITYPE as tagDOCHOSTUITYPE

type _DOCHOSTUIINFO
	cbSize as ULONG
	dwFlags as DWORD
	dwDoubleClick as DWORD
	pchHostCss as OLECHAR ptr
	pchHostNS as OLECHAR ptr
end type

type DOCHOSTUIINFO as _DOCHOSTUIINFO
#define __IHostDialogHelper_INTERFACE_DEFINED__
extern IID_IHostDialogHelper as const GUID
type IHostDialogHelper as IHostDialogHelper_

type IHostDialogHelperVtbl
	QueryInterface as function(byval This as IHostDialogHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHostDialogHelper ptr) as ULONG
	Release as function(byval This as IHostDialogHelper ptr) as ULONG
	ShowHTMLDialog as function(byval This as IHostDialogHelper ptr, byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as WCHAR ptr, byval pvarArgOut as VARIANT ptr, byval punkHost as IUnknown ptr) as HRESULT
end type

type IHostDialogHelper_
	lpVtbl as IHostDialogHelperVtbl ptr
end type

#define IHostDialogHelper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHostDialogHelper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHostDialogHelper_Release(This) (This)->lpVtbl->Release(This)
#define IHostDialogHelper_ShowHTMLDialog(This, hwndParent, pMk, pvarArgIn, pchOptions, pvarArgOut, punkHost) (This)->lpVtbl->ShowHTMLDialog(This, hwndParent, pMk, pvarArgIn, pchOptions, pvarArgOut, punkHost)
declare function IHostDialogHelper_ShowHTMLDialog_Proxy(byval This as IHostDialogHelper ptr, byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as WCHAR ptr, byval pvarArgOut as VARIANT ptr, byval punkHost as IUnknown ptr) as HRESULT
declare sub IHostDialogHelper_ShowHTMLDialog_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern CLSID_HostDialogHelper as const GUID
#define __IDocHostUIHandler_INTERFACE_DEFINED__
extern IID_IDocHostUIHandler as const GUID
type IDocHostUIHandler as IDocHostUIHandler_

type IDocHostUIHandlerVtbl
	QueryInterface as function(byval This as IDocHostUIHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDocHostUIHandler ptr) as ULONG
	Release as function(byval This as IDocHostUIHandler ptr) as ULONG
	ShowContextMenu as function(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval ppt as POINT ptr, byval pcmdtReserved as IUnknown ptr, byval pdispReserved as IDispatch ptr) as HRESULT
	GetHostInfo as function(byval This as IDocHostUIHandler ptr, byval pInfo as DOCHOSTUIINFO ptr) as HRESULT
	ShowUI as function(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pCommandTarget as IOleCommandTarget ptr, byval pFrame as IOleInPlaceFrame ptr, byval pDoc as IOleInPlaceUIWindow ptr) as HRESULT
	HideUI as function(byval This as IDocHostUIHandler ptr) as HRESULT
	UpdateUI as function(byval This as IDocHostUIHandler ptr) as HRESULT
	EnableModeless as function(byval This as IDocHostUIHandler ptr, byval fEnable as WINBOOL) as HRESULT
	OnDocWindowActivate as function(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
	OnFrameWindowActivate as function(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
	ResizeBorder as function(byval This as IDocHostUIHandler ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fRameWindow as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IDocHostUIHandler ptr, byval lpMsg as LPMSG, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD) as HRESULT
	GetOptionKeyPath as function(byval This as IDocHostUIHandler ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
	GetDropTarget as function(byval This as IDocHostUIHandler ptr, byval pDropTarget as IDropTarget ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
	GetExternal as function(byval This as IDocHostUIHandler ptr, byval ppDispatch as IDispatch ptr ptr) as HRESULT
	TranslateUrl as function(byval This as IDocHostUIHandler ptr, byval dwTranslate as DWORD, byval pchURLIn as LPWSTR, byval ppchURLOut as LPWSTR ptr) as HRESULT
	FilterDataObject as function(byval This as IDocHostUIHandler ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
end type

type IDocHostUIHandler_
	lpVtbl as IDocHostUIHandlerVtbl ptr
end type

#define IDocHostUIHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDocHostUIHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDocHostUIHandler_Release(This) (This)->lpVtbl->Release(This)
#define IDocHostUIHandler_ShowContextMenu(This, dwID, ppt, pcmdtReserved, pdispReserved) (This)->lpVtbl->ShowContextMenu(This, dwID, ppt, pcmdtReserved, pdispReserved)
#define IDocHostUIHandler_GetHostInfo(This, pInfo) (This)->lpVtbl->GetHostInfo(This, pInfo)
#define IDocHostUIHandler_ShowUI(This, dwID, pActiveObject, pCommandTarget, pFrame, pDoc) (This)->lpVtbl->ShowUI(This, dwID, pActiveObject, pCommandTarget, pFrame, pDoc)
#define IDocHostUIHandler_HideUI(This) (This)->lpVtbl->HideUI(This)
#define IDocHostUIHandler_UpdateUI(This) (This)->lpVtbl->UpdateUI(This)
#define IDocHostUIHandler_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)
#define IDocHostUIHandler_OnDocWindowActivate(This, fActivate) (This)->lpVtbl->OnDocWindowActivate(This, fActivate)
#define IDocHostUIHandler_OnFrameWindowActivate(This, fActivate) (This)->lpVtbl->OnFrameWindowActivate(This, fActivate)
#define IDocHostUIHandler_ResizeBorder(This, prcBorder, pUIWindow, fRameWindow) (This)->lpVtbl->ResizeBorder(This, prcBorder, pUIWindow, fRameWindow)
#define IDocHostUIHandler_TranslateAccelerator(This, lpMsg, pguidCmdGroup, nCmdID) (This)->lpVtbl->TranslateAccelerator(This, lpMsg, pguidCmdGroup, nCmdID)
#define IDocHostUIHandler_GetOptionKeyPath(This, pchKey, dw) (This)->lpVtbl->GetOptionKeyPath(This, pchKey, dw)
#define IDocHostUIHandler_GetDropTarget(This, pDropTarget, ppDropTarget) (This)->lpVtbl->GetDropTarget(This, pDropTarget, ppDropTarget)
#define IDocHostUIHandler_GetExternal(This, ppDispatch) (This)->lpVtbl->GetExternal(This, ppDispatch)
#define IDocHostUIHandler_TranslateUrl(This, dwTranslate, pchURLIn, ppchURLOut) (This)->lpVtbl->TranslateUrl(This, dwTranslate, pchURLIn, ppchURLOut)
#define IDocHostUIHandler_FilterDataObject(This, pDO, ppDORet) (This)->lpVtbl->FilterDataObject(This, pDO, ppDORet)

declare function IDocHostUIHandler_ShowContextMenu_Proxy(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval ppt as POINT ptr, byval pcmdtReserved as IUnknown ptr, byval pdispReserved as IDispatch ptr) as HRESULT
declare sub IDocHostUIHandler_ShowContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetHostInfo_Proxy(byval This as IDocHostUIHandler ptr, byval pInfo as DOCHOSTUIINFO ptr) as HRESULT
declare sub IDocHostUIHandler_GetHostInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ShowUI_Proxy(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pCommandTarget as IOleCommandTarget ptr, byval pFrame as IOleInPlaceFrame ptr, byval pDoc as IOleInPlaceUIWindow ptr) as HRESULT
declare sub IDocHostUIHandler_ShowUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_HideUI_Proxy(byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_HideUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_UpdateUI_Proxy(byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_UpdateUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_EnableModeless_Proxy(byval This as IDocHostUIHandler ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnDocWindowActivate_Proxy(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_OnDocWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnFrameWindowActivate_Proxy(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_OnFrameWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ResizeBorder_Proxy(byval This as IDocHostUIHandler ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fRameWindow as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_ResizeBorder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateAccelerator_Proxy(byval This as IDocHostUIHandler ptr, byval lpMsg as LPMSG, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD) as HRESULT
declare sub IDocHostUIHandler_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetOptionKeyPath_Proxy(byval This as IDocHostUIHandler ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
declare sub IDocHostUIHandler_GetOptionKeyPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetDropTarget_Proxy(byval This as IDocHostUIHandler ptr, byval pDropTarget as IDropTarget ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetDropTarget_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetExternal_Proxy(byval This as IDocHostUIHandler ptr, byval ppDispatch as IDispatch ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetExternal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateUrl_Proxy(byval This as IDocHostUIHandler ptr, byval dwTranslate as DWORD, byval pchURLIn as LPWSTR, byval ppchURLOut as LPWSTR ptr) as HRESULT
declare sub IDocHostUIHandler_TranslateUrl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_FilterDataObject_Proxy(byval This as IDocHostUIHandler ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
declare sub IDocHostUIHandler_FilterDataObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDocHostUIHandler2_INTERFACE_DEFINED__
extern IID_IDocHostUIHandler2 as const GUID
type IDocHostUIHandler2 as IDocHostUIHandler2_

type IDocHostUIHandler2Vtbl
	QueryInterface as function(byval This as IDocHostUIHandler2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDocHostUIHandler2 ptr) as ULONG
	Release as function(byval This as IDocHostUIHandler2 ptr) as ULONG
	ShowContextMenu as function(byval This as IDocHostUIHandler2 ptr, byval dwID as DWORD, byval ppt as POINT ptr, byval pcmdtReserved as IUnknown ptr, byval pdispReserved as IDispatch ptr) as HRESULT
	GetHostInfo as function(byval This as IDocHostUIHandler2 ptr, byval pInfo as DOCHOSTUIINFO ptr) as HRESULT
	ShowUI as function(byval This as IDocHostUIHandler2 ptr, byval dwID as DWORD, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pCommandTarget as IOleCommandTarget ptr, byval pFrame as IOleInPlaceFrame ptr, byval pDoc as IOleInPlaceUIWindow ptr) as HRESULT
	HideUI as function(byval This as IDocHostUIHandler2 ptr) as HRESULT
	UpdateUI as function(byval This as IDocHostUIHandler2 ptr) as HRESULT
	EnableModeless as function(byval This as IDocHostUIHandler2 ptr, byval fEnable as WINBOOL) as HRESULT
	OnDocWindowActivate as function(byval This as IDocHostUIHandler2 ptr, byval fActivate as WINBOOL) as HRESULT
	OnFrameWindowActivate as function(byval This as IDocHostUIHandler2 ptr, byval fActivate as WINBOOL) as HRESULT
	ResizeBorder as function(byval This as IDocHostUIHandler2 ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fRameWindow as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IDocHostUIHandler2 ptr, byval lpMsg as LPMSG, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD) as HRESULT
	GetOptionKeyPath as function(byval This as IDocHostUIHandler2 ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
	GetDropTarget as function(byval This as IDocHostUIHandler2 ptr, byval pDropTarget as IDropTarget ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
	GetExternal as function(byval This as IDocHostUIHandler2 ptr, byval ppDispatch as IDispatch ptr ptr) as HRESULT
	TranslateUrl as function(byval This as IDocHostUIHandler2 ptr, byval dwTranslate as DWORD, byval pchURLIn as LPWSTR, byval ppchURLOut as LPWSTR ptr) as HRESULT
	FilterDataObject as function(byval This as IDocHostUIHandler2 ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
	GetOverrideKeyPath as function(byval This as IDocHostUIHandler2 ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
end type

type IDocHostUIHandler2_
	lpVtbl as IDocHostUIHandler2Vtbl ptr
end type

#define IDocHostUIHandler2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDocHostUIHandler2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDocHostUIHandler2_Release(This) (This)->lpVtbl->Release(This)
#define IDocHostUIHandler2_ShowContextMenu(This, dwID, ppt, pcmdtReserved, pdispReserved) (This)->lpVtbl->ShowContextMenu(This, dwID, ppt, pcmdtReserved, pdispReserved)
#define IDocHostUIHandler2_GetHostInfo(This, pInfo) (This)->lpVtbl->GetHostInfo(This, pInfo)
#define IDocHostUIHandler2_ShowUI(This, dwID, pActiveObject, pCommandTarget, pFrame, pDoc) (This)->lpVtbl->ShowUI(This, dwID, pActiveObject, pCommandTarget, pFrame, pDoc)
#define IDocHostUIHandler2_HideUI(This) (This)->lpVtbl->HideUI(This)
#define IDocHostUIHandler2_UpdateUI(This) (This)->lpVtbl->UpdateUI(This)
#define IDocHostUIHandler2_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)
#define IDocHostUIHandler2_OnDocWindowActivate(This, fActivate) (This)->lpVtbl->OnDocWindowActivate(This, fActivate)
#define IDocHostUIHandler2_OnFrameWindowActivate(This, fActivate) (This)->lpVtbl->OnFrameWindowActivate(This, fActivate)
#define IDocHostUIHandler2_ResizeBorder(This, prcBorder, pUIWindow, fRameWindow) (This)->lpVtbl->ResizeBorder(This, prcBorder, pUIWindow, fRameWindow)
#define IDocHostUIHandler2_TranslateAccelerator(This, lpMsg, pguidCmdGroup, nCmdID) (This)->lpVtbl->TranslateAccelerator(This, lpMsg, pguidCmdGroup, nCmdID)
#define IDocHostUIHandler2_GetOptionKeyPath(This, pchKey, dw) (This)->lpVtbl->GetOptionKeyPath(This, pchKey, dw)
#define IDocHostUIHandler2_GetDropTarget(This, pDropTarget, ppDropTarget) (This)->lpVtbl->GetDropTarget(This, pDropTarget, ppDropTarget)
#define IDocHostUIHandler2_GetExternal(This, ppDispatch) (This)->lpVtbl->GetExternal(This, ppDispatch)
#define IDocHostUIHandler2_TranslateUrl(This, dwTranslate, pchURLIn, ppchURLOut) (This)->lpVtbl->TranslateUrl(This, dwTranslate, pchURLIn, ppchURLOut)
#define IDocHostUIHandler2_FilterDataObject(This, pDO, ppDORet) (This)->lpVtbl->FilterDataObject(This, pDO, ppDORet)
#define IDocHostUIHandler2_GetOverrideKeyPath(This, pchKey, dw) (This)->lpVtbl->GetOverrideKeyPath(This, pchKey, dw)
declare function IDocHostUIHandler2_GetOverrideKeyPath_Proxy(byval This as IDocHostUIHandler2 ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
declare sub IDocHostUIHandler2_GetOverrideKeyPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ICustomDoc_INTERFACE_DEFINED__
extern IID_ICustomDoc as const GUID
type ICustomDoc as ICustomDoc_

type ICustomDocVtbl
	QueryInterface as function(byval This as ICustomDoc ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICustomDoc ptr) as ULONG
	Release as function(byval This as ICustomDoc ptr) as ULONG
	SetUIHandler as function(byval This as ICustomDoc ptr, byval pUIHandler as IDocHostUIHandler ptr) as HRESULT
end type

type ICustomDoc_
	lpVtbl as ICustomDocVtbl ptr
end type

#define ICustomDoc_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICustomDoc_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICustomDoc_Release(This) (This)->lpVtbl->Release(This)
#define ICustomDoc_SetUIHandler(This, pUIHandler) (This)->lpVtbl->SetUIHandler(This, pUIHandler)
declare function ICustomDoc_SetUIHandler_Proxy(byval This as ICustomDoc ptr, byval pUIHandler as IDocHostUIHandler ptr) as HRESULT
declare sub ICustomDoc_SetUIHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDocHostShowUI_INTERFACE_DEFINED__
extern IID_IDocHostShowUI as const GUID
type IDocHostShowUI as IDocHostShowUI_

type IDocHostShowUIVtbl
	QueryInterface as function(byval This as IDocHostShowUI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDocHostShowUI ptr) as ULONG
	Release as function(byval This as IDocHostShowUI ptr) as ULONG
	ShowMessage as function(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval lpstrText as LPOLESTR, byval lpstrCaption as LPOLESTR, byval dwType as DWORD, byval lpstrHelpFile as LPOLESTR, byval dwHelpContext as DWORD, byval plResult as LRESULT ptr) as HRESULT
	ShowHelp as function(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval pszHelpFile as LPOLESTR, byval uCommand as UINT, byval dwData as DWORD, byval ptMouse as POINT, byval pDispatchObjectHit as IDispatch ptr) as HRESULT
end type

type IDocHostShowUI_
	lpVtbl as IDocHostShowUIVtbl ptr
end type

#define IDocHostShowUI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDocHostShowUI_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDocHostShowUI_Release(This) (This)->lpVtbl->Release(This)
#define IDocHostShowUI_ShowMessage(This, hwnd, lpstrText, lpstrCaption, dwType, lpstrHelpFile, dwHelpContext, plResult) (This)->lpVtbl->ShowMessage(This, hwnd, lpstrText, lpstrCaption, dwType, lpstrHelpFile, dwHelpContext, plResult)
#define IDocHostShowUI_ShowHelp(This, hwnd, pszHelpFile, uCommand, dwData, ptMouse, pDispatchObjectHit) (This)->lpVtbl->ShowHelp(This, hwnd, pszHelpFile, uCommand, dwData, ptMouse, pDispatchObjectHit)

declare function IDocHostShowUI_ShowMessage_Proxy(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval lpstrText as LPOLESTR, byval lpstrCaption as LPOLESTR, byval dwType as DWORD, byval lpstrHelpFile as LPOLESTR, byval dwHelpContext as DWORD, byval plResult as LRESULT ptr) as HRESULT
declare sub IDocHostShowUI_ShowMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDocHostShowUI_ShowHelp_Proxy(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval pszHelpFile as LPOLESTR, byval uCommand as UINT, byval dwData as DWORD, byval ptMouse as POINT, byval pDispatchObjectHit as IDispatch ptr) as HRESULT
declare sub IDocHostShowUI_ShowHelp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type IClassFactoryEx as IClassFactoryEx_
type IClassFactory3 as IClassFactoryEx
#define __IClassFactoryEx_INTERFACE_DEFINED__
extern IID_IClassFactoryEx as const GUID
extern IID_IClassFactory3 alias "IID_IClassFactoryEx" as const GUID

type IClassFactoryExVtbl
	QueryInterface as function(byval This as IClassFactoryEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IClassFactoryEx ptr) as ULONG
	Release as function(byval This as IClassFactoryEx ptr) as ULONG
	CreateInstance as function(byval This as IClassFactoryEx ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	LockServer as function(byval This as IClassFactoryEx ptr, byval fLock as WINBOOL) as HRESULT
	CreateInstanceWithContext as function(byval This as IClassFactoryEx ptr, byval punkContext as IUnknown ptr, byval punkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IClassFactoryEx_
	lpVtbl as IClassFactoryExVtbl ptr
end type

#define IClassFactoryEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IClassFactoryEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IClassFactoryEx_Release(This) (This)->lpVtbl->Release(This)
#define IClassFactoryEx_CreateInstance(This, pUnkOuter, riid, ppvObject) (This)->lpVtbl->CreateInstance(This, pUnkOuter, riid, ppvObject)
#define IClassFactoryEx_LockServer(This, fLock) (This)->lpVtbl->LockServer(This, fLock)
#define IClassFactoryEx_CreateInstanceWithContext(This, punkContext, punkOuter, riid, ppv) (This)->lpVtbl->CreateInstanceWithContext(This, punkContext, punkOuter, riid, ppv)
declare function IClassFactoryEx_CreateInstanceWithContext_Proxy(byval This as IClassFactoryEx ptr, byval punkContext as IUnknown ptr, byval punkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IClassFactoryEx_CreateInstanceWithContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IHTMLOMWindowServices_INTERFACE_DEFINED__
extern IID_IHTMLOMWindowServices as const GUID
extern SID_SHTMLOMWindowServices alias "IID_IHTMLOMWindowServices" as const GUID
type IHTMLOMWindowServices as IHTMLOMWindowServices_

type IHTMLOMWindowServicesVtbl
	QueryInterface as function(byval This as IHTMLOMWindowServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHTMLOMWindowServices ptr) as ULONG
	Release as function(byval This as IHTMLOMWindowServices ptr) as ULONG
	moveTo as function(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
	moveBy as function(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
	resizeTo as function(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
	resizeBy as function(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
end type

type IHTMLOMWindowServices_
	lpVtbl as IHTMLOMWindowServicesVtbl ptr
end type

#define IHTMLOMWindowServices_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHTMLOMWindowServices_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHTMLOMWindowServices_Release(This) (This)->lpVtbl->Release(This)
#define IHTMLOMWindowServices_moveTo(This, x, y) (This)->lpVtbl->moveTo(This, x, y)
#define IHTMLOMWindowServices_moveBy(This, x, y) (This)->lpVtbl->moveBy(This, x, y)
#define IHTMLOMWindowServices_resizeTo(This, x, y) (This)->lpVtbl->resizeTo(This, x, y)
#define IHTMLOMWindowServices_resizeBy(This, x, y) (This)->lpVtbl->resizeBy(This, x, y)

declare function IHTMLOMWindowServices_moveTo_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_moveTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_moveBy_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_moveBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_resizeTo_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_resizeTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_resizeBy_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_resizeBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern
