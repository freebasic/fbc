''
''
'' docobj -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_docobj_bi__
#define __win_docobj_bi__

#inclib "uuid"

#define OLECMDERR_E_UNKNOWNGROUP (-2147221244)
#define OLECMDERR_E_DISABLED (-2147221247)
#define OLECMDERR_E_NOHELP (-2147221246)
#define OLECMDERR_E_CANCELED (-2147221245)
#define OLECMDERR_E_NOTSUPPORTED (-2147221248)

enum OLECMDID
	OLECMDID_OPEN = 1
	OLECMDID_NEW = 2
	OLECMDID_SAVE = 3
	OLECMDID_SAVEAS = 4
	OLECMDID_SAVECOPYAS = 5
	OLECMDID_PRINT = 6
	OLECMDID_PRINTPREVIEW = 7
	OLECMDID_PAGESETUP = 8
	OLECMDID_SPELL = 9
	OLECMDID_PROPERTIES = 10
	OLECMDID_CUT = 11
	OLECMDID_COPY = 12
	OLECMDID_PASTE = 13
	OLECMDID_PASTESPECIAL = 14
	OLECMDID_UNDO = 15
	OLECMDID_REDO = 16
	OLECMDID_SELECTALL = 17
	OLECMDID_CLEARSELECTION = 18
	OLECMDID_ZOOM = 19
	OLECMDID_GETZOOMRANGE = 20
	OLECMDID_UPDATECOMMANDS = 21
	OLECMDID_REFRESH = 22
	OLECMDID_STOP = 23
	OLECMDID_HIDETOOLBARS = 24
	OLECMDID_SETPROGRESSMAX = 25
	OLECMDID_SETPROGRESSPOS = 26
	OLECMDID_SETPROGRESSTEXT = 27
	OLECMDID_SETTITLE = 28
	OLECMDID_SETDOWNLOADSTATE = 29
	OLECMDID_STOPDOWNLOAD = 30
end enum


enum OLECMDF
	OLECMDF_SUPPORTED = 1
	OLECMDF_ENABLED = 2
	OLECMDF_LATCHED = 4
	OLECMDF_NINCHED = 8
end enum


enum OLECMDEXECOPT
	OLECMDEXECOPT_DODEFAULT = 0
	OLECMDEXECOPT_PROMPTUSER = 1
	OLECMDEXECOPT_DONTPROMPTUSER = 2
	OLECMDEXECOPT_SHOWHELP = 3
end enum


type OLECMDTEXT
	cmdtextf as DWORD
	cwActual as ULONG
	cwBuf as ULONG
	rgwz as wstring * 1
end type

type OLECMD
	cmdID as ULONG
	cmdf as DWORD
end type

type LPOLEINPLACESITE as IOleInPlaceSite ptr
type LPENUMOLEDOCUMENTVIEWS as IEnumOleDocumentViews ptr

extern IID_IContinueCallback alias "IID_IContinueCallback" as IID
extern IID_IEnumOleDocumentViews alias "IID_IEnumOleDocumentViews" as IID
extern IID_IPrint alias "IID_IPrint" as IID
extern IID_IOleDocumentView alias "IID_IOleDocumentView" as IID

type IOleDocumentViewVtbl_ as IOleDocumentViewVtbl

type IOleDocumentView
	lpVtbl as IOleDocumentViewVtbl_ ptr
end type

