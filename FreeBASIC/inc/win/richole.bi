''
''
'' richole -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_richole_bi__
#define __win_richole_bi__

#inclib "uuid"

#define REO_GETOBJ_NO_INTERFACES 0
#define REO_GETOBJ_POLEOBJ 1
#define REO_GETOBJ_PSTG 2
#define REO_GETOBJ_POLESITE 4
#define REO_GETOBJ_ALL_INTERFACES 7
#define REO_CP_SELECTION cast(ULONG,-1)
#define REO_IOB_SELECTION cast(ULONG,-1)
#define REO_IOB_USE_CP cast(ULONG,-2)
#define REO_NULL 0
#define REO_READWRITEMASK &h3FL
#define REO_DONTNEEDPALETTE 32
#define REO_BLANK 16
#define REO_DYNAMICSIZE 8
#define REO_INVERTEDSELECT 4
#define REO_BELOWBASELINE 2
#define REO_RESIZABLE 1
#define REO_LINK &h80000000
#define REO_STATIC &h40000000
#define REO_SELECTED &h08000000
#define REO_OPEN &h4000000
#define REO_INPLACEACTIVE &h2000000
#define REO_HILITED &h1000000
#define REO_LINKAVAILABLE &h800000
#define REO_GETMETAFILE &h400000
#define RECO_PASTE 0
#define RECO_DROP 1
#define RECO_COPY 2
#define RECO_CUT 3
#define RECO_DRAG 4
extern IID_IRichEditOle alias "IID_IRichEditOle" as GUID
extern IID_IRichEditOleCallback alias "IID_IRichEditOleCallback" as GUID

type REOBJECT
	cbStruct as DWORD
	cp as LONG
	clsid as CLSID
	poleobj as LPOLEOBJECT
	pstg as LPSTORAGE
	polesite as LPOLECLIENTSITE
	sizel as SIZEL
	dvaspect as DWORD
	dwFlags as DWORD
	dwUser as DWORD
end type

type IRichEditOleVtbl_ as IRichEditOleVtbl

type IRichEditOle
	lpVtbl as IRichEditOleVtbl_ ptr
end type

type IRichEditOleVtbl
	QueryInterface as function(byval as IRichEditOle ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IRichEditOle ptr) as ULONG
	Release as function(byval as IRichEditOle ptr) as ULONG
	GetClientSite as function(byval as IRichEditOle ptr, byval as LPOLECLIENTSITE ptr) as HRESULT
	GetObjectCount as function(byval as IRichEditOle ptr) as LONG
	GetLinkCount as function(byval as IRichEditOle ptr) as LONG
	GetObjectA as function(byval as IRichEditOle ptr, byval as LONG, byval as REOBJECT ptr, byval as DWORD) as HRESULT
	InsertObject as function(byval as IRichEditOle ptr, byval as REOBJECT ptr) as HRESULT
	ConvertObject as function(byval as IRichEditOle ptr, byval as LONG, byval as CLSID ptr, byval as LPCSTR) as HRESULT
	ActivateAs as function(byval as IRichEditOle ptr, byval as CLSID ptr, byval as CLSID ptr) as HRESULT
	SetHostNames as function(byval as IRichEditOle ptr, byval as LPCSTR, byval as LPCSTR) as HRESULT
	SetLinkAvailable as function(byval as IRichEditOle ptr, byval as LONG, byval as BOOL) as HRESULT
	SetDvaspect as function(byval as IRichEditOle ptr, byval as LONG, byval as DWORD) as HRESULT
	HandsOffStorage as function(byval as IRichEditOle ptr, byval as LONG) as HRESULT
	SaveCompleted as function(byval as IRichEditOle ptr, byval as LONG, byval as LPSTORAGE) as HRESULT
	InPlaceDeactivate as function(byval as IRichEditOle ptr) as HRESULT
	ContextSensitiveHelp as function(byval as IRichEditOle ptr, byval as BOOL) as HRESULT
	GetClipboardData as function(byval as IRichEditOle ptr, byval as CHARRANGE ptr, byval as DWORD, byval as LPDATAOBJECT ptr) as HRESULT
	ImportDataObject as function(byval as IRichEditOle ptr, byval as LPDATAOBJECT, byval as CLIPFORMAT, byval as HGLOBAL) as HRESULT
end type

type LPRICHEDITOLE as IRichEditOle ptr

type IRichEditOleCallbackVtbl_ as IRichEditOleCallbackVtbl

type IRichEditOleCallback
	lpVtbl as IRichEditOleCallbackVtbl_ ptr
end type

type IRichEditOleCallbackVtbl
	QueryInterface as function(byval as IRichEditOleCallback ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IRichEditOleCallback ptr) as ULONG
	Release as function(byval as IRichEditOleCallback ptr) as ULONG
	GetNewStorage as function(byval as IRichEditOleCallback ptr, byval as LPSTORAGE ptr) as HRESULT
	GetInPlaceContext as function(byval as IRichEditOleCallback ptr, byval as LPOLEINPLACEFRAME ptr, byval as LPOLEINPLACEUIWINDOW ptr, byval as LPOLEINPLACEFRAMEINFO) as HRESULT
	ShowContainerUI as function(byval as IRichEditOleCallback ptr, byval as BOOL) as HRESULT
	QueryInsertObject as function(byval as IRichEditOleCallback ptr, byval as LPCLSID, byval as LPSTORAGE, byval as LONG) as HRESULT
	DeleteObject as function(byval as IRichEditOleCallback ptr, byval as LPOLEOBJECT) as HRESULT
	QueryAcceptData as function(byval as IRichEditOleCallback ptr, byval as LPDATAOBJECT, byval as CLIPFORMAT ptr, byval as DWORD, byval as BOOL, byval as HGLOBAL) as HRESULT
	ContextSensitiveHelp as function(byval as IRichEditOleCallback ptr, byval as BOOL) as HRESULT
	GetClipboardData as function(byval as IRichEditOleCallback ptr, byval as CHARRANGE ptr, byval as DWORD, byval as LPDATAOBJECT ptr) as HRESULT
	GetDragDropEffect as function(byval as IRichEditOleCallback ptr, byval as BOOL, byval as DWORD, byval as PDWORD) as HRESULT
	GetContextMenu as function(byval as IRichEditOleCallback ptr, byval as WORD, byval as LPOLEOBJECT, byval as CHARRANGE ptr, byval as HMENU ptr) as HRESULT
end type

type LPRICHEDITOLECALLBACK as IRichEditOleCallback ptr

#endif
