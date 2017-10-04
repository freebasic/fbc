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
#include once "oleidl.bi"
#include once "servprov.bi"
#include once "msxml.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __urlmon_h__
#define __IPersistMoniker_FWD_DEFINED__
#define __IMonikerProp_FWD_DEFINED__
#define __IBindProtocol_FWD_DEFINED__
#define __IBinding_FWD_DEFINED__
#define __IBindStatusCallback_FWD_DEFINED__
#define __IBindStatusCallbackEx_FWD_DEFINED__
#define __IAuthenticate_FWD_DEFINED__
#define __IAuthenticateEx_FWD_DEFINED__
#define __IHttpNegotiate_FWD_DEFINED__
#define __IHttpNegotiate2_FWD_DEFINED__
#define __IHttpNegotiate3_FWD_DEFINED__
#define __IWinInetFileStream_FWD_DEFINED__
#define __IWindowForBindingUI_FWD_DEFINED__
#define __ICodeInstall_FWD_DEFINED__
#define __IUri_FWD_DEFINED__
#define __IUriContainer_FWD_DEFINED__
#define __IUriBuilder_FWD_DEFINED__
#define __IUriBuilderFactory_FWD_DEFINED__
#define __IWinInetInfo_FWD_DEFINED__
#define __IHttpSecurity_FWD_DEFINED__
#define __IWinInetHttpInfo_FWD_DEFINED__
#define __IWinInetHttpTimeouts_FWD_DEFINED__
#define __IWinInetCacheHints_FWD_DEFINED__
#define __IWinInetCacheHints2_FWD_DEFINED__
#define __IBindHost_FWD_DEFINED__
#define __IInternet_FWD_DEFINED__
#define __IInternetBindInfo_FWD_DEFINED__
#define __IInternetBindInfoEx_FWD_DEFINED__
#define __IInternetProtocolRoot_FWD_DEFINED__
#define __IInternetProtocol_FWD_DEFINED__
#define __IInternetProtocolEx_FWD_DEFINED__
#define __IInternetProtocolSink_FWD_DEFINED__
#define __IInternetProtocolSinkStackable_FWD_DEFINED__
#define __IInternetSession_FWD_DEFINED__
#define __IInternetThreadSwitch_FWD_DEFINED__
#define __IInternetPriority_FWD_DEFINED__
#define __IInternetProtocolInfo_FWD_DEFINED__
#define __IInternetSecurityMgrSite_FWD_DEFINED__
#define __IInternetSecurityManager_FWD_DEFINED__
#define __IInternetSecurityManagerEx_FWD_DEFINED__
#define __IInternetSecurityManagerEx2_FWD_DEFINED__
#define __IZoneIdentifier_FWD_DEFINED__
#define __IInternetHostSecurityManager_FWD_DEFINED__
#define __IInternetZoneManager_FWD_DEFINED__
#define __IInternetZoneManagerEx_FWD_DEFINED__
#define __IInternetZoneManagerEx2_FWD_DEFINED__
#define __ISoftDistExt_FWD_DEFINED__
#define __ICatalogFileInfo_FWD_DEFINED__
#define __IDataFilter_FWD_DEFINED__
#define __IEncodingFilterFactory_FWD_DEFINED__
#define __IWrappedProtocol_FWD_DEFINED__
#define __IGetBindHandle_FWD_DEFINED__
#define __IBindCallbackRedirect_FWD_DEFINED__

#inclib "uuid"

#define __IBindStatusCallbackMsg_FWD_DEFINED__
extern CLSID_SBS_StdURLMoniker as const IID
extern CLSID_SBS_HttpProtocol as const IID
extern CLSID_SBS_FtpProtocol as const IID
extern CLSID_SBS_GopherProtocol as const IID
extern CLSID_SBS_HttpSProtocol as const IID
extern CLSID_SBS_FileProtocol as const IID
extern CLSID_SBS_MkProtocol as const IID
extern CLSID_SBS_UrlMkBindCtx as const IID
extern CLSID_SBS_SoftDistExt as const IID
extern CLSID_SBS_CdlProtocol as const IID
extern CLSID_SBS_ClassInstallFilter as const IID
extern CLSID_SBS_InternetSecurityManager as const IID
extern CLSID_SBS_InternetZoneManager as const IID
const INVALID_P_ROOT_SECURITY_ID = cptr(UBYTE ptr, -1)
extern IID_IAsyncMoniker as const IID
extern CLSID_StdURLMoniker as const IID
extern CLSID_HttpProtocol as const IID
extern CLSID_FtpProtocol as const IID
extern CLSID_GopherProtocol as const IID
extern CLSID_HttpSProtocol as const IID
extern CLSID_FileProtocol as const IID
extern CLSID_MkProtocol as const IID
extern CLSID_StdURLProtocol as const IID
extern CLSID_UrlMkBindCtx as const IID
extern CLSID_CdlProtocol as const IID
extern CLSID_ClassInstallFilter as const IID
extern IID_IAsyncBindCtx as const IID

#define SZ_URLCONTEXT OLESTR("URL Context")
#define SZ_ASYNC_CALLEE OLESTR("AsyncCallee")
const MKSYS_URLMONIKER = 6
const URL_MK_LEGACY = 0
const URL_MK_UNIFORM = 1
const URL_MK_NO_CANONICALIZE = 2

