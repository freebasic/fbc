#pragma once

#inclib "uuid"

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __oleidl_h__
#define __IOleAdviseHolder_FWD_DEFINED__
#define __IOleCache_FWD_DEFINED__
#define __IOleCache2_FWD_DEFINED__
#define __IOleCacheControl_FWD_DEFINED__
#define __IParseDisplayName_FWD_DEFINED__
#define __IOleContainer_FWD_DEFINED__
#define __IOleClientSite_FWD_DEFINED__
#define __IOleObject_FWD_DEFINED__
#define __IOleWindow_FWD_DEFINED__
#define __IOleLink_FWD_DEFINED__
#define __IOleItemContainer_FWD_DEFINED__
#define __IOleInPlaceUIWindow_FWD_DEFINED__
#define __IOleInPlaceActiveObject_FWD_DEFINED__
#define __IOleInPlaceFrame_FWD_DEFINED__
#define __IOleInPlaceObject_FWD_DEFINED__
#define __IOleInPlaceSite_FWD_DEFINED__
#define __IContinue_FWD_DEFINED__
#define __IViewObject_FWD_DEFINED__
#define __IViewObject2_FWD_DEFINED__
#define __IDropSource_FWD_DEFINED__
#define __IDropTarget_FWD_DEFINED__
#define __IDropSourceNotify_FWD_DEFINED__
#define __IEnumOLEVERB_FWD_DEFINED__
#define __IOleAdviseHolder_INTERFACE_DEFINED__
type IOleAdviseHolder as IOleAdviseHolder_
type LPOLEADVISEHOLDER as IOleAdviseHolder ptr
extern IID_IOleAdviseHolder as const GUID

type IOleAdviseHolderVtbl
	QueryInterface as function(byval This as IOleAdviseHolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleAdviseHolder ptr) as ULONG
	Release as function(byval This as IOleAdviseHolder ptr) as ULONG
	Advise as function(byval This as IOleAdviseHolder ptr, byval pAdvise as IAdviseSink ptr, byval pdwConnection as DWORD ptr) as HRESULT
	Unadvise as function(byval This as IOleAdviseHolder ptr, byval dwConnection as DWORD) as HRESULT
	EnumAdvise as function(byval This as IOleAdviseHolder ptr, byval ppenumAdvise as IEnumSTATDATA ptr ptr) as HRESULT
	SendOnRename as function(byval This as IOleAdviseHolder ptr, byval pmk as IMoniker ptr) as HRESULT
	SendOnSave as function(byval This as IOleAdviseHolder ptr) as HRESULT
	SendOnClose as function(byval This as IOleAdviseHolder ptr) as HRESULT
end type

type IOleAdviseHolder_
	lpVtbl as IOleAdviseHolderVtbl ptr
end type

