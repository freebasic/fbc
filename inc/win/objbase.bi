''
''
'' objbase -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_objbase_bi__
#define __win_objbase_bi__

#include once "win/rpc.bi"
#include once "win/rpcndr.bi"
#include once "win/basetyps.bi"

#define ULISet32(li,v) li.HighPart=0: li.LowPart=v
#define CLSCTX_ALL (CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER or CLSCTX_LOCAL_SERVER)
#define CLSCTX_INPROC (CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER)
#define CLSCTX_SERVER (CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER)
#define MARSHALINTERFACE_MIN 500
#define CWCSTORAGENAME 32
#define STGM_DIRECT 0
#define STGM_TRANSACTED &h10000L
#define STGM_SIMPLE &h8000000L
#define STGM_READ 0
#define STGM_WRITE 1
#define STGM_READWRITE 2
#define STGM_SHARE_DENY_NONE &h40
#define STGM_SHARE_DENY_READ &h30
#define STGM_SHARE_DENY_WRITE &h20
#define STGM_SHARE_EXCLUSIVE &h10
#define STGM_PRIORITY &h40000L
#define STGM_DELETEONRELEASE &h4000000
#define STGM_NOSCRATCH &h100000
#define STGM_CREATE &h1000
#define STGM_CONVERT &h20000
#define STGM_NOSNAPSHOT &h200000
#define STGM_FAILIFTHERE 0
#define CWCSTORAGENAME 32
#define ASYNC_MODE_COMPATIBILITY 1
#define ASYNC_MODE_DEFAULT 0
#define STGTY_REPEAT 256
#define STG_TOEND &hFFFFFFFF
#define STG_LAYOUT_SEQUENTIAL 0
#define STG_LAYOUT_INTERLEAVED 1
#define COM_RIGHTS_EXECUTE 1
#define COM_RIGHTS_SAFE_FOR_SCRIPTING 2
#define STGOPTIONS_VERSION 2

enum STGFMT
	STGFMT_STORAGE = 0
	STGFMT_FILE = 3
	STGFMT_ANY = 4
	STGFMT_DOCFILE = 5
end enum

type STGOPTIONS
	usVersion as USHORT
	reserved as USHORT
	ulSectorSize as ULONG
	pwcsTemplateFile as WCHAR ptr
end type


enum REGCLS
	REGCLS_SINGLEUSE = 0
	REGCLS_MULTIPLEUSE = 1
	REGCLS_MULTI_SEPARATE = 2
end enum

#include once "win/wtypes.bi"
#include once "win/unknwn.bi"
#include once "win/objidl.bi"

#define IsEqualGUID(rguid1, rguid2) (-(memcmp(rguid1, rguid2, sizeof(GUID)) = 0))
#define IsEqualIID(id1,id2) IsEqualGUID(id1,id2)
#define IsEqualCLSID(id1,id2) IsEqualGUID(id1,id2)

#include once "win/cguid.bi"

enum COINIT
	COINIT_APARTMENTTHREADED = &h2
	COINIT_MULTITHREADED = &h0
	COINIT_DISABLE_OLE1DDE = &h4
	COINIT_SPEED_OVER_MEMORY = &h8
end enum

enum STDMSHLFLAGS
	SMEXF_SERVER = &h01
	SMEXF_HANDLER = &h02
end enum

