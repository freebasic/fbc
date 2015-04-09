'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#inclib "uuid"

#include once "crt/long.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "ocidl.bi"
#include once "objidl.bi"
#include once "oleidl.bi"
#include once "oaidl.bi"
#include once "servprov.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __docobj_h__
#define __IOleDocument_FWD_DEFINED__
#define __IOleDocumentSite_FWD_DEFINED__
#define __IOleDocumentView_FWD_DEFINED__
#define __IEnumOleDocumentViews_FWD_DEFINED__
#define __IContinueCallback_FWD_DEFINED__
#define __IPrint_FWD_DEFINED__
#define __IOleCommandTarget_FWD_DEFINED__
#define __IZoomEvents_FWD_DEFINED__
#define __IProtectFocus_FWD_DEFINED__
#define __IProtectedModeMenuServices_FWD_DEFINED__
#define _LPOLEDOCUMENT_DEFINED
#define __IOleDocument_INTERFACE_DEFINED__
type IOleDocument as IOleDocument_
type LPOLEDOCUMENT as IOleDocument ptr

type __WIDL_docobj_generated_name_00000013 as long
enum
	DOCMISC_CANCREATEMULTIPLEVIEWS = 1
	DOCMISC_SUPPORTCOMPLEXRECTANGLES = 2
	DOCMISC_CANTOPENEDIT = 4
	DOCMISC_NOFILESUPPORT = 8
end enum

type DOCMISC as __WIDL_docobj_generated_name_00000013
extern IID_IOleDocument as const GUID
type IOleDocumentView as IOleDocumentView_
type IEnumOleDocumentViews as IEnumOleDocumentViews_

type IOleDocumentVtbl
	QueryInterface as function(byval This as IOleDocument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleDocument ptr) as ULONG
	Release as function(byval This as IOleDocument ptr) as ULONG
	CreateView as function(byval This as IOleDocument ptr, byval pIPSite as IOleInPlaceSite ptr, byval pstm as IStream ptr, byval dwReserved as DWORD, byval ppView as IOleDocumentView ptr ptr) as HRESULT
	GetDocMiscStatus as function(byval This as IOleDocument ptr, byval pdwStatus as DWORD ptr) as HRESULT
	EnumViews as function(byval This as IOleDocument ptr, byval ppEnum as IEnumOleDocumentViews ptr ptr, byval ppView as IOleDocumentView ptr ptr) as HRESULT
end type

type IOleDocument_
	lpVtbl as IOleDocumentVtbl ptr
end type

declare function IOleDocument_CreateView_Proxy(byval This as IOleDocument ptr, byval pIPSite as IOleInPlaceSite ptr, byval pstm as IStream ptr, byval dwReserved as DWORD, byval ppView as IOleDocumentView ptr ptr) as HRESULT
declare sub IOleDocument_CreateView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocument_GetDocMiscStatus_Proxy(byval This as IOleDocument ptr, byval pdwStatus as DWORD ptr) as HRESULT
declare sub IOleDocument_GetDocMiscStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocument_EnumViews_Proxy(byval This as IOleDocument ptr, byval ppEnum as IEnumOleDocumentViews ptr ptr, byval ppView as IOleDocumentView ptr ptr) as HRESULT
declare sub IOleDocument_EnumViews_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPOLEDOCUMENTSITE_DEFINED
#define __IOleDocumentSite_INTERFACE_DEFINED__
type IOleDocumentSite as IOleDocumentSite_
type LPOLEDOCUMENTSITE as IOleDocumentSite ptr
extern IID_IOleDocumentSite as const GUID

type IOleDocumentSiteVtbl
	QueryInterface as function(byval This as IOleDocumentSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleDocumentSite ptr) as ULONG
	Release as function(byval This as IOleDocumentSite ptr) as ULONG
	ActivateMe as function(byval This as IOleDocumentSite ptr, byval pViewToActivate as IOleDocumentView ptr) as HRESULT
end type

type IOleDocumentSite_
	lpVtbl as IOleDocumentSiteVtbl ptr
end type

declare function IOleDocumentSite_ActivateMe_Proxy(byval This as IOleDocumentSite ptr, byval pViewToActivate as IOleDocumentView ptr) as HRESULT
declare sub IOleDocumentSite_ActivateMe_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPOLEDOCUMENTVIEW_DEFINED
#define __IOleDocumentView_INTERFACE_DEFINED__
type LPOLEDOCUMENTVIEW as IOleDocumentView ptr
extern IID_IOleDocumentView as const GUID

