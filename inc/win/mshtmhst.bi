#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "ocidl.bi"
#include once "docobj.bi"

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
const CONTEXT_MENU_IMGART = 8
const CONTEXT_MENU_DEBUG = 9
const CONTEXT_MENU_VSCROLL = 10
const CONTEXT_MENU_HSCROLL = 11
const MENUEXT_SHOWDIALOG = &h1
#define DOCHOSTUIFLAG_BROWSER (DOCHOSTUIFLAG_DISABLE_HELP_MENU or DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE)
const HTMLDLG_NOUI = &h10
const HTMLDLG_MODAL = &h20
const HTMLDLG_MODELESS = &h40
const HTMLDLG_PRINT_TEMPLATE = &h80
const HTMLDLG_VERIFY = &h100
const HTMLDLG_LMZLUNLOCK = &h200
const HTMLDLG_ALLOWNEXTWINDOW = &h400
const PRINT_DONTBOTHERUSER = &h01
const PRINT_WAITFORCOMPLETION = &h02
extern CGID_MSHTML as const GUID
#define CMDSETID_Forms3 CGID_MSHTML
#define SZ_HTML_CLIENTSITE_OBJECTPARAM wstr("{d4db6850-5385-11d0-89e9-00a0c90a90ac}")
#define __IHTMLWindow2_FWD_DEFINED__
declare function ShowHTMLDialog(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as wstring ptr, byval pvarArgOut as VARIANT ptr) as HRESULT
declare function ShowHTMLDialogEx(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval dwDialogFlags as DWORD, byval pvarArgIn as VARIANT ptr, byval pchOptions as wstring ptr, byval pvarArgOut as VARIANT ptr) as HRESULT
type IHTMLWindow2 as IHTMLWindow2_

declare function ShowModelessHTMLDialog(byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pvarOptions as VARIANT ptr, byval ppWindow as IHTMLWindow2 ptr ptr) as HRESULT
declare function RunHTMLApplication(byval hinst as HINSTANCE, byval hPrevInst as HINSTANCE, byval szCmdLine as LPSTR, byval nCmdShow as long) as HRESULT
declare function CreateHTMLPropertyPage(byval pmk as IMoniker ptr, byval ppPP as IPropertyPage ptr ptr) as HRESULT
extern __MIDL_itf_mshtmhst_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_mshtmhst_0000_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IHostDialogHelper_INTERFACE_DEFINED__
extern IID_IHostDialogHelper as const IID
type IHostDialogHelper as IHostDialogHelper_

type IHostDialogHelperVtbl
	QueryInterface as function(byval This as IHostDialogHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHostDialogHelper ptr) as ULONG
	Release as function(byval This as IHostDialogHelper ptr) as ULONG
	ShowHTMLDialog as function(byval This as IHostDialogHelper ptr, byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as wstring ptr, byval pvarArgOut as VARIANT ptr, byval punkHost as IUnknown ptr) as HRESULT
end type

type IHostDialogHelper_
	lpVtbl as IHostDialogHelperVtbl ptr
end type

declare function IHostDialogHelper_ShowHTMLDialog_Proxy(byval This as IHostDialogHelper ptr, byval hwndParent as HWND, byval pMk as IMoniker ptr, byval pvarArgIn as VARIANT ptr, byval pchOptions as wstring ptr, byval pvarArgOut as VARIANT ptr, byval punkHost as IUnknown ptr) as HRESULT
declare sub IHostDialogHelper_ShowHTMLDialog_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_HostDialogHelper as const GUID

type tagDOCHOSTUITYPE as long
enum
	DOCHOSTUITYPE_BROWSE = 0
	DOCHOSTUITYPE_AUTHOR = 1
end enum

type DOCHOSTUITYPE as tagDOCHOSTUITYPE

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
end enum

type DOCHOSTUIFLAG as tagDOCHOSTUIFLAG
#define DOCHOSTUIATOM_ENABLE_HIRES _T("TridentEnableHiRes")
extern __MIDL_itf_mshtmhst_0277_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_mshtmhst_0277_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IDocHostUIHandler_INTERFACE_DEFINED__

type _DOCHOSTUIINFO
	cbSize as ULONG
	dwFlags as DWORD
	dwDoubleClick as DWORD
	pchHostCss as wstring ptr
	pchHostNS as wstring ptr
end type

