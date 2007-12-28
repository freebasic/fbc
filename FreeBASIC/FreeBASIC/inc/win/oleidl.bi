''
''
'' oleidl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_oleidl_bi__
#define __win_oleidl_bi__

#include once "win/objfwd.bi"

#inclib "uuid"

#define MK_ALT 32

type LPPARSEDISPLAYNAME as IParseDisplayName ptr
type LPOLECONTAINER as IOleContainer ptr
type LPOLECLIENTSITE as IOleClientSite ptr
type LPOLEOBJECT as IOleObject ptr
type LPDROPTARGET as IDropTarget ptr
type LPDROPSOURCE as IDropSource ptr
type LPENUMOLEUNDOUNITS as IEnumOleUndoUnits ptr
type LPENUMOLEVERB as IEnumOLEVERB ptr
type LPOLEWINDOW as IOleWindow ptr
type LPOLEINPLACEUIWINDOW as IOleInPlaceUIWindow ptr
type LPOLEINPLACEACTIVEOBJECT as IOleInPlaceActiveObject ptr
type LPOLEINPLACEFRAME as IOleInPlaceFrame ptr
type LPOLEADVISEHOLDER as IOleAdviseHolder ptr
type LPVIEWOBJECT as IViewObject ptr
type LPVIEWOBJECT2 as IViewObject2 ptr
type LPOLECACHE as IOleCache ptr
type LPOLECACHE2 as IOleCache2 ptr
type LPOLECACHECONTROL as IOleCacheControl ptr

enum BINDSPEED
	BINDSPEED_INDEFINITE = 1
	BINDSPEED_MODERATE
	BINDSPEED_IMMEDIATE
end enum


enum OLEWHICHMK
	OLEWHICHMK_CONTAINER = 1
	OLEWHICHMK_OBJREL
	OLEWHICHMK_OBJFULL
end enum

enum OLEGETMONIKER
	OLEGETMONIKER_ONLYIFTHERE = 1
	OLEGETMONIKER_FORCEASSIGN
	OLEGETMONIKER_UNASSIGN
	OLEGETMONIKER_TEMPFORUSER
end enum

enum USERCLASSTYPE
	USERCLASSTYPE_FULL = 1
	USERCLASSTYPE_SHORT
	USERCLASSTYPE_APPNAME
end enum

enum DROPEFFECT
	DROPEFFECT_NONE = 0
	DROPEFFECT_COPY = 1
	DROPEFFECT_MOVE = 2
	DROPEFFECT_LINK = 4
	DROPEFFECT_SCROLL = &h80000000
end enum

type OLEMENUGROUPWIDTHS
	width(0 to 6-1) as LONG
end type

type LPOLEMENUGROUPWIDTHS as OLEMENUGROUPWIDTHS ptr
type HOLEMENU as HGLOBAL

enum OLECLOSE
	OLECLOSE_SAVEIFDIRTY
	OLECLOSE_NOSAVE
	OLECLOSE_PROMPTSAVE
end enum

type OLEVERB
	lVerb as LONG
	lpszVerbName as LPWSTR
	fuFlags as DWORD
	grfAttribs as DWORD
end type

type LPOLEVERB as OLEVERB ptr
type BORDERWIDTHS as RECT
type LPBORDERWIDTHS as LPRECT
type LPCBORDERWIDTHS as LPCRECT

type OLEINPLACEFRAMEINFO
	cb as UINT
	fMDIApp as BOOL
	hwndFrame as HWND
	haccel as HACCEL
	cAccelEntries as UINT
end type

type LPOLEINPLACEFRAMEINFO as OLEINPLACEFRAMEINFO ptr

type IEnumOLEVERBVtbl_ as IEnumOLEVERBVtbl

type IEnumOLEVERB
	lpVtbl as IEnumOLEVERBVtbl_ ptr
end type

