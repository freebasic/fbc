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

#define IDocHostUIHandler_QueryInterface(this_,riid,ppvObject) (this_)->lpVtbl -> QueryInterface(this_,riid,ppvObject)
#define IDocHostUIHandler_AddRef(this_) (this_)->lpVtbl -> AddRef(this_)
#define IDocHostUIHandler_Release(this_) (this_)->lpVtbl -> Release(this_)
#define IDocHostUIHandler_ShowContextMenu(this_,dwID,ppt,pcmdtReserved,pdispReserved) (this_)->lpVtbl -> ShowContextMenu(this_,dwID,ppt,pcmdtReserved,pdispReserved)
#define IDocHostUIHandler_GetHostInfo(this_,pInfo) (this_)->lpVtbl -> GetHostInfo(this_,pInfo)
#define IDocHostUIHandler_ShowUI(this_,dwID,pActiveObject,pCommandTarget,pFrame,pDoc) (this_)->lpVtbl -> ShowUI(this_,dwID,pActiveObject,pCommandTarget,pFrame,pDoc)
#define IDocHostUIHandler_HideUI(this_) (this_)->lpVtbl -> HideUI(this_)
#define IDocHostUIHandler_UpdateUI(this_) (this_)->lpVtbl -> UpdateUI(this_)
#define IDocHostUIHandler_EnableModeless(this_,fEnable) (this_)->lpVtbl -> EnableModeless(this_,fEnable)
#define IDocHostUIHandler_OnDocWindowActivate(this_,fActivate) (this_)->lpVtbl -> OnDocWindowActivate(this_,fActivate)
#define IDocHostUIHandler_OnFrameWindowActivate(this_,fActivate) (this_)->lpVtbl -> OnFrameWindowActivate(this_,fActivate)
#define IDocHostUIHandler_ResizeBorder(this_,prcBorder,pUIWindow,fRameWindow) (this_)->lpVtbl -> ResizeBorder(this_,prcBorder,pUIWindow,fRameWindow)
#define IDocHostUIHandler_TranslateAccelerator(this_,lpMsg,pguidCmdGroup,nCmdID) (this_)->lpVtbl -> TranslateAccelerator(this_,lpMsg,pguidCmdGroup,nCmdID)
#define IDocHostUIHandler_GetOptionKeyPath(this_,pchKey,dw) (this_)->lpVtbl -> GetOptionKeyPath(this_,pchKey,dw)
#define IDocHostUIHandler_GetDropTarget(this_,pDropTarget,ppDropTarget) (this_)->lpVtbl -> GetDropTarget(this_,pDropTarget,ppDropTarget)
#define IDocHostUIHandler_GetExternal(this_,ppDispatch) (this_)->lpVtbl -> GetExternal(this_,ppDispatch)
#define IDocHostUIHandler_TranslateUrl(this_,dwTranslate,pchURLIn,ppchURLOut) (this_)->lpVtbl -> TranslateUrl(this_,dwTranslate,pchURLIn,ppchURLOut)
#define IDocHostUIHandler_FilterDataObject(this_,pDO,ppDORet) (this_)->lpVtbl -> FilterDataObject(this_,pDO,ppDORet)

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

#define ICustomDoc_QueryInterface(this_,riid,ppvObject) (this_)->lpVtbl -> QueryInterface(this_,riid,ppvObject)
#define ICustomDoc_AddRef(this_) (this_)->lpVtbl -> AddRef(this_)
#define ICustomDoc_Release(this_) (this_)->lpVtbl -> Release(this_)
#define ICustomDoc_SetUIHandler(this_,pUIHandler) (this_)->lpVtbl -> SetUIHandler(this_,pUIHandler)

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

#define IDocHostShowUI_QueryInterface(this_,riid,ppvObject) (this_)->lpVtbl -> QueryInterface(this_,riid,ppvObject)
#define IDocHostShowUI_AddRef(this_) (this_)->lpVtbl -> AddRef(this_)
#define IDocHostShowUI_Release(this_) (this_)->lpVtbl -> Release(this_)
#define IDocHostShowUI_ShowMessage(this_,hwnd,lpstrText,lpstrCaption,dwType,lpstrHelpFile,dwHelpContext,plResult) (this_)->lpVtbl -> ShowMessage(this_,hwnd,lpstrText,lpstrCaption,dwType,lpstrHelpFile,dwHelpContext,plResult)
#define IDocHostShowUI_ShowHelp(this_,hwnd,pszHelpFile,uCommand,dwData,ptMouse,pDispatchObjectHit) (this_)->lpVtbl -> ShowHelp(this_,hwnd,pszHelpFile,uCommand,dwData,ptMouse,pDispatchObjectHit)

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

#define ICSSFilterSite_QueryInterface(this_,riid,ppvObject) (this_)->lpVtbl -> QueryInterface(this_,riid,ppvObject)
#define ICSSFilterSite_AddRef(this_) (this_)->lpVtbl -> AddRef(this_)
#define ICSSFilterSite_Release(this_) (this_)->lpVtbl -> Release(this_)
#define ICSSFilterSite_GetElement(this_,ppElem) (this_)->lpVtbl -> GetElement(this_,ppElem)
#define ICSSFilterSite_FireOnFilterChangeEvent(this_) (this_)->lpVtbl -> FireOnFilterChangeEvent(this_)

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

#define ICSSFilter_QueryInterface(this_,riid,ppvObject) (this_)->lpVtbl -> QueryInterface(this_,riid,ppvObject)
#define ICSSFilter_AddRef(this_) (this_)->lpVtbl -> AddRef(this_)
#define ICSSFilter_Release(this_) (this_)->lpVtbl -> Release(this_)
#define ICSSFilter_SetSite(this_,pSink) (this_)->lpVtbl -> SetSite(this_,pSink)
#define ICSSFilter_OnAmbientPropertyChange(this_,dispid) (this_)->lpVtbl -> OnAmbientPropertyChange(this_,dispid)

#endif
