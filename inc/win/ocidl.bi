#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oleidl.bi"
#include once "oaidl.bi"
#include once "servprov.bi"
#include once "urlmon.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __ocidl_h__
#define __IEnumConnections_FWD_DEFINED__
#define __IConnectionPoint_FWD_DEFINED__
#define __IEnumConnectionPoints_FWD_DEFINED__
#define __IConnectionPointContainer_FWD_DEFINED__
#define __IClassFactory2_FWD_DEFINED__
#define __IProvideClassInfo_FWD_DEFINED__
#define __IProvideClassInfo2_FWD_DEFINED__
#define __IProvideMultipleClassInfo_FWD_DEFINED__
#define __IOleControl_FWD_DEFINED__
#define __IOleControlSite_FWD_DEFINED__
#define __IPropertyPage_FWD_DEFINED__
#define __IPropertyPage2_FWD_DEFINED__
#define __IPropertyPageSite_FWD_DEFINED__
#define __IPropertyNotifySink_FWD_DEFINED__
#define __ISpecifyPropertyPages_FWD_DEFINED__
#define __IPersistMemory_FWD_DEFINED__
#define __IPersistStreamInit_FWD_DEFINED__
#define __IPersistPropertyBag_FWD_DEFINED__
#define __ISimpleFrameSite_FWD_DEFINED__
#define __IFont_FWD_DEFINED__
#define __IPicture_FWD_DEFINED__
#define __IPicture2_FWD_DEFINED__
#define __IFontEventsDisp_FWD_DEFINED__
#define __IFontDisp_FWD_DEFINED__
#define __IPictureDisp_FWD_DEFINED__
#define __IOleInPlaceObjectWindowless_FWD_DEFINED__
#define __IOleInPlaceSiteEx_FWD_DEFINED__
#define __IOleInPlaceSiteWindowless_FWD_DEFINED__
#define __IViewObjectEx_FWD_DEFINED__
#define __IOleUndoUnit_FWD_DEFINED__
#define __IOleParentUndoUnit_FWD_DEFINED__
#define __IEnumOleUndoUnits_FWD_DEFINED__
#define __IOleUndoManager_FWD_DEFINED__
#define __IPointerInactive_FWD_DEFINED__
#define __IObjectWithSite_FWD_DEFINED__
#define __IPerPropertyBrowsing_FWD_DEFINED__
#define __IPropertyBag2_FWD_DEFINED__
#define __IPersistPropertyBag2_FWD_DEFINED__
#define __IAdviseSinkEx_FWD_DEFINED__
#define __IQuickActivate_FWD_DEFINED__
#define __IOleControlTypes_INTERFACE_DEFINED__
extern IOleControlTypes_v1_0_c_ifspec as RPC_IF_HANDLE
extern IOleControlTypes_v1_0_s_ifspec as RPC_IF_HANDLE

type tagUASFLAGS as long
enum
	UAS_NORMAL = &h0
	UAS_BLOCKED = &h1
	UAS_NOPARENTENABLE = &h2
	UAS_MASK = &h3
end enum

type UASFLAGS as tagUASFLAGS

type tagREADYSTATE as long
enum
	READYSTATE_UNINITIALIZED = 0
	READYSTATE_LOADING = 1
	READYSTATE_LOADED = 2
	READYSTATE_INTERACTIVE = 3
	READYSTATE_COMPLETE = 4
end enum

type READYSTATE as tagREADYSTATE
#define __IEnumConnections_INTERFACE_DEFINED__
type IEnumConnections as IEnumConnections_
type PENUMCONNECTIONS as IEnumConnections ptr
type LPENUMCONNECTIONS as IEnumConnections ptr

type tagCONNECTDATA
	pUnk as IUnknown ptr
	dwCookie as DWORD
end type

type CONNECTDATA as tagCONNECTDATA
type PCONNECTDATA as tagCONNECTDATA ptr
type LPCONNECTDATA as tagCONNECTDATA ptr
extern IID_IEnumConnections as const GUID

type IEnumConnectionsVtbl
	QueryInterface as function(byval This as IEnumConnections ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumConnections ptr) as ULONG
	Release as function(byval This as IEnumConnections ptr) as ULONG
	Next as function(byval This as IEnumConnections ptr, byval cConnections as ULONG, byval rgcd as LPCONNECTDATA, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumConnections ptr, byval cConnections as ULONG) as HRESULT
	Reset as function(byval This as IEnumConnections ptr) as HRESULT
	Clone as function(byval This as IEnumConnections ptr, byval ppEnum as IEnumConnections ptr ptr) as HRESULT
end type

type IEnumConnections_
	lpVtbl as IEnumConnectionsVtbl ptr
end type

