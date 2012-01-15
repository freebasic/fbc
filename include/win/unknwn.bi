''
''
'' unknwn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_unknwn_bi__
#define __win_unknwn_bi__

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

#define IUnknown_QueryInterface(T,r,O) (T)->lpVtbl->QueryInterface(T,r,O)
#define IUnknown_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IUnknown_Release(T) (T)->lpVtbl->Release(T)
#define IClassFactory_QueryInterface(T,r,O) (T)->lpVtbl->QueryInterface(T,r,O)
#define IClassFactory_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IClassFactory_Release(T) (T)->lpVtbl->Release(T)
#define IClassFactory_CreateInstance(T,p,r,O) (T)->lpVtbl->CreateInstance(T,p,r,O)
#define IClassFactory_LockServer(T,f) (T)->lpVtbl->LockServer(T,f)

#endif