declare function IOleAdviseHolder_Advise_Proxy(byval This as IOleAdviseHolder ptr, byval pAdvise as IAdviseSink ptr, byval pdwConnection as DWORD ptr) as HRESULT
declare sub IOleAdviseHolder_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleAdviseHolder_Unadvise_Proxy(byval This as IOleAdviseHolder ptr, byval dwConnection as DWORD) as HRESULT
declare sub IOleAdviseHolder_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleAdviseHolder_EnumAdvise_Proxy(byval This as IOleAdviseHolder ptr, byval ppenumAdvise as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IOleAdviseHolder_EnumAdvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleAdviseHolder_SendOnRename_Proxy(byval This as IOleAdviseHolder ptr, byval pmk as IMoniker ptr) as HRESULT
declare sub IOleAdviseHolder_SendOnRename_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleAdviseHolder_SendOnSave_Proxy(byval This as IOleAdviseHolder ptr) as HRESULT
declare sub IOleAdviseHolder_SendOnSave_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleAdviseHolder_SendOnClose_Proxy(byval This as IOleAdviseHolder ptr) as HRESULT
declare sub IOleAdviseHolder_SendOnClose_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleCache_INTERFACE_DEFINED__
type IOleCache as IOleCache_
type LPOLECACHE as IOleCache ptr
extern IID_IOleCache as const GUID

type IOleCacheVtbl
	QueryInterface as function(byval This as IOleCache ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleCache ptr) as ULONG
	Release as function(byval This as IOleCache ptr) as ULONG
	Cache as function(byval This as IOleCache ptr, byval pformatetc as FORMATETC ptr, byval advf as DWORD, byval pdwConnection as DWORD ptr) as HRESULT
	Uncache as function(byval This as IOleCache ptr, byval dwConnection as DWORD) as HRESULT
	EnumCache as function(byval This as IOleCache ptr, byval ppenumSTATDATA as IEnumSTATDATA ptr ptr) as HRESULT
	InitCache as function(byval This as IOleCache ptr, byval pDataObject as IDataObject ptr) as HRESULT
	SetData as function(byval This as IOleCache ptr, byval pformatetc as FORMATETC ptr, byval pmedium as STGMEDIUM ptr, byval fRelease as WINBOOL) as HRESULT
end type

type IOleCache_
	lpVtbl as IOleCacheVtbl ptr
end type

declare function IOleCache_Cache_Proxy(byval This as IOleCache ptr, byval pformatetc as FORMATETC ptr, byval advf as DWORD, byval pdwConnection as DWORD ptr) as HRESULT
declare sub IOleCache_Cache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache_Uncache_Proxy(byval This as IOleCache ptr, byval dwConnection as DWORD) as HRESULT
declare sub IOleCache_Uncache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache_EnumCache_Proxy(byval This as IOleCache ptr, byval ppenumSTATDATA as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IOleCache_EnumCache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache_InitCache_Proxy(byval This as IOleCache ptr, byval pDataObject as IDataObject ptr) as HRESULT
declare sub IOleCache_InitCache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache_SetData_Proxy(byval This as IOleCache ptr, byval pformatetc as FORMATETC ptr, byval pmedium as STGMEDIUM ptr, byval fRelease as WINBOOL) as HRESULT
declare sub IOleCache_SetData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleCache2_INTERFACE_DEFINED__
type IOleCache2 as IOleCache2_
type LPOLECACHE2 as IOleCache2 ptr

#define UPDFCACHE_NODATACACHE &h1
#define UPDFCACHE_ONSAVECACHE &h2
#define UPDFCACHE_ONSTOPCACHE &h4
#define UPDFCACHE_NORMALCACHE &h8
#define UPDFCACHE_IFBLANK &h10
#define UPDFCACHE_ONLYIFBLANK &h80000000
#define UPDFCACHE_IFBLANKORONSAVECACHE (UPDFCACHE_IFBLANK or UPDFCACHE_ONSAVECACHE)
#define UPDFCACHE_ALL cast(DWORD, not UPDFCACHE_ONLYIFBLANK)
#define UPDFCACHE_ALLBUTNODATACACHE (UPDFCACHE_ALL and cast(DWORD, not UPDFCACHE_NODATACACHE))

type tagDISCARDCACHE as long
enum
	DISCARDCACHE_SAVEIFDIRTY = 0
	DISCARDCACHE_NOSAVE = 1
end enum

type DISCARDCACHE as tagDISCARDCACHE
extern IID_IOleCache2 as const GUID

type IOleCache2Vtbl
	QueryInterface as function(byval This as IOleCache2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleCache2 ptr) as ULONG
	Release as function(byval This as IOleCache2 ptr) as ULONG
	Cache as function(byval This as IOleCache2 ptr, byval pformatetc as FORMATETC ptr, byval advf as DWORD, byval pdwConnection as DWORD ptr) as HRESULT
	Uncache as function(byval This as IOleCache2 ptr, byval dwConnection as DWORD) as HRESULT
	EnumCache as function(byval This as IOleCache2 ptr, byval ppenumSTATDATA as IEnumSTATDATA ptr ptr) as HRESULT
	InitCache as function(byval This as IOleCache2 ptr, byval pDataObject as IDataObject ptr) as HRESULT
	SetData as function(byval This as IOleCache2 ptr, byval pformatetc as FORMATETC ptr, byval pmedium as STGMEDIUM ptr, byval fRelease as WINBOOL) as HRESULT
	UpdateCache as function(byval This as IOleCache2 ptr, byval pDataObject as LPDATAOBJECT, byval grfUpdf as DWORD, byval pReserved as LPVOID) as HRESULT
	DiscardCache as function(byval This as IOleCache2 ptr, byval dwDiscardOptions as DWORD) as HRESULT
end type

type IOleCache2_
	lpVtbl as IOleCache2Vtbl ptr
end type

declare function IOleCache2_RemoteUpdateCache_Proxy(byval This as IOleCache2 ptr, byval pDataObject as LPDATAOBJECT, byval grfUpdf as DWORD, byval pReserved as LONG_PTR) as HRESULT
declare sub IOleCache2_RemoteUpdateCache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache2_DiscardCache_Proxy(byval This as IOleCache2 ptr, byval dwDiscardOptions as DWORD) as HRESULT
declare sub IOleCache2_DiscardCache_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCache2_UpdateCache_Proxy(byval This as IOleCache2 ptr, byval pDataObject as LPDATAOBJECT, byval grfUpdf as DWORD, byval pReserved as LPVOID) as HRESULT
declare function IOleCache2_UpdateCache_Stub(byval This as IOleCache2 ptr, byval pDataObject as LPDATAOBJECT, byval grfUpdf as DWORD, byval pReserved as LONG_PTR) as HRESULT
#define __IOleCacheControl_INTERFACE_DEFINED__
type IOleCacheControl as IOleCacheControl_
type LPOLECACHECONTROL as IOleCacheControl ptr
extern IID_IOleCacheControl as const GUID

type IOleCacheControlVtbl
	QueryInterface as function(byval This as IOleCacheControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleCacheControl ptr) as ULONG
	Release as function(byval This as IOleCacheControl ptr) as ULONG
	OnRun as function(byval This as IOleCacheControl ptr, byval pDataObject as LPDATAOBJECT) as HRESULT
	OnStop as function(byval This as IOleCacheControl ptr) as HRESULT
end type

type IOleCacheControl_
	lpVtbl as IOleCacheControlVtbl ptr
end type

declare function IOleCacheControl_OnRun_Proxy(byval This as IOleCacheControl ptr, byval pDataObject as LPDATAOBJECT) as HRESULT
declare sub IOleCacheControl_OnRun_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleCacheControl_OnStop_Proxy(byval This as IOleCacheControl ptr) as HRESULT
declare sub IOleCacheControl_OnStop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IParseDisplayName_INTERFACE_DEFINED__
type IParseDisplayName as IParseDisplayName_
type LPPARSEDISPLAYNAME as IParseDisplayName ptr
extern IID_IParseDisplayName as const GUID

type IParseDisplayNameVtbl
	QueryInterface as function(byval This as IParseDisplayName ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IParseDisplayName ptr) as ULONG
	Release as function(byval This as IParseDisplayName ptr) as ULONG
	ParseDisplayName as function(byval This as IParseDisplayName ptr, byval pbc as IBindCtx ptr, byval pszDisplayName as LPOLESTR, byval pchEaten as ULONG ptr, byval ppmkOut as IMoniker ptr ptr) as HRESULT
end type

type IParseDisplayName_
	lpVtbl as IParseDisplayNameVtbl ptr
end type

declare function IParseDisplayName_ParseDisplayName_Proxy(byval This as IParseDisplayName ptr, byval pbc as IBindCtx ptr, byval pszDisplayName as LPOLESTR, byval pchEaten as ULONG ptr, byval ppmkOut as IMoniker ptr ptr) as HRESULT
declare sub IParseDisplayName_ParseDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleContainer_INTERFACE_DEFINED__
type IOleContainer as IOleContainer_
type LPOLECONTAINER as IOleContainer ptr
extern IID_IOleContainer as const GUID

type IOleContainerVtbl
	QueryInterface as function(byval This as IOleContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleContainer ptr) as ULONG
	Release as function(byval This as IOleContainer ptr) as ULONG
	ParseDisplayName as function(byval This as IOleContainer ptr, byval pbc as IBindCtx ptr, byval pszDisplayName as LPOLESTR, byval pchEaten as ULONG ptr, byval ppmkOut as IMoniker ptr ptr) as HRESULT
	EnumObjects as function(byval This as IOleContainer ptr, byval grfFlags as DWORD, byval ppenum as IEnumUnknown ptr ptr) as HRESULT
	LockContainer as function(byval This as IOleContainer ptr, byval fLock as WINBOOL) as HRESULT
end type

type IOleContainer_
	lpVtbl as IOleContainerVtbl ptr
end type

declare function IOleContainer_EnumObjects_Proxy(byval This as IOleContainer ptr, byval grfFlags as DWORD, byval ppenum as IEnumUnknown ptr ptr) as HRESULT
declare sub IOleContainer_EnumObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleContainer_LockContainer_Proxy(byval This as IOleContainer ptr, byval fLock as WINBOOL) as HRESULT
declare sub IOleContainer_LockContainer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleClientSite_INTERFACE_DEFINED__
type IOleClientSite as IOleClientSite_
type LPOLECLIENTSITE as IOleClientSite ptr
extern IID_IOleClientSite as const GUID

type IOleClientSiteVtbl
	QueryInterface as function(byval This as IOleClientSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleClientSite ptr) as ULONG
	Release as function(byval This as IOleClientSite ptr) as ULONG
	SaveObject as function(byval This as IOleClientSite ptr) as HRESULT
	GetMoniker as function(byval This as IOleClientSite ptr, byval dwAssign as DWORD, byval dwWhichMoniker as DWORD, byval ppmk as IMoniker ptr ptr) as HRESULT
	GetContainer as function(byval This as IOleClientSite ptr, byval ppContainer as IOleContainer ptr ptr) as HRESULT
	ShowObject as function(byval This as IOleClientSite ptr) as HRESULT
	OnShowWindow as function(byval This as IOleClientSite ptr, byval fShow as WINBOOL) as HRESULT
	RequestNewObjectLayout as function(byval This as IOleClientSite ptr) as HRESULT
end type

type IOleClientSite_
	lpVtbl as IOleClientSiteVtbl ptr
end type

declare function IOleClientSite_SaveObject_Proxy(byval This as IOleClientSite ptr) as HRESULT
declare sub IOleClientSite_SaveObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleClientSite_GetMoniker_Proxy(byval This as IOleClientSite ptr, byval dwAssign as DWORD, byval dwWhichMoniker as DWORD, byval ppmk as IMoniker ptr ptr) as HRESULT
declare sub IOleClientSite_GetMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleClientSite_GetContainer_Proxy(byval This as IOleClientSite ptr, byval ppContainer as IOleContainer ptr ptr) as HRESULT
declare sub IOleClientSite_GetContainer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleClientSite_ShowObject_Proxy(byval This as IOleClientSite ptr) as HRESULT
declare sub IOleClientSite_ShowObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleClientSite_OnShowWindow_Proxy(byval This as IOleClientSite ptr, byval fShow as WINBOOL) as HRESULT
declare sub IOleClientSite_OnShowWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleClientSite_RequestNewObjectLayout_Proxy(byval This as IOleClientSite ptr) as HRESULT
declare sub IOleClientSite_RequestNewObjectLayout_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleObject_INTERFACE_DEFINED__
type IOleObject as IOleObject_
type LPOLEOBJECT as IOleObject ptr

type tagOLEGETMONIKER as long
enum
	OLEGETMONIKER_ONLYIFTHERE = 1
	OLEGETMONIKER_FORCEASSIGN = 2
	OLEGETMONIKER_UNASSIGN = 3
	OLEGETMONIKER_TEMPFORUSER = 4
end enum

type OLEGETMONIKER as tagOLEGETMONIKER

type tagOLEWHICHMK as long
enum
	OLEWHICHMK_CONTAINER = 1
	OLEWHICHMK_OBJREL = 2
	OLEWHICHMK_OBJFULL = 3
end enum

type OLEWHICHMK as tagOLEWHICHMK

type tagUSERCLASSTYPE as long
enum
	USERCLASSTYPE_FULL = 1
	USERCLASSTYPE_SHORT = 2
	USERCLASSTYPE_APPNAME = 3
end enum

type USERCLASSTYPE as tagUSERCLASSTYPE

type tagOLEMISC as long
enum
	OLEMISC_RECOMPOSEONRESIZE = &h1
	OLEMISC_ONLYICONIC = &h2
	OLEMISC_INSERTNOTREPLACE = &h4
	OLEMISC_STATIC = &h8
	OLEMISC_CANTLINKINSIDE = &h10
	OLEMISC_CANLINKBYOLE1 = &h20
	OLEMISC_ISLINKOBJECT = &h40
	OLEMISC_INSIDEOUT = &h80
	OLEMISC_ACTIVATEWHENVISIBLE = &h100
	OLEMISC_RENDERINGISDEVICEINDEPENDENT = &h200
	OLEMISC_INVISIBLEATRUNTIME = &h400
	OLEMISC_ALWAYSRUN = &h800
	OLEMISC_ACTSLIKEBUTTON = &h1000
	OLEMISC_ACTSLIKELABEL = &h2000
	OLEMISC_NOUIACTIVATE = &h4000
	OLEMISC_ALIGNABLE = &h8000
	OLEMISC_SIMPLEFRAME = &h10000
	OLEMISC_SETCLIENTSITEFIRST = &h20000
	OLEMISC_IMEMODE = &h40000
	OLEMISC_IGNOREACTIVATEWHENVISIBLE = &h80000
	OLEMISC_WANTSTOMENUMERGE = &h100000
	OLEMISC_SUPPORTSMULTILEVELUNDO = &h200000
end enum

type OLEMISC as tagOLEMISC

type tagOLECLOSE as long
enum
	OLECLOSE_SAVEIFDIRTY = 0
	OLECLOSE_NOSAVE = 1
	OLECLOSE_PROMPTSAVE = 2
end enum

type OLECLOSE as tagOLECLOSE
extern IID_IOleObject as const GUID
type IEnumOLEVERB as IEnumOLEVERB_

type IOleObjectVtbl
	QueryInterface as function(byval This as IOleObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleObject ptr) as ULONG
	Release as function(byval This as IOleObject ptr) as ULONG
	SetClientSite as function(byval This as IOleObject ptr, byval pClientSite as IOleClientSite ptr) as HRESULT
	GetClientSite as function(byval This as IOleObject ptr, byval ppClientSite as IOleClientSite ptr ptr) as HRESULT
	SetHostNames as function(byval This as IOleObject ptr, byval szContainerApp as LPCOLESTR, byval szContainerObj as LPCOLESTR) as HRESULT
	Close as function(byval This as IOleObject ptr, byval dwSaveOption as DWORD) as HRESULT
	SetMoniker as function(byval This as IOleObject ptr, byval dwWhichMoniker as DWORD, byval pmk as IMoniker ptr) as HRESULT
	GetMoniker as function(byval This as IOleObject ptr, byval dwAssign as DWORD, byval dwWhichMoniker as DWORD, byval ppmk as IMoniker ptr ptr) as HRESULT
	InitFromData as function(byval This as IOleObject ptr, byval pDataObject as IDataObject ptr, byval fCreation as WINBOOL, byval dwReserved as DWORD) as HRESULT
	GetClipboardData as function(byval This as IOleObject ptr, byval dwReserved as DWORD, byval ppDataObject as IDataObject ptr ptr) as HRESULT
	DoVerb as function(byval This as IOleObject ptr, byval iVerb as LONG, byval lpmsg as LPMSG, byval pActiveSite as IOleClientSite ptr, byval lindex as LONG, byval hwndParent as HWND, byval lprcPosRect as LPCRECT) as HRESULT
	EnumVerbs as function(byval This as IOleObject ptr, byval ppEnumOleVerb as IEnumOLEVERB ptr ptr) as HRESULT
	Update as function(byval This as IOleObject ptr) as HRESULT
	IsUpToDate as function(byval This as IOleObject ptr) as HRESULT
	GetUserClassID as function(byval This as IOleObject ptr, byval pClsid as CLSID ptr) as HRESULT
	GetUserType as function(byval This as IOleObject ptr, byval dwFormOfType as DWORD, byval pszUserType as LPOLESTR ptr) as HRESULT
	SetExtent as function(byval This as IOleObject ptr, byval dwDrawAspect as DWORD, byval psizel as SIZEL ptr) as HRESULT
	GetExtent as function(byval This as IOleObject ptr, byval dwDrawAspect as DWORD, byval psizel as SIZEL ptr) as HRESULT
	Advise as function(byval This as IOleObject ptr, byval pAdvSink as IAdviseSink ptr, byval pdwConnection as DWORD ptr) as HRESULT
	Unadvise as function(byval This as IOleObject ptr, byval dwConnection as DWORD) as HRESULT
	EnumAdvise as function(byval This as IOleObject ptr, byval ppenumAdvise as IEnumSTATDATA ptr ptr) as HRESULT
	GetMiscStatus as function(byval This as IOleObject ptr, byval dwAspect as DWORD, byval pdwStatus as DWORD ptr) as HRESULT
	SetColorScheme as function(byval This as IOleObject ptr, byval pLogpal as LOGPALETTE ptr) as HRESULT
end type

type IOleObject_
	lpVtbl as IOleObjectVtbl ptr
end type

declare function IOleObject_SetClientSite_Proxy(byval This as IOleObject ptr, byval pClientSite as IOleClientSite ptr) as HRESULT
declare sub IOleObject_SetClientSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetClientSite_Proxy(byval This as IOleObject ptr, byval ppClientSite as IOleClientSite ptr ptr) as HRESULT
declare sub IOleObject_GetClientSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_SetHostNames_Proxy(byval This as IOleObject ptr, byval szContainerApp as LPCOLESTR, byval szContainerObj as LPCOLESTR) as HRESULT
declare sub IOleObject_SetHostNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_Close_Proxy(byval This as IOleObject ptr, byval dwSaveOption as DWORD) as HRESULT
declare sub IOleObject_Close_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_SetMoniker_Proxy(byval This as IOleObject ptr, byval dwWhichMoniker as DWORD, byval pmk as IMoniker ptr) as HRESULT
declare sub IOleObject_SetMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetMoniker_Proxy(byval This as IOleObject ptr, byval dwAssign as DWORD, byval dwWhichMoniker as DWORD, byval ppmk as IMoniker ptr ptr) as HRESULT
declare sub IOleObject_GetMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_InitFromData_Proxy(byval This as IOleObject ptr, byval pDataObject as IDataObject ptr, byval fCreation as WINBOOL, byval dwReserved as DWORD) as HRESULT
declare sub IOleObject_InitFromData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetClipboardData_Proxy(byval This as IOleObject ptr, byval dwReserved as DWORD, byval ppDataObject as IDataObject ptr ptr) as HRESULT
declare sub IOleObject_GetClipboardData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_DoVerb_Proxy(byval This as IOleObject ptr, byval iVerb as LONG, byval lpmsg as LPMSG, byval pActiveSite as IOleClientSite ptr, byval lindex as LONG, byval hwndParent as HWND, byval lprcPosRect as LPCRECT) as HRESULT
declare sub IOleObject_DoVerb_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_EnumVerbs_Proxy(byval This as IOleObject ptr, byval ppEnumOleVerb as IEnumOLEVERB ptr ptr) as HRESULT
declare sub IOleObject_EnumVerbs_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_Update_Proxy(byval This as IOleObject ptr) as HRESULT
declare sub IOleObject_Update_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_IsUpToDate_Proxy(byval This as IOleObject ptr) as HRESULT
declare sub IOleObject_IsUpToDate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetUserClassID_Proxy(byval This as IOleObject ptr, byval pClsid as CLSID ptr) as HRESULT
declare sub IOleObject_GetUserClassID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetUserType_Proxy(byval This as IOleObject ptr, byval dwFormOfType as DWORD, byval pszUserType as LPOLESTR ptr) as HRESULT
declare sub IOleObject_GetUserType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_SetExtent_Proxy(byval This as IOleObject ptr, byval dwDrawAspect as DWORD, byval psizel as SIZEL ptr) as HRESULT
declare sub IOleObject_SetExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetExtent_Proxy(byval This as IOleObject ptr, byval dwDrawAspect as DWORD, byval psizel as SIZEL ptr) as HRESULT
declare sub IOleObject_GetExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_Advise_Proxy(byval This as IOleObject ptr, byval pAdvSink as IAdviseSink ptr, byval pdwConnection as DWORD ptr) as HRESULT
declare sub IOleObject_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_Unadvise_Proxy(byval This as IOleObject ptr, byval dwConnection as DWORD) as HRESULT
declare sub IOleObject_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_EnumAdvise_Proxy(byval This as IOleObject ptr, byval ppenumAdvise as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IOleObject_EnumAdvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_GetMiscStatus_Proxy(byval This as IOleObject ptr, byval dwAspect as DWORD, byval pdwStatus as DWORD ptr) as HRESULT
declare sub IOleObject_GetMiscStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleObject_SetColorScheme_Proxy(byval This as IOleObject ptr, byval pLogpal as LOGPALETTE ptr) as HRESULT
declare sub IOleObject_SetColorScheme_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOLETypes_INTERFACE_DEFINED__
extern IOLETypes_v0_0_c_ifspec as RPC_IF_HANDLE
extern IOLETypes_v0_0_s_ifspec as RPC_IF_HANDLE

type tagOLERENDER as long
enum
	OLERENDER_NONE = 0
	OLERENDER_DRAW = 1
	OLERENDER_FORMAT = 2
	OLERENDER_ASIS = 3
end enum

type OLERENDER as tagOLERENDER
type LPOLERENDER as OLERENDER ptr

type tagOBJECTDESCRIPTOR
	cbSize as ULONG
	clsid as CLSID
	dwDrawAspect as DWORD
	sizel as SIZEL
	pointl as POINTL
	dwStatus as DWORD
	dwFullUserTypeName as DWORD
	dwSrcOfCopy as DWORD
end type

type OBJECTDESCRIPTOR as tagOBJECTDESCRIPTOR
type POBJECTDESCRIPTOR as tagOBJECTDESCRIPTOR ptr
type LPOBJECTDESCRIPTOR as tagOBJECTDESCRIPTOR ptr
type LINKSRCDESCRIPTOR as tagOBJECTDESCRIPTOR
type PLINKSRCDESCRIPTOR as tagOBJECTDESCRIPTOR ptr
type LPLINKSRCDESCRIPTOR as tagOBJECTDESCRIPTOR ptr
#define __IOleWindow_INTERFACE_DEFINED__
type IOleWindow as IOleWindow_
type LPOLEWINDOW as IOleWindow ptr
extern IID_IOleWindow as const GUID

type IOleWindowVtbl
	QueryInterface as function(byval This as IOleWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleWindow ptr) as ULONG
	Release as function(byval This as IOleWindow ptr) as ULONG
	GetWindow as function(byval This as IOleWindow ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleWindow ptr, byval fEnterMode as WINBOOL) as HRESULT
end type

type IOleWindow_
	lpVtbl as IOleWindowVtbl ptr
end type

declare function IOleWindow_GetWindow_Proxy(byval This as IOleWindow ptr, byval phwnd as HWND ptr) as HRESULT
declare sub IOleWindow_GetWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleWindow_ContextSensitiveHelp_Proxy(byval This as IOleWindow ptr, byval fEnterMode as WINBOOL) as HRESULT
declare sub IOleWindow_ContextSensitiveHelp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleLink_INTERFACE_DEFINED__
type IOleLink as IOleLink_
type LPOLELINK as IOleLink ptr

type tagOLEUPDATE as long
enum
	OLEUPDATE_ALWAYS = 1
	OLEUPDATE_ONCALL = 3
end enum

type OLEUPDATE as tagOLEUPDATE
type LPOLEUPDATE as OLEUPDATE ptr
type POLEUPDATE as OLEUPDATE ptr

type tagOLELINKBIND as long
enum
	OLELINKBIND_EVENIFCLASSDIFF = 1
end enum

type OLELINKBIND as tagOLELINKBIND
extern IID_IOleLink as const GUID

type IOleLinkVtbl
	QueryInterface as function(byval This as IOleLink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleLink ptr) as ULONG
	Release as function(byval This as IOleLink ptr) as ULONG
	SetUpdateOptions as function(byval This as IOleLink ptr, byval dwUpdateOpt as DWORD) as HRESULT
	GetUpdateOptions as function(byval This as IOleLink ptr, byval pdwUpdateOpt as DWORD ptr) as HRESULT
	SetSourceMoniker as function(byval This as IOleLink ptr, byval pmk as IMoniker ptr, byval rclsid as const IID const ptr) as HRESULT
	GetSourceMoniker as function(byval This as IOleLink ptr, byval ppmk as IMoniker ptr ptr) as HRESULT
	SetSourceDisplayName as function(byval This as IOleLink ptr, byval pszStatusText as LPCOLESTR) as HRESULT
	GetSourceDisplayName as function(byval This as IOleLink ptr, byval ppszDisplayName as LPOLESTR ptr) as HRESULT
	BindToSource as function(byval This as IOleLink ptr, byval bindflags as DWORD, byval pbc as IBindCtx ptr) as HRESULT
	BindIfRunning as function(byval This as IOleLink ptr) as HRESULT
	GetBoundSource as function(byval This as IOleLink ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	UnbindSource as function(byval This as IOleLink ptr) as HRESULT
	Update as function(byval This as IOleLink ptr, byval pbc as IBindCtx ptr) as HRESULT
end type

type IOleLink_
	lpVtbl as IOleLinkVtbl ptr
end type

declare function IOleLink_SetUpdateOptions_Proxy(byval This as IOleLink ptr, byval dwUpdateOpt as DWORD) as HRESULT
declare sub IOleLink_SetUpdateOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_GetUpdateOptions_Proxy(byval This as IOleLink ptr, byval pdwUpdateOpt as DWORD ptr) as HRESULT
declare sub IOleLink_GetUpdateOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_SetSourceMoniker_Proxy(byval This as IOleLink ptr, byval pmk as IMoniker ptr, byval rclsid as const IID const ptr) as HRESULT
declare sub IOleLink_SetSourceMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_GetSourceMoniker_Proxy(byval This as IOleLink ptr, byval ppmk as IMoniker ptr ptr) as HRESULT
declare sub IOleLink_GetSourceMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_SetSourceDisplayName_Proxy(byval This as IOleLink ptr, byval pszStatusText as LPCOLESTR) as HRESULT
declare sub IOleLink_SetSourceDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_GetSourceDisplayName_Proxy(byval This as IOleLink ptr, byval ppszDisplayName as LPOLESTR ptr) as HRESULT
declare sub IOleLink_GetSourceDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_BindToSource_Proxy(byval This as IOleLink ptr, byval bindflags as DWORD, byval pbc as IBindCtx ptr) as HRESULT
declare sub IOleLink_BindToSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_BindIfRunning_Proxy(byval This as IOleLink ptr) as HRESULT
declare sub IOleLink_BindIfRunning_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_GetBoundSource_Proxy(byval This as IOleLink ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub IOleLink_GetBoundSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_UnbindSource_Proxy(byval This as IOleLink ptr) as HRESULT
declare sub IOleLink_UnbindSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleLink_Update_Proxy(byval This as IOleLink ptr, byval pbc as IBindCtx ptr) as HRESULT
declare sub IOleLink_Update_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleItemContainer_INTERFACE_DEFINED__
type IOleItemContainer as IOleItemContainer_
type LPOLEITEMCONTAINER as IOleItemContainer ptr

type tagBINDSPEED as long
enum
	BINDSPEED_INDEFINITE = 1
	BINDSPEED_MODERATE = 2
	BINDSPEED_IMMEDIATE = 3
end enum

type BINDSPEED as tagBINDSPEED

type tagOLECONTF as long
enum
	OLECONTF_EMBEDDINGS = 1
	OLECONTF_LINKS = 2
	OLECONTF_OTHERS = 4
	OLECONTF_ONLYUSER = 8
	OLECONTF_ONLYIFRUNNING = 16
end enum

type OLECONTF as tagOLECONTF
extern IID_IOleItemContainer as const GUID

type IOleItemContainerVtbl
	QueryInterface as function(byval This as IOleItemContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleItemContainer ptr) as ULONG
	Release as function(byval This as IOleItemContainer ptr) as ULONG
	ParseDisplayName as function(byval This as IOleItemContainer ptr, byval pbc as IBindCtx ptr, byval pszDisplayName as LPOLESTR, byval pchEaten as ULONG ptr, byval ppmkOut as IMoniker ptr ptr) as HRESULT
	EnumObjects as function(byval This as IOleItemContainer ptr, byval grfFlags as DWORD, byval ppenum as IEnumUnknown ptr ptr) as HRESULT
	LockContainer as function(byval This as IOleItemContainer ptr, byval fLock as WINBOOL) as HRESULT
	GetObject as function(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR, byval dwSpeedNeeded as DWORD, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	GetObjectStorage as function(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppvStorage as any ptr ptr) as HRESULT
	IsRunning as function(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR) as HRESULT
end type

type IOleItemContainer_
	lpVtbl as IOleItemContainerVtbl ptr
end type

declare function IOleItemContainer_GetObject_Proxy(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR, byval dwSpeedNeeded as DWORD, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare sub IOleItemContainer_GetObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleItemContainer_GetObjectStorage_Proxy(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppvStorage as any ptr ptr) as HRESULT
declare sub IOleItemContainer_GetObjectStorage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleItemContainer_IsRunning_Proxy(byval This as IOleItemContainer ptr, byval pszItem as LPOLESTR) as HRESULT
declare sub IOleItemContainer_IsRunning_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceUIWindow_INTERFACE_DEFINED__

type IOleInPlaceUIWindow as IOleInPlaceUIWindow_
type LPOLEINPLACEUIWINDOW as IOleInPlaceUIWindow ptr
type BORDERWIDTHS as RECT
type LPBORDERWIDTHS as LPRECT
type LPCBORDERWIDTHS as LPCRECT
extern IID_IOleInPlaceUIWindow as const GUID
type IOleInPlaceActiveObject as IOleInPlaceActiveObject_

type IOleInPlaceUIWindowVtbl
	QueryInterface as function(byval This as IOleInPlaceUIWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceUIWindow ptr) as ULONG
	Release as function(byval This as IOleInPlaceUIWindow ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceUIWindow ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceUIWindow ptr, byval fEnterMode as WINBOOL) as HRESULT
	GetBorder as function(byval This as IOleInPlaceUIWindow ptr, byval lprectBorder as LPRECT) as HRESULT
	RequestBorderSpace as function(byval This as IOleInPlaceUIWindow ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
	SetBorderSpace as function(byval This as IOleInPlaceUIWindow ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
	SetActiveObject as function(byval This as IOleInPlaceUIWindow ptr, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pszObjName as LPCOLESTR) as HRESULT
end type

type IOleInPlaceUIWindow_
	lpVtbl as IOleInPlaceUIWindowVtbl ptr
end type

declare function IOleInPlaceUIWindow_GetBorder_Proxy(byval This as IOleInPlaceUIWindow ptr, byval lprectBorder as LPRECT) as HRESULT
declare sub IOleInPlaceUIWindow_GetBorder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceUIWindow_RequestBorderSpace_Proxy(byval This as IOleInPlaceUIWindow ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
declare sub IOleInPlaceUIWindow_RequestBorderSpace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceUIWindow_SetBorderSpace_Proxy(byval This as IOleInPlaceUIWindow ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
declare sub IOleInPlaceUIWindow_SetBorderSpace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceUIWindow_SetActiveObject_Proxy(byval This as IOleInPlaceUIWindow ptr, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pszObjName as LPCOLESTR) as HRESULT
declare sub IOleInPlaceUIWindow_SetActiveObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceActiveObject_INTERFACE_DEFINED__
type LPOLEINPLACEACTIVEOBJECT as IOleInPlaceActiveObject ptr
extern IID_IOleInPlaceActiveObject as const GUID

type IOleInPlaceActiveObjectVtbl
	QueryInterface as function(byval This as IOleInPlaceActiveObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceActiveObject ptr) as ULONG
	Release as function(byval This as IOleInPlaceActiveObject ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceActiveObject ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceActiveObject ptr, byval fEnterMode as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IOleInPlaceActiveObject ptr, byval lpmsg as LPMSG) as HRESULT
	OnFrameWindowActivate as function(byval This as IOleInPlaceActiveObject ptr, byval fActivate as WINBOOL) as HRESULT
	OnDocWindowActivate as function(byval This as IOleInPlaceActiveObject ptr, byval fActivate as WINBOOL) as HRESULT
	ResizeBorder as function(byval This as IOleInPlaceActiveObject ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fFrameWindow as WINBOOL) as HRESULT
	EnableModeless as function(byval This as IOleInPlaceActiveObject ptr, byval fEnable as WINBOOL) as HRESULT
end type

type IOleInPlaceActiveObject_
	lpVtbl as IOleInPlaceActiveObjectVtbl ptr
end type

declare function IOleInPlaceActiveObject_RemoteTranslateAccelerator_Proxy(byval This as IOleInPlaceActiveObject ptr) as HRESULT
declare sub IOleInPlaceActiveObject_RemoteTranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceActiveObject_OnFrameWindowActivate_Proxy(byval This as IOleInPlaceActiveObject ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IOleInPlaceActiveObject_OnFrameWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceActiveObject_OnDocWindowActivate_Proxy(byval This as IOleInPlaceActiveObject ptr, byval fActivate as WINBOOL) as HRESULT
declare sub IOleInPlaceActiveObject_OnDocWindowActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceActiveObject_RemoteResizeBorder_Proxy(byval This as IOleInPlaceActiveObject ptr, byval prcBorder as LPCRECT, byval riid as const IID const ptr, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fFrameWindow as WINBOOL) as HRESULT
declare sub IOleInPlaceActiveObject_RemoteResizeBorder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceActiveObject_EnableModeless_Proxy(byval This as IOleInPlaceActiveObject ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IOleInPlaceActiveObject_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceActiveObject_TranslateAccelerator_Proxy(byval This as IOleInPlaceActiveObject ptr, byval lpmsg as LPMSG) as HRESULT
declare function IOleInPlaceActiveObject_TranslateAccelerator_Stub(byval This as IOleInPlaceActiveObject ptr) as HRESULT
declare function IOleInPlaceActiveObject_ResizeBorder_Proxy(byval This as IOleInPlaceActiveObject ptr, byval prcBorder as LPCRECT, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fFrameWindow as WINBOOL) as HRESULT
declare function IOleInPlaceActiveObject_ResizeBorder_Stub(byval This as IOleInPlaceActiveObject ptr, byval prcBorder as LPCRECT, byval riid as const IID const ptr, byval pUIWindow as IOleInPlaceUIWindow ptr, byval fFrameWindow as WINBOOL) as HRESULT
#define __IOleInPlaceFrame_INTERFACE_DEFINED__
type IOleInPlaceFrame as IOleInPlaceFrame_
type LPOLEINPLACEFRAME as IOleInPlaceFrame ptr

type tagOIFI
	cb as UINT
	fMDIApp as WINBOOL
	hwndFrame as HWND
	haccel as HACCEL
	cAccelEntries as UINT
end type

type OLEINPLACEFRAMEINFO as tagOIFI
type LPOLEINPLACEFRAMEINFO as tagOIFI ptr

type tagOleMenuGroupWidths
	width(0 to 5) as LONG
end type

type OLEMENUGROUPWIDTHS as tagOleMenuGroupWidths
type LPOLEMENUGROUPWIDTHS as tagOleMenuGroupWidths ptr
type HOLEMENU as HGLOBAL
extern IID_IOleInPlaceFrame as const GUID

type IOleInPlaceFrameVtbl
	QueryInterface as function(byval This as IOleInPlaceFrame ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceFrame ptr) as ULONG
	Release as function(byval This as IOleInPlaceFrame ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceFrame ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceFrame ptr, byval fEnterMode as WINBOOL) as HRESULT
	GetBorder as function(byval This as IOleInPlaceFrame ptr, byval lprectBorder as LPRECT) as HRESULT
	RequestBorderSpace as function(byval This as IOleInPlaceFrame ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
	SetBorderSpace as function(byval This as IOleInPlaceFrame ptr, byval pborderwidths as LPCBORDERWIDTHS) as HRESULT
	SetActiveObject as function(byval This as IOleInPlaceFrame ptr, byval pActiveObject as IOleInPlaceActiveObject ptr, byval pszObjName as LPCOLESTR) as HRESULT
	InsertMenus as function(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU, byval lpMenuWidths as LPOLEMENUGROUPWIDTHS) as HRESULT
	SetMenu as function(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU, byval holemenu as HOLEMENU, byval hwndActiveObject as HWND) as HRESULT
	RemoveMenus as function(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU) as HRESULT
	SetStatusText as function(byval This as IOleInPlaceFrame ptr, byval pszStatusText as LPCOLESTR) as HRESULT
	EnableModeless as function(byval This as IOleInPlaceFrame ptr, byval fEnable as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IOleInPlaceFrame ptr, byval lpmsg as LPMSG, byval wID as WORD) as HRESULT
end type

type IOleInPlaceFrame_
	lpVtbl as IOleInPlaceFrameVtbl ptr
end type

declare function IOleInPlaceFrame_InsertMenus_Proxy(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU, byval lpMenuWidths as LPOLEMENUGROUPWIDTHS) as HRESULT
declare sub IOleInPlaceFrame_InsertMenus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceFrame_SetMenu_Proxy(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU, byval holemenu as HOLEMENU, byval hwndActiveObject as HWND) as HRESULT
declare sub IOleInPlaceFrame_SetMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceFrame_RemoveMenus_Proxy(byval This as IOleInPlaceFrame ptr, byval hmenuShared as HMENU) as HRESULT
declare sub IOleInPlaceFrame_RemoveMenus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceFrame_SetStatusText_Proxy(byval This as IOleInPlaceFrame ptr, byval pszStatusText as LPCOLESTR) as HRESULT
declare sub IOleInPlaceFrame_SetStatusText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceFrame_EnableModeless_Proxy(byval This as IOleInPlaceFrame ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IOleInPlaceFrame_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceFrame_TranslateAccelerator_Proxy(byval This as IOleInPlaceFrame ptr, byval lpmsg as LPMSG, byval wID as WORD) as HRESULT
declare sub IOleInPlaceFrame_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceObject_INTERFACE_DEFINED__
type IOleInPlaceObject as IOleInPlaceObject_
type LPOLEINPLACEOBJECT as IOleInPlaceObject ptr
extern IID_IOleInPlaceObject as const GUID

type IOleInPlaceObjectVtbl
	QueryInterface as function(byval This as IOleInPlaceObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceObject ptr) as ULONG
	Release as function(byval This as IOleInPlaceObject ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceObject ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceObject ptr, byval fEnterMode as WINBOOL) as HRESULT
	InPlaceDeactivate as function(byval This as IOleInPlaceObject ptr) as HRESULT
	UIDeactivate as function(byval This as IOleInPlaceObject ptr) as HRESULT
	SetObjectRects as function(byval This as IOleInPlaceObject ptr, byval lprcPosRect as LPCRECT, byval lprcClipRect as LPCRECT) as HRESULT
	ReactivateAndUndo as function(byval This as IOleInPlaceObject ptr) as HRESULT
end type

type IOleInPlaceObject_
	lpVtbl as IOleInPlaceObjectVtbl ptr
end type

declare function IOleInPlaceObject_InPlaceDeactivate_Proxy(byval This as IOleInPlaceObject ptr) as HRESULT
declare sub IOleInPlaceObject_InPlaceDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceObject_UIDeactivate_Proxy(byval This as IOleInPlaceObject ptr) as HRESULT
declare sub IOleInPlaceObject_UIDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceObject_SetObjectRects_Proxy(byval This as IOleInPlaceObject ptr, byval lprcPosRect as LPCRECT, byval lprcClipRect as LPCRECT) as HRESULT
declare sub IOleInPlaceObject_SetObjectRects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceObject_ReactivateAndUndo_Proxy(byval This as IOleInPlaceObject ptr) as HRESULT
declare sub IOleInPlaceObject_ReactivateAndUndo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceSite_INTERFACE_DEFINED__
type IOleInPlaceSite as IOleInPlaceSite_
type LPOLEINPLACESITE as IOleInPlaceSite ptr
extern IID_IOleInPlaceSite as const GUID

type IOleInPlaceSiteVtbl
	QueryInterface as function(byval This as IOleInPlaceSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceSite ptr) as ULONG
	Release as function(byval This as IOleInPlaceSite ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceSite ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceSite ptr, byval fEnterMode as WINBOOL) as HRESULT
	CanInPlaceActivate as function(byval This as IOleInPlaceSite ptr) as HRESULT
	OnInPlaceActivate as function(byval This as IOleInPlaceSite ptr) as HRESULT
	OnUIActivate as function(byval This as IOleInPlaceSite ptr) as HRESULT
	GetWindowContext as function(byval This as IOleInPlaceSite ptr, byval ppFrame as IOleInPlaceFrame ptr ptr, byval ppDoc as IOleInPlaceUIWindow ptr ptr, byval lprcPosRect as LPRECT, byval lprcClipRect as LPRECT, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function(byval This as IOleInPlaceSite ptr, byval scrollExtant as SIZE) as HRESULT
	OnUIDeactivate as function(byval This as IOleInPlaceSite ptr, byval fUndoable as WINBOOL) as HRESULT
	OnInPlaceDeactivate as function(byval This as IOleInPlaceSite ptr) as HRESULT
	DiscardUndoState as function(byval This as IOleInPlaceSite ptr) as HRESULT
	DeactivateAndUndo as function(byval This as IOleInPlaceSite ptr) as HRESULT
	OnPosRectChange as function(byval This as IOleInPlaceSite ptr, byval lprcPosRect as LPCRECT) as HRESULT
end type

type IOleInPlaceSite_
	lpVtbl as IOleInPlaceSiteVtbl ptr
end type

declare function IOleInPlaceSite_CanInPlaceActivate_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_CanInPlaceActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_OnInPlaceActivate_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_OnInPlaceActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_OnUIActivate_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_OnUIActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_GetWindowContext_Proxy(byval This as IOleInPlaceSite ptr, byval ppFrame as IOleInPlaceFrame ptr ptr, byval ppDoc as IOleInPlaceUIWindow ptr ptr, byval lprcPosRect as LPRECT, byval lprcClipRect as LPRECT, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO) as HRESULT
declare sub IOleInPlaceSite_GetWindowContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_Scroll_Proxy(byval This as IOleInPlaceSite ptr, byval scrollExtant as SIZE) as HRESULT
declare sub IOleInPlaceSite_Scroll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_OnUIDeactivate_Proxy(byval This as IOleInPlaceSite ptr, byval fUndoable as WINBOOL) as HRESULT
declare sub IOleInPlaceSite_OnUIDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_OnInPlaceDeactivate_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_OnInPlaceDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_DiscardUndoState_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_DiscardUndoState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_DeactivateAndUndo_Proxy(byval This as IOleInPlaceSite ptr) as HRESULT
declare sub IOleInPlaceSite_DeactivateAndUndo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSite_OnPosRectChange_Proxy(byval This as IOleInPlaceSite ptr, byval lprcPosRect as LPCRECT) as HRESULT
declare sub IOleInPlaceSite_OnPosRectChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IContinue_INTERFACE_DEFINED__
extern IID_IContinue as const GUID
type IContinue as IContinue_

type IContinueVtbl
	QueryInterface as function(byval This as IContinue ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContinue ptr) as ULONG
	Release as function(byval This as IContinue ptr) as ULONG
	FContinue as function(byval This as IContinue ptr) as HRESULT
end type

type IContinue_
	lpVtbl as IContinueVtbl ptr
end type

declare function IContinue_FContinue_Proxy(byval This as IContinue ptr) as HRESULT
declare sub IContinue_FContinue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IViewObject_INTERFACE_DEFINED__
type IViewObject as IViewObject_
type LPVIEWOBJECT as IViewObject ptr
extern IID_IViewObject as const GUID

type IViewObjectVtbl
	QueryInterface as function(byval This as IViewObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IViewObject ptr) as ULONG
	Release as function(byval This as IViewObject ptr) as ULONG
	Draw as function(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pfnContinue as function(byval dwContinue as ULONG_PTR) as WINBOOL, byval dwContinue as ULONG_PTR) as HRESULT
	GetColorSet as function(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
	Freeze as function(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval pdwFreeze as DWORD ptr) as HRESULT
	Unfreeze as function(byval This as IViewObject ptr, byval dwFreeze as DWORD) as HRESULT
	SetAdvise as function(byval This as IViewObject ptr, byval aspects as DWORD, byval advf as DWORD, byval pAdvSink as IAdviseSink ptr) as HRESULT
	GetAdvise as function(byval This as IViewObject ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
end type

type IViewObject_
	lpVtbl as IViewObjectVtbl ptr
end type

declare function IViewObject_RemoteDraw_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pContinue as IContinue ptr) as HRESULT
declare sub IViewObject_RemoteDraw_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_RemoteGetColorSet_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as ULONG_PTR, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
declare sub IViewObject_RemoteGetColorSet_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_RemoteFreeze_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval pdwFreeze as DWORD ptr) as HRESULT
declare sub IViewObject_RemoteFreeze_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_Unfreeze_Proxy(byval This as IViewObject ptr, byval dwFreeze as DWORD) as HRESULT
declare sub IViewObject_Unfreeze_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_SetAdvise_Proxy(byval This as IViewObject ptr, byval aspects as DWORD, byval advf as DWORD, byval pAdvSink as IAdviseSink ptr) as HRESULT
declare sub IViewObject_SetAdvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_RemoteGetAdvise_Proxy(byval This as IViewObject ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
declare sub IViewObject_RemoteGetAdvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObject_Draw_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pfnContinue as function(byval dwContinue as ULONG_PTR) as WINBOOL, byval dwContinue as ULONG_PTR) as HRESULT
declare function IViewObject_Draw_Stub(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pContinue as IContinue ptr) as HRESULT
declare function IViewObject_GetColorSet_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
declare function IViewObject_GetColorSet_Stub(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as ULONG_PTR, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
declare function IViewObject_Freeze_Proxy(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval pdwFreeze as DWORD ptr) as HRESULT
declare function IViewObject_Freeze_Stub(byval This as IViewObject ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as ULONG_PTR, byval pdwFreeze as DWORD ptr) as HRESULT
declare function IViewObject_GetAdvise_Proxy(byval This as IViewObject ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
declare function IViewObject_GetAdvise_Stub(byval This as IViewObject ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
#define __IViewObject2_INTERFACE_DEFINED__
type IViewObject2 as IViewObject2_
type LPVIEWOBJECT2 as IViewObject2 ptr
extern IID_IViewObject2 as const GUID

type IViewObject2Vtbl
	QueryInterface as function(byval This as IViewObject2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IViewObject2 ptr) as ULONG
	Release as function(byval This as IViewObject2 ptr) as ULONG
	Draw as function(byval This as IViewObject2 ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pfnContinue as function(byval dwContinue as ULONG_PTR) as WINBOOL, byval dwContinue as ULONG_PTR) as HRESULT
	GetColorSet as function(byval This as IViewObject2 ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
	Freeze as function(byval This as IViewObject2 ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval pdwFreeze as DWORD ptr) as HRESULT
	Unfreeze as function(byval This as IViewObject2 ptr, byval dwFreeze as DWORD) as HRESULT
	SetAdvise as function(byval This as IViewObject2 ptr, byval aspects as DWORD, byval advf as DWORD, byval pAdvSink as IAdviseSink ptr) as HRESULT
	GetAdvise as function(byval This as IViewObject2 ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
	GetExtent as function(byval This as IViewObject2 ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval ptd as DVTARGETDEVICE ptr, byval lpsizel as LPSIZEL) as HRESULT
end type

type IViewObject2_
	lpVtbl as IViewObject2Vtbl ptr
end type

declare function IViewObject2_GetExtent_Proxy(byval This as IViewObject2 ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval ptd as DVTARGETDEVICE ptr, byval lpsizel as LPSIZEL) as HRESULT
declare sub IViewObject2_GetExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDropSource_INTERFACE_DEFINED__
type IDropSource as IDropSource_
type LPDROPSOURCE as IDropSource ptr
extern IID_IDropSource as const GUID

type IDropSourceVtbl
	QueryInterface as function(byval This as IDropSource ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDropSource ptr) as ULONG
	Release as function(byval This as IDropSource ptr) as ULONG
	QueryContinueDrag as function(byval This as IDropSource ptr, byval fEscapePressed as WINBOOL, byval grfKeyState as DWORD) as HRESULT
	GiveFeedback as function(byval This as IDropSource ptr, byval dwEffect as DWORD) as HRESULT
end type

type IDropSource_
	lpVtbl as IDropSourceVtbl ptr
end type

declare function IDropSource_QueryContinueDrag_Proxy(byval This as IDropSource ptr, byval fEscapePressed as WINBOOL, byval grfKeyState as DWORD) as HRESULT
declare sub IDropSource_QueryContinueDrag_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropSource_GiveFeedback_Proxy(byval This as IDropSource ptr, byval dwEffect as DWORD) as HRESULT
declare sub IDropSource_GiveFeedback_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDropTarget_INTERFACE_DEFINED__
type IDropTarget as IDropTarget_
type LPDROPTARGET as IDropTarget ptr

#define MK_ALT &h20
#define DROPEFFECT_NONE 0
#define DROPEFFECT_COPY 1
#define DROPEFFECT_MOVE 2
#define DROPEFFECT_LINK 4
#define DROPEFFECT_SCROLL &h80000000
#define DD_DEFSCROLLINSET 11
#define DD_DEFSCROLLDELAY 50
#define DD_DEFSCROLLINTERVAL 50
#define DD_DEFDRAGDELAY 200
#define DD_DEFDRAGMINDIST 2
extern IID_IDropTarget as const GUID

type IDropTargetVtbl
	QueryInterface as function(byval This as IDropTarget ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDropTarget ptr) as ULONG
	Release as function(byval This as IDropTarget ptr) as ULONG
	DragEnter as function(byval This as IDropTarget ptr, byval pDataObj as IDataObject ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
	DragOver as function(byval This as IDropTarget ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
	DragLeave as function(byval This as IDropTarget ptr) as HRESULT
	Drop as function(byval This as IDropTarget ptr, byval pDataObj as IDataObject ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
end type

type IDropTarget_
	lpVtbl as IDropTargetVtbl ptr
end type

declare function IDropTarget_DragEnter_Proxy(byval This as IDropTarget ptr, byval pDataObj as IDataObject ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
declare sub IDropTarget_DragEnter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTarget_DragOver_Proxy(byval This as IDropTarget ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
declare sub IDropTarget_DragOver_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTarget_DragLeave_Proxy(byval This as IDropTarget ptr) as HRESULT
declare sub IDropTarget_DragLeave_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTarget_Drop_Proxy(byval This as IDropTarget ptr, byval pDataObj as IDataObject ptr, byval grfKeyState as DWORD, byval pt as POINTL, byval pdwEffect as DWORD ptr) as HRESULT
declare sub IDropTarget_Drop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDropSourceNotify_INTERFACE_DEFINED__
extern IID_IDropSourceNotify as const GUID
type IDropSourceNotify as IDropSourceNotify_

type IDropSourceNotifyVtbl
	QueryInterface as function(byval This as IDropSourceNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDropSourceNotify ptr) as ULONG
	Release as function(byval This as IDropSourceNotify ptr) as ULONG
	DragEnterTarget as function(byval This as IDropSourceNotify ptr, byval hwndTarget as HWND) as HRESULT
	DragLeaveTarget as function(byval This as IDropSourceNotify ptr) as HRESULT
end type

type IDropSourceNotify_
	lpVtbl as IDropSourceNotifyVtbl ptr
end type

declare function IDropSourceNotify_DragEnterTarget_Proxy(byval This as IDropSourceNotify ptr, byval hwndTarget as HWND) as HRESULT
declare sub IDropSourceNotify_DragEnterTarget_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropSourceNotify_DragLeaveTarget_Proxy(byval This as IDropSourceNotify ptr) as HRESULT
declare sub IDropSourceNotify_DragLeaveTarget_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumOLEVERB_INTERFACE_DEFINED__
type LPENUMOLEVERB as IEnumOLEVERB ptr

type tagOLEVERB
	lVerb as LONG
	lpszVerbName as LPOLESTR
	fuFlags as DWORD
	grfAttribs as DWORD
end type

type OLEVERB as tagOLEVERB
type LPOLEVERB as tagOLEVERB ptr

type tagOLEVERBATTRIB as long
enum
	OLEVERBATTRIB_NEVERDIRTIES = 1
	OLEVERBATTRIB_ONCONTAINERMENU = 2
end enum

type OLEVERBATTRIB as tagOLEVERBATTRIB
extern IID_IEnumOLEVERB as const GUID

type IEnumOLEVERBVtbl
	QueryInterface as function(byval This as IEnumOLEVERB ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumOLEVERB ptr) as ULONG
	Release as function(byval This as IEnumOLEVERB ptr) as ULONG
	Next as function(byval This as IEnumOLEVERB ptr, byval celt as ULONG, byval rgelt as LPOLEVERB, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumOLEVERB ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumOLEVERB ptr) as HRESULT
	Clone as function(byval This as IEnumOLEVERB ptr, byval ppenum as IEnumOLEVERB ptr ptr) as HRESULT
end type

type IEnumOLEVERB_
	lpVtbl as IEnumOLEVERBVtbl ptr
end type

declare function IEnumOLEVERB_RemoteNext_Proxy(byval This as IEnumOLEVERB ptr, byval celt as ULONG, byval rgelt as LPOLEVERB, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumOLEVERB_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOLEVERB_Skip_Proxy(byval This as IEnumOLEVERB ptr, byval celt as ULONG) as HRESULT
declare sub IEnumOLEVERB_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOLEVERB_Reset_Proxy(byval This as IEnumOLEVERB ptr) as HRESULT
declare sub IEnumOLEVERB_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOLEVERB_Clone_Proxy(byval This as IEnumOLEVERB ptr, byval ppenum as IEnumOLEVERB ptr ptr) as HRESULT
declare sub IEnumOLEVERB_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOLEVERB_Next_Proxy(byval This as IEnumOLEVERB ptr, byval celt as ULONG, byval rgelt as LPOLEVERB, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumOLEVERB_Next_Stub(byval This as IEnumOLEVERB ptr, byval celt as ULONG, byval rgelt as LPOLEVERB, byval pceltFetched as ULONG ptr) as HRESULT

end extern

#include once "ole-common.bi"
