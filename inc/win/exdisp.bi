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

#inclib "uuid"

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "ocidl.bi"
#include once "docobj.bi"

extern "Windows"

#define __exdisp_h__
#define __IWebBrowser_FWD_DEFINED__
#define __DWebBrowserEvents_FWD_DEFINED__
#define __IWebBrowserApp_FWD_DEFINED__
#define __IWebBrowser2_FWD_DEFINED__
#define __DWebBrowserEvents2_FWD_DEFINED__
#define __WebBrowser_V1_FWD_DEFINED__
#define __WebBrowser_FWD_DEFINED__
#define __InternetExplorer_FWD_DEFINED__
#define __ShellBrowserWindow_FWD_DEFINED__
#define __DShellWindowsEvents_FWD_DEFINED__
#define __IShellWindows_FWD_DEFINED__
#define __ShellWindows_FWD_DEFINED__
#define __IShellUIHelper_FWD_DEFINED__
#define __ShellUIHelper_FWD_DEFINED__
#define __DShellNameSpaceEvents_FWD_DEFINED__
#define __IShellFavoritesNameSpace_FWD_DEFINED__
#define __IShellNameSpace_FWD_DEFINED__
#define __ShellNameSpace_FWD_DEFINED__
#define __IScriptErrorList_FWD_DEFINED__
#define __CScriptErrorList_FWD_DEFINED__
#define __ISearch_FWD_DEFINED__
#define __ISearches_FWD_DEFINED__
#define __ISearchAssistantOC_FWD_DEFINED__
#define __ISearchAssistantOC2_FWD_DEFINED__
#define __ISearchAssistantOC3_FWD_DEFINED__
#define ___SearchAssistantEvents_FWD_DEFINED__
#define __SearchAssistantOC_FWD_DEFINED__
#define __SHDocVw_LIBRARY_DEFINED__

type CommandStateChangeConstants as long
enum
	CSC_UPDATECOMMANDS = &hffffffff
	CSC_NAVIGATEFORWARD = &h1
	CSC_NAVIGATEBACK = &h2
end enum

type SecureLockIconConstants as long
enum
	secureLockIconUnsecure = 0
	secureLockIconMixed = &h1
	secureLockIconSecureUnknownBits = &h2
	secureLockIconSecure40Bit = &h3
	secureLockIconSecure56Bit = &h4
	secureLockIconSecureFortezza = &h5
	secureLockIconSecure128Bit = &h6
end enum

type ShellWindowTypeConstants as long
enum
	SWC_EXPLORER = 0
	SWC_BROWSER = &h1
	SWC_3RDPARTY = &h2
	SWC_CALLBACK = &h4
end enum

type ShellWindowFindWindowOptions as long
enum
	SWFO_NEEDDISPATCH = &h1
	SWFO_INCLUDEPENDING = &h2
	SWFO_COOKIEPASSED = &h4
end enum

extern LIBID_SHDocVw as const IID
#define __IWebBrowser_INTERFACE_DEFINED__

type BrowserNavConstants as long
enum
	navOpenInNewWindow = &h1
	navNoHistory = &h2
	navNoReadFromCache = &h4
	navNoWriteToCache = &h8
	navAllowAutosearch = &h10
	navBrowserBar = &h20
	navHyperlink = &h40
	navEnforceRestricted = &h80
	navNewWindowsManaged = &h100
	navUntrustedForDownload = &h200
	navTrustedForActiveX = &h400
end enum

type RefreshConstants as long
enum
	REFRESH_NORMAL = 0
	REFRESH_IFEXPIRED = 1
	REFRESH_COMPLETELY = 3
end enum

extern IID_IWebBrowser as const IID
type IWebBrowser as IWebBrowser_