type IOleDocumentViewVtbl
	QueryInterface as function(byval as IOleDocumentView ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleDocumentView ptr) as ULONG
	Release as function(byval as IOleDocumentView ptr) as ULONG
	SetInPlaceSite as function(byval as IOleDocumentView ptr, byval as LPOLEINPLACESITE) as HRESULT
	GetInPlaceSite as function(byval as IOleDocumentView ptr, byval as LPOLEINPLACESITE ptr) as HRESULT
	GetDocument as function(byval as IOleDocumentView ptr, byval as IUnknown ptr) as HRESULT
	SetRect as function(byval as IOleDocumentView ptr, byval as LPRECT) as HRESULT
	GetRect as function(byval as IOleDocumentView ptr, byval as LPRECT) as HRESULT
	SetRectComplex as function(byval as IOleDocumentView ptr, byval as LPRECT, byval as LPRECT, byval as LPRECT, byval as LPRECT) as HRESULT
	Show as function(byval as IOleDocumentView ptr, byval as BOOL) as HRESULT
	UIActivate as function(byval as IOleDocumentView ptr, byval as BOOL) as HRESULT
	Open as function(byval as IOleDocumentView ptr) as HRESULT
	Close as function(byval as IOleDocumentView ptr, byval as DWORD) as HRESULT
	SaveViewState as function(byval as IOleDocumentView ptr, byval as IStream ptr) as HRESULT
	ApplyViewState as function(byval as IOleDocumentView ptr, byval as IStream ptr) as HRESULT
	Clone as function(byval as IOleDocumentView ptr, byval as LPOLEINPLACESITE, byval as IOleDocumentView ptr ptr) as HRESULT
end type

type IEnumOleDocumentViewsVtbl_ as IEnumOleDocumentViewsVtbl

type IEnumOleDocumentViews
	lpVtbl as IEnumOleDocumentViewsVtbl_ ptr
end type

type IEnumOleDocumentViewsVtbl
	QueryInterface as function(byval as IEnumOleDocumentViews ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumOleDocumentViews ptr) as ULONG
	Release as function(byval as IEnumOleDocumentViews ptr) as ULONG
	Next as function(byval as IEnumOleDocumentViews ptr, byval as ULONG, byval as IOleDocumentView ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumOleDocumentViews ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumOleDocumentViews ptr) as HRESULT
	Clone as function(byval as IEnumOleDocumentViews ptr, byval as IEnumOleDocumentViews ptr ptr) as HRESULT
end type
extern IID_IOleDocument alias "IID_IOleDocument" as IID

type IOleDocumentVtbl_ as IOleDocumentVtbl

type IOleDocument
	lpVtbl as IOleDocumentVtbl_ ptr
end type

type IOleDocumentVtbl
	QueryInterface as function(byval as IOleDocument ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleDocument ptr) as ULONG
	Release as function(byval as IOleDocument ptr) as ULONG
	CreateView as function(byval as IOleDocument ptr, byval as LPOLEINPLACESITE, byval as IStream ptr, byval as DWORD, byval as IOleDocumentView ptr ptr) as HRESULT
	GetDocMiscStatus as function(byval as IOleDocument ptr, byval as DWORD ptr) as HRESULT
	EnumViews as function(byval as IOleDocument ptr, byval as LPENUMOLEDOCUMENTVIEWS ptr, byval as IOleDocumentView ptr ptr) as HRESULT
end type
extern IID_IOleCommandTarget alias "IID_IOleCommandTarget" as IID

type IOleCommandTargetVtbl_ as IOleCommandTargetVtbl

type IOleCommandTarget
	lpVtbl as IOleCommandTargetVtbl_ ptr
end type

type IOleCommandTargetVtbl
	QueryInterface as function(byval as IOleCommandTarget ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleCommandTarget ptr) as ULONG
	Release as function(byval as IOleCommandTarget ptr) as ULONG
	QueryStatus as function(byval as IOleCommandTarget ptr, byval as GUID ptr, byval as ULONG, byval as OLECMD ptr, byval as OLECMDTEXT ptr) as HRESULT
	Exec as function(byval as IOleCommandTarget ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as VARIANTARG ptr, byval as VARIANTARG ptr) as HRESULT
end type
extern IID_IOleDocumentSite alias "IID_IOleDocumentSite" as IID

type IOleDocumentSiteVtbl_ as IOleDocumentSiteVtbl

type IOleDocumentSite
	lpVtbl as IOleDocumentSiteVtbl_ ptr
end type

type IOleDocumentSiteVtbl
	QueryInterface as function(byval as IOleDocumentSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleDocumentSite ptr) as ULONG
	Release as function(byval as IOleDocumentSite ptr) as ULONG
	ActivateMe as function(byval as IOleDocumentSite ptr, byval as IOleDocumentView ptr) as HRESULT
end type

#endif
