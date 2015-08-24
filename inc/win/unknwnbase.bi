'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "Windows"

#define __unknwnbase_h__
#define __IUnknown_FWD_DEFINED__
#define __AsyncIUnknown_FWD_DEFINED__
#define __IClassFactory_FWD_DEFINED__
#define __IUnknown_INTERFACE_DEFINED__
type IUnknown as IUnknown_
type LPUNKNOWN as IUnknown ptr
extern IID_IUnknown as const GUID

type IUnknownVtbl
	QueryInterface as function(byval This as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUnknown ptr) as ULONG
	Release as function(byval This as IUnknown ptr) as ULONG
end type

type IUnknown_
	lpVtbl as IUnknownVtbl ptr
end type

#define IUnknown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUnknown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUnknown_Release(This) (This)->lpVtbl->Release(This)

declare function IUnknown_QueryInterface_Proxy(byval This as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare sub IUnknown_QueryInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUnknown_AddRef_Proxy(byval This as IUnknown ptr) as ULONG
declare sub IUnknown_AddRef_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUnknown_Release_Proxy(byval This as IUnknown ptr) as ULONG
declare sub IUnknown_Release_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __AsyncIUnknown_INTERFACE_DEFINED__
extern IID_AsyncIUnknown as const GUID
type AsyncIUnknown as AsyncIUnknown_

type AsyncIUnknownVtbl
	QueryInterface as function(byval This as AsyncIUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as AsyncIUnknown ptr) as ULONG
	Release as function(byval This as AsyncIUnknown ptr) as ULONG
	Begin_QueryInterface as function(byval This as AsyncIUnknown ptr, byval riid as const IID const ptr) as HRESULT
	Finish_QueryInterface as function(byval This as AsyncIUnknown ptr, byval ppvObject as any ptr ptr) as HRESULT
	Begin_AddRef as function(byval This as AsyncIUnknown ptr) as HRESULT
	Finish_AddRef as function(byval This as AsyncIUnknown ptr) as ULONG
	Begin_Release as function(byval This as AsyncIUnknown ptr) as HRESULT
	Finish_Release as function(byval This as AsyncIUnknown ptr) as ULONG
end type

type AsyncIUnknown_
	lpVtbl as AsyncIUnknownVtbl ptr
end type

#define AsyncIUnknown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define AsyncIUnknown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define AsyncIUnknown_Release(This) (This)->lpVtbl->Release(This)
#define AsyncIUnknown_Begin_QueryInterface(This, riid) (This)->lpVtbl->Begin_QueryInterface(This, riid)
#define AsyncIUnknown_Finish_QueryInterface(This, ppvObject) (This)->lpVtbl->Finish_QueryInterface(This, ppvObject)
#define AsyncIUnknown_Begin_AddRef(This) (This)->lpVtbl->Begin_AddRef(This)
#define AsyncIUnknown_Finish_AddRef(This) (This)->lpVtbl->Finish_AddRef(This)
#define AsyncIUnknown_Begin_Release(This) (This)->lpVtbl->Begin_Release(This)
#define AsyncIUnknown_Finish_Release(This) (This)->lpVtbl->Finish_Release(This)

declare function AsyncIUnknown_Begin_QueryInterface_Proxy(byval This as AsyncIUnknown ptr, byval riid as const IID const ptr) as HRESULT
declare sub AsyncIUnknown_Begin_QueryInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIUnknown_Finish_QueryInterface_Proxy(byval This as AsyncIUnknown ptr, byval ppvObject as any ptr ptr) as HRESULT
declare sub AsyncIUnknown_Finish_QueryInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIUnknown_Begin_AddRef_Proxy(byval This as AsyncIUnknown ptr) as HRESULT
declare sub AsyncIUnknown_Begin_AddRef_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIUnknown_Finish_AddRef_Proxy(byval This as AsyncIUnknown ptr) as ULONG
declare sub AsyncIUnknown_Finish_AddRef_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIUnknown_Begin_Release_Proxy(byval This as AsyncIUnknown ptr) as HRESULT
declare sub AsyncIUnknown_Begin_Release_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIUnknown_Finish_Release_Proxy(byval This as AsyncIUnknown ptr) as ULONG
declare sub AsyncIUnknown_Finish_Release_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IClassFactory_INTERFACE_DEFINED__
type IClassFactory as IClassFactory_
type LPCLASSFACTORY as IClassFactory ptr
extern IID_IClassFactory as const GUID

type IClassFactoryVtbl
	QueryInterface as function(byval This as IClassFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IClassFactory ptr) as ULONG
	Release as function(byval This as IClassFactory ptr) as ULONG
	CreateInstance as function(byval This as IClassFactory ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	LockServer as function(byval This as IClassFactory ptr, byval fLock as WINBOOL) as HRESULT
end type

type IClassFactory_
	lpVtbl as IClassFactoryVtbl ptr
end type

#define IClassFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IClassFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IClassFactory_Release(This) (This)->lpVtbl->Release(This)
#define IClassFactory_CreateInstance(This, pUnkOuter, riid, ppvObject) (This)->lpVtbl->CreateInstance(This, pUnkOuter, riid, ppvObject)
#define IClassFactory_LockServer(This, fLock) (This)->lpVtbl->LockServer(This, fLock)

declare function IClassFactory_RemoteCreateInstance_Proxy(byval This as IClassFactory ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT
declare sub IClassFactory_RemoteCreateInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClassFactory_RemoteLockServer_Proxy(byval This as IClassFactory ptr, byval fLock as WINBOOL) as HRESULT
declare sub IClassFactory_RemoteLockServer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClassFactory_CreateInstance_Proxy(byval This as IClassFactory ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function IClassFactory_CreateInstance_Stub(byval This as IClassFactory ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT
declare function IClassFactory_LockServer_Proxy(byval This as IClassFactory ptr, byval fLock as WINBOOL) as HRESULT
declare function IClassFactory_LockServer_Stub(byval This as IClassFactory ptr, byval fLock as WINBOOL) as HRESULT

end extern