type IEnumOLEVERBVtbl
	QueryInterface as function (byval as IEnumOLEVERB ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumOLEVERB ptr) as ULONG
	Release as function (byval as IEnumOLEVERB ptr) as ULONG
	Next as function (byval as IEnumOLEVERB ptr, byval as ULONG, byval as OLEVERB ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumOLEVERB ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumOLEVERB ptr) as HRESULT
	Clone as function (byval as IEnumOLEVERB ptr, byval as IEnumOLEVERB ptr ptr) as HRESULT
end type
extern IID_IParseDisplayName alias "IID_IParseDisplayName" as IID

type IParseDisplayNameVtbl_ as IParseDisplayNameVtbl

type IParseDisplayName
	lpVtbl as IParseDisplayNameVtbl_ ptr
end type

type IParseDisplayNameVtbl
	QueryInterface as function (byval as IParseDisplayName ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IParseDisplayName ptr) as ULONG
	Release as function (byval as IParseDisplayName ptr) as ULONG
	ParseDisplayName as function (byval as IParseDisplayName ptr, byval as IBindCtx ptr, byval as LPOLESTR, byval as ULONG ptr, byval as IMoniker ptr ptr) as HRESULT
end type
extern IID_IOleContainer alias "IID_IOleContainer" as IID

type IOleContainerVtbl_ as IOleContainerVtbl

type IOleContainer
	lpVtbl as IOleContainerVtbl_ ptr
end type

type IOleContainerVtbl
	QueryInterface as function (byval as IOleContainer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleContainer ptr) as ULONG
	Release as function (byval as IOleContainer ptr) as ULONG
	ParseDisplayName as function (byval as IOleContainer ptr, byval as IBindCtx ptr, byval as LPOLESTR, byval as ULONG ptr, byval as IMoniker ptr ptr) as HRESULT
	EnumObjects as function (byval as IOleContainer ptr, byval as DWORD, byval as IEnumUnknown ptr ptr) as HRESULT
	LockContainer as function (byval as IOleContainer ptr, byval as BOOL) as HRESULT
end type
extern IID_IOleItemContainer alias "IID_IOleItemContainer" as IID

type IOleItemContainerVtbl_ as IOleItemContainerVtbl

type IOleItemContainer
	lpVtbl as IOleItemContainerVtbl_ ptr
end type

