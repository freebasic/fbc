''
''
'' exdisp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_exdisp_bi__
#define __win_exdisp_bi__

#inclib "uuid"

#include once "win/objbase.bi"
#include once "win/oaidl.bi"
#include once "win/ocidl.bi"
#include once "win/docobj.bi"

extern CLSID_WebBrowser alias "CLSID_WebBrowser" as CLSID
extern DIID_DWebBrowserEvents alias "DIID_DWebBrowserEvents" as IID

enum BrowserNavConstants
	navOpenInNewWindow = &h1
	navNoHistory = &h2
	navNoReadFromCache = &h4
	navNoWriteTocache = &h8
	navAllowAutosearch = &h10
	navBrowserBar = &h20
	navHyperLink = &h40
end enum

extern IID_IWebBrowser alias "IID_IWebBrowser" as IID

type IWebBrowserVtbl_ as IWebBrowserVtbl

type IWebBrowser
	lpVtbl as IWebBrowserVtbl_ ptr
end type

type IWebBrowserVtbl
	QueryInterface as function(byval as IWebBrowser ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IWebBrowser ptr) as ULONG
	Release as function(byval as IWebBrowser ptr) as ULONG
	GetTypeInfoCount as function(byval as IWebBrowser ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IWebBrowser ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IWebBrowser ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IWebBrowser ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function(byval as IWebBrowser ptr) as HRESULT
	GoForward as function(byval as IWebBrowser ptr) as HRESULT
	GoHome as function(byval as IWebBrowser ptr) as HRESULT
	GoSearch as function(byval as IWebBrowser ptr) as HRESULT
	Navigate as function(byval as IWebBrowser ptr, byval as BSTR, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	Refresh as function(byval as IWebBrowser ptr) as HRESULT
	Refresh2 as function(byval as IWebBrowser ptr, byval as VARIANT_ ptr) as HRESULT
	Stop as function(byval as IWebBrowser ptr) as HRESULT
	get_Application as function(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval as IWebBrowser ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_Left as function(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Left as function(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Top as function(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Top as function(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Width as function(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Width as function(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Height as function(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Height as function(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_LocationName as function(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function(byval as IWebBrowser ptr, byval as VARIANT_BOOL ptr) as HRESULT
end type
extern IID_IWebBrowserApp alias "IID_IWebBrowserApp" as IID

type IWebBrowserAppVtbl_ as IWebBrowserAppVtbl

type IWebBrowserApp
	lpVtbl as IWebBrowserAppVtbl_ ptr
end type

type IWebBrowserAppVtbl
	QueryInterface as function(byval as IWebBrowserApp ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IWebBrowserApp ptr) as ULONG
	Release as function(byval as IWebBrowserApp ptr) as ULONG
	GetTypeInfoCount as function(byval as IWebBrowserApp ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IWebBrowserApp ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IWebBrowserApp ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IWebBrowserApp ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function(byval as IWebBrowserApp ptr) as HRESULT
	GoForward as function(byval as IWebBrowserApp ptr) as HRESULT
	GoHome as function(byval as IWebBrowserApp ptr) as HRESULT
	GoSearch as function(byval as IWebBrowserApp ptr) as HRESULT
	Navigate as function(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	Refresh as function(byval as IWebBrowserApp ptr) as HRESULT
	Refresh2 as function(byval as IWebBrowserApp ptr, byval as VARIANT_ ptr) as HRESULT
	Stop as function(byval as IWebBrowserApp ptr) as HRESULT
	get_Application as function(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Left as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Left as function(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Top as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Top as function(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Width as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Width as function(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Height as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Height as function(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_LocationName as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	Quit as function(byval as IWebBrowserApp ptr) as HRESULT
	ClientToWindow as function(byval as IWebBrowserApp ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	PutProperty as function(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT_) as HRESULT
	GetProperty as function(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	get_Name as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_HWND as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	get_FullName as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Path as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Visible as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusBar as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusText as function(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	put_StatusText as function(byval as IWebBrowserApp ptr, byval as BSTR) as HRESULT
	get_ToolBar as function(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_ToolBar as function(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_MenuBar as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_FullScreen as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
end type
extern IID_IWebBrowser2 alias "IID_IWebBrowser2" as IID

type IWebBrowser2Vtbl_ as IWebBrowser2Vtbl

type IWebBrowser2
	lpVtbl as IWebBrowser2Vtbl_ ptr
end type

type IWebBrowser2Vtbl
	QueryInterface as function(byval as IWebBrowser2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IWebBrowser2 ptr) as ULONG
	Release as function(byval as IWebBrowser2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IWebBrowser2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IWebBrowser2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IWebBrowser2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IWebBrowser2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function(byval as IWebBrowser2 ptr) as HRESULT
	GoForward as function(byval as IWebBrowser2 ptr) as HRESULT
	GoHome as function(byval as IWebBrowser2 ptr) as HRESULT
	GoSearch as function(byval as IWebBrowser2 ptr) as HRESULT
	Navigate as function(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	Refresh as function(byval as IWebBrowser2 ptr) as HRESULT
	Refresh2 as function(byval as IWebBrowser2 ptr, byval as VARIANT_ ptr) as HRESULT
	Stop as function(byval as IWebBrowser2 ptr) as HRESULT
	get_Application as function(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Left as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Left as function(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Top as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Top as function(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Width as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Width as function(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Height as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Height as function(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_LocationName as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	Quit as function(byval as IWebBrowser2 ptr) as HRESULT
	ClientToWindow as function(byval as IWebBrowser2 ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	PutProperty as function(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT_) as HRESULT
	GetProperty as function(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	get_Name as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_HWND as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	get_FullName as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Path as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Visible as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusText as function(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	put_StatusText as function(byval as IWebBrowser2 ptr, byval as BSTR) as HRESULT
	get_ToolBar as function(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_ToolBar as function(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_MenuBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_FullScreen as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	Navigate2 as function(byval as IWebBrowser2 ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	QueryStatusWB as function(byval as IWebBrowser2 ptr, byval as OLECMDID, byval as OLECMDF ptr) as HRESULT
	ExecWB as function(byval as IWebBrowser2 ptr, byval as OLECMDID, byval as OLECMDEXECOPT, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	ShowBrowserBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	get_ReadyState as function(byval as IWebBrowser2 ptr, byval as READYSTATE ptr) as HRESULT
	get_Offline as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Offline as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_Silent as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Silent as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_RegistaerAsBrowser as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsBrowser as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_RegistaerAsDropTarget as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsDropTarget as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_TheaterMode as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_TheaterMode as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_AddressBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_AddressBar as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_Resizable as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Resizable as function(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
end type
extern DIID_DWebBrowserEvents2 alias "DIID_DWebBrowserEvents2" as IID

type DWebBrowserEvents2Vtbl_ as DWebBrowserEvents2Vtbl

type DWebBrowserEvents2
	lpVtbl as DWebBrowserEvents2Vtbl_ ptr
end type

type DWebBrowserEvents2Vtbl
	QueryInterface as function(byval as DWebBrowserEvents2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as DWebBrowserEvents2 ptr) as ULONG
	Release as function(byval as DWebBrowserEvents2 ptr) as ULONG
	GetTypeInfoCount as function(byval as DWebBrowserEvents2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as DWebBrowserEvents2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as DWebBrowserEvents2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as DWebBrowserEvents2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	StatusTextChange as sub(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	ProgressChange as sub(byval as DWebBrowserEvents2 ptr, byval as integer, byval as integer)
	CommandStateChange as sub(byval as DWebBrowserEvents2 ptr, byval as integer, byval as VARIANT_BOOL)
	DownloadBegin as sub(byval as DWebBrowserEvents2 ptr)
	DownloadComplete as sub(byval as DWebBrowserEvents2 ptr)
	TitleChange as sub(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	PropertyChange as sub(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	BeforeNavigate2 as sub(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_BOOL ptr)
	NewWindow2 as sub(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr ptr, byval as VARIANT_BOOL ptr)
	NavigateComplete as sub(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT_ ptr)
	DocumentComplete as sub(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT_ ptr)
	OnQuit as sub(byval as DWebBrowserEvents2 ptr)
	OnVisible as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnToolBar as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnMenuBar as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnStatusBar as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnFullScreen as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnTheaterMode as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	WindowSetResizable as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	WindowSetLeft as sub(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetTop as sub(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetWidth as sub(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetHeight as sub(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowClosing as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL, byval as VARIANT_BOOL ptr)
	ClientToHostWindow as sub(byval as DWebBrowserEvents2 ptr, byval as integer ptr, byval as integer ptr)
	SetSecureLockIcon as sub(byval as DWebBrowserEvents2 ptr, byval as integer)
	FileDownload as sub(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL ptr)
end type

#endif
