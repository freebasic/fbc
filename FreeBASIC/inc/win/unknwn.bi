''
''
'' unknwn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __unknwn_bi__
#define __unknwn_bi__

#ifndef COM_NO_WINDOWS_H
#include once "windows.bi"
#endif

#include once "win/objfwd.bi"
#include once "win/wtypes.bi"

#inclib "uuid"

declare function MIDL_user_allocate alias "MIDL_user_allocate" (byval as size_t) as any ptr
declare sub MIDL_user_free alias "MIDL_user_free" (byval as any ptr)
extern IID_IUnknown alias "IID_IUnknown" as IID
extern IID_IClassFactory alias "IID_IClassFactory" as IID

#ifndef IUnknown
type IUnknownVtbl_ as IUnknownVtbl

type IUnknown
	lpVtbl as IUnknownVtbl_ ptr
end type

type IUnknownVtbl
	QueryInterface as function (byval as IUnknown ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IUnknown ptr) as ULONG
	Release as function (byval as IUnknown ptr) as ULONG
end type

type LPUNKNOWN as IUnknown ptr
#endif

#ifndef IClassFactory
type IClassFactoryVtbl_ as IClassFactoryVtbl

type IClassFactory
	lpVtbl as IClassFactoryVtbl_ ptr
end type

type IClassFactoryVtbl
	QueryInterface as function (byval as IClassFactory ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IClassFactory ptr) as ULONG
	Release as function (byval as IClassFactory ptr) as ULONG
	CreateInstance as function (byval as IClassFactory ptr, byval as LPUNKNOWN, byval as IID ptr, byval as PVOID ptr) as HRESULT
	LockServer as function (byval as IClassFactory ptr, byval as BOOL) as HRESULT
end type

type LPCLASSFACTORY as IClassFactory ptr
#endif

declare function IUnknown_QueryInterface_Proxy alias "IUnknown_QueryInterface_Proxy" (byval as IUnknown ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare sub IUnknown_QueryInterface_Stub alias "IUnknown_QueryInterface_Stub" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IUnknown_AddRef_Proxy alias "IUnknown_AddRef_Proxy" (byval as IUnknown ptr) as ULONG
declare sub IUnknown_AddRef_Stub alias "IUnknown_AddRef_Stub" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IUnknown_Release_Proxy alias "IUnknown_Release_Proxy" (byval as IUnknown ptr) as ULONG
declare sub IUnknown_Release_Stub alias "IUnknown_Release_Stub" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IClassFactory_RemoteCreateInstance_Proxy alias "IClassFactory_RemoteCreateInstance_Proxy" (byval as IClassFactory ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare sub IClassFactory_RemoteCreateInstance_Stub alias "IClassFactory_RemoteCreateInstance_Stub" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IClassFactory_RemoteLockServer_Proxy alias "IClassFactory_RemoteLockServer_Proxy" (byval as IClassFactory ptr, byval as BOOL) as HRESULT
declare sub IClassFactory_RemoteLockServer_Stub alias "IClassFactory_RemoteLockServer_Stub" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IClassFactory_CreateInstance_Proxy alias "IClassFactory_CreateInstance_Proxy" (byval as IClassFactory ptr, byval as IUnknown ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function IClassFactory_CreateInstance_Stub alias "IClassFactory_CreateInstance_Stub" (byval as IClassFactory ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare function IClassFactory_LockServer_Proxy alias "IClassFactory_LockServer_Proxy" (byval as IClassFactory ptr, byval as BOOL) as HRESULT
declare function IClassFactory_LockServer_Stub alias "IClassFactory_LockServer_Stub" (byval as IClassFactory ptr, byval as BOOL) as HRESULT

#define IUnknown_QueryInterface(T,r,O) (T)->lpVtbl->QueryInterface(T,r,O)
#define IUnknown_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IUnknown_Release(T) (T)->lpVtbl->Release(T)
#define IClassFactory_QueryInterface(T,r,O) (T)->lpVtbl->QueryInterface(T,r,O)
#define IClassFactory_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IClassFactory_Release(T) (T)->lpVtbl->Release(T)
#define IClassFactory_CreateInstance(T,p,r,O) (T)->lpVtbl->CreateInstance(T,p,r,O)
#define IClassFactory_LockServer(T,f) (T)->lpVtbl->LockServer(T,f)

#endif
