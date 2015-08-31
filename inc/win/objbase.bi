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

#include once "winapifamily.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "combaseapi.bi"
#include once "objidl.bi"
#include once "urlmon.bi"
#include once "propidl.bi"

extern "Windows"

#define _OBJBASE_H_

type tagCOINIT as long
enum
	COINIT_APARTMENTTHREADED = &h2
	COINIT_MULTITHREADED = COINITBASE_MULTITHREADED
	COINIT_DISABLE_OLE1DDE = &h4
	COINIT_SPEED_OVER_MEMORY = &h8
end enum

type COINIT as tagCOINIT
const MARSHALINTERFACE_MIN = 500
const CWCSTORAGENAME = 32
const STGM_DIRECT = &h00000000
const STGM_TRANSACTED = &h00010000
const STGM_SIMPLE = &h08000000
const STGM_READ = &h00000000
const STGM_WRITE = &h00000001
const STGM_READWRITE = &h00000002
const STGM_SHARE_DENY_NONE = &h00000040
const STGM_SHARE_DENY_READ = &h00000030
const STGM_SHARE_DENY_WRITE = &h00000020
const STGM_SHARE_EXCLUSIVE = &h00000010
const STGM_PRIORITY = &h00040000
const STGM_DELETEONRELEASE = &h04000000
const STGM_NOSCRATCH = &h00100000
const STGM_CREATE = &h00001000
const STGM_CONVERT = &h00020000
const STGM_FAILIFTHERE = &h00000000
const STGM_NOSNAPSHOT = &h00200000
const STGM_DIRECT_SWMR = &h00400000
const ASYNC_MODE_COMPATIBILITY = &h00000001
const ASYNC_MODE_DEFAULT = &h00000000
const STGTY_REPEAT = &h00000100
const STG_TOEND = &hffffffff
const STG_LAYOUT_SEQUENTIAL = &h00000000
const STG_LAYOUT_INTERLEAVED = &h00000001
type STGFMT as DWORD
const STGFMT_STORAGE = 0
const STGFMT_NATIVE = 1
const STGFMT_FILE = 3
const STGFMT_ANY = 4
const STGFMT_DOCFILE = 5
const STGFMT_DOCUMENT = 0

declare function CoBuildVersion() as DWORD
declare function CoInitialize(byval pvReserved as LPVOID) as HRESULT
declare function CoRegisterMallocSpy(byval pMallocSpy as LPMALLOCSPY) as HRESULT
declare function CoRevokeMallocSpy() as HRESULT
declare function CoCreateStandardMalloc(byval memctx as DWORD, byval ppMalloc as IMalloc ptr ptr) as HRESULT
declare function CoRegisterInitializeSpy(byval pSpy as LPINITIALIZESPY, byval puliCookie as ULARGE_INTEGER ptr) as HRESULT
declare function CoRevokeInitializeSpy(byval uliCookie as ULARGE_INTEGER) as HRESULT

type tagCOMSD as long
enum
	SD_LAUNCHPERMISSIONS = 0
	SD_ACCESSPERMISSIONS = 1
	SD_LAUNCHRESTRICTIONS = 2
	SD_ACCESSRESTRICTIONS = 3
end enum