type IWebBrowserVtbl
	QueryInterface as function(byval This as IWebBrowser ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWebBrowser ptr) as ULONG
	Release as function(byval This as IWebBrowser ptr) as ULONG
	GetTypeInfoCount as function(byval This as IWebBrowser ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IWebBrowser ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IWebBrowser ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IWebBrowser ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GoBack as function(byval This as IWebBrowser ptr) as HRESULT
	GoForward as function(byval This as IWebBrowser ptr) as HRESULT
	GoHome as function(byval This as IWebBrowser ptr) as HRESULT
	GoSearch as function(byval This as IWebBrowser ptr) as HRESULT
	Navigate as function(byval This as IWebBrowser ptr, byval URL as BSTR, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
	Refresh as function(byval This as IWebBrowser ptr) as HRESULT
	Refresh2 as function(byval This as IWebBrowser ptr, byval Level as VARIANT ptr) as HRESULT
	Stop as function(byval This as IWebBrowser ptr) as HRESULT
	get_Application as function(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval This as IWebBrowser ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval This as IWebBrowser ptr, byval Type as BSTR ptr) as HRESULT
	get_Left as function(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
	put_Left as function(byval This as IWebBrowser ptr, byval Left as long) as HRESULT
	get_Top as function(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
	put_Top as function(byval This as IWebBrowser ptr, byval Top as long) as HRESULT
	get_Width as function(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
	put_Width as function(byval This as IWebBrowser ptr, byval Width as long) as HRESULT
	get_Height as function(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
	put_Height as function(byval This as IWebBrowser ptr, byval Height as long) as HRESULT
	get_LocationName as function(byval This as IWebBrowser ptr, byval LocationName as BSTR ptr) as HRESULT
	get_LocationURL as function(byval This as IWebBrowser ptr, byval LocationURL as BSTR ptr) as HRESULT
	get_Busy as function(byval This as IWebBrowser ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
end type

type IWebBrowser_
	lpVtbl as IWebBrowserVtbl ptr
end type

#define IWebBrowser_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWebBrowser_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWebBrowser_Release(This) (This)->lpVtbl->Release(This)
#define IWebBrowser_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IWebBrowser_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IWebBrowser_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IWebBrowser_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IWebBrowser_GoBack(This) (This)->lpVtbl->GoBack(This)
#define IWebBrowser_GoForward(This) (This)->lpVtbl->GoForward(This)
#define IWebBrowser_GoHome(This) (This)->lpVtbl->GoHome(This)
#define IWebBrowser_GoSearch(This) (This)->lpVtbl->GoSearch(This)
#define IWebBrowser_Navigate(This, URL, Flags, TargetFrameName, PostData, Headers) (This)->lpVtbl->Navigate(This, URL, Flags, TargetFrameName, PostData, Headers)
#define IWebBrowser_Refresh(This) (This)->lpVtbl->Refresh(This)
#define IWebBrowser_Refresh2(This, Level) (This)->lpVtbl->Refresh2(This, Level)
#define IWebBrowser_Stop(This) (This)->lpVtbl->Stop(This)
#define IWebBrowser_get_Application(This, ppDisp) (This)->lpVtbl->get_Application(This, ppDisp)
#define IWebBrowser_get_Parent(This, ppDisp) (This)->lpVtbl->get_Parent(This, ppDisp)
#define IWebBrowser_get_Container(This, ppDisp) (This)->lpVtbl->get_Container(This, ppDisp)
#define IWebBrowser_get_Document(This, ppDisp) (This)->lpVtbl->get_Document(This, ppDisp)
#define IWebBrowser_get_TopLevelContainer(This, pBool) (This)->lpVtbl->get_TopLevelContainer(This, pBool)
#define IWebBrowser_get_Type(This, Type) (This)->lpVtbl->get_Type(This, Type)
#define IWebBrowser_get_Left(This, pl) (This)->lpVtbl->get_Left(This, pl)
#define IWebBrowser_put_Left(This, Left) (This)->lpVtbl->put_Left(This, Left)
#define IWebBrowser_get_Top(This, pl) (This)->lpVtbl->get_Top(This, pl)
#define IWebBrowser_put_Top(This, Top) (This)->lpVtbl->put_Top(This, Top)
#define IWebBrowser_get_Width(This, pl) (This)->lpVtbl->get_Width(This, pl)
#define IWebBrowser_put_Width(This, Width) (This)->lpVtbl->put_Width(This, Width)
#define IWebBrowser_get_Height(This, pl) (This)->lpVtbl->get_Height(This, pl)
#define IWebBrowser_put_Height(This, Height) (This)->lpVtbl->put_Height(This, Height)
#define IWebBrowser_get_LocationName(This, LocationName) (This)->lpVtbl->get_LocationName(This, LocationName)
#define IWebBrowser_get_LocationURL(This, LocationURL) (This)->lpVtbl->get_LocationURL(This, LocationURL)
#define IWebBrowser_get_Busy(This, pBool) (This)->lpVtbl->get_Busy(This, pBool)

declare function IWebBrowser_GoBack_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_GoBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_GoForward_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_GoForward_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_GoHome_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_GoHome_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_GoSearch_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_GoSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_Navigate_Proxy(byval This as IWebBrowser ptr, byval URL as BSTR, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
declare sub IWebBrowser_Navigate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_Refresh_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_Refresh_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_Refresh2_Proxy(byval This as IWebBrowser ptr, byval Level as VARIANT ptr) as HRESULT
declare sub IWebBrowser_Refresh2_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_Stop_Proxy(byval This as IWebBrowser ptr) as HRESULT
declare sub IWebBrowser_Stop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Application_Proxy(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IWebBrowser_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Parent_Proxy(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IWebBrowser_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Container_Proxy(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IWebBrowser_get_Container_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Document_Proxy(byval This as IWebBrowser ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IWebBrowser_get_Document_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_TopLevelContainer_Proxy(byval This as IWebBrowser ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser_get_TopLevelContainer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Type_Proxy(byval This as IWebBrowser ptr, byval Type as BSTR ptr) as HRESULT
declare sub IWebBrowser_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Left_Proxy(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
declare sub IWebBrowser_get_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_put_Left_Proxy(byval This as IWebBrowser ptr, byval Left as long) as HRESULT
declare sub IWebBrowser_put_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Top_Proxy(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
declare sub IWebBrowser_get_Top_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_put_Top_Proxy(byval This as IWebBrowser ptr, byval Top as long) as HRESULT
declare sub IWebBrowser_put_Top_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Width_Proxy(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
declare sub IWebBrowser_get_Width_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_put_Width_Proxy(byval This as IWebBrowser ptr, byval Width as long) as HRESULT
declare sub IWebBrowser_put_Width_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Height_Proxy(byval This as IWebBrowser ptr, byval pl as long ptr) as HRESULT
declare sub IWebBrowser_get_Height_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_put_Height_Proxy(byval This as IWebBrowser ptr, byval Height as long) as HRESULT
declare sub IWebBrowser_put_Height_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_LocationName_Proxy(byval This as IWebBrowser ptr, byval LocationName as BSTR ptr) as HRESULT
declare sub IWebBrowser_get_LocationName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_LocationURL_Proxy(byval This as IWebBrowser ptr, byval LocationURL as BSTR ptr) as HRESULT
declare sub IWebBrowser_get_LocationURL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser_get_Busy_Proxy(byval This as IWebBrowser ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser_get_Busy_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __DWebBrowserEvents_DISPINTERFACE_DEFINED__
extern DIID_DWebBrowserEvents as const IID
type DWebBrowserEvents as DWebBrowserEvents_

type DWebBrowserEventsVtbl
	QueryInterface as function(byval This as DWebBrowserEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DWebBrowserEvents ptr) as ULONG
	Release as function(byval This as DWebBrowserEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as DWebBrowserEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DWebBrowserEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DWebBrowserEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DWebBrowserEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DWebBrowserEvents_
	lpVtbl as DWebBrowserEventsVtbl ptr
end type

#define DWebBrowserEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DWebBrowserEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DWebBrowserEvents_Release(This) (This)->lpVtbl->Release(This)
#define DWebBrowserEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DWebBrowserEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DWebBrowserEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DWebBrowserEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define __IWebBrowserApp_INTERFACE_DEFINED__
extern IID_IWebBrowserApp as const IID
type IWebBrowserApp as IWebBrowserApp_

type IWebBrowserAppVtbl
	QueryInterface as function(byval This as IWebBrowserApp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWebBrowserApp ptr) as ULONG
	Release as function(byval This as IWebBrowserApp ptr) as ULONG
	GetTypeInfoCount as function(byval This as IWebBrowserApp ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IWebBrowserApp ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IWebBrowserApp ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IWebBrowserApp ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GoBack as function(byval This as IWebBrowserApp ptr) as HRESULT
	GoForward as function(byval This as IWebBrowserApp ptr) as HRESULT
	GoHome as function(byval This as IWebBrowserApp ptr) as HRESULT
	GoSearch as function(byval This as IWebBrowserApp ptr) as HRESULT
	Navigate as function(byval This as IWebBrowserApp ptr, byval URL as BSTR, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
	Refresh as function(byval This as IWebBrowserApp ptr) as HRESULT
	Refresh2 as function(byval This as IWebBrowserApp ptr, byval Level as VARIANT ptr) as HRESULT
	Stop as function(byval This as IWebBrowserApp ptr) as HRESULT
	get_Application as function(byval This as IWebBrowserApp ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IWebBrowserApp ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval This as IWebBrowserApp ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval This as IWebBrowserApp ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval This as IWebBrowserApp ptr, byval Type as BSTR ptr) as HRESULT
	get_Left as function(byval This as IWebBrowserApp ptr, byval pl as long ptr) as HRESULT
	put_Left as function(byval This as IWebBrowserApp ptr, byval Left as long) as HRESULT
	get_Top as function(byval This as IWebBrowserApp ptr, byval pl as long ptr) as HRESULT
	put_Top as function(byval This as IWebBrowserApp ptr, byval Top as long) as HRESULT
	get_Width as function(byval This as IWebBrowserApp ptr, byval pl as long ptr) as HRESULT
	put_Width as function(byval This as IWebBrowserApp ptr, byval Width as long) as HRESULT
	get_Height as function(byval This as IWebBrowserApp ptr, byval pl as long ptr) as HRESULT
	put_Height as function(byval This as IWebBrowserApp ptr, byval Height as long) as HRESULT
	get_LocationName as function(byval This as IWebBrowserApp ptr, byval LocationName as BSTR ptr) as HRESULT
	get_LocationURL as function(byval This as IWebBrowserApp ptr, byval LocationURL as BSTR ptr) as HRESULT
	get_Busy as function(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	Quit as function(byval This as IWebBrowserApp ptr) as HRESULT
	ClientToWindow as function(byval This as IWebBrowserApp ptr, byval pcx as long ptr, byval pcy as long ptr) as HRESULT
	PutProperty as function(byval This as IWebBrowserApp ptr, byval Property as BSTR, byval vtValue as VARIANT) as HRESULT
	GetProperty as function(byval This as IWebBrowserApp ptr, byval Property as BSTR, byval pvtValue as VARIANT ptr) as HRESULT
	get_Name as function(byval This as IWebBrowserApp ptr, byval Name as BSTR ptr) as HRESULT
	get_HWND as function(byval This as IWebBrowserApp ptr, byval pHWND as SHANDLE_PTR ptr) as HRESULT
	get_FullName as function(byval This as IWebBrowserApp ptr, byval FullName as BSTR ptr) as HRESULT
	get_Path as function(byval This as IWebBrowserApp ptr, byval Path as BSTR ptr) as HRESULT
	get_Visible as function(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_StatusBar as function(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_StatusText as function(byval This as IWebBrowserApp ptr, byval StatusText as BSTR ptr) as HRESULT
	put_StatusText as function(byval This as IWebBrowserApp ptr, byval StatusText as BSTR) as HRESULT
	get_ToolBar as function(byval This as IWebBrowserApp ptr, byval Value as long ptr) as HRESULT
	put_ToolBar as function(byval This as IWebBrowserApp ptr, byval Value as long) as HRESULT
	get_MenuBar as function(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_FullScreen as function(byval This as IWebBrowserApp ptr, byval pbFullScreen as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function(byval This as IWebBrowserApp ptr, byval bFullScreen as VARIANT_BOOL) as HRESULT
end type

type IWebBrowserApp_
	lpVtbl as IWebBrowserAppVtbl ptr
end type

#define IWebBrowserApp_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWebBrowserApp_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWebBrowserApp_Release(This) (This)->lpVtbl->Release(This)
#define IWebBrowserApp_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IWebBrowserApp_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IWebBrowserApp_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IWebBrowserApp_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IWebBrowserApp_GoBack(This) (This)->lpVtbl->GoBack(This)
#define IWebBrowserApp_GoForward(This) (This)->lpVtbl->GoForward(This)
#define IWebBrowserApp_GoHome(This) (This)->lpVtbl->GoHome(This)
#define IWebBrowserApp_GoSearch(This) (This)->lpVtbl->GoSearch(This)
#define IWebBrowserApp_Navigate(This, URL, Flags, TargetFrameName, PostData, Headers) (This)->lpVtbl->Navigate(This, URL, Flags, TargetFrameName, PostData, Headers)
#define IWebBrowserApp_Refresh(This) (This)->lpVtbl->Refresh(This)
#define IWebBrowserApp_Refresh2(This, Level) (This)->lpVtbl->Refresh2(This, Level)
#define IWebBrowserApp_Stop(This) (This)->lpVtbl->Stop(This)
#define IWebBrowserApp_get_Application(This, ppDisp) (This)->lpVtbl->get_Application(This, ppDisp)
#define IWebBrowserApp_get_Parent(This, ppDisp) (This)->lpVtbl->get_Parent(This, ppDisp)
#define IWebBrowserApp_get_Container(This, ppDisp) (This)->lpVtbl->get_Container(This, ppDisp)
#define IWebBrowserApp_get_Document(This, ppDisp) (This)->lpVtbl->get_Document(This, ppDisp)
#define IWebBrowserApp_get_TopLevelContainer(This, pBool) (This)->lpVtbl->get_TopLevelContainer(This, pBool)
#define IWebBrowserApp_get_Type(This, Type) (This)->lpVtbl->get_Type(This, Type)
#define IWebBrowserApp_get_Left(This, pl) (This)->lpVtbl->get_Left(This, pl)
#define IWebBrowserApp_put_Left(This, Left) (This)->lpVtbl->put_Left(This, Left)
#define IWebBrowserApp_get_Top(This, pl) (This)->lpVtbl->get_Top(This, pl)
#define IWebBrowserApp_put_Top(This, Top) (This)->lpVtbl->put_Top(This, Top)
#define IWebBrowserApp_get_Width(This, pl) (This)->lpVtbl->get_Width(This, pl)
#define IWebBrowserApp_put_Width(This, Width) (This)->lpVtbl->put_Width(This, Width)
#define IWebBrowserApp_get_Height(This, pl) (This)->lpVtbl->get_Height(This, pl)
#define IWebBrowserApp_put_Height(This, Height) (This)->lpVtbl->put_Height(This, Height)
#define IWebBrowserApp_get_LocationName(This, LocationName) (This)->lpVtbl->get_LocationName(This, LocationName)
#define IWebBrowserApp_get_LocationURL(This, LocationURL) (This)->lpVtbl->get_LocationURL(This, LocationURL)
#define IWebBrowserApp_get_Busy(This, pBool) (This)->lpVtbl->get_Busy(This, pBool)
#define IWebBrowserApp_Quit(This) (This)->lpVtbl->Quit(This)
#define IWebBrowserApp_ClientToWindow(This, pcx, pcy) (This)->lpVtbl->ClientToWindow(This, pcx, pcy)
#define IWebBrowserApp_PutProperty(This, Property, vtValue) (This)->lpVtbl->PutProperty(This, Property, vtValue)
#define IWebBrowserApp_GetProperty(This, Property, pvtValue) (This)->lpVtbl->GetProperty(This, Property, pvtValue)
#define IWebBrowserApp_get_Name(This, Name) (This)->lpVtbl->get_Name(This, Name)
#define IWebBrowserApp_get_HWND(This, pHWND) (This)->lpVtbl->get_HWND(This, pHWND)
#define IWebBrowserApp_get_FullName(This, FullName) (This)->lpVtbl->get_FullName(This, FullName)
#define IWebBrowserApp_get_Path(This, Path) (This)->lpVtbl->get_Path(This, Path)
#define IWebBrowserApp_get_Visible(This, pBool) (This)->lpVtbl->get_Visible(This, pBool)
#define IWebBrowserApp_put_Visible(This, Value) (This)->lpVtbl->put_Visible(This, Value)
#define IWebBrowserApp_get_StatusBar(This, pBool) (This)->lpVtbl->get_StatusBar(This, pBool)
#define IWebBrowserApp_put_StatusBar(This, Value) (This)->lpVtbl->put_StatusBar(This, Value)
#define IWebBrowserApp_get_StatusText(This, StatusText) (This)->lpVtbl->get_StatusText(This, StatusText)
#define IWebBrowserApp_put_StatusText(This, StatusText) (This)->lpVtbl->put_StatusText(This, StatusText)
#define IWebBrowserApp_get_ToolBar(This, Value) (This)->lpVtbl->get_ToolBar(This, Value)
#define IWebBrowserApp_put_ToolBar(This, Value) (This)->lpVtbl->put_ToolBar(This, Value)
#define IWebBrowserApp_get_MenuBar(This, Value) (This)->lpVtbl->get_MenuBar(This, Value)
#define IWebBrowserApp_put_MenuBar(This, Value) (This)->lpVtbl->put_MenuBar(This, Value)
#define IWebBrowserApp_get_FullScreen(This, pbFullScreen) (This)->lpVtbl->get_FullScreen(This, pbFullScreen)
#define IWebBrowserApp_put_FullScreen(This, bFullScreen) (This)->lpVtbl->put_FullScreen(This, bFullScreen)

declare function IWebBrowserApp_Quit_Proxy(byval This as IWebBrowserApp ptr) as HRESULT
declare sub IWebBrowserApp_Quit_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_ClientToWindow_Proxy(byval This as IWebBrowserApp ptr, byval pcx as long ptr, byval pcy as long ptr) as HRESULT
declare sub IWebBrowserApp_ClientToWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_PutProperty_Proxy(byval This as IWebBrowserApp ptr, byval Property as BSTR, byval vtValue as VARIANT) as HRESULT
declare sub IWebBrowserApp_PutProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_GetProperty_Proxy(byval This as IWebBrowserApp ptr, byval Property as BSTR, byval pvtValue as VARIANT ptr) as HRESULT
declare sub IWebBrowserApp_GetProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_Name_Proxy(byval This as IWebBrowserApp ptr, byval Name as BSTR ptr) as HRESULT
declare sub IWebBrowserApp_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_HWND_Proxy(byval This as IWebBrowserApp ptr, byval pHWND as SHANDLE_PTR ptr) as HRESULT
declare sub IWebBrowserApp_get_HWND_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_FullName_Proxy(byval This as IWebBrowserApp ptr, byval FullName as BSTR ptr) as HRESULT
declare sub IWebBrowserApp_get_FullName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_Path_Proxy(byval This as IWebBrowserApp ptr, byval Path as BSTR ptr) as HRESULT
declare sub IWebBrowserApp_get_Path_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_Visible_Proxy(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowserApp_get_Visible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_Visible_Proxy(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
declare sub IWebBrowserApp_put_Visible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_StatusBar_Proxy(byval This as IWebBrowserApp ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowserApp_get_StatusBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_StatusBar_Proxy(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
declare sub IWebBrowserApp_put_StatusBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_StatusText_Proxy(byval This as IWebBrowserApp ptr, byval StatusText as BSTR ptr) as HRESULT
declare sub IWebBrowserApp_get_StatusText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_StatusText_Proxy(byval This as IWebBrowserApp ptr, byval StatusText as BSTR) as HRESULT
declare sub IWebBrowserApp_put_StatusText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_ToolBar_Proxy(byval This as IWebBrowserApp ptr, byval Value as long ptr) as HRESULT
declare sub IWebBrowserApp_get_ToolBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_ToolBar_Proxy(byval This as IWebBrowserApp ptr, byval Value as long) as HRESULT
declare sub IWebBrowserApp_put_ToolBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_MenuBar_Proxy(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowserApp_get_MenuBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_MenuBar_Proxy(byval This as IWebBrowserApp ptr, byval Value as VARIANT_BOOL) as HRESULT
declare sub IWebBrowserApp_put_MenuBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_get_FullScreen_Proxy(byval This as IWebBrowserApp ptr, byval pbFullScreen as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowserApp_get_FullScreen_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowserApp_put_FullScreen_Proxy(byval This as IWebBrowserApp ptr, byval bFullScreen as VARIANT_BOOL) as HRESULT
declare sub IWebBrowserApp_put_FullScreen_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWebBrowser2_INTERFACE_DEFINED__
extern IID_IWebBrowser2 as const IID
type IWebBrowser2 as IWebBrowser2_

type IWebBrowser2Vtbl
	QueryInterface as function(byval This as IWebBrowser2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWebBrowser2 ptr) as ULONG
	Release as function(byval This as IWebBrowser2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IWebBrowser2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IWebBrowser2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IWebBrowser2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IWebBrowser2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GoBack as function(byval This as IWebBrowser2 ptr) as HRESULT
	GoForward as function(byval This as IWebBrowser2 ptr) as HRESULT
	GoHome as function(byval This as IWebBrowser2 ptr) as HRESULT
	GoSearch as function(byval This as IWebBrowser2 ptr) as HRESULT
	Navigate as function(byval This as IWebBrowser2 ptr, byval URL as BSTR, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
	Refresh as function(byval This as IWebBrowser2 ptr) as HRESULT
	Refresh2 as function(byval This as IWebBrowser2 ptr, byval Level as VARIANT ptr) as HRESULT
	Stop as function(byval This as IWebBrowser2 ptr) as HRESULT
	get_Application as function(byval This as IWebBrowser2 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IWebBrowser2 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval This as IWebBrowser2 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval This as IWebBrowser2 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval This as IWebBrowser2 ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval This as IWebBrowser2 ptr, byval Type as BSTR ptr) as HRESULT
	get_Left as function(byval This as IWebBrowser2 ptr, byval pl as long ptr) as HRESULT
	put_Left as function(byval This as IWebBrowser2 ptr, byval Left as long) as HRESULT
	get_Top as function(byval This as IWebBrowser2 ptr, byval pl as long ptr) as HRESULT
	put_Top as function(byval This as IWebBrowser2 ptr, byval Top as long) as HRESULT
	get_Width as function(byval This as IWebBrowser2 ptr, byval pl as long ptr) as HRESULT
	put_Width as function(byval This as IWebBrowser2 ptr, byval Width as long) as HRESULT
	get_Height as function(byval This as IWebBrowser2 ptr, byval pl as long ptr) as HRESULT
	put_Height as function(byval This as IWebBrowser2 ptr, byval Height as long) as HRESULT
	get_LocationName as function(byval This as IWebBrowser2 ptr, byval LocationName as BSTR ptr) as HRESULT
	get_LocationURL as function(byval This as IWebBrowser2 ptr, byval LocationURL as BSTR ptr) as HRESULT
	get_Busy as function(byval This as IWebBrowser2 ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	Quit as function(byval This as IWebBrowser2 ptr) as HRESULT
	ClientToWindow as function(byval This as IWebBrowser2 ptr, byval pcx as long ptr, byval pcy as long ptr) as HRESULT
	PutProperty as function(byval This as IWebBrowser2 ptr, byval Property as BSTR, byval vtValue as VARIANT) as HRESULT
	GetProperty as function(byval This as IWebBrowser2 ptr, byval Property as BSTR, byval pvtValue as VARIANT ptr) as HRESULT
	get_Name as function(byval This as IWebBrowser2 ptr, byval Name as BSTR ptr) as HRESULT
	get_HWND as function(byval This as IWebBrowser2 ptr, byval pHWND as SHANDLE_PTR ptr) as HRESULT
	get_FullName as function(byval This as IWebBrowser2 ptr, byval FullName as BSTR ptr) as HRESULT
	get_Path as function(byval This as IWebBrowser2 ptr, byval Path as BSTR ptr) as HRESULT
	get_Visible as function(byval This as IWebBrowser2 ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_StatusBar as function(byval This as IWebBrowser2 ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_StatusText as function(byval This as IWebBrowser2 ptr, byval StatusText as BSTR ptr) as HRESULT
	put_StatusText as function(byval This as IWebBrowser2 ptr, byval StatusText as BSTR) as HRESULT
	get_ToolBar as function(byval This as IWebBrowser2 ptr, byval Value as long ptr) as HRESULT
	put_ToolBar as function(byval This as IWebBrowser2 ptr, byval Value as long) as HRESULT
	get_MenuBar as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_FullScreen as function(byval This as IWebBrowser2 ptr, byval pbFullScreen as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function(byval This as IWebBrowser2 ptr, byval bFullScreen as VARIANT_BOOL) as HRESULT
	Navigate2 as function(byval This as IWebBrowser2 ptr, byval URL as VARIANT ptr, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
	QueryStatusWB as function(byval This as IWebBrowser2 ptr, byval cmdID as OLECMDID, byval pcmdf as OLECMDF ptr) as HRESULT
	ExecWB as function(byval This as IWebBrowser2 ptr, byval cmdID as OLECMDID, byval cmdexecopt as OLECMDEXECOPT, byval pvaIn as VARIANT ptr, byval pvaOut as VARIANT ptr) as HRESULT
	ShowBrowserBar as function(byval This as IWebBrowser2 ptr, byval pvaClsid as VARIANT ptr, byval pvarShow as VARIANT ptr, byval pvarSize as VARIANT ptr) as HRESULT
	get_ReadyState as function(byval This as IWebBrowser2 ptr, byval plReadyState as READYSTATE ptr) as HRESULT
	get_Offline as function(byval This as IWebBrowser2 ptr, byval pbOffline as VARIANT_BOOL ptr) as HRESULT
	put_Offline as function(byval This as IWebBrowser2 ptr, byval bOffline as VARIANT_BOOL) as HRESULT
	get_Silent as function(byval This as IWebBrowser2 ptr, byval pbSilent as VARIANT_BOOL ptr) as HRESULT
	put_Silent as function(byval This as IWebBrowser2 ptr, byval bSilent as VARIANT_BOOL) as HRESULT
	get_RegisterAsBrowser as function(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsBrowser as function(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
	get_RegisterAsDropTarget as function(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsDropTarget as function(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
	get_TheaterMode as function(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
	put_TheaterMode as function(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
	get_AddressBar as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
	put_AddressBar as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
	get_Resizable as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
	put_Resizable as function(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
end type

type IWebBrowser2_
	lpVtbl as IWebBrowser2Vtbl ptr
end type

#define IWebBrowser2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWebBrowser2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWebBrowser2_Release(This) (This)->lpVtbl->Release(This)
#define IWebBrowser2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IWebBrowser2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IWebBrowser2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IWebBrowser2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IWebBrowser2_GoBack(This) (This)->lpVtbl->GoBack(This)
#define IWebBrowser2_GoForward(This) (This)->lpVtbl->GoForward(This)
#define IWebBrowser2_GoHome(This) (This)->lpVtbl->GoHome(This)
#define IWebBrowser2_GoSearch(This) (This)->lpVtbl->GoSearch(This)
#define IWebBrowser2_Navigate(This, URL, Flags, TargetFrameName, PostData, Headers) (This)->lpVtbl->Navigate(This, URL, Flags, TargetFrameName, PostData, Headers)
#define IWebBrowser2_Refresh(This) (This)->lpVtbl->Refresh(This)
#define IWebBrowser2_Refresh2(This, Level) (This)->lpVtbl->Refresh2(This, Level)
#define IWebBrowser2_Stop(This) (This)->lpVtbl->Stop(This)
#define IWebBrowser2_get_Application(This, ppDisp) (This)->lpVtbl->get_Application(This, ppDisp)
#define IWebBrowser2_get_Parent(This, ppDisp) (This)->lpVtbl->get_Parent(This, ppDisp)
#define IWebBrowser2_get_Container(This, ppDisp) (This)->lpVtbl->get_Container(This, ppDisp)
#define IWebBrowser2_get_Document(This, ppDisp) (This)->lpVtbl->get_Document(This, ppDisp)
#define IWebBrowser2_get_TopLevelContainer(This, pBool) (This)->lpVtbl->get_TopLevelContainer(This, pBool)
#define IWebBrowser2_get_Type(This, Type) (This)->lpVtbl->get_Type(This, Type)
#define IWebBrowser2_get_Left(This, pl) (This)->lpVtbl->get_Left(This, pl)
#define IWebBrowser2_put_Left(This, Left) (This)->lpVtbl->put_Left(This, Left)
#define IWebBrowser2_get_Top(This, pl) (This)->lpVtbl->get_Top(This, pl)
#define IWebBrowser2_put_Top(This, Top) (This)->lpVtbl->put_Top(This, Top)
#define IWebBrowser2_get_Width(This, pl) (This)->lpVtbl->get_Width(This, pl)
#define IWebBrowser2_put_Width(This, Width) (This)->lpVtbl->put_Width(This, Width)
#define IWebBrowser2_get_Height(This, pl) (This)->lpVtbl->get_Height(This, pl)
#define IWebBrowser2_put_Height(This, Height) (This)->lpVtbl->put_Height(This, Height)
#define IWebBrowser2_get_LocationName(This, LocationName) (This)->lpVtbl->get_LocationName(This, LocationName)
#define IWebBrowser2_get_LocationURL(This, LocationURL) (This)->lpVtbl->get_LocationURL(This, LocationURL)
#define IWebBrowser2_get_Busy(This, pBool) (This)->lpVtbl->get_Busy(This, pBool)
#define IWebBrowser2_Quit(This) (This)->lpVtbl->Quit(This)
#define IWebBrowser2_ClientToWindow(This, pcx, pcy) (This)->lpVtbl->ClientToWindow(This, pcx, pcy)
#define IWebBrowser2_PutProperty(This, Property, vtValue) (This)->lpVtbl->PutProperty(This, Property, vtValue)
#define IWebBrowser2_GetProperty(This, Property, pvtValue) (This)->lpVtbl->GetProperty(This, Property, pvtValue)
#define IWebBrowser2_get_Name(This, Name) (This)->lpVtbl->get_Name(This, Name)
#define IWebBrowser2_get_HWND(This, pHWND) (This)->lpVtbl->get_HWND(This, pHWND)
#define IWebBrowser2_get_FullName(This, FullName) (This)->lpVtbl->get_FullName(This, FullName)
#define IWebBrowser2_get_Path(This, Path) (This)->lpVtbl->get_Path(This, Path)
#define IWebBrowser2_get_Visible(This, pBool) (This)->lpVtbl->get_Visible(This, pBool)
#define IWebBrowser2_put_Visible(This, Value) (This)->lpVtbl->put_Visible(This, Value)
#define IWebBrowser2_get_StatusBar(This, pBool) (This)->lpVtbl->get_StatusBar(This, pBool)
#define IWebBrowser2_put_StatusBar(This, Value) (This)->lpVtbl->put_StatusBar(This, Value)
#define IWebBrowser2_get_StatusText(This, StatusText) (This)->lpVtbl->get_StatusText(This, StatusText)
#define IWebBrowser2_put_StatusText(This, StatusText) (This)->lpVtbl->put_StatusText(This, StatusText)
#define IWebBrowser2_get_ToolBar(This, Value) (This)->lpVtbl->get_ToolBar(This, Value)
#define IWebBrowser2_put_ToolBar(This, Value) (This)->lpVtbl->put_ToolBar(This, Value)
#define IWebBrowser2_get_MenuBar(This, Value) (This)->lpVtbl->get_MenuBar(This, Value)
#define IWebBrowser2_put_MenuBar(This, Value) (This)->lpVtbl->put_MenuBar(This, Value)
#define IWebBrowser2_get_FullScreen(This, pbFullScreen) (This)->lpVtbl->get_FullScreen(This, pbFullScreen)
#define IWebBrowser2_put_FullScreen(This, bFullScreen) (This)->lpVtbl->put_FullScreen(This, bFullScreen)
#define IWebBrowser2_Navigate2(This, URL, Flags, TargetFrameName, PostData, Headers) (This)->lpVtbl->Navigate2(This, URL, Flags, TargetFrameName, PostData, Headers)
#define IWebBrowser2_QueryStatusWB(This, cmdID, pcmdf) (This)->lpVtbl->QueryStatusWB(This, cmdID, pcmdf)
#define IWebBrowser2_ExecWB(This, cmdID, cmdexecopt, pvaIn, pvaOut) (This)->lpVtbl->ExecWB(This, cmdID, cmdexecopt, pvaIn, pvaOut)
#define IWebBrowser2_ShowBrowserBar(This, pvaClsid, pvarShow, pvarSize) (This)->lpVtbl->ShowBrowserBar(This, pvaClsid, pvarShow, pvarSize)
#define IWebBrowser2_get_ReadyState(This, plReadyState) (This)->lpVtbl->get_ReadyState(This, plReadyState)
#define IWebBrowser2_get_Offline(This, pbOffline) (This)->lpVtbl->get_Offline(This, pbOffline)
#define IWebBrowser2_put_Offline(This, bOffline) (This)->lpVtbl->put_Offline(This, bOffline)
#define IWebBrowser2_get_Silent(This, pbSilent) (This)->lpVtbl->get_Silent(This, pbSilent)
#define IWebBrowser2_put_Silent(This, bSilent) (This)->lpVtbl->put_Silent(This, bSilent)
#define IWebBrowser2_get_RegisterAsBrowser(This, pbRegister) (This)->lpVtbl->get_RegisterAsBrowser(This, pbRegister)
#define IWebBrowser2_put_RegisterAsBrowser(This, bRegister) (This)->lpVtbl->put_RegisterAsBrowser(This, bRegister)
#define IWebBrowser2_get_RegisterAsDropTarget(This, pbRegister) (This)->lpVtbl->get_RegisterAsDropTarget(This, pbRegister)
#define IWebBrowser2_put_RegisterAsDropTarget(This, bRegister) (This)->lpVtbl->put_RegisterAsDropTarget(This, bRegister)
#define IWebBrowser2_get_TheaterMode(This, pbRegister) (This)->lpVtbl->get_TheaterMode(This, pbRegister)
#define IWebBrowser2_put_TheaterMode(This, bRegister) (This)->lpVtbl->put_TheaterMode(This, bRegister)
#define IWebBrowser2_get_AddressBar(This, Value) (This)->lpVtbl->get_AddressBar(This, Value)
#define IWebBrowser2_put_AddressBar(This, Value) (This)->lpVtbl->put_AddressBar(This, Value)
#define IWebBrowser2_get_Resizable(This, Value) (This)->lpVtbl->get_Resizable(This, Value)
#define IWebBrowser2_put_Resizable(This, Value) (This)->lpVtbl->put_Resizable(This, Value)

declare function IWebBrowser2_Navigate2_Proxy(byval This as IWebBrowser2 ptr, byval URL as VARIANT ptr, byval Flags as VARIANT ptr, byval TargetFrameName as VARIANT ptr, byval PostData as VARIANT ptr, byval Headers as VARIANT ptr) as HRESULT
declare sub IWebBrowser2_Navigate2_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_QueryStatusWB_Proxy(byval This as IWebBrowser2 ptr, byval cmdID as OLECMDID, byval pcmdf as OLECMDF ptr) as HRESULT
declare sub IWebBrowser2_QueryStatusWB_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_ExecWB_Proxy(byval This as IWebBrowser2 ptr, byval cmdID as OLECMDID, byval cmdexecopt as OLECMDEXECOPT, byval pvaIn as VARIANT ptr, byval pvaOut as VARIANT ptr) as HRESULT
declare sub IWebBrowser2_ExecWB_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_ShowBrowserBar_Proxy(byval This as IWebBrowser2 ptr, byval pvaClsid as VARIANT ptr, byval pvarShow as VARIANT ptr, byval pvarSize as VARIANT ptr) as HRESULT
declare sub IWebBrowser2_ShowBrowserBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_ReadyState_Proxy(byval This as IWebBrowser2 ptr, byval plReadyState as READYSTATE ptr) as HRESULT
declare sub IWebBrowser2_get_ReadyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_Offline_Proxy(byval This as IWebBrowser2 ptr, byval pbOffline as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_Offline_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_Offline_Proxy(byval This as IWebBrowser2 ptr, byval bOffline as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_Offline_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_Silent_Proxy(byval This as IWebBrowser2 ptr, byval pbSilent as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_Silent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_Silent_Proxy(byval This as IWebBrowser2 ptr, byval bSilent as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_Silent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_RegisterAsBrowser_Proxy(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_RegisterAsBrowser_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_RegisterAsBrowser_Proxy(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_RegisterAsBrowser_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_RegisterAsDropTarget_Proxy(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_RegisterAsDropTarget_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_RegisterAsDropTarget_Proxy(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_RegisterAsDropTarget_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_TheaterMode_Proxy(byval This as IWebBrowser2 ptr, byval pbRegister as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_TheaterMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_TheaterMode_Proxy(byval This as IWebBrowser2 ptr, byval bRegister as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_TheaterMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_AddressBar_Proxy(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_AddressBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_AddressBar_Proxy(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_AddressBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_get_Resizable_Proxy(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL ptr) as HRESULT
declare sub IWebBrowser2_get_Resizable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebBrowser2_put_Resizable_Proxy(byval This as IWebBrowser2 ptr, byval Value as VARIANT_BOOL) as HRESULT
declare sub IWebBrowser2_put_Resizable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __DWebBrowserEvents2_DISPINTERFACE_DEFINED__
extern DIID_DWebBrowserEvents2 as const IID
type DWebBrowserEvents2 as DWebBrowserEvents2_

type DWebBrowserEvents2Vtbl
	QueryInterface as function(byval This as DWebBrowserEvents2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DWebBrowserEvents2 ptr) as ULONG
	Release as function(byval This as DWebBrowserEvents2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as DWebBrowserEvents2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DWebBrowserEvents2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DWebBrowserEvents2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DWebBrowserEvents2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DWebBrowserEvents2_
	lpVtbl as DWebBrowserEvents2Vtbl ptr
end type

#define DWebBrowserEvents2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DWebBrowserEvents2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DWebBrowserEvents2_Release(This) (This)->lpVtbl->Release(This)
#define DWebBrowserEvents2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DWebBrowserEvents2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DWebBrowserEvents2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DWebBrowserEvents2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)

extern CLSID_WebBrowser_V1 as const CLSID
extern CLSID_WebBrowser as const CLSID
extern CLSID_InternetExplorer as const CLSID
extern CLSID_ShellBrowserWindow as const CLSID
#define __DShellWindowsEvents_DISPINTERFACE_DEFINED__
extern DIID_DShellWindowsEvents as const IID
type DShellWindowsEvents as DShellWindowsEvents_

type DShellWindowsEventsVtbl
	QueryInterface as function(byval This as DShellWindowsEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DShellWindowsEvents ptr) as ULONG
	Release as function(byval This as DShellWindowsEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as DShellWindowsEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DShellWindowsEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DShellWindowsEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DShellWindowsEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DShellWindowsEvents_
	lpVtbl as DShellWindowsEventsVtbl ptr
end type

#define DShellWindowsEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DShellWindowsEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DShellWindowsEvents_Release(This) (This)->lpVtbl->Release(This)
#define DShellWindowsEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DShellWindowsEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DShellWindowsEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DShellWindowsEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define __IShellWindows_INTERFACE_DEFINED__
extern IID_IShellWindows as const IID
type IShellWindows as IShellWindows_

type IShellWindowsVtbl
	QueryInterface as function(byval This as IShellWindows ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellWindows ptr) as ULONG
	Release as function(byval This as IShellWindows ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellWindows ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellWindows ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellWindows ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellWindows ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as IShellWindows ptr, byval Count as long ptr) as HRESULT
	Item as function(byval This as IShellWindows ptr, byval index as VARIANT, byval Folder as IDispatch ptr ptr) as HRESULT
	_NewEnum as function(byval This as IShellWindows ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	Register as function(byval This as IShellWindows ptr, byval pid as IDispatch ptr, byval hwnd as long, byval swClass as long, byval plCookie as long ptr) as HRESULT
	RegisterPending as function(byval This as IShellWindows ptr, byval lThreadId as long, byval pvarloc as VARIANT ptr, byval pvarlocRoot as VARIANT ptr, byval swClass as long, byval plCookie as long ptr) as HRESULT
	Revoke as function(byval This as IShellWindows ptr, byval lCookie as long) as HRESULT
	OnNavigate as function(byval This as IShellWindows ptr, byval lCookie as long, byval pvarLoc as VARIANT ptr) as HRESULT
	OnActivated as function(byval This as IShellWindows ptr, byval lCookie as long, byval fActive as VARIANT_BOOL) as HRESULT
	FindWindowSW as function(byval This as IShellWindows ptr, byval pvarLoc as VARIANT ptr, byval pvarLocRoot as VARIANT ptr, byval swClass as long, byval phwnd as long ptr, byval swfwOptions as long, byval ppdispOut as IDispatch ptr ptr) as HRESULT
	OnCreated as function(byval This as IShellWindows ptr, byval lCookie as long, byval punk as IUnknown ptr) as HRESULT
	ProcessAttachDetach as function(byval This as IShellWindows ptr, byval fAttach as VARIANT_BOOL) as HRESULT
end type

type IShellWindows_
	lpVtbl as IShellWindowsVtbl ptr
end type

#define IShellWindows_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellWindows_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellWindows_Release(This) (This)->lpVtbl->Release(This)
#define IShellWindows_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellWindows_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellWindows_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellWindows_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellWindows_get_Count(This, Count) (This)->lpVtbl->get_Count(This, Count)
#define IShellWindows_Item(This, index, Folder) (This)->lpVtbl->Item(This, index, Folder)
#define IShellWindows__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)
#define IShellWindows_Register(This, pid, hwnd, swClass, plCookie) (This)->lpVtbl->Register(This, pid, hwnd, swClass, plCookie)
#define IShellWindows_RegisterPending(This, lThreadId, pvarloc, pvarlocRoot, swClass, plCookie) (This)->lpVtbl->RegisterPending(This, lThreadId, pvarloc, pvarlocRoot, swClass, plCookie)
#define IShellWindows_Revoke(This, lCookie) (This)->lpVtbl->Revoke(This, lCookie)
#define IShellWindows_OnNavigate(This, lCookie, pvarLoc) (This)->lpVtbl->OnNavigate(This, lCookie, pvarLoc)
#define IShellWindows_OnActivated(This, lCookie, fActive) (This)->lpVtbl->OnActivated(This, lCookie, fActive)
#define IShellWindows_FindWindowSW(This, pvarLoc, pvarLocRoot, swClass, phwnd, swfwOptions, ppdispOut) (This)->lpVtbl->FindWindowSW(This, pvarLoc, pvarLocRoot, swClass, phwnd, swfwOptions, ppdispOut)
#define IShellWindows_OnCreated(This, lCookie, punk) (This)->lpVtbl->OnCreated(This, lCookie, punk)
#define IShellWindows_ProcessAttachDetach(This, fAttach) (This)->lpVtbl->ProcessAttachDetach(This, fAttach)

declare function IShellWindows_get_Count_Proxy(byval This as IShellWindows ptr, byval Count as long ptr) as HRESULT
declare sub IShellWindows_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_Item_Proxy(byval This as IShellWindows ptr, byval index as VARIANT, byval Folder as IDispatch ptr ptr) as HRESULT
declare sub IShellWindows_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows__NewEnum_Proxy(byval This as IShellWindows ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub IShellWindows__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_Register_Proxy(byval This as IShellWindows ptr, byval pid as IDispatch ptr, byval hwnd as long, byval swClass as long, byval plCookie as long ptr) as HRESULT
declare sub IShellWindows_Register_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_RegisterPending_Proxy(byval This as IShellWindows ptr, byval lThreadId as long, byval pvarloc as VARIANT ptr, byval pvarlocRoot as VARIANT ptr, byval swClass as long, byval plCookie as long ptr) as HRESULT
declare sub IShellWindows_RegisterPending_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_Revoke_Proxy(byval This as IShellWindows ptr, byval lCookie as long) as HRESULT
declare sub IShellWindows_Revoke_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_OnNavigate_Proxy(byval This as IShellWindows ptr, byval lCookie as long, byval pvarLoc as VARIANT ptr) as HRESULT
declare sub IShellWindows_OnNavigate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_OnActivated_Proxy(byval This as IShellWindows ptr, byval lCookie as long, byval fActive as VARIANT_BOOL) as HRESULT
declare sub IShellWindows_OnActivated_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_FindWindowSW_Proxy(byval This as IShellWindows ptr, byval pvarLoc as VARIANT ptr, byval pvarLocRoot as VARIANT ptr, byval swClass as long, byval phwnd as long ptr, byval swfwOptions as long, byval ppdispOut as IDispatch ptr ptr) as HRESULT
declare sub IShellWindows_FindWindowSW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_OnCreated_Proxy(byval This as IShellWindows ptr, byval lCookie as long, byval punk as IUnknown ptr) as HRESULT
declare sub IShellWindows_OnCreated_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellWindows_ProcessAttachDetach_Proxy(byval This as IShellWindows ptr, byval fAttach as VARIANT_BOOL) as HRESULT
declare sub IShellWindows_ProcessAttachDetach_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellWindows as const CLSID
#define __IShellUIHelper_INTERFACE_DEFINED__
extern IID_IShellUIHelper as const IID
type IShellUIHelper as IShellUIHelper_

type IShellUIHelperVtbl
	QueryInterface as function(byval This as IShellUIHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellUIHelper ptr) as ULONG
	Release as function(byval This as IShellUIHelper ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellUIHelper ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellUIHelper ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellUIHelper ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellUIHelper ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	ResetFirstBootMode as function(byval This as IShellUIHelper ptr) as HRESULT
	ResetSafeMode as function(byval This as IShellUIHelper ptr) as HRESULT
	RefreshOfflineDesktop as function(byval This as IShellUIHelper ptr) as HRESULT
	AddFavorite as function(byval This as IShellUIHelper ptr, byval URL as BSTR, byval Title as VARIANT ptr) as HRESULT
	AddChannel as function(byval This as IShellUIHelper ptr, byval URL as BSTR) as HRESULT
	AddDesktopComponent as function(byval This as IShellUIHelper ptr, byval URL as BSTR, byval Type as BSTR, byval Left as VARIANT ptr, byval Top as VARIANT ptr, byval Width as VARIANT ptr, byval Height as VARIANT ptr) as HRESULT
	IsSubscribed as function(byval This as IShellUIHelper ptr, byval URL as BSTR, byval pBool as VARIANT_BOOL ptr) as HRESULT
	NavigateAndFind as function(byval This as IShellUIHelper ptr, byval URL as BSTR, byval strQuery as BSTR, byval varTargetFrame as VARIANT ptr) as HRESULT
	ImportExportFavorites as function(byval This as IShellUIHelper ptr, byval fImport as VARIANT_BOOL, byval strImpExpPath as BSTR) as HRESULT
	AutoCompleteSaveForm as function(byval This as IShellUIHelper ptr, byval Form as VARIANT ptr) as HRESULT
	AutoScan as function(byval This as IShellUIHelper ptr, byval strSearch as BSTR, byval strFailureUrl as BSTR, byval pvarTargetFrame as VARIANT ptr) as HRESULT
	AutoCompleteAttach as function(byval This as IShellUIHelper ptr, byval Reserved as VARIANT ptr) as HRESULT
	ShowBrowserUI as function(byval This as IShellUIHelper ptr, byval bstrName as BSTR, byval pvarIn as VARIANT ptr, byval pvarOut as VARIANT ptr) as HRESULT
end type

type IShellUIHelper_
	lpVtbl as IShellUIHelperVtbl ptr
end type

#define IShellUIHelper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellUIHelper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellUIHelper_Release(This) (This)->lpVtbl->Release(This)
#define IShellUIHelper_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellUIHelper_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellUIHelper_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellUIHelper_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellUIHelper_ResetFirstBootMode(This) (This)->lpVtbl->ResetFirstBootMode(This)
#define IShellUIHelper_ResetSafeMode(This) (This)->lpVtbl->ResetSafeMode(This)
#define IShellUIHelper_RefreshOfflineDesktop(This) (This)->lpVtbl->RefreshOfflineDesktop(This)
#define IShellUIHelper_AddFavorite(This, URL, Title) (This)->lpVtbl->AddFavorite(This, URL, Title)
#define IShellUIHelper_AddChannel(This, URL) (This)->lpVtbl->AddChannel(This, URL)
#define IShellUIHelper_AddDesktopComponent(This, URL, Type, Left, Top, Width, Height) (This)->lpVtbl->AddDesktopComponent(This, URL, Type, Left, Top, Width, Height)
#define IShellUIHelper_IsSubscribed(This, URL, pBool) (This)->lpVtbl->IsSubscribed(This, URL, pBool)
#define IShellUIHelper_NavigateAndFind(This, URL, strQuery, varTargetFrame) (This)->lpVtbl->NavigateAndFind(This, URL, strQuery, varTargetFrame)
#define IShellUIHelper_ImportExportFavorites(This, fImport, strImpExpPath) (This)->lpVtbl->ImportExportFavorites(This, fImport, strImpExpPath)
#define IShellUIHelper_AutoCompleteSaveForm(This, Form) (This)->lpVtbl->AutoCompleteSaveForm(This, Form)
#define IShellUIHelper_AutoScan(This, strSearch, strFailureUrl, pvarTargetFrame) (This)->lpVtbl->AutoScan(This, strSearch, strFailureUrl, pvarTargetFrame)
#define IShellUIHelper_AutoCompleteAttach(This, Reserved) (This)->lpVtbl->AutoCompleteAttach(This, Reserved)
#define IShellUIHelper_ShowBrowserUI(This, bstrName, pvarIn, pvarOut) (This)->lpVtbl->ShowBrowserUI(This, bstrName, pvarIn, pvarOut)

declare function IShellUIHelper_ResetFirstBootMode_Proxy(byval This as IShellUIHelper ptr) as HRESULT
declare sub IShellUIHelper_ResetFirstBootMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_ResetSafeMode_Proxy(byval This as IShellUIHelper ptr) as HRESULT
declare sub IShellUIHelper_ResetSafeMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_RefreshOfflineDesktop_Proxy(byval This as IShellUIHelper ptr) as HRESULT
declare sub IShellUIHelper_RefreshOfflineDesktop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AddFavorite_Proxy(byval This as IShellUIHelper ptr, byval URL as BSTR, byval Title as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_AddFavorite_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AddChannel_Proxy(byval This as IShellUIHelper ptr, byval URL as BSTR) as HRESULT
declare sub IShellUIHelper_AddChannel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AddDesktopComponent_Proxy(byval This as IShellUIHelper ptr, byval URL as BSTR, byval Type as BSTR, byval Left as VARIANT ptr, byval Top as VARIANT ptr, byval Width as VARIANT ptr, byval Height as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_AddDesktopComponent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_IsSubscribed_Proxy(byval This as IShellUIHelper ptr, byval URL as BSTR, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IShellUIHelper_IsSubscribed_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_NavigateAndFind_Proxy(byval This as IShellUIHelper ptr, byval URL as BSTR, byval strQuery as BSTR, byval varTargetFrame as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_NavigateAndFind_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_ImportExportFavorites_Proxy(byval This as IShellUIHelper ptr, byval fImport as VARIANT_BOOL, byval strImpExpPath as BSTR) as HRESULT
declare sub IShellUIHelper_ImportExportFavorites_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AutoCompleteSaveForm_Proxy(byval This as IShellUIHelper ptr, byval Form as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_AutoCompleteSaveForm_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AutoScan_Proxy(byval This as IShellUIHelper ptr, byval strSearch as BSTR, byval strFailureUrl as BSTR, byval pvarTargetFrame as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_AutoScan_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_AutoCompleteAttach_Proxy(byval This as IShellUIHelper ptr, byval Reserved as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_AutoCompleteAttach_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellUIHelper_ShowBrowserUI_Proxy(byval This as IShellUIHelper ptr, byval bstrName as BSTR, byval pvarIn as VARIANT ptr, byval pvarOut as VARIANT ptr) as HRESULT
declare sub IShellUIHelper_ShowBrowserUI_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellUIHelper as const CLSID
#define __DShellNameSpaceEvents_DISPINTERFACE_DEFINED__
extern DIID_DShellNameSpaceEvents as const IID
type DShellNameSpaceEvents as DShellNameSpaceEvents_

type DShellNameSpaceEventsVtbl
	QueryInterface as function(byval This as DShellNameSpaceEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DShellNameSpaceEvents ptr) as ULONG
	Release as function(byval This as DShellNameSpaceEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as DShellNameSpaceEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DShellNameSpaceEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DShellNameSpaceEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DShellNameSpaceEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DShellNameSpaceEvents_
	lpVtbl as DShellNameSpaceEventsVtbl ptr
end type

#define DShellNameSpaceEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DShellNameSpaceEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DShellNameSpaceEvents_Release(This) (This)->lpVtbl->Release(This)
#define DShellNameSpaceEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DShellNameSpaceEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DShellNameSpaceEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DShellNameSpaceEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define __IShellFavoritesNameSpace_INTERFACE_DEFINED__
extern IID_IShellFavoritesNameSpace as const IID
type IShellFavoritesNameSpace as IShellFavoritesNameSpace_

type IShellFavoritesNameSpaceVtbl
	QueryInterface as function(byval This as IShellFavoritesNameSpace ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFavoritesNameSpace ptr) as ULONG
	Release as function(byval This as IShellFavoritesNameSpace ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellFavoritesNameSpace ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellFavoritesNameSpace ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellFavoritesNameSpace ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellFavoritesNameSpace ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	MoveSelectionUp as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	MoveSelectionDown as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	ResetSort as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	NewFolder as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	Synchronize_ as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	Import as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	Export as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	InvokeContextMenuCommand as function(byval This as IShellFavoritesNameSpace ptr, byval strCommand as BSTR) as HRESULT
	MoveSelectionTo as function(byval This as IShellFavoritesNameSpace ptr) as HRESULT
	get_SubscriptionsEnabled as function(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	CreateSubscriptionForSelection as function(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	DeleteSubscriptionForSelection as function(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	SetRoot as function(byval This as IShellFavoritesNameSpace ptr, byval bstrFullPath as BSTR) as HRESULT
end type

type IShellFavoritesNameSpace_
	lpVtbl as IShellFavoritesNameSpaceVtbl ptr
end type

#define IShellFavoritesNameSpace_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFavoritesNameSpace_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFavoritesNameSpace_Release(This) (This)->lpVtbl->Release(This)
#define IShellFavoritesNameSpace_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellFavoritesNameSpace_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellFavoritesNameSpace_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellFavoritesNameSpace_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellFavoritesNameSpace_MoveSelectionUp(This) (This)->lpVtbl->MoveSelectionUp(This)
#define IShellFavoritesNameSpace_MoveSelectionDown(This) (This)->lpVtbl->MoveSelectionDown(This)
#define IShellFavoritesNameSpace_ResetSort(This) (This)->lpVtbl->ResetSort(This)
#define IShellFavoritesNameSpace_NewFolder(This) (This)->lpVtbl->NewFolder(This)
#define IShellFavoritesNameSpace_Synchronize(This) (This)->lpVtbl->Synchronize(This)
#define IShellFavoritesNameSpace_Import(This) (This)->lpVtbl->Import(This)
#define IShellFavoritesNameSpace_Export(This) (This)->lpVtbl->Export(This)
#define IShellFavoritesNameSpace_InvokeContextMenuCommand(This, strCommand) (This)->lpVtbl->InvokeContextMenuCommand(This, strCommand)
#define IShellFavoritesNameSpace_MoveSelectionTo(This) (This)->lpVtbl->MoveSelectionTo(This)
#define IShellFavoritesNameSpace_get_SubscriptionsEnabled(This, pBool) (This)->lpVtbl->get_SubscriptionsEnabled(This, pBool)
#define IShellFavoritesNameSpace_CreateSubscriptionForSelection(This, pBool) (This)->lpVtbl->CreateSubscriptionForSelection(This, pBool)
#define IShellFavoritesNameSpace_DeleteSubscriptionForSelection(This, pBool) (This)->lpVtbl->DeleteSubscriptionForSelection(This, pBool)
#define IShellFavoritesNameSpace_SetRoot(This, bstrFullPath) (This)->lpVtbl->SetRoot(This, bstrFullPath)

declare function IShellFavoritesNameSpace_MoveSelectionUp_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_MoveSelectionUp_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_MoveSelectionDown_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_MoveSelectionDown_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_ResetSort_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_ResetSort_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_NewFolder_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_NewFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_Synchronize_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_Synchronize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_Import_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_Import_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_Export_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_Export_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_InvokeContextMenuCommand_Proxy(byval This as IShellFavoritesNameSpace ptr, byval strCommand as BSTR) as HRESULT
declare sub IShellFavoritesNameSpace_InvokeContextMenuCommand_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_MoveSelectionTo_Proxy(byval This as IShellFavoritesNameSpace ptr) as HRESULT
declare sub IShellFavoritesNameSpace_MoveSelectionTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_get_SubscriptionsEnabled_Proxy(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IShellFavoritesNameSpace_get_SubscriptionsEnabled_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_CreateSubscriptionForSelection_Proxy(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IShellFavoritesNameSpace_CreateSubscriptionForSelection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_DeleteSubscriptionForSelection_Proxy(byval This as IShellFavoritesNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
declare sub IShellFavoritesNameSpace_DeleteSubscriptionForSelection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFavoritesNameSpace_SetRoot_Proxy(byval This as IShellFavoritesNameSpace ptr, byval bstrFullPath as BSTR) as HRESULT
declare sub IShellFavoritesNameSpace_SetRoot_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellNameSpace_INTERFACE_DEFINED__
extern IID_IShellNameSpace as const IID
type IShellNameSpace as IShellNameSpace_

type IShellNameSpaceVtbl
	QueryInterface as function(byval This as IShellNameSpace ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellNameSpace ptr) as ULONG
	Release as function(byval This as IShellNameSpace ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellNameSpace ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellNameSpace ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellNameSpace ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellNameSpace ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	MoveSelectionUp as function(byval This as IShellNameSpace ptr) as HRESULT
	MoveSelectionDown as function(byval This as IShellNameSpace ptr) as HRESULT
	ResetSort as function(byval This as IShellNameSpace ptr) as HRESULT
	NewFolder as function(byval This as IShellNameSpace ptr) as HRESULT
	Synchronize_ as function(byval This as IShellNameSpace ptr) as HRESULT
	Import as function(byval This as IShellNameSpace ptr) as HRESULT
	Export as function(byval This as IShellNameSpace ptr) as HRESULT
	InvokeContextMenuCommand as function(byval This as IShellNameSpace ptr, byval strCommand as BSTR) as HRESULT
	MoveSelectionTo as function(byval This as IShellNameSpace ptr) as HRESULT
	get_SubscriptionsEnabled as function(byval This as IShellNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	CreateSubscriptionForSelection as function(byval This as IShellNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	DeleteSubscriptionForSelection as function(byval This as IShellNameSpace ptr, byval pBool as VARIANT_BOOL ptr) as HRESULT
	SetRoot as function(byval This as IShellNameSpace ptr, byval bstrFullPath as BSTR) as HRESULT
	get_EnumOptions as function(byval This as IShellNameSpace ptr, byval pgrfEnumFlags as LONG ptr) as HRESULT
	put_EnumOptions as function(byval This as IShellNameSpace ptr, byval lVal as LONG) as HRESULT
	get_SelectedItem as function(byval This as IShellNameSpace ptr, byval pItem as IDispatch ptr ptr) as HRESULT
	put_SelectedItem as function(byval This as IShellNameSpace ptr, byval pItem as IDispatch ptr) as HRESULT
	get_Root as function(byval This as IShellNameSpace ptr, byval pvar as VARIANT ptr) as HRESULT
	put_Root as function(byval This as IShellNameSpace ptr, byval var as VARIANT) as HRESULT
	get_Depth as function(byval This as IShellNameSpace ptr, byval piDepth as long ptr) as HRESULT
	put_Depth as function(byval This as IShellNameSpace ptr, byval iDepth as long) as HRESULT
	get_Mode as function(byval This as IShellNameSpace ptr, byval puMode as UINT ptr) as HRESULT
	put_Mode as function(byval This as IShellNameSpace ptr, byval uMode as UINT) as HRESULT
	get_Flags as function(byval This as IShellNameSpace ptr, byval pdwFlags as DWORD ptr) as HRESULT
	put_Flags as function(byval This as IShellNameSpace ptr, byval dwFlags as DWORD) as HRESULT
	put_TVFlags as function(byval This as IShellNameSpace ptr, byval dwFlags as DWORD) as HRESULT
	get_TVFlags as function(byval This as IShellNameSpace ptr, byval dwFlags as DWORD ptr) as HRESULT
	get_Columns as function(byval This as IShellNameSpace ptr, byval bstrColumns as BSTR ptr) as HRESULT
	put_Columns as function(byval This as IShellNameSpace ptr, byval bstrColumns as BSTR) as HRESULT
	get_CountViewTypes as function(byval This as IShellNameSpace ptr, byval piTypes as long ptr) as HRESULT
	SetViewType as function(byval This as IShellNameSpace ptr, byval iType as long) as HRESULT
	SelectedItems as function(byval This as IShellNameSpace ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Expand as function(byval This as IShellNameSpace ptr, byval var as VARIANT, byval iDepth as long) as HRESULT
	UnselectAll as function(byval This as IShellNameSpace ptr) as HRESULT
end type

type IShellNameSpace_
	lpVtbl as IShellNameSpaceVtbl ptr
end type

#define IShellNameSpace_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellNameSpace_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellNameSpace_Release(This) (This)->lpVtbl->Release(This)
#define IShellNameSpace_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellNameSpace_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellNameSpace_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellNameSpace_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellNameSpace_MoveSelectionUp(This) (This)->lpVtbl->MoveSelectionUp(This)
#define IShellNameSpace_MoveSelectionDown(This) (This)->lpVtbl->MoveSelectionDown(This)
#define IShellNameSpace_ResetSort(This) (This)->lpVtbl->ResetSort(This)
#define IShellNameSpace_NewFolder(This) (This)->lpVtbl->NewFolder(This)
#define IShellNameSpace_Synchronize(This) (This)->lpVtbl->Synchronize(This)
#define IShellNameSpace_Import(This) (This)->lpVtbl->Import(This)
#define IShellNameSpace_Export(This) (This)->lpVtbl->Export(This)
#define IShellNameSpace_InvokeContextMenuCommand(This, strCommand) (This)->lpVtbl->InvokeContextMenuCommand(This, strCommand)
#define IShellNameSpace_MoveSelectionTo(This) (This)->lpVtbl->MoveSelectionTo(This)
#define IShellNameSpace_get_SubscriptionsEnabled(This, pBool) (This)->lpVtbl->get_SubscriptionsEnabled(This, pBool)
#define IShellNameSpace_CreateSubscriptionForSelection(This, pBool) (This)->lpVtbl->CreateSubscriptionForSelection(This, pBool)
#define IShellNameSpace_DeleteSubscriptionForSelection(This, pBool) (This)->lpVtbl->DeleteSubscriptionForSelection(This, pBool)
#define IShellNameSpace_SetRoot(This, bstrFullPath) (This)->lpVtbl->SetRoot(This, bstrFullPath)
#define IShellNameSpace_get_EnumOptions(This, pgrfEnumFlags) (This)->lpVtbl->get_EnumOptions(This, pgrfEnumFlags)
#define IShellNameSpace_put_EnumOptions(This, lVal) (This)->lpVtbl->put_EnumOptions(This, lVal)
#define IShellNameSpace_get_SelectedItem(This, pItem) (This)->lpVtbl->get_SelectedItem(This, pItem)
#define IShellNameSpace_put_SelectedItem(This, pItem) (This)->lpVtbl->put_SelectedItem(This, pItem)
#define IShellNameSpace_get_Root(This, pvar) (This)->lpVtbl->get_Root(This, pvar)
#define IShellNameSpace_put_Root(This, var) (This)->lpVtbl->put_Root(This, var)
#define IShellNameSpace_get_Depth(This, piDepth) (This)->lpVtbl->get_Depth(This, piDepth)
#define IShellNameSpace_put_Depth(This, iDepth) (This)->lpVtbl->put_Depth(This, iDepth)
#define IShellNameSpace_get_Mode(This, puMode) (This)->lpVtbl->get_Mode(This, puMode)
#define IShellNameSpace_put_Mode(This, uMode) (This)->lpVtbl->put_Mode(This, uMode)
#define IShellNameSpace_get_Flags(This, pdwFlags) (This)->lpVtbl->get_Flags(This, pdwFlags)
#define IShellNameSpace_put_Flags(This, dwFlags) (This)->lpVtbl->put_Flags(This, dwFlags)
#define IShellNameSpace_put_TVFlags(This, dwFlags) (This)->lpVtbl->put_TVFlags(This, dwFlags)
#define IShellNameSpace_get_TVFlags(This, dwFlags) (This)->lpVtbl->get_TVFlags(This, dwFlags)
#define IShellNameSpace_get_Columns(This, bstrColumns) (This)->lpVtbl->get_Columns(This, bstrColumns)
#define IShellNameSpace_put_Columns(This, bstrColumns) (This)->lpVtbl->put_Columns(This, bstrColumns)
#define IShellNameSpace_get_CountViewTypes(This, piTypes) (This)->lpVtbl->get_CountViewTypes(This, piTypes)
#define IShellNameSpace_SetViewType(This, iType) (This)->lpVtbl->SetViewType(This, iType)
#define IShellNameSpace_SelectedItems(This, ppid) (This)->lpVtbl->SelectedItems(This, ppid)
#define IShellNameSpace_Expand(This, var, iDepth) (This)->lpVtbl->Expand(This, var, iDepth)
#define IShellNameSpace_UnselectAll(This) (This)->lpVtbl->UnselectAll(This)

declare function IShellNameSpace_get_EnumOptions_Proxy(byval This as IShellNameSpace ptr, byval pgrfEnumFlags as LONG ptr) as HRESULT
declare sub IShellNameSpace_get_EnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_EnumOptions_Proxy(byval This as IShellNameSpace ptr, byval lVal as LONG) as HRESULT
declare sub IShellNameSpace_put_EnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_SelectedItem_Proxy(byval This as IShellNameSpace ptr, byval pItem as IDispatch ptr ptr) as HRESULT
declare sub IShellNameSpace_get_SelectedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_SelectedItem_Proxy(byval This as IShellNameSpace ptr, byval pItem as IDispatch ptr) as HRESULT
declare sub IShellNameSpace_put_SelectedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_Root_Proxy(byval This as IShellNameSpace ptr, byval pvar as VARIANT ptr) as HRESULT
declare sub IShellNameSpace_get_Root_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_Root_Proxy(byval This as IShellNameSpace ptr, byval var as VARIANT) as HRESULT
declare sub IShellNameSpace_put_Root_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_Depth_Proxy(byval This as IShellNameSpace ptr, byval piDepth as long ptr) as HRESULT
declare sub IShellNameSpace_get_Depth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_Depth_Proxy(byval This as IShellNameSpace ptr, byval iDepth as long) as HRESULT
declare sub IShellNameSpace_put_Depth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_Mode_Proxy(byval This as IShellNameSpace ptr, byval puMode as UINT ptr) as HRESULT
declare sub IShellNameSpace_get_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_Mode_Proxy(byval This as IShellNameSpace ptr, byval uMode as UINT) as HRESULT
declare sub IShellNameSpace_put_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_Flags_Proxy(byval This as IShellNameSpace ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IShellNameSpace_get_Flags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_Flags_Proxy(byval This as IShellNameSpace ptr, byval dwFlags as DWORD) as HRESULT
declare sub IShellNameSpace_put_Flags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_TVFlags_Proxy(byval This as IShellNameSpace ptr, byval dwFlags as DWORD) as HRESULT
declare sub IShellNameSpace_put_TVFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_TVFlags_Proxy(byval This as IShellNameSpace ptr, byval dwFlags as DWORD ptr) as HRESULT
declare sub IShellNameSpace_get_TVFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_Columns_Proxy(byval This as IShellNameSpace ptr, byval bstrColumns as BSTR ptr) as HRESULT
declare sub IShellNameSpace_get_Columns_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_put_Columns_Proxy(byval This as IShellNameSpace ptr, byval bstrColumns as BSTR) as HRESULT
declare sub IShellNameSpace_put_Columns_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_get_CountViewTypes_Proxy(byval This as IShellNameSpace ptr, byval piTypes as long ptr) as HRESULT
declare sub IShellNameSpace_get_CountViewTypes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_SetViewType_Proxy(byval This as IShellNameSpace ptr, byval iType as long) as HRESULT
declare sub IShellNameSpace_SetViewType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_SelectedItems_Proxy(byval This as IShellNameSpace ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellNameSpace_SelectedItems_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_Expand_Proxy(byval This as IShellNameSpace ptr, byval var as VARIANT, byval iDepth as long) as HRESULT
declare sub IShellNameSpace_Expand_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellNameSpace_UnselectAll_Proxy(byval This as IShellNameSpace ptr) as HRESULT
declare sub IShellNameSpace_UnselectAll_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellNameSpace as const CLSID
#define __IScriptErrorList_INTERFACE_DEFINED__
extern IID_IScriptErrorList as const IID
type IScriptErrorList as IScriptErrorList_

type IScriptErrorListVtbl
	QueryInterface as function(byval This as IScriptErrorList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IScriptErrorList ptr) as ULONG
	Release as function(byval This as IScriptErrorList ptr) as ULONG
	GetTypeInfoCount as function(byval This as IScriptErrorList ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IScriptErrorList ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IScriptErrorList ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IScriptErrorList ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	advanceError as function(byval This as IScriptErrorList ptr) as HRESULT
	retreatError as function(byval This as IScriptErrorList ptr) as HRESULT
	canAdvanceError as function(byval This as IScriptErrorList ptr, byval pfCanAdvance as WINBOOL ptr) as HRESULT
	canRetreatError as function(byval This as IScriptErrorList ptr, byval pfCanRetreat as WINBOOL ptr) as HRESULT
	getErrorLine as function(byval This as IScriptErrorList ptr, byval plLine as LONG ptr) as HRESULT
	getErrorChar as function(byval This as IScriptErrorList ptr, byval plChar as LONG ptr) as HRESULT
	getErrorCode as function(byval This as IScriptErrorList ptr, byval plCode as LONG ptr) as HRESULT
	getErrorMsg as function(byval This as IScriptErrorList ptr, byval pstr as BSTR ptr) as HRESULT
	getErrorUrl as function(byval This as IScriptErrorList ptr, byval pstr as BSTR ptr) as HRESULT
	getAlwaysShowLockState as function(byval This as IScriptErrorList ptr, byval pfAlwaysShowLocked as WINBOOL ptr) as HRESULT
	getDetailsPaneOpen as function(byval This as IScriptErrorList ptr, byval pfDetailsPaneOpen as WINBOOL ptr) as HRESULT
	setDetailsPaneOpen as function(byval This as IScriptErrorList ptr, byval fDetailsPaneOpen as WINBOOL) as HRESULT
	getPerErrorDisplay as function(byval This as IScriptErrorList ptr, byval pfPerErrorDisplay as WINBOOL ptr) as HRESULT
	setPerErrorDisplay as function(byval This as IScriptErrorList ptr, byval fPerErrorDisplay as WINBOOL) as HRESULT
end type

type IScriptErrorList_
	lpVtbl as IScriptErrorListVtbl ptr
end type

#define IScriptErrorList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IScriptErrorList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IScriptErrorList_Release(This) (This)->lpVtbl->Release(This)
#define IScriptErrorList_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IScriptErrorList_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IScriptErrorList_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IScriptErrorList_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IScriptErrorList_advanceError(This) (This)->lpVtbl->advanceError(This)
#define IScriptErrorList_retreatError(This) (This)->lpVtbl->retreatError(This)
#define IScriptErrorList_canAdvanceError(This, pfCanAdvance) (This)->lpVtbl->canAdvanceError(This, pfCanAdvance)
#define IScriptErrorList_canRetreatError(This, pfCanRetreat) (This)->lpVtbl->canRetreatError(This, pfCanRetreat)
#define IScriptErrorList_getErrorLine(This, plLine) (This)->lpVtbl->getErrorLine(This, plLine)
#define IScriptErrorList_getErrorChar(This, plChar) (This)->lpVtbl->getErrorChar(This, plChar)
#define IScriptErrorList_getErrorCode(This, plCode) (This)->lpVtbl->getErrorCode(This, plCode)
#define IScriptErrorList_getErrorMsg(This, pstr) (This)->lpVtbl->getErrorMsg(This, pstr)
#define IScriptErrorList_getErrorUrl(This, pstr) (This)->lpVtbl->getErrorUrl(This, pstr)
#define IScriptErrorList_getAlwaysShowLockState(This, pfAlwaysShowLocked) (This)->lpVtbl->getAlwaysShowLockState(This, pfAlwaysShowLocked)
#define IScriptErrorList_getDetailsPaneOpen(This, pfDetailsPaneOpen) (This)->lpVtbl->getDetailsPaneOpen(This, pfDetailsPaneOpen)
#define IScriptErrorList_setDetailsPaneOpen(This, fDetailsPaneOpen) (This)->lpVtbl->setDetailsPaneOpen(This, fDetailsPaneOpen)
#define IScriptErrorList_getPerErrorDisplay(This, pfPerErrorDisplay) (This)->lpVtbl->getPerErrorDisplay(This, pfPerErrorDisplay)
#define IScriptErrorList_setPerErrorDisplay(This, fPerErrorDisplay) (This)->lpVtbl->setPerErrorDisplay(This, fPerErrorDisplay)

declare function IScriptErrorList_advanceError_Proxy(byval This as IScriptErrorList ptr) as HRESULT
declare sub IScriptErrorList_advanceError_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_retreatError_Proxy(byval This as IScriptErrorList ptr) as HRESULT
declare sub IScriptErrorList_retreatError_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_canAdvanceError_Proxy(byval This as IScriptErrorList ptr, byval pfCanAdvance as WINBOOL ptr) as HRESULT
declare sub IScriptErrorList_canAdvanceError_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_canRetreatError_Proxy(byval This as IScriptErrorList ptr, byval pfCanRetreat as WINBOOL ptr) as HRESULT
declare sub IScriptErrorList_canRetreatError_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getErrorLine_Proxy(byval This as IScriptErrorList ptr, byval plLine as LONG ptr) as HRESULT
declare sub IScriptErrorList_getErrorLine_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getErrorChar_Proxy(byval This as IScriptErrorList ptr, byval plChar as LONG ptr) as HRESULT
declare sub IScriptErrorList_getErrorChar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getErrorCode_Proxy(byval This as IScriptErrorList ptr, byval plCode as LONG ptr) as HRESULT
declare sub IScriptErrorList_getErrorCode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getErrorMsg_Proxy(byval This as IScriptErrorList ptr, byval pstr as BSTR ptr) as HRESULT
declare sub IScriptErrorList_getErrorMsg_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getErrorUrl_Proxy(byval This as IScriptErrorList ptr, byval pstr as BSTR ptr) as HRESULT
declare sub IScriptErrorList_getErrorUrl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getAlwaysShowLockState_Proxy(byval This as IScriptErrorList ptr, byval pfAlwaysShowLocked as WINBOOL ptr) as HRESULT
declare sub IScriptErrorList_getAlwaysShowLockState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getDetailsPaneOpen_Proxy(byval This as IScriptErrorList ptr, byval pfDetailsPaneOpen as WINBOOL ptr) as HRESULT
declare sub IScriptErrorList_getDetailsPaneOpen_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_setDetailsPaneOpen_Proxy(byval This as IScriptErrorList ptr, byval fDetailsPaneOpen as WINBOOL) as HRESULT
declare sub IScriptErrorList_setDetailsPaneOpen_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_getPerErrorDisplay_Proxy(byval This as IScriptErrorList ptr, byval pfPerErrorDisplay as WINBOOL ptr) as HRESULT
declare sub IScriptErrorList_getPerErrorDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IScriptErrorList_setPerErrorDisplay_Proxy(byval This as IScriptErrorList ptr, byval fPerErrorDisplay as WINBOOL) as HRESULT
declare sub IScriptErrorList_setPerErrorDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_CScriptErrorList as const CLSID
#define __ISearch_INTERFACE_DEFINED__
extern IID_ISearch as const IID
type ISearch as ISearch_

type ISearchVtbl
	QueryInterface as function(byval This as ISearch ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearch ptr) as ULONG
	Release as function(byval This as ISearch ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearch ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearch ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearch ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Title as function(byval This as ISearch ptr, byval pbstrTitle as BSTR ptr) as HRESULT
	get_Id as function(byval This as ISearch ptr, byval pbstrId as BSTR ptr) as HRESULT
	get_Url as function(byval This as ISearch ptr, byval pbstrUrl as BSTR ptr) as HRESULT
end type

type ISearch_
	lpVtbl as ISearchVtbl ptr
end type

#define ISearch_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISearch_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISearch_Release(This) (This)->lpVtbl->Release(This)
#define ISearch_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define ISearch_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define ISearch_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define ISearch_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define ISearch_get_Title(This, pbstrTitle) (This)->lpVtbl->get_Title(This, pbstrTitle)
#define ISearch_get_Id(This, pbstrId) (This)->lpVtbl->get_Id(This, pbstrId)
#define ISearch_get_Url(This, pbstrUrl) (This)->lpVtbl->get_Url(This, pbstrUrl)

declare function ISearch_get_Title_Proxy(byval This as ISearch ptr, byval pbstrTitle as BSTR ptr) as HRESULT
declare sub ISearch_get_Title_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearch_get_Id_Proxy(byval This as ISearch ptr, byval pbstrId as BSTR ptr) as HRESULT
declare sub ISearch_get_Id_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearch_get_Url_Proxy(byval This as ISearch ptr, byval pbstrUrl as BSTR ptr) as HRESULT
declare sub ISearch_get_Url_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __ISearches_INTERFACE_DEFINED__
extern IID_ISearches as const IID
type ISearches as ISearches_

type ISearchesVtbl
	QueryInterface as function(byval This as ISearches ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearches ptr) as ULONG
	Release as function(byval This as ISearches ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearches ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearches ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearches ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearches ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as ISearches ptr, byval plCount as long ptr) as HRESULT
	get_Default as function(byval This as ISearches ptr, byval pbstrDefault as BSTR ptr) as HRESULT
	Item as function(byval This as ISearches ptr, byval index as VARIANT, byval ppid as ISearch ptr ptr) as HRESULT
	_NewEnum as function(byval This as ISearches ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
end type

type ISearches_
	lpVtbl as ISearchesVtbl ptr
end type

#define ISearches_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISearches_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISearches_Release(This) (This)->lpVtbl->Release(This)
#define ISearches_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define ISearches_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define ISearches_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define ISearches_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define ISearches_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define ISearches_get_Default(This, pbstrDefault) (This)->lpVtbl->get_Default(This, pbstrDefault)
#define ISearches_Item(This, index, ppid) (This)->lpVtbl->Item(This, index, ppid)
#define ISearches__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)

declare function ISearches_get_Count_Proxy(byval This as ISearches ptr, byval plCount as long ptr) as HRESULT
declare sub ISearches_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearches_get_Default_Proxy(byval This as ISearches ptr, byval pbstrDefault as BSTR ptr) as HRESULT
declare sub ISearches_get_Default_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearches_Item_Proxy(byval This as ISearches ptr, byval index as VARIANT, byval ppid as ISearch ptr ptr) as HRESULT
declare sub ISearches_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearches__NewEnum_Proxy(byval This as ISearches ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub ISearches__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __ISearchAssistantOC_INTERFACE_DEFINED__
extern IID_ISearchAssistantOC as const IID
type ISearchAssistantOC as ISearchAssistantOC_

type ISearchAssistantOCVtbl
	QueryInterface as function(byval This as ISearchAssistantOC ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearchAssistantOC ptr) as ULONG
	Release as function(byval This as ISearchAssistantOC ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearchAssistantOC ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearchAssistantOC ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearchAssistantOC ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearchAssistantOC ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	AddNextMenuItem as function(byval This as ISearchAssistantOC ptr, byval bstrText as BSTR, byval idItem as long) as HRESULT
	SetDefaultSearchUrl as function(byval This as ISearchAssistantOC ptr, byval bstrUrl as BSTR) as HRESULT
	NavigateToDefaultSearch as function(byval This as ISearchAssistantOC ptr) as HRESULT
	IsRestricted as function(byval This as ISearchAssistantOC ptr, byval bstrGuid as BSTR, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_ShellFeaturesEnabled as function(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_SearchAssistantDefault as function(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_Searches as function(byval This as ISearchAssistantOC ptr, byval ppid as ISearches ptr ptr) as HRESULT
	get_InWebFolder as function(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	PutProperty as function(byval This as ISearchAssistantOC ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval bstrValue as BSTR) as HRESULT
	GetProperty as function(byval This as ISearchAssistantOC ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
	put_EventHandled as function(byval This as ISearchAssistantOC ptr, byval bHandled as VARIANT_BOOL) as HRESULT
	ResetNextMenu as function(byval This as ISearchAssistantOC ptr) as HRESULT
	FindOnWeb as function(byval This as ISearchAssistantOC ptr) as HRESULT
	FindFilesOrFolders as function(byval This as ISearchAssistantOC ptr) as HRESULT
	FindComputer as function(byval This as ISearchAssistantOC ptr) as HRESULT
	FindPrinter as function(byval This as ISearchAssistantOC ptr) as HRESULT
	FindPeople as function(byval This as ISearchAssistantOC ptr) as HRESULT
	GetSearchAssistantURL as function(byval This as ISearchAssistantOC ptr, byval bSubstitute as VARIANT_BOOL, byval bCustomize as VARIANT_BOOL, byval pbstrValue as BSTR ptr) as HRESULT
	NotifySearchSettingsChanged as function(byval This as ISearchAssistantOC ptr) as HRESULT
	put_ASProvider as function(byval This as ISearchAssistantOC ptr, byval Provider as BSTR) as HRESULT
	get_ASProvider as function(byval This as ISearchAssistantOC ptr, byval pProvider as BSTR ptr) as HRESULT
	put_ASSetting as function(byval This as ISearchAssistantOC ptr, byval Setting as long) as HRESULT
	get_ASSetting as function(byval This as ISearchAssistantOC ptr, byval pSetting as long ptr) as HRESULT
	NETDetectNextNavigate as function(byval This as ISearchAssistantOC ptr) as HRESULT
	PutFindText as function(byval This as ISearchAssistantOC ptr, byval FindText as BSTR) as HRESULT
	get_Version as function(byval This as ISearchAssistantOC ptr, byval pVersion as long ptr) as HRESULT
	EncodeString as function(byval This as ISearchAssistantOC ptr, byval bstrValue as BSTR, byval bstrCharSet as BSTR, byval bUseUTF8 as VARIANT_BOOL, byval pbstrResult as BSTR ptr) as HRESULT
end type

type ISearchAssistantOC_
	lpVtbl as ISearchAssistantOCVtbl ptr
end type

#define ISearchAssistantOC_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISearchAssistantOC_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISearchAssistantOC_Release(This) (This)->lpVtbl->Release(This)
#define ISearchAssistantOC_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define ISearchAssistantOC_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define ISearchAssistantOC_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define ISearchAssistantOC_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define ISearchAssistantOC_AddNextMenuItem(This, bstrText, idItem) (This)->lpVtbl->AddNextMenuItem(This, bstrText, idItem)
#define ISearchAssistantOC_SetDefaultSearchUrl(This, bstrUrl) (This)->lpVtbl->SetDefaultSearchUrl(This, bstrUrl)
#define ISearchAssistantOC_NavigateToDefaultSearch(This) (This)->lpVtbl->NavigateToDefaultSearch(This)
#define ISearchAssistantOC_IsRestricted(This, bstrGuid, pVal) (This)->lpVtbl->IsRestricted(This, bstrGuid, pVal)
#define ISearchAssistantOC_get_ShellFeaturesEnabled(This, pVal) (This)->lpVtbl->get_ShellFeaturesEnabled(This, pVal)
#define ISearchAssistantOC_get_SearchAssistantDefault(This, pVal) (This)->lpVtbl->get_SearchAssistantDefault(This, pVal)
#define ISearchAssistantOC_get_Searches(This, ppid) (This)->lpVtbl->get_Searches(This, ppid)
#define ISearchAssistantOC_get_InWebFolder(This, pVal) (This)->lpVtbl->get_InWebFolder(This, pVal)
#define ISearchAssistantOC_PutProperty(This, bPerLocale, bstrName, bstrValue) (This)->lpVtbl->PutProperty(This, bPerLocale, bstrName, bstrValue)
#define ISearchAssistantOC_GetProperty(This, bPerLocale, bstrName, pbstrValue) (This)->lpVtbl->GetProperty(This, bPerLocale, bstrName, pbstrValue)
#define ISearchAssistantOC_put_EventHandled(This, bHandled) (This)->lpVtbl->put_EventHandled(This, bHandled)
#define ISearchAssistantOC_ResetNextMenu(This) (This)->lpVtbl->ResetNextMenu(This)
#define ISearchAssistantOC_FindOnWeb(This) (This)->lpVtbl->FindOnWeb(This)
#define ISearchAssistantOC_FindFilesOrFolders(This) (This)->lpVtbl->FindFilesOrFolders(This)
#define ISearchAssistantOC_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define ISearchAssistantOC_FindPrinter(This) (This)->lpVtbl->FindPrinter(This)
#define ISearchAssistantOC_FindPeople(This) (This)->lpVtbl->FindPeople(This)
#define ISearchAssistantOC_GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue) (This)->lpVtbl->GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue)
#define ISearchAssistantOC_NotifySearchSettingsChanged(This) (This)->lpVtbl->NotifySearchSettingsChanged(This)
#define ISearchAssistantOC_put_ASProvider(This, Provider) (This)->lpVtbl->put_ASProvider(This, Provider)
#define ISearchAssistantOC_get_ASProvider(This, pProvider) (This)->lpVtbl->get_ASProvider(This, pProvider)
#define ISearchAssistantOC_put_ASSetting(This, Setting) (This)->lpVtbl->put_ASSetting(This, Setting)
#define ISearchAssistantOC_get_ASSetting(This, pSetting) (This)->lpVtbl->get_ASSetting(This, pSetting)
#define ISearchAssistantOC_NETDetectNextNavigate(This) (This)->lpVtbl->NETDetectNextNavigate(This)
#define ISearchAssistantOC_PutFindText(This, FindText) (This)->lpVtbl->PutFindText(This, FindText)
#define ISearchAssistantOC_get_Version(This, pVersion) (This)->lpVtbl->get_Version(This, pVersion)
#define ISearchAssistantOC_EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult) (This)->lpVtbl->EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult)

declare function ISearchAssistantOC_AddNextMenuItem_Proxy(byval This as ISearchAssistantOC ptr, byval bstrText as BSTR, byval idItem as long) as HRESULT
declare sub ISearchAssistantOC_AddNextMenuItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_SetDefaultSearchUrl_Proxy(byval This as ISearchAssistantOC ptr, byval bstrUrl as BSTR) as HRESULT
declare sub ISearchAssistantOC_SetDefaultSearchUrl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_NavigateToDefaultSearch_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_NavigateToDefaultSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_IsRestricted_Proxy(byval This as ISearchAssistantOC ptr, byval bstrGuid as BSTR, byval pVal as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC_IsRestricted_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_ShellFeaturesEnabled_Proxy(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC_get_ShellFeaturesEnabled_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_SearchAssistantDefault_Proxy(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC_get_SearchAssistantDefault_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_Searches_Proxy(byval This as ISearchAssistantOC ptr, byval ppid as ISearches ptr ptr) as HRESULT
declare sub ISearchAssistantOC_get_Searches_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_InWebFolder_Proxy(byval This as ISearchAssistantOC ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC_get_InWebFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_PutProperty_Proxy(byval This as ISearchAssistantOC ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval bstrValue as BSTR) as HRESULT
declare sub ISearchAssistantOC_PutProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_GetProperty_Proxy(byval This as ISearchAssistantOC ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
declare sub ISearchAssistantOC_GetProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_put_EventHandled_Proxy(byval This as ISearchAssistantOC ptr, byval bHandled as VARIANT_BOOL) as HRESULT
declare sub ISearchAssistantOC_put_EventHandled_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_ResetNextMenu_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_ResetNextMenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_FindOnWeb_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_FindOnWeb_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_FindFilesOrFolders_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_FindFilesOrFolders_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_FindComputer_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_FindComputer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_FindPrinter_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_FindPrinter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_FindPeople_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_FindPeople_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_GetSearchAssistantURL_Proxy(byval This as ISearchAssistantOC ptr, byval bSubstitute as VARIANT_BOOL, byval bCustomize as VARIANT_BOOL, byval pbstrValue as BSTR ptr) as HRESULT
declare sub ISearchAssistantOC_GetSearchAssistantURL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_NotifySearchSettingsChanged_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_NotifySearchSettingsChanged_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_put_ASProvider_Proxy(byval This as ISearchAssistantOC ptr, byval Provider as BSTR) as HRESULT
declare sub ISearchAssistantOC_put_ASProvider_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_ASProvider_Proxy(byval This as ISearchAssistantOC ptr, byval pProvider as BSTR ptr) as HRESULT
declare sub ISearchAssistantOC_get_ASProvider_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_put_ASSetting_Proxy(byval This as ISearchAssistantOC ptr, byval Setting as long) as HRESULT
declare sub ISearchAssistantOC_put_ASSetting_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_ASSetting_Proxy(byval This as ISearchAssistantOC ptr, byval pSetting as long ptr) as HRESULT
declare sub ISearchAssistantOC_get_ASSetting_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_NETDetectNextNavigate_Proxy(byval This as ISearchAssistantOC ptr) as HRESULT
declare sub ISearchAssistantOC_NETDetectNextNavigate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_PutFindText_Proxy(byval This as ISearchAssistantOC ptr, byval FindText as BSTR) as HRESULT
declare sub ISearchAssistantOC_PutFindText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_get_Version_Proxy(byval This as ISearchAssistantOC ptr, byval pVersion as long ptr) as HRESULT
declare sub ISearchAssistantOC_get_Version_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC_EncodeString_Proxy(byval This as ISearchAssistantOC ptr, byval bstrValue as BSTR, byval bstrCharSet as BSTR, byval bUseUTF8 as VARIANT_BOOL, byval pbstrResult as BSTR ptr) as HRESULT
declare sub ISearchAssistantOC_EncodeString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __ISearchAssistantOC2_INTERFACE_DEFINED__
extern IID_ISearchAssistantOC2 as const IID
type ISearchAssistantOC2 as ISearchAssistantOC2_

type ISearchAssistantOC2Vtbl
	QueryInterface as function(byval This as ISearchAssistantOC2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearchAssistantOC2 ptr) as ULONG
	Release as function(byval This as ISearchAssistantOC2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearchAssistantOC2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearchAssistantOC2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearchAssistantOC2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearchAssistantOC2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	AddNextMenuItem as function(byval This as ISearchAssistantOC2 ptr, byval bstrText as BSTR, byval idItem as long) as HRESULT
	SetDefaultSearchUrl as function(byval This as ISearchAssistantOC2 ptr, byval bstrUrl as BSTR) as HRESULT
	NavigateToDefaultSearch as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	IsRestricted as function(byval This as ISearchAssistantOC2 ptr, byval bstrGuid as BSTR, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_ShellFeaturesEnabled as function(byval This as ISearchAssistantOC2 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_SearchAssistantDefault as function(byval This as ISearchAssistantOC2 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_Searches as function(byval This as ISearchAssistantOC2 ptr, byval ppid as ISearches ptr ptr) as HRESULT
	get_InWebFolder as function(byval This as ISearchAssistantOC2 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	PutProperty as function(byval This as ISearchAssistantOC2 ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval bstrValue as BSTR) as HRESULT
	GetProperty as function(byval This as ISearchAssistantOC2 ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
	put_EventHandled as function(byval This as ISearchAssistantOC2 ptr, byval bHandled as VARIANT_BOOL) as HRESULT
	ResetNextMenu as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	FindOnWeb as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	FindFilesOrFolders as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	FindComputer as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	FindPrinter as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	FindPeople as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	GetSearchAssistantURL as function(byval This as ISearchAssistantOC2 ptr, byval bSubstitute as VARIANT_BOOL, byval bCustomize as VARIANT_BOOL, byval pbstrValue as BSTR ptr) as HRESULT
	NotifySearchSettingsChanged as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	put_ASProvider as function(byval This as ISearchAssistantOC2 ptr, byval Provider as BSTR) as HRESULT
	get_ASProvider as function(byval This as ISearchAssistantOC2 ptr, byval pProvider as BSTR ptr) as HRESULT
	put_ASSetting as function(byval This as ISearchAssistantOC2 ptr, byval Setting as long) as HRESULT
	get_ASSetting as function(byval This as ISearchAssistantOC2 ptr, byval pSetting as long ptr) as HRESULT
	NETDetectNextNavigate as function(byval This as ISearchAssistantOC2 ptr) as HRESULT
	PutFindText as function(byval This as ISearchAssistantOC2 ptr, byval FindText as BSTR) as HRESULT
	get_Version as function(byval This as ISearchAssistantOC2 ptr, byval pVersion as long ptr) as HRESULT
	EncodeString as function(byval This as ISearchAssistantOC2 ptr, byval bstrValue as BSTR, byval bstrCharSet as BSTR, byval bUseUTF8 as VARIANT_BOOL, byval pbstrResult as BSTR ptr) as HRESULT
	get_ShowFindPrinter as function(byval This as ISearchAssistantOC2 ptr, byval pbShowFindPrinter as VARIANT_BOOL ptr) as HRESULT
end type

type ISearchAssistantOC2_
	lpVtbl as ISearchAssistantOC2Vtbl ptr
end type

#define ISearchAssistantOC2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISearchAssistantOC2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISearchAssistantOC2_Release(This) (This)->lpVtbl->Release(This)
#define ISearchAssistantOC2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define ISearchAssistantOC2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define ISearchAssistantOC2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define ISearchAssistantOC2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define ISearchAssistantOC2_AddNextMenuItem(This, bstrText, idItem) (This)->lpVtbl->AddNextMenuItem(This, bstrText, idItem)
#define ISearchAssistantOC2_SetDefaultSearchUrl(This, bstrUrl) (This)->lpVtbl->SetDefaultSearchUrl(This, bstrUrl)
#define ISearchAssistantOC2_NavigateToDefaultSearch(This) (This)->lpVtbl->NavigateToDefaultSearch(This)
#define ISearchAssistantOC2_IsRestricted(This, bstrGuid, pVal) (This)->lpVtbl->IsRestricted(This, bstrGuid, pVal)
#define ISearchAssistantOC2_get_ShellFeaturesEnabled(This, pVal) (This)->lpVtbl->get_ShellFeaturesEnabled(This, pVal)
#define ISearchAssistantOC2_get_SearchAssistantDefault(This, pVal) (This)->lpVtbl->get_SearchAssistantDefault(This, pVal)
#define ISearchAssistantOC2_get_Searches(This, ppid) (This)->lpVtbl->get_Searches(This, ppid)
#define ISearchAssistantOC2_get_InWebFolder(This, pVal) (This)->lpVtbl->get_InWebFolder(This, pVal)
#define ISearchAssistantOC2_PutProperty(This, bPerLocale, bstrName, bstrValue) (This)->lpVtbl->PutProperty(This, bPerLocale, bstrName, bstrValue)
#define ISearchAssistantOC2_GetProperty(This, bPerLocale, bstrName, pbstrValue) (This)->lpVtbl->GetProperty(This, bPerLocale, bstrName, pbstrValue)
#define ISearchAssistantOC2_put_EventHandled(This, bHandled) (This)->lpVtbl->put_EventHandled(This, bHandled)
#define ISearchAssistantOC2_ResetNextMenu(This) (This)->lpVtbl->ResetNextMenu(This)
#define ISearchAssistantOC2_FindOnWeb(This) (This)->lpVtbl->FindOnWeb(This)
#define ISearchAssistantOC2_FindFilesOrFolders(This) (This)->lpVtbl->FindFilesOrFolders(This)
#define ISearchAssistantOC2_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define ISearchAssistantOC2_FindPrinter(This) (This)->lpVtbl->FindPrinter(This)
#define ISearchAssistantOC2_FindPeople(This) (This)->lpVtbl->FindPeople(This)
#define ISearchAssistantOC2_GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue) (This)->lpVtbl->GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue)
#define ISearchAssistantOC2_NotifySearchSettingsChanged(This) (This)->lpVtbl->NotifySearchSettingsChanged(This)
#define ISearchAssistantOC2_put_ASProvider(This, Provider) (This)->lpVtbl->put_ASProvider(This, Provider)
#define ISearchAssistantOC2_get_ASProvider(This, pProvider) (This)->lpVtbl->get_ASProvider(This, pProvider)
#define ISearchAssistantOC2_put_ASSetting(This, Setting) (This)->lpVtbl->put_ASSetting(This, Setting)
#define ISearchAssistantOC2_get_ASSetting(This, pSetting) (This)->lpVtbl->get_ASSetting(This, pSetting)
#define ISearchAssistantOC2_NETDetectNextNavigate(This) (This)->lpVtbl->NETDetectNextNavigate(This)
#define ISearchAssistantOC2_PutFindText(This, FindText) (This)->lpVtbl->PutFindText(This, FindText)
#define ISearchAssistantOC2_get_Version(This, pVersion) (This)->lpVtbl->get_Version(This, pVersion)
#define ISearchAssistantOC2_EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult) (This)->lpVtbl->EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult)
#define ISearchAssistantOC2_get_ShowFindPrinter(This, pbShowFindPrinter) (This)->lpVtbl->get_ShowFindPrinter(This, pbShowFindPrinter)
declare function ISearchAssistantOC2_get_ShowFindPrinter_Proxy(byval This as ISearchAssistantOC2 ptr, byval pbShowFindPrinter as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC2_get_ShowFindPrinter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __ISearchAssistantOC3_INTERFACE_DEFINED__
extern IID_ISearchAssistantOC3 as const IID
type ISearchAssistantOC3 as ISearchAssistantOC3_

type ISearchAssistantOC3Vtbl
	QueryInterface as function(byval This as ISearchAssistantOC3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearchAssistantOC3 ptr) as ULONG
	Release as function(byval This as ISearchAssistantOC3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearchAssistantOC3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearchAssistantOC3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearchAssistantOC3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearchAssistantOC3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	AddNextMenuItem as function(byval This as ISearchAssistantOC3 ptr, byval bstrText as BSTR, byval idItem as long) as HRESULT
	SetDefaultSearchUrl as function(byval This as ISearchAssistantOC3 ptr, byval bstrUrl as BSTR) as HRESULT
	NavigateToDefaultSearch as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	IsRestricted as function(byval This as ISearchAssistantOC3 ptr, byval bstrGuid as BSTR, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_ShellFeaturesEnabled as function(byval This as ISearchAssistantOC3 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_SearchAssistantDefault as function(byval This as ISearchAssistantOC3 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	get_Searches as function(byval This as ISearchAssistantOC3 ptr, byval ppid as ISearches ptr ptr) as HRESULT
	get_InWebFolder as function(byval This as ISearchAssistantOC3 ptr, byval pVal as VARIANT_BOOL ptr) as HRESULT
	PutProperty as function(byval This as ISearchAssistantOC3 ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval bstrValue as BSTR) as HRESULT
	GetProperty as function(byval This as ISearchAssistantOC3 ptr, byval bPerLocale as VARIANT_BOOL, byval bstrName as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
	put_EventHandled as function(byval This as ISearchAssistantOC3 ptr, byval bHandled as VARIANT_BOOL) as HRESULT
	ResetNextMenu as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	FindOnWeb as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	FindFilesOrFolders as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	FindComputer as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	FindPrinter as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	FindPeople as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	GetSearchAssistantURL as function(byval This as ISearchAssistantOC3 ptr, byval bSubstitute as VARIANT_BOOL, byval bCustomize as VARIANT_BOOL, byval pbstrValue as BSTR ptr) as HRESULT
	NotifySearchSettingsChanged as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	put_ASProvider as function(byval This as ISearchAssistantOC3 ptr, byval Provider as BSTR) as HRESULT
	get_ASProvider as function(byval This as ISearchAssistantOC3 ptr, byval pProvider as BSTR ptr) as HRESULT
	put_ASSetting as function(byval This as ISearchAssistantOC3 ptr, byval Setting as long) as HRESULT
	get_ASSetting as function(byval This as ISearchAssistantOC3 ptr, byval pSetting as long ptr) as HRESULT
	NETDetectNextNavigate as function(byval This as ISearchAssistantOC3 ptr) as HRESULT
	PutFindText as function(byval This as ISearchAssistantOC3 ptr, byval FindText as BSTR) as HRESULT
	get_Version as function(byval This as ISearchAssistantOC3 ptr, byval pVersion as long ptr) as HRESULT
	EncodeString as function(byval This as ISearchAssistantOC3 ptr, byval bstrValue as BSTR, byval bstrCharSet as BSTR, byval bUseUTF8 as VARIANT_BOOL, byval pbstrResult as BSTR ptr) as HRESULT
	get_ShowFindPrinter as function(byval This as ISearchAssistantOC3 ptr, byval pbShowFindPrinter as VARIANT_BOOL ptr) as HRESULT
	get_SearchCompanionAvailable as function(byval This as ISearchAssistantOC3 ptr, byval pbAvailable as VARIANT_BOOL ptr) as HRESULT
	put_UseSearchCompanion as function(byval This as ISearchAssistantOC3 ptr, byval bUseSC as VARIANT_BOOL) as HRESULT
	get_UseSearchCompanion as function(byval This as ISearchAssistantOC3 ptr, byval pbUseSC as VARIANT_BOOL ptr) as HRESULT
end type

type ISearchAssistantOC3_
	lpVtbl as ISearchAssistantOC3Vtbl ptr
end type

#define ISearchAssistantOC3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISearchAssistantOC3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISearchAssistantOC3_Release(This) (This)->lpVtbl->Release(This)
#define ISearchAssistantOC3_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define ISearchAssistantOC3_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define ISearchAssistantOC3_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define ISearchAssistantOC3_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define ISearchAssistantOC3_AddNextMenuItem(This, bstrText, idItem) (This)->lpVtbl->AddNextMenuItem(This, bstrText, idItem)
#define ISearchAssistantOC3_SetDefaultSearchUrl(This, bstrUrl) (This)->lpVtbl->SetDefaultSearchUrl(This, bstrUrl)
#define ISearchAssistantOC3_NavigateToDefaultSearch(This) (This)->lpVtbl->NavigateToDefaultSearch(This)
#define ISearchAssistantOC3_IsRestricted(This, bstrGuid, pVal) (This)->lpVtbl->IsRestricted(This, bstrGuid, pVal)
#define ISearchAssistantOC3_get_ShellFeaturesEnabled(This, pVal) (This)->lpVtbl->get_ShellFeaturesEnabled(This, pVal)
#define ISearchAssistantOC3_get_SearchAssistantDefault(This, pVal) (This)->lpVtbl->get_SearchAssistantDefault(This, pVal)
#define ISearchAssistantOC3_get_Searches(This, ppid) (This)->lpVtbl->get_Searches(This, ppid)
#define ISearchAssistantOC3_get_InWebFolder(This, pVal) (This)->lpVtbl->get_InWebFolder(This, pVal)
#define ISearchAssistantOC3_PutProperty(This, bPerLocale, bstrName, bstrValue) (This)->lpVtbl->PutProperty(This, bPerLocale, bstrName, bstrValue)
#define ISearchAssistantOC3_GetProperty(This, bPerLocale, bstrName, pbstrValue) (This)->lpVtbl->GetProperty(This, bPerLocale, bstrName, pbstrValue)
#define ISearchAssistantOC3_put_EventHandled(This, bHandled) (This)->lpVtbl->put_EventHandled(This, bHandled)
#define ISearchAssistantOC3_ResetNextMenu(This) (This)->lpVtbl->ResetNextMenu(This)
#define ISearchAssistantOC3_FindOnWeb(This) (This)->lpVtbl->FindOnWeb(This)
#define ISearchAssistantOC3_FindFilesOrFolders(This) (This)->lpVtbl->FindFilesOrFolders(This)
#define ISearchAssistantOC3_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define ISearchAssistantOC3_FindPrinter(This) (This)->lpVtbl->FindPrinter(This)
#define ISearchAssistantOC3_FindPeople(This) (This)->lpVtbl->FindPeople(This)
#define ISearchAssistantOC3_GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue) (This)->lpVtbl->GetSearchAssistantURL(This, bSubstitute, bCustomize, pbstrValue)
#define ISearchAssistantOC3_NotifySearchSettingsChanged(This) (This)->lpVtbl->NotifySearchSettingsChanged(This)
#define ISearchAssistantOC3_put_ASProvider(This, Provider) (This)->lpVtbl->put_ASProvider(This, Provider)
#define ISearchAssistantOC3_get_ASProvider(This, pProvider) (This)->lpVtbl->get_ASProvider(This, pProvider)
#define ISearchAssistantOC3_put_ASSetting(This, Setting) (This)->lpVtbl->put_ASSetting(This, Setting)
#define ISearchAssistantOC3_get_ASSetting(This, pSetting) (This)->lpVtbl->get_ASSetting(This, pSetting)
#define ISearchAssistantOC3_NETDetectNextNavigate(This) (This)->lpVtbl->NETDetectNextNavigate(This)
#define ISearchAssistantOC3_PutFindText(This, FindText) (This)->lpVtbl->PutFindText(This, FindText)
#define ISearchAssistantOC3_get_Version(This, pVersion) (This)->lpVtbl->get_Version(This, pVersion)
#define ISearchAssistantOC3_EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult) (This)->lpVtbl->EncodeString(This, bstrValue, bstrCharSet, bUseUTF8, pbstrResult)
#define ISearchAssistantOC3_get_ShowFindPrinter(This, pbShowFindPrinter) (This)->lpVtbl->get_ShowFindPrinter(This, pbShowFindPrinter)
#define ISearchAssistantOC3_get_SearchCompanionAvailable(This, pbAvailable) (This)->lpVtbl->get_SearchCompanionAvailable(This, pbAvailable)
#define ISearchAssistantOC3_put_UseSearchCompanion(This, bUseSC) (This)->lpVtbl->put_UseSearchCompanion(This, bUseSC)
#define ISearchAssistantOC3_get_UseSearchCompanion(This, pbUseSC) (This)->lpVtbl->get_UseSearchCompanion(This, pbUseSC)

declare function ISearchAssistantOC3_get_SearchCompanionAvailable_Proxy(byval This as ISearchAssistantOC3 ptr, byval pbAvailable as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC3_get_SearchCompanionAvailable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC3_put_UseSearchCompanion_Proxy(byval This as ISearchAssistantOC3 ptr, byval bUseSC as VARIANT_BOOL) as HRESULT
declare sub ISearchAssistantOC3_put_UseSearchCompanion_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchAssistantOC3_get_UseSearchCompanion_Proxy(byval This as ISearchAssistantOC3 ptr, byval pbUseSC as VARIANT_BOOL ptr) as HRESULT
declare sub ISearchAssistantOC3_get_UseSearchCompanion_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define ___SearchAssistantEvents_DISPINTERFACE_DEFINED__
extern DIID__SearchAssistantEvents as const IID
type _SearchAssistantEvents as _SearchAssistantEvents_

type _SearchAssistantEventsVtbl
	QueryInterface as function(byval This as _SearchAssistantEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as _SearchAssistantEvents ptr) as ULONG
	Release as function(byval This as _SearchAssistantEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as _SearchAssistantEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as _SearchAssistantEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as _SearchAssistantEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as _SearchAssistantEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type _SearchAssistantEvents_
	lpVtbl as _SearchAssistantEventsVtbl ptr
end type

#define _SearchAssistantEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define _SearchAssistantEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define _SearchAssistantEvents_Release(This) (This)->lpVtbl->Release(This)
#define _SearchAssistantEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define _SearchAssistantEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define _SearchAssistantEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define _SearchAssistantEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
extern CLSID_SearchAssistantOC as const CLSID

end extern
