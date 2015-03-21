#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __servprov_h__
#define __IServiceProvider_FWD_DEFINED__
#define __IServiceProvider_INTERFACE_DEFINED__

type IServiceProvider as IServiceProvider_

type LPSERVICEPROVIDER as IServiceProvider ptr

extern IID_IServiceProvider as const GUID

type IServiceProviderVtbl
	QueryInterface as function(byval This as IServiceProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IServiceProvider ptr) as ULONG
	Release as function(byval This as IServiceProvider ptr) as ULONG
	QueryService as function(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
end type

type IServiceProvider_
	lpVtbl as IServiceProviderVtbl ptr
end type

declare function IServiceProvider_RemoteQueryService_Proxy(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT
declare sub IServiceProvider_RemoteQueryService_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IServiceProvider_QueryService_Proxy(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function IServiceProvider_QueryService_Stub(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT

end extern