declare function IEnumConnections_RemoteNext_Proxy(byval This as IEnumConnections ptr, byval cConnections as ULONG, byval rgcd as LPCONNECTDATA, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumConnections_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnections_Skip_Proxy(byval This as IEnumConnections ptr, byval cConnections as ULONG) as HRESULT
declare sub IEnumConnections_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnections_Reset_Proxy(byval This as IEnumConnections ptr) as HRESULT
declare sub IEnumConnections_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnections_Clone_Proxy(byval This as IEnumConnections ptr, byval ppEnum as IEnumConnections ptr ptr) as HRESULT
declare sub IEnumConnections_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnections_Next_Proxy(byval This as IEnumConnections ptr, byval cConnections as ULONG, byval rgcd as LPCONNECTDATA, byval pcFetched as ULONG ptr) as HRESULT
declare function IEnumConnections_Next_Stub(byval This as IEnumConnections ptr, byval cConnections as ULONG, byval rgcd as LPCONNECTDATA, byval pcFetched as ULONG ptr) as HRESULT
#define __IConnectionPoint_INTERFACE_DEFINED__

type IConnectionPoint as IConnectionPoint_
type PCONNECTIONPOINT as IConnectionPoint ptr
type LPCONNECTIONPOINT as IConnectionPoint ptr
extern IID_IConnectionPoint as const GUID
type IConnectionPointContainer as IConnectionPointContainer_

type IConnectionPointVtbl
	QueryInterface as function(byval This as IConnectionPoint ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IConnectionPoint ptr) as ULONG
	Release as function(byval This as IConnectionPoint ptr) as ULONG
	GetConnectionInterface as function(byval This as IConnectionPoint ptr, byval pIID as IID ptr) as HRESULT
	GetConnectionPointContainer as function(byval This as IConnectionPoint ptr, byval ppCPC as IConnectionPointContainer ptr ptr) as HRESULT
	Advise as function(byval This as IConnectionPoint ptr, byval pUnkSink as IUnknown ptr, byval pdwCookie as DWORD ptr) as HRESULT
	Unadvise as function(byval This as IConnectionPoint ptr, byval dwCookie as DWORD) as HRESULT
	EnumConnections as function(byval This as IConnectionPoint ptr, byval ppEnum as IEnumConnections ptr ptr) as HRESULT
end type

type IConnectionPoint_
	lpVtbl as IConnectionPointVtbl ptr
end type

declare function IConnectionPoint_GetConnectionInterface_Proxy(byval This as IConnectionPoint ptr, byval pIID as IID ptr) as HRESULT
declare sub IConnectionPoint_GetConnectionInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IConnectionPoint_GetConnectionPointContainer_Proxy(byval This as IConnectionPoint ptr, byval ppCPC as IConnectionPointContainer ptr ptr) as HRESULT
declare sub IConnectionPoint_GetConnectionPointContainer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IConnectionPoint_Advise_Proxy(byval This as IConnectionPoint ptr, byval pUnkSink as IUnknown ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub IConnectionPoint_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IConnectionPoint_Unadvise_Proxy(byval This as IConnectionPoint ptr, byval dwCookie as DWORD) as HRESULT
declare sub IConnectionPoint_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IConnectionPoint_EnumConnections_Proxy(byval This as IConnectionPoint ptr, byval ppEnum as IEnumConnections ptr ptr) as HRESULT
declare sub IConnectionPoint_EnumConnections_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumConnectionPoints_INTERFACE_DEFINED__

type IEnumConnectionPoints as IEnumConnectionPoints_
type PENUMCONNECTIONPOINTS as IEnumConnectionPoints ptr
type LPENUMCONNECTIONPOINTS as IEnumConnectionPoints ptr
extern IID_IEnumConnectionPoints as const GUID

type IEnumConnectionPointsVtbl
	QueryInterface as function(byval This as IEnumConnectionPoints ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumConnectionPoints ptr) as ULONG
	Release as function(byval This as IEnumConnectionPoints ptr) as ULONG
	Next as function(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG, byval ppCP as LPCONNECTIONPOINT ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG) as HRESULT
	Reset as function(byval This as IEnumConnectionPoints ptr) as HRESULT
	Clone as function(byval This as IEnumConnectionPoints ptr, byval ppEnum as IEnumConnectionPoints ptr ptr) as HRESULT
end type

type IEnumConnectionPoints_
	lpVtbl as IEnumConnectionPointsVtbl ptr
end type

declare function IEnumConnectionPoints_RemoteNext_Proxy(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG, byval ppCP as LPCONNECTIONPOINT ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumConnectionPoints_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnectionPoints_Skip_Proxy(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG) as HRESULT
declare sub IEnumConnectionPoints_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnectionPoints_Reset_Proxy(byval This as IEnumConnectionPoints ptr) as HRESULT
declare sub IEnumConnectionPoints_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnectionPoints_Clone_Proxy(byval This as IEnumConnectionPoints ptr, byval ppEnum as IEnumConnectionPoints ptr ptr) as HRESULT
declare sub IEnumConnectionPoints_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumConnectionPoints_Next_Proxy(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG, byval ppCP as LPCONNECTIONPOINT ptr, byval pcFetched as ULONG ptr) as HRESULT
declare function IEnumConnectionPoints_Next_Stub(byval This as IEnumConnectionPoints ptr, byval cConnections as ULONG, byval ppCP as LPCONNECTIONPOINT ptr, byval pcFetched as ULONG ptr) as HRESULT
#define __IConnectionPointContainer_INTERFACE_DEFINED__
type PCONNECTIONPOINTCONTAINER as IConnectionPointContainer ptr
type LPCONNECTIONPOINTCONTAINER as IConnectionPointContainer ptr
extern IID_IConnectionPointContainer as const GUID

type IConnectionPointContainerVtbl
	QueryInterface as function(byval This as IConnectionPointContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IConnectionPointContainer ptr) as ULONG
	Release as function(byval This as IConnectionPointContainer ptr) as ULONG
	EnumConnectionPoints as function(byval This as IConnectionPointContainer ptr, byval ppEnum as IEnumConnectionPoints ptr ptr) as HRESULT
	FindConnectionPoint as function(byval This as IConnectionPointContainer ptr, byval riid as const IID const ptr, byval ppCP as IConnectionPoint ptr ptr) as HRESULT
end type

type IConnectionPointContainer_
	lpVtbl as IConnectionPointContainerVtbl ptr
end type

declare function IConnectionPointContainer_EnumConnectionPoints_Proxy(byval This as IConnectionPointContainer ptr, byval ppEnum as IEnumConnectionPoints ptr ptr) as HRESULT
declare sub IConnectionPointContainer_EnumConnectionPoints_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IConnectionPointContainer_FindConnectionPoint_Proxy(byval This as IConnectionPointContainer ptr, byval riid as const IID const ptr, byval ppCP as IConnectionPoint ptr ptr) as HRESULT
declare sub IConnectionPointContainer_FindConnectionPoint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IClassFactory2_INTERFACE_DEFINED__
type IClassFactory2 as IClassFactory2_
type LPCLASSFACTORY2 as IClassFactory2 ptr

type tagLICINFO
	cbLicInfo as LONG
	fRuntimeKeyAvail as WINBOOL
	fLicVerified as WINBOOL
end type

type LICINFO as tagLICINFO
type LPLICINFO as tagLICINFO ptr
extern IID_IClassFactory2 as const GUID

type IClassFactory2Vtbl
	QueryInterface as function(byval This as IClassFactory2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IClassFactory2 ptr) as ULONG
	Release as function(byval This as IClassFactory2 ptr) as ULONG
	CreateInstance as function(byval This as IClassFactory2 ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	LockServer as function(byval This as IClassFactory2 ptr, byval fLock as WINBOOL) as HRESULT
	GetLicInfo as function(byval This as IClassFactory2 ptr, byval pLicInfo as LICINFO ptr) as HRESULT
	RequestLicKey as function(byval This as IClassFactory2 ptr, byval dwReserved as DWORD, byval pBstrKey as BSTR ptr) as HRESULT
	CreateInstanceLic as function(byval This as IClassFactory2 ptr, byval pUnkOuter as IUnknown ptr, byval pUnkReserved as IUnknown ptr, byval riid as const IID const ptr, byval bstrKey as BSTR, byval ppvObj as PVOID ptr) as HRESULT
end type

type IClassFactory2_
	lpVtbl as IClassFactory2Vtbl ptr
end type

declare function IClassFactory2_GetLicInfo_Proxy(byval This as IClassFactory2 ptr, byval pLicInfo as LICINFO ptr) as HRESULT
declare sub IClassFactory2_GetLicInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClassFactory2_RequestLicKey_Proxy(byval This as IClassFactory2 ptr, byval dwReserved as DWORD, byval pBstrKey as BSTR ptr) as HRESULT
declare sub IClassFactory2_RequestLicKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClassFactory2_RemoteCreateInstanceLic_Proxy(byval This as IClassFactory2 ptr, byval riid as const IID const ptr, byval bstrKey as BSTR, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare sub IClassFactory2_RemoteCreateInstanceLic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClassFactory2_CreateInstanceLic_Proxy(byval This as IClassFactory2 ptr, byval pUnkOuter as IUnknown ptr, byval pUnkReserved as IUnknown ptr, byval riid as const IID const ptr, byval bstrKey as BSTR, byval ppvObj as PVOID ptr) as HRESULT
declare function IClassFactory2_CreateInstanceLic_Stub(byval This as IClassFactory2 ptr, byval riid as const IID const ptr, byval bstrKey as BSTR, byval ppvObj as IUnknown ptr ptr) as HRESULT
#define __IProvideClassInfo_INTERFACE_DEFINED__
type IProvideClassInfo as IProvideClassInfo_
type LPPROVIDECLASSINFO as IProvideClassInfo ptr
extern IID_IProvideClassInfo as const GUID

type IProvideClassInfoVtbl
	QueryInterface as function(byval This as IProvideClassInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProvideClassInfo ptr) as ULONG
	Release as function(byval This as IProvideClassInfo ptr) as ULONG

	#ifdef UNICODE
		GetClassInfoW as function(byval This as IProvideClassInfo ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#else
		GetClassInfoA as function(byval This as IProvideClassInfo ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#endif
end type

type IProvideClassInfo_
	lpVtbl as IProvideClassInfoVtbl ptr
end type

declare function IProvideClassInfo_GetClassInfo_Proxy(byval This as IProvideClassInfo ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
declare sub IProvideClassInfo_GetClassInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IProvideClassInfo2_INTERFACE_DEFINED__
type IProvideClassInfo2 as IProvideClassInfo2_
type LPPROVIDECLASSINFO2 as IProvideClassInfo2 ptr

type tagGUIDKIND as long
enum
	GUIDKIND_DEFAULT_SOURCE_DISP_IID = 1
end enum

type GUIDKIND as tagGUIDKIND
extern IID_IProvideClassInfo2 as const GUID

type IProvideClassInfo2Vtbl
	QueryInterface as function(byval This as IProvideClassInfo2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProvideClassInfo2 ptr) as ULONG
	Release as function(byval This as IProvideClassInfo2 ptr) as ULONG

	#ifdef UNICODE
		GetClassInfoW as function(byval This as IProvideClassInfo2 ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#else
		GetClassInfoA as function(byval This as IProvideClassInfo2 ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#endif

	GetGUID as function(byval This as IProvideClassInfo2 ptr, byval dwGuidKind as DWORD, byval pGUID as GUID ptr) as HRESULT
end type

type IProvideClassInfo2_
	lpVtbl as IProvideClassInfo2Vtbl ptr
end type

declare function IProvideClassInfo2_GetGUID_Proxy(byval This as IProvideClassInfo2 ptr, byval dwGuidKind as DWORD, byval pGUID as GUID ptr) as HRESULT
declare sub IProvideClassInfo2_GetGUID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IProvideMultipleClassInfo_INTERFACE_DEFINED__
#define MULTICLASSINFO_GETTYPEINFO &h1
#define MULTICLASSINFO_GETNUMRESERVEDDISPIDS &h2
#define MULTICLASSINFO_GETIIDPRIMARY &h4
#define MULTICLASSINFO_GETIIDSOURCE &h8
#define TIFLAGS_EXTENDDISPATCHONLY &h1
type IProvideMultipleClassInfo as IProvideMultipleClassInfo_
type LPPROVIDEMULTIPLECLASSINFO as IProvideMultipleClassInfo ptr
extern IID_IProvideMultipleClassInfo as const GUID

type IProvideMultipleClassInfoVtbl
	QueryInterface as function(byval This as IProvideMultipleClassInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProvideMultipleClassInfo ptr) as ULONG
	Release as function(byval This as IProvideMultipleClassInfo ptr) as ULONG

	#ifdef UNICODE
		GetClassInfoW as function(byval This as IProvideMultipleClassInfo ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#else
		GetClassInfoA as function(byval This as IProvideMultipleClassInfo ptr, byval ppTI as ITypeInfo ptr ptr) as HRESULT
	#endif

	GetGUID as function(byval This as IProvideMultipleClassInfo ptr, byval dwGuidKind as DWORD, byval pGUID as GUID ptr) as HRESULT
	GetMultiTypeInfoCount as function(byval This as IProvideMultipleClassInfo ptr, byval pcti as ULONG ptr) as HRESULT
	GetInfoOfIndex as function(byval This as IProvideMultipleClassInfo ptr, byval iti as ULONG, byval dwFlags as DWORD, byval pptiCoClass as ITypeInfo ptr ptr, byval pdwTIFlags as DWORD ptr, byval pcdispidReserved as ULONG ptr, byval piidPrimary as IID ptr, byval piidSource as IID ptr) as HRESULT
end type

type IProvideMultipleClassInfo_
	lpVtbl as IProvideMultipleClassInfoVtbl ptr
end type

declare function IProvideMultipleClassInfo_GetMultiTypeInfoCount_Proxy(byval This as IProvideMultipleClassInfo ptr, byval pcti as ULONG ptr) as HRESULT
declare sub IProvideMultipleClassInfo_GetMultiTypeInfoCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IProvideMultipleClassInfo_GetInfoOfIndex_Proxy(byval This as IProvideMultipleClassInfo ptr, byval iti as ULONG, byval dwFlags as DWORD, byval pptiCoClass as ITypeInfo ptr ptr, byval pdwTIFlags as DWORD ptr, byval pcdispidReserved as ULONG ptr, byval piidPrimary as IID ptr, byval piidSource as IID ptr) as HRESULT
declare sub IProvideMultipleClassInfo_GetInfoOfIndex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleControl_INTERFACE_DEFINED__
type IOleControl as IOleControl_
type LPOLECONTROL as IOleControl ptr

type tagCONTROLINFO
	cb as ULONG
	hAccel as HACCEL
	cAccel as USHORT
	dwFlags as DWORD
end type

type CONTROLINFO as tagCONTROLINFO
type LPCONTROLINFO as tagCONTROLINFO ptr

type tagCTRLINFO as long
enum
	CTRLINFO_EATS_RETURN = 1
	CTRLINFO_EATS_ESCAPE = 2
end enum

type CTRLINFO as tagCTRLINFO
extern IID_IOleControl as const GUID

type IOleControlVtbl
	QueryInterface as function(byval This as IOleControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleControl ptr) as ULONG
	Release as function(byval This as IOleControl ptr) as ULONG
	GetControlInfo as function(byval This as IOleControl ptr, byval pCI as CONTROLINFO ptr) as HRESULT
	OnMnemonic as function(byval This as IOleControl ptr, byval pMsg as MSG ptr) as HRESULT
	OnAmbientPropertyChange as function(byval This as IOleControl ptr, byval dispID as DISPID) as HRESULT
	FreezeEvents as function(byval This as IOleControl ptr, byval bFreeze as WINBOOL) as HRESULT
end type

type IOleControl_
	lpVtbl as IOleControlVtbl ptr
end type

declare function IOleControl_GetControlInfo_Proxy(byval This as IOleControl ptr, byval pCI as CONTROLINFO ptr) as HRESULT
declare sub IOleControl_GetControlInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControl_OnMnemonic_Proxy(byval This as IOleControl ptr, byval pMsg as MSG ptr) as HRESULT
declare sub IOleControl_OnMnemonic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControl_OnAmbientPropertyChange_Proxy(byval This as IOleControl ptr, byval dispID as DISPID) as HRESULT
declare sub IOleControl_OnAmbientPropertyChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControl_FreezeEvents_Proxy(byval This as IOleControl ptr, byval bFreeze as WINBOOL) as HRESULT
declare sub IOleControl_FreezeEvents_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleControlSite_INTERFACE_DEFINED__
type IOleControlSite as IOleControlSite_
type LPOLECONTROLSITE as IOleControlSite ptr

type tagPOINTF
	x as FLOAT
	y as FLOAT
end type

type POINTF as tagPOINTF
type LPPOINTF as tagPOINTF ptr

type tagXFORMCOORDS as long
enum
	XFORMCOORDS_POSITION = &h1
	XFORMCOORDS_SIZE = &h2
	XFORMCOORDS_HIMETRICTOCONTAINER = &h4
	XFORMCOORDS_CONTAINERTOHIMETRIC = &h8
	XFORMCOORDS_EVENTCOMPAT = &h10
end enum

type XFORMCOORDS as tagXFORMCOORDS
extern IID_IOleControlSite as const GUID

type IOleControlSiteVtbl
	QueryInterface as function(byval This as IOleControlSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleControlSite ptr) as ULONG
	Release as function(byval This as IOleControlSite ptr) as ULONG
	OnControlInfoChanged as function(byval This as IOleControlSite ptr) as HRESULT
	LockInPlaceActive as function(byval This as IOleControlSite ptr, byval fLock as WINBOOL) as HRESULT
	GetExtendedControl as function(byval This as IOleControlSite ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	TransformCoords as function(byval This as IOleControlSite ptr, byval pPtlHimetric as POINTL ptr, byval pPtfContainer as POINTF ptr, byval dwFlags as DWORD) as HRESULT
	TranslateAccelerator as function(byval This as IOleControlSite ptr, byval pMsg as MSG ptr, byval grfModifiers as DWORD) as HRESULT
	OnFocus as function(byval This as IOleControlSite ptr, byval fGotFocus as WINBOOL) as HRESULT
	ShowPropertyFrame as function(byval This as IOleControlSite ptr) as HRESULT
end type

type IOleControlSite_
	lpVtbl as IOleControlSiteVtbl ptr
end type

declare function IOleControlSite_OnControlInfoChanged_Proxy(byval This as IOleControlSite ptr) as HRESULT
declare sub IOleControlSite_OnControlInfoChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_LockInPlaceActive_Proxy(byval This as IOleControlSite ptr, byval fLock as WINBOOL) as HRESULT
declare sub IOleControlSite_LockInPlaceActive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_GetExtendedControl_Proxy(byval This as IOleControlSite ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IOleControlSite_GetExtendedControl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_TransformCoords_Proxy(byval This as IOleControlSite ptr, byval pPtlHimetric as POINTL ptr, byval pPtfContainer as POINTF ptr, byval dwFlags as DWORD) as HRESULT
declare sub IOleControlSite_TransformCoords_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_TranslateAccelerator_Proxy(byval This as IOleControlSite ptr, byval pMsg as MSG ptr, byval grfModifiers as DWORD) as HRESULT
declare sub IOleControlSite_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_OnFocus_Proxy(byval This as IOleControlSite ptr, byval fGotFocus as WINBOOL) as HRESULT
declare sub IOleControlSite_OnFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleControlSite_ShowPropertyFrame_Proxy(byval This as IOleControlSite ptr) as HRESULT
declare sub IOleControlSite_ShowPropertyFrame_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyPage_INTERFACE_DEFINED__
type IPropertyPage as IPropertyPage_
type LPPROPERTYPAGE as IPropertyPage ptr

type tagPROPPAGEINFO
	cb as ULONG
	pszTitle as LPOLESTR
	size as SIZE
	pszDocString as LPOLESTR
	pszHelpFile as LPOLESTR
	dwHelpContext as DWORD
end type

type PROPPAGEINFO as tagPROPPAGEINFO
type LPPROPPAGEINFO as tagPROPPAGEINFO ptr
extern IID_IPropertyPage as const GUID
type IPropertyPageSite as IPropertyPageSite_

type IPropertyPageVtbl
	QueryInterface as function(byval This as IPropertyPage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyPage ptr) as ULONG
	Release as function(byval This as IPropertyPage ptr) as ULONG
	SetPageSite as function(byval This as IPropertyPage ptr, byval pPageSite as IPropertyPageSite ptr) as HRESULT
	Activate as function(byval This as IPropertyPage ptr, byval hWndParent as HWND, byval pRect as LPCRECT, byval bModal as WINBOOL) as HRESULT
	Deactivate as function(byval This as IPropertyPage ptr) as HRESULT
	GetPageInfo as function(byval This as IPropertyPage ptr, byval pPageInfo as PROPPAGEINFO ptr) as HRESULT
	SetObjects as function(byval This as IPropertyPage ptr, byval cObjects as ULONG, byval ppUnk as IUnknown ptr ptr) as HRESULT
	Show as function(byval This as IPropertyPage ptr, byval nCmdShow as UINT) as HRESULT
	Move as function(byval This as IPropertyPage ptr, byval pRect as LPCRECT) as HRESULT
	IsPageDirty as function(byval This as IPropertyPage ptr) as HRESULT
	Apply as function(byval This as IPropertyPage ptr) as HRESULT
	Help as function(byval This as IPropertyPage ptr, byval pszHelpDir as LPCOLESTR) as HRESULT
	TranslateAccelerator as function(byval This as IPropertyPage ptr, byval pMsg as MSG ptr) as HRESULT
end type

type IPropertyPage_
	lpVtbl as IPropertyPageVtbl ptr
end type

declare function IPropertyPage_SetPageSite_Proxy(byval This as IPropertyPage ptr, byval pPageSite as IPropertyPageSite ptr) as HRESULT
declare sub IPropertyPage_SetPageSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Activate_Proxy(byval This as IPropertyPage ptr, byval hWndParent as HWND, byval pRect as LPCRECT, byval bModal as WINBOOL) as HRESULT
declare sub IPropertyPage_Activate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Deactivate_Proxy(byval This as IPropertyPage ptr) as HRESULT
declare sub IPropertyPage_Deactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_GetPageInfo_Proxy(byval This as IPropertyPage ptr, byval pPageInfo as PROPPAGEINFO ptr) as HRESULT
declare sub IPropertyPage_GetPageInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_SetObjects_Proxy(byval This as IPropertyPage ptr, byval cObjects as ULONG, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IPropertyPage_SetObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Show_Proxy(byval This as IPropertyPage ptr, byval nCmdShow as UINT) as HRESULT
declare sub IPropertyPage_Show_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Move_Proxy(byval This as IPropertyPage ptr, byval pRect as LPCRECT) as HRESULT
declare sub IPropertyPage_Move_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_IsPageDirty_Proxy(byval This as IPropertyPage ptr) as HRESULT
declare sub IPropertyPage_IsPageDirty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Apply_Proxy(byval This as IPropertyPage ptr) as HRESULT
declare sub IPropertyPage_Apply_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_Help_Proxy(byval This as IPropertyPage ptr, byval pszHelpDir as LPCOLESTR) as HRESULT
declare sub IPropertyPage_Help_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPage_TranslateAccelerator_Proxy(byval This as IPropertyPage ptr, byval pMsg as MSG ptr) as HRESULT
declare sub IPropertyPage_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyPage2_INTERFACE_DEFINED__
type IPropertyPage2 as IPropertyPage2_
type LPPROPERTYPAGE2 as IPropertyPage2 ptr
extern IID_IPropertyPage2 as const GUID

type IPropertyPage2Vtbl
	QueryInterface as function(byval This as IPropertyPage2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyPage2 ptr) as ULONG
	Release as function(byval This as IPropertyPage2 ptr) as ULONG
	SetPageSite as function(byval This as IPropertyPage2 ptr, byval pPageSite as IPropertyPageSite ptr) as HRESULT
	Activate as function(byval This as IPropertyPage2 ptr, byval hWndParent as HWND, byval pRect as LPCRECT, byval bModal as WINBOOL) as HRESULT
	Deactivate as function(byval This as IPropertyPage2 ptr) as HRESULT
	GetPageInfo as function(byval This as IPropertyPage2 ptr, byval pPageInfo as PROPPAGEINFO ptr) as HRESULT
	SetObjects as function(byval This as IPropertyPage2 ptr, byval cObjects as ULONG, byval ppUnk as IUnknown ptr ptr) as HRESULT
	Show as function(byval This as IPropertyPage2 ptr, byval nCmdShow as UINT) as HRESULT
	Move as function(byval This as IPropertyPage2 ptr, byval pRect as LPCRECT) as HRESULT
	IsPageDirty as function(byval This as IPropertyPage2 ptr) as HRESULT
	Apply as function(byval This as IPropertyPage2 ptr) as HRESULT
	Help as function(byval This as IPropertyPage2 ptr, byval pszHelpDir as LPCOLESTR) as HRESULT
	TranslateAccelerator as function(byval This as IPropertyPage2 ptr, byval pMsg as MSG ptr) as HRESULT
	EditProperty as function(byval This as IPropertyPage2 ptr, byval dispID as DISPID) as HRESULT
end type

type IPropertyPage2_
	lpVtbl as IPropertyPage2Vtbl ptr
end type

declare function IPropertyPage2_EditProperty_Proxy(byval This as IPropertyPage2 ptr, byval dispID as DISPID) as HRESULT
declare sub IPropertyPage2_EditProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyPageSite_INTERFACE_DEFINED__
type LPPROPERTYPAGESITE as IPropertyPageSite ptr

type tagPROPPAGESTATUS as long
enum
	PROPPAGESTATUS_DIRTY = &h1
	PROPPAGESTATUS_VALIDATE = &h2
	PROPPAGESTATUS_CLEAN = &h4
end enum

type PROPPAGESTATUS as tagPROPPAGESTATUS
extern IID_IPropertyPageSite as const GUID

type IPropertyPageSiteVtbl
	QueryInterface as function(byval This as IPropertyPageSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyPageSite ptr) as ULONG
	Release as function(byval This as IPropertyPageSite ptr) as ULONG
	OnStatusChange as function(byval This as IPropertyPageSite ptr, byval dwFlags as DWORD) as HRESULT
	GetLocaleID as function(byval This as IPropertyPageSite ptr, byval pLocaleID as LCID ptr) as HRESULT
	GetPageContainer as function(byval This as IPropertyPageSite ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
	TranslateAccelerator as function(byval This as IPropertyPageSite ptr, byval pMsg as MSG ptr) as HRESULT
end type

type IPropertyPageSite_
	lpVtbl as IPropertyPageSiteVtbl ptr
end type

declare function IPropertyPageSite_OnStatusChange_Proxy(byval This as IPropertyPageSite ptr, byval dwFlags as DWORD) as HRESULT
declare sub IPropertyPageSite_OnStatusChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPageSite_GetLocaleID_Proxy(byval This as IPropertyPageSite ptr, byval pLocaleID as LCID ptr) as HRESULT
declare sub IPropertyPageSite_GetLocaleID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPageSite_GetPageContainer_Proxy(byval This as IPropertyPageSite ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IPropertyPageSite_GetPageContainer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyPageSite_TranslateAccelerator_Proxy(byval This as IPropertyPageSite ptr, byval pMsg as MSG ptr) as HRESULT
declare sub IPropertyPageSite_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyNotifySink_INTERFACE_DEFINED__
type IPropertyNotifySink as IPropertyNotifySink_
type LPPROPERTYNOTIFYSINK as IPropertyNotifySink ptr
extern IID_IPropertyNotifySink as const GUID

type IPropertyNotifySinkVtbl
	QueryInterface as function(byval This as IPropertyNotifySink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyNotifySink ptr) as ULONG
	Release as function(byval This as IPropertyNotifySink ptr) as ULONG
	OnChanged as function(byval This as IPropertyNotifySink ptr, byval dispID as DISPID) as HRESULT
	OnRequestEdit as function(byval This as IPropertyNotifySink ptr, byval dispID as DISPID) as HRESULT
end type

type IPropertyNotifySink_
	lpVtbl as IPropertyNotifySinkVtbl ptr
end type

declare function IPropertyNotifySink_OnChanged_Proxy(byval This as IPropertyNotifySink ptr, byval dispID as DISPID) as HRESULT
declare sub IPropertyNotifySink_OnChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyNotifySink_OnRequestEdit_Proxy(byval This as IPropertyNotifySink ptr, byval dispID as DISPID) as HRESULT
declare sub IPropertyNotifySink_OnRequestEdit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISpecifyPropertyPages_INTERFACE_DEFINED__
type ISpecifyPropertyPages as ISpecifyPropertyPages_
type LPSPECIFYPROPERTYPAGES as ISpecifyPropertyPages ptr

type tagCAUUID
	cElems as ULONG
	pElems as GUID ptr
end type

type CAUUID as tagCAUUID
type LPCAUUID as tagCAUUID ptr
extern IID_ISpecifyPropertyPages as const GUID

type ISpecifyPropertyPagesVtbl
	QueryInterface as function(byval This as ISpecifyPropertyPages ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISpecifyPropertyPages ptr) as ULONG
	Release as function(byval This as ISpecifyPropertyPages ptr) as ULONG
	GetPages as function(byval This as ISpecifyPropertyPages ptr, byval pPages as CAUUID ptr) as HRESULT
end type

type ISpecifyPropertyPages_
	lpVtbl as ISpecifyPropertyPagesVtbl ptr
end type

declare function ISpecifyPropertyPages_GetPages_Proxy(byval This as ISpecifyPropertyPages ptr, byval pPages as CAUUID ptr) as HRESULT
declare sub ISpecifyPropertyPages_GetPages_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistMemory_INTERFACE_DEFINED__
type IPersistMemory as IPersistMemory_
type LPPERSISTMEMORY as IPersistMemory ptr
extern IID_IPersistMemory as const GUID

type IPersistMemoryVtbl
	QueryInterface as function(byval This as IPersistMemory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistMemory ptr) as ULONG
	Release as function(byval This as IPersistMemory ptr) as ULONG
	GetClassID as function(byval This as IPersistMemory ptr, byval pClassID as CLSID ptr) as HRESULT
	IsDirty as function(byval This as IPersistMemory ptr) as HRESULT
	Load as function(byval This as IPersistMemory ptr, byval pMem as LPVOID, byval cbSize as ULONG) as HRESULT
	Save as function(byval This as IPersistMemory ptr, byval pMem as LPVOID, byval fClearDirty as WINBOOL, byval cbSize as ULONG) as HRESULT
	GetSizeMax as function(byval This as IPersistMemory ptr, byval pCbSize as ULONG ptr) as HRESULT
	InitNew as function(byval This as IPersistMemory ptr) as HRESULT
end type

type IPersistMemory_
	lpVtbl as IPersistMemoryVtbl ptr
end type

declare function IPersistMemory_IsDirty_Proxy(byval This as IPersistMemory ptr) as HRESULT
declare sub IPersistMemory_IsDirty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMemory_RemoteLoad_Proxy(byval This as IPersistMemory ptr, byval pMem as UBYTE ptr, byval cbSize as ULONG) as HRESULT
declare sub IPersistMemory_RemoteLoad_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMemory_RemoteSave_Proxy(byval This as IPersistMemory ptr, byval pMem as UBYTE ptr, byval fClearDirty as WINBOOL, byval cbSize as ULONG) as HRESULT
declare sub IPersistMemory_RemoteSave_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMemory_GetSizeMax_Proxy(byval This as IPersistMemory ptr, byval pCbSize as ULONG ptr) as HRESULT
declare sub IPersistMemory_GetSizeMax_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMemory_InitNew_Proxy(byval This as IPersistMemory ptr) as HRESULT
declare sub IPersistMemory_InitNew_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMemory_Load_Proxy(byval This as IPersistMemory ptr, byval pMem as LPVOID, byval cbSize as ULONG) as HRESULT
declare function IPersistMemory_Load_Stub(byval This as IPersistMemory ptr, byval pMem as UBYTE ptr, byval cbSize as ULONG) as HRESULT
declare function IPersistMemory_Save_Proxy(byval This as IPersistMemory ptr, byval pMem as LPVOID, byval fClearDirty as WINBOOL, byval cbSize as ULONG) as HRESULT
declare function IPersistMemory_Save_Stub(byval This as IPersistMemory ptr, byval pMem as UBYTE ptr, byval fClearDirty as WINBOOL, byval cbSize as ULONG) as HRESULT
#define __IPersistStreamInit_INTERFACE_DEFINED__
type IPersistStreamInit as IPersistStreamInit_
type LPPERSISTSTREAMINIT as IPersistStreamInit ptr
extern IID_IPersistStreamInit as const GUID

type IPersistStreamInitVtbl
	QueryInterface as function(byval This as IPersistStreamInit ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistStreamInit ptr) as ULONG
	Release as function(byval This as IPersistStreamInit ptr) as ULONG
	GetClassID as function(byval This as IPersistStreamInit ptr, byval pClassID as CLSID ptr) as HRESULT
	IsDirty as function(byval This as IPersistStreamInit ptr) as HRESULT
	Load as function(byval This as IPersistStreamInit ptr, byval pStm as LPSTREAM) as HRESULT
	Save as function(byval This as IPersistStreamInit ptr, byval pStm as LPSTREAM, byval fClearDirty as WINBOOL) as HRESULT
	GetSizeMax as function(byval This as IPersistStreamInit ptr, byval pCbSize as ULARGE_INTEGER ptr) as HRESULT
	InitNew as function(byval This as IPersistStreamInit ptr) as HRESULT
end type

type IPersistStreamInit_
	lpVtbl as IPersistStreamInitVtbl ptr
end type

declare function IPersistStreamInit_IsDirty_Proxy(byval This as IPersistStreamInit ptr) as HRESULT
declare sub IPersistStreamInit_IsDirty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistStreamInit_Load_Proxy(byval This as IPersistStreamInit ptr, byval pStm as LPSTREAM) as HRESULT
declare sub IPersistStreamInit_Load_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistStreamInit_Save_Proxy(byval This as IPersistStreamInit ptr, byval pStm as LPSTREAM, byval fClearDirty as WINBOOL) as HRESULT
declare sub IPersistStreamInit_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistStreamInit_GetSizeMax_Proxy(byval This as IPersistStreamInit ptr, byval pCbSize as ULARGE_INTEGER ptr) as HRESULT
declare sub IPersistStreamInit_GetSizeMax_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistStreamInit_InitNew_Proxy(byval This as IPersistStreamInit ptr) as HRESULT
declare sub IPersistStreamInit_InitNew_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistPropertyBag_INTERFACE_DEFINED__
type IPersistPropertyBag as IPersistPropertyBag_
type LPPERSISTPROPERTYBAG as IPersistPropertyBag ptr
extern IID_IPersistPropertyBag as const GUID

type IPersistPropertyBagVtbl
	QueryInterface as function(byval This as IPersistPropertyBag ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistPropertyBag ptr) as ULONG
	Release as function(byval This as IPersistPropertyBag ptr) as ULONG
	GetClassID as function(byval This as IPersistPropertyBag ptr, byval pClassID as CLSID ptr) as HRESULT
	InitNew as function(byval This as IPersistPropertyBag ptr) as HRESULT
	Load as function(byval This as IPersistPropertyBag ptr, byval pPropBag as IPropertyBag ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
	Save as function(byval This as IPersistPropertyBag ptr, byval pPropBag as IPropertyBag ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
end type

type IPersistPropertyBag_
	lpVtbl as IPersistPropertyBagVtbl ptr
end type

declare function IPersistPropertyBag_InitNew_Proxy(byval This as IPersistPropertyBag ptr) as HRESULT
declare sub IPersistPropertyBag_InitNew_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistPropertyBag_Load_Proxy(byval This as IPersistPropertyBag ptr, byval pPropBag as IPropertyBag ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
declare sub IPersistPropertyBag_Load_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistPropertyBag_Save_Proxy(byval This as IPersistPropertyBag ptr, byval pPropBag as IPropertyBag ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
declare sub IPersistPropertyBag_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISimpleFrameSite_INTERFACE_DEFINED__
type ISimpleFrameSite as ISimpleFrameSite_
type LPSIMPLEFRAMESITE as ISimpleFrameSite ptr
extern IID_ISimpleFrameSite as const GUID

type ISimpleFrameSiteVtbl
	QueryInterface as function(byval This as ISimpleFrameSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISimpleFrameSite ptr) as ULONG
	Release as function(byval This as ISimpleFrameSite ptr) as ULONG
	PreMessageFilter as function(byval This as ISimpleFrameSite ptr, byval hWnd as HWND, byval msg as UINT, byval wp as WPARAM, byval lp as LPARAM, byval plResult as LRESULT ptr, byval pdwCookie as DWORD ptr) as HRESULT
	PostMessageFilter as function(byval This as ISimpleFrameSite ptr, byval hWnd as HWND, byval msg as UINT, byval wp as WPARAM, byval lp as LPARAM, byval plResult as LRESULT ptr, byval dwCookie as DWORD) as HRESULT
end type

type ISimpleFrameSite_
	lpVtbl as ISimpleFrameSiteVtbl ptr
end type

declare function ISimpleFrameSite_PreMessageFilter_Proxy(byval This as ISimpleFrameSite ptr, byval hWnd as HWND, byval msg as UINT, byval wp as WPARAM, byval lp as LPARAM, byval plResult as LRESULT ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub ISimpleFrameSite_PreMessageFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISimpleFrameSite_PostMessageFilter_Proxy(byval This as ISimpleFrameSite ptr, byval hWnd as HWND, byval msg as UINT, byval wp as WPARAM, byval lp as LPARAM, byval plResult as LRESULT ptr, byval dwCookie as DWORD) as HRESULT
declare sub ISimpleFrameSite_PostMessageFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFont_INTERFACE_DEFINED__

type IFont as IFont_
type LPFONT as IFont ptr
type TEXTMETRICOLE as TEXTMETRICW
type LPTEXTMETRICOLE as TEXTMETRICOLE ptr
extern IID_IFont as const GUID

type IFontVtbl
	QueryInterface as function(byval This as IFont ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFont ptr) as ULONG
	Release as function(byval This as IFont ptr) as ULONG
	get_Name as function(byval This as IFont ptr, byval pName as BSTR ptr) as HRESULT
	put_Name as function(byval This as IFont ptr, byval name as BSTR) as HRESULT
	get_Size as function(byval This as IFont ptr, byval pSize as CY ptr) as HRESULT
	put_Size as function(byval This as IFont ptr, byval size as CY) as HRESULT
	get_Bold as function(byval This as IFont ptr, byval pBold as WINBOOL ptr) as HRESULT
	put_Bold as function(byval This as IFont ptr, byval bold as WINBOOL) as HRESULT
	get_Italic as function(byval This as IFont ptr, byval pItalic as WINBOOL ptr) as HRESULT
	put_Italic as function(byval This as IFont ptr, byval italic as WINBOOL) as HRESULT
	get_Underline as function(byval This as IFont ptr, byval pUnderline as WINBOOL ptr) as HRESULT
	put_Underline as function(byval This as IFont ptr, byval underline as WINBOOL) as HRESULT
	get_Strikethrough as function(byval This as IFont ptr, byval pStrikethrough as WINBOOL ptr) as HRESULT
	put_Strikethrough as function(byval This as IFont ptr, byval strikethrough as WINBOOL) as HRESULT
	get_Weight as function(byval This as IFont ptr, byval pWeight as SHORT ptr) as HRESULT
	put_Weight as function(byval This as IFont ptr, byval weight as SHORT) as HRESULT
	get_Charset as function(byval This as IFont ptr, byval pCharset as SHORT ptr) as HRESULT
	put_Charset as function(byval This as IFont ptr, byval charset as SHORT) as HRESULT
	get_hFont as function(byval This as IFont ptr, byval phFont as HFONT ptr) as HRESULT
	Clone as function(byval This as IFont ptr, byval ppFont as IFont ptr ptr) as HRESULT
	IsEqual as function(byval This as IFont ptr, byval pFontOther as IFont ptr) as HRESULT
	SetRatio as function(byval This as IFont ptr, byval cyLogical as LONG, byval cyHimetric as LONG) as HRESULT
	QueryTextMetrics as function(byval This as IFont ptr, byval pTM as TEXTMETRICOLE ptr) as HRESULT
	AddRefHfont as function(byval This as IFont ptr, byval hFont as HFONT) as HRESULT
	ReleaseHfont as function(byval This as IFont ptr, byval hFont as HFONT) as HRESULT
	SetHdc as function(byval This as IFont ptr, byval hDC as HDC) as HRESULT
end type

type IFont_
	lpVtbl as IFontVtbl ptr
end type

declare function IFont_get_Name_Proxy(byval This as IFont ptr, byval pName as BSTR ptr) as HRESULT
declare sub IFont_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Name_Proxy(byval This as IFont ptr, byval name as BSTR) as HRESULT
declare sub IFont_put_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Size_Proxy(byval This as IFont ptr, byval pSize as CY ptr) as HRESULT
declare sub IFont_get_Size_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Size_Proxy(byval This as IFont ptr, byval size as CY) as HRESULT
declare sub IFont_put_Size_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Bold_Proxy(byval This as IFont ptr, byval pBold as WINBOOL ptr) as HRESULT
declare sub IFont_get_Bold_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Bold_Proxy(byval This as IFont ptr, byval bold as WINBOOL) as HRESULT
declare sub IFont_put_Bold_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Italic_Proxy(byval This as IFont ptr, byval pItalic as WINBOOL ptr) as HRESULT
declare sub IFont_get_Italic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Italic_Proxy(byval This as IFont ptr, byval italic as WINBOOL) as HRESULT
declare sub IFont_put_Italic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Underline_Proxy(byval This as IFont ptr, byval pUnderline as WINBOOL ptr) as HRESULT
declare sub IFont_get_Underline_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Underline_Proxy(byval This as IFont ptr, byval underline as WINBOOL) as HRESULT
declare sub IFont_put_Underline_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Strikethrough_Proxy(byval This as IFont ptr, byval pStrikethrough as WINBOOL ptr) as HRESULT
declare sub IFont_get_Strikethrough_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Strikethrough_Proxy(byval This as IFont ptr, byval strikethrough as WINBOOL) as HRESULT
declare sub IFont_put_Strikethrough_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Weight_Proxy(byval This as IFont ptr, byval pWeight as SHORT ptr) as HRESULT
declare sub IFont_get_Weight_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Weight_Proxy(byval This as IFont ptr, byval weight as SHORT) as HRESULT
declare sub IFont_put_Weight_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_Charset_Proxy(byval This as IFont ptr, byval pCharset as SHORT ptr) as HRESULT
declare sub IFont_get_Charset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_put_Charset_Proxy(byval This as IFont ptr, byval charset as SHORT) as HRESULT
declare sub IFont_put_Charset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_get_hFont_Proxy(byval This as IFont ptr, byval phFont as HFONT ptr) as HRESULT
declare sub IFont_get_hFont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_Clone_Proxy(byval This as IFont ptr, byval ppFont as IFont ptr ptr) as HRESULT
declare sub IFont_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_IsEqual_Proxy(byval This as IFont ptr, byval pFontOther as IFont ptr) as HRESULT
declare sub IFont_IsEqual_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_SetRatio_Proxy(byval This as IFont ptr, byval cyLogical as LONG, byval cyHimetric as LONG) as HRESULT
declare sub IFont_SetRatio_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_QueryTextMetrics_Proxy(byval This as IFont ptr, byval pTM as TEXTMETRICOLE ptr) as HRESULT
declare sub IFont_QueryTextMetrics_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_AddRefHfont_Proxy(byval This as IFont ptr, byval hFont as HFONT) as HRESULT
declare sub IFont_AddRefHfont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_ReleaseHfont_Proxy(byval This as IFont ptr, byval hFont as HFONT) as HRESULT
declare sub IFont_ReleaseHfont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFont_SetHdc_Proxy(byval This as IFont ptr, byval hDC as HDC) as HRESULT
declare sub IFont_SetHdc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPicture_INTERFACE_DEFINED__
type IPicture as IPicture_
type LPPICTURE as IPicture ptr

type tagPictureAttributes as long
enum
	PICTURE_SCALABLE = &h1
	PICTURE_TRANSPARENT = &h2
end enum

type PICTUREATTRIBUTES as tagPictureAttributes
type OLE_HANDLE as UINT
type OLE_XPOS_HIMETRIC as LONG
type OLE_YPOS_HIMETRIC as LONG
type OLE_XSIZE_HIMETRIC as LONG
type OLE_YSIZE_HIMETRIC as LONG
extern IID_IPicture as const GUID

type IPictureVtbl
	QueryInterface as function(byval This as IPicture ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPicture ptr) as ULONG
	Release as function(byval This as IPicture ptr) as ULONG
	get_Handle as function(byval This as IPicture ptr, byval pHandle as OLE_HANDLE ptr) as HRESULT
	get_hPal as function(byval This as IPicture ptr, byval phPal as OLE_HANDLE ptr) as HRESULT
	get_Type as function(byval This as IPicture ptr, byval pType as SHORT ptr) as HRESULT
	get_Width as function(byval This as IPicture ptr, byval pWidth as OLE_XSIZE_HIMETRIC ptr) as HRESULT
	get_Height as function(byval This as IPicture ptr, byval pHeight as OLE_YSIZE_HIMETRIC ptr) as HRESULT
	Render as function(byval This as IPicture ptr, byval hDC as HDC, byval x as LONG, byval y as LONG, byval cx as LONG, byval cy as LONG, byval xSrc as OLE_XPOS_HIMETRIC, byval ySrc as OLE_YPOS_HIMETRIC, byval cxSrc as OLE_XSIZE_HIMETRIC, byval cySrc as OLE_YSIZE_HIMETRIC, byval pRcWBounds as LPCRECT) as HRESULT
	set_hPal as function(byval This as IPicture ptr, byval hPal as OLE_HANDLE) as HRESULT
	get_CurDC as function(byval This as IPicture ptr, byval phDC as HDC ptr) as HRESULT
	SelectPicture as function(byval This as IPicture ptr, byval hDCIn as HDC, byval phDCOut as HDC ptr, byval phBmpOut as OLE_HANDLE ptr) as HRESULT
	get_KeepOriginalFormat as function(byval This as IPicture ptr, byval pKeep as WINBOOL ptr) as HRESULT
	put_KeepOriginalFormat as function(byval This as IPicture ptr, byval keep as WINBOOL) as HRESULT
	PictureChanged as function(byval This as IPicture ptr) as HRESULT
	SaveAsFile as function(byval This as IPicture ptr, byval pStream as LPSTREAM, byval fSaveMemCopy as WINBOOL, byval pCbSize as LONG ptr) as HRESULT
	get_Attributes as function(byval This as IPicture ptr, byval pDwAttr as DWORD ptr) as HRESULT
end type

type IPicture_
	lpVtbl as IPictureVtbl ptr
end type

declare function IPicture_get_Handle_Proxy(byval This as IPicture ptr, byval pHandle as OLE_HANDLE ptr) as HRESULT
declare sub IPicture_get_Handle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_hPal_Proxy(byval This as IPicture ptr, byval phPal as OLE_HANDLE ptr) as HRESULT
declare sub IPicture_get_hPal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_Type_Proxy(byval This as IPicture ptr, byval pType as SHORT ptr) as HRESULT
declare sub IPicture_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_Width_Proxy(byval This as IPicture ptr, byval pWidth as OLE_XSIZE_HIMETRIC ptr) as HRESULT
declare sub IPicture_get_Width_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_Height_Proxy(byval This as IPicture ptr, byval pHeight as OLE_YSIZE_HIMETRIC ptr) as HRESULT
declare sub IPicture_get_Height_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_Render_Proxy(byval This as IPicture ptr, byval hDC as HDC, byval x as LONG, byval y as LONG, byval cx as LONG, byval cy as LONG, byval xSrc as OLE_XPOS_HIMETRIC, byval ySrc as OLE_YPOS_HIMETRIC, byval cxSrc as OLE_XSIZE_HIMETRIC, byval cySrc as OLE_YSIZE_HIMETRIC, byval pRcWBounds as LPCRECT) as HRESULT
declare sub IPicture_Render_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_set_hPal_Proxy(byval This as IPicture ptr, byval hPal as OLE_HANDLE) as HRESULT
declare sub IPicture_set_hPal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_CurDC_Proxy(byval This as IPicture ptr, byval phDC as HDC ptr) as HRESULT
declare sub IPicture_get_CurDC_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_SelectPicture_Proxy(byval This as IPicture ptr, byval hDCIn as HDC, byval phDCOut as HDC ptr, byval phBmpOut as OLE_HANDLE ptr) as HRESULT
declare sub IPicture_SelectPicture_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_KeepOriginalFormat_Proxy(byval This as IPicture ptr, byval pKeep as WINBOOL ptr) as HRESULT
declare sub IPicture_get_KeepOriginalFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_put_KeepOriginalFormat_Proxy(byval This as IPicture ptr, byval keep as WINBOOL) as HRESULT
declare sub IPicture_put_KeepOriginalFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_PictureChanged_Proxy(byval This as IPicture ptr) as HRESULT
declare sub IPicture_PictureChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_SaveAsFile_Proxy(byval This as IPicture ptr, byval pStream as LPSTREAM, byval fSaveMemCopy as WINBOOL, byval pCbSize as LONG ptr) as HRESULT
declare sub IPicture_SaveAsFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture_get_Attributes_Proxy(byval This as IPicture ptr, byval pDwAttr as DWORD ptr) as HRESULT
declare sub IPicture_get_Attributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPicture2_INTERFACE_DEFINED__

type IPicture2 as IPicture2_
type LPPICTURE2 as IPicture2 ptr
type HHANDLE as UINT_PTR
extern IID_IPicture2 as const GUID

type IPicture2Vtbl
	QueryInterface as function(byval This as IPicture2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPicture2 ptr) as ULONG
	Release as function(byval This as IPicture2 ptr) as ULONG
	get_Handle as function(byval This as IPicture2 ptr, byval pHandle as HHANDLE ptr) as HRESULT
	get_hPal as function(byval This as IPicture2 ptr, byval phPal as HHANDLE ptr) as HRESULT
	get_Type as function(byval This as IPicture2 ptr, byval pType as SHORT ptr) as HRESULT
	get_Width as function(byval This as IPicture2 ptr, byval pWidth as OLE_XSIZE_HIMETRIC ptr) as HRESULT
	get_Height as function(byval This as IPicture2 ptr, byval pHeight as OLE_YSIZE_HIMETRIC ptr) as HRESULT
	Render as function(byval This as IPicture2 ptr, byval hDC as HDC, byval x as LONG, byval y as LONG, byval cx as LONG, byval cy as LONG, byval xSrc as OLE_XPOS_HIMETRIC, byval ySrc as OLE_YPOS_HIMETRIC, byval cxSrc as OLE_XSIZE_HIMETRIC, byval cySrc as OLE_YSIZE_HIMETRIC, byval pRcWBounds as LPCRECT) as HRESULT
	set_hPal as function(byval This as IPicture2 ptr, byval hPal as HHANDLE) as HRESULT
	get_CurDC as function(byval This as IPicture2 ptr, byval phDC as HDC ptr) as HRESULT
	SelectPicture as function(byval This as IPicture2 ptr, byval hDCIn as HDC, byval phDCOut as HDC ptr, byval phBmpOut as HHANDLE ptr) as HRESULT
	get_KeepOriginalFormat as function(byval This as IPicture2 ptr, byval pKeep as WINBOOL ptr) as HRESULT
	put_KeepOriginalFormat as function(byval This as IPicture2 ptr, byval keep as WINBOOL) as HRESULT
	PictureChanged as function(byval This as IPicture2 ptr) as HRESULT
	SaveAsFile as function(byval This as IPicture2 ptr, byval pStream as LPSTREAM, byval fSaveMemCopy as WINBOOL, byval pCbSize as LONG ptr) as HRESULT
	get_Attributes as function(byval This as IPicture2 ptr, byval pDwAttr as DWORD ptr) as HRESULT
end type

type IPicture2_
	lpVtbl as IPicture2Vtbl ptr
end type

declare function IPicture2_get_Handle_Proxy(byval This as IPicture2 ptr, byval pHandle as HHANDLE ptr) as HRESULT
declare sub IPicture2_get_Handle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_hPal_Proxy(byval This as IPicture2 ptr, byval phPal as HHANDLE ptr) as HRESULT
declare sub IPicture2_get_hPal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_Type_Proxy(byval This as IPicture2 ptr, byval pType as SHORT ptr) as HRESULT
declare sub IPicture2_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_Width_Proxy(byval This as IPicture2 ptr, byval pWidth as OLE_XSIZE_HIMETRIC ptr) as HRESULT
declare sub IPicture2_get_Width_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_Height_Proxy(byval This as IPicture2 ptr, byval pHeight as OLE_YSIZE_HIMETRIC ptr) as HRESULT
declare sub IPicture2_get_Height_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_Render_Proxy(byval This as IPicture2 ptr, byval hDC as HDC, byval x as LONG, byval y as LONG, byval cx as LONG, byval cy as LONG, byval xSrc as OLE_XPOS_HIMETRIC, byval ySrc as OLE_YPOS_HIMETRIC, byval cxSrc as OLE_XSIZE_HIMETRIC, byval cySrc as OLE_YSIZE_HIMETRIC, byval pRcWBounds as LPCRECT) as HRESULT
declare sub IPicture2_Render_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_set_hPal_Proxy(byval This as IPicture2 ptr, byval hPal as HHANDLE) as HRESULT
declare sub IPicture2_set_hPal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_CurDC_Proxy(byval This as IPicture2 ptr, byval phDC as HDC ptr) as HRESULT
declare sub IPicture2_get_CurDC_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_SelectPicture_Proxy(byval This as IPicture2 ptr, byval hDCIn as HDC, byval phDCOut as HDC ptr, byval phBmpOut as HHANDLE ptr) as HRESULT
declare sub IPicture2_SelectPicture_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_KeepOriginalFormat_Proxy(byval This as IPicture2 ptr, byval pKeep as WINBOOL ptr) as HRESULT
declare sub IPicture2_get_KeepOriginalFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_put_KeepOriginalFormat_Proxy(byval This as IPicture2 ptr, byval keep as WINBOOL) as HRESULT
declare sub IPicture2_put_KeepOriginalFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_PictureChanged_Proxy(byval This as IPicture2 ptr) as HRESULT
declare sub IPicture2_PictureChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_SaveAsFile_Proxy(byval This as IPicture2 ptr, byval pStream as LPSTREAM, byval fSaveMemCopy as WINBOOL, byval pCbSize as LONG ptr) as HRESULT
declare sub IPicture2_SaveAsFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPicture2_get_Attributes_Proxy(byval This as IPicture2 ptr, byval pDwAttr as DWORD ptr) as HRESULT
declare sub IPicture2_get_Attributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFontEventsDisp_INTERFACE_DEFINED__
type IFontEventsDisp as IFontEventsDisp_
type LPFONTEVENTS as IFontEventsDisp ptr
extern IID_IFontEventsDisp as const GUID

type IFontEventsDispVtbl
	QueryInterface as function(byval This as IFontEventsDisp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFontEventsDisp ptr) as ULONG
	Release as function(byval This as IFontEventsDisp ptr) as ULONG
	GetTypeInfoCount as function(byval This as IFontEventsDisp ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IFontEventsDisp ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IFontEventsDisp ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IFontEventsDisp ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type IFontEventsDisp_
	lpVtbl as IFontEventsDispVtbl ptr
end type

#define __IFontDisp_INTERFACE_DEFINED__
type IFontDisp as IFontDisp_
type LPFONTDISP as IFontDisp ptr
extern IID_IFontDisp as const GUID

type IFontDispVtbl
	QueryInterface as function(byval This as IFontDisp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFontDisp ptr) as ULONG
	Release as function(byval This as IFontDisp ptr) as ULONG
	GetTypeInfoCount as function(byval This as IFontDisp ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IFontDisp ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IFontDisp ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IFontDisp ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type IFontDisp_
	lpVtbl as IFontDispVtbl ptr
end type

#define __IPictureDisp_INTERFACE_DEFINED__
type IPictureDisp as IPictureDisp_
type LPPICTUREDISP as IPictureDisp ptr
extern IID_IPictureDisp as const GUID

type IPictureDispVtbl
	QueryInterface as function(byval This as IPictureDisp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPictureDisp ptr) as ULONG
	Release as function(byval This as IPictureDisp ptr) as ULONG
	GetTypeInfoCount as function(byval This as IPictureDisp ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IPictureDisp ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IPictureDisp ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IPictureDisp ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type IPictureDisp_
	lpVtbl as IPictureDispVtbl ptr
end type

#define __IOleInPlaceObjectWindowless_INTERFACE_DEFINED__
type IOleInPlaceObjectWindowless as IOleInPlaceObjectWindowless_
type LPOLEINPLACEOBJECTWINDOWLESS as IOleInPlaceObjectWindowless ptr
extern IID_IOleInPlaceObjectWindowless as const GUID

type IOleInPlaceObjectWindowlessVtbl
	QueryInterface as function(byval This as IOleInPlaceObjectWindowless ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceObjectWindowless ptr) as ULONG
	Release as function(byval This as IOleInPlaceObjectWindowless ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceObjectWindowless ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceObjectWindowless ptr, byval fEnterMode as WINBOOL) as HRESULT
	InPlaceDeactivate as function(byval This as IOleInPlaceObjectWindowless ptr) as HRESULT
	UIDeactivate as function(byval This as IOleInPlaceObjectWindowless ptr) as HRESULT
	SetObjectRects as function(byval This as IOleInPlaceObjectWindowless ptr, byval lprcPosRect as LPCRECT, byval lprcClipRect as LPCRECT) as HRESULT
	ReactivateAndUndo as function(byval This as IOleInPlaceObjectWindowless ptr) as HRESULT
	OnWindowMessage as function(byval This as IOleInPlaceObjectWindowless ptr, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	GetDropTarget as function(byval This as IOleInPlaceObjectWindowless ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
end type

type IOleInPlaceObjectWindowless_
	lpVtbl as IOleInPlaceObjectWindowlessVtbl ptr
end type

declare function IOleInPlaceObjectWindowless_OnWindowMessage_Proxy(byval This as IOleInPlaceObjectWindowless ptr, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IOleInPlaceObjectWindowless_OnWindowMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceObjectWindowless_GetDropTarget_Proxy(byval This as IOleInPlaceObjectWindowless ptr, byval ppDropTarget as IDropTarget ptr ptr) as HRESULT
declare sub IOleInPlaceObjectWindowless_GetDropTarget_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceSiteEx_INTERFACE_DEFINED__
type IOleInPlaceSiteEx as IOleInPlaceSiteEx_
type LPOLEINPLACESITEEX as IOleInPlaceSiteEx ptr

type tagACTIVATEFLAGS as long
enum
	ACTIVATE_WINDOWLESS = 1
end enum

type ACTIVATEFLAGS as tagACTIVATEFLAGS
extern IID_IOleInPlaceSiteEx as const GUID

type IOleInPlaceSiteExVtbl
	QueryInterface as function(byval This as IOleInPlaceSiteEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceSiteEx ptr) as ULONG
	Release as function(byval This as IOleInPlaceSiteEx ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceSiteEx ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceSiteEx ptr, byval fEnterMode as WINBOOL) as HRESULT
	CanInPlaceActivate as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	OnInPlaceActivate as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	OnUIActivate as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	GetWindowContext as function(byval This as IOleInPlaceSiteEx ptr, byval ppFrame as IOleInPlaceFrame ptr ptr, byval ppDoc as IOleInPlaceUIWindow ptr ptr, byval lprcPosRect as LPRECT, byval lprcClipRect as LPRECT, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function(byval This as IOleInPlaceSiteEx ptr, byval scrollExtant as SIZE) as HRESULT
	OnUIDeactivate as function(byval This as IOleInPlaceSiteEx ptr, byval fUndoable as WINBOOL) as HRESULT
	OnInPlaceDeactivate as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	DiscardUndoState as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	DeactivateAndUndo as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
	OnPosRectChange as function(byval This as IOleInPlaceSiteEx ptr, byval lprcPosRect as LPCRECT) as HRESULT
	OnInPlaceActivateEx as function(byval This as IOleInPlaceSiteEx ptr, byval pfNoRedraw as WINBOOL ptr, byval dwFlags as DWORD) as HRESULT
	OnInPlaceDeactivateEx as function(byval This as IOleInPlaceSiteEx ptr, byval fNoRedraw as WINBOOL) as HRESULT
	RequestUIActivate as function(byval This as IOleInPlaceSiteEx ptr) as HRESULT
end type

type IOleInPlaceSiteEx_
	lpVtbl as IOleInPlaceSiteExVtbl ptr
end type

declare function IOleInPlaceSiteEx_OnInPlaceActivateEx_Proxy(byval This as IOleInPlaceSiteEx ptr, byval pfNoRedraw as WINBOOL ptr, byval dwFlags as DWORD) as HRESULT
declare sub IOleInPlaceSiteEx_OnInPlaceActivateEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteEx_OnInPlaceDeactivateEx_Proxy(byval This as IOleInPlaceSiteEx ptr, byval fNoRedraw as WINBOOL) as HRESULT
declare sub IOleInPlaceSiteEx_OnInPlaceDeactivateEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteEx_RequestUIActivate_Proxy(byval This as IOleInPlaceSiteEx ptr) as HRESULT
declare sub IOleInPlaceSiteEx_RequestUIActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleInPlaceSiteWindowless_INTERFACE_DEFINED__
type IOleInPlaceSiteWindowless as IOleInPlaceSiteWindowless_
type LPOLEINPLACESITEWINDOWLESS as IOleInPlaceSiteWindowless ptr

type tagOLEDCFLAGS as long
enum
	OLEDC_NODRAW = &h1
	OLEDC_PAINTBKGND = &h2
	OLEDC_OFFSCREEN = &h4
end enum

type OLEDCFLAGS as tagOLEDCFLAGS
extern IID_IOleInPlaceSiteWindowless as const GUID

type IOleInPlaceSiteWindowlessVtbl
	QueryInterface as function(byval This as IOleInPlaceSiteWindowless ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleInPlaceSiteWindowless ptr) as ULONG
	Release as function(byval This as IOleInPlaceSiteWindowless ptr) as ULONG
	GetWindow as function(byval This as IOleInPlaceSiteWindowless ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IOleInPlaceSiteWindowless ptr, byval fEnterMode as WINBOOL) as HRESULT
	CanInPlaceActivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnInPlaceActivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnUIActivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	GetWindowContext as function(byval This as IOleInPlaceSiteWindowless ptr, byval ppFrame as IOleInPlaceFrame ptr ptr, byval ppDoc as IOleInPlaceUIWindow ptr ptr, byval lprcPosRect as LPRECT, byval lprcClipRect as LPRECT, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function(byval This as IOleInPlaceSiteWindowless ptr, byval scrollExtant as SIZE) as HRESULT
	OnUIDeactivate as function(byval This as IOleInPlaceSiteWindowless ptr, byval fUndoable as WINBOOL) as HRESULT
	OnInPlaceDeactivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	DiscardUndoState as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	DeactivateAndUndo as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnPosRectChange as function(byval This as IOleInPlaceSiteWindowless ptr, byval lprcPosRect as LPCRECT) as HRESULT
	OnInPlaceActivateEx as function(byval This as IOleInPlaceSiteWindowless ptr, byval pfNoRedraw as WINBOOL ptr, byval dwFlags as DWORD) as HRESULT
	OnInPlaceDeactivateEx as function(byval This as IOleInPlaceSiteWindowless ptr, byval fNoRedraw as WINBOOL) as HRESULT
	RequestUIActivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	CanWindowlessActivate as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	GetCapture as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	SetCapture as function(byval This as IOleInPlaceSiteWindowless ptr, byval fCapture as WINBOOL) as HRESULT
	GetFocus as function(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
	SetFocus as function(byval This as IOleInPlaceSiteWindowless ptr, byval fFocus as WINBOOL) as HRESULT
	GetDC as function(byval This as IOleInPlaceSiteWindowless ptr, byval pRect as LPCRECT, byval grfFlags as DWORD, byval phDC as HDC ptr) as HRESULT
	ReleaseDC as function(byval This as IOleInPlaceSiteWindowless ptr, byval hDC as HDC) as HRESULT
	InvalidateRect as function(byval This as IOleInPlaceSiteWindowless ptr, byval pRect as LPCRECT, byval fErase as WINBOOL) as HRESULT
	InvalidateRgn as function(byval This as IOleInPlaceSiteWindowless ptr, byval hRGN as HRGN, byval fErase as WINBOOL) as HRESULT
	ScrollRect as function(byval This as IOleInPlaceSiteWindowless ptr, byval dx as INT_, byval dy as INT_, byval pRectScroll as LPCRECT, byval pRectClip as LPCRECT) as HRESULT
	AdjustRect as function(byval This as IOleInPlaceSiteWindowless ptr, byval prc as LPRECT) as HRESULT
	OnDefWindowMessage as function(byval This as IOleInPlaceSiteWindowless ptr, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
end type

type IOleInPlaceSiteWindowless_
	lpVtbl as IOleInPlaceSiteWindowlessVtbl ptr
end type

declare function IOleInPlaceSiteWindowless_CanWindowlessActivate_Proxy(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
declare sub IOleInPlaceSiteWindowless_CanWindowlessActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_GetCapture_Proxy(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
declare sub IOleInPlaceSiteWindowless_GetCapture_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_SetCapture_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval fCapture as WINBOOL) as HRESULT
declare sub IOleInPlaceSiteWindowless_SetCapture_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_GetFocus_Proxy(byval This as IOleInPlaceSiteWindowless ptr) as HRESULT
declare sub IOleInPlaceSiteWindowless_GetFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_SetFocus_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval fFocus as WINBOOL) as HRESULT
declare sub IOleInPlaceSiteWindowless_SetFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_GetDC_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval pRect as LPCRECT, byval grfFlags as DWORD, byval phDC as HDC ptr) as HRESULT
declare sub IOleInPlaceSiteWindowless_GetDC_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_ReleaseDC_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval hDC as HDC) as HRESULT
declare sub IOleInPlaceSiteWindowless_ReleaseDC_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_InvalidateRect_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval pRect as LPCRECT, byval fErase as WINBOOL) as HRESULT
declare sub IOleInPlaceSiteWindowless_InvalidateRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_InvalidateRgn_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval hRGN as HRGN, byval fErase as WINBOOL) as HRESULT
declare sub IOleInPlaceSiteWindowless_InvalidateRgn_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_ScrollRect_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval dx as INT_, byval dy as INT_, byval pRectScroll as LPCRECT, byval pRectClip as LPCRECT) as HRESULT
declare sub IOleInPlaceSiteWindowless_ScrollRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_AdjustRect_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval prc as LPRECT) as HRESULT
declare sub IOleInPlaceSiteWindowless_AdjustRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleInPlaceSiteWindowless_OnDefWindowMessage_Proxy(byval This as IOleInPlaceSiteWindowless ptr, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IOleInPlaceSiteWindowless_OnDefWindowMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IViewObjectEx_INTERFACE_DEFINED__
type IViewObjectEx as IViewObjectEx_
type LPVIEWOBJECTEX as IViewObjectEx ptr

type tagVIEWSTATUS as long
enum
	VIEWSTATUS_OPAQUE = 1
	VIEWSTATUS_SOLIDBKGND = 2
	VIEWSTATUS_DVASPECTOPAQUE = 4
	VIEWSTATUS_DVASPECTTRANSPARENT = 8
	VIEWSTATUS_SURFACE = 16
	VIEWSTATUS_3DSURFACE = 32
end enum

type VIEWSTATUS as tagVIEWSTATUS

type tagHITRESULT as long
enum
	HITRESULT_OUTSIDE = 0
	HITRESULT_TRANSPARENT = 1
	HITRESULT_CLOSE = 2
	HITRESULT_HIT = 3
end enum

type HITRESULT as tagHITRESULT

type tagDVASPECT2 as long
enum
	DVASPECT_OPAQUE = 16
	DVASPECT_TRANSPARENT = 32
end enum

type DVASPECT2 as tagDVASPECT2

type tagExtentInfo
	cb as ULONG
	dwExtentMode as DWORD
	sizelProposed as SIZEL
end type

type DVEXTENTINFO as tagExtentInfo

type tagExtentMode as long
enum
	DVEXTENT_CONTENT = 0
	DVEXTENT_INTEGRAL = 1
end enum

type DVEXTENTMODE as tagExtentMode

type tagAspectInfoFlag as long
enum
	DVASPECTINFOFLAG_CANOPTIMIZE = 1
end enum

type DVASPECTINFOFLAG as tagAspectInfoFlag

type tagAspectInfo
	cb as ULONG
	dwFlags as DWORD
end type

type DVASPECTINFO as tagAspectInfo
extern IID_IViewObjectEx as const GUID

type IViewObjectExVtbl
	QueryInterface as function(byval This as IViewObjectEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IViewObjectEx ptr) as ULONG
	Release as function(byval This as IViewObjectEx ptr) as ULONG
	Draw as function(byval This as IViewObjectEx ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hdcTargetDev as HDC, byval hdcDraw as HDC, byval lprcBounds as LPCRECTL, byval lprcWBounds as LPCRECTL, byval pfnContinue as function(byval dwContinue as ULONG_PTR) as WINBOOL, byval dwContinue as ULONG_PTR) as HRESULT
	GetColorSet as function(byval This as IViewObjectEx ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval ppColorSet as LOGPALETTE ptr ptr) as HRESULT
	Freeze as function(byval This as IViewObjectEx ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval pvAspect as any ptr, byval pdwFreeze as DWORD ptr) as HRESULT
	Unfreeze as function(byval This as IViewObjectEx ptr, byval dwFreeze as DWORD) as HRESULT
	SetAdvise as function(byval This as IViewObjectEx ptr, byval aspects as DWORD, byval advf as DWORD, byval pAdvSink as IAdviseSink ptr) as HRESULT
	GetAdvise as function(byval This as IViewObjectEx ptr, byval pAspects as DWORD ptr, byval pAdvf as DWORD ptr, byval ppAdvSink as IAdviseSink ptr ptr) as HRESULT
	GetExtent as function(byval This as IViewObjectEx ptr, byval dwDrawAspect as DWORD, byval lindex as LONG, byval ptd as DVTARGETDEVICE ptr, byval lpsizel as LPSIZEL) as HRESULT
	GetRect as function(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRect as LPRECTL) as HRESULT
	GetViewStatus as function(byval This as IViewObjectEx ptr, byval pdwStatus as DWORD ptr) as HRESULT
	QueryHitPoint as function(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRectBounds as LPCRECT, byval ptlLoc as POINT, byval lCloseHint as LONG, byval pHitResult as DWORD ptr) as HRESULT
	QueryHitRect as function(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRectBounds as LPCRECT, byval pRectLoc as LPCRECT, byval lCloseHint as LONG, byval pHitResult as DWORD ptr) as HRESULT
	GetNaturalExtent as function(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval lindex as LONG, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval pExtentInfo as DVEXTENTINFO ptr, byval pSizel as LPSIZEL) as HRESULT
end type

type IViewObjectEx_
	lpVtbl as IViewObjectExVtbl ptr
end type

declare function IViewObjectEx_GetRect_Proxy(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRect as LPRECTL) as HRESULT
declare sub IViewObjectEx_GetRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObjectEx_GetViewStatus_Proxy(byval This as IViewObjectEx ptr, byval pdwStatus as DWORD ptr) as HRESULT
declare sub IViewObjectEx_GetViewStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObjectEx_QueryHitPoint_Proxy(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRectBounds as LPCRECT, byval ptlLoc as POINT, byval lCloseHint as LONG, byval pHitResult as DWORD ptr) as HRESULT
declare sub IViewObjectEx_QueryHitPoint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObjectEx_QueryHitRect_Proxy(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval pRectBounds as LPCRECT, byval pRectLoc as LPCRECT, byval lCloseHint as LONG, byval pHitResult as DWORD ptr) as HRESULT
declare sub IViewObjectEx_QueryHitRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IViewObjectEx_GetNaturalExtent_Proxy(byval This as IViewObjectEx ptr, byval dwAspect as DWORD, byval lindex as LONG, byval ptd as DVTARGETDEVICE ptr, byval hicTargetDev as HDC, byval pExtentInfo as DVEXTENTINFO ptr, byval pSizel as LPSIZEL) as HRESULT
declare sub IViewObjectEx_GetNaturalExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleUndoUnit_INTERFACE_DEFINED__
type IOleUndoUnit as IOleUndoUnit_
type LPOLEUNDOUNIT as IOleUndoUnit ptr
extern IID_IOleUndoUnit as const GUID
type IOleUndoManager as IOleUndoManager_

type IOleUndoUnitVtbl
	QueryInterface as function(byval This as IOleUndoUnit ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleUndoUnit ptr) as ULONG
	Release as function(byval This as IOleUndoUnit ptr) as ULONG
	Do as function(byval This as IOleUndoUnit ptr, byval pUndoManager as IOleUndoManager ptr) as HRESULT
	GetDescription as function(byval This as IOleUndoUnit ptr, byval pBstr as BSTR ptr) as HRESULT
	GetUnitType as function(byval This as IOleUndoUnit ptr, byval pClsid as CLSID ptr, byval plID as LONG ptr) as HRESULT
	OnNextAdd as function(byval This as IOleUndoUnit ptr) as HRESULT
end type

type IOleUndoUnit_
	lpVtbl as IOleUndoUnitVtbl ptr
end type

declare function IOleUndoUnit_Do_Proxy(byval This as IOleUndoUnit ptr, byval pUndoManager as IOleUndoManager ptr) as HRESULT
declare sub IOleUndoUnit_Do_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoUnit_GetDescription_Proxy(byval This as IOleUndoUnit ptr, byval pBstr as BSTR ptr) as HRESULT
declare sub IOleUndoUnit_GetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoUnit_GetUnitType_Proxy(byval This as IOleUndoUnit ptr, byval pClsid as CLSID ptr, byval plID as LONG ptr) as HRESULT
declare sub IOleUndoUnit_GetUnitType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoUnit_OnNextAdd_Proxy(byval This as IOleUndoUnit ptr) as HRESULT
declare sub IOleUndoUnit_OnNextAdd_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOleParentUndoUnit_INTERFACE_DEFINED__
type IOleParentUndoUnit as IOleParentUndoUnit_
type LPOLEPARENTUNDOUNIT as IOleParentUndoUnit ptr
extern IID_IOleParentUndoUnit as const GUID

type IOleParentUndoUnitVtbl
	QueryInterface as function(byval This as IOleParentUndoUnit ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleParentUndoUnit ptr) as ULONG
	Release as function(byval This as IOleParentUndoUnit ptr) as ULONG
	Do as function(byval This as IOleParentUndoUnit ptr, byval pUndoManager as IOleUndoManager ptr) as HRESULT
	GetDescription as function(byval This as IOleParentUndoUnit ptr, byval pBstr as BSTR ptr) as HRESULT
	GetUnitType as function(byval This as IOleParentUndoUnit ptr, byval pClsid as CLSID ptr, byval plID as LONG ptr) as HRESULT
	OnNextAdd as function(byval This as IOleParentUndoUnit ptr) as HRESULT
	Open as function(byval This as IOleParentUndoUnit ptr, byval pPUU as IOleParentUndoUnit ptr) as HRESULT
	Close as function(byval This as IOleParentUndoUnit ptr, byval pPUU as IOleParentUndoUnit ptr, byval fCommit as WINBOOL) as HRESULT
	Add as function(byval This as IOleParentUndoUnit ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	FindUnit as function(byval This as IOleParentUndoUnit ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	GetParentState as function(byval This as IOleParentUndoUnit ptr, byval pdwState as DWORD ptr) as HRESULT
end type

type IOleParentUndoUnit_
	lpVtbl as IOleParentUndoUnitVtbl ptr
end type

declare function IOleParentUndoUnit_Open_Proxy(byval This as IOleParentUndoUnit ptr, byval pPUU as IOleParentUndoUnit ptr) as HRESULT
declare sub IOleParentUndoUnit_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleParentUndoUnit_Close_Proxy(byval This as IOleParentUndoUnit ptr, byval pPUU as IOleParentUndoUnit ptr, byval fCommit as WINBOOL) as HRESULT
declare sub IOleParentUndoUnit_Close_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleParentUndoUnit_Add_Proxy(byval This as IOleParentUndoUnit ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleParentUndoUnit_Add_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleParentUndoUnit_FindUnit_Proxy(byval This as IOleParentUndoUnit ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleParentUndoUnit_FindUnit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleParentUndoUnit_GetParentState_Proxy(byval This as IOleParentUndoUnit ptr, byval pdwState as DWORD ptr) as HRESULT
declare sub IOleParentUndoUnit_GetParentState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumOleUndoUnits_INTERFACE_DEFINED__
type IEnumOleUndoUnits as IEnumOleUndoUnits_
type LPENUMOLEUNDOUNITS as IEnumOleUndoUnits ptr
extern IID_IEnumOleUndoUnits as const GUID

type IEnumOleUndoUnitsVtbl
	QueryInterface as function(byval This as IEnumOleUndoUnits ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumOleUndoUnits ptr) as ULONG
	Release as function(byval This as IEnumOleUndoUnits ptr) as ULONG
	Next as function(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG, byval rgElt as IOleUndoUnit ptr ptr, byval pcEltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG) as HRESULT
	Reset as function(byval This as IEnumOleUndoUnits ptr) as HRESULT
	Clone as function(byval This as IEnumOleUndoUnits ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
end type

type IEnumOleUndoUnits_
	lpVtbl as IEnumOleUndoUnitsVtbl ptr
end type

declare function IEnumOleUndoUnits_RemoteNext_Proxy(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG, byval rgElt as IOleUndoUnit ptr ptr, byval pcEltFetched as ULONG ptr) as HRESULT
declare sub IEnumOleUndoUnits_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleUndoUnits_Skip_Proxy(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG) as HRESULT
declare sub IEnumOleUndoUnits_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleUndoUnits_Reset_Proxy(byval This as IEnumOleUndoUnits ptr) as HRESULT
declare sub IEnumOleUndoUnits_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleUndoUnits_Clone_Proxy(byval This as IEnumOleUndoUnits ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
declare sub IEnumOleUndoUnits_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumOleUndoUnits_Next_Proxy(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG, byval rgElt as IOleUndoUnit ptr ptr, byval pcEltFetched as ULONG ptr) as HRESULT
declare function IEnumOleUndoUnits_Next_Stub(byval This as IEnumOleUndoUnits ptr, byval cElt as ULONG, byval rgElt as IOleUndoUnit ptr ptr, byval pcEltFetched as ULONG ptr) as HRESULT
#define __IOleUndoManager_INTERFACE_DEFINED__
#define SID_SOleUndoManager IID_IOleUndoManager
type LPOLEUNDOMANAGER as IOleUndoManager ptr
extern IID_IOleUndoManager as const GUID

type IOleUndoManagerVtbl
	QueryInterface as function(byval This as IOleUndoManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOleUndoManager ptr) as ULONG
	Release as function(byval This as IOleUndoManager ptr) as ULONG
	Open as function(byval This as IOleUndoManager ptr, byval pPUU as IOleParentUndoUnit ptr) as HRESULT
	Close as function(byval This as IOleUndoManager ptr, byval pPUU as IOleParentUndoUnit ptr, byval fCommit as WINBOOL) as HRESULT
	Add as function(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	GetOpenParentState as function(byval This as IOleUndoManager ptr, byval pdwState as DWORD ptr) as HRESULT
	DiscardFrom as function(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	UndoTo as function(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	RedoTo as function(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
	EnumUndoable as function(byval This as IOleUndoManager ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
	EnumRedoable as function(byval This as IOleUndoManager ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
	GetLastUndoDescription as function(byval This as IOleUndoManager ptr, byval pBstr as BSTR ptr) as HRESULT
	GetLastRedoDescription as function(byval This as IOleUndoManager ptr, byval pBstr as BSTR ptr) as HRESULT
	Enable as function(byval This as IOleUndoManager ptr, byval fEnable as WINBOOL) as HRESULT
end type

type IOleUndoManager_
	lpVtbl as IOleUndoManagerVtbl ptr
end type

declare function IOleUndoManager_Open_Proxy(byval This as IOleUndoManager ptr, byval pPUU as IOleParentUndoUnit ptr) as HRESULT
declare sub IOleUndoManager_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_Close_Proxy(byval This as IOleUndoManager ptr, byval pPUU as IOleParentUndoUnit ptr, byval fCommit as WINBOOL) as HRESULT
declare sub IOleUndoManager_Close_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_Add_Proxy(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleUndoManager_Add_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_GetOpenParentState_Proxy(byval This as IOleUndoManager ptr, byval pdwState as DWORD ptr) as HRESULT
declare sub IOleUndoManager_GetOpenParentState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_DiscardFrom_Proxy(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleUndoManager_DiscardFrom_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_UndoTo_Proxy(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleUndoManager_UndoTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_RedoTo_Proxy(byval This as IOleUndoManager ptr, byval pUU as IOleUndoUnit ptr) as HRESULT
declare sub IOleUndoManager_RedoTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_EnumUndoable_Proxy(byval This as IOleUndoManager ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
declare sub IOleUndoManager_EnumUndoable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_EnumRedoable_Proxy(byval This as IOleUndoManager ptr, byval ppEnum as IEnumOleUndoUnits ptr ptr) as HRESULT
declare sub IOleUndoManager_EnumRedoable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_GetLastUndoDescription_Proxy(byval This as IOleUndoManager ptr, byval pBstr as BSTR ptr) as HRESULT
declare sub IOleUndoManager_GetLastUndoDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_GetLastRedoDescription_Proxy(byval This as IOleUndoManager ptr, byval pBstr as BSTR ptr) as HRESULT
declare sub IOleUndoManager_GetLastRedoDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOleUndoManager_Enable_Proxy(byval This as IOleUndoManager ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IOleUndoManager_Enable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPointerInactive_INTERFACE_DEFINED__
type IPointerInactive as IPointerInactive_
type LPPOINTERINACTIVE as IPointerInactive ptr

type tagPOINTERINACTIVE as long
enum
	POINTERINACTIVE_ACTIVATEONENTRY = 1
	POINTERINACTIVE_DEACTIVATEONLEAVE = 2
	POINTERINACTIVE_ACTIVATEONDRAG = 4
end enum

type POINTERINACTIVE as tagPOINTERINACTIVE
extern IID_IPointerInactive as const GUID

type IPointerInactiveVtbl
	QueryInterface as function(byval This as IPointerInactive ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPointerInactive ptr) as ULONG
	Release as function(byval This as IPointerInactive ptr) as ULONG
	GetActivationPolicy as function(byval This as IPointerInactive ptr, byval pdwPolicy as DWORD ptr) as HRESULT
	OnInactiveMouseMove as function(byval This as IPointerInactive ptr, byval pRectBounds as LPCRECT, byval x as LONG, byval y as LONG, byval grfKeyState as DWORD) as HRESULT
	OnInactiveSetCursor as function(byval This as IPointerInactive ptr, byval pRectBounds as LPCRECT, byval x as LONG, byval y as LONG, byval dwMouseMsg as DWORD, byval fSetAlways as WINBOOL) as HRESULT
end type

type IPointerInactive_
	lpVtbl as IPointerInactiveVtbl ptr
end type

declare function IPointerInactive_GetActivationPolicy_Proxy(byval This as IPointerInactive ptr, byval pdwPolicy as DWORD ptr) as HRESULT
declare sub IPointerInactive_GetActivationPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPointerInactive_OnInactiveMouseMove_Proxy(byval This as IPointerInactive ptr, byval pRectBounds as LPCRECT, byval x as LONG, byval y as LONG, byval grfKeyState as DWORD) as HRESULT
declare sub IPointerInactive_OnInactiveMouseMove_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPointerInactive_OnInactiveSetCursor_Proxy(byval This as IPointerInactive ptr, byval pRectBounds as LPCRECT, byval x as LONG, byval y as LONG, byval dwMouseMsg as DWORD, byval fSetAlways as WINBOOL) as HRESULT
declare sub IPointerInactive_OnInactiveSetCursor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IObjectWithSite_INTERFACE_DEFINED__
type IObjectWithSite as IObjectWithSite_
type LPOBJECTWITHSITE as IObjectWithSite ptr
extern IID_IObjectWithSite as const GUID

type IObjectWithSiteVtbl
	QueryInterface as function(byval This as IObjectWithSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectWithSite ptr) as ULONG
	Release as function(byval This as IObjectWithSite ptr) as ULONG
	SetSite as function(byval This as IObjectWithSite ptr, byval pUnkSite as IUnknown ptr) as HRESULT
	GetSite as function(byval This as IObjectWithSite ptr, byval riid as const IID const ptr, byval ppvSite as any ptr ptr) as HRESULT
end type

type IObjectWithSite_
	lpVtbl as IObjectWithSiteVtbl ptr
end type

declare function IObjectWithSite_SetSite_Proxy(byval This as IObjectWithSite ptr, byval pUnkSite as IUnknown ptr) as HRESULT
declare sub IObjectWithSite_SetSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectWithSite_GetSite_Proxy(byval This as IObjectWithSite ptr, byval riid as const IID const ptr, byval ppvSite as any ptr ptr) as HRESULT
declare sub IObjectWithSite_GetSite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPerPropertyBrowsing_INTERFACE_DEFINED__
type IPerPropertyBrowsing as IPerPropertyBrowsing_
type LPPERPROPERTYBROWSING as IPerPropertyBrowsing ptr

type tagCALPOLESTR
	cElems as ULONG
	pElems as LPOLESTR ptr
end type

type CALPOLESTR as tagCALPOLESTR
type LPCALPOLESTR as tagCALPOLESTR ptr

type tagCADWORD
	cElems as ULONG
	pElems as DWORD ptr
end type

type CADWORD as tagCADWORD
type LPCADWORD as tagCADWORD ptr
extern IID_IPerPropertyBrowsing as const GUID

type IPerPropertyBrowsingVtbl
	QueryInterface as function(byval This as IPerPropertyBrowsing ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPerPropertyBrowsing ptr) as ULONG
	Release as function(byval This as IPerPropertyBrowsing ptr) as ULONG
	GetDisplayString as function(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pBstr as BSTR ptr) as HRESULT
	MapPropertyToPage as function(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pClsid as CLSID ptr) as HRESULT
	GetPredefinedStrings as function(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pCaStringsOut as CALPOLESTR ptr, byval pCaCookiesOut as CADWORD ptr) as HRESULT
	GetPredefinedValue as function(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval dwCookie as DWORD, byval pVarOut as VARIANT ptr) as HRESULT
end type

type IPerPropertyBrowsing_
	lpVtbl as IPerPropertyBrowsingVtbl ptr
end type

declare function IPerPropertyBrowsing_GetDisplayString_Proxy(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pBstr as BSTR ptr) as HRESULT
declare sub IPerPropertyBrowsing_GetDisplayString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPerPropertyBrowsing_MapPropertyToPage_Proxy(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pClsid as CLSID ptr) as HRESULT
declare sub IPerPropertyBrowsing_MapPropertyToPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPerPropertyBrowsing_GetPredefinedStrings_Proxy(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval pCaStringsOut as CALPOLESTR ptr, byval pCaCookiesOut as CADWORD ptr) as HRESULT
declare sub IPerPropertyBrowsing_GetPredefinedStrings_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPerPropertyBrowsing_GetPredefinedValue_Proxy(byval This as IPerPropertyBrowsing ptr, byval dispID as DISPID, byval dwCookie as DWORD, byval pVarOut as VARIANT ptr) as HRESULT
declare sub IPerPropertyBrowsing_GetPredefinedValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyBag2_INTERFACE_DEFINED__
type IPropertyBag2 as IPropertyBag2_
type LPPROPERTYBAG2 as IPropertyBag2 ptr

type tagPROPBAG2_TYPE as long
enum
	PROPBAG2_TYPE_UNDEFINED = 0
	PROPBAG2_TYPE_DATA = 1
	PROPBAG2_TYPE_URL = 2
	PROPBAG2_TYPE_OBJECT = 3
	PROPBAG2_TYPE_STREAM = 4
	PROPBAG2_TYPE_STORAGE = 5
	PROPBAG2_TYPE_MONIKER = 6
end enum

type PROPBAG2_TYPE as tagPROPBAG2_TYPE

type tagPROPBAG2
	dwType as DWORD
	vt as VARTYPE
	cfType as CLIPFORMAT
	dwHint as DWORD
	pstrName as LPOLESTR
	clsid as CLSID
end type

type PROPBAG2 as tagPROPBAG2
extern IID_IPropertyBag2 as const GUID

type IPropertyBag2Vtbl
	QueryInterface as function(byval This as IPropertyBag2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyBag2 ptr) as ULONG
	Release as function(byval This as IPropertyBag2 ptr) as ULONG
	Read as function(byval This as IPropertyBag2 ptr, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pErrLog as IErrorLog ptr, byval pvarValue as VARIANT ptr, byval phrError as HRESULT ptr) as HRESULT
	Write as function(byval This as IPropertyBag2 ptr, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pvarValue as VARIANT ptr) as HRESULT
	CountProperties as function(byval This as IPropertyBag2 ptr, byval pcProperties as ULONG ptr) as HRESULT
	GetPropertyInfo as function(byval This as IPropertyBag2 ptr, byval iProperty as ULONG, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pcProperties as ULONG ptr) as HRESULT
	LoadObject as function(byval This as IPropertyBag2 ptr, byval pstrName as LPCOLESTR, byval dwHint as DWORD, byval pUnkObject as IUnknown ptr, byval pErrLog as IErrorLog ptr) as HRESULT
end type

type IPropertyBag2_
	lpVtbl as IPropertyBag2Vtbl ptr
end type

declare function IPropertyBag2_Read_Proxy(byval This as IPropertyBag2 ptr, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pErrLog as IErrorLog ptr, byval pvarValue as VARIANT ptr, byval phrError as HRESULT ptr) as HRESULT
declare sub IPropertyBag2_Read_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag2_Write_Proxy(byval This as IPropertyBag2 ptr, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pvarValue as VARIANT ptr) as HRESULT
declare sub IPropertyBag2_Write_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag2_CountProperties_Proxy(byval This as IPropertyBag2 ptr, byval pcProperties as ULONG ptr) as HRESULT
declare sub IPropertyBag2_CountProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag2_GetPropertyInfo_Proxy(byval This as IPropertyBag2 ptr, byval iProperty as ULONG, byval cProperties as ULONG, byval pPropBag as PROPBAG2 ptr, byval pcProperties as ULONG ptr) as HRESULT
declare sub IPropertyBag2_GetPropertyInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag2_LoadObject_Proxy(byval This as IPropertyBag2 ptr, byval pstrName as LPCOLESTR, byval dwHint as DWORD, byval pUnkObject as IUnknown ptr, byval pErrLog as IErrorLog ptr) as HRESULT
declare sub IPropertyBag2_LoadObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistPropertyBag2_INTERFACE_DEFINED__
type IPersistPropertyBag2 as IPersistPropertyBag2_
type LPPERSISTPROPERTYBAG2 as IPersistPropertyBag2 ptr
extern IID_IPersistPropertyBag2 as const GUID

type IPersistPropertyBag2Vtbl
	QueryInterface as function(byval This as IPersistPropertyBag2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistPropertyBag2 ptr) as ULONG
	Release as function(byval This as IPersistPropertyBag2 ptr) as ULONG
	GetClassID as function(byval This as IPersistPropertyBag2 ptr, byval pClassID as CLSID ptr) as HRESULT
	InitNew as function(byval This as IPersistPropertyBag2 ptr) as HRESULT
	Load as function(byval This as IPersistPropertyBag2 ptr, byval pPropBag as IPropertyBag2 ptr, byval pErrLog as IErrorLog ptr) as HRESULT
	Save as function(byval This as IPersistPropertyBag2 ptr, byval pPropBag as IPropertyBag2 ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
	IsDirty as function(byval This as IPersistPropertyBag2 ptr) as HRESULT
end type

type IPersistPropertyBag2_
	lpVtbl as IPersistPropertyBag2Vtbl ptr
end type

declare function IPersistPropertyBag2_InitNew_Proxy(byval This as IPersistPropertyBag2 ptr) as HRESULT
declare sub IPersistPropertyBag2_InitNew_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistPropertyBag2_Load_Proxy(byval This as IPersistPropertyBag2 ptr, byval pPropBag as IPropertyBag2 ptr, byval pErrLog as IErrorLog ptr) as HRESULT
declare sub IPersistPropertyBag2_Load_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistPropertyBag2_Save_Proxy(byval This as IPersistPropertyBag2 ptr, byval pPropBag as IPropertyBag2 ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
declare sub IPersistPropertyBag2_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistPropertyBag2_IsDirty_Proxy(byval This as IPersistPropertyBag2 ptr) as HRESULT
declare sub IPersistPropertyBag2_IsDirty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAdviseSinkEx_INTERFACE_DEFINED__
type IAdviseSinkEx as IAdviseSinkEx_
type LPADVISESINKEX as IAdviseSinkEx ptr
extern IID_IAdviseSinkEx as const GUID

type IAdviseSinkExVtbl
	QueryInterface as function(byval This as IAdviseSinkEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAdviseSinkEx ptr) as ULONG
	Release as function(byval This as IAdviseSinkEx ptr) as ULONG
	OnDataChange as sub(byval This as IAdviseSinkEx ptr, byval pFormatetc as FORMATETC ptr, byval pStgmed as STGMEDIUM ptr)
	OnViewChange as sub(byval This as IAdviseSinkEx ptr, byval dwAspect as DWORD, byval lindex as LONG)
	OnRename as sub(byval This as IAdviseSinkEx ptr, byval pmk as IMoniker ptr)
	OnSave as sub(byval This as IAdviseSinkEx ptr)
	OnClose as sub(byval This as IAdviseSinkEx ptr)
	OnViewStatusChange as sub(byval This as IAdviseSinkEx ptr, byval dwViewStatus as DWORD)
end type

type IAdviseSinkEx_
	lpVtbl as IAdviseSinkExVtbl ptr
end type

declare function IAdviseSinkEx_RemoteOnViewStatusChange_Proxy(byval This as IAdviseSinkEx ptr, byval dwViewStatus as DWORD) as HRESULT
declare sub IAdviseSinkEx_RemoteOnViewStatusChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IAdviseSinkEx_OnViewStatusChange_Proxy(byval This as IAdviseSinkEx ptr, byval dwViewStatus as DWORD)
declare function IAdviseSinkEx_OnViewStatusChange_Stub(byval This as IAdviseSinkEx ptr, byval dwViewStatus as DWORD) as HRESULT
#define __IQuickActivate_INTERFACE_DEFINED__
type IQuickActivate as IQuickActivate_
type LPQUICKACTIVATE as IQuickActivate ptr

type tagQACONTAINERFLAGS as long
enum
	QACONTAINER_SHOWHATCHING = &h1
	QACONTAINER_SHOWGRABHANDLES = &h2
	QACONTAINER_USERMODE = &h4
	QACONTAINER_DISPLAYASDEFAULT = &h8
	QACONTAINER_UIDEAD = &h10
	QACONTAINER_AUTOCLIP = &h20
	QACONTAINER_MESSAGEREFLECT = &h40
	QACONTAINER_SUPPORTSMNEMONICS = &h80
end enum

type QACONTAINERFLAGS as tagQACONTAINERFLAGS
type OLE_COLOR as DWORD

type tagQACONTAINER
	cbSize as ULONG
	pClientSite as IOleClientSite ptr
	pAdviseSink as IAdviseSinkEx ptr
	pPropertyNotifySink as IPropertyNotifySink ptr
	pUnkEventSink as IUnknown ptr
	dwAmbientFlags as DWORD
	colorFore as OLE_COLOR
	colorBack as OLE_COLOR
	pFont as IFont ptr
	pUndoMgr as IOleUndoManager ptr
	dwAppearance as DWORD
	lcid as LONG
	hpal as HPALETTE
	pBindHost as IBindHost ptr
	pOleControlSite as IOleControlSite ptr
	pServiceProvider as IServiceProvider ptr
end type

type QACONTAINER as tagQACONTAINER

type tagQACONTROL
	cbSize as ULONG
	dwMiscStatus as DWORD
	dwViewStatus as DWORD
	dwEventCookie as DWORD
	dwPropNotifyCookie as DWORD
	dwPointerActivationPolicy as DWORD
end type

type QACONTROL as tagQACONTROL
extern IID_IQuickActivate as const GUID

type IQuickActivateVtbl
	QueryInterface as function(byval This as IQuickActivate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQuickActivate ptr) as ULONG
	Release as function(byval This as IQuickActivate ptr) as ULONG
	QuickActivate as function(byval This as IQuickActivate ptr, byval pQaContainer as QACONTAINER ptr, byval pQaControl as QACONTROL ptr) as HRESULT
	SetContentExtent as function(byval This as IQuickActivate ptr, byval pSizel as LPSIZEL) as HRESULT
	GetContentExtent as function(byval This as IQuickActivate ptr, byval pSizel as LPSIZEL) as HRESULT
end type

type IQuickActivate_
	lpVtbl as IQuickActivateVtbl ptr
end type

declare function IQuickActivate_RemoteQuickActivate_Proxy(byval This as IQuickActivate ptr, byval pQaContainer as QACONTAINER ptr, byval pQaControl as QACONTROL ptr) as HRESULT
declare sub IQuickActivate_RemoteQuickActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQuickActivate_SetContentExtent_Proxy(byval This as IQuickActivate ptr, byval pSizel as LPSIZEL) as HRESULT
declare sub IQuickActivate_SetContentExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQuickActivate_GetContentExtent_Proxy(byval This as IQuickActivate ptr, byval pSizel as LPSIZEL) as HRESULT
declare sub IQuickActivate_GetContentExtent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQuickActivate_QuickActivate_Proxy(byval This as IQuickActivate ptr, byval pQaContainer as QACONTAINER ptr, byval pQaControl as QACONTROL ptr) as HRESULT
declare function IQuickActivate_QuickActivate_Stub(byval This as IQuickActivate ptr, byval pQaContainer as QACONTAINER ptr, byval pQaControl as QACONTROL ptr) as HRESULT
declare function HFONT_UserSize(byval as ULONG ptr, byval as ULONG, byval as HFONT ptr) as ULONG
declare function HFONT_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HFONT ptr) as ubyte ptr
declare function HFONT_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HFONT ptr) as ubyte ptr
declare sub HFONT_UserFree(byval as ULONG ptr, byval as HFONT ptr)
declare function HRGN_UserSize(byval as ULONG ptr, byval as ULONG, byval as HRGN ptr) as ULONG
declare function HRGN_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HRGN ptr) as ubyte ptr
declare function HRGN_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HRGN ptr) as ubyte ptr
declare sub HRGN_UserFree(byval as ULONG ptr, byval as HRGN ptr)

end extern

#include once "ole-common.bi"
