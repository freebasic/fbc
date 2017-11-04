'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if _WIN32_WINNT >= &h0600
	#include once "objbase.bi"
#endif

#if (not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0601)
	extern "Windows"
#elseif defined(__FB_64BIT__) and (_WIN32_WINNT >= &h0601)
	extern "C"
#endif

#if _WIN32_WINNT >= &h0600
	#define __INC_PORTABLEDEVICECONNECTAPI__
#endif

#if _WIN32_WINNT >= &h0601
	#define __IConnectionRequestCallback_FWD_DEFINED__
	type ILocationReport as IConnectionRequestCallback
	type IConnectionRequestCallbackVtbl as IConnectionRequestCallbackVtbl_

	type IConnectionRequestCallback
		lpVtbl as IConnectionRequestCallbackVtbl ptr
	end type

	type IConnectionRequestCallbackVtbl_
		QueryInterface as function(byval This as IConnectionRequestCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IConnectionRequestCallback ptr) as ULONG
		Release as function(byval This as IConnectionRequestCallback ptr) as ULONG
		OnComplete as function(byval This as IConnectionRequestCallback ptr, byval hrStatus as HRESULT) as HRESULT
	end type

	#define IConnectionRequestCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IConnectionRequestCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IConnectionRequestCallback_Release(This) (This)->lpVtbl->Release(This)
	#define IConnectionRequestCallback_OnComplete(This, hrStatus) (This)->lpVtbl->OnComplete(This, hrStatus)

	end extern
#endif
