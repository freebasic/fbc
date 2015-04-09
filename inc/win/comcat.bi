'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#inclib "uuid"

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __comcat_h__
#define __IEnumGUID_FWD_DEFINED__
#define __IEnumCATEGORYINFO_FWD_DEFINED__
#define __ICatRegister_FWD_DEFINED__
#define __ICatInformation_FWD_DEFINED__
extern CLSID_StdComponentCategoriesMgr as const CLSID
type CATID as GUID
type REFCATID as const GUID const ptr
#define IID_IEnumCLSID IID_IEnumGUID
#define IEnumCLSID IEnumGUID
#define LPENUMCLSID LPENUMGUID
#define CATID_NULL GUID_NULL
#define IsEqualCATID(rcatid1, rcatid2) IsEqualGUID(rcatid1, rcatid2)
#define IID_IEnumCATID IID_IEnumGUID
#define IEnumCATID IEnumGUID

extern CATID_Insertable as const CATID
extern CATID_Control as const CATID
extern CATID_Programmable as const CATID
extern CATID_IsShortcut as const CATID
extern CATID_NeverShowExt as const CATID
extern CATID_DocObject as const CATID
extern CATID_Printable as const CATID
extern CATID_RequiresDataPathHost as const CATID
extern CATID_PersistsToMoniker as const CATID
extern CATID_PersistsToStorage as const CATID
extern CATID_PersistsToStreamInit as const CATID
extern CATID_PersistsToStream as const CATID
extern CATID_PersistsToMemory as const CATID
extern CATID_PersistsToFile as const CATID
extern CATID_PersistsToPropertyBag as const CATID
extern CATID_InternetAware as const CATID
extern CATID_DesignTimeUIActivatableControl as const CATID
#define _LPENUMGUID_DEFINED
#define __IEnumGUID_INTERFACE_DEFINED__
type IEnumGUID as IEnumGUID_
type LPENUMGUID as IEnumGUID ptr
extern IID_IEnumGUID as const GUID

type IEnumGUIDVtbl
	QueryInterface as function(byval This as IEnumGUID ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumGUID ptr) as ULONG
	Release as function(byval This as IEnumGUID ptr) as ULONG
	Next as function(byval This as IEnumGUID ptr, byval celt as ULONG, byval rgelt as GUID ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumGUID ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumGUID ptr) as HRESULT
	Clone as function(byval This as IEnumGUID ptr, byval ppenum as IEnumGUID ptr ptr) as HRESULT
end type

type IEnumGUID_
	lpVtbl as IEnumGUIDVtbl ptr
end type

