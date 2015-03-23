#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"

extern "Windows"

#define __objsafe_h__
#define __IObjectSafety_FWD_DEFINED__
#define _LPSAFEOBJECT_DEFINED
const INTERFACESAFE_FOR_UNTRUSTED_CALLER = &h00000001
const INTERFACESAFE_FOR_UNTRUSTED_DATA = &h00000002
const INTERFACE_USES_DISPEX = &h00000004
const INTERFACE_USES_SECURITY_MANAGER = &h00000008

extern IID_IObjectSafety as const GUID
extern CATID_SafeForScripting as GUID
extern CATID_SafeForInitializing as GUID
extern __MIDL_itf_objsafe_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_objsafe_0000_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IObjectSafety_INTERFACE_DEFINED__
extern IID_IObjectSafety as const IID
type IObjectSafety as IObjectSafety_

type IObjectSafetyVtbl
	QueryInterface as function(byval This as IObjectSafety ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectSafety ptr) as ULONG
	Release as function(byval This as IObjectSafety ptr) as ULONG
	GetInterfaceSafetyOptions as function(byval This as IObjectSafety ptr, byval riid as const IID const ptr, byval pdwSupportedOptions as DWORD ptr, byval pdwEnabledOptions as DWORD ptr) as HRESULT
	SetInterfaceSafetyOptions as function(byval This as IObjectSafety ptr, byval riid as const IID const ptr, byval dwOptionSetMask as DWORD, byval dwEnabledOptions as DWORD) as HRESULT
end type

type IObjectSafety_
	lpVtbl as IObjectSafetyVtbl ptr
end type

declare function IObjectSafety_GetInterfaceSafetyOptions_Proxy(byval This as IObjectSafety ptr, byval riid as const IID const ptr, byval pdwSupportedOptions as DWORD ptr, byval pdwEnabledOptions as DWORD ptr) as HRESULT
declare sub IObjectSafety_GetInterfaceSafetyOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IObjectSafety_SetInterfaceSafetyOptions_Proxy(byval This as IObjectSafety ptr, byval riid as const IID const ptr, byval dwOptionSetMask as DWORD, byval dwEnabledOptions as DWORD) as HRESULT
declare sub IObjectSafety_SetInterfaceSafetyOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
type LPOBJECTSAFETY as IObjectSafety ptr
extern __MIDL_itf_objsafe_0009_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_objsafe_0009_v0_0_s_ifspec as RPC_IF_HANDLE

end extern
