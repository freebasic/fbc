''
''
'' mshtmhst -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mshtmhst_bi__
#define __win_mshtmhst_bi__

#include once "win/rpc.bi"
#include once "win/rpcndr.bi"

#ifndef COM_NO_WINDOWS_H
#include once "windows.bi"
#include once "win/ole2.bi"
#endif

#include once "win/ocidl.bi"
#include once "win/docobj.bi"
#include once "win/mshtml.bi"

#define CONTEXT_MENU_DEFAULT 0
#define CONTEXT_MENU_IMAGE 1
#define CONTEXT_MENU_CONTROL 2
#define CONTEXT_MENU_TABLE 3
#define CONTEXT_MENU_TEXTSELECT 4
#define CONTEXT_MENU_ANCHOR 5
#define CONTEXT_MENU_UNKNOWN 6
#define MENUEXT_SHOWDIALOG &h1

extern CGID_MSHTML alias "CGID_MSHTML" as GUID

type SHOWHTMLDIALOGFN as HRESULT

enum DOCHOSTUIDBLCLK
	DOCHOSTUIDBLCLK_DEFAULT = 0
	DOCHOSTUIDBLCLK_SHOWPROPERTIES = 1
	DOCHOSTUIDBLCLK_SHOWCODE = 2
end enum

enum DOCHOSTUIFLAG
	DOCHOSTUIFLAG_DIALOG = 1
	DOCHOSTUIFLAG_DISABLE_HELP_MENU = 2
	DOCHOSTUIFLAG_NO3DBORDER = 4
	DOCHOSTUIFLAG_SCROLL_NO = 8
	DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE = 16
	DOCHOSTUIFLAG_OPENNEWWIN = 32
	DOCHOSTUIFLAG_DISABLE_OFFSCREEN = 64
	DOCHOSTUIFLAG_FLAT_SCROLLBAR = 128
	DOCHOSTUIFLAG_DIV_BLOCKDEFAULT = 256
	DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY = 512
	DOCHOSTUIFLAG_DISABLE_COOKIE = 1024
end enum

type DOCHOSTUIINFO
	cbSize as ULONG
	dwFlags as DWORD
	dwDoubleClick as DWORD
end type

extern IID_IDocHostUIHandler alias "IID_IDocHostUIHandler" as IID

type IDocHostUIHandlerVtbl_ as IDocHostUIHandlerVtbl

type IDocHostUIHandler
	lpVtbl as IDocHostUIHandlerVtbl_ ptr
end type