declare function IEnumGUID_RemoteNext_Proxy(byval This as IEnumGUID ptr, byval celt as ULONG, byval rgelt as GUID ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumGUID_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumGUID_Skip_Proxy(byval This as IEnumGUID ptr, byval celt as ULONG) as HRESULT
declare sub IEnumGUID_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumGUID_Reset_Proxy(byval This as IEnumGUID ptr) as HRESULT
declare sub IEnumGUID_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumGUID_Clone_Proxy(byval This as IEnumGUID ptr, byval ppenum as IEnumGUID ptr ptr) as HRESULT
declare sub IEnumGUID_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumGUID_Next_Proxy(byval This as IEnumGUID ptr, byval celt as ULONG, byval rgelt as GUID ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumGUID_Next_Stub(byval This as IEnumGUID ptr, byval celt as ULONG, byval rgelt as GUID ptr, byval pceltFetched as ULONG ptr) as HRESULT
#define _LPENUMCATEGORYINFO_DEFINED
#define __IEnumCATEGORYINFO_INTERFACE_DEFINED__
type IEnumCATEGORYINFO as IEnumCATEGORYINFO_
type LPENUMCATEGORYINFO as IEnumCATEGORYINFO ptr

type tagCATEGORYINFO
	catid as CATID
	lcid as LCID
	szDescription as wstring * 128
end type

type CATEGORYINFO as tagCATEGORYINFO
type LPCATEGORYINFO as tagCATEGORYINFO ptr
extern IID_IEnumCATEGORYINFO as const GUID

type IEnumCATEGORYINFOVtbl
	QueryInterface as function(byval This as IEnumCATEGORYINFO ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumCATEGORYINFO ptr) as ULONG
	Release as function(byval This as IEnumCATEGORYINFO ptr) as ULONG
	Next as function(byval This as IEnumCATEGORYINFO ptr, byval celt as ULONG, byval rgelt as CATEGORYINFO ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumCATEGORYINFO ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumCATEGORYINFO ptr) as HRESULT
	Clone as function(byval This as IEnumCATEGORYINFO ptr, byval ppenum as IEnumCATEGORYINFO ptr ptr) as HRESULT
end type

type IEnumCATEGORYINFO_
	lpVtbl as IEnumCATEGORYINFOVtbl ptr
end type

declare function IEnumCATEGORYINFO_Next_Proxy(byval This as IEnumCATEGORYINFO ptr, byval celt as ULONG, byval rgelt as CATEGORYINFO ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumCATEGORYINFO_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumCATEGORYINFO_Skip_Proxy(byval This as IEnumCATEGORYINFO ptr, byval celt as ULONG) as HRESULT
declare sub IEnumCATEGORYINFO_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumCATEGORYINFO_Reset_Proxy(byval This as IEnumCATEGORYINFO ptr) as HRESULT
declare sub IEnumCATEGORYINFO_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumCATEGORYINFO_Clone_Proxy(byval This as IEnumCATEGORYINFO ptr, byval ppenum as IEnumCATEGORYINFO ptr ptr) as HRESULT
declare sub IEnumCATEGORYINFO_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPCATREGISTER_DEFINED
#define __ICatRegister_INTERFACE_DEFINED__
type ICatRegister as ICatRegister_
type LPCATREGISTER as ICatRegister ptr
extern IID_ICatRegister as const GUID

type ICatRegisterVtbl
	QueryInterface as function(byval This as ICatRegister ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICatRegister ptr) as ULONG
	Release as function(byval This as ICatRegister ptr) as ULONG
	RegisterCategories as function(byval This as ICatRegister ptr, byval cCategories as ULONG, byval rgCategoryInfo as CATEGORYINFO ptr) as HRESULT
	UnRegisterCategories as function(byval This as ICatRegister ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
	RegisterClassImplCategories as function(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
	UnRegisterClassImplCategories as function(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
	RegisterClassReqCategories as function(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
	UnRegisterClassReqCategories as function(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
end type

type ICatRegister_
	lpVtbl as ICatRegisterVtbl ptr
end type

declare function ICatRegister_RegisterCategories_Proxy(byval This as ICatRegister ptr, byval cCategories as ULONG, byval rgCategoryInfo as CATEGORYINFO ptr) as HRESULT
declare sub ICatRegister_RegisterCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatRegister_UnRegisterCategories_Proxy(byval This as ICatRegister ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
declare sub ICatRegister_UnRegisterCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatRegister_RegisterClassImplCategories_Proxy(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
declare sub ICatRegister_RegisterClassImplCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatRegister_UnRegisterClassImplCategories_Proxy(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
declare sub ICatRegister_UnRegisterClassImplCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatRegister_RegisterClassReqCategories_Proxy(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
declare sub ICatRegister_RegisterClassReqCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatRegister_UnRegisterClassReqCategories_Proxy(byval This as ICatRegister ptr, byval rclsid as const IID const ptr, byval cCategories as ULONG, byval rgcatid as CATID ptr) as HRESULT
declare sub ICatRegister_UnRegisterClassReqCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPCATINFORMATION_DEFINED
#define __ICatInformation_INTERFACE_DEFINED__
type ICatInformation as ICatInformation_
type LPCATINFORMATION as ICatInformation ptr
extern IID_ICatInformation as const GUID

type ICatInformationVtbl
	QueryInterface as function(byval This as ICatInformation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICatInformation ptr) as ULONG
	Release as function(byval This as ICatInformation ptr) as ULONG
	EnumCategories as function(byval This as ICatInformation ptr, byval lcid as LCID, byval ppenumCategoryInfo as IEnumCATEGORYINFO ptr ptr) as HRESULT
	GetCategoryDesc as function(byval This as ICatInformation ptr, byval rcatid as REFCATID, byval lcid as LCID, byval pszDesc as LPWSTR ptr) as HRESULT
	EnumClassesOfCategories as function(byval This as ICatInformation ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr, byval ppenumClsid as IEnumGUID ptr ptr) as HRESULT
	IsClassOfCategories as function(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr) as HRESULT
	EnumImplCategoriesOfClass as function(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval ppenumCatid as IEnumGUID ptr ptr) as HRESULT
	EnumReqCategoriesOfClass as function(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval ppenumCatid as IEnumGUID ptr ptr) as HRESULT
end type

type ICatInformation_
	lpVtbl as ICatInformationVtbl ptr
end type

declare function ICatInformation_EnumCategories_Proxy(byval This as ICatInformation ptr, byval lcid as LCID, byval ppenumCategoryInfo as IEnumCATEGORYINFO ptr ptr) as HRESULT
declare sub ICatInformation_EnumCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_GetCategoryDesc_Proxy(byval This as ICatInformation ptr, byval rcatid as REFCATID, byval lcid as LCID, byval pszDesc as LPWSTR ptr) as HRESULT
declare sub ICatInformation_GetCategoryDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_RemoteEnumClassesOfCategories_Proxy(byval This as ICatInformation ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr, byval ppenumClsid as IEnumGUID ptr ptr) as HRESULT
declare sub ICatInformation_RemoteEnumClassesOfCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_RemoteIsClassOfCategories_Proxy(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr) as HRESULT
declare sub ICatInformation_RemoteIsClassOfCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_EnumImplCategoriesOfClass_Proxy(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval ppenumCatid as IEnumGUID ptr ptr) as HRESULT
declare sub ICatInformation_EnumImplCategoriesOfClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_EnumReqCategoriesOfClass_Proxy(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval ppenumCatid as IEnumGUID ptr ptr) as HRESULT
declare sub ICatInformation_EnumReqCategoriesOfClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatInformation_EnumClassesOfCategories_Proxy(byval This as ICatInformation ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr, byval ppenumClsid as IEnumGUID ptr ptr) as HRESULT
declare function ICatInformation_EnumClassesOfCategories_Stub(byval This as ICatInformation ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr, byval ppenumClsid as IEnumGUID ptr ptr) as HRESULT
declare function ICatInformation_IsClassOfCategories_Proxy(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr) as HRESULT
declare function ICatInformation_IsClassOfCategories_Stub(byval This as ICatInformation ptr, byval rclsid as const IID const ptr, byval cImplemented as ULONG, byval rgcatidImpl as const CATID ptr, byval cRequired as ULONG, byval rgcatidReq as const CATID ptr) as HRESULT

end extern