declare function CreateURLMoniker(byval pMkCtx as LPMONIKER, byval szURL as LPCWSTR, byval ppmk as LPMONIKER ptr) as HRESULT
declare function CreateURLMonikerEx(byval pMkCtx as LPMONIKER, byval szURL as LPCWSTR, byval ppmk as LPMONIKER ptr, byval dwFlags as DWORD) as HRESULT
declare function GetClassURL(byval szURL as LPCWSTR, byval pClsID as CLSID ptr) as HRESULT
type IBindStatusCallback as IBindStatusCallback_
declare function CreateAsyncBindCtx(byval reserved as DWORD, byval pBSCb as IBindStatusCallback ptr, byval pEFetc as IEnumFORMATETC ptr, byval ppBC as IBindCtx ptr ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	type IUri as IUri_
	declare function CreateURLMonikerEx2(byval pMkCtx as LPMONIKER, byval pUri as IUri ptr, byval ppmk as LPMONIKER ptr, byval dwFlags as DWORD) as HRESULT
#endif

declare function CreateAsyncBindCtxEx(byval pbc as IBindCtx ptr, byval dwOptions as DWORD, byval pBSCb as IBindStatusCallback ptr, byval pEnum as IEnumFORMATETC ptr, byval ppBC as IBindCtx ptr ptr, byval reserved as DWORD) as HRESULT
declare function MkParseDisplayNameEx(byval pbc as IBindCtx ptr, byval szDisplayName as LPCWSTR, byval pchEaten as ULONG ptr, byval ppmk as LPMONIKER ptr) as HRESULT
declare function RegisterBindStatusCallback(byval pBC as LPBC, byval pBSCb as IBindStatusCallback ptr, byval ppBSCBPrev as IBindStatusCallback ptr ptr, byval dwReserved as DWORD) as HRESULT
declare function RevokeBindStatusCallback(byval pBC as LPBC, byval pBSCb as IBindStatusCallback ptr) as HRESULT
declare function GetClassFileOrMime(byval pBC as LPBC, byval szFilename as LPCWSTR, byval pBuffer as LPVOID, byval cbSize as DWORD, byval szMime as LPCWSTR, byval dwReserved as DWORD, byval pclsid as CLSID ptr) as HRESULT
declare function IsValidURL(byval pBC as LPBC, byval szURL as LPCWSTR, byval dwReserved as DWORD) as HRESULT
declare function CoGetClassObjectFromURL(byval rCLASSID as const IID const ptr, byval szCODE as LPCWSTR, byval dwFileVersionMS as DWORD, byval dwFileVersionLS as DWORD, byval szTYPE as LPCWSTR, byval pBindCtx as LPBINDCTX, byval dwClsContext as DWORD, byval pvReserved as LPVOID, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
declare function IEInstallScope(byval pdwScope as LPDWORD) as HRESULT
declare function FaultInIEFeature(byval hWnd as HWND, byval pClassSpec as uCLSSPEC ptr, byval pQuery as QUERYCONTEXT ptr, byval dwFlags as DWORD) as HRESULT
declare function GetComponentIDFromCLSSPEC(byval pClassspec as uCLSSPEC ptr, byval ppszComponentID as LPSTR ptr) as HRESULT

const FIEF_FLAG_FORCE_JITUI = &h1
const FIEF_FLAG_PEEK = &h2
const FIEF_FLAG_SKIP_INSTALLED_VERSION_CHECK = &h4
declare function IsAsyncMoniker(byval pmk as IMoniker ptr) as HRESULT
type IBinding as IBinding_

declare function CreateURLBinding(byval lpszUrl as LPCWSTR, byval pbc as IBindCtx ptr, byval ppBdg as IBinding ptr ptr) as HRESULT
declare function RegisterMediaTypes(byval ctypes as UINT, byval rgszTypes as const LPCSTR ptr, byval rgcfTypes as CLIPFORMAT ptr) as HRESULT
declare function FindMediaType(byval rgszTypes as LPCSTR, byval rgcfTypes as CLIPFORMAT ptr) as HRESULT
declare function CreateFormatEnumerator(byval cfmtetc as UINT, byval rgfmtetc as FORMATETC ptr, byval ppenumfmtetc as IEnumFORMATETC ptr ptr) as HRESULT
declare function RegisterFormatEnumerator(byval pBC as LPBC, byval pEFetc as IEnumFORMATETC ptr, byval reserved as DWORD) as HRESULT
declare function RevokeFormatEnumerator(byval pBC as LPBC, byval pEFetc as IEnumFORMATETC ptr) as HRESULT
declare function RegisterMediaTypeClass(byval pBC as LPBC, byval ctypes as UINT, byval rgszTypes as const LPCSTR ptr, byval rgclsID as CLSID ptr, byval reserved as DWORD) as HRESULT
declare function FindMediaTypeClass(byval pBC as LPBC, byval szType as LPCSTR, byval pclsID as CLSID ptr, byval reserved as DWORD) as HRESULT
declare function UrlMkSetSessionOption(byval dwOption as DWORD, byval pBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwReserved as DWORD) as HRESULT
declare function UrlMkGetSessionOption(byval dwOption as DWORD, byval pBuffer as LPVOID, byval dwBufferLength as DWORD, byval pdwBufferLengthOut as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare function FindMimeFromData(byval pBC as LPBC, byval pwzUrl as LPCWSTR, byval pBuffer as LPVOID, byval cbSize as DWORD, byval pwzMimeProposed as LPCWSTR, byval dwMimeFlags as DWORD, byval ppwzMimeOut as LPWSTR ptr, byval dwReserved as DWORD) as HRESULT
const FMFD_DEFAULT = &h0
const FMFD_URLASFILENAME = &h1

#if _WIN32_WINNT >= &h0600
	const FMFD_ENABLEMIMESNIFFING = &h2
	const FMFD_IGNOREMIMETEXTPLAIN = &h4
#endif

const FMFD_SERVERMIME = &h8
const FMFD_RESPECTTEXTPLAIN = &h10
const FMFD_RETURNUPDATEDIMGMIMES = &h20
const UAS_EXACTLEGACY = &h1000

declare function ObtainUserAgentString(byval dwOption as DWORD, byval pszUAOut as LPSTR, byval cbSize as DWORD ptr) as HRESULT
declare function CompareSecurityIds(byval pbSecurityId1 as UBYTE ptr, byval dwLen1 as DWORD, byval pbSecurityId2 as UBYTE ptr, byval dwLen2 as DWORD, byval dwReserved as DWORD) as HRESULT
declare function CompatFlagsFromClsid(byval pclsid as CLSID ptr, byval pdwCompatFlags as LPDWORD, byval pdwMiscStatusFlags as LPDWORD) as HRESULT

const URLMON_OPTION_USERAGENT = &h10000001
const URLMON_OPTION_USERAGENT_REFRESH = &h10000002
const URLMON_OPTION_URL_ENCODING = &h10000004

#if _WIN32_WINNT >= &h0600
	const URLMON_OPTION_USE_BINDSTRINGCREDS = &h10000008
	const URLMON_OPTION_USE_BROWSERAPPSDOCUMENTS = &h10000010
#endif

const CF_NULL = 0
#define CFSTR_MIME_NULL NULL
#define CFSTR_MIME_TEXT __TEXT("text/plain")
#define CFSTR_MIME_RICHTEXT __TEXT("text/richtext")
#define CFSTR_MIME_MANIFEST __TEXT("text/cache-manifest")
#define CFSTR_MIME_WEBVTT __TEXT("text/vtt")
#define CFSTR_MIME_X_BITMAP __TEXT("image/x-xbitmap")
#define CFSTR_MIME_POSTSCRIPT __TEXT("application/postscript")
#define CFSTR_MIME_AIFF __TEXT("audio/aiff")
#define CFSTR_MIME_BASICAUDIO __TEXT("audio/basic")
#define CFSTR_MIME_WAV __TEXT("audio/wav")
#define CFSTR_MIME_X_WAV __TEXT("audio/x-wav")
#define CFSTR_MIME_GIF __TEXT("image/gif")
#define CFSTR_MIME_PJPEG __TEXT("image/pjpeg")
#define CFSTR_MIME_JPEG __TEXT("image/jpeg")
#define CFSTR_MIME_TIFF __TEXT("image/tiff")
#define CFSTR_MIME_JPEG_XR __TEXT("image/vnd.ms-photo")
#define CFSTR_MIME_PNG __TEXT("image/png")
#define CFSTR_MIME_X_PNG __TEXT("image/x-png")
#define CFSTR_MIME_X_ICON __TEXT("image/x-icon")
#define CFSTR_MIME_SVG_XML __TEXT("image/svg+xml")
#define CFSTR_MIME_BMP __TEXT("image/bmp")
#define CFSTR_MIME_X_EMF __TEXT("image/x-emf")
#define CFSTR_MIME_X_WMF __TEXT("image/x-wmf")
#define CFSTR_MIME_AVI __TEXT("video/avi")
#define CFSTR_MIME_MPEG __TEXT("video/mpeg")
#define CFSTR_MIME_FRACTALS __TEXT("application/fractals")
#define CFSTR_MIME_RAWDATA __TEXT("application/octet-stream")
#define CFSTR_MIME_RAWDATASTRM __TEXT("application/octet-stream")
#define CFSTR_MIME_PDF __TEXT("application/pdf")
#define CFSTR_MIME_HTA __TEXT("application/hta")
#define CFSTR_MIME_APP_XML __TEXT("application/xml")
#define CFSTR_MIME_XHTML __TEXT("application/xhtml+xml")
#define CFSTR_MIME_X_AIFF __TEXT("audio/x-aiff")
#define CFSTR_MIME_X_REALAUDIO __TEXT("audio/x-pn-realaudio")
#define CFSTR_MIME_XBM __TEXT("image/xbm")
#define CFSTR_MIME_QUICKTIME __TEXT("video/quicktime")
#define CFSTR_MIME_X_MSVIDEO __TEXT("video/x-msvideo")
#define CFSTR_MIME_X_SGI_MOVIE __TEXT("video/x-sgi-movie")
#define CFSTR_MIME_HTML __TEXT("text/html")
#define CFSTR_MIME_XML __TEXT("text/xml")
#define CFSTR_MIME_TTML __TEXT("application/ttml+xml")
#define CFSTR_MIME_TTAF __TEXT("application/ttaf+xml")
#define MK_S_ASYNCHRONOUS _HRESULT_TYPEDEF_(&h401E8)
#define S_ASYNCHRONOUS MK_S_ASYNCHRONOUS
#define INET_E_INVALID_URL _HRESULT_TYPEDEF_(&h800C0002)
#define INET_E_NO_SESSION _HRESULT_TYPEDEF_(&h800C0003)
#define INET_E_CANNOT_CONNECT _HRESULT_TYPEDEF_(&h800C0004)
#define INET_E_RESOURCE_NOT_FOUND _HRESULT_TYPEDEF_(&h800C0005)
#define INET_E_OBJECT_NOT_FOUND _HRESULT_TYPEDEF_(&h800C0006)
#define INET_E_DATA_NOT_AVAILABLE _HRESULT_TYPEDEF_(&h800C0007)
#define INET_E_DOWNLOAD_FAILURE _HRESULT_TYPEDEF_(&h800C0008)
#define INET_E_AUTHENTICATION_REQUIRED _HRESULT_TYPEDEF_(&h800C0009)
#define INET_E_NO_VALID_MEDIA _HRESULT_TYPEDEF_(&h800C000A)
#define INET_E_CONNECTION_TIMEOUT _HRESULT_TYPEDEF_(&h800C000B)
#define INET_E_INVALID_REQUEST _HRESULT_TYPEDEF_(&h800C000C)
#define INET_E_UNKNOWN_PROTOCOL _HRESULT_TYPEDEF_(&h800C000D)
#define INET_E_SECURITY_PROBLEM _HRESULT_TYPEDEF_(&h800C000E)
#define INET_E_CANNOT_LOAD_DATA _HRESULT_TYPEDEF_(&h800C000F)
#define INET_E_CANNOT_INSTANTIATE_OBJECT _HRESULT_TYPEDEF_(&h800C0010)
#define INET_E_INVALID_CERTIFICATE _HRESULT_TYPEDEF_(&h800C0019)
#define INET_E_REDIRECT_FAILED _HRESULT_TYPEDEF_(&h800C0014)
#define INET_E_REDIRECT_TO_DIR _HRESULT_TYPEDEF_(&h800C0015)
#define INET_E_CANNOT_LOCK_REQUEST _HRESULT_TYPEDEF_(&h800C0016)
#define INET_E_USE_EXTEND_BINDING _HRESULT_TYPEDEF_(&h800C0017)
#define INET_E_TERMINATED_BIND _HRESULT_TYPEDEF_(&h800C0018)
#define INET_E_RESERVED_1 _HRESULT_TYPEDEF_(&h800C001A)
#define INET_E_BLOCKED_REDIRECT_XSECURITYID _HRESULT_TYPEDEF_(&h800C001B)
#define INET_E_DOMINJECTIONVALIDATION _HRESULT_TYPEDEF_(&h800C001C)
#define INET_E_ERROR_FIRST _HRESULT_TYPEDEF_(&h800C0002)
#define INET_E_CODE_DOWNLOAD_DECLINED _HRESULT_TYPEDEF_(&h800C0100)
#define INET_E_RESULT_DISPATCHED _HRESULT_TYPEDEF_(&h800C0200)
#define INET_E_CANNOT_REPLACE_SFP_FILE _HRESULT_TYPEDEF_(&h800C0300)

#if _WIN32_WINNT >= &h0600
	#define INET_E_CODE_INSTALL_SUPPRESSED _HRESULT_TYPEDEF_(&h800C0400)
#endif

#define INET_E_CODE_INSTALL_BLOCKED_BY_HASH_POLICY _HRESULT_TYPEDEF_(&h800C0500)
#define INET_E_DOWNLOAD_BLOCKED_BY_INPRIVATE _HRESULT_TYPEDEF_(&h800C0501)
#define INET_E_CODE_INSTALL_BLOCKED_IMMERSIVE _HRESULT_TYPEDEF_(&h800C0502)
#define INET_E_FORBIDFRAMING _HRESULT_TYPEDEF_(&h800C0503)
#define INET_E_CODE_INSTALL_BLOCKED_ARM _HRESULT_TYPEDEF_(&h800C0504)
#define INET_E_BLOCKED_PLUGGABLE_PROTOCOL _HRESULT_TYPEDEF_(&h800C0505)
#define INET_E_ERROR_LAST INET_E_BLOCKED_PLUGGABLE_PROTOCOL
#define _LPPERSISTMONIKER_DEFINED
#define __IPersistMoniker_INTERFACE_DEFINED__
type IPersistMoniker as IPersistMoniker_
type LPPERSISTMONIKER as IPersistMoniker ptr
extern IID_IPersistMoniker as const GUID

type IPersistMonikerVtbl
	QueryInterface as function(byval This as IPersistMoniker ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistMoniker ptr) as ULONG
	Release as function(byval This as IPersistMoniker ptr) as ULONG
	GetClassID as function(byval This as IPersistMoniker ptr, byval pClassID as CLSID ptr) as HRESULT
	IsDirty as function(byval This as IPersistMoniker ptr) as HRESULT
	Load as function(byval This as IPersistMoniker ptr, byval fFullyAvailable as WINBOOL, byval pimkName as IMoniker ptr, byval pibc as LPBC, byval grfMode as DWORD) as HRESULT
	Save as function(byval This as IPersistMoniker ptr, byval pimkName as IMoniker ptr, byval pbc as LPBC, byval fRemember as WINBOOL) as HRESULT
	SaveCompleted as function(byval This as IPersistMoniker ptr, byval pimkName as IMoniker ptr, byval pibc as LPBC) as HRESULT
	GetCurMoniker as function(byval This as IPersistMoniker ptr, byval ppimkName as IMoniker ptr ptr) as HRESULT
end type

type IPersistMoniker_
	lpVtbl as IPersistMonikerVtbl ptr
end type

#define IPersistMoniker_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistMoniker_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistMoniker_Release(This) (This)->lpVtbl->Release(This)
#define IPersistMoniker_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define IPersistMoniker_IsDirty(This) (This)->lpVtbl->IsDirty(This)
#define IPersistMoniker_Load(This, fFullyAvailable, pimkName, pibc, grfMode) (This)->lpVtbl->Load(This, fFullyAvailable, pimkName, pibc, grfMode)
#define IPersistMoniker_Save(This, pimkName, pbc, fRemember) (This)->lpVtbl->Save(This, pimkName, pbc, fRemember)
#define IPersistMoniker_SaveCompleted(This, pimkName, pibc) (This)->lpVtbl->SaveCompleted(This, pimkName, pibc)
#define IPersistMoniker_GetCurMoniker(This, ppimkName) (This)->lpVtbl->GetCurMoniker(This, ppimkName)

declare function IPersistMoniker_GetClassID_Proxy(byval This as IPersistMoniker ptr, byval pClassID as CLSID ptr) as HRESULT
declare sub IPersistMoniker_GetClassID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMoniker_IsDirty_Proxy(byval This as IPersistMoniker ptr) as HRESULT
declare sub IPersistMoniker_IsDirty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMoniker_Load_Proxy(byval This as IPersistMoniker ptr, byval fFullyAvailable as WINBOOL, byval pimkName as IMoniker ptr, byval pibc as LPBC, byval grfMode as DWORD) as HRESULT
declare sub IPersistMoniker_Load_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMoniker_Save_Proxy(byval This as IPersistMoniker ptr, byval pimkName as IMoniker ptr, byval pbc as LPBC, byval fRemember as WINBOOL) as HRESULT
declare sub IPersistMoniker_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMoniker_SaveCompleted_Proxy(byval This as IPersistMoniker ptr, byval pimkName as IMoniker ptr, byval pibc as LPBC) as HRESULT
declare sub IPersistMoniker_SaveCompleted_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistMoniker_GetCurMoniker_Proxy(byval This as IPersistMoniker ptr, byval ppimkName as IMoniker ptr ptr) as HRESULT
declare sub IPersistMoniker_GetCurMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPMONIKERPROP_DEFINED
#define __IMonikerProp_INTERFACE_DEFINED__
type IMonikerProp as IMonikerProp_
type LPMONIKERPROP as IMonikerProp ptr

type __WIDL_urlmon_generated_name_00000002 as long
enum
	MIMETYPEPROP = &h0
	USE_SRC_URL = &h1
	CLASSIDPROP = &h2
	TRUSTEDDOWNLOADPROP = &h3
	POPUPLEVELPROP = &h4
end enum

type MONIKERPROPERTY as __WIDL_urlmon_generated_name_00000002
extern IID_IMonikerProp as const GUID

type IMonikerPropVtbl
	QueryInterface as function(byval This as IMonikerProp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMonikerProp ptr) as ULONG
	Release as function(byval This as IMonikerProp ptr) as ULONG
	PutProperty as function(byval This as IMonikerProp ptr, byval mkp as MONIKERPROPERTY, byval val as LPCWSTR) as HRESULT
end type

type IMonikerProp_
	lpVtbl as IMonikerPropVtbl ptr
end type

#define IMonikerProp_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMonikerProp_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMonikerProp_Release(This) (This)->lpVtbl->Release(This)
#define IMonikerProp_PutProperty(This, mkp, val) (This)->lpVtbl->PutProperty(This, mkp, val)
declare function IMonikerProp_PutProperty_Proxy(byval This as IMonikerProp ptr, byval mkp as MONIKERPROPERTY, byval val as LPCWSTR) as HRESULT
declare sub IMonikerProp_PutProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPBINDPROTOCOL_DEFINED
#define __IBindProtocol_INTERFACE_DEFINED__
type IBindProtocol as IBindProtocol_
type LPBINDPROTOCOL as IBindProtocol ptr
extern IID_IBindProtocol as const GUID

type IBindProtocolVtbl
	QueryInterface as function(byval This as IBindProtocol ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBindProtocol ptr) as ULONG
	Release as function(byval This as IBindProtocol ptr) as ULONG
	CreateBinding as function(byval This as IBindProtocol ptr, byval szUrl as LPCWSTR, byval pbc as IBindCtx ptr, byval ppb as IBinding ptr ptr) as HRESULT
end type

type IBindProtocol_
	lpVtbl as IBindProtocolVtbl ptr
end type

#define IBindProtocol_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBindProtocol_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindProtocol_Release(This) (This)->lpVtbl->Release(This)
#define IBindProtocol_CreateBinding(This, szUrl, pbc, ppb) (This)->lpVtbl->CreateBinding(This, szUrl, pbc, ppb)
declare function IBindProtocol_CreateBinding_Proxy(byval This as IBindProtocol ptr, byval szUrl as LPCWSTR, byval pbc as IBindCtx ptr, byval ppb as IBinding ptr ptr) as HRESULT
declare sub IBindProtocol_CreateBinding_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPBINDING_DEFINED
#define __IBinding_INTERFACE_DEFINED__
type LPBINDING as IBinding ptr
extern IID_IBinding as const GUID

type IBindingVtbl
	QueryInterface as function(byval This as IBinding ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBinding ptr) as ULONG
	Release as function(byval This as IBinding ptr) as ULONG
	Abort as function(byval This as IBinding ptr) as HRESULT
	Suspend as function(byval This as IBinding ptr) as HRESULT
	Resume as function(byval This as IBinding ptr) as HRESULT
	SetPriority as function(byval This as IBinding ptr, byval nPriority as LONG) as HRESULT
	GetPriority as function(byval This as IBinding ptr, byval pnPriority as LONG ptr) as HRESULT
	GetBindResult as function(byval This as IBinding ptr, byval pclsidProtocol as CLSID ptr, byval pdwResult as DWORD ptr, byval pszResult as LPOLESTR ptr, byval pdwReserved as DWORD ptr) as HRESULT
end type

type IBinding_
	lpVtbl as IBindingVtbl ptr
end type

#define IBinding_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBinding_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBinding_Release(This) (This)->lpVtbl->Release(This)
#define IBinding_Abort(This) (This)->lpVtbl->Abort(This)
#define IBinding_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IBinding_Resume(This) (This)->lpVtbl->Resume(This)
#define IBinding_SetPriority(This, nPriority) (This)->lpVtbl->SetPriority(This, nPriority)
#define IBinding_GetPriority(This, pnPriority) (This)->lpVtbl->GetPriority(This, pnPriority)
#define IBinding_GetBindResult(This, pclsidProtocol, pdwResult, pszResult, pdwReserved) (This)->lpVtbl->GetBindResult(This, pclsidProtocol, pdwResult, pszResult, pdwReserved)

declare function IBinding_Abort_Proxy(byval This as IBinding ptr) as HRESULT
declare sub IBinding_Abort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_Suspend_Proxy(byval This as IBinding ptr) as HRESULT
declare sub IBinding_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_Resume_Proxy(byval This as IBinding ptr) as HRESULT
declare sub IBinding_Resume_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_SetPriority_Proxy(byval This as IBinding ptr, byval nPriority as LONG) as HRESULT
declare sub IBinding_SetPriority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_GetPriority_Proxy(byval This as IBinding ptr, byval pnPriority as LONG ptr) as HRESULT
declare sub IBinding_GetPriority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_RemoteGetBindResult_Proxy(byval This as IBinding ptr, byval pclsidProtocol as CLSID ptr, byval pdwResult as DWORD ptr, byval pszResult as LPOLESTR ptr, byval dwReserved as DWORD) as HRESULT
declare sub IBinding_RemoteGetBindResult_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBinding_GetBindResult_Proxy(byval This as IBinding ptr, byval pclsidProtocol as CLSID ptr, byval pdwResult as DWORD ptr, byval pszResult as LPOLESTR ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare function IBinding_GetBindResult_Stub(byval This as IBinding ptr, byval pclsidProtocol as CLSID ptr, byval pdwResult as DWORD ptr, byval pszResult as LPOLESTR ptr, byval dwReserved as DWORD) as HRESULT
#define _LPBINDSTATUSCALLBACK_DEFINED
#define __IBindStatusCallback_INTERFACE_DEFINED__
type LPBINDSTATUSCALLBACK as IBindStatusCallback ptr

type __WIDL_urlmon_generated_name_00000003 as long
enum
	BINDVERB_GET = &h0
	BINDVERB_POST = &h1
	BINDVERB_PUT = &h2
	BINDVERB_CUSTOM = &h3
	BINDVERB_RESERVED1 = &h4
end enum

type BINDVERB as __WIDL_urlmon_generated_name_00000003

type __WIDL_urlmon_generated_name_00000004 as long
enum
	BINDINFOF_URLENCODESTGMEDDATA = &h1
	BINDINFOF_URLENCODEDEXTRAINFO = &h2
end enum

type BINDINFOF as __WIDL_urlmon_generated_name_00000004

type __WIDL_urlmon_generated_name_00000005 as long
enum
	BINDF_ASYNCHRONOUS = &h1
	BINDF_ASYNCSTORAGE = &h2
	BINDF_NOPROGRESSIVERENDERING = &h4
	BINDF_OFFLINEOPERATION = &h8
	BINDF_GETNEWESTVERSION = &h10
	BINDF_NOWRITECACHE = &h20
	BINDF_NEEDFILE = &h40
	BINDF_PULLDATA = &h80
	BINDF_IGNORESECURITYPROBLEM = &h100
	BINDF_RESYNCHRONIZE = &h200
	BINDF_HYPERLINK = &h400
	BINDF_NO_UI = &h800
	BINDF_SILENTOPERATION = &h1000
	BINDF_PRAGMA_NO_CACHE = &h2000
	BINDF_GETCLASSOBJECT = &h4000
	BINDF_RESERVED_1 = &h8000
	BINDF_FREE_THREADED = &h10000
	BINDF_DIRECT_READ = &h20000
	BINDF_FORMS_SUBMIT = &h40000
	BINDF_GETFROMCACHE_IF_NET_FAIL = &h80000
	BINDF_FROMURLMON = &h100000
	BINDF_FWD_BACK = &h200000
	BINDF_PREFERDEFAULTHANDLER = &h400000
	BINDF_ENFORCERESTRICTED = &h800000
	BINDF_RESERVED_2 = &h80000000
	BINDF_RESERVED_3 = &h1000000
	BINDF_RESERVED_4 = &h2000000
	BINDF_RESERVED_5 = &h4000000
	BINDF_RESERVED_6 = &h8000000
	BINDF_RESERVED_7 = &h40000000
	BINDF_RESERVED_8 = &h20000000
end enum

const BINDF_NOCOPYDATA = BINDF_PULLDATA
const BINDF_DONTPUTINCACHE = BINDF_NOWRITECACHE
const BINDF_DONTUSECACHE = BINDF_GETNEWESTVERSION
type BINDF as __WIDL_urlmon_generated_name_00000005

type __WIDL_urlmon_generated_name_00000006 as long
enum
	URL_ENCODING_NONE = &h0
	URL_ENCODING_ENABLE_UTF8 = &h10000000
	URL_ENCODING_DISABLE_UTF8 = &h20000000
end enum

type URL_ENCODING as __WIDL_urlmon_generated_name_00000006

type _tagBINDINFO
	cbSize as ULONG
	szExtraInfo as LPWSTR
	stgmedData as STGMEDIUM
	grfBindInfoF as DWORD
	dwBindVerb as DWORD
	szCustomVerb as LPWSTR
	cbstgmedData as DWORD
	dwOptions as DWORD
	dwOptionsFlags as DWORD
	dwCodePage as DWORD
	securityAttributes as SECURITY_ATTRIBUTES
	iid as IID
	pUnk as IUnknown ptr
	dwReserved as DWORD
end type

type BINDINFO as _tagBINDINFO

type _REMSECURITY_ATTRIBUTES
	nLength as DWORD
	lpSecurityDescriptor as DWORD
	bInheritHandle as WINBOOL
end type

type REMSECURITY_ATTRIBUTES as _REMSECURITY_ATTRIBUTES
type PREMSECURITY_ATTRIBUTES as _REMSECURITY_ATTRIBUTES ptr
type LPREMSECURITY_ATTRIBUTES as _REMSECURITY_ATTRIBUTES ptr

type _tagRemBINDINFO
	cbSize as ULONG
	szExtraInfo as LPWSTR
	grfBindInfoF as DWORD
	dwBindVerb as DWORD
	szCustomVerb as LPWSTR
	cbstgmedData as DWORD
	dwOptions as DWORD
	dwOptionsFlags as DWORD
	dwCodePage as DWORD
	securityAttributes as REMSECURITY_ATTRIBUTES
	iid as IID
	pUnk as IUnknown ptr
	dwReserved as DWORD
end type

type RemBINDINFO as _tagRemBINDINFO

type tagRemFORMATETC
	cfFormat as DWORD
	ptd as DWORD
	dwAspect as DWORD
	lindex as LONG
	tymed as DWORD
end type

type RemFORMATETC as tagRemFORMATETC
type LPREMFORMATETC as tagRemFORMATETC ptr

type __WIDL_urlmon_generated_name_00000007 as long
enum
	BINDINFO_OPTIONS_WININETFLAG = &h10000
	BINDINFO_OPTIONS_ENABLE_UTF8 = &h20000
	BINDINFO_OPTIONS_DISABLE_UTF8 = &h40000
	BINDINFO_OPTIONS_USE_IE_ENCODING = &h80000
	BINDINFO_OPTIONS_BINDTOOBJECT = &h100000
	BINDINFO_OPTIONS_SECURITYOPTOUT = &h200000
	BINDINFO_OPTIONS_IGNOREMIMETEXTPLAIN = &h400000
	BINDINFO_OPTIONS_USEBINDSTRINGCREDS = &h800000
	BINDINFO_OPTIONS_IGNOREHTTPHTTPSREDIRECTS = &h1000000
	BINDINFO_OPTIONS_IGNORE_SSLERRORS_ONCE = &h2000000
	BINDINFO_WPC_DOWNLOADBLOCKED = &h8000000
	BINDINFO_WPC_LOGGING_ENABLED = &h10000000
	BINDINFO_OPTIONS_ALLOWCONNECTDATA = &h20000000
	BINDINFO_OPTIONS_DISABLEAUTOREDIRECTS = &h40000000
	BINDINFO_OPTIONS_SHDOCVW_NAVIGATE = clng(&h80000000)
end enum

type BINDINFO_OPTIONS as __WIDL_urlmon_generated_name_00000007

type __WIDL_urlmon_generated_name_00000008 as long
enum
	BSCF_FIRSTDATANOTIFICATION = &h1
	BSCF_INTERMEDIATEDATANOTIFICATION = &h2
	BSCF_LASTDATANOTIFICATION = &h4
	BSCF_DATAFULLYAVAILABLE = &h8
	BSCF_AVAILABLEDATASIZEUNKNOWN = &h10
	BSCF_SKIPDRAINDATAFORFILEURLS = &h20
	BSCF_64BITLENGTHDOWNLOAD = &h40
end enum

type BSCF as __WIDL_urlmon_generated_name_00000008

type tagBINDSTATUS as long
enum
	BINDSTATUS_FINDINGRESOURCE = 1
	BINDSTATUS_CONNECTING = 2
	BINDSTATUS_REDIRECTING = 3
	BINDSTATUS_BEGINDOWNLOADDATA = 4
	BINDSTATUS_DOWNLOADINGDATA = 5
	BINDSTATUS_ENDDOWNLOADDATA = 6
	BINDSTATUS_BEGINDOWNLOADCOMPONENTS = 7
	BINDSTATUS_INSTALLINGCOMPONENTS = 8
	BINDSTATUS_ENDDOWNLOADCOMPONENTS = 9
	BINDSTATUS_USINGCACHEDCOPY = 10
	BINDSTATUS_SENDINGREQUEST = 11
	BINDSTATUS_CLASSIDAVAILABLE = 12
	BINDSTATUS_MIMETYPEAVAILABLE = 13
	BINDSTATUS_CACHEFILENAMEAVAILABLE = 14
	BINDSTATUS_BEGINSYNCOPERATION = 15
	BINDSTATUS_ENDSYNCOPERATION = 16
	BINDSTATUS_BEGINUPLOADDATA = 17
	BINDSTATUS_UPLOADINGDATA = 18
	BINDSTATUS_ENDUPLOADDATA = 19
	BINDSTATUS_PROTOCOLCLASSID = 20
	BINDSTATUS_ENCODING = 21
	BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE = 22
	BINDSTATUS_CLASSINSTALLLOCATION = 23
	BINDSTATUS_DECODING = 24
	BINDSTATUS_LOADINGMIMEHANDLER = 25
	BINDSTATUS_CONTENTDISPOSITIONATTACH = 26
	BINDSTATUS_FILTERREPORTMIMETYPE = 27
	BINDSTATUS_CLSIDCANINSTANTIATE = 28
	BINDSTATUS_IUNKNOWNAVAILABLE = 29
	BINDSTATUS_DIRECTBIND = 30
	BINDSTATUS_RAWMIMETYPE = 31
	BINDSTATUS_PROXYDETECTING = 32
	BINDSTATUS_ACCEPTRANGES = 33
	BINDSTATUS_COOKIE_SENT = 34
	BINDSTATUS_COMPACT_POLICY_RECEIVED = 35
	BINDSTATUS_COOKIE_SUPPRESSED = 36
	BINDSTATUS_COOKIE_STATE_UNKNOWN = 37
	BINDSTATUS_COOKIE_STATE_ACCEPT = 38
	BINDSTATUS_COOKIE_STATE_REJECT = 39
	BINDSTATUS_COOKIE_STATE_PROMPT = 40
	BINDSTATUS_COOKIE_STATE_LEASH = 41
	BINDSTATUS_COOKIE_STATE_DOWNGRADE = 42
	BINDSTATUS_POLICY_HREF = 43
	BINDSTATUS_P3P_HEADER = 44
	BINDSTATUS_SESSION_COOKIE_RECEIVED = 45
	BINDSTATUS_PERSISTENT_COOKIE_RECEIVED = 46
	BINDSTATUS_SESSION_COOKIES_ALLOWED = 47
	BINDSTATUS_CACHECONTROL = 48
	BINDSTATUS_CONTENTDISPOSITIONFILENAME = 49
	BINDSTATUS_MIMETEXTPLAINMISMATCH = 50
	BINDSTATUS_PUBLISHERAVAILABLE = 51
	BINDSTATUS_DISPLAYNAMEAVAILABLE = 52
	BINDSTATUS_SSLUX_NAVBLOCKED = 53
	BINDSTATUS_SERVER_MIMETYPEAVAILABLE = 54
	BINDSTATUS_SNIFFED_CLASSIDAVAILABLE = 55
	BINDSTATUS_64BIT_PROGRESS = 56
	BINDSTATUS_LAST = BINDSTATUS_64BIT_PROGRESS
	BINDSTATUS_RESERVED_0 = 57
	BINDSTATUS_RESERVED_1 = 58
	BINDSTATUS_RESERVED_2 = 59
	BINDSTATUS_RESERVED_3 = 60
	BINDSTATUS_RESERVED_4 = 61
	BINDSTATUS_RESERVED_5 = 62
	BINDSTATUS_RESERVED_6 = 63
	BINDSTATUS_RESERVED_7 = 64
	BINDSTATUS_RESERVED_8 = 65
	BINDSTATUS_RESERVED_9 = 66
	BINDSTATUS_LAST_PRIVATE = BINDSTATUS_RESERVED_9
end enum

type BINDSTATUS as tagBINDSTATUS
extern IID_IBindStatusCallback as const GUID

type IBindStatusCallbackVtbl
	QueryInterface as function(byval This as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBindStatusCallback ptr) as ULONG
	Release as function(byval This as IBindStatusCallback ptr) as ULONG
	OnStartBinding as function(byval This as IBindStatusCallback ptr, byval dwReserved as DWORD, byval pib as IBinding ptr) as HRESULT
	GetPriority as function(byval This as IBindStatusCallback ptr, byval pnPriority as LONG ptr) as HRESULT
	OnLowResource as function(byval This as IBindStatusCallback ptr, byval reserved as DWORD) as HRESULT
	OnProgress as function(byval This as IBindStatusCallback ptr, byval ulProgress as ULONG, byval ulProgressMax as ULONG, byval ulStatusCode as ULONG, byval szStatusText as LPCWSTR) as HRESULT
	OnStopBinding as function(byval This as IBindStatusCallback ptr, byval hresult as HRESULT, byval szError as LPCWSTR) as HRESULT
	GetBindInfo as function(byval This as IBindStatusCallback ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
	OnDataAvailable as function(byval This as IBindStatusCallback ptr, byval grfBSCF as DWORD, byval dwSize as DWORD, byval pformatetc as FORMATETC ptr, byval pstgmed as STGMEDIUM ptr) as HRESULT
	OnObjectAvailable as function(byval This as IBindStatusCallback ptr, byval riid as const IID const ptr, byval punk as IUnknown ptr) as HRESULT
end type

type IBindStatusCallback_
	lpVtbl as IBindStatusCallbackVtbl ptr
end type

#define IBindStatusCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBindStatusCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindStatusCallback_Release(This) (This)->lpVtbl->Release(This)
#define IBindStatusCallback_OnStartBinding(This, dwReserved, pib) (This)->lpVtbl->OnStartBinding(This, dwReserved, pib)
#define IBindStatusCallback_GetPriority(This, pnPriority) (This)->lpVtbl->GetPriority(This, pnPriority)
#define IBindStatusCallback_OnLowResource(This, reserved) (This)->lpVtbl->OnLowResource(This, reserved)
#define IBindStatusCallback_OnProgress(This, ulProgress, ulProgressMax, ulStatusCode, szStatusText) (This)->lpVtbl->OnProgress(This, ulProgress, ulProgressMax, ulStatusCode, szStatusText)
#define IBindStatusCallback_OnStopBinding(This, hresult, szError) (This)->lpVtbl->OnStopBinding(This, hresult, szError)
#define IBindStatusCallback_GetBindInfo(This, grfBINDF, pbindinfo) (This)->lpVtbl->GetBindInfo(This, grfBINDF, pbindinfo)
#define IBindStatusCallback_OnDataAvailable(This, grfBSCF, dwSize, pformatetc, pstgmed) (This)->lpVtbl->OnDataAvailable(This, grfBSCF, dwSize, pformatetc, pstgmed)
#define IBindStatusCallback_OnObjectAvailable(This, riid, punk) (This)->lpVtbl->OnObjectAvailable(This, riid, punk)

declare function IBindStatusCallback_OnStartBinding_Proxy(byval This as IBindStatusCallback ptr, byval dwReserved as DWORD, byval pib as IBinding ptr) as HRESULT
declare sub IBindStatusCallback_OnStartBinding_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_GetPriority_Proxy(byval This as IBindStatusCallback ptr, byval pnPriority as LONG ptr) as HRESULT
declare sub IBindStatusCallback_GetPriority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_OnLowResource_Proxy(byval This as IBindStatusCallback ptr, byval reserved as DWORD) as HRESULT
declare sub IBindStatusCallback_OnLowResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_OnProgress_Proxy(byval This as IBindStatusCallback ptr, byval ulProgress as ULONG, byval ulProgressMax as ULONG, byval ulStatusCode as ULONG, byval szStatusText as LPCWSTR) as HRESULT
declare sub IBindStatusCallback_OnProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_OnStopBinding_Proxy(byval This as IBindStatusCallback ptr, byval hresult as HRESULT, byval szError as LPCWSTR) as HRESULT
declare sub IBindStatusCallback_OnStopBinding_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_RemoteGetBindInfo_Proxy(byval This as IBindStatusCallback ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as RemBINDINFO ptr, byval pstgmed as RemSTGMEDIUM ptr) as HRESULT
declare sub IBindStatusCallback_RemoteGetBindInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_RemoteOnDataAvailable_Proxy(byval This as IBindStatusCallback ptr, byval grfBSCF as DWORD, byval dwSize as DWORD, byval pformatetc as RemFORMATETC ptr, byval pstgmed as RemSTGMEDIUM ptr) as HRESULT
declare sub IBindStatusCallback_RemoteOnDataAvailable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_OnObjectAvailable_Proxy(byval This as IBindStatusCallback ptr, byval riid as const IID const ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IBindStatusCallback_OnObjectAvailable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallback_GetBindInfo_Proxy(byval This as IBindStatusCallback ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
declare function IBindStatusCallback_GetBindInfo_Stub(byval This as IBindStatusCallback ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as RemBINDINFO ptr, byval pstgmed as RemSTGMEDIUM ptr) as HRESULT
declare function IBindStatusCallback_OnDataAvailable_Proxy(byval This as IBindStatusCallback ptr, byval grfBSCF as DWORD, byval dwSize as DWORD, byval pformatetc as FORMATETC ptr, byval pstgmed as STGMEDIUM ptr) as HRESULT
declare function IBindStatusCallback_OnDataAvailable_Stub(byval This as IBindStatusCallback ptr, byval grfBSCF as DWORD, byval dwSize as DWORD, byval pformatetc as RemFORMATETC ptr, byval pstgmed as RemSTGMEDIUM ptr) as HRESULT
#define _LPBINDSTATUSCALLBACKEX_DEFINED
#define __IBindStatusCallbackEx_INTERFACE_DEFINED__
type IBindStatusCallbackEx as IBindStatusCallbackEx_
type LPBINDSTATUSCALLBACKEX as IBindStatusCallbackEx ptr

type __WIDL_urlmon_generated_name_00000009 as long
enum
	BINDF2_DISABLEBASICOVERHTTP = &h1
	BINDF2_DISABLEAUTOCOOKIEHANDLING = &h2
	BINDF2_READ_DATA_GREATER_THAN_4GB = &h4
	BINDF2_DISABLE_HTTP_REDIRECT_XSECURITYID = &h8
	BINDF2_SETDOWNLOADMODE = &h20
	BINDF2_DISABLE_HTTP_REDIRECT_CACHING = &h40
	BINDF2_KEEP_CALLBACK_MODULE_LOADED = &h80
	BINDF2_ALLOW_PROXY_CRED_PROMPT = &h100
	BINDF2_RESERVED_F = &h20000
	BINDF2_RESERVED_E = &h40000
	BINDF2_RESERVED_D = &h80000
	BINDF2_RESERVED_C = &h100000
	BINDF2_RESERVED_B = &h200000
	BINDF2_RESERVED_A = &h400000
	BINDF2_RESERVED_9 = &h800000
	BINDF2_RESERVED_8 = &h1000000
	BINDF2_RESERVED_7 = &h2000000
	BINDF2_RESERVED_6 = &h4000000
	BINDF2_RESERVED_5 = &h8000000
	BINDF2_RESERVED_4 = &h10000000
	BINDF2_RESERVED_3 = &h20000000
	BINDF2_RESERVED_2 = &h40000000
	BINDF2_RESERVED_1 = &h80000000
end enum

type BINDF2 as __WIDL_urlmon_generated_name_00000009
extern IID_IBindStatusCallbackEx as const GUID

type IBindStatusCallbackExVtbl
	QueryInterface as function(byval This as IBindStatusCallbackEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBindStatusCallbackEx ptr) as ULONG
	Release as function(byval This as IBindStatusCallbackEx ptr) as ULONG
	OnStartBinding as function(byval This as IBindStatusCallbackEx ptr, byval dwReserved as DWORD, byval pib as IBinding ptr) as HRESULT
	GetPriority as function(byval This as IBindStatusCallbackEx ptr, byval pnPriority as LONG ptr) as HRESULT
	OnLowResource as function(byval This as IBindStatusCallbackEx ptr, byval reserved as DWORD) as HRESULT
	OnProgress as function(byval This as IBindStatusCallbackEx ptr, byval ulProgress as ULONG, byval ulProgressMax as ULONG, byval ulStatusCode as ULONG, byval szStatusText as LPCWSTR) as HRESULT
	OnStopBinding as function(byval This as IBindStatusCallbackEx ptr, byval hresult as HRESULT, byval szError as LPCWSTR) as HRESULT
	GetBindInfo as function(byval This as IBindStatusCallbackEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
	OnDataAvailable as function(byval This as IBindStatusCallbackEx ptr, byval grfBSCF as DWORD, byval dwSize as DWORD, byval pformatetc as FORMATETC ptr, byval pstgmed as STGMEDIUM ptr) as HRESULT
	OnObjectAvailable as function(byval This as IBindStatusCallbackEx ptr, byval riid as const IID const ptr, byval punk as IUnknown ptr) as HRESULT
	GetBindInfoEx as function(byval This as IBindStatusCallbackEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
end type

type IBindStatusCallbackEx_
	lpVtbl as IBindStatusCallbackExVtbl ptr
end type

#define IBindStatusCallbackEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBindStatusCallbackEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindStatusCallbackEx_Release(This) (This)->lpVtbl->Release(This)
#define IBindStatusCallbackEx_OnStartBinding(This, dwReserved, pib) (This)->lpVtbl->OnStartBinding(This, dwReserved, pib)
#define IBindStatusCallbackEx_GetPriority(This, pnPriority) (This)->lpVtbl->GetPriority(This, pnPriority)
#define IBindStatusCallbackEx_OnLowResource(This, reserved) (This)->lpVtbl->OnLowResource(This, reserved)
#define IBindStatusCallbackEx_OnProgress(This, ulProgress, ulProgressMax, ulStatusCode, szStatusText) (This)->lpVtbl->OnProgress(This, ulProgress, ulProgressMax, ulStatusCode, szStatusText)
#define IBindStatusCallbackEx_OnStopBinding(This, hresult, szError) (This)->lpVtbl->OnStopBinding(This, hresult, szError)
#define IBindStatusCallbackEx_GetBindInfo(This, grfBINDF, pbindinfo) (This)->lpVtbl->GetBindInfo(This, grfBINDF, pbindinfo)
#define IBindStatusCallbackEx_OnDataAvailable(This, grfBSCF, dwSize, pformatetc, pstgmed) (This)->lpVtbl->OnDataAvailable(This, grfBSCF, dwSize, pformatetc, pstgmed)
#define IBindStatusCallbackEx_OnObjectAvailable(This, riid, punk) (This)->lpVtbl->OnObjectAvailable(This, riid, punk)
#define IBindStatusCallbackEx_GetBindInfoEx(This, grfBINDF, pbindinfo, grfBINDF2, pdwReserved) (This)->lpVtbl->GetBindInfoEx(This, grfBINDF, pbindinfo, grfBINDF2, pdwReserved)

declare function IBindStatusCallbackEx_RemoteGetBindInfoEx_Proxy(byval This as IBindStatusCallbackEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as RemBINDINFO ptr, byval pstgmed as RemSTGMEDIUM ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare sub IBindStatusCallbackEx_RemoteGetBindInfoEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindStatusCallbackEx_GetBindInfoEx_Proxy(byval This as IBindStatusCallbackEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare function IBindStatusCallbackEx_GetBindInfoEx_Stub(byval This as IBindStatusCallbackEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as RemBINDINFO ptr, byval pstgmed as RemSTGMEDIUM ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
#define _LPAUTHENTICATION_DEFINED
#define __IAuthenticate_INTERFACE_DEFINED__
type IAuthenticate as IAuthenticate_
type LPAUTHENTICATION as IAuthenticate ptr
extern IID_IAuthenticate as const GUID

type IAuthenticateVtbl
	QueryInterface as function(byval This as IAuthenticate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAuthenticate ptr) as ULONG
	Release as function(byval This as IAuthenticate ptr) as ULONG
	Authenticate as function(byval This as IAuthenticate ptr, byval phwnd as HWND ptr, byval pszUsername as LPWSTR ptr, byval pszPassword as LPWSTR ptr) as HRESULT
end type

type IAuthenticate_
	lpVtbl as IAuthenticateVtbl ptr
end type

#define IAuthenticate_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAuthenticate_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAuthenticate_Release(This) (This)->lpVtbl->Release(This)
#define IAuthenticate_Authenticate(This, phwnd, pszUsername, pszPassword) (This)->lpVtbl->Authenticate(This, phwnd, pszUsername, pszPassword)
declare function IAuthenticate_Authenticate_Proxy(byval This as IAuthenticate ptr, byval phwnd as HWND ptr, byval pszUsername as LPWSTR ptr, byval pszPassword as LPWSTR ptr) as HRESULT
declare sub IAuthenticate_Authenticate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPAUTHENTICATIONEX_DEFINED
#define __IAuthenticateEx_INTERFACE_DEFINED__
type IAuthenticateEx as IAuthenticateEx_
type LPAUTHENTICATIONEX as IAuthenticateEx ptr

type __WIDL_urlmon_generated_name_0000000A as long
enum
	AUTHENTICATEF_PROXY = &h1
	AUTHENTICATEF_BASIC = &h2
	AUTHENTICATEF_HTTP = &h4
end enum

type AUTHENTICATEF as __WIDL_urlmon_generated_name_0000000A

type _tagAUTHENTICATEINFO
	dwFlags as DWORD
	dwReserved as DWORD
end type

type AUTHENTICATEINFO as _tagAUTHENTICATEINFO
extern IID_IAuthenticateEx as const GUID

type IAuthenticateExVtbl
	QueryInterface as function(byval This as IAuthenticateEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAuthenticateEx ptr) as ULONG
	Release as function(byval This as IAuthenticateEx ptr) as ULONG
	Authenticate as function(byval This as IAuthenticateEx ptr, byval phwnd as HWND ptr, byval pszUsername as LPWSTR ptr, byval pszPassword as LPWSTR ptr) as HRESULT
	AuthenticateEx as function(byval This as IAuthenticateEx ptr, byval phwnd as HWND ptr, byval pszUsername as LPWSTR ptr, byval pszPassword as LPWSTR ptr, byval pauthinfo as AUTHENTICATEINFO ptr) as HRESULT
end type

type IAuthenticateEx_
	lpVtbl as IAuthenticateExVtbl ptr
end type

#define IAuthenticateEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAuthenticateEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAuthenticateEx_Release(This) (This)->lpVtbl->Release(This)
#define IAuthenticateEx_Authenticate(This, phwnd, pszUsername, pszPassword) (This)->lpVtbl->Authenticate(This, phwnd, pszUsername, pszPassword)
#define IAuthenticateEx_AuthenticateEx(This, phwnd, pszUsername, pszPassword, pauthinfo) (This)->lpVtbl->AuthenticateEx(This, phwnd, pszUsername, pszPassword, pauthinfo)
declare function IAuthenticateEx_AuthenticateEx_Proxy(byval This as IAuthenticateEx ptr, byval phwnd as HWND ptr, byval pszUsername as LPWSTR ptr, byval pszPassword as LPWSTR ptr, byval pauthinfo as AUTHENTICATEINFO ptr) as HRESULT
declare sub IAuthenticateEx_AuthenticateEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPHTTPNEGOTIATE_DEFINED
#define __IHttpNegotiate_INTERFACE_DEFINED__
type IHttpNegotiate as IHttpNegotiate_
type LPHTTPNEGOTIATE as IHttpNegotiate ptr
extern IID_IHttpNegotiate as const GUID

type IHttpNegotiateVtbl
	QueryInterface as function(byval This as IHttpNegotiate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHttpNegotiate ptr) as ULONG
	Release as function(byval This as IHttpNegotiate ptr) as ULONG
	BeginningTransaction as function(byval This as IHttpNegotiate ptr, byval szURL as LPCWSTR, byval szHeaders as LPCWSTR, byval dwReserved as DWORD, byval pszAdditionalHeaders as LPWSTR ptr) as HRESULT
	OnResponse as function(byval This as IHttpNegotiate ptr, byval dwResponseCode as DWORD, byval szResponseHeaders as LPCWSTR, byval szRequestHeaders as LPCWSTR, byval pszAdditionalRequestHeaders as LPWSTR ptr) as HRESULT
end type

type IHttpNegotiate_
	lpVtbl as IHttpNegotiateVtbl ptr
end type

#define IHttpNegotiate_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHttpNegotiate_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHttpNegotiate_Release(This) (This)->lpVtbl->Release(This)
#define IHttpNegotiate_BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders) (This)->lpVtbl->BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders)
#define IHttpNegotiate_OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders) (This)->lpVtbl->OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders)

declare function IHttpNegotiate_BeginningTransaction_Proxy(byval This as IHttpNegotiate ptr, byval szURL as LPCWSTR, byval szHeaders as LPCWSTR, byval dwReserved as DWORD, byval pszAdditionalHeaders as LPWSTR ptr) as HRESULT
declare sub IHttpNegotiate_BeginningTransaction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHttpNegotiate_OnResponse_Proxy(byval This as IHttpNegotiate ptr, byval dwResponseCode as DWORD, byval szResponseHeaders as LPCWSTR, byval szRequestHeaders as LPCWSTR, byval pszAdditionalRequestHeaders as LPWSTR ptr) as HRESULT
declare sub IHttpNegotiate_OnResponse_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPHTTPNEGOTIATE2_DEFINED
#define __IHttpNegotiate2_INTERFACE_DEFINED__
type IHttpNegotiate2 as IHttpNegotiate2_
type LPHTTPNEGOTIATE2 as IHttpNegotiate2 ptr
extern IID_IHttpNegotiate2 as const GUID

type IHttpNegotiate2Vtbl
	QueryInterface as function(byval This as IHttpNegotiate2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHttpNegotiate2 ptr) as ULONG
	Release as function(byval This as IHttpNegotiate2 ptr) as ULONG
	BeginningTransaction as function(byval This as IHttpNegotiate2 ptr, byval szURL as LPCWSTR, byval szHeaders as LPCWSTR, byval dwReserved as DWORD, byval pszAdditionalHeaders as LPWSTR ptr) as HRESULT
	OnResponse as function(byval This as IHttpNegotiate2 ptr, byval dwResponseCode as DWORD, byval szResponseHeaders as LPCWSTR, byval szRequestHeaders as LPCWSTR, byval pszAdditionalRequestHeaders as LPWSTR ptr) as HRESULT
	GetRootSecurityId as function(byval This as IHttpNegotiate2 ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
end type

type IHttpNegotiate2_
	lpVtbl as IHttpNegotiate2Vtbl ptr
end type

#define IHttpNegotiate2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHttpNegotiate2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHttpNegotiate2_Release(This) (This)->lpVtbl->Release(This)
#define IHttpNegotiate2_BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders) (This)->lpVtbl->BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders)
#define IHttpNegotiate2_OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders) (This)->lpVtbl->OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders)
#define IHttpNegotiate2_GetRootSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetRootSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved)
declare function IHttpNegotiate2_GetRootSecurityId_Proxy(byval This as IHttpNegotiate2 ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IHttpNegotiate2_GetRootSecurityId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPHTTPNEGOTIATE3_DEFINED
#define __IHttpNegotiate3_INTERFACE_DEFINED__
type IHttpNegotiate3 as IHttpNegotiate3_
type LPHTTPNEGOTIATE3 as IHttpNegotiate3 ptr
extern IID_IHttpNegotiate3 as const GUID

type IHttpNegotiate3Vtbl
	QueryInterface as function(byval This as IHttpNegotiate3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHttpNegotiate3 ptr) as ULONG
	Release as function(byval This as IHttpNegotiate3 ptr) as ULONG
	BeginningTransaction as function(byval This as IHttpNegotiate3 ptr, byval szURL as LPCWSTR, byval szHeaders as LPCWSTR, byval dwReserved as DWORD, byval pszAdditionalHeaders as LPWSTR ptr) as HRESULT
	OnResponse as function(byval This as IHttpNegotiate3 ptr, byval dwResponseCode as DWORD, byval szResponseHeaders as LPCWSTR, byval szRequestHeaders as LPCWSTR, byval pszAdditionalRequestHeaders as LPWSTR ptr) as HRESULT
	GetRootSecurityId as function(byval This as IHttpNegotiate3 ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
	GetSerializedClientCertContext as function(byval This as IHttpNegotiate3 ptr, byval ppbCert as UBYTE ptr ptr, byval pcbCert as DWORD ptr) as HRESULT
end type

type IHttpNegotiate3_
	lpVtbl as IHttpNegotiate3Vtbl ptr
end type

#define IHttpNegotiate3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHttpNegotiate3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHttpNegotiate3_Release(This) (This)->lpVtbl->Release(This)
#define IHttpNegotiate3_BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders) (This)->lpVtbl->BeginningTransaction(This, szURL, szHeaders, dwReserved, pszAdditionalHeaders)
#define IHttpNegotiate3_OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders) (This)->lpVtbl->OnResponse(This, dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders)
#define IHttpNegotiate3_GetRootSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetRootSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved)
#define IHttpNegotiate3_GetSerializedClientCertContext(This, ppbCert, pcbCert) (This)->lpVtbl->GetSerializedClientCertContext(This, ppbCert, pcbCert)
declare function IHttpNegotiate3_GetSerializedClientCertContext_Proxy(byval This as IHttpNegotiate3 ptr, byval ppbCert as UBYTE ptr ptr, byval pcbCert as DWORD ptr) as HRESULT
declare sub IHttpNegotiate3_GetSerializedClientCertContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPWININETFILESTREAM_DEFINED
#define __IWinInetFileStream_INTERFACE_DEFINED__
type IWinInetFileStream as IWinInetFileStream_
type LPWININETFILESTREAM as IWinInetFileStream ptr
extern IID_IWinInetFileStream as const GUID

type IWinInetFileStreamVtbl
	QueryInterface as function(byval This as IWinInetFileStream ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWinInetFileStream ptr) as ULONG
	Release as function(byval This as IWinInetFileStream ptr) as ULONG
	SetHandleForUnlock as function(byval This as IWinInetFileStream ptr, byval hWinInetLockHandle as DWORD_PTR, byval dwReserved as DWORD_PTR) as HRESULT
	SetDeleteFile as function(byval This as IWinInetFileStream ptr, byval dwReserved as DWORD_PTR) as HRESULT
end type

type IWinInetFileStream_
	lpVtbl as IWinInetFileStreamVtbl ptr
end type

#define IWinInetFileStream_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWinInetFileStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWinInetFileStream_Release(This) (This)->lpVtbl->Release(This)
#define IWinInetFileStream_SetHandleForUnlock(This, hWinInetLockHandle, dwReserved) (This)->lpVtbl->SetHandleForUnlock(This, hWinInetLockHandle, dwReserved)
#define IWinInetFileStream_SetDeleteFile(This, dwReserved) (This)->lpVtbl->SetDeleteFile(This, dwReserved)

declare function IWinInetFileStream_SetHandleForUnlock_Proxy(byval This as IWinInetFileStream ptr, byval hWinInetLockHandle as DWORD_PTR, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IWinInetFileStream_SetHandleForUnlock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWinInetFileStream_SetDeleteFile_Proxy(byval This as IWinInetFileStream ptr, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IWinInetFileStream_SetDeleteFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPWINDOWFORBINDINGUI_DEFINED
#define __IWindowForBindingUI_INTERFACE_DEFINED__
type IWindowForBindingUI as IWindowForBindingUI_
type LPWINDOWFORBINDINGUI as IWindowForBindingUI ptr
extern IID_IWindowForBindingUI as const GUID

type IWindowForBindingUIVtbl
	QueryInterface as function(byval This as IWindowForBindingUI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWindowForBindingUI ptr) as ULONG
	Release as function(byval This as IWindowForBindingUI ptr) as ULONG
	GetWindow as function(byval This as IWindowForBindingUI ptr, byval rguidReason as const GUID const ptr, byval phwnd as HWND ptr) as HRESULT
end type

type IWindowForBindingUI_
	lpVtbl as IWindowForBindingUIVtbl ptr
end type

#define IWindowForBindingUI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWindowForBindingUI_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWindowForBindingUI_Release(This) (This)->lpVtbl->Release(This)
#define IWindowForBindingUI_GetWindow(This, rguidReason, phwnd) (This)->lpVtbl->GetWindow(This, rguidReason, phwnd)
declare function IWindowForBindingUI_GetWindow_Proxy(byval This as IWindowForBindingUI ptr, byval rguidReason as const GUID const ptr, byval phwnd as HWND ptr) as HRESULT
declare sub IWindowForBindingUI_GetWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPCODEINSTALL_DEFINED
#define __ICodeInstall_INTERFACE_DEFINED__
type ICodeInstall as ICodeInstall_
type LPCODEINSTALL as ICodeInstall ptr

type __WIDL_urlmon_generated_name_0000000B as long
enum
	CIP_DISK_FULL = 0
	CIP_ACCESS_DENIED = 1
	CIP_NEWER_VERSION_EXISTS = 2
	CIP_OLDER_VERSION_EXISTS = 3
	CIP_NAME_CONFLICT = 4
	CIP_TRUST_VERIFICATION_COMPONENT_MISSING = 5
	CIP_EXE_SELF_REGISTERATION_TIMEOUT = 6
	CIP_UNSAFE_TO_ABORT = 7
	CIP_NEED_REBOOT = 8
	CIP_NEED_REBOOT_UI_PERMISSION = 9
end enum

type CIP_STATUS as __WIDL_urlmon_generated_name_0000000B
extern IID_ICodeInstall as const GUID

type ICodeInstallVtbl
	QueryInterface as function(byval This as ICodeInstall ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICodeInstall ptr) as ULONG
	Release as function(byval This as ICodeInstall ptr) as ULONG
	GetWindow as function(byval This as ICodeInstall ptr, byval rguidReason as const GUID const ptr, byval phwnd as HWND ptr) as HRESULT
	OnCodeInstallProblem as function(byval This as ICodeInstall ptr, byval ulStatusCode as ULONG, byval szDestination as LPCWSTR, byval szSource as LPCWSTR, byval dwReserved as DWORD) as HRESULT
end type

type ICodeInstall_
	lpVtbl as ICodeInstallVtbl ptr
end type

#define ICodeInstall_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICodeInstall_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICodeInstall_Release(This) (This)->lpVtbl->Release(This)
#define ICodeInstall_GetWindow(This, rguidReason, phwnd) (This)->lpVtbl->GetWindow(This, rguidReason, phwnd)
#define ICodeInstall_OnCodeInstallProblem(This, ulStatusCode, szDestination, szSource, dwReserved) (This)->lpVtbl->OnCodeInstallProblem(This, ulStatusCode, szDestination, szSource, dwReserved)
declare function ICodeInstall_OnCodeInstallProblem_Proxy(byval This as ICodeInstall ptr, byval ulStatusCode as ULONG, byval szDestination as LPCWSTR, byval szSource as LPCWSTR, byval dwReserved as DWORD) as HRESULT
declare sub ICodeInstall_OnCodeInstallProblem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define _LPUri_DEFINED
	#define __IUri_INTERFACE_DEFINED__

	type __WIDL_urlmon_generated_name_0000000C as long
	enum
		Uri_PROPERTY_ABSOLUTE_URI = 0
		Uri_PROPERTY_STRING_START = Uri_PROPERTY_ABSOLUTE_URI
		Uri_PROPERTY_AUTHORITY = 1
		Uri_PROPERTY_DISPLAY_URI = 2
		Uri_PROPERTY_DOMAIN = 3
		Uri_PROPERTY_EXTENSION = 4
		Uri_PROPERTY_FRAGMENT = 5
		Uri_PROPERTY_HOST = 6
		Uri_PROPERTY_PASSWORD = 7
		Uri_PROPERTY_PATH = 8
		Uri_PROPERTY_PATH_AND_QUERY = 9
		Uri_PROPERTY_QUERY = 10
		Uri_PROPERTY_RAW_URI = 11
		Uri_PROPERTY_SCHEME_NAME = 12
		Uri_PROPERTY_USER_INFO = 13
		Uri_PROPERTY_USER_NAME = 14
		Uri_PROPERTY_STRING_LAST = Uri_PROPERTY_USER_NAME
		Uri_PROPERTY_HOST_TYPE = 15
		Uri_PROPERTY_DWORD_START = Uri_PROPERTY_HOST_TYPE
		Uri_PROPERTY_PORT = 16
		Uri_PROPERTY_SCHEME = 17
		Uri_PROPERTY_ZONE = 18
		Uri_PROPERTY_DWORD_LAST = Uri_PROPERTY_ZONE
	end enum

	type Uri_PROPERTY as __WIDL_urlmon_generated_name_0000000C

	type __WIDL_urlmon_generated_name_0000000D as long
	enum
		Uri_HOST_UNKNOWN = 0
		Uri_HOST_DNS = 1
		Uri_HOST_IPV4 = 2
		Uri_HOST_IPV6 = 3
		Uri_HOST_IDN = 4
	end enum

	type Uri_HOST_TYPE as __WIDL_urlmon_generated_name_0000000D
	extern IID_IUri as const GUID

	type IUriVtbl
		QueryInterface as function(byval This as IUri ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUri ptr) as ULONG
		Release as function(byval This as IUri ptr) as ULONG
		GetPropertyBSTR as function(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pbstrProperty as BSTR ptr, byval dwFlags as DWORD) as HRESULT
		GetPropertyLength as function(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pcchProperty as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		GetPropertyDWORD as function(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pdwProperty as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		HasProperty as function(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pfHasProperty as WINBOOL ptr) as HRESULT
		GetAbsoluteUri as function(byval This as IUri ptr, byval pbstrAbsoluteUri as BSTR ptr) as HRESULT
		GetAuthority as function(byval This as IUri ptr, byval pbstrAuthority as BSTR ptr) as HRESULT
		GetDisplayUri as function(byval This as IUri ptr, byval pbstrDisplayString as BSTR ptr) as HRESULT
		GetDomain as function(byval This as IUri ptr, byval pbstrDomain as BSTR ptr) as HRESULT
		GetExtension as function(byval This as IUri ptr, byval pbstrExtension as BSTR ptr) as HRESULT
		GetFragment as function(byval This as IUri ptr, byval pbstrFragment as BSTR ptr) as HRESULT
		GetHost as function(byval This as IUri ptr, byval pbstrHost as BSTR ptr) as HRESULT
		GetPassword as function(byval This as IUri ptr, byval pbstrPassword as BSTR ptr) as HRESULT
		GetPath as function(byval This as IUri ptr, byval pbstrPath as BSTR ptr) as HRESULT
		GetPathAndQuery as function(byval This as IUri ptr, byval pbstrPathAndQuery as BSTR ptr) as HRESULT
		GetQuery as function(byval This as IUri ptr, byval pbstrQuery as BSTR ptr) as HRESULT
		GetRawUri as function(byval This as IUri ptr, byval pbstrRawUri as BSTR ptr) as HRESULT
		GetSchemeName as function(byval This as IUri ptr, byval pbstrSchemeName as BSTR ptr) as HRESULT
		GetUserInfo as function(byval This as IUri ptr, byval pbstrUserInfo as BSTR ptr) as HRESULT

		#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
			GetUserNameW as function(byval This as IUri ptr, byval pbstrUserName as BSTR ptr) as HRESULT
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
			GetUserNameA as function(byval This as IUri ptr, byval pbstrUserName as BSTR ptr) as HRESULT
		#endif

		GetHostType as function(byval This as IUri ptr, byval pdwHostType as DWORD ptr) as HRESULT
		GetPort as function(byval This as IUri ptr, byval pdwPort as DWORD ptr) as HRESULT
		GetScheme as function(byval This as IUri ptr, byval pdwScheme as DWORD ptr) as HRESULT
		GetZone as function(byval This as IUri ptr, byval pdwZone as DWORD ptr) as HRESULT
		GetProperties as function(byval This as IUri ptr, byval pdwFlags as LPDWORD) as HRESULT
		IsEqual as function(byval This as IUri ptr, byval pUri as IUri ptr, byval pfEqual as WINBOOL ptr) as HRESULT
	end type

	type IUri_
		lpVtbl as IUriVtbl ptr
	end type

	#define IUri_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUri_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUri_Release(This) (This)->lpVtbl->Release(This)
	#define IUri_GetPropertyBSTR(This, uriProp, pbstrProperty, dwFlags) (This)->lpVtbl->GetPropertyBSTR(This, uriProp, pbstrProperty, dwFlags)
	#define IUri_GetPropertyLength(This, uriProp, pcchProperty, dwFlags) (This)->lpVtbl->GetPropertyLength(This, uriProp, pcchProperty, dwFlags)
	#define IUri_GetPropertyDWORD(This, uriProp, pdwProperty, dwFlags) (This)->lpVtbl->GetPropertyDWORD(This, uriProp, pdwProperty, dwFlags)
	#define IUri_HasProperty(This, uriProp, pfHasProperty) (This)->lpVtbl->HasProperty(This, uriProp, pfHasProperty)
	#define IUri_GetAbsoluteUri(This, pbstrAbsoluteUri) (This)->lpVtbl->GetAbsoluteUri(This, pbstrAbsoluteUri)
	#define IUri_GetAuthority(This, pbstrAuthority) (This)->lpVtbl->GetAuthority(This, pbstrAuthority)
	#define IUri_GetDisplayUri(This, pbstrDisplayString) (This)->lpVtbl->GetDisplayUri(This, pbstrDisplayString)
	#define IUri_GetDomain(This, pbstrDomain) (This)->lpVtbl->GetDomain(This, pbstrDomain)
	#define IUri_GetExtension(This, pbstrExtension) (This)->lpVtbl->GetExtension(This, pbstrExtension)
	#define IUri_GetFragment(This, pbstrFragment) (This)->lpVtbl->GetFragment(This, pbstrFragment)
	#define IUri_GetHost(This, pbstrHost) (This)->lpVtbl->GetHost(This, pbstrHost)
	#define IUri_GetPassword(This, pbstrPassword) (This)->lpVtbl->GetPassword(This, pbstrPassword)
	#define IUri_GetPath(This, pbstrPath) (This)->lpVtbl->GetPath(This, pbstrPath)
	#define IUri_GetPathAndQuery(This, pbstrPathAndQuery) (This)->lpVtbl->GetPathAndQuery(This, pbstrPathAndQuery)
	#define IUri_GetQuery(This, pbstrQuery) (This)->lpVtbl->GetQuery(This, pbstrQuery)
	#define IUri_GetRawUri(This, pbstrRawUri) (This)->lpVtbl->GetRawUri(This, pbstrRawUri)
	#define IUri_GetSchemeName(This, pbstrSchemeName) (This)->lpVtbl->GetSchemeName(This, pbstrSchemeName)
	#define IUri_GetUserInfo(This, pbstrUserInfo) (This)->lpVtbl->GetUserInfo(This, pbstrUserInfo)
	#define IUri_GetUserName(This, pbstrUserName) (This)->lpVtbl->GetUserName(This, pbstrUserName)
	#define IUri_GetHostType(This, pdwHostType) (This)->lpVtbl->GetHostType(This, pdwHostType)
	#define IUri_GetPort(This, pdwPort) (This)->lpVtbl->GetPort(This, pdwPort)
	#define IUri_GetScheme(This, pdwScheme) (This)->lpVtbl->GetScheme(This, pdwScheme)
	#define IUri_GetZone(This, pdwZone) (This)->lpVtbl->GetZone(This, pdwZone)
	#define IUri_GetProperties(This, pdwFlags) (This)->lpVtbl->GetProperties(This, pdwFlags)
	#define IUri_IsEqual(This, pUri, pfEqual) (This)->lpVtbl->IsEqual(This, pUri, pfEqual)

	declare function IUri_GetPropertyBSTR_Proxy(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pbstrProperty as BSTR ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IUri_GetPropertyBSTR_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPropertyLength_Proxy(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pcchProperty as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IUri_GetPropertyLength_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPropertyDWORD_Proxy(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pdwProperty as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IUri_GetPropertyDWORD_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_HasProperty_Proxy(byval This as IUri ptr, byval uriProp as Uri_PROPERTY, byval pfHasProperty as WINBOOL ptr) as HRESULT
	declare sub IUri_HasProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetAbsoluteUri_Proxy(byval This as IUri ptr, byval pbstrAbsoluteUri as BSTR ptr) as HRESULT
	declare sub IUri_GetAbsoluteUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetAuthority_Proxy(byval This as IUri ptr, byval pbstrAuthority as BSTR ptr) as HRESULT
	declare sub IUri_GetAuthority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetDisplayUri_Proxy(byval This as IUri ptr, byval pbstrDisplayString as BSTR ptr) as HRESULT
	declare sub IUri_GetDisplayUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetDomain_Proxy(byval This as IUri ptr, byval pbstrDomain as BSTR ptr) as HRESULT
	declare sub IUri_GetDomain_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetExtension_Proxy(byval This as IUri ptr, byval pbstrExtension as BSTR ptr) as HRESULT
	declare sub IUri_GetExtension_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetFragment_Proxy(byval This as IUri ptr, byval pbstrFragment as BSTR ptr) as HRESULT
	declare sub IUri_GetFragment_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetHost_Proxy(byval This as IUri ptr, byval pbstrHost as BSTR ptr) as HRESULT
	declare sub IUri_GetHost_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPassword_Proxy(byval This as IUri ptr, byval pbstrPassword as BSTR ptr) as HRESULT
	declare sub IUri_GetPassword_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPath_Proxy(byval This as IUri ptr, byval pbstrPath as BSTR ptr) as HRESULT
	declare sub IUri_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPathAndQuery_Proxy(byval This as IUri ptr, byval pbstrPathAndQuery as BSTR ptr) as HRESULT
	declare sub IUri_GetPathAndQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetQuery_Proxy(byval This as IUri ptr, byval pbstrQuery as BSTR ptr) as HRESULT
	declare sub IUri_GetQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetRawUri_Proxy(byval This as IUri ptr, byval pbstrRawUri as BSTR ptr) as HRESULT
	declare sub IUri_GetRawUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetSchemeName_Proxy(byval This as IUri ptr, byval pbstrSchemeName as BSTR ptr) as HRESULT
	declare sub IUri_GetSchemeName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetUserInfo_Proxy(byval This as IUri ptr, byval pbstrUserInfo as BSTR ptr) as HRESULT
	declare sub IUri_GetUserInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetUserName_Proxy(byval This as IUri ptr, byval pbstrUserName as BSTR ptr) as HRESULT
	declare sub IUri_GetUserName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetHostType_Proxy(byval This as IUri ptr, byval pdwHostType as DWORD ptr) as HRESULT
	declare sub IUri_GetHostType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetPort_Proxy(byval This as IUri ptr, byval pdwPort as DWORD ptr) as HRESULT
	declare sub IUri_GetPort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetScheme_Proxy(byval This as IUri ptr, byval pdwScheme as DWORD ptr) as HRESULT
	declare sub IUri_GetScheme_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetZone_Proxy(byval This as IUri ptr, byval pdwZone as DWORD ptr) as HRESULT
	declare sub IUri_GetZone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_GetProperties_Proxy(byval This as IUri ptr, byval pdwFlags as LPDWORD) as HRESULT
	declare sub IUri_GetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUri_IsEqual_Proxy(byval This as IUri ptr, byval pUri as IUri ptr, byval pfEqual as WINBOOL ptr) as HRESULT
	declare sub IUri_IsEqual_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function CreateUri(byval pwzURI as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppURI as IUri ptr ptr) as HRESULT
	declare function CreateUriWithFragment(byval pwzURI as LPCWSTR, byval pwzFragment as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppURI as IUri ptr ptr) as HRESULT
	declare function CreateUriFromMultiByteString(byval pszANSIInputUri as LPCSTR, byval dwEncodingFlags as DWORD, byval dwCodePage as DWORD, byval dwCreateFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppUri as IUri ptr ptr) as HRESULT

	const Uri_HAS_ABSOLUTE_URI = 1 shl Uri_PROPERTY_ABSOLUTE_URI
	const Uri_HAS_AUTHORITY = 1 shl Uri_PROPERTY_AUTHORITY
	const Uri_HAS_DISPLAY_URI = 1 shl Uri_PROPERTY_DISPLAY_URI
	const Uri_HAS_DOMAIN = 1 shl Uri_PROPERTY_DOMAIN
	const Uri_HAS_EXTENSION = 1 shl Uri_PROPERTY_EXTENSION
	const Uri_HAS_FRAGMENT = 1 shl Uri_PROPERTY_FRAGMENT
	const Uri_HAS_HOST = 1 shl Uri_PROPERTY_HOST
	const Uri_HAS_PASSWORD = 1 shl Uri_PROPERTY_PASSWORD
	const Uri_HAS_PATH = 1 shl Uri_PROPERTY_PATH
	const Uri_HAS_QUERY = 1 shl Uri_PROPERTY_QUERY
	const Uri_HAS_RAW_URI = 1 shl Uri_PROPERTY_RAW_URI
	const Uri_HAS_SCHEME_NAME = 1 shl Uri_PROPERTY_SCHEME_NAME
	const Uri_HAS_USER_NAME = 1 shl Uri_PROPERTY_USER_NAME
	const Uri_HAS_PATH_AND_QUERY = 1 shl Uri_PROPERTY_PATH_AND_QUERY
	const Uri_HAS_USER_INFO = 1 shl Uri_PROPERTY_USER_INFO
	const Uri_HAS_HOST_TYPE = 1 shl Uri_PROPERTY_HOST_TYPE
	const Uri_HAS_PORT = 1 shl Uri_PROPERTY_PORT
	const Uri_HAS_SCHEME = 1 shl Uri_PROPERTY_SCHEME
	const Uri_HAS_ZONE = 1 shl Uri_PROPERTY_ZONE
	const Uri_CREATE_ALLOW_RELATIVE = &h1
	const Uri_CREATE_ALLOW_IMPLICIT_WILDCARD_SCHEME = &h2
	const Uri_CREATE_ALLOW_IMPLICIT_FILE_SCHEME = &h4
	const Uri_CREATE_NOFRAG = &h8
	const Uri_CREATE_NO_CANONICALIZE = &h10
	const Uri_CREATE_CANONICALIZE = &h100
	const Uri_CREATE_FILE_USE_DOS_PATH = &h20
	const Uri_CREATE_DECODE_EXTRA_INFO = &h40
	const Uri_CREATE_NO_DECODE_EXTRA_INFO = &h80
	const Uri_CREATE_CRACK_UNKNOWN_SCHEMES = &h200
	const Uri_CREATE_NO_CRACK_UNKNOWN_SCHEMES = &h400
	const Uri_CREATE_PRE_PROCESS_HTML_URI = &h800
	const Uri_CREATE_NO_PRE_PROCESS_HTML_URI = &h1000
	const Uri_CREATE_IE_SETTINGS = &h2000
	const Uri_CREATE_NO_IE_SETTINGS = &h4000
	const Uri_CREATE_NO_ENCODE_FORBIDDEN_CHARACTERS = &h8000
	const Uri_CREATE_NORMALIZE_INTL_CHARACTERS = &h10000
	const Uri_CREATE_CANONICALIZE_ABSOLUTE = &h20000
	const Uri_DISPLAY_NO_FRAGMENT = &h1
	const Uri_PUNYCODE_IDN_HOST = &h2
	const Uri_DISPLAY_IDN_HOST = &h4
	const Uri_DISPLAY_NO_PUNYCODE = &h8
	const Uri_ENCODING_USER_INFO_AND_PATH_IS_PERCENT_ENCODED_UTF8 = &h1
	const Uri_ENCODING_USER_INFO_AND_PATH_IS_CP = &h2
	const Uri_ENCODING_HOST_IS_IDN = &h4
	const Uri_ENCODING_HOST_IS_PERCENT_ENCODED_UTF8 = &h8
	const Uri_ENCODING_HOST_IS_PERCENT_ENCODED_CP = &h10
	const Uri_ENCODING_QUERY_AND_FRAGMENT_IS_PERCENT_ENCODED_UTF8 = &h20
	const Uri_ENCODING_QUERY_AND_FRAGMENT_IS_CP = &h40
	const Uri_ENCODING_RFC = (Uri_ENCODING_USER_INFO_AND_PATH_IS_PERCENT_ENCODED_UTF8 or Uri_ENCODING_HOST_IS_PERCENT_ENCODED_UTF8) or Uri_ENCODING_QUERY_AND_FRAGMENT_IS_PERCENT_ENCODED_UTF8
	const UriBuilder_USE_ORIGINAL_FLAGS = &h1
	#define __IUriContainer_INTERFACE_DEFINED__
	extern IID_IUriContainer as const GUID
	type IUriContainer as IUriContainer_

	type IUriContainerVtbl
		QueryInterface as function(byval This as IUriContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUriContainer ptr) as ULONG
		Release as function(byval This as IUriContainer ptr) as ULONG
		GetIUri as function(byval This as IUriContainer ptr, byval ppIUri as IUri ptr ptr) as HRESULT
	end type

	type IUriContainer_
		lpVtbl as IUriContainerVtbl ptr
	end type

	#define IUriContainer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUriContainer_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUriContainer_Release(This) (This)->lpVtbl->Release(This)
	#define IUriContainer_GetIUri(This, ppIUri) (This)->lpVtbl->GetIUri(This, ppIUri)
	declare function IUriContainer_GetIUri_Proxy(byval This as IUriContainer ptr, byval ppIUri as IUri ptr ptr) as HRESULT
	declare sub IUriContainer_GetIUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IUriBuilder_INTERFACE_DEFINED__
	extern IID_IUriBuilder as const GUID
	type IUriBuilder as IUriBuilder_

	type IUriBuilderVtbl
		QueryInterface as function(byval This as IUriBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUriBuilder ptr) as ULONG
		Release as function(byval This as IUriBuilder ptr) as ULONG
		CreateUriSimple as function(byval This as IUriBuilder ptr, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
		CreateUri as function(byval This as IUriBuilder ptr, byval dwCreateFlags as DWORD, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
		CreateUriWithFlags as function(byval This as IUriBuilder ptr, byval dwCreateFlags as DWORD, byval dwUriBuilderFlags as DWORD, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
		GetIUri as function(byval This as IUriBuilder ptr, byval ppIUri as IUri ptr ptr) as HRESULT
		SetIUri as function(byval This as IUriBuilder ptr, byval pIUri as IUri ptr) as HRESULT
		GetFragment as function(byval This as IUriBuilder ptr, byval pcchFragment as DWORD ptr, byval ppwzFragment as LPCWSTR ptr) as HRESULT
		GetHost as function(byval This as IUriBuilder ptr, byval pcchHost as DWORD ptr, byval ppwzHost as LPCWSTR ptr) as HRESULT
		GetPassword as function(byval This as IUriBuilder ptr, byval pcchPassword as DWORD ptr, byval ppwzPassword as LPCWSTR ptr) as HRESULT
		GetPath as function(byval This as IUriBuilder ptr, byval pcchPath as DWORD ptr, byval ppwzPath as LPCWSTR ptr) as HRESULT
		GetPort as function(byval This as IUriBuilder ptr, byval pfHasPort as WINBOOL ptr, byval pdwPort as DWORD ptr) as HRESULT
		GetQuery as function(byval This as IUriBuilder ptr, byval pcchQuery as DWORD ptr, byval ppwzQuery as LPCWSTR ptr) as HRESULT
		GetSchemeName as function(byval This as IUriBuilder ptr, byval pcchSchemeName as DWORD ptr, byval ppwzSchemeName as LPCWSTR ptr) as HRESULT

		#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
			GetUserNameW as function(byval This as IUriBuilder ptr, byval pcchUserName as DWORD ptr, byval ppwzUserName as LPCWSTR ptr) as HRESULT
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
			GetUserNameA as function(byval This as IUriBuilder ptr, byval pcchUserName as DWORD ptr, byval ppwzUserName as LPCWSTR ptr) as HRESULT
		#endif

		SetFragment as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetHost as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetPassword as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetPath as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetPort as function(byval This as IUriBuilder ptr, byval fHasPort as WINBOOL, byval dwNewValue as DWORD) as HRESULT
		SetQuery as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetSchemeName as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		SetUserName as function(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
		RemoveProperties as function(byval This as IUriBuilder ptr, byval dwPropertyMask as DWORD) as HRESULT
		HasBeenModified as function(byval This as IUriBuilder ptr, byval pfModified as WINBOOL ptr) as HRESULT
	end type

	type IUriBuilder_
		lpVtbl as IUriBuilderVtbl ptr
	end type

	#define IUriBuilder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUriBuilder_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUriBuilder_Release(This) (This)->lpVtbl->Release(This)
	#define IUriBuilder_CreateUriSimple(This, dwAllowEncodingPropertyMask, dwReserved, ppIUri) (This)->lpVtbl->CreateUriSimple(This, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
	#define IUriBuilder_CreateUri(This, dwCreateFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri) (This)->lpVtbl->CreateUri(This, dwCreateFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
	#define IUriBuilder_CreateUriWithFlags(This, dwCreateFlags, dwUriBuilderFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri) (This)->lpVtbl->CreateUriWithFlags(This, dwCreateFlags, dwUriBuilderFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
	#define IUriBuilder_GetIUri(This, ppIUri) (This)->lpVtbl->GetIUri(This, ppIUri)
	#define IUriBuilder_SetIUri(This, pIUri) (This)->lpVtbl->SetIUri(This, pIUri)
	#define IUriBuilder_GetFragment(This, pcchFragment, ppwzFragment) (This)->lpVtbl->GetFragment(This, pcchFragment, ppwzFragment)
	#define IUriBuilder_GetHost(This, pcchHost, ppwzHost) (This)->lpVtbl->GetHost(This, pcchHost, ppwzHost)
	#define IUriBuilder_GetPassword(This, pcchPassword, ppwzPassword) (This)->lpVtbl->GetPassword(This, pcchPassword, ppwzPassword)
	#define IUriBuilder_GetPath(This, pcchPath, ppwzPath) (This)->lpVtbl->GetPath(This, pcchPath, ppwzPath)
	#define IUriBuilder_GetPort(This, pfHasPort, pdwPort) (This)->lpVtbl->GetPort(This, pfHasPort, pdwPort)
	#define IUriBuilder_GetQuery(This, pcchQuery, ppwzQuery) (This)->lpVtbl->GetQuery(This, pcchQuery, ppwzQuery)
	#define IUriBuilder_GetSchemeName(This, pcchSchemeName, ppwzSchemeName) (This)->lpVtbl->GetSchemeName(This, pcchSchemeName, ppwzSchemeName)
	#define IUriBuilder_GetUserName(This, pcchUserName, ppwzUserName) (This)->lpVtbl->GetUserName(This, pcchUserName, ppwzUserName)
	#define IUriBuilder_SetFragment(This, pwzNewValue) (This)->lpVtbl->SetFragment(This, pwzNewValue)
	#define IUriBuilder_SetHost(This, pwzNewValue) (This)->lpVtbl->SetHost(This, pwzNewValue)
	#define IUriBuilder_SetPassword(This, pwzNewValue) (This)->lpVtbl->SetPassword(This, pwzNewValue)
	#define IUriBuilder_SetPath(This, pwzNewValue) (This)->lpVtbl->SetPath(This, pwzNewValue)
	#define IUriBuilder_SetPort(This, fHasPort, dwNewValue) (This)->lpVtbl->SetPort(This, fHasPort, dwNewValue)
	#define IUriBuilder_SetQuery(This, pwzNewValue) (This)->lpVtbl->SetQuery(This, pwzNewValue)
	#define IUriBuilder_SetSchemeName(This, pwzNewValue) (This)->lpVtbl->SetSchemeName(This, pwzNewValue)
	#define IUriBuilder_SetUserName(This, pwzNewValue) (This)->lpVtbl->SetUserName(This, pwzNewValue)
	#define IUriBuilder_RemoveProperties(This, dwPropertyMask) (This)->lpVtbl->RemoveProperties(This, dwPropertyMask)
	#define IUriBuilder_HasBeenModified(This, pfModified) (This)->lpVtbl->HasBeenModified(This, pfModified)

	declare function IUriBuilder_CreateUriSimple_Proxy(byval This as IUriBuilder ptr, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
	declare sub IUriBuilder_CreateUriSimple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_CreateUri_Proxy(byval This as IUriBuilder ptr, byval dwCreateFlags as DWORD, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
	declare sub IUriBuilder_CreateUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_CreateUriWithFlags_Proxy(byval This as IUriBuilder ptr, byval dwCreateFlags as DWORD, byval dwUriBuilderFlags as DWORD, byval dwAllowEncodingPropertyMask as DWORD, byval dwReserved as DWORD_PTR, byval ppIUri as IUri ptr ptr) as HRESULT
	declare sub IUriBuilder_CreateUriWithFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetIUri_Proxy(byval This as IUriBuilder ptr, byval ppIUri as IUri ptr ptr) as HRESULT
	declare sub IUriBuilder_GetIUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetIUri_Proxy(byval This as IUriBuilder ptr, byval pIUri as IUri ptr) as HRESULT
	declare sub IUriBuilder_SetIUri_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetFragment_Proxy(byval This as IUriBuilder ptr, byval pcchFragment as DWORD ptr, byval ppwzFragment as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetFragment_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetHost_Proxy(byval This as IUriBuilder ptr, byval pcchHost as DWORD ptr, byval ppwzHost as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetHost_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetPassword_Proxy(byval This as IUriBuilder ptr, byval pcchPassword as DWORD ptr, byval ppwzPassword as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetPassword_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetPath_Proxy(byval This as IUriBuilder ptr, byval pcchPath as DWORD ptr, byval ppwzPath as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetPort_Proxy(byval This as IUriBuilder ptr, byval pfHasPort as WINBOOL ptr, byval pdwPort as DWORD ptr) as HRESULT
	declare sub IUriBuilder_GetPort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetQuery_Proxy(byval This as IUriBuilder ptr, byval pcchQuery as DWORD ptr, byval ppwzQuery as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetSchemeName_Proxy(byval This as IUriBuilder ptr, byval pcchSchemeName as DWORD ptr, byval ppwzSchemeName as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetSchemeName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_GetUserName_Proxy(byval This as IUriBuilder ptr, byval pcchUserName as DWORD ptr, byval ppwzUserName as LPCWSTR ptr) as HRESULT
	declare sub IUriBuilder_GetUserName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetFragment_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetFragment_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetHost_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetHost_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetPassword_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetPassword_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetPath_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetPort_Proxy(byval This as IUriBuilder ptr, byval fHasPort as WINBOOL, byval dwNewValue as DWORD) as HRESULT
	declare sub IUriBuilder_SetPort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetQuery_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetSchemeName_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetSchemeName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_SetUserName_Proxy(byval This as IUriBuilder ptr, byval pwzNewValue as LPCWSTR) as HRESULT
	declare sub IUriBuilder_SetUserName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_RemoveProperties_Proxy(byval This as IUriBuilder ptr, byval dwPropertyMask as DWORD) as HRESULT
	declare sub IUriBuilder_RemoveProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilder_HasBeenModified_Proxy(byval This as IUriBuilder ptr, byval pfModified as WINBOOL ptr) as HRESULT
	declare sub IUriBuilder_HasBeenModified_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IUriBuilderFactory_INTERFACE_DEFINED__
	extern IID_IUriBuilderFactory as const GUID
	type IUriBuilderFactory as IUriBuilderFactory_

	type IUriBuilderFactoryVtbl
		QueryInterface as function(byval This as IUriBuilderFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUriBuilderFactory ptr) as ULONG
		Release as function(byval This as IUriBuilderFactory ptr) as ULONG
		CreateIUriBuilder as function(byval This as IUriBuilderFactory ptr, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppIUriBuilder as IUriBuilder ptr ptr) as HRESULT
		CreateInitializedIUriBuilder as function(byval This as IUriBuilderFactory ptr, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppIUriBuilder as IUriBuilder ptr ptr) as HRESULT
	end type

	type IUriBuilderFactory_
		lpVtbl as IUriBuilderFactoryVtbl ptr
	end type

	#define IUriBuilderFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUriBuilderFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUriBuilderFactory_Release(This) (This)->lpVtbl->Release(This)
	#define IUriBuilderFactory_CreateIUriBuilder(This, dwFlags, dwReserved, ppIUriBuilder) (This)->lpVtbl->CreateIUriBuilder(This, dwFlags, dwReserved, ppIUriBuilder)
	#define IUriBuilderFactory_CreateInitializedIUriBuilder(This, dwFlags, dwReserved, ppIUriBuilder) (This)->lpVtbl->CreateInitializedIUriBuilder(This, dwFlags, dwReserved, ppIUriBuilder)

	declare function IUriBuilderFactory_CreateIUriBuilder_Proxy(byval This as IUriBuilderFactory ptr, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppIUriBuilder as IUriBuilder ptr ptr) as HRESULT
	declare sub IUriBuilderFactory_CreateIUriBuilder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IUriBuilderFactory_CreateInitializedIUriBuilder_Proxy(byval This as IUriBuilderFactory ptr, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppIUriBuilder as IUriBuilder ptr ptr) as HRESULT
	declare sub IUriBuilderFactory_CreateInitializedIUriBuilder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function CreateIUriBuilder(byval pIUri as IUri ptr, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval ppIUriBuilder as IUriBuilder ptr ptr) as HRESULT
#endif

#define _LPWININETINFO_DEFINED
#define __IWinInetInfo_INTERFACE_DEFINED__
type IWinInetInfo as IWinInetInfo_
type LPWININETINFO as IWinInetInfo ptr
extern IID_IWinInetInfo as const GUID

type IWinInetInfoVtbl
	QueryInterface as function(byval This as IWinInetInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWinInetInfo ptr) as ULONG
	Release as function(byval This as IWinInetInfo ptr) as ULONG
	QueryOption as function(byval This as IWinInetInfo ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pcbBuf as DWORD ptr) as HRESULT
end type

type IWinInetInfo_
	lpVtbl as IWinInetInfoVtbl ptr
end type

#define IWinInetInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWinInetInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWinInetInfo_Release(This) (This)->lpVtbl->Release(This)
#define IWinInetInfo_QueryOption(This, dwOption, pBuffer, pcbBuf) (This)->lpVtbl->QueryOption(This, dwOption, pBuffer, pcbBuf)

declare function IWinInetInfo_RemoteQueryOption_Proxy(byval This as IWinInetInfo ptr, byval dwOption as DWORD, byval pBuffer as UBYTE ptr, byval pcbBuf as DWORD ptr) as HRESULT
declare sub IWinInetInfo_RemoteQueryOption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWinInetInfo_QueryOption_Proxy(byval This as IWinInetInfo ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pcbBuf as DWORD ptr) as HRESULT
declare function IWinInetInfo_QueryOption_Stub(byval This as IWinInetInfo ptr, byval dwOption as DWORD, byval pBuffer as UBYTE ptr, byval pcbBuf as DWORD ptr) as HRESULT

const WININETINFO_OPTION_LOCK_HANDLE = 65534
#define _LPHTTPSECURITY_DEFINED
#define __IHttpSecurity_INTERFACE_DEFINED__
type IHttpSecurity as IHttpSecurity_
type LPHTTPSECURITY as IHttpSecurity ptr
extern IID_IHttpSecurity as const GUID

type IHttpSecurityVtbl
	QueryInterface as function(byval This as IHttpSecurity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHttpSecurity ptr) as ULONG
	Release as function(byval This as IHttpSecurity ptr) as ULONG
	GetWindow as function(byval This as IHttpSecurity ptr, byval rguidReason as const GUID const ptr, byval phwnd as HWND ptr) as HRESULT
	OnSecurityProblem as function(byval This as IHttpSecurity ptr, byval dwProblem as DWORD) as HRESULT
end type

type IHttpSecurity_
	lpVtbl as IHttpSecurityVtbl ptr
end type

#define IHttpSecurity_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHttpSecurity_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHttpSecurity_Release(This) (This)->lpVtbl->Release(This)
#define IHttpSecurity_GetWindow(This, rguidReason, phwnd) (This)->lpVtbl->GetWindow(This, rguidReason, phwnd)
#define IHttpSecurity_OnSecurityProblem(This, dwProblem) (This)->lpVtbl->OnSecurityProblem(This, dwProblem)
declare function IHttpSecurity_OnSecurityProblem_Proxy(byval This as IHttpSecurity ptr, byval dwProblem as DWORD) as HRESULT
declare sub IHttpSecurity_OnSecurityProblem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPWININETHTTPINFO_DEFINED
#define __IWinInetHttpInfo_INTERFACE_DEFINED__
type IWinInetHttpInfo as IWinInetHttpInfo_
type LPWININETHTTPINFO as IWinInetHttpInfo ptr
extern IID_IWinInetHttpInfo as const GUID

type IWinInetHttpInfoVtbl
	QueryInterface as function(byval This as IWinInetHttpInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWinInetHttpInfo ptr) as ULONG
	Release as function(byval This as IWinInetHttpInfo ptr) as ULONG
	QueryOption as function(byval This as IWinInetHttpInfo ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pcbBuf as DWORD ptr) as HRESULT
	QueryInfo as function(byval This as IWinInetHttpInfo ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pcbBuf as DWORD ptr, byval pdwFlags as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
end type

type IWinInetHttpInfo_
	lpVtbl as IWinInetHttpInfoVtbl ptr
end type

#define IWinInetHttpInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWinInetHttpInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWinInetHttpInfo_Release(This) (This)->lpVtbl->Release(This)
#define IWinInetHttpInfo_QueryOption(This, dwOption, pBuffer, pcbBuf) (This)->lpVtbl->QueryOption(This, dwOption, pBuffer, pcbBuf)
#define IWinInetHttpInfo_QueryInfo(This, dwOption, pBuffer, pcbBuf, pdwFlags, pdwReserved) (This)->lpVtbl->QueryInfo(This, dwOption, pBuffer, pcbBuf, pdwFlags, pdwReserved)

declare function IWinInetHttpInfo_RemoteQueryInfo_Proxy(byval This as IWinInetHttpInfo ptr, byval dwOption as DWORD, byval pBuffer as UBYTE ptr, byval pcbBuf as DWORD ptr, byval pdwFlags as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare sub IWinInetHttpInfo_RemoteQueryInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWinInetHttpInfo_QueryInfo_Proxy(byval This as IWinInetHttpInfo ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pcbBuf as DWORD ptr, byval pdwFlags as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare function IWinInetHttpInfo_QueryInfo_Stub(byval This as IWinInetHttpInfo ptr, byval dwOption as DWORD, byval pBuffer as UBYTE ptr, byval pcbBuf as DWORD ptr, byval pdwFlags as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
#define _LPWININETHTTPTIMEOUTS_DEFINED
#define __IWinInetHttpTimeouts_INTERFACE_DEFINED__
extern IID_IWinInetHttpTimeouts as const GUID
type IWinInetHttpTimeouts as IWinInetHttpTimeouts_

type IWinInetHttpTimeoutsVtbl
	QueryInterface as function(byval This as IWinInetHttpTimeouts ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWinInetHttpTimeouts ptr) as ULONG
	Release as function(byval This as IWinInetHttpTimeouts ptr) as ULONG
	GetRequestTimeouts as function(byval This as IWinInetHttpTimeouts ptr, byval pdwConnectTimeout as DWORD ptr, byval pdwSendTimeout as DWORD ptr, byval pdwReceiveTimeout as DWORD ptr) as HRESULT
end type

type IWinInetHttpTimeouts_
	lpVtbl as IWinInetHttpTimeoutsVtbl ptr
end type

#define IWinInetHttpTimeouts_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWinInetHttpTimeouts_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWinInetHttpTimeouts_Release(This) (This)->lpVtbl->Release(This)
#define IWinInetHttpTimeouts_GetRequestTimeouts(This, pdwConnectTimeout, pdwSendTimeout, pdwReceiveTimeout) (This)->lpVtbl->GetRequestTimeouts(This, pdwConnectTimeout, pdwSendTimeout, pdwReceiveTimeout)
declare function IWinInetHttpTimeouts_GetRequestTimeouts_Proxy(byval This as IWinInetHttpTimeouts ptr, byval pdwConnectTimeout as DWORD ptr, byval pdwSendTimeout as DWORD ptr, byval pdwReceiveTimeout as DWORD ptr) as HRESULT
declare sub IWinInetHttpTimeouts_GetRequestTimeouts_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define _LPWININETCACHEHINTS_DEFINED
	#define __IWinInetCacheHints_INTERFACE_DEFINED__
	type IWinInetCacheHints as IWinInetCacheHints_
	type LPWININETCACHEHINTS as IWinInetCacheHints ptr
	extern IID_IWinInetCacheHints as const GUID

	type IWinInetCacheHintsVtbl
		QueryInterface as function(byval This as IWinInetCacheHints ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IWinInetCacheHints ptr) as ULONG
		Release as function(byval This as IWinInetCacheHints ptr) as ULONG
		SetCacheExtension as function(byval This as IWinInetCacheHints ptr, byval pwzExt as LPCWSTR, byval pszCacheFile as LPVOID, byval pcbCacheFile as DWORD ptr, byval pdwWinInetError as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
	end type

	type IWinInetCacheHints_
		lpVtbl as IWinInetCacheHintsVtbl ptr
	end type

	#define IWinInetCacheHints_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IWinInetCacheHints_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IWinInetCacheHints_Release(This) (This)->lpVtbl->Release(This)
	#define IWinInetCacheHints_SetCacheExtension(This, pwzExt, pszCacheFile, pcbCacheFile, pdwWinInetError, pdwReserved) (This)->lpVtbl->SetCacheExtension(This, pwzExt, pszCacheFile, pcbCacheFile, pdwWinInetError, pdwReserved)
	declare function IWinInetCacheHints_SetCacheExtension_Proxy(byval This as IWinInetCacheHints ptr, byval pwzExt as LPCWSTR, byval pszCacheFile as LPVOID, byval pcbCacheFile as DWORD ptr, byval pdwWinInetError as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
	declare sub IWinInetCacheHints_SetCacheExtension_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define _LPWININETCACHEHINTS2_DEFINED
	#define __IWinInetCacheHints2_INTERFACE_DEFINED__
	type IWinInetCacheHints2 as IWinInetCacheHints2_
	type LPWININETCACHEHINTS2 as IWinInetCacheHints2 ptr
	extern IID_IWinInetCacheHints2 as const GUID

	type IWinInetCacheHints2Vtbl
		QueryInterface as function(byval This as IWinInetCacheHints2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IWinInetCacheHints2 ptr) as ULONG
		Release as function(byval This as IWinInetCacheHints2 ptr) as ULONG
		SetCacheExtension as function(byval This as IWinInetCacheHints2 ptr, byval pwzExt as LPCWSTR, byval pszCacheFile as LPVOID, byval pcbCacheFile as DWORD ptr, byval pdwWinInetError as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
		SetCacheExtension2 as function(byval This as IWinInetCacheHints2 ptr, byval pwzExt as LPCWSTR, byval pwzCacheFile as wstring ptr, byval pcchCacheFile as DWORD ptr, byval pdwWinInetError as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
	end type

	type IWinInetCacheHints2_
		lpVtbl as IWinInetCacheHints2Vtbl ptr
	end type

	#define IWinInetCacheHints2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IWinInetCacheHints2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IWinInetCacheHints2_Release(This) (This)->lpVtbl->Release(This)
	#define IWinInetCacheHints2_SetCacheExtension(This, pwzExt, pszCacheFile, pcbCacheFile, pdwWinInetError, pdwReserved) (This)->lpVtbl->SetCacheExtension(This, pwzExt, pszCacheFile, pcbCacheFile, pdwWinInetError, pdwReserved)
	#define IWinInetCacheHints2_SetCacheExtension2(This, pwzExt, pwzCacheFile, pcchCacheFile, pdwWinInetError, pdwReserved) (This)->lpVtbl->SetCacheExtension2(This, pwzExt, pwzCacheFile, pcchCacheFile, pdwWinInetError, pdwReserved)
	declare function IWinInetCacheHints2_SetCacheExtension2_Proxy(byval This as IWinInetCacheHints2 ptr, byval pwzExt as LPCWSTR, byval pwzCacheFile as wstring ptr, byval pcchCacheFile as DWORD ptr, byval pdwWinInetError as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
	declare sub IWinInetCacheHints2_SetCacheExtension2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define _LPBINDHOST_DEFINED
extern SID_BindHost as const GUID
#define __IBindHost_INTERFACE_DEFINED__
type IBindHost as IBindHost_
type LPBINDHOST as IBindHost ptr
extern IID_IBindHost as const GUID
extern SID_IBindHost alias "IID_IBindHost" as const GUID
extern SID_SBindHost alias "IID_IBindHost" as const GUID

type IBindHostVtbl
	QueryInterface as function(byval This as IBindHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBindHost ptr) as ULONG
	Release as function(byval This as IBindHost ptr) as ULONG
	CreateMoniker as function(byval This as IBindHost ptr, byval szName as LPOLESTR, byval pBC as IBindCtx ptr, byval ppmk as IMoniker ptr ptr, byval dwReserved as DWORD) as HRESULT
	MonikerBindToStorage as function(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
	MonikerBindToObject as function(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
end type

type IBindHost_
	lpVtbl as IBindHostVtbl ptr
end type

#define IBindHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBindHost_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindHost_Release(This) (This)->lpVtbl->Release(This)
#define IBindHost_CreateMoniker(This, szName, pBC, ppmk, dwReserved) (This)->lpVtbl->CreateMoniker(This, szName, pBC, ppmk, dwReserved)
#define IBindHost_MonikerBindToStorage(This, pMk, pBC, pBSC, riid, ppvObj) (This)->lpVtbl->MonikerBindToStorage(This, pMk, pBC, pBSC, riid, ppvObj)
#define IBindHost_MonikerBindToObject(This, pMk, pBC, pBSC, riid, ppvObj) (This)->lpVtbl->MonikerBindToObject(This, pMk, pBC, pBSC, riid, ppvObj)

declare function IBindHost_CreateMoniker_Proxy(byval This as IBindHost ptr, byval szName as LPOLESTR, byval pBC as IBindCtx ptr, byval ppmk as IMoniker ptr ptr, byval dwReserved as DWORD) as HRESULT
declare sub IBindHost_CreateMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindHost_RemoteMonikerBindToStorage_Proxy(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare sub IBindHost_RemoteMonikerBindToStorage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindHost_RemoteMonikerBindToObject_Proxy(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare sub IBindHost_RemoteMonikerBindToObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBindHost_MonikerBindToStorage_Proxy(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
declare function IBindHost_MonikerBindToStorage_Stub(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare function IBindHost_MonikerBindToObject_Proxy(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
declare function IBindHost_MonikerBindToObject_Stub(byval This as IBindHost ptr, byval pMk as IMoniker ptr, byval pBC as IBindCtx ptr, byval pBSC as IBindStatusCallback ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT

const URLOSTRM_USECACHEDCOPY_ONLY = &h1
const URLOSTRM_USECACHEDCOPY = &h2
const URLOSTRM_GETNEWESTVERSION = &h3

declare function HlinkSimpleNavigateToString(byval szTarget as LPCWSTR, byval szLocation as LPCWSTR, byval szTargetFrameName as LPCWSTR, byval pUnk as IUnknown ptr, byval pbc as IBindCtx ptr, byval as IBindStatusCallback ptr, byval grfHLNF as DWORD, byval dwReserved as DWORD) as HRESULT
declare function HlinkSimpleNavigateToMoniker(byval pmkTarget as IMoniker ptr, byval szLocation as LPCWSTR, byval szTargetFrameName as LPCWSTR, byval pUnk as IUnknown ptr, byval pbc as IBindCtx ptr, byval as IBindStatusCallback ptr, byval grfHLNF as DWORD, byval dwReserved as DWORD) as HRESULT
declare function URLOpenStreamA(byval as LPUNKNOWN, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLOpenStreamW(byval as LPUNKNOWN, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLOpenPullStreamA(byval as LPUNKNOWN, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLOpenPullStreamW(byval as LPUNKNOWN, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLDownloadToFileA(byval as LPUNKNOWN, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLDownloadToFileW(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLDownloadToCacheFileA(byval as LPUNKNOWN, byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLDownloadToCacheFileW(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLOpenBlockingStreamA(byval as LPUNKNOWN, byval as LPCSTR, byval as LPSTREAM ptr, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
declare function URLOpenBlockingStreamW(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPSTREAM ptr, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT

#ifdef UNICODE
	declare function URLOpenStream alias "URLOpenStreamW"(byval as LPUNKNOWN, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLOpenPullStream alias "URLOpenPullStreamW"(byval as LPUNKNOWN, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLDownloadToFile alias "URLDownloadToFileW"(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLDownloadToCacheFile alias "URLDownloadToCacheFileW"(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLOpenBlockingStream alias "URLOpenBlockingStreamW"(byval as LPUNKNOWN, byval as LPCWSTR, byval as LPSTREAM ptr, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
#else
	declare function URLOpenStream alias "URLOpenStreamA"(byval as LPUNKNOWN, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLOpenPullStream alias "URLOpenPullStreamA"(byval as LPUNKNOWN, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLDownloadToFile alias "URLDownloadToFileA"(byval as LPUNKNOWN, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLDownloadToCacheFile alias "URLDownloadToCacheFileA"(byval as LPUNKNOWN, byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
	declare function URLOpenBlockingStream alias "URLOpenBlockingStreamA"(byval as LPUNKNOWN, byval as LPCSTR, byval as LPSTREAM ptr, byval as DWORD, byval as LPBINDSTATUSCALLBACK) as HRESULT
#endif

declare function HlinkGoBack(byval pUnk as IUnknown ptr) as HRESULT
declare function HlinkGoForward(byval pUnk as IUnknown ptr) as HRESULT
declare function HlinkNavigateString(byval pUnk as IUnknown ptr, byval szTarget as LPCWSTR) as HRESULT
declare function HlinkNavigateMoniker(byval pUnk as IUnknown ptr, byval pmkTarget as IMoniker ptr) as HRESULT
#define _LPIINTERNET
#define __IInternet_INTERFACE_DEFINED__
type IInternet as IInternet_
type LPIINTERNET as IInternet ptr
extern IID_IInternet as const GUID

type IInternetVtbl
	QueryInterface as function(byval This as IInternet ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternet ptr) as ULONG
	Release as function(byval This as IInternet ptr) as ULONG
end type

type IInternet_
	lpVtbl as IInternetVtbl ptr
end type

#define IInternet_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternet_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternet_Release(This) (This)->lpVtbl->Release(This)
#define _LPIINTERNETBINDINFO
#define __IInternetBindInfo_INTERFACE_DEFINED__
type IInternetBindInfo as IInternetBindInfo_
type LPIINTERNETBINDINFO as IInternetBindInfo ptr

type tagBINDSTRING as long
enum
	BINDSTRING_HEADERS = 1
	BINDSTRING_ACCEPT_MIMES = 2
	BINDSTRING_EXTRA_URL = 3
	BINDSTRING_LANGUAGE = 4
	BINDSTRING_USERNAME = 5
	BINDSTRING_PASSWORD = 6
	BINDSTRING_UA_PIXELS = 7
	BINDSTRING_UA_COLOR = 8
	BINDSTRING_OS = 9
	BINDSTRING_USER_AGENT = 10
	BINDSTRING_ACCEPT_ENCODINGS = 11
	BINDSTRING_POST_COOKIE = 12
	BINDSTRING_POST_DATA_MIME = 13
	BINDSTRING_URL = 14
	BINDSTRING_IID = 15
	BINDSTRING_FLAG_BIND_TO_OBJECT = 16
	BINDSTRING_PTR_BIND_CONTEXT = 17
	BINDSTRING_XDR_ORIGIN = 18
	BINDSTRING_DOWNLOADPATH = 19
	BINDSTRING_ROOTDOC_URL = 20
	BINDSTRING_INITIAL_FILENAME = 21
	BINDSTRING_PROXY_USERNAME = 22
	BINDSTRING_PROXY_PASSWORD = 23
end enum

type BINDSTRING as tagBINDSTRING
extern IID_IInternetBindInfo as const GUID

type IInternetBindInfoVtbl
	QueryInterface as function(byval This as IInternetBindInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetBindInfo ptr) as ULONG
	Release as function(byval This as IInternetBindInfo ptr) as ULONG
	GetBindInfo as function(byval This as IInternetBindInfo ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
	GetBindString as function(byval This as IInternetBindInfo ptr, byval ulStringType as ULONG, byval ppwzStr as LPOLESTR ptr, byval cEl as ULONG, byval pcElFetched as ULONG ptr) as HRESULT
end type

type IInternetBindInfo_
	lpVtbl as IInternetBindInfoVtbl ptr
end type

#define IInternetBindInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetBindInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetBindInfo_Release(This) (This)->lpVtbl->Release(This)
#define IInternetBindInfo_GetBindInfo(This, grfBINDF, pbindinfo) (This)->lpVtbl->GetBindInfo(This, grfBINDF, pbindinfo)
#define IInternetBindInfo_GetBindString(This, ulStringType, ppwzStr, cEl, pcElFetched) (This)->lpVtbl->GetBindString(This, ulStringType, ppwzStr, cEl, pcElFetched)

declare function IInternetBindInfo_GetBindInfo_Proxy(byval This as IInternetBindInfo ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
declare sub IInternetBindInfo_GetBindInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetBindInfo_GetBindString_Proxy(byval This as IInternetBindInfo ptr, byval ulStringType as ULONG, byval ppwzStr as LPOLESTR ptr, byval cEl as ULONG, byval pcElFetched as ULONG ptr) as HRESULT
declare sub IInternetBindInfo_GetBindString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETBINDINFOEX
#define __IInternetBindInfoEx_INTERFACE_DEFINED__
type IInternetBindInfoEx as IInternetBindInfoEx_
type LPIINTERNETBINDINFOEX as IInternetBindInfoEx ptr
extern IID_IInternetBindInfoEx as const GUID

type IInternetBindInfoExVtbl
	QueryInterface as function(byval This as IInternetBindInfoEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetBindInfoEx ptr) as ULONG
	Release as function(byval This as IInternetBindInfoEx ptr) as ULONG
	GetBindInfo as function(byval This as IInternetBindInfoEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr) as HRESULT
	GetBindString as function(byval This as IInternetBindInfoEx ptr, byval ulStringType as ULONG, byval ppwzStr as LPOLESTR ptr, byval cEl as ULONG, byval pcElFetched as ULONG ptr) as HRESULT
	GetBindInfoEx as function(byval This as IInternetBindInfoEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
end type

type IInternetBindInfoEx_
	lpVtbl as IInternetBindInfoExVtbl ptr
end type

#define IInternetBindInfoEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetBindInfoEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetBindInfoEx_Release(This) (This)->lpVtbl->Release(This)
#define IInternetBindInfoEx_GetBindInfo(This, grfBINDF, pbindinfo) (This)->lpVtbl->GetBindInfo(This, grfBINDF, pbindinfo)
#define IInternetBindInfoEx_GetBindString(This, ulStringType, ppwzStr, cEl, pcElFetched) (This)->lpVtbl->GetBindString(This, ulStringType, ppwzStr, cEl, pcElFetched)
#define IInternetBindInfoEx_GetBindInfoEx(This, grfBINDF, pbindinfo, grfBINDF2, pdwReserved) (This)->lpVtbl->GetBindInfoEx(This, grfBINDF, pbindinfo, grfBINDF2, pdwReserved)
declare function IInternetBindInfoEx_GetBindInfoEx_Proxy(byval This as IInternetBindInfoEx ptr, byval grfBINDF as DWORD ptr, byval pbindinfo as BINDINFO ptr, byval grfBINDF2 as DWORD ptr, byval pdwReserved as DWORD ptr) as HRESULT
declare sub IInternetBindInfoEx_GetBindInfoEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETPROTOCOLROOT_DEFINED
#define __IInternetProtocolRoot_INTERFACE_DEFINED__
type IInternetProtocolRoot as IInternetProtocolRoot_
type LPIINTERNETPROTOCOLROOT as IInternetProtocolRoot ptr

type _tagPI_FLAGS as long
enum
	PI_PARSE_URL = &h1
	PI_FILTER_MODE = &h2
	PI_FORCE_ASYNC = &h4
	PI_USE_WORKERTHREAD = &h8
	PI_MIMEVERIFICATION = &h10
	PI_CLSIDLOOKUP = &h20
	PI_DATAPROGRESS = &h40
	PI_SYNCHRONOUS = &h80
	PI_APARTMENTTHREADED = &h100
	PI_CLASSINSTALL = &h200
	PI_PASSONBINDCTX = &h2000
	PI_NOMIMEHANDLER = &h8000
	PI_LOADAPPDIRECT = &h4000
	PD_FORCE_SWITCH = &h10000
	PI_PREFERDEFAULTHANDLER = &h20000
end enum

const PI_DOCFILECLSIDLOOKUP = PI_CLSIDLOOKUP
type PI_FLAGS as _tagPI_FLAGS

type _tagPROTOCOLDATA
	grfFlags as DWORD
	dwState as DWORD
	pData as LPVOID
	cbData as ULONG
end type

type PROTOCOLDATA as _tagPROTOCOLDATA

type _tagStartParam
	iid as IID
	pIBindCtx as IBindCtx ptr
	pItf as IUnknown ptr
end type

type StartParam as _tagStartParam
extern IID_IInternetProtocolRoot as const GUID
type IInternetProtocolSink as IInternetProtocolSink_

type IInternetProtocolRootVtbl
	QueryInterface as function(byval This as IInternetProtocolRoot ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetProtocolRoot ptr) as ULONG
	Release as function(byval This as IInternetProtocolRoot ptr) as ULONG
	Start as function(byval This as IInternetProtocolRoot ptr, byval szUrl as LPCWSTR, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
	Continue as function(byval This as IInternetProtocolRoot ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
	Abort as function(byval This as IInternetProtocolRoot ptr, byval hrReason as HRESULT, byval dwOptions as DWORD) as HRESULT
	Terminate as function(byval This as IInternetProtocolRoot ptr, byval dwOptions as DWORD) as HRESULT
	Suspend as function(byval This as IInternetProtocolRoot ptr) as HRESULT
	Resume as function(byval This as IInternetProtocolRoot ptr) as HRESULT
end type

type IInternetProtocolRoot_
	lpVtbl as IInternetProtocolRootVtbl ptr
end type

#define IInternetProtocolRoot_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetProtocolRoot_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetProtocolRoot_Release(This) (This)->lpVtbl->Release(This)
#define IInternetProtocolRoot_Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved) (This)->lpVtbl->Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
#define IInternetProtocolRoot_Continue(This, pProtocolData) (This)->lpVtbl->Continue(This, pProtocolData)
#define IInternetProtocolRoot_Abort(This, hrReason, dwOptions) (This)->lpVtbl->Abort(This, hrReason, dwOptions)
#define IInternetProtocolRoot_Terminate(This, dwOptions) (This)->lpVtbl->Terminate(This, dwOptions)
#define IInternetProtocolRoot_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IInternetProtocolRoot_Resume(This) (This)->lpVtbl->Resume(This)

declare function IInternetProtocolRoot_Start_Proxy(byval This as IInternetProtocolRoot ptr, byval szUrl as LPCWSTR, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
declare sub IInternetProtocolRoot_Start_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolRoot_Continue_Proxy(byval This as IInternetProtocolRoot ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
declare sub IInternetProtocolRoot_Continue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolRoot_Abort_Proxy(byval This as IInternetProtocolRoot ptr, byval hrReason as HRESULT, byval dwOptions as DWORD) as HRESULT
declare sub IInternetProtocolRoot_Abort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolRoot_Terminate_Proxy(byval This as IInternetProtocolRoot ptr, byval dwOptions as DWORD) as HRESULT
declare sub IInternetProtocolRoot_Terminate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolRoot_Suspend_Proxy(byval This as IInternetProtocolRoot ptr) as HRESULT
declare sub IInternetProtocolRoot_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolRoot_Resume_Proxy(byval This as IInternetProtocolRoot ptr) as HRESULT
declare sub IInternetProtocolRoot_Resume_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETPROTOCOL_DEFINED
#define __IInternetProtocol_INTERFACE_DEFINED__
type IInternetProtocol as IInternetProtocol_
type LPIINTERNETPROTOCOL as IInternetProtocol ptr
extern IID_IInternetProtocol as const GUID

type IInternetProtocolVtbl
	QueryInterface as function(byval This as IInternetProtocol ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetProtocol ptr) as ULONG
	Release as function(byval This as IInternetProtocol ptr) as ULONG
	Start as function(byval This as IInternetProtocol ptr, byval szUrl as LPCWSTR, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
	Continue as function(byval This as IInternetProtocol ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
	Abort as function(byval This as IInternetProtocol ptr, byval hrReason as HRESULT, byval dwOptions as DWORD) as HRESULT
	Terminate as function(byval This as IInternetProtocol ptr, byval dwOptions as DWORD) as HRESULT
	Suspend as function(byval This as IInternetProtocol ptr) as HRESULT
	Resume as function(byval This as IInternetProtocol ptr) as HRESULT
	Read as function(byval This as IInternetProtocol ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
	Seek as function(byval This as IInternetProtocol ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
	LockRequest as function(byval This as IInternetProtocol ptr, byval dwOptions as DWORD) as HRESULT
	UnlockRequest as function(byval This as IInternetProtocol ptr) as HRESULT
end type

type IInternetProtocol_
	lpVtbl as IInternetProtocolVtbl ptr
end type

#define IInternetProtocol_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetProtocol_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetProtocol_Release(This) (This)->lpVtbl->Release(This)
#define IInternetProtocol_Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved) (This)->lpVtbl->Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
#define IInternetProtocol_Continue(This, pProtocolData) (This)->lpVtbl->Continue(This, pProtocolData)
#define IInternetProtocol_Abort(This, hrReason, dwOptions) (This)->lpVtbl->Abort(This, hrReason, dwOptions)
#define IInternetProtocol_Terminate(This, dwOptions) (This)->lpVtbl->Terminate(This, dwOptions)
#define IInternetProtocol_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IInternetProtocol_Resume(This) (This)->lpVtbl->Resume(This)
#define IInternetProtocol_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
#define IInternetProtocol_Seek(This, dlibMove, dwOrigin, plibNewPosition) (This)->lpVtbl->Seek(This, dlibMove, dwOrigin, plibNewPosition)
#define IInternetProtocol_LockRequest(This, dwOptions) (This)->lpVtbl->LockRequest(This, dwOptions)
#define IInternetProtocol_UnlockRequest(This) (This)->lpVtbl->UnlockRequest(This)

declare function IInternetProtocol_Read_Proxy(byval This as IInternetProtocol ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
declare sub IInternetProtocol_Read_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocol_Seek_Proxy(byval This as IInternetProtocol ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
declare sub IInternetProtocol_Seek_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocol_LockRequest_Proxy(byval This as IInternetProtocol ptr, byval dwOptions as DWORD) as HRESULT
declare sub IInternetProtocol_LockRequest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocol_UnlockRequest_Proxy(byval This as IInternetProtocol ptr) as HRESULT
declare sub IInternetProtocol_UnlockRequest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define _LPIINTERNETPROTOCOLEX_DEFINED
	#define __IInternetProtocolEx_INTERFACE_DEFINED__
	extern IID_IInternetProtocolEx as const GUID
	type IInternetProtocolEx as IInternetProtocolEx_

	type IInternetProtocolExVtbl
		QueryInterface as function(byval This as IInternetProtocolEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInternetProtocolEx ptr) as ULONG
		Release as function(byval This as IInternetProtocolEx ptr) as ULONG
		Start as function(byval This as IInternetProtocolEx ptr, byval szUrl as LPCWSTR, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
		Continue as function(byval This as IInternetProtocolEx ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
		Abort as function(byval This as IInternetProtocolEx ptr, byval hrReason as HRESULT, byval dwOptions as DWORD) as HRESULT
		Terminate as function(byval This as IInternetProtocolEx ptr, byval dwOptions as DWORD) as HRESULT
		Suspend as function(byval This as IInternetProtocolEx ptr) as HRESULT
		Resume as function(byval This as IInternetProtocolEx ptr) as HRESULT
		Read as function(byval This as IInternetProtocolEx ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
		Seek as function(byval This as IInternetProtocolEx ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
		LockRequest as function(byval This as IInternetProtocolEx ptr, byval dwOptions as DWORD) as HRESULT
		UnlockRequest as function(byval This as IInternetProtocolEx ptr) as HRESULT
		StartEx as function(byval This as IInternetProtocolEx ptr, byval pUri as IUri ptr, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
	end type

	type IInternetProtocolEx_
		lpVtbl as IInternetProtocolExVtbl ptr
	end type

	#define IInternetProtocolEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInternetProtocolEx_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInternetProtocolEx_Release(This) (This)->lpVtbl->Release(This)
	#define IInternetProtocolEx_Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved) (This)->lpVtbl->Start(This, szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
	#define IInternetProtocolEx_Continue(This, pProtocolData) (This)->lpVtbl->Continue(This, pProtocolData)
	#define IInternetProtocolEx_Abort(This, hrReason, dwOptions) (This)->lpVtbl->Abort(This, hrReason, dwOptions)
	#define IInternetProtocolEx_Terminate(This, dwOptions) (This)->lpVtbl->Terminate(This, dwOptions)
	#define IInternetProtocolEx_Suspend(This) (This)->lpVtbl->Suspend(This)
	#define IInternetProtocolEx_Resume(This) (This)->lpVtbl->Resume(This)
	#define IInternetProtocolEx_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
	#define IInternetProtocolEx_Seek(This, dlibMove, dwOrigin, plibNewPosition) (This)->lpVtbl->Seek(This, dlibMove, dwOrigin, plibNewPosition)
	#define IInternetProtocolEx_LockRequest(This, dwOptions) (This)->lpVtbl->LockRequest(This, dwOptions)
	#define IInternetProtocolEx_UnlockRequest(This) (This)->lpVtbl->UnlockRequest(This)
	#define IInternetProtocolEx_StartEx(This, pUri, pOIProtSink, pOIBindInfo, grfPI, dwReserved) (This)->lpVtbl->StartEx(This, pUri, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
	declare function IInternetProtocolEx_StartEx_Proxy(byval This as IInternetProtocolEx ptr, byval pUri as IUri ptr, byval pOIProtSink as IInternetProtocolSink ptr, byval pOIBindInfo as IInternetBindInfo ptr, byval grfPI as DWORD, byval dwReserved as HANDLE_PTR) as HRESULT
	declare sub IInternetProtocolEx_StartEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define _LPIINTERNETPROTOCOLSINK_DEFINED
#define __IInternetProtocolSink_INTERFACE_DEFINED__
type LPIINTERNETPROTOCOLSINK as IInternetProtocolSink ptr
extern IID_IInternetProtocolSink as const GUID

type IInternetProtocolSinkVtbl
	QueryInterface as function(byval This as IInternetProtocolSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetProtocolSink ptr) as ULONG
	Release as function(byval This as IInternetProtocolSink ptr) as ULONG
	Switch as function(byval This as IInternetProtocolSink ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
	ReportProgress as function(byval This as IInternetProtocolSink ptr, byval ulStatusCode as ULONG, byval szStatusText as LPCWSTR) as HRESULT
	ReportData as function(byval This as IInternetProtocolSink ptr, byval grfBSCF as DWORD, byval ulProgress as ULONG, byval ulProgressMax as ULONG) as HRESULT
	ReportResult as function(byval This as IInternetProtocolSink ptr, byval hrResult as HRESULT, byval dwError as DWORD, byval szResult as LPCWSTR) as HRESULT
end type

type IInternetProtocolSink_
	lpVtbl as IInternetProtocolSinkVtbl ptr
end type

#define IInternetProtocolSink_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetProtocolSink_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetProtocolSink_Release(This) (This)->lpVtbl->Release(This)
#define IInternetProtocolSink_Switch(This, pProtocolData) (This)->lpVtbl->Switch(This, pProtocolData)
#define IInternetProtocolSink_ReportProgress(This, ulStatusCode, szStatusText) (This)->lpVtbl->ReportProgress(This, ulStatusCode, szStatusText)
#define IInternetProtocolSink_ReportData(This, grfBSCF, ulProgress, ulProgressMax) (This)->lpVtbl->ReportData(This, grfBSCF, ulProgress, ulProgressMax)
#define IInternetProtocolSink_ReportResult(This, hrResult, dwError, szResult) (This)->lpVtbl->ReportResult(This, hrResult, dwError, szResult)

declare function IInternetProtocolSink_Switch_Proxy(byval This as IInternetProtocolSink ptr, byval pProtocolData as PROTOCOLDATA ptr) as HRESULT
declare sub IInternetProtocolSink_Switch_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolSink_ReportProgress_Proxy(byval This as IInternetProtocolSink ptr, byval ulStatusCode as ULONG, byval szStatusText as LPCWSTR) as HRESULT
declare sub IInternetProtocolSink_ReportProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolSink_ReportData_Proxy(byval This as IInternetProtocolSink ptr, byval grfBSCF as DWORD, byval ulProgress as ULONG, byval ulProgressMax as ULONG) as HRESULT
declare sub IInternetProtocolSink_ReportData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolSink_ReportResult_Proxy(byval This as IInternetProtocolSink ptr, byval hrResult as HRESULT, byval dwError as DWORD, byval szResult as LPCWSTR) as HRESULT
declare sub IInternetProtocolSink_ReportResult_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETPROTOCOLSINKSTACKABLE_DEFINED
#define __IInternetProtocolSinkStackable_INTERFACE_DEFINED__
type IInternetProtocolSinkStackable as IInternetProtocolSinkStackable_
type LPIINTERNETPROTOCOLSINKStackable as IInternetProtocolSinkStackable ptr
extern IID_IInternetProtocolSinkStackable as const GUID

type IInternetProtocolSinkStackableVtbl
	QueryInterface as function(byval This as IInternetProtocolSinkStackable ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetProtocolSinkStackable ptr) as ULONG
	Release as function(byval This as IInternetProtocolSinkStackable ptr) as ULONG
	SwitchSink as function(byval This as IInternetProtocolSinkStackable ptr, byval pOIProtSink as IInternetProtocolSink ptr) as HRESULT
	CommitSwitch as function(byval This as IInternetProtocolSinkStackable ptr) as HRESULT
	RollbackSwitch as function(byval This as IInternetProtocolSinkStackable ptr) as HRESULT
end type

type IInternetProtocolSinkStackable_
	lpVtbl as IInternetProtocolSinkStackableVtbl ptr
end type

#define IInternetProtocolSinkStackable_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetProtocolSinkStackable_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetProtocolSinkStackable_Release(This) (This)->lpVtbl->Release(This)
#define IInternetProtocolSinkStackable_SwitchSink(This, pOIProtSink) (This)->lpVtbl->SwitchSink(This, pOIProtSink)
#define IInternetProtocolSinkStackable_CommitSwitch(This) (This)->lpVtbl->CommitSwitch(This)
#define IInternetProtocolSinkStackable_RollbackSwitch(This) (This)->lpVtbl->RollbackSwitch(This)

declare function IInternetProtocolSinkStackable_SwitchSink_Proxy(byval This as IInternetProtocolSinkStackable ptr, byval pOIProtSink as IInternetProtocolSink ptr) as HRESULT
declare sub IInternetProtocolSinkStackable_SwitchSink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolSinkStackable_CommitSwitch_Proxy(byval This as IInternetProtocolSinkStackable ptr) as HRESULT
declare sub IInternetProtocolSinkStackable_CommitSwitch_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolSinkStackable_RollbackSwitch_Proxy(byval This as IInternetProtocolSinkStackable ptr) as HRESULT
declare sub IInternetProtocolSinkStackable_RollbackSwitch_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETSESSION_DEFINED
#define __IInternetSession_INTERFACE_DEFINED__
type IInternetSession as IInternetSession_
type LPIINTERNETSESSION as IInternetSession ptr

type _tagOIBDG_FLAGS as long
enum
	OIBDG_APARTMENTTHREADED = &h100
	OIBDG_DATAONLY = &h1000
end enum

type OIBDG_FLAGS as _tagOIBDG_FLAGS
extern IID_IInternetSession as const GUID

type IInternetSessionVtbl
	QueryInterface as function(byval This as IInternetSession ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetSession ptr) as ULONG
	Release as function(byval This as IInternetSession ptr) as ULONG
	RegisterNameSpace as function(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval rclsid as const IID const ptr, byval pwzProtocol as LPCWSTR, byval cPatterns as ULONG, byval ppwzPatterns as const LPCWSTR ptr, byval dwReserved as DWORD) as HRESULT
	UnregisterNameSpace as function(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval pszProtocol as LPCWSTR) as HRESULT
	RegisterMimeFilter as function(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval rclsid as const IID const ptr, byval pwzType as LPCWSTR) as HRESULT
	UnregisterMimeFilter as function(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval pwzType as LPCWSTR) as HRESULT
	CreateBinding as function(byval This as IInternetSession ptr, byval pBC as LPBC, byval szUrl as LPCWSTR, byval pUnkOuter as IUnknown ptr, byval ppUnk as IUnknown ptr ptr, byval ppOInetProt as IInternetProtocol ptr ptr, byval dwOption as DWORD) as HRESULT
	SetSessionOption as function(byval This as IInternetSession ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwReserved as DWORD) as HRESULT
	GetSessionOption as function(byval This as IInternetSession ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pdwBufferLength as DWORD ptr, byval dwReserved as DWORD) as HRESULT
end type

type IInternetSession_
	lpVtbl as IInternetSessionVtbl ptr
end type

#define IInternetSession_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetSession_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetSession_Release(This) (This)->lpVtbl->Release(This)
#define IInternetSession_RegisterNameSpace(This, pCF, rclsid, pwzProtocol, cPatterns, ppwzPatterns, dwReserved) (This)->lpVtbl->RegisterNameSpace(This, pCF, rclsid, pwzProtocol, cPatterns, ppwzPatterns, dwReserved)
#define IInternetSession_UnregisterNameSpace(This, pCF, pszProtocol) (This)->lpVtbl->UnregisterNameSpace(This, pCF, pszProtocol)
#define IInternetSession_RegisterMimeFilter(This, pCF, rclsid, pwzType) (This)->lpVtbl->RegisterMimeFilter(This, pCF, rclsid, pwzType)
#define IInternetSession_UnregisterMimeFilter(This, pCF, pwzType) (This)->lpVtbl->UnregisterMimeFilter(This, pCF, pwzType)
#define IInternetSession_CreateBinding(This, pBC, szUrl, pUnkOuter, ppUnk, ppOInetProt, dwOption) (This)->lpVtbl->CreateBinding(This, pBC, szUrl, pUnkOuter, ppUnk, ppOInetProt, dwOption)
#define IInternetSession_SetSessionOption(This, dwOption, pBuffer, dwBufferLength, dwReserved) (This)->lpVtbl->SetSessionOption(This, dwOption, pBuffer, dwBufferLength, dwReserved)
#define IInternetSession_GetSessionOption(This, dwOption, pBuffer, pdwBufferLength, dwReserved) (This)->lpVtbl->GetSessionOption(This, dwOption, pBuffer, pdwBufferLength, dwReserved)

declare function IInternetSession_RegisterNameSpace_Proxy(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval rclsid as const IID const ptr, byval pwzProtocol as LPCWSTR, byval cPatterns as ULONG, byval ppwzPatterns as const LPCWSTR ptr, byval dwReserved as DWORD) as HRESULT
declare sub IInternetSession_RegisterNameSpace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_UnregisterNameSpace_Proxy(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval pszProtocol as LPCWSTR) as HRESULT
declare sub IInternetSession_UnregisterNameSpace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_RegisterMimeFilter_Proxy(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval rclsid as const IID const ptr, byval pwzType as LPCWSTR) as HRESULT
declare sub IInternetSession_RegisterMimeFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_UnregisterMimeFilter_Proxy(byval This as IInternetSession ptr, byval pCF as IClassFactory ptr, byval pwzType as LPCWSTR) as HRESULT
declare sub IInternetSession_UnregisterMimeFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_CreateBinding_Proxy(byval This as IInternetSession ptr, byval pBC as LPBC, byval szUrl as LPCWSTR, byval pUnkOuter as IUnknown ptr, byval ppUnk as IUnknown ptr ptr, byval ppOInetProt as IInternetProtocol ptr ptr, byval dwOption as DWORD) as HRESULT
declare sub IInternetSession_CreateBinding_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_SetSessionOption_Proxy(byval This as IInternetSession ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetSession_SetSessionOption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSession_GetSessionOption_Proxy(byval This as IInternetSession ptr, byval dwOption as DWORD, byval pBuffer as LPVOID, byval pdwBufferLength as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare sub IInternetSession_GetSessionOption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETTHREADSWITCH_DEFINED
#define __IInternetThreadSwitch_INTERFACE_DEFINED__
type IInternetThreadSwitch as IInternetThreadSwitch_
type LPIINTERNETTHREADSWITCH as IInternetThreadSwitch ptr
extern IID_IInternetThreadSwitch as const GUID

type IInternetThreadSwitchVtbl
	QueryInterface as function(byval This as IInternetThreadSwitch ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetThreadSwitch ptr) as ULONG
	Release as function(byval This as IInternetThreadSwitch ptr) as ULONG
	Prepare as function(byval This as IInternetThreadSwitch ptr) as HRESULT
	Continue as function(byval This as IInternetThreadSwitch ptr) as HRESULT
end type

type IInternetThreadSwitch_
	lpVtbl as IInternetThreadSwitchVtbl ptr
end type

#define IInternetThreadSwitch_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetThreadSwitch_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetThreadSwitch_Release(This) (This)->lpVtbl->Release(This)
#define IInternetThreadSwitch_Prepare(This) (This)->lpVtbl->Prepare(This)
#define IInternetThreadSwitch_Continue(This) (This)->lpVtbl->Continue(This)

declare function IInternetThreadSwitch_Prepare_Proxy(byval This as IInternetThreadSwitch ptr) as HRESULT
declare sub IInternetThreadSwitch_Prepare_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetThreadSwitch_Continue_Proxy(byval This as IInternetThreadSwitch ptr) as HRESULT
declare sub IInternetThreadSwitch_Continue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETPRIORITY_DEFINED
#define __IInternetPriority_INTERFACE_DEFINED__
type IInternetPriority as IInternetPriority_
type LPIINTERNETPRIORITY as IInternetPriority ptr
extern IID_IInternetPriority as const GUID

type IInternetPriorityVtbl
	QueryInterface as function(byval This as IInternetPriority ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetPriority ptr) as ULONG
	Release as function(byval This as IInternetPriority ptr) as ULONG
	SetPriority as function(byval This as IInternetPriority ptr, byval nPriority as LONG) as HRESULT
	GetPriority as function(byval This as IInternetPriority ptr, byval pnPriority as LONG ptr) as HRESULT
end type

type IInternetPriority_
	lpVtbl as IInternetPriorityVtbl ptr
end type

#define IInternetPriority_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetPriority_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetPriority_Release(This) (This)->lpVtbl->Release(This)
#define IInternetPriority_SetPriority(This, nPriority) (This)->lpVtbl->SetPriority(This, nPriority)
#define IInternetPriority_GetPriority(This, pnPriority) (This)->lpVtbl->GetPriority(This, pnPriority)

declare function IInternetPriority_SetPriority_Proxy(byval This as IInternetPriority ptr, byval nPriority as LONG) as HRESULT
declare sub IInternetPriority_SetPriority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetPriority_GetPriority_Proxy(byval This as IInternetPriority ptr, byval pnPriority as LONG ptr) as HRESULT
declare sub IInternetPriority_GetPriority_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPIINTERNETPROTOCOLINFO_DEFINED
#define __IInternetProtocolInfo_INTERFACE_DEFINED__
type IInternetProtocolInfo as IInternetProtocolInfo_
type LPIINTERNETPROTOCOLINFO as IInternetProtocolInfo ptr

type _tagPARSEACTION as long
enum
	PARSE_CANONICALIZE = 1
	PARSE_FRIENDLY = 2
	PARSE_SECURITY_URL = 3
	PARSE_ROOTDOCUMENT = 4
	PARSE_DOCUMENT = 5
	PARSE_ANCHOR = 6
	PARSE_ENCODE_IS_UNESCAPE = 7
	PARSE_DECODE_IS_ESCAPE = 8
	PARSE_PATH_FROM_URL = 9
	PARSE_URL_FROM_PATH = 10
	PARSE_MIME = 11
	PARSE_SERVER = 12
	PARSE_SCHEMA = 13
	PARSE_SITE = 14
	PARSE_DOMAIN = 15
	PARSE_LOCATION = 16
	PARSE_SECURITY_DOMAIN = 17
	PARSE_ESCAPE = 18
	PARSE_UNESCAPE = 19
end enum

type PARSEACTION as _tagPARSEACTION

type _tagPSUACTION as long
enum
	PSU_DEFAULT = 1
	PSU_SECURITY_URL_ONLY = 2
end enum

type PSUACTION as _tagPSUACTION

type _tagQUERYOPTION as long
enum
	QUERY_EXPIRATION_DATE = 1
	QUERY_TIME_OF_LAST_CHANGE = 2
	QUERY_CONTENT_ENCODING = 3
	QUERY_CONTENT_TYPE = 4
	QUERY_REFRESH = 5
	QUERY_RECOMBINE = 6
	QUERY_CAN_NAVIGATE = 7
	QUERY_USES_NETWORK = 8
	QUERY_IS_CACHED = 9
	QUERY_IS_INSTALLEDENTRY = 10
	QUERY_IS_CACHED_OR_MAPPED = 11
	QUERY_USES_CACHE = 12
	QUERY_IS_SECURE = 13
	QUERY_IS_SAFE = 14
	QUERY_USES_HISTORYFOLDER = 15
	QUERY_IS_CACHED_AND_USABLE_OFFLINE = 16
end enum

type QUERYOPTION as _tagQUERYOPTION
extern IID_IInternetProtocolInfo as const GUID

type IInternetProtocolInfoVtbl
	QueryInterface as function(byval This as IInternetProtocolInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetProtocolInfo ptr) as ULONG
	Release as function(byval This as IInternetProtocolInfo ptr) as ULONG
	ParseUrl as function(byval This as IInternetProtocolInfo ptr, byval pwzUrl as LPCWSTR, byval ParseAction as PARSEACTION, byval dwParseFlags as DWORD, byval pwzResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT
	CombineUrl as function(byval This as IInternetProtocolInfo ptr, byval pwzBaseUrl as LPCWSTR, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval pwzResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT
	CompareUrl as function(byval This as IInternetProtocolInfo ptr, byval pwzUrl1 as LPCWSTR, byval pwzUrl2 as LPCWSTR, byval dwCompareFlags as DWORD) as HRESULT
	QueryInfo as function(byval This as IInternetProtocolInfo ptr, byval pwzUrl as LPCWSTR, byval OueryOption as QUERYOPTION, byval dwQueryFlags as DWORD, byval pBuffer as LPVOID, byval cbBuffer as DWORD, byval pcbBuf as DWORD ptr, byval dwReserved as DWORD) as HRESULT
end type

type IInternetProtocolInfo_
	lpVtbl as IInternetProtocolInfoVtbl ptr
end type

#define IInternetProtocolInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetProtocolInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetProtocolInfo_Release(This) (This)->lpVtbl->Release(This)
#define IInternetProtocolInfo_ParseUrl(This, pwzUrl, ParseAction, dwParseFlags, pwzResult, cchResult, pcchResult, dwReserved) (This)->lpVtbl->ParseUrl(This, pwzUrl, ParseAction, dwParseFlags, pwzResult, cchResult, pcchResult, dwReserved)
#define IInternetProtocolInfo_CombineUrl(This, pwzBaseUrl, pwzRelativeUrl, dwCombineFlags, pwzResult, cchResult, pcchResult, dwReserved) (This)->lpVtbl->CombineUrl(This, pwzBaseUrl, pwzRelativeUrl, dwCombineFlags, pwzResult, cchResult, pcchResult, dwReserved)
#define IInternetProtocolInfo_CompareUrl(This, pwzUrl1, pwzUrl2, dwCompareFlags) (This)->lpVtbl->CompareUrl(This, pwzUrl1, pwzUrl2, dwCompareFlags)
#define IInternetProtocolInfo_QueryInfo(This, pwzUrl, OueryOption, dwQueryFlags, pBuffer, cbBuffer, pcbBuf, dwReserved) (This)->lpVtbl->QueryInfo(This, pwzUrl, OueryOption, dwQueryFlags, pBuffer, cbBuffer, pcbBuf, dwReserved)

declare function IInternetProtocolInfo_ParseUrl_Proxy(byval This as IInternetProtocolInfo ptr, byval pwzUrl as LPCWSTR, byval ParseAction as PARSEACTION, byval dwParseFlags as DWORD, byval pwzResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare sub IInternetProtocolInfo_ParseUrl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolInfo_CombineUrl_Proxy(byval This as IInternetProtocolInfo ptr, byval pwzBaseUrl as LPCWSTR, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval pwzResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare sub IInternetProtocolInfo_CombineUrl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolInfo_CompareUrl_Proxy(byval This as IInternetProtocolInfo ptr, byval pwzUrl1 as LPCWSTR, byval pwzUrl2 as LPCWSTR, byval dwCompareFlags as DWORD) as HRESULT
declare sub IInternetProtocolInfo_CompareUrl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetProtocolInfo_QueryInfo_Proxy(byval This as IInternetProtocolInfo ptr, byval pwzUrl as LPCWSTR, byval OueryOption as QUERYOPTION, byval dwQueryFlags as DWORD, byval pBuffer as LPVOID, byval cbBuffer as DWORD, byval pcbBuf as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare sub IInternetProtocolInfo_QueryInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const PARSE_ENCODE = PARSE_ENCODE_IS_UNESCAPE
const PARSE_DECODE = PARSE_DECODE_IS_ESCAPE

type IOInet as IInternet
type IOInetBindInfo as IInternetBindInfo
type IOInetBindInfoEx as IInternetBindInfoEx
type IOInetProtocolRoot as IInternetProtocolRoot
type IOInetProtocol as IInternetProtocol

#if _WIN32_WINNT >= &h0600
	type IOInetProtocolEx as IInternetProtocolEx
#endif

type IOInetProtocolSink as IInternetProtocolSink
type IOInetProtocolInfo as IInternetProtocolInfo
type IOInetSession as IInternetSession
type IOInetPriority as IInternetPriority
type IOInetThreadSwitch as IInternetThreadSwitch
type IOInetProtocolSinkStackable as IInternetProtocolSinkStackable
type LPOINET as LPIINTERNET
type LPOINETPROTOCOLINFO as LPIINTERNETPROTOCOLINFO
type LPOINETBINDINFO as LPIINTERNETBINDINFO
type LPOINETPROTOCOLROOT as LPIINTERNETPROTOCOLROOT
type LPOINETPROTOCOL as LPIINTERNETPROTOCOL

#if _WIN32_WINNT >= &h0600
	#define LPOINETPROTOCOLEX LPIINTERNETPROTOCOLEX
#endif

type LPOINETPROTOCOLSINK as LPIINTERNETPROTOCOLSINK
type LPOINETSESSION as LPIINTERNETSESSION
type LPOINETTHREADSWITCH as LPIINTERNETTHREADSWITCH
type LPOINETPRIORITY as LPIINTERNETPRIORITY
type LPOINETPROTOCOLINFO as LPIINTERNETPROTOCOLINFO
#define LPOINETPROTOCOLSINKSTACKABLE LPIINTERNETPROTOCOLSINKSTACKABLE

extern IID_IOInet alias "IID_IInternet" as const GUID
extern IID_IOInetBindInfo alias "IID_IInternetBindInfo" as const GUID
extern IID_IOInetBindInfoEx alias "IID_IInternetBindInfoEx" as const GUID
extern IID_IOInetProtocolRoot alias "IID_IInternetProtocolRoot" as const GUID
extern IID_IOInetProtocol alias "IID_IInternetProtocol" as const GUID

#if _WIN32_WINNT >= &h0600
	extern IID_IOInetProtocolEx alias "IID_IInternetProtocolEx" as const GUID
#endif

extern IID_IOInetProtocolSink alias "IID_IInternetProtocolSink" as const GUID
extern IID_IOInetProtocolInfo alias "IID_IInternetProtocolInfo" as const GUID
extern IID_IOInetSession alias "IID_IInternetSession" as const GUID
extern IID_IOInetPriority alias "IID_IInternetPriority" as const GUID
extern IID_IOInetThreadSwitch alias "IID_IInternetThreadSwitch" as const GUID
extern IID_IOInetProtocolSinkStackable alias "IID_IInternetProtocolSinkStackable" as const GUID
declare function CoInternetParseUrl(byval pwzUrl as LPCWSTR, byval ParseAction as PARSEACTION, byval dwFlags as DWORD, byval pszResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function CoInternetParseIUri(byval pIUri as IUri ptr, byval ParseAction as PARSEACTION, byval dwFlags as DWORD, byval pwzResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
#endif

declare function CoInternetCombineUrl(byval pwzBaseUrl as LPCWSTR, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval pszResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function CoInternetCombineUrlEx(byval pBaseUri as IUri ptr, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval ppCombinedUri as IUri ptr ptr, byval dwReserved as DWORD_PTR) as HRESULT
	declare function CoInternetCombineIUri(byval pBaseUri as IUri ptr, byval pRelativeUri as IUri ptr, byval dwCombineFlags as DWORD, byval ppCombinedUri as IUri ptr ptr, byval dwReserved as DWORD_PTR) as HRESULT
#endif

declare function CoInternetCompareUrl(byval pwzUrl1 as LPCWSTR, byval pwzUrl2 as LPCWSTR, byval dwFlags as DWORD) as HRESULT
declare function CoInternetGetProtocolFlags(byval pwzUrl as LPCWSTR, byval pdwFlags as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare function CoInternetQueryInfo(byval pwzUrl as LPCWSTR, byval QueryOptions as QUERYOPTION, byval dwQueryFlags as DWORD, byval pvBuffer as LPVOID, byval cbBuffer as DWORD, byval pcbBuffer as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare function CoInternetGetSession(byval dwSessionMode as DWORD, byval ppIInternetSession as IInternetSession ptr ptr, byval dwReserved as DWORD) as HRESULT
declare function CoInternetGetSecurityUrl(byval pwszUrl as LPCWSTR, byval ppwszSecUrl as LPWSTR ptr, byval psuAction as PSUACTION, byval dwReserved as DWORD) as HRESULT
declare function AsyncInstallDistributionUnit(byval szDistUnit as LPCWSTR, byval szTYPE as LPCWSTR, byval szExt as LPCWSTR, byval dwFileVersionMS as DWORD, byval dwFileVersionLS as DWORD, byval szURL as LPCWSTR, byval pbc as IBindCtx ptr, byval pvReserved as LPVOID, byval flags as DWORD) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function CoInternetGetSecurityUrlEx(byval pUri as IUri ptr, byval ppSecUri as IUri ptr ptr, byval psuAction as PSUACTION, byval dwReserved as DWORD_PTR) as HRESULT
	#define _INTERNETFEATURELIST_DEFINED

	type _tagINTERNETFEATURELIST as long
	enum
		FEATURE_OBJECT_CACHING = 0
		FEATURE_ZONE_ELEVATION = 1
		FEATURE_MIME_HANDLING = 2
		FEATURE_MIME_SNIFFING = 3
		FEATURE_WINDOW_RESTRICTIONS = 4
		FEATURE_WEBOC_POPUPMANAGEMENT = 5
		FEATURE_BEHAVIORS = 6
		FEATURE_DISABLE_MK_PROTOCOL = 7
		FEATURE_LOCALMACHINE_LOCKDOWN = 8
		FEATURE_SECURITYBAND = 9
		FEATURE_RESTRICT_ACTIVEXINSTALL = 10
		FEATURE_VALIDATE_NAVIGATE_URL = 11
		FEATURE_RESTRICT_FILEDOWNLOAD = 12
		FEATURE_ADDON_MANAGEMENT = 13
		FEATURE_PROTOCOL_LOCKDOWN = 14
		FEATURE_HTTP_USERNAME_PASSWORD_DISABLE = 15
		FEATURE_SAFE_BINDTOOBJECT = 16
		FEATURE_UNC_SAVEDFILECHECK = 17
		FEATURE_GET_URL_DOM_FILEPATH_UNENCODED = 18
		FEATURE_TABBED_BROWSING = 19
		FEATURE_SSLUX = 20
		FEATURE_DISABLE_NAVIGATION_SOUNDS = 21
		FEATURE_DISABLE_LEGACY_COMPRESSION = 22
		FEATURE_FORCE_ADDR_AND_STATUS = 23
		FEATURE_XMLHTTP = 24
		FEATURE_DISABLE_TELNET_PROTOCOL = 25
		FEATURE_FEEDS = 26
		FEATURE_BLOCK_INPUT_PROMPTS = 27
		FEATURE_ENTRY_COUNT = 28
	end enum

	type INTERNETFEATURELIST as _tagINTERNETFEATURELIST
	const SET_FEATURE_ON_THREAD = &h1
	const SET_FEATURE_ON_PROCESS = &h2
	const SET_FEATURE_IN_REGISTRY = &h4
	const SET_FEATURE_ON_THREAD_LOCALMACHINE = &h8
	const SET_FEATURE_ON_THREAD_INTRANET = &h10
	const SET_FEATURE_ON_THREAD_TRUSTED = &h20
	const SET_FEATURE_ON_THREAD_INTERNET = &h40
	const SET_FEATURE_ON_THREAD_RESTRICTED = &h80
	const GET_FEATURE_FROM_THREAD = &h1
	const GET_FEATURE_FROM_PROCESS = &h2
	const GET_FEATURE_FROM_REGISTRY = &h4
	const GET_FEATURE_FROM_THREAD_LOCALMACHINE = &h8
	const GET_FEATURE_FROM_THREAD_INTRANET = &h10
	const GET_FEATURE_FROM_THREAD_TRUSTED = &h20
	const GET_FEATURE_FROM_THREAD_INTERNET = &h40
	const GET_FEATURE_FROM_THREAD_RESTRICTED = &h80
	declare function CoInternetSetFeatureEnabled(byval FeatureEntry as INTERNETFEATURELIST, byval dwFlags as DWORD, byval fEnable as WINBOOL) as HRESULT
	declare function CoInternetIsFeatureEnabled(byval FeatureEntry as INTERNETFEATURELIST, byval dwFlags as DWORD) as HRESULT
	type IInternetSecurityManager as IInternetSecurityManager_
	declare function CoInternetIsFeatureEnabledForUrl(byval FeatureEntry as INTERNETFEATURELIST, byval dwFlags as DWORD, byval szURL as LPCWSTR, byval pSecMgr as IInternetSecurityManager ptr) as HRESULT
	type IInternetSecurityManagerEx2 as IInternetSecurityManagerEx2_
	declare function CoInternetIsFeatureEnabledForIUri(byval FeatureEntry as INTERNETFEATURELIST, byval dwFlags as DWORD, byval pIUri as IUri ptr, byval pSecMgr as IInternetSecurityManagerEx2 ptr) as HRESULT
	declare function CoInternetIsFeatureZoneElevationEnabled(byval szFromURL as LPCWSTR, byval szToURL as LPCWSTR, byval pSecMgr as IInternetSecurityManager ptr, byval dwFlags as DWORD) as HRESULT
#endif

declare function CopyStgMedium(byval pcstgmedSrc as const STGMEDIUM ptr, byval pstgmedDest as STGMEDIUM ptr) as HRESULT
declare function CopyBindInfo(byval pcbiSrc as const BINDINFO ptr, byval pbiDest as BINDINFO ptr) as HRESULT
declare sub ReleaseBindInfo(byval pbindinfo as BINDINFO ptr)

#define INET_E_USE_DEFAULT_PROTOCOLHANDLER _HRESULT_TYPEDEF_(&h800C0011)
#define INET_E_USE_DEFAULT_SETTING _HRESULT_TYPEDEF_(&h800C0012)
#define INET_E_DEFAULT_ACTION INET_E_USE_DEFAULT_PROTOCOLHANDLER
#define INET_E_QUERYOPTION_UNKNOWN _HRESULT_TYPEDEF_(&h800C0013)
#define INET_E_REDIRECTING _HRESULT_TYPEDEF_(&h800C0014)
declare function OInetParseUrl alias "CoInternetParseUrl"(byval pwzUrl as LPCWSTR, byval ParseAction as PARSEACTION, byval dwFlags as DWORD, byval pszResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare function OInetCombineUrl alias "CoInternetCombineUrl"(byval pwzBaseUrl as LPCWSTR, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval pszResult as LPWSTR, byval cchResult as DWORD, byval pcchResult as DWORD ptr, byval dwReserved as DWORD) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function OInetCombineUrlEx alias "CoInternetCombineUrlEx"(byval pBaseUri as IUri ptr, byval pwzRelativeUrl as LPCWSTR, byval dwCombineFlags as DWORD, byval ppCombinedUri as IUri ptr ptr, byval dwReserved as DWORD_PTR) as HRESULT
	declare function OInetCombineIUri alias "CoInternetCombineIUri"(byval pBaseUri as IUri ptr, byval pRelativeUri as IUri ptr, byval dwCombineFlags as DWORD, byval ppCombinedUri as IUri ptr ptr, byval dwReserved as DWORD_PTR) as HRESULT
#endif

declare function OInetCompareUrl alias "CoInternetCompareUrl"(byval pwzUrl1 as LPCWSTR, byval pwzUrl2 as LPCWSTR, byval dwFlags as DWORD) as HRESULT
declare function OInetQueryInfo alias "CoInternetQueryInfo"(byval pwzUrl as LPCWSTR, byval QueryOptions as QUERYOPTION, byval dwQueryFlags as DWORD, byval pvBuffer as LPVOID, byval cbBuffer as DWORD, byval pcbBuffer as DWORD ptr, byval dwReserved as DWORD) as HRESULT
declare function OInetGetSession alias "CoInternetGetSession"(byval dwSessionMode as DWORD, byval ppIInternetSession as IInternetSession ptr ptr, byval dwReserved as DWORD) as HRESULT
const PROTOCOLFLAG_NO_PICS_CHECK = &h1

#if _WIN32_WINNT <= &h0502
	type IInternetSecurityManager as IInternetSecurityManager_
#endif

declare function CoInternetCreateSecurityManager(byval pSP as IServiceProvider ptr, byval ppSM as IInternetSecurityManager ptr ptr, byval dwReserved as DWORD) as HRESULT
type IInternetZoneManager as IInternetZoneManager_
declare function CoInternetCreateZoneManager(byval pSP as IServiceProvider ptr, byval ppZM as IInternetZoneManager ptr ptr, byval dwReserved as DWORD) as HRESULT
extern CLSID_InternetSecurityManager as const IID
extern CLSID_InternetZoneManager as const IID

#if _WIN32_WINNT >= &h0600
	extern CLSID_PersistentZoneIdentifier as const IID
#endif

#define _LPINTERNETSECURITYMGRSITE_DEFINED
#define __IInternetSecurityMgrSite_INTERFACE_DEFINED__
extern IID_IInternetSecurityMgrSite as const GUID
type IInternetSecurityMgrSite as IInternetSecurityMgrSite_

type IInternetSecurityMgrSiteVtbl
	QueryInterface as function(byval This as IInternetSecurityMgrSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetSecurityMgrSite ptr) as ULONG
	Release as function(byval This as IInternetSecurityMgrSite ptr) as ULONG
	GetWindow as function(byval This as IInternetSecurityMgrSite ptr, byval phwnd as HWND ptr) as HRESULT
	EnableModeless as function(byval This as IInternetSecurityMgrSite ptr, byval fEnable as WINBOOL) as HRESULT
end type

type IInternetSecurityMgrSite_
	lpVtbl as IInternetSecurityMgrSiteVtbl ptr
end type

#define IInternetSecurityMgrSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetSecurityMgrSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetSecurityMgrSite_Release(This) (This)->lpVtbl->Release(This)
#define IInternetSecurityMgrSite_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IInternetSecurityMgrSite_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)

declare function IInternetSecurityMgrSite_GetWindow_Proxy(byval This as IInternetSecurityMgrSite ptr, byval phwnd as HWND ptr) as HRESULT
declare sub IInternetSecurityMgrSite_GetWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityMgrSite_EnableModeless_Proxy(byval This as IInternetSecurityMgrSite ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IInternetSecurityMgrSite_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define _LPINTERNETSECURITYMANANGER_DEFINED
#define __IInternetSecurityManager_INTERFACE_DEFINED__
const MUTZ_NOSAVEDFILECHECK = &h1
const MUTZ_ISFILE = &h2
const MUTZ_ACCEPT_WILDCARD_SCHEME = &h80
const MUTZ_ENFORCERESTRICTED = &h100
const MUTZ_RESERVED = &h200
const MUTZ_REQUIRESAVEDFILECHECK = &h400
const MUTZ_DONT_UNESCAPE = &h800
const MUTZ_DONT_USE_CACHE = &h1000
const MUTZ_FORCE_INTRANET_FLAGS = &h2000
const MUTZ_IGNORE_ZONE_MAPPINGS = &h4000
const MAX_SIZE_SECURITY_ID = 512

type __WIDL_urlmon_generated_name_0000000E as long
enum
	PUAF_DEFAULT = &h0
	PUAF_NOUI = &h1
	PUAF_ISFILE = &h2
	PUAF_WARN_IF_DENIED = &h4
	PUAF_FORCEUI_FOREGROUND = &h8
	PUAF_CHECK_TIFS = &h10
	PUAF_DONTCHECKBOXINDIALOG = &h20
	PUAF_TRUSTED = &h40
	PUAF_ACCEPT_WILDCARD_SCHEME = &h80
	PUAF_ENFORCERESTRICTED = &h100
	PUAF_NOSAVEDFILECHECK = &h200
	PUAF_REQUIRESAVEDFILECHECK = &h400
	PUAF_DONT_USE_CACHE = &h1000
	PUAF_RESERVED1 = &h2000
	PUAF_RESERVED2 = &h4000
	PUAF_LMZ_UNLOCKED = &h10000
	PUAF_LMZ_LOCKED = &h20000
	PUAF_DEFAULTZONEPOL = &h40000
	PUAF_NPL_USE_LOCKED_IF_RESTRICTED = &h80000
	PUAF_NOUIIFLOCKED = &h100000
	PUAF_DRAGPROTOCOLCHECK = &h200000
end enum

type PUAF as __WIDL_urlmon_generated_name_0000000E

type __WIDL_urlmon_generated_name_0000000F as long
enum
	PUAFOUT_DEFAULT = &h0
	PUAFOUT_ISLOCKZONEPOLICY = &h1
end enum

type PUAFOUT as __WIDL_urlmon_generated_name_0000000F

type __WIDL_urlmon_generated_name_00000010 as long
enum
	SZM_CREATE = &h0
	SZM_DELETE = &h1
end enum

type SZM_FLAGS as __WIDL_urlmon_generated_name_00000010
extern IID_IInternetSecurityManager as const GUID
extern SID_SInternetSecurityManager alias "IID_IInternetSecurityManager" as const GUID

type IInternetSecurityManagerVtbl
	QueryInterface as function(byval This as IInternetSecurityManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetSecurityManager ptr) as ULONG
	Release as function(byval This as IInternetSecurityManager ptr) as ULONG
	SetSecuritySite as function(byval This as IInternetSecurityManager ptr, byval pSite as IInternetSecurityMgrSite ptr) as HRESULT
	GetSecuritySite as function(byval This as IInternetSecurityManager ptr, byval ppSite as IInternetSecurityMgrSite ptr ptr) as HRESULT
	MapUrlToZone as function(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval pdwZone as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	GetSecurityId as function(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
	ProcessUrlAction as function(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
	QueryCustomPolicy as function(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
	SetZoneMapping as function(byval This as IInternetSecurityManager ptr, byval dwZone as DWORD, byval lpszPattern as LPCWSTR, byval dwFlags as DWORD) as HRESULT
	GetZoneMappings as function(byval This as IInternetSecurityManager ptr, byval dwZone as DWORD, byval ppenumString as IEnumString ptr ptr, byval dwFlags as DWORD) as HRESULT
end type

type IInternetSecurityManager_
	lpVtbl as IInternetSecurityManagerVtbl ptr
end type

#define IInternetSecurityManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetSecurityManager_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetSecurityManager_Release(This) (This)->lpVtbl->Release(This)
#define IInternetSecurityManager_SetSecuritySite(This, pSite) (This)->lpVtbl->SetSecuritySite(This, pSite)
#define IInternetSecurityManager_GetSecuritySite(This, ppSite) (This)->lpVtbl->GetSecuritySite(This, ppSite)
#define IInternetSecurityManager_MapUrlToZone(This, pwszUrl, pdwZone, dwFlags) (This)->lpVtbl->MapUrlToZone(This, pwszUrl, pdwZone, dwFlags)
#define IInternetSecurityManager_GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved)
#define IInternetSecurityManager_ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved) (This)->lpVtbl->ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
#define IInternetSecurityManager_QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved) (This)->lpVtbl->QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
#define IInternetSecurityManager_SetZoneMapping(This, dwZone, lpszPattern, dwFlags) (This)->lpVtbl->SetZoneMapping(This, dwZone, lpszPattern, dwFlags)
#define IInternetSecurityManager_GetZoneMappings(This, dwZone, ppenumString, dwFlags) (This)->lpVtbl->GetZoneMappings(This, dwZone, ppenumString, dwFlags)

declare function IInternetSecurityManager_SetSecuritySite_Proxy(byval This as IInternetSecurityManager ptr, byval pSite as IInternetSecurityMgrSite ptr) as HRESULT
declare sub IInternetSecurityManager_SetSecuritySite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_GetSecuritySite_Proxy(byval This as IInternetSecurityManager ptr, byval ppSite as IInternetSecurityMgrSite ptr ptr) as HRESULT
declare sub IInternetSecurityManager_GetSecuritySite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_MapUrlToZone_Proxy(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval pdwZone as DWORD ptr, byval dwFlags as DWORD) as HRESULT
declare sub IInternetSecurityManager_MapUrlToZone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_GetSecurityId_Proxy(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IInternetSecurityManager_GetSecurityId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_ProcessUrlAction_Proxy(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetSecurityManager_ProcessUrlAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_QueryCustomPolicy_Proxy(byval This as IInternetSecurityManager ptr, byval pwszUrl as LPCWSTR, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetSecurityManager_QueryCustomPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_SetZoneMapping_Proxy(byval This as IInternetSecurityManager ptr, byval dwZone as DWORD, byval lpszPattern as LPCWSTR, byval dwFlags as DWORD) as HRESULT
declare sub IInternetSecurityManager_SetZoneMapping_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetSecurityManager_GetZoneMappings_Proxy(byval This as IInternetSecurityManager ptr, byval dwZone as DWORD, byval ppenumString as IEnumString ptr ptr, byval dwFlags as DWORD) as HRESULT
declare sub IInternetSecurityManager_GetZoneMappings_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define _LPINTERNETSECURITYMANANGEREX_DEFINED
	#define __IInternetSecurityManagerEx_INTERFACE_DEFINED__
	extern IID_IInternetSecurityManagerEx as const GUID
	extern SID_SInternetSecurityManagerEx alias "IID_IInternetSecurityManagerEx" as const GUID
	type IInternetSecurityManagerEx as IInternetSecurityManagerEx_

	type IInternetSecurityManagerExVtbl
		QueryInterface as function(byval This as IInternetSecurityManagerEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInternetSecurityManagerEx ptr) as ULONG
		Release as function(byval This as IInternetSecurityManagerEx ptr) as ULONG
		SetSecuritySite as function(byval This as IInternetSecurityManagerEx ptr, byval pSite as IInternetSecurityMgrSite ptr) as HRESULT
		GetSecuritySite as function(byval This as IInternetSecurityManagerEx ptr, byval ppSite as IInternetSecurityMgrSite ptr ptr) as HRESULT
		MapUrlToZone as function(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval pdwZone as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		GetSecurityId as function(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
		ProcessUrlAction as function(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
		QueryCustomPolicy as function(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
		SetZoneMapping as function(byval This as IInternetSecurityManagerEx ptr, byval dwZone as DWORD, byval lpszPattern as LPCWSTR, byval dwFlags as DWORD) as HRESULT
		GetZoneMappings as function(byval This as IInternetSecurityManagerEx ptr, byval dwZone as DWORD, byval ppenumString as IEnumString ptr ptr, byval dwFlags as DWORD) as HRESULT
		ProcessUrlActionEx as function(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD, byval pdwOutFlags as DWORD ptr) as HRESULT
	end type

	type IInternetSecurityManagerEx_
		lpVtbl as IInternetSecurityManagerExVtbl ptr
	end type

	#define IInternetSecurityManagerEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInternetSecurityManagerEx_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInternetSecurityManagerEx_Release(This) (This)->lpVtbl->Release(This)
	#define IInternetSecurityManagerEx_SetSecuritySite(This, pSite) (This)->lpVtbl->SetSecuritySite(This, pSite)
	#define IInternetSecurityManagerEx_GetSecuritySite(This, ppSite) (This)->lpVtbl->GetSecuritySite(This, ppSite)
	#define IInternetSecurityManagerEx_MapUrlToZone(This, pwszUrl, pdwZone, dwFlags) (This)->lpVtbl->MapUrlToZone(This, pwszUrl, pdwZone, dwFlags)
	#define IInternetSecurityManagerEx_GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved)
	#define IInternetSecurityManagerEx_ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved) (This)->lpVtbl->ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
	#define IInternetSecurityManagerEx_QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved) (This)->lpVtbl->QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
	#define IInternetSecurityManagerEx_SetZoneMapping(This, dwZone, lpszPattern, dwFlags) (This)->lpVtbl->SetZoneMapping(This, dwZone, lpszPattern, dwFlags)
	#define IInternetSecurityManagerEx_GetZoneMappings(This, dwZone, ppenumString, dwFlags) (This)->lpVtbl->GetZoneMappings(This, dwZone, ppenumString, dwFlags)
	#define IInternetSecurityManagerEx_ProcessUrlActionEx(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags) (This)->lpVtbl->ProcessUrlActionEx(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
	declare function IInternetSecurityManagerEx_ProcessUrlActionEx_Proxy(byval This as IInternetSecurityManagerEx ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD, byval pdwOutFlags as DWORD ptr) as HRESULT
	declare sub IInternetSecurityManagerEx_ProcessUrlActionEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define _LPINTERNETSECURITYMANANGEREx2_DEFINED
	#define __IInternetSecurityManagerEx2_INTERFACE_DEFINED__
	extern IID_IInternetSecurityManagerEx2 as const GUID
	extern SID_SInternetSecurityManagerEx2 alias "IID_IInternetSecurityManagerEx2" as const GUID

	type IInternetSecurityManagerEx2Vtbl
		QueryInterface as function(byval This as IInternetSecurityManagerEx2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInternetSecurityManagerEx2 ptr) as ULONG
		Release as function(byval This as IInternetSecurityManagerEx2 ptr) as ULONG
		SetSecuritySite as function(byval This as IInternetSecurityManagerEx2 ptr, byval pSite as IInternetSecurityMgrSite ptr) as HRESULT
		GetSecuritySite as function(byval This as IInternetSecurityManagerEx2 ptr, byval ppSite as IInternetSecurityMgrSite ptr ptr) as HRESULT
		MapUrlToZone as function(byval This as IInternetSecurityManagerEx2 ptr, byval pwszUrl as LPCWSTR, byval pdwZone as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		GetSecurityId as function(byval This as IInternetSecurityManagerEx2 ptr, byval pwszUrl as LPCWSTR, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
		ProcessUrlAction as function(byval This as IInternetSecurityManagerEx2 ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
		QueryCustomPolicy as function(byval This as IInternetSecurityManagerEx2 ptr, byval pwszUrl as LPCWSTR, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
		SetZoneMapping as function(byval This as IInternetSecurityManagerEx2 ptr, byval dwZone as DWORD, byval lpszPattern as LPCWSTR, byval dwFlags as DWORD) as HRESULT
		GetZoneMappings as function(byval This as IInternetSecurityManagerEx2 ptr, byval dwZone as DWORD, byval ppenumString as IEnumString ptr ptr, byval dwFlags as DWORD) as HRESULT
		ProcessUrlActionEx as function(byval This as IInternetSecurityManagerEx2 ptr, byval pwszUrl as LPCWSTR, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD, byval pdwOutFlags as DWORD ptr) as HRESULT
		MapUrlToZoneEx2 as function(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval pdwZone as DWORD ptr, byval dwFlags as DWORD, byval ppwszMappedUrl as LPWSTR ptr, byval pdwOutFlags as DWORD ptr) as HRESULT
		ProcessUrlActionEx2 as function(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval pdwOutFlags as DWORD ptr) as HRESULT
		GetSecurityIdEx2 as function(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
		QueryCustomPolicyEx2 as function(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD_PTR) as HRESULT
	end type

	type IInternetSecurityManagerEx2_
		lpVtbl as IInternetSecurityManagerEx2Vtbl ptr
	end type

	#define IInternetSecurityManagerEx2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInternetSecurityManagerEx2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInternetSecurityManagerEx2_Release(This) (This)->lpVtbl->Release(This)
	#define IInternetSecurityManagerEx2_SetSecuritySite(This, pSite) (This)->lpVtbl->SetSecuritySite(This, pSite)
	#define IInternetSecurityManagerEx2_GetSecuritySite(This, ppSite) (This)->lpVtbl->GetSecuritySite(This, ppSite)
	#define IInternetSecurityManagerEx2_MapUrlToZone(This, pwszUrl, pdwZone, dwFlags) (This)->lpVtbl->MapUrlToZone(This, pwszUrl, pdwZone, dwFlags)
	#define IInternetSecurityManagerEx2_GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetSecurityId(This, pwszUrl, pbSecurityId, pcbSecurityId, dwReserved)
	#define IInternetSecurityManagerEx2_ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved) (This)->lpVtbl->ProcessUrlAction(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
	#define IInternetSecurityManagerEx2_QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved) (This)->lpVtbl->QueryCustomPolicy(This, pwszUrl, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)
	#define IInternetSecurityManagerEx2_SetZoneMapping(This, dwZone, lpszPattern, dwFlags) (This)->lpVtbl->SetZoneMapping(This, dwZone, lpszPattern, dwFlags)
	#define IInternetSecurityManagerEx2_GetZoneMappings(This, dwZone, ppenumString, dwFlags) (This)->lpVtbl->GetZoneMappings(This, dwZone, ppenumString, dwFlags)
	#define IInternetSecurityManagerEx2_ProcessUrlActionEx(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags) (This)->lpVtbl->ProcessUrlActionEx(This, pwszUrl, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
	#define IInternetSecurityManagerEx2_MapUrlToZoneEx2(This, pUri, pdwZone, dwFlags, ppwszMappedUrl, pdwOutFlags) (This)->lpVtbl->MapUrlToZoneEx2(This, pUri, pdwZone, dwFlags, ppwszMappedUrl, pdwOutFlags)
	#define IInternetSecurityManagerEx2_ProcessUrlActionEx2(This, pUri, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags) (This)->lpVtbl->ProcessUrlActionEx2(This, pUri, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
	#define IInternetSecurityManagerEx2_GetSecurityIdEx2(This, pUri, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetSecurityIdEx2(This, pUri, pbSecurityId, pcbSecurityId, dwReserved)
	#define IInternetSecurityManagerEx2_QueryCustomPolicyEx2(This, pUri, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved) (This)->lpVtbl->QueryCustomPolicyEx2(This, pUri, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)

	declare function IInternetSecurityManagerEx2_MapUrlToZoneEx2_Proxy(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval pdwZone as DWORD ptr, byval dwFlags as DWORD, byval ppwszMappedUrl as LPWSTR ptr, byval pdwOutFlags as DWORD ptr) as HRESULT
	declare sub IInternetSecurityManagerEx2_MapUrlToZoneEx2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetSecurityManagerEx2_ProcessUrlActionEx2_Proxy(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR, byval pdwOutFlags as DWORD ptr) as HRESULT
	declare sub IInternetSecurityManagerEx2_ProcessUrlActionEx2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetSecurityManagerEx2_GetSecurityIdEx2_Proxy(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
	declare sub IInternetSecurityManagerEx2_GetSecurityIdEx2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetSecurityManagerEx2_QueryCustomPolicyEx2_Proxy(byval This as IInternetSecurityManagerEx2 ptr, byval pUri as IUri ptr, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD_PTR) as HRESULT
	declare sub IInternetSecurityManagerEx2_QueryCustomPolicyEx2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IZoneIdentifier_INTERFACE_DEFINED__
	extern IID_IZoneIdentifier as const GUID
	type IZoneIdentifier as IZoneIdentifier_

	type IZoneIdentifierVtbl
		QueryInterface as function(byval This as IZoneIdentifier ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IZoneIdentifier ptr) as ULONG
		Release as function(byval This as IZoneIdentifier ptr) as ULONG
		GetId as function(byval This as IZoneIdentifier ptr, byval pdwZone as DWORD ptr) as HRESULT
		SetId as function(byval This as IZoneIdentifier ptr, byval dwZone as DWORD) as HRESULT
		Remove as function(byval This as IZoneIdentifier ptr) as HRESULT
	end type

	type IZoneIdentifier_
		lpVtbl as IZoneIdentifierVtbl ptr
	end type

	#define IZoneIdentifier_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IZoneIdentifier_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IZoneIdentifier_Release(This) (This)->lpVtbl->Release(This)
	#define IZoneIdentifier_GetId(This, pdwZone) (This)->lpVtbl->GetId(This, pdwZone)
	#define IZoneIdentifier_SetId(This, dwZone) (This)->lpVtbl->SetId(This, dwZone)
	#define IZoneIdentifier_Remove(This) (This)->lpVtbl->Remove(This)

	declare function IZoneIdentifier_GetId_Proxy(byval This as IZoneIdentifier ptr, byval pdwZone as DWORD ptr) as HRESULT
	declare sub IZoneIdentifier_GetId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IZoneIdentifier_SetId_Proxy(byval This as IZoneIdentifier ptr, byval dwZone as DWORD) as HRESULT
	declare sub IZoneIdentifier_SetId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IZoneIdentifier_Remove_Proxy(byval This as IZoneIdentifier ptr) as HRESULT
	declare sub IZoneIdentifier_Remove_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define _LPINTERNETHOSTSECURITYMANANGER_DEFINED
#define __IInternetHostSecurityManager_INTERFACE_DEFINED__
extern IID_IInternetHostSecurityManager as const GUID
extern SID_SInternetHostSecurityManager alias "IID_IInternetHostSecurityManager" as const GUID
type IInternetHostSecurityManager as IInternetHostSecurityManager_

type IInternetHostSecurityManagerVtbl
	QueryInterface as function(byval This as IInternetHostSecurityManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetHostSecurityManager ptr) as ULONG
	Release as function(byval This as IInternetHostSecurityManager ptr) as ULONG
	GetSecurityId as function(byval This as IInternetHostSecurityManager ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
	ProcessUrlAction as function(byval This as IInternetHostSecurityManager ptr, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
	QueryCustomPolicy as function(byval This as IInternetHostSecurityManager ptr, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
end type

type IInternetHostSecurityManager_
	lpVtbl as IInternetHostSecurityManagerVtbl ptr
end type

#define IInternetHostSecurityManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetHostSecurityManager_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetHostSecurityManager_Release(This) (This)->lpVtbl->Release(This)
#define IInternetHostSecurityManager_GetSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved) (This)->lpVtbl->GetSecurityId(This, pbSecurityId, pcbSecurityId, dwReserved)
#define IInternetHostSecurityManager_ProcessUrlAction(This, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved) (This)->lpVtbl->ProcessUrlAction(This, dwAction, pPolicy, cbPolicy, pContext, cbContext, dwFlags, dwReserved)
#define IInternetHostSecurityManager_QueryCustomPolicy(This, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved) (This)->lpVtbl->QueryCustomPolicy(This, guidKey, ppPolicy, pcbPolicy, pContext, cbContext, dwReserved)

declare function IInternetHostSecurityManager_GetSecurityId_Proxy(byval This as IInternetHostSecurityManager ptr, byval pbSecurityId as UBYTE ptr, byval pcbSecurityId as DWORD ptr, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IInternetHostSecurityManager_GetSecurityId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetHostSecurityManager_ProcessUrlAction_Proxy(byval This as IInternetHostSecurityManager ptr, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwFlags as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetHostSecurityManager_ProcessUrlAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetHostSecurityManager_QueryCustomPolicy_Proxy(byval This as IInternetHostSecurityManager ptr, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval pContext as UBYTE ptr, byval cbContext as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetHostSecurityManager_QueryCustomPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

const URLACTION_MIN = &h1000
const URLACTION_DOWNLOAD_MIN = &h1000
const URLACTION_DOWNLOAD_SIGNED_ACTIVEX = &h1001
const URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX = &h1004
const URLACTION_DOWNLOAD_CURR_MAX = &h1004
const URLACTION_DOWNLOAD_MAX = &h11FF
const URLACTION_ACTIVEX_MIN = &h1200
const URLACTION_ACTIVEX_RUN = &h1200
const URLPOLICY_ACTIVEX_CHECK_LIST = &h10000
const URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY = &h1201
const URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY = &h1202
const URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY = &h1203
const URLACTION_SCRIPT_OVERRIDE_SAFETY = &h1401
const URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY = &h1204
const URLACTION_ACTIVEX_TREATASUNTRUSTED = &h1205
const URLACTION_ACTIVEX_NO_WEBOC_SCRIPT = &h1206
const URLACTION_ACTIVEX_OVERRIDE_REPURPOSEDETECTION = &h1207
const URLACTION_ACTIVEX_OVERRIDE_OPTIN = &h1208
const URLACTION_ACTIVEX_SCRIPTLET_RUN = &h1209
const URLACTION_ACTIVEX_DYNSRC_VIDEO_AND_ANIMATION = &h120A
const URLACTION_ACTIVEX_OVERRIDE_DOMAINLIST = &h120B
const URLACTION_ACTIVEX_CURR_MAX = &h120B
const URLACTION_ACTIVEX_MAX = &h13ff
const URLACTION_SCRIPT_MIN = &h1400
const URLACTION_SCRIPT_RUN = &h1400
const URLACTION_SCRIPT_JAVA_USE = &h1402
const URLACTION_SCRIPT_SAFE_ACTIVEX = &h1405
const URLACTION_CROSS_DOMAIN_DATA = &h1406
const URLACTION_SCRIPT_PASTE = &h1407
const URLACTION_ALLOW_XDOMAIN_SUBFRAME_RESIZE = &h1408
const URLACTION_SCRIPT_XSSFILTER = &h1409
const URLACTION_SCRIPT_NAVIGATE = &h140A
const URLACTION_PLUGGABLE_PROTOCOL_XHR = &h140B
const URLACTION_SCRIPT_CURR_MAX = &h140B
const URLACTION_SCRIPT_MAX = &h15ff
const URLACTION_HTML_MIN = &h1600
const URLACTION_HTML_SUBMIT_FORMS = &h1601
const URLACTION_HTML_SUBMIT_FORMS_FROM = &h1602
const URLACTION_HTML_SUBMIT_FORMS_TO = &h1603
const URLACTION_HTML_FONT_DOWNLOAD = &h1604
const URLACTION_HTML_JAVA_RUN = &h1605
const URLACTION_HTML_USERDATA_SAVE = &h1606
const URLACTION_HTML_SUBFRAME_NAVIGATE = &h1607
const URLACTION_HTML_META_REFRESH = &h1608
const URLACTION_HTML_MIXED_CONTENT = &h1609
const URLACTION_HTML_INCLUDE_FILE_PATH = &h160A
const URLACTION_HTML_ALLOW_INJECTED_DYNAMIC_HTML = &h160B
const URLACTION_HTML_REQUIRE_UTF8_DOCUMENT_CODEPAGE = &h160C
const URLACTION_HTML_ALLOW_CROSS_DOMAIN_CANVAS = &h160D
const URLACTION_HTML_ALLOW_WINDOW_CLOSE = &h160E
const URLACTION_HTML_ALLOW_CROSS_DOMAIN_WEBWORKER = &h160F
const URLACTION_HTML_ALLOW_CROSS_DOMAIN_TEXTTRACK = &h1610
const URLACTION_HTML_ALLOW_INDEXEDDB = &h1611
const URLACTION_HTML_MAX = &h17ff
const URLACTION_SHELL_MIN = &h1800
const URLACTION_SHELL_INSTALL_DTITEMS = &h1800
const URLACTION_SHELL_MOVE_OR_COPY = &h1802
const URLACTION_SHELL_FILE_DOWNLOAD = &h1803
const URLACTION_SHELL_VERB = &h1804
const URLACTION_SHELL_WEBVIEW_VERB = &h1805
const URLACTION_SHELL_SHELLEXECUTE = &h1806

#if _WIN32_WINNT >= &h0600
	const URLACTION_SHELL_EXECUTE_HIGHRISK = &h1806
	const URLACTION_SHELL_EXECUTE_MODRISK = &h1807
	const URLACTION_SHELL_EXECUTE_LOWRISK = &h1808
	const URLACTION_SHELL_POPUPMGR = &h1809
	const URLACTION_SHELL_RTF_OBJECTS_LOAD = &h180A
	const URLACTION_SHELL_ENHANCED_DRAGDROP_SECURITY = &h180B
	const URLACTION_SHELL_EXTENSIONSECURITY = &h180C
	const URLACTION_SHELL_SECURE_DRAGSOURCE = &h180D
#endif

#if _WIN32_WINNT >= &h0601
	const URLACTION_SHELL_REMOTEQUERY = &h180E
	const URLACTION_SHELL_PREVIEW = &h180F
	const URLACTION_SHELL_SHARE = &h1810
	const URLACTION_SHELL_ALLOW_CROSS_SITE_SHARE = &h1811
#endif

const URLACTION_SHELL_CURR_MAX = &h1811
const URLACTION_SHELL_MAX = &h19ff
const URLACTION_NETWORK_MIN = &h1A00
const URLACTION_CREDENTIALS_USE = &h1A00
const URLPOLICY_CREDENTIALS_SILENT_LOGON_OK = &h0
const URLPOLICY_CREDENTIALS_MUST_PROMPT_USER = &h10000
const URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT = &h20000
const URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY = &h30000
const URLACTION_AUTHENTICATE_CLIENT = &h1A01
const URLPOLICY_AUTHENTICATE_CLEARTEXT_OK = &h0
const URLPOLICY_AUTHENTICATE_CHALLENGE_RESPONSE = &h10000
const URLPOLICY_AUTHENTICATE_MUTUAL_ONLY = &h30000
const URLACTION_COOKIES = &h1A02
const URLACTION_COOKIES_SESSION = &h1A03
const URLACTION_CLIENT_CERT_PROMPT = &h1A04
const URLACTION_COOKIES_THIRD_PARTY = &h1A05
const URLACTION_COOKIES_SESSION_THIRD_PARTY = &h1A06
const URLACTION_COOKIES_ENABLED = &h1A10
const URLACTION_NETWORK_CURR_MAX = &h1A10
const URLACTION_NETWORK_MAX = &h1Bff
const URLACTION_JAVA_MIN = &h1C00
const URLACTION_JAVA_PERMISSIONS = &h1C00
const URLPOLICY_JAVA_PROHIBIT = &h0
const URLPOLICY_JAVA_HIGH = &h10000
const URLPOLICY_JAVA_MEDIUM = &h20000
const URLPOLICY_JAVA_LOW = &h30000
const URLPOLICY_JAVA_CUSTOM = &h800000
const URLACTION_JAVA_CURR_MAX = &h1C00
const URLACTION_JAVA_MAX = &h1Cff
const URLACTION_INFODELIVERY_MIN = &h1D00
const URLACTION_INFODELIVERY_NO_ADDING_CHANNELS = &h1D00
const URLACTION_INFODELIVERY_NO_EDITING_CHANNELS = &h1D01
const URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS = &h1D02
const URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS = &h1D03
const URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS = &h1D04
const URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS = &h1D05
const URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING = &h1D06
const URLACTION_INFODELIVERY_CURR_MAX = &h1D06
const URLACTION_INFODELIVERY_MAX = &h1Dff
const URLACTION_CHANNEL_SOFTDIST_MIN = &h1E00
const URLACTION_CHANNEL_SOFTDIST_PERMISSIONS = &h1E05
const URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT = &h10000
const URLPOLICY_CHANNEL_SOFTDIST_PRECACHE = &h20000
const URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL = &h30000
const URLACTION_CHANNEL_SOFTDIST_MAX = &h1Eff

#if _WIN32_WINNT >= &h0601
	const URLACTION_DOTNET_USERCONTROLS = &h2005
#endif

#if _WIN32_WINNT >= &h0600
	const URLACTION_BEHAVIOR_MIN = &h2000
	const URLACTION_BEHAVIOR_RUN = &h2000
	const URLPOLICY_BEHAVIOR_CHECK_LIST = &h10000
	const URLACTION_FEATURE_MIN = &h2100
	const URLACTION_FEATURE_MIME_SNIFFING = &h2100
	const URLACTION_FEATURE_ZONE_ELEVATION = &h2101
	const URLACTION_FEATURE_WINDOW_RESTRICTIONS = &h2102
	const URLACTION_FEATURE_SCRIPT_STATUS_BAR = &h2103
	const URLACTION_FEATURE_FORCE_ADDR_AND_STATUS = &h2104
	const URLACTION_FEATURE_BLOCK_INPUT_PROMPTS = &h2105
	const URLACTION_FEATURE_DATA_BINDING = &h2106
	const URLACTION_FEATURE_CROSSDOMAIN_FOCUS_CHANGE = &h2107
	const URLACTION_AUTOMATIC_DOWNLOAD_UI_MIN = &h2200
	const URLACTION_AUTOMATIC_DOWNLOAD_UI = &h2200
	const URLACTION_AUTOMATIC_ACTIVEX_UI = &h2201
	const URLACTION_ALLOW_RESTRICTEDPROTOCOLS = &h2300
	const URLACTION_ALLOW_APEVALUATION = &h2301
	const URLACTION_ALLOW_XHR_EVALUATION = &h2302
	const URLACTION_WINDOWS_BROWSER_APPLICATIONS = &h2400
	const URLACTION_XPS_DOCUMENTS = &h2401
	const URLACTION_LOOSE_XAML = &h2402
	const URLACTION_LOWRIGHTS = &h2500
	const URLACTION_WINFX_SETUP = &h2600
	const URLACTION_INPRIVATE_BLOCKING = &h2700
#endif

const URLACTION_ALLOW_AUDIO_VIDEO = &h2701
const URLACTION_ALLOW_ACTIVEX_FILTERING = &h2702
const URLACTION_ALLOW_STRUCTURED_STORAGE_SNIFFING = &h2703
const URLACTION_ALLOW_AUDIO_VIDEO_PLUGINS = &h2704
const URLACTION_ALLOW_ZONE_ELEVATION_VIA_OPT_OUT = &h2705
const URLACTION_ALLOW_ZONE_ELEVATION_OPT_OUT_ADDITION = &h2706
const URLACTION_ALLOW_CROSSDOMAIN_DROP_WITHIN_WINDOW = &h2708
const URLACTION_ALLOW_CROSSDOMAIN_DROP_ACROSS_WINDOWS = &h2709
const URLACTION_ALLOW_CROSSDOMAIN_APPCACHE_MANIFEST = &h270A
const URLACTION_ALLOW_RENDER_LEGACY_DXTFILTERS = &h270B
const URLPOLICY_ALLOW = &h0
const URLPOLICY_QUERY = &h1
const URLPOLICY_DISALLOW = &h3
const URLPOLICY_NOTIFY_ON_ALLOW = &h10
const URLPOLICY_NOTIFY_ON_DISALLOW = &h20
const URLPOLICY_LOG_ON_ALLOW = &h40
const URLPOLICY_LOG_ON_DISALLOW = &h80
const URLPOLICY_MASK_PERMISSIONS = &h0f
#define GetUrlPolicyPermissions(dw) (dw and URLPOLICY_MASK_PERMISSIONS)
#define SetUrlPolicyPermissions(dw, dw2) scope : (dw) = ((dw) and (not URLPOLICY_MASK_PERMISSIONS)) or (dw2) : end scope
const URLPOLICY_DONTCHECKDLGBOX = &h100

#if _WIN32_WINNT >= &h0600
	extern GUID_CUSTOM_LOCALMACHINEZONEUNLOCKED as const GUID
#endif

#define _LPINTERNETZONEMANAGER_DEFINED
#define __IInternetZoneManager_INTERFACE_DEFINED__
type LPURLZONEMANAGER as IInternetZoneManager ptr

type tagURLZONE as long
enum
	URLZONE_INVALID = -1
	URLZONE_PREDEFINED_MIN = 0
	URLZONE_LOCAL_MACHINE = 0
	URLZONE_INTRANET = 1
	URLZONE_TRUSTED = 2
	URLZONE_INTERNET = 3
	URLZONE_UNTRUSTED = 4
	URLZONE_PREDEFINED_MAX = 999
	URLZONE_USER_MIN = 1000
	URLZONE_USER_MAX = 10000
end enum

type URLZONE as tagURLZONE
const URLZONE_ESC_FLAG = &h100

type tagURLTEMPLATE as long
enum
	URLTEMPLATE_CUSTOM = &h0
	URLTEMPLATE_PREDEFINED_MIN = &h10000
	URLTEMPLATE_LOW = &h10000
	URLTEMPLATE_MEDLOW = &h10500
	URLTEMPLATE_MEDIUM = &h11000
	URLTEMPLATE_MEDHIGH = &h11500
	URLTEMPLATE_HIGH = &h12000
	URLTEMPLATE_PREDEFINED_MAX = &h20000
end enum

type URLTEMPLATE as tagURLTEMPLATE

enum
	MAX_ZONE_PATH = 260
	MAX_ZONE_DESCRIPTION = 200
end enum

type __WIDL_urlmon_generated_name_00000011 as long
enum
	ZAFLAGS_CUSTOM_EDIT = &h1
	ZAFLAGS_ADD_SITES = &h2
	ZAFLAGS_REQUIRE_VERIFICATION = &h4
	ZAFLAGS_INCLUDE_PROXY_OVERRIDE = &h8
	ZAFLAGS_INCLUDE_INTRANET_SITES = &h10
	ZAFLAGS_NO_UI = &h20
	ZAFLAGS_SUPPORTS_VERIFICATION = &h40
	ZAFLAGS_UNC_AS_INTRANET = &h80
	ZAFLAGS_DETECT_INTRANET = &h100
	ZAFLAGS_USE_LOCKED_ZONES = &h10000
	ZAFLAGS_VERIFY_TEMPLATE_SETTINGS = &h20000
	ZAFLAGS_NO_CACHE = &h40000
end enum

type ZAFLAGS as __WIDL_urlmon_generated_name_00000011

type _ZONEATTRIBUTES
	cbSize as ULONG
	szDisplayName as wstring * 260
	szDescription as wstring * 200
	szIconPath as wstring * 260
	dwTemplateMinLevel as DWORD
	dwTemplateRecommended as DWORD
	dwTemplateCurrentLevel as DWORD
	dwFlags as DWORD
end type

type ZONEATTRIBUTES as _ZONEATTRIBUTES
type LPZONEATTRIBUTES as _ZONEATTRIBUTES ptr

type _URLZONEREG as long
enum
	URLZONEREG_DEFAULT = 0
	URLZONEREG_HKLM = 1
	URLZONEREG_HKCU = 2
end enum

type URLZONEREG as _URLZONEREG
extern IID_IInternetZoneManager as const GUID

type IInternetZoneManagerVtbl
	QueryInterface as function(byval This as IInternetZoneManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternetZoneManager ptr) as ULONG
	Release as function(byval This as IInternetZoneManager ptr) as ULONG
	GetZoneAttributes as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
	SetZoneAttributes as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
	GetZoneCustomPolicy as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval urlZoneReg as URLZONEREG) as HRESULT
	SetZoneCustomPolicy as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
	GetZoneActionPolicy as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
	SetZoneActionPolicy as function(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
	PromptAction as function(byval This as IInternetZoneManager ptr, byval dwAction as DWORD, byval hwndParent as HWND, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwPromptFlags as DWORD) as HRESULT
	LogAction as function(byval This as IInternetZoneManager ptr, byval dwAction as DWORD, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwLogFlags as DWORD) as HRESULT
	CreateZoneEnumerator as function(byval This as IInternetZoneManager ptr, byval pdwEnum as DWORD ptr, byval pdwCount as DWORD ptr, byval dwFlags as DWORD) as HRESULT
	GetZoneAt as function(byval This as IInternetZoneManager ptr, byval dwEnum as DWORD, byval dwIndex as DWORD, byval pdwZone as DWORD ptr) as HRESULT
	DestroyZoneEnumerator as function(byval This as IInternetZoneManager ptr, byval dwEnum as DWORD) as HRESULT
	CopyTemplatePoliciesToZone as function(byval This as IInternetZoneManager ptr, byval dwTemplate as DWORD, byval dwZone as DWORD, byval dwReserved as DWORD) as HRESULT
end type

type IInternetZoneManager_
	lpVtbl as IInternetZoneManagerVtbl ptr
end type

#define IInternetZoneManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternetZoneManager_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternetZoneManager_Release(This) (This)->lpVtbl->Release(This)
#define IInternetZoneManager_GetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->GetZoneAttributes(This, dwZone, pZoneAttributes)
#define IInternetZoneManager_SetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->SetZoneAttributes(This, dwZone, pZoneAttributes)
#define IInternetZoneManager_GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg)
#define IInternetZoneManager_SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg)
#define IInternetZoneManager_GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
#define IInternetZoneManager_SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
#define IInternetZoneManager_PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags) (This)->lpVtbl->PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags)
#define IInternetZoneManager_LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags) (This)->lpVtbl->LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags)
#define IInternetZoneManager_CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags) (This)->lpVtbl->CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags)
#define IInternetZoneManager_GetZoneAt(This, dwEnum, dwIndex, pdwZone) (This)->lpVtbl->GetZoneAt(This, dwEnum, dwIndex, pdwZone)
#define IInternetZoneManager_DestroyZoneEnumerator(This, dwEnum) (This)->lpVtbl->DestroyZoneEnumerator(This, dwEnum)
#define IInternetZoneManager_CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved) (This)->lpVtbl->CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved)

declare function IInternetZoneManager_GetZoneAttributes_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
declare sub IInternetZoneManager_GetZoneAttributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_SetZoneAttributes_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
declare sub IInternetZoneManager_SetZoneAttributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_GetZoneCustomPolicy_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval urlZoneReg as URLZONEREG) as HRESULT
declare sub IInternetZoneManager_GetZoneCustomPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_SetZoneCustomPolicy_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
declare sub IInternetZoneManager_SetZoneCustomPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_GetZoneActionPolicy_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
declare sub IInternetZoneManager_GetZoneActionPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_SetZoneActionPolicy_Proxy(byval This as IInternetZoneManager ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
declare sub IInternetZoneManager_SetZoneActionPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_PromptAction_Proxy(byval This as IInternetZoneManager ptr, byval dwAction as DWORD, byval hwndParent as HWND, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwPromptFlags as DWORD) as HRESULT
declare sub IInternetZoneManager_PromptAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_LogAction_Proxy(byval This as IInternetZoneManager ptr, byval dwAction as DWORD, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwLogFlags as DWORD) as HRESULT
declare sub IInternetZoneManager_LogAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_CreateZoneEnumerator_Proxy(byval This as IInternetZoneManager ptr, byval pdwEnum as DWORD ptr, byval pdwCount as DWORD ptr, byval dwFlags as DWORD) as HRESULT
declare sub IInternetZoneManager_CreateZoneEnumerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_GetZoneAt_Proxy(byval This as IInternetZoneManager ptr, byval dwEnum as DWORD, byval dwIndex as DWORD, byval pdwZone as DWORD ptr) as HRESULT
declare sub IInternetZoneManager_GetZoneAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_DestroyZoneEnumerator_Proxy(byval This as IInternetZoneManager ptr, byval dwEnum as DWORD) as HRESULT
declare sub IInternetZoneManager_DestroyZoneEnumerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInternetZoneManager_CopyTemplatePoliciesToZone_Proxy(byval This as IInternetZoneManager ptr, byval dwTemplate as DWORD, byval dwZone as DWORD, byval dwReserved as DWORD) as HRESULT
declare sub IInternetZoneManager_CopyTemplatePoliciesToZone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define _LPINTERNETZONEMANAGEREX_DEFINED
	#define __IInternetZoneManagerEx_INTERFACE_DEFINED__
	extern IID_IInternetZoneManagerEx as const GUID
	type IInternetZoneManagerEx as IInternetZoneManagerEx_

	type IInternetZoneManagerExVtbl
		QueryInterface as function(byval This as IInternetZoneManagerEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInternetZoneManagerEx ptr) as ULONG
		Release as function(byval This as IInternetZoneManagerEx ptr) as ULONG
		GetZoneAttributes as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
		SetZoneAttributes as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
		GetZoneCustomPolicy as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval urlZoneReg as URLZONEREG) as HRESULT
		SetZoneCustomPolicy as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		GetZoneActionPolicy as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		SetZoneActionPolicy as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		PromptAction as function(byval This as IInternetZoneManagerEx ptr, byval dwAction as DWORD, byval hwndParent as HWND, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwPromptFlags as DWORD) as HRESULT
		LogAction as function(byval This as IInternetZoneManagerEx ptr, byval dwAction as DWORD, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwLogFlags as DWORD) as HRESULT
		CreateZoneEnumerator as function(byval This as IInternetZoneManagerEx ptr, byval pdwEnum as DWORD ptr, byval pdwCount as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		GetZoneAt as function(byval This as IInternetZoneManagerEx ptr, byval dwEnum as DWORD, byval dwIndex as DWORD, byval pdwZone as DWORD ptr) as HRESULT
		DestroyZoneEnumerator as function(byval This as IInternetZoneManagerEx ptr, byval dwEnum as DWORD) as HRESULT
		CopyTemplatePoliciesToZone as function(byval This as IInternetZoneManagerEx ptr, byval dwTemplate as DWORD, byval dwZone as DWORD, byval dwReserved as DWORD) as HRESULT
		GetZoneActionPolicyEx as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
		SetZoneActionPolicyEx as function(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
	end type

	type IInternetZoneManagerEx_
		lpVtbl as IInternetZoneManagerExVtbl ptr
	end type

	#define IInternetZoneManagerEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInternetZoneManagerEx_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInternetZoneManagerEx_Release(This) (This)->lpVtbl->Release(This)
	#define IInternetZoneManagerEx_GetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->GetZoneAttributes(This, dwZone, pZoneAttributes)
	#define IInternetZoneManagerEx_SetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->SetZoneAttributes(This, dwZone, pZoneAttributes)
	#define IInternetZoneManagerEx_GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx_SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx_GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx_SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx_PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags) (This)->lpVtbl->PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags)
	#define IInternetZoneManagerEx_LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags) (This)->lpVtbl->LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags)
	#define IInternetZoneManagerEx_CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags) (This)->lpVtbl->CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags)
	#define IInternetZoneManagerEx_GetZoneAt(This, dwEnum, dwIndex, pdwZone) (This)->lpVtbl->GetZoneAt(This, dwEnum, dwIndex, pdwZone)
	#define IInternetZoneManagerEx_DestroyZoneEnumerator(This, dwEnum) (This)->lpVtbl->DestroyZoneEnumerator(This, dwEnum)
	#define IInternetZoneManagerEx_CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved) (This)->lpVtbl->CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved)
	#define IInternetZoneManagerEx_GetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags) (This)->lpVtbl->GetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)
	#define IInternetZoneManagerEx_SetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags) (This)->lpVtbl->SetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)

	declare function IInternetZoneManagerEx_GetZoneActionPolicyEx_Proxy(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
	declare sub IInternetZoneManagerEx_GetZoneActionPolicyEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetZoneManagerEx_SetZoneActionPolicyEx_Proxy(byval This as IInternetZoneManagerEx ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
	declare sub IInternetZoneManagerEx_SetZoneActionPolicyEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	#define _LPINTERNETZONEMANAGEREX2_DEFINED
	const SECURITY_IE_STATE_GREEN = &h0
	const SECURITY_IE_STATE_RED = &h1
	#define __IInternetZoneManagerEx2_INTERFACE_DEFINED__
	extern IID_IInternetZoneManagerEx2 as const GUID
	type IInternetZoneManagerEx2 as IInternetZoneManagerEx2_

	type IInternetZoneManagerEx2Vtbl
		QueryInterface as function(byval This as IInternetZoneManagerEx2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInternetZoneManagerEx2 ptr) as ULONG
		Release as function(byval This as IInternetZoneManagerEx2 ptr) as ULONG
		GetZoneAttributes as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
		SetZoneAttributes as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr) as HRESULT
		GetZoneCustomPolicy as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval ppPolicy as UBYTE ptr ptr, byval pcbPolicy as DWORD ptr, byval urlZoneReg as URLZONEREG) as HRESULT
		SetZoneCustomPolicy as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval guidKey as const GUID const ptr, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		GetZoneActionPolicy as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		SetZoneActionPolicy as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG) as HRESULT
		PromptAction as function(byval This as IInternetZoneManagerEx2 ptr, byval dwAction as DWORD, byval hwndParent as HWND, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwPromptFlags as DWORD) as HRESULT
		LogAction as function(byval This as IInternetZoneManagerEx2 ptr, byval dwAction as DWORD, byval pwszUrl as LPCWSTR, byval pwszText as LPCWSTR, byval dwLogFlags as DWORD) as HRESULT
		CreateZoneEnumerator as function(byval This as IInternetZoneManagerEx2 ptr, byval pdwEnum as DWORD ptr, byval pdwCount as DWORD ptr, byval dwFlags as DWORD) as HRESULT
		GetZoneAt as function(byval This as IInternetZoneManagerEx2 ptr, byval dwEnum as DWORD, byval dwIndex as DWORD, byval pdwZone as DWORD ptr) as HRESULT
		DestroyZoneEnumerator as function(byval This as IInternetZoneManagerEx2 ptr, byval dwEnum as DWORD) as HRESULT
		CopyTemplatePoliciesToZone as function(byval This as IInternetZoneManagerEx2 ptr, byval dwTemplate as DWORD, byval dwZone as DWORD, byval dwReserved as DWORD) as HRESULT
		GetZoneActionPolicyEx as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
		SetZoneActionPolicyEx as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval dwAction as DWORD, byval pPolicy as UBYTE ptr, byval cbPolicy as DWORD, byval urlZoneReg as URLZONEREG, byval dwFlags as DWORD) as HRESULT
		GetZoneAttributesEx as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr, byval dwFlags as DWORD) as HRESULT
		GetZoneSecurityState as function(byval This as IInternetZoneManagerEx2 ptr, byval dwZoneIndex as DWORD, byval fRespectPolicy as WINBOOL, byval pdwState as LPDWORD, byval pfPolicyEncountered as WINBOOL ptr) as HRESULT
		GetIESecurityState as function(byval This as IInternetZoneManagerEx2 ptr, byval fRespectPolicy as WINBOOL, byval pdwState as LPDWORD, byval pfPolicyEncountered as WINBOOL ptr, byval fNoCache as WINBOOL) as HRESULT
		FixUnsecureSettings as function(byval This as IInternetZoneManagerEx2 ptr) as HRESULT
	end type

	type IInternetZoneManagerEx2_
		lpVtbl as IInternetZoneManagerEx2Vtbl ptr
	end type

	#define IInternetZoneManagerEx2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInternetZoneManagerEx2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInternetZoneManagerEx2_Release(This) (This)->lpVtbl->Release(This)
	#define IInternetZoneManagerEx2_GetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->GetZoneAttributes(This, dwZone, pZoneAttributes)
	#define IInternetZoneManagerEx2_SetZoneAttributes(This, dwZone, pZoneAttributes) (This)->lpVtbl->SetZoneAttributes(This, dwZone, pZoneAttributes)
	#define IInternetZoneManagerEx2_GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneCustomPolicy(This, dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx2_SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneCustomPolicy(This, dwZone, guidKey, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx2_GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->GetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx2_SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg) (This)->lpVtbl->SetZoneActionPolicy(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg)
	#define IInternetZoneManagerEx2_PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags) (This)->lpVtbl->PromptAction(This, dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags)
	#define IInternetZoneManagerEx2_LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags) (This)->lpVtbl->LogAction(This, dwAction, pwszUrl, pwszText, dwLogFlags)
	#define IInternetZoneManagerEx2_CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags) (This)->lpVtbl->CreateZoneEnumerator(This, pdwEnum, pdwCount, dwFlags)
	#define IInternetZoneManagerEx2_GetZoneAt(This, dwEnum, dwIndex, pdwZone) (This)->lpVtbl->GetZoneAt(This, dwEnum, dwIndex, pdwZone)
	#define IInternetZoneManagerEx2_DestroyZoneEnumerator(This, dwEnum) (This)->lpVtbl->DestroyZoneEnumerator(This, dwEnum)
	#define IInternetZoneManagerEx2_CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved) (This)->lpVtbl->CopyTemplatePoliciesToZone(This, dwTemplate, dwZone, dwReserved)
	#define IInternetZoneManagerEx2_GetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags) (This)->lpVtbl->GetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)
	#define IInternetZoneManagerEx2_SetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags) (This)->lpVtbl->SetZoneActionPolicyEx(This, dwZone, dwAction, pPolicy, cbPolicy, urlZoneReg, dwFlags)
	#define IInternetZoneManagerEx2_GetZoneAttributesEx(This, dwZone, pZoneAttributes, dwFlags) (This)->lpVtbl->GetZoneAttributesEx(This, dwZone, pZoneAttributes, dwFlags)
	#define IInternetZoneManagerEx2_GetZoneSecurityState(This, dwZoneIndex, fRespectPolicy, pdwState, pfPolicyEncountered) (This)->lpVtbl->GetZoneSecurityState(This, dwZoneIndex, fRespectPolicy, pdwState, pfPolicyEncountered)
	#define IInternetZoneManagerEx2_GetIESecurityState(This, fRespectPolicy, pdwState, pfPolicyEncountered, fNoCache) (This)->lpVtbl->GetIESecurityState(This, fRespectPolicy, pdwState, pfPolicyEncountered, fNoCache)
	#define IInternetZoneManagerEx2_FixUnsecureSettings(This) (This)->lpVtbl->FixUnsecureSettings(This)

	declare function IInternetZoneManagerEx2_GetZoneAttributesEx_Proxy(byval This as IInternetZoneManagerEx2 ptr, byval dwZone as DWORD, byval pZoneAttributes as ZONEATTRIBUTES ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IInternetZoneManagerEx2_GetZoneAttributesEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetZoneManagerEx2_GetZoneSecurityState_Proxy(byval This as IInternetZoneManagerEx2 ptr, byval dwZoneIndex as DWORD, byval fRespectPolicy as WINBOOL, byval pdwState as LPDWORD, byval pfPolicyEncountered as WINBOOL ptr) as HRESULT
	declare sub IInternetZoneManagerEx2_GetZoneSecurityState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetZoneManagerEx2_GetIESecurityState_Proxy(byval This as IInternetZoneManagerEx2 ptr, byval fRespectPolicy as WINBOOL, byval pdwState as LPDWORD, byval pfPolicyEncountered as WINBOOL ptr, byval fNoCache as WINBOOL) as HRESULT
	declare sub IInternetZoneManagerEx2_GetIESecurityState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IInternetZoneManagerEx2_FixUnsecureSettings_Proxy(byval This as IInternetZoneManagerEx2 ptr) as HRESULT
	declare sub IInternetZoneManagerEx2_FixUnsecureSettings_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

extern CLSID_SoftDistExt as const IID
#define _LPSOFTDISTEXT_DEFINED
const SOFTDIST_FLAG_USAGE_EMAIL = &h1
const SOFTDIST_FLAG_USAGE_PRECACHE = &h2
const SOFTDIST_FLAG_USAGE_AUTOINSTALL = &h4
const SOFTDIST_FLAG_DELETE_SUBSCRIPTION = &h8
const SOFTDIST_ADSTATE_NONE = &h0
const SOFTDIST_ADSTATE_AVAILABLE = &h1
const SOFTDIST_ADSTATE_DOWNLOADED = &h2
const SOFTDIST_ADSTATE_INSTALLED = &h3

type _tagCODEBASEHOLD
	cbSize as ULONG
	szDistUnit as LPWSTR
	szCodeBase as LPWSTR
	dwVersionMS as DWORD
	dwVersionLS as DWORD
	dwStyle as DWORD
end type

type CODEBASEHOLD as _tagCODEBASEHOLD
type LPCODEBASEHOLD as _tagCODEBASEHOLD ptr

type _tagSOFTDISTINFO
	cbSize as ULONG
	dwFlags as DWORD
	dwAdState as DWORD
	szTitle as LPWSTR
	szAbstract as LPWSTR
	szHREF as LPWSTR
	dwInstalledVersionMS as DWORD
	dwInstalledVersionLS as DWORD
	dwUpdateVersionMS as DWORD
	dwUpdateVersionLS as DWORD
	dwAdvertisedVersionMS as DWORD
	dwAdvertisedVersionLS as DWORD
	dwReserved as DWORD
end type

type SOFTDISTINFO as _tagSOFTDISTINFO
type LPSOFTDISTINFO as _tagSOFTDISTINFO ptr
#define __ISoftDistExt_INTERFACE_DEFINED__
extern IID_ISoftDistExt as const GUID
type ISoftDistExt as ISoftDistExt_

type ISoftDistExtVtbl
	QueryInterface as function(byval This as ISoftDistExt ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISoftDistExt ptr) as ULONG
	Release as function(byval This as ISoftDistExt ptr) as ULONG
	ProcessSoftDist as function(byval This as ISoftDistExt ptr, byval szCDFURL as LPCWSTR, byval pSoftDistElement as IXMLElement ptr, byval lpsdi as LPSOFTDISTINFO) as HRESULT
	GetFirstCodeBase as function(byval This as ISoftDistExt ptr, byval szCodeBase as LPWSTR ptr, byval dwMaxSize as LPDWORD) as HRESULT
	GetNextCodeBase as function(byval This as ISoftDistExt ptr, byval szCodeBase as LPWSTR ptr, byval dwMaxSize as LPDWORD) as HRESULT
	AsyncInstallDistributionUnit as function(byval This as ISoftDistExt ptr, byval pbc as IBindCtx ptr, byval pvReserved as LPVOID, byval flags as DWORD, byval lpcbh as LPCODEBASEHOLD) as HRESULT
end type

type ISoftDistExt_
	lpVtbl as ISoftDistExtVtbl ptr
end type

#define ISoftDistExt_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISoftDistExt_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISoftDistExt_Release(This) (This)->lpVtbl->Release(This)
#define ISoftDistExt_ProcessSoftDist(This, szCDFURL, pSoftDistElement, lpsdi) (This)->lpVtbl->ProcessSoftDist(This, szCDFURL, pSoftDistElement, lpsdi)
#define ISoftDistExt_GetFirstCodeBase(This, szCodeBase, dwMaxSize) (This)->lpVtbl->GetFirstCodeBase(This, szCodeBase, dwMaxSize)
#define ISoftDistExt_GetNextCodeBase(This, szCodeBase, dwMaxSize) (This)->lpVtbl->GetNextCodeBase(This, szCodeBase, dwMaxSize)
#define ISoftDistExt_AsyncInstallDistributionUnit(This, pbc, pvReserved, flags, lpcbh) (This)->lpVtbl->AsyncInstallDistributionUnit(This, pbc, pvReserved, flags, lpcbh)

declare function ISoftDistExt_ProcessSoftDist_Proxy(byval This as ISoftDistExt ptr, byval szCDFURL as LPCWSTR, byval pSoftDistElement as IXMLElement ptr, byval lpsdi as LPSOFTDISTINFO) as HRESULT
declare sub ISoftDistExt_ProcessSoftDist_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISoftDistExt_GetFirstCodeBase_Proxy(byval This as ISoftDistExt ptr, byval szCodeBase as LPWSTR ptr, byval dwMaxSize as LPDWORD) as HRESULT
declare sub ISoftDistExt_GetFirstCodeBase_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISoftDistExt_GetNextCodeBase_Proxy(byval This as ISoftDistExt ptr, byval szCodeBase as LPWSTR ptr, byval dwMaxSize as LPDWORD) as HRESULT
declare sub ISoftDistExt_GetNextCodeBase_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISoftDistExt_AsyncInstallDistributionUnit_Proxy(byval This as ISoftDistExt ptr, byval pbc as IBindCtx ptr, byval pvReserved as LPVOID, byval flags as DWORD, byval lpcbh as LPCODEBASEHOLD) as HRESULT
declare sub ISoftDistExt_AsyncInstallDistributionUnit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function GetSoftwareUpdateInfo(byval szDistUnit as LPCWSTR, byval psdi as LPSOFTDISTINFO) as HRESULT
declare function SetSoftwareUpdateAdvertisementState(byval szDistUnit as LPCWSTR, byval dwAdState as DWORD, byval dwAdvertisedVersionMS as DWORD, byval dwAdvertisedVersionLS as DWORD) as HRESULT
#define _LPCATALOGFILEINFO_DEFINED
#define __ICatalogFileInfo_INTERFACE_DEFINED__
type ICatalogFileInfo as ICatalogFileInfo_
type LPCATALOGFILEINFO as ICatalogFileInfo ptr
extern IID_ICatalogFileInfo as const GUID

type ICatalogFileInfoVtbl
	QueryInterface as function(byval This as ICatalogFileInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICatalogFileInfo ptr) as ULONG
	Release as function(byval This as ICatalogFileInfo ptr) as ULONG
	GetCatalogFile as function(byval This as ICatalogFileInfo ptr, byval ppszCatalogFile as LPSTR ptr) as HRESULT
	GetJavaTrust as function(byval This as ICatalogFileInfo ptr, byval ppJavaTrust as any ptr ptr) as HRESULT
end type

type ICatalogFileInfo_
	lpVtbl as ICatalogFileInfoVtbl ptr
end type

#define ICatalogFileInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICatalogFileInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICatalogFileInfo_Release(This) (This)->lpVtbl->Release(This)
#define ICatalogFileInfo_GetCatalogFile(This, ppszCatalogFile) (This)->lpVtbl->GetCatalogFile(This, ppszCatalogFile)
#define ICatalogFileInfo_GetJavaTrust(This, ppJavaTrust) (This)->lpVtbl->GetJavaTrust(This, ppJavaTrust)

declare function ICatalogFileInfo_GetCatalogFile_Proxy(byval This as ICatalogFileInfo ptr, byval ppszCatalogFile as LPSTR ptr) as HRESULT
declare sub ICatalogFileInfo_GetCatalogFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICatalogFileInfo_GetJavaTrust_Proxy(byval This as ICatalogFileInfo ptr, byval ppJavaTrust as any ptr ptr) as HRESULT
declare sub ICatalogFileInfo_GetJavaTrust_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPDATAFILTER_DEFINED
#define __IDataFilter_INTERFACE_DEFINED__
type IDataFilter as IDataFilter_
type LPDATAFILTER as IDataFilter ptr
extern IID_IDataFilter as const GUID

type IDataFilterVtbl
	QueryInterface as function(byval This as IDataFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDataFilter ptr) as ULONG
	Release as function(byval This as IDataFilter ptr) as ULONG
	DoEncode as function(byval This as IDataFilter ptr, byval dwFlags as DWORD, byval lInBufferSize as LONG, byval pbInBuffer as UBYTE ptr, byval lOutBufferSize as LONG, byval pbOutBuffer as UBYTE ptr, byval lInBytesAvailable as LONG, byval plInBytesRead as LONG ptr, byval plOutBytesWritten as LONG ptr, byval dwReserved as DWORD) as HRESULT
	DoDecode as function(byval This as IDataFilter ptr, byval dwFlags as DWORD, byval lInBufferSize as LONG, byval pbInBuffer as UBYTE ptr, byval lOutBufferSize as LONG, byval pbOutBuffer as UBYTE ptr, byval lInBytesAvailable as LONG, byval plInBytesRead as LONG ptr, byval plOutBytesWritten as LONG ptr, byval dwReserved as DWORD) as HRESULT
	SetEncodingLevel as function(byval This as IDataFilter ptr, byval dwEncLevel as DWORD) as HRESULT
end type

type IDataFilter_
	lpVtbl as IDataFilterVtbl ptr
end type

#define IDataFilter_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDataFilter_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDataFilter_Release(This) (This)->lpVtbl->Release(This)
#define IDataFilter_DoEncode(This, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved) (This)->lpVtbl->DoEncode(This, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
#define IDataFilter_DoDecode(This, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved) (This)->lpVtbl->DoDecode(This, dwFlags, lInBufferSize, pbInBuffer, lOutBufferSize, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
#define IDataFilter_SetEncodingLevel(This, dwEncLevel) (This)->lpVtbl->SetEncodingLevel(This, dwEncLevel)

declare function IDataFilter_DoEncode_Proxy(byval This as IDataFilter ptr, byval dwFlags as DWORD, byval lInBufferSize as LONG, byval pbInBuffer as UBYTE ptr, byval lOutBufferSize as LONG, byval pbOutBuffer as UBYTE ptr, byval lInBytesAvailable as LONG, byval plInBytesRead as LONG ptr, byval plOutBytesWritten as LONG ptr, byval dwReserved as DWORD) as HRESULT
declare sub IDataFilter_DoEncode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataFilter_DoDecode_Proxy(byval This as IDataFilter ptr, byval dwFlags as DWORD, byval lInBufferSize as LONG, byval pbInBuffer as UBYTE ptr, byval lOutBufferSize as LONG, byval pbOutBuffer as UBYTE ptr, byval lInBytesAvailable as LONG, byval plInBytesRead as LONG ptr, byval plOutBytesWritten as LONG ptr, byval dwReserved as DWORD) as HRESULT
declare sub IDataFilter_DoDecode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataFilter_SetEncodingLevel_Proxy(byval This as IDataFilter ptr, byval dwEncLevel as DWORD) as HRESULT
declare sub IDataFilter_SetEncodingLevel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPENCODINGFILTERFACTORY_DEFINED

type _tagPROTOCOLFILTERDATA
	cbSize as DWORD
	pProtocolSink as IInternetProtocolSink ptr
	pProtocol as IInternetProtocol ptr
	pUnk as IUnknown ptr
	dwFilterFlags as DWORD
end type

type PROTOCOLFILTERDATA as _tagPROTOCOLFILTERDATA
#define __IEncodingFilterFactory_INTERFACE_DEFINED__
type IEncodingFilterFactory as IEncodingFilterFactory_
type LPENCODINGFILTERFACTORY as IEncodingFilterFactory ptr

type _tagDATAINFO
	ulTotalSize as ULONG
	ulavrPacketSize as ULONG
	ulConnectSpeed as ULONG
	ulProcessorSpeed as ULONG
end type

type DATAINFO as _tagDATAINFO
extern IID_IEncodingFilterFactory as const GUID

type IEncodingFilterFactoryVtbl
	QueryInterface as function(byval This as IEncodingFilterFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEncodingFilterFactory ptr) as ULONG
	Release as function(byval This as IEncodingFilterFactory ptr) as ULONG
	FindBestFilter as function(byval This as IEncodingFilterFactory ptr, byval pwzCodeIn as LPCWSTR, byval pwzCodeOut as LPCWSTR, byval info as DATAINFO, byval ppDF as IDataFilter ptr ptr) as HRESULT
	GetDefaultFilter as function(byval This as IEncodingFilterFactory ptr, byval pwzCodeIn as LPCWSTR, byval pwzCodeOut as LPCWSTR, byval ppDF as IDataFilter ptr ptr) as HRESULT
end type

type IEncodingFilterFactory_
	lpVtbl as IEncodingFilterFactoryVtbl ptr
end type

#define IEncodingFilterFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEncodingFilterFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEncodingFilterFactory_Release(This) (This)->lpVtbl->Release(This)
#define IEncodingFilterFactory_FindBestFilter(This, pwzCodeIn, pwzCodeOut, info, ppDF) (This)->lpVtbl->FindBestFilter(This, pwzCodeIn, pwzCodeOut, info, ppDF)
#define IEncodingFilterFactory_GetDefaultFilter(This, pwzCodeIn, pwzCodeOut, ppDF) (This)->lpVtbl->GetDefaultFilter(This, pwzCodeIn, pwzCodeOut, ppDF)

declare function IEncodingFilterFactory_FindBestFilter_Proxy(byval This as IEncodingFilterFactory ptr, byval pwzCodeIn as LPCWSTR, byval pwzCodeOut as LPCWSTR, byval info as DATAINFO, byval ppDF as IDataFilter ptr ptr) as HRESULT
declare sub IEncodingFilterFactory_FindBestFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEncodingFilterFactory_GetDefaultFilter_Proxy(byval This as IEncodingFilterFactory ptr, byval pwzCodeIn as LPCWSTR, byval pwzCodeOut as LPCWSTR, byval ppDF as IDataFilter ptr ptr) as HRESULT
declare sub IEncodingFilterFactory_GetDefaultFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _HITLOGGING_DEFINED
declare function IsLoggingEnabledA(byval pszUrl as LPCSTR) as WINBOOL
declare function IsLoggingEnabledW(byval pwszUrl as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function IsLoggingEnabled alias "IsLoggingEnabledW"(byval pwszUrl as LPCWSTR) as WINBOOL
#else
	declare function IsLoggingEnabled alias "IsLoggingEnabledA"(byval pszUrl as LPCSTR) as WINBOOL
#endif

type _tagHIT_LOGGING_INFO
	dwStructSize as DWORD
	lpszLoggedUrlName as LPSTR
	StartTime as SYSTEMTIME
	EndTime as SYSTEMTIME
	lpszExtendedInfo as LPSTR
end type

type HIT_LOGGING_INFO as _tagHIT_LOGGING_INFO
type LPHIT_LOGGING_INFO as _tagHIT_LOGGING_INFO ptr
declare function WriteHitLogging(byval lpLogginginfo as LPHIT_LOGGING_INFO) as WINBOOL
const CONFIRMSAFETYACTION_LOADOBJECT = &h1

type CONFIRMSAFETY
	clsid as CLSID
	pUnk as IUnknown ptr
	dwFlags as DWORD
end type

extern GUID_CUSTOM_CONFIRMOBJECTSAFETY as const GUID
#define _LPIWRAPPEDPROTOCOL_DEFINED
#define __IWrappedProtocol_INTERFACE_DEFINED__
type IWrappedProtocol as IWrappedProtocol_
type LPIWRAPPEDPROTOCOL as IWrappedProtocol ptr
extern IID_IWrappedProtocol as const GUID

type IWrappedProtocolVtbl
	QueryInterface as function(byval This as IWrappedProtocol ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWrappedProtocol ptr) as ULONG
	Release as function(byval This as IWrappedProtocol ptr) as ULONG
	GetWrapperCode as function(byval This as IWrappedProtocol ptr, byval pnCode as LONG ptr, byval dwReserved as DWORD_PTR) as HRESULT
end type

type IWrappedProtocol_
	lpVtbl as IWrappedProtocolVtbl ptr
end type

#define IWrappedProtocol_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWrappedProtocol_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWrappedProtocol_Release(This) (This)->lpVtbl->Release(This)
#define IWrappedProtocol_GetWrapperCode(This, pnCode, dwReserved) (This)->lpVtbl->GetWrapperCode(This, pnCode, dwReserved)
declare function IWrappedProtocol_GetWrapperCode_Proxy(byval This as IWrappedProtocol ptr, byval pnCode as LONG ptr, byval dwReserved as DWORD_PTR) as HRESULT
declare sub IWrappedProtocol_GetWrapperCode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _LPGETBINDHANDLE_DEFINED
#define __IGetBindHandle_INTERFACE_DEFINED__
type IGetBindHandle as IGetBindHandle_
type LPGETBINDHANDLE as IGetBindHandle ptr

type __WIDL_urlmon_generated_name_00000012 as long
enum
	BINDHANDLETYPES_APPCACHE = &h0
	BINDHANDLETYPES_DEPENDENCY = &h1
	BINDHANDLETYPES_COUNT = &h2
end enum

type BINDHANDLETYPES as __WIDL_urlmon_generated_name_00000012
extern IID_IGetBindHandle as const GUID

type IGetBindHandleVtbl
	QueryInterface as function(byval This as IGetBindHandle ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGetBindHandle ptr) as ULONG
	Release as function(byval This as IGetBindHandle ptr) as ULONG
	GetBindHandle as function(byval This as IGetBindHandle ptr, byval enumRequestedHandle as BINDHANDLETYPES, byval pRetHandle as HANDLE ptr) as HRESULT
end type

type IGetBindHandle_
	lpVtbl as IGetBindHandleVtbl ptr
end type

#define IGetBindHandle_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IGetBindHandle_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IGetBindHandle_Release(This) (This)->lpVtbl->Release(This)
#define IGetBindHandle_GetBindHandle(This, enumRequestedHandle, pRetHandle) (This)->lpVtbl->GetBindHandle(This, enumRequestedHandle, pRetHandle)
declare function IGetBindHandle_GetBindHandle_Proxy(byval This as IGetBindHandle ptr, byval enumRequestedHandle as BINDHANDLETYPES, byval pRetHandle as HANDLE ptr) as HRESULT
declare sub IGetBindHandle_GetBindHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define _XHRPLUGGABLEPROTOCOL_DEFINED

type _tagPROTOCOL_ARGUMENT
	szMethod as LPCWSTR
	szTargetUrl as LPCWSTR
end type

type PROTOCOL_ARGUMENT as _tagPROTOCOL_ARGUMENT
type LPPROTOCOL_ARGUMENT as _tagPROTOCOL_ARGUMENT ptr
#define _LPBINDCALLBACKREDIRECT_DEFINED
#define __IBindCallbackRedirect_INTERFACE_DEFINED__
type IBindCallbackRedirect as IBindCallbackRedirect_
type LPBINDCALLBACKREDIRECT as IBindCallbackRedirect ptr
extern IID_IBindCallbackRedirect as const GUID

type IBindCallbackRedirectVtbl
	QueryInterface as function(byval This as IBindCallbackRedirect ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBindCallbackRedirect ptr) as ULONG
	Release as function(byval This as IBindCallbackRedirect ptr) as ULONG
	Redirect as function(byval This as IBindCallbackRedirect ptr, byval lpcUrl as LPCWSTR, byval vbCancel as VARIANT_BOOL ptr) as HRESULT
end type

type IBindCallbackRedirect_
	lpVtbl as IBindCallbackRedirectVtbl ptr
end type

#define IBindCallbackRedirect_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBindCallbackRedirect_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindCallbackRedirect_Release(This) (This)->lpVtbl->Release(This)
#define IBindCallbackRedirect_Redirect(This, lpcUrl, vbCancel) (This)->lpVtbl->Redirect(This, lpcUrl, vbCancel)

declare function IBindCallbackRedirect_Redirect_Proxy(byval This as IBindCallbackRedirect ptr, byval lpcUrl as LPCWSTR, byval vbCancel as VARIANT_BOOL ptr) as HRESULT
declare sub IBindCallbackRedirect_Redirect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern

#include once "ole-common.bi"