type IOleItemContainerVtbl
	QueryInterface as function (byval as IOleItemContainer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleItemContainer ptr) as ULONG
	Release as function (byval as IOleItemContainer ptr) as ULONG
	ParseDisplayName as function (byval as IOleItemContainer ptr, byval as IBindCtx ptr, byval as LPOLESTR, byval as ULONG ptr, byval as IMoniker ptr ptr) as HRESULT
	EnumObjects as function (byval as IOleItemContainer ptr, byval as DWORD, byval as IEnumUnknown ptr ptr) as HRESULT
	LockContainer as function (byval as IOleItemContainer ptr, byval as BOOL) as HRESULT
	GetObjectA as function (byval as IOleItemContainer ptr, byval as LPOLESTR, byval as DWORD, byval as IBindCtx ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	GetObjectStorage as function (byval as IOleItemContainer ptr, byval as LPOLESTR, byval as IBindCtx ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	IsRunning as function (byval as IOleItemContainer ptr, byval as LPOLESTR) as HRESULT
end type
extern IID_IOleClientSite alias "IID_IOleClientSite" as IID

type IOleClientSiteVtbl_ as IOleClientSiteVtbl

type IOleClientSite
	lpVtbl as IOleClientSiteVtbl_ ptr
end type

type IOleClientSiteVtbl
	QueryInterface as function (byval as IOleClientSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleClientSite ptr) as ULONG
	Release as function (byval as IOleClientSite ptr) as ULONG
	SaveObject as function (byval as IOleClientSite ptr) as HRESULT
	GetMoniker as function (byval as IOleClientSite ptr, byval as DWORD, byval as DWORD, byval as LPMONIKER ptr) as HRESULT
	GetContainer as function (byval as IOleClientSite ptr, byval as LPOLECONTAINER ptr) as HRESULT
	ShowObject as function (byval as IOleClientSite ptr) as HRESULT
	OnShowWindow as function (byval as IOleClientSite ptr, byval as BOOL) as HRESULT
	RequestNewObjectLayout as function (byval as IOleClientSite ptr) as HRESULT
end type
extern IID_IOleObject alias "IID_IOleObject" as IID

type IOleObjectVtbl_ as IOleObjectVtbl

type IOleObject
	lpVtbl as IOleObjectVtbl_ ptr
end type

type IOleObjectVtbl
	QueryInterface as function (byval as IOleObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleObject ptr) as ULONG
	Release as function (byval as IOleObject ptr) as ULONG
	SetClientSite as function (byval as IOleObject ptr, byval as LPOLECLIENTSITE) as HRESULT
	GetClientSite as function (byval as IOleObject ptr, byval as LPOLECLIENTSITE ptr) as HRESULT
	SetHostNames as function (byval as IOleObject ptr, byval as LPCOLESTR, byval as LPCOLESTR) as HRESULT
	Close as function (byval as IOleObject ptr, byval as DWORD) as HRESULT
	SetMoniker as function (byval as IOleObject ptr, byval as DWORD, byval as LPMONIKER) as HRESULT
	GetMoniker as function (byval as IOleObject ptr, byval as DWORD, byval as DWORD, byval as LPMONIKER ptr) as HRESULT
	InitFromData as function (byval as IOleObject ptr, byval as LPDATAOBJECT, byval as BOOL, byval as DWORD) as HRESULT
	GetClipboardData as function (byval as IOleObject ptr, byval as DWORD, byval as LPDATAOBJECT ptr) as HRESULT
	DoVerb as function (byval as IOleObject ptr, byval as LONG, byval as LPMSG, byval as LPOLECLIENTSITE, byval as LONG, byval as HWND, byval as LPCRECT) as HRESULT
	EnumVerbs as function (byval as IOleObject ptr, byval as LPENUMOLEVERB ptr) as HRESULT
	Update as function (byval as IOleObject ptr) as HRESULT
	IsUpToDate as function (byval as IOleObject ptr) as HRESULT
	GetUserClassID as function (byval as IOleObject ptr, byval as LPCLSID) as HRESULT
	GetUserType as function (byval as IOleObject ptr, byval as DWORD, byval as LPOLESTR ptr) as HRESULT
	SetExtent as function (byval as IOleObject ptr, byval as DWORD, byval as SIZEL ptr) as HRESULT
	GetExtent as function (byval as IOleObject ptr, byval as DWORD, byval as SIZEL ptr) as HRESULT
	Advise as function (byval as IOleObject ptr, byval as LPADVISESINK, byval as PDWORD) as HRESULT
	Unadvise as function (byval as IOleObject ptr, byval as DWORD) as HRESULT
	EnumAdvise as function (byval as IOleObject ptr, byval as LPENUMSTATDATA ptr) as HRESULT
	GetMiscStatus as function (byval as IOleObject ptr, byval as DWORD, byval as PDWORD) as HRESULT
	SetColorScheme as function (byval as IOleObject ptr, byval as LPLOGPALETTE) as HRESULT
end type
extern IID_IOleWindow alias "IID_IOleWindow" as IID

type IOleWindowVtbl_ as IOleWindowVtbl

type IOleWindow
	lpVtbl as IOleWindowVtbl_ ptr
end type

type IOleWindowVtbl
	QueryInterface as function (byval as IOleWindow ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleWindow ptr) as ULONG
	Release as function (byval as IOleWindow ptr) as ULONG
	GetWindow as function (byval as IOleWindow ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleWindow ptr, byval as BOOL) as HRESULT
end type
extern IID_IOleInPlaceUIWindow alias "IID_IOleInPlaceUIWindow" as IID

type IOleInPlaceUIWindowVtbl_ as IOleInPlaceUIWindowVtbl

type IOleInPlaceUIWindow
	lpVtbl as IOleInPlaceUIWindowVtbl_ ptr
end type

type IOleInPlaceUIWindowVtbl
	QueryInterface as function (byval as IOleInPlaceUIWindow ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleInPlaceUIWindow ptr) as ULONG
	Release as function (byval as IOleInPlaceUIWindow ptr) as ULONG
	GetWindow as function (byval as IOleInPlaceUIWindow ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleInPlaceUIWindow ptr, byval as BOOL) as HRESULT
	GetBorder as function (byval as IOleInPlaceUIWindow ptr, byval as LPRECT) as HRESULT
	RequestBorderSpace as function (byval as IOleInPlaceUIWindow ptr, byval as LPCBORDERWIDTHS) as HRESULT
	SetBorderSpace as function (byval as IOleInPlaceUIWindow ptr, byval as LPCBORDERWIDTHS) as HRESULT
	SetActiveObject as function (byval as IOleInPlaceUIWindow ptr, byval as LPOLEINPLACEACTIVEOBJECT, byval as LPCOLESTR) as HRESULT
end type
extern IID_IOleInPlaceObject alias "IID_IOleInPlaceObject" as IID

type IOleInPlaceObjectVtbl_ as IOleInPlaceObjectVtbl 

type IOleInPlaceObject
	lpVtbl as IOleInPlaceObjectVtbl_ ptr
end type

type IOleInPlaceObjectVtbl
	QueryInterface as function (byval as IOleInPlaceObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleInPlaceObject ptr) as ULONG
	Release as function (byval as IOleInPlaceObject ptr) as ULONG
	GetWindow as function (byval as IOleInPlaceObject ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleInPlaceObject ptr, byval as BOOL) as HRESULT
	InPlaceDeactivate as function (byval as IOleInPlaceObject ptr) as HRESULT
	UIDeactivate as function (byval as IOleInPlaceObject ptr) as HRESULT
	SetObjectRects as function (byval as IOleInPlaceObject ptr, byval as LPCRECT, byval as LPCRECT) as HRESULT
	ReactivateAndUndo as function (byval as IOleInPlaceObject ptr) as HRESULT
end type
extern IID_IOleInPlaceActiveObject alias "IID_IOleInPlaceActiveObject" as IID

type IOleInPlaceActiveObjectVtbl_ as IOleInPlaceActiveObjectVtbl

type IOleInPlaceActiveObject
	lpVtbl as IOleInPlaceActiveObjectVtbl_ ptr
end type

type IOleInPlaceActiveObjectVtbl
	QueryInterface as function (byval as IOleInPlaceActiveObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleInPlaceActiveObject ptr) as ULONG
	Release as function (byval as IOleInPlaceActiveObject ptr) as ULONG
	GetWindow as function (byval as IOleInPlaceActiveObject ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleInPlaceActiveObject ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorA as function (byval as IOleInPlaceActiveObject ptr, byval as LPMSG) as HRESULT
	OnFrameWindowActivate as function (byval as IOleInPlaceActiveObject ptr, byval as BOOL) as HRESULT
	OnDocWindowActivate as function (byval as IOleInPlaceActiveObject ptr, byval as BOOL) as HRESULT
	ResizeBorder as function (byval as IOleInPlaceActiveObject ptr, byval as LPCRECT, byval as LPOLEINPLACEUIWINDOW, byval as BOOL) as HRESULT
	EnableModeless as function (byval as IOleInPlaceActiveObject ptr, byval as BOOL) as HRESULT
end type
extern IID_IOleInPlaceFrame alias "IID_IOleInPlaceFrame" as IID

type IOleInPlaceFrameVtbl_ as IOleInPlaceFrameVtbl

type IOleInPlaceFrame
	lpVtbl as IOleInPlaceFrameVtbl_ ptr
end type

type IOleInPlaceFrameVtbl
	QueryInterface as function (byval as IOleInPlaceFrame ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleInPlaceFrame ptr) as ULONG
	Release as function (byval as IOleInPlaceFrame ptr) as ULONG
	GetWindow as function (byval as IOleInPlaceFrame ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleInPlaceFrame ptr, byval as BOOL) as HRESULT
	GetBorder as function (byval as IOleInPlaceFrame ptr, byval as LPRECT) as HRESULT
	RequestBorderSpace as function (byval as IOleInPlaceFrame ptr, byval as LPCBORDERWIDTHS) as HRESULT
	SetBorderSpace as function (byval as IOleInPlaceFrame ptr, byval as LPCBORDERWIDTHS) as HRESULT
	SetActiveObject as function (byval as IOleInPlaceFrame ptr, byval as LPOLEINPLACEACTIVEOBJECT, byval as LPCOLESTR) as HRESULT
	InsertMenus as function (byval as IOleInPlaceFrame ptr, byval as HMENU, byval as LPOLEMENUGROUPWIDTHS) as HRESULT
	SetMenu as function (byval as IOleInPlaceFrame ptr, byval as HMENU, byval as HOLEMENU, byval as HWND) as HRESULT
	RemoveMenus as function (byval as IOleInPlaceFrame ptr, byval as HMENU) as HRESULT
	SetStatusText as function (byval as IOleInPlaceFrame ptr, byval as LPCOLESTR) as HRESULT
	EnableModeless as function (byval as IOleInPlaceFrame ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorA as function (byval as IOleInPlaceFrame ptr, byval as LPMSG, byval as WORD) as HRESULT
end type
extern IID_IOleInPlaceSite alias "IID_IOleInPlaceSite" as IID

type IOleInPlaceSiteVtbl_ as IOleInPlaceSiteVtbl

type IOleInPlaceSite
	lpVtbl as IOleInPlaceSiteVtbl_ ptr
end type

type IOleInPlaceSiteVtbl
	QueryInterface as function (byval as IOleInPlaceSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleInPlaceSite ptr) as ULONG
	Release as function (byval as IOleInPlaceSite ptr) as ULONG
	GetWindow as function (byval as IOleInPlaceSite ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IOleInPlaceSite ptr, byval as BOOL) as HRESULT
	CanInPlaceActivate as function (byval as IOleInPlaceSite ptr) as HRESULT
	OnInPlaceActivate as function (byval as IOleInPlaceSite ptr) as HRESULT
	OnUIActivate as function (byval as IOleInPlaceSite ptr) as HRESULT
	GetWindowContext as function (byval as IOleInPlaceSite ptr, byval as IOleInPlaceFrame ptr ptr, byval as IOleInPlaceUIWindow ptr ptr, byval as LPRECT, byval as LPRECT, byval as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function (byval as IOleInPlaceSite ptr, byval as SIZE) as HRESULT
	OnUIDeactivate as function (byval as IOleInPlaceSite ptr, byval as BOOL) as HRESULT
	OnInPlaceDeactivate as function (byval as IOleInPlaceSite ptr) as HRESULT
	DiscardUndoState as function (byval as IOleInPlaceSite ptr) as HRESULT
	DeactivateAndUndo as function (byval as IOleInPlaceSite ptr) as HRESULT
	OnPosRectChange as function (byval as IOleInPlaceSite ptr, byval as LPCRECT) as HRESULT
end type
extern IID_IOleAdviseHolder alias "IID_IOleAdviseHolder" as IID

type IOleAdviseHolderVtbl_ as IOleAdviseHolderVtbl

type IOleAdviseHolder
	lpVtbl as IOleAdviseHolderVtbl_ ptr
end type

type IOleAdviseHolderVtbl
	QueryInterface as function (byval as IOleAdviseHolder ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IOleAdviseHolder ptr) as ULONG
	Release as function (byval as IOleAdviseHolder ptr) as ULONG
	Advise as function (byval as IOleAdviseHolder ptr, byval as LPADVISESINK, byval as PDWORD) as HRESULT
	Unadvise as function (byval as IOleAdviseHolder ptr, byval as DWORD) as HRESULT
	EnumAdvise as function (byval as IOleAdviseHolder ptr, byval as LPENUMSTATDATA ptr) as HRESULT
	SendOnRename as function (byval as IOleAdviseHolder ptr, byval as LPMONIKER) as HRESULT
	SendOnSave as function (byval as IOleAdviseHolder ptr) as HRESULT
	SendOnClose as function (byval as IOleAdviseHolder ptr) as HRESULT
end type
extern IID_IDropSource alias "IID_IDropSource" as IID

type IDropSourceVtbl_ as IDropSourceVtbl

type IDropSource
	lpVtbl as IDropSourceVtbl_ ptr
end type

type IDropSourceVtbl
	QueryInterface as function (byval as IDropSource ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IDropSource ptr) as ULONG
	Release as function (byval as IDropSource ptr) as ULONG
	QueryContinueDrag as function (byval as IDropSource ptr, byval as BOOL, byval as DWORD) as HRESULT
	GiveFeedback as function (byval as IDropSource ptr, byval as DWORD) as HRESULT
end type
extern IID_IDropTarget alias "IID_IDropTarget" as IID

type IDropTargetVtbl_ as IDropTargetVtbl

type IDropTarget
	lpVtbl as IDropTargetVtbl_ ptr
end type

type IDropTargetVtbl
	QueryInterface as function (byval as IDropTarget ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IDropTarget ptr) as ULONG
	Release as function (byval as IDropTarget ptr) as ULONG
	DragEnter as function (byval as IDropTarget ptr, byval as LPDATAOBJECT, byval as DWORD, byval as POINTL, byval as PDWORD) as HRESULT
	DragOver as function (byval as IDropTarget ptr, byval as DWORD, byval as POINTL, byval as PDWORD) as HRESULT
	DragLeave as function (byval as IDropTarget ptr) as HRESULT
	Drop as function (byval as IDropTarget ptr, byval as LPDATAOBJECT, byval as DWORD, byval as POINTL, byval as PDWORD) as HRESULT
end type
extern IID_IViewObject alias "IID_IViewObject" as IID

type __IView_pfncont as function (byval as DWORD) as BOOL

type IViewObjectVtbl_ as IViewObjectVtbl

type IViewObject
	lpVtbl as IViewObjectVtbl_ ptr
end type

type IViewObjectVtbl
	QueryInterface as function (byval as IViewObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IViewObject ptr) as ULONG
	Release as function (byval as IViewObject ptr) as ULONG
	Draw as function (byval as IViewObject ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as DVTARGETDEVICE ptr, byval as HDC, byval as HDC, byval as LPCRECTL, byval as LPCRECTL, byval as __IView_pfncont, byval as DWORD) as HRESULT
	GetColorSet as function (byval as IViewObject ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as DVTARGETDEVICE ptr, byval as HDC, byval as LPLOGPALETTE ptr) as HRESULT
	Freeze as function (byval as IViewObject ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as PDWORD) as HRESULT
	Unfreeze as function (byval as IViewObject ptr, byval as DWORD) as HRESULT
	SetAdvise as function (byval as IViewObject ptr, byval as DWORD, byval as DWORD, byval as IAdviseSink ptr) as HRESULT
	GetAdvise as function (byval as IViewObject ptr, byval as PDWORD, byval as PDWORD, byval as IAdviseSink ptr ptr) as HRESULT
end type
extern IID_IViewObject2 alias "IID_IViewObject2" as IID

type IViewObject2Vtbl_ as IViewObject2Vtbl

type IViewObject2
	lpVtbl as IViewObject2Vtbl_ ptr
end type

type IViewObject2Vtbl
	QueryInterface as function (byval as IViewObject2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IViewObject2 ptr) as ULONG
	Release as function (byval as IViewObject2 ptr) as ULONG
	Draw as function (byval as IViewObject2 ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as DVTARGETDEVICE ptr, byval as HDC, byval as HDC, byval as LPCRECTL, byval as LPCRECTL, byval as __IView_pfncont, byval as DWORD) as HRESULT
	GetColorSet as function (byval as IViewObject2 ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as DVTARGETDEVICE ptr, byval as HDC, byval as LPLOGPALETTE ptr) as HRESULT
	Freeze as function (byval as IViewObject2 ptr, byval as DWORD, byval as LONG, byval as PVOID, byval as PDWORD) as HRESULT
	Unfreeze as function (byval as IViewObject2 ptr, byval as DWORD) as HRESULT
	SetAdvise as function (byval as IViewObject2 ptr, byval as DWORD, byval as DWORD, byval as IAdviseSink ptr) as HRESULT
	GetAdvise as function (byval as IViewObject2 ptr, byval as PDWORD, byval as PDWORD, byval as IAdviseSink ptr ptr) as HRESULT
	GetExtent as function (byval as IViewObject2 ptr, byval as DWORD, byval as LONG, byval as DVTARGETDEVICE ptr, byval as LPSIZEL) as HRESULT
end type
extern IID_IOleCache alias "IID_IOleCache" as IID

type IOleCacheVtbl_ as IOleCacheVtbl

type IOleCache
	lpVtbl as IOleCacheVtbl_ ptr
end type

type IOleCacheVtbl
	QueryInterface as function(byval as IOleCache ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleCache ptr) as ULONG
	Release as function(byval as IOleCache ptr) as ULONG
	Cache as function(byval as IOleCache ptr, byval as FORMATETC ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	Uncache as function(byval as IOleCache ptr, byval as DWORD) as HRESULT
	EnumCache as function(byval as IOleCache ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
	InitCache as function(byval as IOleCache ptr, byval as LPDATAOBJECT) as HRESULT
	SetData as function(byval as IOleCache ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr, byval as BOOL) as HRESULT
end type
extern IID_IOleCache2 alias "IID_IOleCache2" as IID

type IOleCache2Vtbl_ as IOleCache2Vtbl

type IOleCache2
	lpVtbl as IOleCache2Vtbl_ ptr
end type

type IOleCache2Vtbl
	QueryInterface as function(byval as IOleCache2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleCache2 ptr) as ULONG
	Release as function(byval as IOleCache2 ptr) as ULONG
	Cache as function(byval as IOleCache2 ptr, byval as FORMATETC ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	Uncache as function(byval as IOleCache2 ptr, byval as DWORD) as HRESULT
	EnumCache as function(byval as IOleCache2 ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
	InitCache as function(byval as IOleCache2 ptr, byval as LPDATAOBJECT) as HRESULT
	SetData as function(byval as IOleCache2 ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr, byval as BOOL) as HRESULT
	UpdateCache as function(byval as IOleCache2 ptr, byval as LPDATAOBJECT, byval as DWORD, byval as LPVOID) as HRESULT
	DiscardCache as function(byval as IOleCache2 ptr, byval as DWORD) as HRESULT
end type
extern IID_IOleCacheControl alias "IID_IOleCacheControl" as IID

type IOleCacheControlVtbl_ as IOleCacheControlVtbl

type IOleCacheControl
	lpVtbl as IOleCacheControlVtbl_ ptr
end type

type IOleCacheControlVtbl
	QueryInterface as function(byval as IOleCacheControl ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleCacheControl ptr) as ULONG
	Release as function(byval as IOleCacheControl ptr) as ULONG
	OnRun as function(byval as IOleCacheControl ptr, byval as LPDATAOBJECT) as HRESULT
	OnStop as function(byval as IOleCacheControl ptr) as HRESULT
end type

#endif