type COMSD as tagCOMSD
declare function CoGetSystemSecurityPermissions(byval comSDType as COMSD, byval ppSD as PSECURITY_DESCRIPTOR ptr) as HRESULT
declare function CoLoadLibrary(byval lpszLibName as LPOLESTR, byval bAutoFree as WINBOOL) as HINSTANCE
declare sub CoFreeLibrary(byval hInst as HINSTANCE)
declare sub CoFreeAllLibraries()
declare function CoGetInstanceFromFile(byval pServerInfo as COSERVERINFO ptr, byval pClsid as CLSID ptr, byval punkOuter as IUnknown ptr, byval dwClsCtx as DWORD, byval grfMode as DWORD, byval pwszName as wstring ptr, byval dwCount as DWORD, byval pResults as MULTI_QI ptr) as HRESULT
declare function CoGetInstanceFromIStorage(byval pServerInfo as COSERVERINFO ptr, byval pClsid as CLSID ptr, byval punkOuter as IUnknown ptr, byval dwClsCtx as DWORD, byval pstg as IStorage ptr, byval dwCount as DWORD, byval pResults as MULTI_QI ptr) as HRESULT
declare function CoAllowSetForegroundWindow(byval pUnk as IUnknown ptr, byval lpvReserved as LPVOID) as HRESULT
declare function DcomChannelSetHResult(byval pvReserved as LPVOID, byval pulReserved as ULONG ptr, byval appsHR as HRESULT) as HRESULT
declare function CoIsOle1Class(byval rclsid as const IID const ptr) as WINBOOL
declare function CLSIDFromProgIDEx(byval lpszProgID as LPCOLESTR, byval lpclsid as LPCLSID) as HRESULT
declare function CoFileTimeToDosDateTime(byval lpFileTime as FILETIME ptr, byval lpDosDate as LPWORD, byval lpDosTime as LPWORD) as WINBOOL
declare function CoDosDateTimeToFileTime(byval nDosDate as WORD, byval nDosTime as WORD, byval lpFileTime as FILETIME ptr) as WINBOOL
declare function CoFileTimeNow(byval lpFileTime as FILETIME ptr) as HRESULT
declare function CoRegisterMessageFilter(byval lpMessageFilter as LPMESSAGEFILTER, byval lplpMessageFilter as LPMESSAGEFILTER ptr) as HRESULT
declare function CoRegisterChannelHook(byval ExtensionUuid as const GUID const ptr, byval pChannelHook as IChannelHook ptr) as HRESULT
declare function CoTreatAsClass(byval clsidOld as const IID const ptr, byval clsidNew as const IID const ptr) as HRESULT
declare function CreateDataAdviseHolder(byval ppDAHolder as LPDATAADVISEHOLDER ptr) as HRESULT
declare function CreateDataCache(byval pUnkOuter as LPUNKNOWN, byval rclsid as const IID const ptr, byval iid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function StgOpenLayoutDocfile(byval pwcsDfName as const wstring ptr, byval grfMode as DWORD, byval reserved as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgCreateDocfile(byval pwcsName as const wstring ptr, byval grfMode as DWORD, byval reserved as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgCreateDocfileOnILockBytes(byval plkbyt as ILockBytes ptr, byval grfMode as DWORD, byval reserved as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgOpenStorage(byval pwcsName as const wstring ptr, byval pstgPriority as IStorage ptr, byval grfMode as DWORD, byval snbExclude as SNB, byval reserved as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgOpenStorageOnILockBytes(byval plkbyt as ILockBytes ptr, byval pstgPriority as IStorage ptr, byval grfMode as DWORD, byval snbExclude as SNB, byval reserved as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgIsStorageFile(byval pwcsName as const wstring ptr) as HRESULT
declare function StgIsStorageILockBytes(byval plkbyt as ILockBytes ptr) as HRESULT
declare function StgSetTimes(byval lpszName as const wstring ptr, byval pctime as const FILETIME ptr, byval patime as const FILETIME ptr, byval pmtime as const FILETIME ptr) as HRESULT
declare function StgOpenAsyncDocfileOnIFillLockBytes(byval pflb as IFillLockBytes ptr, byval grfMode as DWORD, byval asyncFlags as DWORD, byval ppstgOpen as IStorage ptr ptr) as HRESULT
declare function StgGetIFillLockBytesOnILockBytes(byval pilb as ILockBytes ptr, byval ppflb as IFillLockBytes ptr ptr) as HRESULT
declare function StgGetIFillLockBytesOnFile(byval pwcsName as const wstring ptr, byval ppflb as IFillLockBytes ptr ptr) as HRESULT
const STGOPTIONS_VERSION = 2

type tagSTGOPTIONS
	usVersion as USHORT
	reserved as USHORT
	ulSectorSize as ULONG
	pwcsTemplateFile as const wstring ptr
end type

type STGOPTIONS as tagSTGOPTIONS
declare function StgCreateStorageEx(byval pwcsName as const wstring ptr, byval grfMode as DWORD, byval stgfmt as DWORD, byval grfAttrs as DWORD, byval pStgOptions as STGOPTIONS ptr, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval riid as const IID const ptr, byval ppObjectOpen as any ptr ptr) as HRESULT
declare function StgOpenStorageEx(byval pwcsName as const wstring ptr, byval grfMode as DWORD, byval stgfmt as DWORD, byval grfAttrs as DWORD, byval pStgOptions as STGOPTIONS ptr, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval riid as const IID const ptr, byval ppObjectOpen as any ptr ptr) as HRESULT
declare function BindMoniker(byval pmk as LPMONIKER, byval grfOpt as DWORD, byval iidResult as const IID const ptr, byval ppvResult as LPVOID ptr) as HRESULT
declare function CoGetObject(byval pszName as LPCWSTR, byval pBindOptions as BIND_OPTS ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function MkParseDisplayName(byval pbc as LPBC, byval szUserName as LPCOLESTR, byval pchEaten as ULONG ptr, byval ppmk as LPMONIKER ptr) as HRESULT
declare function MonikerRelativePathTo(byval pmkSrc as LPMONIKER, byval pmkDest as LPMONIKER, byval ppmkRelPath as LPMONIKER ptr, byval dwReserved as WINBOOL) as HRESULT
declare function MonikerCommonPrefixWith(byval pmkThis as LPMONIKER, byval pmkOther as LPMONIKER, byval ppmkCommon as LPMONIKER ptr) as HRESULT
declare function CreateBindCtx(byval reserved as DWORD, byval ppbc as LPBC ptr) as HRESULT
declare function CreateGenericComposite(byval pmkFirst as LPMONIKER, byval pmkRest as LPMONIKER, byval ppmkComposite as LPMONIKER ptr) as HRESULT
declare function GetClassFile(byval szFilename as LPCOLESTR, byval pclsid as CLSID ptr) as HRESULT
declare function CreateClassMoniker(byval rclsid as const IID const ptr, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreateFileMoniker(byval lpszPathName as LPCOLESTR, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreateItemMoniker(byval lpszDelim as LPCOLESTR, byval lpszItem as LPCOLESTR, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreateAntiMoniker(byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreatePointerMoniker(byval punk as LPUNKNOWN, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreateObjrefMoniker(byval punk as LPUNKNOWN, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CoInstall(byval pbc as IBindCtx ptr, byval dwFlags as DWORD, byval pClassSpec as uCLSSPEC ptr, byval pQuery as QUERYCONTEXT ptr, byval pszCodeBase as LPWSTR) as HRESULT
declare function GetRunningObjectTable(byval reserved as DWORD, byval pprot as LPRUNNINGOBJECTTABLE ptr) as HRESULT
declare function CreateStdProgressIndicator(byval hwndParent as HWND, byval pszTitle as LPCOLESTR, byval pIbscCaller as IBindStatusCallback ptr, byval ppIbsc as IBindStatusCallback ptr ptr) as HRESULT

end extern