type IOleDocumentViewVtbl
	QueryInterface as function(byval This as IOleDocumentView ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleDocumentView ptr) as ULONG
	Release as function(byval This as IOleDocumentView ptr) as ULONG
	SetInPlaceSite as function(byval This as IOleDocumentView ptr, byval pIPSite as IOleInPlaceSite ptr) as HRESULT
	GetInPlaceSite as function(byval This as IOleDocumentView ptr, byval ppIPSite as IOleInPlaceSite ptr ptr) as HRESULT
	GetDocument as function(byval This as IOleDocumentView ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	SetRect as function(byval This as IOleDocumentView ptr, byval prcView as LPRECT) as HRESULT
	GetRect as function(byval This as IOleDocumentView ptr, byval prcView as LPRECT) as HRESULT
	SetRectComplex as function(byval This as IOleDocumentView ptr, byval prcView as LPRECT, byval prcHScroll as LPRECT, byval prcVScroll as LPRECT, byval prcSizeBox as LPRECT) as HRESULT
	Show as function(byval This as IOleDocumentView ptr, byval fShow as WINBOOL) as HRESULT
	UIActivate as function(byval This as IOleDocumentView ptr, byval fUIActivate as WINBOOL) as HRESULT
	Open as function(byval This as IOleDocumentView ptr) as HRESULT
	CloseView as function(byval This as IOleDocumentView ptr, byval dwReserved as DWORD) as HRESULT
	SaveViewState as function(byval This as IOleDocumentView ptr, byval pstm as LPSTREAM) as HRESULT
	ApplyViewState as function(byval This as IOleDocumentView ptr, byval pstm as LPSTREAM) as HRESULT
	Clone as function(byval This as IOleDocumentView ptr, byval pIPSiteNew as IOleInPlaceSite ptr, byval ppViewNew as IOleDocumentView ptr ptr) as HRESULT
end type

type IOleDocumentView_
	lpVtbl as IOleDocumentViewVtbl ptr
end type

declare function IOleDocumentView_SetInPlaceSite_Proxy(byval This as IOleDocumentView ptr, byval pIPSite as IOleInPlaceSite ptr) as HRESULT
declare sub IOleDocumentView_SetInPlaceSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_GetInPlaceSite_Proxy(byval This as IOleDocumentView ptr, byval ppIPSite as IOleInPlaceSite ptr ptr) as HRESULT
declare sub IOleDocumentView_GetInPlaceSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_GetDocument_Proxy(byval This as IOleDocumentView ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub IOleDocumentView_GetDocument_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_SetRect_Proxy(byval This as IOleDocumentView ptr, byval prcView as LPRECT) as HRESULT
declare sub IOleDocumentView_SetRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_GetRect_Proxy(byval This as IOleDocumentView ptr, byval prcView as LPRECT) as HRESULT
declare sub IOleDocumentView_GetRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_SetRectComplex_Proxy(byval This as IOleDocumentView ptr, byval prcView as LPRECT, byval prcHScroll as LPRECT, byval prcVScroll as LPRECT, byval prcSizeBox as LPRECT) as HRESULT
declare sub IOleDocumentView_SetRectComplex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_Show_Proxy(byval This as IOleDocumentView ptr, byval fShow as WINBOOL) as HRESULT
declare sub IOleDocumentView_Show_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_UIActivate_Proxy(byval This as IOleDocumentView ptr, byval fUIActivate as WINBOOL) as HRESULT
declare sub IOleDocumentView_UIActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_Open_Proxy(byval This as IOleDocumentView ptr) as HRESULT
declare sub IOleDocumentView_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_CloseView_Proxy(byval This as IOleDocumentView ptr, byval dwReserved as DWORD) as HRESULT
declare sub IOleDocumentView_CloseView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_SaveViewState_Proxy(byval This as IOleDocumentView ptr, byval pstm as LPSTREAM) as HRESULT
declare sub IOleDocumentView_SaveViewState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_ApplyViewState_Proxy(byval This as IOleDocumentView ptr, byval pstm as LPSTREAM) as HRESULT
declare sub IOleDocumentView_ApplyViewState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleDocumentView_Clone_Proxy(byval This as IOleDocumentView ptr, byval pIPSiteNew as IOleInPlaceSite ptr, byval ppViewNew as IOleDocumentView ptr ptr) as HRESULT
declare sub IOleDocumentView_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPENUMOLEDOCUMENTVIEWS_DEFINED
#define __IEnumOleDocumentViews_INTERFACE_DEFINED__
type LPENUMOLEDOCUMENTVIEWS as IEnumOleDocumentViews ptr
extern IID_IEnumOleDocumentViews as const GUID

type IEnumOleDocumentViewsVtbl
	QueryInterface as function(byval This as IEnumOleDocumentViews ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumOleDocumentViews ptr) as ULONG
	Release as function(byval This as IEnumOleDocumentViews ptr) as ULONG
	Next as function(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG, byval rgpView as IOleDocumentView ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG) as HRESULT
	Reset as function(byval This as IEnumOleDocumentViews ptr) as HRESULT
	Clone as function(byval This as IEnumOleDocumentViews ptr, byval ppEnum as IEnumOleDocumentViews ptr ptr) as HRESULT
end type

type IEnumOleDocumentViews_
	lpVtbl as IEnumOleDocumentViewsVtbl ptr
end type

declare function IEnumOleDocumentViews_RemoteNext_Proxy(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG, byval rgpView as IOleDocumentView ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumOleDocumentViews_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleDocumentViews_Skip_Proxy(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG) as HRESULT
declare sub IEnumOleDocumentViews_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleDocumentViews_Reset_Proxy(byval This as IEnumOleDocumentViews ptr) as HRESULT
declare sub IEnumOleDocumentViews_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleDocumentViews_Clone_Proxy(byval This as IEnumOleDocumentViews ptr, byval ppEnum as IEnumOleDocumentViews ptr ptr) as HRESULT
declare sub IEnumOleDocumentViews_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleDocumentViews_Next_Proxy(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG, byval rgpView as IOleDocumentView ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare function IEnumOleDocumentViews_Next_Stub(byval This as IEnumOleDocumentViews ptr, byval cViews as ULONG, byval rgpView as IOleDocumentView ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
#define _LPCONTINUECALLBACK_DEFINED
#define __IContinueCallback_INTERFACE_DEFINED__
type IContinueCallback as IContinueCallback_
type LPCONTINUECALLBACK as IContinueCallback ptr
extern IID_IContinueCallback as const GUID

type IContinueCallbackVtbl
	QueryInterface as function(byval This as IContinueCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContinueCallback ptr) as ULONG
	Release as function(byval This as IContinueCallback ptr) as ULONG
	FContinue as function(byval This as IContinueCallback ptr) as HRESULT
	FContinuePrinting as function(byval This as IContinueCallback ptr, byval nCntPrinted as LONG, byval nCurPage as LONG, byval pwszPrintStatus as wstring ptr) as HRESULT
end type

type IContinueCallback_
	lpVtbl as IContinueCallbackVtbl ptr
end type

declare function IContinueCallback_FContinue_Proxy(byval This as IContinueCallback ptr) as HRESULT
declare sub IContinueCallback_FContinue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IContinueCallback_FContinuePrinting_Proxy(byval This as IContinueCallback ptr, byval nCntPrinted as LONG, byval nCurPage as LONG, byval pwszPrintStatus as wstring ptr) as HRESULT
declare sub IContinueCallback_FContinuePrinting_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPPRINT_DEFINED
#define __IPrint_INTERFACE_DEFINED__
type IPrint as IPrint_
type LPPRINT as IPrint ptr

type __WIDL_docobj_generated_name_00000014 as long
enum
	PRINTFLAG_MAYBOTHERUSER = 1
	PRINTFLAG_PROMPTUSER = 2
	PRINTFLAG_USERMAYCHANGEPRINTER = 4
	PRINTFLAG_RECOMPOSETODEVICE = 8
	PRINTFLAG_DONTACTUALLYPRINT = 16
	PRINTFLAG_FORCEPROPERTIES = 32
	PRINTFLAG_PRINTTOFILE = 64
end enum

type PRINTFLAG as __WIDL_docobj_generated_name_00000014

type tagPAGERANGE
	nFromPage as LONG
	nToPage as LONG
end type

type PAGERANGE as tagPAGERANGE

type tagPAGESET
	cbStruct as ULONG
	fOddPages as WINBOOL
	fEvenPages as WINBOOL
	cPageRange as ULONG
	rgPages(0 to 0) as PAGERANGE
end type

type PAGESET as tagPAGESET
#define PAGESET_TOLASTPAGE cast(WORD, -cast(clong, 1))
extern IID_IPrint as const GUID

type IPrintVtbl
	QueryInterface as function(byval This as IPrint ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPrint ptr) as ULONG
	Release as function(byval This as IPrint ptr) as ULONG
	SetInitialPageNum as function(byval This as IPrint ptr, byval nFirstPage as LONG) as HRESULT
	GetPageInfo as function(byval This as IPrint ptr, byval pnFirstPage as LONG ptr, byval pcPages as LONG ptr) as HRESULT
	Print as function(byval This as IPrint ptr, byval grfFlags as DWORD, byval pptd as DVTARGETDEVICE ptr ptr, byval ppPageSet as PAGESET ptr ptr, byval pstgmOptions as STGMEDIUM ptr, byval pcallback as IContinueCallback ptr, byval nFirstPage as LONG, byval pcPagesPrinted as LONG ptr, byval pnLastPage as LONG ptr) as HRESULT
end type

type IPrint_
	lpVtbl as IPrintVtbl ptr
end type

declare function IPrint_SetInitialPageNum_Proxy(byval This as IPrint ptr, byval nFirstPage as LONG) as HRESULT
declare sub IPrint_SetInitialPageNum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPrint_GetPageInfo_Proxy(byval This as IPrint ptr, byval pnFirstPage as LONG ptr, byval pcPages as LONG ptr) as HRESULT
declare sub IPrint_GetPageInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPrint_RemotePrint_Proxy(byval This as IPrint ptr, byval grfFlags as DWORD, byval pptd as DVTARGETDEVICE ptr ptr, byval pppageset as PAGESET ptr ptr, byval pstgmOptions as RemSTGMEDIUM ptr, byval pcallback as IContinueCallback ptr, byval nFirstPage as LONG, byval pcPagesPrinted as LONG ptr, byval pnLastPage as LONG ptr) as HRESULT
declare sub IPrint_RemotePrint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPrint_Print_Proxy(byval This as IPrint ptr, byval grfFlags as DWORD, byval pptd as DVTARGETDEVICE ptr ptr, byval ppPageSet as PAGESET ptr ptr, byval pstgmOptions as STGMEDIUM ptr, byval pcallback as IContinueCallback ptr, byval nFirstPage as LONG, byval pcPagesPrinted as LONG ptr, byval pnLastPage as LONG ptr) as HRESULT
declare function IPrint_Print_Stub(byval This as IPrint ptr, byval grfFlags as DWORD, byval pptd as DVTARGETDEVICE ptr ptr, byval pppageset as PAGESET ptr ptr, byval pstgmOptions as RemSTGMEDIUM ptr, byval pcallback as IContinueCallback ptr, byval nFirstPage as LONG, byval pcPagesPrinted as LONG ptr, byval pnLastPage as LONG ptr) as HRESULT
#define _LPOLECOMMANDTARGET_DEFINED
#define __IOleCommandTarget_INTERFACE_DEFINED__
type IOleCommandTarget as IOleCommandTarget_
type LPOLECOMMANDTARGET as IOleCommandTarget ptr

type OLECMDF as long
enum
	OLECMDF_SUPPORTED = &h1
	OLECMDF_ENABLED = &h2
	OLECMDF_LATCHED = &h4
	OLECMDF_NINCHED = &h8
	OLECMDF_INVISIBLE = &h10
	OLECMDF_DEFHIDEONCTXTMENU = &h20
end enum

type _tagOLECMD
	cmdID as ULONG
	cmdf as DWORD
end type

type OLECMD as _tagOLECMD

type _tagOLECMDTEXT
	cmdtextf as DWORD
	cwActual as ULONG
	cwBuf as ULONG
	rgwz as wstring * 1
end type

type OLECMDTEXT as _tagOLECMDTEXT

type OLECMDTEXTF as long
enum
	OLECMDTEXTF_NONE = 0
	OLECMDTEXTF_NAME = 1
	OLECMDTEXTF_STATUS = 2
end enum

type OLECMDEXECOPT as long
enum
	OLECMDEXECOPT_DODEFAULT = 0
	OLECMDEXECOPT_PROMPTUSER = 1
	OLECMDEXECOPT_DONTPROMPTUSER = 2
	OLECMDEXECOPT_SHOWHELP = 3
end enum

type OLECMDID as long
enum
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
	OLECMDID_ONTOOLBARACTIVATED = 31
	OLECMDID_FIND = 32
	OLECMDID_DELETE = 33
	OLECMDID_HTTPEQUIV = 34
	OLECMDID_HTTPEQUIV_DONE = 35
	OLECMDID_ENABLE_INTERACTION = 36
	OLECMDID_ONUNLOAD = 37
	OLECMDID_PROPERTYBAG2 = 38
	OLECMDID_PREREFRESH = 39
	OLECMDID_SHOWSCRIPTERROR = 40
	OLECMDID_SHOWMESSAGE = 41
	OLECMDID_SHOWFIND = 42
	OLECMDID_SHOWPAGESETUP = 43
	OLECMDID_SHOWPRINT = 44
	OLECMDID_CLOSE = 45
	OLECMDID_ALLOWUILESSSAVEAS = 46
	OLECMDID_DONTDOWNLOADCSS = 47
	OLECMDID_UPDATEPAGESTATUS = 48
	OLECMDID_PRINT2 = 49
	OLECMDID_PRINTPREVIEW2 = 50
	OLECMDID_SETPRINTTEMPLATE = 51
	OLECMDID_GETPRINTTEMPLATE = 52
	OLECMDID_PAGEACTIONBLOCKED = 55
	OLECMDID_PAGEACTIONUIQUERY = 56
	OLECMDID_FOCUSVIEWCONTROLS = 57
	OLECMDID_FOCUSVIEWCONTROLSQUERY = 58
	OLECMDID_SHOWPAGEACTIONMENU = 59
	OLECMDID_ADDTRAVELENTRY = 60
	OLECMDID_UPDATETRAVELENTRY = 61
	OLECMDID_UPDATEBACKFORWARDSTATE = 62
	OLECMDID_OPTICAL_ZOOM = 63
	OLECMDID_OPTICAL_GETZOOMRANGE = 64
	OLECMDID_WINDOWSTATECHANGED = 65
	OLECMDID_ACTIVEXINSTALLSCOPE = 66
	OLECMDID_UPDATETRAVELENTRY_DATARECOVERY = 67
	OLECMDID_SHOWTASKDLG = 68
	OLECMDID_POPSTATEEVENT = 69
	OLECMDID_VIEWPORT_MODE = 70
	OLECMDID_LAYOUT_VIEWPORT_WIDTH = 71
	OLECMDID_VISUAL_VIEWPORT_EXCLUDE_BOTTOM = 72
	OLECMDID_USER_OPTICAL_ZOOM = 73
	OLECMDID_PAGEAVAILABLE = 74
	OLECMDID_GETUSERSCALABLE = 75
	OLECMDID_UPDATE_CARET = 76
	OLECMDID_ENABLE_VISIBILITY = 77
	OLECMDID_MEDIA_PLAYBACK = 78
end enum

type MEDIAPLAYBACK_STATE as long
enum
	MEDIAPLAYBACK_RESUME = 0
	MEDIAPLAYBACK_PAUSE = 1
end enum

#define OLECMDERR_E_FIRST (OLE_E_LAST + 1)
#define OLECMDERR_E_NOTSUPPORTED OLECMDERR_E_FIRST
#define OLECMDERR_E_DISABLED (OLECMDERR_E_FIRST + 1)
#define OLECMDERR_E_NOHELP (OLECMDERR_E_FIRST + 2)
#define OLECMDERR_E_CANCELED (OLECMDERR_E_FIRST + 3)
#define OLECMDERR_E_UNKNOWNGROUP (OLECMDERR_E_FIRST + 4)
#define MSOCMDERR_E_FIRST OLECMDERR_E_FIRST
#define MSOCMDERR_E_NOTSUPPORTED OLECMDERR_E_NOTSUPPORTED
#define MSOCMDERR_E_DISABLED OLECMDERR_E_DISABLED
#define MSOCMDERR_E_NOHELP OLECMDERR_E_NOHELP
#define MSOCMDERR_E_CANCELED OLECMDERR_E_CANCELED
#define MSOCMDERR_E_UNKNOWNGROUP OLECMDERR_E_UNKNOWNGROUP
const OLECMD_TASKDLGID_ONBEFOREUNLOAD = 1

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	const OLECMDARGINDEX_SHOWPAGEACTIONMENU_HWND = 0
	const OLECMDARGINDEX_SHOWPAGEACTIONMENU_X = 1
	const OLECMDARGINDEX_SHOWPAGEACTIONMENU_Y = 2
	const OLECMDARGINDEX_ACTIVEXINSTALL_PUBLISHER = 0
	const OLECMDARGINDEX_ACTIVEXINSTALL_DISPLAYNAME = 1
	const OLECMDARGINDEX_ACTIVEXINSTALL_CLSID = 2
	const OLECMDARGINDEX_ACTIVEXINSTALL_INSTALLSCOPE = 3
	const OLECMDARGINDEX_ACTIVEXINSTALL_SOURCEURL = 4
	const INSTALL_SCOPE_INVALID = 0
	const INSTALL_SCOPE_MACHINE = 1
	const INSTALL_SCOPE_USER = 2

	type IGNOREMIME as long
	enum
		IGNOREMIME_PROMPT = &h1
		IGNOREMIME_TEXT = &h2
	end enum

	type WPCSETTING as long
	enum
		WPCSETTING_LOGGING_ENABLED = &h1
		WPCSETTING_FILEDOWNLOAD_BLOCKED = &h2
	end enum
#endif

extern IID_IOleCommandTarget as const GUID

type IOleCommandTargetVtbl
	QueryInterface as function(byval This as IOleCommandTarget ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleCommandTarget ptr) as ULONG
	Release as function(byval This as IOleCommandTarget ptr) as ULONG
	QueryStatus as function(byval This as IOleCommandTarget ptr, byval pguidCmdGroup as const GUID ptr, byval cCmds as ULONG, byval prgCmds as OLECMD ptr, byval pCmdText as OLECMDTEXT ptr) as HRESULT
	Exec as function(byval This as IOleCommandTarget ptr, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD, byval nCmdexecopt as DWORD, byval pvaIn as VARIANT ptr, byval pvaOut as VARIANT ptr) as HRESULT
end type

type IOleCommandTarget_
	lpVtbl as IOleCommandTargetVtbl ptr
end type

declare function IOleCommandTarget_QueryStatus_Proxy(byval This as IOleCommandTarget ptr, byval pguidCmdGroup as const GUID ptr, byval cCmds as ULONG, byval prgCmds as OLECMD ptr, byval pCmdText as OLECMDTEXT ptr) as HRESULT
declare sub IOleCommandTarget_QueryStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCommandTarget_Exec_Proxy(byval This as IOleCommandTarget ptr, byval pguidCmdGroup as const GUID ptr, byval nCmdID as DWORD, byval nCmdexecopt as DWORD, byval pvaIn as VARIANT ptr, byval pvaOut as VARIANT ptr) as HRESULT
declare sub IOleCommandTarget_Exec_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type OLECMDID_REFRESHFLAG as long
enum
	OLECMDIDF_REFRESH_NORMAL = 0
	OLECMDIDF_REFRESH_IFEXPIRED = 1
	OLECMDIDF_REFRESH_CONTINUE = 2
	OLECMDIDF_REFRESH_COMPLETELY = 3
	OLECMDIDF_REFRESH_NO_CACHE = 4
	OLECMDIDF_REFRESH_RELOAD = 5
	OLECMDIDF_REFRESH_LEVELMASK = &h00FF
	OLECMDIDF_REFRESH_CLEARUSERINPUT = &h1000
	OLECMDIDF_REFRESH_PROMPTIFOFFLINE = &h2000
	OLECMDIDF_REFRESH_THROUGHSCRIPT = &h4000

	#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
		OLECMDIDF_REFRESH_SKIPBEFOREUNLOADEVENT = &h8000
		OLECMDIDF_REFRESH_PAGEACTION_ACTIVEXINSTALL = &h00010000
		OLECMDIDF_REFRESH_PAGEACTION_FILEDOWNLOAD = &h00020000
		OLECMDIDF_REFRESH_PAGEACTION_LOCALMACHINE = &h00040000
		OLECMDIDF_REFRESH_PAGEACTION_POPUPWINDOW = &h00080000
		OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNLOCALMACHINE = &h00100000
		OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNTRUSTED = &h00200000
		OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTRANET = &h00400000
		OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTERNET = &h00800000
		OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNRESTRICTED = &h01000000
	#endif

	OLECMDIDF_REFRESH_PAGEACTION_MIXEDCONTENT = &h02000000
	OLECMDIDF_REFRESH_PAGEACTION_INVALID_CERT = &h04000000
end enum

type OLECMDID_PAGEACTIONFLAG as long
enum
	OLECMDIDF_PAGEACTION_FILEDOWNLOAD = &h00000001
	OLECMDIDF_PAGEACTION_ACTIVEXINSTALL = &h00000002
	OLECMDIDF_PAGEACTION_ACTIVEXTRUSTFAIL = &h00000004
	OLECMDIDF_PAGEACTION_ACTIVEXUSERDISABLE = &h00000008
	OLECMDIDF_PAGEACTION_ACTIVEXDISALLOW = &h00000010
	OLECMDIDF_PAGEACTION_ACTIVEXUNSAFE = &h00000020
	OLECMDIDF_PAGEACTION_POPUPWINDOW = &h00000040
	OLECMDIDF_PAGEACTION_LOCALMACHINE = &h00000080
	OLECMDIDF_PAGEACTION_MIMETEXTPLAIN = &h00000100
	OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE = &h00000200
	OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXINSTALL = &h00000200
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNLOCALMACHINE = &h00000400
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNTRUSTED = &h00000800
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTRANET = &h00001000
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTERNET = &h00002000
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNRESTRICTED = &h00004000
	OLECMDIDF_PAGEACTION_PROTLOCKDOWNDENY = &h00008000
	OLECMDIDF_PAGEACTION_POPUPALLOWED = &h00010000
	OLECMDIDF_PAGEACTION_SCRIPTPROMPT = &h00020000
	OLECMDIDF_PAGEACTION_ACTIVEXUSERAPPROVAL = &h00040000
	OLECMDIDF_PAGEACTION_MIXEDCONTENT = &h00080000
	OLECMDIDF_PAGEACTION_INVALID_CERT = &h00100000
	OLECMDIDF_PAGEACTION_INTRANETZONEREQUEST = &h00200000
	OLECMDIDF_PAGEACTION_XSSFILTERED = &h00400000
	OLECMDIDF_PAGEACTION_SPOOFABLEIDNHOST = &h00800000
	OLECMDIDF_PAGEACTION_ACTIVEX_EPM_INCOMPATIBLE = &h01000000
	OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXUSERAPPROVAL = &h02000000
	OLECMDIDF_PAGEACTION_WPCBLOCKED = &h04000000
	OLECMDIDF_PAGEACTION_WPCBLOCKED_ACTIVEX = &h08000000
	OLECMDIDF_PAGEACTION_EXTENSION_COMPAT_BLOCKED = &h10000000
	OLECMDIDF_PAGEACTION_NORESETACTIVEX = &h20000000
	OLECMDIDF_PAGEACTION_GENERIC_STATE = &h40000000
	OLECMDIDF_PAGEACTION_RESET = clng(&h80000000)
end enum

type OLECMDID_BROWSERSTATEFLAG as long
enum
	OLECMDIDF_BROWSERSTATE_EXTENSIONSOFF = &h00000001
	OLECMDIDF_BROWSERSTATE_IESECURITY = &h00000002
	OLECMDIDF_BROWSERSTATE_PROTECTEDMODE_OFF = &h00000004
	OLECMDIDF_BROWSERSTATE_RESET = &h00000008
	OLECMDIDF_BROWSERSTATE_REQUIRESACTIVEX = &h00000010
end enum

type OLECMDID_OPTICAL_ZOOMFLAG as long
enum
	OLECMDIDF_OPTICAL_ZOOM_NOPERSIST = &h00000001
	OLECMDIDF_OPTICAL_ZOOM_NOLAYOUT = &h00000010
end enum

type PAGEACTION_UI as long
enum
	PAGEACTION_UI_DEFAULT = 0
	PAGEACTION_UI_MODAL = 1
	PAGEACTION_UI_MODELESS = 2
	PAGEACTION_UI_SILENT = 3
end enum

type OLECMDID_WINDOWSTATE_FLAG as long
enum
	OLECMDIDF_WINDOWSTATE_USERVISIBLE = &h00000001
	OLECMDIDF_WINDOWSTATE_ENABLED = &h00000002
	OLECMDIDF_WINDOWSTATE_USERVISIBLE_VALID = &h00010000
	OLECMDIDF_WINDOWSTATE_ENABLED_VALID = &h00020000
end enum

type OLECMDID_VIEWPORT_MODE_FLAG as long
enum
	OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH = &h00000001
	OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM = &h00000002
	OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH_VALID = &h00010000
	OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM_VALID = &h00020000
end enum

#define IMsoDocument IOleDocument
#define IMsoDocumentSite IOleDocumentSite
#define IMsoView IOleDocumentView
#define IEnumMsoView IEnumOleDocumentViews
#define IMsoCommandTarget IOleCommandTarget
#define LPMSODOCUMENT LPOLEDOCUMENT
#define LPMSODOCUMENTSITE LPOLEDOCUMENTSITE
#define LPMSOVIEW LPOLEDOCUMENTVIEW
#define LPENUMMSOVIEW LPENUMOLEDOCUMENTVIEWS
#define LPMSOCOMMANDTARGET LPOLECOMMANDTARGET
#define MSOCMD OLECMD
#define MSOCMDTEXT OLECMDTEXT
#define IID_IMsoDocument IID_IOleDocument
#define IID_IMsoDocumentSite IID_IOleDocumentSite
#define IID_IMsoView IID_IOleDocumentView
#define IID_IEnumMsoView IID_IEnumOleDocumentViews
#define IID_IMsoCommandTarget IID_IOleCommandTarget
#define MSOCMDF_SUPPORTED OLECMDF_SUPPORTED
#define MSOCMDF_ENABLED OLECMDF_ENABLED
#define MSOCMDF_LATCHED OLECMDF_LATCHED
#define MSOCMDF_NINCHED OLECMDF_NINCHED
#define MSOCMDTEXTF_NONE OLECMDTEXTF_NONE
#define MSOCMDTEXTF_NAME OLECMDTEXTF_NAME
#define MSOCMDTEXTF_STATUS OLECMDTEXTF_STATUS
#define MSOCMDEXECOPT_DODEFAULT OLECMDEXECOPT_DODEFAULT
#define MSOCMDEXECOPT_PROMPTUSER OLECMDEXECOPT_PROMPTUSER
#define MSOCMDEXECOPT_DONTPROMPTUSER OLECMDEXECOPT_DONTPROMPTUSER
#define MSOCMDEXECOPT_SHOWHELP OLECMDEXECOPT_SHOWHELP
#define MSOCMDID_OPEN OLECMDID_OPEN
#define MSOCMDID_NEW OLECMDID_NEW
#define MSOCMDID_SAVE OLECMDID_SAVE
#define MSOCMDID_SAVEAS OLECMDID_SAVEAS
#define MSOCMDID_SAVECOPYAS OLECMDID_SAVECOPYAS
#define MSOCMDID_PRINT OLECMDID_PRINT
#define MSOCMDID_PRINTPREVIEW OLECMDID_PRINTPREVIEW
#define MSOCMDID_PAGESETUP OLECMDID_PAGESETUP
#define MSOCMDID_SPELL OLECMDID_SPELL
#define MSOCMDID_PROPERTIES OLECMDID_PROPERTIES
#define MSOCMDID_CUT OLECMDID_CUT
#define MSOCMDID_COPY OLECMDID_COPY
#define MSOCMDID_PASTE OLECMDID_PASTE
#define MSOCMDID_PASTESPECIAL OLECMDID_PASTESPECIAL
#define MSOCMDID_UNDO OLECMDID_UNDO
#define MSOCMDID_REDO OLECMDID_REDO
#define MSOCMDID_SELECTALL OLECMDID_SELECTALL
#define MSOCMDID_CLEARSELECTION OLECMDID_CLEARSELECTION
#define MSOCMDID_ZOOM OLECMDID_ZOOM
#define MSOCMDID_GETZOOMRANGE OLECMDID_GETZOOMRANGE
extern SID_SContainerDispatch as const GUID
#define __IZoomEvents_INTERFACE_DEFINED__
extern IID_IZoomEvents as const GUID
type IZoomEvents as IZoomEvents_

type IZoomEventsVtbl
	QueryInterface as function(byval This as IZoomEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IZoomEvents ptr) as ULONG
	Release as function(byval This as IZoomEvents ptr) as ULONG
	OnZoomPercentChanged as function(byval This as IZoomEvents ptr, byval ulZoomPercent as ULONG) as HRESULT
end type

type IZoomEvents_
	lpVtbl as IZoomEventsVtbl ptr
end type

declare function IZoomEvents_OnZoomPercentChanged_Proxy(byval This as IZoomEvents ptr, byval ulZoomPercent as ULONG) as HRESULT
declare sub IZoomEvents_OnZoomPercentChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IProtectFocus_INTERFACE_DEFINED__
extern IID_IProtectFocus as const GUID
type IProtectFocus as IProtectFocus_

type IProtectFocusVtbl
	QueryInterface as function(byval This as IProtectFocus ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProtectFocus ptr) as ULONG
	Release as function(byval This as IProtectFocus ptr) as ULONG
	AllowFocusChange as function(byval This as IProtectFocus ptr, byval pfAllow as WINBOOL ptr) as HRESULT
end type

type IProtectFocus_
	lpVtbl as IProtectFocusVtbl ptr
end type

declare function IProtectFocus_AllowFocusChange_Proxy(byval This as IProtectFocus ptr, byval pfAllow as WINBOOL ptr) as HRESULT
declare sub IProtectFocus_AllowFocusChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define SID_SProtectFocus IID_IProtectFocus
#define _LPPROTECTEDMODEMENUSERVICES_DEFINED
#define __IProtectedModeMenuServices_INTERFACE_DEFINED__
extern IID_IProtectedModeMenuServices as const GUID
type IProtectedModeMenuServices as IProtectedModeMenuServices_

type IProtectedModeMenuServicesVtbl
	QueryInterface as function(byval This as IProtectedModeMenuServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProtectedModeMenuServices ptr) as ULONG
	Release as function(byval This as IProtectedModeMenuServices ptr) as ULONG
	CreateMenu as function(byval This as IProtectedModeMenuServices ptr, byval phMenu as HMENU ptr) as HRESULT
	LoadMenu as function(byval This as IProtectedModeMenuServices ptr, byval pszModuleName as LPCWSTR, byval pszMenuName as LPCWSTR, byval phMenu as HMENU ptr) as HRESULT
	LoadMenuID as function(byval This as IProtectedModeMenuServices ptr, byval pszModuleName as LPCWSTR, byval wResourceID as WORD, byval phMenu as HMENU ptr) as HRESULT
end type

type IProtectedModeMenuServices_
	lpVtbl as IProtectedModeMenuServicesVtbl ptr
end type

declare function IProtectedModeMenuServices_CreateMenu_Proxy(byval This as IProtectedModeMenuServices ptr, byval phMenu as HMENU ptr) as HRESULT
declare sub IProtectedModeMenuServices_CreateMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IProtectedModeMenuServices_LoadMenu_Proxy(byval This as IProtectedModeMenuServices ptr, byval pszModuleName as LPCWSTR, byval pszMenuName as LPCWSTR, byval phMenu as HMENU ptr) as HRESULT
declare sub IProtectedModeMenuServices_LoadMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IProtectedModeMenuServices_LoadMenuID_Proxy(byval This as IProtectedModeMenuServices ptr, byval pszModuleName as LPCWSTR, byval wResourceID as WORD, byval phMenu as HMENU ptr) as HRESULT
declare sub IProtectedModeMenuServices_LoadMenuID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern

#include once "ole-common.bi"
