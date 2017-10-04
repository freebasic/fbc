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

#include once "apiset.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "crt/stdlib.bi"
#include once "wtypesbase.bi"
#include once "unknwnbase.bi"
#include once "objidlbase.bi"
#include once "guiddef.bi"
#include once "cguid.bi"

extern "Windows"

#define _COMBASEAPI_H_
#macro LISet32(li, v)
	scope
		(li).HighPart = iif(cast(LONG, (v)) < 0, -1, 0)
		(li).LowPart = (v)
	end scope
#endmacro
#macro ULISet32(li, v)
	scope
		(li).HighPart = 0
		(li).LowPart = (v)
	end scope
#endmacro
#define CLSCTX_INPROC (CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER)
#define CLSCTX_ALL (((CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER) or CLSCTX_LOCAL_SERVER) or CLSCTX_REMOTE_SERVER)
#define CLSCTX_SERVER ((CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER) or CLSCTX_REMOTE_SERVER)

type tagREGCLS as long
enum
	REGCLS_SINGLEUSE = 0
	REGCLS_MULTIPLEUSE = 1
	REGCLS_MULTI_SEPARATE = 2
	REGCLS_SUSPENDED = 4
	REGCLS_SURROGATE = 8
end enum

type REGCLS as tagREGCLS

type tagCOINITBASE as long
enum
	COINITBASE_MULTITHREADED = &h0
end enum

type COINITBASE as tagCOINITBASE

#if _WIN32_WINNT = &h0602
	type tagServerInformation
		dwServerPid as DWORD
		dwServerTid as DWORD
		ui64ServerAddress as UINT64
	end type

	type ServerInformation as tagServerInformation
	type PServerInformation as tagServerInformation ptr

	type CO_MTA_USAGE_COOKIE__
		unused as long
	end type

	type CO_MTA_USAGE_COOKIE as CO_MTA_USAGE_COOKIE__ ptr
#endif

declare function CreateStreamOnHGlobal(byval hGlobal as HGLOBAL, byval fDeleteOnRelease as WINBOOL, byval ppstm as LPSTREAM ptr) as HRESULT
declare function GetHGlobalFromStream(byval pstm as LPSTREAM, byval phglobal as HGLOBAL ptr) as HRESULT
declare sub CoUninitialize()
declare function CoInitializeEx(byval pvReserved as LPVOID, byval dwCoInit as DWORD) as HRESULT
declare function CoGetCurrentLogicalThreadId(byval pguid as GUID ptr) as HRESULT
declare function CoGetContextToken(byval pToken as ULONG_PTR ptr) as HRESULT

#if _WIN32_WINNT >= &h0601
	declare function CoGetApartmentType(byval pAptType as APTTYPE ptr, byval pAptQualifier as APTTYPEQUALIFIER ptr) as HRESULT
#endif