declare function CoBuildVersion alias "CoBuildVersion" () as DWORD
declare function CoInitialize alias "CoInitialize" (byval as PVOID) as HRESULT
declare function CoInitializeEx alias "CoInitializeEx" (byval as LPVOID, byval as DWORD) as HRESULT
declare sub CoUninitialize alias "CoUninitialize" ()
declare function CoGetMalloc alias "CoGetMalloc" (byval as DWORD, byval as LPMALLOC ptr) as HRESULT
declare function CoGetCurrentProcess alias "CoGetCurrentProcess" () as DWORD
declare function CoRegisterMallocSpy alias "CoRegisterMallocSpy" (byval as LPMALLOCSPY) as HRESULT
declare function CoRevokeMallocSpy alias "CoRevokeMallocSpy" () as HRESULT
declare function CoCreateStandardMalloc alias "CoCreateStandardMalloc" (byval as DWORD, byval as IMalloc ptr ptr) as HRESULT
declare function CoGetClassObject alias "CoGetClassObject" (byval as CLSID ptr, byval as DWORD, byval as COSERVERINFO ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function CoRegisterClassObject alias "CoRegisterClassObject" (byval as CLSID ptr, byval as LPUNKNOWN, byval as DWORD, byval as DWORD, byval as PDWORD) as HRESULT
declare function CoRevokeClassObject alias "CoRevokeClassObject" (byval as DWORD) as HRESULT
declare function CoGetMarshalSizeMax alias "CoGetMarshalSizeMax" (byval as ULONG ptr, byval as IID ptr, byval as LPUNKNOWN, byval as DWORD, byval as PVOID, byval as DWORD) as HRESULT
declare function CoMarshalInterface alias "CoMarshalInterface" (byval as LPSTREAM, byval as IID ptr, byval as LPUNKNOWN, byval as DWORD, byval as PVOID, byval as DWORD) as HRESULT
declare function CoUnmarshalInterface alias "CoUnmarshalInterface" (byval as LPSTREAM, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function CoMarshalHresult alias "CoMarshalHresult" (byval as LPSTREAM, byval as HRESULT) as HRESULT
declare function CoUnmarshalHresult alias "CoUnmarshalHresult" (byval as LPSTREAM, byval as HRESULT ptr) as HRESULT
declare function CoReleaseMarshalData alias "CoReleaseMarshalData" (byval as LPSTREAM) as HRESULT
declare function CoDisconnectObject alias "CoDisconnectObject" (byval as LPUNKNOWN, byval as DWORD) as HRESULT
declare function CoLockObjectExternal alias "CoLockObjectExternal" (byval as LPUNKNOWN, byval as BOOL, byval as BOOL) as HRESULT
declare function CoGetStandardMarshal alias "CoGetStandardMarshal" (byval as IID ptr, byval as LPUNKNOWN, byval as DWORD, byval as PVOID, byval as DWORD, byval as LPMARSHAL ptr) as HRESULT
declare function CoGetStdMarshalEx alias "CoGetStdMarshalEx" (byval as LPUNKNOWN, byval as DWORD, byval as LPUNKNOWN ptr) as HRESULT
declare function CoIsHandlerConnected alias "CoIsHandlerConnected" (byval as LPUNKNOWN) as BOOL
declare function CoHasStrongExternalConnections alias "CoHasStrongExternalConnections" (byval as LPUNKNOWN) as BOOL
declare function CoMarshalInterThreadInterfaceInStream alias "CoMarshalInterThreadInterfaceInStream" (byval as IID ptr, byval as LPUNKNOWN, byval as LPSTREAM ptr) as HRESULT
declare function CoGetInterfaceAndReleaseStream alias "CoGetInterfaceAndReleaseStream" (byval as LPSTREAM, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function CoCreateFreeThreadedMarshaler alias "CoCreateFreeThreadedMarshaler" (byval as LPUNKNOWN, byval as LPUNKNOWN ptr) as HRESULT
declare function CoLoadLibrary alias "CoLoadLibrary" (byval as LPOLESTR, byval as BOOL) as HINSTANCE
declare sub CoFreeLibrary alias "CoFreeLibrary" (byval as HINSTANCE)
declare sub CoFreeAllLibraries alias "CoFreeAllLibraries" ()
declare sub CoFreeUnusedLibraries alias "CoFreeUnusedLibraries" ()
declare function CoCreateInstance alias "CoCreateInstance" (byval as CLSID ptr, byval as LPUNKNOWN, byval as DWORD, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function CoCreateInstanceEx alias "CoCreateInstanceEx" (byval as CLSID ptr, byval as IUnknown ptr, byval as DWORD, byval as COSERVERINFO ptr, byval as DWORD, byval as MULTI_QI ptr) as HRESULT
declare function StringFromCLSID alias "StringFromCLSID" (byval as CLSID ptr, byval as LPOLESTR ptr) as HRESULT
declare function CLSIDFromString alias "CLSIDFromString" (byval as LPOLESTR, byval as LPCLSID) as HRESULT
declare function StringFromIID alias "StringFromIID" (byval as IID ptr, byval as LPOLESTR ptr) as HRESULT
declare function IIDFromString alias "IIDFromString" (byval as LPOLESTR, byval as LPIID) as HRESULT
declare function CoIsOle1Class alias "CoIsOle1Class" (byval as CLSID ptr) as BOOL
declare function ProgIDFromCLSID alias "ProgIDFromCLSID" (byval as CLSID ptr, byval as LPOLESTR ptr) as HRESULT
declare function CLSIDFromProgID alias "CLSIDFromProgID" (byval as LPCOLESTR, byval as LPCLSID) as HRESULT
declare function StringFromGUID2 alias "StringFromGUID2" (byval as GUID ptr, byval as LPOLESTR, byval as integer) as integer
declare function CoCreateGuid alias "CoCreateGuid" (byval as GUID ptr) as HRESULT
declare function CoFileTimeToDosDateTime alias "CoFileTimeToDosDateTime" (byval as FILETIME ptr, byval as LPWORD, byval as LPWORD) as BOOL
declare function CoDosDateTimeToFileTime alias "CoDosDateTimeToFileTime" (byval as WORD, byval as WORD, byval as FILETIME ptr) as BOOL
declare function CoFileTimeNow alias "CoFileTimeNow" (byval as FILETIME ptr) as HRESULT
declare function CoRegisterMessageFilter alias "CoRegisterMessageFilter" (byval as LPMESSAGEFILTER, byval as LPMESSAGEFILTER ptr) as HRESULT
declare function CoGetTreatAsClass alias "CoGetTreatAsClass" (byval as CLSID ptr, byval as LPCLSID) as HRESULT
declare function CoTreatAsClass alias "CoTreatAsClass" (byval as CLSID ptr, byval as CLSID ptr) as HRESULT

type LPFNGETCLASSOBJECT as function(byval as CLSID ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
type LPFNCANUNLOADNOW as function() as HRESULT

declare function DllGetClassObject alias "DllGetClassObject" (byval as CLSID ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function DllCanUnloadNow alias "DllCanUnloadNow" () as HRESULT
declare function CoTaskMemAlloc alias "CoTaskMemAlloc" (byval as ULONG) as PVOID
declare function CoTaskMemRealloc alias "CoTaskMemRealloc" (byval as PVOID, byval as ULONG) as PVOID
declare sub CoTaskMemFree alias "CoTaskMemFree" (byval as PVOID)
declare function CreateDataAdviseHolder alias "CreateDataAdviseHolder" (byval as LPDATAADVISEHOLDER ptr) as HRESULT
declare function CreateDataCache alias "CreateDataCache" (byval as LPUNKNOWN, byval as CLSID ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function StgCreateDocfile alias "StgCreateDocfile" (byval as OLECHAR ptr, byval as DWORD, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare function StgCreateDocfileOnILockBytes alias "StgCreateDocfileOnILockBytes" (byval as ILockBytes ptr, byval as DWORD, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare function StgOpenStorage alias "StgOpenStorage" (byval as OLECHAR ptr, byval as IStorage ptr, byval as DWORD, byval as SNB, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare function StgOpenStorageOnILockBytes alias "StgOpenStorageOnILockBytes" (byval as ILockBytes ptr, byval as IStorage ptr, byval as DWORD, byval as SNB, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare function StgIsStorageFile alias "StgIsStorageFile" (byval as OLECHAR ptr) as HRESULT
declare function StgIsStorageILockBytes alias "StgIsStorageILockBytes" (byval as ILockBytes ptr) as HRESULT
declare function StgSetTimes alias "StgSetTimes" (byval as OLECHAR ptr, byval as FILETIME ptr, byval as FILETIME ptr, byval as FILETIME ptr) as HRESULT
declare function StgCreateStorageEx alias "StgCreateStorageEx" (byval as WCHAR ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as STGOPTIONS ptr, byval as any ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function StgOpenStorageEx alias "StgOpenStorageEx" (byval as WCHAR ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as STGOPTIONS ptr, byval as any ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function BindMoniker alias "BindMoniker" (byval as LPMONIKER, byval as DWORD, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function CoGetObject alias "CoGetObject" (byval as LPCWSTR, byval as BIND_OPTS ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function MkParseDisplayName alias "MkParseDisplayName" (byval as LPBC, byval as LPCOLESTR, byval as ULONG ptr, byval as LPMONIKER ptr) as HRESULT
declare function MonikerRelativePathTo alias "MonikerRelativePathTo" (byval as LPMONIKER, byval as LPMONIKER, byval as LPMONIKER ptr, byval as BOOL) as HRESULT
declare function MonikerCommonPrefixWith alias "MonikerCommonPrefixWith" (byval as LPMONIKER, byval as LPMONIKER, byval as LPMONIKER ptr) as HRESULT
declare function CreateBindCtx alias "CreateBindCtx" (byval as DWORD, byval as LPBC ptr) as HRESULT
declare function CreateGenericComposite alias "CreateGenericComposite" (byval as LPMONIKER, byval as LPMONIKER, byval as LPMONIKER ptr) as HRESULT
declare function GetClassFile alias "GetClassFile" (byval as LPCOLESTR, byval as CLSID ptr) as HRESULT
declare function CreateFileMoniker alias "CreateFileMoniker" (byval as LPCOLESTR, byval as LPMONIKER ptr) as HRESULT
declare function CreateItemMoniker alias "CreateItemMoniker" (byval as LPCOLESTR, byval as LPCOLESTR, byval as LPMONIKER ptr) as HRESULT
declare function CreateAntiMoniker alias "CreateAntiMoniker" (byval as LPMONIKER ptr) as HRESULT
declare function CreatePointerMoniker alias "CreatePointerMoniker" (byval as LPUNKNOWN, byval as LPMONIKER ptr) as HRESULT
declare function GetRunningObjectTable alias "GetRunningObjectTable" (byval as DWORD, byval as LPRUNNINGOBJECTTABLE ptr) as HRESULT
declare function CoInitializeSecurity alias "CoInitializeSecurity" (byval as PSECURITY_DESCRIPTOR, byval as LONG, byval as SOLE_AUTHENTICATION_SERVICE ptr, byval as any ptr, byval as DWORD, byval as DWORD, byval as any ptr, byval as DWORD, byval as any ptr) as HRESULT
declare function CoGetCallContext alias "CoGetCallContext" (byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function CoQueryProxyBlanket alias "CoQueryProxyBlanket" (byval as IUnknown ptr, byval as DWORD ptr, byval as DWORD ptr, byval as OLECHAR ptr ptr, byval as DWORD ptr, byval as DWORD ptr, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as DWORD ptr) as HRESULT
declare function CoSetProxyBlanket alias "CoSetProxyBlanket" (byval as IUnknown ptr, byval as DWORD, byval as DWORD, byval as OLECHAR ptr, byval as DWORD, byval as DWORD, byval as RPC_AUTH_IDENTITY_HANDLE, byval as DWORD) as HRESULT
declare function CoCopyProxy alias "CoCopyProxy" (byval as IUnknown ptr, byval as IUnknown ptr ptr) as HRESULT
declare function CoQueryClientBlanket alias "CoQueryClientBlanket" (byval as DWORD ptr, byval as DWORD ptr, byval as OLECHAR ptr ptr, byval as DWORD ptr, byval as DWORD ptr, byval as RPC_AUTHZ_HANDLE ptr, byval as DWORD ptr) as HRESULT
declare function CoImpersonateClient alias "CoImpersonateClient" () as HRESULT
declare function CoRevertToSelf alias "CoRevertToSelf" () as HRESULT
declare function CoQueryAuthenticationServices alias "CoQueryAuthenticationServices" (byval as DWORD ptr, byval as SOLE_AUTHENTICATION_SERVICE ptr ptr) as HRESULT
declare function CoSwitchCallContext alias "CoSwitchCallContext" (byval as IUnknown ptr, byval as IUnknown ptr ptr) as HRESULT
declare function CoGetInstanceFromFile alias "CoGetInstanceFromFile" (byval as COSERVERINFO ptr, byval as CLSID ptr, byval as IUnknown ptr, byval as DWORD, byval as DWORD, byval as OLECHAR ptr, byval as DWORD, byval as MULTI_QI ptr) as HRESULT
declare function CoGetInstanceFromIStorage alias "CoGetInstanceFromIStorage" (byval as COSERVERINFO ptr, byval as CLSID ptr, byval as IUnknown ptr, byval as DWORD, byval as IStorage ptr, byval as DWORD, byval as MULTI_QI ptr) as HRESULT
declare function CoAddRefServerProcess alias "CoAddRefServerProcess" () as ULONG
declare function CoReleaseServerProcess alias "CoReleaseServerProcess" () as ULONG
declare function CoResumeClassObjects alias "CoResumeClassObjects" () as HRESULT
declare function CoSuspendClassObjects alias "CoSuspendClassObjects" () as HRESULT
declare function CoGetPSClsid alias "CoGetPSClsid" (byval as IID ptr, byval as CLSID ptr) as HRESULT
declare function CoRegisterPSClsid alias "CoRegisterPSClsid" (byval as IID ptr, byval as CLSID ptr) as HRESULT

#endif
