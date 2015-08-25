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

#define IServiceProvider_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IServiceProvider_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IServiceProvider_Release(This) (This)->lpVtbl->Release(This)
#define IServiceProvider_QueryService(This, guidService, riid, ppvObject) (This)->lpVtbl->QueryService(This, guidService, riid, ppvObject)

declare function IServiceProvider_RemoteQueryService_Proxy(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT
declare sub IServiceProvider_RemoteQueryService_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IServiceProvider_QueryService_Proxy(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function IServiceProvider_QueryService_Stub(byval This as IServiceProvider ptr, byval guidService as const GUID const ptr, byval riid as const IID const ptr, byval ppvObject as IUnknown ptr ptr) as HRESULT

end extern
