''
''
'' exdisp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __exdisp_bi__
#define __exdisp_bi__

#inclib "uuid"

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
	QueryInterface as function stdcall(byval as IWebBrowser ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function stdcall(byval as IWebBrowser ptr) as ULONG
	Release as function stdcall(byval as IWebBrowser ptr) as ULONG
	GetTypeInfoCount as function stdcall(byval as IWebBrowser ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function stdcall(byval as IWebBrowser ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function stdcall(byval as IWebBrowser ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function stdcall(byval as IWebBrowser ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function stdcall(byval as IWebBrowser ptr) as HRESULT
	GoForward as function stdcall(byval as IWebBrowser ptr) as HRESULT
	GoHome as function stdcall(byval as IWebBrowser ptr) as HRESULT
	GoSearch as function stdcall(byval as IWebBrowser ptr) as HRESULT
	Navigate as function stdcall(byval as IWebBrowser ptr, byval as BSTR, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	Refresh as function stdcall(byval as IWebBrowser ptr) as HRESULT
	Refresh2 as function stdcall(byval as IWebBrowser ptr, byval as VARIANT ptr) as HRESULT
	Stop as function stdcall(byval as IWebBrowser ptr) as HRESULT
	get_Application as function stdcall(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function stdcall(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function stdcall(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function stdcall(byval as IWebBrowser ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function stdcall(byval as IWebBrowser ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function stdcall(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_Left as function stdcall(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Left as function stdcall(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Top as function stdcall(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Top as function stdcall(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Width as function stdcall(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Width as function stdcall(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_Height as function stdcall(byval as IWebBrowser ptr, byval as integer ptr) as HRESULT
	put_Height as function stdcall(byval as IWebBrowser ptr, byval as integer) as HRESULT
	get_LocationName as function stdcall(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function stdcall(byval as IWebBrowser ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function stdcall(byval as IWebBrowser ptr, byval as VARIANT_BOOL ptr) as HRESULT
end type
extern IID_IWebBrowserApp alias "IID_IWebBrowserApp" as IID

type IWebBrowserAppVtbl_ as IWebBrowserAppVtbl

type IWebBrowserApp
	lpVtbl as IWebBrowserAppVtbl_ ptr
end type

type IWebBrowserAppVtbl
	QueryInterface as function stdcall(byval as IWebBrowserApp ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function stdcall(byval as IWebBrowserApp ptr) as ULONG
	Release as function stdcall(byval as IWebBrowserApp ptr) as ULONG
	GetTypeInfoCount as function stdcall(byval as IWebBrowserApp ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function stdcall(byval as IWebBrowserApp ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function stdcall(byval as IWebBrowserApp ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function stdcall(byval as IWebBrowserApp ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	GoForward as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	GoHome as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	GoSearch as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	Navigate as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	Refresh as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	Refresh2 as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT ptr) as HRESULT
	Stop as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	get_Application as function stdcall(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function stdcall(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function stdcall(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function stdcall(byval as IWebBrowserApp ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Left as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Left as function stdcall(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Top as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Top as function stdcall(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Width as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Width as function stdcall(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_Height as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_Height as function stdcall(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_LocationName as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	Quit as function stdcall(byval as IWebBrowserApp ptr) as HRESULT
	ClientToWindow as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	PutProperty as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT) as HRESULT
	GetProperty as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR, byval as VARIANT ptr) as HRESULT
	get_Name as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_HWND as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	get_FullName as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Path as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	get_Visible as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusBar as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusText as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR ptr) as HRESULT
	put_StatusText as function stdcall(byval as IWebBrowserApp ptr, byval as BSTR) as HRESULT
	get_ToolBar as function stdcall(byval as IWebBrowserApp ptr, byval as integer ptr) as HRESULT
	put_ToolBar as function stdcall(byval as IWebBrowserApp ptr, byval as integer) as HRESULT
	get_MenuBar as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
	get_FullScreen as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function stdcall(byval as IWebBrowserApp ptr, byval as VARIANT_BOOL) as HRESULT
end type
extern IID_IWebBrowser2 alias "IID_IWebBrowser2" as IID

type IWebBrowser2Vtbl_ as IWebBrowser2Vtbl

type IWebBrowser2
	lpVtbl as IWebBrowser2Vtbl_ ptr
end type

type IWebBrowser2Vtbl
	QueryInterface as function stdcall(byval as IWebBrowser2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function stdcall(byval as IWebBrowser2 ptr) as ULONG
	Release as function stdcall(byval as IWebBrowser2 ptr) as ULONG
	GetTypeInfoCount as function stdcall(byval as IWebBrowser2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function stdcall(byval as IWebBrowser2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function stdcall(byval as IWebBrowser2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function stdcall(byval as IWebBrowser2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GoBack as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	GoForward as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	GoHome as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	GoSearch as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	Navigate as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	Refresh as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	Refresh2 as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT ptr) as HRESULT
	Stop as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	get_Application as function stdcall(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Parent as function stdcall(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Container as function stdcall(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_Document as function stdcall(byval as IWebBrowser2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_TopLevelContainer as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	get_Type as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Left as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Left as function stdcall(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Top as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Top as function stdcall(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Width as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Width as function stdcall(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_Height as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_Height as function stdcall(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_LocationName as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_LocationURL as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Busy as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	Quit as function stdcall(byval as IWebBrowser2 ptr) as HRESULT
	ClientToWindow as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	PutProperty as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT) as HRESULT
	GetProperty as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR, byval as VARIANT ptr) as HRESULT
	get_Name as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_HWND as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	get_FullName as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Path as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	get_Visible as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Visible as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_StatusBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_StatusText as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR ptr) as HRESULT
	put_StatusText as function stdcall(byval as IWebBrowser2 ptr, byval as BSTR) as HRESULT
	get_ToolBar as function stdcall(byval as IWebBrowser2 ptr, byval as integer ptr) as HRESULT
	put_ToolBar as function stdcall(byval as IWebBrowser2 ptr, byval as integer) as HRESULT
	get_MenuBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_MenuBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_FullScreen as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_FullScreen as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	Navigate2 as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	QueryStatusWB as function stdcall(byval as IWebBrowser2 ptr, byval as OLECMDID, byval as OLECMDF ptr) as HRESULT
	ExecWB as function stdcall(byval as IWebBrowser2 ptr, byval as OLECMDID, byval as OLECMDEXECOPT, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	ShowBrowserBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	get_ReadyState as function stdcall(byval as IWebBrowser2 ptr, byval as READYSTATE ptr) as HRESULT
	get_Offline as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Offline as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_Silent as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Silent as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_RegistaerAsBrowser as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsBrowser as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_RegistaerAsDropTarget as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_RegisterAsDropTarget as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_TheaterMode as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_TheaterMode as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_AddressBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_AddressBar as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_Resizable as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_Resizable as function stdcall(byval as IWebBrowser2 ptr, byval as VARIANT_BOOL) as HRESULT
end type
extern DIID_DWebBrowserEvents2 alias "DIID_DWebBrowserEvents2" as IID

type DWebBrowserEvents2Vtbl_ as DWebBrowserEvents2Vtbl

type DWebBrowserEvents2
	lpVtbl as DWebBrowserEvents2Vtbl_ ptr
end type

type DWebBrowserEvents2Vtbl
	QueryInterface as function stdcall(byval as DWebBrowserEvents2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function stdcall(byval as DWebBrowserEvents2 ptr) as ULONG
	Release as function stdcall(byval as DWebBrowserEvents2 ptr) as ULONG
	GetTypeInfoCount as function stdcall(byval as DWebBrowserEvents2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function stdcall(byval as DWebBrowserEvents2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function stdcall(byval as DWebBrowserEvents2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function stdcall(byval as DWebBrowserEvents2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	StatusTextChange as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	ProgressChange as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer, byval as integer)
	CommandStateChange as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer, byval as VARIANT_BOOL)
	DownloadBegin as sub stdcall(byval as DWebBrowserEvents2 ptr)
	DownloadComplete as sub stdcall(byval as DWebBrowserEvents2 ptr)
	TitleChange as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	PropertyChange as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as BSTR)
	BeforeNavigate2 as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT_BOOL ptr)
	NewWindow2 as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr ptr, byval as VARIANT_BOOL ptr)
	NavigateComplete as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT ptr)
	DocumentComplete as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as IDispatch ptr, byval as VARIANT ptr)
	OnQuit as sub stdcall(byval as DWebBrowserEvents2 ptr)
	OnVisible as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnToolBar as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnMenuBar as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnStatusBar as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnFullScreen as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	OnTheaterMode as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	WindowSetResizable as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL)
	WindowSetLeft as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetTop as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetWidth as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowSetHeight as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer)
	WindowClosing as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL, byval as VARIANT_BOOL ptr)
	ClientToHostWindow as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer ptr, byval as integer ptr)
	SetSecureLockIcon as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as integer)
	FileDownload as sub stdcall(byval as DWebBrowserEvents2 ptr, byval as VARIANT_BOOL ptr)
end type

#endif