declare function CoGetObjectContext(byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function CoRegisterClassObject(byval rclsid as const IID const ptr, byval pUnk as LPUNKNOWN, byval dwClsContext as DWORD, byval flags as DWORD, byval lpdwRegister as LPDWORD) as HRESULT
declare function CoRevokeClassObject(byval dwRegister as DWORD) as HRESULT
declare function CoResumeClassObjects() as HRESULT
declare function CoSuspendClassObjects() as HRESULT
declare function CoGetMalloc(byval dwMemContext as DWORD, byval ppMalloc as LPMALLOC ptr) as HRESULT
declare function CoGetCurrentProcess() as DWORD
declare function CoGetCallerTID(byval lpdwTID as LPDWORD) as HRESULT
declare function CoGetDefaultContext(byval aptType as APTTYPE, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT

#if _WIN32_WINNT = &h0602
	declare function CoDecodeProxy(byval dwClientPid as DWORD, byval ui64ProxyAddress as UINT64, byval pServerInformation as PServerInformation) as HRESULT
	declare function CoIncrementMTAUsage(byval pCookie as CO_MTA_USAGE_COOKIE ptr) as HRESULT
	declare function CoDecrementMTAUsage(byval Cookie as CO_MTA_USAGE_COOKIE) as HRESULT
	declare function CoWaitForMultipleObjects(byval dwFlags as DWORD, byval dwTimeout as DWORD, byval cHandles as ULONG, byval pHandles as const HANDLE ptr, byval lpdwindex as LPDWORD) as HRESULT
	declare function CoAllowUnmarshalerCLSID(byval clsid as const IID const ptr) as HRESULT
#endif

declare function CoGetClassObject(byval rclsid as const IID const ptr, byval dwClsContext as DWORD, byval pvReserved as LPVOID, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function CoAddRefServerProcess() as ULONG
declare function CoReleaseServerProcess() as ULONG
declare function CoGetPSClsid(byval riid as const IID const ptr, byval pClsid as CLSID ptr) as HRESULT
declare function CoRegisterPSClsid(byval riid as const IID const ptr, byval rclsid as const IID const ptr) as HRESULT
declare function CoRegisterSurrogate(byval pSurrogate as LPSURROGATE) as HRESULT
declare function CoMarshalHresult(byval pstm as LPSTREAM, byval hresult as HRESULT) as HRESULT
declare function CoUnmarshalHresult(byval pstm as LPSTREAM, byval phresult as HRESULT ptr) as HRESULT
declare function CoLockObjectExternal(byval pUnk as LPUNKNOWN, byval fLock as WINBOOL, byval fLastUnlockReleases as WINBOOL) as HRESULT
declare function CoGetStdMarshalEx(byval pUnkOuter as LPUNKNOWN, byval smexflags as DWORD, byval ppUnkInner as LPUNKNOWN ptr) as HRESULT

type tagSTDMSHLFLAGS as long
enum
	SMEXF_SERVER = &h01
	SMEXF_HANDLER = &h02
end enum

type STDMSHLFLAGS as tagSTDMSHLFLAGS
declare function CoGetMarshalSizeMax(byval pulSize as ULONG ptr, byval riid as const IID const ptr, byval pUnk as LPUNKNOWN, byval dwDestContext as DWORD, byval pvDestContext as LPVOID, byval mshlflags as DWORD) as HRESULT
declare function CoMarshalInterface(byval pStm as LPSTREAM, byval riid as const IID const ptr, byval pUnk as LPUNKNOWN, byval dwDestContext as DWORD, byval pvDestContext as LPVOID, byval mshlflags as DWORD) as HRESULT
declare function CoUnmarshalInterface(byval pStm as LPSTREAM, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function CoReleaseMarshalData(byval pStm as LPSTREAM) as HRESULT
declare function CoDisconnectObject(byval pUnk as LPUNKNOWN, byval dwReserved as DWORD) as HRESULT
declare function CoGetStandardMarshal(byval riid as const IID const ptr, byval pUnk as LPUNKNOWN, byval dwDestContext as DWORD, byval pvDestContext as LPVOID, byval mshlflags as DWORD, byval ppMarshal as LPMARSHAL ptr) as HRESULT
declare function CoMarshalInterThreadInterfaceInStream(byval riid as const IID const ptr, byval pUnk as LPUNKNOWN, byval ppStm as LPSTREAM ptr) as HRESULT
declare function CoGetInterfaceAndReleaseStream(byval pStm as LPSTREAM, byval iid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function CoCreateFreeThreadedMarshaler(byval punkOuter as LPUNKNOWN, byval ppunkMarshal as LPUNKNOWN ptr) as HRESULT
declare sub CoFreeUnusedLibraries()
declare sub CoFreeUnusedLibrariesEx(byval dwUnloadDelay as DWORD, byval dwReserved as DWORD)
declare function CoInitializeSecurity(byval pSecDesc as PSECURITY_DESCRIPTOR, byval cAuthSvc as LONG, byval asAuthSvc as SOLE_AUTHENTICATION_SERVICE ptr, byval pReserved1 as any ptr, byval dwAuthnLevel as DWORD, byval dwImpLevel as DWORD, byval pAuthList as any ptr, byval dwCapabilities as DWORD, byval pReserved3 as any ptr) as HRESULT
declare function CoSwitchCallContext(byval pNewObject as IUnknown ptr, byval ppOldObject as IUnknown ptr ptr) as HRESULT

const COM_RIGHTS_EXECUTE = 1
const COM_RIGHTS_EXECUTE_LOCAL = 2
const COM_RIGHTS_EXECUTE_REMOTE = 4
const COM_RIGHTS_ACTIVATE_LOCAL = 8
const COM_RIGHTS_ACTIVATE_REMOTE = 16
declare function CoCreateInstanceFromApp(byval Clsid as const IID const ptr, byval punkOuter as IUnknown ptr, byval dwClsCtx as DWORD, byval reserved as PVOID, byval dwCount as DWORD, byval pResults as MULTI_QI ptr) as HRESULT
declare function CoIsHandlerConnected(byval pUnk as LPUNKNOWN) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function CoDisconnectContext(byval dwTimeout as DWORD) as HRESULT
#endif

declare function CoGetCallContext(byval riid as const IID const ptr, byval ppInterface as any ptr ptr) as HRESULT
declare function CoQueryProxyBlanket(byval pProxy as IUnknown ptr, byval pwAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as LPOLESTR ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pAuthInfo as RPC_AUTH_IDENTITY_HANDLE ptr, byval pCapabilites as DWORD ptr) as HRESULT
declare function CoSetProxyBlanket(byval pProxy as IUnknown ptr, byval dwAuthnSvc as DWORD, byval dwAuthzSvc as DWORD, byval pServerPrincName as wstring ptr, byval dwAuthnLevel as DWORD, byval dwImpLevel as DWORD, byval pAuthInfo as RPC_AUTH_IDENTITY_HANDLE, byval dwCapabilities as DWORD) as HRESULT
declare function CoCopyProxy(byval pProxy as IUnknown ptr, byval ppCopy as IUnknown ptr ptr) as HRESULT
declare function CoQueryClientBlanket(byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as LPOLESTR ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pPrivs as RPC_AUTHZ_HANDLE ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare function CoImpersonateClient() as HRESULT
declare function CoRevertToSelf() as HRESULT
declare function CoQueryAuthenticationServices(byval pcAuthSvc as DWORD ptr, byval asAuthSvc as SOLE_AUTHENTICATION_SERVICE ptr ptr) as HRESULT
declare function CoCreateInstance(byval rclsid as const IID const ptr, byval pUnkOuter as LPUNKNOWN, byval dwClsContext as DWORD, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function CoCreateInstanceEx(byval Clsid as const IID const ptr, byval punkOuter as IUnknown ptr, byval dwClsCtx as DWORD, byval pServerInfo as COSERVERINFO ptr, byval dwCount as DWORD, byval pResults as MULTI_QI ptr) as HRESULT
declare function CoGetCancelObject(byval dwThreadId as DWORD, byval iid as const IID const ptr, byval ppUnk as any ptr ptr) as HRESULT
declare function CoSetCancelObject(byval pUnk as IUnknown ptr) as HRESULT
declare function CoCancelCall(byval dwThreadId as DWORD, byval ulTimeout as ULONG) as HRESULT
declare function CoTestCancel() as HRESULT
declare function CoEnableCallCancellation(byval pReserved as LPVOID) as HRESULT
declare function CoDisableCallCancellation(byval pReserved as LPVOID) as HRESULT
declare function StringFromCLSID(byval rclsid as const IID const ptr, byval lplpsz as LPOLESTR ptr) as HRESULT
declare function CLSIDFromString(byval lpsz as LPCOLESTR, byval pclsid as LPCLSID) as HRESULT
declare function StringFromIID(byval rclsid as const IID const ptr, byval lplpsz as LPOLESTR ptr) as HRESULT
declare function IIDFromString(byval lpsz as LPCOLESTR, byval lpiid as LPIID) as HRESULT
declare function ProgIDFromCLSID(byval clsid as const IID const ptr, byval lplpszProgID as LPOLESTR ptr) as HRESULT
declare function CLSIDFromProgID(byval lpszProgID as LPCOLESTR, byval lpclsid as LPCLSID) as HRESULT
declare function StringFromGUID2(byval rguid as const GUID const ptr, byval lpsz as LPOLESTR, byval cchMax as long) as long
declare function CoCreateGuid(byval pguid as GUID ptr) as HRESULT
declare function CoWaitForMultipleHandles(byval dwFlags as DWORD, byval dwTimeout as DWORD, byval cHandles as ULONG, byval pHandles as LPHANDLE, byval lpdwindex as LPDWORD) as HRESULT

type tagCOWAIT_FLAGS as long
enum
	COWAIT_DEFAULT = 0
	COWAIT_WAITALL = 1
	COWAIT_ALERTABLE = 2
	COWAIT_INPUTAVAILABLE = 4
	COWAIT_DISPATCH_CALLS = 8
	COWAIT_DISPATCH_WINDOW_MESSAGES = &h10
end enum

type COWAIT_FLAGS as tagCOWAIT_FLAGS

#if _WIN32_WINNT = &h0602
	type CWMO_FLAGS as long
	enum
		CWMO_DEFAULT = 0
		CWMO_DISPATCH_CALLS = 1
		CWMO_DISPATCH_WINDOW_MESSAGES = 2
	end enum
#endif

const CWMO_MAX_HANDLES = 56
declare function CoGetTreatAsClass(byval clsidOld as const IID const ptr, byval pClsidNew as LPCLSID) as HRESULT
declare function CoInvalidateRemoteMachineBindings(byval pszMachineName as LPOLESTR) as HRESULT
type LPFNGETCLASSOBJECT as function(byval as const IID const ptr, byval as const IID const ptr, byval as LPVOID ptr) as HRESULT
type LPFNCANUNLOADNOW as function() as HRESULT
declare function DllGetClassObject(byval rclsid as const IID const ptr, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function DllCanUnloadNow() as HRESULT
declare function CoTaskMemAlloc(byval cb as SIZE_T_) as LPVOID
declare function CoTaskMemRealloc(byval pv as LPVOID, byval cb as SIZE_T_) as LPVOID
declare sub CoTaskMemFree(byval pv as LPVOID)

end extern