type DOCHOSTUIINFO as _DOCHOSTUIINFO
extern IID_IDocHostUIHandler as const IID
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
	TranslateUrl as function(byval This as IDocHostUIHandler ptr, byval dwTranslate as DWORD, byval pchURLIn as wstring ptr, byval ppchURLOut as wstring ptr ptr) as HRESULT
	FilterDataObject as function(byval This as IDocHostUIHandler ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
end type

type IDocHostUIHandler_
	lpVtbl as IDocHostUIHandlerVtbl ptr
end type

declare function IDocHostUIHandler_ShowContextMenu_Proxy(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval ppt as POINT ptr, byval pcmdtReserved as IUnknown ptr, byval pdispReserved as IDispatch ptr) as HRESULT
declare sub IDocHostUIHandler_ShowContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetHostInfo_Proxy(byval This as IDocHostUIHandler ptr, byval pInfo as DOCHOSTUIINFO ptr) as HRESULT
declare sub IDocHostUIHandler_GetHostInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ShowUI_Proxy(byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pCommandTarget as IOleCommandTarget ptr, byval pFrame as IOleInPlaceFrame ptr, byval pDoc as IOleInPlaceUIWindow ptr) as HRESULT
declare sub IDocHostUIHandler_ShowUI_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_HideUI_Proxy(byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_HideUI_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_UpdateUI_Proxy(byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_UpdateUI_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_EnableModeless_Proxy(byval This as IDocHostUIHandler ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnDocWindowActivate_Proxy(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_OnDocWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnFrameWindowActivate_Proxy(byval This as IDocHostUIHandler ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_OnFrameWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ResizeBorder_Proxy(byval This as IDocHostUIHandler ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fRameWindow as WINBOOL) as HRESULT
declare sub IDocHostUIHandler_ResizeBorder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateAccelerator_Proxy(byval This as IDocHostUIHandler ptr, byval lpMsg as LPMSG, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD) as HRESULT
declare sub IDocHostUIHandler_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetOptionKeyPath_Proxy(byval This as IDocHostUIHandler ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
declare sub IDocHostUIHandler_GetOptionKeyPath_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetDropTarget_Proxy(byval This as IDocHostUIHandler ptr, byval pDropTarget as IDropTarget ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetDropTarget_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetExternal_Proxy(byval This as IDocHostUIHandler ptr, byval ppDispatch as IDispatch ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetExternal_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateUrl_Proxy(byval This as IDocHostUIHandler ptr, byval dwTranslate as DWORD, byval pchURLIn as wstring ptr, byval ppchURLOut as wstring ptr ptr) as HRESULT
declare sub IDocHostUIHandler_TranslateUrl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_FilterDataObject_Proxy(byval This as IDocHostUIHandler ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
declare sub IDocHostUIHandler_FilterDataObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IDocHostUIHandler2_INTERFACE_DEFINED__
extern IID_IDocHostUIHandler2 as const IID
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
	TranslateUrl as function(byval This as IDocHostUIHandler2 ptr, byval dwTranslate as DWORD, byval pchURLIn as wstring ptr, byval ppchURLOut as wstring ptr ptr) as HRESULT
	FilterDataObject as function(byval This as IDocHostUIHandler2 ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
	GetOverrideKeyPath as function(byval This as IDocHostUIHandler2 ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
end type

type IDocHostUIHandler2_
	lpVtbl as IDocHostUIHandler2Vtbl ptr
end type

declare function IDocHostUIHandler2_GetOverrideKeyPath_Proxy(byval This as IDocHostUIHandler2 ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
declare sub IDocHostUIHandler2_GetOverrideKeyPath_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CGID_DocHostCommandHandler as const GUID
extern __MIDL_itf_mshtmhst_0279_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_mshtmhst_0279_v0_0_s_ifspec as RPC_IF_HANDLE
#define __ICustomDoc_INTERFACE_DEFINED__
extern IID_ICustomDoc as const IID
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

declare function ICustomDoc_SetUIHandler_Proxy(byval This as ICustomDoc ptr, byval pUIHandler as IDocHostUIHandler ptr) as HRESULT
declare sub ICustomDoc_SetUIHandler_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IDocHostShowUI_INTERFACE_DEFINED__
extern IID_IDocHostShowUI as const IID
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

declare function IDocHostShowUI_ShowMessage_Proxy(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval lpstrText as LPOLESTR, byval lpstrCaption as LPOLESTR, byval dwType as DWORD, byval lpstrHelpFile as LPOLESTR, byval dwHelpContext as DWORD, byval plResult as LRESULT ptr) as HRESULT
declare sub IDocHostShowUI_ShowMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostShowUI_ShowHelp_Proxy(byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval pszHelpFile as LPOLESTR, byval uCommand as UINT, byval dwData as DWORD, byval ptMouse as POINT, byval pDispatchObjectHit as IDispatch ptr) as HRESULT
declare sub IDocHostShowUI_ShowHelp_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define IClassFactory3 IClassFactoryEx
#define IID_IClassFactory3 IID_IClassFactoryEx
extern __MIDL_itf_mshtmhst_0281_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_mshtmhst_0281_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IClassFactoryEx_INTERFACE_DEFINED__
extern IID_IClassFactoryEx as const IID
type IClassFactoryEx as IClassFactoryEx_

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

declare function IClassFactoryEx_CreateInstanceWithContext_Proxy(byval This as IClassFactoryEx ptr, byval punkContext as IUnknown ptr, byval punkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IClassFactoryEx_CreateInstanceWithContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IHTMLOMWindowServices_INTERFACE_DEFINED__
extern IID_IHTMLOMWindowServices as const IID
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

declare function IHTMLOMWindowServices_moveTo_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_moveTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_moveBy_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_moveBy_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_resizeTo_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_resizeTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IHTMLOMWindowServices_resizeBy_Proxy(byval This as IHTMLOMWindowServices ptr, byval x as LONG, byval y as LONG) as HRESULT
declare sub IHTMLOMWindowServices_resizeBy_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define SID_SHTMLOMWindowServices IID_IHTMLOMWindowServices
extern __MIDL_itf_mshtmhst_0283_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_mshtmhst_0283_v0_0_s_ifspec as RPC_IF_HANDLE

end extern