type IDocHostUIHandlerVtbl
	QueryInterface as function(byval as IDocHostUIHandler ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDocHostUIHandler ptr) as ULONG
	Release as function(byval as IDocHostUIHandler ptr) as ULONG
	ShowContextMenu as function(byval as IDocHostUIHandler ptr, byval as DWORD, byval as POINT ptr, byval as IUnknown ptr, byval as IDispatch ptr) as HRESULT
	GetHostInfo as function(byval as IDocHostUIHandler ptr, byval as DOCHOSTUIINFO ptr) as HRESULT
	ShowUI as function(byval as IDocHostUIHandler ptr, byval as DWORD, byval as IOleInPlaceActiveObject ptr, byval as IOleCommandTarget ptr, byval as IOleInPlaceFrame ptr, byval as IOleInPlaceUIWindow ptr) as HRESULT
	HideUI as function(byval as IDocHostUIHandler ptr) as HRESULT
	UpdateUI as function(byval as IDocHostUIHandler ptr) as HRESULT
	EnableModeless as function(byval as IDocHostUIHandler ptr, byval as BOOL) as HRESULT
	OnDocWindowActivate as function(byval as IDocHostUIHandler ptr, byval as BOOL) as HRESULT
	OnFrameWindowActivate as function(byval as IDocHostUIHandler ptr, byval as BOOL) as HRESULT
	ResizeBorder as function(byval as IDocHostUIHandler ptr, byval as LPCRECT, byval as IOleInPlaceUIWindow ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorA as function(byval as IDocHostUIHandler ptr, byval as LPMSG, byval as GUID ptr, byval as DWORD) as HRESULT
	GetOptionKeyPath as function(byval as IDocHostUIHandler ptr, byval as LPOLESTR ptr, byval as DWORD) as HRESULT
	GetDropTarget as function(byval as IDocHostUIHandler ptr, byval as IDropTarget ptr, byval as IDropTarget ptr ptr) as HRESULT
	GetExternal as function(byval as IDocHostUIHandler ptr, byval as IDispatch ptr ptr) as HRESULT
	TranslateUrl as function(byval as IDocHostUIHandler ptr, byval as DWORD, byval as OLECHAR ptr, byval as OLECHAR ptr ptr) as HRESULT
	FilterDataObject as function(byval as IDocHostUIHandler ptr, byval as IDataObject ptr, byval as IDataObject ptr ptr) as HRESULT
end type


extern IID_ICustomDoc alias "IID_ICustomDoc" as IID

type ICustomDocVtbl_ as ICustomDocVtbl

type ICustomDoc
	lpVtbl as ICustomDocVtbl_ ptr
end type

type ICustomDocVtbl
	QueryInterface as function(byval as ICustomDoc ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICustomDoc ptr) as ULONG
	Release as function(byval as ICustomDoc ptr) as ULONG
	SetUIHandler as function(byval as ICustomDoc ptr, byval as IDocHostUIHandler ptr) as HRESULT
end type

extern IID_IDocHostShowUI alias "IID_IDocHostShowUI" as IID

type IDocHostShowUIVtbl_ as IDocHostShowUIVtbl

type IDocHostShowUI
	lpVtbl as IDocHostShowUIVtbl_ ptr
end type

type IDocHostShowUIVtbl
	QueryInterface as function(byval as IDocHostShowUI ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDocHostShowUI ptr) as ULONG
	Release as function(byval as IDocHostShowUI ptr) as ULONG
	ShowMessage as function(byval as IDocHostShowUI ptr, byval as HWND, byval as LPOLESTR, byval as LPOLESTR, byval as DWORD, byval as LPOLESTR, byval as DWORD, byval as LRESULT ptr) as HRESULT
	ShowHelp as function(byval as IDocHostShowUI ptr, byval as HWND, byval as LPOLESTR, byval as UINT, byval as DWORD, byval as POINT, byval as IDispatch ptr) as HRESULT
end type

extern IID_ICSSFilterSite alias "IID_ICSSFilterSite" as IID

type ICSSFilterSiteVtbl_ as ICSSFilterSiteVtbl

type ICSSFilterSite
	lpVtbl as ICSSFilterSiteVtbl_ ptr
end type

type ICSSFilterSiteVtbl
	QueryInterface as function(byval as ICSSFilterSite ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICSSFilterSite ptr) as ULONG
	Release as function(byval as ICSSFilterSite ptr) as ULONG
	GetElement as function(byval as ICSSFilterSite ptr, byval as IHTMLElement ptr ptr) as HRESULT
	FireOnFilterChangeEvent as function(byval as ICSSFilterSite ptr) as HRESULT
end type

extern IID_ICSSFilter alias "IID_ICSSFilter" as IID

type ICSSFilterVtbl_ as ICSSFilterVtbl

type ICSSFilter
	lpVtbl as ICSSFilterVtbl_ ptr
end type

type ICSSFilterVtbl
	QueryInterface as function(byval as ICSSFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICSSFilter ptr) as ULONG
	Release as function(byval as ICSSFilter ptr) as ULONG
	SetSite as function(byval as ICSSFilter ptr, byval as ICSSFilterSite ptr) as HRESULT
	OnAmbientPropertyChange as function(byval as ICSSFilter ptr, byval as LONG) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDocHostUIHandler_ShowContextMenu_Proxy alias "IDocHostUIHandler_ShowContextMenu_Proxy" (byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval ppt as POINT ptr, byval pcmdtReserved as IUnknown ptr, byval pdispReserved as IDispatch ptr) as HRESULT
declare sub IDocHostUIHandler_ShowContextMenu_Stub alias "IDocHostUIHandler_ShowContextMenu_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetHostInfo_Proxy alias "IDocHostUIHandler_GetHostInfo_Proxy" (byval This as IDocHostUIHandler ptr, byval pInfo as DOCHOSTUIINFO ptr) as HRESULT
declare sub IDocHostUIHandler_GetHostInfo_Stub alias "IDocHostUIHandler_GetHostInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ShowUI_Proxy alias "IDocHostUIHandler_ShowUI_Proxy" (byval This as IDocHostUIHandler ptr, byval dwID as DWORD, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pCommandTarget as IOleCommandTarget ptr, byval pFrame as IOleInPlaceFrame ptr, byval pDoc as IOleInPlaceUIWindow ptr) as HRESULT
declare sub IDocHostUIHandler_ShowUI_Stub alias "IDocHostUIHandler_ShowUI_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_HideUI_Proxy alias "IDocHostUIHandler_HideUI_Proxy" (byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_HideUI_Stub alias "IDocHostUIHandler_HideUI_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_UpdateUI_Proxy alias "IDocHostUIHandler_UpdateUI_Proxy" (byval This as IDocHostUIHandler ptr) as HRESULT
declare sub IDocHostUIHandler_UpdateUI_Stub alias "IDocHostUIHandler_UpdateUI_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_EnableModeless_Proxy alias "IDocHostUIHandler_EnableModeless_Proxy" (byval This as IDocHostUIHandler ptr, byval fEnable as BOOL) as HRESULT
declare sub IDocHostUIHandler_EnableModeless_Stub alias "IDocHostUIHandler_EnableModeless_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnDocWindowActivate_Proxy alias "IDocHostUIHandler_OnDocWindowActivate_Proxy" (byval This as IDocHostUIHandler ptr, byval fActivate as BOOL) as HRESULT
declare sub IDocHostUIHandler_OnDocWindowActivate_Stub alias "IDocHostUIHandler_OnDocWindowActivate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_OnFrameWindowActivate_Proxy alias "IDocHostUIHandler_OnFrameWindowActivate_Proxy" (byval This as IDocHostUIHandler ptr, byval fActivate as BOOL) as HRESULT
declare sub IDocHostUIHandler_OnFrameWindowActivate_Stub alias "IDocHostUIHandler_OnFrameWindowActivate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_ResizeBorder_Proxy alias "IDocHostUIHandler_ResizeBorder_Proxy" (byval This as IDocHostUIHandler ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fRameWindow as BOOL) as HRESULT
declare sub IDocHostUIHandler_ResizeBorder_Stub alias "IDocHostUIHandler_ResizeBorder_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateAccelerator_Proxy alias "IDocHostUIHandler_TranslateAccelerator_Proxy" (byval This as IDocHostUIHandler ptr, byval lpMsg as LPMSG, byval pguidCmdGroup as GUID ptr, byval nCmdID as DWORD) as HRESULT
declare sub IDocHostUIHandler_TranslateAccelerator_Stub alias "IDocHostUIHandler_TranslateAccelerator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetOptionKeyPath_Proxy alias "IDocHostUIHandler_GetOptionKeyPath_Proxy" (byval This as IDocHostUIHandler ptr, byval pchKey as LPOLESTR ptr, byval dw as DWORD) as HRESULT
declare sub IDocHostUIHandler_GetOptionKeyPath_Stub alias "IDocHostUIHandler_GetOptionKeyPath_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetDropTarget_Proxy alias "IDocHostUIHandler_GetDropTarget_Proxy" (byval This as IDocHostUIHandler ptr, byval pDropTarget as IDropTarget ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetDropTarget_Stub alias "IDocHostUIHandler_GetDropTarget_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_GetExternal_Proxy alias "IDocHostUIHandler_GetExternal_Proxy" (byval This as IDocHostUIHandler ptr, byval ppDispatch as IDispatch ptr ptr) as HRESULT
declare sub IDocHostUIHandler_GetExternal_Stub alias "IDocHostUIHandler_GetExternal_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_TranslateUrl_Proxy alias "IDocHostUIHandler_TranslateUrl_Proxy" (byval This as IDocHostUIHandler ptr, byval dwTranslate as DWORD, byval pchURLIn as OLECHAR ptr, byval ppchURLOut as OLECHAR ptr ptr) as HRESULT
declare sub IDocHostUIHandler_TranslateUrl_Stub alias "IDocHostUIHandler_TranslateUrl_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostUIHandler_FilterDataObject_Proxy alias "IDocHostUIHandler_FilterDataObject_Proxy" (byval This as IDocHostUIHandler ptr, byval pDO as IDataObject ptr, byval ppDORet as IDataObject ptr ptr) as HRESULT
declare sub IDocHostUIHandler_FilterDataObject_Stub alias "IDocHostUIHandler_FilterDataObject_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostShowUI_ShowMessage_Proxy alias "IDocHostShowUI_ShowMessage_Proxy" (byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval lpstrText as LPOLESTR, byval lpstrCaption as LPOLESTR, byval dwType as DWORD, byval lpstrHelpFile as LPOLESTR, byval dwHelpContext as DWORD, byval plResult as LRESULT ptr) as HRESULT
declare sub IDocHostShowUI_ShowMessage_Stub alias "IDocHostShowUI_ShowMessage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDocHostShowUI_ShowHelp_Proxy alias "IDocHostShowUI_ShowHelp_Proxy" (byval This as IDocHostShowUI ptr, byval hwnd as HWND, byval pszHelpFile as LPOLESTR, byval uCommand as UINT, byval dwData as DWORD, byval ptMouse as POINT, byval pDispatchObjectHit as IDispatch ptr) as HRESULT
declare sub IDocHostShowUI_ShowHelp_Stub alias "IDocHostShowUI_ShowHelp_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICSSFilterSite_GetElement_Proxy alias "ICSSFilterSite_GetElement_Proxy" (byval This as ICSSFilterSite ptr, byval ppElem as IHTMLElement ptr ptr) as HRESULT
declare sub ICSSFilterSite_GetElement_Stub alias "ICSSFilterSite_GetElement_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICSSFilterSite_FireOnFilterChangeEvent_Proxy alias "ICSSFilterSite_FireOnFilterChangeEvent_Proxy" (byval This as ICSSFilterSite ptr) as HRESULT
declare sub ICSSFilterSite_FireOnFilterChangeEvent_Stub alias "ICSSFilterSite_FireOnFilterChangeEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICSSFilter_SetSite_Proxy alias "ICSSFilter_SetSite_Proxy" (byval This as ICSSFilter ptr, byval pSink as ICSSFilterSite ptr) as HRESULT
declare sub ICSSFilter_SetSite_Stub alias "ICSSFilter_SetSite_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICSSFilter_OnAmbientPropertyChange_Proxy alias "ICSSFilter_OnAmbientPropertyChange_Proxy" (byval This as ICSSFilter ptr, byval dispid as LONG) as HRESULT
declare sub ICSSFilter_OnAmbientPropertyChange_Stub alias "ICSSFilter_OnAmbientPropertyChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICustomDoc_SetUIHandler_Proxy alias "ICustomDoc_SetUIHandler_Proxy" (byval This as ICustomDoc ptr, byval pUIHandler as IDocHostUIHandler ptr) as HRESULT
declare sub ICustomDoc_SetUIHandler_Stub alias "ICustomDoc_SetUIHandler_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#endif
